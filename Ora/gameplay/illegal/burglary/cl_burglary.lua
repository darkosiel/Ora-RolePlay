Citizen.CreateThread(
    function()
        while (GetResourceState("gcphone") ~= "started") do
            Wait(1000)
        end
        TriggerServerEvent("AM::Illegal:addPhone", "5005245", "Ora::Illegal:StartBurglaryNorth")
        TriggerServerEvent("AM::Illegal:addPhone", "5006318", "Ora::Illegal:StartBurglarySouth")
    end
)

local unknownVariable = ""
local propId = "prop_cs_cardbox_01"
local musicEventId = {"DH1_START", "EPS1_START", "FAM4_MISSION_START"}
local soundLevels = {[0] = "Relativement calme", [4] = "Bruit de pas", [7] = "Très bruyant"}
local burglaryManager = {}

burglaryManager.STATE = 0
burglaryManager.CALLED = false
burglaryManager.START_TIME = 0
burglaryManager.ENTITY_DESTROYED = {}
burglaryManager.ENTRY_TIME = 0
burglaryManager.THREAD_LAUNCHED = false
burglaryManager.EXIT_POS = nil
burglaryManager.INITIAL_POSITION = nil
burglaryManager.PROPERTY = nil
burglaryManager.STREET = nil
burglaryManager.BLIP = nil
burglaryManager.NPC = {} 

local isDoingRobbery = false
local wqU76o = 255
local sound = 0.0

-- Set the appartment in the dark when the robber enters the house
local function disableLight(flag)
    if isDoingRobbery == flag then
        return
    end
    isDoingRobbery = flag
    SetArtificialLightsState(flag)
end


-- Indicate the sound level
local function noiseMeter(K)
    local qL, vfIyB = math.floor(K * 10), ""
    for soundLevelIndex, soundLevelValue in pairs(soundLevels) do
        if soundLevelIndex <= qL then
            value = soundLevelValue
        end
    end
    return value
end

-- Remove the box from the hand of the player
local function removeBox()
    if burglaryManager.BOX then
        DeleteEntity(burglaryManager.BOX)
    end
    burglaryManager.BOX = nil
    ClearPedTasks(LocalPlayer().Ped)
end

-- End the roberry.
local function finishRoberry(hasBeenDetected)
    TriggerMusicEvent("GLOBAL_KILL_MUSIC")
    disableLight(false)
    for entityId, u in pairs(burglaryManager.ENTITY_DESTROYED or {}) do
        RemoveModelHide(u.pos, 1.0, u.model, true)
    end
    removeBox()
    if hasBeenDetected then
        ShowNotification("~r~Vous avez été détecté, fuyez!")
        burglaryManager.STATE = 3
        burglaryManager.ENTITY_DESTROYED = {}
    else
        ShowNotification("~r~Cambriolage terminé.\nVous avez quitté la zone.")

        if (burglaryManager.BLIP ~= nil) then
            RemoveBlip(burglaryManager.BLIP)
        end

        burglaryManager.STATE = 0
        burglaryManager.START_TIME = 0
        burglaryManager.CALLED = false
        burglaryManager.ENTITY_DESTROYED = {}
        burglaryManager.ENTRY_TIME = 0
        burglaryManager.THREAD_LAUNCHED = false
        burglaryManager.EXIT_POS = nil
        burglaryManager.INITIAL_POSITION = nil
        burglaryManager.PROPERTY = nil
        burglaryManager.STREET = nil
        burglaryManager.BLIP = nil
    end
   
    collectgarbage()
end

-- Returns the item name from the model.
local function getItemFromItemModel(model)
    for i = 1, #BurglaryConfig.rewards, 1 do
        if (BurglaryConfig.rewards[i].model == model) then
            return BurglaryConfig.rewards[i].item
        end
    end
    return BurglaryConfig.defaultItem
end

-- Remove the item in the house and add a box in the hands of the player.
local function RobItem(K, i1)
    if burglaryManager.BOX then
        DeleteEntity(burglaryManager.BOX)
    end
    burglaryManager.STATE = 2
    CreateModelHide(i1.pos, 1.0, GetEntityModel(i1.entity), true)
    table.insert(burglaryManager.ENTITY_DESTROYED, {ent = i1.entity, pos = i1.pos, model = GetEntityModel(i1.entity)})
    PlaySimpleForceAnim({"anim@heists@box_carry@", "idle"}, 49)

    burglaryManager.BOX = Ora.World.Object:CreateObjectNoOffset(GetHashKey(propId), GetEntityCoords(K), true, true, false)
    AttachEntityToEntity(
        burglaryManager.BOX,
        K,
        GetPedBoneIndex(K, 60309),
        0.025,
        0.08,
        0.255,
        -145.0,
        290.0,
        0.0,
        false,
        false,
        false,
        false,
        0,
        1
    )

    ShowAdvancedNotification(
        "Mitch",
        "~b~Dialogue",
        "~g~~h~Ok, va décharger ça dans ton coffre maintenant~h~",
        "CHAR_BEVERLY",
        1
    )
end

-- Local variables used to display correctly the "noise meter"
local hPQ, R1FIoQI, NsoTwDs, HGli = .925, .975, .14, .03
local iy = {".", "..", "...", ""}

local availableEntities = {}

-- Add a marks on items when they can be robbed
local function showItemAsAvailable(m6SCS0, NUhYw6R4)
    local Hv, Ch, urkh = table.unpack(m6SCS0)
    local zhzpBSx = 7
    local rHSjalVy, TjhsnP, t5jzEd9 = table.unpack(GetFinalRenderedCamCoord())
    local JZAU2, zPXTTg =
        GetDistanceBetweenCoords(rHSjalVy, TjhsnP, t5jzEd9, Hv, Ch, urkh, 1),
        GetDistanceBetweenCoords(LocalPlayer().Pos, Hv, Ch, urkh, 1) - 1.65
    local seMLr, qX = ((1 / JZAU2) * (zhzpBSx * .7)) * (1 / GetGameplayCamFov()) * 100, wqU76o
    if zPXTTg < zhzpBSx then
        qX = math.floor(wqU76o * ((zhzpBSx - zPXTTg) / zhzpBSx))
    elseif zPXTTg >= zhzpBSx then
        qX = 0
    end
    qX = math.max(0, math.min(wqU76o, qX))
    SetDrawOrigin(Hv, Ch, urkh, 0)
    local h_8, xL7OTb = .004 * seMLr, .008 * seMLr
    DrawSprite(
        "commonmenu",
        NUhYw6R4 ~= 2 and "shop_tick_icon" or "shop_lock",
        .0,
        .0,
        h_8,
        xL7OTb,
        .0,
        255,
        255,
        255,
        qX
    )
    ClearDrawOrigin()
end

-- Seek items to rob in the house
local function populateItemsToRob()
    Citizen.CreateThread(
        function()
            while burglaryManager.THREAD_LAUNCHED == true do
                Citizen.Wait(3000)
                local playerPed = LocalPlayer().Ped
                local playerPosition = LocalPlayer().Pos
                local interiorId = GetInteriorFromEntity(playerPed)
                
                if burglaryManager.STATE == 1 and interiorId ~= 0 then
                    for object in EnumerateObjects() do
                        if object and DoesEntityExist(object) and not IsEntityAttached(object) and
                                GetEntityPopulationType(object) == 0 and
                                IsEntityStatic(object) and
                                tableHasValue(BurglaryConfig.entityModelToRob, GetEntityModel(object)) and
                                GetDistanceBetweenCoords(GetEntityCoords(object), playerPosition) <= 10 and
                                not tableHasValue(burglaryManager.ENTITY_DESTROYED, object, "ent") and
                                HasEntityClearLosToEntityInFront(playerPed, object)
                            then
                                availableEntities[object] = {pos = GetEntityCoords(object), id = 1, entity = object, model = GetEntityModel(object)}
                            end
                    end
                end
            end
            availableEntities = {}
        end
    )    
end

-- Verify if the IN Game time is correct to launch Burglary
local function isCorrectTimeToBurglar()
    if (GetClockHours() >= BurglaryConfig.startHour or GetClockHours() <= BurglaryConfig.stopHour) then
        return true
    end

    return false
end

function StartBurglary(type, policeCount)

    if (policeCount >= BurglaryConfig.minCops)  then

        TriggerServerEvent(
            "Ora:sendToDiscord",
            19,
            "Lance une mission cambriolage",
            "info"
        )

        ShowAdvancedNotification(
            "Mitch",
            "~b~Dialogue",
            "~g~~h~Salut mec, tu veux te faire de l'argent facile ? T'inquiete meme pas!~h~",
            "CHAR_BEVERLY",
            1
        )

        ShowAdvancedNotification(
            "Mitch",
            "~b~Dialogue",
            "~o~~h~Rends toi à l'adresse indiquée. Les proprios sont en vacances!~h~",
            "CHAR_BEVERLY",
            1
        )

        burglaryManager.STATE = 0
        burglaryManager.START_TIME = GetGameTimer()
        if (type == "south") then
            burglaryManager.PROPERTY = BurglaryConfig.robberyVillas[math.random(1, #BurglaryConfig.robberyVillas)]
            burglaryManager.STREET = BurglaryConfig.roberryStart[math.random(1, #BurglaryConfig.roberryStart)]
        else
            burglaryManager.PROPERTY = BurglaryConfig.robberyVillasNorth[math.random(1, #BurglaryConfig.robberyVillasNorth)]
            burglaryManager.STREET = BurglaryConfig.roberryStartNorth[math.random(1, #BurglaryConfig.roberryStartNorth)]
        end

        burglaryManager.BLIP = AddBlipForCoord(burglaryManager.STREET.pos.x, burglaryManager.STREET.pos.y, burglaryManager.STREET.pos.z)
        SetBlipRoute(burglaryManager.BLIP, true)
        SetBlipRouteColour(burglaryManager.BLIP, 1)

        Citizen.CreateThread(function() 
            while (true) do
                Wait(0)
                local playerPed = LocalPlayer().Ped
                local playerPosition = LocalPlayer().Pos
                local currentDistanceFromEnterDoor = 1000
                if (burglaryManager.STREET ~= nil) then
                    currentDistanceFromEnterDoor = GetDistanceBetweenCoords(playerPosition.x, playerPosition.y, playerPosition.z, burglaryManager.STREET.pos.x, burglaryManager.STREET.pos.y, burglaryManager.STREET.pos.z, true)
                end
                local currentDistanceFromExitDoor = 1000
                if (burglaryManager.PROPERTY ~= nil) then
                    currentDistanceFromExitDoor = GetDistanceBetweenCoords(playerPosition.x, playerPosition.y, playerPosition.z, burglaryManager.PROPERTY.pos.x, burglaryManager.PROPERTY.pos.y, burglaryManager.PROPERTY.pos.z, true)
                end
                local interiorId = GetInteriorFromEntity(playerPed)

                if (currentDistanceFromEnterDoor < 30.0) then
                    DrawMarker(
                        1,
                        burglaryManager.STREET.pos.x,
                        burglaryManager.STREET.pos.y,
                        burglaryManager.STREET.pos.z,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        1.0,
                        1.0,
                        1.0,
                        255,
                        195,
                        0,
                        70
                    )  
                end

                if currentDistanceFromEnterDoor <= 1.5 and burglaryManager.STATE ~= 3 then
                    if (burglaryManager.STATE == 0) then
                        DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ commencer a cambrioler.")
                    else 
                        DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ re-rentrer dans la maison.")
                    end

                    if IsDisabledControlJustPressed(0, 51) then
                        local canStart = false
                        if (burglaryManager.STATE == 0) then 
                            if (Ora.Inventory:GetItemCount("crochetage") == 0) then
                                ShowNotification("~r~Vous n'avez pas de kit de crochetage pour la porte~s~")
                            else
                                Ora.Core:Debug(string.format("Starting lockpicking the door for burglary"))
                                exports["mythic_progbar"]:Progress(
                                    {
                                        name = "lockpick",
                                        duration = 20000,
                                        label = "Crochetage en cours...",
                                        useWhileDead = true,
                                        canCancel = false,
                                        controlDisables = {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = true,
                                            disableCombat = true
                                        },
                                        animation = {
                                            animDict = "missheistfbisetup1leadinoutah_1_mcs_1",
                                            anim = "leadin_janitor_idle_01",
                                            flags = 1
                                        }
                                    },
                                    function(cancelled)
                                                
                                    end
                                )
                                Wait(20000)
                                burglaryManager.STATE = 1
                                burglaryManager.INITIAL_POSITION = LocalPlayer().Pos
                                canStart = true   
                            end
                        end

                        if (canStart == true or burglaryManager.STATE > 0) then
                            burglaryManager.ENTRY_TIME = GetGameTimer()
                        
                            DoScreenFadeOut(100)
                            TriggerServerEvent("Ora::SE::RoutingBucket:SwitchToAnyAvailableRoutingBucket")
                            Ora.Core:Debug(string.format("Adding Freeze for player"))
                            local interiorAtCoords = GetInteriorAtCoords(burglaryManager.PROPERTY.pos.x, burglaryManager.PROPERTY.pos.y, burglaryManager.PROPERTY.pos.z)
                            if not IsValidInterior(interiorAtCoords) then
                                Ora.Core:Debug(string.format("Interior id ^5%s^3 does not exist", interiorAtCoords))
                                interiorAtCoords = "NOTFOUND"
                            else
                                Ora.Core:Debug(string.format("Interior id ^5%s^3 will now be loaded", interiorAtCoords))
                                PinInteriorInMemory(interiorAtCoords)
                            end
                            Ora.Jobs.Immo:RemoveExits()
                            FreezeEntityPosition(LocalPlayer().Ped, true)
                            Wait(500)
                            Ora.Core:TeleportEntityTo(LocalPlayer().Ped, vector3(burglaryManager.PROPERTY.pos.x,  burglaryManager.PROPERTY.pos.y,  burglaryManager.PROPERTY.pos.z), true)
                            if (sound > 0.5) then
                                sound = 0.35
                            end
                            local maxTry = 100
                            local currentTry = 0
                            while interiorId == 0 do
                                interiorId = GetInteriorFromEntity(LocalPlayer().Ped)
                                Citizen.Wait(75)
                                if (currentTry > maxTry) then
                                    Ora.Core:Debug(string.format("Interior cannot be loaded for position ^5%s %s %s^3", burglaryManager.PROPERTY.pos.x, burglaryManager.PROPERTY.pos.y, burglaryManager.PROPERTY.pos.z))
                                    interiorId = "NOTFOUND"
                                    break
                                end
                                currentTry = currentTry + 1
                            end
                            Ora.Core:Debug(string.format("Removing Freeze for player"))
                            FreezeEntityPosition(LocalPlayer().Ped, false)
                            DoScreenFadeIn(500)
                            
                            for entityIndex, entityElement in pairs(burglaryManager.ENTITY_DESTROYED) do
                                CreateModelHide(entityElement.pos, 1.0, entityElement.model, true)
                            end
        
                            disableLight(true)
                            if (burglaryManager.THREAD_LAUNCHED == nil or burglaryManager.THREAD_LAUNCHED == false) then
                                populateItemsToRob()
                                burglaryManager.THREAD_LAUNCHED = true
                            end
                        end
                    end
                end

                if (burglaryManager.STATE == 1 or burglaryManager.STATE == 2) and interiorId ~= 0 then
                    local stealthNoise = GetPlayerCurrentStealthNoise(PlayerId())

                    if stealthNoise == 0.0 and not IsEntityStatic(playerPed) then
                        stealthNoise = 1.0
                    end

                    local b = stealthNoise * 0.700

                    if sound < 1 and sound >= 0 then
                        b = sound > 0 and (b <= 0 and -1.5) or b
                        sound = math.max(0, math.min(1, sound + (math.random(5, 7) / 50000) * b))
                    elseif sound >= 1 then
                        finishRoberry(true)
                    end

                    if not burglaryManager.CALLED and (sound > math.random(6, 8) / 10) then
                        if ((GetGameTimer() - burglaryManager.ENTRY_TIME) / 1000 > 15) then
                            local typeOfBust = math.random(1,10)
                            if (typeOfBust > 5) then
                                Ora.Core:Debug(string.format("Player busted, cops called"))
                                burglaryManager.CALLED = true
                                local message = "J'entends des pas chez mon voisin du dessus alors qu'il est en vacances!"
                                local burglaryCoords = vector3(burglaryManager.STREET.pos.x, burglaryManager.STREET.pos.y, burglaryManager.STREET.pos.z)
                                TriggerServerEvent("call:makeCall2", "police", burglaryCoords, message, "Voisin")
                            else
                                Ora.Core:Debug(string.format("Owner is here, now waking up"))
                                burglaryManager.CALLED = true
                                npcSpawnPosition = burglaryManager.PROPERTY.g
                                burglaryManager.NPC = {} 
                                
                                owner1 = Ora.World.Ped:Create(5, "u_m_y_fibmugger_01", vector3(npcSpawnPosition.x, npcSpawnPosition.y, npcSpawnPosition.z), 0.0)
                                owner2 = Ora.World.Ped:Create(5, "a_m_m_fatlatin_01", vector3(npcSpawnPosition.x + 0.5, npcSpawnPosition.y, npcSpawnPosition.z), 0.0)
                                owner3 = Ora.World.Ped:Create(5, "a_f_y_fitness_02", vector3(npcSpawnPosition.x + 0.75, npcSpawnPosition.y, npcSpawnPosition.z), 0.0)

                                TaskCombatPed(owner1, LocalPlayer().Ped, 0, 16)
                                TaskCombatPed(owner2, LocalPlayer().Ped, 0, 16)
                                TaskCombatPed(owner3, LocalPlayer().Ped, 0, 16)

                                SetPedCombatAttributes(owner1, 46, true)
                                SetPedFleeAttributes(owner1, 0, 0)
                                SetPedAsEnemy(owner1, true)
                                SetPedMaxHealth(owner1, 900)
                                SetPedAlertness(owner1, 3)
                                SetPedCombatRange(owner1, 0)
                                SetPedCombatMovement(owner1, 3)

                                SetPedCombatAttributes(owner2, 46, true)
                                SetPedFleeAttributes(owner2, 0, 0)
                                SetPedAsEnemy(owner2, true)
                                SetPedMaxHealth(owner2, 900)
                                SetPedAlertness(owner2, 3)
                                SetPedCombatRange(owner2, 0)
                                SetPedCombatMovement(owner2, 3)

                                SetPedCombatAttributes(owner3, 46, true)
                                SetPedFleeAttributes(owner3, 0, 0)
                                SetPedAsEnemy(owner3, true)
                                SetPedMaxHealth(owner3, 900)
                                SetPedAlertness(owner3, 3)
                                SetPedCombatRange(owner3, 0)
                                SetPedCombatMovement(owner3, 3)
                                
                                table.insert(burglaryManager.NPC, owner1)
                                table.insert(burglaryManager.NPC, owner2)
                                table.insert(burglaryManager.NPC, owner3)

                                local message = "Il y a un inconnu chez moi !! Cambriolage"
                                local burglaryCoords = vector3(burglaryManager.STREET.pos.x, burglaryManager.STREET.pos.y, burglaryManager.STREET.pos.z)
                                TriggerServerEvent("call:makeCall2", "police", burglaryCoords, message, "Voisin")
                                finishRoberry(true)
                            end
                        end
                    end

                    local noiseLevel = noiseMeter(sound)
                    if not timer or GetGameTimer() >= timer then
                        timer = GetGameTimer() + 500
                        unknownVariable = iy[string.len(unknownVariable) + 1] or ""
                    end
                    DrawRect(hPQ, R1FIoQI, NsoTwDs, HGli, 0, 0, 0, 100)
                    local KMw7_i1s, CQi = NsoTwDs - .0025, HGli - .005
                    local nHlJ = math.max(0, math.min(KMw7_i1s, KMw7_i1s * sound))
                    DrawRect(
                        (hPQ - KMw7_i1s / 2) + nHlJ / 2,
                        R1FIoQI,
                        nHlJ,
                        CQi,
                        math.floor(255 * sound),
                        math.floor(255 - 255 * sound),
                        0,
                        100
                    )
                    DrawNiceText(hPQ, R1FIoQI - .0125, .3, (E or "Detecteur de bruit") .. unknownVariable, 0, 0, false)
                    DrawNiceText(
                        hPQ,
                        R1FIoQI - .05,
                        .5,
                        string.format("Heure : %02d:%02d", GetClockHours(), GetClockMinutes()),
                        4,
                        0
                    )

                    for elementIndex, elementValue in pairs(availableEntities) do
                        showItemAsAvailable(elementValue.pos, elementValue.id)
                        if GetDistanceBetweenCoords(elementValue.pos, playerPosition) <= 1.5 and elementValue.entity and burglaryManager.STATE == 1 then
                            DrawTopNotification("Appuyez sur ~INPUT_REPLAY_SHOWHOTKEY~ pour voler.")
                            if IsDisabledControlJustPressed(0, 311) and burglaryManager.STATE == 1 then
                                Ora.Core:Debug(string.format("Item has been stolen"))
                                burglaryManager.STOLEN_ITEM = elementValue
                                RobItem(LocalPlayer().Ped, elementValue)
                            end
                        end
                    end
                end

                if interiorId ~= 0 then
                    DrawMarker(
                        1,
                        burglaryManager.PROPERTY.pos.x,
                        burglaryManager.PROPERTY.pos.y,
                        burglaryManager.PROPERTY.pos.z,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        1.0,
                        1.0,
                        1.0,
                        255,
                        195,
                        0,
                        70
                    )  

                    if currentDistanceFromExitDoor <= 1.5 then
                        DrawTopNotification("Appuyez sur ~INPUT_CONTEXT~ sortir de la maison.")
                        if IsDisabledControlJustPressed(0, 51) then
                            DoScreenFadeOut(100)
                            TriggerServerEvent("Ora::SE::RoutingBucket:SwitchToDefaultRoutingBucket")
                            Ora.Core:Debug(string.format("Added Freeze on player"))
                            FreezeEntityPosition(LocalPlayer().Ped, true)
                            Ora.Core:TeleportEntityTo(LocalPlayer().Ped, vector3(burglaryManager.INITIAL_POSITION.x,  burglaryManager.INITIAL_POSITION.y,  burglaryManager.INITIAL_POSITION.z), true)                                        
                            local maxTryOut = 100
                            local currentTryOut = 0
                            while interiorId ~= 0 do
                                interiorId = GetInteriorFromEntity(LocalPlayer().Ped)
                                Citizen.Wait(75)
                                if (currentTryOut > maxTryOut) then
                                    Ora.Core:Debug(string.format("Exterior cannot be loaded for position ^5%s %s %s^3", burglaryManager.INITIAL_POSITION.x, burglaryManager.INITIAL_POSITION.y, burglaryManager.INITIAL_POSITION.z))
                                    interiorId = 0
                                    Ora.Core:Debug(string.format("Removed Freeze on player"))
                                    break
                                end
                                currentTryOut = currentTryOut + 1
                            end
                            FreezeEntityPosition(LocalPlayer().Ped, false)
                            Ora.Core:Debug(string.format("Removed Freeze on player"))
                            DoScreenFadeIn(500)
                            disableLight(false)
                            Ora.Jobs.Immo:CreateExits()
                            if (burglaryManager.STATE == 3 and burglaryManager.NPC ~= nil) then
                                for npcKey, npcValue in pairs(burglaryManager.NPC) do
                                    if DoesEntityExist(npcValue) then
                                        Ora.Core:Debug(string.format("Removed spawned NPC ^5%s^3", npcValue))
                                        DeleteEntity(npcValue)
                                    end
                                end
                            end

                            burglaryManager.THREAD_LAUNCHED = false
                        end
                    end
                end

                if burglaryManager.BOX and not IsEntityPlayingAnim(LocalPlayer().Ped, "anim@heists@box_carry@", "idle", 3) then
                    PlaySimpleForceAnim({"anim@heists@box_carry@", "idle"}, 49)
                end

                if  (burglaryManager.STATE == 2 or burglaryManager.STATE == 3) and interiorId == 0 and burglaryManager.STOLEN_ITEM ~= nil then
                    for vehicle in EnumerateVehicles() do
                        if vehicle and DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(vehicle), playerPosition) <= 3.0 and HasEntityClearLosToEntityInFront(playerPed, vehicle) then
                            DrawTopNotification("Appuyez sur ~INPUT_REPLAY_SHOWHOTKEY~ pour déposer le carton.")
                            if IsDisabledControlJustPressed(0, 311) then
                                -- Add item to inventory
                                local itemName = getItemFromItemModel(burglaryManager.STOLEN_ITEM.model)
                                ShowNotification(string.format("Votre objet volé a été placé dans le coffre ~h~%s~h~", GetVehicleNumberPlateText(vehicle)))
                                Ora.World.Vehicle:AddItemIntoTrunk(vehicle, itemName)
                                TriggerPlayerEvent("XNL_NET:AddPlayerXP", GetPlayerServerId(PlayerId()), 150)
                                burglaryManager.STATE = 1
                                burglaryManager.STOLEN_ITEM = nil
                                if burglaryManager.BOX then
                                    DeleteEntity(burglaryManager.BOX)
                                    burglaryManager.BOX = nil
                                    removeBox()
                                end
                            end
                        end
                    end

                    if (burglaryManager.CALLED == false) then
                        for outdoorPed in EnumeratePeds() do
                            if
                                DoesEntityExist(outdoorPed) and not IsEntityDead(outdoorPed) and not IsPedInAnyVehicle(outdoorPed) and
                                    GetDistanceBetweenCoords(GetEntityCoords(outdoorPed), playerPosition) < 13 and
                                    HasEntityClearLosToEntityInFront(outdoorPed, playerPed) and outdoorPed ~= playerPed and not IsPedAPlayer(outdoorPed)
                             then
                                forceAnim({"missfbi3_steve_phone", "steve_phone_idle_b"}, 49, {time = 4000, ped = outdoorPed})
                                Citizen.SetTimeout(
                                    5000,
                                    function()
                                        if DoesEntityExist(outdoorPed) and not IsPedDeadOrDying(outdoorPed) then
                                            TaskWanderStandard(outdoorPed, 10.0, 10)
                                            burglaryManager.CALLED = true
                                            local message = "Une personne semble cambrioler mon voisin!"
                                            local burglaryCoords = vector3(burglaryManager.STREET.pos.x, burglaryManager.STREET.pos.y, burglaryManager.STREET.pos.z)
                                            TriggerServerEvent("call:makeCall2", "police", burglaryCoords, message, "Voisin vigilant")
                                            TriggerServerEvent("call:makeCall2", "lssd", burglaryCoords, message, "Voisin vigilant")
                                        end
                                    end
                                )

                                
                            end
                        end
                    end
                end

                if (burglaryManager.STATE > 0) then 
                    if GetInteriorAtCoords(playerPosition.x, playerPosition.y, playerPosition.z) == 0 and (GetDistanceBetweenCoords(playerPosition.x, playerPosition.y, playerPosition.z, burglaryManager.STREET.pos.x, burglaryManager.STREET.pos.y, burglaryManager.STREET.pos.z) > 40) then
                        finishRoberry()
                        break
                    end
                end
            end
        end)
    else
        ShowAdvancedNotification(
            "Mitch",
            "~b~Dialogue",
            "~r~~h~Désolé man, j'ai pas d'info pour le moment! Rappelle plus tard!~h~",
            "CHAR_BEVERLY",
            1
        )
    end

end

RegisterNetEvent("Ora::Illegal:StartBurglaryNorth")
AddEventHandler(
    "Ora::Illegal:StartBurglaryNorth",
    function()
        if burglaryManager.STATE > 0 then
            ShowAdvancedNotification(
                "Mitch",
                "~b~Dialogue",
                "~y~~h~Sorry man, mais t'as encore un contrat à faire pour moi avant d'en prendre un nouveau!~h~",
                "CHAR_BEVERLY",
                1
            )
            return
        end

        if (isCorrectTimeToBurglar() == false) then
            ShowAdvancedNotification(
                "Mitch",
                "~b~Dialogue",
                "~r~~h~Mec c'est la nuit que tu vas cambrioler!\nRappelle moi plus tard~h~",
                "CHAR_BEVERLY",
                1
            )
            return
        end

        TriggerServerCallback("Ora::SE::Service:GetTotalServiceCountForJobs", 
            function(availablePlayers) 
                StartBurglary("north", availablePlayers)
            end,
            {"lssd"}
        )
    end
)

-- Event called when the player make a Phonecall.
RegisterNetEvent("Ora::Illegal:StartBurglarySouth")
AddEventHandler(
    "Ora::Illegal:StartBurglarySouth",
    function()
        if burglaryManager.STATE > 0 then
            ShowAdvancedNotification(
                "Mitch",
                "~b~Dialogue",
                "~y~~h~Sorry man, mais t'as encore un contrat à faire pour moi avant d'en prendre un nouveau!~h~",
                "CHAR_BEVERLY",
                1
            )
            return
        end

        if (isCorrectTimeToBurglar() == false) then
            ShowAdvancedNotification(
                "Mitch",
                "~b~Dialogue",
                "~r~~h~Mec c'est la nuit que tu vas cambrioler!\nRappelle moi plus tard~h~",
                "CHAR_BEVERLY",
                1
            )
            return
        end

        TriggerServerCallback("Ora::SE::Service:GetTotalServiceCountForJobs", 
            function(availablePlayers) 
                StartBurglary("south", availablePlayers)
            end,
            {"police", "lssd"}
        )
    end
)