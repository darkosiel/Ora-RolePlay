Ora.Service = {}

function Ora.Service:GetModuleName()
  return "Service"
end

function Ora.Service:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Service:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.Service:GetModuleName())