-- ALTER TABLE `players_parking` ADD `health` LONGTEXT NULL AFTER `vehicles`;
Ora.World.Vehicle.ExistingPlates = {}

MySQL.ready(
    function()
        MySQL.Async.fetchAll(
            'SELECT plate FROM players_vehicles',
            {},
            function(result)
                for _, veh in pairs(result) do
                    table.insert(Ora.World.Vehicle.ExistingPlates, veh.plate)
                end
            end
        )
    end
)

function Ora.World.Vehicle:IsVehicleBelongsToAnyPlayer(vehicleIdentifier)
    results = MySQL.Sync.fetchAll(
        "SELECT count(plate) AS number_of_vehicles FROM players_vehicles WHERE plate_identifier = @vehicleIdentifier",
        {
            ["@vehicleIdentifier"] = vehicleIdentifier
        }
    )

    if results ~= nil and results[1] ~= nil then
        if (results[1].number_of_vehicles > 0) then
            return true
        end
    end

    return false
end

function Ora.World.Vehicle:IsVehicleInParking(vehicleIdentifier)
    results = MySQL.Sync.fetchAll(
        "SELECT count(plate) AS number_of_vehicles FROM players_parking WHERE plate = @plate",
        {
            ["@plate"] = vehicleIdentifier
        }
    )

    if results ~= nil and results[1] ~= nil then
        if (results[1].number_of_vehicles > 0) then
            return true
        end
    end

    return false
end

function Ora.World.Vehicle:SetVehicleToPound(vehicleIdentifier)
    MySQL.Sync.insert(
        "UPDATE players_vehicles SET pound = 1 WHERE plate_identifier = @vehicleIdentifier",
        {
            ["@vehicleIdentifier"] = vehicleIdentifier
        }
    )
end


RegisterServerEvent("Ora::SE::World:Garage:StoreVehicle")
AddEventHandler(
    "Ora::SE::World:Garage:StoreVehicle",
    function(vehicleData, vehicleHealthData, garage, plate)
        --(source)
        local uuid = Ora.Identity:GetUuid(source)
        local customlabel = nil

        MySQL.Async.fetchAll('SELECT * FROM players_vehicles WHERE plate = @plate', { ['@plate'] = plate }, function(result)
            if result[1] ~= nil then
                print(result[1].label)
            end
        end)

        MySQL.Async.fetchAll(
            "SELECT count(plate) AS number_of_vehicles FROM players_parking WHERE garage = @garage AND plate = @plate",
            {
                ["@garage"] = garage,
                ["@plate"] = vehicleData.model .. "|" .. plate
            },
            function(results)
                if results ~= nil and results[1] ~= nil then
                    if (results[1].number_of_vehicles == 0) then
                        MySQL.Sync.insert(
                            "INSERT INTO players_parking (vehicles,health,garage,label,uuid,plate) VALUES (@vehicleData,@healthData, @garage,@label,@name,@plate)",
                            {
                                ["@vehicleData"] = json.encode(vehicleData),
                                ["@healthData"] = json.encode(vehicleHealthData),
                                ["@garage"] = garage,
                                ["@label"] = vehicleData.label,
                                ["@name"] = uuid,
                                ["@plate"] = vehicleData.model .. "|" .. plate
                            }
                        )
                    end
                end
            end
        )

        
    end
)

RegisterServerCallback(
    "Ora::SE::World:Garage:IsVehicleStored",
    function(source, callback, garageName, vehicleIdentifier, removeFromStorage)
        removeFromStorage = removeFromStorage or false
        MySQL.Async.fetchAll(
            "SELECT count(plate) AS number_of_vehicles FROM players_parking WHERE garage = @garage AND plate = @plate",
            {
                ["@garage"] = garageName,
                ["@plate"] = vehicleIdentifier
            },
            function(results)
                if (results ~= nil and results[1] ~= nil and results[1].number_of_vehicles > 0) then
                    if (removeFromStorage == true) then
                        MySQL.Sync.execute(
                            "DELETE FROM players_parking WHERE garage = @garage AND plate = @plate",
                            {
                                ["@garage"] = garageName,
                                ["@plate"] = vehicleIdentifier
                            }
                        )
                        callback(true, nil)
                    end
                else
                    callback(false, "Ce véhicule ne semble pas être dans ce garage")
                end
            end
        )
    end
)


RegisterServerEvent("Ora::SE::World:Vehicle:RemoveAllItemsNameFromTrunk")
AddEventHandler(
    "Ora::SE::World:Vehicle:RemoveAllItemsNameFromTrunk",
    function(vehicleIdentifier, itemName)
        MySQL.Async.execute(
            "DELETE FROM storages_inventory_items2 WHERE item_name = @item_name AND storage_name = @storage_name",
            {
                ["@storage_name"] = vehicleIdentifier,
                ["@item_name"] = itemName
            }
        )
    end
)

RegisterServerEvent("Ora::SE::World:Vehicle:SaveHandling")
AddEventHandler(
    "Ora::SE::World:Vehicle:SaveHandling",
    function(plateID, data)
        local src = source
        local vdata = json.encode(data)
        MySQL.Async.fetchAll(
            "SELECT * FROM players_vehicles WHERE plate_identifier = @pid",
            {["@pid"] = plateID},
            function(res)
                if res[1] then
                    MySQL.Async.execute(
                        "UPDATE players_vehicles SET data = @data WHERE plate_identifier = @pid",
                        {
                            ["@pid"] = plateID,
                            ["@data"] = vdata
                        },
                        function(result)
                            if result == 1 then
                                TriggerClientEvent('RageUI:Popup', src, {message = "~g~~h~Succès~h~~s~\nPréparation sauvegardée."})
                            else
                                error('Update on vehicule data failed, contactez un administrateur.')
                            end
                        end
                    )
                else
                    TriggerClientEvent('RageUI:Popup', src, {message = "~r~~h~Error~h~~s~\nLe véhicule appartient à personne."})
                end
            end
        )
    end
)

RegisterServerCallback(
    "Ora::SE::World:Vehicle:GetHandling",
    function(source, callback, plateID)
        MySQL.Async.fetchAll(
            "SELECT data FROM players_vehicles WHERE plate_identifier = @pid",
            {
                ["@pid"] = plateID
            },
            function(result)
                if result[1] then
                    callback(true, json.decode(result[1].data))
                else
                    callback(false)
                end
            end
        )
    end
)

RegisterServerCallback(
    "Ora::SVCB::World:Vehicle:GetExistingPlates",
    function(source, callback)
        callback(Ora.World.Vehicle.ExistingPlates)
    end
)
