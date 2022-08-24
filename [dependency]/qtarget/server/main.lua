RegisterServerEvent("qtarget:server:ToggleDoor", function(target, vehicle, doorIndex)
	TriggerClientEvent("qtarget:client:ToggleDoor", target, vehicle, doorIndex)

end)

RegisterServerEvent("qtarget:server:SyncToogleDoor", function(vehicle, doorIndex)
	local trailerPos = GetEntityCoords(NetworkGetEntityFromNetworkId(vehicle))

	for k, v in pairs(GetPlayers()) do
		if #(GetEntityCoords(GetPlayerPed(v)) - trailerPos) < 10.0 then
			TriggerClientEvent("qtarget:client:ToggleDoor", v, vehicle, doorIndex, true)
		end
	end
end)