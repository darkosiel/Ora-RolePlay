local ind = {l = false, r = false}
local display = true

Citizen.CreateThread(
    function()
        local PedCar = nil
        local PedInVehicleSeat = nil
        while true do
            local Ped, waitTime = PlayerPedId(), 1000
            local PedCar = GetVehiclePedIsIn(Ped)

            _,feuPosition,feuRoute = GetVehicleLightsState(PedCar)
            if(feuPosition == 1 and feuRoute == 0) then
                SendNUIMessage({
                    feuPosition = true
                })
            else
                SendNUIMessage({
                    feuPosition = false
                })
            end
            if(feuPosition == 1 and feuRoute == 1) then
                SendNUIMessage({
                    feuRoute = true
                })
            else
                SendNUIMessage({
                    feuRoute = false
                })
            end

            if PedCar ~= 0 and  GetIsVehicleEngineRunning(PedCar) and display then
                waitTime = 100
                if PedCar then
                    -- Speed
                    carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
                    SendNUIMessage(
                        {
                            showhud = true,
                            speed = carSpeed
                        }
                    )
                else
                    SendNUIMessage(
                        {
                            showhud = false
                        }
                    )
                    PedInVehicleSeat = nil
                    PedCar = nil
                end
            else
                SendNUIMessage(
                    {
                        showhud = false
                    }
                )
                PedInVehicleSeat = nil
                PedCar = nil
            end

            Citizen.Wait(waitTime)
        end
    end
)

-- Consume fuel factor
Citizen.CreateThread(
    function()
        while true do
            local Ped = PlayerPedId()
            if (IsPedInAnyVehicle(Ped)) then
                local PedCar = GetVehiclePedIsIn(Ped, false)
                if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
                    carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
                    fuel = GetVehicleFuelLevel(PedCar)

                    SendNUIMessage(
                        {
                            showfuel = true,
                            fuel = fuel
                        }
                    )
                end
            end

            Citizen.Wait(1000)
        end
    end
)

RegisterNetEvent("speedo:display")
AddEventHandler(
    "speedo:display",
    function(visible)
        display = visible
    end
)
