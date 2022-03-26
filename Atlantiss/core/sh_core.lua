Atlantiss = Atlantiss or {}

Atlantiss.ServerName = "Atlantiss"
Atlantiss.Debug = false

-- Module Manager
Atlantiss.Modules = {}
Atlantiss.Modules.List = {}
Atlantiss.Modules.Config = {}

Atlantiss.State = {}
Atlantiss.State.Initializing = true

function Atlantiss:GetServerName()
  return self.ServerName
end

function Atlantiss:IsDebug()
  return self.Debug
end

function Atlantiss:SetDebug(debug)
  self.Debug = debug
end

function Atlantiss.Modules:Register(moduleName)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 module^7.\n",  Atlantiss:GetServerName(), moduleName))
	self.List[#self.List + 1] = moduleName
end

function Atlantiss:InitializeModules()
	for _, moduleName in pairs(self.Modules.List) do
    if self[moduleName] and self[moduleName]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Module ^5%s^3 initialized^7.\n", self.ServerName, moduleName))
      self[moduleName]:Initialize()
    end
  end
end


-- Var Manager
Atlantiss.VM = {}
Atlantiss.VM.Registry = {}

function Atlantiss.VM:Get(varName)
	if (self.Registry[varName]) then
      return self.Registry[varName]
  end

  return false
end

function Atlantiss.VM:Set(varName, varValue)
    self.Registry[varName] = varValue
end

Atlantiss.Core = {}
Atlantiss.Core.InternalConfig = {}

function Atlantiss.Core:GetModuleName()
  return "Core"
end

function Atlantiss.Core:GetGridZoneRadius()
    return 128
end

function Atlantiss.Core:GetGridZoneId(posX, posY)
    return 100 + math.ceil((posX + posY) / (self:GetGridZoneRadius() * 2))
end

function Atlantiss.Core:GetIdentifierForCoords(position)
	return string.format("%4.2f-%4.2f", position.x, position.y, position.z)
end


function Atlantiss.Core:GetGridZoneIdForRadius(posX, posY, radius)
	return 100 + math.ceil((posX + posY) / (radius * 2))
end


function Atlantiss.Core:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Core:GetModuleName(), message))
  end
end


function Atlantiss.Core:TeleportEntityTo(entity, position, floorDeterminedPosition)
  Atlantiss.Core:Debug(string.format("Teleporting user ^5%s^3 to position ^5%s %s %s^3 and position is trusted ^5%s^3", GetPlayerServerId(PlayerId()), position.x, position.y, position.z, floorDeterminedPosition))
	done = true
	DoScreenFadeOut(100)
	Citizen.Wait(100)
	done = Atlantiss.Core:TeleportAndRequestCollision(position, entity, floorDeterminedPosition)
	local tempTimer = GetGameTimer()
	while not done do
		Citizen.Wait(0)
		if GetGameTimer() - tempTimer > 10000 then
			break
		end
	end
	DoScreenFadeIn(100)
end

function Atlantiss.Core:TeleportAndRequestCollision(pos, ent, floorDeterminedPosition)
	if not pos or not pos.x or not pos.y or not pos.z or (ent and not DoesEntityExist(ent)) then return true end
	local x, y, z = pos.x, pos.y, pos.z + 1.0
	ent = ent or GetPlayerPed(-1)

	RequestCollisionAtCoord(x, y, z)
  NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
  local tempTimer = GetGameTimer()
  while not IsNewLoadSceneLoaded() do
    Atlantiss.Core:Debug(string.format("Teleporting user ^5%s^3 waiting Scene Zone Load", GetPlayerServerId(PlayerId())))
    if GetGameTimer() - tempTimer > 3000 then
      break
    end

    Citizen.Wait(0)
  end

	SetEntityCoordsNoOffset(ent, x, y, z)
	local tempTimer = GetGameTimer()
	while not HasCollisionLoadedAroundEntity(ent) do
    Atlantiss.Core:Debug(string.format("Teleporting user ^5%s^3 waiting collision load", GetPlayerServerId(PlayerId())))
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
      Atlantiss.Core:Debug(string.format("Teleporting user ^5%s^3 waiting floor detection", GetPlayerServerId(PlayerId())))
			z = z + 10.0
			floorHasBeenFound, floorPosition = GetGroundZAndNormalFor_3dCoord(x, y, z)
			Wait(0)

			if GetGameTimer() - tempTimer > 2000 then
				break
			end
		end
	end

  Atlantiss.Core:Debug(string.format("Finaly teleporting user ^5%s^3", GetPlayerServerId(PlayerId())))
	SetEntityCoordsNoOffset(ent, x, y, floorHasBeenFound and floorPosition or z)
  NewLoadSceneStop()
	if type(pos) ~= "vector3" and pos.a then SetEntityHeading(ent, pos.a) end
	return true
end