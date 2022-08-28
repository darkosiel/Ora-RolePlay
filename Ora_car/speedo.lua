local ind = {l = false, r = false}
local display = true

Citizen.CreateThread(
    function()
        local GetIsVehicleEngineRunning, GetEntitySpeed, SendNUIMessage = GetIsVehicleEngineRunning, GetEntitySpeed, SendNUIMessage
        local GetVehiclePedIsIn = GetVehiclePedIsIn
        local PedCar = nil
        local Ped = PlayerPedId()
        
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(1500)
                Ped = PlayerPedId()
                PedCar = GetVehiclePedIsIn(Ped)
            end
        end)

        Citizen.CreateThread(function()
            while true do
                local waitTime = 1000

                -- if(feuPosition == 1 and feuRoute == 0) then
                --     SendNUIMessage({
                --         feuPosition = true
                --         feuRoute = false
                --     })
                -- else
                --     SendNUIMessage({
                --         feuPosition = false
                --         feuRoute = false
                --     })
                -- end
                -- if(feuPosition == 1 and feuRoute == 1) then
                --     SendNUIMessage({
                --         feuPosition = true
                --         feuRoute = true
                --     })
                -- else
                --     SendNUIMessage({
                --         feuPosition = false
                --         feuRoute = false
                --     })
                -- end



                if PedCar ~= 0 and  GetIsVehicleEngineRunning(PedCar) and display then
                    if PedCar then
                        waitTime = 400
                        -- Speed
                        carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
                        _,feuPosition,feuRoute = GetVehicleLightsState(PedCar)

                        SendNUIMessage(
                            {
                                showhud = true,
                                speed = carSpeed,
                                feuPosition = feuPosition == 1 and true or false,
                                feuRoute = feuRoute == 1 and true or false
                            }
                        )
                    else
                        SendNUIMessage(
                            {
                                showhud = false
                            }
                        )
                        PedCar = nil
                    end
                else
                    SendNUIMessage(
                        {
                            showhud = false
                        }
                    )
                    PedCar = nil
                end

                Citizen.Wait(waitTime)
            end
        end)

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
