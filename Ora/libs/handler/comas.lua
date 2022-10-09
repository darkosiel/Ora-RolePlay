local locksound = false
local wait = 15
local count = 60
local dead = false
local canRemoveStrength = true
local calledLSFD = false
local respawnPos = {x = 306.47, y = -595.02, z = 43.28}
local weaponHashType = {
    "inconnue",
    "dégâts de mêlée",
    "blessure par balle",
    "chute",
    "dégâts explosifs",
    "feu",
    "chute",
    "éléctrique",
    "écorchure",
    "gaz",
    "gaz",
    "eau"
}
local boneTypes = {
    ["Dos"] = {0, 23553, 56604, 57597},
    ["Crâne"] = {
        1356,
        11174,
        12844,
        17188,
        17719,
        19336,
        20178,
        20279,
        20623,
        21550,
        25260,
        27474,
        29868,
        31086,
        35731,
        43536,
        45750,
        46240,
        47419,
        47495,
        49979,
        58331,
        61839,
        39317
    },
    ["Coude droit"] = {2992},
    ["Coude gauche"] = {22711},
    ["Main gauche"] = {
        4089,
        4090,
        4137,
        4138,
        4153,
        4154,
        4169,
        4170,
        4185,
        4186,
        18905,
        26610,
        26611,
        26612,
        26613,
        26614,
        60309
    },
    ["Main droite"] = {
        6286,
        28422,
        57005,
        58866,
        58867,
        58868,
        58869,
        58870,
        64016,
        64017,
        64064,
        64065,
        64080,
        64081,
        64096,
        64097,
        64112,
        64113
    },
    ["Bras gauche"] = {5232, 45509, 61007, 61163},
    ["Bras droit"] = {28252, 40269, 43810},
    ["Jambe droite"] = {6442, 16335, 51826, 36864},
    ["Jambe gauche"] = {23639, 46078, 58271, 63931},
    ["Pied droit"] = {20781, 24806, 35502, 52301},
    ["Pied gauche"] = {2108, 14201, 57717, 65245},
    ["Poîtrine"] = {10706, 64729, 24816, 24817, 24818},
    ["Ventre"] = {11816}
}

local deathTime, waitTime, deathCause = 0, 60 * 1000 * 10.0, {}
local function RespawnPed(ped, coords)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    TriggerEvent("playerSpawned", coords.x, coords.y, coords.z, coords.heading)
    ClearPedBloodDamage(ped)
    if RespawnToHospitalMenu ~= nil then
        RespawnToHospitalMenu.close()
        RespawnToHospitalMenu = nil
    end
end
local put = nil

local function canBeRevived()
    local bool = not DoesEntityExist(GetEntityAttachedTo(PlayerPedId()))
    if not bool then
        RageUI.Popup({message = "~r~Vous avez besoin d'une réanimation."})
    end
    return bool
end
ko = false
local RestrictedKey = {
    "X",
    "C",
    "LSHIFT",
    "F5",
    "F2",
    "F3",
    "F1",
    "F6",
    "F7",
    "K",
    "L",
    "P",
    "G",
    "B",
    "SPACE",
    "LEFTSHIFT",
    "TAB"
}
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local Player = LocalPlayer()
            if (Player.KO or Player.isDead) then
                for i = 1, #RestrictedKey, 1 do
                    DisableControlAction(0, Keys[RestrictedKey[i]], true)
                end
                if (IsDisabledControlJustPressed(0, Keys[RestrictedKey[i]])) then
                    ShowNotification("~r~Vous ne pouvez pas faire ça pour le moment")
                end
            end
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local Player = LocalPlayer()

            Player.isDead = dead
            ko = Player.KO
            if ko then
                local ped = PlayerPedId()
                ko = false
                local wait = true
                exports["mythic_progbar"]:Progress(
                    {
                        name = "unique_action_name",
                        duration = 15000, --15000
                        label = "Vous êtes KO",
                        useWhileDead = true,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = true,
                            disableCombat = true
                        }
                    },
                    function(cancelled)
                        if not cancelled then
                            ko = false
                            Player.KO = false
                            Ora.Health:SetKO(false)
                            Ora.Health:SetMyHealthPercent(15)
                            wait = false
                            Citizen.CreateThread(
                                function()
                                    -- body
                                    Wait(5000) --Wait(800)
                                    setSobre()
                                end
                            )
                        else
                            -- Do Something If Action Was Cancelled
                        end
                    end
                )
                while wait do
                    Wait(1)
                    SetPedToRagdoll(ped, 1000, 1000, 0, 1, 1, 0)
                end
            end
            if dead then
                local ped = PlayerPedId()
                Ora.Health:SetIsDead(true)
                ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
                SetTimecycleModifier("rply_vignette")

                Citizen.Wait(1000)
                while dead do
                    SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 1, 1, 0)
                    drawTxt(.38, .87, .4, "Origine: ~p~" .. (deathCause[2] or "inconnue"), 4, nil, nil, 100)
                    drawTxt(.38, .895, .4, "Cause: ~p~" .. (deathCause[3] or "inconnue"), 4, nil, nil, 100)
                    drawTxt(.38, .92, .4, "Blessure: ~p~" .. (deathCause[4] or "inconnu"), 4, nil, nil, 100)
                    deathTime = deathTime or GetGameTimer()
                    local t = deathTime + waitTime

                    drawTimer(t - GetGameTimer(), true)

                    local CallPressed = IsControlJustPressed(1, Keys["E"])
                    if (CallPressed and canBeRevived() and calledLSFD == false) then
                        calledLSFD = true
                        RageUI.Popup({message = "~b~Vous avez appelé les urgences."})
                        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                        local coords = {x = x, y = y, z = z}
                        TriggerServerEvent("call:makeCall", "lsfd", coords, "~n~Origine: ~p~"..(deathCause[2] or "inconnue").."~n~~w~Cause: ~p~"..(deathCause[3] or "inconnue").."~n~~w~Blessure: ~p~"..(deathCause[4] or "inconnu"))
                        TriggerServerEvent("call:makeCall", "lsms", coords, "~n~Origine: ~p~"..(deathCause[2] or "inconnue").."~n~~w~Cause: ~p~"..(deathCause[3] or "inconnue").."~n~~w~Blessure: ~p~"..(deathCause[4] or "inconnu"))
                        Citizen.SetTimeout(600000, function() calledLSFD = false end)
                    end

                    if (t - GetGameTimer() < 0) then
                        drawTxt(.38, .52, .4, "Appuyez sur Y pour être TP au Ocean Center", 4, nil, nil, 100)
                        if (IsControlJustPressed(1, Keys["Y"])) then
                            local ped = PlayerPedId()
                            Ora.Core:TeleportEntityTo(ped, vector3(-1861.79, -323.38, 49.45), true)
                            ClearPedBloodDamage(ped)
                            Ora.Health:Revive()
                            Ora.Health:SetIsDead(false)
                            Ora.Health:SetMyHealthPercent(20)
                            dead = false
                            Ora.Health:SetIsDead(false)
                            ShowNotification({message = "~g~Vous avez été transporté à l'hopital"})
                        end
                    end
                    Citizen.Wait(0)
                end
            end
        end
    end
)
function drawTimer(time, bl)
    DrawRect(0.44, 0.97, 0.14, 0.03, 0, 0, 0, 100)
    drawScrTxt(0.4475, 0.9675, 0.14, 0.03, 0, 0.325, "Temps:")
    drawScrTxt(0.4875, 0.965, 0.14, 0.03, 4, 0.45, bl and MilliSecondsToClock(time) or SecondsToClock(time))
end
local xSMS = 0.15
function drawScrTxt(x, y, w, h, f, s, text, outline, center, wr)
    SetTextFont(f)
    SetTextScale(s, s)
    SetTextColour(255, 255, 255, 255)
    if center then
        SetTextCentre(true)
    end
    SetTextDropShadow()
    if outline then
        SetTextOutline()
    end
    if wr then
        SetTextWrap(0.0, xSMS + 0.125)
    end
    SetTextEntry("jamyfafi")
    AddTextComponentString(text)
    if string.len(text) > 99 and AddLongString then
        AddLongString(text)
    end
    DrawText(x - w / 2, y - h / 2 + 0.005)
end

function RevivePlayer()
    local ped = PlayerPedId()
    LocalPlayer().isDead = false
    
    if IsEntityDead(ped) or IsPedDeadOrDying(ped, 1) then
        NetworkResurrectLocalPlayer(GetEntityCoords(ped), 0, true, true, false)
    end

    Ora.Health:SetIsDead(false)
    SetEntityInvincible(ped, false)
    Ora.Health:SetMyHealthPercent(15)
    TriggerServerEvent("Ora::SE::Player:RegisterHealth", GetEntityHealth(ped))
    canRemoveStrength = true
end

function SecondsToClock(seconds)
    seconds = tonumber(seconds)

    if seconds <= 0 then
        return "00:00"
    else
        mins = string.format("%02.f", math.floor(seconds / 60))
        secs = string.format("%02.f", math.floor(seconds - mins * 60))
        return string.format("%s:%s", mins, secs)
    end
end

function MilliSecondsToClock(seconds)
    seconds = tonumber(seconds / 1000)

    if seconds <= 0 then
        return "00:00.00"
    else
        mins = string.format("%02.f", math.floor(seconds / 60))
        secs = string.format("%02.f", math.floor(seconds - mins * 60))
        milli = string.format("%02.f", math.floor(seconds * 1000 - mins * 60000 - secs * 1000))
        return string.format("%s:%s.%s", mins, secs, milli)
    end
end
function drawTxt(x, y, scale, text, f, c, n, a, r, g, b)
    a = a or 255
    if not r then
        r = 255
        g = 255
        b = 255
    end
    if not f then
        f = 4
    end
    SetTextFont(f)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextCentre(c)
    if not n then
        SetTextDropShadow()
        SetTextOutline()
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 255)
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

local firstSpawn = true
RegisterNetEvent("Ora::CE::Character:Loaded")
AddEventHandler(
    "Ora::CE::Character:Loaded",
    function()
        Wait(100)
        if firstSpawn then
            firstSpawn = false
            TriggerServerCallback(
                "Ora::SE::Health:IsPlayerDead",
                function(bool)
                    print("Death status : " .. tostring(bool))
                    if bool then
                        --Ora.Health:Slay()
                    end
                end
            )
        end
    end
)
AddEventHandler(
    "EntityDeath",
    function(ped, attackEntity, weaponUsed)
        if not dead then
            deathCause = table.pack(GetAllCauseOfDeath(PlayerPedId()))
            dead = true

            Citizen.Wait(500)
            local PedKiller = GetPedSourceOfDeath(PlayerPedId())
            local DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
            local Weapon = LogWeaponNames[tostring(DeathCauseHash)]
            local DeathReason = nil

            if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
                Killer = NetworkGetPlayerIndexFromPed(PedKiller)
            elseif
                IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and
                    IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1))
            then
                Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
            end

            if (Killer == PlayerId()) then
                DeathReason = "committed suicide"
            elseif (Killer == nil) then
                DeathReason = "died"
            else
                if IsMelee(DeathCauseHash) then
                    DeathReason = "a assassiné"
                elseif IsTorch(DeathCauseHash) then
                    DeathReason = "a brulé"
                elseif IsKnife(DeathCauseHash) then
                    DeathReason = "a poignardé"
                elseif IsPistol(DeathCauseHash) then
                    DeathReason = "a tiré sur"
                elseif IsSub(DeathCauseHash) then
                    DeathReason = "riddled"
                elseif IsRifle(DeathCauseHash) then
                    DeathReason = "tiré"
                elseif IsLight(DeathCauseHash) then
                    DeathReason = "a tiré"
                elseif IsShotgun(DeathCauseHash) then
                    DeathReason = "a pulvérisé"
                elseif IsSniper(DeathCauseHash) then
                    DeathReason = "a snipé"
                elseif IsHeavy(DeathCauseHash) then
                    DeathReason = "obliterated"
                elseif IsMinigun(DeathCauseHash) then
                    DeathReason = "a déchiqueté"
                elseif IsBomb(DeathCauseHash) then
                    DeathReason = "a fait exploser"
                elseif IsVeh(DeathCauseHash) then
                    DeathReason = "mowed over"
                elseif IsVK(DeathCauseHash) then
                    DeathReason = "a ecrasé"
                else
                    DeathReason = "a tué"
                end
            end

            if DeathReason == "committed suicide" or DeathReason == "died" then
                TriggerServerEvent(
                    "Ora:sendToDiscord",
                    5,
                    "[SUICIDE] " .. Ora.Identity:GetFullname(GetPlayerServerId(PlayerId())) .. " " .. DeathReason .. ".",
                    "info"
                )
            else
                TriggerServerEvent(
                    "Ora:sendToDiscord",
                    5,
                    "[MORT] " ..
                    GetPlayerServerId(Killer) ..
                            " | " ..
                            Ora.Identity:GetFullname(GetPlayerServerId(Killer)) ..
                                    " " .. DeathReason .. " " .. Ora.Identity:GetFullname(GetPlayerServerId(PlayerId())) .. "." .. " " .. Weapon,
                    "info"
                )
            end
            Killer = nil
            DeathReason = nil
            DeathCauseHash = nil
            Weapon = nil

            local ped = PlayerPedId()
            SetEntityVisible(ped, false)
            RageUI.Popup({message = "~r~Appuyez sur ~y~E~r~ pour appeler les medecins."})
            deathTime = GetGameTimer() or 0
            
            ped = PlayerPedId()

            if (IsEntityDead(ped) or IsPedDeadOrDying(ped, 1)) then
                NetworkResurrectLocalPlayer(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z, GetEntityHeading(ped), true, false) 
            end

            Ora.Health:Revive()
            SetEntityVisible(ped, true)
            SetPedToRagdoll(ped, 1000, 1000, 0, 1, 1, 0)
            TriggerServerEvent("Ora::Illegal:PlayerIsDead", true)
            Ora.Health:SetIsDead(true)
            ClearAreaOfPeds(GetEntityCoords(PlayerPedId()), 10.0, 1)
        end
    end
)
AddEventHandler(
    "EntityKO",
    function(_, killer)
        local Player = LocalPlayer()
        Player.KO = true
        Ora.Health:SetKO(true)
        Ora.Health:Revive()
        local ped = PlayerPedId()
        SetPedToRagdoll(ped, 1000, 1000, 0, 1, 1, 0)
        ClearAreaOfPeds(GetEntityCoords(PlayerPedId()), 10.0, 1)
    end
)
local KOWeapons = {
    -1569615261,
    -1600701090,
    126349499,
    4194021054,
    -100946242,
    -1600701090,
    2694266206,
    -37975472,
    539292904,
    0
}

AddEventHandler(
    "gameEventTriggered",
    function(eventName, eventArguments)
        if eventName == "CEventNetworkEntityDamage" then
            local victimEntity, attackEntity, x1, x2, x3, fatalBool, weaponUsed, x4, x5, x6, x7, x8, entityType = table.unpack(eventArguments)
            local weaponUsed = eventArguments[7]
            local ped = PlayerPedId()
            
            if ped ~= victimEntity then
                return
            end
            --print("I'm hit by a damage")
            Ora.Core:Debug(string.format("victimEnt : ^5%s^3\nattackEnt : ^5%s^3\nx1 : ^5%s^3\nx2 : ^5%s^3\nx3 : ^5%s^3\nfatalBool : ^5%s^3\nweaponUsed : ^5%s^3\nx4 : ^5%s^3\nx5 : ^5%s^3\nx6 : ^5%s^3\nx7 : ^5%s^3\nx8 : ^5%s^3\nentityType : ^5%s^3", victimEntity, attackEntity, x1, x2, x3, fatalBool, weaponUsed, x4, x5, x6, x7, x8, entityType))
            local IsKO = fatalBool ~= 0 and (IsPedArmed(attackEntity, 1) or tableHasValue(KOWeapons, weaponUsed))
            eventName = IsKO and "EntityKO" or fatalBool ~= 0 and "EntityDeath" or "EntityTakeDamage"
            --print(eventName, fatalBool, IsKo, victimEntity, attackEntity, weaponUsed)
            TriggerServerCallback("Ora::SE::Anticheat:RegisterPed", function()
                Ora.Health:SetCurrentRegisteredHealth(GetEntityHealth(PlayerPedId()))
                TriggerEvent(eventName, victimEntity, attackEntity, weaponUsed)
                TriggerServerEvent("Ora::SE::Player:RegisterHealth", GetEntityHealth(LocalPlayer().Ped))
                if victimEntity == ped and GetPedArmour(ped) <= 0 and IsEntityAPed(attackEntity) and IsPedAPlayer(attackEntity) and not fatalBool and IsPedArmed(attackEntity, 6) then
                    SetPedToRagdollWithFall(ped, 1500, 2000, 1, -GetEntityForwardVector(ped), 1.0, 0.0, .0, .0, .0, .0, .0)
                end
            end,GetEntityModel(PlayerPedId()))
        end
    end
)

function GetAllCauseOfDeath(ped)
    local exist, lastBone = GetPedLastDamageBone(ped)
    local cause, what, timeDeath =
        GetPedCauseOfDeath(ped),
        Citizen.InvokeNative(0x93C8B64DEB84728C, ped),
        Citizen.InvokeNative(0x1E98817B311AE98A, ped)
    if what and DoesEntityExist(what) then
        if IsEntityAPed(what) then
            what = "traces de combat"
        elseif IsEntityAVehicle(what) then
            what = "écrasé par un véhicule"
        elseif IsEntityAnObject(what) then
            what = "semble s'être pris un objet"
        end
    end
    what = type(what) == "string" and what or "inconnue"

    if cause then
        if IsWeaponValid(cause) then
            cause = weaponHashType[GetWeaponDamageType(cause)] or "inconnue"
        elseif IsModelInCdimage(cause) then
            cause = "véhicule"
        end
    end
    cause = type(cause) == "string" and cause or "mêlée"

    local boneName = "Dos"
    if exist and lastBone then
        for k, v in pairs(boneTypes) do
            if tableHasValue(v, lastBone) then
                boneName = k
                break
            end
        end
    end

    return timeDeath, what, cause, boneName
end

function startAttitude(_, anim)
    Citizen.CreateThread(
        function()
            local playerPed = PlayerPedId()

            RequestAnimSet(anim)

            while not HasAnimSetLoaded(anim) do
                Citizen.Wait(1)
            end
            SetPedMotionBlur(playerPed, false)
            SetPedMovementClipset(playerPed, anim, true)
        end
    )
end
function createAnEffect(name, cam, time)
    Citizen.CreateThread(
        function()
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)

            SetTimecycleModifier(name or "spectator3")
            if cam then
                SetCamEffect(2)
            end
            DoScreenFadeIn(1000)

            Citizen.Wait(1000 * (time or effetTime))
            setSobre()
        end
    )
end
function setSobre()
    Citizen.CreateThread(
        function()
            local ped = LocalPlayer().Ped
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ClearTimecycleModifier()
            ResetScenarioTypesEnabled()
            ResetPedMovementClipset(ped, 0)
            SetPedIsDrunk(ped, false)
            SetCamEffect(0)
        end
    )
end

effetTime = 180
RegisterNetEvent("player:Revive")
AddEventHandler(
    "player:Revive",
    function()
        playerCoords = {}
        Ora.Health:Revive()
        playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        coords = {["x"] = coords.x, ["y"] = coords.y, ["z"] = coords.z}
        local Player = LocalPlayer()
        dead = false
        Player.KO = false
        Ora.Health:SetIsDead(false)
        Ora.Health:SetKO(false)

        local ped = PlayerPedId()
        Ora.Health:SetIsDead(false)
        RageUI.Popup({message = "~g~Réanimation\n~w~Vous venez d'être réanimé, ~r~~r~vous êtes blessé."})
        ClearTimecycleModifier()
        ClearPedBloodDamage(ped)
        ClearAreaOfPeds(GetEntityCoords(PlayerPedId()), 6.0, 1)
        Player.isDead = false
        Player.KO = false
        setSobre()
        TriggerServerEvent("Ora::SE::Player:RegisterHealth", GetEntityHealth(LocalPlayer().Ped))
    end
)
ClearTimecycleModifier()
DoScreenFadeIn(800)

-- Citizen.CreateThread(
--     function()
--         local isDead = false
--         local hasBeenDead = false
--         local diedAt

--         while true do
--             Wait(0)
--             local player = PlayerId()

--             if NetworkIsPlayerActive(player) then
--                 local ped = PlayerPedId()

--                 if IsPedFatallyInjured(ped) and not isDead then
--                     isDead = true
--                     if not diedAt then
--                         diedAt = GetGameTimer()
--                     end

--                     local killer, killerweapon = NetworkGetEntityKillerOfPlayer(player)
--                     local killerentitytype = GetEntityType(killer)
--                     local killertype = -1
--                     local killerinvehicle = false
--                     local killervehiclename = ""
--                     local killervehicleseat = 0
--                     if killerentitytype == 1 then
--                         killertype = GetPedType(killer)
--                         if IsPedInAnyVehicle(killer, false) == 1 then
--                             killerinvehicle = true
--                             killervehiclename = nil
--                         else
--                             killerinvehicle = false
--                         end
--                     end

--                     local killerid = GetPlayerByEntityID(killer)
--                     if killer ~= ped and killerid ~= nil and NetworkIsPlayerActive(killerid) then
--                         killerid = GetPlayerServerId(killerid)
--                     else
--                         killerid = -1
--                     end
--                     --print(killer,killedid)

--                     if killer == ped or killer == -1 then
--                         hasBeenDead = true
--                     else
--                         print(killertype)
--                         print(killerweapon)
--                         print(killerinvehicle)
--                         print(killervehiclename)
--                         print(GetEntityCoords(ped))

--                         hasBeenDead = true
--                     end
--                 elseif not IsPedFatallyInjured(ped) then
--                     isDead = false
--                     diedAt = nil
--                 end

--                 if not hasBeenDead and diedAt ~= nil and diedAt > 0 then
--                     hasBeenDead = true
--                 elseif hasBeenDead and diedAt ~= nil and diedAt <= 0 then
--                     hasBeenDead = false
--                 end
--             end
--         end
--     end
-- )

-- function GetPlayerByEntityID(id)
--     --print("iidd",id)
--     for i=0,255 do
--         if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
--     end
--     return nil
-- end
