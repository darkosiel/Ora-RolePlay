Atlantiss.RoutingBucket = {}

Atlantiss.RoutingBucket.List = {}
Atlantiss.RoutingBucket.DefaultBucket = 0

function Atlantiss.RoutingBucket:GetDefaultSharedBucket()
  return self.DefaultBucket
end

function Atlantiss.RoutingBucket:GetModuleName()
  return "RoutingBucket"
end

function Atlantiss.RoutingBucket:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.RoutingBucket:GetModuleName(), message))
  end
end

Atlantiss.Modules:Register(Atlantiss.RoutingBucket:GetModuleName())