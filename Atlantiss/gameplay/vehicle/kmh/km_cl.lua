local kmsTotal
local kmsNow = 0 
local posVeh
local kmIsReady = false

local function distanceV(d1, d2) return #(d1-d2) end

local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function text(x, y, scale, text)
    SetTextFont(4)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextDropShadow(20,255,0,0,255)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(x, y)
end

Citizen.CreateThread(function()
    while true do
        local ped = LocalPlayer().Ped
        if IsPedInAnyVehicle(ped, false) then
            local vehPed = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(vehPed, -1) == ped then
                local plate = GetVehicleNumberPlateText(vehPed)
                if GetIsVehicleEngineRunning(vehPed) then
                    TriggerServerCallback('kmveh:getVehicle', function(kms)
                        kmsTotal = kms
                        TriggerEvent('kmveh:HUD', round(kms, 3).." km")
                        kmIsReady = true
                    end, plate)
                    while kmsTotal == nil and kmIsReady == false do 
                        Wait(100) 
                    end
                    local driveCar = true
                    while driveCar do
                        if not GetIsVehicleEngineRunning(vehPed) or GetPedInVehicleSeat(vehPed, -1) ~= ped then
                            driveCar = false
                            kmIsReady = false
                            kmsTotal = round((kmsTotal + kmsNow)/1000, 3)
                            TriggerServerEvent('kmveh:setKms', plate, kmsTotal)
                            break
                        end
                        oldPos = GetEntityCoords(vehPed)
                        Wait(1000)
                        currPos = GetEntityCoords(vehPed)
                        local dist = distanceV(oldPos, currPos)
                        kmsNow = kmsNow + dist
                    end
                end
            end
        end
        Wait(2000)
    end
end)

AddEventHandler('kmveh:ShowHUD', function()
    kmDummy = kmsTotal + kmsNow
    local km = kmDummy/1000
    TriggerEvent('kmveh:HUD', round(km, 3).." km")
end)

AddEventHandler('kmveh:HUD', function(txt)
    local endTimer = GetGameTimer() + 10000
    while GetGameTimer() < endTimer  do
        text(0.16, 0.950, 0.5, txt)
        Wait(0)
    end
end)