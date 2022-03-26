Atlantiss.Jobs.Casino = {}
Atlantiss.Jobs.Casino.Submodules = {}

function Atlantiss.Jobs.Casino:GetJobName()
  return "Casino"
end

function Atlantiss.Jobs.Casino:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Atlantiss.Jobs:GetModuleName(), Atlantiss.Jobs.Casino:GetJobName(), message))
  end
end

function Atlantiss.Jobs.Casino:Initialize()
  self:InitializeSubmodules()
end

function Atlantiss.Jobs.Casino:Register(module)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 Casino Submodule^7.\n",  Atlantiss:GetServerName(), module))
  self.Submodules[#self.Submodules + 1] = module
end

function Atlantiss.Jobs.Casino:InitializeSubmodules()
  for _, module in pairs(self.Submodules) do
    if self[module] and self[module]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Casino Submodules ^5%s^3 initialized^7.\n", Atlantiss:GetServerName(), module))
      self[module]:Initialize()
    end
  end
end

Atlantiss.Jobs:Register(Atlantiss.Jobs.Casino:GetJobName())
