local instances = {}
local existOrNot = {}

function GetInstancedPlayers()
    local players = {}

    for k, v in pairs(instances) do
        if (v.players ~= nil) then
            for k2, v2 in ipairs(v.players) do
                players[v2] = true
            end
        end
    end

    return players
end

AddEventHandler(
    "playerDropped",
    function(reason)
        if instances[source] then
            CloseInstance(source)
        end
    end
)

function CreateInstance(type, player, data)
    if (instances[data.property] == nil) then
        instances[data.property] = {
            type = type,
            host = player,
            players = {},
            data = data,
            hash = data.property
        }
    end

    TriggerEvent("instance:onCreate", instances[data.property])
    TriggerClientEvent("instance:onCreate", player, instances[data.property])
    TriggerClientEvent("instance:onInstancedPlayersData", -1, GetInstancedPlayers())
end

function CloseInstance(instance)
    if instances[instance] then
        for i = 1, #instances[instance].players do
            TriggerClientEvent("instance:onClose", instances[instance].players[i])
        end

        instances[instance] = nil

        TriggerClientEvent("instance:onInstancedPlayersData", -1, GetInstancedPlayers())
        TriggerEvent("instance:onClose", instance)
    end
end

function AddPlayerToInstance(instance, player)
    local found = false

    if (instances[instance] == nil) then
        instances[instance] = {}
        instances[instance].players = {}
    end

    for i = 1, #instances[instance].players do
        if instances[instance].players[i] == player then
            found = true
            break
        end
    end

    if not found then
        table.insert(instances[instance].players, player)
    end

    TriggerClientEvent("instance:onEnter", player, instances[instance])

    for i = 1, #instances[instance].players do
        if instances[instance].players[i] ~= player then
            TriggerClientEvent("instance:onPlayerEntered", instances[instance].players[i], instances[instance], player)
        end
    end

    TriggerClientEvent("instance:onInstancedPlayersData", -1, GetInstancedPlayers())
end

function RemovePlayerFromInstance(instance, player)
    if instances[instance] then
        TriggerClientEvent("instance:onLeave", player, instances[instance])

        for i = 1, #instances[instance].players do
            if instances[instance].players[i] == player then
                instances[instance].players[i] = nil
            end
        end

        for i = 1, #instances[instance].players do
            if instances[instance].players[i] ~= player then
                if (instances[instance] ~= nil and instances[instance].players ~= nil and instances[instance].players[i] ~= nil) then
                    TriggerClientEvent(
                        "instance:onPlayerLeft",
                        instances[instance].players[i],
                        instances[instance],
                        player
                    )
                end
            end
        end

        TriggerClientEvent("instance:onInstancedPlayersData", -1, GetInstancedPlayers())
    end
end

function InvitePlayerToInstance(instance, type, player, data)
    TriggerClientEvent("instance:onInvite", player, instance, type, data)
end

RegisterServerEvent("instance:create")
AddEventHandler(
    "instance:create",
    function(type, data)
        CreateInstance(type, source, data)
    end
)

RegisterServerEvent("instance:close")
AddEventHandler(
    "instance:close",
    function()
        CloseInstance(source)
    end
)

RegisterServerEvent("instance:enter")
AddEventHandler(
    "instance:enter",
    function(instance)
        AddPlayerToInstance(instance, source)
    end
)

RegisterServerEvent("instance:leave")
AddEventHandler(
    "instance:leave",
    function(instance)
        RemovePlayerFromInstance(instance, source)
    end
)

RegisterServerEvent("instance:invite")
AddEventHandler(
    "instance:invite",
    function(instance, type, player, data)
        InvitePlayerToInstance(instance, type, player, data)
    end
)

RegisterServerEvent("instance:checkifexist")
AddEventHandler(
    "instance:checkifexist",
    function(data)
        TriggerClientEvent("instance:Exist", source, existOrNot[data])
    end
)

Citizen.CreateThread(
    function()
        while (GetResourceState("Ora") ~= "started") do
            Wait(1000)
        end
        exports["Ora"]:RegisterServerCallback('instance:checkifexistCallback', function(source, cb, propertyName)
            cb(existOrNot[propertyName])
        end)
    end
)

function getSourceFromIdentifier(identifier, cb)
    TriggerEvent(
        "es:getPlayers",
        function(users)
            for k, user in pairs(users) do
                if (user.getIdentifier ~= nil and user.getIdentifier() == identifier) or (user.identifier == identifier) then
                    cb(k)
                    return
                end
            end
        end
    )
    cb(nil)
end
