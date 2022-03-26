---------
---------
--Parow--
---------
---------
---------
---------

local femaleFix = {
    ["WORLD_HUMAN_BUM_WASH"] = {"amb@world_human_bum_wash@male@high@idle_a", "idle_a"},
    ["WORLD_HUMAN_SIT_UPS"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a"},
    ["WORLD_HUMAN_PUSH_UPS"] = {"amb@world_human_push_ups@male@base", "base"},
    ["WORLD_HUMAN_BUM_FREEWAY"] = {"amb@world_human_bum_freeway@male@base", "base"},
    ["WORLD_HUMAN_CLIPBOARD"] = {"amb@world_human_clipboard@male@base", "base"},
    ["WORLD_HUMAN_VEHICLE_MECHANIC"] = {"amb@world_human_vehicle_mechanic@male@base", "base"}
}

local depecWeps = {-1716189206, 2227010557, 2460120199, 4191993645, 3756226112, 3441901897, -581044007, -102973651}
local allowedPeds = {
    ["-664053099"] = 4, -- biche F
    ["1682622302"] = 2, -- coyotte
    ["-541762431"] = 1, -- lapin
    ["307287994"] = 3, -- mountain lion
    ["-745300483"] = 1, -- oiseau
    ["1457690978"] = 1, -- oiseau 2
    ["402729631"] = 1, -- oiseau 3
    ["-1430839454"] = 1, -- faucon
    ["2864127842"] = 1, -- faucon
    ["-50684386"] = 1, -- vache
    ["-832573324"] = 1, -- sanglier
    ["3462393972"] = 1, -- sanglier
    ["-1323586730"] = 1 -- porc
}
local huntedPeds = {}
local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

local function GetClosestPlayer(radius)
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(ped)
        if ped ~= ply then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance =
                GetDistanceBetweenCoords(
                targetCoords["x"],
                targetCoords["y"],
                targetCoords["z"],
                plyCoords["x"],
                plyCoords["y"],
                plyCoords["z"],
                true
            )
            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    if closestDistance <= radius then
        return closestPlayer
    else
        return nil
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(1)

        local pedCoords = GetEntityCoords(PlayerPedId())
        local ent = GetClosestPed(pedCoords, 3.0)
        mdl = ent and tostring(GetEntityModel(ent))
        if ent and DoesEntityExist(ent) and IsEntityDead(ent) and not tableHasValue(huntedPeds, ent) and allowedPeds[mdl] then
            local entCoords = GetEntityCoords(ent)
            DrawText3D(
                entCoords.x,
                entCoords.y,
                entCoords.z + 0.98,
                "appuyez sur ~h~[K]~h~ avec votre couteau en main pour depecer l'animal"
            )
        else
            Wait(500)
        end

        local ped = PlayerPedId()
        if IsControlJustPressed(1, Keys["K"]) and IsPedWeaponReadyToShoot(ped) then
            --print(GetSelectedPedWeapon(ped))
            if not tableHasValue(depecWeps, tonumber(GetSelectedPedWeapon(ped))) then
                --exports["Atlantiss"]:ShowNotification("~r~Vous n'avez pas le matériel necessaire.")
            else
                local ent = GetClosestPed(pedCoords, 3.0)
                if ent and DoesEntityExist(ent) and IsEntityDead(ent) and not tableHasValue(huntedPeds, ent) and GetClosestPlayer(3.0) == nil then
                    FreezeEntityPosition(PlayerPedId(), true)
                    local addToHuntedPed = true
                    doAnim({"missexile3", "ex03_dingy_search_case_a_michael"})
                    local mdl = ent and tostring(GetEntityModel(ent))
                    Citizen.Wait(4000)
                    FreezeEntityPosition(PlayerPedId(), false)
                    if not allowedPeds[mdl] then
                        exports["Atlantiss"]:ShowNotification("~r~Cette viande n'a aucune valeur.")
                    else
                        -- Biche
                        if (mdl == "-664053099") then
                            local loopCounter = 0
                            math.randomseed(GetGameTimer())
                            local maxReward = math.random(5, 10)
                            local addRewards = addRewardsToInventory("meat1", "viande(s) de biche / cerfs(s)", maxReward)
                            DeleteEntity(ent)
                            if (addRewards == false) then
                                addToHuntedPed = false
                            end
                        elseif (mdl == "1682622302") then
                            -- coyotte
                            local loopCounter = 0
                            math.randomseed(GetGameTimer())
                            local maxReward = math.random(2, 4)
                            local addRewards = addRewardsToInventory("meat2", "viande(s) de coyotte", maxReward)
                            DeleteEntity(ent)
                            if (addRewards == false) then
                                addToHuntedPed = false
                            end
                        elseif (mdl == "-541762431") then
                            -- lapin
                            local loopCounter = 0
                            math.randomseed(GetGameTimer())
                            local maxReward = math.random(1, 3)
                            local addRewards = addRewardsToInventory("meat3", "viande(s) de lapin", maxReward)
                            DeleteEntity(ent)
                            if (addRewards == false) then
                                addToHuntedPed = false
                            end
                        elseif (mdl == "307287994") then
                            -- Puma
                            local loopCounter = 0
                            math.randomseed(GetGameTimer())
                            local maxReward = math.random(4, 6)
                            local addRewards = addRewardsToInventory("meat4", "viande(s) de puma", maxReward)
                            DeleteEntity(ent)
                            if (addRewards == false) then
                                addToHuntedPed = false
                            end
                        elseif (mdl == "-745300483" or mdl == "1457690978" or mdl == "402729631" or mdl == "-1430839454" or mdl == "2864127842") then
                            local loopCounter = 0
                            math.randomseed(GetGameTimer())
                            local maxReward = math.random(1, 3)
                            local addRewards = addRewardsToInventory("meat5", "viande(s) d'oiseau", maxReward)
                            DeleteEntity(ent)
                            if (addRewards == false) then
                                addToHuntedPed = false
                            end
                        elseif (mdl == "-1323586730" or mdl == "-832573324" or mdl == "3462393972") then
                            local loopCounter = 0
                            math.randomseed(GetGameTimer())
                            local maxReward = math.random(4, 7)
                            local addRewards = addRewardsToInventory("meat6", "viande(s) de cochon/sanglier", maxReward)
                            DeleteEntity(ent)
                            if (addRewards == false) then
                                addToHuntedPed = false
                            end
                        elseif (mdl == "-50684386") then
                            local loopCounter = 0
                            math.randomseed(GetGameTimer())
                            local maxReward = math.random(8, 12)
                            local addRewards = addRewardsToInventory("meat7", "viande(s) de boeuf/vache", maxReward)
                            DeleteEntity(ent)
                            if (addRewards == false) then
                                addToHuntedPed = false
                            end
                        end
                        if (addToHuntedPed == true) then
                            table.insert(huntedPeds, ent)
                            SetEntityAsNoLongerNeeded(ent)
                        end
                    end
                end
            end
        end
    end
end)

function addRewardsToInventory(itemName, itemLabel, qty)
    local loopCounter = 0

    if (exports["Atlantiss"]:CanReceive(itemName, qty)) then
        while (loopCounter <= qty) do
            exports["Atlantiss"]:AddItem({name = itemName, data = {quality = math.random(50, 99)}})
            loopCounter = loopCounter + 1
        end
        exports["Atlantiss"]:ShowNotification(
            "Vous avez récupéré ~b~" ..
                qty .. "x~w~ de ~g~" .. itemLabel .."~s~."
        )
        return true
    else
        return false
    end
end

---FCT
function tableHasValue(tbl, value, k)
    if not tbl or not value or type(tbl) ~= "table" then
        return
    end
    for _, v in pairs(tbl) do
        if k and v[k] == value or v == value then
            return true, _
        end
    end
end

function GetClosestPed(vector, radius, modelHash, testFunction)
    if not vector or not radius then
        return
    end
    local handle, myped, veh = FindFirstPed(), PlayerPedId()
    local success, theVeh
    repeat
        success, veh = FindNextPed(handle)
        local firstDist = GetDistanceBetweenCoords(GetEntityCoords(veh), vector.x, vector.y, vector.z)
        if
            firstDist < radius and veh ~= myped and (not modelHash or modelHash == GetEntityModel(veh)) and
                (not theVeh or firstDist < GetDistanceBetweenCoords(GetEntityCoords(theVeh), GetEntityCoords(veh))) and
                (not testFunction or testFunction(veh))
         then
            theVeh = veh
        end
    until not success
    EndFindPed(handle)

    return theVeh
end

function forceAnim(animName, flag, args)
    flag, args = flag and tonumber(flag) or false, args or {}
    local ped, time, clearTasks, animPos, animRot, animTime =
        args.ped or PlayerPedId(),
        args.time,
        args.clearTasks,
        args.pos,
        args.ang

    if IsPedInAnyVehicle(ped) and (not flag or flag < 40) then
        return
    end

    if not clearTasks then
        ClearPedTasks(ped)
    end

    if not animName[2] and femaleFix[animName[1]] and GetEntityModel(ped) == -1667301416 then
        animName = femaleFix[animName[1]]
    end

    if animName[2] and not HasAnimDictLoaded(animName[1]) then
        if not DoesAnimDictExist(animName[1]) then
            return
        end
        RequestAnimDict(animName[1])
        while not HasAnimDictLoaded(animName[1]) do
            Citizen.Wait(10)
        end
    end

    if not animName[2] then
        ClearAreaOfObjects(GetEntityCoords(ped), 1.0)
        TaskStartScenarioInPlace(ped, animName[1], -1, not tableHasValue(animBug, animName[1]))
    else
        if not animPos then
            TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, flag or 44, 0, 0, 0, 0, 0)
        else
            TaskPlayAnimAdvanced(
                ped,
                animName[1],
                animName[2],
                animPos.x,
                animPos.y,
                animPos.z,
                animRot.x,
                animRot.y,
                animRot.z,
                8.0,
                -8.0,
                -1,
                flag or 44,
                animTime or -1,
                0,
                0
            )
        end
    end

    if time and type(time) == "number" then
        Citizen.Wait(time)
        ClearPedTasks(ped)
    end

    if not args.dict then
        RemoveAnimDict(animName[1])
    end
end

function doAnim(animName, time, flag, ped, customPos)
    if type(animName) ~= "table" then
        animName = {animName}
    end
    ped, flag = ped or PlayerPedId(), flag and tonumber(flag) or false
    if not animName or not animName[1] or string.len(animName[1]) < 1 then
        return
    end
    Citizen.CreateThread(
        function()
            forceAnim(animName, flag, {ped = ped, time = time, pos = customPos})
        end
    )
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end
