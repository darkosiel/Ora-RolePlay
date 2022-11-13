isDev             = true

C                 = {}
C.Interior        = {
    Coords = vector3(625.1706, -232.8408, 39.4937), --GTAV Decompiled Script - jewelry_heist.c line:128704
    Name   = "V_JEWEL2",
}

C.Masks           = {
    [GetHashKey("mp_m_freemode_01")] = {
        { Comp = 1, D_Id = 36 },
        { Comp = 1, D_Id = 46 },
    },
    [GetHashKey("mp_f_freemode_01")] = {
        { Comp = 1, D_Id = 35 },
        { Comp = 1, D_Id = 45 },
    },
}

C.RequiredItems = {
    GetHashKey("WEAPON_PISTOL"),
    GetHashKey("WEAPON_COMBATPISTOL"),
    GetHashKey("WEAPON_PISTOL50"),
    GetHashKey("WEAPON_REVOLVER"),
    GetHashKey("WEAPON_VINTAGEPISTOL"),
    GetHashKey("WEAPON_SNSPISTOL"),
    GetHashKey("WEAPON_HEAVYPISTOL"),
    GetHashKey("WEAPON_RAYPISTOL"),
    GetHashKey("WEAPON_DOUBLEACTION"),
    GetHashKey("WEAPON_KNUCKLE"),
    GetHashKey("WEAPON_PELLE"),
    GetHashKey("WEAPON_PICKAXE"),
    GetHashKey("WEAPON_KATANA"),
    GetHashKey("WEAPON_SLEDGEHAMMER"),
    GetHashKey("WEAPON_HAMMER"),
    GetHashKey("WEAPON_BAT"),
    GetHashKey("WEAPON_GOLFCLUB"),
    GetHashKey("WEAPON_CROWBAR"),
    GetHashKey("WEAPON_BOTTLE"),
    GetHashKey("WEAPON_DAGGER"),
    GetHashKey("WEAPON_HATCHET"),
    GetHashKey("WEAPON_BATTLEAXE"),
    GetHashKey("WEAPON_MACHETE"),
    GetHashKey("WEAPON_FLASHLIGHT"),
    GetHashKey("WEAPON_SNOWBALL"),
    GetHashKey("WEAPON_MICROSMG"),
    GetHashKey("WEAPON_MINISMG"),
    GetHashKey("WEAPON_ASSAULTSMG"),
    GetHashKey("WEAPON_MACHINEPISTOL"),
    GetHashKey("WEAPON_GRENADELAUNCHER_SMOKE"),
    GetHashKey("WEAPON_MG"),
    GetHashKey("WEAPON_COMBATMG"),
    GetHashKey("WEAPON_GUSENBERG"),
    GetHashKey("WEAPON_ASSAULTRIFLE"),
    GetHashKey("WEAPON_COMPACTRIFLE"),
    GetHashKey("WEAPON_CARBINERIFLE"),
    GetHashKey("WEAPON_SPECIALCARBINE"),
    GetHashKey("WEAPON_ADVANCEDRIFLE"),
    GetHashKey("WEAPON_TACTICALRIFLE"),
    GetHashKey("WEAPON_BULLPUPRIFLE"),
    GetHashKey("WEAPON_MUSKET"),
    GetHashKey("WEAPON_HEAVYSNIPER"),
    GetHashKey("WEAPON_SNIPERRIFLE"),
    GetHashKey("WEAPON_PUMPSHOTGUN"),
    GetHashKey("WEAPON_SMG"),
    GetHashKey("WEAPON_COMBATPDW"),
    GetHashKey("WEAPON_SAWNOFFSHOTGUN"),
    GetHashKey("WEAPON_LESSLETHAL"),
    GetHashKey("WEAPON_BULLPUPSHOTGUN"),
    GetHashKey("WEAPON_DBSHOTGUN"),
    GetHashKey("WEAPON_WRENCH"),
    GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),
    GetHashKey("weapon_carbinerifle_mk2"),
    GetHashKey("weapon_specialcarbine_mk2"),
    GetHashKey("weapon_bullpuprifle_mk2"),
    GetHashKey("weapon_militaryrifle"),
    GetHashKey("weapon_combatmg_mk2"),
    GetHashKey("weapon_heavysniper_mk2"),
    GetHashKey("weapon_marksmanrifle_mk2"),
    GetHashKey("weapon_marksmanrifle_mk2"),
    GetHashKey("weapon_hominglauncher"),
    GetHashKey("weapon_railgun"),
    --GetHashKey("weapon_firework"),
    GetHashKey("weapon_compactlauncher"),
    GetHashKey("weapon_minigun"),
    GetHashKey("weapon_rpg"),
    GetHashKey("weapon_rayminigun"),
    GetHashKey("weapon_combatshotgun"),
    GetHashKey("weapon_autoshotgun"),
    GetHashKey("weapon_heavyshotgun"),
    GetHashKey("weapon_pumpshotgun_mk2"),
    GetHashKey("weapon_smg_mk2"),
    GetHashKey("weapon_raycarbine"),
    GetHashKey("weapon_ceramicpistol"),
    GetHashKey("weapon_gadgetpistol"),
    GetHashKey("weapon_navyrevolver"),
    GetHashKey("weapon_revolver_mk2"),
    GetHashKey("weapon_snspistol_mk2"),
    GetHashKey("weapon_pistol_mk2"),
    GetHashKey("weapon_assaultshotgun"),
    GetHashKey("weapon_appistol"),
    GetHashKey("weapon_marksmanpistol"),
    GetHashKey("WEAPON_FIREEXTINGUISHER"),
    GetHashKey("WEAPON_LWRC"),
    GetHashKey("WEAPON_VP9")
}

C.VangelicoCoords = vector3(-623.34393310547, -231.72245788574, 38.057014465332)
C.ResetAlarm      = vector3(-630.96893310547, -229.42497253418, 37.057037353516)

iTypes            = {
    [1] = "DES_Jewel_Cab",
    [2] = "DES_Jewel_Cab2",
    [3] = "DES_Jewel_Cab3",
    [4] = "DES_Jewel_Cab4"
}

C.Anims           = {
    [iTypes[1]] = {
        Dict = "missheist_jewel",
        Anim = "smash_case_necklace"
    },
    [iTypes[2]] = {
        Dict = "missheist_jewel",
        Anim = "smash_case_e"
    },
    [iTypes[3]] = {
        Dict = "missheist_jewel",
        Anim = "smash_case_tray_a"
    },
    [iTypes[4]] = {
        Dict = "missheist_jewel",
        Anim = "smash_case_tray_b"
    },
}

C.Cases           = {
    ["JWL_00"] = {
        Type     = iTypes[1],
        Coords_1 = vector3(-627.735, -234.439, 37.875),
        Coords_2 = vector3(-628.187, -233.538, 37.0946),
        Heading  = 360 - 144.0
    },
    ["JWL_01"] = {
        Type     = iTypes[1],
        Coords_1 = vector3(-626.716, -233.685, 37.8583),
        Coords_2 = vector3(-627.136, -232.775, 37.0946),
        Heading  = 360 - 144.0
    },
    ["JWL_02"] = {
        Type     = iTypes[3],
        Coords_1 = vector3(-627.35, -234.947, 37.8531),
        Coords_2 = vector3(-626.62, -235.725, 37.0946),
        Heading  = 36.0
    },
    ["JWL_03"] = {
        Type     = iTypes[4],
        Coords_1 = vector3(-626.298, -234.193, 37.8492),
        Coords_2 = vector3(-625.57, -234.962, 37.0946),
        Heading  = 36.0
    },
    ["JWL_04"] = {
        Type     = iTypes[2],
        Coords_1 = vector3(-626.399, -239.132, 37.8616),
        Coords_2 = vector3(-626.894, -238.2, 37.0856),
        Heading  = 360 - 144.0
    },
    ["JWL_05"] = {
        Type     = iTypes[3],
        Coords_1 = vector3(-625.376, -238.358, 37.8687),
        Coords_2 = vector3(-625.867, -237.458, 37.0946),
        Heading  = 360 - 144.0
    },
    ["JWL_06"] = {
        Type     = iTypes[3],
        Coords_1 = vector3(-625.517, -227.421, 37.86),
        Coords_2 = vector3(-624.738, -228.2, 37.0946),
        Heading  = 36.0,
    },
    ["JWL_07"] = {
        Type     = iTypes[4],
        Coords_1 = vector3(-624.467, -226.653, 37.861),
        Coords_2 = vector3(-623.688, -227.437, 37.0946),
        Heading  = 36.0
    },
    ["JWL_08"] = {
        Type     = iTypes[2],
        Coords_1 = vector3(-623.8118, -228.6336, 37.8522),
        Coords_2 = vector3(-624.293, -227.831, 37.0946),
        Heading  = 360 - 143.511
    },
    ["JWL_09"] = {
        Type     = iTypes[4],
        Coords_1 = vector3(-624.1267, -230.7476, 37.8618),
        Coords_2 = vector3(-624.939, -231.247, 37.0946),
        Heading  = 360 - 54.13
    },
    ["JWL_10"] = {
        Type     = iTypes[3],
        Coords_1 = vector3(-621.7181, -228.9636, 37.8425),
        Coords_2 = vector3(-620.864, -228.481, 37.0946),
        Heading  = 126.925
    },
    ["JWL_11"] = {
        Type     = iTypes[1],
        Coords_1 = vector3(-622.7541, -232.614, 37.8638),
        Coords_2 = vector3(-623.3596, -233.2296, 37.0946),
        Heading  = 360 - 52.984
    },
    ["JWL_12"] = {
        Type     = iTypes[1],
        Coords_1 = vector3(-620.3262, -230.829, 37.8578),
        Coords_2 = vector3(-619.408, -230.1969, 37.0946),
        Heading  = 126.352
    },
    ["JWL_13"] = {
        Type     = iTypes[4],
        Coords_1 = vector3(-620.6465, -232.9308, 37.8407),
        Coords_2 = vector3(-620.184, -233.729, 37.0946),
        Heading  = 36.398
    },
    ["JWL_14"] = {
        Type     = iTypes[1],
        Coords_1 = vector3(-619.978, -234.93, 37.8537),
        Coords_2 = vector3(-620.44, -234.084, 37.0946),
        Heading  = 360 - 144.00
    },
    ["JWL_15"] = {
        Type     = iTypes[3],
        Coords_1 = vector3(-618.937, -234.16, 37.8425),
        Coords_2 = vector3(-619.39, -233.32, 37.0946),
        Heading  = 360 - 144.00
    },
    ["JWL_16"] = {
        Type     = iTypes[1],
        Coords_1 = vector3(-620.163, -226.212, 37.8266),
        Coords_2 = vector3(-620.797, -226.79, 37.0946),
        Heading  = 360 - 54.0
    },
    ["JWL_17"] = {
        Type     = iTypes[2],
        Coords_1 = vector3(-619.384, -227.259, 37.8342),
        Coords_2 = vector3(-620.055, -227.817, 37.0856),
        Heading  = 360 - 54.0
    },
    ["JWL_18"] = {
        Type     = iTypes[3],
        Coords_1 = vector3(-618.019, -229.115, 37.8302),
        Coords_2 = vector3(-618.679, -229.704, 37.0946),
        Heading  = 360 - 54.0
    },
    ["JWL_19"] = {
        Type     = iTypes[2],
        Coords_1 = vector3(-617.249, -230.156, 37.8201),
        Coords_2 = vector3(-617.937, -230.731, 37.0856),
        Heading  = 360 - 54.0
    },

}