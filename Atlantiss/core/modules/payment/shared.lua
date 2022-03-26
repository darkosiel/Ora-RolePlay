Atlantiss.Payment = {}
Atlantiss.Payment.Fake = {}

function Atlantiss.Payment:GetModuleName()
  return "Payment"
end

function Atlantiss.Payment:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Payment:GetModuleName(), message))
  end
end

Atlantiss.Modules:Register(Atlantiss.Payment:GetModuleName())
