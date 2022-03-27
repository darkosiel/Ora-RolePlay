local RACE_STATE_NONE = 0
local RACE_STATE_JOINED = 1
local RACE_STATE_RACING = 2
local RACE_STATE_RECORDING = 3
local BET_RACE = 4
local RACE_CHECKPOINT_TYPE = 45
local RACE_CHECKPOINT_FINISH_TYPE = 9

local races = {}
local raceStatus = {
    state = RACE_STATE_NONE,
    index = 0,
    checkpoint = 0
}

local recordedCheckpoint = {}

Citizen.CreateThread(function()
    TriggerServerCallback("getRaces", function(races)
        races = races
    end)
end)

function Popup(array)
    ClearPrints()
    SetNotificationTextEntry("STRING")
    if (array.message == nil) then
        error("Missing arguments, message")
    else
        AddTextComponentString(tostring(array.message))
    end
    DrawNotification(false, true)
    if (array.sound ~= nil) then
        if (array.sound.audio_name ~= nil) then
            if (array.sound.audio_ref ~= nil) then
                PlaySoundFrontend(-1, array.sound.audio_name, array.sound.audio_ref, true)
            else
                error("Missing arguments, audio_ref")
            end
        else
            error("Missing arguments, audio_name")
        end
    end
end

RegisterCommand("race", function(source, args)

    if args[1] == nil then
        local player = GetPlayerPed(-1)
        if IsPedInAnyVehicle(player, false) then
            if IsWaypointActive() then
                --local amount = tonumber(args[1])
                exports['Snoupinput']:ShowInput("Montant parié en $", 10, "number", "", true)
                local amount = exports['Snoupinput']:GetInput()
                if amount and tonumber(amount) ~= nil then
                    amount = tonumber(amount)
                    if amount < 0 then return Popup({message = "~r~Erreur:\nTu dois parier de l'argent, pas glitch petit malin.~s~"}) end
                    --local startDelay = tonumber(args[2])
                    exports['Snoupinput']:ShowInput("Délai avant le départ en secondes", 10, "number", "60", true)
                    local startDelay = exports['Snoupinput']:GetInput()
                    if startDelay and tonumber(startDelay) ~= nil then
                        startDelay = tonumber(startDelay)
                        startDelay = startDelay and startDelay*1000 or config_cl.joinDuration
                        local startCoords = GetEntityCoords(GetPlayerPed(-1))
                        local waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
                        local retval, nodeCoords = GetClosestVehicleNode(waypointCoords.x, waypointCoords.y, waypointCoords.z, 1)
                        table.insert(recordedCheckpoint, {blip = nil, coords = nodeCoords})
                        TriggerServerEvent('StreetRaces:createRace_sv', amount, startDelay, startCoords, recordedCheckpoint)
                        table.remove(recordedCheckpoint, 1)
                        raceStatus.state = RACE_STATE_NONE
                    else
                        Popup({message = "~p~Race (Courses de rue)~m~\nTu dois entrer un pari et un délai (~h~60~h~ min. recommandé)~s~", sound = {audio_name = "Enter_1st", audio_ref = "GTAO_Magnate_Boss_Modes_Soundset"}})
                    end
                else
                    Popup({message = "~p~Race (Courses de rue)~m~\nTu dois entrer un pari et un délai (~h~60~h~ min. recommandé)~s~", sound = {audio_name = "Enter_1st", audio_ref = "GTAO_Magnate_Boss_Modes_Soundset"}})
                end
            else
                Popup({message = "~r~Erreur:\nTu dois avoir une destination pour initialiser une course !~s~"})
            end
        else
            Popup({message = "~r~Erreur:\nTu dois être dans un véhicule pour faire ça !~s~"})
        end
    elseif args[1] == "r" then
        local player = GetPlayerPed(-1)
        if IsPedInAnyVehicle(player, false) then
            if IsWaypointActive() then
                --local amount = tonumber(args[1])
                exports['Snoupinput']:ShowInput("Montant parié en $", 10, "number", "", true)
                local amount = exports['Snoupinput']:GetInput()
                if amount and tonumber(amount) ~= nil then
                    amount = tonumber(amount)
                    if amount < 0 then return Popup({message = "~r~Erreur:\nTu dois parier de l'argent, pas glitch petit malin.~s~"}) end
                    --local startDelay = tonumber(args[2])
                    exports['Snoupinput']:ShowInput("Délai avant le départ en secondes", 10, "number", "60", true)
                    local startDelay = exports['Snoupinput']:GetInput()
                    if startDelay and tonumber(startDelay) ~= nil then
                        startDelay = tonumber(startDelay)
                        startDelay = startDelay and startDelay*1000 or config_cl.joinDuration
                        local startCoords = GetEntityCoords(GetPlayerPed(-1))
                        local waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
                        local retval, nodeCoords = GetClosestVehicleNode(waypointCoords.x, waypointCoords.y, waypointCoords.z, 1)
                        table.insert(recordedCheckpoint, {blip = nil, coords = nodeCoords})
                        TriggerServerEvent('StreetRaces:createRace_sv', amount, startDelay, startCoords, recordedCheckpoint)
                        table.remove(recordedCheckpoint, 1)
                        raceStatus.state = RACE_STATE_NONE
                        RageUI.Visible(RMenu:Get("personnal", "vehicule"), true)
                    else
                        Popup({message = "~p~Race (Courses de rue)~m~\nTu dois entrer un pari et un délai (~h~60~h~ min. recommandé)~s~", sound = {audio_name = "Enter_1st", audio_ref = "GTAO_Magnate_Boss_Modes_Soundset"}})
                    end
                else
                    Popup({message = "~p~Race (Courses de rue)~m~\nTu dois entrer un pari et un délai (~h~60~h~ min. recommandé)~s~", sound = {audio_name = "Enter_1st", audio_ref = "GTAO_Magnate_Boss_Modes_Soundset"}})
                end
            else
                Popup({message = "~r~Erreur:\nTu dois avoir une destination pour initialiser une course !~s~"})
            end
        else
            Popup({message = "~r~Erreur:\nTu dois être dans un véhicule pour faire ça !~s~"})
        end
    else
        return
    end
end)

RegisterNetEvent("StreetRaces:createRace_cl")
AddEventHandler("StreetRaces:createRace_cl", function(race)--index, amount, startDelay, startCoords, checkpoints
    --[[ local race = {
        amount = amount,
        started = false,
        startTime = GetGameTimer() + startDelay,
        startCoords = startCoords,
        checkpoints = checkpoints
    } ]]
    local race = race
    race.startTime = GetGameTimer() + race.startDelay
    table.insert(races, race)
end)

RegisterNetEvent("StreetRaces:joinedRace_cl")
AddEventHandler("StreetRaces:joinedRace_cl", function(index, montant)
    raceStatus.index = index
    raceStatus.state = RACE_STATE_JOINED
    local race = races[index]
    local checkpoints = race.checkpoints
    for i, checkpoint in pairs(checkpoints) do
        checkpoint.blip = AddBlipForCoord(checkpoint.coords.x, checkpoint.coords.y, checkpoint.coords.z)
        SetBlipColour(checkpoint.blip, config_cl.checkpointBlipColor)
        SetBlipAsShortRange(checkpoint.blip, true)
        ShowNumberOnBlip(checkpoint.blip, i)
    end
    SetWaypointOff()
    SetBlipRoute(checkpoints[1].blip, true)
    SetBlipRouteColour(checkpoints[1].blip, config_cl.checkpointBlipColor)
end)

RegisterNetEvent("StreetRaces:bettingRace_cl")
AddEventHandler("StreetRaces:bettingRace_cl", function(index, montant)
    raceStatus.index = index
    raceStatus.state = BET_RACE
end)

RegisterNetEvent("StreetRaces:removeRace_cl")
AddEventHandler("StreetRaces:removeRace_cl", function(index)
    if index == raceStatus.index then
        cleanupRace()
        raceStatus.index = 0
        raceStatus.checkpoint = 0
        raceStatus.state = RACE_STATE_NONE
    elseif index < raceStatus.index then
        raceStatus.index = raceStatus.index - 1
    end
    table.remove(races, index)
end)

RegisterNetEvent('StreetRaces:Popup')
AddEventHandler('StreetRaces:Popup', function(msg)
    Popup({message = msg})
end)

-- RegisterNetEvent('StreetRaces:sendWinMoney')
-- AddEventHandler('StreetRaces:sendWinMoney', 
--     function(montant) 
--         TriggerServerEvent(Ora.Payment:GetServerEventName(), {AMOUNT = montant, SOURCE = "Courses de rue", LEGIT = true})
--     end
-- )

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = LocalPlayer().Ped
        if IsPedInAnyVehicle(player, false) then
            local position = GetEntityCoords(player)
            local vehicle = GetVehiclePedIsIn(player, false)

            if raceStatus.state == RACE_STATE_RACING then
                local race = races[raceStatus.index]
                if raceStatus.checkpoint == 0 then
                    raceStatus.checkpoint = 1
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]

                    if config_cl.checkpointRadius > 0 then
                        local checkpointType = raceStatus.checkpoint < #race.checkpoints and RACE_CHECKPOINT_TYPE or RACE_CHECKPOINT_FINISH_TYPE
                        checkpoint.checkpoint = CreateCheckpoint(checkpointType, checkpoint.coords.x,  checkpoint.coords.y, checkpoint.coords.z, 0, 0, 0, config_cl.checkpointRadius, 0, 255, 85, 127, 0) -- default 255, 255, 0
                        SetCheckpointCylinderHeight(checkpoint.checkpoint, config_cl.checkpointHeight, config_cl.checkpointHeight, config_cl.checkpointRadius)
                    end

                    SetBlipRoute(checkpoint.blip, true)
                    SetBlipRouteColour(checkpoint.blip, config_cl.checkpointBlipColor)
                else
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]
                    if GetDistanceBetweenCoords(position.x, position.y, position.z, checkpoint.coords.x, checkpoint.coords.y, 0, false) < config_cl.checkpointProximity then
                        RemoveBlip(checkpoint.blip)
                        if config_cl.checkpointRadius > 0 then
                            DeleteCheckpoint(checkpoint.checkpoint)
                        end
                        if raceStatus.checkpoint == #(race.checkpoints) then
                            PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")
                            local currentTime = (GetGameTimer() - race.startTime)
                            TriggerServerCallback(
                                'StreetRaces:finishedRace_sv',
                                function(prize)
                                    TriggerServerCallback(
                                        "Ora::SE::Money:AuthorizePayment", 
                                        function(token)
                                            TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = prize, SOURCE = "Courses de rue", LEGIT = true})
                                        end,
                                        {}
                                    )
                                end,
                                raceStatus.index,
                                currentTime
                            )
                            raceStatus.checkpoint = 0
                            raceStatus.state = RACE_STATE_NONE
                        end
                    end
                end

                if config_cl.hudEnabled then
                    local timeSeconds = (GetGameTimer() - race.startTime)/1000.0
                    local timeMinutes = math.floor(timeSeconds/60.0)
                    timeSeconds = timeSeconds - 60.0*timeMinutes
                    Draw2DText(config_cl.hudPosition.x, config_cl.hudPosition.y, ("~y~%02d:%06.3f"):format(timeMinutes, timeSeconds), 0.7)
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]
                    local checkpointDist = math.floor(GetDistanceBetweenCoords(position.x, position.y, position.z, checkpoint.coords.x, checkpoint.coords.y, 0, false))
                    Draw2DText(config_cl.hudPosition.x, config_cl.hudPosition.y + 0.04, ("~y~CHECKPOINT %d/%d (%dm)"):format(raceStatus.checkpoint, #race.checkpoints, checkpointDist), 0.5)
                end
            elseif raceStatus.state == RACE_STATE_JOINED then
                local race = races[raceStatus.index]
                local currentTime = GetGameTimer()
                local count = race.startTime - currentTime
                if count <= 0 then
                    raceStatus.state = RACE_STATE_RACING
                    raceStatus.checkpoint = 0
                    FreezeEntityPosition(vehicle, false)
                elseif count <= config_cl.freezeDuration then
                    Draw2DText(0.5, 0.4, ("~y~%d"):format(math.ceil(count/1000.0)), 3.0)
                    if count <= 1000 then
                        FreezeEntityPosition(vehicle, true)
                    end
                else
                    local temp, zCoord = GetGroundZFor_3dCoord(race.startCoords.x, race.startCoords.y, 9999.9, 1)
                    Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+1.0, ("Tu cours pour ~g~$%d~w~ début dans ~y~%d~w~s"):format(race.amount, math.ceil(count/1000.0)))
                    Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+0.80, "Appuie sur [~g~E~w~] pour abandonner la course")
                    if IsControlJustReleased(1, config_cl.leaveKeybind) then
                        cleanupRace()
                        TriggerServerEvent('StreetRaces:leaveRace_sv', raceStatus.index)
                        TriggerServerCallback(
                            "Ora::SE::Money:AuthorizePayment", 
                            function(token)
                                TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = race.amount, SOURCE = "Courses de rue", LEGIT = true})
                            end,
                            {}
                        )
                        raceStatus.index = 0
                        raceStatus.checkpoint = 0
                        raceStatus.state = RACE_STATE_NONE
                    end
                end
            elseif raceStatus.state == BET_RACE then
                local race = races[raceStatus.index]
                local currentTime = GetGameTimer()
                local count = race.startTime - currentTime
                local temp, zCoord = GetGroundZFor_3dCoord(race.startCoords.x, race.startCoords.y, 9999.9, 1)
                Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+1.0, ("Tu as ajouté ~g~$%d~w~ au cashprize début dans ~y~%d~w~s"):format(race.amount, math.ceil(count/1000.0)))
            else
                for index, race in pairs(races) do
                    local currentTime = GetGameTimer()
                    --local proximity = GetDistanceBetweenCoords(position.x, position.y, position.z, race.startCoords.x, race.startCoords.y, race.startCoords.z, true)
                    local proximity = #(race.startCoords - position)

                    if proximity < config_cl.joinProximity and currentTime < race.startTime then
                        local count = math.ceil((race.startTime - currentTime)/1000.0)
                        local temp, zCoord = GetGroundZFor_3dCoord(race.startCoords.x, race.startCoords.y, 9999.9, 0)
                        Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+1.0, ("Course à ~g~$%d~w~ début dans ~y~%d~w~s"):format(race.amount, count))
                        Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+0.80, "Appuie sur [~g~E~w~] pour participer OU appuie sur [~g~B~w~] pour ajouter ~g~$"..race.amount.."~w~ au cashprize")

                        if IsControlJustReleased(1, config_cl.joinKeybind) then
                            dataonWait = {}
                            dataonWait = {
                                title = "Participation course",
                                price = race.amount,
                                fct = function()
                                    TriggerServerEvent('StreetRaces:joinRace_sv', index)
                                end
                            }
                            TriggerEvent('payWith?')
                            break
                        end
                        if IsControlJustReleased(0, config_cl.betKeybind) then
                            dataonWait = {}
                            dataonWait = {
                                title = "Participation course",
                                price = race.amount,
                                fct = function()
                                    TriggerServerEvent('StreetRaces:betRace_sv', index)
                                end
                            }
                            TriggerEvent('payWith?')
                            break
                        end
                    end
                end
            end
        end
    end
end)

function cleanupRace()
    if raceStatus.index ~= 0 then
        local race = races[raceStatus.index]
        local checkpoints = race.checkpoints
        for _, checkpoint in pairs(checkpoints) do
            if checkpoint.blip then
                RemoveBlip(checkpoint.blip)
            end
            if checkpoint.checkpoint then
                DeleteCheckpoint(checkpoint.checkpoint)
            end
        end

        if raceStatus.state == RACE_STATE_RACING then
            local lastCheckpoint = checkpoints[#checkpoints]
            SetNewWaypoint(lastCheckpoint.coords.x, lastCheckpoint.coords.y)
        end

        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        FreezeEntityPosition(vehicle, false)
    end
end

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = 1.8*(1/dist)*(1/GetGameplayCamFov())*100

        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function Draw2DText(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
