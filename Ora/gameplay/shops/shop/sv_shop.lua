BikeRentalRecord = {}

RegisterServerEvent("Ora_rental:addVehicle")
AddEventHandler(
    "Ora_rental:addVehicle",
    function(rentalIdentifier, price)
        BikeRentalRecord[rentalIdentifier] = price
    end
)

RegisterServerEvent("Ora::SE::Receipt:CreateReceipt")
AddEventHandler(
    "Ora::SE::Receipt:CreateReceipt",
    function(args)
        local _source = source
        local totalPrice = args.PRICE
        local pawnShop = args.PAWNSHOP

        TriggerClientEvent("Ora::CE::Inventory:AddItems", _source, {{name = "receipt", data = { price = totalPrice, date = os.date("%Y-%m-%d %H:%M", os.time()), pawnshop =  pawnShop.pawnshop_receipt}, label = pawnShop.pawnshop_receipt .. " | " .. totalPrice .. "$" .. " | " .. os.date("%Y-%m-%d %H:%M", os.time())}})
    end
)


RegisterServerCallback(
    "Ora_rental:getRentalPrice",
    function(source, callback, rentalIdentifier)
        if (BikeRentalRecord[rentalIdentifier] ~= nil) then
            callback(BikeRentalRecord[rentalIdentifier])
        else
            callback(false)
        end
    end
)

RegisterServerCallback("Ora:getNewNumber", function(source, callback)
    local identifiers = GetIdentifiers(source).steam
    MySQL.Async.fetchAll("SELECT phone_number FROM users", nil, function(result)
        callback(result)
    end)
end)

RegisterServerCallback(
  "Ora::SE::NpcJobs:DrivingSchool::CanPass",
  function(src, cb)
    local UUID = Ora.Identity:GetUuid(src)

    MySQL.Async.fetchAll(
      "SELECT permis2 FROM users WHERE uuid = @uuid",
      {["@uuid"] = UUID},
      function(res)
          if (res[1].permis2 == 0) then
            cb(true)
          else
            cb(false)
          end
      end
    )
  end
)

