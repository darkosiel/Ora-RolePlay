Ora.RoutingBucket = {}

Ora.RoutingBucket.List = {}
Ora.RoutingBucket.DefaultBucket = 0

function Ora.RoutingBucket:GetDefaultSharedBucket()
  return self.DefaultBucket
end

function Ora.RoutingBucket:GetModuleName()
  return "RoutingBucket"
end

function Ora.RoutingBucket:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.RoutingBucket:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.RoutingBucket:GetModuleName())