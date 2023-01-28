local callActive = false
local haveTarget = false
local ttak2 = false
local work = {}
local target = {}

PreviousCalls = {}

function AddLongString(txt)
    AddTextComponentSubstringPlayerName(txt)
    if string.len(txt) > 99 then
        for i = 100, string.len(txt), 99 do
            AddTextComponentSubstringPlayerName(string.sub(txt, i, i + 99))
        end
    end
end

ShowAdvancedNotification = function(title, subject, msg, icon, iconType)
    BeginTextCommandThefeedPost("jamyfafi")
    AddLongString(msg)
    SetNotificationMessage(icon, icon, false, iconType, title, subject)
    EndTextCommandThefeedPostTicker(true, false)
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
            --[[if isCall == false then
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
                        callActive = false
                    end
                else
                    SendNotification("~r~Vous avez déjà un appel en cours !")
                end
            elseif IsControlJustPressed(1, 303) and callActive then]]
                if work == "uber" then
                    TriggerServerCallback('Ora:call:uber:isTaken', function(taken)
                        if taken then
                            SendNotification("~r~L'appel a déjà été prit par un autre chauffeur Uber.")
                        else
                            --SendNotification("~o~Vous avez remplacé l'appel.")
                            RemoveBlip(target.blip)
                            haveTarget = false
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
                            callActive = false
                        end
                    end)
                else
                    --SendNotification("~o~Vous avez remplacé l'appel.")
                    RemoveBlip(target.blip)
                    haveTarget = false
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
        else
            TriggerEvent("itinerance:notif", "~r~Vous n'avez aucun appel en cours !")
        end
    end
)

RegisterNetEvent("call:callIncoming2")
AddEventHandler(
    "call:callIncoming2",
    function(job, pos, message, author)
        --(job, pos, message)

        callActive = true
        work = job
        target.pos = pos
        local coords = LocalPlayer().Pos

        local dist = "*x*"
        local streetname = "Non indiquée"
        local zone = ""

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

        local title, subject, msg, icon, iconType = "", "", "", "", 1

        if work == "police" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 911"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_lspd"
            iconType = 1
        elseif work == "lssd" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 911"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_LSSD"
            iconType = 1
        elseif work == "mecano" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 907"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_BENNYS"
            iconType = 1
        elseif work == "mecano2" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 907"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_BEEKERS"
            iconType = 1
        elseif work == "chauffeur" then
            --SendNotification("Appuyez sur ~g~Y~s~ pour prendre l'appel ou ~g~L~s~ pour le refuser")
            title = "Centrale"
            subject = "~b~Appel d'urgence: 906"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_CALL911"
            iconType = 1
        elseif work == "lsms" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 911"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_CALL911"
            iconType = 1
        elseif work == "fib" then
            title = "Centrale"
            subject = "~b~Appel"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_FIB"
            iconType = 1
        elseif work == "pilot" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "epicerie" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "brinks" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "army" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "realestateagent" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "caroccasions" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "uber" then
            title = "Centrale"
            subject = "~b~Appel client"
            msg = "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. ""
            icon = "CHAR_UBER"
            iconType = 1
        elseif work == "unicorn" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 902"
            msg =  "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. ""
            icon = "CHAR_CALL911"
            iconType = 1
        elseif work == "journaliste" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 900"
            msg =  "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. ""
            icon = "CHAR_CALL911"
            iconType = 1
        elseif work == "state" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "lsfd" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 911"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_LSFD"
            iconType = 1        
        else
            title = "Centrale"
            subject = "~b~Appel"
            msg = "~b~Localisation: ~s~" .. streetname .. ""
            icon = "CHAR_DEFAULT"
            iconType = 1
        end

        msg = msg .. "\n~b~Détails:~s~ " .. message
        if title ~= "" then
            ShowAdvancedNotification(title, subject, msg, icon, iconType)
        end

        SendNotification(
            "Appuyer sur ~b~Y~s~ pour prendre l'appel / ~r~=~s~ pour le refuser"    
            --"Appuyez sur ~b~Y~s~ pour prendre l'appel ou ~o~U~s~ pour remplacer l'appel ~r~=~s~ pour le refuser"
        )
        ttak2 = true

        PreviousCalls = PreviousCalls or {}

        local function MeasureStringWidth(str, font, scale)
            BeginTextCommandWidth("CELL_EMAIL_BCON")
            AddTextComponentSubstringPlayerName(str)
            SetTextFont(font or 0)
            SetTextScale(1.0, scale or 0)
            return EndTextCommandGetWidth(true) * 1920
        end

        -- Get lenght of message and cut it if too long
        local displayedMessage = message
        -- remove any "\n" from the message
        displayedMessage = string.gsub(displayedMessage, "\n", "")
        local _, _, _, h, m, s = GetUtcTime()
        local time = string.format("%02d:%02d:%02d", h, m, s)
        local messageLength = MeasureStringWidth((displayedMessage.."...  " .. time), 0, 0.35)
        repeat
            displayedMessage = string.sub(displayedMessage, 0, -2)
            messageLength = MeasureStringWidth((displayedMessage.."...  " .. time), 0, 0.35)
        until messageLength < 431+100
        --Clear space at the end of the message
        displayedMessage = string.gsub(displayedMessage, "%s+$", "")
        displayedMessage = displayedMessage .. "..."

        table.insert(
            PreviousCalls,
            {
                job = job,
                pos = pos,
                message = message:gsub("\n", ""),
                displayedMessage = displayedMessage,
                streetname = streetname,
                time = time,
                notif = {
                    title = title, 
                    subject = subject, 
                    msg = msg, 
                    icon = icon, 
                    iconType = iconType
                }
            }
        )
    end
)

RegisterNetEvent("call:callIncoming")
AddEventHandler(
    "call:callIncoming",
    function(job, pos, message)
        --(job, pos, message)

        callActive = true
        work = job
        target.pos = pos

        local coords = LocalPlayer().Pos
        local zone = GetZoneLabelTextFromZoneCode(GetNameOfZone(target.pos.x, target.pos.y, target.pos.z))
        local dist = CalculateTravelDistanceBetweenPoints(coords.x, coords.y, coords.z, target.pos.x, target.pos.y, target.pos.z)
        local streetname = GetStreetNameFromHashKey(GetStreetNameAtCoord(target.pos.x, target.pos.y, target.pos.z))

        local title, subject, msg, icon, iconType = "", "", "", "", 1

        if work == "police" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 911"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_lspd"
            iconType = 1
        elseif work == "lssd" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 911"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_LSSD"
            iconType = 1
        elseif work == "mecano" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 907"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_BENNYS"
            iconType = 1
        elseif work == "mecano2" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 907"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_BEEKERS"
            iconType = 1
        elseif work == "chauffeur" then
            --SendNotification("Appuyez sur ~g~Y~s~ pour prendre l'appel ou ~g~L~s~ pour le refuser")
            title = "Centrale"
            subject = "~b~Appel d'urgence: 906"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_CALL911"
            iconType = 1
        elseif work == "lsms" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 911"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_CALL911"
            iconType = 1
        elseif work == "fib" then
            title = "Centrale"
            subject = "~b~Appel"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_FIB"
            iconType = 1
        elseif work == "pilot" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "epicerie" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "brinks" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "army" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "realestateagent" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "caroccasions" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "uber" then
            title = "Centrale"
            subject = "~b~Appel client"
            msg = "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. ""
            icon = "CHAR_UBER"
            iconType = 1
        elseif work == "unicorn" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 902"
            msg =  "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. ""
            icon = "CHAR_CALL911"
            iconType = 1
        elseif work == "journaliste" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 900"
            msg =  "~b~Identité: ~s~Inconnu\n~b~Localisation: ~s~" .. streetname .. ""
            icon = "CHAR_CALL911"
            iconType = 1
        elseif work == "state" then
            SendNotification("~r~APPEL EN COURS:~w~ " .. tostring(message))
        elseif work == "lsfd" then
            title = "Centrale"
            subject = "~b~Appel d'urgence: 911"
            msg = string.format("~b~Distance: (~s~%sm~b~)\nLocalisation: ~s~%s - %s\n", math.ceil(dist), zone, streetname)
            icon = "CHAR_LSFD"
            iconType = 1        
        else
            title = "Centrale"
            subject = "~b~Appel"
            msg = "~b~Localisation: ~s~" .. streetname .. ""
            icon = "CHAR_DEFAULT"
            iconType = 1
        end

        msg = msg .. "\n~b~Détails:~s~ " .. message
        if title ~= "" then
            ShowAdvancedNotification(title, subject, msg, icon, iconType)
        end

        SendNotification(
            "Appuyer sur ~b~Y~s~ pour prendre l'appel / ~r~=~s~ pour le refuser"    
            --"Appuyez sur ~b~Y~s~ pour prendre l'appel ou ~o~U~s~ pour remplacer l'appel ~r~=~s~ pour le refuser"
        )
        ttak2 = false

        PreviousCalls = PreviousCalls or {}

        local function MeasureStringWidth(str, font, scale)
            BeginTextCommandWidth("CELL_EMAIL_BCON")
            AddTextComponentSubstringPlayerName(str)
            SetTextFont(font or 0)
            SetTextScale(1.0, scale or 0)
            return EndTextCommandGetWidth(true) * 1920
        end

        -- Get lenght of message and cut it if too long
        local displayedMessage = message
        -- remove any "\n" from the message
        displayedMessage = string.gsub(displayedMessage, "\n", "")
        local _, _, _, h, m, s = GetUtcTime()
        local time = string.format("%02d:%02d:%02d", h, m, s)
        local messageLength = MeasureStringWidth((displayedMessage.."...  " .. time), 0, 0.35)
        repeat
            displayedMessage = string.sub(displayedMessage, 0, -2)
            messageLength = MeasureStringWidth((displayedMessage.."...  " .. time), 0, 0.35)
        until messageLength < 431+100
        --Clear space at the end of the message
        displayedMessage = string.gsub(displayedMessage, "%s+$", "")
        displayedMessage = displayedMessage .. "..."

        table.insert(
            PreviousCalls,
            {
                job = job,
                pos = pos,
                --message = message,
                displayedMessage = displayedMessage,
                streetname = streetname,
                time = time,
                notif = {
                    title = title, 
                    subject = subject, 
                    msg = msg, 
                    icon = icon, 
                    iconType = iconType
                }
            }
        )
    end
)

Citizen.CreateThread(function()
    repeat Wait(0) until RMenu ~= nil
    print("RMenu loaded")
    RMenu.Add("personnal", "settings_call_history", RageUI.CreateSubMenu(RMenu:Get("personnal", "settings"), "Historique des appels", "Historique des appels"))

    RegisterCommand("appels", function()
        RageUI.Visible(RMenu:Get("personnal", "settings_call_history"), not RageUI.Visible(RMenu:Get("personnal", "settings_call_history")))
    end, false)

    Citizen.CreateThread(function() while true do Wait(1.0)
        if RageUI.Visible(RMenu:Get("personnal", "settings_call_history")) then
            RageUI.DrawContent({header = true, glare = true},function()
                if #PreviousCalls > 0 then
                    for k, call in pairs(PreviousCalls) do
                        RageUI.Button(call.displayedMessage, ("~b~Détails:~s~ %s\n~b~Localisation:~s~ %s"):format(call.message, call.streetname), {RightLabel = call.time}, true, function(_, _, s)
                            if s then
                                
                                ShowAdvancedNotification(call.notif.title, call.notif.subject, call.notif.msg, call.notif.icon, call.notif.iconType)

                                if call.job == "uber" then
                                    --SendNotification("~o~Vous avez remplacé l'appel.")
                                    RemoveBlip(target.blip)
                                    haveTarget = false
                                    callActive = false

                                    if (call.pos ~= nil) then
                                        call.blip = AddBlipForCoord(call.pos.x, call.pos.y, call.pos.z)
                                        SetBlipRoute(call.blip, true)
                                        haveTarget = true
                                    else
                                        SendNotification("~b~Il n'y a pas de position indiquée, fiez vous aux informations du central")
                                        haveTarget = false
                                    end
                                    callActive = false
                                    SendNotification("~b~Vous avez pris l'appel !\nAttention, quelqu'un a peut être déjà répondu à cet appel.")
                                else
                                    RemoveBlip(target.blip)
                                    haveTarget = false
                                    callActive = false
                
                                    SendNotification("~b~Vous avez pris l'appel !")
                                    if (call.pos ~= nil) then
                                        call.blip = AddBlipForCoord(call.pos.x, call.pos.y, call.pos.z)
                                        SetBlipRoute(call.blip, true)
                                        haveTarget = true
                                    else
                                        SendNotification("~b~Il n'y a pas de position indiquée, fiez vous aux informations du central")
                                        haveTarget = false
                                    end
                                    target = call
                                    callActive = false
                                end

                            end
                        end)
                    end
                else
                    RageUI.Button("Aucun appel", nil, {}, false, function(_, _, s) end)
                end
            end)

        end
    end end)
end)
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
