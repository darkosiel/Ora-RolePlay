function StartpegasusMission(param)
    local positionStartRandomness = Random(#pegasus["startMission"])
    if positionStartRandomness == 0 then
        positionStartRandomness = 1
    end

    local positionStart = pegasus["startMission"][positionStartRandomness]

    local coords = {
        x = positionStart.pos.x,
        y = positionStart.pos.y,
        z = positionStart.pos.z
    }

    currentMission.finished = false
    currentMission.participant = {GetPlayerServerId(PlayerId())}
    currentMission.id = GetGameTimer()
    currentMission.blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    ShowAdvancedNotification(
        "Centrale",
        "~b~Dialogue",
        "~g~~h~Des clients attendent un Chaffeur~h~~w~\n\n~o~Va les récupérer !~w~",
        "CHAR_LESTER",
        1
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
    local spawnedVehicle = GetVehiclePedIsIn(LocalPlayer().Ped, false)
    local startFinishMission = false
    local endPosition = nil

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            playerCoords = LocalPlayer().Pos
            local distanceBetweenCoords = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, coords.x, coords.y, coords.z, false)
            startDropOff = true

            if (startDropOff == true) then
                if (currentDropOffPoint == nil) then
                    currentDropOffIndex = currentDropOffIndex + 1
                    if (currentDropOffIndex <= #pegasus.DropOff) then 
                        dropOffPointItems = #pegasus.DropOff[currentDropOffIndex]
                        currentDropOffPoint = pegasus.DropOff[currentDropOffIndex][math.random(1, dropOffPointItems)]
                        if (currentMission.blip ~= nil) then
                            RemoveBlip(currentMission.blip)
                        end
                        currentMission.blip = AddBlipForCoord(currentDropOffPoint.pos.x, currentDropOffPoint.pos.y, currentDropOffPoint.pos.z)
                        SetBlipRoute(currentMission.blip, true)

                        ShowAdvancedNotification(
                            "Client",
                            "~b~Dialogue",
                            "~g~~h~Hey~h~~w~\n\n~o~Dépose moi à l'adresse indiquée.~w~",
                            "CHAR_LESTER",
                            1
                        )
                    else
                        if (currentMission.blip ~= nil) then
                            RemoveBlip(currentMission.blip)
                        end
                        local endPosCount = #pegasus.endMission
                        endPosition = pegasus.endMission[math.random(1, endPosCount)]
                        currentMission.blip = AddBlipForCoord(endPosition.pos.x, endPosition.pos.y, endPosition.pos.z)
                        SetBlipRoute(currentMission.blip, true)
                        
                        ShowAdvancedNotification(
                            "Centrale",
                            "~b~Dialogue",
                            "~g~~h~Super~h~~w~\n\n~o~Tout les clients sont arrivés à bon port!.~w~",
                            "CHAR_LESTER",
                            1
                        )
                        startDropOff = false
                        startFinishMission = true
                    end
                else
                    if (GetDistanceBetweenCoords(GetEntityCoords(GetVehiclePedIsIn(LocalPlayer().Ped, false)).x, GetEntityCoords(GetVehiclePedIsIn(LocalPlayer().Ped, false)).y, GetEntityCoords(GetVehiclePedIsIn(LocalPlayer().Ped, false)).z, currentDropOffPoint.pos.x, currentDropOffPoint.pos.y, currentDropOffPoint.pos.z, true) <= 10.0) then
                        ShowAdvancedNotification(
                            "Client",
                            "~b~Dialogue",
                            "~g~~h~Je descends, j'ai payé ton patron.~h~~w~",
                            "CHAR_LESTER",
                            1
                        )

                        TriggerServerEvent("business:SetProductivity", GetPlayerServerId(PlayerId()), "pegasus", 250, true)
                        TriggerServerEvent("entreprise:Add", "pegasus", 250)

                        SetVehicleUndriveable(GetVehiclePedIsIn(LocalPlayer().Ped, false), true)
                        FreezeEntityPosition(GetVehiclePedIsIn(LocalPlayer().Ped, false), true)
                        Citizen.Wait(1000)
                        SetVehicleDoorOpen(GetVehiclePedIsIn(LocalPlayer().Ped, false), 3, false, false)
                        
                        if (passenger ~= nil) then
                            math.randomseed(GetGameTimer())
                            local chancePedLeave = math.random(1, 100)
                            math.randomseed(GetGameTimer())
                            local r = math.random(90, 110)

                            if (chancePedLeave >= 80) then
                                ShowAdvancedNotification(
                                    "Client",
                                    "~b~Dialogue",
                                    "~r~~h~Tu roules commme une merde !! | Pète lui la gueule pour obtenir l'argent. Tu as 60 secondes~h~~w~",
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
                                        "Centrale",
                                        "~b~Dialogue",
                                        "~g~~h~Tu as réussi à le rattraper. Tu reçois 300 $.~h~~w~",
                                        "CHAR_LESTER",
                                        1
                                    )

                                    TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = passenger, network_id = NetworkGetNetworkIdFromEntity(passenger), seconds = 30})

                                else
                                    ShowAdvancedNotification(
                                        "Centrale",
                                        "~b~Dialogue",
                                        "~r~~h~Le client a fui ... tu as perdu " .. r .. "$.~h~~w~",
                                        "CHAR_LESTER",
                                        1
                                    )
                                
                                    TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = passenger, network_id = NetworkGetNetworkIdFromEntity(passenger), seconds = 30})
                                end

                                if (oldPassenger ~= nil) then 
                                    TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = oldPassenger, network_id = NetworkGetNetworkIdFromEntity(oldPassenger), seconds = 30})
                                    oldPassenger = nil
                                end
                            else
                                ShowAdvancedNotification(
                                    "Client",
                                    "~b~Dialogue",
                                    "~g~~h~J'ai payé votre patron. Ciao' $.~h~~w~",
                                    "CHAR_LESTER",
                                    1
                                )
                                TaskLeaveVehicle(passenger)
                                TaskWanderStandard(passenger, 10.0, 10)
                                TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = passenger, network_id = NetworkGetNetworkIdFromEntity(passenger), seconds = 30})

                                if (oldPassenger ~= nil) then
                                    TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = oldPassenger, network_id = NetworkGetNetworkIdFromEntity(oldPassenger), seconds = 30})
                                    oldPassenger = nil
                                end
                            end

                            if (GetVehiclePedIsIn(LocalPlayer().Ped, false) ~= nil and currentDropOffIndex < #pegasus.DropOff) then 
                                math.randomseed(GetGameTimer() * math.random(10000, 50000))
                                local clientModel = "s_f_y_hooker_03"
                                local vehicleLocation = GetEntityCoords(GetVehiclePedIsIn(LocalPlayer().Ped, false))
                                oldPassenger = passenger
                                passenger = Ora.World.Ped:CreatePedInsideVehicle(GetVehiclePedIsIn(LocalPlayer().Ped, false), 5, GetHashKey("s_f_y_hooker_03"), 2, true, true)
                            end
                        end

                        Citizen.Wait(2000)
                        SetVehicleDoorShut(GetVehiclePedIsIn(LocalPlayer().Ped, false), 3, false, false)
                        SetVehicleUndriveable(GetVehiclePedIsIn(LocalPlayer().Ped, false), false)
                        FreezeEntityPosition(GetVehiclePedIsIn(LocalPlayer().Ped, false), false)
                        currentDropOffPoint = nil
                    end
                end
            end

            if (startFinishMission == true) then
                if (GetDistanceBetweenCoords(GetEntityCoords(GetVehiclePedIsIn(LocalPlayer().Ped, false)).x, GetEntityCoords(GetVehiclePedIsIn(LocalPlayer().Ped, false)).y, GetEntityCoords(GetVehiclePedIsIn(LocalPlayer().Ped, false)).z, endPosition.pos.x, endPosition.pos.y, endPosition.pos.z, true) <= 10.0) then
                    ShowAdvancedNotification(
                        "Centrale",
                        "~b~Dialogue",
                        "~g~~h~Merci pour ton bon boulot. Ta mission est terminée.~h~~w~",
                        "CHAR_LESTER",
                        1
                    )

                    RemoveBlip(currentMission.blip)
                    SetFarmLimit(100)

                    local truckLaunched = false
                    local currentPath = 1
                    local startDropOff = false
                    local currentDropOffPoint = nil
                    local isInDelivery = false
                    local currentDropOffIndex = 0
                    local passenger = nil
                    local oldPassenger = nil
                    local spawnedVehicle = GetVehiclePedIsIn(LocalPlayer().Ped, false)
                    local startFinishMission = false
                    local endPosition = nil
                    break
                end
            end
        end
    end)
end