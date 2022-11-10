
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
    end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function GetClosestVehicle(x, y, z, radius)
    local closestVehicle
    local closestDistance = -1

    local from = vector3(x, y, z)
    local to = vector3(x, y, z)

    for vehicle in EnumerateVehicles() do
        local pos = GetEntityCoords(vehicle)
        local distance = #(pos - vector3(x, y, z))

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicle
            closestDistance = distance
        end
    end

    return closestVehicle, closestDistance
end

function GetClosestPed(x, y, z, radius)
    local closestPed
    local closestDistance = -1

    local from = vector3(x, y, z)
    local to = vector3(x, y, z)

    for ped in EnumeratePeds() do
        local pos = GetEntityCoords(ped)
        local distance = #(pos - vector3(x, y, z))

        if closestDistance == -1 or closestDistance > distance then
            closestPed = ped
            closestDistance = distance
        end
    end

    return closestPed, closestDistance
end

function GetClosestObject(x, y, z, radius)
    local closestObject
    local closestDistance = -1

    local from
end


local function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

local AtmsModels <const> = {
	prop_atm_01 = true,
	prop_atm_02 = true,
	prop_atm_03 = true,
	prop_fleeca_atm = true,
}

local function getAtms()
	local atms = {}

	for v, k in EnumerateObjects() do
		if AtmsModels[GetEntityModel(v)] then
			print("Found ATM")
			local coords = GetEntityCoords(v)
			if GetInteriorAtCoords(coords) == 0 then
				print("Found ATM outside")
				table.insert(atms, {
					prop = GetEntityModel(v),
					coords = coords,
					rot = {
						x = GetEntityRotation(v, 1).x,
						y = GetEntityRotation(v, 1).y,
						z = GetEntityRotation(v, 1).z,
					},
				})
			end
		end
	end

	return atms
end

RegisterCommand("generateAtms", function()
	local atms = getAtms()
	TriggerServerEvent("Ora:Jobs:G6:GenerateAtms", json.encode(atms))	
end)


