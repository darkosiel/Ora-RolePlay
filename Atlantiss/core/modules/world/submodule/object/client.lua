Atlantiss.World.Object.LazyLoading = {
  Data = {}
}

function Atlantiss.World.Object:Create(model, x, y, z, isNetwork, netMissionEntity, dynamic)
  local _model, _x, _y, _z, _isNetwork, _netMissionEntity, _dynamic = model, x, y, z, isNetwork, netMissionEntity, dynamic
  local modelHash = (type(_model) == "number" and _model or GetHashKey(_model))

  if (type(_x) == "table" or type(_x) == "vector3") then
    x = _x.x
    y = _x.y
    z = _x.z
    isNetwork = _y
    netMissionEntity = _z
    dynamic = _isNetwork or nil
  end

  Atlantiss.Utils:RequestAndWAitForModel(model)

  local canSend = false
  local object = nil
  Atlantiss.World:Debug(string.format("Create : Object ^5%s^3 will be registered as a legit props", model))
  TriggerServerCallback("Atlantiss::SE::Anticheat:RegisterObject", 
      function()
        object = CreateObject(modelHash, x, y, z, isNetwork, netMissionEntity, dynamic)
          Atlantiss.World:Debug(string.format("Object ^5%s^3 is now created at position ^5%s %s %s^3", model, x, y, z))
          canSend = true
      end,
      modelHash
  )

  local localTime = GetGameTimer()
 
  while (canSend == false and localTime + 5000 > GetGameTimer()) do
      Atlantiss.World:Debug(string.format("Object ^5%s^3 is waiting callback from anticheat", model))
      Wait(100)
  end

  if (object == nil) then
      ShowNotification(string.format("l'objet ~h~%s~h~ n'a pas pu être créé", model))
      return
  end

  return object
end

function Atlantiss.World.Object:CreateObjectNoOffset(model, x, y, z, isNetwork, thisScriptCheck, dynamic)
  local _model, _x, _y, _z, _isNetwork, _thisScriptCheck, _dynamic = model, x, y, z, isNetwork, thisScriptCheck, dynamic
  
  local modelHash = (type(_model) == "number" and _model or GetHashKey(_model))

  if (type(_x) == "table" or type(_x) == "vector3") then
    x = _x.x
    y = _x.y
    z = _x.z
    isNetwork = _y
    thisScriptCheck = _z
    dynamic = _isNetwork or nil
  end

  Atlantiss.Utils:RequestAndWAitForModel(model)

  local canSend = false
  local object = nil
  Atlantiss.World:Debug(string.format("CreateObjectNoOffset : Object ^5%s^3 will be registered as a legit props", model))
  TriggerServerCallback("Atlantiss::SE::Anticheat:RegisterObject", 
      function()
        object = CreateObjectNoOffset(modelHash, x, y, z, isNetwork, thisScriptCheck, dynamic)
          Atlantiss.World:Debug(string.format("Object ^5%s^3 is now created at position ^5%s %s %s^3", model, x, y, z))
          canSend = true
      end,
      modelHash
  )

  local localTime = GetGameTimer()
 
  while (canSend == false and localTime + 5000 > GetGameTimer()) do
      Atlantiss.World:Debug(string.format("Object ^5%s^3 is waiting callback from anticheat", model))
      Wait(100)
  end

  if (object == nil) then
      ShowNotification(string.format("l'objet ~h~%s~h~ n'a pas pu être créé", model))
      return
  end

  return object
end

function Atlantiss.World.Object:Initialize()
  Atlantiss.World.Object:StartLazyLoadingObjectByZone()
end

function Atlantiss.World.Object:StartLazyLoadingObjectByZone()
  Citizen.CreateThread(function()
    while true do
      Wait(2000)
      local entityCoords = LocalPlayer().Pos
      local zoneId = Atlantiss.Core:GetGridZoneId(entityCoords.x, entityCoords.y)
      Atlantiss.World.Object.LazyLoading.CurrentZone = zoneId
      if (Atlantiss.World.Object.LazyLoading.PreviousZone == nil or Atlantiss.World.Object.LazyLoading.CurrentZone ~= Atlantiss.World.Object.LazyLoading.PreviousZone) then
        Atlantiss.World:Debug(string.format("Zone has changed, previous zone : ^5%s^3, new zone : ^5%s^3", Atlantiss.World.Object.LazyLoading.PreviousZone, zoneId))
        Atlantiss.World.Object.LazyLoading.Data = {}
        Atlantiss.World.Object:LoadObjectsForZone(zoneId)
        Atlantiss.World.Object.LazyLoading.PreviousZone = zoneId
      end
    end
  end)
end

function Atlantiss.World.Object:LoadObjectsForZone(zoneId)

  local canSend = false

  TriggerServerCallback("Atlantiss::SE::World:Object:GetObjectsAtZoneId", 
      function(objectsAsJson)
        local objects = json.decode(objectsAsJson)
        Atlantiss.World.Object.LazyLoading.Data = objects
        canSend = true
      end,
      zoneId
  )

  while canSend == false do
    Atlantiss.World:Debug(string.format("Waiting data for zone id ^5%s^3", zoneId))
    Wait(100)
  end

  return canSend
end

function Atlantiss.World.Object:GetNearestAtm(distanceLimit)
  local distanceLimitForObject = distanceLimit and distanceLimit or 5.0 
  if (Atlantiss.World.Object.LazyLoading.Data["atm"] == nil) then
    return false, vector(0, 0, 0), 0.0
  end

  local playerCoords = LocalPlayer().Pos
  local minDistance = nil
  local nearestAtm = nil
  local nearestAtmHeading = nil

  for key, value in pairs(Atlantiss.World.Object.LazyLoading.Data["atm"]) do
    local distanceBetweenCoords = GetDistanceBetweenCoords(playerCoords, vector3(value.position.x, value.position.y, value.position.z))
    if (distanceBetweenCoords <= distanceLimitForObject and (minDistance == nil or distanceLimitForObject < minDistance)) then
      minDistance = distanceBetweenCoords
      nearestAtmCoords = vector3(value.position.x, value.position.y, value.position.z)
      nearestAtmHeading = value.rotation.z
    end
  end

  if (minDistance == nil) then
    return false, vector(0, 0, 0), 0.0
  end

  return true, nearestAtmCoords, nearestAtmHeading
end