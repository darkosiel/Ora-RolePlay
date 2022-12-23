local Key = 38 -- E
local price = 80

local vehicleWashStation = {
	{26.5906,  -1392.0261,  27.3634},
	{167.1034,  -1719.4704,  27.2916},
	{-74.5693,  6427.8715,  29.4400},
	{-699.6325,  -932.7043,  17.0139},
	{1362.5385, 3592.1274, 33.9211}
}

Citizen.CreateThread(function()
	Citizen.Wait(0)
	for i = 1, #vehicleWashStation do
		local garageCoords = vehicleWashStation[i]
		local stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100) -- 100 = carwash
		SetBlipAsShortRange(stationBlip, true)
		SetBlipScale(0.6)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Carwash")
		EndTextCommandSetBlipName(stationBlip)
	end
end)


Citizen.CreateThread(function()
	local Player = LocalPlayer()
	while true do
		Citizen.Wait(1.0)
		if Player.InVehicle then 
			for _, coords in pairs(vehicleWashStation) do
				DrawMarker(25, coords[1], coords[2], coords[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 255, 255, 255, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), coords[1], coords[2], coords[3], true ) < 5 then
					AddTextEntry("HELP", "Appuyer sur ~INPUT_CONTEXT~ pour commencer le lavage ! " .. price .. "$")
					DisplayHelpTextThisFrame("HELP", false)
					if IsControlJustPressed(1, Key) then
						dataonWait = {
							title = "Achat Lavage",
							price = 85,
							fct = function()        
							end
						  }
						TriggerEvent("payWith?")
						local veh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
						if GetVehicleDirtLevel(veh) <= 3.0 then
							SendNotification("~b~Votre voiture est déjà propre !")
						else
							SetVehicleEngineOn(veh, false, true, false)
							FreezeEntityPosition(veh, true)
							SendNotification("~b~Lavage en cours")
							Wait(8000)
							SendNotification("~g~Votre voiture est lavée !")
							SetVehicleDirtLevel(veh, 1.0)
							SetVehicleEngineOn(veh, true, true, true)
							FreezeEntityPosition(veh, false)
						end
					end
				end
			end
		end
	end
end)