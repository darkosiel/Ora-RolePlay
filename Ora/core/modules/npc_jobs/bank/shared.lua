Ora.NpcJobs.Bank = {}

-- Ora.NpcJobs.Bank.Positions = {
--   -- Los Santos
--   { name = "Juan", pos = vector3(254.15, 222.41, 106.29 - 0.98), heading = 155.47},
--   { name = "Albert", pos = vector3(247.01, 225.04, 106.29 - 0.98), heading = 161.53 },
--   { name = "Vincent", pos = vector3(243.56, 226.27, 106.29 - 0.98), heading = 160.3 },
--   -- Paleto
--   { name = "Claytus", pos = vector3(-112.23, 6471.17, 31.63 - 0.98), heading = 131.86},
-- }

Ora.NpcJobs.Bank.AvailablePeds = {
  "u_m_m_bankman",
  "u_m_o_finguru_01",
  "u_m_y_gunvend_01",
  "u_m_y_chip",
  "u_m_m_vince"
}

-- Ora.NpcJobs.Bank.Zones = {
--   -- Los Santos
--   { pos = vector3(254.15, 222.41, 106.29 - 0.98), heading = 155.47, name = "bank_ls1"},
--   { pos = vector3(247.01, 225.04, 106.29 - 0.98), heading = 161.53, name = "bank_ls2" },
--   { pos = vector3(243.56, 226.27, 106.29 - 0.98), heading = 160.3, name = "bank_ls3" },
--   -- Paleto
--   { pos = vector3(-113.13, 6470.08, 31.63 - 0.95), heading = 310.58, name = "bank_pal1"},
-- }

Ora.NpcJobs.Bank.CardLabels = {
  [1] = "Classic", 
  [2] = "Gold", 
  [3] = "Platinium", 
  [4] = "Blackcard"
}

Ora.NpcJobs.Bank.Card = {
  [1] = "classic",
  [2] = "gold",
  [3] = "platinium",
  [4] = "blackcard"
}

Ora.NpcJobs.Bank.CardPrices = {
  [1] = 5000,
  [2] = 15000,
  [3] = 30000,
  [4] = 45000
}

Ora.NpcJobs.Bank.CardRatios = {
  [1] = {maxDeposit = 5000, maxRemove = 5000, deposit = 0, remove = 0},
  [2] = {maxDeposit = 15000, maxRemove = 15000, deposit = 0, remove = 0},
  [3] = {maxDeposit = 50000, maxRemove = 50000, deposit = 0, remove = 0},
  [4] = {maxDeposit = 250000, maxRemove = 250000, deposit = 0, remove = 0}
}

function Ora.NpcJobs.Bank:GetCardPriceByName(name)
  for key, value in pairs(self.CardLabels) do
      if (value == name) then
        return self:GetCardPriceById(key)
      end
  end

  return false
end

function Ora.NpcJobs.Bank:GetCardCodeByName(name)
  for key, value in pairs(self.CardLabels) do
      if (value == name) then
        return self:GetCardCodeById(key)
      end
  end

  return false
end

function Ora.NpcJobs.Bank:GetCardIdByName(name)
  for key, value in pairs(self.CardLabels) do
      if (value == name) then
        return key
      end
  end

  return false
end

function Ora.NpcJobs.Bank:GetCardPriceById(id)
  return self.CardPrices[id]
end

function Ora.NpcJobs.Bank:GetCardCodeById(id)
  return self.Card[id]
end

function Ora.NpcJobs.Bank:GetCardLabelById(id)
  return self.CardLabels[id]
end

function Ora.NpcJobs.Bank:GetCardRatioById(id)
  return self.CardRatios[id]
end

function Ora.NpcJobs.Bank:GetDefaultAmountForCompanyAccount()
  return 50000
end

function Ora.NpcJobs.Bank:GetJobName()
  return "Bank"
end

function Ora.NpcJobs.Bank:GetPedPositions()
  return self.Positions
end

function Ora.NpcJobs.Bank:GetZones()
  return self.Zones
end

function Ora.NpcJobs.Bank:GetPedsModels()
  return self.AvailablePeds
end

function Ora.NpcJobs.Bank:GetRandomPed()
  return self.AvailablePeds[math.random(1, #self.AvailablePeds)]
end


function Ora.NpcJobs.Bank:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Ora.NpcJobs:GetModuleName(), Ora.NpcJobs.Bank:GetJobName(), message))
  end
end

Ora.NpcJobs:Register(Ora.NpcJobs.Bank:GetJobName())
