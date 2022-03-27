Ora.Identity.Job = {}

function Ora.Identity.Job:GetModuleName()
  return "Job"
end

function Ora.Identity.Job:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Identity.Job:GetModuleName(), message))
  end
end


Ora.Identity:Register(Ora.Identity.Job:GetModuleName())
