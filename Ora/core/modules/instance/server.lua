function Ora.Instance:Initialize()

end

function Ora.Instance:GetIdForCoords(x, y, z)
  if (type(x) == "table") then
    local zFromTable = x.z
    if (FromTable == 0) then
      zFromTable = 1
    end

    return (x.x * x.y * zFromTable) / zFromTable
  end

  if (z == 0) then 
    z = 1
  end

  return (x * y * z) / z 
end

function Ora.Instance:HasPropertyRoutingBucket(propertyName)
  if (self.PropertiesToBucket[propertyName] ~= nil) then
      return true
  end

  return false
end

function Ora.Instance:GenerateNewBucketList()
  local minBucket = 1  
  local maxBucket = 63
  local newBuckets = {}
  for i = minBucket, maxBucket, 1 do
      newBuckets[i] = false
  end

  return newBuckets
end

function Ora.Instance:RegisterRoutingBucketForProperty(propertyId, propertyName, propertyData)
  Ora.Instance:Debug(string.format("Registering new instance ^5%s^3 with property id ^5%s^3.", propertyName, propertyId))

    if self.PropertyIdsToBucket[propertyId] == nil then
      self.PropertyIdsToBucket[propertyId] = self:GenerateNewBucketList()
    end

    for key, value in pairs(self.PropertyIdsToBucket[propertyId]) do
        if (value == false) then
          self.PropertyIdsToBucket[propertyId][key] = true
          self.PropertiesToBucket[propertyName] = key
          if (self.BucketToProperties[key] == nil) then
            self.BucketToProperties[key] = {}
          end
          self.BucketToProperties[key][propertyName] = propertyId

          self.Properties[propertyName] = {bucket_id = key, hash = propertyName, property_id = propertyId, members = {}}

          for dataKey, dataValue in pairs(propertyData) do
            self.Properties[propertyName][dataKey] = dataValue
          end

          Ora.Instance:Debug(string.format("Routing bucket assigned to instance ^5%s^3 is ^5%s^3.", propertyName, key))
          return key
        end
    end
end

function Ora.Instance:GetPropertyData(propertyName)
  if self.Properties[propertyName] == nil then
    Ora.Instance:Debug(string.format("Instance ^5%s^3 has no property data. Returning empty object", propertyName))
    return {}
  end

  Ora.Instance:Debug(string.format("Returning instance ^5%s^3 property data.", propertyName))
  return self.Properties[propertyName]
end

function Ora.Instance:AddPlayerToInstance(propertyName, playerId)
  if (self:IsInstanceCreated(propertyName) == false) then
    self:Debug(string.format("Property ^5%s^3 does not exists", propertyName))
    TriggerClientEvent("Ora::CE::Core:ShowNotification", playerId, string.format("La propriété ~b~%s~s~ n'est pas enregistrée", propertyName))
    return false
  end

  if self.Properties[propertyName] == nil then
    self:Debug(string.format("Instance ^5%s^3 has no property data.", propertyName))
    TriggerClientEvent("Ora::CE::Core:ShowNotification", playerId, string.format("La propriété ~b~%s~s~ n'est pas enregistrée", propertyName))
    return false
  end

  self.Properties[propertyName].members[playerId] = true
  self.PlayerToProperties[playerId] = propertyName
  Ora.RoutingBucket:SetPlayerToRoutingBucket(playerId, self.Properties[propertyName].bucket_id)
  self:Debug(string.format("Player ^5%s^3 has been added to property ^5%s^3 in bucket id ^5%s^3", playerId, propertyName, self.Properties[propertyName].bucket_id))
end

function Ora.Instance:CanInstanceBeRemoved(propertyName)
  self:Debug(string.format("Verifying if instance ^5%s^3 can be removed", propertyName))
  local propertyData = self:GetPropertyData(propertyName)

  if (propertyData ~= nil and propertyData.members ~= nil) then
      local hasNotOnlyNil = false

      for key, value in pairs(propertyData.members) do
        if value ~= nil and value ~= false then
          hasNotOnlyNil = true
        end
      end

      if hasNotOnlyNil == false then
        self:Debug(string.format("Instance ^5%s^3 can be removed because only nil or false members", propertyName))
        return true
      else
        return false
      end
  end

  return true
end

function Ora.Instance:RemovePlayerFromInstance(propertyName, playerId)
  if (self:IsInstanceCreated(propertyName) == false) then
    self:Debug(string.format("Property ^5%s^3 does not exists", propertyName))
    TriggerClientEvent("Ora::CE::Core:ShowNotification", playerId, string.format("La propriété ~b~%s~s~ n'est pas enregistrée", propertyName))
    return false
  end

  local propertyData = self:GetPropertyData(propertyName)
  if (propertyData.members ~= nil and propertyData.members[playerId] ~= nil) then
    propertyData.members[playerId] = nil
    self.PlayerToProperties[playerId] = nil
    Ora.RoutingBucket:SetPlayerToRoutingBucket(playerId, Ora.RoutingBucket:GetDefaultSharedBucket())
    self:Debug(string.format("Player ^5%s^3 has been removed from property ^5%s^3 in bucket id ^5%s^3", playerId, propertyName, propertyData.bucket_id))
  end

  if (self:CanInstanceBeRemoved(propertyName)) then
    self:RemoveInstance(propertyName)
  end
end

function Ora.Instance:RemovePlayerFromInstanceBecauseOfDrop(playerId)
  local propertyName = nil
  if (self.PlayerToProperties[playerId] ~= nil) then
    propertyName = self.PlayerToProperties[playerId]
    self:RemovePlayerFromInstance(propertyName, playerId)
    Ora.Instance:Debug(string.format("Player ^5%s^3 removed from instance ^5%s^3", playerId, propertyName))
  end
  
  self:Debug(string.format("Player ^5%s^3 has not been removed from because he is not registered in a property", playerId))

  if (propertyName ~= nil) then
    if (self:CanInstanceBeRemoved(propertyName)) then
      self:RemoveInstance(propertyName)
    end
  end

end

function Ora.Instance:RemoveInstance(propertyName)
  self:DestroyRoutingBucketForProperty(propertyName)
  self.Properties[propertyName] = nil
  Ora.Instance:Debug(string.format("Removing instance ^5%s^3", propertyName))
end

function Ora.Instance:IsInstanceCreated(propertyName)
    if (self.Properties[propertyName] ~= nil) then
      return true
    end

    return false
end

function Ora.Instance:CreateInstance(propertyName, propertyData)
  local propertyId = self:GetIdForCoords(propertyData.inside.x, propertyData.inside.y, propertyData.inside.z)
  self:RegisterRoutingBucketForProperty(propertyId, propertyName, propertyData)
  Ora.Instance:Debug(string.format("Creating instance ^5%s^3 with property id ^5%s^3.", propertyName, propertyId))
end

function Ora.Instance:DestroyRoutingBucketForProperty(propertyName)
  Ora.Instance:Debug(string.format("Removing routing bucket for instance ^5%s^3", propertyName))

  if self.Properties[propertyName] == nil then
    Ora.Instance:Debug(string.format("Instance ^5%s^3 does not exists in Properties. not removing.", propertyName))
    return true
  end

  local propertyData = self:GetPropertyData(propertyName)
  if (propertyData.bucket_id ~= nil and self.BucketToProperties[propertyData.bucket_id][propertyName] ~= nil) then
    Ora.Instance:Debug(string.format("Destroy instance ^5%s^3 removing bucket to properties.", propertyName))
    self.BucketToProperties[propertyData.bucket_id][propertyName] = nil
  end

  if (propertyData.property_id ~= nil and self.PropertyIdsToBucket[propertyData.property_id] ~= nil and propertyData.bucket_id ~= nil and self.PropertyIdsToBucket[propertyData.property_id][propertyData.bucket_id]) then
    Ora.Instance:Debug(string.format("Destroy instance ^5%s^3 removing property ids to bucket.", propertyName))
    self.PropertyIdsToBucket[propertyData.property_id][propertyData.bucket_id] = false
  end

  Ora.Instance:Debug(string.format("Destroy instance ^5%s^3 removing property to bucket.", propertyName))
  self.PropertiesToBucket[propertyName] = nil

  return true
end


function Ora.Instance:GetRoutingBucketForProperty(propertyName)
    if (self:HasPropertyRoutingBucket(propertyName)) then
      Ora.Instance:Debug(string.format("Returning routing bucket ^5%s^3 for instance ^5%s^3", self.PropertiesToBucket[propertyName], propertyName))
      return self.PropertiesToBucket[propertyName]
    end

    Ora.Instance:Debug(string.format("Returning routing bucket ^5%s^3 for instance ^5%s^3", false, propertyName))
    return false
end


RegisterServerCallback(
    "Ora::SE::Instance:EnterInstance",
    function(source, callback, propertyName, propertyData)
      local _source = source
      Ora.Instance:Debug(string.format("Player ^5%s^3 sended event ^5%s", _source, "Ora::SE::Instance:EnterInstance"))
      if (Ora.Instance:IsInstanceCreated(propertyName) == false) then
        Ora.Instance:CreateInstance(propertyName, propertyData)
      end

      Ora.Instance:AddPlayerToInstance(propertyName, _source)
      callback(true)
    end
)

RegisterServerCallback(
    "Ora::SE::Instance:LeaveInstance",
    function(source, callback, propertyName)
      local _source = source
        Ora.Instance:Debug(string.format("Player ^5%s^3 sended event ^5%s", _source, "Ora::SE::Instance:LeaveInstance"))
        if (Ora.Instance:IsInstanceCreated(propertyName) == true) then
          Ora.Instance:RemovePlayerFromInstance(propertyName, _source)
          Ora.Instance:Debug(string.format("Player ^5%s^3 is now removed from instance ^5%s", _source, propertyName))
          callback(true)
        else
          Ora.Instance:Debug(string.format("Player ^5%s^3 is not removed from instance ^5%s because it does not exist", _source, propertyName))
          callback(false)
      end
    end
)

RegisterServerCallback(
    "Ora::SE::Instance:LeaveAllInstance",
    function(source, callback)
      local _source = source
      Ora.Instance:Debug(string.format("Player ^5%s^3 sended event ^5%s", _source, "Ora::SE::Instance:LeaveAllInstance"))
      Ora.Instance:RemovePlayerFromInstanceBecauseOfDrop(_source)
      callback(true)
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
      local _source = source
      Ora.Instance:RemovePlayerFromInstanceBecauseOfDrop(_source)
    end
)
