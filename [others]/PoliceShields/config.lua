main = {
    commandName = "shield",
    commandChatSuggestion = "Use a police shield",
    parameterType = "Shield Type", -- Use this to change to a different language
    acePermissionsEnabled = true, --If true, this enables ace permissions
    enableDeveloperCommand = false, -- Toggle the developer command (/shieldposition) which can assist in positioning the shields
    networkedWhenDeveloping = true, -- Toggle whether the shield is synced to other players when using the shieldposition command
    developerBoneIndex = "IK_L_Hand", -- The bone index to attach the shield to when using the shield position command
    developerCollision = true, -- Whether collision should be enabled when using the shield position command
    offSetMovement = 0.009,
    rotationMovement = 0.7,
    developerAnimDict = "combat@combat_reactions@pistol_1h_hillbilly",
    developerAnimName = "180",
}

translations = {
    noArguments = "~r~Error~w~: You must specify the shield type",
    invalidShieldType = "~r~Error~w~: You must specify the shield type",
    outsideVehicle = "~r~Error~w~: You must be outside a vehicle",
    shieldRemoved = "~g~Success~w~: Shield removed",
    invalidShieldModel = "Invalid Shield Model - Usage /shieldposition [model]",
}

-- These are the job checks to use all police shields
jobCheck = {
    ESX = {
        enabled = false,
        checkJob = {
            enabled = true, -- Enable this to use ESX job check
            jobs = {"police"} -- A user can have any of the following jobs, allowing you to add multiple
        }
    },
    -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
    vRP = {
        enabled = false,
        checkGroup = {
            enabled = false, -- Enable this to use vRP group check
            groups = {"police", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
        },
        checkPermission = {
            enabled = false, -- Enable this to use vRP permission check
            permissions = {"player.kick"} -- A user can have any of the following permissions, allowing you to add multiple
        },
    },
    -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
    QBCore = {
        enabled = false,
        checkJob = {
            enabled = false, -- Enable this to use QBCore job check
            jobs = {"police"}, -- A user can have any of the following jobs, meaning you can add different jobs
        },
        checkPermission = {
            enabled = false, -- Enable this to use QBCore permission check
            permissions = {"god"}, -- A user can have any of the following permissions, allowing you to add multiple
        },
    },
}

-- Shield Names must be one word for command usage
-- eg /shield ballistic

shields = {
    {
        name = "Firearms",
        model = `bv_shield1`,
        offSet = {-0.099, 0.378, -0.135},
        rotation = {177.1, 178.5, 0.0},
        boneIndex = -1,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
    {
        name = "SWAT",
        model = GetHashKey('bv_shield2'),
        offSet = {0.054, 0.036, 0.0},
        rotation = {-122.5, 101.5, -83.3},
        boneIndex = 62,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
    {
        name = "Small",
        model = `bv_shield3`,
        offSet = {0.0, 0.288, 0.0},
        rotation = {0.0, 0.0, 163.1},
        boneIndex = -1,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
    {
        name = "Long",
        model = `bv_shield4`,
        offSet = {0.045, 0.405, -0.108},
        rotation = {0.7, -0.7, 171.5},
        boneIndex = -1,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
    {
        name = "CTSFO2",
        model = `prop_shield_one`,
        offSet = {-0.59, 0.29, 0.15},
        rotation = {0.16, 79.04, 41.39},
        boneIndex = 24818,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
    {
        name = "Firearms2",
        model = `prop_shield_two`,
        offSet = {-0.59, 0.29, 0.15},
        rotation = {0.16, 79.04, 41.39},
        boneIndex = 24818,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
    {
        name = "Long2",
        model = `prop_shield_three`,
        offSet = {0.738, 0.117, 0.675},
        rotation = {11.2, 210.7, 102.98},
        boneIndex = 62,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
    {
        name = "Short2",
        model = `prop_shield_four`,
        offSet = {-0.68, 0.22, 0.15},
        rotation = {0.52, 79.28, 41.39},
        boneIndex = 24818,
        collision = true,
        animDict = "combat@combat_reactions@pistol_1h_hillbilly",
        animName = "180",
    },
}