local Config, Players, Types, Entities, Models, Zones, Bones = {}, {}, {}, {}, {}, {}, {}
Types[1], Types[2], Types[3] = {}, {}, {}
Config.VehicleBones = {'chassis', 'windscreen', 'seat_pside_r', 'seat_dside_r', 'bodyshell', 'suspension_lm', 'suspension_lr', 'platelight', 'attach_female', 'attach_male', 'bonnet', 'boot', 'chassis_dummy', 'chassis_Control', 'door_dside_f', 'door_dside_r', 'door_pside_f', 'door_pside_r', 'Gun_GripR', 'windscreen_f', 'VFX_Emitter', 'window_lf', 'window_lr', 'window_rf', 'window_rr', 'engine', 'gun_ammo', 'ROPE_ATTATCH', 'wheel_lf', 'wheel_lr', 'wheel_rf', 'wheel_rr', 'exhaust', 'overheat', 'misc_e', 'seat_dside_f', 'seat_pside_f', 'Gun_Nuzzle'}

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------
-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 7.0

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
local M = {}

M.RequiredItems = function(items)
	local cnt = 0
	for item, count in pairs(items) do
		cnt = cnt + 1
		if exports["Ora"]:GetItemCount(item) >= count then
			cnt = cnt - 1
		end
	end
	if cnt == 0 then
		return true
	end
	return false
end

M.CheckOptions = function(data, entity, distance)
	local job = exports["Ora"]:AtlantissGetJob()
	local dist = data.distance == nil or distance <= data.distance
	local canInteract = data.canInteract == nil or data.canInteract(entity)
	local requiredItem = data.required_items == nil or data.required_items and M.RequiredItems(data.required_items)

	if dist and canInteract and requiredItem then
		if type(data.job) == "table" then
			for k, v in ipairs(data.job) do
				if v == job.name then
					return true
				end
			end
		elseif data.job == nil or data.job == job.name then
			return true
		end
	end
	return false
end

M.CloneTable = function(table)
	local copy = {}
	for k,v in pairs(table) do
		if type(v) == 'table' then
			copy[k] = M.CloneTable(v)
		else
			if type(v) == 'function' then v = nil end
			copy[k] = v
		end
	end
	return copy
end

M.ToggleDoor = function(vehicle, door)
	if GetVehicleDoorLockStatus(vehicle) ~= 2 then 
		if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
			SetVehicleDoorShut(vehicle, door, false)
		else
			SetVehicleDoorOpen(vehicle, door, false)
		end
	end
end

M.EnterByDoor = function(vehicle, door)
	local ped = PlayerPedId()
	TaskEnterVehicle(ped, vehicle, 10000, door, 1.0, 1, 0);
end


-------------------------------------------------------------------------------
-- Default options
-------------------------------------------------------------------------------
Bones['seat_dside_f'] = {
	options = {
		{
			icon = "fas fa-door-open",
			label = "Ouvrir/Fermer la porte",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_f') ~= -1
			end,
			action = function(entity)
				M.ToggleDoor(entity, 0)
			end
		},
	},
	distance = 1.2
}

Bones['seat_pside_f'] = {
	options = {
		{
			icon = "fas fa-door-open",
			label = "Ouvrir/Fermer la porte",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_pside_f') ~= -1
			end,
			action = function(entity)
				M.ToggleDoor(entity, 1)
			end
		},
	},
	distance = 1.2
}

Bones['seat_dside_r'] = {
	options = {
		{
			icon = "fas fa-door-open",
			label = "Ouvrir/Fermer la porte",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
			end,
			action = function(entity)
				M.ToggleDoor(entity, 2)
			end
		},
		{
			icon = "fas fa-door-open",
			label = "Entrer par cette porte",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
			end,
			action = function(entity)
				M.EnterDoor(entity, 1)
			end
		}
	},
	distance = 1.2
}

Bones['seat_pside_r'] = {
	options = {
		{
			icon = "fas fa-door-open",
			label = "Ouvrir/Fermer la porte",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_pside_r') ~= -1
			end,
			action = function(entity)
				M.ToggleDoor(entity, 3)
			end
		},
		{
			icon = "fas fa-door-open",
			label = "Entrer par cette porte",
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_pside_r') ~= -1
			end,
			action = function(entity)
				M.EnterByDoor(entity, 2)
			end
		}
	},
	distance = 1.2
}

Bones['bonnet'] = {
	options = {
		{
			icon = "fas fa-door-open",
			label = "Ouvrir/Fermer le capot",
			action = function(entity)
				M.ToggleDoor(entity, 4)
			end
		},
	},
	distance = 1.2
}

Bones['boot'] = {
	options = {
		{
			icon = "fas fa-door-open",
			label = "Ouvrir/Fermer le coffre",
			action = function(entity)
				M.ToggleDoor(entity, 5)
			end
		},
		{
			icon = "fas fa-door-open",
			label = "Basculer l'étage",
			canInteract = function(entity)
				if GetHashKey("tr2") == GetEntityModel(entity) then
					return true
				end
				return false 
			end,
			action = function(entity)
				M.ToggleDoor(entity, 4)
			end
		}
	},
	distance = 1.5
}

-------------------------------------------------------------------------------
return Config, Players, Types, Entities, Models, Zones, Bones, M
-------------------------------------------------------------------------------