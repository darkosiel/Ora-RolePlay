Ora.Identity.Orga = {}

function Ora.Identity.Orga:GetModuleName()
  return "Orga"
end

function Ora.Identity.Orga:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Identity.Orga:GetModuleName(), message))
  end
end


Ora.Identity:Register(Ora.Identity.Orga:GetModuleName())
