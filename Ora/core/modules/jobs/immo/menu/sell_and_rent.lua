function Ora.Jobs.Immo:ResetSellAndRent()
	self.SellAndRent = {
		PAYMENT_PROCESS = false,
		CLIENT = nil,
		CLIENT_FULLNAME = "",
		PRICE_TO_PAY = 0,
		NUMBER_OF_WEEKS = 1
	}
end

Ora.Jobs.Immo.SellAndRent = Ora.Jobs.Immo:ResetSellAndRent()

RMenu.Add("appart", "Ora_jobs_immo_sell", RageUI.CreateSubMenu(RMenu:Get("appart", "main"), "Vendre la propriété", "Informations"))
RMenu.Add("appart", "Ora_jobs_immo_rent", RageUI.CreateSubMenu(RMenu:Get("appart", "main"), "Louer la propriété", "Informations"))
RMenu.Add("appart", "Ora_jobs_immo_self_rent", RageUI.CreateSubMenu(RMenu:Get("appart", "main"), "Prolonger la location", "Informations"))

Citizen.CreateThread(
  function()
    while true do
		Wait(0)
		if RageUI.Visible(RMenu:Get("appart","Ora_jobs_immo_sell")) then
			RageUI.DrawContent({ header = true, glare = false }, function()
				if (Ora.Jobs.Immo.Menu == nil or Ora.Jobs.Immo.Menu.Property == nil) then
					RageUI.Button(
						"~r~Aucune propriété selectionnée pour le moment",
						nil,
						{},
						true,
						function(_, _, Selected)
						end
					)
				else
					if (Ora.Jobs.Immo.SellAndRent.PAYMENT_PROCESS == true) then
						RageUI.CloseAll()
					else

						RageUI.Button(
							"Nom de la location",
							nil,
							{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.Menu.Property.name)},
							true,
							function(_, Ac, Selected)
								
							end
						)

						
						if (Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY == 0) then
							Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY = math.ceil(Ora.Jobs.Immo.Menu.Property.price)
						end

						RageUI.Button(
							"Prix propriété : Achat/Vente",
							nil,
							{RightLabel = string.format("~h~~b~%s$~h~", Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY)},
							true,
							function(_, Ac, Selected)
								if Selected then
									-- local price = KeyboardInput("~b~Nouveau prix de vente", Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY, 10)
									-- if (math.tointeger(price) ~= nil and math.tointeger(price) > 0) then
									--   Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY = math.tointeger(price)
									--   ShowNotification(string.format("Le montant est désormais de ~h~~g~%s~h~~s~", math.tointeger(price) .. "$"))
									-- else
									--   ShowNotification(string.format("Le montant selectionné est ~h~~r~%s~h~~s~", "invalide"))
									-- end
								end
							end
						)
				
						RageUI.Button(
							"Acquereur",
							"Appuyez sur ~h~ENTRER~h~ pour selectionner l'acquereur",
							{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME)},
							true,
							function(_, Ac, Selected)
								if Ac then
									HoverPlayer()
								end
								if Selected then
									local playerId = GetPlayerServerIdInDirection(8.0)
									if (playerId ~= false) then
										local playerFullname = Ora.Identity:GetFullname(playerId)
										Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME = playerFullname
										Ora.Jobs.Immo.SellAndRent.CLIENT = playerId
										ShowNotification(string.format("Vous avez selectionné ~h~~g~%s~s~~h~", Ora.Identity:GetFullname(playerId)))
									else
										ShowNotification(string.format("Vous n'avez selectionné ~h~~r~%s~h~~s~", "aucun joueur"))
									end
								end
							end
						)

						RageUI.CenterButton(
							"~h~~g~Valider la vente~s~~h~",
							"Appuyez sur ~h~ENTRER~h~ pour finaliser la vente",
							{},
							true,
							function(_, Ac, Selected)
								if Selected then
									if Ora.Jobs.Immo.SellAndRent.CLIENT ~= nil then
										local finalPrice = Ora.Jobs.Immo.Menu.Property.price

										if (Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY > 0) then
											finalPrice = Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY
										end
										RageUI.CloseAll()

										TriggerServerCallback(
											"getBankingAccountsPly3",
											function(result)
												if (result[1].amount - finalPrice >= 0) then
													--TriggerServerEvent("business:SetProductivity", Ora.Jobs.Immo.SellAndRent.CLIENT, "immo", finalPrice, false)
													TriggerServerEvent("appart:updateown", Ora.Jobs.Immo.SellAndRent.CLIENT, Ora.Jobs.Immo.Menu.Property.id)
													--TriggerServerEvent("Ora:RemoveFromBankAccount", "immo", finalPrice)

													TriggerServerEvent(
													"newTransaction",
													"Agent Immobilier",
													"immo",
													finalPrice,
													string.format("Vente de %s", Ora.Jobs.Immo.Menu.Property.name),
													string.format("%s a vendu un bien à %s.", Ora.Identity:GetMyName(), Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME)
													)
													
													ShowNotification(string.format("Vous avez vendu ~h~~g~%s~h~~s~ à ~h~~g~%s~h~~s~ pour ~h~~g~%s$~h~~s~", Ora.Jobs.Immo.Menu.Property.name, Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME, finalPrice))
												else
													ShowNotification("~r~L'entreprise n'a pas assez d'argent dans le compte bancaire !")
												end
											end,
											"immo"
										)
									else
										ShowNotification(string.format("Vous n'avez selectionné ~h~~r~%s~h~~s~", "aucun joueur"))
									end
								end
							end
						)
					end
				end
			end)
		end


		if RageUI.Visible(RMenu:Get("appart","Ora_jobs_immo_rent")) then
			RageUI.DrawContent({ header = true, glare = false }, function()

				if (Ora.Jobs.Immo.Menu == nil or Ora.Jobs.Immo.Menu.Property == nil) then
					RageUI.Button(
						"~r~Aucune propriété selectionnée pour le moment",
						nil,
						{},
						true,
						function(_, _, Selected)
						end
					)
				else
					if (Ora.Jobs.Immo.SellAndRent.PAYMENT_PROCESS == true) then
						RageUI.CloseAll()
					else
						if (Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY == 0) then
							Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY = math.ceil(Ora.Jobs.Immo.Menu.Property.price / 50)
						end

						RageUI.Button(
							"Nom de la location",
							nil,
							{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.Menu.Property.name)},
							true,
							function(_, Ac, Selected)
							end
						)

						RageUI.Button(
							"Prix propriété : Location",
							nil,
							{RightLabel = string.format("~h~~b~%s$~h~", Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY)},
							true,
							function(_, Ac, Selected)
								if Selected then
								-- local price = KeyboardInput("~b~Nouveau prix de location / semaine", Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY, 10)
								-- if (math.tointeger(price) ~= nil and math.tointeger(price) > 0) then
								--   Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY = math.tointeger(price)
								--   ShowNotification(string.format("Le montant est désormais de ~h~~g~%s~h~~s~", math.tointeger(price) .. " $"))
								-- else
								--   ShowNotification(string.format("Le montant selectionné est ~h~~r~%s~h~~s~", "invalide"))
								-- end
								end
							end
						)

						RageUI.Button(
							"Nombre de semaines de location",
							"Appuyez sur ~h~ENTRER~h~ pour définir le nombre de semaine",
							{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS)},
							true,
							function(_, Ac, Selected)
								if Selected then
									local weeks = KeyboardInput("~b~Nombre de semaines", Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS, 1)
									if (math.tointeger(weeks) ~= nil and math.tointeger(weeks) > 0) then
										Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS = math.tointeger(weeks)
										ShowNotification(string.format("Le nombre de semaine est de ~h~~g~%s~h~~s~", math.tointeger(weeks)))
									else
										ShowNotification(string.format("Le nombre de semaine est ~h~~r~%s~h~~s~", "invalide"))
									end
								end
							end
						)

						RageUI.Button(
							"Prix total à payer",
							nil,
							{RightLabel = string.format("~h~~b~%s$~h~", Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY * Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS)},
							true,
							function(_, Ac, Selected)
							end
						)
				
						RageUI.Button(
							"Locataire",
							"Appuyez sur ~h~ENTRER~h~ pour selectionner le locataire",
							{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME)},
							true,
							function(_, Ac, Selected)
								if Ac then
									HoverPlayer()
								end
								if Selected then
									local playerId = GetPlayerServerIdInDirection(8.0)
									if (playerId ~= false) then
										local playerFullname = Ora.Identity:GetFullname(playerId)
										Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME = playerFullname
										Ora.Jobs.Immo.SellAndRent.CLIENT = playerId
										ShowNotification(string.format("Vous avez selectionné ~h~~g~%s~s~~h~", Ora.Identity:GetFullname(playerId)))
									else
										ShowNotification(string.format("Vous n'avez selectionné ~h~~r~%s~h~~s~", "aucun joueur"))
									end
								end
							end
						)

						RageUI.CenterButton(
							"~h~~g~Valider la location~s~~h~",
							"Appuyez sur ~h~ENTRER~h~ pour la location",
							{},
							true,
							function(_, Ac, Selected)
								if Selected then
								if Ora.Jobs.Immo.SellAndRent.CLIENT ~= nil then
									local finalPrice = (Ora.Jobs.Immo.Menu.Property.price / 50) * Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS

									if (Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY > 0) then
										finalPrice = Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY * Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS
									end
									RageUI.CloseAll()

									TriggerServerCallback(
										"getBankingAccountsPly3",
										function(result)
											if (result[1].amount - finalPrice >= 0) then
												--TriggerServerEvent("business:SetProductivity", Ora.Jobs.Immo.SellAndRent.CLIENT, "immo", finalPrice, false)
												TriggerServerEvent("appart:updateownLoc", Ora.Jobs.Immo.SellAndRent.CLIENT, Ora.Jobs.Immo.Menu.Property.id, Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS)
												--TriggerServerEvent("Ora:RemoveFromBankAccount", "immo", finalPrice)

												TriggerServerEvent(
													"newTransaction",
													"Agent Immobilier",
													"immo",
													finalPrice,
													string.format("Location de %s", Ora.Jobs.Immo.Menu.Property.name),
													string.format("%s a loué un bien à %s pendant %s semaine(s).", Ora.Identity:GetMyName(), Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME, Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS)
												)
													
												ShowNotification(string.format("Vous avez loué ~h~~g~%s~h~~s~ à ~h~~g~%s~h~~s~", Ora.Jobs.Immo.Menu.Property.name, Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME))      
												ShowNotification(string.format("pour ~h~~g~%s~h~~s~ semaine(s) à ~h~~g~%s$~h~~s~", Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS, finalPrice))
											else
												ShowNotification("~r~L'entreprise n'a pas assez d'argent dans le compte bancaire !")
											end
										end,
										"immo"
									)
								else
									ShowNotification(string.format("Vous n'avez selectionné ~h~~r~%s~h~~s~", "aucun joueur"))
								end
							end
						end
						)
					end
				end
			end)
		end

			if (RageUI.Visible(RMenu:Get("appart","Ora_jobs_immo_self_rent"))) then
				RageUI.DrawContent({ header = true, glare = false }, function()
					if (Ora.Jobs.Immo.Menu == nil or Ora.Jobs.Immo.Menu.Property == nil) then
						RageUI.Button(
							"~r~Aucune propriété selectionnée pour le moment",
							nil,
							{},
							true,
							function(_, _, Selected)
							end
						)
					else
						if (Ora.Jobs.Immo.SellAndRent.PAYMENT_PROCESS == true) then
							RageUI.CloseAll()
						else

							if (Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY == 0) then
								Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY = math.ceil(Ora.Jobs.Immo.Menu.Property.price / 50)
							end

							RageUI.Button(
								"Nom de la location",
								nil,
								{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.Menu.Property.name)},
								true,
								function(_, Ac, Selected)
								end
							)

							RageUI.Button(
								"Prix propriété : Location",
								string.format("+ Taxe: %s", (Ora.Jobs.Immo.Tax * 100) - 100 .. "%"),
								{RightLabel = string.format("~h~~b~%s$~h~", Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY)},
								true,
								function(_, Ac, Selected)
									if Selected then
										-- local price = KeyboardInput("~b~Nouveau prix de location / semaine", Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY, 10)
										-- if (math.tointeger(price) ~= nil and math.tointeger(price) > 0) then
										--   Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY = math.tointeger(price)
										--   ShowNotification(string.format("Le montant est désormais de ~h~~g~%s~h~~s~", math.tointeger(price) .. " $"))
										-- else
										--   ShowNotification(string.format("Le montant selectionné est ~h~~r~%s~h~~s~", "invalide"))
										-- end
									end
								end
							)

							RageUI.Button(
								"Nombre de semaines de prolongation",
								"Appuyez sur ~h~ENTRER~h~ pour définir le nombre de semaine",
								{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS)},
								true,
								function(_, Ac, Selected)
									if Selected then
										local weeks = KeyboardInput("~b~Nombre de semaines", Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS, 1)
										if (math.tointeger(weeks) ~= nil and math.tointeger(weeks) > 0) then
											Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS = math.tointeger(weeks)
											ShowNotification(string.format("Le nombre de semaine est de ~h~~g~%s~h~~s~", math.tointeger(weeks)))
										else
											ShowNotification(string.format("Le nombre de semaine est ~h~~r~%s~h~~s~", "invalide"))
										end
									end
								end
							)

							RageUI.Button(
								"Prix total à payer avec la taxe",
								nil,
								{RightLabel = string.format("~h~~b~%s$~h~", math.floor((Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY * Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS) * Ora.Jobs.Immo.Tax))},
								true,
								function(_, Ac, Selected)
								end
							)
					
							RageUI.Button(
								"Locataire",
								nil,
								{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME)},
								true,
								function(_, Ac, Selected)
								end
							)

							RageUI.CenterButton(
								"~h~~g~Valider la prolongation~s~~h~",
								"Appuyez sur ~h~ENTRER~h~ pour valider",
								{},
								true,
								function(_, Ac, Selected)
									if Selected then
										if Ora.Jobs.Immo.SellAndRent.CLIENT ~= nil then
											local finalPrice = (Ora.Jobs.Immo.Menu.Property.price / 50) * Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS

											if (Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY > 0) then
												finalPrice = math.floor((Ora.Jobs.Immo.SellAndRent.PRICE_TO_PAY * Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS) * Ora.Jobs.Immo.Tax)
											end
											RageUI.CloseAll()

											dataonWait = {
												title = string.format("Prolongation de %s pendant %s semaine(s).", Ora.Jobs.Immo.Menu.Property.name, Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS),
												price = finalPrice,
												account = "immo",
												fct = function()
													TriggerServerEvent("appart:updateownLoc", Ora.Jobs.Immo.SellAndRent.CLIENT, Ora.Jobs.Immo.Menu.Property.id, Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS)
													TriggerServerEvent(
														"Ora:AddFromBankAccount",
														"immo",
														finalPrice - (Ora.Jobs.Immo.Menu.Property.price / 50) * Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS
													)
		
													TriggerServerEvent(
														"newTransaction",
														Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME,
														"immo",
														finalPrice,
														string.format("Prolongation de %s", Ora.Jobs.Immo.Menu.Property.name),
														string.format("a prolongé son bail pendant %s semaine(s) pour %s$.", Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS, finalPrice)
													)
														
													ShowNotification(string.format("Vous avez prolongé ~h~~g~%s~h~~s~ pour ~h~~g~%s~h~~s~ semaine(s) à ~h~~g~%s$~h~~s~", Ora.Jobs.Immo.Menu.Property.name, Ora.Jobs.Immo.SellAndRent.NUMBER_OF_WEEKS, finalPrice))      
												end
											}

											TriggerEvent("payWith?")

										else
											ShowNotification(string.format("Vous n'avez selectionné ~h~~r~%s~h~~s~", "aucun joueur"))
										end
									end
								end
							)
						end
					end
				end)
			end
		end
  	end
)