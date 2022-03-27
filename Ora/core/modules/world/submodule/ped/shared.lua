Ora.World.Ped = {}
Ora.World.Ped.FemaleList = json.decode(LoadResourceFile(GetCurrentResourceName(), "core/modules/world/submodule/ped/data/female_peds.json"))
Ora.World.Ped.GangList = json.decode(LoadResourceFile(GetCurrentResourceName(), "core/modules/world/submodule/ped/data/gang_peds.json"))
Ora.World:Register("Ped")

function Ora.World.Ped:IsPedMale(ped)
  local ped = GetEntityModel(ped)

  for _, model in ipairs(Ora.World.Ped.FemaleList) do
    if ped == GetHashKey(model) then
      return false
    end
  end

  return true
end

function Ora.World.Ped:IsPedAGangster(ped)
  local ped = GetEntityModel(ped)

  for _, model in ipairs(Ora.World.Ped.GangList) do
    if ped == GetHashKey(model) then
      return true
    end
  end

  return false
end
