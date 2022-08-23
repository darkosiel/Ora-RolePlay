local relationshipTypes = {
    "PLAYER",
    "SECURITY_GUARD",
    "PRIVATE_SECURITY",
    "FIREMAN",
    "GANG_1",
    "GANG_2",
    "GANG_9",
    "GANG_10",
    "AMBIENT_GANG_LOST",
    "AMBIENT_GANG_MEXICAN",
    "AMBIENT_GANG_FAMILY",
    "AMBIENT_GANG_BALLAS",
    "AMBIENT_GANG_MARABUNTE",
    "AMBIENT_GANG_CULT",
    "AMBIENT_GANG_SALVA",
    "AMBIENT_GANG_WEICHENG",
    "AMBIENT_GANG_HILLBILLY",
    "DEALER",
    "HATES_PLAYER",
    "HEN",
    "NO_RELATIONSHIP",
    "SPECIAL",
    "MISSION2",
    "MISSION3",
    "MISSION4",
    "MISSION5",
    "MISSION6",
    "MISSION7",
    "MISSION8",
    "ARMY",
    "GUARD_DOG",
    "AGGRESSIVE_INVESTIGATE",
    "MEDIC",
    "CAT"
}

local RELATIONSHIP_HATE = 1

--[[Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            SetPlayerWeaponDamageModifier(GetHashKey("weapon_unarmed"), 0.10)
            for _, group in ipairs(relationshipTypes) do
                SetRelationshipBetweenGroups(RELATIONSHIP_HATE, GetHashKey("PLAYER"), GetHashKey(group))
                SetRelationshipBetweenGroups(RELATIONSHIP_HATE, GetHashKey(group), GetHashKey("PLAYER"))
            end
        end
    end
)]]
local mp_pointing = false
local keyPressed = false
local vehicleGenerator = {
    {x = 1222.7, y = 2712.9, z = 38.01, r = 500}, -- AntiSpawn Larry's
    {x = -44.02, y = -1098.0, z = 26.42, r = 100}, -- AntiSpawn concess sud
    --{x = 133.89, y = 6604.01, z = 31.84, r = 500}, -- AntiSpawn biker QG
    --{x = 1986.10, y = 3785.63, z = 34.65, r = 500}, -- AntiSpawn station sandy
    {x = 1806.64, y = 3392.35, z = 41.44, r = 500}, -- AntiSpawn FlyWheels Garage
    {x = 1210.2546, y = -3272.5209, z = 13.77, r = 500}, -- AntiSpawn Post Op
    {x = -1342.8936, y = -1086.5444, z = 6.9363, r = 500}, -- AntiSpawn Mirror
    --{x = 408.50, y = -988.39, z = 29.26, r = 500}, -- AntiSpawn LSPD
    {x = 1639.45, y = 4836.45, z = 42.02, r = 500}, -- Club House AOD
    {x = 1410.83, y = 1117.63, z = 114.83, r = 500} -- Antispawn Fuente Blanca
}



local function startPointing()
    local ped = PlayerPedId()
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(50)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end
local pT = false
function pointKey()
    if IsPedOnFoot(PlayerPedId()) then
        if not pT then
            startPointing()
        else
            stopPointing()
        end
        pT = not pT
    end
end
RegisterCommand(
    "+poiting",
    function()
        pointKey()
    end,
    false
)
RegisterCommand(
    "-poiting",
    function()
        pointKey()
    end,
    false
)
RegisterCommand(
    "poiting",
    function()
        pointKey()
    end,
    false
)
RegisterKeyMapping("poiting", "Montrer du doigt", "keyboard", "b")
local once = true
local oldval = false
local oldvalped = false
local ishandcuff = false

Citizen.CreateThread(
    function()
        while true do
            Wait(0)

            if once then
                once = false
            end
            if ishandcuff == false then
                if not keyPressed then
                    if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                        Wait(200)
                        if not IsControlPressed(0, 29) then
                            keyPressed = true
                            -- startPointing()
                            mp_pointing = true
                        else
                            keyPressed = true
                            while IsControlPressed(0, 29) do
                                Wait(50)
                            end
                        end
                    elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                        keyPressed = true
                        mp_pointing = false
                    --stopPointing()
                    end
                end

                if keyPressed then
                    if not IsControlPressed(0, 29) then
                        keyPressed = false
                    end
                end
                if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
                    stopPointing()
                end
                if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
                    if not IsPedOnFoot(PlayerPedId()) then
                        stopPointing()
                    else
                        local ped = PlayerPedId()
                        local camPitch = GetGameplayCamRelativePitch()
                        if camPitch < -70.0 then
                            camPitch = -70.0
                        elseif camPitch > 42.0 then
                            camPitch = 42.0
                        end
                        camPitch = (camPitch + 70.0) / 112.0

                        local camHeading = GetGameplayCamRelativeHeading()
                        local cosCamHeading = Cos(camHeading)
                        local sinCamHeading = Sin(camHeading)
                        if camHeading < -180.0 then
                            camHeading = -180.0
                        elseif camHeading > 180.0 then
                            camHeading = 180.0
                        end
                        camHeading = (camHeading + 180.0) / 360.0

                        local blocked = 0
                        local nn = 0

                        local coords =
                            GetOffsetFromEntityInWorldCoords(
                            ped,
                            (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)),
                            (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)),
                            0.6
                        )
                        local ray =
                            Cast_3dRayPointToPoint(
                            coords.x,
                            coords.y,
                            coords.z - 0.2,
                            coords.x,
                            coords.y,
                            coords.z + 0.2,
                            0.4,
                            95,
                            ped,
                            7
                        )
                        nn, blocked, coords, coords = GetRaycastResult(ray)

                        Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                        Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                        Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                        Citizen.InvokeNative(
                            0xB0A6CFD2C69C1088,
                            ped,
                            "isFirstPerson",
                            Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4
                        )
                    end
                end
            end
        end
    end
)

local clearAreaOfPedsArray = { --Antispawn PNJ
    { pos = vector3(-1084.15, -821.88, 5.48), radius = 60.0 },
    { pos = vector3(326.78, -583.25, 43.4), radius = 50.0 },
    { pos = vector3(-556.62, 285.77, 82.18), radius = 25.0 },
    { pos = vector3(338.99, 287.44, 99.80), radius = 25.0 },
    { pos = vector3(-1572.96, -261.3, 48.48), radius = 50.0 },
    { pos = vector3(-580.09, -932.8, 23.68), radius = 25.0 },
    { pos = vector3(-1070.56, -245.15, 40.35), radius = 25.0 },
    { pos = vector3(-559.68, -199.2, 39.34), radius = 25.0 },
    { pos = vector3(245.51, -1093.77, 30.21), radius = 25.0 },
    { pos = vector3(117.96, -1287.3, 28.27), radius = 50.0 },
    { pos = vector3(322.58, 181.54, 103.59), radius = 6.0 },
    { pos = vector3(248.62, 220.36, 106.29), radius = 15.0 },
    { pos = vector3(-204.8388, -1333.2086, 34.89), radius = 60.0 },
    { pos = vector3(-1427.299, -245.1012, 16.8039), radius = 20.0 },
    { pos = vector3(1990.88, 3054.02, 47.21), radius = 60.0 },-- Yellow Jack 
    { pos = vector3(811.8556, -2149.9516, 29.6210), radius = 60.0 },-- Ammunation Sud
    { pos = vector3(1410.99, 1147.39, 114.33), radius = 60.0 },-- Madrazo
    { pos = vector3(146.24, -1113.88, 29.31), radius = 40.0 },-- PDM
    { pos = vector3(-1839.58, -360.67, 59.00), radius = 40.0 },-- Hopital
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPosition = GetEntityCoords(PlayerPedId()) 
        ClearAreaOfCops(playerPosition.x, playerPosition.y, playerPosition.z, 500.0, 0)
    end
end)

Citizen.CreateThread(
    function()
        SetPoliceIgnorePlayer(PlayerId(), true)
        SetEveryoneIgnorePlayer(PlayerId(), true)
        SetPlayerCanBeHassledByGangs(PlayerId(), false)
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
        SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))

        while true do
            Citizen.Wait(0)

            local playerPosition = GetEntityCoords(PlayerPedId()) 
            for key, value in pairs(clearAreaOfPedsArray) do
                if (GetDistanceBetweenCoords(value.pos, playerPosition, false) < 250.0) then
                    ClearAreaOfPeds(value.pos.x, value.pos.y, value.pos.z, value.radius, 1)
                end
            end
            SetPedDensityMultiplierThisFrame(1.0) -- set npc/ai peds density to 0
            SetScenarioPedDensityMultiplierThisFrame(1.0, 1.0)
            SetVehicleDensityMultiplierThisFrame(0.8) -- was at 0.6
            SetParkedVehicleDensityMultiplierThisFrame(0.8) -- was at 0.5
            SetRandomVehicleDensityMultiplierThisFrame(0.8) -- was at 0.5 -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
            DisablePlayerVehicleRewards(PlayerId())
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        end
    end
)

local function CheckResolution(firstConn)
    local x, y = GetActiveScreenResolution()
    
    if (firstConn == true) then
        if (--[[(not GetIsWidescreen()) or]] (x <= 1176 and y <= 664)) then
            ShowNotification("~r~~h~Vous avez 2 minutes pour changer votre résolution (1920x1080 optimal), sans quoi, vous serez ban 2H.")
            Citizen.SetTimeout(60000, function()
                if (--[[(not GetIsWidescreen()) or]] (x <= 1176 and y <= 664)) then
                    ShowNotification("~r~~h~Vous avez 1 minute pour changer votre résolution (1920x1080 optimal), sans quoi, vous serez ban 2H.")
                else
                    ShowNotification("~g~Parfait, bon jeu !")
                end
            end)
        end
    else
        if (--[[(not GetIsWidescreen()) or]] (x <= 1176 and y <= 664)) then
            TriggerServerEvent("banPlayer", GetPlayerServerId(PlayerId()), "Votre résolution doit être supérieure à 1280 x 1080", 7200)
        end
    end
end

Citizen.CreateThread(
    function()
        Wait(5000)

        CheckResolution(true)
        
        Wait(120000)
        
        while true do
            CheckResolution(false)

            Wait(600000)
        end
    end
)

local SCENARIO_GROUPS = {
    2017590552, -- LSIA planes
    2141866469, -- Sandy Shores planes
    1409640232, -- Grapeseed planes
    "ng_planes" -- Far up in the skies jets
}

local SCENARIO_TYPES = {
    "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes
    "WORLD_VEHICLE_MILITARY_PLANES_BIG" -- Zancudo Big Planes
}

Citizen.CreateThread(
    function()
        while true do
            for _, sctyp in next, SCENARIO_TYPES do
                SetScenarioTypeEnabled(sctyp, false)
            end

            for _, scgrp in next, SCENARIO_GROUPS do
                SetScenarioGroupEnabled(scgrp, false)
            end
            Wait(10000)
        end
    end
)

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

RegisterNetEvent("setVehicleDoors")
AddEventHandler(
    "setVehicleDoors",
    function(veh, doors)
        SetVehicleDoorsLocked(veh, doors)
    end
)
function drawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function drawRct(x, y, width, height, r, g, b, a)
    DrawRect(x + width / 2, y + height / 2, width, height, r, g, b, a)
end

--[[Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            HideHudComponentThisFrame(141)
            HideHudComponentThisFrame(2)
            if not ishandcuff then
            -- if IsControlPressed(1, 323) and IsPedOnFoot(PlayerPedId())  then
            -- 	local ped = PlayerPedId()

            -- 	if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then

            -- 		RequestAnimDict( "random@mugging3" )

            -- 		while ( not HasAnimDictLoaded( "random@mugging3" ) ) do
            -- 			Citizen.Wait( 1 )
            -- 		end

            -- 		if handsup then
            -- 			ClearPedSecondaryTask(ped)
            -- 			handsup = false
            -- 			TriggerServerEvent("core:updateHands",handsup)
            -- 			Citizen.Wait(500)
            -- 		else
            -- 			TaskPlayAnim(ped, "random@mugging3", "handsup_standing_enter", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
            -- 			Wait(100)
            -- 			TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
            -- 			handsup = true
            -- 			TriggerServerEvent("core:updateHands", handsup)
            -- 			Citizen.Wait(500)
            -- 		end
            -- 	end
            -- end
            end
        end
    end
)]]
function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function DisableActions(ped)
    DisableControlAction(1, 140, true)
    DisableControlAction(1, 141, true)
    DisableControlAction(1, 142, true)
    DisableControlAction(1, 37, true)
    DisablePlayerFiring(ped, true)
end

RegisterNetEvent("core:HandCuff")
AddEventHandler(
    "core:HandCuff",
    function(m)
        ishandcuff = m
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            local ped = PlayerPedId()

            if IsPedArmed(ped, 6) then
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
                if GetVehiclePedIsUsing(ped) ~= 0 then
                    DisableControlAction(1, 25, true)
                    DisableControlAction(1, 68, true)
                end
                if IsPlayerFreeAiming(PlayerId()) then
                    DisableControlAction(1, 22, true)
                    DisableControlAction(1, 36, true)
                end
            end

            HideHudComponentThisFrame(141)
            HideHudComponentThisFrame(2)
        end
    end
)

AddEventHandler(
    "playerSpawned",
    function()
        Citizen.CreateThread(
            function()
                local player = PlayerId()
                local playerPed = PlayerPedId()

                NetworkSetFriendlyFireOption(true)
                SetCanAttackFriendly(playerPed, true, true)
            end
        )
    end
)
