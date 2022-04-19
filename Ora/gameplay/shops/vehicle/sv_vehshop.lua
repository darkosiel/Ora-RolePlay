-- RegisterServerCallback("vehicleshop:BuyVehicle", function(source, callback,price,targetSource,vehicle)
--     local _veh = json.encode(vehicle)
--     local pUUID = Player.GetPlayer(source).uuid

--     MySQL.Async.execute(
--         'INSERT INTO players_vehicles (uuid,settings,plate,label) VALUES(@uuid,@settings,@plate,@label)',
--         {
--             ['@uuid'] = targetSource,
--             ['@settings'] = _veh,
--             ['@plate'] = vehicle.plate,
--             ['@label'] = vehicle.label,

--         }
--     )

--     MySQL.Async.execute(
--         'INSERT INTO vehicles_sold_nord (buyer,model,plate,vendor,prices,date) VALUES(@buyer,@model,@plate,@vendor,@price,@date)',
--         {
--             ['@buyer'] = uuid,
--             ['@vendor'] = pUUID,
--             ['@plate'] = vehicle.plate,
--             ['@model'] = vehicle.label,
--             ['@price'] = price,
--             ['@date'] = os.date("%Y-%m-%d %H:%M:%S", os.time())

--         }
--     )
--     --(true)
--     callback(true)
-- end)

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
        "INSERT INTO vehicles_sold (buyer,model,plate,vendor,prices,date) VALUES(@buyer,@model,@plate,@vendor,@price,@date)",
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
    "vehicleshop:BuyVehicle",
    function(source, callback, price, _targetSource, vehicle)
        local vehicleOptions = json.encode(vehicle)
        local seller = Ora.Identity:GetUuid(source)
        while (Ora.Utils:HasValue(Ora.World.Vehicle.ExistingPlates, vehicle.plate)) do
            vehicle.plate = Ora.World.Vehicle:GenerateRandomPlate()
        end
        insertNewVehicleIntoDatabase(seller, "concess", vehicleOptions, vehicle.plate, vehicle.label, price)
        callback(true, vehicle.plate)
    end
)

RegisterServerCallback(
    "vehicleshop:BuyVehicleForCompany",
    function(source, callback, price, company, vehicle)
        local vehicleOptions = json.encode(vehicle)
        local seller = Ora.Identity:GetUuid(source)
        while (Ora.Utils:HasValue(Ora.World.Vehicle.ExistingPlates, vehicle.plate)) do
            vehicle.plate = Ora.World.Vehicle:GenerateRandomPlate()
        end
        insertNewVehicleIntoDatabase(seller, "concess", vehicleOptions, vehicle.plate, vehicle.label, price)
        callback(true, vehicle.plate)
    end
)

RegisterServerCallback(
    "vehicleshop:GetAll",
    function(source, callback)
        MySQL.Async.fetchAll(
            "SELECT * FROM vehicles_sold",
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

RegisterServerEvent("vehicle:SetProperties")
AddEventHandler(
    "vehicle:SetProperties",
    function(plate, dat)
        MySQL.Async.execute(
            "UPDATE players_vehicles set settings = @settings WHERE plate = @plate",
            {
                ["@settings"] = json.encode(dat),
                ["@plate"] = plate
            }
        )
    end
)

RegisterServerCallback(
    "core:GetVehicleOwnedX",
    function(source, cb, plate)
        local found = false
        MySQL.Async.fetchAll(
            "SELECT * FROM players_vehicles",
            {},
            function(result)
                for i = 1, #result, 1 do
                    if result[i].plate == plate then
                        found = true
                    end
                end
                cb(found)
            end
        )
    end
)
RegisterServerCallback(
    "core:GetVehicleOwned+Infos",
    function(source, cb, plate)
        --print(cb)
        local found = false
        local r = {}
        MySQL.Async.fetchAll(
            "SELECT * FROM players_vehicles",
            {},
            function(result)
                for i = 1, #result, 1 do
                    if result[i].plate == plate then
                        found = true
                        r = result[i]
                        break
                    end
                end
                MySQL.Async.fetchAll(
                    "SELECT first_name,last_name FROM players_identity where uuid = @uuid",
                    {
                        ["@uuid"] = r.uuid
                    },
                    function(_re)
                        local o = os.time()
                        p = os.date("%d/%m/%Y", o)

                        cb(found, r, _re[1], tostring(p))
                    end
                )
            end
        )
    end
)
RegisterServerCallback(
    "core:SetNewOwner+Infos",
    function(source, cb, fname, lname, plate)
        local foundPlt = false
        local r = {}
        local r2 = {}
        if lname == 0 then
            MySQL.Async.fetchAll(
                "SELECT * FROM players_vehicles WHERE plate = @plate",
                {
                    ["@plate"] = plate
                },
                function(vhl)
                    for i = 1, #vhl, 1 do
                        if vhl[i].plate == plate then
                            foundPlt = true
                            r = vhl[i]
                            break
                        end
                    end
                    if foundPlt then
                        MySQL.Async.fetchAll(
                            "UPDATE players_vehicles SET uuid = @uuid WHERE plate = @plate",
                            {
                                ["@uuid"] = fname,
                                ["@plate"] = plate
                            },
                            function(isUpdated)
                                if isUpdated.affectedRows == 1 then
                                    cb(foundPlt, r, true)
                                else
                                    cb(foundPlt, r, false)
                                end
                            end
                        )
                    else
                        cb(foundPlt, r, false)
                    end
                end
            )
        else
            local foundPly = false
            MySQL.Async.fetchAll(
                "SELECT * FROM players_identity WHERE first_name = @fname AND last_name = @lname",
                {
                    ["@fname"] = fname,
                    ["@lname"] = lname
                },
                function(result)
                    if #result == 1 then
                        foundPly = true
                        r = result[1]
                    end
                    MySQL.Async.fetchAll(
                        "SELECT * FROM players_vehicles WHERE plate = @plate",
                        {
                            ["@plate"] = plate
                        },
                        function(vhl)
                            for i = 1, #vhl, 1 do
                                if vhl[i].plate == plate then
                                    foundPlt = true
                                    r2 = vhl[i]
                                    break
                                end
                            end
                            if foundPly and foundPlt then
                                MySQL.Async.fetchAll(
                                    "UPDATE players_vehicles SET uuid = @uuid WHERE plate = @plate",
                                    {
                                        ["@uuid"] = result[1].uuid,
                                        ["@plate"] = plate
                                    },
                                    function(isUpdated)
                                        if isUpdated.affectedRows == 1 then
                                            cb(foundPly, r, foundPlt, r2, true)
                                        else
                                            cb(foundPly, r, foundPlt, r2, false)
                                        end
                                    end
                                )
                            else
                                cb(foundPly, r, foundPlt, r2, false)
                            end
                        end
                    )
                end
            )
        end
    end
)
