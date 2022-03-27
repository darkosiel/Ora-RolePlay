RegisterServerCallback(
    "onlinePlayers:list",
    function(source, callback)
        local players = {}
        for _, playerId in ipairs(GetPlayers()) do
            local playerFullname = GetPlayerName(playerId)
            if (Ora.Identity:HasFullname(playerId)) then
                playerFullname = Ora.Identity:GetFullname(playerId)
            end
            table.insert(players, {id = playerId, name = playerFullname})
        end

        callback(players)
    end
)
