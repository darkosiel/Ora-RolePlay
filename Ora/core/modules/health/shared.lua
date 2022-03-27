Ora.Health = {}

Ora.Health.State = {
  CANT_RUN = false,
  CANT_SHOOT = false,
  IS_DEAD = false,
  IS_KO = false,
  CURRENT_HEALTH = nil
}

function Ora.Health:GetModuleName()
  return "Health"
end

function Ora.Health:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Health:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.Health:GetModuleName())