Ora.Jobs.Jetsam.E_Thread = false
Ora.Jobs.Jetsam.Trailer = nil
Ora.Jobs.Jetsam.VehAttached = {}


RMenu.Add("Jetsam", "main", RageUI.CreateMenu("Jetsam ", "Actions disponibles", 10, 100))


function Ora.Jobs.Jetsam.CloseUI()
    if (not Ora.Inventory.State.IsOpen) then
        SendNUIMessage({eventName = "closeJetsamMenu"})
        SetNuiFocus(false, false)
    end
end

function Ora.Jobs.Jetsam.EnterZone()
    while (Ora.Player.HasLoaded == false) do Wait(50) end

	if (not Ora.Identity:HasAnyJob("jetsam")) then return end
    
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
	
			Zone:Add({x = 819.37, y = -2986.64, z = 6.02 - 0.98, a = 304.70}, Ora.Jobs.Jetsam.EnterZone, Ora.Jobs.Jetsam.ExitZone, "", 3.5)
			
			local blip = AddBlipForCoord(819.37, -2986.64, 6.02)
			SetBlipSprite(blip, 521)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 61)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Jetsam - Réception des commandes")
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
										Ora.Jobs.Jetsam.Trailer = Ora.World.Vehicle:Create("tr2", {x = 827.43, y = -2944.47, z = 5.90}, 180.49, {customs = {}, warp_into_vehicle = false, maxFuel = true, health = {}})
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

										if (Ora.Jobs.Jetsam.Trailer ~= nil and GetVehicleInDirection(15.0) == Ora.Jobs.Jetsam.Trailer) then
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
								"Attacher le véhicule à la remoque à voitures",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										if (Ora.Jobs.Jetsam.Trailer == nil) then
											return RageUI.Popup({message = "~r~Vous n'avez pas sorti de remorque vous-même"})
										end

										local veh = GetVehiclePedIsIn(PlayerPedId(), false)

										if (veh == 0) then
											return RageUI.Popup({message = "~r~Vous n'êtes pas dans un véhicule"})
										end

										local vehCoords = GetEntityCoords(veh)
										local rotx, roty, rotz = table.unpack(GetEntityRotation(veh))
										rotz = rotz - 180.0

										local vehRotation = vector3(rotx, roty, rotz)
										local vehConfig = Ora.Jobs.Jetsam.TrailerConfig[GetEntityModel(veh)]

										if (vehConfig ~= nil) then
											local x, y, z = table.unpack(vehCoords)
											y = y - vehConfig.y
											z = z - vehConfig.z
											vehCoords = vector3(x, y, z)
										end

										AttachVehicleOnToTrailer(veh, Ora.Jobs.Jetsam.Trailer, 0.0, 0.0, 0.0, GetOffsetFromEntityGivenWorldCoords(Ora.Jobs.Jetsam.Trailer, vehCoords), vehRotation, false)
										SetEntityCollision(veh, false, true)

										table.insert(Ora.Jobs.Jetsam.VehAttached, veh)

										RageUI.Popup({message = "~b~Véhicule attaché à la remorque"})
									end
								end
							)

							RageUI.Button(
								"Détacher la voiture de la remoque à voitures",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										local veh = ClosestVeh()
										local vehIndex = Ora.Utils:IndexOf(Ora.Jobs.Jetsam.VehAttached, veh)

										if (veh == 0) then
											return RageUI.Popup({message = "~r~Il n'y a pas de véhicule devant vous"})
										end

										if (vehIndex == 0) then return end

										DetachEntity(Ora.Jobs.Jetsam.VehAttached[vehIndex], true, false)
										SetEntityCollision(Ora.Jobs.Jetsam.VehAttached[vehIndex], true, true)
										table.remove(Ora.Jobs.Jetsam.VehAttached, vehIndex)
									end
								end
							)

							RageUI.Button(
								"Détacher toutes les véhicules de la remoque à voitures",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										for i = 1, #(Ora.Jobs.Jetsam.VehAttached) do
											DetachEntity(Ora.Jobs.Jetsam.VehAttached[i], true, false)
											SetEntityCollision(Ora.Jobs.Jetsam.VehAttached[i], true, true)
										end

										Ora.Jobs.Jetsam.VehAttached = {}
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
				
				spawnedVehicle = Ora.World.Vehicle:Create(veh.model, {x = 827.94, y = -2924.32, z = 5.88 - 0.80}, 180.49, {})
				
				while (spawnedVehicle == nil) do
					Wait(100)
				end

				Ora.World.Vehicle:ApplyCustomsToVehicle(spawnedVehicle, veh)
		
				if (GetVehicleNumberPlateText(spawnedVehicle) ~= plate) then 
					SetVehicleNumberPlateText(spawnedVehicle, plate)
				end
		
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
							name = "carte_grise",
							data = {
								plate = plate,
								model = veh.label,
								identity = "Jetsam"
							},
							label = plate
						}
					}
				)

				SetNewWaypoint(827.94, -2924.32)
				RageUI.Popup({message = "~b~Le véhicule a été livré ici"})
			end,
			data.id
		)
    end
)
