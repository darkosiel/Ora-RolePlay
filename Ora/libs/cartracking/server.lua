local vehiclesLocalisation = {}

RegisterServerEvent("OraCar:saveCarPosition")
AddEventHandler(
    "OraCar:saveCarPosition",
    function(carIdentifier, position)
        if (carIdentifier ~= nil) then
            vehiclesLocalisation[carIdentifier] = position
        end
    end
)

RegisterServerEvent("OraCar:poundVehicle")
AddEventHandler(
    "OraCar:poundVehicle",
    function(carIdentifier)
        local explodedPlate = explode(carIdentifier, "|")

        Ora.World.Vehicle:SetVehicleToPound_Plate(explodedPlate[1])
    end
)

RegisterServerCallback(
    "OraCar:getCarPositionWithoutModel",
    function(source, callback, carIdentifier)
        local vehicleModel = nil
        print(carIdentifier)
        MySQL.Async.fetchAll(
            "SELECT settings, pound FROM players_vehicles WHERE plate = @plate",
            {
                ["@plate"] = carIdentifier
            },
            function(result)
                if (result[1] ~= nil and result[1].settings ~= nil) then
                    local jsonDecoded = json.decode(result[1].settings)

                    for key, value in pairs(jsonDecoded) do
                        if key == "model" then
                            if (type(value) == "string") then
                                vehicleModel = GetHashKey(value)
                            else
                                vehicleModel = value
                            end
                        end
                    end

                    local finalIdentifier = vehicleModel .. "|" .. carIdentifier
                    if (vehiclesLocalisation[finalIdentifier] ~= nil) then
                        if (result[1].pound == true) then
                            callback("pounded", nil)
                        else
                            MySQL.Async.fetchAll(
                                "SELECT count(id) as numberOfCar FROM players_parking WHERE plate LIKE @plate",
                                {
                                    ["@plate"] = "%" .. finalIdentifier
                                },
                                function(result)
                                    if (result[1] ~= nil and result[1].numberOfCar ~= nil and result[1].numberOfCar > 0) then
                                        callback("parked", nil)
                                    elseif (result[1].numberOfCar == 0) then
                                        callback("outside", vehiclesLocalisation[finalIdentifier])
                                        Ora.World.Vehicle:SetVehicleToPound_Plate(carIdentifier)
                                    else
                                        Ora.World.Vehicle:SetVehicleToPound_Plate(carIdentifier)
                                        callback("pounded", nil)
                                    end
                                end
                            )
                        end
                    else
                        Ora.World.Vehicle:SetVehicleToPound_Plate(carIdentifier)
                        callback("pounded", nil)
                    end
                else
                    callback("pounded", nil)
                end
            end
        )
    end
)

RegisterServerCallback(
    "OraCar:getCarPosition",
    function(source, callback, carIdentifier)
        local carIdentifierPlate = nil
        if (vehiclesLocalisation[carIdentifier] ~= nil) then
            MySQL.Async.fetchAll(
                "SELECT count(id) as numberOfCar FROM players_parking WHERE plate = @plate",
                {
                    ["@plate"] = carIdentifier
                },
                function(result)
                    if (result[1] ~= nil and result[1].numberOfCar ~= nil and result[1].numberOfCar > 0) then
                        callback("parked", nil)
                    elseif (result[1].numberOfCar == 0) then
                        callback("outside", vehiclesLocalisation[carIdentifier])
                    else
                        local explodedPlate = explode(carIdentifier, "|")
                        Ora.World.Vehicle:SetVehicleToPound_Plate(explodedPlate[1])
                        callback("pounded", nil)
                    end
                end
            )
        else
            local explodedPlate = explode(carIdentifier, "|")
            Ora.World.Vehicle:SetVehicleToPound_Plate(explodedPlate[1])
            callback("pounded", nil)
        end
    end
)

function explode(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
