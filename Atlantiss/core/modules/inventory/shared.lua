Atlantiss.Inventory = {}

function Atlantiss.Inventory:GetModuleName()
  return "Inventory"
end

function Atlantiss.Inventory:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Inventory:GetModuleName(), message))
  end
end

Atlantiss.Modules:Register(Atlantiss.Inventory:GetModuleName())