RegisterServerCallback(
    "garage:GetVehicle",
    function(s, callback, Garage)
        local uuid = Ora.Identity:GetUuid(s)
        MySQL.Async.fetchAll(
            "SELECT * FROM players_parking WHERE garage =@name and uuid = @uuid ORDER BY id ASC",
            {
                ["@name"] = Garage,
                ["@uuid"] = uuid
            },
            function(result)
                callback(result)
            end
        )
    end
)

RegisterServerCallback(
    "garage:GetVehicle2",
    function(s, callback, Garage)
        MySQL.Async.fetchAll(
            "SELECT * FROM players_parking WHERE garage = @name ORDER BY id ASC",
            {
                ["@name"] = Garage
            },
            function(result)
                callback(result)
            end
        )
    end
)

RegisterServerCallback(
    "garage:canStoreVehicle",
    function(s, callback, garageName, garageLimit, garageType)
        local message = ""
        local numberOfCars = 0
        local uuid = Ora.Identity:GetUuid(s)
        local searchCriterias = {}
        local sqlQuery = nil

        if (garageType == 1 or garageType == 0) then
            sqlQuery = "SELECT count(id) as number_of_cars FROM players_parking WHERE garage = @name and uuid = @uuid"
            searchCriterias = {
                ["@name"] = garageName,
                ["@uuid"] = uuid
            }
        else
            sqlQuery = "SELECT count(id) as number_of_cars FROM players_parking WHERE garage = @name"
            searchCriterias = {
                ["@name"] = garageName
            }
        end

        MySQL.Async.fetchAll(
            sqlQuery,
            searchCriterias,
            function(result)
                if (result[1] ~= nil) then
                    if
                        (result[1].number_of_cars ~= nil and
                            tonumber(result[1].number_of_cars) + 1 > tonumber(garageLimit))
                     then
                        callback(false, "~r~Les " .. garageLimit .. " places de votre garage sont déjà utilisées~s~")
                    else
                        callback(true, nil)
                    end
                else
                    callback(false, "~r~Le garage ne semble pas exister~s~")
                end
            end
        )
    end
)

RegisterServerCallback(
    "vehicles:GetOwnedVehicles",
    function(_source, callback)
        local uuid = Ora.Identity:GetUuid(_source)

        MySQL.Async.fetchAll(
            "SELECT * FROM players_vehicles WHERE uuid =@name",
            {
                ["@name"] = uuid
            },
            function(result)
                callback(result)
            end
        )
    end
)

RegisterServerEvent("Garage:StockVehicle")
AddEventHandler(
    "Garage:StockVehicle",
    function(vehicleData, garage)
        --(source)
        local uuid = Ora.Identity:GetUuid(source)

        MySQL.Async.fetchAll(
            "SELECT count(plate) AS number_of_vehicles FROM players_parking WHERE garage = @garage AND plate = @plate",
            {
                ["@garage"] = garage,
                ["@plate"] = vehicleData.model .. "|" .. vehicleData.plate
            },
            function(results)
                if results ~= nil and results[1] ~= nil then
                    if (results[1].number_of_vehicles == 0) then
                        MySQL.Sync.insert(
                            "INSERT INTO players_parking (vehicles,garage,label,uuid,plate) VALUES (@vehicleData,@garage,@label,@name,@plate)",
                            {
                                ["@vehicleData"] = json.encode(vehicleData),
                                ["@garage"] = garage,
                                ["@label"] = vehicleData.label,
                                ["@name"] = uuid,
                                ["@plate"] = vehicleData.model .. "|" .. vehicleData.plate
                            }
                        )
                    end
                end
            end
        )
    end
)

RegisterServerEvent("Garage:UpdateLabel")
AddEventHandler(
    "Garage:UpdateLabel",
    function(id, label)
        MySQL.Async.execute(
            "UPDATE players_parking SET label = @label where id = @id",
            {
                ["@id"] = id,
                ["@label"] = label
            }
        )
    end
)

RegisterServerEvent("Garage:UpdateCarLabel")
AddEventHandler(
        "Garage:UpdateCarLabel",
        function(plate, label)
            MySQL.Async.execute(
                    "UPDATE players_vehicles SET label = @label where plate = @plate",
                    {
                        ["@plate"] = plate,
                        ["@label"] = label
                    }
            )
        end
)

RegisterServerEvent("vehicle:PreterCle")
AddEventHandler(
    "vehicle:PreterCle",
    function(targetSource, plate, label)
        TriggerClientEvent("vehicle:AddTempClé", targetSource, plate, label)
    end
)
RegisterServerEvent("Garage:SortirVehicule")
AddEventHandler(
    "Garage:SortirVehicule",
    function(id)
        MySQL.Async.execute(
            "DELETE FROM players_parking where id = @id",
            {
                ["@id"] = id,
                ["@label"] = label
            }
        )
    end
)

RegisterServerEvent("Garage:RemoveVehicule")
AddEventHandler(
    "Garage:RemoveVehicule",
    function(name, plate)
        MySQL.Async.execute(
            "DELETE FROM players_parking where garage = @name AND plate = @plate",
            {
                ["@name"] = name,
                ["@plate"] = plate
            }
        )
    end
)

--- admin
RegisterServerEvent("kickPlayerM")
AddEventHandler(
    "kickPlayerM",
    function(m, reason)
        local _source = m
        if (GetPlayerName(_source)) then
            local player = tonumber(_source)
            DropPlayer(player, reason)
        else
            --("o")
        end
    end
)

RegisterServerEvent("SetVehicleWindowSV")
AddEventHandler("SetVehicleWindowSV", function(windowsDown, i) TriggerClientEvent("VehicleWindowCL", -1, source, windowsDown, i) end)