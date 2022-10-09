AddRelationshipGroup("CarjackVehicle")
SetRelationshipBetweenGroups(0, GetHashKey("CarjackVehicle"), 0xA49E591C)
SetRelationshipBetweenGroups(0, 0xA49E591C, GetHashKey("CarjackVehicle"))

local pedsModel = {
    "a_f_m_downtown_01",
    "a_f_m_eastsa_01",
    "a_f_m_soucentmc_01",
    "a_f_y_femaleagent",
    "a_f_y_smartcaspat_01",
    "a_m_m_eastsa_01",
    "a_m_m_bevhills_01",
    "a_m_m_fatlatin_01",
    "a_m_m_mexlabor_01",
    "a_m_m_og_boss_01",
    "a_m_m_paparazzi_01",
    "a_m_y_epsilon_02",
    "a_m_y_soucent_02",
    "a_m_y_gencaspat_01",
    "g_m_m_armlieut_01"
}

local counterStarted = false

local function startTimeCounter(illegalMission)
    counterStarted = true
    if (illegalMission.scenarioSettings ~= nil) then
        if (illegalMission.scenarioSettings.hours ~= nil) then
            illegalMission.timeLeft =
                (illegalMission.scenarioSettings.hours * 60 * 1000 * 60.0) +
                GetGameTimer()
        end
        if (illegalMission.scenarioSettings.minutes ~= nil) then
            illegalMission.timeLeft =
                (illegalMission.scenarioSettings.minutes * 60 * 1000) +
                GetGameTimer()
        end
    end

    Citizen.CreateThread(function()
        scaleform = RequestScaleformMovie_2("INSTRUCTIONAL_BUTTONS")
        local hPQ, R1FIoQI, NsoTwDs, HGli = .925, .975, .14, .03
        local iy = {".", "..", "...", ""}
        repeat Wait(0) until HasScaleformMovieLoaded(scaleform)

        while true do Wait(0)
            if renderScaleform == true then
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            end
            local timeleft = (illegalMission.timeLeft - GetGameTimer()) / 1000
            local barCount = {1}

            if counterStarted == true and timeleft ~= nil then
                if timeleft > 0 then
                    -- DrawTimerBar(barCount, "TEMPS RESTANT", s2m(timeleft))
                    DrawNiceText(
                        hPQ,
                        R1FIoQI - .05,
                        .5,
                        string.format("TEMPS RESTANT : "..s2m(timeleft)),
                        4,
                        0
                    )
                else
                    TriggerEvent("Ora:illegal:failCurrentMission", illegalMission)
                end
            end

            if timeleft < 0 or counterStarted == false then
                break
            end
        end
    end)
end

RegisterNetEvent("Ora:illegal:counterStop")
AddEventHandler("Ora:illegal:counterStop", function()
    counterStarted = false
end)

RegisterNetEvent("Ora:illegal:failCurrentMission")
AddEventHandler("Ora:illegal:failCurrentMission", function(mission)
    for k, v in pairs(mission.rewards) do
        if k == "xp" then
            math.randomseed(GetGameTimer())
            local xp = math.random(v[1], v[2])
        
            for i = 1, #currentMission.participant, 1 do
                TriggerPlayerEvent(
                    "XNL_NET:RemovePlayerXP",
                    currentMission.participant[i],
                    math.floor(xp / #currentMission.participant)
                )
            end
        end
    end

    if mission.blip ~= nil then
        RemoveBlip(mission.blip)
        mission.blip = nil
    end

    if (mission.type == "carjacking") then
        Ora.Illegal.Carjacking:StopCarjacking()
    end

    if (mission.type == "gofast") then
        Ora.Illegal.Gofast:Finish()
    end

    if (mission.type == "carroberry") then
        Ora.Illegal.CarRoberry:Finish()
    end

    TriggerServerEvent("missionEnd", mission)
    ShowNotification("~r~~h~Mission échouée~h~\nVous êtes arrivé trop tard.~s~")
end)

RegisterNetEvent("Ora:illegal:successCurrentMission")
AddEventHandler("Ora:illegal:successCurrentMission", function(currentMission)
    if currentMission.blip ~= nil then
        RemoveBlip(currentMission.blip)
        currentMission.blip = nil
    end
    TriggerEvent("Ora:illegal:counterStop")
    local f = false
    for i = 1, #currentMission.participant, 1 do
        if
            currentMission.participant[i] ==
                GetPlayerServerId(PlayerId())
         then
            f = true
            break
        end
    end

    for k, v in pairs(currentMission.rewards) do
        if k == "xp" then
            math.randomseed(GetGameTimer())
            local xp = math.random(v[1], v[2])
            if f then
                for i = 1, #currentMission.participant, 1 do
                    TriggerPlayerEvent(
                        "XNL_NET:AddPlayerXP",
                        currentMission.participant[i],
                        math.floor(xp / #currentMission.participant)
                    )
                end
            end
        end

        if k == "money" then
            math.randomseed(GetGameTimer())
            local r = math.random(v.amount[1], v.amount[2])
            TriggerServerCallback(
                "Ora::SE::Money:AuthorizePayment", 
                function(token)
                    TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = r, SOURCE = "Migrant", LEGIT = true})
                end,
                {}
            )
            ShowNotification("Tiens voilà " .. r .. "$")
        end

        if k == "items" then
            Ora.Inventory:AddItems(v)
        end
    end
    currentMission = {}
    TriggerServerEvent("missionEnd", mission)
    ShowNotification("~g~~h~Mission terminée avec succès~h~~s~")
end)

local function callPoliceIfNpcIsHere(coords, message, excludedPed)
    for outdoorPed in EnumeratePeds() do
        if
            DoesEntityExist(outdoorPed) and not IsEntityDead(outdoorPed) and
                GetDistanceBetweenCoords(GetEntityCoords(outdoorPed), coords) < 30.0 and
                HasEntityClearLosToEntityInFront(outdoorPed, LocalPlayer().Ped) and outdoorPed ~= LocalPlayer().Ped  and outdoorPed ~= excludedPed and not IsPedAPlayer(outdoorPed)
         then
            forceAnim({"missfbi3_steve_phone", "steve_phone_idle_b"}, 49, {time = 4000, ped = outdoorPed})
            Citizen.SetTimeout(
                5000,
                function()
                    if DoesEntityExist(outdoorPed) and not IsPedDeadOrDying(outdoorPed) then
                        TaskWanderStandard(outdoorPed, 10.0, 10)
                        TriggerServerEvent("call:makeCall2", "police", coords, message, "Citoyen")
                        TriggerServerEvent("call:makeCall2", "lssd", coords, message, "Citoyen")
                    end
                end
            )

            
        end
    end
end

local function isPlayerDrivingTargetCar(vehicleIdentifier)
    if (IsPedInAnyVehicle(LocalPlayer().Ped, true)) then
        local vehicle = GetVehiclePedIsIn(LocalPlayer().Ped, false)
        if (getVehicleIdentifier(vehicle) == vehicleIdentifier) then
            return true
        end
        return false
    end
    return false
end

illegalscenario = {
    [1] = function(param)
        if (Ora.Illegal.CarRoberry:CanStart()) then
            Ora.Illegal.CarRoberry:Start(currentMission.label)
            currentMission.finished = false
            currentMission.participant = {GetPlayerServerId(PlayerId())}
            currentMission.id = Ora.Illegal.CarRoberry:GetMissionId()
            currentMission.timeLeft = (Ora.Illegal.CarRoberry:GetMaxTimeForMission() * 60 * 1000) + GetGameTimer()
            currentMission.type = "carroberry"
            TriggerServerEvent("startIllegalMission", currentMission)
            startTimeCounter(currentMission)
        end
    
    end,
    [2] = function(param)
        local configStart = param.configStart
        Ora.Illegal.Gofast:SetMissionLevel(currentMission.label)
        if (Ora.Illegal.Gofast:CanStart()) then
            Ora.Illegal.Gofast:Start()
            Ora.Illegal.Gofast:SetItemToPutInTrunk(configStart.itemInTrunk)
            currentMission.finished = false
            currentMission.participant = {GetPlayerServerId(PlayerId())}
            currentMission.id = Ora.Illegal.Gofast:GetMissionId()
            currentMission.timeLeft = (Ora.Illegal.Gofast:GetMaxTimeForMission() * 60 * 1000) + GetGameTimer()
            currentMission.type = "gofast"
            TriggerServerEvent("startIllegalMission", currentMission)
            startTimeCounter(currentMission)
        end
    end,
    [3] = function(param)
        Ora.Illegal.Carjacking:SetMissionLevel(currentMission.label)
        if (Ora.Illegal.Carjacking:CanStart() == true) then
            Ora.Illegal.Carjacking:StartCarjacking()
            currentMission.finished = false
            currentMission.participant = {GetPlayerServerId(PlayerId())}
            currentMission.id = Ora.Illegal.Carjacking:GetMissionId()
            currentMission.timeLeft = (Ora.Illegal.Carjacking:GetMaxTimeForMission() * 60 * 1000) + GetGameTimer()
            currentMission.type = "carjacking"
            TriggerServerEvent("startIllegalMission", currentMission)
            startTimeCounter(currentMission)
        else
            ShowNotification("~r~Vous êtes déjà en mission")
        end
    end,
    [4] = function(param)
        local positionStartRandomness = Random(#missionConfig["startMigrantSmuggling"])
        if positionStartRandomness == 0 then
            positionStartRandomness = 1
        end

        local positionStart = missionConfig["startMigrantSmuggling"][positionStartRandomness]

        local coords = {
            x = positionStart.pos.x,
            y = positionStart.pos.y,
            z = positionStart.pos.z
        }

        currentMission.finished = false
        currentMission.participant = {GetPlayerServerId(PlayerId())}
        currentMission.id = GetGameTimer()
        currentMission.blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipRoute(currentMission.blip, true)
        TriggerServerEvent("startIllegalMission", currentMission)
        startTimeCounter(currentMission)

        ShowAdvancedNotification(
            "Jason",
            "~b~Dialogue",
            "~g~~h~On a récupéré quelques migrants~h~~w~\n\n~o~Va récupérer le van plein de migrants!~w~",
            "CHAR_LESTER",
            1
        )

        TriggerServerEvent(
            "Ora:sendToDiscord",
            18,
            "[MISSION #"..currentMission.id.."]\nLance une mission passage de migrants", 
            "info"
        )

        local playerPed = LocalPlayer().Ped
        local playerCoords = LocalPlayer().Pos
        local truckLaunched = false
        local currentPath = 1
        local startDropOff = false
        local currentDropOffPoint = nil
        local isInDelivery = false
        local currentDropOffIndex = 0
        local passenger = nil
        local oldPassenger = nil
        local spawnedVehicle = nil
        local startFinishMission = false
        local endPosition = nil

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(1000)
                playerCoords = LocalPlayer().Pos
                local distanceBetweenCoords = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, coords.x, coords.y, coords.z, false)

                if (distanceBetweenCoords <= 5.0 and truckLaunched == false) then
                    truckLaunched = true
                    ShowAdvancedNotification(
                        "Jason",
                        "~b~Dialogue",
                        "~g~~h~Opération Migrant~h~~w~\n\n~o~Le chauffeur arrive! Patiente 30 secondes~w~",
                        "CHAR_LESTER",
                        1
                    )

                    vehicleFct.SpawnVehicle(
                        "speedo4",
                        positionStart.truckPos,
                        positionStart.headingTruck,
                        function(vehicle)
                            TriggerServerEvent(
                                "Ora:sendToDiscord",
                                18,
                                "[MISSION #"..currentMission.id.."]\nVéhicule créé : {x = " .. positionStart.truckPos.x .. ", y = " .. positionStart.truckPos.y .. ", z = " .. positionStart.truckPos.z .. "}", 
                                "info"
                            )
                            v = vehicle
                            spawnedVehicle = vehicle
                            
                            SetEntityAsMissionEntity(v, true, true)
                            SetVehicleOnGroundProperly(v)
                            SetVehicleMod(v, 11, 2, false)
                            SetVehicleMod(v, 12, 3, false)
                            SetVehicleMod(v, 13, 2, false)
                            SetVehicleMod(v, 15, 2, false)
                            ToggleVehicleMod(v, 18, 1)
                            ToggleVehicleMod(v, 22, 1)
                            Citizen.InvokeNative(0x06FAACD625D80CAA, v)
                            local blip = nil
                            if IsEntityAVehicle(v) then
                                local coords = GetEntityCoords(v)
                                local driverModel = currentMission.scenarioSettings.truckers[math.random(#currentMission.scenarioSettings.truckers)]
                                driver = Ora.World.Ped:Create(5, driverModel, vector3(positionStart.truckPos.x + 1.0, positionStart.truckPos.y + 1.0, positionStart.truckPos.z), 0.0)
                                local passengerModel = currentMission.scenarioSettings.truckers[math.random(#currentMission.scenarioSettings.truckers)]
                                passenger = Ora.World.Ped:Create(5, passengerModel, vector3(positionStart.truckPos.x + 1.0, positionStart.truckPos.y + 1.0, positionStart.truckPos.z), 0.0)
                                SetPedIntoVehicle(driver, vehicle, -1)
                                SetPedIntoVehicle(passenger, vehicle, 2)
                            
                                currentMission.goalCar =
                                    GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
                                local vehicleStorageName =
                                    GetEntityModel(vehicle) .. "|" .. GetVehicleNumberPlateText(vehicle)
                                currentMission.plates = GetVehicleNumberPlateText(vehicle)
                                currentMission.platesVerif = vehicleStorageName
                                currentMission.participant = {GetPlayerServerId(PlayerId())}
                                TriggerServerEvent("editIllegalMission", currentMission)

                                TaskVehicleDriveToCoord(driver, vehicle, playerCoords.x, playerCoords.y, playerCoords.z, 17.0, 0, "mule2", 786603, 1, true)
                                enroute = true
                                while enroute do
                                    Citizen.Wait(500)
                                    distanceToTarget = GetDistanceBetweenCoords(playerCoords, GetEntityCoords(vehicle).x, GetEntityCoords(vehicle).y, GetEntityCoords(vehicle).z, true)
                                   
                                    if distanceToTarget < 20 then
                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            18,
                                            "[MISSION #"..currentMission.id.."]\nVéhicule arrivé sur place", 
                                            "success"
                                        )
                                        enroute = false
                                        TaskVehicleTempAction(driver, vehicle, 27, 6000)
                                        Wait(3000)
                                        TaskLeaveVehicle(driver, vehicle, 256)

                                        ShowAdvancedNotification(
                                            "Jason",
                                            "~b~Dialogue",
                                            "~g~~h~Opération Migrant~h~~w~\n\n~o~Prend le van et dépose les migrants un par un.~w~",
                                            "CHAR_LESTER",
                                            1
                                        )

                                        TaskWanderStandard(driver, 10.0, 10)
                                        startDropOff = true
                                        TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = driver, network_id = NetworkGetNetworkIdFromEntity(driver), seconds = 30})
                                    end
                                end
                                
                            end
                        end
                    )
                end

                if (startDropOff == true) then
                    if (currentDropOffPoint == nil) then
                        currentDropOffIndex = currentDropOffIndex + 1
                        if (currentDropOffIndex <= #missionConfig.migrantSmugglingDropOff) then 
                            dropOffPointItems = #missionConfig.migrantSmugglingDropOff[currentDropOffIndex]
                            currentDropOffPoint = missionConfig.migrantSmugglingDropOff[currentDropOffIndex][math.random(1, dropOffPointItems)]
                            if (currentMission.blip ~= nil) then
                                RemoveBlip(currentMission.blip)
                            end
                            currentMission.blip = AddBlipForCoord(currentDropOffPoint.pos.x, currentDropOffPoint.pos.y, currentDropOffPoint.pos.z)
                            SetBlipRoute(currentMission.blip, true)
                            TriggerServerEvent("editIllegalMission", currentMission)

                            ShowAdvancedNotification(
                                "Jason",
                                "~b~Dialogue",
                                "~g~~h~Opération Migrant~h~~w~\n\n~o~Depose le migrant #".. currentDropOffIndex .." à l'adresse indiquée.~w~",
                                "CHAR_LESTER",
                                1
                            )
                        else
                            if (currentMission.blip ~= nil) then
                                RemoveBlip(currentMission.blip)
                            end
                            math.randomseed(GetGameTimer() * math.random(10000, 50000))
                            local endPosCount = #missionConfig.endMigrantSmuggling
                            endPosition = missionConfig.endMigrantSmuggling[math.random(1, endPosCount)]
                            currentMission.blip = AddBlipForCoord(endPosition.pos.x, endPosition.pos.y, endPosition.pos.z)
                            SetBlipRoute(currentMission.blip, true)
                            TriggerServerEvent("editIllegalMission", currentMission)
                            
                            ShowAdvancedNotification(
                                "Jason",
                                "~b~Dialogue",
                                "~g~~h~Opération Migrant~h~~w~\n\n~o~Bien, tout les migrants sont descendu ramene le van à l'adresse indiquée.~w~",
                                "CHAR_LESTER",
                                1
                            )
                            startDropOff = false
                            startFinishMission = true
                        end
                    else
                        if (GetDistanceBetweenCoords(GetEntityCoords(spawnedVehicle).x, GetEntityCoords(spawnedVehicle).y, GetEntityCoords(spawnedVehicle).z, currentDropOffPoint.pos.x, currentDropOffPoint.pos.y, currentDropOffPoint.pos.z, true) <= 10.0) then
                            ShowAdvancedNotification(
                                "Jason",
                                "~b~Dialogue",
                                "~g~~h~Le migrant descend de la voiture. Il va te payer.~h~~w~",
                                "CHAR_LESTER",
                                1
                            )

                            SetVehicleUndriveable(spawnedVehicle, true)
                            FreezeEntityPosition(spawnedVehicle, true)
                            Citizen.Wait(1000)
                            SetVehicleDoorOpen(spawnedVehicle, 3, false, false)
                            
                            if (passenger ~= nil) then
                                math.randomseed(GetGameTimer())
                                local chancePedLeave = math.random(1, 100)
                                math.randomseed(GetGameTimer())
                                local r = math.random(90, 110)

                                local plate = GetVehicleNumberPlateText(spawnedVehicle)
                                callPoliceIfNpcIsHere(LocalPlayer().Pos, "Un homme transporte des migrants. Plaque commence par " .. plate:sub(1, 4) .. " ...", passenger)

                                if (chancePedLeave >= 80) then
                                    ShowAdvancedNotification(
                                        "Jason",
                                        "~b~Dialogue",
                                        "~r~~h~Le migrant se casse sans te payer !!! Pète lui la gueule pour obtenir l'argent. Tu as 60 secondes~h~~w~",
                                        "CHAR_LESTER",
                                        1
                                    )
                                    TaskLeaveVehicle(passenger)
                                    TaskSmartFleePed(
                                        passenger --[[ Ped ]], 
                                        playerPed --[[ Ped ]], 
                                        350.0 --[[ number ]], 
                                        30000 --[[ Any ]], 
                                        true --[[ boolean ]], 
                                        true --[[ boolean ]]
                                    )
                                    local loopCount = 0
                                    while ((DoesEntityExist(passenger) and IsPedDeadOrDying(passenger) == false) and loopCount <= 60) do
                                        loopCount = loopCount + 1
                                        Citizen.Wait(1000)
                                    end
                                    Citizen.Wait(1000)
                                    if loopCount < 60 then
                                        ShowAdvancedNotification(
                                            "Jason",
                                            "~b~Dialogue",
                                            "~g~~h~Tu as réussi à le rattraper. Tu reçois " .. r .. "$.~h~~w~",
                                            "CHAR_LESTER",
                                            1
                                        )
                                        TriggerServerCallback(
                                            "Ora::SE::Money:AuthorizePayment", 
                                            function(token)
                                                TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = r, SOURCE = "Migrant", LEGIT = true})
                                            end,
                                            {}
                                        )
                                        local plate = GetVehicleNumberPlateText(spawnedVehicle)
                                        TriggerServerEvent("call:makeCall2", "police", LocalPlayer().Pos, "Un passeur en van a taper un migrant devant moi. La plaque commence par " .. plate:sub(1, 4), "Citoyen")
                                        TriggerServerEvent("call:makeCall2", "lssd", LocalPlayer().Pos, "Un passeur en van a taper un migrant devant moi. La plaque commence par " .. plate:sub(1, 4), "Citoyen")
                                        TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = passenger, network_id = NetworkGetNetworkIdFromEntity(passenger), seconds = 30})

                                    else
                                        ShowAdvancedNotification(
                                            "Jason",
                                            "~b~Dialogue",
                                            "~r~~h~Le migrant a fui ... tu as perdu " .. r .. "$.~h~~w~",
                                            "CHAR_LESTER",
                                            1
                                        )
                                        local plate = GetVehicleNumberPlateText(spawnedVehicle)
                                        TriggerServerEvent("call:makeCall2", "police", LocalPlayer().Pos, "Une personne dans un van gris semble transporter des migrants. La plaque commence par " .. plate:sub(1, 4), "Citoyen")
                                        TriggerServerEvent("call:makeCall2", "lssd", LocalPlayer().Pos, "Une personne dans un van gris semble transporter des migrants. La plaque commence par " .. plate:sub(1, 4), "Citoyen")
                                        TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = passenger, network_id = NetworkGetNetworkIdFromEntity(passenger), seconds = 30})
                                    end

                                    if (oldPassenger ~= nil) then 
                                        TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = oldPassenger, network_id = NetworkGetNetworkIdFromEntity(oldPassenger), seconds = 30})
                                        oldPassenger = nil
                                    end
                                else
                                    ShowAdvancedNotification(
                                        "Jason",
                                        "~b~Dialogue",
                                        "~g~~h~Le migrant te paye " .. r .. "$.~h~~w~",
                                        "CHAR_LESTER",
                                        1
                                    )
                                    TriggerServerCallback(
                                        "Ora::SE::Money:AuthorizePayment", 
                                        function(token)
                                            TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = r, SOURCE = "Migrant", LEGIT = true})
                                        end,
                                        {}
                                    )
                                    TaskLeaveVehicle(passenger)
                                    TaskWanderStandard(passenger, 10.0, 10)
                                    TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = passenger, network_id = NetworkGetNetworkIdFromEntity(passenger), seconds = 30})

                                    if (oldPassenger ~= nil) then
                                        TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = oldPassenger, network_id = NetworkGetNetworkIdFromEntity(oldPassenger), seconds = 30})
                                        oldPassenger = nil
                                    end
                                end

                                if (spawnedVehicle ~= nil and currentDropOffIndex < #missionConfig.migrantSmugglingDropOff) then 
                                    math.randomseed(GetGameTimer() * math.random(10000, 50000))
                                    local migrantModel = currentMission.scenarioSettings.migrants[math.random(#currentMission.scenarioSettings.migrants)]
                                    local vehicleLocation = GetEntityCoords(spawnedVehicle)
                                    oldPassenger = passenger
                                    passenger = Ora.World.Ped:Create(5, migrantModel, vector3(vehicleLocation.x + 2.0, vehicleLocation.y + 2.0, vehicleLocation.z), 0.0)
                                    TaskEnterVehicle(passenger, spawnedVehicle, 2000, 2, 2.0, 16, 0)
                                end
                            end

                            Citizen.Wait(2000)
                            SetVehicleDoorShut(spawnedVehicle, 3, false, false)
                            SetVehicleUndriveable(spawnedVehicle, false)
                            FreezeEntityPosition(spawnedVehicle, false)
                            currentDropOffPoint = nil
                        end
                    end
                end

                if (startFinishMission == true) then
                    if (GetDistanceBetweenCoords(GetEntityCoords(spawnedVehicle).x, GetEntityCoords(spawnedVehicle).y, GetEntityCoords(spawnedVehicle).z, endPosition.pos.x, endPosition.pos.y, endPosition.pos.z, true) <= 10.0) then
                        ShowAdvancedNotification(
                            "Jason",
                            "~b~Dialogue",
                            "~g~~h~Merci pour ton bon boulot.~h~~w~",
                            "CHAR_LESTER",
                            1
                        )
                        TriggerServerEvent(
                            "Ora:sendToDiscord",
                            18,
                            "[MISSION #"..currentMission.id.."]\nMission terminée", 
                            "info"
                        )

                        TriggerEvent("Ora:illegal:successCurrentMission", currentMission)

                        if (spawnedVehicle ~= nil and DoesEntityExist(spawnedVehicle)) then 
                            DeleteEntity(spawnedVehicle)
                        end

                        local truckLaunched = false
                        local currentPath = 1
                        local startDropOff = false
                        local currentDropOffPoint = nil
                        local isInDelivery = false
                        local currentDropOffIndex = 0
                        local passenger = nil
                        local oldPassenger = nil
                        local spawnedVehicle = nil
                        local startFinishMission = false
                        local endPosition = nil
                        break
                    end
                end
            end
        end)
    end
}

-- Function to call police for gofast
function callPoliceForGoFast(currentMission, isUpdate)
    local coordsPlayer = LocalPlayer().Pos
    local coordsApprox =
        vector3(coordsPlayer.x + Random(100, 300) * 1.0, coordsPlayer.y + Random(100, 300) * 1.0, coordsPlayer.z)
    local message =
        "[GOF] - " ..
        currentMission.plates ..
            "\nVéhicule " .. currentMission.goalCar .. " (" .. currentMission.plates .. ") est un gofast avéré."

    if (isUpdate == true) then
        message =
            "UPDATE [GOF] - " ..
            currentMission.plates ..
                "\nVéhicule " ..
                    currentMission.goalCar .. " (" .. currentMission.plates .. ") aperçu dans ces alentours."
    end

    TriggerServerEvent("call:makeCall2", "police", coordsApprox, message, "Collègue LSPD")
    TriggerServerEvent("call:makeCall2", "lssd", coordsApprox, message, "Collègue LSSD")
end

-- Function to call police for carjacking
function callPoliceForCarjacking(currentMission, vehicle)
    coords = GetEntityCoords(vehicle)
    TriggerServerEvent(
        "call:makeCall2",
        "police",
        vector3(coords.x, coords.y, coords.z),
        "On m'a volé ma voiture vite !!!! Il a pris cette direction." .. " immat. : " .. currentMission.plates .. "."
    )
    TriggerServerEvent(
        "call:makeCall2",
        "lssd",
        vector3(coords.x, coords.y, coords.z),
        "On m'a volé ma voiture vite !!!! Il a pris cette direction." .. " immat. : " .. currentMission.plates .. "."
    )
end

-- Function to call police for stealing vehicle
function callPoliceForStealing(currentMission, vehicle, isUpdate)
    local coords = GetEntityCoords(vehicle)
    local message =
        "[VOL] - " ..
        currentMission.plates ..
            "\nVéhicule " .. currentMission.goalCar .. " (" .. currentMission.plates .. ") a été déclaré volé."

    if (isUpdate == true) then
        message =
            "UPDATE [VOL] - " ..
            currentMission.plates ..
                "\nVéhicule " ..
                    currentMission.goalCar .. " (" .. currentMission.plates .. ") aperçu dans ces alentours."
    end

    TriggerServerEvent("call:makeCall2", "police", vector3(coords.x, coords.y, coords.z), message, "Collègue LSPD")
    TriggerServerEvent("call:makeCall2", "lssd", vector3(coords.x, coords.y, coords.z), message, "Collègue LSSD")
end

function AddItemIntoTrunk(itemName, vehicle)
    local numberItemsToSpawn = 1
    local items = {}

    for i = 1, numberItemsToSpawn, 1 do
        table.insert(items, {id = generateUUIDV2(), name = itemName, metadata = {}, label = "Qualité inégalable"})
    end
    local vehicleStorageName = GetEntityModel(vehicle) .. "|" .. GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent("rage-reborn:TransfertToStorage", items, itemName, vehicleStorageName)
end

function AddPropIntoTrunk(model, vehicle)
    local modelHash = GetHashKey(model)
    local playerPed = LocalPlayer().Ped
    local coords = GetEntityCoords(vehicle)
    local forward = GetEntityForwardVector(vehicle)
    local x, y, z = table.unpack(coords - forward * 1.0)

    Citizen.CreateThread(
        function()
            if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
                RequestModel(modelHash)

                while not HasModelLoaded(modelHash) do
                    Citizen.Wait(1)
                end
            end
            local obj = Ora.World.Object:Create(modelHash, coords.x, coords.y, coords.z - 0.3, true, false, true)
            SetModelAsNoLongerNeeded(modelHash)
            SetEntityHeading(obj, GetEntityHeading(vehicle))

            AttachEntityToEntity(
                obj,
                vehicle,
                GetEntityBoneIndexByName(playerPed, "misc_a"),
                0.0,
                -0.72,
                0.3,
                0.0,
                0.0,
                0.0,
                true,
                true,
                false,
                true,
                0,
                true
            )
        end
    )
end

