Ora.Illegal = {}
Ora.Illegal.FakeMoneyTax = 1.5
Ora.Illegal.FakeMoneyBleaching = 1.2
Ora.Illegal.List = {}

Ora.Illegal.DeactivatedMissions = {
  ['burglary'] = true,
  ['drugselling'] = true,
  ['roberry'] = true,
  ['carjacking'] = true,
  ['carroberry'] = true,
  ['gofast'] = true,
  ['migrantsmuggling'] = true,
  ['gundelivery'] = true,
  ['drugcomponent'] = true,
  ['atm'] = true,
  ['fleeca'] = true,
  ['jewelry'] = false
}


Ora.Illegal.CopsLimitation = {
    ['default'] = 2, --2
    ['burglary'] = 2, --2
    ['drugselling'] = 2, --2
    ['roberry'] = 2, --2
    ['carjacking'] = 3, --3
    ['carroberry'] = 3, --3
    ['gofast'] = 4, --4
    ['migrantsmuggling'] = 2, --2
    ['gundelivery'] = 3, --3
    ['drugcomponent'] = 3, --3
    ['atm'] = 6, --6
    ['fleeca'] = 8, --8
    ['jewelry'] = 8, --8
} 

function Ora.Illegal:GetCopsRequired(missionName)
	if (self.CopsLimitation[missionName]) then
      return self.CopsLimitation[missionName]
  end

  return self.CopsLimitation["default"]
end


function Ora.Illegal:IsAvailable(mission)

end

function Ora.Illegal:IsDeactivated(mission)
  if (self.DeactivatedMissions[mission] ~= nil) then
    return self.DeactivatedMissions[mission]
  end

  return false
end

function Ora.Illegal:GetModuleName()
  return "Illegal"
end

function Ora.Illegal:Initialize()
  self:InitializeMissions()
end

function Ora.Illegal:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Illegal:GetModuleName(), message))
  end
end

function Ora.Illegal:Register(missionName)
  if (not self:IsDeactivated(mission)) then
    Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 Illegal Mission ^7.\n",  Ora:GetServerName(), missionName))
    self.List[#self.List + 1] = missionName
  end
end

function Ora.Illegal:InitializeMissions()
	for _, mission in pairs(self.List) do
    if self[mission] and not self:IsDeactivated(mission) and self[mission]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Mission ^5%s^3 initialized^7.\n", Ora:GetServerName(), mission))
      self[mission]:Initialize()
    end
  end
end

Ora.Modules:Register(Ora.Illegal:GetModuleName())
