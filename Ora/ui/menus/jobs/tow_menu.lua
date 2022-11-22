local Data = {
	PlayersIdentities = {},
	Companies = {},
	Vehicles = {}
}
local ownerCategory = 1
local filterTow = nil
local filterTowRegex = nil

function ProcessSelectionOfIdentity(uuid, name)
	Data.Vehicles = {}
	Data.SelectedUUID = uuid
	RMenu:Get('jobs',"tow_vehicle").Subtitle = "Véhicules de "..name
	TriggerServerCallback("core:GetVehicleInPound", function(result)
		Data.Vehicles = result
		print(json.encode(Data.Vehicles))
	end, uuid)
end

local function case_insensitive_pattern(pattern)
	
	-- find an optional '%' (group 1) followed by any character (group 2)
	local p = pattern:gsub("(%%?)(.)", function(percent, letter)
		
		if percent ~= "" or not letter:match("%a") then
			-- if the '%' matched, or `letter` is not a letter, return "as is"
			return percent .. letter
		else
			-- else, return a case-insensitive character class of the matched letter
			return string.format("[%s%s]", letter:lower(), letter:upper())
		end
		
	end)
	
	return p
end

RMenu.Add('jobs',"tow", RageUI.CreateMenu(nil, "Joueurs disponibles",10,100,"shopui_title_carmod2","shopui_title_carmod2"))
RMenu.Add('jobs',"tow_vehicle", RageUI.CreateSubMenu(RMenu:Get('jobs',"tow"),nil, "Vehicles de",10,100))
Citizen.CreateThread(function()
	while true do
		Wait(1)
		if RageUI.Visible(RMenu:Get('jobs',"tow")) then
			RageUI.DrawContent({ header = true, glare = false }, function()
				if LocalPlayer().InVehicle then
					RageUI.Button("Rentrer véhicule",nil,{},true,function(_,_,Selected)
						if Selected then
							veh = GetVehiclePedIsIn(LocalPlayer().Ped)
							TriggerServerEvent("storevehicletow",GetVehicleNumberPlateText(veh))
							DeleteEntity(veh)
						end
					end)
				end
				
				if #Data.PlayersIdentities == 0 then
					RageUI.Button("Vide",nil,{},false,function(_,_,Selected) end)
				else
					RageUI.List("Catégorie de propriétaire", {"Civil", "Professionnel"}, ownerCategory, nil, {}, true, function(_, Active, Selected, Index) 
						if Active and ownerCategory ~= Index then
							ownerCategory = Index
						end
					end)
					RageUI.Button("Rechercher",nil,{RightLabel = filterTow == nil and "🔍" or filterTow},true,function(_,Active,Selected)
						if Selected then
							filterTow = KeyboardInput("Entrez un prénom ou un nom",nil,500)
							if filterTow ~= nil and filterTow ~= "" then
								filterTowRegex = case_insensitive_pattern(filterTow)
							else
								filterTow = nil
								filterTowRegex = nil
							end
							RageUI.Refresh()
						end
					end)
					
					if ownerCategory == 1 then
						for k, v in pairs(Data.PlayersIdentities) do
							if filterTowRegex == nil or string.find(v.name,filterTowRegex) then
								RageUI.Button(v.name,nil,{},true,function(_,_,Selected)
									if Selected then
										ProcessSelectionOfIdentity(v.uuid, v.name)
									end
								end,RMenu:Get('jobs',"tow_vehicle"))    
							end
						end
					elseif ownerCategory == 2 then -- Category : Professionnel
						for k, v in pairs(Data.Companies) do
							local job = Jobs[v.uuid]
							if filterTow == nil or string.find(job.label,filterTow) then
								RageUI.Button(job.label,nil,{},true,function(_,_,Selected)
									if Selected then
										ProcessSelectionOfIdentity(v.uuid, tostring(job.label))
									end
								end,RMenu:Get('jobs',"tow_vehicle"))    
							end
						end
					end
				end
			end)
		end
	
		if RageUI.Visible(RMenu:Get('jobs',"tow_vehicle")) then
			RageUI.DrawContent({ header = true, glare = false }, function()
				if #Data.Vehicles == 0 then
					RageUI.Button("Vide",nil,{},true,function()
					end)
				else
					for k, v in pairs(Data.Vehicles) do
						if v.uuid == Data.SelectedUUID then -- Should always be true because we only get vehicles of the selected identity
							RageUI.Button(v.label, nil, {RightLabel = v.plate}, true, function(_, _, Selected)
								if Selected then
									if v.pound then 
										TriggerServerEvent("vehicle:UnTowVehicle",v.id)
										local vehicleData = json.decode(v.settings)
										local coords = LocalPlayer().Pos
										local heading = GetEntityHeading(LocalPlayer().Ped)
										
										vehicleFct.SpawnVehicle(vehicleData.model, coords,heading, function(_veh)						
											SetPedIntoVehicle(LocalPlayer().Ped,_veh,-1)
											vehicleFct.SetVehicleProperties(_veh,vehicleData)
										end)
										v.pound = false
									end
								end
							end,RMenu:Get('jobs',"tow"))
						end
					end
				end
			end)
		end
	end
end)
function OpenTow()
	TriggerServerCallback('core:GetAllIdentityPlayers', function(Identities, _Companies)
		Data.PlayersIdentities  = Identities
		Data.Companies = _Companies
		--Data.Vehicles = Data    
		for k, v in pairs(Data.PlayersIdentities) do
			-- format both first_name and last_name to lower case
			v.name = v.first_name:lower() .. " " .. v.last_name:lower()
			-- set the first letter of every word in the string to upper case
			v.name = v.name:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
		end
		
		-- sort the table by first_name and last_name
		table.sort(Data.PlayersIdentities, function(a, b)
			if a.first_name == b.first_name then
				return a.last_name < b.last_name
			else
				return a.first_name < b.first_name
			end
		end)
		
		-- Same for companies
		table.sort(Data.Companies, function(a, b)
			return Jobs[a.uuid].label < Jobs[b.uuid].label
		end)
	end)
	RageUI.Visible(RMenu:Get('jobs',"tow"),true)
end