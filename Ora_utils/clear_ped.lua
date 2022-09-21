local clearAreaOfPedsArray = { --Antispawn PNJ
    { pos = vector3(-1084.15, -821.88, 5.48), radius = 60.0 },
    { pos = vector3(326.78, -583.25, 43.4), radius = 50.0 },
    { pos = vector3(-556.62, 285.77, 82.18), radius = 25.0 },
    { pos = vector3(338.99, 287.44, 99.80), radius = 25.0 },
    { pos = vector3(-1572.96, -261.3, 48.48), radius = 50.0 },
    { pos = vector3(-580.09, -932.8, 23.68), radius = 25.0 },
    { pos = vector3(-1070.56, -245.15, 40.35), radius = 25.0 },
    { pos = vector3(-559.68, -199.2, 39.34), radius = 25.0 },
    { pos = vector3(245.51, -1093.77, 30.21), radius = 25.0 },
    { pos = vector3(117.96, -1287.3, 28.27), radius = 50.0 },
    { pos = vector3(322.58, 181.54, 103.59), radius = 6.0 },
    { pos = vector3(248.62, 220.36, 106.29), radius = 15.0 },
    { pos = vector3(-204.8388, -1333.2086, 34.89), radius = 60.0 },
    { pos = vector3(-1427.299, -245.1012, 16.8039), radius = 20.0 },
    { pos = vector3(1990.88, 3054.02, 47.21), radius = 60.0 },-- Yellow Jack 
    { pos = vector3(811.8556, -2149.9516, 29.6210), radius = 60.0 },-- Ammunation Sud
    { pos = vector3(1410.99, 1147.39, 114.33), radius = 60.0 },-- Madrazo
    { pos = vector3(146.24, -1113.88, 29.31), radius = 40.0 },-- PDM
    { pos = vector3(-1839.58, -360.67, 59.00), radius = 60.0 },-- Hopital
    { pos = vector3(-1912.3077, -388.1100, 48.95), radius = 60.0 },-- klébar
    { pos = vector3(2033.8979, 4984.5527, 40.73), radius = 60.0 },-- ferme
}

Citizen.CreateThread(function()
    local PlayerId, PlayerPedId, GetEntityCoords, ClearAreaOfCops = PlayerId, PlayerPedId, GetEntityCoords, ClearAreaOfCops
    while true do
        Citizen.Wait(1000)
        Player.PlayerId = PlayerId()
        Player.Ped = PlayerPedId()
        Player.Position = GetEntityCoords(Player.Ped)
        ClearAreaOfCops(Player.Position.x, Player.Position.y, Player.Position.z, 500.0, 0)
    end
end)

AddEventHandler("populationPedCreating", function(x, y, z, model, functions)
    for k, v in pairs(clearAreaOfPedsArray) do
        if #(v.pos - vector3(x, y, z)) <= v.radius then
            CancelEvent()
        end
    end
end)

Citizen.CreateThread(function()
    local GetHashKey = GetHashKey
    local ClearAreaOfPeds = ClearAreaOfPeds
    local SetPedDensityMultiplierThisFrame = SetPedDensityMultiplierThisFrame
    local SetScenarioPedDensityMultiplierThisFrame = SetScenarioPedDensityMultiplierThisFrame
    local SetVehicleDensityMultiplierThisFrame = SetVehicleDensityMultiplierThisFrame
    local SetParkedVehicleDensityMultiplierThisFrame = SetParkedVehicleDensityMultiplierThisFrame
    local SetRandomVehicleDensityMultiplierThisFrame = SetRandomVehicleDensityMultiplierThisFrame
    local DisablePlayerVehicleRewards = DisablePlayerVehicleRewards
    local SetPlayerHealthRechargeMultiplier = SetPlayerHealthRechargeMultiplier
    SetPoliceIgnorePlayer(Player.PlayerId, true)
    SetEveryoneIgnorePlayer(Player.PlayerId, true)
    SetPlayerCanBeHassledByGangs(Player.PlayerId, false)
    SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))
    while true do
        Citizen.Wait(0)

        -- for key, value in pairs(clearAreaOfPedsArray) do
        --     if #(value.pos - Player.Position) < 250.0 then
        --         print("Deleting peds for " .. key)
        --         ClearAreaOfPeds(value.pos.x, value.pos.y, value.pos.z, value.radius, 1)
        --     end
        -- end

        SetPedDensityMultiplierThisFrame(1.0) -- set npc/ai peds density to 0
        SetScenarioPedDensityMultiplierThisFrame(1.0, 1.0)
        SetVehicleDensityMultiplierThisFrame(0.8) -- was at 0.6
        SetParkedVehicleDensityMultiplierThisFrame(0.8) -- was at 0.5
        SetRandomVehicleDensityMultiplierThisFrame(0.8) -- was at 0.5 -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
        DisablePlayerVehicleRewards(Player.PlayerId)
        SetPlayerHealthRechargeMultiplier(Player.PlayerId, 0.0)
    end
end
)