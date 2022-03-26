Atlantiss.Identity.Orga = {}

function Atlantiss.Identity.Orga:GetModuleName()
  return "Orga"
end

function Atlantiss.Identity.Orga:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Identity.Orga:GetModuleName(), message))
  end
end


Atlantiss.Identity:Register(Atlantiss.Identity.Orga:GetModuleName())
