Atlantiss.NpcJobs = {}

Atlantiss.NpcJobs.List = {}

Atlantiss.NpcJobs.DeactivatedNpcJobs = {
  ["bank"] = false
}

function Atlantiss.NpcJobs:IsAvailable(job)

end

function Atlantiss.NpcJobs:IsDeactivated(job)

end

function Atlantiss.NpcJobs:GetModuleName()
  return "NpcJobs"
end

function Atlantiss.NpcJobs:Initialize()
  self:InitializeJobs()
end

function Atlantiss.NpcJobs:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.NpcJobs:GetModuleName(), message))
  end
end

function Atlantiss.NpcJobs:Register(jobName)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 NPC job^7.\n",  Atlantiss:GetServerName(), jobName))
	self.List[#self.List + 1] = jobName
end

function Atlantiss.NpcJobs:InitializeJobs()
	for _, job in pairs(self.List) do
    if self[job] and self[job]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Job ^5%s^3 initialized^7.\n", Atlantiss:GetServerName(), job))
      self[job]:Initialize()
    end
  end
end

Atlantiss.Modules:Register(Atlantiss.NpcJobs:GetModuleName())
