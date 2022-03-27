Ora.Consumable = {}
Ora.Consumable.Submodules = {}

function Ora.Consumable:GetModuleName()
  return "Consumable"
end

function Ora.Consumable:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Consumable:GetModuleName(), message))
  end
end

function Ora.Consumable:Initialize()
  self:InitializeSubmodules()
end

function Ora.Consumable:Register(module)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 Submodule^7.\n",  Ora:GetServerName(), module))
  self.Submodules[#self.Submodules + 1] = module
end

function Ora.Consumable:InitializeSubmodules()
  for _, module in pairs(self.Submodules) do
    if self[module] and self[module]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Submodule ^5%s^3 initialized^7.\n", Ora:GetServerName(), module))
      self[module]:Initialize()
    end
  end
end

Ora.Modules:Register(Ora.Consumable:GetModuleName())