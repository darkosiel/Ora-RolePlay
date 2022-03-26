local isInVehicle = false
local lastVehicle = nil
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped) then
                if (isInVehicle == false or lastVehicle == nil) then
                    local vehicle = GetVehiclePedIsIn(ped)
                    if (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
                        isInVehicle = true
                        lastVehicle = vehicle
                    end
                end
            else
                if (isInVehicle == true and lastVehicle ~= nil) then
                    local status, vehicleIdentifier = pcall(getVehicleIdentifier, lastVehicle)
                    if (status == true) then
                        TriggerServerEvent(
                            "atlantissCar:saveCarPosition",
                            vehicleIdentifier,
                            GetEntityCoords(lastVehicle)
                        )
                    end

                    isInVehicle = false
                    lastVehicle = nil
                end
            end
        end
    end
)
