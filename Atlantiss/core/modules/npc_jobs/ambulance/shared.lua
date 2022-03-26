Atlantiss.NpcJobs.Ambulance = {
  IS_ALLOWED = false
}

function Atlantiss.NpcJobs.Ambulance:GetJobName()
  return "Ambulance"
end

function Atlantiss.NpcJobs.Ambulance:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Atlantiss.NpcJobs:GetModuleName(), Atlantiss.NpcJobs.Ambulance:GetJobName(), message))
  end
end

Atlantiss.NpcJobs:Register(Atlantiss.NpcJobs.Ambulance:GetJobName())
