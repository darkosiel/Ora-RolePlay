Ora.Instance = {}

Ora.Instance.Properties = {}
Ora.Instance.PlayerToProperties = {}
Ora.Instance.BucketToProperties = {}
Ora.Instance.PropertiesToBucket = {}
Ora.Instance.PropertyIdsToBucket = {}
Ora.Instance.DefaultBucket = 0

function Ora.Instance:GetDefaultSharedBucket()
  return self.DefaultBucket
end

function Ora.Instance:GetModuleName()
  return "Instance"
end

function Ora.Instance:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Instance:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.Instance:GetModuleName())