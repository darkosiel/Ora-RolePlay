RegisterServerCallback(
    "onlinePlayers:list",
    function(source, callback, onlyId)
        local players = {}
        if onlyId == nil or onlyId == false then
            for _, playerId in ipairs(GetPlayers()) do
                local playerFullname = GetPlayerName(playerId)
                if (Ora.Identity:HasFullname(playerId)) then
                    playerFullname = Ora.Identity:GetFullname(playerId)
                end
                table.insert(players, {id = playerId, name = playerFullname})
            end
        else
           players = GetPlayers()            
        end

        callback(players)
    end
)

RegisterServerCallback("onlinePlayers:getNumberOfPlayer", function(source, callback) 
    callback(#GetPlayers()) 
end)