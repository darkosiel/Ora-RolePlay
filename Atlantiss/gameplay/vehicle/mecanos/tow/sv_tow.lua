RegisterServerEvent("vehicle:UnTowVehicle")
AddEventHandler(
    "vehicle:UnTowVehicle",
    function(id)
        MySQL.Async.execute(
            "UPDATE players_vehicles SET pound = 0 where id = @id",
            {
                ["@id"] = id
            }
        )
    end
)

MySQL.ready(
    function()
        MySQL.Async.fetchAll(
            "SELECT * FROM players_parking",
            {},
            function(_result)
                for keyVeh, valueVeh in pairs(_result) do
                    if (valueVeh.plate == nil) then
                        vehicleData = json.decode(valueVeh.vehicles)
                        if vehicleData.plate == nil then
                            math.randomseed(GetGameTimer())
                            vehicleData.plate = math.random(10000000, 99999999)

                            MySQL.Async.execute(
                                "UPDATE players_parking SET vehicles = @vehicles where id = @id",
                                {
                                    ["@id"] = valueVeh.id,
                                    ["@vehicles"] = json.encode(vehicleData)
                                },
                                function(inserted)
                                    print("[MIGRATION] ^2 Added plate into vehicle^0")
                                end
                            )
                        end

                        valueVeh.plate = vehicleData.model .. "|" .. vehicleData.plate
                        MySQL.Async.execute(
                            "UPDATE players_parking SET plate = @plate where id = @id",
                            {
                                ["@id"] = valueVeh.id,
                                ["@plate"] = valueVeh.plate
                            },
                            function(inserted)
                                print(
                                    "[MIGRATION] ^2 Adedd plate to vehicle id " ..
                                        vehicleData.plate ..
                                            " set : " .. vehicleData.model .. "|" .. vehicleData.plate .. "^0"
                                )
                            end
                        )
                    end
                end

                

                MySQL.Async.execute(
                    "UPDATE players_vehicles SET pound = 1 WHERE id IN (SELECT pv.id FROM `players_vehicles` AS pv LEFT JOIN players_parking AS pp ON pp.label = pv.label AND pp.plate LIKE CONCAT('%', pv.plate, '%') WHERE pv.pound = 0 AND pp.garage IS NULL AND (pv.label IS NOT NULL OR pv.label != \"NULL\"));",
                    {},
                    function(modifiedRows)
                        print("[TOW] ^2 " .. modifiedRows .. " has been sent to tow")
                    end
                )
            end
        )
    end
)
