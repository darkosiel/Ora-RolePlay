Ora.Jobs.Immo.Info = {
	Owner = "",
	Coowners = {}
}

RMenu.Add("appart", "Ora_jobs_immo_information", RageUI.CreateSubMenu(RMenu:Get("appart", "main"), "Informations", "Informations"))
RMenu.Add("appart", "coowners", RageUI.CreateSubMenu(RMenu:Get("appart", "Ora_jobs_immo_information"), "Co-propriétaire(s)", "Co-propriétaire(s)"))

Citizen.CreateThread(
	function()
		while true do 
			Wait(0)

			if RageUI.Visible(RMenu:Get("appart","Ora_jobs_immo_information")) then
				RageUI.DrawContent({ header = true, glare = true }, function()
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
						if (Ora.Jobs.Immo.Info.PAYMENT_PROCESS == true) then
							RageUI.CloseAll()
						else
							local buyPrice = Ora.Jobs.Immo.Menu.Property.price .. "$"
							local rentPrice = math.ceil(Ora.Jobs.Immo.Menu.Property.price / 50) .. "$"
							
							RageUI.Button(
								"Intérieur",
								nil,
								{RightLabel = "~h~~b~" .. Ora.Jobs.Immo:GetInteriorById(Ora.Jobs.Immo.Menu.Property.indexx).label .. "~h~"},
								true,
								function(_, _, Selected)
								end
							)
							
							RageUI.Button(
								"Capacité du coffre",
								nil,
								{RightLabel = "~h~~b~" .. Ora.Jobs.Immo.Menu.Property.capacity .. " KG" .. "~h~"},
								true,
								function(_, _, Selected)
								end
							)

							if (Ora.Jobs.Immo.Menu.Property.garageMax ~= nil) then
								RageUI.Button(
									"Capacité garage",
									nil,
									{RightLabel = "~h~~b~" .. Ora.Jobs.Immo.Menu.Property.garageMax .. " Véhicules" .. "~h~"},
									true,
									function(_, _, Selected)
									end
								)
							end

							RageUI.Button(
								"Prix propriété : Achat/Vente",
								nil,
								{RightLabel = "~h~~b~" .. buyPrice .. "~h~"},
								true,
								function(_, Ac, Selected)
								end
							)

							RageUI.Button(
								"Fin du bail",
								nil,
								{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.Menu.Property.time == nil and "Propriétaire" or Ora.Jobs.Immo.Menu.Property.time)},
								true,
								function(_, Ac, Selected)
								end
							)
					
							RageUI.Button(
								"Prix de la location / semaine",
								nil,
								{RightLabel = "~h~~b~" .. rentPrice .. "~h~"},
								true,
								function(_, Ac, Selected) 
								end
							)

							RageUI.Button(
								"Propriétaire",
								nil,
								{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.Info.Owner ~= "" and Ora.Jobs.Immo.Info.Owner or "~r~Personne")},
								true,
								function(_, Ac, Selected)
								end
							)

							RageUI.Button(
								"Co-propriétaire(s)",
								nil,
								{RightLabel = "➡"},
								true,
								function(_, Ac, Selected)
								end,
								RMenu:Get("appart", "coowners")
							)
						end
					end
				end)
			end

			if RageUI.Visible(RMenu:Get("appart", "coowners")) then
				RageUI.DrawContent({ header = true, glare = true }, function()
					if (Ora.Jobs.Immo.Info.Coowners ~= "" and Ora.Jobs.Immo.Info.Coowners ~= {} and Ora.Utils:TableLength(Ora.Jobs.Immo.Info.Coowners) > 0) then
						for _, coowner in pairs(Ora.Jobs.Immo.Info.Coowners) do
							RageUI.Button(
								string.format("~h~~b~%s~h~", coowner),
								nil,
								{},
								true,
								function(_, Ac, Selected)
								end
							)
						end
					else
						RageUI.Button(
							"~h~~r~Personne~h~",
							nil,
							{},
							true,
							function(_, Ac, Selected)
							end
						)
					end
				end)
			end
		end
	end
)

RMenu:Get("appart","Ora_jobs_immo_information").Closed = function()
  Ora.Jobs.Immo.Info.Owner = ""
  Ora.Jobs.Immo.Info.Coowners = ""
end

function Ora.Jobs.Immo:GetPropertyOwners(property)
  for key, value in pairs(property) do
    if (key == "owner") then
		if value:len() < 25 then -- Vérifie si le proprio est un job
			Ora.Jobs.Immo.Info.Owner = value
		else
			TriggerServerCallback(
					"Ora::SE::Identity:GetFullNameFromUUID",
					function(fullname)
						Ora.Jobs.Immo.Info.Owner = fullname
					end,
					value
			)
		end
    elseif (key == "coowner") then
			if (Ora.Utils:TableLength(value) ~= 0) then
				TriggerServerCallback(
					"Ora::SE::Identity:GetFullNamesFromUUIDs",
					function(fullnames)
						Ora.Jobs.Immo.Info.Coowners = fullnames
					end,
					value
				)
			end
    end
  end
end
