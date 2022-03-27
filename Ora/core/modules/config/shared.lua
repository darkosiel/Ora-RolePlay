Ora.Config = {}
Ora.Config.Data = {}

function Ora.Config:GetDataCollection(name)
  if (Ora.Config.Data[name] ~= nil) then
    self:Debug(string.format("Returning data collection ^5%s^3", name))
    return Ora.Config.Data[name]
  end

  self:Debug(string.format("Collection ^5%s^3 has not been found", name))
  return {}
end

function Ora.Config:SetDataCollection(name, value)
  if (Ora.Config.Data[name] ~= nil) then
    self:Debug(string.format("Data collection ^5%s^3 already exist. It's now replaced", name))
  end
  self:Debug(string.format("Adding data collection ^5%s^3", name))
  Ora.Config.Data[name] = value
end

function Ora.Config:GetModuleName()
  return "Config"
end

function Ora.Config:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Config:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.Config:GetModuleName())