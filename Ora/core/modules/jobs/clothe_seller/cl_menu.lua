function CreateClotheSellerMenu(jobName, menuTitle, modelPositions, clearParameters)

---@diagnostic disable-next-line: missing-parameter
	RMenu.Add(jobName,"main", RageUI.CreateMenu(menuTitle, "Actions disponibles",10,100))
	local pedPrev = {}
	local mannequins = {}
	for i = 1, #modelPositions do
		table.insert(mannequins, tostring(i))
	end
	local manqidx = 1
	local skinLIST = {"mp_m_freemode_01", "mp_f_freemode_01"}
	local skinSexe = {"Homme", "Femme"}
	local skinIndex = 1
	local torso = {}
	local pant = {}
	local chauss = {}
	local unders = {}
	local access = {}
	local sac = {}
	local tops = {}
	local pantcolor = {}
	local chausscolor = {}
	local accesscolor = {}
	local underscolor = {}
	local topcolor = {}
	local saccolor = {}
	local torsoPos = 1
	local pantPos = 1
	local sacPos = 1
	local chaussPos = 1
	local undersPos = 1
	local accessPos = 1
	local topsPos = 1
	local pantcolorPos = 1
	local chausscolorPos = 1
	local accesscolorPos = 1
	local underscolorPos = 1
	local topcolorPos = 1
	local saccolorPos = 1

	local lockedTorso = true
	local lockedPant = true
	local lockedSac = true
	local lockedPantColor = true
	local lockedchauss = true
	local lockedchaussColor = true
	local accessLocked = true
	local accessColorLocked = true
	local underscolorLocked = true
	local undersLocked = true
	local topLocked = true
	local topColorLocked = true
	local sacColorLocked = true
	local function makeAnim()
		TaskPlayAnim(pedPrev[manqidx], "random@mugging3", "handsup_standing_enter", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
		Wait(100)
		TaskPlayAnim(pedPrev[manqidx], "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
	end

	local manPos = modelPositions
	
	local function RegenMenu()
		torsoPos = 1
		pantPos = 1
		chaussPos = 1
		undersPos = 1
		accessPos = 1
		topsPos = 1
		pantcolorPos = 1
		chausscolorPos = 1
		accesscolorPos = 1
		underscolorPos = 1
		topcolorPos = 1
		sacPos = 1
		ped = pedPrev[manqidx]

		torso = {}
		for i = 0, GetNumberOfPedDrawableVariations(ped, 3), 1 do
			table.insert(torso, i)
		end

		sac = {}
		for i = 0, GetNumberOfPedDrawableVariations(ped, 5), 1 do
			table.insert(sac, i)
		end

		pant = {}
		for i = 0, GetNumberOfPedDrawableVariations(ped, 4), 1 do
			table.insert(pant, i)
		end

		chauss = {}
		for i=0, GetNumberOfPedDrawableVariations(ped, 6), 1 do
			table.insert(chauss, i)
		end

		access = {}
		for i = 0, GetNumberOfPedDrawableVariations(ped, 7), 1 do
			table.insert(access, i)
		end

		unders = {}
		for i = 0, GetNumberOfPedDrawableVariations(ped, 8), 1 do
			table.insert(unders, i)
		end

		tops = {}
		for i = 0, GetNumberOfPedDrawableVariations(ped, 11), 1 do
			table.insert(tops, i)
		end

		pantcolor = {}
		for i = 0 , GetNumberOfPedTextureVariations(ped, 4), 1 do
			table.insert(pantcolor, i)
		end

		chausscolor = {}
		for i = 0 , GetNumberOfPedTextureVariations(ped, 6), 1 do
			table.insert(chausscolor, i)
		end

		accesscolor = {}
		for i = 0 , GetNumberOfPedTextureVariations(ped, 7), 1 do
			table.insert(accesscolor, i)
		end

		underscolor = {}
		for i = 0 , GetNumberOfPedTextureVariations(ped, 8), 1 do
			table.insert(underscolor, i)
		end
		
		topcolor = {}
		for i = 0 , GetNumberOfPedTextureVariations(ped, 11), 1 do
			table.insert(topcolor, i)
		end

		saccolor = {}
		for i = 0 , GetNumberOfPedTextureVariations(ped, 5, 0), 1 do
			table.insert(saccolor, i)
		end

		lockedTorso = true
		lockedPant = true
		lockedPantColor = true
		lockedchauss = true
		lockedchaussColor = true
		accessLocked = true
		accessColorLocked = true
		underscolorLocked = true
		undersLocked = true
		topLocked = true
		topColorLocked = true
		lockedSac = true
		sacColorLocked = true
	end

	local function spawnManequin()
		RequestAnimDict("random@mugging3")
			
		while (not HasAnimDictLoaded("random@mugging3")) do 
			Citizen.Wait(1)
		end
		pedPrev[manqidx] = Ora.World.Ped:Create(5, skinLIST[skinIndex], vector3(manPos[manqidx][1], manPos[manqidx][2], manPos[manqidx][3]), manPos[manqidx][4])
		SetPedFleeAttributes(pedPrev[manqidx], 0, 0)
		SetPedKeepTask(pedPrev[manqidx], true)
		SetBlockingOfNonTemporaryEvents(pedPrev[manqidx], true)

		Citizen.CreateThread(function()
			Wait(2000)
			FreezeEntityPosition(pedPrev[manqidx], true)
			makeAnim()
		end)
		RegenMenu()
		RageUI.Refresh()
	end
	local function respawnSkin()
		local p = pedPrev[manqidx]

		pedPrev[manqidx] = Ora.World.Ped:Create(5, skinLIST[skinIndex], vector3(manPos[manqidx][1], manPos[manqidx][2], manPos[manqidx][3]), manPos[manqidx][4])
		NetworkRequestControlOfEntity(p)
		DeleteEntity(p)
		TriggerPlayerEvent("ENTI:DeletePed_"..jobName,-1)
		SetPedFleeAttributes(pedPrev[manqidx], 0, 0)
		SetPedKeepTask(pedPrev[manqidx], true)
		SetBlockingOfNonTemporaryEvents(pedPrev[manqidx], true)

		Citizen.CreateThread(function()
			Wait(2000)
			FreezeEntityPosition(pedPrev[manqidx], true)
			makeAnim()
		end)
		RegenMenu()
		RageUI.Refresh()
	end

	RegisterNetEvent("ENTI:DeletePed_"..jobName)
	AddEventHandler("ENTI:DeletePed_"..jobName,function()
		ClearAreaOfPeds(table.unpack(clearParameters))
	end)

	RMenu:Get(jobName,"main").Closed = function()
		DeleteEntity(pedPrev[manqidx])
		pedPrev[manqidx] = nil

		TriggerPlayerEvent("ENTI:DeletePed_"..jobName,-1)
	end

	
	

	Citizen.CreateThread(function()
		Wait(500)
		while Ora.Player.HasLoaded == false do Wait(500) end

		
		while true do
			Wait(0)

			if RageUI.Visible(RMenu:Get(jobName,"main")) then
				RageUI.DrawContent({ header = true, glare = false }, function()
					RageUI.List(pedPrev[manqidx] == nil and "Faire apparaitre le mannequin" or "Supprimer le mannequin", mannequins, manqidx , nil, {}, true, function(Hovered, Active, Selected, Index)
						if manqidx ~= Index then manqidx = Index end
						-- if Selected and manqidx == 4 and manPos[4][1] == nil then
						-- 	return RageUI.Popup({message = "~r~Erreur~s~\nIl faut définir une position pour ce mannequin et être ~y~PDG~s~ ou ~y~Co-PDG~s~."})
						-- elseif Selected and pedPrev[manqidx] == nil then
						if Selected and pedPrev[manqidx] == nil then
							spawnManequin()
						elseif Selected and pedPrev[manqidx] ~= nil then
							NetworkRequestControlOfEntity(pedPrev[manqidx])
							DeleteEntity(pedPrev[manqidx])
							TriggerPlayerEvent("ENTI:DeletePed_"..jobName,-1)
							pedPrev[manqidx] = nil
							-- if manPos[4][1] then
							-- 	manPos[4] = {}
							-- 	RageUI.Popup({message = "~y~Attention~s~\nLa position du 4e mannequin a été réinitialisée."})
							-- end
						end
					end)


					RageUI.List("Sexe mannequin", skinSexe,  skinIndex,nil,{}, true, function(Hovered, Active, Selected, Index)
						if skinIndex ~= Index then
							skinIndex = Index
							if pedPrev[manqidx] ~= nil then
								respawnSkin()
							end
						end
					end)

					if pedPrev[manqidx] == nil then
						-- local isAbleTo = false
						-- if Ora.Identity.Job:GetName() == jobName then
						-- 	isAbleTo = (Ora.Identity.Job:IsCoBoss() or Ora.Identity.Job:IsBoss())
						-- else
						-- 	isAbleTo = (Ora.Identity.Orga:IsCoBoss() or Ora.Identity.Orga:IsBoss())
						-- end

						-- if isAbleTo then
						-- 	RageUI.Button(
						-- 		"Enregistrer la position du mannequin en face de vous",
						-- 		nil,
						-- 		{},
						-- 		true,
						-- 		function(_, Active, Selected)
						-- 			if Selected then
						-- 				local coords = GetEntityCoords(LocalPlayer().Ped)
						-- 				manPos[4][1] = GetEntityForwardX(LocalPlayer().Ped) + coords.x
						-- 				manPos[4][2] = GetEntityForwardY(LocalPlayer().Ped) + coords.y
						-- 				manPos[4][3] = coords.z
						-- 				manPos[4][4] = GetEntityHeading(LocalPlayer().Ped) + 180
						-- 				RageUI.Popup({message = "~g~Position enregistrée pour le mennequin !"})
						-- 			end
						-- 		end
						-- 	)
						-- end
					else
						manequin = pedPrev[manqidx]
						RageUI.List("Haut ", tops, topsPos,nil, {},topLocked, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= topsPos then
									SetPedComponentVariation(manequin, 11, Index-1, underscolorPos - 1)
									
									topcolor = {}
									ped = manequin
									for i = 0 ,GetNumberOfPedTextureVariations(ped,11,Index-1),1 do
										table.insert( topcolor, i )
									end
									topcolorPos = 1
									topColorLocked = true
								end
							end
							topsPos = Index
							
							if Selected and not topLocked then
								topLocked = true
							elseif Selected then
								topLocked = false
							end
						end)
						RageUI.List("Couleur du haut ", topcolor, topcolorPos,nil, {},topColorLocked, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= topcolorPos then
									SetPedComponentVariation(manequin, 11, topsPos-1, Index-1)
								end
			
							end
							topcolorPos = Index
							if Selected and not topColorLocked then
								topColorLocked = true
							
							elseif Selected then
								topColorLocked = false
							end
						end)
						RageUI.List("Sous haut ", unders, undersPos,nil, {},undersLocked, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= undersPos then
									SetPedComponentVariation(manequin, 8, Index-1, underscolorPos - 1)
									underscolor = {}
									ped = manequin
									for i = 0 ,GetNumberOfPedTextureVariations(ped,8,Index-1),1 do
										table.insert( underscolor, i )
									end
									underscolorPos = 1
									accessColorLocked = true
								end
							end
							undersPos = Index
							if Selected and not undersLocked then
								undersLocked = true
							elseif Selected then
								undersLocked = false
							end
						end)
			
						RageUI.List("Couleur du sous haut ", underscolor, underscolorPos,nil, {},underscolorLocked, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= underscolorPos then
									SetPedComponentVariation(manequin, 8, undersPos-1, Index-1)
								end
							end
							underscolorPos = Index
							if Selected and not underscolorLocked then
								underscolorLocked = true
							elseif Selected then
								underscolorLocked = false
							end
						end)
						RageUI.List("Accessoire ", access, accessPos,nil, {},accessLocked, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= accessPos then
									SetPedComponentVariation(manequin, 7, Index-1, accesscolorPos - 1)
									
									accesscolor = {}
									ped = manequin
									for i = 0 ,GetNumberOfPedTextureVariations(ped,7,Index-1),1 do
										table.insert( accesscolor, i )
									end
									accesscolorPos = 1
									accessColorLocked = true
								end
							end
							accessPos = Index
							if Selected and not accessLocked then
								accessLocked = true
							elseif Selected then
								accessLocked = false
							end
						end)
						RageUI.List("Couleur de l'accessoire ", accesscolor, accesscolorPos,nil, {},accessColorLocked, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= accesscolorPos then
									SetPedComponentVariation(manequin, 7, accessPos-1, Index-1)
								end
							end
							accesscolorPos = Index
							if Selected and not accessColorLocked then
								accessColorLocked = true
							elseif Selected then
								accessColorLocked = false
							end
						end)
			
						RageUI.List("Bras ", torso, torsoPos,nil, {},lockedTorso, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= torsoPos then
									SetPedComponentVariation(manequin, 3, Index-1, 0)
								end
							end
							torsoPos = Index
							if Selected and not lockedTorso then
								lockedTorso = true
							elseif Selected then
								lockedTorso = false
							end
						end)
			
						RageUI.List("Pantalon ", pant, pantPos,nil, {},lockedPant, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= pantPos then
									SetPedComponentVariation(manequin, 4, Index-1, pantcolorPos - 1)
									pantcolor = {}
									ped = manequin
									for i = 0 ,GetNumberOfPedTextureVariations(ped,4,Index-1),1 do
										table.insert( pantcolor, i )
									end
									pantcolorPos = 1 
									lockedPantColor = true
								end
							end
							pantPos = Index
							if Selected and not lockedPant then
								lockedPant = true
							elseif Selected then
								lockedPant = false
							end
						end)
			
						RageUI.List("Couleur du pantalon ", pantcolor, pantcolorPos,nil, {},lockedPantColor, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= torsoPos then
									SetPedComponentVariation(manequin, 4, pantPos-1, Index-1)
								end
							end
							pantcolorPos = Index
							if Selected and not lockedPantColor then
								lockedPantColor = true
							elseif Selected then
								lockedPantColor = false
							end
						end)
			
						RageUI.List("Chaussure ", chauss, chaussPos,nil, {},lockedchauss, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= chaussPos then
									SetPedComponentVariation(manequin, 6, Index-1, chausscolorPos - 1)
									
									chausscolor = {}
									ped = manequin
									for i = 0 ,GetNumberOfPedTextureVariations(ped,6,Index-1),1 do
										table.insert( chausscolor, i )
									end
									chausscolorPos = 1
									lockedchaussColor = true
								end
							end
							chaussPos = Index
							if Selected and not lockedchauss then
								lockedchauss = true
							elseif Selected then
								lockedchauss = false
							end
						end)
						
						RageUI.List("Couleur des chaussures ", chausscolor, chausscolorPos,nil, {},lockedchaussColor, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= chausscolorPos then
									SetPedComponentVariation(manequin, 6, chaussPos-1, Index-1)
								end
							end
							chausscolorPos = Index
							if Selected and not lockedchaussColor then
								lockedchaussColor = true
							elseif Selected then
								lockedchaussColor = false
							end
						end)

						RageUI.List("Sac ", sac, sacPos,nil, {},lockedSac, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= sacPos then
									SetPedComponentVariation(manequin, 5, Index-1, 0)
									saccolor = {}
									saccolorPos = 1
									for i = 0 , GetNumberOfPedTextureVariations(manequin, 5, Index-1)-1, 1 do
										table.insert(saccolor, i)
									end
									print(json.encode(saccolor))

									sacPos = Index
								end
							end
							if Selected and not lockedSac then
								lockedSac = true
							elseif Selected then
								lockedSac = false
							end
						end)
						
						RageUI.List("Couleur sac", saccolor, saccolorPos,nil, {},lockedSac, function(Hovered, Active, Selected, Index)
							if Active then
								if Index ~= saccolorPos then
									SetPedComponentVariation(manequin, 5, sacPos-1, Index - 1)
									saccolorPos = Index
								end
							end
							if Selected and not sacColorLocked then
								sacColorLocked = true
							elseif Selected then
								sacColorLocked = false
							end
						end)
			
						if not lockedTorso and not lockedPant and not lockedPantColor and not lockedSac and not sacColorLocked and not lockedchauss and not lockedPant and not lockedchaussColor and not accessLocked and not accessColorLocked and not underscolorLocked and not topLocked and not topColorLocked  then
							RageUI.Button("Valider" , nil, {}, true, function(Hovered, Active, Selected)
								if Selected then
									local maxCraft = Ora.Inventory:GetItemCount("fabric")
									local count = tonumber(KeyboardInput("Combien de copies de la tenue ? ( max : ".. maxCraft .. " )"))
									if count ~= nil and count > 0 and count <= maxCraft then
										Ora.Inventory:RemoveAnyItemsFromName("fabric", count)
										local data = {
											torso = torsoPos - 1,
											pant = pantPos - 1,
											chaus = chaussPos - 1,
											unders = undersPos - 1,
											access = accessPos - 1,
											tops = topsPos - 1,
											pantcolor = pantcolorPos - 1,
											chausscolor = chausscolorPos - 1,
											underscolor = underscolorPos - 1,
											topcolor = topcolorPos - 1,
											accesscolor = accesscolorPos - 1,
											sac = sacPos - 1,
											saccolor = saccolorPos - 1
										}
										local item = {}
										item.name = "tenue"
										item.data = data
										item.label = KeyboardInput("Nom de la tenue ? ", nil , 25)
										NetworkRequestControlOfEntity(pedPrev[manqidx])
										SetEntityCoords(pedPrev[manqidx], 0,0, -120.0)
										DeleteEntity(pedPrev[manqidx])
										TriggerPlayerEvent("ENTI:DeletePed_"..jobName,-1)
										pedPrev[manqidx] = nil
										RageUI.Refresh()
										ShowNotification("~g~Tenue(s) créée(s) ! (-" .. count .. " tissus)")
										for i = 1 , count , 1 do
											item.id = generateUUIDV2()
											Ora.Inventory:AddItem(item)
										end
									else
										ShowNotification("~r~Nombre invalide ou tissu insuffisant !")
									end
								end
							end)
						end
					end
				end, function()
				end)
			end
		end
	end)
end