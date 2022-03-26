Atlantiss.World.Vehicle = {}
Atlantiss.World.Vehicle.DataDamagesLevelMapper = {[800] = 50, [600] = 150, [400] = 250, [200] = 400, [0] = 800}

Atlantiss.World.Vehicle.List = {}

function Atlantiss.World.Vehicle:IsSpawnedVehicle(vehicle)
  if (self.List[vehicle] ~= nil) then
    return true
  else
    return false
  end
end

function Atlantiss.World.Vehicle:AddSpawnedVehicle(vehicle, owner)
  self.List[vehicle] = owner
end

function Atlantiss.World.Vehicle:RemoveSpawnedVehicle(vehicle)
  if (self.List[vehicle] ~= nil) then
    self.List[vehicle] = nil
  end
end

function Atlantiss.World.Vehicle:GenerateRandomPlate()
  return string.format("%02d%s%03d", math.random(1,99), Atlantiss.Utils:GetRandomString(false, true, false, 3), math.random(1,999))
end

Atlantiss.World:Register("Vehicle")