Ora.NpcJobs.Ambulance = {
  IS_ALLOWED = false
}

function Ora.NpcJobs.Ambulance:GetJobName()
  return "Ambulance"
end

function Ora.NpcJobs.Ambulance:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Ora.NpcJobs:GetModuleName(), Ora.NpcJobs.Ambulance:GetJobName(), message))
  end
end

Ora.NpcJobs:Register(Ora.NpcJobs.Ambulance:GetJobName())
