Ora.Inventory = {}

function Ora.Inventory:GetModuleName()
  return "Inventory"
end

function Ora.Inventory:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Inventory:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.Inventory:GetModuleName())