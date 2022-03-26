Atlantiss.Health.Dead = {}

RegisterServerEvent("Atlantiss::SE::Player:RegisterHealth")
AddEventHandler(
    "Atlantiss::SE::Player:RegisterHealth",
    function(health)
        local _source = source
        local uuid = Atlantiss.Identity:GetUuid(_source)
        local results = MySQL.Sync.fetchAll(
            "SELECT count(uuid) AS result_count FROM players_identity WHERE uuid = @uuid",
            {
              ['@uuid'] = uuid
            }
        )

        if (results ~= nil and results[1] ~= nil and results[1].result_count > 0) then
            MySQL.Sync.execute(
                "UPDATE players_identity SET health = @health WHERE uuid = @uuid",
                {
                  ['@health'] = health,
                  ['@uuid'] = uuid
                }
            )
        end
    end
)

RegisterServerEvent("Atlantiss::SE::Health:SetPlayerIsDead")
AddEventHandler(
    "Atlantiss::SE::Health:SetPlayerIsDead",
    function(isDead)
        local _source = source
        local uuid = Atlantiss.Identity:GetUuid(_source)

        if (Atlantiss.Health.Dead[uuid] ~= nil) then
            Atlantiss.Health.Dead[uuid] = nil
        end

        if (isDead == false) then return end
      
        Atlantiss.Health.Dead[uuid] = isDead
    end
)

RegisterServerCallback(
    "Atlantiss::SE::Health:IsPlayerDead",
    function(source, callback)
        local uuid = Atlantiss.Identity:GetUuid(source)
        if (Atlantiss.Health.Dead[uuid] ~= nil) then
            callback(true)
        else
            callback(false)
        end
    end
)
