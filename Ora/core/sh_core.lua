Ora = Ora or {}

Ora.ServerName = "Ora"
Ora.Debug = false

-- Module Manager
Ora.Modules = {}
Ora.Modules.List = {}
Ora.Modules.Config = {}

Ora.State = {}
Ora.State.Initializing = true

function Ora:GetServerName()
  return self.ServerName
end

function Ora:IsDebug()
  return self.Debug
end

function Ora:SetDebug(debug)
  self.Debug = debug
end

function Ora.Modules:Register(moduleName)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 module^7.\n",  Ora:GetServerName(), moduleName))
	self.List[#self.List + 1] = moduleName
end

function Ora:InitializeModules()
	for _, moduleName in pairs(self.Modules.List) do
    if self[moduleName] and self[moduleName]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Module ^5%s^3 initialized^7.\n", self.ServerName, moduleName))
      self[moduleName]:Initialize()
    end
  end
end


-- Var Manager
Ora.VM = {}
Ora.VM.Registry = {}

function Ora.VM:Get(varName)
	if (self.Registry[varName]) then
      return self.Registry[varName]
  end

  return false
end

function Ora.VM:Set(varName, varValue)
    self.Registry[varName] = varValue
end

Ora.Core = {}
Ora.Core.InternalConfig = {}

function Ora.Core:GetModuleName()
  return "Core"
end

function Ora.Core:GetGridZoneRadius()
    return 128
end

function Ora.Core:GetGridZoneId(posX, posY)
    return 100 + math.ceil((posX + posY) / (self:GetGridZoneRadius() * 2))
end

function Ora.Core:GetIdentifierForCoords(position)
	return string.format("%4.2f-%4.2f", position.x, position.y, position.z)
end


function Ora.Core:GetGridZoneIdForRadius(posX, posY, radius)
	return 100 + math.ceil((posX + posY) / (radius * 2))
end


function Ora.Core:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Core:GetModuleName(), message))
  end
end


function Ora.Core:TeleportEntityTo(entity, position, floorDeterminedPosition)
  Ora.Core:Debug(string.format("Teleporting user ^5%s^3 to position ^5%s %s %s^3 and position is trusted ^5%s^3", GetPlayerServerId(PlayerId()), position.x, position.y, position.z, floorDeterminedPosition))
	done = true
	DoScreenFadeOut(100)
	Citizen.Wait(100)
	done = Ora.Core:TeleportAndRequestCollision(position, entity, floorDeterminedPosition)
	local tempTimer = GetGameTimer()
	while not done do
		Citizen.Wait(0)
		if GetGameTimer() - tempTimer > 10000 then
			break
		end
	end
	DoScreenFadeIn(100)
end

function Ora.Core:TeleportAndRequestCollision(pos, ent, floorDeterminedPosition)
	if not pos or not pos.x or not pos.y or not pos.z or (ent and not DoesEntityExist(ent)) then return true end
	local x, y, z = pos.x, pos.y, pos.z + 1.0
	ent = ent or GetPlayerPed(-1)

	RequestCollisionAtCoord(x, y, z)
  NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
  local tempTimer = GetGameTimer()
  while not IsNewLoadSceneLoaded() do
    Ora.Core:Debug(string.format("Teleporting user ^5%s^3 waiting Scene Zone Load", GetPlayerServerId(PlayerId())))
    if GetGameTimer() - tempTimer > 3000 then
      break
    end

    Citizen.Wait(0)
  end

	SetEntityCoordsNoOffset(ent, x, y, z)
	local tempTimer = GetGameTimer()
	while not HasCollisionLoadedAroundEntity(ent) do
    Ora.Core:Debug(string.format("Teleporting user ^5%s^3 waiting collision load", GetPlayerServerId(PlayerId())))
		if GetGameTimer() - tempTimer > 3000 then
			break
		end

		Citizen.Wait(0)
	end

	local floorHasBeenFound, floorPosition
	if not floorDeterminedPosition then
		floorHasBeenFound, floorPosition = GetGroundZAndNormalFor_3dCoord(x, y, z)
		tempTimer = GetGameTimer()
		while not floorHasBeenFound do
      Ora.Core:Debug(string.format("Teleporting user ^5%s^3 waiting floor detection", GetPlayerServerId(PlayerId())))
			z = z + 10.0
			floorHasBeenFound, floorPosition = GetGroundZAndNormalFor_3dCoord(x, y, z)
			Wait(0)

			if GetGameTimer() - tempTimer > 2000 then
				break
			end
		end
	end

  Ora.Core:Debug(string.format("Finaly teleporting user ^5%s^3", GetPlayerServerId(PlayerId())))
	SetEntityCoordsNoOffset(ent, x, y, floorHasBeenFound and floorPosition or z)
  NewLoadSceneStop()
	if type(pos) ~= "vector3" and pos.a then SetEntityHeading(ent, pos.a) end
	return true
end