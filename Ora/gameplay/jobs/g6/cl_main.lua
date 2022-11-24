
Current_Session_Data = {}
local ITEM_NAME_FOR_CASES = "g6_case"
local Current_Blip = nil

local function DisplayHelpText(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

-- Functions to process the route while in a session

local function Notify(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	return EndTextCommandThefeedPostTicker(false, false)
end

RegisterNetEvent("g6:notifyPlayer", function(message)
	Notify(message)
end)

function StartSessionThread(sessionData)

	if sessionData == nil then
		print("No session data")
		return
	end

	if sessionData.route == nil then
		print("No route data")
		return
	end

	if sessionData.agents == nil then
		print("No agents data")
		return
	end

	if sessionData.currentRouteStop == nil then
		print("No currentRouteStop data")
		return
	end

	if sessionData.currentRouteStop == 0 then
		ShowNotification("La session vient de ~b~commencer~s~.\n\nRendez-vous au premier point pour obtenir les ~b~malettes~s~.")
		Current_Blip = AddBlipForCoord(sessionData.depotCoords)
		SetBlipRoute(Current_Blip, true)
		SetBlipRouteColour(Current_Blip, 2)
		SetBlipColour(Current_Blip, 2)
		-- Set blip name
		BeginTextCommandSetBlipName('MYBLIP')
		AddTextComponentSubstringPlayerName('Dépot')
		EndTextCommandSetBlipName(Current_Blip)
		-- Set blip sprite
		SetBlipSprite(Current_Blip, 1)
	end

	Current_Session_Data = sessionData

	Citizen.CreateThread(function()
		while Current_Session_Data ~= nil do
			Player = LocalPlayer()
			if Current_Session_Data.currentRouteStop == 0 then
				if Player.Vehicle ~= 0 and NetworkGetNetworkIdFromEntity(GetVehiclePedIsIn(Player.Ped, false)) == sessionData.vehicle.serverId and GetPedInVehicleSeat(Player.Vehicle, -1) == Player.Ped then
					-- Check if the player is at the depot
					local distance = #(Player.Pos - Current_Session_Data.depotCoords)
					if distance < 25 then
						DrawMarker(1, Current_Session_Data.depotCoords, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 255, 0, 100, 0, 0, 0, 0)
						if distance < 5.0  then
							DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour charger les malettes dans votre coffre.")
							if IsControlJustPressed(0, 51) then
								TriggerServerEvent("g6:fillTheTrunk")
							end
						end
					end
				--else
					--DisplayHelpText("You must be the driver of the stockade registerd to get the cases")
				end
			else
				local distanceToNextPoint = #(Player.Pos - vector3(Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.x, Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.y, Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.z))
				if distanceToNextPoint <= 10.0 then
					DrawMarker(1, table.unpack(Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords), 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 255, 0, 0, 0, 0)
					if distanceToNextPoint <= 2.0 then
						DisplayHelpText("Appuyer sur ~INPUT_CONTEXT~ pour remplir les ATMS.")
						if IsControlJustPressed(0, 38) then
							FillATM(Current_Session_Data)
						end
					end
				end
			end
			Citizen.Wait(1.0)
		end
	end)
end

function UpdateSession(sessionData)
	--print("Updating session")
	if sessionData ~= nil then
		for k, v in pairs(sessionData.agents) do
			if v == Player.ServerID then
				sessionData.clientInSession = true
				break
			end
		end

		if sessionData.clientInSession and Current_Session_Data.currentRouteStop ~= sessionData.currentRouteStop then
			-- Remove the blip
			RemoveBlip(Current_Blip)
			Current_Blip = nil
			-- Add the blip for the next point
			Current_Blip = AddBlipForCoord(sessionData.route[sessionData.currentRouteStop].coords.x, sessionData.route[sessionData.currentRouteStop].coords.y, sessionData.route[sessionData.currentRouteStop].coords.z)
			SetBlipRoute(Current_Blip, true)
			SetBlipRouteColour(Current_Blip, 2)
			SetBlipColour(Current_Blip, 2)
			-- Set blip name
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("ATM To fill")
			EndTextCommandSetBlipName(Current_Blip)
			-- Set blip sprite
			SetBlipSprite(Current_Blip, 431)

			ShowNotification("~g~Vous devez vous rendre au prochain point de livraison")
		end
	end
	--print("Updating session", json.encode(sessionData), Current_Blip)
	if (sessionData == nil or sessionData.clientInSession == nil) and Current_Blip ~= nil then
		-- Remove the blip
		SetBlipRoute(Current_Blip, false)
		RemoveBlip(Current_Blip)
		Current_Blip = nil
		ShowNotification("~r~Vous n'êtes plus dans la session")
	end

	Current_Session_Data = sessionData
end

function EndSession()
	if Current_Blip ~= nil then
		SetBlipRoute(Current_Blip, false)
		RemoveBlip(Current_Blip)
		Current_Blip = nil
	end
	Current_Session_Data = nil
	ShowNotification("~g~La session est terminée")
end

function GetInventoryItemQty(itemName)
	local qty = 0

	return (Ora.Inventory.Data[itemName] ~= nil and #Ora.Inventory.Data[itemName] >= 0) and #Ora.Inventory.Data[itemName] or 0
end

function FillATM()
	-- Check if he has enough cases in the inventory
	local cases = GetInventoryItemQty(ITEM_NAME_FOR_CASES)
	if cases < 1 then
		ShowNotification("Vous n'avez pas assez de caisses sur vous")
		return
	end

	-- Check if the ATM is in the right position

	local distanceToATM = #(Player.Pos - vector3(Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.x, Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.y, Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.z))
	if distanceToATM > 2.5 then
		ShowNotification("Vous n'êtes pas à la bonne position pour remplir l'ATM")
		return
	end

	local currentInv = Ora.Inventory.Data[ITEM_NAME_FOR_CASES]
	local qty = #currentInv
	if qty < 1 then
		ShowNotification("Vous n'avez pas assez de caisses sur vous")
		return
	end

	-- Remove the cases from the inventory
	TriggerServerEvent("g6:fillATM")
end

RegisterNetEvent("g6:sessionStarted", function(data)
	StartSessionThread(data)
end)

RegisterNetEvent("g6:sessionUpdated", function(data)
	--print("Session updated", json.encode(data))
	UpdateSession(data)
end)

RegisterNetEvent("g6:sessionEnded", function()
	EndSession()
end)

local AtmModels = {
	[GetHashKey("prop_atm_01")] = true,
	[GetHashKey("prop_atm_02")] = true,
	[GetHashKey("prop_atm_03")] = true,
	[GetHashKey("prop_fleeca_atm")] = true,
}

local function getAtmInFrontOfMe()
	-- local plyCoords = GetEntityCoords(PlayerPedId(), false)
	-- plyCoords = vector3(plyCoords.x, plyCoords.y, plyCoords.z)
	-- local plyOffset = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
	-- --local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(plyCoords.x, plyCoords.y, plyCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 16, PlayerPedId(), 1)
	-- local rayHandle = StartShapeTestCapsule(plyCoords.x, plyCoords.y, plyCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 0.5, 16, PlayerPedId(), 1)
	-- for i = 1, 200 do
	-- 	Wait(1.0)
	-- 	DrawLine(plyCoords.x, plyCoords.y, plyCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 255, 0, 0, 255)
	-- end
	
	-- local retval, hit, endCoords, _, result = GetShapeTestResult(rayHandle)
	-- return retval, hit, endCoords, _, result
	
	for k, v in pairs(AtmModels) do
		local obj = GetClosestObjectOfType(Player.Pos.x, Player.Pos.y, Player.Pos.z, 2.0, k, false, false, false)
		if obj ~= 0 then
			return obj
		end
	end
	return 0
	-- enumerate entities around the player and check for the model and pos
	
end


-- RegisterCommand("animAtm", function()
-- 	local timer = 0
-- 	local AnimTime = 10000
-- 	local dict, anim_intro, anim_loop = "mp_take_money_mg", "stand_cash_in_bag_intro", "stand_cash_in_bag_loop"
-- 	if not HasAnimDictLoaded(dict) then
-- 		RequestAnimDict(dict)
-- 		while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
-- 	end

-- 	--TaskPlayAnim(Player.Ped, dict, anim, 8.0, 8.0, AnimTime, 29, 1, 0, 0, 0)
-- 	local _, _, _, _, atm = getAtmInFrontOfMe()
-- 	print(atm, GetEntityModel(atm), AtmModels[GetEntityModel(atm)], #(GetEntityCoords(GetEntityModel(atm)) - v.coords))
-- 	if AtmModels[GetEntityModel(atm)] and #(GetEntityCoords(GetEntityModel(atm)) - v.coords) then
-- 		local pos = GetEntityCoords(atm, false)
-- 		local atmHeading = GetEntityHeading(atm)
-- 		local atmForwardVector = GetEntityForwardVector(atm)
-- 		local atmCoords = GetEntityCoords(atm, false) + atmForwardVector * - 1.0
-- 		local groundZ = Player.Pos.z

-- 		if #(Player.Pos - vector3(atmCoords.x, atmCoords.y, groundZ)) > 0.02 then
-- 			TaskGoStraightToCoord(Player.Ped, atmCoords.x, atmCoords.y, groundZ, 0.8, 1000, atmHeading, 0.0)
-- 			print("hello")
-- 		end
-- 		repeat
-- 			Citizen.Wait(10.0)
-- 			print(#(Player.Pos - vector3(atmCoords.x, atmCoords.y, groundZ)))
-- 		until #(Player.Pos - vector3(atmCoords.x, atmCoords.y, groundZ)) <= 0.02
-- 		SetEntityHeading(Player.Ped, atmHeading)
-- 		Citizen.Wait(1500.0)
-- 		TaskPlayAnim(Player.Ped, dict, anim_loop, 8.0, 8.0, AnimTime, 17, 1, 0, 0, 0)
-- 		--TaskPlayAnimAdvanced(Player.Ped, dict, anim_loop, atmCoords.x, atmCoords.y, groundZ, 0.0, 0.0, Player.Heading , 8.0, 8.0, AnimTime, 29, 1, 0, 0, 0)
-- 		repeat
-- 			timer = timer + 1000
-- 			Wait(1000)
-- 		until not IsEntityPlayingAnim(Player.Ped, dict, anim_loop, 3)


-- 		if timer < AnimTime then
-- 			ShowNotification("~r~Vous avez interrompu l'action. Veillez à ne pas interrompre l'animation.")
-- 			return
-- 		end
-- 		ShowNotification("YOUHOU")
-- 	else
-- 		ShowNotification("~r~Vous devez être devant un ATM")
-- 	end
-- end)


-- RegisterCommand("getAtmHeading", function()
-- 	local _, _, _, _, atm = getAtmInFrontOfMe()
-- 	local atmHeading = GetEntityHeading(atm)
-- 	local forwardVector = GetEntityForwardVector(atm)
-- 	local atmCoords = GetOffsetFromEntityInWorldCoords(atm, 0.0, -1.0, 0.0)
-- 	print(atmHeading, LocalPlayer().Heading)
-- end)

RegisterNetEvent("g6:fillATM")
AddEventHandler("g6:fillATM", function()
	local atm = getAtmInFrontOfMe()
	local player = PlayerPedId()
	local playerCoords = GetEntityCoords(player, false)
	local atmCoords = GetEntityCoords(atm, false)
	local distanceToATM = #(playerCoords - atmCoords)
	if distanceToATM > 2.5 then
		ShowNotification("Vous n'êtes pas à la bonne position pour remplir l'ATM")
		return
	end

	-- Check if the ATM is in the right position
	local distanceToATM = #(Player.Pos - vector3(Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.x, Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.y, Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.z))
	if distanceToATM > 2.5 then
		ShowNotification("Vous n'êtes pas à la bonne position pour remplir l'ATM")
		return
	end

	local currentInv = Ora.Inventory.Data[ITEM_NAME_FOR_CASES]
	local qty = #currentInv
	if qty < 1 then
		ShowNotification("Vous n'avez pas assez de caisses sur vous")
		return
	end

	-- Remove the cases from the inventory
	TriggerServerEvent("g6:fillATM")
end)

RegisterNetEvent("g6:fillATM_cb", function()
	--print("Le joueur a été autorisé à remplir l'ATM.")

	-- Play an animation for about 20 seconds
	local timer = 0
	local AnimTime = 10000
	local dict, anim_intro, anim_loop = "mp_take_money_mg", "stand_cash_in_bag_intro", "stand_cash_in_bag_loop"
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
	end

	local currentAtm = Current_Session_Data.route[Current_Session_Data.currentRouteStop]
	
	--TaskPlayAnim(Player.Ped, dict, anim, 8.0, 8.0, AnimTime, 29, 1, 0, 0, 0)
	local atm = getAtmInFrontOfMe()
	local distanceToATM = #(GetEntityCoords(atm) - vector3(Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.x, Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.y, Current_Session_Data.route[Current_Session_Data.currentRouteStop].coords.z))
	--print(atm, GetEntityModel(atm), AtmModels[GetEntityModel(atm)], distanceToATM)
	if AtmModels[GetEntityModel(atm)] and distanceToATM < 0.5 then
		local pos = GetEntityCoords(atm, false)
		local atmHeading = GetEntityHeading(atm)
		local atmCoords = GetOffsetFromEntityInWorldCoords(atm, 0.0, -1.0, 0.0)
		local groundZ = Player.Pos.z

		if #(Player.Pos - vector3(atmCoords.x, atmCoords.y, groundZ)) > 0.02 then
			TaskGoStraightToCoord(Player.Ped, atmCoords.x, atmCoords.y, groundZ, 0.8, 1000, atmHeading, 0.0)
		end
		repeat
			Citizen.Wait(10.0)
			--print(#(Player.Pos - vector3(atmCoords.x, atmCoords.y, groundZ)))
		until #(Player.Pos - vector3(atmCoords.x, atmCoords.y, groundZ)) <= 0.02
		SetEntityHeading(Player.Ped, atmHeading)

		Citizen.Wait(500.0)

		TaskPlayAnim(Player.Ped, dict, anim_loop, 8.0, 8.0, AnimTime, 17, 1, 0, 0, 0)
		--TaskPlayAnimAdvanced(Player.Ped, dict, anim_loop, atmCoords.x, atmCoords.y, groundZ, 0.0, 0.0, Player.Heading , 8.0, 8.0, AnimTime, 29, 1, 0, 0, 0)
		repeat
			timer = timer + 1000
			Wait(1000)
		until not IsEntityPlayingAnim(Player.Ped, dict, anim_loop, 3)


		if timer < AnimTime then
			ShowNotification("~r~Vous avez interrompu l'action. Veillez à ne pas interrompre l'animation.")
			return
		end
		ShowNotification("~g~Vous avez rempli l'ATM. Allez au prochain ATM.")

		Ora.Inventory:RemoveFirstItem(ITEM_NAME_FOR_CASES)

		-- Update the current point of the route
		TriggerServerEvent("g6:nextRouteStop")
	else
		ShowNotification("~r~Vous devez être devant l'ATM.")
	end
end)

RegisterNetEvent("g6:fillTheTrunk_cb", function(qty)
	--print("Player been authorized to fill the trunk")
	Citizen.Wait(1000)
	ShowNotification("~g~Vous avez rempli le coffre du stockade. Allez au prochain point de livraison.")
	RemoveBlip(Current_Blip)

	-- TODO : Only add amount in truck

	-- local getQuantityInTrunk

	-- Have a ped come out of a point and put items in the trunk
	-- local Data = Config.LoadingDock
	-- local ped = CreatePed(4, Data.Ped.Model, Data.Ped.Spawn.x, Data.Ped.Spawn.y, Data.Ped.Spawn.z, Data.Ped.Spawn.h, false, true)
	-- local vehicle = Player.Vehicle
	-- if GetEntityModel(vehicle) ~= GetHashKey("stockade") then
	-- 	ShowNotification("~r~Vous n'êtes pas dans le bon véhicule")
	-- 	return
	-- end

	-- Create trolley and attach it to player
	-- local trolley = CreateObject(Data.Trolley.Model, 0, 0, 0, true, true, true)
	-- AttachEntityToEntity(trolley, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

	-- local trunkPos = GetEntityBonePosition2(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
	-- local trunkHeading = GetEntityHeading(vehicle)
	-- local trunkCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -1.0, 0.0)
	-- local groundZ = GetGroundZAndNormalFor3dCoord(trunkCoords.x, trunkCoords.y, trunkCoords.z)

	-- TaskGoToCoordAnyMeans(ped, trunkCoords, 2.0, 0, 0, 786603, 0xbf800000)
	-- repeat
	-- 	Citizen.Wait(10.0)
	-- until #(Player.Pos - vector3(trunkCoords.x, trunkCoords.y, groundZ)) <= 1.0
	-- Citizen.Wait(500.0)

	-- DetachEntity(trolley, true, true)
	-- FreezeEntityPosition(trolley, true)

	local vehId = NetworkGetEntityFromNetworkId(Current_Session_Data.vehicle.serverId)
	-- print("Current Player Vehicle Server Id", NetworkGetNetworkIdFromEntity(vehId))
	-- print("Current_Session_Data.vehicle.serverId", Current_Session_Data.vehicle.serverId)
	-- print("Number of stops ", #Current_Session_Data.route)
	Ora.World.Vehicle:AddItemsIntoTrunk(vehId, ITEM_NAME_FOR_CASES, #Current_Session_Data.route)

	TriggerServerEvent("g6:nextRouteStop")

end)

-- Process players unlocking the cases

local zones = {
	-- getCases = {
	-- 	name = "Louis",

	-- 	pos = vector3(-27.347029, -665.625549, 32.442867),
	-- 	radius = 1.5,
	-- 	restrictedJob = {g6 = true},
	-- 	onPressAction = function()
	-- 		-- Ask how many cases to get
	-- 		local input = KeyboardInput("How many cases?", "", 3)
	-- 		if input ~= nil then
	-- 			local cases = tonumber(input)
	-- 			if cases ~= nil then
	-- 				if cases > 0 and cases <= 20 then
	-- 					TriggerServerEvent("g6:getCases", cases)
	-- 				else
	-- 					Notification("Vous ne pouvez pas prendre plus de 20 caisses")
	-- 				end
	-- 			else
	-- 				Notification("Vous devez entrer un nombre")
	-- 			end
	-- 		end
	-- 	end
	-- },

	crackCase = {
		name = "Joshua",
		displayLabel = "parler à Joshua",
		model = GetHashKey("s_m_y_dealer_01"),
		heading = 0.0,
		pos = vector3(1218.1278, 2741.9743, 38.005398),
		radius = 1.5,
		restrictedJob = {},
		onPressAction = function()
			-- Ask input of how many cases the player wants to crack
			-- Todo : add the real function
			local input = KeyboardInput("Combien de caisses ?", "", 3)
			-- Check if the player has enough cases
			if input ~= nil and input ~= "" and tonumber(input) > 0 then
				input = tonumber(input)
				local cases = Ora.Inventory.Data[ITEM_NAME_FOR_CASES]
				if #cases < input then
					ShowNotification("~r~Vous n'avez pas assez de caisses")
					return
				end
				-- Remove the cases from the inventory
				for i = 1, input, 1 do
					Ora.Inventory:RemoveFirstItem(cases[i].name)
				end
				-- Calculate the amount of money the player will get
				local money = input * 3000
				-- Give the money to the player

				TriggerServerCallback("Ora::SE::Money:AuthorizePayment", function(token)
					TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = money, SOURCE = "Breaking case G6", LEGIT = false})
					TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", money, false)
				end,{})
				
				TriggerServerEvent("Ora:sendToDiscord", "G6", "Le joueur a cassé " .. input .. " caisses pour un total de " .. money .. "$", "warning")

				-- Show a notification
				ShowNotification("~g~Vous avez reçu ~g~" .. money .. "$~g~ pour avoir ouvert " .. input .. " caisses")
			else
				ShowNotification("~r~Vous devez entrer un nombre")
			end
		end,
	}
}

local zonesByZoneId = {}

for k, v in pairs(zones) do
	local zone = Ora.Core:GetGridZoneId(v.pos.x, v.pos.y)
	zonesByZoneId[zone] = zonesByZoneId[zone] or {}
	table.insert(zonesByZoneId[zone], v)
end

RegisterNetEvent("g6:sessionCreated", function(data)
	Current_Session_Data = data
	ShowNotification("Une session a été créée")
end)

zones = {}
collectgarbage()

AddEventHandler("Ora::CE::PlayerLoaded", function()
	-- Ora.Identity.Job:GetName(LocalPlayer().ServerID)
	-- Ora.Identity.Orga:GetName(LocalPlayer().ServerID)
	Citizen.CreateThread(function()
		Citizen.Wait(5000)
		local Player = LocalPlayer()
		while true do
			local Job1 = Ora.Identity.Job:GetName()
			local Job2 = Ora.Identity.Orga:GetName()
			if zonesByZoneId[Player.ZoneId] then
				for k, v in pairs(zonesByZoneId[Player.ZoneId]) do
					-- TODO : add support to restrict to certain ranks
					if #v.restrictedJob == 0 or v.restrictedJob[Job1] or v.restrictedJob[Job2] then
						if #(Player.Pos - v.pos) < v.radius*5 then
							--DrawMarker(1, v.pos.x, v.pos.y, v.pos.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 255, 0, 0, 0, 0, 0, 0, 0)
							if #(Player.Pos - v.pos) < v.radius then
								DisplayHelpText("Appuyer sur ~INPUT_CONTEXT~ pour "..v.displayLabel)
								if IsControlJustPressed(0, 38) then
									v.onPressAction()
								end
							end
						end
					end
				end
			end

			Citizen.Wait(0.0)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			if zonesByZoneId[LocalPlayer().ZoneId] then
				for k, v in pairs(zonesByZoneId[LocalPlayer().ZoneId]) do
					local pedAlreadyPresent = GetClosestPedInArea(v.pos, v.radius)
					local modelOfPedAlreadyPresent = GetEntityModel(pedAlreadyPresent)
					if v.model == modelOfPedAlreadyPresent then
						SetEntityAsMissionEntity(pedAlreadyPresent, true, true)
						SetEntityCoords(pedAlreadyPresent, v.pos.x, v.pos.y, v.pos.z-0.99)
						SetEntityHeading(pedAlreadyPresent, v.heading)
					elseif IsModelInCdimage(v.model) and IsModelValid(v.model) then
						if pedAlreadyPresent ~= 0 then
							DeleteEntity(pedAlreadyPresent)
						end
						if not HasModelLoaded(v.model) then RequestModel(v.model) end
						while not HasModelLoaded(v.model) do
							--print("Waiting for model to load")
							Citizen.Wait(0)
						end
						local ped = CreatePed(4, v.model, v.pos.x, v.pos.y, v.pos.z-0.99, v.heading, false, false)
						SetEntityHeading(pedAlreadyPresent, v.heading)
						SetEntityAsMissionEntity(ped, true, true)
						SetBlockingOfNonTemporaryEvents(ped, true)
						SetPedDiesWhenInjured(ped, false)
						SetPedCanPlayAmbientAnims(ped, true)
						SetPedCanRagdollFromPlayerImpact(ped, false)
						SetEntityInvincible(ped, true)
						FreezeEntityPosition(ped, true)
						--TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
					end
				end
			end
		end
	end)
end)

function GetClosestPedInArea(pos, radius)
	local closestPed = nil
	local closestDistance = nil

	for ped in EnumeratePeds() do
		local pedPos = GetEntityCoords(ped)
		local distance = #(pos - pedPos)
		if distance < radius then
			if closestPed == nil then
				closestPed = ped
				closestDistance = distance
			else
				if distance < closestDistance then
					closestPed = ped
					closestDistance = distance
				end
			end
		end
	end

	return closestPed, closestDistance
end

function GetClosestPedInArea(pos, radius)
	local closestPed = nil
	local closestDistance = nil

	for ped in EnumeratePeds() do
		local pedPos = GetEntityCoords(ped)
		local distance = #(pos - pedPos)
		if distance < radius then
			if closestPed == nil then
				closestPed = ped
				closestDistance = distance
			else
				if distance < closestDistance then
					closestPed = ped
					closestDistance = distance
				end
			end
		end
	end

	return closestPed, closestDistance
end

--[[
	RegisterNetEvent("g6:debugRoute", function(route)
		local route = json.decode(route)
		ShowNotification("[DEBUG] Route's stops have been uploaded on the map.")

		ClearGpsMultiRoute()
		ClearGpsCustomRoute()

		StartGpsCustomRoute(6, true, true)

		-- Set the route to render

		for k, v in pairs(route) do
			print(k, v)
			AddPointToGpsCustomRoute(v.coords.x, v.coords.y, v.coords.z)
			local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
			SetBlipSprite(blip, 1)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, k)
			-- SetBlipName to "Stop"
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Stop")
			EndTextCommandSetBlipName(blip)
		end

		SetGpsCustomRouteRender(true)
	end)
]]

Citizen.CreateThread(function()
	local atms = json.decode(LoadResourceFile(GetCurrentResourceName(), "gameplay/jobs/g6/atms.json"))

	for k, v in pairs(atms) do
		local coords = v.coords
		local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
		--SetBlipHiddenOnLegend(blip, true)
		SetBlipSprite(blip, 434)

		SetBlipScale(blip, 0.6)
		SetBlipDisplay(blip, 5)
		SetBlipAsFriendly(blip, true)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
	end
end)


-- ------------------------------------
-- --------- ATM LIST CLEANER ---------
-- ------------------------------------

-- local atms = json.decode(LoadResourceFile(GetCurrentResourceName(), "gameplay/jobs/g6/atms.json"))

-- local atmsCleaned = {}

-- -- Do a camera framework to get the next atm


-- local currentAtmIndex = 1
-- local currentAtm = atms[currentAtmIndex]
-- local cleanListAtm = {}

-- local function Start()
-- 	Citizen.CreateThread(function()
-- 		local Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
-- 		function SetCamCoordsRelitavely(cam, coords, rotation)

-- 			-- calculate forward vector base on coords and rotation
-- 			local forward = vector3( math.sin(math.rad(rotation.z)) * math.abs(math.cos(math.rad(rotation.x))), math.cos(math.rad(rotation.z)) * math.abs(math.cos(math.rad(rotation.x))), math.sin(math.rad(rotation.x)))

-- 			local target = coords + forward * 2.5

-- 			SetCamCoord(cam, coords)
-- 			PointCamAtCoord(cam, target)
-- 			SetCamRot(cam, rotation, 2)
-- 			SetCamFov(cam, 60.0)
-- 		end

-- 		local coords = currentAtm.coords
-- 		local heading = currentAtm.heading
-- 		local fov = currentAtm.fov

-- 		while true do
-- 			-- Get the direction of the camera
-- 			local direction = GetCamRot(Camera, 2)
-- 			-- Get the coords of the camera
-- 			local camCoords = GetCamCoord(Camera)

-- 			-- Get the forward vector of the camera
-- 			local forwardVector = GetEntityForwardVector(Camera)

-- 			-- Get the right vector of the camera
-- 			local rightVector = GetEntityRightVector(Camera)

-- 			-- Get the up vector of the camera
-- 			local upVector = GetEntityUpVector(Camera)

-- 			-- Move the camera forward
-- 			if IsControlPressed(0, 32) then
-- 				local newCoords = camCoords + forwardVector * 0.1
-- 				SetCamCoord(Camera, newCoords)
-- 			end

-- 			-- Move the camera backward
-- 			if IsControlPressed(0, 32) then
-- 				local newCoords = camCoords - forwardVector * 0.1
-- 				SetCamCoord(Camera, newCoords)
-- 			end

-- 			-- Move the camera left
-- 			if IsControlPressed(0, 32) then
-- 				local newCoords = camCoords - rightVector * 0.1
-- 				SetCamCoord(Camera, newCoords)
-- 			end

-- 			-- Move the camera right
-- 			if IsControlPressed(0, 32) then
-- 				local newCoords = camCoords + rightVector * 0.1
-- 				SetCamCoord(Camera, newCoords)
-- 			end

-- 			-- Move the camera up
-- 			if IsControlPressed(0, 32) then
-- 				local newCoords = camCoords + upVector * 0.1
-- 				SetCamCoord(Camera, newCoords)
-- 			end

-- 			-- Move the camera down
-- 			if IsControlPressed(0, 32) then
-- 				local newCoords = camCoords - upVector * 0.1
-- 				SetCamCoord(Camera, newCoords)
-- 			end

-- 			-- Rotate the camera based on the mouse
-- 			if IsControlPressed(0, 32) then
-- 				local mouseX, mouseY = GetDisabledControlNormal(0, 1), GetDisabledControlNormal(0, 2)
-- 				local newDirection = direction + vector3(mouseY * 0.5, mouseX * 0.5, 0)
-- 				SetCamRot(Camera, newDirection, 2)
-- 			end

-- 			-- Do not insert it to the clean list of atm, next one
-- 			if IsControlJustPressed(0, "SUPPR") then
-- 				currentAtmIndex = currentAtmIndex + 1
-- 				SetCamCoordsRelitavely(Camera, currentAtm.coords, vector3(0, 0, currentAtm.rot.z))
-- 			end

-- 			if IsControlJustPressed(0, "enter") then
-- 				table.insert(cleanListAtm, currentAtm)
-- 				currentAtmIndex = currentAtmIndex + 1
-- 				SetCamCoordsRelitavely(Camera, currentAtm.coords, vector3(0, 0, currentAtm.rot.z))
-- 			end
-- 		end
-- 	end)
-- end


-- RegisterCommand("startCleaning", function()

-- end)