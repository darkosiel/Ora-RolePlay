Ora.Jobs.DrivingSchool.Licences = {"Voiture", "Moto", "Poid-lourd"}
Ora.Jobs.DrivingSchool.LicencesIndex = 1
Ora.Jobs.DrivingSchool.Trailer = nil


RMenu.Add("drivingschool", "main", RageUI.CreateMenu("Auto-école", "Actions disponibles", 10, 100))
RMenu.Add("drivingschool", "licences", RageUI.CreateSubMenu(RMenu:Get("drivingschool", "main"), "Auto-école", "Liste des permis", 10, 100))


function Ora.Jobs.DrivingSchool.INIT()
	Citizen.CreateThread(
		function()
			while (Ora.Player.HasLoaded == false) do Wait(500) end
		
			if (Ora.Identity.Job:GetName() == "drivingschool") then
				KeySettings:Add(
					"keyboard",
					"F6",
					function()
						RageUI.Visible(RMenu:Get("drivingschool", "main"), true)
					end,
					"drivingschool"
				)
			elseif (Ora.Identity.Orga:GetName() == "drivingschool") then
				KeySettings:Add(
					"keyboard",
					"F7",
					function()
						RageUI.Visible(RMenu:Get("drivingschool", "main"), true)
					end,
					"drivingschool"
				)
			end

			while true do
				Wait(0)
				
				if (RageUI.Visible(RMenu:Get("drivingschool", "main"))) then
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
										CreateFacture("drivingschool")
									end
									if (Active) then
										HoverPlayer()
									end
								end
							)

							RageUI.Button(
								"Annonce",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
										local text = exports['Snoupinput']:GetInput()

										if (text ~= false) then
											TriggerServerEvent("Job:Annonce", "Auto School", "Annonce", text, "WEB_FRUIT", 8, "Auto School")
										end
									end
								end
							)

							RageUI.List(
								"Attribuer un permis de conduire",
								Ora.Jobs.DrivingSchool.Licences,
								Ora.Jobs.DrivingSchool.LicencesIndex,
								nil,
								{},
								true,
								function(Hovered, Active, Selected, Index)
									Ora.Jobs.DrivingSchool.LicencesIndex = Index

									if (Active) then
										HoverPlayer()
									end

									if (Selected) then
										local PlayerID = GetPlayerServerIdInDirection(8.0)

										if (PlayerID) then
											TriggerServerCallback(
												"Ora::SE::Identity:GetIdentity",
												function(PlayerIdentity)
													PlayerIdentity.serial = math.random(111111111, 9999999999)
													PlayerIdentity.male = Ora.World.Ped:IsPedMale(LocalPlayer().Ped) and "M" or "F"
													
													if (Ora.Jobs.DrivingSchool.LicencesIndex == 1) then
														TriggerPlayerEvent("Ora::CE::Inventory:AddItems", PlayerID, {{name = "permis-conduire", data = {points = 12, uid = "LS-" .. Random(99999999), identity = PlayerIdentity}}})
													elseif (Ora.Jobs.DrivingSchool.LicencesIndex == 2) then
														TriggerPlayerEvent("Ora::CE::Inventory:AddItems", PlayerID, {{name = "permis-conduire-moto", data = {points = 12, uid = "LS-" .. Random(99999999), identity = PlayerIdentity}}})
													elseif (Ora.Jobs.DrivingSchool.LicencesIndex == 3) then
														TriggerPlayerEvent("Ora::CE::Inventory:AddItems", PlayerID, {{name = "permis-conduire-pl", data = {points = 12, uid = "LS-" .. Random(99999999), identity = PlayerIdentity}}})
													end
												end,
												PlayerID
											)
										end
									end
								end
							)

							RageUI.Button(
								"Ajouter des points au permis",
								nil,
								{},
								true,
								function()
								end,
								RMenu:Get("drivingschool", "licences")
							)

							RageUI.Button(
								"Sortir une remorque",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										Ora.Jobs.DrivingSchool.Trailer = Ora.World.Vehicle:Create("trailers", {x = 176.36, y = 387.56, z = 109.12}, 262.38, {customs = {}, warp_into_vehicle = false, maxFuel = true, health = {}})
										SetNewWaypoint(176.36, 387.56)
										RageUI.Popup({message = "~b~Votre remorque est sortie ici"})
									end
								end
							)

							RageUI.Button(
								"Ranger la remorque",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										if (#(vector3(176.36, 387.56, 109.12) - GetEntityCoords(LocalPlayer().Ped)) > 15.0) then
											return RageUI.Popup({message = "~r~Vous êtes trop loin du garage entreprise"})
										end

										if (Ora.Jobs.DrivingSchool.Trailer ~= nil and GetVehicleInDirection(18.0) == Ora.Jobs.DrivingSchool.Trailer) then
											DeleteEntity(Ora.Jobs.DrivingSchool.Trailer)
											Ora.Jobs.DrivingSchool.Trailer = nil
											RageUI.Popup({message = "~b~Vous avez rangé votre remorque"})
										else
											RageUI.Popup({message = "~r~Vous n'avez pas sorti de remorque vous-même ou alors elle n'est pas en face de vous"})
										end
									end
								end
							)
						end,
						function()
						end
					)
				end
				
				if (RageUI.Visible(RMenu:Get("drivingschool", "licences"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							if (
								(Ora.Inventory.Data["permis-conduire"] == nil or #Ora.Inventory.Data["permis-conduire"] == 0) and
								(Ora.Inventory.Data["permis-conduire-moto"] == nil or #Ora.Inventory.Data["permis-conduire-moto"] == 0) and
								(Ora.Inventory.Data["permis-conduire-pl"] == nil or #Ora.Inventory.Data["permis-conduire-pl"] == 0)
							) then
								RageUI.Button(
									"Vide",
									nil,
									{},
									true,
									function(_, _, Selected)
									end
								)
							end

							if Ora.Inventory.Data["permis-conduire"] ~= nil then
								for i = 1, #Ora.Inventory.Data["permis-conduire"], 1 do
									local v = Ora.Inventory.Data["permis-conduire"][i]
									local data = v.data
									local label = data.identity.first_name.." "..data.identity.last_name

									RageUI.Button(
										string.format("%s - %s Voiture", label, data.uid),
										nil,
										{RightLabel = data.points .. " points"},
										true,
										function(_, _, Selected)
											if Selected then
												exports['Snoupinput']:ShowInput("Nombre de points à ajouter", 2, "number", "1", true)
												local am = exports['Snoupinput']:GetInput()

												if (am ~= nil and am ~= false) then
													data.points = data.points + tonumber(am)
													RageUI.CloseAll()
												end
											end
										end
									)
									--[[ RageUI.List(label .. " - " .. data.uid, driversLicenseOptions, dIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
										dIndex = Index
										if Selected then
												if dIndex == 1 then
														local am = KeyboardInput("Nombre de points à enlever", nil, 2)
														if am ~= nil and am ~= "" then
																data.points = data.points - am
														end
														RageUI.CloseAll()
												else
														local am = KeyboardInput("Nombre de points à ajouter", nil, 2)
														if am ~= nil and am ~= "" then
																data.points = data.points + am
														end
														RageUI.CloseAll()
												end
										end
									end) ]]
								end
							end

							if Ora.Inventory.Data["permis-conduire-moto"] ~= nil then
									for i = 1, #Ora.Inventory.Data["permis-conduire-moto"], 1 do
											local v = Ora.Inventory.Data["permis-conduire-moto"][i]
											local data = v.data
											local label = data.identity.first_name.." "..data.identity.last_name
											
											RageUI.Button(
													string.format("%s - %s Moto", label, data.uid),
													nil,
													{RightLabel = data.points .. " points"},
													true,
													function(_, _, Selected)
															if Selected then
																	local am = KeyboardInput("Nombre de points à enlever", nil, 2)
																	if am ~= nil and am ~= "" then
																			data.points = data.points - am
																	end
																	RageUI.CloseAll()
															end
													end
											)
									end
							end

							if Ora.Inventory.Data["permis-conduire-pl"] ~= nil then
									for i = 1, #Ora.Inventory.Data["permis-conduire-pl"], 1 do
											local v = Ora.Inventory.Data["permis-conduire-pl"][i]
											local data = v.data
											local label = data.identity.first_name.." "..data.identity.last_name

											RageUI.Button(
													string.format("%s - %s PL", label, data.uid),
													nil,
													{RightLabel = data.points .. " points"},
													true,
													function(_, _, Selected)
															if Selected then
																	local am = KeyboardInput("Nombre de points à enlever", nil, 2)
																	if am ~= nil and am ~= "" then
																			data.points = data.points - am
																	end
																	RageUI.CloseAll()
															end
													end
											)
									end
							end
						end,
						function()
						end
					)
				end

        if (Ora.Identity.Job:GetName() == "drivingschool" and Ora.Identity.Job.ChangingJob) then
          KeySettings:Clear("keyboard", "F6", "drivingschool")
          break
        elseif (Ora.Identity.Orga:GetName() == "drivingschool" and Ora.Identity.Orga.ChangingJob) then
          KeySettings:Clear("keyboard", "F7", "drivingschool")
          break
        end
			end
		end
	)
end
