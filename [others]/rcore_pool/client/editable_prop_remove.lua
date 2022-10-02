PropsToRemove = Config.PropsToRemove or {
    vector3(1992.803, 3047.312, 46.22865),
}

local models = {
    GetHashKey("prop_pool_ball_01"),
    GetHashKey("prop_poolball_1"),
    GetHashKey("prop_poolball_2"),
    GetHashKey("prop_poolball_3"),
    GetHashKey("prop_poolball_4"),
    GetHashKey("prop_poolball_5"),
    GetHashKey("prop_poolball_6"),
    GetHashKey("prop_poolball_7"),
    GetHashKey("prop_poolball_8"),
    GetHashKey("prop_poolball_9"),
    GetHashKey("prop_poolball_10"),
    GetHashKey("prop_poolball_11"),
    GetHashKey("prop_poolball_12"),
    GetHashKey("prop_poolball_13"),
    GetHashKey("prop_poolball_14"),
    GetHashKey("prop_poolball_15"),
    GetHashKey("prop_poolball_cue"),
    GetHashKey("prop_pool_cue"),
    GetHashKey("prop_pool_tri"),
}

Citizen.CreateThread(function()
    for _, pos in pairs(PropsToRemove) do
        for _, model in pairs(models) do
            Wait(0)
            CreateModelHideExcludingScriptObjects(pos.x, pos.y, pos.z, 3.0, model, true)
        end
    end
end)
