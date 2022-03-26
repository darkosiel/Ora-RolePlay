local weeds = {}

RegisterServerEvent("createWeed")
AddEventHandler(
    "createWeed",
    function(c)
        local p = math.randomseed(os.time())
        local k = GetGameTimer() .. math.random(10000, 99999)
        --print(k)
        weeds[k] = {states = 1, water = 100, purety = 50, percent = 0, fertz = 0, coords = c}
        TriggerClientEvent("createWeed", -1, c, k)
    end
)

RegisterServerEvent("createWeed2")
AddEventHandler(
    "createWeed2",
    function(coords, table)
        local p = math.randomseed(os.time())
        local k = GetGameTimer() .. math.random(10000, 99999)

        weeds[k] = table
        --print("CREATE WEED 2 " .. coords.x, coords.y, coords.z)
        TriggerClientEvent("createWeed2", -1, coords, k, table)
    end
)

RegisterServerEvent("removeWeed")
AddEventHandler(
    "removeWeed",
    function(d)
        weeds[d] = nil
        TriggerClientEvent("removeWeed", -1, d)
    end
)

function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then
        x = math.floor(x + 0.5)
    else
        x = math.ceil(x - 0.5)
    end
    return x / n
end
RegisterServerEvent("editWeed")
AddEventHandler(
    "editWeed",
    function(i, n)
        TriggerClientEvent("editWeed", -1, i, n)
        weeds[i] = n
    end
)

RegisterServerEvent("getWeeds")
AddEventHandler(
    "getWeeds",
    function()
        TriggerClientEvent("weedsARE", source, weeds)
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(40000)
            for k, v in pairs(weeds) do
                v.percent = round(v.percent + ((1 * (((v.fertz + 100) / 100) * 2)) / 1.77), 2)

                if v.percent > 100 then
                    v.percent = 100.0
                end
                if v.percent ~= 100 then
                    local t = (math.random())
                    v.water = round(v.water - t, 2)
                    if v.water < 0 then
                        TriggerClientEvent("removeWeed", -1, k)
                        weeds[k] = nil
                    else
                        TriggerClientEvent("water+percentEdit", -1, k, v.percent, v.water)
                    end
                else
                    TriggerClientEvent("water+percentEdit", -1, k, v.percent, v.water)
                end
            end
        end
    end
)
