local depecWeps = {-1716189206, 2227010557, 2460120199, 4191993645, 3756226112, 3441901897}
local allowedPeds = {
    ["1596003233"] = true, -- inmate
    ["-1313105063"] = true, -- inmate
    ["1456041926"] = true -- cell guard
}
local huntedPeds = {}
local Keys = {
    ["K"] = 311
}

local searchableItems = {
    344662182,
    -1322183878,
    -1685625437,
    -1738103333,
    1165008631,
    493845300,
    -2007495856,
    -77338465,
    -686494084,
    -259008966
}

local currentPrisonner = 0
local prisonnerCoords = {
    {position = vector3(1654.19, 2532.06, 45.56 - 0.98), heading = 79.0},
    {position = vector3(1641.81, 2517.1, 45.56 - 0.98), heading = 348.78},
    {position = vector3(1631.35, 2526.05, 45.56 - 0.98), heading = 269.2},
    {position = vector3(1643.76, 2540.78, 45.56 - 0.98), heading = 181.05},
    {position = vector3(1649.25, 2538.9, 45.56 - 0.98), heading = 278.64},
    {position = vector3(1656.28, 2547.4, 45.56 - 0.98), heading = 187.77},
    {position = vector3(1652.87, 2543.28, 45.56 - 0.98), heading = 231.16},
    {position = vector3(1616.47, 2528.84, 45.56 - 0.98), heading = 248.96},
    {position = vector3(1618.55, 2520.74, 45.56 - 0.98), heading = 332.57},
    {position = vector3(1630.11, 2525.95, 45.56 - 0.98), heading = 106.06}
}

local femaleFix = {
    ["WORLD_HUMAN_BUM_WASH"] = {"amb@world_human_bum_wash@male@high@idle_a", "idle_a"},
    ["WORLD_HUMAN_SIT_UPS"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a"},
    ["WORLD_HUMAN_PUSH_UPS"] = {"amb@world_human_push_ups@male@base", "base"},
    ["WORLD_HUMAN_BUM_FREEWAY"] = {"amb@world_human_bum_freeway@male@base", "base"},
    ["WORLD_HUMAN_CLIPBOARD"] = {"amb@world_human_clipboard@male@base", "base"},
    ["WORLD_HUMAN_VEHICLE_MECHANIC"] = {"amb@world_human_vehicle_mechanic@male@base", "base"}
}

Citizen.CreateThread(
    function()
        while true do
            Wait(1000 * 10)
            local pedCoords = LocalPlayer().Pos
            if (GetNameOfZone(pedCoords.x, pedCoords.y, pedCoords.z) == "JAIL") then
                currentPrisonner = 0
                for ped in EnumeratePeds() do
                    local entityModel = GetEntityModel(ped)

                    if (entityModel == -1313105063 or entityModel == 1596003233) then
                        currentPrisonner = currentPrisonner + 1
                    end
                end

                if (currentPrisonner < 10) then
                    RequestModel(GetHashKey("s_m_y_prisoner_01"))

                    while not HasModelLoaded(GetHashKey("s_m_y_prisoner_01")) do
                        Citizen.Wait(50)
                    end

                    local pedsToSpawn = 10 - currentPrisonner
                    for i = 1, pedsToSpawn, 1 do
                        local prisonnerPosition = prisonnerCoords[i]
                        local prisonnerPed = Ora.World.Ped:Create(5, "s_m_y_prisoner_01", vector3(prisonnerPosition.position.x, prisonnerPosition.position.y, prisonnerPosition.position.z),  prisonnerPosition.heading)
                        TaskWanderInArea(prisonnerPed, prisonnerPosition.position.x, prisonnerPosition.position.y, prisonnerPosition.position.z, 150.0, 20.0, 25000.0)
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        local waitTime = 5000
        while true do
            Wait(waitTime)
            local pedCoords = LocalPlayer().Pos
            local nameOfZone = GetNameOfZone(pedCoords.x, pedCoords.y, pedCoords.z)
            if (nameOfZone == "JAIL") then
                waitTime = 0
                local ent = GetClosestPed(pedCoords, 3.0)
                mdl = ent and tostring(GetEntityModel(ent))

                if
                    ent and DoesEntityExist(ent) and IsEntityDead(ent) and not tableHasValue(huntedPeds, ent) and
                        allowedPeds[mdl]
                 then
                    local entCoords = GetEntityCoords(ent)
                    DrawText3D(
                        entCoords.x,
                        entCoords.y,
                        entCoords.z + 0.98,
                        "appuyez sur ~h~[K]~h~ pour fouiller le corps"
                    )
                end

                local nearItem, propsItem = isNearSearchableItem()
                local isTrash = false
                if (nearItem == true and not tableHasValue(huntedPeds, propsItem)) then
                    local entCoords = GetEntityCoords(propsItem)
                    DrawText3D(
                        entCoords.x,
                        entCoords.y,
                        entCoords.z + 0.98,
                        "appuyez sur ~h~[K]~h~ pour fouiller l'objet"
                    )
                    isTrash = true
                end

                local ped = LocalPlayer().Ped
                local doAdmin = false

                if IsControlJustPressed(1, Keys["K"]) then
                    if isTrash == true then
                        if propsItem and DoesEntityExist(propsItem) and not tableHasValue(huntedPeds, propsItem) then
                            table.insert(huntedPeds, propsItem)
                            isTrash = false
                            doAdmin = true
                        end
                    else
                        local ent = GetClosestPed(pedCoords, 3.0)
                        if ent and DoesEntityExist(ent) and IsEntityDead(ent) and not tableHasValue(huntedPeds, ent) then
                            table.insert(huntedPeds, ent)
                            SetEntityAsNoLongerNeeded(ent)
                            doAdmin = true
                            TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = ent, network_id = NetworkGetNetworkIdFromEntity(ent), seconds = 30})
                        end
                    end

                    if (doAdmin == true) then
                        doAnim({"missexile3", "ex03_dingy_search_case_a_michael"})
                        local mdl = ent and tostring(GetEntityModel(ent))
                        Citizen.Wait(10000)
                        math.randomseed(GetGameTimer() * math.random(5000, 10000))
                        local chanceToFind = math.random(1, 10)
                        math.randomseed(GetGameTimer() * math.random(5000, 10000))

                        if (chanceToFind > 3) then
                            local whatToFind = math.random(1, 100)
                            if (whatToFind < 60) then
                                Ora.Inventory:AddItem({name = "info"})
                            elseif (whatToFind < 75) then
                                Ora.Inventory:AddItem({name = "info2"})
                            elseif (whatToFind < 90) then
                                Ora.Inventory:AddItem({name = "info3"})
                            elseif (whatToFind < 95) then
                                Ora.Inventory:AddItem({name = "info4"})
                            elseif (whatToFind < 98) then
                                Ora.Inventory:AddItem({name = "chocolat"})
                            elseif (whatToFind < 99) then
                                Ora.Inventory:AddItem({name = "cigarette"})
                            else
                                math.randomseed(GetGameTimer() * math.random(5000, 10000))
                                local chanceToFind2 = math.random(1, 10)

                                if (chanceToFind2 == 6) then
                                    Ora.Inventory:AddItem({name = "beer"})
                                end

                                if (chanceToFind2 == 7) then
                                    Ora.Inventory:AddItem({name = "weed_pooch"})
                                end

                                if (chanceToFind2 == 8) then
                                    Ora.Inventory:AddItem({name = "meth"})
                                end

                                if (chanceToFind2 == 9) then
                                    Ora.Inventory:AddItem({name = "coke1"})
                                end

                                if (chanceToFind2 == 10) then
                                    Ora.Inventory:AddItem({name = "tel", data = {num = 777 .. math.random(1111, 9999)}})
                                end
                            end
                        else
                            ShowNotification("~h~~r~Vous n'avez rien trouvé~s~")
                        end
                    end
                end
            else
                waitTime = 5000
            end
        end
    end
)

function isNearSearchableItem()
    local found = false
    local _obj = false
    local plyPos = LocalPlayer().Pos
    for k, v in pairs(searchableItems) do
        local obj = GetClosestObjectOfType(plyPos, 3.0, v, false, true, true)
        local objCoords = GetEntityCoords(obj)
        if (GetNameOfZone(objCoords.x, objCoords.y, objCoords.z) == "JAIL") then
            if obj and DoesEntityExist(obj) and GetDistanceBetweenCoords(plyPos, GetEntityCoords(obj), true) < 2.8 then
                found = true
                _obj = obj
                break
            end
        end
    end

    return found, _obj
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
    local handle, myped, veh = FindFirstPed(), LocalPlayer().Ped
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
        args.ped or LocalPlayer().Ped,
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
    ped, flag = ped or LocalPlayer().Ped, flag and tonumber(flag) or false
    if not animName or not animName[1] or string.len(animName[1]) < 1 then
        return
    end
    Citizen.CreateThread(
        function()
            forceAnim(animName, flag, {ped = ped, time = time, pos = customPos})
        end
    )
end
