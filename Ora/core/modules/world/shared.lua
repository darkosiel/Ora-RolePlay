Ora.World = {}
Ora.World.List = {}

Ora.World.VehicleGeneratorRemoved = { --Antispawn VOITURES
  {x = 1222.7, y = 2712.9, z = 38.01, r = 3.0}, -- AntiSpawn Larry's
  {x = -44.02, y = -1098.0, z = 26.42, r = 3.0}, -- AntiSpawn concess sud
  --{x = 133.89, y = 6604.01, z = 31.84, r = 500}, -- AntiSpawn biker QG
  --{x = 1986.10, y = 3785.63, z = 34.65, r = 500}, -- AntiSpawn station sandy
  {x = 1767.12, y = 3328.01, z = 41.44, r = 5.0}, -- AntiSpawn FlyWheels Garage
  --{x = 408.50, y = -988.39, z = 29.26, r = 500}, -- AntiSpawn LSPD
  {x = 1639.45, y = 4836.45, z = 42.02, r = 3.0}, -- Club House AOD
  {x = -102.858, y = -2071.420, z = 17.00, r = 100.0}, -- Karting
  {x = 205.28, y = -1651.42, z = 29.80, r = 200.0}, -- Caserne pompier
  {x = 1410.83, y = 1117.63, z = 114.83, r = 500}, -- Antispawn Fuente Blanca
  {x = 31.7753, y = 6459.4218, z = 31.30, r = 500}, --Dirty Punks
  {x = -444.8722, y = 6010.3310, z = 36.50, r = 500} --BCSO
}


function Ora.World:GetModuleName()
  return "World"
end

function Ora.World:Initialize()
  self:InitializeSubmodules()
end

function Ora.World:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.World:GetModuleName(), message))
  end
end

function Ora.World:Register(submodule)
  Citizen.Trace(string.format("^2[%s] ^3Registering ^5%s^3 Submodule ^7.\n",  Ora:GetServerName(), submodule))
  self.List[#self.List + 1] = submodule
end

function Ora.World:InitializeSubmodules()
	for _, submodule in pairs(self.List) do
    if self[submodule] and self[submodule]["Initialize"] then
      Citizen.Trace(string.format("^2[%s] ^3Submodule ^5%s^3 initialized^7.\n", Ora:GetServerName(), submodule))
      self[submodule]:Initialize()
    end
  end
end

Ora.Modules:Register(Ora.World:GetModuleName())
