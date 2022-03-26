RegisterNetEvent("TreasureHunt:showHint")
AddEventHandler(
    "TreasureHunt:showHint",
    function(nextHint, rewardNumber)
        print(nextHint)
        SendNUIMessage(
            {
                action = "showHint",
                data = nextHint,
                rewardNumber = rewardNumber
            }
        )
        Wait(10000)
        SendNUIMessage(
            {
                action = "hide"
            }
        )
    end
)
