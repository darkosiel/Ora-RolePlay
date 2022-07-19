local function insertNewVehicleIntoDatabase(seller, buyer, vehicleOptions, plate, label, price)
    local vehicleOptionsObject = json.decode(vehicleOptions)
    MySQL.Async.execute(
        "INSERT INTO players_vehicles (uuid,settings,plate,label,plate_identifier) VALUES(@uuid,@settings,@plate,@label,@plateidentifier)",
        {
            ["@uuid"] = buyer,
            ["@settings"] = vehicleOptions,
            ["@plate"] = plate,
            ["@label"] = label,
            ["@plateidentifier"] = vehicleOptionsObject.model .. "|" .. plate
        }
    )

    MySQL.Async.execute(
        "INSERT INTO vehicles_sold_nord (buyer,model,plate,vendor,prices,date) VALUES(@buyer,@model,@plate,@vendor,@price,@date)",
        {
            ["@buyer"] = buyer,
            ["@vendor"] = seller,
            ["@plate"] = plate,
            ["@model"] = label,
            ["@price"] = price,
            ["@date"] = os.date("%Y-%m-%d %H:%M:%S", os.time())
        }
    )
    return true
end

RegisterServerCallback(
    "autoshop:BuyVehicle",
    function(source, callback, price, targetSource, vehicle)
        local vehicleOptions = json.encode(vehicle)
        local seller = Ora.Identity:GetUuid(source)
        while (Ora.Utils:HasValue(Ora.World.Vehicle.ExistingPlates, vehicle.plate)) do
            vehicle.plate = Ora.World.Vehicle:GenerateRandomPlate()
        end
        insertNewVehicleIntoDatabase(seller, "jetsam", vehicleOptions, vehicle.plate, vehicle.label, price)
        callback(true, vehicle.plate)
    end
)

RegisterServerCallback(
    "autoshop:BuyVehicleForCompany",
    function(source, callback, price, company, vehicle)
        local vehicleOptions = json.encode(vehicle)
        local seller = Ora.Identity:GetUuid(source)
        while (Ora.Utils:HasValue(Ora.World.Vehicle.ExistingPlates, vehicle.plate)) do
            vehicle.plate = Ora.World.Vehicle:GenerateRandomPlate()
        end
        insertNewVehicleIntoDatabase(seller, company, vehicleOptions, vehicle.plate, vehicle.label, price)
        callback(true, vehicle.plate)
    end
)

RegisterServerCallback(
    "autoshop:GetAll",
    function(source, callback)
        MySQL.Async.fetchAll(
            "SELECT * FROM vehicles_sold_nord",
            {},
            function(result)
                MySQL.Async.fetchAll(
                    "SELECT * FROM players_identity",
                    {},
                    function(_result)
                        callback(result, _result)
                    end
                )
            end
        )
    end
)