RegisterNetEvent("Ora::CE::General:Snap")
AddEventHandler(
    "Ora::CE::General:Snap",
    function(eventData)
        if GetResourceState("screenshot-basic") == "started" then
            exports["screenshot-basic"]:requestScreenshotUpload(
                "https://pictures.orarp.com/upload.php",
                "anticheat",
                function(data)
                    local resp = json.decode(data)
                    if (resp ~= nil) then
                        TriggerServerEvent(eventData.SERVER_EVENT, {TOKEN = eventData.TOKEN, PICTURE_URL = resp.url})
                    end
                end
            )
        else
            TriggerServerEvent("Ora::SE::Anticheat:ResourceStopped", "screenshot-basic")
        end
    end
)

function Ora.Anticheat:Initialize()
    if (not self:IsAnticheatWhitelist()) then
        self:Debug(string.format("^5%s^3 is not whitelist for Anticheat", GetPlayerServerId(PlayerId())))
        local tempTime = GetGameTimer() + 60000
        Citizen.CreateThread(function()
            local playerServerId = GetPlayerServerId(PlayerId())
            local playerId = PlayerId()
            local myPed = LocalPlayer().Ped
    
            while true do
                Citizen.Wait(4000)
                local fullname = Ora.Identity:GetFullname(playerServerId)
                if (Citizen.InvokeNative(0x048746E388762E11, Citizen.ReturnResultAnyway())) then
                    Ora.Anticheat:ReportCheat("error", string.format("[CHEAT] | le joueur %s | %s est en mode spectateur", playerServerId,fullname), true)
                end
    
                if GetPlayerVehicleDamageModifier(playerId) then
                    SetPlayerVehicleDamageModifier(playerId, 1.0)
                end
    
                for allGamerTagsIds = 0, 256, 16 do
                    if IsMpGamerTagActive(allGamerTagsIds) then
                        Ora.Anticheat:ReportCheat("error", string.format("[CHEAT] | le joueur %s | %s a le nom des joueurs IG", playerServerId, fullname), true)
                        break
                    end
                end
    
                if self.Alert.BLIPS then
                    local aroundPlayers = GetActivePlayers()
                    for index, value in pairs(aroundPlayers) do
                        local playerPed = GetPlayerPed(value)
                        if playerPed ~= myPed then
                            local blipFromEntity = GetBlipFromEntity(playerPed)
                            if blipFromEntity and DoesBlipExist(blipFromEntity) then
                                Ora.Anticheat:ReportCheat("error", string.format("[CHEAT] | le joueur %s | %s a les blips des joueurs sur sa minimap", playerServerId, fullname), true)
                                break
                            end
                        end
                    end
                end
    
                if (IsPedInAnyVehicle(myPed)) then
                    local vehiclePedIsIn = GetVehiclePedIsIn(myPed, false)
                    if (vehiclePedIsIn ~= nil and DoesEntityExist(vehiclePedIsIn)) then
                        local topSpeedModifier = GetVehicleTopSpeedModifier(vehiclePedIsIn)
                        if topSpeedModifier >= 100.0 then
                            Ora.Anticheat:ReportCheat("error", string.format("[CHEAT] | le joueur %s | %s a un voiture avec un top speed modifié : %s", playerServerId, fullname, topSpeedModifier), true)
                        end
                    end
                end
            end
        end)
    else
        self:Debug(string.format("^5%s^3 is whitelist for Anticheat", GetPlayerServerId(PlayerId())))
    end
end

function Ora.Anticheat:IsWeaponBlacklisted(weaponName)
    if (Ora.Anticheat.WeaponBlacklist[weaponName] ~= nil) then 
        return true
    end

    return false
end

function Ora.Anticheat:GetBlacklistWeaponName(weaponName)
    if (Ora.Anticheat.WeaponBlacklist[weaponName] ~= nil) then 
        return Ora.Anticheat.WeaponBlacklist[weaponName]
    end

    return "INCONNU"
end

function Ora.Anticheat:ReportCheat(type, message, needScreenshot) 
    TriggerServerEvent("Ora::SE::Anticheat:ReportMessage", type,  message, needScreenshot)
end

