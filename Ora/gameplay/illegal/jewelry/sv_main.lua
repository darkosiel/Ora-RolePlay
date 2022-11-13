-----------------------------
--- Made by @Naytoxp#2134 ---
---   Released to OraRP   ---
-----------------------------


local isRobberyInProgress = false
local PlayersRewards      = {}

-- Initialize the math.random (http://lua-users.org/wiki/MathLibraryTutorial)
math.randomseed(os.time());
math.random();
math.random();
math.random()

if isDev then
    RegisterCommand("printRewards", function(source)
        print(source)
        print(("---- Récompenses de %s ----"):format(GetPlayerName(source)))
        for k, v in pairs(PlayersRewards[source]) do
            print(v.l, v.n, v.e.r)
        end
        print(("---- Fin des récompenses de %s ----"):format(GetPlayerName(source)))
    end)

    RegisterCommand("stopRobbery", function(source)
        isRobberyInProgress = false
        TriggerClientEvent("jewellery_heist:stopTheAlarm", -1)
    end)
end

local function SaveLastTimeRobbery(time)
    lastTimeRobbery = os.time()
    SetResourceKvp("lastTimeRobbery", lastTimeRobbery)
end

local function GetLastTimeRobbery()
    local result = GetResourceKvpString("lastTimeRobbery")
    if result == nil then
        result = 0
    end
    if isDev then
        --print(("Last robbery time: %s"):format(result))
        result = 0
    end
    return result
end

---------------------------------
---- Cop's related functions ----
---------------------------------
--- TODO : Make the function to check if a player is a cop
local function IsPlayerCop(source)
    return true
end

function checkIfThereIsEnoughCops()
    local nbCops = 0
    local nbCops = Ora.Service:GetTotalServiceCountForJobs({"police", "lssd"})
    print(("Il y a %s policiers en service"):format(nbCops))
    print(("Il faut %s policiers en service"):format(Ora.Illegal:GetCopsRequired("jewelry")))
    return nbCops >= Ora.Illegal:GetCopsRequired("jewelry")
end

function AlertCops()
    print("Alerting the cops")
    local message = "Bijouterie Vangelico : l'alarme a été déclanchée."
    local coords  = C.VangelicoCoords
    
    TriggerEvent(
        "call:makeCall2",
        "police",
        {x = C.Alert.Coords.x, y = C.Alert.Coords.y, z = C.Alert.Coords.z},
        "\n" .. C.Alert.Message,
        "Bijouterie Vangelico"
    )
    TriggerEvent(
        "call:makeCall2",
        "lssd",
        {x = C.Alert.Coords.x, y = C.Alert.Coords.y, z = C.Alert.Coords.z},
        "\n" .. C.Alert.Message,
        "Bijouterie Vangelico"
    )

end

function ResetAlarmByCop(source)
    if IsPlayerCop(source) then
        print(("Resetting the alarm (%s - %s)"):format(GetPlayerName(source), source))
        TriggerClientEvent("jewellery_heist:stopTheAlarm", -1)
        isRobberyInProgress = false
    end
end

RegisterServerEvent("jewellery_heist:copResetsAlarm", function()
    ResetAlarmByCop(source)
end)

function StartAlarmAndGas(source)
    local source        = source or -1
    local gasMultiplier = 1
    for k, v in pairs(GasCanCutted) do
        if v == true then
            gasMultiplier = gasMultiplier - 0.5
        end
    end
    print("Gas multiplier = " .. gasMultiplier)
    TriggerClientEvent("jewellery_heist:startAlarm", source, gasMultiplier)
end

---------------------------------------------------------
---- Cutting gas canned on the roof of the vangelico ----
---------------------------------------------------------
GasCanCutted = {}
RegisterServerEvent("jewellery_heist:cut_gas", function(canId)
    print("Player #" .. source .. " is cutting the gas")
    GasCanCutted[canId] = true
end)

RegisterCommand("cutGas", function(source)
    if getDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(source)), vector3(-622.3212890625, -242.30813598633, 55.656867980957)) <= 1.5 then
        TriggerEvent("jewellery_heist:cut_gas", 1)
        print(source .. " a bouché une bouteille de gaz")
    end
    if getDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(source)), vector3(-628.32397460938, -226.48760986328, 55.901142120361)) <= 1.5 then
        TriggerEvent("jewellery_heist:cut_gas", 2)
        print(source .. " a bouché une bouteille de gaz")
    end
end)

-----------------------------------
---- Robbery related functions ----
-----------------------------------

local function CalculatesRewards(caseId)
    local type = C.Cases[caseId].Type
    print(caseId, type)
    local probabilitiesOfThisCaseType = rewardsProbability[type]

    local prob_quantity_of_items      = probabilitiesOfThisCaseType.quantity_of_items
    local qty
    local prob_qty                    = math.random(0, 10000) / 10000
    for k, v in pairs(prob_quantity_of_items) do
        if prob_qty <= v then
            qty = k
        end
    end

    local items   = probabilitiesOfThisCaseType.items

    local rewards = {}
    for i = 1, qty do
        local prob_item = math.random(0, 10000) / 10000
        local item, item_index
        for k, v in pairs(items) do
            if prob_item <= v.probability then
                item       = v.name
                item_index = k
            end
        end
        -- for i = 1, 
            rewards[i]        = Items[item]
            rewards[i].name = item

        local rarety_prob = math.random(0, 10000) / 10000
        for k, v in pairs(items[item_index].rarety_probability) do
            if rarety_prob <= v then
                rewards[i].data = { rarety = k }
            end
        end
    end

    if PlayersRewards[source] == nil then
        PlayersRewards[source] = {}
    end

    for k, v in pairs(rewards) do
        table.insert(PlayersRewards[source], v)
        print(json.encode(v))
    end

    return rewards
end

----------------
---- Events ----
----------------
RegisterServerEvent("jewellery_heist:askForConfigData", function()
    print(source .. " asked for config data")
    TriggerClientEvent("jewellery_heist:receiveConfigData", source, json.encode(C.Cases))
    if isRobberyInProgress then
        print("Uptated state of the alarm to player #" .. source)
        StartAlarmAndGas(source)
        TriggerClientEvent("jewellery_heist:startAlarm", source)
    end
end)

--- Robbery
RegisterServerEvent("jewellery_heist:brokenCase:Request", function(caseId, coords)
    local pCoords = GetEntityCoords(GetPlayerPed(source))

    -- If the jewellery was robbed recently, don't allow the player to break the case
    if not isRobberyInProgress and os.time() - GetLastTimeRobbery() < C.TimeBetweenRobberies then
        TriggerClientEvent("jewellery_heist:alreadyRobbed", source)
        return
    end
    -- If there isn't enough cops, don't allow the player to break the case
    if not checkIfThereIsEnoughCops() then
        print("Not enough cops to break the case")
        TriggerClientEvent("jewellery_heist:notEnoughCops", source)
        return
    end

    if C.Cases[caseId] ~= {} and C.Cases[caseId] ~= nil then
        v = C.Cases[caseId]
        if coords == v.Coords_1 then
            if getDistanceBetweenCoords(coords, pCoords) <= 1.5 then
                print("Player #" .. source .. " is breaking the case #" .. caseId)
                TriggerClientEvent("jewellery_heist:brokenCase:Allow", source, caseId)
            end
        else
            print(("Coords doesn't match. The player is probably cheating. (Player id : %s, CaseId : [%s], Coords : [%s])"):format(source, caseId, coords))
        end
    else
        print(("Case ID doesn't match. The player is probably cheating. (Player id : %s, CaseId : [%s], Coords : [%s])"):format(source, caseId, coords))
    end

    for k, v in pairs(C.Cases) do
    end

    if not isRobberyInProgress then
        isRobberyInProgress = true
        SaveLastTimeRobbery()
        StartAlarmAndGas()
        Citizen.Wait(C.WaitToCallCops)
        AlertCops()
    end
end)

RegisterServerEvent("jewellery_heist:brokenCase:Done", function(caseId)
    local source = source
    print("Player #" .. source .. " is done with the case #" .. caseId)
    C.Cases[caseId].Broken = true
    TriggerClientEvent("jewellery_heist:updateCase", -1, caseId)

    -- Give the objects to the player
    local rewards = CalculatesRewards(caseId)
    -- Drops items one by one
    TriggerClientEvent("Ora::CE::Inventory:AddItems", source, rewards)
    rewards = nil
    collectgarbage()
end)



-----------------------------
--- Made by @Naytoxp#2134 ---
---   Released to OraRP   ---
-----------------------------