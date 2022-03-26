Atlantiss.Identity.Job = {}

function Atlantiss.Identity.Job:GetModuleName()
  return "Job"
end

function Atlantiss.Identity.Job:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Identity.Job:GetModuleName(), message))
  end
end


Atlantiss.Identity:Register(Atlantiss.Identity.Job:GetModuleName())
