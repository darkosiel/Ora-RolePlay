local taxisArray = {}

RegisterNetEvent("Taxi:Finished")
AddEventHandler("Taxi:Finished", function(veh, ped)
	table.insert(taxisArray, {taxi = veh, driver = ped, timeout = 0})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)

		if (#taxisArray > 0) then
			for i = 1, #taxisArray, 1 do
				if (taxisArray[i] ~= nil and taxisArray[i].timeout ~= nil) then
					taxisArray[i].timeout = taxisArray[i].timeout + 1

					if (taxisArray[i].timeout == 2) then
						TriggerClientEvent("Taxi:deleteEm", -1, taxisArray[i].taxi, taxisArray[i].driver)
						table.remove(taxisArray, i)
					end
				end
			end
		end
	end
end)
