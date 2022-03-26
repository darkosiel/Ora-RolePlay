Atlantiss.Service = {}

function Atlantiss.Service:GetModuleName()
  return "Service"
end

function Atlantiss.Service:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Service:GetModuleName(), message))
  end
end

Atlantiss.Modules:Register(Atlantiss.Service:GetModuleName())