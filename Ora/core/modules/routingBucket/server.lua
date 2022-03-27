
function Ora.RoutingBucket:Initialize()
    local maxBucket = 63
    for i = 1, maxBucket, 1 do
      self.List[i] = true
      self:Debug(string.format("Creating available bucket ^5%s^3", i))
    end
end

function Ora.RoutingBucket:SetPlayerToRoutingBucket(playerId, routingBucket)
  SetEntityRoutingBucket(GetPlayerPed(playerId), routingBucket)
  SetPlayerRoutingBucket(playerId, routingBucket)
  self:Debug(string.format("Adding player ^5%s^3 to routing bucket ^5%s^3", playerId, routingBucket))
end

function Ora.RoutingBucket:AddPlayerToAnyAvailableRoutingBucket(playerId)
    local availableRoutingBucket = self:ReserveAvailableRoutingBucket()
    SetEntityRoutingBucket(GetPlayerPed(playerId), availableRoutingBucket)
    SetPlayerRoutingBucket(playerId, availableRoutingBucket)
    self:Debug(string.format("Adding player ^5%s^3 to routing bucket ^5%s^3", playerId, availableRoutingBucket))
end

function Ora.RoutingBucket:RemovePlayerFromAssignedRoutingBucket(playerId)
  local routingBucketEntity = GetEntityRoutingBucket(GetPlayerPed(playerId))
  local routingBucketPlayer = GetPlayerRoutingBucket(playerId)

  SetEntityRoutingBucket(GetPlayerPed(playerId), self:GetDefaultSharedBucket())
  SetPlayerRoutingBucket(playerId, self:GetDefaultSharedBucket())

  if (routingBucketEntity ~= 0 and self.List[routingBucketEntity] ~= nil and self.List[routingBucketEntity] == false) then
    self.List[routingBucketEntity] = true
    self:Debug(string.format("Routing bucket ^5%s^3 is now ^5%s^3", routingBucketEntity, "available"))
  end

  if (routingBucketPlayer ~= 0 and self.List[routingBucketPlayer] ~= nil and self.List[routingBucketPlayer] == false) then
    self.List[routingBucketPlayer] = true
    self:Debug(string.format("Routing bucket ^5%s^3 is now ^5%s^3", routingBucketPlayer, "available"))
  end

  self:Debug(string.format("Removing player ^5%s^3 from routing bucket ^5%s^3 / ^5%s^3", playerId, routingBucketEntity, routingBucketPlayer))
end

function Ora.RoutingBucket:ReserveAvailableRoutingBucket()
  for key, value in pairs(self.List) do
    if (value == true) then
      self:Debug(string.format("Routing bucket ^5%s is now %s^3", value, "busy"))
      self.List[key] = false
      return key
    end
  end
end

RegisterServerEvent("Ora::SE::RoutingBucket:SwitchToAnyAvailableRoutingBucket")
AddEventHandler(
    "Ora::SE::RoutingBucket:SwitchToAnyAvailableRoutingBucket",
    function()
        local _source = source
        Ora.RoutingBucket:Debug(string.format("Player ^5%s^3 sended event ^5%s", _source, "Ora::SE::RoutingBucket:SwitchToAnyAvailableRoutingBucket"))
        Ora.RoutingBucket:AddPlayerToAnyAvailableRoutingBucket(_source)
    end
)
RegisterServerEvent("Ora::SE::RoutingBucket:SwitchToDefaultRoutingBucket")
AddEventHandler(
    "Ora::SE::RoutingBucket:SwitchToDefaultRoutingBucket",
    function()
        local _source = source
        Ora.RoutingBucket:Debug(string.format("Player ^5%s^3 sended event ^5%s", _source, "Ora::SE::RoutingBucket:SwitchToDefaultRoutingBucket"))
        Ora.RoutingBucket:RemovePlayerFromAssignedRoutingBucket(_source)
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
      local _source = source
      Ora.RoutingBucket:RemovePlayerFromAssignedRoutingBucket(_source)
    end
)
