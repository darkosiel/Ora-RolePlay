Ora.World.Object.Files = {
  ["atm"] = "core/modules/world/submodule/object/data/atm.json"
}

Ora.World.Object.List = {
  ["atm"] = nil
}

Ora.World.Object.PartitionedByZone = {
  ["atm"] = {}
}

function Ora.World.Object:GetFileForObject(objectType)
  if (self.Files[objectType] ~= nil) then
      return self.Files[objectType]
  end

  return nil
end

function Ora.World.Object:GetFileContentForObject(objectType)
  if (self.List[objectType] == nil) then
    Ora.World:Debug(string.format("Object of type ^5%s^3 not loaded. Retrieving it from files", objectType))
    if (self:GetFileForObject(objectType) ~= nil) then
      local contentAsJson = LoadResourceFile(GetCurrentResourceName(), "./" .. self:GetFileForObject(objectType))
      self.List[objectType] = json.decode(contentAsJson)
      Ora.World:Debug(string.format("Returning ^5%s^3 elements of type ^5%s^3", #self.List[objectType], objectType))
      return self.List[objectType]
    end

    Ora.World:Debug(string.format("No file found for elements of type ^5%s^3", objectType))
    return nil
  end

  Ora.World:Debug(string.format("Returning ^5%s^3 elements of type ^5%s^3", #self.List[objectType], objectType))
  return self.List[objectType]
end

function Ora.World.Object:Initialize()
  self:InitializeAtm()
end

function Ora.World.Object:InitializeAtm()
  Ora.World:Debug(string.format("Initializing ^5%s^3 elements", "ATM"))

  local atms = self:GetFileContentForObject("atm")
  for key, value in pairs(atms) do
    local zoneId = Ora.Core:GetGridZoneId(value.position.x, value.position.y)

    if (self.PartitionedByZone["atm"][zoneId] == nil) then
      self.PartitionedByZone["atm"][zoneId] = {}
    end

    table.insert(self.PartitionedByZone["atm"][zoneId], value)
  end
end

RegisterServerCallback(
    "Ora::SE::World:Object:GetPositionsForObjectAtZoneId",
    function(source, callback, objectType, zoneId)
      Ora.World:Debug(string.format("Received event ^5%s^3 to retrieve object of type ^5%s^3 at zone id ^5%s^3", "Ora::SE::World:Object:GetPositionsForObjectAtZoneId", objectType, zoneId))
      if (Ora.World.Object.PartitionedByZone[objectType] ~= nil and Ora.World.Object.PartitionedByZone[objectType][zoneId] ~= nil) then
        Ora.World:Debug(string.format("Returned ^5%s^3 element of type ^5%s^3 at zone id ^5%s^3", #Ora.World.Object.PartitionedByZone[objectType][zoneId], objectType, zoneId))
        callback(json.encode(Ora.World.Object.PartitionedByZone[objectType][zoneId]))
        return
      end
      Ora.World:Debug(string.format("Returned ^5%s^3 element of type ^5%s^3 at zone id ^5%s^3", 0, objectType, zoneId))
      callback(json.encode({}))
    end
)

RegisterServerCallback(
    "Ora::SE::World:Object:GetObjectsAtZoneId",
    function(source, callback, zoneId)
      Ora.World:Debug(string.format("Received event ^5%s^3 to retrieve all objects at zone id ^5%s^3", "Ora::SE::World:Object:GetObjectsAtZoneId", zoneId))
      local data = {}
      for key, value in pairs(Ora.World.Object.PartitionedByZone) do
        if value[zoneId] ~= nil then
          Ora.World:Debug(string.format("Added ^5%s^3 element of type ^5%s^3 at zone id ^5%s^3", #Ora.World.Object.PartitionedByZone[key][zoneId], key, zoneId))
          data[key] = value[zoneId]
        end
      end

      callback(json.encode(data))
    end
)

RegisterServerCallback(
    "Ora::SE::World:Object:GetPositionsForObjectAtAnyZone",
    function(source, callback, objectType)
      Ora.World:Debug("Received event ^5%s^3 to retrieve object of type ^5%s^3 at any zone", "Ora::SE::World:Object:GetPositionsForObjectAtAnyZone", objectType)
      if (Ora.World.Object.List[objectType] ~= nil) then
        Ora.World:Debug("Returned ^5%s^3 element of type ^5%s^3", Ora.World.Object.List[objectType], objectType)
        callback(json.encode(Ora.World.Object.List[objectType]))
        return
      end
      Ora.World:Debug("Returned ^5%s^3 element of type ^5%s^3", 0, objectType)
      callback(json.encode({}))
    end
)