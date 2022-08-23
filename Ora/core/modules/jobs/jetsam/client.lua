Ora.Jobs.Jetsam.E_Thread = false
Ora.Jobs.Jetsam.Trailer = nil
Ora.Jobs.Jetsam.VehAttached = {}


whitelist = { -- when adding add-on cars simply use their spawn name
    'FLATBED',
    'BENSON',
    'WASTLNDR', -- WASTELANDER
    'MULE',
    'MULE2',
    'MULE3',
    'MULE4',
    'TRAILER', -- TRFLAT
    'ARMYTRAILER',
    'BOATTRAILER',
}

offsets = { -- when adding add-on cars simply use their spawn name
    {model = 'FLATBED', offset = {x = 0.0, y = -9.0, z = -1.25}},
    {model = 'BENSON', offset = {x = 0.0, y = 0.0, z = -1.25}},
    {model = 'WASTLNDR', offset = {x = 0.0, y = -7.2, z = -0.9}},
    {model = 'MULE', offset = {x = 0.0, y = -7.0, z = -1.75}},
    {model = 'MULE2', offset = {x = 0.0, y = -7.0, z = -1.75}},
    {model = 'MULE3', offset = {x = 0.0, y = -7.0, z = -1.75}},
    {model = 'MULE4', offset = {x = 0.0, y = -7.0, z = -1.75}},
    {model = 'TRAILER', offset = {x = 0.0, y = -9.0, z = -1.25}},
    {model = 'ARMYTRAILER', offset = {x = 0.0, y = -9.5, z = -3.0}},
}

RampHash = 'imp_prop_flatbed_ramp'

function getClosestVehicle(coords)
    local ped = PlayerPedId()
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = -1
    local closestVehicle = -1
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(vehicleCoords - coords)

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end
    return closestVehicle, closestDistance
end

function GetVehicleBelowMe(cFrom, cTo) -- Function to get the vehicle under me
    local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(cFrom.x, cFrom.y, cFrom.z, cTo.x, cTo.y, cTo.z, 10, PlayerPedId(), 0) -- Sends raycast under me
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle) -- Stores the vehicle under 
    return vehicle -- Returns the vehic
end

function contains(item, list)
    for _, value in ipairs(list) do
        if value == item then return true end
    end
    return false
end


RMenu.Add("Jetsam", "main", RageUI.CreateMenu("Jetsam ", "Actions disponibles", 10, 100))


function Ora.Jobs.Jetsam.CloseUI()
    if (not Ora.Inventory.State.IsOpen) then
        SendNUIMessage({eventName = "closeJetsamMenu"})
        SetNuiFocus(false, false)
    end
end

function Ora.Jobs.Jetsam.EnterZone()
    while (Ora.Player.HasLoaded == false) do Wait(50) end

	if (not Ora.Identity:HasAnyJob("concess")) then return end
    
    Ora.Jobs.Jetsam.E_Thread = false
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir l'ordinateur")

    Citizen.CreateThread(
        function()
            while true do
                Wait(0)
                if (IsControlJustPressed(0, Keys["E"])) then
					TriggerServerCallback(
						"Ora::SVCB::Jobs:Jetsam:RequestOpenMenu",
						function(bool)
							if (not bool) then return RageUI.Popup({message = "~r~Quelqu'un utilise déjà cet ordinateur"}) end

							TriggerServerCallback(
								"Ora::SVCB::Jobs:Jetsam:GetOrders",
								function(commandes)
									local cmds = commandes
									local uuids = {}
		
									for id, array in pairs(cmds) do
										for key, value in pairs(array) do
											if (key == "owner") then
												cmds[id]["owner"] = Jobs[value].label or value
											--[[ elseif (key == "uuid") then
												TriggerServerCallback(
													"Ora::SE::Identity:GetFullNameFromUUID",
													function(name)
														if (name ~= nil) then
															cmds[id]["uuid"] = name
														end
													end,
													value
												) ]]

											end
										end
										table.insert(uuids, cmds[id]["uuid"])
									end

									TriggerServerCallback(
										"Ora::SE::Identity:GetFullNamesFromUUIDs",
										function(fullnames)
											for uuid, fullname in pairs(fullnames) do
												for id, _ in pairs(cmds) do
													if (cmds[id]["uuid"] == uuid) then
														cmds[id]["uuid"] = fullname
													end
												end
											end

											SetNuiFocus(true, true)
											SendNUIMessage({eventName = "openJetsamMenu", orders = cmds})
										end,
										uuids
									)
								end
							)
							Ora.Jobs.Jetsam.E_Thread = true
						end
					)
                end

                if (Ora.Jobs.Jetsam.E_Thread == true) then
                    Ora.Jobs.Jetsam.E_Thread = false
                    break
                end
            end
        end
    )
end

function Ora.Jobs.Jetsam.ExitZone()
    Ora.Jobs.Jetsam.E_Thread = true
    Ora.Jobs.Jetsam.CloseUI()
    Hint:RemoveAll()

	TriggerServerEvent("Ora::SE::Jobs:Jetsam:ClosedMenu")
end

function Ora.Jobs.Jetsam.INIT()
	Citizen.CreateThread(
		function()
			while (Ora.Player.HasLoaded == false) do Wait(500) end
	
			Zone:Add({x = -30.94593, y = -1088.0161, z = 27.2743 - 0.98, a = 176.367}, Ora.Jobs.Jetsam.EnterZone, Ora.Jobs.Jetsam.ExitZone, "", 3.5)
			
			local blip = AddBlipForCoord(-30.94593, -1088.0161, 27.2743)
			SetBlipSprite(blip, 521)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 61)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Réception des commandes")
			EndTextCommandSetBlipName(blip)

			if (Ora.Identity.Job:GetName() == "jetsam") then
				KeySettings:Add(
					"keyboard",
					"F6",
					function()
						RageUI.Visible(RMenu:Get("Jetsam", "main"), true)
					end,
					"jetsam"
				)
			elseif (Ora.Identity.Orga:GetName() == "jetsam") then
				KeySettings:Add(
					"keyboard",
					"F7",
					function()
						RageUI.Visible(RMenu:Get("Jetsam", "main"), true)
					end,
					"jetsam"
				)
			end

			while true do
				Wait(0)

				if (RageUI.Visible(RMenu:Get("Jetsam", "main"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							RageUI.Button(
								"Facturation",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										CreateFacture("jetsam")
									end
									if (Active) then
										HoverPlayer()
									end
								end
							)

							RageUI.Button(
								"Faire spawn la remorque à voitures",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										Ora.Jobs.Jetsam.Trailer = Ora.World.Vehicle:Create("trflat", {x = 827.43, y = -2944.47, z = 5.90}, 180.49, {customs = {}, warp_into_vehicle = false, maxFuel = true, health = {}})
										SetNewWaypoint(827.43, -2944.47)
										RageUI.Popup({message = "~b~Votre remorque est sortie ici, ~h~attachez-là à votre camion avant de la remplir~h~"})
									end
								end
							)

							RageUI.Button(
								"Ranger la remorque à voitures",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										if (#(vector3(827.43, -2944.47, 5.90) - GetEntityCoords(GetPlayerPed(-1))) > 15.0) then
											return RageUI.Popup({message = "~r~Vous êtes trop loin du garage entreprise"})
										end

										if (GetVehicleInDirection(15.0) == Ora.Jobs.Jetsam.Trailer) then
											DeleteEntity(Ora.Jobs.Jetsam.Trailer)
											Ora.Jobs.Jetsam.Trailer = nil
											RageUI.Popup({message = "~b~Vous avez rangé votre remorque"})
										else
											RageUI.Popup({message = "~r~Vous n'avez pas sorti de remorque vous-même ou alors elle n'est pas en face de vous"})
										end
									end
								end
							)

							RageUI.Button(
								"Sortir la rampe",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										local player = PlayerPedId()
										local playerCoords = GetEntityCoords(player)
										local radius = 5.0
									
										local vehicle = nil
									
										if IsAnyVehicleNearPoint(playerCoords, radius) then
											vehicle = getClosestVehicle(playerCoords)
											local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
									
											if contains(vehicleName, whitelist) then
												local vehicleCoords = GetEntityCoords(vehicle)
									
												for _, value in pairs(offsets) do
													if vehicleName == value.model then
														local ramp = CreateObject(RampHash, vector3(value.offset.x, value.offset.y, value.offset.z), true, false, false)
														AttachEntityToEntity(ramp, vehicle, GetEntityBoneIndexByName(vehicle, 'chassis'), value.offset.x, value.offset.y, value.offset.z , 180.0, 180.0, 0.0, 0, 0, 1, 0, 0, 1)
														RageUI.Popup({message = "~g~La rampe est bien sortie."})
													end
												end
												return
											end
											return
											RageUI.Popup({message = "~r~Vous devez être sur la remorque."})
										end
									end
								end
							)

							RageUI.Button(
								"Ranger la rampe",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										local player = PlayerPedId()
										local playerCoords = GetEntityCoords(player)
									
										local object = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 5.0, RampHash, false, 0, 0)
									
										if not IsPedInAnyVehicle(player, false) then
											if GetHashKey(RampHash) == GetEntityModel(object) then
												DeleteObject(object)
												RageUI.Popup({message = "~g~La rampe est bien rentrée."})
												return
											end
											RageUI.Popup({message = "~r~Vous devez être sur la rampe."})
										end
									end
								end
							)

							RageUI.Button(
								"Attacher le véhicule",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										local player = PlayerPedId()
										local vehicle = nil
									
										if IsPedInAnyVehicle(player, false) then
											vehicle = GetVehiclePedIsIn(player, false)
											if GetPedInVehicleSeat(vehicle, -1) == player then
												local vehicleCoords = GetEntityCoords(vehicle)
												local vehicleOffset = GetOffsetFromEntityInWorldCoords(vehicle, 1.0, 0.0, -1.5)
												local vehicleRotation = GetEntityRotation(vehicle, 2)
												local belowEntity = GetVehicleBelowMe(vehicleCoords, vehicleOffset)
												local vehicleBelowRotation = GetEntityRotation(belowEntity, 2)
												local vehicleBelowName = GetDisplayNameFromVehicleModel(GetEntityModel(belowEntity))
									
												local vehiclesOffset = GetOffsetFromEntityGivenWorldCoords(belowEntity, vehicleCoords)
									
												local vehiclePitch = vehicleRotation.x - vehicleBelowRotation.x
												local vehicleYaw = vehicleRotation.z - vehicleBelowRotation.z
									
												if contains(vehicleBelowName, whitelist) then
													if not IsEntityAttached(vehicle) then
														AttachEntityToEntity(vehicle, belowEntity, GetEntityBoneIndexByName(belowEntity, 'chassis'), vehiclesOffset, vehiclePitch, 0.0, vehicleYaw, false, false, true, false, 0, true)
														return RageUI.Popup({message = "~g~Véhicule bien attaché."})
													end
													return RageUI.Popup({message = "~g~Véhicule bien attaché."})
												end
												return RageUI.Popup({message = 'Vous ne pouvez pas attacher : ' .. vehicleBelowName})
											end
											return RageUI.Popup({message = "~r~Vous devez être conducteur."})
										end
										RageUI.Popup({message = "~r~Vous devez être dans un véhicule."})
									end
								end
							)

							RageUI.Button(
								"Détacher le véhicule",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										local player = PlayerPedId()
										local vehicle = nil
									
										if IsPedInAnyVehicle(player, false) then
											vehicle = GetVehiclePedIsIn(player, false)
											if GetPedInVehicleSeat(vehicle, -1) == player then
												if IsEntityAttached(vehicle) then
													DetachEntity(vehicle, false, true)
													return RageUI.Popup({message = "~g~Véhicule bien détaché."})
												else
													return RageUI.Popup({message = "~g~Véhicule pas attaché."})
												end
											else
												return RageUI.Popup({message = "~r~Vous devez être conducteur."})
											end
										else
											return RageUI.Popup({message = "~r~Vous devez être dans un véhicule."})
										end
									end
								end
							)
						end,
						function()
						end
					)
				end


				if (Ora.Identity.Job:GetName() == "jetsam" and Ora.Identity.Job.ChangingJob) then
					KeySettings:Clear("keyboard", "F6", "jetsam")
					break
				elseif (Ora.Identity.Orga:GetName() == "jetsam" and Ora.Identity.Orga.ChangingJob) then
					KeySettings:Clear("keyboard", "F7", "jetsam")
					break
				end
			end
		end
	)
end


RegisterNUICallback("JetsamCloseUI", function() Ora.Jobs.Jetsam.CloseUI() end)

RegisterNUICallback(
    "JetsamRetreiveOrder",
    function(data)
        Ora.Jobs.Jetsam.CloseUI()

		TriggerServerCallback(
			"Ora::SVCB::Jobs:Jetsam:ArchiveOrder",
			function(order)
				if (order == nil) then
					error(string.format("(order id: %s) 'Ora::SVCB::Jobs:Jetsam:ArchiveOrder', contactez un développeur via ticket.", data.id))
					return RageUI.Popup({message = "~r~ERREUR~s~\nContactez le responsable"})
				end


				local vehdata = json.decode(order.data)
				local veh = vehdata.customs
				local plate = vehdata.plate
				local spawnedVehicle = nil

				Wait(10000)

				spawnedVehicle = Ora.World.Vehicle:Create(veh.model, {x = 120.57, y = -1116.49, z = 29.17 - 0.80}, 178.17, {maxFuel = true})
				
				while (spawnedVehicle == nil) do
					Wait(100)
				end

				Ora.World.Vehicle:ApplyCustomsToVehicle(spawnedVehicle, veh)
		
				if (GetVehicleNumberPlateText(spawnedVehicle) ~= plate) then 
					SetVehicleNumberPlateText(spawnedVehicle, plate)
				end
				
				SetVehicleDirtLevel(vehicle, 0)

				Ora.Inventory:AddItems(
					{
						{
							name = "key",
							data = {
								plate = plate,
								vehicleIdentifier = getVehicleIdentifier(spawnedVehicle)
							},
							label = plate
						},
						{
							name = "key",
							data = {
								plate = plate,
								vehicleIdentifier = getVehicleIdentifier(spawnedVehicle)
							},
							label = plate
						}
					}
				)

				SetNewWaypoint(-17.098, -1105.643)
				RageUI.Popup({message = "~b~Le véhicule a été livré ici"})
			end,
			data.id
		)
    end
)
