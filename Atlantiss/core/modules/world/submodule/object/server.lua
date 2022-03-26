Atlantiss.World.Object.Files = {
  ["atm"] = "core/modules/world/submodule/object/data/atm.json"
}

Atlantiss.World.Object.List = {
  ["atm"] = nil
}

Atlantiss.World.Object.PartitionedByZone = {
  ["atm"] = {}
}

function Atlantiss.World.Object:GetFileForObject(objectType)
  if (self.Files[objectType] ~= nil) then
      return self.Files[objectType]
  end

  return nil
end

function Atlantiss.World.Object:GetFileContentForObject(objectType)
  if (self.List[objectType] == nil) then
    Atlantiss.World:Debug(string.format("Object of type ^5%s^3 not loaded. Retrieving it from files", objectType))
    if (self:GetFileForObject(objectType) ~= nil) then
      local contentAsJson = LoadResourceFile(GetCurrentResourceName(), "./" .. self:GetFileForObject(objectType))
      self.List[objectType] = json.decode(contentAsJson)
      Atlantiss.World:Debug(string.format("Returning ^5%s^3 elements of type ^5%s^3", #self.List[objectType], objectType))
      return self.List[objectType]
    end

    Atlantiss.World:Debug(string.format("No file found for elements of type ^5%s^3", objectType))
    return nil
  end

  Atlantiss.World:Debug(string.format("Returning ^5%s^3 elements of type ^5%s^3", #self.List[objectType], objectType))
  return self.List[objectType]
end

function Atlantiss.World.Object:Initialize()
  self:InitializeAtm()
end

function Atlantiss.World.Object:InitializeAtm()
  Atlantiss.World:Debug(string.format("Initializing ^5%s^3 elements", "ATM"))

  local atms = self:GetFileContentForObject("atm")
  for key, value in pairs(atms) do
    local zoneId = Atlantiss.Core:GetGridZoneId(value.position.x, value.position.y)

    if (self.PartitionedByZone["atm"][zoneId] == nil) then
      self.PartitionedByZone["atm"][zoneId] = {}
    end

    table.insert(self.PartitionedByZone["atm"][zoneId], value)
  end
end

RegisterServerCallback(
    "Atlantiss::SE::World:Object:GetPositionsForObjectAtZoneId",
    function(source, callback, objectType, zoneId)
      Atlantiss.World:Debug(string.format("Received event ^5%s^3 to retrieve object of type ^5%s^3 at zone id ^5%s^3", "Atlantiss::SE::World:Object:GetPositionsForObjectAtZoneId", objectType, zoneId))
      if (Atlantiss.World.Object.PartitionedByZone[objectType] ~= nil and Atlantiss.World.Object.PartitionedByZone[objectType][zoneId] ~= nil) then
        Atlantiss.World:Debug(string.format("Returned ^5%s^3 element of type ^5%s^3 at zone id ^5%s^3", #Atlantiss.World.Object.PartitionedByZone[objectType][zoneId], objectType, zoneId))
        callback(json.encode(Atlantiss.World.Object.PartitionedByZone[objectType][zoneId]))
        return
      end
      Atlantiss.World:Debug(string.format("Returned ^5%s^3 element of type ^5%s^3 at zone id ^5%s^3", 0, objectType, zoneId))
      callback(json.encode({}))
    end
)

RegisterServerCallback(
    "Atlantiss::SE::World:Object:GetObjectsAtZoneId",
    function(source, callback, zoneId)
      Atlantiss.World:Debug(string.format("Received event ^5%s^3 to retrieve all objects at zone id ^5%s^3", "Atlantiss::SE::World:Object:GetObjectsAtZoneId", zoneId))
      local data = {}
      for key, value in pairs(Atlantiss.World.Object.PartitionedByZone) do
        if value[zoneId] ~= nil then
          Atlantiss.World:Debug(string.format("Added ^5%s^3 element of type ^5%s^3 at zone id ^5%s^3", #Atlantiss.World.Object.PartitionedByZone[key][zoneId], key, zoneId))
          data[key] = value[zoneId]
        end
      end

      callback(json.encode(data))
    end
)

RegisterServerCallback(
    "Atlantiss::SE::World:Object:GetPositionsForObjectAtAnyZone",
    function(source, callback, objectType)
      Atlantiss.World:Debug("Received event ^5%s^3 to retrieve object of type ^5%s^3 at any zone", "Atlantiss::SE::World:Object:GetPositionsForObjectAtAnyZone", objectType)
      if (Atlantiss.World.Object.List[objectType] ~= nil) then
        Atlantiss.World:Debug("Returned ^5%s^3 element of type ^5%s^3", Atlantiss.World.Object.List[objectType], objectType)
        callback(json.encode(Atlantiss.World.Object.List[objectType]))
        return
      end
      Atlantiss.World:Debug("Returned ^5%s^3 element of type ^5%s^3", 0, objectType)
      callback(json.encode({}))
    end
)