Atlantiss.Jobs.Jetsam.E_Thread = false
Atlantiss.Jobs.Jetsam.Trailer = nil
Atlantiss.Jobs.Jetsam.VehAttached = {}


RMenu.Add("Jetsam", "main", RageUI.CreateMenu("Jetsam ", "Actions disponibles", 10, 100))


function Atlantiss.Jobs.Jetsam.CloseUI()
    if (not Atlantiss.Inventory.State.IsOpen) then
        SendNUIMessage({eventName = "closeJetsamMenu"})
        SetNuiFocus(false, false)
    end
end

function Atlantiss.Jobs.Jetsam.EnterZone()
    while (Atlantiss.Player.HasLoaded == false) do Wait(50) end

	if (not Atlantiss.Identity:HasAnyJob("jetsam")) then return end
    
    Atlantiss.Jobs.Jetsam.E_Thread = false
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir l'ordinateur")

    Citizen.CreateThread(
        function()
            while true do
                Wait(0)
                if (IsControlJustPressed(0, Keys["E"])) then
					TriggerServerCallback(
						"Atlantiss::SVCB::Jobs:Jetsam:RequestOpenMenu",
						function(bool)
							if (not bool) then return RageUI.Popup({message = "~r~Quelqu'un utilise déjà cet ordinateur"}) end

							TriggerServerCallback(
								"Atlantiss::SVCB::Jobs:Jetsam:GetOrders",
								function(commandes)
									local cmds = commandes
									local uuids = {}
		
									for id, array in pairs(cmds) do
										for key, value in pairs(array) do
											if (key == "owner") then
												cmds[id]["owner"] = Jobs[value].label or value
											--[[ elseif (key == "uuid") then
												TriggerServerCallback(
													"Atlantiss::SE::Identity:GetFullNameFromUUID",
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
										"Atlantiss::SE::Identity:GetFullNamesFromUUIDs",
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
							Atlantiss.Jobs.Jetsam.E_Thread = true
						end
					)
                end

                if (Atlantiss.Jobs.Jetsam.E_Thread == true) then
                    Atlantiss.Jobs.Jetsam.E_Thread = false
                    break
                end
            end
        end
    )
end

function Atlantiss.Jobs.Jetsam.ExitZone()
    Atlantiss.Jobs.Jetsam.E_Thread = true
    Atlantiss.Jobs.Jetsam.CloseUI()
    Hint:RemoveAll()

	TriggerServerEvent("Atlantiss::SE::Jobs:Jetsam:ClosedMenu")
end

function Atlantiss.Jobs.Jetsam.INIT()
	Citizen.CreateThread(
		function()
			while (Atlantiss.Player.HasLoaded == false) do Wait(500) end
	
			Zone:Add({x = 819.37, y = -2986.64, z = 6.02 - 0.98, a = 304.70}, Atlantiss.Jobs.Jetsam.EnterZone, Atlantiss.Jobs.Jetsam.ExitZone, "", 3.5)
			
			local blip = AddBlipForCoord(819.37, -2986.64, 6.02)
			SetBlipSprite(blip, 521)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 61)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Jetsam - Réception des commandes")
			EndTextCommandSetBlipName(blip)

			if (Atlantiss.Identity.Job:GetName() == "jetsam") then
				KeySettings:Add(
					"keyboard",
					"F6",
					function()
						RageUI.Visible(RMenu:Get("Jetsam", "main"), true)
					end,
					"jetsam"
				)
			elseif (Atlantiss.Identity.Orga:GetName() == "jetsam") then
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
										Atlantiss.Jobs.Jetsam.Trailer = Atlantiss.World.Vehicle:Create("tr2", {x = 827.43, y = -2944.47, z = 5.90}, 180.49, {customs = {}, warp_into_vehicle = false, maxFuel = true, health = {}})
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

										if (Atlantiss.Jobs.Jetsam.Trailer ~= nil and GetVehicleInDirection(15.0) == Atlantiss.Jobs.Jetsam.Trailer) then
											DeleteEntity(Atlantiss.Jobs.Jetsam.Trailer)
											Atlantiss.Jobs.Jetsam.Trailer = nil
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
										if (Atlantiss.Jobs.Jetsam.Trailer == nil) then
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
										local vehConfig = Atlantiss.Jobs.Jetsam.TrailerConfig[GetEntityModel(veh)]

										if (vehConfig ~= nil) then
											local x, y, z = table.unpack(vehCoords)
											y = y - vehConfig.y
											z = z - vehConfig.z
											vehCoords = vector3(x, y, z)
										end

										AttachVehicleOnToTrailer(veh, Atlantiss.Jobs.Jetsam.Trailer, 0.0, 0.0, 0.0, GetOffsetFromEntityGivenWorldCoords(Atlantiss.Jobs.Jetsam.Trailer, vehCoords), vehRotation, false)
										SetEntityCollision(veh, false, true)

										table.insert(Atlantiss.Jobs.Jetsam.VehAttached, veh)

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
										local vehIndex = Atlantiss.Utils:IndexOf(Atlantiss.Jobs.Jetsam.VehAttached, veh)

										if (veh == 0) then
											return RageUI.Popup({message = "~r~Il n'y a pas de véhicule devant vous"})
										end

										if (vehIndex == 0) then return end

										DetachEntity(Atlantiss.Jobs.Jetsam.VehAttached[vehIndex], true, false)
										SetEntityCollision(Atlantiss.Jobs.Jetsam.VehAttached[vehIndex], true, true)
										table.remove(Atlantiss.Jobs.Jetsam.VehAttached, vehIndex)
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
										for i = 1, #(Atlantiss.Jobs.Jetsam.VehAttached) do
											DetachEntity(Atlantiss.Jobs.Jetsam.VehAttached[i], true, false)
											SetEntityCollision(Atlantiss.Jobs.Jetsam.VehAttached[i], true, true)
										end

										Atlantiss.Jobs.Jetsam.VehAttached = {}
									end
								end
							)
						end,
						function()
						end
					)
				end


				if (Atlantiss.Identity.Job:GetName() == "jetsam" and Atlantiss.Identity.Job.ChangingJob) then
					KeySettings:Clear("keyboard", "F6", "jetsam")
					break
				elseif (Atlantiss.Identity.Orga:GetName() == "jetsam" and Atlantiss.Identity.Orga.ChangingJob) then
					KeySettings:Clear("keyboard", "F7", "jetsam")
					break
				end
			end
		end
	)
end


RegisterNUICallback("JetsamCloseUI", function() Atlantiss.Jobs.Jetsam.CloseUI() end)

RegisterNUICallback(
    "JetsamRetreiveOrder",
    function(data)
        Atlantiss.Jobs.Jetsam.CloseUI()

		TriggerServerCallback(
			"Atlantiss::SVCB::Jobs:Jetsam:ArchiveOrder",
			function(order)
				if (order == nil) then
					error(string.format("(order id: %s) 'Atlantiss::SVCB::Jobs:Jetsam:ArchiveOrder', contactez un développeur via ticket.", data.id))
					return RageUI.Popup({message = "~r~ERREUR~s~\nContactez le responsable"})
				end


				local vehdata = json.decode(order.data)
				local veh = vehdata.customs
				local plate = vehdata.plate
				local spawnedVehicle = nil
				
				spawnedVehicle = Atlantiss.World.Vehicle:Create(veh.model, {x = 827.94, y = -2924.32, z = 5.88 - 0.80}, 180.49, {})
				
				while (spawnedVehicle == nil) do
					Wait(100)
				end

				Atlantiss.World.Vehicle:ApplyCustomsToVehicle(spawnedVehicle, veh)
		
				if (GetVehicleNumberPlateText(spawnedVehicle) ~= plate) then 
					SetVehicleNumberPlateText(spawnedVehicle, plate)
				end
		
				Atlantiss.Inventory:AddItems(
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
