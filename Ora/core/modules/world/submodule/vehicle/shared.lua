Ora.World.Vehicle = {}
Ora.World.Vehicle.DataDamagesLevelMapper = {[800] = 50, [600] = 150, [400] = 250, [200] = 400, [0] = 800}

Ora.World.Vehicle.List = {}

Ora.World.Vehicle.Current.Label = "NULL"

function Ora.World.Vehicle:IsSpawnedVehicle(vehicle)
  if (self.List[vehicle] ~= nil) then
    return true
  else
    return false
  end
end

function Ora.World.Vehicle:AddSpawnedVehicle(vehicle, owner)
  self.List[vehicle] = owner
end

function Ora.World.Vehicle:RemoveSpawnedVehicle(vehicle)
  if (self.List[vehicle] ~= nil) then
    self.List[vehicle] = nil
  end
end

function Ora.World.Vehicle:GenerateRandomPlate()
  return string.format("%02d%s%03d", math.random(1,99), Ora.Utils:GetRandomString(false, true, false, 3), math.random(1,999))
end

Ora.World:Register("Vehicle")