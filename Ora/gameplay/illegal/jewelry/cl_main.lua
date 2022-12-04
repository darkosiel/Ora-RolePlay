-----------------------------
--- Made by @Naytoxp#2134 ---
---   Released to OraRP   ---
-----------------------------

-- Give a hammer to a player (for dev use only)
-- if isDev then
--     RegisterCommand("hammer", function(source)
--         -- Give riffle to player ped
--         GiveWeaponToPed(Player.Ped, GetHashKey("WEAPON_HAMMER"), 1000, false, true)
--     end, true)
-- end
local dict, effect = "scr_jewelheist", "scr_jewel_fog_volume"

local print2       = print

local function print(...)
    if isDev then
        print2(...)
    end
end

Player                                  = {}
local caseUpdated                       = false
local isRobberyInProgress               = false
local VANGELICO_COORDS                  = C.VangelicoCoords
local ParticleFX, ParticleGasMultiplier = nil, nil
local realJob = nil

---- Create thread while true do and wait 1 second and display a marker on C.Cases[i].Coords_1 and C.Cases[i].Coords_2
Citizen.CreateThread(function()
    -- Reset the case on the script restart
    for k, v in pairs(C.Cases) do
        local retval = GetRayfireMapObject(v.Coords_1.x, v.Coords_1.y, v.Coords_1.z, 1.0, v.Type)
        SetStateOfRayfireMapObject(retval, 2)
    end

    TriggerServerEvent("jewellery_heist:askForConfigData")

    PrepareAlarm("JEWEL_STORE_HEIST_ALARMS")
    StartAlarm("JEWEL_STORE_HEIST_ALARMS")
    StopAlarm("JEWEL_STORE_HEIST_ALARMS", 1)
    isRobberyInProgress = false

    while true do
        Player = LocalPlayer()
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent("jewellery_heist:receiveConfigData", function(c)
    local temp = json.decode(c)
    for k, v in pairs(temp) do
        for k2, v2 in pairs(v) do
            C.Cases[k][k2] = type(v2) == "table" and vector3(v2.x, v2.y, v2.z) or v2
        end
    end
    if Player.Pos then
        if getDistanceBetweenCoords(VANGELICO_COORDS, Player.Pos) < 35.0 then
            UpdateCaseVisualStatus()
        end
    end
    temp = nil
    collectgarbage()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2500)
        realJob = Ora.Identity.Job:Get()
        if (realJob.name == "police" or realJob.name == "lssd") then
            realJob.isLawEnforcement = true
            goto continue
        end
        realJob = Ora.Identity.Orga:Get()
        if (realJob.name == "police" or realJob.name == "lssd") then
            realJob.isLawEnforcement = true
            goto continue
        end
        realJob.isLawEnforcement = false
        ::continue::
    end
end)

function DoesPlayerHaveRequiredItem()
    local retval = false
    for k, v in pairs(C.RequiredItems) do
        if Player.Weapon == v then
            retval = true
            break
        end
    end
    return retval
end

Citizen.CreateThread(function()
    -- For better CPU usage : pass through local variables the functions
    local DisplayHelpMessage, getDistanceBetweenCoords, UpdateCaseVisualStatus, DoesPlayerHaveRequiredItem, IsControlJustPressed, TriggerServerEvent, DrawMarker, Wait = DisplayHelpMessage, getDistanceBetweenCoords, UpdateCaseVisualStatus, DoesPlayerHaveRequiredItem, IsControlJustPressed, TriggerServerEvent, DrawMarker, Citizen.Wait

    while true do
        if Player.Pos and getDistanceBetweenCoords(VANGELICO_COORDS, Player.Pos) < 35.0 then
            if not caseUpdated then
                UpdateCaseVisualStatus()
                caseUpdated = true
            end

            for k, v in pairs(C.Cases) do
                if not v.Broken then
                    local distance = getDistanceBetweenCoords(Player.Pos, v.Coords_2)
                    if distance < 2.5 then
                        DrawMarker(26, v.Coords_2.x, v.Coords_2.y, v.Coords_2.z, 0.0, 0.0, 0.0, 0.0, 0.0, v.Heading, 0.5, 0.5, 0.5, 255, 255, 255, isRobberyInProgress and 100 or 30, false, false, 2, false, false, false, false)

                        if distance <= 1.0 then
                            -- Display help message
                            if DoesPlayerHaveRequiredItem() then
                                if isRobberyInProgress then
                                    DisplayHelpMessage("Appuyez sur ~INPUT_PICKUP~ pour casser la vitrine.")
                                else
                                    DisplayHelpMessage("Appuyez sur ~INPUT_PICKUP~ pour casser la vitrine et commencer le braquage.")
                                end
                                if IsControlJustPressed(0, 38) then
                                    TriggerServerEvent("jewellery_heist:brokenCase:Request", k, v.Coords_1)
                                    Wait(3500)
                                end
                            else
                                DisplayHelpMessage("Equipez un marteau pour casser la vitrine.")
                            end
                        end
                    end
                end
            end

            -- TODO : Make the function to check if the player is a police officer (only to display the marker and help message, a check is done on the server-side)
            if isRobberyInProgress and realJob.isLawEnforcement then
                DrawMarker(25, C.ResetAlarm.x, C.ResetAlarm.y, C.ResetAlarm.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, false, 2, false, false, false, false)
                if getDistanceBetweenCoords(C.ResetAlarm, Player.Pos) < 2.0 then
                    DisplayHelpMessage(("Appuyez sur ~INPUT_PICKUP~ pour réinitialiser l'alarme."))
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent("jewellery_heist:copResetsAlarm")
                    end
                end
            end

        else
            caseUpdated = false
            Wait(2500)
        end
        Wait(1.0)
    end
end)

-- -- TODO : Make the function to check if the player has the required weapon/item
-- function DoesPlayerHaveRequiredItem()
--     -- This is to do
--     local requiredItem = "weapon_hammer"
--     local _, hash      = GetCurrentPedWeapon(
--             Player.Ped --[[ Ped ]],
--             false --[[ boolean ]]
--     )

--     return hash == GetHashKey(requiredItem)
-- end

function UpdateCaseVisualStatus()
    for k, v in pairs(C.Cases) do
        if v.Broken then
            local retval = GetRayfireMapObject(v.Coords_1.x, v.Coords_1.y, v.Coords_1.z, 1.0, v.Type)
            SetStateOfRayfireMapObject(retval, 9)
        end
    end
end

-- Alarm handling
RegisterNetEvent("jewellery_heist:startAlarm", function(gasMultiplier)
    PrepareAlarm("JEWEL_STORE_HEIST_ALARMS")
    StartAlarm("JEWEL_STORE_HEIST_ALARMS")
    isRobberyInProgress = true
    StartSoporificGazEffect(gasMultiplier)
end)

---- Gas related functions
function DoesPedWearMask()
    for k, v in pairs(C.Masks[GetEntityModel(Player.Ped)]) do
        if GetPedDrawableVariation(Player.Ped, v.Comp) == v.D_Id then
            return true
        end
    end
    return false
end

---- TODO : Do items for the masks
RegisterCommand("mask", function()
    if DoesPedWearMask() then
        SetPedComponentVariation(Player.Ped, 1, 0, 0, 2)
    else
        SetPedComponentVariation(Player.Ped, 1, 36, 0, 0)
    end
end, false)

function StartSoporificGazEffect(gasMultiplier)
    if gasMultiplier > 0 then
        ParticleGasMultiplier = gasMultiplier
        RequestNamedPtfxAsset(dict)
        while not HasNamedPtfxAssetLoaded(dict) do
            Citizen.Wait(0)
        end
        UseParticleFxAsset(dict)
        ParticleFX = StartParticleFxLoopedAtCoord(effect, -624.60168457031, -232.41754150391, 38.057033538818, 0.0, 0.0, 0.0, 10, false, false, false, false)
        SetParticleFxLoopedAlpha(ParticleFX, 0.0)
        Citizen.CreateThread(function()
            for i = 1, 100 do
                SetParticleFxLoopedAlpha(ParticleFX, i * (0.2 * ParticleGasMultiplier))
                Citizen.Wait(100)
            end
        end)

        Citizen.CreateThread(function()
            while ParticleFX ~= nil do
                --SetParticleFxLoopedEvolution(ParticleFX, effect, 10)
                if GetInteriorAtCoords(VANGELICO_COORDS) == GetInteriorFromEntity(PlayerPedId()) then
                    if not DoesPedWearMask() and not dead then
                        ApplyDamageToPed(Player.Ped, 3 * (ParticleGasMultiplier), false)
                    end
                end
                Citizen.Wait(1000)
            end
        end)
    end
end

function StopSoporificGazEffect()
    if ParticleGasMultiplier ~= nil and ParticleGasMultiplier > 0 then
        for i = 100, 1, -1 do
            SetParticleFxLoopedAlpha(ParticleFX, i * 0.1 * ParticleGasMultiplier)
            Citizen.Wait(100)
        end
        StopParticleFxLooped(ParticleFX, 0)
        Wait(100)
        ParticleFX = nil
        RemoveNamedPtfxAsset(dict)
        collectgarbage()
    end
end

RegisterNetEvent("jewellery_heist:stopTheAlarm", function()
    Citizen.CreateThread(function()

        PrepareAlarm("JEWEL_STORE_HEIST_ALARMS")
        -- Making sure it's really stoped by starting it again just in case
        StartAlarm("JEWEL_STORE_HEIST_ALARMS")
        StopAlarm("JEWEL_STORE_HEIST_ALARMS", 1)
        isRobberyInProgress = false
        StopSoporificGazEffect()
    end)
end)

-- Broken case handling to network the status and not allow client to do anything without the server allowing it
RegisterNetEvent("jewellery_heist:brokenCase:Allow", function(caseId)
    --print("Allowing case " .. caseId)
    local v = C.Cases[caseId]

    --TaskGoStraightToCoord(Player.Ped, v.Coords_2.x, v.Coords_2.y, v.Coords_2.z, 1.0, -1, v.Heading * 1.0, 0.0)
    SetEntityHeading(Player.Ped, v.Heading * 1.0)
    local retval = GetRayfireMapObject(v.Coords_1.x, v.Coords_1.y, v.Coords_1.z, 1.0, v.Type)
    SetStateOfRayfireMapObject(retval, 4)
    Citizen.Wait(10.0)
    TaskPlayAnim2(Player.Ped, C.Anims[v.Type].Dict, C.Anims[v.Type].Anim, 1.0, -1.0, -1, 0, 0, false, false, false)
    Citizen.Wait(650)
    -- play breaking glass sound
    SetStateOfRayfireMapObject(retval, 6)
    while IsEntityPlayingAnim(Player.Ped, C.Anims[v.Type].Dict, C.Anims[v.Type].Anim, 3) do
        Citizen.Wait(100.0)
    end
    SetStateOfRayfireMapObject(retval, 9)
    Notification("Vitrine cassée.")
    v.Broken = true
    TriggerServerEvent("jewellery_heist:brokenCase:Done", caseId)
end)

RegisterNetEvent("jewellery_heist:updateCase", function(caseId)
    C.Cases[caseId].Broken = true
    if getDistanceBetweenCoords(VANGELICO_COORDS, Player.Pos) < 35.0 then
        UpdateCaseVisualStatus()
    end
end)

RegisterNetEvent("jewellery_heist:notEnoughCops", function()
    Notification("~r~Il n'y a pas assez de policiers en ligne.", true, false)
end)

RegisterNetEvent("jewellery_heist:alreadyRobbed", function()
    Notification("~r~Cette bijouterie a déjà été braquée récemment..", true, false)
end)

-- To do :
-- - Add the sound of the glass

-----------------------------
--- Made by @Naytoxp#2134 ---
---   Released to OraRP   ---
-----------------------------