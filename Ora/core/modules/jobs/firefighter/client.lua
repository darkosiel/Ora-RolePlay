RMenu.Add("Firefighter", "main", RageUI.CreateMenu("Pompier ", "Actions disponibles", 10, 100))
RMenu.Add("Firefighter", "stretcher", RageUI.CreateSubMenu(RMenu:Get("Firefighter", "main"), "Actions brancard ", "Actions disponibles", 10, 100))
RMenu.Add("Firefighter", "vehicle", RageUI.CreateSubMenu(RMenu:Get("Firefighter", "main"), "Actions véhicule ", "Actions disponibles", 10, 100))
RMenu.Add("Firefighter", "object", RageUI.CreateSubMenu(RMenu:Get("Firefighter", "main"), "Actions objets ", "Actions disponibles", 10, 100))

function Ora.Jobs.Firefighter.INIT()
	Citizen.CreateThread(
		function()
			while (Ora.Player.HasLoaded == false) do Wait(500) end

			if (Ora.Identity.Job:GetName() == "lsfd") then
				KeySettings:Add(
					"keyboard",
					"F6",
					function()
						RageUI.Visible(RMenu:Get("Firefighter", "main"), true)
					end,
					"lsfd"
				)
			elseif (Ora.Identity.Orga:GetName() == "lsfd") then
				KeySettings:Add(
					"keyboard",
					"F7",
					function()
						RageUI.Visible(RMenu:Get("Firefighter", "main"), true)
					end,
					"lsfd"
				)
			end

			while true do
				Wait(0)

				if (RageUI.Visible(RMenu:Get("Firefighter", "main"))) then
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
										CreateFacture("lsfd")
									end
									if (Active) then
										HoverPlayer()
									end
								end
							)

							RageUI.Button(
								"Actions véhicule",
								nil,
								{},
								true,
								function()
								end,
                RMenu:Get("Firefighter", "vehicle")
							)

							RageUI.Button(
								"Actions brancard",
								nil,
								{},
								true,
								function()
								end,
                RMenu:Get("Firefighter", "stretcher")
							)

							RageUI.Button(
								"Actions objets",
								nil,
								{},
								true,
								function()
								end,
                RMenu:Get("Firefighter", "object")
							)

							RageUI.Button(
								"Test stupéfiant",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										Police.Stup()
									end
									if (Active) then
										HoverPlayer()
									end
								end
							)
              
							RageUI.Button(
                "Informations effectifs",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "lsfd")
									end
								end
              )
              
							RageUI.Button(
                "Annonce",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										exports['Snoupinput']:ShowInput("Texte de l'annonce", 90)
                    local text = exports['Snoupinput']:GetInput()
                    if (text ~= false and text ~= "") then
                        TriggerServerEvent("Job:Annonce", "LSFD", "Annonce", text, "CHAR_CALL911", 8, "LSFD")
                    end
									end
								end
              )

              RageUI.Button(
                "Réanimation",
                nil,
                {},
                true,
                function(_, Active, Selected)
                  if (Selected) then
                    Ambulance.Revive()
                  end
                  if (Active) then
                    HoverPlayer()
                  end
                end
              )

              RageUI.Button(
                "Bipeur: Supprimer les interventions",
                nil,
                {},
                true,
                function(_, _, Selected)
                  if (Selected) then
                    Ora.Jobs.Firefighter.Dispatch:clear(0)
                  end
                end
              )

			  RageUI.Button(
                "Sortir la lance",
                nil,
                {},
                true,
                function(_, _, Selected)
                  if (Selected) then
                    Police.GetHose()
                  end
                end
              )

              RageUI.Button(
                "Annuler l'appel en cours",
                nil,
                {},
                true,
                function(_, _, Selected)
                  if (Selected) then
                    TriggerEvent("call:cancelCall")
                  end
                end
              )
                
						end,
						function()
						end
					)
				end

        if (RageUI.Visible(RMenu:Get("Firefighter", "stretcher"))) then
          RageUI.DrawContent(
						{header = true, glare = false},
						function()
							RageUI.Button(
								"Sortir le brancard de l'ambulance",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										Ambulance.GetOffStretcher()
									end
									if (Active) then
										Ambulance.DrawMarkerVehicle()
									end
								end
							)

							RageUI.Button(
								"Mettre le brancard dans l'ambulance",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										Ambulance.PutStretcherOnVehicle()
									end
									if (Active) then
										Ambulance.DrawMarkerVehicle()
									end
								end
							)

							RageUI.Button(
								"Prendre/Déposer le brancard",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										Ambulance.PickPutStretcher()
									end
									if (Active) then
										Ambulance.DrawMarkerStretcher(true)
									end
								end
							)

							RageUI.Button(
								"Mettre/Descendre la personne du brancard",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										Ambulance.PutOnStretcher()
									end
									if (Active) then
										Ambulance.DrawMarkerStretcher(false)
                    Ambulance.DrawMarkerOnPed()
									end
								end
							)

							RageUI.Button(
								"Ranger le brancard",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										Ambulance.RemoveStretcher()
									end
									if (Active) then
										Ambulance.DrawMarkerStretcher(true)
									end
								end
							)
            end,
						function()
						end
					)
        end

        if (RageUI.Visible(RMenu:Get("Firefighter", "vehicle"))) then
          RageUI.DrawContent(
						{header = true, glare = false},
						function()
							RageUI.Button(
								"Mettre dans le véhicule",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										Police.PutInVeh()
									end
									if (Active) then
										HoverPlayer()
									end
								end
							)

							RageUI.Button(
								"Sortir du véhicule",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										Police.SortirVeh()
									end
									if (Active) then
										HoverPlayer()
									end
								end
							)
            end,
						function()
						end
					)
        end

        if (RageUI.Visible(RMenu:Get("Firefighter", "object"))) then
          RageUI.DrawContent(
						{header = true, glare = false},
						function()
							RageUI.Button(
								"Mettre un cone",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										useCone()
									end
								end
							)

							RageUI.Button(
								"Mettre une barriere",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										useBarrier()
									end
								end
							)

							RageUI.Button(
								"Enlever un cone",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										DeleteCone()
									end
								end
							)

							RageUI.Button(
								"Enlever une barriere",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										DeleteBarrier()
									end
								end
							)

							RageUI.Button(
								"Sortir/Ranger l'écarteur hydraulique",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										ExecuteCommand("spreaders script")
									end
								end
							)

							RageUI.Button(
								"Sortir les pistons hydrauliques",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										ExecuteCommand("stabilisers setup script")
									end
								end
							)

							RageUI.Button(
								"Ranger les pistons hydrauliques",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										ExecuteCommand("stabilisers remove script")
									end
								end
							)
            end,
						function()
						end
					)
        end


				if (Ora.Identity.Job:GetName() == "lsfd" and Ora.Identity.Job.ChangingJob) then
					KeySettings:Clear("keyboard", "F6", "lsfd")
					break
				elseif (Ora.Identity.Orga:GetName() == "lsfd" and Ora.Identity.Orga.ChangingJob) then
					KeySettings:Clear("keyboard", "F7", "lsfd")
					break
				end
			end
		end
	)
end

