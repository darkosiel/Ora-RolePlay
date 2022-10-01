CreateThread(function()
    while true do
        
        local visibleText = false
        local inRange = false
        local sleep = 5

        if true then

            for key, ped in pairs(Config.Peds) do
                local pos = GetEntityCoords(PlayerPedId())
                local dist = #(pos - ped.coords)
                RequestModel(ped.model)
                while not HasModelLoaded(ped.model) do
                    print('loading model')
                    Wait(10)
                end
                
                if dist < 70 then
                    if not DoesEntityExist(ped.spawedPed) then
                        ped.spawedPed = CreatePed(26, ped.model, ped.coords.x, ped.coords.y, ped.coords.z, false, false)
                        SetEntityHeading(ped.spawedPed, ped.heading)
                        SetEntityInvincible(ped.spawedPed, true)
                        SetBlockingOfNonTemporaryEvents(ped.spawedPed, true)

                        RequestAnimDict(ped.anim)
                        while not HasAnimDictLoaded(ped.anim) do
                        Citizen.Wait(100)
                        end
                    
                        local netScene4 = CreateSynchronizedScene(ped.coords.x, ped.coords.y, ped.coords.z, vector3(0.0, 0.0, ped.heading), 2)
                        TaskSynchronizedScene(ped.spawedPed, netScene4, ped.anim, ped.anim2, 1.0, -4.0, 261, 0, 0)
                        SetSynchronizedSceneLooped(netScene4, 1)
                    end
                    if dist < 3 then
                        inRange = true
                        if dist < 1.5 then
                            if not visibleText then
                                HintToDisplay("Appuyez sur ~INPUT_PICKUP~ pour interagir.")
                                if IsControlJustReleased(0, 38) then
                                    visibleText = true
                                end
                            end
                            if visibleText then
                                HintToDisplay(ped.txt)
                                -- Logs discord LS Event
                                local fullName 
                                exports["Ora"]:TriggerServerCallback("Ora::SE::Identity:GetMyIdentity", function(data)
                                    fullName = data.first_name .. " " .. data.last_name
                                    TriggerServerEvent("chasse:server:CreateLog", "chasse", "Chasse au Trésor", "green", "**" .. fullName .. "** trouve (#".. key ..") : " .. ped.txt)
                                end)
                                Wait(7000)
                                visibleText = false
                            end
                        end
                    end 
                end
            end

            if not inRange then
                Wait(1500)
            end

        -- else
        --     sleep = 5000
        end

        Citizen.Wait(sleep)
    end
end)

function HintToDisplay(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, 10000)
end