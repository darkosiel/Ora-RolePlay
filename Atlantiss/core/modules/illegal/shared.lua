Atlantiss.Illegal = {}
Atlantiss.Illegal.FakeMoneyTax = 1.5
Atlantiss.Illegal.FakeMoneyBleaching = 1.2
Atlantiss.Illegal.List = {}

Atlantiss.Illegal.DeactivatedMissions = {
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


Atlantiss.Illegal.CopsLimitation = {
    ['default'] = 2,
    ['burglary'] = 2,
    ['drugselling'] = 2,
    ['roberry'] = 2,
    ['carjacking'] = 3,
    ['carroberry'] = 3,
    ['gofast'] = 4,
    ['migrantsmuggling'] = 2,
    ['gundelivery'] = 4,
    ['drugcomponent'] = 4,
    ['atm'] = 6,
    ['fleeca'] = 8,
    ['jewelry'] = 8,
}

function Atlantiss.Illegal:GetCopsRequired(missionName)
	if (self.CopsLimitation[missionName]) then
      return self.CopsLimitation[missionName]
  end

  return self.CopsLimitation["default"]
end


function Atlantiss.Illegal:IsAvailable(mission)

end

function Atlantiss.Illegal:IsDeactivated(mission)
  if (self.DeactivatedMissions[mission] ~= nil) then
    return self.DeactivatedMissions[mission]
  end

  return false
end

function Atlantiss.Illegal:GetModuleName()
  return "Illegal"
end

function Atlantiss.Illegal:Initialize()
  self:InitializeMissions()
end

function Atlantiss.Illegal:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Illegal:GetModuleName(), message))
  end
end

function Atlantiss.Illegal:Register(missionName)
  if (not self:IsDeactivated(mission)) then
    Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 Illegal Mission ^7.\n",  Atlantiss:GetServerName(), missionName))
    self.List[#self.List + 1] = missionName
  end
end

function Atlantiss.Illegal:InitializeMissions()
	for _, mission in pairs(self.List) do
    if self[mission] and not self:IsDeactivated(mission) and self[mission]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Mission ^5%s^3 initialized^7.\n", Atlantiss:GetServerName(), mission))
      self[mission]:Initialize()
    end
  end
end

Atlantiss.Modules:Register(Atlantiss.Illegal:GetModuleName())
