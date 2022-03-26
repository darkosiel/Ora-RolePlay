Atlantiss.Jobs = {}

Atlantiss.Jobs.List = {}

Atlantiss.Jobs.Deactivated = {
  ["immo"] = false
}


function Atlantiss.Jobs:GetModuleName()
  return "Jobs"
end

function Atlantiss.Jobs:Initialize()
  self:InitializeJobs()
end

function Atlantiss.Jobs:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Jobs:GetModuleName(), message))
  end
end

function Atlantiss.Jobs:Register(jobName)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 Job^7.\n",  Atlantiss:GetServerName(), jobName))
	self.List[#self.List + 1] = jobName
end

function Atlantiss.Jobs:InitializeJobs()
	for _, job in pairs(self.List) do
    if self[job] and self[job]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Job ^5%s^3 initialized^7.\n", Atlantiss:GetServerName(), job))
      self[job]:Initialize()
    end
  end
end

Atlantiss.Modules:Register(Atlantiss.Jobs:GetModuleName())
