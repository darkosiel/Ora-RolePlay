local heading = 254.5
local vehicle = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -49.772243, -1083.906860, 26.88841, true) < 40 then --Changer les coordonnés
            if DoesEntityExist(vehicle) == false then
                RequestModel(GetHashKey('Nero2')) --Changer nom du véhicule
                while not HasModelLoaded(GetHashKey('Nero2')) do --Changer nom du véhicule
                    Wait(1)
                end
                vehicle = CreateVehicle(GetHashKey('Nero2'), -49.772243, -1083.906860, 26.88841, heading, false, false) --Changer nom du véhicule
                FreezeEntityPosition(vehicle, true)
                SetEntityInvincible(vehicle, true)
                SetEntityCoords(vehicle, -49.772243, -1083.906860, 26.88841, false, false, false, true) --Changer les coordonnés
                local props = vehicleFct.GetVehicleProperties(currentvehicle)
                props['wheelColor'] = 147
                props['plate'] = "Expo" --Changer nom de la plaque
                vehicleFct.SetVehicleProperties(vehicle, props)
            else
                SetEntityHeading(vehicle, heading)
                heading = heading+0.1
            end
        end
    end
end)