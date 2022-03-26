RegisterServerEvent("Atlantiss::Player:banWeapon")
AddEventHandler(
    "Atlantiss::Player:banWeapon",
    function(playerId, isBan)
      local _source = source
      local uuid = Atlantiss.Identity:GetUuid(playerId)

      if (uuid ~= "" and uuid ~= nil) then
        MySQL.Async.fetchAll(
            "SELECT * FROM player_ban_weapon WHERE uuid = @uuid",
            {
                ["@uuid"] = uuid
            },
            function(results)
              if (results[1] ~= nil) then
                if (isBan == true) then
                  TriggerClientEvent("RageUI:Popup", _source, {message = "~o~Cette personne est déjà ban arme~s~"})
                  TriggerClientEvent("Atlantiss::Player:banWeapon", playerId, true)
                else
                  MySQL.Sync.execute(
                      "DELETE FROM player_ban_weapon WHERE uuid = @uuid",
                      {
                          ["@uuid"] = uuid
                      }
                  )
                  TriggerClientEvent("Atlantiss::Player:banWeapon", playerId, true)
                  TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Cette personne n'est plus ban armes~s~"})
                end
              else
                if (isBan == true) then
                  local now = os.time()
                  -- 1 Week of ban weapon
                  local timestamp = now + 604800
                  MySQL.Sync.execute(
                      "INSERT INTO player_ban_weapon (uuid, expires_at) VALUES (@uuid, @expiresAt)",
                      {
                          ["@uuid"] = uuid,
                          ["@expiresAt"] = timestamp
                      }
                  )
                  TriggerClientEvent("Atlantiss::Player:banWeapon", playerId, true)
                  TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Cette personne est désormais ban arme 1 semaine~s~"})
                end
              end
            end
          )
      end
    end
)
