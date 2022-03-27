Ora.Payment = {}
Ora.Payment.Fake = {}

function Ora.Payment:GetModuleName()
  return "Payment"
end

function Ora.Payment:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Payment:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.Payment:GetModuleName())
