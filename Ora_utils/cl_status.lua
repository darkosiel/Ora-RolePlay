--faim = 55
--soif = 55
--inLoading  =false
--Citizen.CreateThread(function ()
--	while true do
--		Wait(35700)
--			Citizen.Wait(3500)
--			RemoveCalories(12.12)
--			RemoveWater(11.18)
--
--	end
--end)

faim = 55
soif = 55
inLoading = false
local canDrain = true
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            Citizen.Wait(35000)
            if (canDrain == true) then
                RemoveCalories(0.12)
                RemoveWater(0.18)
            end
        end
    end
)

function setfaim(calories)
    faim = calories
    TriggerServerEvent("mosrow:setfaim", faim)
end
function AddCalories(calories)
    if calories == nil then
        calories = 10
    end
    if faim == 100 then
        return
    end
    if faim + calories <= 100 then
        faim = faim + calories
    else
        faim = 100
    end
    TriggerServerEvent("mosrow:setfaim", faim)
end

function RemoveCalories(calories)
    if faim == 0 then
        return
    end
    if faim - calories >= 0 then
        faim = faim - calories
    else
        faim = 0
    end
    if faim <= 10 and faim > 0 then
        ShowNotification("Vous avez faim \n~g~vous devez manger !")
    elseif faim == 0 then
        SetEntityHealth(PlayerPedId(), 0)
    end
    TriggerServerEvent("mosrow:setfaim", faim)
end

function SetSoif(water)
    soif = water
    TriggerServerEvent("mosrow:SetSoif", soif)
end
function AddWater(water)
    if soif == 100 then
        return
    end
    if soif + water <= 100 then
        soif = soif + water
    else
        soif = 100
    end
    TriggerServerEvent("mosrow:SetSoif", soif)
end

function RemoveWater(water)
    if soif == 0 then
        return
    end
    if soif - water >= 0 then
        soif = soif - water
    else
        soif = 0
    end
    if soif <= 10 and soif > 0 then
        ShowNotification("Vous avez soif \n~g~vous devez boire")
    elseif soif == 0 then
        SetEntityHealth(PlayerPedId(), 0)
    end
    TriggerServerEvent("mosrow:SetSoif", soif)
end

local firstspawn = 0
AddEventHandler(
    "playerSpawned",
    function(spawn)
        if firstspawn == 0 then
            firstspawn = 1
        end
    end
)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterNetEvent("mosrow:AddCalories")
AddEventHandler(
    "mosrow:AddCalories",
    function(calories)
        AddCalories(calories)
    end
)

RegisterNetEvent("mosrow:AddWater")
AddEventHandler(
    "mosrow:AddWater",
    function(water)
        AddWater(water)
        --	--print(water)
    end
)

RegisterNetEvent("mosrow:Death")
AddEventHandler(
    "mosrow:Death",
    function()
        setfaim(50)
        SetSoif(50)
    end
)

local function drawRct(x, y, width, height, r, g, b, a)
    DrawRect(x + width / 2, y + height / 2, width, height, r, g, b, a)
end
local HUD = true
AddEventHandler(
    "displayNourriture",
    function(H)
        HUD = H
    end
)

exports("GetPlayerHUD", function() return HUD end)
exports("GetPlayerBars", function() return {faim, soif} end)
exports("SetPlayerHUD", function(bool) HUD = bool end)
exports("ToggleDrain", function(bool) canDrain = bool end)
exports(
    "InitHungerThirst",
    function(faim, soif)
        setfaim(faim)
        SetSoif(soif)
    end
)

local HUDtype = 1
AddEventHandler(
    "DisplayThisHUD",
    function(it)
        HUDtype = tonumber(it)
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            while (GetResourceState("Atlantiss") ~= "started") do Wait(50) end
            ResetScriptGfxAlign()
            --	--print(soif,faim)

            --	drawRct(0.013, 0.770,105/704,0.0425,0,0,0,200)
            if HUD then
                if HUDtype == 1 then
                    drawRct(0.0155, 0.793, 0.069, 0.01, 255, 216, 0, 70) -- Deux petites lignes au dessus de la map jaune
                    drawRct(0.0155, 0.793, faim / 1440, 0.01, 255, 216, 0, 150)
                    drawRct(0.0865, 0.793, 0.069, 0.01, 0, 194, 211, 70)
                    drawRct(0.0865, 0.793, soif / 1440, 0.01, 0, 194, 211, 150)
                elseif HUDtype == 2 then
                    drawRct(0.0155, 0.793, 0.069, 0.01, 165, 0, 255, 70) -- Deux petites lignes au dessus de la map violet
                    drawRct(0.0155, 0.793, faim / 1440, 0.01, 165, 0, 255, 150)
                    drawRct(0.0865, 0.793, 0.069, 0.01, 0, 194, 211, 70)
                    drawRct(0.0865, 0.793, soif / 1440, 0.01, 0, 194, 211, 150)
                elseif HUDtype == 3 then
                    drawRct(0.0155, 0.793, 0.069, 0.01, 52,177,74, 70) -- Deux petites lignes au dessus de la map vert
                    drawRct(0.0155, 0.793, faim / 1440, 0.01, 52,177,74, 150)
                    drawRct(0.0865, 0.793, 0.069, 0.01, 0, 194, 211, 70)
                    drawRct(0.0865, 0.793, soif / 1440, 0.01, 0, 194, 211, 150)
                elseif HUDtype == 4 then
                    drawRct(0.0155, 0.793, 0.069, 0.01, 244, 5, 82, 70) -- Deux petites lignes au dessus de la map rouge
                    drawRct(0.0155, 0.793, faim / 1440, 0.01, 244, 5, 82, 150)
                    drawRct(0.0865, 0.793, 0.069, 0.01, 0, 194, 211, 70)
                    drawRct(0.0865, 0.793, soif / 1440, 0.01, 0, 194, 211, 150)
                elseif HUDtype == 5 then
                    drawRct(0.015, 0.985, 0.069, 0.009, 244, 5, 82, 70) -- Deux petites lignes en dessous de la map
                    drawRct(0.015, 0.985, faim / 1440, 0.009, 244, 5, 82, 150)
                    drawRct(0.0865, 0.985, 0.069, 0.009, 0, 194, 211, 70)
                    drawRct(0.0865, 0.985, soif / 1440, 0.009, 0, 194, 211, 150)
                elseif HUDtype == 6 then
                    drawRct(0.015, 0.780, 0.1405, 0.015, 244, 5, 82, 90) -- Base blue and red bar 
                    drawRct(0.015, 0.780, faim / 704, 0.015, 244, 5, 82, 90)
                    drawRct(0.015, 0.795, 0.1405, 0.015, 0, 194, 211, 90)
                    drawRct(0.015, 0.795, soif / 704, 0.015, 0, 194, 211, 90)
                elseif HUDtype == 7 then
                    drawRct(0.015, 0.780, 0.1405, 0.015, 246, 141, 23, 100) -- Base
                    drawRct(0.015, 0.780, faim / 704, 0.015, 246, 141, 23, 190)
                    drawRct(0.015, 0.795, 0.1405, 0.015, 84, 163, 199, 100)
                    drawRct(0.015, 0.795, soif / 704, 0.015, 84, 163, 199, 190)
                end

            end
            if soif < 1 or faim < 1 then
                SetEntityHealth(PlayerPedId(), 0)
                setfaim(50)
                SetSoif(50)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            TriggerEvent("updateStatus", soif, faim)
        end
    end
)

local item = nil

RegisterNetEvent("miam:Drink")
AddEventHandler(
    "miam:Drink",
    function(item, Items)
        TriggerServerEvent("removeItem", item.id, item.name)
        items = Items[item.name]
        --DrinkSomething(items)
        if items.soif ~= nil then
            DrinkSomething()
        else
            EatSomething(items)
        end
    end
)

local alreadyOnCoke = false

RegisterNetEvent("drug:Coke")
AddEventHandler(
    "drug:Coke",
    function(item, Items)
        if (alreadyOnCoke == false) then
            ShowNotification(
                "~g~Vous avez consommé de la cocaine ! Vous êtes moins sensible a la douleur pendant 5 minutes~w~"
            )
            ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.4)
            StartScreenEffect("Rampage", 1000 * 60 * 5, true)

            local playerPed = PlayerPedId()
            TriggerServerEvent("atlantiss_status:addOn", "coke")

            StatSetInt(GetHashKey("MP0_STAMINA"), 30, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 30, true)
            SetRunSprintMultiplierForPlayer(player, 1.2)
            SetSwimMultiplierForPlayer(player, 1.2)
            SetPedArmour(playerPed, GetPedArmour(playerPed) + 65)

            alreadyOnCoke = true
            Citizen.Wait(1000 * 60 * 5)
            alreadyOnCoke = false

            StopScreenEffect("Rampage")
            StopGameplayCamShaking(false)

            SetPedArmour(playerPed, GetPedArmour(playerPed) - 65)
            StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 0, true)
            SetRunSprintMultiplierForPlayer(player, 1.0)
            SetSwimMultiplierForPlayer(player, 1.0)
        else
            ShowNotification(
                "~r~Vous avez déjà consommé de la cocaine ! Vous voulez faire une overdose. Vous avez perdu un pochon~w~"
            )
        end
    end
)

local alreadyOnMeth = false

RegisterNetEvent("drug:Meth")
AddEventHandler(
    "drug:Meth",
    function(item, Items)
        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.2)
        StartScreenEffect("ChopVision", 1000 * 60 * 3, true)

        if (alreadyOnMeth == false) then
            ShowNotification(
                "~g~Vous avez consommé de la meth ! Vous êtes moins sensible a la douleur pendant 3 minutes~w~"
            )
            local playerPed = PlayerPedId()
            TriggerServerEvent("atlantiss_status:addOn", "meth")
            StatSetInt(GetHashKey("MP0_STAMINA"), 20, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 20, true)
            SetRunSprintMultiplierForPlayer(playerPed, 1.1)
            SetSwimMultiplierForPlayer(playerPed, 1.1)
            SetPedArmour(playerPed, GetPedArmour(playerPed) + 45)

            alreadyOnMeth = true
            Citizen.Wait(1000 * 60 * 3)
            alreadyOnMeth = false

            StopScreenEffect("ChopVision")
            StopGameplayCamShaking(false)

            SetPedArmour(playerPed, GetPedArmour(playerPed) - 45)
            StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 0, true)
            SetRunSprintMultiplierForPlayer(playerPed, 1.0)
            SetSwimMultiplierForPlayer(playerPed, 1.0)
        else
            ShowNotification(
                "~r~Vous avez déjà consommé de la meth ! Vous voulez faire une overdose. Vous avez perdu un pochon~w~"
            )
        end
    end
)

local alreadyOnWeed = false

RegisterNetEvent("drug:Weed")
AddEventHandler(
    "drug:Weed",
    function(item, Items)
        local playerPed = PlayerPedId()

        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.2)
        StartScreenEffect("DrugsMichaelAliensFight", 1000 * 60 * 5, true)

        if (alreadyOnWeed == false) then
            TriggerServerEvent("atlantiss_status:addOn", "weed")

            ShowNotification("~g~Vous avez consommé de la weed !~w~")
            ShowNotification(
                "~g~Vous êtes moins sensible a la douleur pendant 5 minutes mais vous êtes moins rapide~w~"
            )

            StatSetInt(GetHashKey("MP0_STAMINA"), 10, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 10, true)
            SetRunSprintMultiplierForPlayer(playerPed, 0.7)
            SetSwimMultiplierForPlayer(playerPed, 0.7)
            SetPedArmour(playerPed, GetPedArmour(playerPed) + 30)

            alreadyOnWeed = true
            Citizen.Wait(1000 * 60 * 5)
            alreadyOnWeed = false

            StopScreenEffect("DrugsMichaelAliensFight")
            StopGameplayCamShaking(false)

            SetPedArmour(playerPed, GetPedArmour(playerPed) - 30)
            StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 0, true)
            SetRunSprintMultiplierForPlayer(playerPed, 1.0)
            SetSwimMultiplierForPlayer(playerPed, 1.0)
        else
            ShowNotification(
                "~r~Vous avez déjà consommé de la weed ! Vous voulez faire une overdose. Vous avez perdu un pochon~w~"
            )
        end
    end
)

function Drunk(level, start)
    Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)

        if start then
            DoScreenFadeOut(800)
            Wait(1000)
        end

        if level == 1 then
            RequestAnimSet("move_m@drunk@slightlydrunk")
            while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
                Wait(0)
            end
            SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
        elseif level == 2 then
            RequestAnimSet("move_m@drunk@moderatedrunk")
            while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
                Wait(0)
            end
            SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
        elseif level == 3 then
            RequestAnimSet("move_m@drunk@verydrunk")
            while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
                Wait(0)
            end
            SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
        end

        SetTimecycleModifier("spectator5")
        SetPedMotionBlur(playerPed, true)
        SetPedIsDrunk(playerPed, true)

        if start then
            DoScreenFadeIn(800)
        end
    end)

end

function BackToReality()
    Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)

        DoScreenFadeOut(800)
        Wait(1000)

        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(playerPed, 0)
        SetPedIsDrunk(playerPed, false)
        SetPedMotionBlur(playerPed, false)

        DoScreenFadeIn(800)
    end)
end

local IsAlreadyDrunk = false
local alcPercentage = 0

AddEventHandler("DrinkingAlcohol", function(_drinkingVal)
    Wait(10000)
    local drinkingVal = _drinkingVal
    local level = 0

    if drinkingVal <= 3 then
        alcPercentage = alcPercentage + 5
    elseif drinkingVal <= 6 then
        alcPercentage = alcPercentage + 10
    elseif drinkingVal <= 8 then
        alcPercentage = alcPercentage + 15
    else
        alcPercentage = alcPercentage + 20
    end

    if alcPercentage >= 100 then return end

    if alcPercentage <= 40 then
        level = 1
    elseif alcPercentage > 40 and alcPercentage <= 60 then
        level = 2
    elseif alcPercentage > 60 then
        level = 3
    end

    if not IsAlreadyDrunk and alcPercentage >= 30 then 
        IsAlreadyDrunk = true
        Drunk(level, true)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(6500)
        if IsAlreadyDrunk then
            if alcPercentage == 0 then
                BackToReality()
                IsAlreadyDrunk = false
            elseif alcPercentage <= 40 then
                alcPercentage = alcPercentage - 1
                Drunk(1, false)
            elseif alcPercentage > 40 and alcPercentage <= 60 then
                alcPercentage = alcPercentage - 1
                Drunk(2, false)
            elseif alcPercentage > 60 then
                alcPercentage = alcPercentage - 1
                Drunk(3, false)
            end
        end
    end
end)

local prop = nil
function EatSomething(items)
    DeleteEntity(prop)
    local prop_name = items.props
    IsAnimated = true
    local playerPed = PlayerPedId()
    Citizen.CreateThread(
        function()
            local x, y, z = table.unpack(GetEntityCoords(playerPed))
            exports["Ora"]:TriggerServerCallback("Atlantiss::SE::Anticheat:RegisterObject", 
                function()
                    prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
                    AttachEntityToEntity(
                        prop,
                        playerPed,
                        GetPedBoneIndex(playerPed, 18905),
                        0.12,
                        0.028,
                        0.001,
                        10.0,
                        175.0,
                        0.0,
                        true,
                        true,
                        false,
                        true,
                        1,
                        true
                    )
                    RequestAnimDict("mp_player_inteat@burger")
                    while not HasAnimDictLoaded("mp_player_inteat@burger") do
                        Wait(0)
                    end
                    TaskPlayAnim(
                        playerPed,
                        "mp_player_inteat@burger",
                        "mp_player_int_eat_burger_fp",
                        8.0,
                        -8,
                        -1,
                        49,
                        0,
                        0,
                        0,
                        0
                    )
                    Wait(3000)
                    IsAnimated = false
                    ClearPedSecondaryTask(playerPed)
                    DeleteObject(prop)
                end,
                GetHashKey(prop_name)
            )
        end
    )
    AddCalories(items.faim)
end

function DrinkSomething()
    DeleteEntity(prop)
    local prop_name = items.props
    IsAnimated = true
    local playerPed = PlayerPedId()
    Citizen.CreateThread(
        function()
            local x, y, z = table.unpack(GetEntityCoords(playerPed))
            exports["Ora"]:TriggerServerCallback("Atlantiss::SE::Anticheat:RegisterObject", 
                function()
                    prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
                    AttachEntityToEntity(
                        prop,
                        playerPed,
                        GetPedBoneIndex(playerPed, 18905),
                        0.12,
                        0.030,
                        0.010,
                        -85.0,
                        175.0,
                        0.0,
                        true,
                        true,
                        false,
                        true,
                        1,
                        true
                    )
                    RequestAnimDict("mp_player_intdrink")
                    while not HasAnimDictLoaded("mp_player_intdrink") do
                        Wait(0)
                    end
                    TaskPlayAnim(playerPed, "mp_player_intdrink", "loop_bottle", 8.0, -8, -1, 49, 0, 0, 0, 0)
                    Wait(3000)
                    IsAnimated = false
                    ClearPedSecondaryTask(playerPed)
                    DeleteObject(prop)
                end,
                GetHashKey(prop_name)
            )
        end
    )
    AddWater(items.soif)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(10000)
            --print(soif,faim)
            TriggerServerEvent("savefood", soif, faim)
            TriggerEvent("updateStatus", soif, faim)
        end
    end
)