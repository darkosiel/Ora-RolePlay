Atlantiss.Instance = {}

Atlantiss.Instance.Properties = {}
Atlantiss.Instance.PlayerToProperties = {}
Atlantiss.Instance.BucketToProperties = {}
Atlantiss.Instance.PropertiesToBucket = {}
Atlantiss.Instance.PropertyIdsToBucket = {}
Atlantiss.Instance.DefaultBucket = 0

function Atlantiss.Instance:GetDefaultSharedBucket()
  return self.DefaultBucket
end

function Atlantiss.Instance:GetModuleName()
  return "Instance"
end

function Atlantiss.Instance:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Instance:GetModuleName(), message))
  end
end

Atlantiss.Modules:Register(Atlantiss.Instance:GetModuleName())