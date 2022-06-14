Ora.DrugDealing = {}


Ora.DrugDealing.Area = {
  [1] = "Vespucci Beach",
  [2] = "Place des cubes",
  [3] = "Maze Bank Arena",
  [4] = "Little Seoul",
  [5] = "Mirror park",
  [6] = "Sandy Shore",
  [8] = "Vinewood",
  [7] = "Paleto",
}

Ora.DrugDealing.SimultaneousLimit = {
  [1] = 3,
  [2] = 3,
  [3] = 3,
  [4] = 3,
  [5] = 3,
  [6] = 4,
  [7] = 4,
  [8] = 3,
}

Ora.DrugDealing.CopsJuridiction = {
  [1] = "police",
  [2] = "police",
  [3] = "police",
  [4] = "police",
  [5] = "police",
  [6] = "lssd",
  [7] = "lssd",
  [8] = "police",
}

function Ora.DrugDealing:GetDealingAreas()
  self:Debug(string.format("Returning ^5%s^3 dealing areas", #Ora.DrugDealing.Area))
  return self.Area
end

function Ora.DrugDealing:GetDealingAreaNameById(zoneId)
  if (self.Area[zoneId] ~= nil) then 
    self:Debug(string.format("Returning name ^5%s^3 of dealing area ^5%s^3", self.Area[zoneId], zoneId))
    return self.Area[zoneId]
  end

  self:Debug(string.format("Returning name false of dealing area ^5%s^3 because it does not exist", zoneId))
  return false
end

function Ora.DrugDealing:GetDealingZoneIdByName(name)
  for key, value in pairs(self.Area) do
      if (string.lower(value) == string.lower(name)) then
        self:Debug(string.format("Returning zone id ^5%s^3 for zone name ^5%s^3", key, name))
        return key
      end
  end

  self:Debug(string.format("Returning false for zone name ^5%s^3 because it does not exist", name))
  return false
end

function Ora.DrugDealing:GetCopsJuridictionForZoneId(zoneId)
  if (self.CopsJuridiction[zoneId] ~= nil) then
    self:Debug(string.format("Returning cops juridiction ^5%s^3 for zone ^5%s^3", Ora.DrugDealing.CopsJuridiction[zoneId], zoneId))
    return self.CopsJuridiction[zoneId]
  end

  self:Debug(string.format("Returning default cops juridiction for zone ^5%s^3 because it does not exists", zoneId))
  return "all"
end

function Ora.DrugDealing:GetSimultaneousLimitForZone(zoneId)
    if (self.SimultaneousLimit[zoneId] ~= nil) then
      self:Debug(string.format("Returning simultaneous limitation of ^5%s^3 for zone ^5%s^3", Ora.DrugDealing.SimultaneousLimit[zoneId], zoneId))
      return self.SimultaneousLimit[zoneId]
    end

    self:Debug(string.format("Returning default simultaneous limitation for zone ^5%s^3 because it does not exists", zoneId))
    return 3
end

function Ora.DrugDealing:GetModuleName()
  return "DrugDealing"
end

function Ora.DrugDealing:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.DrugDealing:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.DrugDealing:GetModuleName())