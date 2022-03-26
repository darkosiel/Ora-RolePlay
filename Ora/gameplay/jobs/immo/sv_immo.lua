RegisterServerEvent("core:NewAppartDuSexe")
AddEventHandler(
    "core:NewAppartDuSexe",
    function(bool)
        MySQL.Async.execute(
            "INSERT INTO players_appartement (capacity,name,pos,price,indexx,garagePos,garageMax) VALUES(@capacity,@name,@pos,@price,@index,@garagePos,@maxGrg)",
            {
                ["@capacity"] = bool.max,
                ["@name"] = bool.name,
                ["@pos"] = bool.entry,
                ["@price"] = bool.price,
                ["@index"] = bool.index,
                ["@garagePos"] = bool.garage,
                ["@maxGrg"] = bool.maxGrg
            }
        )
        Wait(500)
        local result = MySQL.Sync.fetchAll("SELECT * FROM players_appartement WHERE name = @name", { ['@name'] = bool.name})
        for i = 1, #result, 1 do
            result[i].time = os.date("%d/%m/%Y %X", result[i].time)
            TriggerClientEvent("add:Appart", -1, result[i])
        end
    end
)
RegisterServerCallback(
    "core:GetSKin",
    function(_source, callback)
        local uuid = Atlantiss.Identity:GetUuid(_source)
        MySQL.Async.fetchAll(
            "SELECT face FROM players_appearance WHERE uuid =@uuid",
            {
                ["@uuid"] = uuid
            },
            function(result)
                callback(result[1].face)
            end
        )
    end
)

RegisterServerCallback(
    "core:GetSKin2",
    function(_source, callback)
        local uuid = Atlantiss.Identity:GetUuid(_source)
        MySQL.Async.fetchAll(
            "SELECT * FROM players_appearance WHERE uuid =@name",
            {
                ["@name"] = uuid
            },
            function(result)
                callback(result[1].face, result[1].model)
            end
        )
    end
)

RegisterServerEvent("appart:remove")
AddEventHandler(
    "appart:remove",
    function(id)
        MySQL.Async.execute(
            "DELETE FROM players_appartement WHERE id=@id",
            {
                ["@id"] = id
            }
        )
        TriggerClientEvent("core:SyncApparts", -1)
    end
)

RegisterServerEvent("appart:updateown")
AddEventHandler(
    "appart:updateown",
    function(targetSrc, id)
        local uuid = Atlantiss.Identity:GetUuid(targetSrc)
        MySQL.Async.execute(
            "UPDATE players_appartement SET owner=@owner where id=@id",
            {
                ["@id"] = id,
                ["@owner"] = uuid,
                ["@time"] = nil
            }
        )
        TriggerClientEvent("core:UpdateOwner", -1, id, uuid)
    end
)
RegisterServerEvent("appart:updateownLoc")
AddEventHandler(
    "appart:updateownLoc",
    function(targetSrc, id, weekRent)
        local uuid = Atlantiss.Identity:GetUuid(targetSrc)
        now = os.time()
        MySQL.Async.fetchAll(
            "SELECT time FROM players_appartement WHERE id=@id",
            {
                ["@id"] = id
            },
            function(result)
                if result[1].time ~= nil then
                    now = result[1].time
                end
                MySQL.Async.execute(
                    "UPDATE players_appartement SET owner=@owner, time = @time where id=@id",
                    {
                        ["@id"] = id,
                        ["@owner"] = uuid,
                        ["@time"] = now + (604800 * weekRent)
                    }
                )
                TriggerClientEvent("core:updateloc", -1, id, uuid, os.date("%d/%m/%Y %X", now + (604800 * weekRent)))
            end
        )
    end
)

RegisterServerEvent("appart:updateownLoc2")
AddEventHandler(
    "appart:updateownLoc2",
    function(id, weekrent)
        now = os.time()
        MySQL.Async.fetchAll(
            "SELECT time FROM players_appartement WHERE id=@id",
            {
                ["@id"] = id
            },
            function(result)
                if result[1].time ~= nil then
                    now = result[1].time
                end
                MySQL.Async.execute(
                    "UPDATE players_appartement SET time = @time where id=@id",
                    {
                        ["@id"] = id,
                        ["@time"] = now + (604800 * weekrent)
                    }
                )
                TriggerClientEvent("core:updateloc2", -1, id, os.date("%d/%m/%Y %X", now + (604800 * weekrent)))
            end
        )
    end
)

RegisterServerEvent("core:RemoveAll")
AddEventHandler(
    "core:RemoveAll",
    function(id)
        MySQL.Async.execute("UPDATE players_appartement SET coowner = NULL WHERE id = @id", {["@id"] = id})

        TriggerClientEvent("core:UpdateCoOwner", -1, id, {})
    end
)

RegisterServerEvent("core:RemoveCoOwner")
AddEventHandler(
    "core:RemoveCoOwner",
    function(targetSrc, id, own)
        local uuid = Atlantiss.Identity:GetUuid(targetSrc)

        for i = 1, #own, 1 do
            if own[i] == uuid then
                own[i] = nil
            end
        end
        MySQL.Async.execute(
            "UPDATE players_appartement SET coowner=@coowner where id=@id",
            {
                ["@id"] = id,
                ["@coowner"] = json.encode(own),
                ["@time"] = nil
            }
        )
        TriggerClientEvent("core:UpdateCoOwner", -1, id, own)
    end
)

RegisterServerEvent("core:AddCoOwner")
AddEventHandler(
    "core:AddCoOwner",
    function(targetSrc, id, own)
        if (own == nil) then
            own = {}
        end
        
        local uuid = Atlantiss.Identity:GetUuid(targetSrc)
        table.insert(own, uuid)

        MySQL.Async.execute(
            "UPDATE players_appartement SET coowner=@coowner where id=@id",
            {
                ["@id"] = id,
                ["@coowner"] = json.encode(own),
                ["@time"] = nil
            }
        )
        TriggerClientEvent("core:UpdateCoOwner", -1, id, own)
    end
)

RegisterServerCallback(
    "appart:requestData",
    function(source, callback)
        local result = MySQL.Sync.fetchAll("SELECT * FROM players_appartement")
        for i = 1, #result, 1 do
            if result[i].time ~= nil then
                result[i].time = os.date("%d/%m/%Y %X", result[i].time)
            end
        end
        callback(result)
    end
)

RegisterServerCallback(
    "appart:doesExists",
    function(s, cb, name)
        MySQL.Async.fetchAll(
            "SELECT name FROM players_appartement WHERE name = @name", 
            {['@name'] = name},
            function(r) cb(r[1] and true or false) end
        )
    end
)

RegisterServerCallback('Atlantiss::SVCB::immo:GetSourcesFromUUID', function(source, callback, currentProperty)
    local result = {}

    for k ,v in pairs(GetALLPLAYERS()) do
        if v.uuid == currentProperty.owner then
            table.insert(result, k)
        end

        if currentProperty.coowner and type(currentProperty.coowner) == "table" and #currentProperty.coowner > 0 then
            for i=1, #currentProperty.coowner do
                if v.uuid == currentProperty.coowner[i] then
                    table.insert(result, k)
                end
            end
        end
    end
    
    Wait(100)
    callback(result)
end)

function CheckAppart()
    local result = MySQL.Sync.fetchAll("SELECT * FROM players_appartement")
    for i = 1, #result, 1 do
        now = os.time()
        if result[i].time ~= nil then
            if now > result[i].time then
                MySQL.Async.execute(
                    "UPDATE players_appartement SET owner=@label, coowner=@label, time=@time where id=@id",
                    {
                        ["@id"] = result[i].id,
                        ["@label"] = nil,
                        ["@time"] = nil
                    }
                )
            end
        end
    end
end

MySQL.ready(
    function()
        CheckAppart()
    end
)
