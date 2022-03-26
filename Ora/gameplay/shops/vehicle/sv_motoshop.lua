


RegisterServerCallback("bikershop:BuyVehicle", function(source, callback,price,targetSource,vehicle)
    local pUUID = Atlantiss.Identity:GetUuid(source)
    local uuid = "jetsam"
    while (Atlantiss.Utils:HasValue(Atlantiss.World.Vehicle.ExistingPlates, vehicle.plate)) do
        vehicle.plate = Atlantiss.World.Vehicle:GenerateRandomPlate()
    end
    local _veh = json.encode(vehicle)

    MySQL.Async.execute(
        'INSERT INTO players_vehicles (uuid,settings,plate,label,plate_identifier) VALUES(@uuid,@settings,@plate,@label,@plateidentifier)',
        {
            ['@uuid'] = uuid,
            ['@settings'] = _veh,
            ['@plate'] = vehicle.plate,
            ['@label'] = vehicle.label,
            ['@plateidentifier'] = vehicle.model .. "|" .. vehicle.plate,
        }
    )

    MySQL.Async.execute(
        'INSERT INTO motos_sold (buyer,model,plate,vendor,prices,date) VALUES(@buyer,@model,@plate,@vendor,@price,@date)',
        {
            ['@buyer'] = uuid,
            ['@vendor'] = pUUID,
            ['@plate'] = vehicle.plate,
            ['@model'] = vehicle.label,
            ['@price'] = price,
            ['@date'] = os.date("%Y-%m-%d %H:%M:%S", os.time())

        }
    )
    --(true)
    callback(true, vehicle.plate)
end)

RegisterServerCallback("bikershop:GetAll", function(source, callback)

    MySQL.Async.fetchAll('SELECT * FROM motos_sold', {}, function(result)
        MySQL.Async.fetchAll('SELECT * FROM players_identity', {}, function(_result)
            callback(result,_result)
        end)
    end)
end)