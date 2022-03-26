Atlantiss.NpcJobs.Bank = {}

Atlantiss.NpcJobs.Bank.Positions = {
  -- Los Santos
  { name = "Juan", pos = vector3(243.63, 226.23, 106.29 - 0.98), heading = 158.23},
  { name = "Albert", pos = vector3(248.95, 224.3, 106.29 - 0.98), heading = 158.63 },
  { name = "Vincent", pos = vector3(253.95, 222.52, 106.29 - 0.98), heading = 158.21 },
  -- Paleto
  { name = "Claytus", pos = vector3(-112.23, 6471.17, 31.63 - 0.98), heading = 131.86},
}

Atlantiss.NpcJobs.Bank.AvailablePeds = {
  "u_m_m_bankman",
  "u_m_o_finguru_01",
  "u_m_y_gunvend_01",
  "u_m_y_chip",
  "u_m_m_vince"
}

Atlantiss.NpcJobs.Bank.Zones = {
  -- Los Santos
  { pos = vector3(243.12, 224.75, 106.29 - 0.95), heading = 336.37, name = "bank_ls1"},
  { pos = vector3(248.33, 222.75, 106.29 - 0.95), heading = 334.05, name = "bank_ls2" },
  { pos = vector3(253.52, 221.05, 106.29 - 0.95), heading = 336.16, name = "bank_ls3" },
  -- Paleto
  { pos = vector3(-113.13, 6470.08, 31.63 - 0.95), heading = 310.58, name = "bank_pal1"},
}

Atlantiss.NpcJobs.Bank.CardLabels = {
  [1] = "Classic", 
  [2] = "Gold", 
  [3] = "Platinium", 
  [4] = "Blackcard"
}

Atlantiss.NpcJobs.Bank.Card = {
  [1] = "classic",
  [2] = "gold",
  [3] = "platinium",
  [4] = "blackcard"
}

Atlantiss.NpcJobs.Bank.CardPrices = {
  [1] = 5000,
  [2] = 15000,
  [3] = 30000,
  [4] = 45000
}

Atlantiss.NpcJobs.Bank.CardRatios = {
  [1] = {maxDeposit = 5000, maxRemove = 5000, deposit = 0, remove = 0},
  [2] = {maxDeposit = 15000, maxRemove = 15000, deposit = 0, remove = 0},
  [3] = {maxDeposit = 50000, maxRemove = 50000, deposit = 0, remove = 0},
  [4] = {maxDeposit = 250000, maxRemove = 250000, deposit = 0, remove = 0}
}

function Atlantiss.NpcJobs.Bank:GetCardPriceByName(name)
  for key, value in pairs(self.CardLabels) do
      if (value == name) then
        return self:GetCardPriceById(key)
      end
  end

  return false
end

function Atlantiss.NpcJobs.Bank:GetCardCodeByName(name)
  for key, value in pairs(self.CardLabels) do
      if (value == name) then
        return self:GetCardCodeById(key)
      end
  end

  return false
end

function Atlantiss.NpcJobs.Bank:GetCardIdByName(name)
  for key, value in pairs(self.CardLabels) do
      if (value == name) then
        return key
      end
  end

  return false
end

function Atlantiss.NpcJobs.Bank:GetCardPriceById(id)
  return self.CardPrices[id]
end

function Atlantiss.NpcJobs.Bank:GetCardCodeById(id)
  return self.Card[id]
end

function Atlantiss.NpcJobs.Bank:GetCardLabelById(id)
  return self.CardLabels[id]
end

function Atlantiss.NpcJobs.Bank:GetCardRatioById(id)
  return self.CardRatios[id]
end

function Atlantiss.NpcJobs.Bank:GetDefaultAmountForCompanyAccount()
  return 50000
end

function Atlantiss.NpcJobs.Bank:GetJobName()
  return "Bank"
end

function Atlantiss.NpcJobs.Bank:GetPedPositions()
  return self.Positions
end

function Atlantiss.NpcJobs.Bank:GetZones()
  return self.Zones
end

function Atlantiss.NpcJobs.Bank:GetPedsModels()
  return self.AvailablePeds
end

function Atlantiss.NpcJobs.Bank:GetRandomPed()
  return self.AvailablePeds[math.random(1, #self.AvailablePeds)]
end


function Atlantiss.NpcJobs.Bank:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Atlantiss.NpcJobs:GetModuleName(), Atlantiss.NpcJobs.Bank:GetJobName(), message))
  end
end

Atlantiss.NpcJobs:Register(Atlantiss.NpcJobs.Bank:GetJobName())
