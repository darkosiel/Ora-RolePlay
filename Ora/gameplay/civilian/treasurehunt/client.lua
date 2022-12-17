local countFirework = 200
local countRace = 95
local startRace = false
local finishRace = nil
local test2 = "Railey Pearce"


CreateThread(function()
    while true do
        
        local visibleText = false
        local inRange = false
        local sleep = 5
        local playerServerId = GetPlayerServerId(PlayerId())
        local playerName = Ora.Identity:GetFullname(playerServerId)

        -- if LocalPlayer.state.isLoggedIn then

            local pos = GetEntityCoords(PlayerPedId())
            
            for key, value in pairs(Config.Peds) do
                local ped = Config.Peds[key]
                local dist = #(pos - ped.coords)
                RequestModel(ped.model)

                while not HasModelLoaded(ped.model) do
                    Wait(10)
                end
                
                if dist < ped.distancespawn then
                    if not DoesEntityExist(ped.spawedPed) then
                        ped.spawedPed = CreatePed(26, ped.model, ped.coords.x, ped.coords.y, ped.coords.z, false, false)
                        SetEntityHeading(ped.spawedPed, ped.heading)
                        SetEntityInvincible(ped.spawedPed, true)
                        SetBlockingOfNonTemporaryEvents(ped.spawedPed, true)
                        if ped.anim and ped.anim2 then
                            RequestAnimDict(ped.anim)
                            while not HasAnimDictLoaded(ped.anim) do
                                Citizen.Wait(100)
                            end
                        
                            local netScene4 = CreateSynchronizedScene(ped.coords.x, ped.coords.y, ped.coords.z, vector3(0.0, 0.0, ped.heading), 2)
                            TaskSynchronizedScene(ped.spawedPed, netScene4, ped.anim, ped.anim2, 1.0, -4.0, 261, 0, 0)
                            SetSynchronizedSceneLooped(netScene4, 1)
                        end
                    end
                    if dist < 3 then
                        inRange = true
                        if dist < 1.5 then
                            if not visibleText then
                                HintToDisplay("Appuyez sur ~INPUT_PICKUP~ pour interagir")
                                if IsControlJustReleased(0, 38) then
                                    visibleText = true
                                    if ped.event then
                                        TriggerEvent(ped.event)
                                        countFirework = 200
                                    end
                                end
                            end
                            if visibleText then
                                if ped.txt then
                                    HintToDisplay(ped.txt)
                                    if Config.Logs then
                                        -- TriggerServerEvent("chasse:server:CreateLog", "chasse", "Chasse au Trésor", "green", "**" .. playerName.. "** trouve : " ..ped.txt)
                                        TriggerServerEvent("Ora:sendToDiscord", "Event", "" .. playerName.. " trouve : " ..ped.txt, 16711680)
                                    end
                                elseif ped.txt2 then
                                    HintToDisplay(ped.txt2)
                                    if Config.Logs then
                                        -- TriggerServerEvent("chasse:server:CreateLog", "chasse", "Chasse au Trésor", "white", "**" .. playerName .. "** trouve : " .. ped.txt2)
                                        TriggerServerEvent("Ora:sendToDiscord", "Event", "" .. playerName.. " trouve : " ..ped.txt2, 16711680)
                                    end
                                elseif ped.txt3 then
                                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                                        local veh = GetVehiclePedIsIn(PlayerPedId())
                                        startRace = false
                                        finishRace = false
                                        -- vector3(-682.95, 5146.1, 119.25)
                                        SetNewWaypoint(-682.95, 5146.1)
                                        DoScreenFadeOut(500)
                                        Wait(1000)
                                        SetPedCoordsKeepVehicle(PlayerPedId(), vector3(496.72, 5592.55, 795.1))
                                        SetEntityHeading(PlayerPedId(), 155.63)
                                        DoScreenFadeIn(500)
                                        Wait(1400)
                                        if Config.Logs then
                                            -- TriggerServerEvent("chasse:server:CreateLog", "chasse", "Chasse au Trésor", "orange", "**" .. playerName.. "** trouve : " ..ped.txt3)
                                            TriggerServerEvent("Ora:sendToDiscord", "Event", "" .. playerName.. " trouve : " ..ped.txt3, 16711680)
                                        end
                                        HintToDisplay(ped.txt3)
                                        SetVehicleEngineOn(veh, false, true, true)
                                        FreezeEntityPosition(veh, true)
                                        Wait(7000)
                                        HintToDisplay('Appuyez sur ~INPUT_PICKUP~ à tout moment pour annuler et retourner sur les hauteurs')
                                        Wait(4000)
                                        HintToDisplay('3 ...')
                                        Wait(1000)
                                        HintToDisplay('2 ...')
                                        Wait(1000)
                                        HintToDisplay('1 ...')
                                        Wait(1000)
                                        SetVehicleEngineOn(veh, true, true, false)
                                        FreezeEntityPosition(veh, false)
                                        -- vector3(500.73, 5576.51, 791.39)
                                        UseParticleFxAssetNextCall("scr_indep_fireworks")
                                        StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", 500.73, 5576.51, 791.39, 0.0, 0.0, 0.0, math.random() * 0.3 + 0.5, false, false, false, false)
                                        -- vector3(479.33, 5584.11, 791.49)
                                        UseParticleFxAssetNextCall("scr_indep_fireworks")
                                        StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", 479.33, 5584.11, 791.49, 0.0, 0.0, 0.0, math.random() * 0.3 + 0.5, false, false, false, false)
                                        PlaySoundFromEntity(-1, "IDLE_BEEP", GetPlayerPed(-1), "EPSILONISM_04_SOUNDSET", 0)
                                        HintToDisplay('GO !!!')
                                        startRace = true
                                    else
                                        HintToDisplay('14e Informateur : "Reviens me voir quand tu seras à bord d`un véhicule tout-terrain"')
                                    end
                                end

                                if ped.anim3 and ped.anim4 then
                                    RequestAnimDict(ped.anim3)
                                    while not HasAnimDictLoaded(ped.anim3) do
                                        Citizen.Wait(100)
                                    end
                                
                                    local netScene4 = CreateSynchronizedScene(ped.coordsnetscene, vector3(0.0, 0.0, ped.heading), 2)
                                    TaskSynchronizedScene(ped.spawedPed, netScene4, ped.anim3, ped.anim4, 1.0, -4.0, 261, 0, 0)
                                    SetSynchronizedSceneLooped(netScene4, 1)
                                    Wait(4000)
                                    ClearPedTasks(ped.spawedPed)
                                    SetEntityInvincible(ped.spawedPed, false)
                                    TaskCombatPed(ped.spawedPed, PlayerPedId(), 200, 200)
                                    SetPedAsCop(ped.spawedPed, true)
                                end

                                if ped.anim5 and ped.anim6 then
                                    RequestAnimDict(ped.anim5)
                                    while not HasAnimDictLoaded(ped.anim5) do
                                        Citizen.Wait(100)
                                    end
                                
                                    local netScene4 = CreateSynchronizedScene(ped.coords.x, ped.coords.y, ped.coords.z, vector3(0.0, 0.0, ped.heading), 2)
                                    TaskSynchronizedScene(ped.spawedPed, netScene4, ped.anim5, ped.anim6, 1.0, -4.0, 261, 0, 0)
                                    SetSynchronizedSceneLooped(netScene4, 1)
                                end

                                if ped.event2 then
                                    Wait(4000)
                                    TriggerEvent(ped.event2)
                                    Wait(3000)
                                    HintToDisplay('19e Informatrice : "... Malheur à toi qui cherche dans la brume ou sans la lune. Reparles moi !"')
                                    countFirework = 4
                                end
                                Wait(7000)
                                visibleText = false
                            end
                        end
                    end 
                end
            end

            local distFinishRace = #(pos - vector3(-682.17, 5146.31, 119.89))
            local distPedRace = #(pos - vector3(2426.96, 5211.0, 58.8))

            if startRace then
                inRange = true
                countRace = countRace - 1
                if countRace >= 1 then
                    if countRace >= 60 then
                        HintToDisplay("1min " .. countRace - 60 .. "s") --  Appuyez sur ~INPUT_PICKUP~ pour annuler.
                    else
                        HintToDisplay(countRace .. "s")
                    end
                    Wait(1000)
                elseif countRace <= 1 then
                    if distPedRace > 50 then
                        HintToDisplay("Vous avez échoué ! Vous allez être transporté sur les hauteurs.")
                        startRace = false
                        countRace = 100
                        Wait(5000)
                        DoScreenFadeOut(500)
                        Wait(1000)
                        SetPedCoordsKeepVehicle(PlayerPedId(), vector3(493.19, 5603.83, 794.21))
                        SetEntityHeading(PlayerPedId(), 215.89)
                        FreezeEntityPosition(PlayerPedId(), true)
                        Wait(1400)
                        FreezeEntityPosition(PlayerPedId(), false)
                        DoScreenFadeIn(500)
                        HintToDisplay("Vous pouvez retenter votre chance.")
                    else
                        HintToDisplay("Échec ! Temps écoulé ! Vous pouvez retenter votre chance.")
                        countRace = 100
                        startRace = false
                    end
                end
            end

            if startRace and distFinishRace < 50 then
                inRange = true
                -- vector3(-682.31, 5155.93, 127.85)
                UseParticleFxAssetNextCall("scr_indep_fireworks")
                StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", -682.31, 5155.93, 127.85, 0.0, 0.0, 0.0, math.random() * 0.3 + 0.5, false, false, false, false)
                -- vector3(-691.16, 5143.52, 127.85)
                UseParticleFxAssetNextCall("scr_indep_fireworks")
                StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", -691.16, 5143.52, 127.85, 0.0, 0.0, 0.0, math.random() * 0.3 + 0.5, false, false, false, false)
                countRace = 0
                HintToDisplay('Terminé ! Bien joué !')
                startRace = false
                countRace = 95
                Wait(5000)
                HintToDisplay('14e Informateur : "SMS : 7 22 / 222 666 88 66 8 777 999 / 222 555 88 22"')
                if Config.Logs then
                    TriggerServerEvent("chasse:server:CreateLog", "chasse", "Course au Trésor", "green", '**' .. playerName .. '** trouve : 14e Informateur : "SMS : 7 22 / 222 666 88 66 8 777 999 / 222 555 88 22"')
                end
                Wait(10000)
                HintToDisplay('Reste proche de l`arrivée pour revoir l`indice')
                Wait(4000)
                finishRace = true
            end

            if finishRace and distFinishRace < 30 then
                inRange = true
                HintToDisplay('14e Informateur : "SMS : 7 22 / 222 666 88 66 8 777 999 / 222 555 88 22"')
            end

            if not inRange then
                Wait(1500)
            end

        -- else
        --     sleep = 5000
        -- end

        Citizen.Wait(sleep)
    end
end)

function HintToDisplay(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, 10000)
end

CreateThread(function()
    while true do

        local sleep2 = 5

        if startRace then

            sleep2 = 5

            if IsControlJustReleased(0, 38) then
                countRace = 0
            end

        else 
            sleep2 = 1500
        end

        Citizen.Wait(sleep2)
    end
end)


---------------- Firework


RegisterNetEvent('chasse:client:UseFirework', function()
    CountFirework()
end)

function CountFirework()
    while true do

        if countFirework > 1 then
            DoFireWork2()
            DoFireWork()
            Wait(math.random(0, 500))
        end
        
        Citizen.Wait(200)
    end
end

function DoFireWork()
    -- vector3(110.22, 1124.05, 255.29)
    local fireworkLoc = {x = 110.22, y = 1124.05, z = 255.29}
    CreateThread(function()
        local randomFirework = math.random(1, 5)
        if randomFirework == 1 then
            UseParticleFxAssetNextCall("scr_indep_fireworks")
            StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", fireworkLoc.x + math.random(3, 10), fireworkLoc.y + math.random(3, 40), fireworkLoc.z + math.random(30, 100), 0.0, 0.0, 0.0, math.random() * 2.3 + 0.5, false, false, false, false)
        elseif randomFirework == 2 then
            UseParticleFxAssetNextCall("scr_indep_fireworks")
            StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trail_spawn", fireworkLoc.x + math.random(3, 10), fireworkLoc.y + math.random(3, 40), fireworkLoc.z + math.random(30, 100), 0.0, 0.0, 0.0, math.random() * 2.3 + 0.5, false, false, false, false)
        elseif randomFirework == 3 then
            UseParticleFxAssetNextCall("proj_indep_firework")
            StartNetworkedParticleFxNonLoopedAtCoord("proj_indep_flare_trail", fireworkLoc.x + math.random(3, 10), fireworkLoc.y + math.random(3, 40), fireworkLoc.z + math.random(30, 100), 0.0, 0.0, 0.0, math.random() * 2.3 + 0.5, false, false, false, false)
        elseif randomFirework == 4 then
            UseParticleFxAssetNextCall("proj_indep_firework_v2")
            StartNetworkedParticleFxNonLoopedAtCoord("scr_xmas_firework_sparkle_spawn", fireworkLoc.x + math.random(3, 10), fireworkLoc.y + math.random(3, 40), fireworkLoc.z + math.random(30, 100), 0.0, 0.0, 0.0, math.random() * 2.3 + 0.5, false, false, false, false)
        elseif randomFirework == 5 then
            UseParticleFxAssetNextCall("proj_xmas_firework")
            StartNetworkedParticleFxNonLoopedAtCoord("scr_firework_xmas_burst_rgw", fireworkLoc.x + math.random(3, 10), fireworkLoc.y + math.random(3, 40), fireworkLoc.z + math.random(30, 100), 0.0, 0.0, 0.0, math.random() * 2.3 + 0.5, false, false, false, false)
        end
        -- vector3(99.74, 1139.91, 258.07)
        UseParticleFxAssetNextCall("scr_indep_fireworks")
        StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", 99.74, 1139.91, 258.07, 0.0, 0.0, 0.0, math.random() * 1.3 + 0.5, false, false, false, false)
        -- vector3(86.94, 1151.73, 262.0)
        UseParticleFxAssetNextCall("scr_indep_fireworks")
        StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", 86.94, 1151.73, 262.0, 0.0, 0.0, 0.0, math.random() * 0.3 + 0.5, false, false, false, false)
        -- vector3(106.57, 1128.58, 256.47)
        UseParticleFxAssetNextCall("scr_indep_fireworks")
        StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", 106.57, 1128.58, 256.47, 0.0, 0.0, 0.0, math.random() * 0.3 + 0.5, false, false, false, false)
    end)
    countFirework = countFirework - 1
end

function DoFireWork2()
    -- vector3(103.56, 1134.85, 257.21)
    fireworkLoc = {x = 103.56, y = 1134.85, z = 257.21}
    CreateThread(function()
        local randomFirework = math.random(1, 5)
        if randomFirework == 1 then
            UseParticleFxAssetNextCall("scr_indep_fireworks")
            StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_shotburst", fireworkLoc.x + math.random(3, 10), fireworkLoc.y + math.random(3, 40), fireworkLoc.z + math.random(30, 100), 0.0, 0.0, 0.0, math.random() * 1.3 + 0.5, false, false, false, false)
        elseif randomFirework == 2 then
            UseParticleFxAssetNextCall("scr_indep_fireworks")
            StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_sparkle_spawn", fireworkLoc.x + math.random(3, 10), fireworkLoc.y + math.random(3, 40), fireworkLoc.z + math.random(30, 100), 0.0, 0.0, 0.0, math.random() * 1.3 + 0.5, false, false, false, false)
        elseif randomFirework == 3 then
            UseParticleFxAssetNextCall("proj_indep_firework")
            StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_air_burst", fireworkLoc.x + math.random(3, 10), fireworkLoc.y + math.random(3, 40), fireworkLoc.z + math.random(30, 100), 0.0, 0.0, 0.0, math.random() * 1.3 + 0.5, false, false, false, false)
        elseif randomFirework == 4 then
            UseParticleFxAssetNextCall("proj_indep_firework_v2")
            StartNetworkedParticleFxNonLoopedAtCoord("scr_firework_indep_burst_rwb", fireworkLoc.x + math.random(3, 10), fireworkLoc.y + math.random(3, 40), fireworkLoc.z + math.random(30, 100), 0.0, 0.0, 0.0, math.random() * 1.3 + 0.5, false, false, false, false)
        elseif randomFirework == 5 then
            UseParticleFxAssetNextCall("proj_xmas_firework")
            StartNetworkedParticleFxNonLoopedAtCoord("scr_firework_xmas_spiral_burst_rgw", fireworkLoc.x + math.random(3, 10), fireworkLoc.y + math.random(3, 40), fireworkLoc.z + math.random(30, 100), 0.0, 0.0, 0.0, math.random() * 1.3 + 0.5, false, false, false, false)
        end
        -- vector3(340.53, 1165.82, 220.71)
        UseParticleFxAssetNextCall("scr_indep_fireworks")
        StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", 340.53, 1165.82, 220.71, 0.0, 0.0, 0.0, math.random() * 0.3 + 0.5, false, false, false, false)
    end)
end