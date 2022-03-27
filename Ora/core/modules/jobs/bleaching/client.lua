RMenu.Add("bleacher", "main", RageUI.CreateMenu("Blanchisseur", "Actions disponibles", 10, 100))
RMenu.Add("bleacher", "list", RageUI.CreateSubMenu(RMenu:Get("bleacher", "main"), "Blanchisseur", "Liste des blanchiments terminés", 10, 100))


function Ora.Jobs.Bleacher.INIT()
	Citizen.CreateThread(
		function()
			while (Ora.Player.HasLoaded == false) do Wait(500) end
		
			if (Ora.Identity.Job:GetName() == "bleacher") then
				KeySettings:Add(
					"keyboard",
					"F6",
					function()
						RageUI.Visible(RMenu:Get("bleacher", "main"), true)
					end,
					"bleacher"
				)
			elseif (Ora.Identity.Orga:GetName() == "bleacher") then
				KeySettings:Add(
					"keyboard",
					"F7",
					function()
						RageUI.Visible(RMenu:Get("bleacher", "main"), true)
					end,
					"bleacher"
				)
			end

      local Blip = AddBlipForCoord(Ora.Jobs.Bleacher.Pos.x, Ora.Jobs.Bleacher.Pos.y, Ora.Jobs.Bleacher.Pos.z)
			SetBlipSprite(Blip, 272)
			SetBlipDisplay(Blip, 4)
			SetBlipScale(Blip, 1.1)
			SetBlipColour(Blip, 69)
			SetBlipAsShortRange(Blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Blanchisseur - Site de blanchiment")
			EndTextCommandSetBlipName(Blip)

			while true do
				Wait(0)
				if (RageUI.Visible(RMenu:Get("bleacher", "main"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							RageUI.Button(
								"Effectuer un blanchiment",
								string.format("Taux de perte au blanchiment ~b~%s%s", 100 - math.floor(Ora.Jobs.Bleacher.Tax * 100), "%"),
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
                    --if (#(Ora.Jobs.Bleacher.Pos - GetEntityCoords(PlayerPedId())) > 2.0) then return RageUI.Popup({message = "~r~Vous êtes trop loin de votre lieu de blanchiment"}) end
                    if (GetInteriorAtCoords(GetEntityCoords(PlayerPedId())) ~= 247809) then return RageUI.Popup({message = "~r~Vous n'êtes pas dans votre lieu de blanchiment"}) end

                    exports['Snoupinput']:ShowInput("Montant en $", 100, "number", "1000", true)
										local count = exports['Snoupinput']:GetInput()

										if (count) then
                      count = tonumber(count)
										  TriggerServerCallback(
                        "Ora::SVCB::Job::Bleacher::CanBleach",
                        function(canBleach, message)
                          if (canBleach) then
                            dataonWait = {
                              price = count,
                              fct = function() TriggerServerEvent("Ora::SE::Job::Bleacher::BleachingMoney", count) end
                            }

                            RageUI.CloseAll()
                            TriggerEvent("payByFakeCash")
                          else
                            RageUI.Popup({message = message})
                          end
                        end,
                        count
                      )
                    end
									end
								end
							)

							RageUI.Button(
								"Blanchiments terminés",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
                    TriggerServerCallback(
                      "Ora::SVCB::Job::Bleacher::GetFinishedList",
                      function(list)
                        Ora.Jobs.Bleacher.CurrentBleachings = list
                      end
                    )
									end
								end,
                RMenu:Get("bleacher", "list")
							)
						end,
						function()
						end
					)
				end

        if (RageUI.Visible(RMenu:Get("bleacher", "list"))) then
          RageUI.DrawContent(
						{header = true, glare = false},
						function()
              if (Ora.Utils:TableLength(Ora.Jobs.Bleacher.CurrentBleachings) == 0) then
                RageUI.Button(
                  "Aucun blanchiment terminé",
                  nil,
                  {},
                  true,
                  function()
                  end
                )
              else
                for id, bleaching in ipairs(Ora.Jobs.Bleacher.CurrentBleachings) do
                  RageUI.Button(
                    string.format("Blanchiment de $%s", bleaching.VALUE),
                    string.format("Effectué à %s pour un total de $%s sans taxe", bleaching.TIMESTAMP, bleaching.INITIALVALUE),
                    {},
                    true,
                    function(_, _, Selected)
                      if (Selected) then
                        TriggerServerEvent("Ora::SE::Job::Bleacher::RetreiveBleaching", id)
                        table.remove(Ora.Jobs.Bleacher.CurrentBleachings, id)
                      end
                    end
                  )
                end
              end
            end
          )
        end

        if (Ora.Identity.Job:GetName() == "bleacher" and Ora.Identity.Job.ChangingJob) then
          KeySettings:Clear("keyboard", "F6", "bleacher")
          break
        elseif (Ora.Identity.Orga:GetName() == "bleacher" and Ora.Identity.Orga.ChangingJob) then
          KeySettings:Clear("keyboard", "F7", "bleacher")
          break
        end
			end
		end
	)
end
