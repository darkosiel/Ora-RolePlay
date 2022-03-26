Atlantiss.Config = {}
Atlantiss.Config.Data = {}

function Atlantiss.Config:GetDataCollection(name)
  if (Atlantiss.Config.Data[name] ~= nil) then
    self:Debug(string.format("Returning data collection ^5%s^3", name))
    return Atlantiss.Config.Data[name]
  end

  self:Debug(string.format("Collection ^5%s^3 has not been found", name))
  return {}
end

function Atlantiss.Config:SetDataCollection(name, value)
  if (Atlantiss.Config.Data[name] ~= nil) then
    self:Debug(string.format("Data collection ^5%s^3 already exist. It's now replaced", name))
  end
  self:Debug(string.format("Adding data collection ^5%s^3", name))
  Atlantiss.Config.Data[name] = value
end

function Atlantiss.Config:GetModuleName()
  return "Config"
end

function Atlantiss.Config:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Config:GetModuleName(), message))
  end
end

Atlantiss.Modules:Register(Atlantiss.Config:GetModuleName())