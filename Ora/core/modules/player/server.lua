-- CREATE TABLE players_phone ( `id` INT NOT NULL AUTO_INCREMENT , `uuid` VARCHAR(255) NOT NULL , `phone` INT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;
-- ALTER TABLE `players_phone` ADD INDEX(`uuid`);
-- ALTER TABLE `players_phone` ADD INDEX(`phone`);
-- ALTER TABLE `players_phone` CHANGE `phone` `phone` VARCHAR(20) NULL DEFAULT NULL;
-- ALTER TABLE `players_phone` DROP `uuid`;

Ora.Player.SessionData = {}

function Ora.Player:GetSessionData(playerId)
    if self.SessionData[playerId] ~= nil then
        return self.SessionData[playerId]
    end

    return {}
end

function Ora.Player:AppendToSessionDataKey(playerId, key, value)
    if self.SessionData[playerId] == nil then
        self.SessionData[playerId] = {}
    end

    if self.SessionData[playerId][key] == nil then
        self.SessionData[playerId][key] = {}
    end

    table.insert(self.SessionData[playerId][key], value)
end

function Ora.Player:SetSessionDataKey(playerId, key, value)
    if self.SessionData[playerId] == nil then
        self.SessionData[playerId] = {}
    end

    if self.SessionData[playerId][key] == nil then
        self.SessionData[playerId][key] = {}
    end

    self.SessionData[playerId][key] = value
end

function Ora.Player:GetSessionDataKey(playerId, key)
    if self.SessionData[playerId] == nil then
        return nil
    end

    if self.SessionData[playerId][key] == nil then
        return nil
    end

    return self.SessionData[playerId][key]
end


function Ora.Player:GenerateNewPhoneNumber()
    local newNumber = string.format("555%04d", math.random(1111, 9999))
    local isValid = false

    while (isValid == false) do
        Wait(10)
        local results = MySQL.Sync.fetchAll(
            "SELECT pp.* FROM `players_phone` as pp WHERE pp.`phone` = @number",
            {
                ["@number"] = newNumber
            }
        )

        if (results ~= nil and results[1] ~= nil) then
            newNumber = string.format("555%4d", math.random(1111, 9999))
        else 
            isValid = true
        end
    end

    return newNumber
end


function Ora.Player:RegisterPhoneNumberToPlayer(phoneNumber)
    local results = MySQL.Sync.insert(
        "INSERT INTO `players_phone` (phone) VALUES(@number)",
        {
            ["@number"] = phoneNumber
        }
    )
end

function Ora.Player:GetStrength(playerId)
    local results = MySQL.Sync.fetchAll(
        "SELECT strength FROM `users` WHERE uuid = @uuid",
        {
            ["@uuid"] = Ora.Identity:GetUuid(playerId)
        }
    )

    if (results ~= nil and results[1] ~= nil) then
        return results[1].strength
    end

    return 0
end

function Ora.Player:GetXp(playerId)
    local results = MySQL.Sync.fetchAll(
        "SELECT xp FROM `users` WHERE uuid = @uuid",
        {
            ["@uuid"] = Ora.Identity:GetUuid(playerId)
        }
    )

    if (results ~= nil and results[1] ~= nil) then
        return results[1].xp
    end

    return 0
end

function TriggerMultiClientsEvent(eventName, playerList, ...)
    for k, v in pairs(playerList) do
        TriggerClientEvent(eventName, v, ...)
    end
end

RegisterServerCallback("Ora::SE::Player:Phone:GetNewPhoneNumber", 
    function(source, cb) 
        local _source = source
        local newPhoneNumber = Ora.Player:GenerateNewPhoneNumber()
        Ora.Player:RegisterPhoneNumberToPlayer(newPhoneNumber)
        -- OraPhone
        local identity = Ora.Identity:GetIdentity(_source)
        exports.OraPhone:RegisterNewPhone(newPhoneNumber, identity)
        cb(newPhoneNumber)
    end
)

RegisterServerEvent("Ora::SE::Player:AddToSessionData")
AddEventHandler(
    "Ora::SE::Player:AddToSessionData",
    function(key, data)
        local _source = source
        local newData = nil
        if (type(data) == "string") then
            newData =  os.date("%Y-%m-%d %H:%M", os.time()) .. " > " .. data
        else
            newData = data
        end

        Ora.Player:AppendToSessionDataKey(_source, key, newData)
    end
)

RegisterServerEvent("Ora::SE::Player:SetSessionData")
AddEventHandler(
    "Ora::SE::Player:SetSessionData",
    function(key, data)
        local _source = source
        Ora.Player:SetSessionData(_source, key, data)
    end
)


AddEventHandler(
    "playerDropped",
    function(reason)
        local _source = source
        local sessionData = Ora.Player:GetSessionData(_source)
        local fullname = Ora.Identity:GetFullname(_source)
        local hasValue = false
        local message = "```markdown\n# RAPPORT DE SESSION DU JOUEUR ".. fullname .. "\n```"

        for key, value in pairs(sessionData) do
            if (Ora.Player.SessionDataMapper[key] ~= nil) then
                hasValue = true
               message = message .. Ora.Player.SessionDataMapper[key](value)
            end
        end

        if (hasValue) then 
            TriggerEvent(
                "Ora:sendToDiscordFromServer",
                _source,
                32,
                message,
                "info"
            )
        end
    end
)

RegisterServerEvent("Ora::SE::Player:UpdateTattoos")
AddEventHandler(
    "Ora::SE::Player:UpdateTattoos",
    function(tattooListFixed)
        local _source = source
        MySQL.Async.execute(
            "UPDATE players_appearance SET tattoo = @tattooList WHERE uuid = @uuid",
            {
              ['@tattooList'] = json.encode(tattooListFixed),
              ['@uuid'] = Ora.Identity:GetUuid(_source)
            },
            function (affectedRows)
            end
        )
    end
)

RegisterServerEvent("Ora::SE::Player:RegisterHealth")
AddEventHandler(
    "Ora::SE::Player:RegisterHealth",
    function(health)
        local _source = source
        if (health > 0) then
            local results = MySQL.Sync.fetchAll(
                "SELECT count(uuid) AS result_count FROM players_identity WHERE uuid = @uuid",
                {
                ['@uuid'] = Ora.Identity:GetUuid(_source)
                }
            )

            if (results ~= nil and results[1] ~= nil and results[1].result_count > 0) then
                MySQL.Sync.execute(
                    "UPDATE players_identity SET health = @health WHERE uuid = @uuid",
                    {
                    ['@health'] = health,
                    ['@uuid'] = Ora.Identity:GetUuid(_source)
                    }
                )
            end
        end
    end
)

RegisterServerCallback("Ora::SCB::Player:GetTattoos", 
  function(source, cb, player) 
    local _source = source
    local playerUuid = Ora.Identity:GetUuid(player)

    MySQL.Async.fetchAll(
        "SELECT tattoo FROM players_appearance WHERE uuid = @uuid",
        {['@uuid'] = playerUuid},
        function(result)
            if result[1] then
                cb(json.decode(result[1].tattoo))
            else
                cb(false)
            end
        end
    )
  end
)

RegisterServerEvent("Ora::SE::Player:SetTattoo")
AddEventHandler(
    "Ora::SE::Player:SetTattoo",
    function(target, tattoos)
        local playerUuid = Ora.Identity:GetUuid(target)

        MySQL.Async.execute(
            "UPDATE players_appearance SET tattoo = @tattoo WHERE uuid = @uuid",
            {
                ['@tattoo'] = json.encode(tattoos),
                ['@uuid'] = playerUuid
            }
        )
    end
)
