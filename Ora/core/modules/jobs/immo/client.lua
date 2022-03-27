Ora.Jobs.Immo.SubMenu = {
	SelectedProperty = nil,
	CurrentOwner = "",
	CurrentCoowners = {},
	CurrentGaragePos = nil,
	CurrentCapacity = 1,
	CurrentGarageMax = 1,
	HasBeenUpdated = false,
	UpdatedStuff = {}
}


RMenu.Add("immo", "main", RageUI.CreateMenu("Immobilier ", "Actions disponibles", 10, 100))

RMenu.Add(
	"immo",
	"put_proprio",
	RageUI.CreateSubMenu(RMenu:Get("immo", "main"), "Immobilier ", "Actions disponibles", 10, 100)
)

RMenu.Add(
    "Ora:Immo",
    "Raids",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Perquisitions en cours", "Selectionner pour accéder aux détails")
)

RMenu.Add(
    "Ora:Immo",
    "Raids_confirm",
    RageUI.CreateSubMenu(RMenu:Get("Ora:Immo", "Raids"), "Perquisitions en cours", "Options")
)

RMenu.Add(
    "Ora:Immo",
    "List",
    RageUI.CreateSubMenu(RMenu:Get("immo", "main"), "Propriétés existantes", "Liste")
)

RMenu.Add(
    "Ora:Immo",
    "CurrentProperty",
    RageUI.CreateSubMenu(RMenu:Get("Ora:Immo", "List"), "Propriété sélectionnée", "Détails")
)

RMenu.Add(
    "Ora:Immo",
	"Coowners",
    RageUI.CreateSubMenu(RMenu:Get("Ora:Immo", "CurrentProperty"), "Co-propriétaire(s)", "Noms")
)

RMenu.Add(
    "Ora:Immo:Update",
	"Interior",
    RageUI.CreateSubMenu(RMenu:Get("Ora:Immo", "CurrentProperty"), "Modifier l'intérieur", "Intérieurs disponibles")
)

RMenu.Add("appart", "main", RageUI.CreateMenu(nil, "Actions disponibles", 10, 100))


function Ora.Jobs.Immo:RemoveExits()
	for key, value in pairs(self:GetInteriors()) do
		local property = value
		value.entry.z = value.entry.z - 0.9
		Zone:Remove(value.entry)
	end
end

function Ora.Jobs.Immo:CreateExits()
	for key, value in pairs(self:GetInteriors()) do
		local property = value
		value.entry.z = value.entry.z - 0.9
		Zone:Add(value.entry, Ora.World.Appart["ExitFromAppartCreateHint"], Ora.World.Appart["ExitFromAppartRemoveHint"], value.entry, 1.3)
	end
end

function Ora.Jobs.Immo.INIT()
	Citizen.CreateThread(
		function()
			while (Ora.Player.HasLoaded == false) do Wait(500) end

			local PosOfMarker, isMarkerEnabled, WeightOfPos, PosOfInterior, cam, numberOfHouse
			local PosInLabelAppart = 1
			local createdCamera = nil
			local CoordsCamList = Ora.Jobs.Immo:GetInteriors()
			local price
			local oldIndex
			local CurrentProperty
			local users = {}

			RMenu:Get("immo", "put_proprio").Closed = function()
				PosOfMarker, isMarkerEnabled, WeightOfPos, PosOfInterior, cam, numberOfHouse = nil
				PosInLabelAppart = 1
				createdCamera = nil
				DestroyCam(createdCamera, 0)
				RenderScriptCams(0, 0, 1, 1, 1)
				createdCamera = 0
				ClearTimecycleModifier("scanline_cam_cheap")
				SetFocusEntity(GetPlayerPed(PlayerId()))
			end

			RMenu:Get("Ora:Immo", "CurrentProperty").Closed = function()
				Ora.Jobs.Immo.SubMenu.CurrentGaragePos = nil
				Ora.Jobs.Immo.SubMenu.HasBeenUpdated = false
				Ora.Jobs.Immo.SubMenu.UpdatedStuff = {}
			end

			if (Ora.Identity.Job:GetName() == "immo") then
				KeySettings:Add(
					"keyboard",
					"F6",
					function()
						RageUI.Visible(RMenu:Get("immo", "main"), true)
					end,
					"immo"
				)
			else
				KeySettings:Add(
					"keyboard",
					"F7",
					function()
						RageUI.Visible(RMenu:Get("immo", "main"), true)
					end,
					"immo"
				)
			end

			while true do
				Wait(0)

				if (RageUI.Visible(RMenu:Get("immo", "main"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							RageUI.Button(
								"Créer une propriété",
								nil,
								{},
								true,
								function(Hovered, Active, Selected)
									if (Active and Ora.Player:IsFreezed()) then
										Ora.Player:FreezePlayer(LocalPlayer().Ped, false)
									end
									if (Selected) then
										Ora.Jobs.Immo:ResetCurrent()
									end
								end,
								RMenu:Get("immo", "put_proprio")
							)

							RageUI.Button(
								"Facture",
								nil,
								{},
								true,
								function(Hovered, Active, Selected)
									if Selected then
										CreateFacture("immo")
									end
									if Active then
										HoverPlayer()
									end
								end
							)

							RageUI.Button(
								"Liste des propriétés existantes",
								nil,
								{},
								true,
								function(Hovered, Active, Selected)
								end,
								RMenu:Get("Ora:Immo", "List")
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
										if (text ~= false and text ~= "") then
											TriggerServerEvent("Job:Annonce", "Agence Immobilière", "Annonce", text, "CHAR_IMMO", 8)
										end
									end
								end
							)
						end,
						function()
						end
					)
				end

				if RageUI.Visible(RMenu:Get("immo", "put_proprio")) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							if Ora.Jobs.Immo.Current.ENTRY_POS ~= nil and type(Ora.Jobs.Immo.Current.ENTRY_POS) == "vector3" then
								DrawMarker( 25, Ora.Jobs.Immo.Current.ENTRY_POS.x, Ora.Jobs.Immo.Current.ENTRY_POS.y, Ora.Jobs.Immo.Current.ENTRY_POS.z, nil, nil, nil, nil, nil, nil, 1.0, 1.0, 1.0, 255, 255, 255, 100 )

								if Ora.Jobs.Immo.Current.GARAGE_POS ~= nil and type(Ora.Jobs.Immo.Current.GARAGE_POS) == "vector3" then
									DrawMarker( 25, Ora.Jobs.Immo.Current.GARAGE_POS.x, Ora.Jobs.Immo.Current.GARAGE_POS.y, Ora.Jobs.Immo.Current.GARAGE_POS.z, nil, nil, nil, nil, nil, nil, 1.0, 1.0, 1.0, 125, 0, 0, 100 )
								end
							end
							RageUI.Button(
								"Placer une propriété",
								"Place l'entrée de la propriété",
								{},
								true,
								function(Hovered, Active, Selected)
									if Active then
										coords = LocalPlayer().Pos
										if Ora.Jobs.Immo.Current.ENTRY_POS == nil then
											DrawMarker(25, coords.x, coords.y, coords.z - 0.95, nil, nil, nil, nil, nil, nil, 1.0, 1.0, 1.0, 255, 255, 255, 100 )
										else
											DrawMarker(25, Ora.Jobs.Immo.Current.ENTRY_POS.x, Ora.Jobs.Immo.Current.ENTRY_POS.y, Ora.Jobs.Immo.Current.ENTRY_POS.z, nil, nil, nil, nil, nil, nil, 1.0, 1.0, 1.0, 255, 255, 255, 100 )
										end
									end
									if Selected then
										coords = LocalPlayer().Pos
										Ora.Jobs.Immo.Current.ENTRY_POS = vector3(coords.x, coords.y, coords.z - 0.95)
									end
								end,
								RMenu:Get("immo", "main_second")
							)

							if Ora.Jobs.Immo.Current.ENTRY_POS ~= nil and type(Ora.Jobs.Immo.Current.ENTRY_POS) == "vector3" then
								RageUI.List(
									"Capacité du coffre",
									Ora.Jobs.Immo:GetAvailableWeight(),
									Ora.Jobs.Immo.Current.SAFE_INDEX,
									nil,
									{},
									true,
									function(Hovered, Active, Selected, Index)
										if Active then
											Ora.Jobs.Immo.Current.SAFE_INDEX = Index
										end
									end
								)


								local streetName --[[ Hash ]], crossingRoad --[[ Hash ]] =
									GetStreetNameAtCoord(Ora.Jobs.Immo.Current.ENTRY_POS.x, Ora.Jobs.Immo.Current.ENTRY_POS.y, Ora.Jobs.Immo.Current.ENTRY_POS.z)
								realstreetname = GetStreetNameFromHashKey(streetName)

								RageUI.Button(
									"Numéro de la propriété",
									"Indiquez le numéro de la maison",
									{
										RightLabel = Ora.Jobs.Immo.Current.HOUSE_NUMBER
									},
									true,
									function(Hovered, Active, Selected)
										if Selected then
											exports['Snoupinput']:ShowInput("Entrez le numéro de la propriété", 4, "number", nil, true)
											local input = exports['Snoupinput']:GetInput()
											if (input ~= false and input ~= "" and tonumber(input) ~= nil) then
												TriggerServerCallback(
													'appart:doesExists',
													function(b)
														if b then
															ShowNotification("~r~Ce numéro existe déjà dans cette rue.")
														else
															Ora.Jobs.Immo.Current.HOUSE_NUMBER = realstreetname .. " #" .. input 
														end
													end,
													realstreetname .. " #" .. input
												)
											end
										end
									end
								)

								RageUI.List(
									"Intérieur",
									Ora.Jobs.Immo:GetInteriorLabels(),
									Ora.Jobs.Immo.Current.INTERIOR_INDEX,
									nil,
									{},
									true,
									function(Hovered, Active, Selected, Index)
										Ora.Jobs.Immo.Current.INTERIOR_INDEX = Index
										if Active and oldIndex ~= Index then
											Ora.Player:FreezePlayer(LocalPlayer().Ped, true)
											Ora.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, true)
											DestroyCam(Ora.Jobs.Immo.Current.CAMERA, 0)
											RenderScriptCams(0, 0, 1, 1, 1)
											ClearTimecycleModifier("scanline_cam_cheap")
											SetFocusEntity(GetPlayerPed(PlayerId()))
											oldIndex = Index
											Ora.Jobs.Immo.Current.INTERIOR_DATA = Ora.Jobs.Immo:GetInteriorById(Index)
											Ora.Jobs.Immo.Current.INTERIOR_CAMERA = Ora.Jobs.Immo.Current.INTERIOR_DATA.coords
											Ora.Jobs.Immo.Current.INTERIOR_CAMERA_ROTATION = Ora.Jobs.Immo.Current.INTERIOR_DATA.r

											local int = GetInteriorAtCoords(Ora.Jobs.Immo.Current.INTERIOR_CAMERA.x, Ora.Jobs.Immo.Current.INTERIOR_CAMERA.y, Ora.Jobs.Immo.Current.INTERIOR_CAMERA.z)
											LoadInterior(int)
											while not IsInteriorReady(int) do
												Wait(1)
											end
											Ora.Jobs.Immo.Current.CAMERA = CreateCam("DEFAULT_SCRIPTED_CAMERA", 2)
											SetCamCoord(Ora.Jobs.Immo.Current.CAMERA, Ora.Jobs.Immo.Current.INTERIOR_CAMERA.x, Ora.Jobs.Immo.Current.INTERIOR_CAMERA.y, Ora.Jobs.Immo.Current.INTERIOR_CAMERA.z)
											SetCamRot(Ora.Jobs.Immo.Current.CAMERA, Ora.Jobs.Immo.Current.INTERIOR_CAMERA_ROTATION.x, Ora.Jobs.Immo.Current.INTERIOR_CAMERA_ROTATION.y, Ora.Jobs.Immo.Current.INTERIOR_CAMERA_ROTATION.z, 1)
											SetFocusArea(Ora.Jobs.Immo.Current.INTERIOR_CAMERA.x, Ora.Jobs.Immo.Current.INTERIOR_CAMERA.y, Ora.Jobs.Immo.Current.INTERIOR_CAMERA.z, Ora.Jobs.Immo.Current.INTERIOR_CAMERA.x, Ora.Jobs.Immo.Current.INTERIOR_CAMERA.y, Ora.Jobs.Immo.Current.INTERIOR_CAMERA.z)
											RenderScriptCams(1, 0, 0, 1, 1)
										elseif not Active then
											DestroyCam(Ora.Jobs.Immo.Current.CAMERA, 0)
											RenderScriptCams(0, 0, 1, 1, 1)
											Ora.Jobs.Immo.Current.CAMERA = nil
											ClearTimecycleModifier("scanline_cam_cheap")
											SetFocusEntity(GetPlayerPed(PlayerId()))
											Ora.Player:FreezePlayer(LocalPlayer().Ped, false)
											Ora.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, false)
										end
									end
								)

								RageUI.Button(
									"Placer l'entrée du garage",
									nil,
									{},
									true,
									function(Hovered, Active, Selected)
										if Active then
											coords = LocalPlayer().Pos
											if Ora.Jobs.Immo.Current.GARAGE_POS == nil then
												DrawMarker( 25, coords.x, coords.y, coords.z - 0.95, nil, nil, nil, nil, nil, nil, 1.0, 1.0, 1.0, 120, 0, 0, 100 )
											else
												DrawMarker( 25, Ora.Jobs.Immo.Current.GARAGE_POS.x, Ora.Jobs.Immo.Current.GARAGE_POS.y, Ora.Jobs.Immo.Current.GARAGE_POS.z, nil, nil, nil, nil, nil, nil, 1.0, 1.0, 1.0, 120, 0, 0, 100 )
											end
										end
										if Selected then
											coords = LocalPlayer().Pos
											Ora.Jobs.Immo.Current.GARAGE_POS = vector3(coords.x, coords.y, coords.z - 0.95)
										end
									end
								)

								if Ora.Jobs.Immo.Current.GARAGE_POS ~= nil and type(Ora.Jobs.Immo.Current.GARAGE_POS) == "vector3" then
									RageUI.List(
										"Nombre de place",
										Ora.Jobs.Immo:GetAvailableGaragePlaces(),
										Ora.Jobs.Immo.Current.GARAGE_INDEX,
										nil,
										{},
										true,
										function(Hovered, Active, Selected, Index)
											if Active then
												Ora.Jobs.Immo.Current.GARAGE_INDEX = Index
											end
										end
									)
								end

								RageUI.Button(
									"Prix à l'achat",
									nil,
									{
										RightLabel = Ora.Jobs.Immo.Current.PRICE .. "$"
									},
									true,
									function(Hovered, Active, Selected)
										if Selected then
											exports['Snoupinput']:ShowInput("Entrez le prix de la propriété (sans $)", 25, "number", nil, true)
											local amount = exports['Snoupinput']:GetInput()
											if (amount ~= false and amount ~= "" and tonumber(amount) ~= nil) then
												Ora.Jobs.Immo.Current.PRICE = amount
											end
										end
									end
								)

								if Ora.Jobs.Immo.Current.PRICE ~= nil then
									RageUI.Button(
										"Prix de la location",
										"Chaque semaine le client devra payer " ..
											math.floor(Ora.Jobs.Immo.Current.PRICE / 50) .. "$",
										{
											RightLabel = math.floor(Ora.Jobs.Immo.Current.PRICE / 50) .. "$"
										},
										true,
										function(Hovered, Active, Selected)
											if Selected then
											end
										end
									)

									RageUI.Button(
										"Enregistrer la propriété",
										nil,
										{},
										true,
										function(Hovered, Active, Selected)
											if Selected then
												RageUI.CloseAll()
												if Ora.Jobs.Immo:IsNewAppartValid(Ora.Jobs.Immo.Current) then
													Ora.Jobs.Immo.Current.SAFE_CAPACITY = Ora.Jobs.Immo:GetSafeCapacityForIndex(Ora.Jobs.Immo.Current.SAFE_INDEX)
													Ora.Jobs.Immo.Current.PARKING_PLACE_COUNT = Ora.Jobs.Immo:GetParkingPlaceCountForIndex(Ora.Jobs.Immo.Current.GARAGE_INDEX)
													ShowNotification(string.format("~b~~h~Patientez :~s~~h~ %s", "Pendant la création de la propriété"))
													TriggerServerEvent("Ora::SE::Job::Immo:Create", json.encode(Ora.Jobs.Immo.Current))
												else
													for key, value in pairs(Ora.Jobs.Immo:GetLastValidationMessages()) do
														ShowNotification(string.format("~r~~h~Erreur :~s~~h~ %s", value))
													end
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

				if (RageUI.Visible(RMenu:Get("Ora:Immo", "List"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							for id, property in pairs(Ora.World.Appart:GetList()) do
								RageUI.Button(
									property.name,
									Ora.Jobs.Immo:GetInteriorById(property.indexx).label,
									{},
									true,
									function(_, _, Selected)
										if (Selected) then
											Ora.Jobs.Immo.SubMenu.SelectedProperty = id
											Ora.Jobs.Immo.SubMenu.CurrentOwner = ""
											Ora.Jobs.Immo.SubMenu.CurrentCoowners = {}

											if (type(property.owner) == "string") then
												TriggerServerCallback(
													"Ora::SE::Identity:GetFullNameFromUUID",
													function(fullname)
														Ora.Jobs.Immo.SubMenu.CurrentOwner = fullname
													end,
													property.owner
												)
											end
											if (Ora.Utils:TableLength(property.coowner) ~= 0) then
												TriggerServerCallback(
													"Ora::SE::Identity:GetFullNamesFromUUIDs",
													function(fullnames)
														Ora.Jobs.Immo.SubMenu.CurrentCoowners = fullnames
													end,
													property.coowner
												)
											end
										end
									end,
									RMenu:Get("Ora:Immo", "CurrentProperty")
								)
							end
						end,
						function()
						end
					)
				end

				if (RageUI.Visible(RMenu:Get("Ora:Immo", "CurrentProperty"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							if (Ora.Jobs.Immo.SubMenu.SelectedProperty == nil) then RageUI.GoBack() end

							local SelectedProperty = Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty)

							if (Ora.Jobs.Immo.SubMenu.CurrentGaragePos ~= nil and type(Ora.Jobs.Immo.SubMenu.CurrentGaragePos) == "vector3") then
								DrawMarker(25, Ora.Jobs.Immo.SubMenu.CurrentGaragePos.x, Ora.Jobs.Immo.SubMenu.CurrentGaragePos.y, Ora.Jobs.Immo.SubMenu.CurrentGaragePos.z, nil, nil, nil, nil, nil, nil, 1.0, 1.0, 1.0, 125, 0, 0, 100)
							end

							RageUI.Button(
								"Intérieur",
								"Selectionnez pour modifier",
								{
									RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo:GetInteriorById(SelectedProperty.indexx).label),
									Color = Ora.Jobs.Immo.SubMenu.UpdatedStuff["indexx"] ~= nil and {HightLightColor = {0, 155, 0, 150}} or {}
								},
								true,
								function(_, _, Selected)
								end,
								RMenu:Get("Ora:Immo:Update", "Interior")
							)

							RageUI.List(
								"Capacité du coffre",
								Ora.Jobs.Immo:GetAvailableWeight(),
								Ora.Jobs.Immo.SubMenu.CurrentCapacity,
								"Selectionnez pour modifier",
								{RightLabel = string.format("~h~~b~%s KG~h~", SelectedProperty.capacity)},
								true,
								function(Hovered, Active, Selected, Index)
									if (Active) then
										Ora.Jobs.Immo.SubMenu.CurrentCapacity = Index
									end
									if (Selected) then
										Ora.Jobs.Immo.SubMenu.HasBeenUpdated = true
										Ora.Jobs.Immo.SubMenu.UpdatedStuff["capacity"] = Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty).capacity
										Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty).capacity = Ora.Jobs.Immo:GetSafeCapacityForIndex(Ora.Jobs.Immo.SubMenu.CurrentCapacity)
									end
								end
							)

							RageUI.List(
								"Nombre de place",
								Ora.Jobs.Immo:GetAvailableGaragePlaces(),
								Ora.Jobs.Immo.SubMenu.CurrentGarageMax,
								"Selectionnez pour modifier",
								{RightLabel = string.format("~h~~b~Garage %s places~h~", SelectedProperty.garageMax)},
								true,
								function(Hovered, Active, Selected, Index)
									if (Active) then
										Ora.Jobs.Immo.SubMenu.CurrentGarageMax = Index
									end
									if (Selected) then
										Ora.Jobs.Immo.SubMenu.HasBeenUpdated = true
										Ora.Jobs.Immo.SubMenu.UpdatedStuff["garageMax"] = Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty).garageMax
										Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty).garageMax = Ora.Jobs.Immo:GetParkingPlaceCountForIndex(Ora.Jobs.Immo.SubMenu.CurrentGarageMax)
									end
								end
							)

							RageUI.Button(
								"Prix propriété : Achat/Vente",
								"Selectionnez pour modifier",
								{
									RightLabel = string.format("~h~~b~%s$~h~", SelectedProperty.price),
									Color = Ora.Jobs.Immo.SubMenu.UpdatedStuff["price"] ~= nil and {HightLightColor = {0, 155, 0, 150}} or {}
								},
								true,
								function(_, Ac, Selected)
									if (Selected) then
										exports['Snoupinput']:ShowInput("Entrez le prix de la propriété (sans $)", 25, "number", SelectedProperty.price, true)
										local amount = exports['Snoupinput']:GetInput()
										print(amount)
										if (amount ~= false and amount ~= "" and tonumber(amount) ~= nil) then
											Ora.Jobs.Immo.SubMenu.HasBeenUpdated = true
											Ora.Jobs.Immo.SubMenu.UpdatedStuff["price"] = Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty).price
											Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty).price = amount
										end
									end
								end
							)

							RageUI.Button(
								"Prix de la location / semaine",
								nil,
								{RightLabel = string.format("~h~~b~%s$~h~", math.ceil(SelectedProperty.price / 50))},
								true,
								function(_, Ac, Selected) 
								end
							)

							RageUI.Button(
								"Fin du bail",
								nil,
								{RightLabel = string.format("~h~~b~%s~h~", SelectedProperty.time == nil and "Propriétaire" or SelectedProperty.time)},
								true,
								function(_, Ac, Selected)
								end
							)

							RageUI.Button(
								"Position du garage",
								"Selectionnez pour la voir temporairement",
								{},
								true,
								function(_, Ac, Selected)
									if (Selected) then
										local pos = SelectedProperty.garagePos
										pos.z = pos.z + 0.5
										Marker:Add(
											pos,
											{
												type = 25,
												scale = {x = 1.5, y = 1.5, z = 0.2},
												color = {r = 255, g = 0, b = 0, a = 255},
												Up = true,
												Cam = false,
												Rotate = false,
												visible = true
											}
										)

										RageUI.Popup({message = "~b~Le marqueur du garage vous est montré en ~r~rouge~b~ pendant 30s."})

										Citizen.SetTimeout(30000, function()
											Marker:Remove(pos)
										end)
									end
								end
							)

							RageUI.Button(
								"Changer la position du garage",
								"Selectionnez pour changer la position",
								{Color = Ora.Jobs.Immo.SubMenu.UpdatedStuff["garagePos"] ~= nil and {HightLightColor = {0, 155, 0, 150}} or {}},
								true,
								function(_, Active, Selected)
									if (Selected) then
										Ora.Jobs.Immo.SubMenu.HasBeenUpdated = true
										Ora.Jobs.Immo.SubMenu.UpdatedStuff["garagePos"] = SelectedProperty.garagePos
										Marker:Remove(SelectedProperty.garagePos)
										SelectedProperty.garagePos = Ora.Jobs.Immo.SubMenu.CurrentGaragePos
									end

									if (Active) then
										if (Ora.Jobs.Immo.SubMenu.UpdatedStuff["garagePos"] ~= nil) then
											Ora.Jobs.Immo.SubMenu.CurrentGaragePos = SelectedProperty.garagePos
										else
											Ora.Jobs.Immo.SubMenu.CurrentGaragePos = vector3(LocalPlayer().Pos.x, LocalPlayer().Pos.y, LocalPlayer().Pos.z - 0.95)
										end
									else
										Ora.Jobs.Immo.SubMenu.CurrentGaragePos = nil
									end
								end
							)

							RageUI.Button(
								"Propriétaire",
								nil,
								{RightLabel = string.format("~h~~b~%s~h~", Ora.Jobs.Immo.SubMenu.CurrentOwner ~= "" and Ora.Jobs.Immo.SubMenu.CurrentOwner or "~r~Personne")},
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
								RMenu:Get("Ora:Immo", "Coowners")
							)

							RageUI.Button(
								"~g~Enregistrer les changements",
								"Selectionnez pour enregistrer les changements",
								{},
								true,
								function(_, Ac, Selected)
									if (Selected) then
										if (Ora.Jobs.Immo.SubMenu.HasBeenUpdated == true) then
											TriggerServerEvent(
												"Ora::SE::Job::Immo:Update",
												Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty),
												Ora.Jobs.Immo.SubMenu.UpdatedStuff
											)
											TriggerPlayerEvent(
												"Ora::CE::World:Appart:SyncWithID",
												-1,
												Ora.Jobs.Immo.SubMenu.SelectedProperty,
												Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty)
											)
											TriggerServerEvent(
												"Ora::SE::World:Appart:LogUpdates",
												Ora.Jobs.Immo.SubMenu.UpdatedStuff,
												Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty)
											)
											RageUI.Popup({message = "~g~Changements effectués"})
										else
											RageUI.Popup({message = "~b~Aucun changement n'a été effectué"})
										end

										Ora.Jobs.Immo.SubMenu.CurrentGaragePos = nil
										Ora.Jobs.Immo.SubMenu.HasBeenUpdated = false
										Ora.Jobs.Immo.SubMenu.UpdatedStuff = {}
										RageUI.GoBack()
									end
								end
							)
						end,
						function()
						end
					)
				end

				if (RageUI.Visible(RMenu:Get("Ora:Immo:Update", "Interior"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							for id, label in pairs(Ora.Jobs.Immo:GetInteriorLabels()) do
								RageUI.Button(
									label,
									"Selectionnez pour changer l'intérieur",
									{},
									true,
									function(_, Active, Selected)
										if (Selected) then
											Ora.Jobs.Immo.SubMenu.HasBeenUpdated = true
											Ora.Jobs.Immo.SubMenu.UpdatedStuff["indexx"] = Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty).indexx
											Ora.World.Appart:GetById(Ora.Jobs.Immo.SubMenu.SelectedProperty).indexx = id
											TriggerServerEvent("Ora::SE::Job::Immo:Remake:Interior", Ora.World.Appart:GetList()[Ora.Jobs.Immo.SubMenu.SelectedProperty].name, id)
											RageUI.GoBack()
										end
									end
								)
							end
						end
					)
				end

				if (RageUI.Visible(RMenu:Get("Ora:Immo", "Coowners"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							if (Ora.Jobs.Immo.SubMenu.CurrentCoowners ~= "" and Ora.Jobs.Immo.SubMenu.CurrentCoowners ~= {} and Ora.Utils:TableLength(Ora.Jobs.Immo.SubMenu.CurrentCoowners) > 0) then
								for _, coowner in pairs(Ora.Jobs.Immo.SubMenu.CurrentCoowners) do
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
						end,
						function()
						end
					)
				end

				if (Ora.Identity.Job:GetName() == "immo" and Ora.Identity.Job.ChangingJob) then
					KeySettings:Clear("keyboard", "F6", "immo")
					break
				elseif (Ora.Identity.Orga:GetName() == "immo" and Ora.Identity.Orga.ChangingJob) then
					KeySettings:Clear("keyboard", "F7", "immo")
					break
				end
			end
		end
	)
end


RegisterNetEvent("Ora::CE::Job::Immo:GetRaids")
AddEventHandler(
	"Ora::CE::Job::Immo:GetRaids",
	function(raids)
		Ora.Jobs.Immo.Raids = raids
	end
)


Citizen.CreateThread(
    function()
		local currentRaidID = nil

		while (Ora.Player.HasLoaded == false) do Wait(500) end

		TriggerServerCallback(
			"Ora::SVCB::Job::Immo:GetRaids",
			function(raids)
				Ora.Jobs.Immo.Raids = raids
			end
		)

		while true do
			Wait(0)

			if (Ora.Identity:GetMyGroup() == "superadmin") then
				if (RageUI.Visible(RMenu:Get("Ora:Immo", "Raids"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							for id, Raid in ipairs(Ora.Jobs.Immo.Raids) do
								RageUI.Button(
									Raid.PropertyName,
									string.format("[%s] %s", Raid.AuthorID, Raid.AuthorName),
									{},
									true,
									function(_, Active, Selected)
										if (Selected) then
											currentRaidID = id
										end
									end,
									RMenu:Get("Ora:Immo", "Raids_confirm")
								)
							end
						end,
						function()
						end
					)
				end

				if (RageUI.Visible(RMenu:Get("Ora:Immo", "Raids_confirm"))) then
					RageUI.DrawContent(
						{header = true, glare = false},
						function()
							RageUI.Button(
								"S'y téléporter",
								"~h~Activez le NO CLIP avant",
								{},
								true,
								function(_, Active, Selected)
									if (Selected) then
										SetEntityCoordsNoOffset(
											LocalPlayer().Ped,
											Ora.Jobs.Immo.Raids[currentRaidID].PropertyPos.x,
											Ora.Jobs.Immo.Raids[currentRaidID].PropertyPos.y,
											Ora.Jobs.Immo.Raids[currentRaidID].PropertyPos.z + 10.0,
											false,
											false,
											false,
											true
										)
									end
								end
							)

							RageUI.Button(
								"~r~Arrêter la perquisition",
								nil,
								{},
								true,
								function(_, _, Selected)
									if (Selected) then
										table.remove(Ora.Jobs.Immo.Raids, currentRaidID)
										TriggerServerEvent("Ora::SE::Job::Immo:RemoveRaid", currentRaidID)
										RageUI.GoBack()
									end
								end
							)
						end,
						function()
						end
					)
				end
			end
		end
    end
)
