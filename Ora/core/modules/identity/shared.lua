Ora.Identity = {}
Ora.Identity.Submodules = {}

function Ora.Identity:GetModuleName()
  return "Identity"
end

function Ora.Identity:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Identity:GetModuleName(), message))
  end
end

function Ora.Identity:Initialize()
  self:InitializeSubmodules()
end

function Ora.Identity:Register(module)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 Submodule^7.\n",  Ora:GetServerName(), module))
  self.Submodules[#self.Submodules + 1] = module
end

function Ora.Identity:InitializeSubmodules()
  for _, module in pairs(self.Submodules) do
    if self[module] and self[module]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Submodule ^5%s^3 initialized^7.\n", Ora:GetServerName(), module))
      self[module]:Initialize()
    end
  end
end

Ora.Modules:Register(Ora.Identity:GetModuleName())
