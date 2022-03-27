IllegalShops = IllegalShops or {}
IllegalShops.SERVER = {}
IllegalShops.SERVER.DEFINED_POSITION= {}
IllegalShops.SERVER.LOADED_POSITION = false

if (IllegalShops.SERVER.LOADED_POSITION == false) then
    IllegalShops.SERVER.LOADED_POSITION = true
    IllegalShops.SERVER.DEFINED_POSITION = IllegalShops.SHARED.GetRandomDealerPosition()
end


--[[
CREATE TABLE `organisation_shop_limit` ( `id` INT NOT NULL AUTO_INCREMENT , `organisation_id` INT NOT NULL , `limitation` LONGTEXT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE `organisation_shop_limit` ADD FOREIGN KEY (`organisation_id`) REFERENCES `organisation`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
]]

Citizen.CreateThread(function()
  print("^1RE-INIT - organisation_shop_limit")
  local organisationProperty = MySQL.Sync.execute(
    "UPDATE organisation_shop_limit SET limitation = @limitation",
    {
      ['@limitation'] = json.encode(IllegalShops.SHARED.GetDefaultLimitation())
    }
)
end)

RegisterServerCallback("Ora::SE::IllegalShop:verifyOrder", 
  function(source, cb, quoteObject)
      local organisationOrder = MySQL.Sync.fetchAll(
          "SELECT * FROM organisation_shop_limit WHERE organisation_id = @organisationId",
          {
            ['@organisationId'] = quoteObject.ORGANISATION.ID,
          }
      )

      if (organisationOrder[1] ~= nil) then
          local canBeOrdered = true
          if (organisationOrder[1].limitation ~= nil) then
              local limitation = json.decode(organisationOrder[1].limitation)

              for index, value in pairs(limitation) do
                  if (quoteObject.ITEMS[index] ~= nil and value >= (quoteObject.ITEMS[index].CURRENT_INDEX - 1)) then
                    -- Nothing to do
                  else
                    canBeOrdered = false
                  end
              end
          end
          cb(canBeOrdered)
      else
          cb(false)
      end
  end
)

RegisterServerEvent("Ora::SE::IllegalShop:registerOrder")
AddEventHandler("Ora::SE::IllegalShop:registerOrder",function(quoteObject)
    local _source = source
    local orderDetails = {}
    local limitation = {}
    local canBeOrdered = false

    local organisationOrder = MySQL.Sync.fetchAll(
        "SELECT * FROM organisation_shop_limit WHERE organisation_id = @organisationId",
        {
          ['@organisationId'] = quoteObject.ORGANISATION.ID,
        }
    )
    
    if (organisationOrder[1] ~= nil) then
          if (organisationOrder[1].limitation ~= nil) then
              limitation = json.decode(organisationOrder[1].limitation)

              for index, value in pairs(limitation) do
                  if (quoteObject.ITEMS[index] ~= nil and value >= (quoteObject.ITEMS[index].CURRENT_INDEX - 1)) then
                      limitation[index] = value - (quoteObject.ITEMS[index].CURRENT_INDEX - 1)
                  end
              end
              canBeOrdered = true
          else 
              canBeOrdered = false
          end
    else 
        canBeOrdered = false
    end

    if (canBeOrdered == false) then
        TriggerClientEvent("Ora::Illegal:ShowNotification", _source, "~r~Une erreur s'est produite lors de votre commande. (".. quoteObject.TOTAL_PRICE .. "$)~s~")
        TriggerClientEvent("Ora::Illegal:ShowNotification", _source, "~r~Veuillez ouvrir un ticket~s~")
        return 
    end

    local organisationProperty = MySQL.Sync.execute(
        "UPDATE organisation_shop_limit SET limitation = @limitation WHERE id = @itemId",
        {
          ['@itemId'] = organisationOrder[1].id,
          ['@limitation'] = json.encode(limitation)
        }
    )

    TriggerClientEvent("Ora::Illegal:ShowNotification", _source, "~g~Votre commande d'un montant de ~h~".. quoteObject.TOTAL_PRICE .."$~h~ est validée~s~")
    TriggerEvent("Ora::Illegal:sendMessageToOrga", quoteObject.ORGANISATION.ID, "Votre faction vient d'acheter au dealer du coin pour un montant de ~h~" .. quoteObject.TOTAL_PRICE .. "$~h~.")
    TriggerEvent("Ora::Illegal:updateOrgaForAllClient", quoteObject.ORGANISATION.ID)
    TriggerEvent("Ora:sendToDiscordFromServer", _source, 21, "[" ..  quoteObject.ORGANISATION.NAME .. "]\nAchat au dealer du coin (" .. quoteObject.TOTAL_PRICE .. "$)", "info")

    local deliveryItems = {}
    for index, value in pairs(quoteObject.ITEMS) do

        for j = 1, value.CURRENT_INDEX - 1, 1 do
          table.insert(deliveryItems, {name = index, data = {quality = 10}, label = nil})
        end
    end

  TriggerClientEvent("Ora::CE::Inventory:AddItems", _source, deliveryItems)

end)


RegisterServerCallback("Ora::SE::Illegal:GetGlobalLimitationForOrganisation", 
  function(source, cb, arg)
      local organisationShopLimit = MySQL.Sync.fetchAll(
          "SELECT * FROM organisation_shop_limit WHERE organisation_id = @organisationId",
          {
            ['@organisationId'] = arg.ORGANISATION.ID,
          }
      )

      if (organisationShopLimit[1] ~= nil) then
          local shopLimit = organisationShopLimit[1]
          shopLimit.limitation = json.decode(shopLimit.limitation)
          cb(json.encode(shopLimit))
      else
          MySQL.Sync.insert(
              "INSERT INTO organisation_shop_limit (organisation_id, limitation) VALUES (@organisationId, @limitation)",
              {
                ['@organisationId'] = arg.ORGANISATION.ID,
                ['@limitation'] = json.encode(IllegalShops.SHARED.GetDefaultLimitation()),
              }
          )

          cb(json.encode(IllegalShops.SHARED.GetDefaultLimitation()))
      end
  end
)

RegisterServerCallback("Ora::SE::Illegal:GetIllegalDealerPosition", 
  function(source, cb)
     cb(json.encode(IllegalShops.SERVER.DEFINED_POSITION))
  end
)

