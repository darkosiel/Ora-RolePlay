Atlantiss.Jobs.Casino.Shops = {}
Atlantiss.Jobs.Casino.Shops.CurrentZone = nil
Atlantiss.Jobs.Casino.Drinks = {}
Atlantiss.Jobs.Casino.Shops.Peds = { -- s_m_y_casino_01 s_f_y_casino_01
	["Casino Bar 1"] = {
		Pos = {x = 939.93, y = 27.56, z = 71.83 - 0.98, a = 326.70},
		Ped = {
			model = "s_m_y_barman_01"
		},
		Bar = true
	},
	["Casino Bar 2"] = {
		Pos = {x = 937.02, y = 26.24, z = 71.83 - 0.98, a = 97.41},
		Ped = {
			model = "s_m_y_barman_01"
		},
		Bar = true
	},
	["Casino Bar 3"] = {
		Pos = {x = 939.79, y = 24.54, z = 71.83 - 0.98, a = 205.535},
		Ped = {
			model = "s_m_y_barman_01"
		},
		Bar = true
	}
}
Atlantiss.Jobs.Casino.DrinksPrices = {
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

function Atlantiss.Jobs.Casino.INIT()
	Citizen.CreateThread(
		function()
			while (Atlantiss.Player.HasLoaded == false) do Wait(500) end
		
			if (Atlantiss.Identity.Job:GetName() == "casino") then
				KeySettings:Add(
					"keyboard",
					"F6",
					function()
						RageUI.Visible(RMenu:Get("casino", "main"), true)
					end,
					"casino"
				)
			elseif (Atlantiss.Identity.Orga:GetName() == "casino") then
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

				if (Atlantiss.Identity.Job:GetName() == "casino" and Atlantiss.Identity.Job.ChangingJob) then
					KeySettings:Clear("keyboard", "F6", "casino")
					break
				elseif (Atlantiss.Identity.Orga:GetName() == "casino" and Atlantiss.Identity.Orga.ChangingJob) then
					KeySettings:Clear("keyboard", "F7", "casino")
					break
				end
			end
		end
	)
end

function Atlantiss.Jobs.Casino.Shops.EnterZone(zone)
	while (Atlantiss.Player.HasLoaded == false) do Wait(50) end

	Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
	KeySettings:Add("keyboard", "E", Atlantiss.Jobs.Casino.Shops.Toggle, "Shop")
	KeySettings:Add("controller", 46, Atlantiss.Jobs.Casino.Shops.Toggle, "Shop")
	Atlantiss.Jobs.Casino.Shops.Current = zone
end

function Atlantiss.Jobs.Casino.Shops.ExitZone(zone)
	if Atlantiss.Jobs.Casino.Shops.Current ~= nil then
		Hint:RemoveAll()
		if RageUI.Visible(RMenu:Get("shops", Atlantiss.Jobs.Casino.Shops.Current)) then
			RageUI.Visible(RMenu:Get("shops", Atlantiss.Jobs.Casino.Shops.Current), false)
		end
		KeySettings:Clear("keyboard", "E", "Shop")
		KeySettings:Clear("controller", 46, "Shop")
		Atlantiss.Jobs.Casino.Shops.Current = nil
		Atlantiss.Jobs.Casino.Drinks = {}
	end
end

function Atlantiss.Jobs.Casino.Shops.Toggle()
	RageUI.Visible(RMenu:Get("shops", Atlantiss.Jobs.Casino.Shops.Current), not RageUI.Visible(RMenu:Get("shops", Atlantiss.Jobs.Casino.Shops.Current)))
end


Citizen.CreateThread(
	function()
		while (Atlantiss.Player.HasLoaded == false) do Wait(50) end

		for name, v in pairs(Atlantiss.Jobs.Casino.Shops.Peds) do
			Zone:Add(v.Pos, Atlantiss.Jobs.Casino.Shops.EnterZone, Atlantiss.Jobs.Casino.Shops.ExitZone, name, 2.5)
			Ped:Add(v.Ped.name, v.Ped.model, v.Pos, nil)
			RMenu.Add("shops", name, RageUI.CreateMenu(nil, "Objets disponibles", 10, 100, "shopui_title_conveniencestore", "shopui_title_conveniencestore"))
		end

		while true do
			Wait(0)

			if (Atlantiss.Jobs.Casino.Shops.Current ~= nil) then
				if (RageUI.Visible(RMenu:Get("shops", Atlantiss.Jobs.Casino.Shops.Current)) and Atlantiss.Jobs.Casino.Shops.Peds[Atlantiss.Jobs.Casino.Shops.Current].Bar) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							if (TableLength(Atlantiss.Jobs.Casino.Drinks) == 0) then
								RageUI.Button(
									"~b~Demander au serveur ce qu'il propose",
									nil,
									{},
									true,
									function(_, _, Selected)
										if Selected then
											RageUI.Popup({message = "~y~Très bien, merci de patienter."})
											TriggerServerCallback(
												"Atlantiss::SE::Job::Casino::GetDrinksStored",
												function(drinks)
													Atlantiss.Jobs.Casino.Drinks = drinks
												end,
												true
											)
										end
									end
								)
							else
								for name, nb in pairs(Atlantiss.Jobs.Casino.Drinks) do
									RageUI.Button(
										Items[name].label,
										nil,
										{RightLabel = "$"..Atlantiss.Jobs.Casino.DrinksPrices[name]},
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
														"Atlantiss::SE::Job::Casino::GetDrinksStored",
														function(drinks)
															Atlantiss.Jobs.Casino.Drinks = drinks
															
															if (not Atlantiss.Jobs.Casino.Drinks[name]) then
																RageUI.CloseAll()
															end
														end
													)

													dataonWait = {
														item = {
															name = name,
															data = {},
															afterPayment = function()
																TriggerServerEvent("entreprise:Add", "casino", Atlantiss.Jobs.Casino.DrinksPrices[name] * count)
																TriggerServerEvent("Atlantiss::SE::Job::Casino::RemoveFromStorage", name, count)

																if (Atlantiss.Jobs.Casino.Drinks[name] - count <= 0) then
																	Atlantiss.Jobs.Casino.Drinks[name] = nil
																else
																	Atlantiss.Jobs.Casino.Drinks[name] = Atlantiss.Jobs.Casino.Drinks[name] - count
																end
															end
														},
														price = Atlantiss.Jobs.Casino.DrinksPrices[name] * count,
														count = count,
														title = string.format("%s - %s", Atlantiss.Jobs.Casino.DrinksPrices[name], Atlantiss.Jobs.Casino.Shops.Current),
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
