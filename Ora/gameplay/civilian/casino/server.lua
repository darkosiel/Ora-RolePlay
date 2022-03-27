while (exports["kgv-blackjack"] == nil) do
    Wait(500)
    print("Waiting for Export")
end

local CasinoStats = {
    TOTAL_BET = 0,
    TOTAL_WIN = 0
}


Citizen.CreateThread(
  function()
      while (true) do
          -- Every 60 minutes update
          Citizen.Wait(1000 * 60 * 60)

          if (CasinoStats.TOTAL_BET > 0) then
            local playerWinRate = ((CasinoStats.TOTAL_WIN) * 100.0)  / CasinoStats.TOTAL_BET
            local casinoWinRate = 100 - playerWinRate

            TriggerEvent(
                "Ora:sendToDiscordFromServer",
                999999,
                28,
                    string.format(
                        "CASINO RESUME DES GAINS POUR LA DERNIERE HEURE\n\n* Total joué : %s\n* Total gain casino : %s\n* Total gain joueur : %s\n\nRépartition des gains :\n* Casino : %s\n* Joueur : %s",
                        CasinoStats.TOTAL_BET .. "$",
                        CasinoStats.TOTAL_BET - CasinoStats.TOTAL_WIN .. "$",
                        CasinoStats.TOTAL_WIN .. "$",
                        math.floor(casinoWinRate) .. "%",
                        math.floor(playerWinRate) .. "%"
                    ),
                "info"
            )
          end

          CasinoStats.TOTAL_BET = 0
          CasinoStats.TOTAL_WIN = 0
      end
  end
)


exports["kgv-blackjack"]:SetGetChipsCallback(
    function(source)
        local _source = source
        local result =
            MySQL.Sync.fetchAll(
            "SELECT inventory FROM players_inventory WHERE uuid = @uuid",
            {
                ["@uuid"] = Ora.Identity:GetUuid(_source)
            }
        )
        local numberOfPieces = 0

        if (result[1] ~= nil and result[1].inventory ~= nil) then
            local inventory = json.decode(result[1].inventory)

            if (inventory["casinopiece"] ~= nil) then
                numberOfPieces = #inventory["casinopiece"]
                TriggerClientEvent(
                    "RageUI:Popup",
                    source,
                    {message = "~r~Vous avez " .. numberOfPieces .. " Jetons de Casino $10~s~"}
                )
            else
                TriggerClientEvent("RageUI:Popup", source, {message = "~r~Vous avez 0 Jetons de Casino $10~s~"})
            end
        else
            TriggerClientEvent("RageUI:Popup", source, {message = "~r~Vous avez 0 Jetons de Casino $10~s~"})
        end

        return numberOfPieces * 10
    end
)

exports["kgv-blackjack"]:SetTakeChipsCallback(
    function(source, amount)
        if (amount > 0) then
            local itemToRemove = math.floor(amount / 10)
            TriggerClientEvent(
                "RageUI:Popup",
                source,
                {message = "~y~Vous avez misé " .. itemToRemove .. "x Jetons de Casino $10~s~"}
            )
            TriggerEvent(
                  "Ora:sendToDiscordFromServer",
                  source,
                  27,
                  "MISE : " .. itemToRemove * 10 .."$",
                  "info"
            )
            CasinoStats.TOTAL_BET = CasinoStats.TOTAL_BET +  (itemToRemove * 10)
            Wait(50)
            TriggerClientEvent("Ora::CE::Inventory:RemoveAnyItemsWithName", source, "casinopiece", itemToRemove)
        end
    end
)

exports["kgv-blackjack"]:SetGiveChipsCallback(
    function(source, amount)
        local _source = source
        if (amount > 0) then
            local itemToAdd = math.floor(amount / 10)
            local items = {}

            TriggerClientEvent(
                "RageUI:Popup",
                _source,
                {
                    message = "~g~~h~BRAVO~h~ Vous avez reçu " .. itemToAdd .. "x Jetons de Casino $10~s~"
                }
            )

            TriggerEvent(
                    "Ora:sendToDiscordFromServer",
                    source,
                    27,
                    "GAGNE : " .. itemToAdd * 10 .."$",
                    "info"
            )

            CasinoStats.TOTAL_WIN = CasinoStats.TOTAL_WIN +  (itemToAdd * 10)

            for i = 1, itemToAdd, 1 do
                table.insert(items, {name = "casinopiece", data = {}, label = nil})
            end

            local sendItems = {}
            local itemSent = 0

            for key, v in pairs(items) do
                table.insert(sendItems, v)
                itemSent = itemSent + 1
                if (itemSent >= 150) then
                    TriggerClientEvent("Ora::CE::Inventory:AddItems", _source, sendItems)
                    sendItems = {}
                    itemSent = 0
                    Wait(100)
                end
            end
            TriggerClientEvent("Ora::CE::Inventory:AddItems", _source, sendItems)
        end
    end
)
