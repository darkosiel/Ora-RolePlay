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


Player = {
    Ped = PlayerPedId(),
    Position = vector3(0, 0, 0),
    PlayerId = PlayerId(),
}


local function startPointing()
    local ped = Player.Ped
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
    local ped = Player.Ped
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(Player.Ped)
end
local pT = false
function pointKey()
    if IsPedOnFoot(Player.Ped) then
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
                    if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(Player.Ped) then
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
                    elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(Player.Ped) and mp_pointing) then
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
                if Citizen.InvokeNative(0x921CE12C489C4C41, Player.Ped) and not mp_pointing then
                    stopPointing()
                end
                if Citizen.InvokeNative(0x921CE12C489C4C41, Player.Ped) then
                    if not IsPedOnFoot(Player.Ped) then
                        stopPointing()
                    else
                        local ped = Player.Ped
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
--     { pos = vector3(-1084.15, -821.88, 5.48), radius = 60.0 },
--     { pos = vector3(326.78, -583.25, 43.4), radius = 50.0 },
--     { pos = vector3(-556.62, 285.77, 82.18), radius = 25.0 },
--     { pos = vector3(338.99, 287.44, 99.80), radius = 25.0 },
--     { pos = vector3(-1572.96, -261.3, 48.48), radius = 50.0 },
--     { pos = vector3(-580.09, -932.8, 23.68), radius = 25.0 },
--     { pos = vector3(-1070.56, -245.15, 40.35), radius = 25.0 },
--     { pos = vector3(-559.68, -199.2, 39.34), radius = 25.0 },
--     { pos = vector3(245.51, -1093.77, 30.21), radius = 25.0 },
--     { pos = vector3(117.96, -1287.3, 28.27), radius = 50.0 },
--     { pos = vector3(322.58, 181.54, 103.59), radius = 6.0 },
--     { pos = vector3(248.62, 220.36, 106.29), radius = 15.0 },
--     { pos = vector3(-204.8388, -1333.2086, 34.89), radius = 60.0 },
--     { pos = vector3(-1427.299, -245.1012, 16.8039), radius = 20.0 },
--     { pos = vector3(1990.88, 3054.02, 47.21), radius = 60.0 },-- Yellow Jack 
--     { pos = vector3(811.8556, -2149.9516, 29.6210), radius = 60.0 },-- Ammunation Sud
--     { pos = vector3(1410.99, 1147.39, 114.33), radius = 60.0 },-- Madrazo
--     { pos = vector3(146.24, -1113.88, 29.31), radius = 40.0 },-- PDM
    { pos = vector3(-1839.58, -360.67, 59.00), radius = 40.0 },-- Hopital
}

-- Citizen.CreateThread(function()
--     local PlayerId, PlayerPedId, GetEntityCoords, ClearAreaOfCops = PlayerId, PlayerPedId, GetEntityCoords, ClearAreaOfCops
--     while true do
--         Citizen.Wait(1000)
--         Player.PlayerId = PlayerId()
--         Player.Ped = PlayerPedId()
--         Player.Position = GetEntityCoords(Player.Ped)
--         ClearAreaOfCops(Player.Position.x, Player.Position.y, Player.Position.z, 500.0, 0)
--     end
-- end)

-- Citizen.CreateThread(function()
--         local GetHashKey = GetHashKey
--         local ClearAreaOfPeds = ClearAreaOfPeds
--         local SetPedDensityMultiplierThisFrame = SetPedDensityMultiplierThisFrame
--         local SetScenarioPedDensityMultiplierThisFrame = SetScenarioPedDensityMultiplierThisFrame
--         local SetVehicleDensityMultiplierThisFrame = SetVehicleDensityMultiplierThisFrame
--         local SetParkedVehicleDensityMultiplierThisFrame = SetParkedVehicleDensityMultiplierThisFrame
--         local SetRandomVehicleDensityMultiplierThisFrame = SetRandomVehicleDensityMultiplierThisFrame
--         local DisablePlayerVehicleRewards = DisablePlayerVehicleRewards
--         local SetPlayerHealthRechargeMultiplier = SetPlayerHealthRechargeMultiplier
--         SetPoliceIgnorePlayer(Player.PlayerId, true)
--         SetEveryoneIgnorePlayer(Player.PlayerId, true)
--         SetPlayerCanBeHassledByGangs(Player.PlayerId, false)
--         SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
--         SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))
--         while true do
--             Citizen.Wait(0)

--             -- for key, value in pairs(clearAreaOfPedsArray) do
--             --     if #(value.pos - Player.Position) < 250.0 then
--             --         print("Deleting peds for " .. key)
--             --         ClearAreaOfPeds(value.pos.x, value.pos.y, value.pos.z, value.radius, 1)
--             --     end
--             -- end
--             SetPedDensityMultiplierThisFrame(1.0) -- set npc/ai peds density to 0
--             SetScenarioPedDensityMultiplierThisFrame(1.0, 1.0)
--             SetVehicleDensityMultiplierThisFrame(0.8) -- was at 0.6
--             SetParkedVehicleDensityMultiplierThisFrame(0.8) -- was at 0.5
--             SetRandomVehicleDensityMultiplierThisFrame(0.8) -- was at 0.5 -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
--             DisablePlayerVehicleRewards(Player.PlayerId)
--             SetPlayerHealthRechargeMultiplier(Player.PlayerId, 0.0)
--         end
--     end
-- )

-- AddEventHandler("populationPedCreating", function(x, y, z, model, functions)
--     for k, v in pairs(ClearAreaOfPedsArray) do
--         if #(v.pos - vector3(x, y, z)) < v.radius then
--             print("Cancelling ped creation for " .. k)
--             CancelEvent()
--         end
--     end
-- end)

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
            -- if IsControlPressed(1, 323) and IsPedOnFoot(Player.Ped)  then
            -- 	local ped = Player.Ped

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


RegisterNetEvent("core:HandCuff")
AddEventHandler(
    "core:HandCuff",
    function(m)
        ishandcuff = m
    end
)

AddEventHandler(
    "playerSpawned",
    function()
        Citizen.CreateThread(
            function()
                local playerPed = Player.Ped

                NetworkSetFriendlyFireOption(true)
                SetCanAttackFriendly(playerPed, true, true)
            end
        )
    end
)
