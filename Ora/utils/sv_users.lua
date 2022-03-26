RegisterServerCallback(
    "onlinePlayers:list",
    function(source, callback)
        local players = {}
        for _, playerId in ipairs(GetPlayers()) do
            local playerFullname = GetPlayerName(playerId)
            if (Atlantiss.Identity:HasFullname(playerId)) then
                playerFullname = Atlantiss.Identity:GetFullname(playerId)
            end
            table.insert(players, {id = playerId, name = playerFullname})
        end

        callback(players)
    end
)
