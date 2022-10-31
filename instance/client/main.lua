OraAppartment = OraAppartment or  {}

OraAppartment.USERS_LIST_LOADED = false
OraAppartment.USERS_LIST = {}

function OraAppartment.GetOnlineUsers()

    if (OraAppartment.USERS_LIST_LOADED) then
        TriggerServerCallback(
            "onlinePlayers:list",
            function(users)
                OraAppartment.USERS_LIST = users
                OraAppartment.USERS_LIST_LOADED = true
            end
        )
        
        while (OraAppartment.USERS_LIST_LOADED == false) do
            Wait(10)
        end        
    end

    return OraAppartment.USERS_LIST
end

local instance, instancedPlayers, registeredInstanceTypes, playersToHide = {}, {}, {}, {}
local instanceInvite, insideInstance

function GetInstance()
    return instance
end

function CreateInstance(type, data)
    TriggerServerEvent("instance:create", type, data)
end

function CloseInstance()
    instance = {}
    TriggerServerEvent("instance:close")
    insideInstance = false
end

function EnterInstance(instance)
    insideInstance = true

    if (instance.data ~= nil and instance.data.property ~= nil) then
        instanceId = instance.data.property
    else
        instanceId = instance.host
    end

    instance.hash = instanceId
    TriggerServerEvent("instance:enter", instanceId)
    if registeredInstanceTypes[instance.type].enter then
        registeredInstanceTypes[instance.type].enter(instance)
    end
end

function LeaveInstance()
    if instance.hash then
        SetEntityVisible(PlayerPedId(), true, 0)
        SetEntityCollision(PlayerPedId(), true, true)

        exports["Ora"]:TriggerServerCallback(
            "onlinePlayers:list",
            function(users)
                for userId, userValue in pairs(users) do
                    if (NetworkIsPlayerActive(userValue)) then
                        local otherPlayerPed = GetPlayerPed(userValue)
                        SetEntityVisible(otherPlayerPed, true, 0)
                        SetEntityNoCollisionEntity(PlayerPedId(), userValue, false)
                    end
                end
            end, true --to only get players id
        )

        if registeredInstanceTypes[instance.type].exit then
            registeredInstanceTypes[instance.type].exit(instance)
        end

        TriggerServerEvent("instance:leave", instance.hash)
    end

    insideInstance = false
end

function InviteToInstance(type, player, data)
    TriggerServerEvent("instance:invite", instance.hash, type, player, data)
end

function RegisterInstanceType(type, enter, exit)
    registeredInstanceTypes[type] = {
        enter = enter,
        exit = exit
    }
end

AddEventHandler(
    "instance:get",
    function(cb)
        cb(GetInstance())
    end
)

AddEventHandler(
    "instance:create",
    function(type, data)
        CreateInstance(type, data)
    end
)

AddEventHandler(
    "instance:close",
    function()
        CloseInstance()
    end
)

AddEventHandler(
    "instance:enter",
    function(_instance)
        EnterInstance(_instance)
    end
)

AddEventHandler(
    "instance:leave",
    function()
        LeaveInstance()
    end
)

AddEventHandler(
    "instance:invite",
    function(type, player, data)
        InviteToInstance(type, player, data)
    end
)

AddEventHandler(
    "instance:registerType",
    function(name, enter, exit)
        RegisterInstanceType(name, enter, exit)
    end
)

RegisterNetEvent("instance:onInstancedPlayersData")
AddEventHandler(
    "instance:onInstancedPlayersData",
    function(_instancedPlayers)
        instancedPlayers = _instancedPlayers
    end
)

RegisterNetEvent("instance:onCreate")
AddEventHandler(
    "instance:onCreate",
    function(_instance)
        instance = {}
    end
)

RegisterNetEvent("instance:onEnter")
AddEventHandler(
    "instance:onEnter",
    function(_instance)
        instance = _instance
    end
)

RegisterNetEvent("instance:onLeave")
AddEventHandler(
    "instance:onLeave",
    function(_instance)
        instance = {}
    end
)

RegisterNetEvent("instance:onClose")
AddEventHandler(
    "instance:onClose",
    function(_instance)
        instance = {}
    end
)

RegisterNetEvent("instance:onPlayerEntered")
AddEventHandler(
    "instance:onPlayerEntered",
    function(_instance, player)
        instance = _instance
        local playerName = GetPlayerName(GetPlayerFromServerId(player))
    end
)

RegisterNetEvent("instance:onPlayerLeft")
AddEventHandler(
    "instance:onPlayerLeft",
    function(_instance, player)
        instance = _instance
        local playerName = GetPlayerName(GetPlayerFromServerId(player))
    end
)

RegisterNetEvent("instance:onInvite")
AddEventHandler(
    "instance:onInvite",
    function(_instance, type, data)
        instanceInvite = {
            type = type,
            host = _instance,
            data = data
        }

        Citizen.CreateThread(
            function()
                Citizen.Wait(10000)

                if instanceInvite then
                    instanceInvite = nil
                end
            end
        )
    end
)

TriggerEvent(
    "instance:registerType",
    "labos",
    function(instance)
        exports["Ora"]:EnterLabos()
    end,
    function(instance)
        exports["Ora"]:ExitLabos()
    end
)

TriggerEvent(
    "instance:registerType",
    "illegal_property",
    function(instance)
        exports["Ora"]:EnterIllegalProperty()
    end,
    function(instance)
        exports["Ora"]:ExitIllegalProperty()
    end
)

TriggerEvent(
    "instance:registerType",
    "property",
    function(instance)
        exports["Ora"]:EnterAppart()
    end,
    function(instance)
        exports["Ora"]:ExitAppart()
    end
)

RegisterInstanceType("default")

-- Controls for invite
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if instanceInvite then
                if IsControlJustReleased(0, 38) then
                    EnterInstance(instanceInvite)
                    instanceInvite = nil
                end
            else
                Citizen.Wait(500)
            end
        end
    end
)

-- Instance players
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            playersToHide = {}
            if instance.hash then
                -- Get players and sets them as pairs
                for k, v in ipairs(GetActivePlayers()) do
                    playersToHide[GetPlayerServerId(v)] = true
                end

                -- Dont set our instanced players invisible
                for _, player in ipairs(instance.players) do
                    playersToHide[player] = false
                end
            else
                for player, _ in pairs(instancedPlayers) do
                    playersToHide[player] = true
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()

            -- Hide all these players
            for serverId, renderInvisible in pairs(playersToHide) do
                local player = GetPlayerFromServerId(serverId)
                if NetworkIsPlayerActive(player) then
                    local otherPlayerPed = GetPlayerPed(player)

                    if (otherPlayerPed ~= playerPed) then
                        if (renderInvisible == true) then
                            SetEntityVisible(otherPlayerPed, false, 0)
                            SetEntityNoCollisionEntity(playerPed, otherPlayerPed, true)
                        else
                            SetEntityVisible(otherPlayerPed, true, 0)
                            SetEntityNoCollisionEntity(playerPed, otherPlayerPed, false)
                        end
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        TriggerEvent("instance:loaded")
    end
)

-- Fix vehicles randomly spawning nearby the player inside an instance
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0) -- must be run every frame

            if insideInstance then
                SetVehicleDensityMultiplierThisFrame(0.0)
                SetParkedVehicleDensityMultiplierThisFrame(0.0)

                local pos = GetEntityCoords(PlayerPedId())
                RemoveVehiclesFromGeneratorsInArea(
                    pos.x - 900.0,
                    pos.y - 900.0,
                    pos.z - 900.0,
                    pos.x + 900.0,
                    pos.y + 900.0,
                    pos.z + 900.0
                )
            else
                Citizen.Wait(500)
            end
        end
    end
)
