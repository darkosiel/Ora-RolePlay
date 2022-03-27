Ora.NpcJobs = {}

Ora.NpcJobs.List = {}

Ora.NpcJobs.DeactivatedNpcJobs = {
  ["bank"] = false
}

function Ora.NpcJobs:IsAvailable(job)

end

function Ora.NpcJobs:IsDeactivated(job)

end

function Ora.NpcJobs:GetModuleName()
  return "NpcJobs"
end

function Ora.NpcJobs:Initialize()
  self:InitializeJobs()
end

function Ora.NpcJobs:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.NpcJobs:GetModuleName(), message))
  end
end

function Ora.NpcJobs:Register(jobName)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 NPC job^7.\n",  Ora:GetServerName(), jobName))
	self.List[#self.List + 1] = jobName
end

function Ora.NpcJobs:InitializeJobs()
	for _, job in pairs(self.List) do
    if self[job] and self[job]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Job ^5%s^3 initialized^7.\n", Ora:GetServerName(), job))
      self[job]:Initialize()
    end
  end
end

Ora.Modules:Register(Ora.NpcJobs:GetModuleName())
