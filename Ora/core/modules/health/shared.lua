Atlantiss.Health = {}

Atlantiss.Health.State = {
  CANT_RUN = false,
  CANT_SHOOT = false,
  IS_DEAD = false,
  IS_KO = false,
  CURRENT_HEALTH = nil
}

function Atlantiss.Health:GetModuleName()
  return "Health"
end

function Atlantiss.Health:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Health:GetModuleName(), message))
  end
end

Atlantiss.Modules:Register(Atlantiss.Health:GetModuleName())