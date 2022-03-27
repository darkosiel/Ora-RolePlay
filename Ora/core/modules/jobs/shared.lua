Ora.Jobs = {}

Ora.Jobs.List = {}

Ora.Jobs.Deactivated = {
  ["immo"] = false
}


function Ora.Jobs:GetModuleName()
  return "Jobs"
end

function Ora.Jobs:Initialize()
  self:InitializeJobs()
end

function Ora.Jobs:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Jobs:GetModuleName(), message))
  end
end

function Ora.Jobs:Register(jobName)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 Job^7.\n",  Ora:GetServerName(), jobName))
	self.List[#self.List + 1] = jobName
end

function Ora.Jobs:InitializeJobs()
	for _, job in pairs(self.List) do
    if self[job] and self[job]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Job ^5%s^3 initialized^7.\n", Ora:GetServerName(), job))
      self[job]:Initialize()
    end
  end
end

Ora.Modules:Register(Ora.Jobs:GetModuleName())
