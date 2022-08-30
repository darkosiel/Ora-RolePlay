Ora.Health.Dead = {}

---- Already present in core/module/player/server.lua
-- RegisterServerEvent("Ora::SE::Player:RegisterHealth")
-- AddEventHandler(
--     "Ora::SE::Player:RegisterHealth",
--     function(health)
--         local _source = source
--         local uuid = Ora.Identity:GetUuid(_source)
--         local results = MySQL.Sync.fetchAll(
--             "SELECT count(uuid) AS result_count FROM players_identity WHERE uuid = @uuid",
--             {
--               ['@uuid'] = uuid
--             }
--         )

--         if (results ~= nil and results[1] ~= nil and results[1].result_count > 0) then
--             MySQL.Sync.execute(
--                 "UPDATE players_identity SET health = @health WHERE uuid = @uuid",
--                 {
--                   ['@health'] = health,
--                   ['@uuid'] = uuid
--                 }
--             )
--         end
--     end
-- )

RegisterServerEvent("Ora::SE::Health:SetPlayerIsDead", function(isDead)
    local _source = source
    local uuid = Ora.Identity:GetUuid(_source)

    if (Ora.Health.Dead[uuid] ~= nil) then
        Ora.Health.Dead[uuid] = nil
    end

    if (isDead) then 
        Ora.Health.Dead[uuid] = isDead
    end
    
    SaveResourceFile("Ora", "core/modules/health/playersDead.json", json.encode(Ora.Health.Dead), -1)
end)

AddEventHandler("onServerResourceStart", function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        local data = LoadResourceFile("Ora", "core/modules/health/playersDead.json")
        Ora.Health.Dead = json.decode(data ~= nil and data or "{}")
    end
end)

RegisterServerCallback("Ora::SE::Health:IsPlayerDead",function(source, callback)
    local uuid = Ora.Identity:GetUuid(source)
    print(source, uuid, Ora.Health.Dead[uuid])
    if (Ora.Health.Dead[uuid] ~= nil) then
        callback(true)
    else
        callback(false)
    end
end)
