Ora.Jobs.Casino = {}
Ora.Jobs.Casino.Submodules = {}

function Ora.Jobs.Casino:GetJobName()
  return "Casino"
end

function Ora.Jobs.Casino:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Ora.Jobs:GetModuleName(), Ora.Jobs.Casino:GetJobName(), message))
  end
end

function Ora.Jobs.Casino:Initialize()
  self:InitializeSubmodules()
end

function Ora.Jobs.Casino:Register(module)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 Casino Submodule^7.\n",  Ora:GetServerName(), module))
  self.Submodules[#self.Submodules + 1] = module
end

function Ora.Jobs.Casino:InitializeSubmodules()
  for _, module in pairs(self.Submodules) do
    if self[module] and self[module]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Casino Submodules ^5%s^3 initialized^7.\n", Ora:GetServerName(), module))
      self[module]:Initialize()
    end
  end
end

Ora.Jobs:Register(Ora.Jobs.Casino:GetJobName())
