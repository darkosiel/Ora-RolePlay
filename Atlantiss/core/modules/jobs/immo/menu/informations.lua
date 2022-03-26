Atlantiss.Jobs.Immo.Info = {
	Owner = "",
	Coowners = {}
}

RMenu.Add("appart", "atlantiss_jobs_immo_information", RageUI.CreateSubMenu(RMenu:Get("appart", "main"), "Informations", "Informations"))
RMenu.Add("appart", "coowners", RageUI.CreateSubMenu(RMenu:Get("appart", "atlantiss_jobs_immo_information"), "Co-propriétaire(s)", "Co-propriétaire(s)"))

Citizen.CreateThread(
	function()
		while true do 
			Wait(0)

			if RageUI.Visible(RMenu:Get("appart","atlantiss_jobs_immo_information")) then
				RageUI.DrawContent({ header = true, glare = true }, function()
					if (Atlantiss.Jobs.Immo.Menu == nil or Atlantiss.Jobs.Immo.Menu.Property == nil) then
						RageUI.Button(
							"~r~Aucune propriété selectionnée pour le moment",
							nil,
							{},
							true,
							function(_, _, Selected)
							end
						)
					else
						if (Atlantiss.Jobs.Immo.Info.PAYMENT_PROCESS == true) then
							RageUI.CloseAll()
						else
							local buyPrice = Atlantiss.Jobs.Immo.Menu.Property.price .. "$"
							local rentPrice = math.ceil(Atlantiss.Jobs.Immo.Menu.Property.price / 50) .. "$"
							
							RageUI.Button(
								"Intérieur",
								nil,
								{RightLabel = "~h~~b~" .. Atlantiss.Jobs.Immo:GetInteriorById(Atlantiss.Jobs.Immo.Menu.Property.indexx).label .. "~h~"},
								true,
								function(_, _, Selected)
								end
							)
							
							RageUI.Button(
								"Capacité du coffre",
								nil,
								{RightLabel = "~h~~b~" .. Atlantiss.Jobs.Immo.Menu.Property.capacity .. " KG" .. "~h~"},
								true,
								function(_, _, Selected)
								end
							)

							if (Atlantiss.Jobs.Immo.Menu.Property.garageMax ~= nil) then
								RageUI.Button(
									"Capacité garage",
									nil,
									{RightLabel = "~h~~b~" .. Atlantiss.Jobs.Immo.Menu.Property.garageMax .. " Véhicules" .. "~h~"},
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
								{RightLabel = string.format("~h~~b~%s~h~", Atlantiss.Jobs.Immo.Menu.Property.time == nil and "Propriétaire" or Atlantiss.Jobs.Immo.Menu.Property.time)},
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
								{RightLabel = string.format("~h~~b~%s~h~", Atlantiss.Jobs.Immo.Info.Owner ~= "" and Atlantiss.Jobs.Immo.Info.Owner or "~r~Personne")},
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
					if (Atlantiss.Jobs.Immo.Info.Coowners ~= "" and Atlantiss.Jobs.Immo.Info.Coowners ~= {} and Atlantiss.Utils:TableLength(Atlantiss.Jobs.Immo.Info.Coowners) > 0) then
						for _, coowner in pairs(Atlantiss.Jobs.Immo.Info.Coowners) do
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

RMenu:Get("appart","atlantiss_jobs_immo_information").Closed = function()
  Atlantiss.Jobs.Immo.Info.Owner = ""
  Atlantiss.Jobs.Immo.Info.Coowners = ""
end

function Atlantiss.Jobs.Immo:GetPropertyOwners(property)
  for key, value in pairs(property) do
    if (key == "owner") then
      TriggerServerCallback(
        "Atlantiss::SE::Identity:GetFullNameFromUUID",
        function(fullname)
					Atlantiss.Jobs.Immo.Info.Owner = fullname
        end,
        value
      )
    elseif (key == "coowner") then
			if (Atlantiss.Utils:TableLength(value) ~= 0) then
				TriggerServerCallback(
					"Atlantiss::SE::Identity:GetFullNamesFromUUIDs",
					function(fullnames)
						Atlantiss.Jobs.Immo.Info.Coowners = fullnames
					end,
					value
				)
			end
    end
  end
end
