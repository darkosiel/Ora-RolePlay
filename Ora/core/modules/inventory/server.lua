Ora.Inventory.CanReceiveMatchingTable = {}
Ora.Inventory.CanStealMatchingTable = {}
Ora.Inventory.StoragePlayerMapper = {}

function Ora.Inventory:AddPlayerToStorage(playerId, storageName)
    if self.StoragePlayerMapper[storageName] == nil then
        self.StoragePlayerMapper[storageName] = {}
    end

    self.StoragePlayerMapper[storageName][playerId] = true
end

function Ora.Inventory:RemovePlayerFromStorage(playerId, storageName)
    if self.StoragePlayerMapper[storageName] == nil then
        return false
    end

    if self.StoragePlayerMapper[storageName][playerId] ~= nil then
        self.StoragePlayerMapper[storageName][playerId] = nil
        return true
    end

    return false
end

function Ora.Inventory:RemovePlayerFromAnyStorage(playerId)
    for key, value in pairs(self.StoragePlayerMapper) do
        for storedPlayerId, isInStorage in pairs(self.StoragePlayerMapper[value]) do
            if (storedPlayerId == playerId) then
                self.StoragePlayerMapper[value][storedPlayerId] = nil
                return true
            end
        end
    end

    return false
end

function Ora.Inventory:IsPlayerInStorage(playerId, storageName)
    if self.StoragePlayerMapper[storageName] == nil then
        return false
    end

    if self.StoragePlayerMapper[storageName][playerId] ~= nil then
        return true
    end

    return false
end

function Ora.Inventory:SendRefreshEventToPlayersInStorage(storageName)
    if self.StoragePlayerMapper[storageName] == nil then
        return false
    end

    for playerId, _ in pairs(self.StoragePlayerMapper[storageName]) do
        TriggerClientEvent("Ora::CE::Inventory:RefreshStorage", playerId, {STORAGE_NAME = storageName})
    end

    return false
end

RegisterServerEvent("Ora::SE::Inventory:PopulateCanReceiveResult")
AddEventHandler(
    "Ora::SE::Inventory:PopulateCanReceiveResult",
    function(canReceive, giverPlayer)
        local _source = source
        Ora.Inventory.CanReceiveMatchingTable[giverPlayer .. "_" .. _source] = canReceive
    end
)

RegisterServerCallback(
    "Ora::SE::Inventory:CanReceive",
    function(source, cb, itemName, qty, otherPlayer)
        local _source = source
        Ora.Inventory.CanReceiveMatchingTable[_source .. "_" .. otherPlayer] = nil
        TriggerClientEvent("Ora::CE::Inventory:CanReceive", otherPlayer, itemName, qty, source)

        local maxTry = 50
        local currentTry = 0
        while (Ora.Inventory.CanReceiveMatchingTable[_source .. "_" .. otherPlayer] == nil and currentTry <= maxTry) do
            currentTry = currentTry + 1
            Wait(100)
        end

        if (Ora.Inventory.CanReceiveMatchingTable[_source .. "_" .. otherPlayer] == nil) then
            Ora.Inventory.CanReceiveMatchingTable[_source .. "_" .. otherPlayer] = false
        end
        
        cb(Ora.Inventory.CanReceiveMatchingTable[_source .. "_" .. otherPlayer])
    end
)

RegisterServerEvent("Ora::SE::Inventory:PopulateCanStealResult")
AddEventHandler(
    "Ora::SE::Inventory:PopulateCanStealResult",
    function(canSteal, stealerPlayer)
        local _source = source
        Ora.Inventory:Debug(string.format("Received response for event ^5%s^3 dispatched to ^5%s^3 and response is ^5%s^3", "Ora::CE::Inventory:CanBeStealed", _source, canSteal))     
        Ora.Inventory.CanStealMatchingTable[stealerPlayer .. "_" .. _source] = canSteal
    end
)

RegisterServerCallback(
    "Ora::SE::Inventory:StealIfAvailable",
    function(source, cb, itemData, qty, otherPlayer)
        local _source = source

        Ora.Inventory:Debug(string.format("Received event ^5%s^3", "Ora::SE::Inventory:StealIfAvailable"))     
        Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer] = nil
        Ora.Inventory:Debug(string.format("Dispatching event ^5%s^3 to ^5%s^3", "Ora::CE::Inventory:StealIfAvailable", otherPlayer))     
        TriggerClientEvent("Ora::CE::Inventory:StealIfAvailable", otherPlayer, itemData, qty, source)

        local maxTry = 50
        local currentTry = 0
        while (Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer] == nil and currentTry <= maxTry) do
            Ora.Inventory:Debug(string.format("Waiting response for event ^5%s^3 dispatched to ^5%s^3", "Ora::CE::Inventory:StealIfAvailable", otherPlayer))     
            currentTry = currentTry + 1
            Wait(100)
        end

        if (Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer] == nil) then
            Ora.Inventory:Debug(string.format("Auto set response for callback for event ^5%s^3 dispatched to ^5%s^3 with answer ^5%s^3", "Ora::CE::Inventory:StealIfAvailable", _source, Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer]))     
            Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer] = false
        end
        
        Ora.Inventory:Debug(string.format("Returning callback for event ^5%s^3 dispatched to ^5%s^3 with answer ^5%s^3", "Ora::CE::Inventory:StealIfAvailable", _source, Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer]))     
        cb(Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer])
    end
)

RegisterServerCallback(
    "Ora::SE::Inventory:CanSteal",
    function(source, cb, itemName, qty, otherPlayer)
        local _source = source
        Ora.Inventory:Debug(string.format("Received event ^5%s^3", "Ora::SE::Inventory:CanSteal"))     
        Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer] = nil
        Ora.Inventory:Debug(string.format("Dispatching event ^5%s^3 to ^5%s^3", "Ora::CE::Inventory:CanBeStealed", otherPlayer))     
        TriggerClientEvent("Ora::CE::Inventory:CanBeStealed", otherPlayer, itemName, qty, source)

        local maxTry = 50
        local currentTry = 0
        while (Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer] == nil and currentTry <= maxTry) do
            Ora.Inventory:Debug(string.format("Waiting response for event ^5%s^3 dispatched to ^5%s^3", "Ora::CE::Inventory:CanBeStealed", otherPlayer))     
            currentTry = currentTry + 1
            Wait(100)
        end

        if (Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer] == nil) then
            Ora.Inventory:Debug(string.format("Auto set response for callback for event ^5%s^3 dispatched to ^5%s^3 with answer ^5%s^3", "Ora::CE::Inventory:CanBeStealed", _source, Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer]))     
            Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer] = false
        end
        
        Ora.Inventory:Debug(string.format("Returning callback for event ^5%s^3 dispatched to ^5%s^3 with answer ^5%s^3", "Ora::CE::Inventory:CanBeStealed", _source, Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer]))     
        cb(Ora.Inventory.CanStealMatchingTable[_source .. "_" .. otherPlayer])
    end
)

RegisterServerEvent("Ora::SE::Inventory:AddPlayerToStorage")
AddEventHandler(
    "Ora::SE::Inventory:AddPlayerToStorage",
    function(storageName)
        local _source = source
        Ora.Inventory:AddPlayerToStorage(_source, storageName)
    end
)

RegisterServerEvent("Ora::SE::Inventory:RemovePlayerFromStorage")
AddEventHandler(
    "Ora::SE::Inventory:RemovePlayerFromStorage",
    function(storageName)
        local _source = source
        Ora.Inventory:RemovePlayerFromStorage(_source, storageName)
    end
)

RegisterServerCallback(
    "Ora::SE::Inventory:IsInStorage",
    function(source, cb, storageName)
        cb(Ora.Inventory:IsPlayerInStorage(_source, storageName))
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        local _source = source
        Ora.Inventory:RemovePlayerFromAnyStorage(_source)
    end
)

RegisterServerEvent("Ora::SE::Inventory:SaveInventory")
AddEventHandler("Ora::SE::Inventory:SaveInventory",function(inv, fallbackUuid)
    local _source = source
    local ply = Player.GetPlayer(_source)
    local playerUuid = Ora.Identity:GetUuid(_source)

    if (playerUuid == nil and fallbackUuid ~= nil) then
        playerUuid = fallbackUuid
    end

    if (playerUuid == nil) then 
        return
    end

    if inv == "null" then return end
    if #inv > #json.encode({}) then
        MySQL.Async.fetchAll('SELECT inventory FROM players_inventory WHERE uuid = @uuid', {
            ["@uuid"] = playerUuid
        }, function(result)

            if result[1] == nil then
                MySQL.Async.execute(
                    'INSERT INTO players_inventory (uuid,inventory) VALUES(@uuid,@items)',
                    {
                        ['@uuid'] = playerUuid,
                        ['@items'] = inv
                    }
                )
            end

        end)

        if inv ~= "null" and inv ~= "[]" then 
            MySQL.Async.execute(
                'UPDATE players_inventory SET inventory= @inv where uuid=@uuid',
                {
                        ['@uuid'] = playerUuid,
                        ['@inv'] = inv,
                }
            )
        end
    end
end)

RegisterServerCallback('Ora::SCB::Inventory:GetInventory', function(source, callback)
    local _source = source
    local playerUuid = Ora.Identity:GetUuid(_source)
    --Ora.Inventory:Debug('Trigger SVCB GetInventory from '..source)

    MySQL.Async.fetchAll(
        'SELECT inventory FROM players_inventory WHERE uuid = @uuid',
        {["@uuid"] = playerUuid},
        function(result)
            if result[1] == nil then
                result[1] = {
                    inventory = {}
                }
                
                if playerUuid == nil then
                    local identifier = GetIdentifiers(_source).steam
                    if (identifier ~= nil) then
                        local identifierResults = MySQL.Sync.fetchAll(
                            'SELECT uuid FROM `users` WHERE identifier = @identifier', 
                            {
                                ["@identifier"] = identifier
                            }
                        )

                        if (identifierResults[1] ~= nil) then
                            playerUuid = identifierResults[1].uuid
                        end
                    end
                end

                MySQL.Async.execute(
                    'INSERT INTO players_inventory (uuid,inventory) VALUES(@uuid,@items)',
                    {
                        ['@uuid']   = playerUuid,
                        ['@items'] = json.encode({})

            
                    }
                )
            end
            
            --Ora.Inventory:Debug('Data length fetched from CB: '..#result[1].inventory)
            callback(result[1].inventory)
        end
    )
end)

function Ora.getItemCount(source, cb, itemName, targetID)
    if targetID == nil or targetID == 0 then return cb(false) end
    local count = 0
    local target = Ora.Identity:GetUuid(targetID)

    MySQL.Async.fetchAll(
        'SELECT inventory FROM players_inventory WHERE uuid = @uuid', 
        {
            ["@uuid"] = target
        }, 
        function(result)
            if (result[1] ~= nil) then
                for k, v in pairs(json.decode(result[1].inventory)) do
                    if k == itemName then
                        for _, _ in pairs(v) do
                            count = count + 1
                        end
                        break
                    end
                end
                cb(count)
            else
                cb(false)
            end
        end
    )
end

RegisterServerCallback("Ora::SE::Inventory:GetItemCount", getItemCount)
