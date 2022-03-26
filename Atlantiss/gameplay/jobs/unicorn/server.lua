local spawned = false
local spawnedPeds = {}

RegisterServerCallback('strip:spawn', function(source, cb)
	if #spawnedPeds > 0 then
		cb(spawned, spawnedPeds)
		spawnedPeds = {}
		spawned = not spawned
	else
		cb(spawned)
		spawned = not spawned
	end
end)

RegisterNetEvent("strip:sendPeds")
AddEventHandler("strip:sendPeds", function(peds) spawnedPeds = peds end)
