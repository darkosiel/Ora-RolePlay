Citizen.CreateThread(
    function()
        while (true) do
            for _, playerId in ipairs(GetPlayers()) do
                SetEntityDistanceCullingRadius(GetPlayerPed(playerId), 400.0)
            end
            Wait(60000)
        end
    end
)