OraAdmin = OraAdmin or {}
OraAdmin.PLAYERS_SERVERSIDE = {}

function OraAdmin.AddPlayer(id, playerUuid, role, name)
    OraAdmin.PLAYERS_SERVERSIDE[id] = {id = id, uuid = playerUuid, group = role, name = name, ped = NetworkGetNetworkIdFromEntity(GetPlayerPed(id))}
end

function OraAdmin.RemovePlayer(id)
    OraAdmin.PLAYERS_SERVERSIDE[id] = nil
end

function OraAdmin.GetPlayers()
    return OraAdmin.PLAYERS_SERVERSIDE
end

AddEventHandler(
    "playerDropped",
    function(reason)
        local _source = source
        OraAdmin.RemovePlayer(_source)
    end
)

Users = {}

function GetALLPLAYERS()
    return Users
end

function Player.NewPlayerConnected(source)
    local _source = source
    --  Users[source] = Player.CreatePlayer(_source)
end
function Player.GetSourceFromUUID(UUID)
    for i = 1, #Users, 1 do
        if Users[i] ~= nil and Users[i].uuid ~= nil and Users[i].uuid == UUID then
            return Users[i].source
        end
    end
end
function Player.Disconnected(source)
    Users[source] = nil
    MySQL.Async.execute(
        "UPDATE users SET is_active=@skin where identifier=@identifier",
        {
            ["@table"] = "is_active",
            ["@skin"] = 0,
            ["@identifier"] = GetIdentifiers(source).steam
        }
    )
end
RegisterServerEvent("identity:editPic2")
AddEventHandler(
    "identity:editPic2",
    function(url)
        local uuid = Ora.Identity:GetUuid(source)

        MySQL.Async.execute(
            "UPDATE players_identity SET face_picutre=@url where uuid=@uuid",
            {
                ["@uuid"] = uuid,
                ["@url"] = url
            }
        )
    end
)
RegisterServerEvent("identity:editPic")
AddEventHandler(
    "identity:editPic",
    function(uuid, url)
        MySQL.Async.execute(
            "UPDATE players_identity SET face_picutre=@url where uuid=@uuid",
            {
                ["@uuid"] = uuid,
                ["@url"] = url
            }
        )
    end
)

function Player.GetPlayer(_source)
    if Users[_source] == nil then
        Users[_source] = Player.CreatePlayer(_source)
    end

    if (Users[_source].uuid == nil or Users[_source].uuid == false) then
        local uuid = Ora.Identity:GetUuid(_source)
        Users[_source].uuid = uuid
    end

    return Users[_source]
end

RegisterServerEvent("newXP")
AddEventHandler(
    "newXP",
    function(xp)
        local playerUuid = Ora.Identity:GetUuid(source)
        local allXp = Ora.Player:GetXp(source)
        allXp = allXp + xp

        MySQL.Async.execute(
            "UPDATE users SET xp=@xp where uuid=@uuid",
            {
                ["@xp"] = allXp,
                ["@uuid"] = playerUuid
            }
        )
    end
)

StrengthDiffByUser = {}

RegisterServerCallback(
    "Ora:getStrength",
    function(source, callback)
        local playerUuid = Ora.Identity:GetUuid(source)
        MySQL.Async.fetchAll(
            "SELECT * FROM `users` WHERE uuid = @uuid",
            {
                ["@uuid"] = playerUuid
            },
            function(result)
                if (result[1] == nil) then
                    callback(0)
                else
                    local currentStrength = result[1].strength
                    if (currentStrength > 1000) then
                        currentStrength = 1000
                    end

                    local isFull = false
                    if (StrengthDiffByUser[playerUuid] == nil) then
                        StrengthDiffByUser[playerUuid] = 0
                    end

                    if (StrengthDiffByUser[playerUuid] > 3.0) then
                        isFull = true
                    end

                    callback(currentStrength / 10, isFull)
                end
            end
        )
    end
)

RegisterServerEvent("newStrength")
AddEventHandler(
    "newStrength",
    function(xp)
        local playerUuid = Ora.Identity:GetUuid(source)
        if (StrengthDiffByUser[playerUuid] == nil) then
            StrengthDiffByUser[playerUuid] = 0
        end

        StrengthDiffByUser[playerUuid] = StrengthDiffByUser[playerUuid] + xp

        if (StrengthDiffByUser[playerUuid] <= 3.1) then
            local strength = Ora.Player:GetStrength(source)
            strength = strength + (xp * 10)

            if (strength > 1000) then
                strength = 1000
            end

            MySQL.Async.execute(
                "UPDATE users SET strength=@strength where uuid=@uuid",
                {
                    ["@strength"] = strength,
                    ["@uuid"] = playerUuid
                }
            )
        end
    end
)

RegisterServerEvent("removeStrength")
AddEventHandler(
    "removeStrength",
    function(xp)
        local playerUuid = Ora.Identity:GetUuid(source)
        local strength = Ora.Player:GetStrength(source)
        strength = strength - (xp * 10)

        if (StrengthDiffByUser[playerUuid] == nil) then
            StrengthDiffByUser[playerUuid] = 0
        end

        if StrengthDiffByUser[playerUuid] > 0 then
            StrengthDiffByUser[playerUuid] = StrengthDiffByUser[playerUuid] - xp
        end

        if strength < 0 then
            strength = 0
        end

        MySQL.Async.execute(
            "UPDATE users SET strength=@strength where uuid=@uuid",
            {
                ["@strength"] = strength,
                ["@uuid"] = playerUuid
            }
        )
    end
)

RegisterServerEvent("Ora:PlayerClass:RemoveStrength")
AddEventHandler(
    "Ora:PlayerClass:RemoveStrength",
    function(pID, number)
        local playerUuid = Ora.Identity:GetUuid(pID)
        local strength = Ora.Player:GetStrength(pID)
        strength = strength - (number * 10)

        if (StrengthDiffByUser[playerUuid] == nil) then
            StrengthDiffByUser[playerUuid] = 0
        end

        if StrengthDiffByUser[playerUuid] > 0 then
            StrengthDiffByUser[playerUuid] = StrengthDiffByUser[playerUuid] - number
        end

        if strength < 0 then
            strength = 0
        end

        MySQL.Async.execute(
            "UPDATE users SET strength=@strength where uuid=@uuid",
            {
                ["@strength"] = strength,
                ["@uuid"] = playerUuid
            }
        )
    end
)

RegisterServerEvent("Ora::SE::PlayerLoaded")

function Player.CreatePlayer(_source)
    local FLT = {}
    local self = FLT
    FLT.identifers = GetIdentifiers(_source)
    FLT.name = GetPlayerName(_source)
    FLT.uuid = Player.GetCurrentUuid(_source)
    FLT.Weight = 0
    FLT.source = _source
    FLT.money = 0
    FLT.black_money = 0
    FLT.xp = 0
    FLT.strength = 0
    FLT.firstname = ""
    FLT.surname = ""
    -- TODO Fix

    MySQL.Async.fetchAll(
        "SELECT `uuid`,`money`,`xp`,`group`, `strength` FROM `users` WHERE `identifier` = @identifiers",
        {
            ["@identifiers"] = FLT.identifers.steam
        },
        function(result)
            if result[1] ~= nil then
                FLT.uuid = result[1].uuid
                FLT.money = result[1].money
                --FLT.black_money = result[1].black_money
                FLT.group = result[1].group
                FLT.xp = tonumber(result[1].xp)
                FLT.strength = math.tointeger(result[1].strength)
                --TriggerClientEvent("es:activateBlackMoney", self.source, self.black_money)
                TriggerClientEvent("es:activateMoney", self.source, self.money)
                
            end
        end
    )

    FLT.AddItem = function(item, amount, data, label, id)
        if id == nil then
            local userX = MySQL.Sync.fetchAll("SELECT id FROM players_inventory ORDER BY id ASC")
            for i = 1, amount, 1 do
                MySQL.Async.execute(
                    "INSERT INTO players_inventory (uuid,name,data,label) VALUES(@uuid,@item,@data,@label)",
                    {
                        ["@uuid"] = FLT.uuid,
                        ["@item"] = item,
                        ["@data"] = json.encode(data),
                        ["@label"] = label
                    }
                )
                userX[#userX].id = userX[#userX].id + 1

                local item = {name = item, data = data, label = label, id = userX[#userX].id}
                TriggerClientEvent("Ora::CE::Inventory:AddItems", FLT.source, {item})
            end
        else
            MySQL.Async.execute(
                "INSERT INTO players_inventory (id,uuid,name,data,label) VALUES(@id,@uuid,@item,@data,@label)",
                {
                    ["@id"] = id,
                    ["@uuid"] = FLT.uuid,
                    ["@item"] = item,
                    ["@data"] = json.encode(data),
                    ["@label"] = label
                }
            )
            local _id = id
            local item = {name = item, data = data, label = label, id = _id}
            TriggerClientEvent("Ora::CE::Inventory:AddItems", FLT.source, {item})
        end
    end
    FLT.RemoveItem = function(id, name, b)
        --(id
    end
    FLT.RenameItem = function(id, label)
        MySQL.Async.execute(
            "UPDATE players_inventory SET label=@label where id=@id",
            {
                ["@id"] = id,
                ["@label"] = label
            }
        )
    end

    FLT.EditData = function(id, data, name)
        MySQL.Async.execute(
            "UPDATE players_inventory SET data=@data where id=@id",
            {
                ["@id"] = id,
                ["@data"] = json.encode(data)
            }
        )
        TriggerClientEvent("inventory:editData", FLT.source, id, data, name)
    end

    FLT.RemoveAll = function()
        MySQL.Async.execute(
            "DELETE FROM players_inventory WHERE uuid=@identifier",
            {
                ["@identifier"] = FLT.uuid
            }
        )
    end

    FLT.EditSkin = function(skin, table)
        MySQL.Async.execute(
            "UPDATE players_inventory SET @table=@skin where uuid=@id",
            {
                ["@table"] = table,
                ["@skin"] = json.encode(skin),
                ["@id"] = FLT.uuid
            }
        )
    end

--[[    FLT.removeBlackMoney = function(m)
        if m ~= nil then
            if m < 0 then
                TriggerEvent("banImACheater", FLT.source)
            end
            if type(m) == "number" then
                local newMoney = FLT.black_money - m
                FLT.black_money = newMoney

                TriggerClientEvent("es:activateBlackMoney", FLT.source, FLT.black_money)
                TriggerClientEvent("es:removedBlackMoney", FLT.source, m, false, FLT.black_money)
            end
        end
    end]]

    FLT.removeMoney = function(m)
        if m ~= nil then
            if m < 0 then
                TriggerEvent("banImACheater", FLT.source)
            end
            if type(m) == "number" then
                local newMoney = FLT.money - m
                FLT.money = newMoney
                TriggerClientEvent("es:activateMoney", FLT.source, FLT.money)
                TriggerClientEvent("es:removedMoney", FLT.source, m, false, FLT.money)
            end
        end
    end

    FLT.addMoney = function(m)
        if m ~= nil then
            if m < 0 then
                TriggerEvent("banImACheater", FLT.source)
            end
            if type(m) == "number" then
                FLT.money = FLT.money + m
                TriggerClientEvent("es:activateMoney", FLT.source, FLT.money)
                TriggerEvent(Ora.Payment:GetServerEventName() .. ":SERVERSIDE", FLT.source, {AMOUNT = m, SOURCE = "player.addMoney", LEGIT = true})
            end
        end
    end

    --[[FLT.addBlackMoney = function(m)
        if m ~= nil then
            if m < 0 then
                TriggerEvent("banImACheater", FLT.source)
            end
            if type(m) == "number" then
                FLT.black_money = FLT.black_money + m
                TriggerClientEvent("es:activateBlackMoney", FLT.source, FLT.black_money)
                TriggerClientEvent("es:removedBlackMoney", FLT.source, m, false, FLT.black_money)
                TriggerEvent(Ora.Payment.Fake:GetServerEventName() .. ":SERVERSIDE", FLT.source, {AMOUNT = m, SOURCE = "player.addBlackMoney", LEGIT = true})
            end
        end
    end]]

    FLT.getMoney = function(m)
        return FLT.money
    end

    --[[FLT.getBlackMoney = function(m)
        return FLT.black_money
    end]]

    return FLT
end

function Player.GetCurrentUuid(_source)
    MySQL.Async.fetchAll(
        "SELECT uuid FROM `users` WHERE identifier = @identifiers",
        {
            ["@identifiers"] = GetIdentifiers(_source).steam
        },
        function(result)
            if result[1] ~= nil then
                return result[1].uuid
            else
                Wait(5000)
            end
        end
    )
end

AddEventHandler(
    "mugroom:SelectedPlayer",
    function()
        Player.NewPlayerConnected(source)
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        Player.Disconnected(source)
    end
)
RegisterServerEvent("core:SetNumber")
AddEventHandler(
    "core:SetNumber",
    function(price)
        local uuid = Ora.Identity:GetUuid(source)

        MySQL.Async.execute(
            "UPDATE users SET phone_number=@phone_number where uuid=@uuid",
            {
                ["@phone_number"] = price,
                ["@uuid"] = uuid,
                ["@updated"] = GetDatetime()
            }
        )
    end
)

RegisterServerEvent("core:GetMoney")
AddEventHandler(
    "core:GetMoney",
    function(callback, _source)
        local player = Player.GetPlayer(_source)
        callback(player.money, player.black_money)
    end
)

RegisterServerEvent("money:Pay")
AddEventHandler(
    "money:Pay",
    function(price)
        local player = Player.GetPlayer(source)
        player.removeMoney(price)
    end
)
RegisterServerEvent("money:Pay22")
AddEventHandler(
    "money:Pay22",
    function(price, s)
        local player = Player.GetPlayer(s)
        if s == nil then
            print("^1SOURCE = NIL 338^0")
        end
        while player == nil do
            Wait(1)
            player = Player.GetPlayer(xxxx)
        end
        player.addMoney(price)
    end
)
--[[RegisterServerEvent("black_money:Pay22")
AddEventHandler(
    "black_money:Pay22",
    function(price, s)
        local player = Player.GetPlayer(s)
        player.addBlackMoney(price)
    end
)]]
function Player.Save()
    for k, v in pairs(Users) do
        MySQL.Async.execute(
            "UPDATE users SET money=@money,black_money=@black where uuid=@uuid",
            {
                ["@money"] = v.money,
                ["@black"] = v.black_money,
                ["@uuid"] = v.uuid,
                ["@updated"] = GetDatetime()
            }
        )
    end
    --("^3[Players] ^4Players saved ^0")
    SetTimeout(20000, Player.Save)
end

SetTimeout(20000, Player.Save)

RegisterServerEvent("player:Handcuff")
AddEventHandler(
    "player:Handcuff",
    function(trgtSource, bool)
        TriggerClientEvent("player:HandCuff", trgtSource, bool)
    end
)

RegisterServerEvent("money:Add")
AddEventHandler(
    "money:Add",
    function(price)
        local player = Player.GetPlayer(source)
        player.addMoney(price)
    end
)

RegisterServerEvent("money:Add2")
AddEventHandler(
    "money:Add2",
    function(price, xxxx)
        if xxxx == nil then
            print("^1SOURCE = NIL 338^0")
        end
        local player = Player.GetPlayer(xxxx)
        while player == nil do
            Wait(0)
            player = Player.GetPlayer(xxxx)
        end
        player.addMoney(price)
    end
)

--[[RegisterServerEvent("black_money:Add2")
AddEventHandler(
    "black_money:Add2",
    function(price, xxxx)
        if xxxx == nil then
            print("^1SOURCE = NIL 338^0")
        end
        local player = Player.GetPlayer(xxxx)
        while player == nil do
            Wait(0)
            player = Player.GetPlayer(xxxx)
        end
        player.addBlackMoney(price)
    end
)]]

RegisterServerEvent("money:Remove2")
AddEventHandler(
    "money:Remove2",
    function(price, _source)
        local player = Player.GetPlayer(_source)
        player.removeMoney(price)
    end
)

--[[RegisterServerEvent("black_money:Add")
AddEventHandler(
    "black_money:Add",
    function(price)
        local player = Player.GetPlayer(source)
        player.addBlackMoney(price)
    end
)]]

--[[RegisterServerEvent("black_money:Pay")
AddEventHandler(
    "black_money:Pay",
    function(price)
        local player = Player.GetPlayer(source)
        player.removeBlackMoney(price)
    end
)]]

--[[RegisterServerEvent("black_money:Pay2")
AddEventHandler(
    "black_money:Pay2",
    function(price, xxxx)
        local player = Player.GetPlayer(xxxx)
        player.removeBlackMoney(price)
    end
)]]
RegisterServerEvent("money:Remove2")
AddEventHandler(
    "money:Remove2",
    function(price, xxxx)
        local player = Player.GetPlayer(xxxx)
        player.removeMoney(price)
    end
)

AddEventHandler(
    "playerDropped",
    function()
        local Source = source

        if (Users[Source]) then
            TriggerEvent("es:playerDropped", Users[Source])
            money = Users[Source].getMoney()
            --black_money = Users[Source].getBlackMoney()
            MySQL.Async.execute(
                "UPDATE users SET money=@money where uuid=@id",
                {
                    ["@id"] = Users[Source].uuid,
                    ["@money"] = Users[Source].money,
                   -- ["@black_money"] = Users[Source].black_money
                }
            )
            Users[Source] = nil
        end
    end
)

RegisterServerCallback(
    "core:GetAllIdentityPlayers",
    function(source, callback)
        local _source = source
        local identifers = GetIdentifiers(_source).steam
        local result = MySQL.Sync.fetchAll("SELECT DISTINCT players_identity.uuid AS uuid, last_name, first_name FROM players_identity, players_vehicles WHERE players_identity.uuid = players_vehicles.uuid AND players_vehicles.pound = 1")
        
        local jobsKeysString = "\"first\""
        for k, v in pairs(Jobs) do
            jobsKeysString = jobsKeysString .. ", \"" .. k .. "\""
        end
        local jobsThatHaveVehicleInPound = MySQL.Sync.fetchAll("SELECT DISTINCT uuid FROM players_vehicles WHERE pound = 1 AND uuid IN (" .. jobsKeysString .. ")")
        
        callback(result, jobsThatHaveVehicleInPound)
    end
)

RegisterServerCallback("core:GetVehicleInPound", function(source, cb, uuid)
    local _source = source
    local identifers = GetIdentifiers(_source).steam
    local result = MySQL.Sync.fetchAll("SELECT * FROM players_vehicles WHERE uuid = @uuid AND pound = 1", {["@uuid"] = uuid})
    cb(result)
end)

----

local braceletListUUID = {}
RegisterServerEvent("core:RegisterBracelet")
AddEventHandler(
    "core:RegisterBracelet",
    function(src)
        --print("k")
        local playerUuid = Ora.Identity:GetUuid(src)
        braceletListUUID[playerUuid] = src
        --print("insert")
    end
)

RegisterServerEvent("core:DeleteBracelet")
AddEventHandler(
    "core:DeleteBracelet",
    function(src)
        for k, v in pairs(braceletListUUID) do
            if v == src then
                braceletListUUID[k] = nil
                break
            end
        end

        TriggerClientEvent("deleteBracelet", -1, src)
    end
)
RegisterServerCallback(
    "core:GetBraceletList",
    function(source, callback)
        MySQL.Async.fetchAll(
            "SELECT * FROM players_identity",
            {},
            function(result)
                callback(result, braceletListUUID)
            end
        )
    end
)

local PlayerTracking = {}

RegisterServerEvent("trackingToggle")
AddEventHandler(
    "trackingToggle",
    function(t)
        PlayerTracking[source] = t
        TriggerClientEvent("trackingRefresh", -1, PlayerTracking)
    end
)

RegisterServerEvent("kickPlayer")
AddEventHandler(
    "kickPlayer",
    function(target, msg)
        local _source = source
        local ply = Player.GetPlayer(_source)

        if Ora.Identity:GetGroup(_source) ~= "superadmin" or Ora.Identity:GetGroup(_source) ~= "staff" then
            return BanPlayer(_source, os.time() + 99999, "Cheat", _source)
        end

        DropPlayer(target, msg)
    end
)
RegisterServerEvent("banPlayer")
AddEventHandler(
    "banPlayer",
    function(target, msg, time)
        local _source = source
        local ply = Player.GetPlayer(_source)
        local now = os.time()

        if ((Ora.Identity:GetGroup(_source)  ~= "superadmin" or Ora.Identity:GetGroup(_source) ~= "staff") and (msg ~= "Votre résolution doit être supérieure à 1280 x 1080")) then
            return BanPlayer(_source, now + 99999, "Cheat", _source)
        end

        BanPlayer(target, time + now, msg, _source)
    end
)

RegisterServerEvent("warnPlayer")
AddEventHandler(
    "warnPlayer",
    function(target, msg, time)
        local now = os.time()
        local _source = source
        local ply = Player.GetPlayer(source)

        if Ora.Identity:GetGroup(_source)  ~= "superadmin" or Ora.Identity:GetGroup(_source) ~= "staff" then
            return BanPlayer(_source, now + 99999, "Cheat", _source)
        end
        WarnPlayer(target, msg, source)
    end
)

function BanPlayer(src, timestamp, reason, _source)
    local steam64 = GetPlayerIdentifiers(src)[1]
    local rockstar = nil
    local ipv4 = nil

    for _, foundID in ipairs(GetPlayerIdentifiers(src)) do
        if string.match(foundID, "license:") then
            rockstar = string.sub(foundID, 9)
        elseif string.match(foundID, "ip:") then
            ipv4 = string.sub(foundID, 4)
        elseif string.match(foundID, "steam:") then
            steam64 = foundID
        end
    end

    MySQL.Async.execute(
        "UPDATE whitelist SET permanent_ban = 1, ban_expire_at = @ban_expire_at, reason = @reason WHERE identifier = @identifier",
        {
            ["@identifier"] = steam64,
            ["@ban_expire_at"] = timestamp,
            ["@reason"] = reason
        }
    )

    MySQL.Async.execute(
        "INSERT INTO players_bans (identifier, date, reason, moderator, unbandate) VALUES(@identifier, @date, @reason, @banfrom, @unbandate)",
        {
            ["@identifier"] = steam64,
            ["@unbandate"] = timestamp,
            ["@reason"] = reason,
            ["@banfrom"] = GetPlayerName(_source),
            ["@date"] = os.date("%Y-%m-%d %H:%M:%S", os.time())
        
        }
    )

    DropPlayer(src, reason)
end
function WarnPlayer(src, reason, _source)
    local steam64 = GetPlayerIdentifiers(src)[1]

    local steam_name = GetPlayerName(src)
    local rockstar = nil
    local ipv4 = nil
    for _, foundID in ipairs(GetPlayerIdentifiers(src)) do
        if string.match(foundID, "license:") then
            rockstar = string.sub(foundID, 9)
        elseif string.match(foundID, "ip:") then
            ipv4 = string.sub(foundID, 4)
        elseif string.match(foundID, "steam:") then
            steam64 = foundID
        end
    end

    MySQL.Async.execute(
        "INSERT INTO players_warns (identifier,date,reason,moderator) VALUES(@identifier,@date,@reason,@banfrom)",
        {
            ["@identifier"] = steam64,
            ["@unbandate"] = timestamp,
            ["@reason"] = reason,
            ["@banfrom"] = GetPlayerName(_source),
            ["@date"] = os.date("%Y-%m-%d %H:%M:%S", os.time())
        }
    )
end

RegisterServerCallback(
    "GetHistoBan",
    function(source, callback, param)
        local src = param
        local steam64 = GetPlayerIdentifiers(src)[1]

        local steam_name = GetPlayerName(src)
        local rockstar = nil
        local ipv4 = nil
        for _, foundID in ipairs(GetPlayerIdentifiers(src)) do
            if string.match(foundID, "license:") then
                rockstar = string.sub(foundID, 9)
            elseif string.match(foundID, "ip:") then
                ipv4 = string.sub(foundID, 4)
            elseif string.match(foundID, "steam:") then
                steam64 = foundID
            end
        end
        MySQL.Async.fetchAll(
            "SELECT * FROM players_bans WHERE identifier=@identifier",
            {
                ["@identifier"] = steam64
            },
            function(result)
                for i = 1, #result, 1 do
                    result[i].date = os.date("%d/%m/%Y %X", result[i].date)
                    result[i].unbandate = os.date("%d/%m/%Y %X", result[i].unbandate)
                end
                callback(result)
            end
        )
    end
)

RegisterServerCallback(
    "GetHistoWarn",
    function(source, callback, param)
        local src = param
        local steam64 = GetPlayerIdentifiers(src)[1]

        local steam_name = GetPlayerName(src)
        local rockstar = nil
        local ipv4 = nil
        for _, foundID in ipairs(GetPlayerIdentifiers(src)) do
            if string.match(foundID, "license:") then
                rockstar = string.sub(foundID, 9)
            elseif string.match(foundID, "ip:") then
                ipv4 = string.sub(foundID, 4)
            elseif string.match(foundID, "steam:") then
                steam64 = foundID
            end
        end
        MySQL.Async.fetchAll(
            "SELECT * FROM players_warns WHERE identifier=@identifier",
            {
                ["@identifier"] = steam64
            },
            function(result)
                for i = 1, #result, 1 do
                    result[i].date = os.date("%d/%m/%Y %X", result[i].date)
                end
                callback(result)
            end
        )
    end
)
local deadTable = {}

RegisterServerEvent("IMDEAD")
AddEventHandler(
    "IMDEAD",
    function(b)
        local steam64 = GetPlayerIdentifiers(source)[1]
        deadTable[steam64] = b
    end
)

RegisterServerEvent("core:removeFromDead")
AddEventHandler(
    "core:removeFromDead",
    function()
        local steam64 = GetPlayerIdentifiers(source)[1]
        if (deadTable[steam64] ~= nil) then
            deadTable[steam64] = nil
        end
    end
)

RegisterServerCallback(
    "core:GetDead",
    function(source, callback)
        local steam64 = GetPlayerIdentifiers(source)[1]
        local isDead = false

        if (deadTable[steam64] == nil) then
            isDead = false
        elseif deadTable[steam64] == false then
            isDead = false
        else
            isDead = true
        end

        callback(isDead)
    end
)

local function getPlayerUuid(source)
    return Ora.Identity:GetUuid(source)
end

RegisterServerCallback(
    "Ora::SE:Admin:AmIAdmin?",
    function(source, callback, options)
        local myGroup = Ora.Identity:GetGroup(source)
        local playerUuid = getPlayerUuid(source)
        local returnArgs = {
            [1] = false,
            [2] = {}
        }

        if (myGroup == "superadmin" or myGroup = "staff") then
            returnArgs[1] = true
        end

        if (options.GET_ALL_USERS == true) then
            for _, playerId in ipairs(GetPlayers()) do
                local playerItem = OraAdmin.PLAYERS_SERVERSIDE[playerId]
                if (playerItem ~= nil) then
                    table.insert(returnArgs[2], playerItem)
                else
                    table.insert(returnArgs[2], {id = tostring(playerId), uuid = Ora.Identity:GetUuid(playerId), name = "[" .. playerId .. "] " .. Ora.Identity:GetFullname(playerId), group = Ora.Identity:GetGroup(playerId), ped = NetworkGetNetworkIdFromEntity(GetPlayerPed(playerId))})
                end
            end
        else
            returnArgs[2] = {}
        end
        
        callback(returnArgs[1], json.encode(returnArgs[2]))
    end
)

RegisterServerCallback(
    "Ora::SE::Admin:GetMpTagsIdentityForPlayers",
    function(source, callback, players)
        local callbackArgs = {}
        for key, playerId in pairs(players) do
            table.insert(callbackArgs, {id = tostring(playerId), uuid = Ora.Identity:GetUuid(playerId), name = "[" .. playerId .. "] " .. Ora.Identity:GetFullname(playerId), group = Ora.Identity:GetGroup(playerId), ped = NetworkGetNetworkIdFromEntity(GetPlayerPed(playerId))})
            Ora.Identity:Debug(string.format("^5%s^3 triggered ServerEventCallback : Ora::SE::Admin:GetMpTagsIdentityForPlayers to retrieve identity of ^5%s^3", source, playerId))
        end
        callback(json.encode(callbackArgs))
    end
)