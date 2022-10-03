function EnumerateEntities(initFunc, moveFunc, disposeFunc)
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

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end;

Citizen.CreateThread(function()
	Citizen.Wait(0)
	local EnumerateVehicles = EnumerateVehicles
	local SetEntityAsMissionEntity = SetEntityAsMissionEntity
	local DeleteEntity = DeleteEntity
	local GetVehicleClass = GetVehicleClass
	local IsVehicleSeatFree = IsVehicleSeatFree
	local IsEntityInAir = IsEntityInAir
	while true do	
		for veh in EnumerateVehicles() do
			local class = GetVehicleClass(veh)
			if class == 15 or class == 16 or veh == 'polmav' then
				if IsVehicleSeatFree(veh, -1) and IsEntityInAir(veh) then
					SetEntityAsMissionEntity(veh, 1, 1)
					DeleteEntity(veh)
				end
			end
		end
		Citizen.Wait(2000)
	end
end)