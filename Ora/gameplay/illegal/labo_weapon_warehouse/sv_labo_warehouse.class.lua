IllegalLabsAndWarehouse = IllegalLabsAndWarehouse or {}

--[[
  CREATE TABLE `organisation_property_order` ( `id` INT NOT NULL AUTO_INCREMENT , `organisation_id` INT NOT NULL , `property_id` INT NOT NULL , `price` INT NOT NULL , `order_detail` LONGTEXT NOT NULL , `status` VARCHAR(255) NOT NULL , `created_at` VARCHAR(255) NOT NULL , PRIMARY KEY (`id`), INDEX (`status`)) ENGINE = InnoDB CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;
  ALTER TABLE `organisation_property_order` ADD CONSTRAINT `fk_orga_prop_order` FOREIGN KEY (`organisation_id`) REFERENCES `organisation`(`id`) ON DELETE CASCADE ON UPDATE CASCADE; ALTER TABLE `organisation_property_order` ADD CONSTRAINT `fk_orga_order` FOREIGN KEY (`property_id`) REFERENCES `organisation_property`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
  ALTER TABLE `organisation_property_order` CHANGE `created_at` `created_at` DATETIME NOT NULL;
  ALTER TABLE `organisation_property_order` ADD `phone` VARCHAR(255) NOT NULL AFTER `order_detail`;
  ALTER TABLE `organisation_property_order` ADD `scheduled_at` DATETIME NOT NULL AFTER `created_at`;
  ALTER TABLE `organisation_property_order` ADD `delivery_position` LONGTEXT NULL AFTER `scheduled_at`;

  CREATE TABLE `organisation_property_workqueue` ( `id` INT NOT NULL AUTO_INCREMENT , `property_id` INT NOT NULL , `organisation_id` INT NOT NULL , `workplace_id` VARCHAR(255) NOT NULL , `production` LONGTEXT NOT NULL , `status` VARCHAR(255) NOT NULL , `created_at` DATETIME NOT NULL , `scheduled_delivery` DATETIME NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;
  ALTER TABLE `organisation_property_workqueue` ADD FOREIGN KEY (`organisation_id`) REFERENCES `organisation`(`id`) ON DELETE CASCADE ON UPDATE CASCADE; ALTER TABLE `organisation_property_workqueue` ADD FOREIGN KEY (`property_id`) REFERENCES `organisation_property`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
  ALTER TABLE `organisation_property_workqueue` ADD INDEX(`workplace_id`)
  ALTER TABLE `organisation_property_workqueue` CHANGE `scheduled_delivery` `scheduled_at` DATETIME NOT NULL;
  ALTER TABLE `organisation_property_workqueue` CHANGE `created_at` `created_at` VARCHAR(255) NOT NULL;
  ALTER TABLE `organisation_property_workqueue` CHANGE `scheduled_at` `scheduled_at` VARCHAR(255) NOT NULL;
  ]]


-- Every friday at the reboot, we will reset all limitations for Weapons Warehouse
local FRIDAY = "5"
if (os.date("%w", os.time()) == FRIDAY) then
    Citizen.CreateThread(function()
        local properties = MySQL.Sync.fetchAll(
            "SELECT op.*, o.name AS organisation_name, o.label AS organisation_label FROM organisation_property AS op INNER JOIN organisation AS o ON op.organisation_id = o.id WHERE type = @weaponType",
            {
                ["@weaponType"] = "weapon"
            }
        )
    
        print("RESETING LIMITATIONS FOR WEAPONS WAREHOUSES")
        for index, value in pairs(properties) do
            print(" --- > [".. value.organisation_label.."] " .. value.organisation_name)
            local basicLimitation = IllegalLabsAndWarehouse.GetLimitationsByBusinessId(value.business_id)
            local targetLimitation = IllegalLabsAndWarehouse.ApplyProductionToLimitation(value.business_id, basicLimitation, value.type, value.production_level)
    
            local organisationProperty = MySQL.Sync.execute(
                "UPDATE organisation_property SET limitation = @limitation WHERE id = @propertyId",
                {
                  ['@propertyId'] = value.id,
                  ['@limitation'] = json.encode(targetLimitation)
                }
            )
    
        end  
    end)
end

Citizen.CreateThread(
  function()
      while (true) do
          -- Every minutes, we check if we have an order to ship.
          Citizen.Wait(1000 * 60)
          
          -- Checking orders for GUNLEADERS
          local orders = MySQL.Sync.fetchAll(
              "SELECT opo.*, op.name AS property_name, op.type AS property_type FROM organisation_property_order AS opo LEFT JOIN organisation_property AS op ON opo.property_id = op.id WHERE scheduled_at <= @now AND status = @processingStatus",
              {
                  ["@now"] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
                  ["@processingStatus"] = "processing"
              }
          )

          if (orders ~= nil and orders[1] ~= nil) then
              for index, value in pairs(orders) do
                  local modifiedRows = MySQL.Sync.execute(
                      "UPDATE organisation_property_order SET status = @status WHERE id = @updateId",
                      {
                        ['@status'] = "waiting_delivery",
                        ['@updateId'] = value.id
                      }
                  )
                  local propertyType = value.property_type

                  TriggerEvent("Ora::Illegal:sendMessageToOrga", value.organisation_id, "~h~Commande #" .. value.id .. "~h~ est prête. Rendez vous à votre dépot pour la récupérer")
                  if (IllegalLabsAndWarehouse.IsDrugType(propertyType)) then
                    TriggerEvent("Ora::Illegal:sendMessageToOrga", value.organisation_id, "~h~LABO DE DROGUE " .. value.property_name .. "~h~")
                    TriggerEvent("Ora:sendToDiscordFromServer", 999999, 21, "[PROPRIETE " .. value.property_name .. "]\nla commande d'ingrédients est prête à être récupérée", "info")
                  else
                    TriggerEvent("Ora::Illegal:sendMessageToOrga", value.organisation_id, "~h~DEPOT D'ARMES " .. value.property_name .. "~h~")
                    TriggerEvent("Ora:sendToDiscordFromServer", 999999, 22, "[PROPRIETE " .. value.property_name .. "]\nla commande d'armes est prête à être récupérée", "info")
                  end

              end
          end

          -- Checking drug making for DRUG LAB
          local orders = MySQL.Sync.fetchAll(
              "SELECT opw.*, op.name AS property_name FROM organisation_property_workqueue AS opw LEFT JOIN organisation_property AS op ON opw.property_id = op.id WHERE scheduled_at <= @now AND status = @processingStatus",
              {
                  ["@now"] = os.time(),
                  ["@processingStatus"] = "processing"
              }
          )

          if (orders[1] ~= nil) then
              for index, value in pairs(orders) do
                  local modifiedRows = MySQL.Sync.execute(
                      "UPDATE organisation_property_workqueue SET status = @status WHERE id = @updateId",
                      {
                        ['@status'] = "waiting_delivery",
                        ['@updateId'] = value.id
                      }
                  )
                  TriggerEvent("Ora:sendToDiscordFromServer", 999999, 21, "[PROPRIETE " .. value.property_name .. "]\nLa drogue est désormais prête à être récupérée", "info")
              end
          end

      end
  end
)

RegisterServerEvent("Ora::Illegal:ChangeOwnerOfProperty")
AddEventHandler(
    "Ora::Illegal:ChangeOwnerOfProperty",
    function(data)
        local propertyId = data.property_id
        local previousOrganisationId = data.old_owner
        local newOrganisationId = data.new_owner

        MySQL.Async.execute(
            "UPDATE organisation_property SET organisation_id = @newOrganisationId WHERE id = @propertyId",
            {
              ['@propertyId'] = propertyId,
              ['@newOrganisationId'] = newOrganisationId
            },
            function (affectedRows)
                TriggerEvent("Ora::Illegal:sendMessageToOrga", newOrganisationId, "Vous avez désormais accès a la propriété.")
                TriggerEvent("Ora::Illegal:setupOrgaForAllClient", previousOrganisationId)
                TriggerEvent("Ora::Illegal:setupOrgaForAllClient", newOrganisationId)
                TriggerEvent("Ora:sendToDiscordFromServer", 999999, 23, "[PROPRIETE #" .. data.property_id .. "]\nLa propriété a été retiré a la faction " .. data.old_owner .. " et donné à la faction " .. data.new_owner, "info")
            end
        )

    end
)

RegisterServerEvent("Ora::Illegal:ChangeOwnerOfPropertyByPolice")
AddEventHandler(
    "Ora::Illegal:ChangeOwnerOfPropertyByPolice",
    function(data)
        local propertyId = data.property_id
        local previousOrganisationId = data.old_owner
        local newOrganisationId = data.new_owner

        MySQL.Async.execute(
            "UPDATE organisation_property SET organisation_id = @newOrganisationId WHERE id = @propertyId",
            {
              ['@propertyId'] = propertyId,
              ['@newOrganisationId'] = newOrganisationId
            },
            function (affectedRows)
                TriggerEvent("Ora::Illegal:sendMessageToOrga", newOrganisationId, "Vous avez enfoncé la porte d'une propriété douteuse.")
                TriggerEvent("Ora::Illegal:sendMessageToOrga", previousOrganisationId, "Une caméra vous indique que la police perquisitionne une de vos propriété.")
                TriggerEvent("Ora::Illegal:setupOrgaForAllClient", previousOrganisationId)
                TriggerEvent("Ora::Illegal:setupOrgaForAllClient", newOrganisationId)
                TriggerEvent("Ora:sendToDiscordFromServer", 999999, 23, "[POLICE - PROPRIETE #" .. data.property_id .. "]\nLa propriété a été retiré a la faction " .. data.old_owner .. " et donné à la faction " .. data.new_owner .. " - Perqusition police", "info")
            end
        )

    end
)

RegisterServerEvent("Ora::Illegal:updateProductionLevel")
AddEventHandler(
    "Ora::Illegal:updateProductionLevel",
    function(data)
        local _source = source
        local newLimitations = IllegalLabsAndWarehouse.ApplyProductionToLimitation(data.PROPERTY.business_id, data.PROPERTY.limitation, data.PROPERTY.type, data.LEVEL)
        
        local organisationProperty = MySQL.Sync.execute(
            "UPDATE organisation_property SET limitation = @limitation, production_level = @level WHERE id = @propertyId",
            {
              ['@propertyId'] = data.PROPERTY.id,
              ['@level'] = data.LEVEL,
              ['@limitation'] = json.encode(newLimitations)
            }
        )

        TriggerEvent("Ora::Illegal:sendMessageToOrga", data.PROPERTY.organisation_id, "La propriété ~h~" .. data.PROPERTY.name .. "~h~ est désormais en production niveau : ".. data.LEVEL ..".")
        TriggerEvent("Ora::Illegal:updateOrgaForAllClient", data.PROPERTY.organisation_id)
        TriggerEvent("Ora:sendToDiscordFromServer", _source, 23, "[PROPRIETE " .. data.PROPERTY.name .. "]\nLa propriété est passé en production niveau " .. data.LEVEL, "info")

    end
)

RegisterServerEvent("Ora::Illegal:updateSecurityLevel")
AddEventHandler(
    "Ora::Illegal:updateSecurityLevel",
    function(data)
        local _source = source
        
        local organisationProperty = MySQL.Sync.execute(
            "UPDATE organisation_property SET security_level = @level WHERE id = @propertyId",
            {
              ['@propertyId'] = data.PROPERTY.id,
              ['@level'] = data.LEVEL
            }
        )

        TriggerEvent("Ora::Illegal:sendMessageToOrga", data.PROPERTY.organisation_id, "La propriété ~h~" .. data.PROPERTY.name .. "~h~ est désormais en sécurité niveau : ".. data.LEVEL ..".")
        TriggerEvent("Ora::Illegal:updateOrgaForAllClient", data.PROPERTY.organisation_id)
        TriggerEvent("Ora:sendToDiscordFromServer", _source, 23, "[PROPRIETE " .. data.PROPERTY.name .. "]\nLa propriété est passé en securité niveau " .. data.LEVEL, "info")
    end
)

RegisterServerEvent("Ora::Illegal:retrieveProductionFromWorkplaceQueue")
AddEventHandler("Ora::Illegal:retrieveProductionFromWorkplaceQueue",function(propertyWokplaceObjectAsJson)
    local _source = source
    local propertyWokplaceObject = json.decode(propertyWokplaceObjectAsJson)

    local organisationPropertyWorkqueue = MySQL.Sync.fetchAll(
        "SELECT * FROM organisation_property_workqueue WHERE id = @id AND workplace_id = @workplaceId AND property_id = @propertyId",
        {
          ['@propertyId'] = propertyWokplaceObject.PROPERTY.id,
          ['@workplaceId'] = propertyWokplaceObject.WORKPLACE_ID,
          ['@id'] = propertyWokplaceObject.CURRENT_PRODUCTION.id,
        }
    )

    if (organisationPropertyWorkqueue[1] == nil) then
        TriggerClientEvent("Ora::Illegal:ShowNotification", _source, "~r~Cette production a déjà été recupérée par quelqu'un d'autre.~s~")
        TriggerEvent("Ora:sendToDiscordFromServer", _source, 21, "[PROPRIETE " .. propertyWokplaceObject.PROPERTY.name .. "]\nTentative de récupération d'un contenu déjà délivré ("..  propertyWokplaceObject.WORKPLACE_ID ..")", "error")
    end

    if (organisationPropertyWorkqueue[1] ~= nil) then
        if (organisationPropertyWorkqueue[1].status ~= "waiting_delivery") then
            TriggerClientEvent("Ora::Illegal:ShowNotification", _source, "~r~Cette production a déjà été recupérée par quelqu'un d'autre.~s~")
            TriggerEvent("Ora:sendToDiscordFromServer", _source, 21, "[PROPRIETE " .. propertyWokplaceObject.PROPERTY.name .. "]\nTentative de récupération d'un contenu déjà délivré ("..  propertyWokplaceObject.WORKPLACE_ID ..")", "error")
        else
            local production = json.decode(organisationPropertyWorkqueue[1].production)
            MySQL.Async.execute(
                "DELETE FROM organisation_property_workqueue WHERE id = @id",
                {['@id']    = propertyWokplaceObject.CURRENT_PRODUCTION.id},
                function (affectedRows)
                    local sendItems = {}

                    for i = 1, production.count, 1 do 
                        table.insert(sendItems, 
                            {name = production.item_name, data = {quality = production.quality}, label = IllegalLabsAndWarehouse.GetDrugQualityLabel(production.quality)}
                        )
                    end

                    TriggerClientEvent("Ora::CE::Inventory:AddItems", _source, sendItems)
                    TriggerClientEvent("Ora::Illegal:ShowNotification", _source, "~g~Vous avez récupéré ".. production.count .."x pochons de drogue.~s~")
                    TriggerEvent("Ora:sendToDiscordFromServer", _source, 21, "[PROPRIETE " .. propertyWokplaceObject.PROPERTY.name .. "]\nRécupération de ".. production.count .."x pochons de drogue", "info")
                end
            )
        end
    end

end)

RegisterServerEvent("Ora::Illegal:createPropertyWorkplaceQueue")
AddEventHandler("Ora::Illegal:createPropertyWorkplaceQueue",function(propertyWokplaceObjectAsJson)
    local _source = source
    local propertyWokplaceObject = json.decode(propertyWokplaceObjectAsJson)

    local organisationProperty = MySQL.Sync.fetchAll(
        "SELECT count(id) as resultsCount FROM organisation_property_workqueue WHERE property_id = @propertyId AND workplace_id = @workplaceId",
        {
          ['@propertyId'] = propertyWokplaceObject.PROPERTY.id,
          ['@workplaceId'] = propertyWokplaceObject.WORKPLACE_ID
        }
    )

    if (organisationProperty[1] ~= nil) then
        if (organisationProperty[1].resultsCount > 0) then
            TriggerClientEvent("Ora::Illegal:ShowNotification", _source, "~r~Impossible de lancer la production. Il y a déjà une production en cours~s~")
            TriggerEvent("Ora:sendToDiscordFromServer", _source, 21, "[PROPRIETE #" .. propertyWokplaceObject.PROPERTY.name .. "]\nTentative de lancement d'une production alors qu'une production est déjà en cours (" .. propertyWokplaceObject.WORKPLACE_ID .. ")", "error")
        else
            local newId = MySQL.Sync.insert(
                "INSERT INTO organisation_property_workqueue (organisation_id, property_id, workplace_id, production, status, created_at, scheduled_at) VALUES (@organisation_id, @property_id, @workplace_id, @production, @status, @created_at, @scheduled_at)",
                   {
                        ['@organisation_id']    = propertyWokplaceObject.PROPERTY.organisation_id,
                        ['@property_id']        = propertyWokplaceObject.PROPERTY.id,
                        ['@workplace_id']       = propertyWokplaceObject.WORKPLACE_ID,
                        ['@production']         = json.encode(propertyWokplaceObject.PRODUCTION),
                        ['@status']             = "processing",
                        ['@created_at']         = os.time(),
                        ['@scheduled_at']       = os.time() + (propertyWokplaceObject.TIME * 60),
                    }
            )

            for removeItemIndex, removeItemValue in pairs(propertyWokplaceObject.NEEDED_MATERIALS) do
                TriggerClientEvent("Ora::CE::Inventory:RemoveAnyItemsWithName", _source, removeItemValue.name, removeItemValue.count)
            end

            TriggerClientEvent("Ora::Illegal:ShowNotification", _source, "~g~Production lancée. Fin estimée dans : ".. propertyWokplaceObject.TIME .." minutes~s~")
            TriggerEvent("Ora:sendToDiscordFromServer", _source, 21, "[PROPRIETE #" .. propertyWokplaceObject.PROPERTY.name .. "]\nLancement d'une production de drogue pour une durée de " ..  propertyWokplaceObject.TIME .. " minutes (" .. propertyWokplaceObject.WORKPLACE_ID .. ")", "info")
        end
    end

end)

RegisterServerEvent("Ora:Illegal:registerOrder")
AddEventHandler("Ora:Illegal:registerOrder",function(quoteObject)
    local _source = source
    local orderDetails = {}
    local organisationProperty = MySQL.Sync.fetchAll(
        "SELECT * FROM organisation_property WHERE id = @propertyId",
        {
          ['@propertyId'] = quoteObject.PROPERTY.id,
        }
    )

    if quoteObject.NO_LIMIT == nil or quoteObject.NO_LIMIT == false then
        local canBeOrdered = false
        local limitation = {}
        if (organisationProperty[1] ~= nil) then
              if (organisationProperty[1].limitation ~= nil) then
                  limitation = json.decode(organisationProperty[1].limitation)
    
                  for index, value in pairs(limitation) do
                      if (quoteObject.ITEMS[value.name] ~= nil and value.byWeek >= (quoteObject.ITEMS[value.name].CURRENT_INDEX - 1)) then
                          limitation[index].byWeek = value.byWeek - (quoteObject.ITEMS[value.name].CURRENT_INDEX - 1)
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
            "UPDATE organisation_property SET limitation = @limitation WHERE id = @propertyId",
            {
              ['@propertyId'] = quoteObject.PROPERTY.id,
              ['@limitation'] = json.encode(limitation)
            }
        )
    end

    for index, value in pairs(quoteObject.ITEMS) do
        orderDetails[index] = {price = value.PRICE, qty = (value.CURRENT_INDEX - 1)}
    end

    local newId = MySQL.Sync.insert(
        "INSERT INTO organisation_property_order (organisation_id, property_id, price, order_detail, phone, status, created_at, scheduled_at, delivery_position) VALUES (@organisation_id, @property_id, @price, @order_detail, @phone, @status, @created_at, @scheduled_at, @delivery_position)",
           {
                ['@organisation_id']    = quoteObject.PROPERTY.organisation_id,
                ['@property_id']        = quoteObject.PROPERTY.id,
                ['@price']              = quoteObject.TOTAL_PRICE,
                ['@order_detail']       = json.encode(orderDetails),
                ['@status']             = "processing",
                ['@phone']              = math.random(10,99) .. math.random(10,99) .. quoteObject.PROPERTY.organisation_id .. quoteObject.PROPERTY.id,
                ['@created_at']         = os.date("%Y-%m-%d %H:%M:%S", os.time()),
                ['@scheduled_at']       = os.date("%Y-%m-%d %H:%M:%S", (os.time() + math.random(1000, 1800))),
                ['@delivery_position']  = json.encode(quoteObject.DELIVERY_POSITION)
            }
    )

    TriggerClientEvent("Ora::Illegal:ShowNotification", _source, "~g~Votre commande d'un montant de ~h~".. quoteObject.TOTAL_PRICE .."$~h~ est validée~s~")
    TriggerClientEvent("Ora::Illegal:ShowNotification", _source, "~b~Votre faction sera contactée d'ici les 30 prochaines minutes~s~")

    if (IllegalLabsAndWarehouse.IsDrugType(quoteObject.PROPERTY.type)) then
        TriggerEvent("Ora::Illegal:sendMessageToOrga", quoteObject.PROPERTY.organisation_id, "Commande d'ingrédients d'une valeur de ~h~" .. quoteObject.TOTAL_PRICE .. "$~h~ effectuée.")
        local message = "[PROPRIETE #" .. quoteObject.PROPERTY.name .. "]\nLancement d'une commande d'ingrédients de drogue (" .. quoteObject.TOTAL_PRICE .. "$)\n\nDétails commande : "
        for orderDetailIndex, orderDetailValue in pairs(orderDetails) do
            if orderDetailValue.qty > 0 then
                message = message .. "\n-" ..  orderDetailIndex .. " : " .. orderDetailValue.qty .. "x / " .. orderDetailValue.price .. "$"
            end
        end
        TriggerEvent("Ora:sendToDiscordFromServer", _source, 21, message, "info")
    else
        local message = "[PROPRIETE #" .. quoteObject.PROPERTY.name .. "]\nLancement d'une commande d'armes (" .. quoteObject.TOTAL_PRICE .. "$)\n\nDétails commande : "
        for orderDetailIndex, orderDetailValue in pairs(orderDetails) do
            if orderDetailValue.qty > 0 then
                message = message .. "\n-" ..  orderDetailIndex .. " : " .. orderDetailValue.qty .. "x / " .. orderDetailValue.price .. "$"
            end
        end
        TriggerEvent("Ora::Illegal:sendMessageToOrga", quoteObject.PROPERTY.organisation_id, "Commande d'armes d'une valeur de ~h~" .. quoteObject.TOTAL_PRICE .. "$~h~ effectuée.")
        TriggerEvent("Ora:sendToDiscordFromServer", _source, 22, message, "info")
    end

    TriggerEvent("Ora::Illegal:updateOrgaForAllClient", quoteObject.PROPERTY.organisation_id)
end)

RegisterServerCallback("Ora:Illegal:GetOrderHistoryByPropertyId", 
  function(source, cb, propertyId) 
      local orders = MySQL.Sync.fetchAll(
          "SELECT opo.*, op.type as property_type  FROM organisation_property_order AS opo INNER JOIN organisation_property AS op ON op.id = opo.property_id WHERE property_id = @propertyId ORDER BY id DESC",
          {
              ["@propertyId"] = propertyId
          }
      )

      local ordersFormated = {}

      for index, value in pairs(orders) do
          if (value.delivery_position == nil) then 
            value.delivery_position = '{}'
          end

          table.insert(ordersFormated, {
              id = value.id,
              organisation_id = value.organisation_id,
              property_id = value.property_id,
              price = value.price,
              order_detail = json.decode(value.order_detail),
              phone = value.phone,
              status = value.status,
              created_at = value.created_at,
              scheduled_at = value.scheduled_at,
              delivery_position = json.decode(value.delivery_position),
              property_type = value.property_type
          })
      end

      cb(json.encode(ordersFormated))
  end
)

RegisterServerCallback("Ora:Illegal:OrderCanBeDelivered", 
  function(source, cb, id) 
    local orders = MySQL.Sync.fetchAll(
        "SELECT * FROM organisation_property_order WHERE id = @id",
        {
            ["@id"] = id
        }
    )

    if (orders[1] ~= nil) then
        if orders[1].status == "waiting_delivery" then 
            local affectedRows = MySQL.Sync.execute(
                "UPDATE organisation_property_order SET status = @status WHERE id = @id",
                {
                    ["@id"] = id,
                    ["@status"] = "delivered"
                }
            )
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end

  end
)

RegisterServerCallback("Ora:Illegal:GetWaitingOrderByPhoneNumber", 
  function(source, cb, phoneNumber) 
      local orders = MySQL.Sync.fetchAll(
          "SELECT opo.*, op.type as property_type FROM organisation_property_order AS opo INNER JOIN organisation_property AS op ON op.id = opo.property_id WHERE phone = @phoneNumber and status = @status LIMIT 1",
          {
              ["@phoneNumber"] = phoneNumber,
              ["@status"] = "waiting_delivery"
          }
      )

      local orderFormated = {}

      if (orders[1] ~= nil) then
            local order = orders[1]
            orderFormated = {
                id = order.id,
                organisation_id = order.organisation_id,
                property_id = order.property_id,
                price = order.price,
                order_detail = json.decode(order.order_detail),
                phone = order.phone,
                status = order.status,
                created_at = order.created_at,
                scheduled_at = order.scheduled_at,
                delivery_position = json.decode(order.delivery_position),
                property_type = order.property_type
            }
      end

      cb(json.encode(orderFormated))
  end
)


RegisterServerCallback("Ora:Illegal:GetPropertyByName", 
  function(source, cb, name) 

    local properties = MySQL.Sync.fetchAll(
        "SELECT * FROM organisation_property WHERE name = @propertyName",
        {
            ["@propertyName"] = name
        }
    )

    if (properties[1] ~= nil) then
          cb({ 
              id = properties[1].id, 
              organisation_id = properties[1].organisation_id, 
              name = properties[1].name, 
              type = properties[1].type, 
              business_id = properties[1].business_id,
              outside_door = json.decode(properties[1].outside_door),
              production_level = properties[1].production_level,
              security_level = properties[1].security_level,
              capacity = properties[1].capacity,
              limitation = json.decode(properties[1].limitation)
          })
    else
        cb({})
    end
  end
)

RegisterServerCallback("Ora:Illegal:GetPropertyById", 
  function(source, cb, id) 

    local properties = MySQL.Sync.fetchAll(
        "SELECT * FROM organisation_property WHERE id = @propertyId",
        {
            ["@propertyId"] = id
        }
    )

    if (properties[1] ~= nil) then
          cb({ 
              id = properties[1].id, 
              organisation_id = properties[1].organisation_id, 
              name = properties[1].name, 
              type = properties[1].type, 
              business_id = properties[1].business_id,
              outside_door = json.decode(properties[1].outside_door),
              production_level = properties[1].production_level,
              security_level = properties[1].security_level,
              capacity = properties[1].capacity,
              limitation = json.decode(properties[1].limitation)
          })
    else
        cb({})
    end
  end
)

RegisterServerCallback("Ora:Illegal:GetIllegalProperties", 
  function(source, cb) 
        local properties = MySQL.Sync.fetchAll(
            "SELECT * FROM organisation_property",
            {}
        )

        local propertiesResult = {}

        for index, value in ipairs(properties) do
            table.insert(
                propertiesResult, 
                {
                    id = value.id, 
                    organisation_id = value.organisation_id, 
                    name = value.name, 
                    type = value.type, 
                    business_id = value.business_id,
                    outside_door = json.decode(value.outside_door),
                    production_level = value.production_level,
                    security_level = value.security_level,
                    capacity = value.capacity,
                    limitation = json.decode(value.limitation),
                    last_attacked_at = value.last_attacked_at,
                    today = os.time()
                }
            )
        end
        
        cb(json.encode(propertiesResult))
  end
)

RegisterServerCallback("Ora:Illegal:verifyOrder", 
  function(source, cb, quoteObject)
      local organisationProperty = MySQL.Sync.fetchAll(
          "SELECT * FROM organisation_property WHERE id = @propertyId",
          {
            ['@propertyId'] = quoteObject.PROPERTY.id,
          }
      )

      if (organisationProperty[1] ~= nil) then
          local canBeOrdered = true
          if (organisationProperty[1].limitation ~= nil) then
              local limitation = json.decode(organisationProperty[1].limitation)

              for index, value in pairs(limitation) do
                  if (quoteObject.ITEMS[value.name] ~= nil and value.byWeek >= (quoteObject.ITEMS[value.name].CURRENT_INDEX - 1)) then
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

RegisterServerCallback("Ora:Illegal:GetWorkplaceQueueByPropertyIdAndWorkplaceId", 
  function(source, cb, arg)
      local propertyWorkplace = MySQL.Sync.fetchAll(
          "SELECT * FROM organisation_property_workqueue WHERE property_id = @propertyId AND workplace_id = @workplaceId",
          {
            ['@propertyId'] = arg.PROPERTY_ID,
            ['@workplaceId'] = arg.WORKPLACE_ID
          }
      )

      if (propertyWorkplace[1] ~= nil) then
          propertyWorkplace[1].current_time = os.time()
          cb(json.encode(propertyWorkplace[1]))
      else
          cb(json.encode({}))
      end
  end
)
