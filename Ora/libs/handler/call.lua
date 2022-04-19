local callActive = false
local haveTarget = false
local isCall = false
local ttak2 = false
local work = {}
local target = {}
ShowAdvancedNotification = function(title, subject, msg, icon, iconType)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(msg)
    SetNotificationMessage(icon, icon, false, iconType, title, subject)
    DrawNotification(false, false)
end
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            -- if IsControlJustPressed(1, 56) then
            --     local plyPos = GetEntityCoords(LocalPlayer().Ped, true)
            --     TriggerServerEvent("call:makeCall", "uber", {x=plyPos.x,y=plyPos.y,z=plyPos.z})
            -- end

            if IsControlJustPressed(1, 246) and callActive then
                if isCall == false then
                    if work == "uber" then
                        TriggerServerCallback('Ora:call:uber:isTaken', function(taken)
                            if taken then
                                SendNotification("~r~L'appel a déjà été prit par un autre chauffeur Uber.")
                            else
                                TriggerServerEvent("call:getCall", work, ttak2)
                                SendNotification("~b~Vous avez pris l'appel !")
                                if (target.pos ~= nil) then
                                    target.blip = AddBlipForCoord(target.pos.x, target.pos.y, target.pos.z)
                                    SetBlipRoute(target.blip, true)
                                    haveTarget = true
                                else
                                    SendNotification("~b~Il n'y a pas de position indiquée, fiez vous aux informations du central")
                                    haveTarget = false
                                end
                                isCall = true
                                callActive = false
                            end
                        end)
                    else
                        TriggerServerEvent("call:getCall", work, ttak2)
                        SendNotification("~b~Vous avez pris l'appel !")
                        if (target.pos ~= nil) then
                            target.blip = AddBlipForCoord(target.pos.x, target.pos.y, target.pos.z)
                            SetBlipRoute(target.blip, true)
                            haveTarget = true
                        else
                            SendNotification("~b~Il n'y a pas de position indiquée, fiez vous aux informations du central")
                            haveTarget = false
                        end
                        isCall = true
                        callActive = false
                    end
                else
                    SendNotification("~r~Vous avez déjà un appel en cours !")
                end
            elseif IsControlJustPressed(1, 303) and callActive then
                if work == "uber" then
                    TriggerServerCallback('Ora:call:uber:isTaken', function(taken)
                        if taken then
                            SendNotification("~r~L'appel a déjà été prit par un autre chauffeur Uber.")
                        else
                            SendNotification("~o~Vous avez remplacé l'appel.")
                            RemoveBlip(target.blip)
                            haveTarget = false
                            isCall = false
                            callActive = false

                            TriggerServerEvent("call:getCall", work, ttak2)
                            SendNotification("~b~Vous avez pris l'appel !")
                            if (target.pos ~= nil) then
                                target.blip = AddBlipForCoord(target.pos.x, target.pos.y, target.pos.z)
                                SetBlipRoute(target.blip, true)
                                haveTarget = true
                            else
                                SendNotification("~b~Il n'y a pas de position indiquée, fiez vous aux informations du central")
                                haveTarget = false
                            end
                            isCall = true
                            callActive = false
                        end
                    end)
                else
                    SendNotification("~o~Vous avez remplacé l'appel.")
                    RemoveBlip(target.blip)
                    haveTarget = false
                    isCall = false
                    callActive = false

                    TriggerServerEvent("call:getCall", work, ttak2)
                    SendNotification("~b~Vous avez pris l'appel !")
                    if (target.pos ~= nil) then
                        target.blip = AddBlipForCoord(target.pos.x, target.pos.y, target.pos.z)
                        SetBlipRoute(target.blip, true)
                        haveTarget = true
                    else
                        SendNotification("~b~Il n'y a pas de position indiquée, fiez vous aux informations du central")
                        haveTarget = false
                    end
                    isCall = true
                    callActive = false
                end
            elseif IsControlJustPressed(1, 83) and callActive then
                SendNotification("~r~Vous avez refusé l'appel.")
                callActive = false
            end
            if haveTarget then
                DrawMarker(
                    1,
                    target.pos.x,
                    target.pos.y,
                    target.pos.z - 1,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    2.001,
                    2.0001,
                    0.5001,
                    255,
                    255,
                    0,
                    200,
                    0,
                    0,
                    0,
                    0
                )
                local playerPos = GetEntityCoords(LocalPlayer().Ped, true)
                if
                    GetDistanceBetweenCoords(
                        target.pos.x,
                        target.pos.y,
                        target.pos.z,
                        playerPos.x,
                        playerPos.y,
                        playerPos.z,
                        false
                    ) < 2.0
                 then
                    RemoveBlip(target.blip)
                    haveTarget = false
                    isCall = false
                end
            end
        end
    end
)

RegisterNetEvent("call:cancelCall")
AddEventHandler(
    "call:cancelCall",
    function()
        if haveTarget then
            RemoveBlip(target.blip)
            haveTarget = false
            isCall = false
        else
            TriggerEvent("itinerance:notif", "~r~Vous n'avez aucun appel en cours !")
        end
    end
)

RegisterNetEvent("call:callIncoming2")
AddEventHandler(
    "call:callIncoming2",
    function(job, pos, msg, author)
        --(job, pos, msg)

        callActive = true
        work = job
        target.pos = pos
        coords = LocalPlayer().Pos

        dist = "*x*"
        streetname = "Non indiquée"

        if pos ~= nil then
            dist =
                CalculateTravelDistanceBetweenPoints(
                coords.x,
                coords.y,
                coords.z,
                target.pos.x,
                target.pos.y,
                target.pos.z
            )
            zone = GetZoneLabelTextFromZoneCode(GetNameOfZone(target.pos.x, target.pos.y, target.pos.z))
            streetname =
                GetStreetNameFromHashKey(GetStreetNameAtCoord(target.pos.x, target.pos.y, target.pos.z))
        end

        if work == "police" then
            --SendNotification("Appuyez sur ~g~Y~s~ pour prendre l'appel ou ~g~L~s~ pour le refuser")
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 911",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_LSPD",
                1
            )
        elseif work == "lssd" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 911",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_LSSD",
                1
            )
        elseif work == "mecano" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 907",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_BENNYS",
                1
            )
        elseif work == "mecano2" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 907",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_BEEKERS",
                1
            )
        elseif work == "chauffeur" then
            --SendNotification("Appuyez sur ~g~Y~s~ pour prendre l'appel ou ~g~L~s~ pour le refuser")
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 906",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_CALL911",
                1
            )
        elseif work == "lsms" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 912",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_CALL911",
                1
            )
        elseif work == "fib" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_FIB",
                1
            )
        elseif work == "pilot" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "epicerie" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "brinks" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "army" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "realestateagent" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "caroccasions" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "uber" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel client",
                "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. "",
                "CHAR_UBER",
                1
            )
        elseif work == "unicorn" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 902",
                "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. "",
                "CHAR_CALL911",
                1
            )
        elseif work == "journaliste" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 900",
                "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. "",
                "CHAR_CALL911",
                1
            )
        elseif work == "state" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        else
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel",
                "~b~Localisation: ~s~" .. streetname .. "",
                "CHAR_CALL911",
                1
            )
        end

        SendNotification("~b~Détails:~s~ " .. msg)
        SendNotification(
            "Appuyez sur ~b~Y~s~ pour prendre l'appel ou ~o~U~s~ pour remplacer l'appel ~r~=~s~ pour le refuser"
        )
        ttak2 = true
    end
)
RegisterNetEvent("call:callIncoming")
AddEventHandler(
    "call:callIncoming",
    function(job, pos, msg)
        --(job, pos, msg)

        callActive = true
        work = job
        target.pos = pos

        coords = LocalPlayer().Pos
        zone = GetZoneLabelTextFromZoneCode(GetNameOfZone(target.pos.x, target.pos.y, target.pos.z))
        dist =
            CalculateTravelDistanceBetweenPoints(coords.x, coords.y, coords.z, target.pos.x, target.pos.y, target.pos.z)
        streetname =
            GetStreetNameFromHashKey(GetStreetNameAtCoord(target.pos.x, target.pos.y, target.pos.z))

        if work == "police" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 911",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_LSPD",
                1
            )
        elseif work == "lssd" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 911",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_LSSD",
                1
            )
        elseif work == "mecano" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 907",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_BENNYS",
                1
            )
        elseif work == "mecano2" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 907",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_BEEKERS",
                1
            )
        elseif work == "chauffeur" then
            --SendNotification("Appuyez sur ~g~Y~s~ pour prendre l'appel ou ~g~L~s~ pour le refuser")
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 906",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_CALL911",
                1
            )
        elseif work == "lsms" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 912",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_CALL911",
                1
            )
        elseif work == "fib" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel",
                string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname),
                "CHAR_FIB",
                1
            )
        elseif work == "pilot" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "epicerie" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "brinks" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "army" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "realestateagent" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "caroccasions" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        elseif work == "uber" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel client",
                "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. "",
                "CHAR_UBER",
                1
            )
        elseif work == "unicorn" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 902",
                "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. "",
                "CHAR_CALL911",
                1
            )
        elseif work == "journaliste" then
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel d'urgence: 900",
                "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. "",
                "CHAR_CALL911",
                1
            )
        elseif work == "state" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(msg))
        else
            ShowAdvancedNotification(
                "Centrale",
                "~b~Appel",
                "~b~Localisation: ~s~" .. streetname .. "",
                "CHAR_DEFAULT",
                1
            )
        end

        SendNotification("~b~Détails:~s~ " .. msg)
        SendNotification(
            "Appuyez sur ~b~Y~s~ pour prendre l'appel ou ~o~U~s~ pour remplacer l'appel ~r~=~s~ pour le refuser"
        )
        ttak2 = false
    end
)

RegisterNetEvent("call:taken")
AddEventHandler(
    "call:taken",
    function(a)
        -- callActive = false
        SendNotification("~b~L'appel a été pris par " .. a)
    end
)

RegisterNetEvent("target:call:taken")
AddEventHandler(
    "target:call:taken",
    function(taken)
        if taken == 1 then
            SendNotification("~b~Quelqu'un est en route !")
        else
            ShowNotification("~r~Personne n'est apte à prendre votre message.")
        end
    end
)

function SendNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, false)
end
