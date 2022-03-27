function Ora.World.Animals:Spawn()
  local x, y, z = Ora.Utils:RandomFloat(self.huntingZone.min.x, self.huntingZone.max.x), Ora.Utils:RandomFloat(self.huntingZone.min.y, self.huntingZone.max.y), self.huntingZone.maxZ
  local onGround, groundZ = GetGroundZFor_3dCoord(x, y, z, 1)
  local heading = math.random(360)
  local isPointInside = self.huntingZone:isPointInside(vector3(x, y, groundZ))
  
  while not onGround or not isPointInside do
    Wait(100)
    x, y = Ora.Utils:RandomFloat(self.huntingZone.min.x, self.huntingZone.max.x), Ora.Utils:RandomFloat(self.huntingZone.min.y, self.huntingZone.max.y)
    onGround, groundZ = GetGroundZFor_3dCoord(x, y, z, 1)
    isPointInside = self.huntingZone:isPointInside(vector3(x, y, groundZ))
  end

  local model = self.spawn.random[math.random(#self.spawn.random)]  
  local animal = Ora.World.Ped:Create(5, model, vector3(x, y, groundZ), heading)
  SetEntityAsMissionEntity(animal, true, true)
  TaskWanderStandard(animal, 0.0, 0)
  SetPedRelationshipGroupHash(animal, GetHashKey("WILD_ANIMAL"))
  Citizen.SetTimeout(4000, function()
    if not DoesEntityExist(animal) or IsEntityInWater(animal) or IsPedFalling(animal) or (IsEntityDead(animal) and GetPedSourceOfDeath(animal) == 0) then
      DeleteEntity(animal)
      self:Spawn()
    end
  end)
end

Citizen.CreateThread(function()
  for k, v in ipairs(Ora.World.Animals.spawn.model) do
    for i = 1, v.chance, 1 do
      table.insert(Ora.World.Animals.spawn.random, v.hash)
    end
  end
end)

Ora.World.Animals.huntingZone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
  if isPointInside then
    Ora.World.Animals.spawn.stop = false
    Ora.World.Animals:SpawnThread()
  else
    Ora.World.Animals.spawn.stop = true
  end
end, 5000)

function Ora.World.Animals:SpawnThread()
  Citizen.CreateThread(function()
    while true do
      Wait(self.spawn.timeInterval * 60000)
      if not self.spawn.stop then
        self:Spawn()
      else
        break
      end
    end
  end)
end