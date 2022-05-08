Ora.ZoneSystem = {}
Ora.ZoneSystem.WaitTime = 3600000 -- 1 hour
Ora.ZoneSystem.PrintStuff = true
Ora.ZoneSystem.OpenHours = {
  22,
  23,
  0,
  1,
  2,
  3,
}
Ora.ZoneSystem.Bars = {
  ["Unicorn"] = { Pos = vector3(121.03, -1288.75, 28.26), JobName = "unicorn", MoneyPerHour = 500, MaxDistance = 30.0 },
  ["Miror"] = { Pos = vector3(-1348.2995, -1070.0476, 11.4665), JobName = "restaurant", MoneyPerHour = 500, MaxDistance = 30.0 },
  ["Tequilala"] = { Pos = vector3(-560.29, 286.08, 82.17), JobName = "tequilala", MoneyPerHour = 500, MaxDistance = 15.0 },
  ["Galaxy"] = { Pos = vector3(-1593.92, -3012.15, -79.0), JobName = "night", MoneyPerHour = 500, MaxDistance = 40.0 },
  ["HenHouse"] = { Pos = vector3(-304.56, 6265.54, 31.49), JobName = "henhouse", MoneyPerHour = 500, MaxDistance = 20.0 },
  ["Pearl's"] = { Pos = vector3(-1832.50, -1191.68, 12.92), JobName = "restaurant", MoneyPerHour = 250, MaxDistance = 20.0 },
  ["YellowJack"] = { Pos = vector3(1987.99, 3050.73, 47.21), JobName = "yellowjack" , MoneyPerHour = 500, MaxDistance = 5.0 },
  ["Bahamas"] = { Pos = vector3(-1391.72, -604.94, 30.31), JobName = "bahamas", MoneyPerHour = 500, MaxDistance = 30.0 },
  ["8 Billards"] = { Pos = vector3(-1586.14, -995.74, 12.08), JobName = "billards", MoneyPerHour = 500, MaxDistance = 20.0 },
}

function Ora.ZoneSystem:GetModuleName()
  return "ZoneSystem"
end

function Ora.ZoneSystem:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.ZoneSystem:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.ZoneSystem:GetModuleName())
