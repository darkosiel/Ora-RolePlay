local mk1 = {
    "Aucune teinture",
    "Teinture verte 1000$",
    "Teinture or 30000$",
    "Teinture rose 1000$",
    "Teinture armée 2500$",
    "Teinture LSPD 5000$",
    "Teinture Orange 4500$",
    "Teinture Platine 20000$"
}

local mk1price = {
    0,
    1000,
    30000,
    1000,
    2500,
    5000,
    4000,
    20000
}
local WeaponsFct =
    WeaponsFct or
    {
        interiorIDs = {
            [153857] = true,
            [200961] = true,
            [140289] = {
                weaponRotationOffset = 135.0
            },
            [180481] = true,
            [168193] = true,
            [164609] = {
                weaponRotationOffset = 150.0
            },
            [175617] = true,
            [176385] = true,
            [178689] = true,
            [137729] = {
                additionalOffset = vec(8.3, -6.5, 0.0),
                additionalCameraOffset = vec(8.3, -6.0, 0.0),
                additionalCameraPoint = vec(1.0, -0.91, 0.0),
                additionalWeaponOffset = vec(0.0, 0.5, 0.0),
                weaponRotationOffset = -60.0
            },
            [248065] = {
                additionalOffset = vec(-10.0, 3.0, 0.0),
                additionalCameraOffset = vec(-9.5, 3.0, 0.0),
                additionalCameraPoint = vec(-1.0, 0.4, 0.0),
                additionalWeaponOffset = vec(0.4, 0.0, 0.0)
            }
        },
        closeMenuNextFrame = false,
        weaponClasses = {}
    }
weapon_name = {
    can = "WEAPON_CANETTE",
    parachute = "gadget_parachute",
    pistol = "WEAPON_PISTOL",
    pistolcombat = "WEAPON_COMBATPISTOL",
    pistol50 = "WEAPON_PISTOL50",
    revolver = "WEAPON_REVOLVER",
    pistolvintage = "WEAPON_VINTAGEPISTOL",
    snspistol = "WEAPON_SNSPISTOL",
    pitollourd = "WEAPON_HEAVYPISTOL",
    stungun = "WEAPON_STUNGUN",
    raypistol = "WEAPON_RAYPISTOL",
    flaregun = "WEAPON_FLAREGUN",
    pistoldouble = "WEAPON_DOUBLEACTION",
    knuckle = "WEAPON_KNUCKLE",
    knife1 = "WEAPON_SWITCHBLADE",
    pelle = "WEAPON_PELLE",
    pioche = "WEAPON_PICKAXE",
    katana = "WEAPON_KATANA",
    masse = "WEAPON_SLEDGEHAMMER",
    knife = "WEAPON_KNIFE",
    nightstick = "WEAPON_NIGHTSTICK",
    hammer = "WEAPON_HAMMER",
    batte = "WEAPON_BAT",
    golf = "WEAPON_GOLFCLUB",
    crowbar = "WEAPON_CROWBAR",
    bottle = "WEAPON_BOTTLE",
    dagger = "WEAPON_DAGGER",
    hatchet = "WEAPON_HATCHET",
    combathatchet = "WEAPON_BATTLEAXE",
    machete = "WEAPON_MACHETE",
    flashlight = "WEAPON_FLASHLIGHT",
    microsmg = "WEAPON_MICROSMG",
    minismg = "WEAPON_MINISMG",
    assaultsmg = "WEAPON_ASSAULTSMG",
    machinepistol = "WEAPON_MACHINEPISTOL",
    gaslauncher = "WEAPON_GRENADELAUNCHER_SMOKE",
    mg = "WEAPON_MG",
    combatmg = "WEAPON_COMBATMG",
    gusenberg = "WEAPON_GUSENBERG",
    ak = "WEAPON_ASSAULTRIFLE",
    compactrifle = "WEAPON_COMPACTRIFLE",
    carrabine = "WEAPON_CARBINERIFLE",
    carabinespecial = "WEAPON_SPECIALCARBINE",
    advancedrifle = "WEAPON_ADVANCEDRIFLE",
    bullpuprifle = "WEAPON_BULLPUPRIFLE",
    musket = "WEAPON_MUSKET",
    heavysniper = "WEAPON_HEAVYSNIPER",
    sniperrifle = "WEAPON_SNIPERRIFLE",
    shootgun = "WEAPON_PUMPSHOTGUN",
    teargas = "WEAPON_SMOKEGRENADE",
    bombsticky = "WEAPON_STICKYBOMB",
    molotov = "WEAPON_MOLOTOV",
    gascan = "WEAPON_PETROLCAN",
    smg = "WEAPON_SMG",
    combatsmg = "WEAPON_COMBATPDW",
    hazardouscan = "WEAPON_HAZARDCAN",
    shootguncompact = "WEAPON_SAWNOFFSHOTGUN",
    beanbag = "WEAPON_BEAMBAG",
    bullpupshootgun = "WEAPON_BULLPUPSHOTGUN",
    dbshotgun = "WEAPON_DBSHOTGUN",
    wrench = "WEAPON_WRENCH",
    poolcue = "WEAPON_POOLCUE",
    akmk2 = "WEAPON_ASSAULTRIFLE_MK2",
    m4mk2 = "weapon_carbinerifle_mk2",
    specialcarbinemk2 = "weapon_specialcarbine_mk2",
    bullpupriflemk2 = "weapon_bullpuprifle_mk2",
    militaryrifle = "weapon_militaryrifle",
    combatmgmk2 = "weapon_combatmg_mk2",
    heavysnipermk2 = "weapon_heavysniper_mk2",
    marksmanriflemk2 = "weapon_marksmanrifle_mk2",
    marksmanriflemk2 = "weapon_marksmanrifle_mk2",
    hominglauncher = "weapon_hominglauncher",
    railgun = "weapon_railgun",
    compactlauncher = "weapon_compactlauncher",
    minigun = "weapon_minigun",
    rpg = "weapon_rpg",
    rayminigun = "weapon_rayminigun",
    combatshotgun = "weapon_combatshotgun",
    autoshotgun = "weapon_autoshotgun",
    heavyshotgun = "weapon_heavyshotgun",
    pumpshotgunmk2 = "weapon_pumpshotgun_mk2",
    smgmk2 = "weapon_smg_mk2",
    raycarbine = "weapon_raycarbine",
    ceramicpistol = "weapon_ceramicpistol",
    gadgetpistol = "weapon_gadgetpistol",
    navyrevolver = "weapon_navyrevolver",
    revolvermk2 = "weapon_revolver_mk2",
    snspistolmk2 = "weapon_snspistol_mk2",
    pistolmk2 = "weapon_pistol_mk2",
    assaultshotgun = "weapon_assaultshotgun",
    apppistol = "weapon_appistol",
    marksmanpistol = "weapon_marksmanpistol",
    fire_extinguisher = "WEAPON_FIREEXTINGUISHER"
}

weapon_munition = {
    pistol = "mm9",
    pistolcombat = "mm9",
    pitollourd = "mm9",
    pistol50 = "snip",
    revolver = "snip",
    pistolvintage = "mm9",
    snspistol = "acp45",
    stungun = nil,
    raypistol = nil,
    flaregun = "calibre12",
    pistoldouble = "snip",
    --- blanches
    knuckle = nil,
    knife1 = nil,
    knife = nil,
    pelle = nil,
    pioche = nil,
    masse = nil,
    nightstick = nil,
    hammer = nil,
    batte = nil,
    golf = nil,
    crowbar = nil,
    katana = nil,
    bottle = nil,
    dagger = nil,
    hatchet = nil,
    combathatchet = nil,
    machete = nil,
    flashlight = nil,
    gascan = nil,
    hazardouscan = nil,
    wrench = nil,
    poolcue = nil,
    fire_extinguisher = nil,
    --- grenades
    teargas = "teargas",
    bombsticky = "bombsticky",
    molotov ="molotov",
    can = "can",
    parachute = nil,
    --- smg
    microsmg = "mm9",
    minismg = "mm9",
    assaultsmg = "mm9",
    smg = "acp45",
    combatsmg = "acp45",
    machinepistol = "mm9",
    gaslauncher = "teargas",
    --- armes lourdes
    mg = "akm",
    combatmg = "akm",
    gusenberg = "akm",
    ak = "akm",
    compactrifle = "akm",
    carrabine = "cab2",
    carabinespecial = "cab2",
    advancedrifle = "cab2",
    bullpuprifle = "cab2",
    musket = "cab",
    --- sniper
    heavysniper = "snip",
    sniperrifle = "snip",
    --- calibre 12
    shootgun = "calibre12",
    shootguncompact = "calibre12",
    beanbag = "calibre12",
    bullpupshootgun = "calibre12",
    dbshotgun = "calibre12"
}

local globalAttachmentTable = {
    {"COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_CARBINERIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_ASSAULTRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_MICROSMG_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_SNIPERRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_PISTOL_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_PISTOL50_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_APPISTOL_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_HEAVYPISTOL_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_SMG_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_MARKSMANRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish", 15000},
    {"COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER", "Lowrider Finish", 1000},
    {"COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER", "Lowrider Finish", 1000},
    {"COMPONENT_SNSPISTOL_VARMOD_LOWRIDER", "Lowrider Finish", 1000},
    {"COMPONENT_MG_COMBATMG_LOWRIDER", "Lowrider Finish", 1000},
    {"COMPONENT_BULLPUPRIFLE_VARMOD_LOWRIDER", "Lowrider Finish", 1000},
    {"COMPONENT_MG_VARMOD_LOWRIDER", "Lowrider Finish", 1000},
    {"COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER", "Lowrider Finish", 1000},
    {"COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER", "Lowrider Finish", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_MACHINEPISTOL_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_MINISMG_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_MARKSMANRIFLE_MK2_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_COMBATMG_MK2_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_SMG_MK2_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_PISTOL_MK2_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_PISTOL_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_ASSAULTSHOTGUN_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_HEAVYSHOTGUN_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_PISTOL50_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_COMBATPISTOL_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_APPISTOL_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_COMBATPDW_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_SNSPISTOL_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_ASSAULTRIFLE_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_COMBATMG_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_MG_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_ASSAULTSMG_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_GUSENBERG_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_MICROSMG_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_BULLPUPRIFLE_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_COMPACTRIFLE_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_HEAVYPISTOL_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_VINTAGEPISTOL_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_CARBINERIFLE_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_ADVANCEDRIFLE_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_MARKSMANRIFLE_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_SMG_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_SPECIALCARBINE_CLIP_02", "Extended Magazine", 1000},
    {"COMPONENT_AT_PI_FLSH_02", "Lampe torche", 1000},
    {"COMPONENT_AT_AR_FLSH	", "Lampe torche", 1000},
    {"COMPONENT_AT_PI_FLSH", "Lampe torche", 1000},
    {"COMPONENT_AT_AR_FLSH", "Lampe torche", 1000},
    {"COMPONENT_AT_PI_FLSH_03", "Lampe torche", 1000},
    {"COMPONENT_AT_PI_SUPP", "Silencieux", 1000},
    {"COMPONENT_AT_PI_SUPP_02", "Silencieux", 1000},
    {"COMPONENT_AT_AR_SUPP", "Silencieux", 1000},
    {"COMPONENT_AT_AR_SUPP_02", "Silencieux", 1000},
    {"COMPONENT_AT_SR_SUPP", "Silencieux", 1000},
    {"COMPONENT_AT_SR_SUPP_03", "Silencieux", 1000},
    {"COMPONENT_AT_PI_SUPP", "Silencieux", 1000},
    {"COMPONENT_AT_PI_COMP", "Compensator", 1000},
    {"COMPONENT_AT_PI_COMP_02", "Compensator", 1000},
    {"COMPONENT_AT_PI_COMP_03", "Compensator", 1000},
    {"COMPONENT_AT_MRFL_BARREL_01", "Barrel Attachment 1", 1000},
    {"COMPONENT_AT_MRFL_BARREL_02", "Barrel Attachment 2", 1000},
    {"COMPONENT_AT_SR_BARREL_01", "Barrel Attachment 1", 1000},
    {"COMPONENT_AT_BP_BARREL_01", "Barrel Attachment 1", 1000},
    {"COMPONENT_AT_BP_BARREL_02", "Barrel Attachment 2", 1000},
    {"COMPONENT_AT_SC_BARREL_01", "Barrel Attachment 1", 1000},
    {"COMPONENT_AT_SC_BARREL_02", "Barrel Attachment 2", 1000},
    {"COMPONENT_AT_AR_BARREL_01", "Barrel Attachment 1", 1000},
    {"COMPONENT_AT_SB_BARREL_01", "Barrel Attachment 1", 1000},
    {"COMPONENT_AT_CR_BARREL_01", "Barrel Attachment 1", 1000},
    {"COMPONENT_AT_MG_BARREL_01", "Barrel Attachment 1", 1000},
    {"COMPONENT_AT_MG_BARREL_02", "Barrel Attachment 2", 1000},
    {"COMPONENT_AT_CR_BARREL_02", "Barrel Attachment 2", 1000},
    {"COMPONENT_AT_SR_BARREL_02", "Barrel Attachment 2", 1000},
    {"COMPONENT_AT_SB_BARREL_02", "Barrel Attachment 2", 1000},
    {"COMPONENT_AT_AR_BARREL_02", "Barrel Attachment 2", 1000},
    {"COMPONENT_AT_MUZZLE_01", "Muzzle Attachment 1", 1000},
    {"COMPONENT_AT_MUZZLE_02", "Muzzle Attachment 2", 1000},
    {"COMPONENT_AT_MUZZLE_03", "Muzzle Attachment 3", 1000},
    {"COMPONENT_AT_MUZZLE_04", "Muzzle Attachment 4", 1000},
    {"COMPONENT_AT_MUZZLE_05", "Muzzle Attachment 5", 1000},
    {"COMPONENT_AT_MUZZLE_06", "Muzzle Attachment 6", 1000},
    {"COMPONENT_AT_MUZZLE_07", "Muzzle Attachment 7", 1000},
    {"COMPONENT_AT_AR_AFGRIP", "Grip", 1000},
    {"COMPONENT_AT_AR_AFGRIP_02", "Grip", 1000},
    {"COMPONENT_AT_PI_RAIL", "Holographic Sight", 1000},
    {"COMPONENT_AT_SCOPE_MACRO_MK2", "Holographic Sight", 1000},
    {"COMPONENT_AT_PI_RAIL_02", "Holographic Sight", 1000},
    {"COMPONENT_AT_SIGHTS_SMG", "Holographic Sight", 1000},
    {"COMPONENT_AT_SIGHTS", "Holographic Sight", 1000},
    {"COMPONENT_AT_SCOPE_SMALL", "Scope Small", 1000},
    {"COMPONENT_AT_SCOPE_SMALL_02", "Scope Small", 1000},
    {"COMPONENT_AT_SCOPE_MACRO_02", "Scope", 1000},
    {"COMPONENT_AT_SCOPE_SMALL_02", "Scope", 1000},
    {"COMPONENT_AT_SCOPE_MACRO", "Scope", 1000},
    {"COMPONENT_AT_SCOPE_MEDIUM", "Scope", 1000},
    {"COMPONENT_AT_SCOPE_LARGE", "Scope", 1000},
    {"COMPONENT_AT_SCOPE_SMALL", "Scope", 1000},
    {"COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2", "2x Scope", 1000},
    {"COMPONENT_AT_SCOPE_SMALL_MK2", "2x Scope", 1000},
    {"COMPONENT_AT_SCOPE_SMALL_SMG_MK2", "4x Scope", 1000},
    {"COMPONENT_AT_SCOPE_MEDIUM_MK2", "4x Scope", 1000},
    {"COMPONENT_AT_SCOPE_MAX", "Advanced Scope", 1000},
    {"COMPONENT_AT_SCOPE_LARGE", "Scope Large", 1000},
    {"COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2", "Scope Large", 1000},
    {"COMPONENT_AT_SCOPE_LARGE_MK2", "8x Scope", 1000},
    {"COMPONENT_AT_SCOPE_NV", "Nightvision Scope", 1000},
    {"COMPONENT_AT_SCOPE_THERMAL", "Thermal Scope", 1000},
    --{ "COMPONENT_KNUCKLE_VARMOD_PLAYER", "Default Skin",1000},
    {"COMPONENT_KNUCKLE_VARMOD_LOVE", "Love Skin", 1000},
    {"COMPONENT_KNUCKLE_VARMOD_DOLLAR", "Dollar Skin", 1000},
    {"COMPONENT_KNUCKLE_VARMOD_VAGOS", "Vagos Skin", 1000},
    {"COMPONENT_KNUCKLE_VARMOD_HATE", "Hate Skin", 1000},
    {"COMPONENT_KNUCKLE_VARMOD_DIAMOND", "Diamond Skin", 1000},
    {"COMPONENT_KNUCKLE_VARMOD_PIMP", "Pimp Skin", 1000},
    {"COMPONENT_KNUCKLE_VARMOD_KING", "King Skin", 1000},
    {"COMPONENT_KNUCKLE_VARMOD_BALLAS", "Ballas Skin", 1000},
    {"COMPONENT_KNUCKLE_VARMOD_BASE", "Base Skin", 1000},
    {"COMPONENT_SWITCHBLADE_VARMOD_VAR1", "Default Skin", 1000},
    {"COMPONENT_SWITCHBLADE_VARMOD_VAR2", "Variant 2 Skin", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_PUMPSHOTGUN_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_REVOLVER_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_SMG_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO", "Camo 1", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_SMG_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO_02", "Camo 2", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_SMG_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO_03", "Camo 3", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_SMG_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO_04", "Camo 4", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_SMG_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO_05", "Camo 5", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_SMG_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO_06", "Camo 6", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_SMG_MK2_CAMO_07", "Camo 7", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_SMG_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO_08", "Camo 8", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_SMG_MK2_CAMO_09", "Camo 9", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_SMG_MK2_CAMO_10", "Camo 10", 1000},
    {"COMPONENT_PISTOL_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_SMG_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_COMBATMG_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01", "American Camo", 1000},
    {"COMPONENT_SNSPISTOL_MK2_CAMO_IND_01", "American Camo", 1000}
}

local restrictedJob = {'police', 'lssd', 'usms', 'gouv', 'doj'}
local ep1 = false
local Indexes2 = {}
local Open = function()
    RageUI.Visible(RMenu:Get("ammunation", "main"), true)
    playerPed = LocalPlayer().Ped
    for i = 0, GetNumberOfPedDrawableVariations(playerPed, 9) - 1, 1 do
        Indexes2[i] = 1
    end
end

local OpenM = function()
    RageUI.Visible(RMenu:Get("ammunation", "main"), true)
    playerPed = LocalPlayer().Ped
    for i = 0, GetNumberOfPedDrawableVariations(playerPed, 9) - 1, 1 do
        Indexes2[i] = 1
    end
end

local OpenP = function()
    RageUI.Visible(RMenu:Get("ammunation privé", "main private"), true)
    playerPed = LocalPlayer().Ped
    for i = 0, GetNumberOfPedDrawableVariations(playerPed, 9) - 1, 1 do
        Indexes2[i] = 1
    end
end

local kevlarConfig = {
    [1] = {
        status = 50,
        name = "Kevlar anti-riot"
    },
    [2] = {
        status = 50,
        name = "Kevlar"
    },
    [3] = {
        status = 100,
        name = "Kevlar lourd LSSD"
    },
    [4] = {
        status = 50,
        name = "Kevlar detective"
    },
    [5] = {
        status = 50,
        name = "Kevlar sheriff"
    },
    [10] = {
        status = 0,
        name = "Gilet Jaune"
    },
    [12] = {
        status = 100,
        name = "Kevlar SWAT"
    },
    [13] = {
        status = 25,
        name = "Radio"
    },
    [14] = {
        status = 25,
        name = "Radio"
    },
    [15] = {
        status = 25,
        name = "Radio"
    },
    [16] = {
        status = 75,
        name = "Metro"
    },
    [17] = {
        status = 50,
        name = "Sous pull kevlar"
    },
    [18] = {
        status = 50,
        name = "Kevlar LSPD / LSSD"
    },
    [19] = {
        status = 0,
        name = "Radio SAMS"
    },
    [21] = {
        status = 0,
        name = "Carte"
    },
    [22] = {
        status = 0,
        name = "Badge"
    },
    [23] = {
        status = 75,
        name = "Metro"
    },
    [24] = {
        status = 0,
        name = "Badge"
    },
    [25] = {
        status = 25,
        name = "Gilet de sauvetage"
    },
    [26] = {
        status = 25,
        name = "Sous pull"
    },
    [28] = {
        status = 25,
        name = "Sous pull 2"
    },
    [29] = {
        status = 100,
        name = "SRT LSSD"
    },
    [30] = {
        status = 0,
        name = "Rien"
    },
    [31] = {
        status = 0,
        name = "Rien"
    },
    [32] = {
        status = 0,
        name = "Rien"
    },
    [33] = {
        status = 0,
        name = "Rien"
    },
    [34] = {
        status = 0,
        name = "Rien"
    },
    [35] = {
        status = 0,
        name = "Rien"
    },
    [36] = {
        status = 0,
        name = "Rien"
    },
    [37] = {
        status = 25,
        name = "Radio"
    },
    [38] = {
        status = 0,
        name = "Rien"
    },
    [39] = {
        status = 0,
        name = "Rien"
    },
    [40] = {
        status = 50,
        name = "Rien"
    },
    [41] = {
        status = 0,
        name = "Rien"
    },
    [42] = {
        status = 0,
        name = "Badge"
    },
    [43] = {
        status = 100,
        name = "Kevlar FIB"
    },
    [44] = {
        status = 100,
        name = "Rien"
    },
    [45] = {
        status = 50,
        name = "Kevlar police"
    },
    [46] = {
        status = 50,
        name = "Kevlar FIB"
    },
    [47] = {
        status = 0,
        name = "Rien"
    },
    [48] = {
        status = 0,
        name = "Rien"
    },
    [49] = {
        status = 0,
        name = "Rien"
    },
    [50] = {
        status = 0,
        name = "Rien"
    },
    [51] = {
        status = 0,
        name = "Rien"
    },
    [52] = {
        status = 0,
        name = "Rien"
    },
    [53] = {
        status = 100,
        name = "Kevlar lourd LSPD"
    },
    [55] = {
        status = 0,
        name = "Carte FIB"
    },
}

local weapon_config = {
    Pos = {x = 250.45, y = -45.27, z = 68.94},
    Ped = {
        Pos = {x = 250.45, y = -45.27, z = 68.94, a = 146.59},
        model = "s_m_y_ammucity_01",
        name = "Freddy"
    },
    Blips = {
        sprite = 313,
        color = 1,
        name = "Armurerie - Accessoires d'armes"
    },
    EnterZone = function()
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
        KeySettings:Add("keyboard", "E", Open, "Ammu")
        KeySettings:Add("controller", 46, Open, "Ammu")
    end,
    ExitZone = function()
        KeySettings:Clear("keyboard", "E", "Ammu")
        KeySettings:Clear("controller", 46, "Ammu")
        Hint:RemoveAll()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
    end
}

local private_conf = {
    Pos = {x = 250.1571, y = -51.6418, z = 68.9411, a = 23.3754},
    Ped = {
        Pos = {x = 250.1571, y = -51.6418, z = 68.9411, a = 23.3754},
        model = "s_m_y_ammucity_01",
        name = "Bébèrt"
    },
    EnterZone = function()
        local isAuth = false
        for i=1, #restrictedJob do
            if restrictedJob[i] == Atlantiss.Identity.Job:GetName() then isAuth = true end
            if restrictedJob[i] == Atlantiss.Identity.Orga:GetName() then isAuth = true end
        end
        if isAuth then
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
            KeySettings:Add("keyboard", "E", OpenP, "Ammu")
            KeySettings:Add("controller", 46, OpenP, "Ammu")
        end
    end,
    ExitZone = function()
        KeySettings:Clear("keyboard", "E", "Ammu")
        KeySettings:Clear("controller", 46, "Ammu")
        Hint:RemoveAll()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
    end
}

local private_conf_paleto = {
    Pos = {x = -327.81, y = 6084.39, z = 30.45, a = 182.79},
    Ped = {
        Pos = {x = -327.81, y = 6084.39, z = 30.45, a = 182.79},
        model = "s_m_y_ammucity_01",
        name = "Smith"
    },
    EnterZone = function()
        local isAuth = false
        for i=1, #restrictedJob do
            if restrictedJob[i] == Atlantiss.Identity.Job:GetName() then isAuth = true end
            if restrictedJob[i] == Atlantiss.Identity.Orga:GetName() then isAuth = true end
        end
        if isAuth then
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
            KeySettings:Add("keyboard", "E", OpenP, "Ammu")
            KeySettings:Add("controller", 46, OpenP, "Ammu")
        end
    end,
    ExitZone = function()
        KeySettings:Clear("keyboard", "E", "Ammu")
        KeySettings:Clear("controller", 46, "Ammu")
        Hint:RemoveAll()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
    end
}


local private_arme = {
    Pos = {x = 254.0569, y = -50.17169, z = 68.9410629, a = 70.3039016},
    Ped = {
        Pos = {x = 254.0569, y = -50.17169, z = 68.9410629, a = 70.3039016},
        model = "s_m_y_ammucity_01",
        name = "Matthieu"
    },
    EnterZone = function()
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
        KeySettings:Add("keyboard", "E", Open, "Ammu")
        KeySettings:Add("controller", 46, Open, "Ammu")
    end,
    ExitZone = function()
        KeySettings:Clear("keyboard", "E", "Ammu")
        KeySettings:Clear("controller", 46, "Ammu")
        Hint:RemoveAll()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
    end
}

local globalWeaponTable = {
    blanc = {
        -- {"WEAPON_KNUCKLE", "Poing Americain", 300},
        -- {"WEAPON_HAMMER", "Marteau", 250},
        -- {"WEAPON_BAT", "Batte", 300},
        -- {"WEAPON_CROWBAR", "Pied de biche", 400}
    },
    pistol = {}
}
local munition_index = 1
local function build()
    v = weapon_config
    k = private_conf
    y = private_conf_paleto
    x = private_arme
    if not v.Hidden then
        local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
        SetBlipSprite(blip, v.Blips.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, v.Blips.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Blips.name)
        EndTextCommandSetBlipName(blip)
    end
    Zone:Add(v.Pos, v.EnterZone, v.ExitZone, i, 2.5)
    Ped:Add(v.Ped.name, v.Ped.model, v.Ped.Pos, nil)
    RMenu.Add(
        "ammunation",
        "main",
        RageUI.CreateMenu(nil, "Catégories disponibles", 10, 100, "shopui_title_gunclub", "shopui_title_gunclub")
    )
    RMenu.Add(
        "ammunation",
        "weapons",
        RageUI.CreateSubMenu(
            RMenu:Get("ammunation", "main"),
            nil,
            "Armes disponibles",
            10,
            100,
            "shopui_title_gunclub",
            "shopui_title_gunclub"
        )
    )
    RMenu.Add(
        "ammunation",
        "blanches",
        RageUI.CreateSubMenu(
            RMenu:Get("ammunation", "main"),
            nil,
            "Armes blanches disponibles",
            10,
            100,
            "shopui_title_gunclub",
            "shopui_title_gunclub"
        )
    )
    -- RMenu.Add('ammunation', "munitions", RageUI.CreateSubMenu(RMenu:Get('ammunation', "main"), nil, "Munitions disponibles",10,100,"shopui_title_gunclub","shopui_title_gunclub"))
    RMenu.Add(
        "ammunation",
        "my_weap",
        RageUI.CreateSubMenu(
            RMenu:Get("ammunation", "main"),
            nil,
            "Armes disponibles",
            10,
            100,
            "shopui_title_gunclub",
            "shopui_title_gunclub"
        )
    )

    RMenu.Add(
        "ammunation",
        "my_weap_1",
        RageUI.CreateSubMenu(
            RMenu:Get("ammunation", "my_weap"),
            nil,
            "Options disponibles",
            10,
            100,
            "shopui_title_gunclub",
            "shopui_title_gunclub"
        )
    )

    -- Private menu

    Zone:Add(k.Pos, k.EnterZone, k.ExitZone, i, 2.5)
    Ped:Add(k.Ped.name, k.Ped.model, k.Ped.Pos, nil)
    RMenu.Add(
        "ammunation privé",
        "main private",
        RageUI.CreateMenu(nil, "Catégories disponibles", 10, 100, "shopui_title_gunclub", "shopui_title_gunclub")
    )

    RMenu.Add(
        "ammunation privé",
        "kevlars",
        RageUI.CreateSubMenu(
            RMenu:Get("ammunation privé", "main private"),
            nil,
            "Kevlars disponibles",
            10,
            100,
            "shopui_title_gunclub",
            "shopui_title_gunclub"
        )
    )

    
    Zone:Add(y.Pos, y.EnterZone, y.ExitZone, i, 2.5)
    Ped:Add(y.Ped.name, y.Ped.model, y.Ped.Pos, nil)
    RMenu.Add(
        "ammunation privé",
        "main private",
        RageUI.CreateMenu(nil, "Catégories disponibles", 10, 100, "shopui_title_gunclub", "shopui_title_gunclub")
    )

    RMenu.Add(
        "ammunation privé",
        "kevlars",
        RageUI.CreateSubMenu(
            RMenu:Get("ammunation privé", "main private"),
            nil,
            "Kevlars disponibles",
            10,
            100,
            "shopui_title_gunclub",
            "shopui_title_gunclub"
        )
    )

    RMenu:Get("ammunation privé", "kevlars").Closed = function()
        SetPedComponentVariation(LocalPlayer().Ped, 9, 0, 0, 2)
    end
end

build()
function indexOf(t, object)
    if type(t) ~= "table" then
        error("table expected, got " .. type(t), 2)
    end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end
local xp = {}
local price = 0
local amount_index = 1
local munition_type = {"9mm", ".45", ".12", "7.62", "5.56"}
local munition_name = {"mm9", "acp45", "calibre12", "akm", "cab"}
local myweapIn = nil
local Indexes = 1
local inv_index = 1
local inv_name = nil
function GetAltPropVariationData(ped, propIndex)
    local prop = GetPedPropIndex(ped, propIndex)

    local propTexture = GetPedPropTextureIndex(ped, propIndex)

    local propHashName =
        GetHashNameForProp(
        LocalPlayer().Ped,
        0,
        GetPedPropIndex(LocalPlayer().Ped, 0),
        GetPedPropTextureIndex(LocalPlayer().Ped, 0)
    )

    local someHash = 0
    local unk1 = 0
    local unk2 = 0

    local maxVariations = GetShopPedApparelVariantPropCount(propHashName)
    _AltPropVariationData = {}

    if (maxVariations > 0) then
        items = {}
        for i = 1, maxVariations, 1 do
            UnsafeAltPropVariationData = {}

            unk1, unk2 = GetVariantProp(propHashName, i)

            --print(GetShopPedProp(someHash, nil));

            items[i] = {
                unkHash1,
                unkHash2,
                unkInt1,
                altPropIndex,
                altPropTextureIndex,
                unkInt2,
                someHash,
                altPropVariationIndex = unk1,
                altPropVariationTexture = unk2
            }
            return items
        end
    end
    return nil
end

RMenu:Get("ammunation", "main").Closed = function()
    if DoesEntityExist(wObj) then
        DeleteEntity(wObj)
    end
end

Citizen.CreateThread(
    function()
        Wait(500)
        while true do
            Wait(1)
            ----print(GetEntityAnimCurrentTime(LocalPlayer().Ped, animstring, a))
            --if GetShopPedApparelVariantPropCount(GetHashNameForProp(LocalPlayer().Ped,0,GetPedPropIndex(LocalPlayer().Ped, 0),GetPedPropTextureIndex(LocalPlayer().Ped,0))) >0  then
            --if IsControlJustPressed(0, Keys["E"]) then
            --end
            --end
            if RageUI.Visible(RMenu:Get("ammunation", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        --[[ RageUI.Button(
                            "Armes",
                            nil,
                            {},
                            true,
                            function()
                            end,
                            RMenu:Get("ammunation", "weapons")
                        )
                        RageUI.Button(
                            "Armes blanches",
                            nil,
                            {},
                            true,
                            function()
                            end,
                            RMenu:Get("ammunation", "blanches")
                        ) ]]
                        -- RageUI.Button("Munitions",nil,{},true,function() end,RMenu:Get('ammunation', "munitions"))
                        RageUI.Button(
                            "Mes armes",
                            nil,
                            {},
                            true,
                            function()
                            end,
                            RMenu:Get("ammunation", "my_weap")
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("ammunation privé", "main private")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Kevlars",
                            nil,
                            {},
                            true,
                            function()
                            end,
                            RMenu:Get("ammunation privé", "kevlars")
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("ammunation", "my_weap_1")) then
                local CurrentWeapon = myweapIn
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Faire apparaitre une réplique de l'arme",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    TriggerEvent('atlantiss:inventory:deleteIfWeapon', CurrentWeapon)
                                    if DoesEntityExist(wObj) then
                                        DeleteEntity(wObj)
                                    end
                                    local model = GetHashKey(weapon_name[myweapIn.name])
                                    RequestWeaponAsset(model, 31, 0)
                                    while not HasWeaponAssetLoaded(model) do
                                        RequestWeaponAsset(model, 31, 0)
                                        Wait(100)
                                    end
                                    wObj = CreateWeaponObject(model, 0, 249.740, -45.90, 70.30, false, 1.0, false)
                                end
                            end
                        )
                        RageUI.List(
                            "Teinture",
                            mk1,
                            Indexes,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                Indexes = Index
                                if Active then
                                    if DoesEntityExist(wObj) then
                                        SetWeaponObjectTintIndex(wObj, Indexes - 1)
                                    end
                                end
                                if Selected then
                                    TriggerEvent('atlantiss:inventory:deleteIfWeapon', CurrentWeapon)
                                    if DoesEntityExist(wObj) then
                                        DeleteObject(wObj)
                                    end
                                    playerPed = LocalPlayer().Ped
                                    dataonWait = {
                                        title = "Achat teinture arme",
                                        price = mk1price[Index],
                                        fct = function()
                                            RageUI.Popup(
                                                {
                                                    message = "Vous avez appliqué la teinture ~b~" ..
                                                        mk1[Indexes] .. " ~s~à votre arme"
                                                }
                                            )
                                            CurrentWeapon.data["tint"] = Index - 1
                                            Atlantiss.Inventory.Data[inv_name][inv_index].data = CurrentWeapon.data
                                            --TriggerServerEvent("inventory:editData",CurrentWeapon.id,CurrentWeapon.data)
                                            if
                                                HasPedGotWeapon(
                                                    playerPed,
                                                    GetHashKey(weapon_name[CurrentWeapon.name]),
                                                    false
                                                )
                                            then
                                                SetPedWeaponTintIndex(
                                                    playerPed,
                                                    GetHashKey(weapon_name[CurrentWeapon.name]),
                                                    Index - 1
                                                )
                                            end
                                        end
                                    }
                                    CloseAllMenus()
                                    TriggerEvent("payWith?")
                                end
                            end
                        )
                        for k, attachmentObject in ipairs(globalAttachmentTable) do
                            ----dump(attachmentObject))

                            if DoesWeaponTakeWeaponComponent(weapon_name[CurrentWeapon.name], attachmentObject[1]) then
                                data = myweapIn.data
                                if data.access ~= nil then
                                    if indexOf(data.access, attachmentObject[1]) then
                                        xp[k] = RageUI.BadgeStyle.Gun
                                    end
                                end
                                RageUI.Button(
                                    attachmentObject[2],
                                    nil,
                                    {
                                        LeftBadge = xp[k],
                                        RightLabel = attachmentObject[3] .. "$"
                                    },
                                    true,
                                    function(Hovered, Active, Selected)
                                        if Active then
                                            if DoesEntityExist(wObj) then
                                                if not HasWeaponGotWeaponComponent(wObj, attachmentObject[1]) then
                                                    RequestModel(GetWeaponComponentTypeModel(attachmentObject[1]))
                                                    while not HasModelLoaded(
                                                        GetWeaponComponentTypeModel(attachmentObject[1])
                                                    ) do
                                                        RequestModel(GetWeaponComponentTypeModel(attachmentObject[1]))
                                                        Wait(100)
                                                    end
                                                    GiveWeaponComponentToWeaponObject(wObj, attachmentObject[1])
                                                end
                                            end
                                        end
                                        if Selected then
                                            TriggerEvent('atlantiss:inventory:deleteIfWeapon', CurrentWeapon)
                                            if DoesEntityExist(wObj) then
                                                DeleteObject(wObj)
                                            end
                                            dataonWait = {
                                                title = "Achat accessoire d'arme",
                                                price = attachmentObject[3],
                                                fct = function()
                                                    xp[k] = RageUI.BadgeStyle.Gun
                                                    if CurrentWeapon.data["access"] == nil then
                                                        CurrentWeapon.data["access"] = {}
                                                    end
                                                    table.insert(CurrentWeapon.data["access"], attachmentObject[1])
                                                    Atlantiss.Inventory.Data[inv_name][inv_index].data = CurrentWeapon.data
                                                    --TriggerServerEvent("inventory:editData",CurrentWeapon.id,CurrentWeapon.data)

                                                    if
                                                        HasPedGotWeapon(
                                                            playerPed,
                                                            GetHashKey(weapon_name[CurrentWeapon.name]),
                                                            false
                                                        )
                                                     then
                                                        GiveWeaponComponentToPed(
                                                            playerPed,
                                                            GetHashKey(weapon_name[CurrentWeapon.name]),
                                                            GetHashKey(attachmentObject[1])
                                                        )
                                                    end
                                                end
                                            }
                                            CloseAllMenus()
                                            TriggerEvent("payWith?")
                                        end
                                    end
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("ammunation", "my_weap")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(Atlantiss.Inventory.Data) do
                            if Items[k] then
                                if Items[k].category == "weapon" then
                                    for i = 1, #v, 1 do
                                        if v[i].data == nil then
                                            v[i].data = {}
                                        end
                                        
                                        if type(v[i].data) == "string" then
                                            v[i].data = json.decode(v[i].data) 
                                        end

                                        if v[i].data.serial == nil then
                                            v[i].data.serial = "UNDEFINED"
                                        end
                                        RageUI.Button(
                                            Items[k].label,
                                            nil,
                                            {RightLabel = "#" .. v[i].data.serial},
                                            true,
                                            function(_, _, Selected)
                                                if Selected then
                                                    myweapIn = v[i]
                                                    inv_index = i
                                                    inv_name = k
                                                end
                                            end,
                                            RMenu:Get("ammunation", "my_weap_1")
                                        )
                                    end
                                end
                            end
                        end
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("ammunation", "weapons")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for i = 1, #globalWeaponTable.pistol, 1 do
                            local c = globalWeaponTable.pistol[i]
                            RageUI.Button(
                                c[2],
                                nil,
                                {RightLabel = c[3] .. "$"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        for m1, m3 in pairs(weapon_name) do
                                            if m3 == c[1] then
                                                local receive = Atlantiss.Inventory:CanReceive(m1, 1)
                                                if receive then
                                                    dataonWait = {
                                                        title = "Achat arme à feu",
                                                        price = c[3],
                                                        fct = function()
                                                            local data = {serial = math.random(111111111, 999999999)}
                                                            items = {name = m1, data = data}
                                                            Atlantiss.Inventory:AddItem(items)
                                                            TriggerServerEvent("BuyNewWeapon", data, Items[m1].label)
                                                        end
                                                    }
                                                    CloseAllMenus()
                                                    TriggerEvent("payWith?")
                                                end
                                                break
                                            end
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("ammunation", "blanches")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for i = 1, #globalWeaponTable.blanc, 1 do
                            local c = globalWeaponTable.blanc[i]
                            RageUI.Button(
                                c[2],
                                nil,
                                {RightLabel = c[3] .. "$"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerServerCallback(
                                            "getArmeblanched",
                                            function(Data)
                                                if Data then
                                                    for m1, m3 in pairs(weapon_name) do
                                                        if m3 == c[1] then
                                                            local receive = Atlantiss.Inventory:CanReceive(m1, 1)
                                                            if receive then
                                                                dataonWait = {
                                                                    title = "Achat arme blanche",
                                                                    price = c[3],
                                                                    fct = function()
                                                                        for m1, m3 in pairs(weapon_name) do
                                                                            local receive = Atlantiss.Inventory:CanReceive(m1, 1)
                                                                            if m3 == c[1] and receive then
                                                                                local data = {
                                                                                    serial = math.random(111111111, 999999999)
                                                                                }
                                                                                items = {name = m1, data = data}
                                                                                Atlantiss.Inventory:AddItem(items)
                                                                                TriggerServerEvent(
                                                                                    "BuyNewWeapon",
                                                                                    data,
                                                                                    Items[m1].label
                                                                                )
                                                                                TriggerServerEvent("ArmeBlanche")

                                                                                break
                                                                            end
                                                                        end
                                                                    end
                                                                }
                                                                CloseAllMenus()
                                                                TriggerEvent("payWith?")
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        )
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("ammunation privé", "kevlars")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        playerPed = LocalPlayer().Ped
                        for i = 1, GetNumberOfPedDrawableVariations(playerPed, 9) - 1, 1 do
                            local amount = {}
                            local ind = i + 1
                            for c = 1, GetNumberOfPedTextureVariations(playerPed, 9, i), 1 do
                                amount[c] = c
                            end

                            if gilItem[ind] == nil then
                                local kevlarName = "Kevlar civil #" .. i
                                if (kevlarConfig[i] ~= nil) then
                                    kevlarName = kevlarConfig[i].name
                                end
                                gilItem[ind] = kevlarName
                            end
                            RageUI.List(
                                gilItem[i + 1],
                                amount,
                                Indexes2[i],
                                "",
                                {RightLabel = "300$"},
                                true,
                                function(Hovered, Active, Selected, Index)
                                    Indexes2[i] = Index
                                    if Active then
                                        SetPedComponentVariation(playerPed, 9, i, Index - 1, 2)
                                    end
                                    if Selected then
                                        local receive = Atlantiss.Inventory:CanReceive("kevlar", 1)
                                        if receive then
                                            local kevlarLevel = 10
                                            local kevlarLabel = "Kevlar"
                                            if (kevlarConfig[i] ~= nil) then
                                                kevlarLevel = kevlarConfig[i].status
                                                kevlarLabel = kevlarConfig[i].name
                                            end
                                            dataonWait = {
                                                title = "Achat Ammunation",
                                                price = 300,
                                                fct = function()
                                                    items = {
                                                        name = "kevlar",
                                                        label = kevlarLabel,
                                                        data = {
                                                            ind = i,
                                                            var = Index - 1,
                                                            serial = math.random(111111111, 999999999),
                                                            status = kevlarLevel
                                                        }
                                                    }
                                                    Atlantiss.Inventory:AddItem(items)
                                                end
                                            }
                                            CloseAllMenus()
                                            TriggerEvent("payWith?")
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("ammunation", "munitions")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RenderText(price .. "$", 1800, 1000, 1, 1.3, 100, 255, 100, 255, 1)
                        amount = {}
                        for i = 0, 1000, 1 do
                            amount[i] = i
                        end
                        RageUI.List(
                            "9mm",
                            munition_type,
                            munition_index,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                munition_index = Index
                            end
                        )
                        RageUI.List(
                            "Combien ?",
                            amount,
                            amount_index,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                if amount_index ~= Index then
                                    amount_index = Index
                                end
                            end
                        )
                        RageUI.Button(
                            "~g~Acheter",
                            nil,
                            {RightLabel = amount_index * 2 .. "$"},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local receive = Atlantiss.Inventory:CanReceive("mm9", amount_index)
                                    if receive then
                                        dataonWait = {
                                            title = "Achat munitions",
                                            price = amount_index * 2,
                                            fct = function()
                                                for i = 1, amount_index, 1 do
                                                    Atlantiss.Inventory:AddItem(munition_name[munition_index])
                                                end
                                                --				TriggerServerEvent("core:buymunition",amount_index,munition_name[munition_index])
                                            end
                                        }
                                        CloseAllMenus()
                                        TriggerEvent("payWith?")
                                    end
                                end
                            end
                        )
                    end,
                    function()
                    end
                )
            end
        end
    end
)
local xp = {}
local CurrentWeapon = nil

local Indexes = 1
local Indexes2 = {}
gilItem = {}
amount = {}
local kx = 20
local price = 0
function indexOf(t, object)
    if type(t) ~= "table" then
        error("table expected, got " .. type(t), 2)
    end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end
local cam = nil
function DeleteAmmunation()
    RenderScriptCams(false, true, 10, true, true)
    SetCamActive(WeaponsFct.currentMenuCamera, false)
    DeleteObject(WeaponsFct.fakeWeaponObject)
    SetPlayerControl(PlayerId(), true)
end
function RemoveWeaponAmmunation()
end
SetPlayerControl(PlayerId(), true)
Citizen.CreateThread(
    function()
        function CreateFakeWeaponObject(weapon, keepOldWeapon)
            local weaponWorldModel = GetWeapontypeModel(weapon)
            RequestModel(weaponWorldModel)
            while not HasModelLoaded(weaponWorldModel) do
                Citizen.Wait(0)
            end

            local interiorID = GetInteriorFromEntity(LocalPlayer().Ped)
            local rotationOffset = 0.0
            local additionalOffset = vec(0, 0, 0)
            local additionalWeaponOffset = vec(0, 0, 0)
            if type(WeaponsFct.interiorIDs[interiorID]) == "table" then
                rotationOffset = WeaponsFct.interiorIDs[interiorID].weaponRotationOffset or 0.0
                additionalOffset = WeaponsFct.interiorIDs[interiorID].additionalOffset or additionalOffset
                additionalWeaponOffset =
                    WeaponsFct.interiorIDs[interiorID].additionalWeaponOffset or additionalWeaponOffset
            end

            local fakeWeaponCoords =
                (GetOffsetFromInteriorInWorldCoords(interiorID, 4.0, 6.25, 2.0) + additionalOffset) +
                additionalWeaponOffset
            local fakeWeapon = CreateWeaponObject(weapon, 1 * 3, fakeWeaponCoords, true, 0.0)
            SetEntityAlpha(fakeWeapon, 0)
            SetEntityHeading(fakeWeapon, (GetCamRot(GetRenderingCam(), 1).z - 180) + rotationOffset)
            SetEntityCoordsNoOffset(fakeWeapon, fakeWeaponCoords)

            if not keepOldWeapon then
                SetEntityAlpha(fakeWeapon, 255)
                if DoesEntityExist(WeaponsFct.fakeWeaponObject) then
                    DeleteObject(WeaponsFct.fakeWeaponObject)
                end
                WeaponsFct.fakeWeaponObject = fakeWeapon
            end

            return fakeWeapon
        end
    end
)

Citizen.CreateThread(
    function()
        function CreateFakeWeaponObject2(weapon, attachments)
            local weaponWorldModel = GetWeapontypeModel(weapon)
            RequestModel(weaponWorldModel)
            while not HasModelLoaded(weaponWorldModel) do
                Citizen.Wait(0)
            end

            local interiorID = GetInteriorFromEntity(LocalPlayer().Ped)
            local rotationOffset = 0.0
            local additionalOffset = vec(0, 0, 0)
            local additionalWeaponOffset = vec(0, 0, 0)
            if type(WeaponsFct.interiorIDs[interiorID]) == "table" then
                rotationOffset = WeaponsFct.interiorIDs[interiorID].weaponRotationOffset or 0.0
                additionalOffset = WeaponsFct.interiorIDs[interiorID].additionalOffset or additionalOffset
                additionalWeaponOffset =
                    WeaponsFct.interiorIDs[interiorID].additionalWeaponOffset or additionalWeaponOffset
            end

            local fakeWeaponCoords =
                (GetOffsetFromInteriorInWorldCoords(interiorID, 4.0, 6.25, 2.0) + additionalOffset) +
                additionalWeaponOffset
            local fakeWeapon = CreateWeaponObject(weapon, 1 * 3, fakeWeaponCoords, true, 0.0)
            SetEntityAlpha(fakeWeapon, 0)
            SetEntityHeading(fakeWeapon, (GetCamRot(GetRenderingCam(), 1).z - 180) + rotationOffset)
            SetEntityCoordsNoOffset(fakeWeapon, fakeWeaponCoords)

            for i, attach in ipairs(attachments) do
                if DoesPlayerWeaponHaveComponent(weapon.model, attach.model) then
                    GiveWeaponComponentToWeaponObject(fakeWeapon, attach.model)
                end
            end

            return fakeWeapon
        end
    end
)
