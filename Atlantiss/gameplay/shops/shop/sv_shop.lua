BikeRentalRecord = {}

RegisterServerEvent("atlantiss_rental:addVehicle")
AddEventHandler(
    "atlantiss_rental:addVehicle",
    function(rentalIdentifier, price)
        BikeRentalRecord[rentalIdentifier] = price
    end
)

RegisterServerEvent("Atlantiss::SE::Receipt:CreateReceipt")
AddEventHandler(
    "Atlantiss::SE::Receipt:CreateReceipt",
    function(args)
        local _source = source
        local totalPrice = args.PRICE
        local pawnShop = args.PAWNSHOP

        TriggerClientEvent("Atlantiss::CE::Inventory:AddItems", _source, {{name = "receipt", data = { price = totalPrice, date = os.date("%Y-%m-%d %H:%M", os.time()), pawnshop =  pawnShop.pawnshop_receipt}, label = pawnShop.pawnshop_receipt .. " | " .. totalPrice .. "$" .. " | " .. os.date("%Y-%m-%d %H:%M", os.time())}})
    end
)


RegisterServerCallback(
    "atlantiss_rental:getRentalPrice",
    function(source, callback, rentalIdentifier)
        if (BikeRentalRecord[rentalIdentifier] ~= nil) then
            callback(BikeRentalRecord[rentalIdentifier])
        else
            callback(false)
        end
    end
)

RegisterServerCallback("atlantiss:getNewNumber", function(source, callback)
    local identifiers = GetIdentifiers(source).steam
    MySQL.Async.fetchAll("SELECT phone_number FROM users", nil, function(result)
        callback(result)
    end)
end)

