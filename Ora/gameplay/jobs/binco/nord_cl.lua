
-- RMenu.Add('bincoN',"main", RageUI.CreateMenu("Binco Nord", "Actions disponibles",10,100))
-- local pedPrev = {}
-- local mannequins = {"1", "2", "3"}
-- local manqidx = 1
-- local skinLIST = {"mp_m_freemode_01", "mp_f_freemode_01"}
-- local skinSexe = {"Homme", "Femme"}
-- local skinIndex = 1
-- local torso = {}
-- local pant = {}
-- local chauss = {}
-- local unders = {}
-- local access = {}
-- local tops = {}
-- local pantcolor = {}
-- local chausscolor = {}
-- local accesscolor = {}
-- local underscolor = {}
-- local topcolor = {}
-- local torsoPos = 1
-- local pantPos = 1
-- local chaussPos = 1
-- local undersPos = 1
-- local accessPos = 1
-- local topsPos = 1
-- local pantcolorPos = 1
-- local chausscolorPos = 1
-- local accesscolorPos = 1
-- local underscolorPos = 1
-- local topcolorPos = 1
-- local lockedTorso = true
-- local lockedPant = true
-- local lockedPantColor = true
-- local lockedchauss = true
-- local lockedchaussColor = true
-- local accessLocked = true
-- local accessColorLocked = true
-- local underscolorLocked = true
-- local undersLocked = true
-- local topLocked = true
-- local topColorLocked = true
-- local function makeAnim()
--     TaskPlayAnim(pedPrev[manqidx], "random@mugging3", "handsup_standing_enter", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
--     Wait(100)
--     TaskPlayAnim(pedPrev[manqidx], "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
-- end
-- local manPos = {
--     {613.19, 2761.65, 42.08, 274.49},
--     {614.00, 2748.08, 41.08, 342.78},
--     {621.22, 2765.78, 42.08, 121.69}
-- }

-- local function spawnManequin()
--     RequestAnimDict("random@mugging3")
		
--     while (not HasAnimDictLoaded("random@mugging3")) do 
--         Citizen.Wait(1)
--     end
--     pedPrev[manqidx] = Ora.World.Ped:Create(5, skinLIST[skinIndex], vector3(manPos[manqidx][1], manPos[manqidx][2], manPos[manqidx][3]), manPos[manqidx][4])
    
--     SetPedFleeAttributes(pedPrev[manqidx], 0, 0)
--     SetPedKeepTask(pedPrev[manqidx], true)
--     SetBlockingOfNonTemporaryEvents(pedPrev[manqidx], true)

--     Citizen.CreateThread(function()
--         Wait(2000)
--         FreezeEntityPosition(pedPrev[manqidx], true)
--         makeAnim()
--     end)
--     RegenMenu3()
--     RageUI.Refresh()
-- end

-- local function respawnSkin()
--     local p = pedPrev[manqidx]
--     pedPrev[manqidx] = Ora.World.Ped:Create(5, skinLIST[skinIndex], vector3(manPos[manqidx][1], manPos[manqidx][2], manPos[manqidx][3]), manPos[manqidx][4])
--     NetworkRequestControlOfEntity(p)
--     DeleteEntity(p)
--     TriggerPlayerEvent("ENTI:DeletePed2",-1)
--     SetPedFleeAttributes(pedPrev[manqidx], 0, 0)
--     SetPedKeepTask(pedPrev[manqidx], true)
--     SetBlockingOfNonTemporaryEvents(pedPrev[manqidx], true)

--     Citizen.CreateThread(function()
--         Wait(2000)
--         FreezeEntityPosition(pedPrev[manqidx], true)
--         makeAnim()
--     end)
--     RegenMenu3()
--     RageUI.Refresh()
-- end

-- RegisterNetEvent("ENTI:DeletePed2")
-- AddEventHandler("ENTI:DeletePed2",function()
--     ClearAreaOfPeds(-831.24,-1072.53,11.34, 246.51,3.0,1)
-- end)

-- RMenu:Get("bincoN","main").Closed = function()
--     DeleteEntity(pedPrev[manqidx])
--     pedPrev[manqidx] = nil
--     TriggerPlayerEvent("ENTI:DeletePed2",-1)
-- end

-- Citizen.CreateThread(function()
--     while Ora.Player.HasLoaded == false do Wait(50) end
--     while true do
--         Wait(1)

--         if RageUI.Visible(RMenu:Get("bincoN","main")) then
--             RageUI.DrawContent({ header = true, glare = false }, function()
--                 RageUI.List(pedPrev[manqidx] == nil and "Faire apparaitre le mannequin" or "Supprimer le mannequin", mannequins, manqidx , nil, {}, true, function(Hovered, Active, Selected, Index)
--                     if manqidx ~= Index then
--                         manqidx = Index
--                     end
--                     if Selected and pedPrev[manqidx] == nil then
--                         spawnManequin()
--                     elseif Selected and pedPrev[manqidx] ~= nil then
--                         NetworkRequestControlOfEntity(pedPrev[manqidx])
--                         DeleteEntity(pedPrev[manqidx])
--                         TriggerPlayerEvent("ENTI:DeletePed2",-1)
--                         pedPrev[manqidx] = nil
--                     end
--                 end)

--                 RageUI.List("Sexe mannequin", skinSexe,  skinIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
--                     if skinIndex ~= Index then
--                         skinIndex = Index
--                         if pedPrev[manqidx] ~= nil then
--                             respawnSkin()
--                         end
--                     end
--                 end)

--                 if pedPrev[manqidx] ~= nil then
--                     manequin = pedPrev[manqidx]
--                     RageUI.List("Haut ", tops, topsPos, nil, {}, topLocked, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= topsPos then
--                                 SetPedComponentVariation(manequin, 11, Index - 1, underscolorPos - 1)
--                                 topcolor = {}
--                                 ped = manequin
--                                 for i = 0, GetNumberOfPedTextureVariations(ped, 11, Index - 1), 1 do
--                                     table.insert(topcolor, i)
--                                 end
--                                 topcolorPos = 1
--                                 topColorLocked = true
--                             end
--                         end
--                         topsPos = Index
                        
--                         if Selected and not topLocked then
--                             topLocked = true
--                         elseif Selected then
--                             topLocked = false
--                         end
--                     end)
--                     RageUI.List("Couleur du haut ", topcolor, topcolorPos, nil, {}, topColorLocked, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= topcolorPos then
--                                 SetPedComponentVariation(manequin, 11, topsPos - 1, Index - 1)
--                             end
--                         end
--                         topcolorPos = Index
--                         if Selected and not topColorLocked then
--                             topColorLocked = true
--                         elseif Selected then
--                             topColorLocked = false
--                         end
--                     end)
--                     RageUI.List("Sous haut ", unders, undersPos, nil, {}, undersLocked, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= undersPos then
--                                 SetPedComponentVariation(manequin, 8, Index - 1, underscolorPos - 1)
                                
--                                 underscolor = {}
--                                 ped = manequin
--                                 for i = 0, GetNumberOfPedTextureVariations(ped, 8, Index - 1), 1 do
--                                     table.insert(underscolor, i)
--                                 end
--                                 underscolorPos = 1
--                                 accessColorLocked = true
--                             end
--                         end
--                         undersPos = Index
--                         if Selected and not undersLocked then
--                             undersLocked = true
--                         elseif Selected then
--                             undersLocked = false
--                         end
--                     end)
        
--                     RageUI.List("Couleur du sous haut ", underscolor, underscolorPos, nil, {}, underscolorLocked, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= underscolorPos then
--                                 SetPedComponentVariation(manequin, 8, undersPos - 1, Index - 1)
--                             end
--                         end
--                         underscolorPos = Index
--                         if Selected and not underscolorLocked then
--                             underscolorLocked = true
--                         elseif Selected then
--                             underscolorLocked = false
--                         end
--                     end)
--                     RageUI.List("Accessoire ", access, accessPos, nil, {}, accessLocked, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= accessPos then
--                                 SetPedComponentVariation(manequin, 7, Index - 1, accesscolorPos - 1)
                                
--                                 accesscolor = {}
--                                 ped = manequin
--                                 for i = 0, GetNumberOfPedTextureVariations(ped, 7, Index - 1), 1 do
--                                     table.insert(accesscolor, i)
--                                 end
--                                 accesscolorPos = 1
--                                 accessColorLocked = true
--                             end
--                         end
--                         accessPos = Index
--                         if Selected and not accessLocked then
--                             accessLocked = true
--                         elseif Selected then
--                             accessLocked = false
--                         end
--                     end)
--                     RageUI.List("Couleur de l'accessoire ", accesscolor, accesscolorPos, nil, {}, accessColorLocked, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= accesscolorPos then
--                                 SetPedComponentVariation(manequin, 7, accessPos - 1, Index - 1)
--                             end
        
--                         end
--                         accesscolorPos = Index
--                         if Selected and not accessColorLocked then
--                             accessColorLocked = true
--                         elseif Selected then
--                             accessColorLocked = false
--                         end
--                     end)
        
--                     RageUI.List("Bras ", torso, torsoPos, nil, {}, lockedTorso, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= torsoPos then
--                                 SetPedComponentVariation(manequin, 3, Index-1, 0)
--                             end
--                         end
--                         torsoPos = Index
--                         if Selected and not lockedTorso then
--                             lockedTorso = true
--                         elseif Selected then
--                             lockedTorso = false
--                         end
--                     end)
        
--                     RageUI.List("Pantalon ", pant, pantPos,nil, {}, lockedPant, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= pantPos then
--                                 SetPedComponentVariation(manequin, 4, Index - 1, pantcolorPos - 1)
--                                 pantcolor = {}
--                                 ped = manequin
--                                 for i = 0, GetNumberOfPedTextureVariations(ped, 4, Index - 1), 1 do
--                                     table.insert(pantcolor, i)
--                                 end
--                                 pantcolorPos = 1 
--                                 lockedPantColor = true
--                             end
--                         end
--                         pantPos = Index
--                         if Selected and not lockedPant then
--                             lockedPant = true
--                         elseif Selected then
--                             lockedPant = false
--                         end
--                     end)
        
--                     RageUI.List("Couleur du pantalon ", pantcolor, pantcolorPos, nil, {}, lockedPantColor, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= torsoPos then
--                                 SetPedComponentVariation(manequin, 4, pantPos - 1, Index - 1)
--                             end
--                         end
--                         pantcolorPos = Index
--                         if Selected and not lockedPantColor then
--                             lockedPantColor = true
--                         elseif Selected then
--                             lockedPantColor = false
--                         end

--                     end)
        
--                     RageUI.List("Chaussure ", chauss, chaussPos, nil, {}, lockedchauss, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= chaussPos then
--                                 SetPedComponentVariation(manequin, 6, Index - 1, chausscolorPos - 1)
                                
--                                 chausscolor = {}
--                                 ped = manequin
--                                 for i = 0, GetNumberOfPedTextureVariations(ped, 6, Index - 1), 1 do
--                                     table.insert(chausscolor, i)
--                                 end
--                                 chausscolorPos = 1
--                                 lockedchaussColor = true
--                             end
--                         end
--                         chaussPos = Index
--                         if Selected and not lockedchauss then
--                             lockedchauss = true
--                         elseif Selected then
--                             lockedchauss = false
--                         end

--                     end)
                    
        
                    
--                     RageUI.List("Couleur des chaussures ", chausscolor, chausscolorPos, nil, {}, lockedchaussColor, function(Hovered, Active, Selected, Index)
--                         if Active then
--                             if Index ~= chausscolorPos then
--                                 SetPedComponentVariation(manequin, 6, chaussPos - 1, Index - 1)
--                             end
--                         end
--                         chausscolorPos = Index
--                         if Selected and not lockedchaussColor then
--                             lockedchaussColor = true
--                         elseif Selected then
--                             lockedchaussColor = false
--                         end
--                     end)
        
--                     if not lockedTorso and not lockedPant and not lockedPantColor and not lockedchauss and not lockedPant and not lockedchaussColor and not accessLocked and not accessColorLocked and not underscolorLocked and not topLocked and not topColorLocked  then
        
--                         RageUI.Button("Valider" , nil, {}, true, function(Hovered, Active, Selected)
--                             if Selected then
--                                 local maxCraft = Ora.Inventory:GetItemCount("fabric")
--                                 local count = tonumber(KeyboardInput("Combien de copies de la tenue ? ( max : ".. maxCraft .. " )"))
--                                 if count ~= nil and count > 0 and count <= maxCraft then
--                                     Ora.Inventory:RemoveAnyItemsFromName("fabric", count)
--                                     local data = {
--                                         torso = torsoPos - 1,
--                                         pant = pantPos - 1,
--                                         chaus = chaussPos - 1,
--                                         unders = undersPos - 1,
--                                         access = accessPos - 1,
--                                         tops = topsPos - 1,
--                                         pantcolor = pantcolorPos - 1,
--                                         chausscolor = chausscolorPos - 1,
--                                         underscolor = underscolorPos - 1,
--                                         topcolor = topcolorPos - 1,
--                                         accesscolor = accesscolorPos - 1
--                                     }
--                                     local item = {}
--                                     item.name = "tenue"
--                                     item.data = data
--                                     item.label = KeyboardInput("Nom de la tenue ? ", nil , 25)
--                                     NetworkRequestControlOfEntity(pedPrev[manqidx])
--                                     SetEntityCoords(pedPrev[manqidx], 0,0, -120.0)
--                                     DeleteEntity(pedPrev[manqidx])
--                                     TriggerPlayerEvent("ENTI:DeletePed2",-1)
--                                     pedPrev[manqidx] = nil
--                                     RageUI.Refresh()
--                                     ShowNotification("~g~Tenue(s) créée(s) ! ")
--                                     for i = 1 , count , 1 do
--                                         item.id = generateUUIDV2()
--                                         Ora.Inventory:AddItem(item)
--                                     end
--                                 else
--                                     ShowNotification("~r~Nombre invalide ou tissu insuffisant")
--                                 end
--                             end
--                         end)
--                     end
--                 end
--             end, function()
--             end)
--         end
--     end
-- end)


-- function RegenMenu3()
--     torsoPos = 1
--     pantPos = 1
--     chaussPos = 1
--     undersPos = 1
--     accessPos = 1
--     topsPos = 1
--     pantcolorPos = 1
--     chausscolorPos = 1
--     accesscolorPos = 1
--     underscolorPos = 1
--     topcolorPos = 1
-- 	ped = pedPrev[manqidx]

-- 	torso = {}
-- 	for i = 0, GetNumberOfPedDrawableVariations(ped, 3), 1 do
-- 		table.insert(torso, i)
-- 	end

-- 	pant = {}
-- 	for i = 0, GetNumberOfPedDrawableVariations(ped, 4), 1 do
-- 		table.insert(pant, i)
-- 	end

-- 	chauss = {}
-- 	for i=0, GetNumberOfPedDrawableVariations(ped, 6), 1 do
-- 		table.insert(chauss, i)
-- 	end

-- 	access = {}
-- 	for i = 0, GetNumberOfPedDrawableVariations(ped, 7), 1 do
-- 		table.insert(access, i)
-- 	end

-- 	unders = {}
-- 	for i = 0, GetNumberOfPedDrawableVariations(ped, 8), 1 do
-- 		table.insert(unders, i)
-- 	end

-- 	tops = {}
-- 	for i = 0, GetNumberOfPedDrawableVariations(ped, 11), 1 do
-- 		table.insert(tops, i)
-- 	end

-- 	pantcolor = {}
-- 	for i = 0 , GetNumberOfPedTextureVariations(ped, 4), 1 do
-- 		table.insert(pantcolor, i)
-- 	end

-- 	chausscolor = {}
-- 	for i = 0 , GetNumberOfPedTextureVariations(ped, 6), 1 do
-- 		table.insert(chausscolor, i)
-- 	end

-- 	accesscolor = {}
-- 	for i = 0 , GetNumberOfPedTextureVariations(ped, 7), 1 do
-- 		table.insert(accesscolor, i)
-- 	end

-- 	underscolor = {}
-- 	for i = 0 , GetNumberOfPedTextureVariations(ped, 8), 1 do
-- 		table.insert(underscolor, i)
-- 	end
	
-- 	topcolor = {}
-- 	for i = 0 , GetNumberOfPedTextureVariations(ped, 11), 1 do
-- 		table.insert(topcolor, i)
--     end

--     lockedTorso = true
--     lockedPant = true
--     lockedPantColor = true
--     lockedchauss = true
--     lockedchaussColor = true
--     accessLocked = true
--     accessColorLocked = true
--     underscolorLocked = true
--     undersLocked = true
--     topLocked = true
--     topColorLocked = true
-- end

local modelPositions = {
    {614.43, 2768.59, 42.08, 222.53},
    {614.00, 2748.08, 41.08, 342.78},
    {621.22, 2765.78, 42.08, 121.69}
}

local clear = { -831.24,-1072.53,11.34, 246.51,3.0,1}

CreateClotheSellerMenu("bincoN", "Binco Nord", modelPositions, clear)