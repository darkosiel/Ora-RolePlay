-- ALTER TABLE `users` ADD COLUMN `last_connected_at` DATETIME NULL AFTER `hud`;

Ora.PlayersData = {}
Ora.DisableCheckup = false

local function IsYetRegistered(licence, steam, initSrc)
    local res = {}
	
	if (Ora.DisableCheckup == true) then
		return res
	end

    for src, ids in pairs(Ora.PlayersData) do
        local l, s = ids[1], ids[2]

        if (licence == l or steam == s) then
            local hook = string.format(
                "[%s & %s] %s s'est connecté avec plusieurs clients au même compte steam.\n\n[HEX] : **%s**\n[LICENCE] : **%s**",
                initSrc,
                src,
                Ora.Identity:GetFullname(src) ~= "" and Ora.Identity:GetFullname(src) or GetPlayerName(src),
                s,
                l 
            )

            TriggerEvent("Ora:sendToDiscordFromServer", src, 12, hook, "error")
            table.insert(res, src)
        end
    end
    Wait(100)

    return res
end

AddEventHandler(
  "Ora::SE::PlayerLoaded",
  function(source)
	local steam

	for _, foundID in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(foundID, "steam:") then
            steam = foundID
			break
        end
    end

	Ora.Jobs.Firefighter.Whitelist:addPlayer(source, steam)
	TriggerClientEvent("Ora::CE::PlayerLoaded", source)
  end
)

function Ora:InitializeCharacter(source)
    local playerUuid = Ora.Identity:GetUuid(source)
    TriggerEvent("Ora::ServerSidePlayerLoaded", source, playerUuid)
    TriggerClientEvent("Ora::PlayerLoaded", source, playerUuid)

    if (playerUuid ~= nil) then
        MySQL.Async.fetchAll(
            "SELECT pi.* FROM `players_identity` as pi WHERE pi.`uuid` = @uuid",
            {
                ["@uuid"] = playerUuid
            },
            function(identityResults)
                if (identityResults ~= nil and identityResults[1] ~= nil) then
                    TriggerEvent(
                        "Ora::SE::Identity:Loaded", 
                        source, 
                        {
                            last_name = identityResults[1].last_name,
                            first_name = identityResults[1].first_name,
                            uuid = identityResults[1].uuid,
                        }
                    )
                end
            end
        )
    end

    MySQL.Async.fetchAll(
        "SELECT * FROM player_ban_weapon WHERE uuid = @uuid",
        {
            ["@uuid"] = playerUuid
        },
        function(resultsPlayerBan)
            if (resultsPlayerBan[1] ~= nil) then
                local now = os.time()
                if (resultsPlayerBan[1].expires_at ~= nil and now > math.tointeger(resultsPlayerBan[1].expires_at)) then
                    TriggerClientEvent("RageUI:Popup", source, {message = "~h~~g~~h~Votre ban armes est supprimé~s~"})
                    TriggerClientEvent("Ora::Player:banWeapon", source, false)
                    MySQL.Sync.execute(
                        "DELETE FROM player_ban_weapon WHERE uuid = @uuid",
                        {
                            ["@uuid"] = playerUuid,
                        }
                    )
                else
                    TriggerClientEvent("RageUI:Popup", source, {message = "~h~~r~Rappel:~h~ Vous êtes ban armes~s~"})
                    TriggerClientEvent("Ora::Player:banWeapon", source, true)
                end
            end
        end
    )

    OraAdmin.AddPlayer(source, Ora.Identity:GetUuid(source), Ora.Identity:GetGroup(source), "["..source.."] " .. Ora.Identity:GetFullname(source))
    TriggerEvent("Ora::SE::PlayerLoaded", source)
end

Citizen.CreateThread(
    function()
        while (GetResourceState("Ora") ~= "started") do
            Wait(100)
        end

        Ora:InitializeModules()
    end
)

RegisterCommand(
    "emptyPlayersTable",
    function(source)
        if (source == 0) then
            Ora.PlayersData = {}
            TriggerClientEvent("Ora::CE::Core:SendClientInfos", -1)
            print("^2Player's table cleaned !^0")
        end
    end,
    true
)

RegisterCommand(
    "toggleSteamCheck",
    function(source)
        if (source == 0) then
            Ora.DisableCheckup = not Ora.DisableCheckup
			if (Ora.DisableCheckup == true) then
				print("^2Steam & Licence check disabled !^0")
			else
				print("^2Steam & Licence check enbaled !^0")
			end
        end
    end,
    true
)

RegisterNetEvent("Ora::SE::Core:SendClientInfos")
AddEventHandler(
  "Ora::SE::Core:SendClientInfos",
  function()
    local src = source
    local licence, steam

    for _, foundID in ipairs(GetPlayerIdentifiers(src)) do
        if string.match(foundID, "license:") then
            licence = string.sub(foundID, 9)
        elseif string.match(foundID, "steam:") then
            steam = foundID
        end
    end
    Wait(100)

    local regSrcs = IsYetRegistered(licence, steam, src)
    if (#regSrcs > 0) then
        local message = "Connexion avec plusieurs clients sur le même compte steam ou rockstar interdite."
        local hook = string.format(
            "[%s] %s s'est connecté avec plusieurs clients au même compte steam ou rockstar.\n\n[HEX] : **%s**\n[LICENCE] : **%s**",
            src,
            Ora.Identity:GetFullname(src) ~= "" and Ora.Identity:GetFullname(src) or GetPlayerName(src),
            steam,
            licence
        )

        TriggerEvent("Ora:sendToDiscordFromServer", src, 12, hook, "error")

        for i = 1, #regSrcs do
            DropPlayer(regSrcs[i], message)
        end

        DropPlayer(src, message)

        return
    end

    Ora.PlayersData[src] = {licence, steam}
  end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        local src = source
        local playerPing = GetPlayerPing(src)
        local playerUUID = Ora.Identity:GetUuid(src)
		local steam

		for _, foundID in ipairs(GetPlayerIdentifiers(src)) do
			if string.match(foundID, "steam:") then
				steam = foundID
				break
			end
		end

        TriggerEvent(
            "Ora:sendToDiscordFromServer",
            src,
            14,
            Ora.Identity:GetFullname(src) .. " se deconnecte\n\n* Ping : " .. playerPing .. "ms\n* Raison : " .. reason,
            "info"
        )

        MySQL.Async.execute("UPDATE users SET last_connected_at = current_timestamp() WHERE uuid = @uuid", {["@uuid"] = playerUUID})

		if (src and Ora.PlayersData[src]) then
			Ora.PlayersData[src] = nil
		end

		Ora.Jobs.Firefighter.Whitelist:removePlayer(src, steam)
    end
)
