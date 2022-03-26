Atlantiss.Identity = {}
Atlantiss.Identity.Submodules = {}

function Atlantiss.Identity:GetModuleName()
  return "Identity"
end

function Atlantiss.Identity:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Identity:GetModuleName(), message))
  end
end

function Atlantiss.Identity:Initialize()
  self:InitializeSubmodules()
end

function Atlantiss.Identity:Register(module)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 Submodule^7.\n",  Atlantiss:GetServerName(), module))
  self.Submodules[#self.Submodules + 1] = module
end

function Atlantiss.Identity:InitializeSubmodules()
  for _, module in pairs(self.Submodules) do
    if self[module] and self[module]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Submodule ^5%s^3 initialized^7.\n", Atlantiss:GetServerName(), module))
      self[module]:Initialize()
    end
  end
end

Atlantiss.Modules:Register(Atlantiss.Identity:GetModuleName())
