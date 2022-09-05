local CurrentShield = nil

function showNotification(message)
    message = message.."."
    SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

local Shield = {}

setmetatable(Shield, {})
	
function Shield:DestroyShield()
	DetachEntity(self.shield)
	DeleteEntity(self.shield)
	ClearPedTasksImmediately(self.ped)
end

function Shield:CreateShield(modelName) 
	self.ped = PlayerPedId()
	local model = GetHashKey(modelName)
	local param = nil
	for k, v in pairs(shields) do
		if v.model == model then
			param = v
			break
		end
	end

	if not IsModelInCdimage(model) then
		error("Model not found")
		return
	end

	RequestModel(model)
	while not HasModelLoaded(model) do Wait(0) end
	local coords = GetEntityCoords(self.ped)
	self.shield = CreateObject(model, coords, main.networkedWhenDeveloping, true, true)
	while not DoesEntityExist(self.shield) do Wait(0) end
	SetModelAsNoLongerNeeded(model)
	local offSet = param.offSet
	local rotation = param.rotation
	RequestAnimDict(param.animDict)
	while not HasAnimDictLoaded(param.animDict) do Wait(0) end
	TaskPlayAnim(self.ped, param.animDict, param.animName, 8.0, -8.0, -1, 50, 0.0, 0, 0, 0)
	--local boneIndex = GetEntityBoneIndexByName(ped, main.developerBoneIndex)
	self.boneId = param.boneIndex
	AttachEntityToEntity(self.shield, self.ped, self.boneId, offSet[1], offSet[2], offSet[3], rotation[1], rotation[2], rotation[3], true, true, main.developerCollision, false, 1, true)
	Citizen.CreateThread(function()
		while self.shield ~= nil do
			Wait(1000)
			if not DoesEntityExist(self.shield) then
				break
			end
			if IsPedInAnyVehicle(self.ped) or IsEntityDead(self.ped) then
				self:DestroyShield()
				ClearPedTasksImmediately(self.ped)
				break
			end
		end
	end)
	return self
end

exports("CreateShield", function(modelName)
	CurrentShield = Shield:CreateShield(modelName)
end)

exports("DestroyShield", function()
	if CurrentShield ~= nil then
		CurrentShield:DestroyShield()
		CurrentShield = nil
	end
end)