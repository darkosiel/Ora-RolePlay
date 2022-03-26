Atlantiss.World.Ped = {}
Atlantiss.World.Ped.FemaleList = json.decode(LoadResourceFile(GetCurrentResourceName(), "core/modules/world/submodule/ped/data/female_peds.json"))
Atlantiss.World.Ped.GangList = json.decode(LoadResourceFile(GetCurrentResourceName(), "core/modules/world/submodule/ped/data/gang_peds.json"))
Atlantiss.World:Register("Ped")

function Atlantiss.World.Ped:IsPedMale(ped)
  local ped = GetEntityModel(ped)

  for _, model in ipairs(Atlantiss.World.Ped.FemaleList) do
    if ped == GetHashKey(model) then
      return false
    end
  end

  return true
end

function Atlantiss.World.Ped:IsPedAGangster(ped)
  local ped = GetEntityModel(ped)

  for _, model in ipairs(Atlantiss.World.Ped.GangList) do
    if ped == GetHashKey(model) then
      return true
    end
  end

  return false
end
