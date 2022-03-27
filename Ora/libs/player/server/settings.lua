RegisterServerCallback(
    "getSettings",
    function(source, callback)
        local _source = source
        local identifiers = GetIdentifiers(_source).steam

        MySQL.Async.fetchAll(
            "SELECT * FROM users WHERE identifier = @identifiers",
            {
                ["@identifiers"] = identifiers
            },
            function(result)
                if result[1] then
                    callback(result[1])
                else
                    callback(nil)
                end
            end
        )
    end
)

local armeBuyed = {}

RegisterServerCallback(
    "getArmeblanched",
    function(source, callback)
        local uuid = Ora.Identity:GetUuid(source)

        callback(armeBuyed[uuid] == nil)
    end
)
RegisterServerEvent("ArmeBlanche")
AddEventHandler(
    "ArmeBlanche",
    function()
        local uuid = Ora.Identity:GetUuid(source)

        table.insert(armeBuyed, uuid)
    end
)
RegisterServerEvent("BuyNewWeapon")
AddEventHandler(
    "BuyNewWeapon",
    function(data, label)
        local player = Player.GetPlayer(source)

        MySQL.Async.execute(
            "INSERT INTO players_weapon (serial,weapon_name,user) VALUES(@serial,@weapon_name,@user)",
            {
                ["@serial"] = data.serial,
                ["@weapon_name"] = label,
                ["@user"] = json.encode({name = player.firstname, surname = player.surname})
            }
        )
    end
)
RegisterServerEvent("saveMyColor")
AddEventHandler(
    "saveMyColor",
    function(color)
        local _source = source
        local identifers = GetIdentifiers(_source).steam

        MySQL.Async.fetchAll(
            "UPDATE users SET colors = @color WHERE identifier = @identifiers",
            {
                ["@identifiers"] = identifers,
                ["@color"] = json.encode(color)
            }
        )
    end
)
RegisterServerEvent("SetPlyHUD")
AddEventHandler("SetPlyHUD", function(index)
    local _source = source
    local _index = index
    local hex = GetIdentifiers(_source).steam
    MySQL.Async.fetchAll(
        "UPDATE users SET hud = @index WHERE identifier = @hex",
        {
            ["@index"] = _index,
            ["@hex"] = hex
        }
    )
end)
RegisterServerEvent("saveMyBind")
AddEventHandler(
    "saveMyBind",
    function(bind)
        local _source = source
        local identifers = GetIdentifiers(_source).steam

        MySQL.Async.fetchAll(
            "UPDATE users SET bind = @bind WHERE identifier = @identifiers",
            {
                ["@identifiers"] = identifers,
                ["@bind"] = json.encode(bind)
            }
        )
    end
)

AddEventHandler(
    "playerConnecting",
    function(name, setKickReason, deferrals)
        local _source = source

        local steam64 = GetPlayerIdentifiers(_source)[1]

        local steam_name = GetPlayerName(_source)
        local rockstar = nil
        local ipv4 = nil
        deferrals.defer()

        deferrals.update(string.format("Bonjour %s. Nous vérifions que vous êtes bien whitelist.", name))

        Wait(1000)
        for _, foundID in ipairs(GetPlayerIdentifiers(_source)) do
            if string.match(foundID, "license:") then
                rockstar = string.sub(foundID, 9)
            elseif string.match(foundID, "ip:") then
                ipv4 = string.sub(foundID, 4)
            elseif string.match(foundID, "steam:") then
                steam64 = foundID
            end
        end
        local listed = MySQL.Sync.fetchAll("SELECT * FROM whitelist WHERE identifier=@name", {["@name"] = steam64})
        local name = GetPlayerName(_source) or "Nom inconnu"
        local playerPing = GetPlayerPing(_source)

        --print("Connexion : " .. name)
        if listed ~= nil and listed[1] ~= nil then
            if listed[1].permanent_ban then
                local now = os.time()
                if now > listed[1].ban_expire_at then
                    deferrals.update("Vous avez été débanni faites attention dés à présent !")
                    MySQL.Async.execute(
                        "UPDATE whitelist SET permanent_ban=0, ban_expire_at = 0, reason = 0 where identifier=@identifier",
                        {
                            ["@identifier"] = steam64,
                            ["@ban_expire_at"] = timestamp,
                            ["@reason"] = reason
                        }
                    )
                    Wait(2000)
                    deferrals.done()
                    TriggerEvent(
                        "Ora:sendToDiscordFromServer",
                        _source,
                        14,
                        string.format(
                            "Se connecte sur Ora\n\n* Ping : %s ms\n* IP V4 : %s\n* SteamHex : %s\n* Licence : %s",
                            playerPing, ipv4, steam64, rockstar 
                        )
                        "info"
                    )
                else
                    deferrals.done(
                        "Vous êtes banni jusqu'au " ..
                            os.date("%d/%m/%Y %X", listed[1].ban_expire_at) .. "\nRaison : " .. listed[1].reason
                    )
                end
            else
                TriggerEvent(
                    "Ora:sendToDiscordFromServer",
                    _source,
                    14,
                    string.format(
                        "Se connecte sur Ora\n\n* Ping : %s ms\n* IP V4 : %s\n* SteamHex : %s\n* Licence : %s",
                        playerPing, ipv4, steam64, rockstar 
                    ),
                    "info"
                )
                deferrals.done()
            end
        else
            deferrals.done("Vous n'êtes pas whitelist !")
        end
    end
)
