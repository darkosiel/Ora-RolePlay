Ora.Jobs.Casino.Shops = {}
Ora.Jobs.Casino.Shops.CurrentZone = nil
Ora.Jobs.Casino.Drinks = {}
Ora.Jobs.Casino.Shops.Peds = { -- s_m_y_casino_01 s_f_y_casino_01
	["Casino Bar 1"] = {
		Pos = {x = 979.77, y = 25.44, z = 71.46 - 0.98, a = 336.74},
		Ped = {
			model = "s_m_y_barman_01"
		},
		Bar = true
	},
	["Casino Bar 2"] = {
		Pos = {x = 978.38, y = 22.58, z = 71.46 - 0.98, a = 144.51},
		Ped = {
			model = "s_m_y_barman_01"
		},
		Bar = true
	}
}
Ora.Jobs.Casino.DrinksPrices = {
	["beer"] = 50,
	["white_wine"] = 50,
	["high_quality_wine"] = 50,
	["red_wine"] = 50,
	["tequila"] = 50,
	["rhum"] = 50,
	["cognac"] = 50,
	["vodka"] = 50,
	["whisky"] = 50,
}


RMenu.Add("casino", "main", RageUI.CreateMenu("Casino", "Actions disponibles", 10, 100))

local function TableLength(t)
	local count = 0
	for _,_ in pairs(t) do count = count + 1 end

	return count
end

function Ora.Jobs.Casino.INIT()
	Citizen.CreateThread(
		function()
			while (Ora.Player.HasLoaded == false) do Wait(500) end
		
			if (Ora.Identity.Job:GetName() == "casino") then
				KeySettings:Add(
					"keyboard",
					"F6",
					function()
						RageUI.Visible(RMenu:Get("casino", "main"), true)
					end,
					"casino"
				)
			elseif (Ora.Identity.Orga:GetName() == "casino") then
				KeySettings:Add(
					"keyboard",
					"F7",
					function()
						RageUI.Visible(RMenu:Get("casino", "main"), true)
					end,
					"casino"
				)
			end

			while true do
				Wait(0)
				if (RageUI.Visible(RMenu:Get("casino", "main"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							RageUI.Button(
								"Facturation",
								nil,
								{},
								true,
								function(_, Active, Selected)
									if Selected then
										CreateFacture("casino")
									end
									if Active then
										HoverPlayer()
									end
								end
							)
							RageUI.Button(
								"Annonce",
								nil,
								{},
								true,
								function(_, _, Selected)
									if Selected then
										exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
										local text = exports['Snoupinput']:GetInput()
										if text ~= false then
											TriggerServerEvent("Job:Annonce", "Casino", "Annonce", text, "CHAR_CASINO", 8, "Casino")
										end
									end
								end
							)
						end,
						function()
						end
					)
				end

				if (Ora.Identity.Job:GetName() == "casino" and Ora.Identity.Job.ChangingJob) then
					KeySettings:Clear("keyboard", "F6", "casino")
					break
				elseif (Ora.Identity.Orga:GetName() == "casino" and Ora.Identity.Orga.ChangingJob) then
					KeySettings:Clear("keyboard", "F7", "casino")
					break
				end
			end
		end
	)
end

function Ora.Jobs.Casino.Shops.EnterZone(zone)
	while (Ora.Player.HasLoaded == false) do Wait(50) end

	Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
	KeySettings:Add("keyboard", "E", Ora.Jobs.Casino.Shops.Toggle, "Shop")
	KeySettings:Add("controller", 46, Ora.Jobs.Casino.Shops.Toggle, "Shop")
	Ora.Jobs.Casino.Shops.Current = zone
end

function Ora.Jobs.Casino.Shops.ExitZone(zone)
	if Ora.Jobs.Casino.Shops.Current ~= nil then
		Hint:RemoveAll()
		if RageUI.Visible(RMenu:Get("shops", Ora.Jobs.Casino.Shops.Current)) then
			RageUI.Visible(RMenu:Get("shops", Ora.Jobs.Casino.Shops.Current), false)
		end
		KeySettings:Clear("keyboard", "E", "Shop")
		KeySettings:Clear("controller", 46, "Shop")
		Ora.Jobs.Casino.Shops.Current = nil
		Ora.Jobs.Casino.Drinks = {}
	end
end

function Ora.Jobs.Casino.Shops.Toggle()
	RageUI.Visible(RMenu:Get("shops", Ora.Jobs.Casino.Shops.Current), not RageUI.Visible(RMenu:Get("shops", Ora.Jobs.Casino.Shops.Current)))
end


Citizen.CreateThread(
	function()
		while (Ora.Player.HasLoaded == false) do Wait(50) end

		for name, v in pairs(Ora.Jobs.Casino.Shops.Peds) do
			Zone:Add(v.Pos, Ora.Jobs.Casino.Shops.EnterZone, Ora.Jobs.Casino.Shops.ExitZone, name, 2.5)
			Ped:Add(v.Ped.name, v.Ped.model, v.Pos, nil)
			RMenu.Add("shops", name, RageUI.CreateMenu(nil, "Objets disponibles", 10, 100, "shopui_title_conveniencestore", "shopui_title_conveniencestore"))
		end

		while true do
			Wait(0)

			if (Ora.Jobs.Casino.Shops.Current ~= nil) then
				if (RageUI.Visible(RMenu:Get("shops", Ora.Jobs.Casino.Shops.Current)) and Ora.Jobs.Casino.Shops.Peds[Ora.Jobs.Casino.Shops.Current].Bar) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							if (TableLength(Ora.Jobs.Casino.Drinks) == 0) then
								RageUI.Button(
									"~b~Demander au serveur ce qu'il propose",
									nil,
									{},
									true,
									function(_, _, Selected)
										if Selected then
											RageUI.Popup({message = "~y~Très bien, merci de patienter."})
											TriggerServerCallback(
												"Ora::SE::Job::Casino::GetDrinksStored",
												function(drinks)
													Ora.Jobs.Casino.Drinks = drinks
												end,
												true
											)
										end
									end
								)
							else
								for name, nb in pairs(Ora.Jobs.Casino.Drinks) do
									RageUI.Button(
										Items[name].label,
										nil,
										{RightLabel = "$"..Ora.Jobs.Casino.DrinksPrices[name]},
										true,
										function(_, _, Selected)
											if Selected then
												exports['Snoupinput']:ShowInput("Combien ?", 90, "number", 1, true)
												local count = exports['Snoupinput']:GetInput()
												if count ~= false then
													if (tonumber(count) > nb) then
														return RageUI.Popup({message = "~r~Malheureusement je n'en ai plus autant, il m'en reste " .. nb})
													end

													TriggerServerCallback(
														"Ora::SE::Job::Casino::GetDrinksStored",
														function(drinks)
															Ora.Jobs.Casino.Drinks = drinks
															
															if (not Ora.Jobs.Casino.Drinks[name]) then
																RageUI.CloseAll()
															end
														end
													)

													dataonWait = {
														item = {
															name = name,
															data = {},
															afterPayment = function()
																TriggerServerEvent("entreprise:Add", "casino", Ora.Jobs.Casino.DrinksPrices[name] * count)
																TriggerServerEvent("Ora::SE::Job::Casino::RemoveFromStorage", name, count)

																if (Ora.Jobs.Casino.Drinks[name] - count <= 0) then
																	Ora.Jobs.Casino.Drinks[name] = nil
																else
																	Ora.Jobs.Casino.Drinks[name] = Ora.Jobs.Casino.Drinks[name] - count
																end
															end
														},
														price = Ora.Jobs.Casino.DrinksPrices[name] * count,
														count = count,
														title = string.format("%s - %s", Ora.Jobs.Casino.DrinksPrices[name], Ora.Jobs.Casino.Shops.Current),
														fct = function() end
													}

													TriggerEvent("payWith?")
												end
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

			end
		end
	end
)
