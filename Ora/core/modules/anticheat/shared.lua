Ora.Anticheat = {}
Ora.Anticheat.GroupsWhitelist = {
  ["superadmin"] = true,
  ["animator"] = true,
  ["user"] = false,
}

Ora.Anticheat.Alert = {
  HEALTH_ALERT = false,
  BLIPS = true
}

Ora.Anticheat.ObjectWhitelist = {
  [`prop_juicestand`] = true,
  [`p_parachute1_sp_dec`] = true,
  [`prop_v_parachute`] = true,
  [`p_parachute1_s`] = true,
  [`p_parachute1_mp_dec`] = true,
  [`p_parachute_s`] = true,
  [`p_parachute1_sp_s`] = true,
  [`p_parachute1_mp_s`] = true,
  [`xm_prop_x17_tool_draw_01a`] = true,
  [974883178] = true,
  [-303457828] = true,
  [1463746489] = true,
  [977923025] = true,
  [1760825203] = true,
  [746336278] = true,
  [1808635348] = true,
  [-1539862408] = true,
  [-2098426548] = true,
  [-1964402432] = true,
  [155046858] = true,
  [1053267296] = true,
  [-1910604593] = true,
  [-1036807324] = true,
  [-1533900808] = true,
  [-154609122] = true,
  [1184113278] = true, -- poolcue
  [1729911864] = true, -- speaker
  [1262298127] = true, -- wheelchair
}

Ora.Anticheat.WeaponBlacklist = {
  [`WEAPON_PISTOL_MK2`] = "WEAPON_PISTOL_MK2",
  [`WEAPON_APPISTOL`] = "WEAPON_APPISTOL",
  [`WEAPON_FLAREGUN`] = "WEAPON_FLAREGUN",
  [`WEAPON_MARKSMANPISTOL`] = "WEAPON_MARKSMANPISTOL",
  [`WEAPON_SMG_MK2`] = "WEAPON_SMG_MK2",
  [`WEAPON_ASSAULTSMG`] = "WEAPON_ASSAULTSMG",
  [`WEAPON_MG`] = "WEAPON_MG",
  [`WEAPON_COMBATMG`] = "WEAPON_COMBATMG",
  [`WEAPON_COMBATMG_MK2`] = "WEAPON_COMBATMG_MK2",
  [`WEAPON_COMBATPDW`] = "WEAPON_COMBATPDW",
  [`WEAPON_GUSENBERG`] = "WEAPON_GUSENBERG",
  [`WEAPON_ASSAULTRIFLE_MK2`] = "WEAPON_ASSAULTRIFLE_MK2",
  [`WEAPON_CARBINERIFLE_MK2`] = "WEAPON_CARBINERIFLE_MK2",
  [`WEAPON_ADVANCEDRIFLE`] = "WEAPON_ADVANCEDRIFLE",
  [`WEAPON_SPECIALCARBINE`] = "WEAPON_SPECIALCARBINE",
  [`WEAPON_BULLPUPRIFLE`] = "WEAPON_BULLPUPRIFLE",
  [`WEAPON_COMPACTRIFLE`] = "WEAPON_COMPACTRIFLE",
  [`WEAPON_SWEEPERSHOTGUN`] = "WEAPON_SWEEPERSHOTGUN",
  [`WEAPON_ASSAULTSHOTGUN`] = "WEAPON_ASSAULTSHOTGUN",
  [`WEAPON_HEAVYSHOTGUN`] = "WEAPON_HEAVYSHOTGUN",
  [`WEAPON_HEAVYSNIPER_MK2`] = "WEAPON_HEAVYSNIPER_MK2",
  [`WEAPON_MARKSMANRIFLE`] = "WEAPON_MARKSMANRIFLE",
  [`WEAPON_RPG`] = "WEAPON_RPG",
  [`WEAPON_MINIGUN`] = "WEAPON_MINIGUN",
  [`WEAPON_FIREWORK`] = "WEAPON_FIREWORK",
  [`WEAPON_RAILGUN`] = "WEAPON_RAILGUN",
  [`WEAPON_HOMINGLAUNCHER`] = "WEAPON_HOMINGLAUNCHER",
  [`WEAPON_GRENADE`] = "WEAPON_GRENADE",
  [`WEAPON_STICKYBOMB`] = "WEAPON_STICKYBOMB",
  [`WEAPON_COMPACTLAUNCHER`] = "WEAPON_COMPACTLAUNCHER",
  [`WEAPON_SNSPISTOL_MK2`] = "WEAPON_SNSPISTOL_MK2",
  [`WEAPON_REVOLVER_MK2`] = "WEAPON_REVOLVER_MK2",
  [`WEAPON_DOUBLEACTION`] = "WEAPON_DOUBLEACTION",
  [`WEAPON_SPECIALCARBINE_MK2`] = "WEAPON_SPECIALCARBINE_MK2",
  [`WEAPON_BULLPUPRIFLE_MK2`] = "WEAPON_BULLPUPRIFLE_MK2",
  [`WEAPON_PUMPSHOTGUN_MK2`] = "WEAPON_PUMPSHOTGUN_MK2",
  [`WEAPON_MARKSMANRIFLE_MK2`] = "WEAPON_MARKSMANRIFLE_MK2",
  [`WEAPON_RAYPISTOL`] = "WEAPON_RAYPISTOL",
  [`WEAPON_RAYCARBINE`] = "WEAPON_RAYCARBINE",
  [`WEAPON_RAYMINIGUN`] = "WEAPON_RAYMINIGUN",
  [`WEAPON_NAVYREVOLVER`] = "WEAPON_NAVYREVOLVER",
  [`WEAPON_CERAMICPISTOL`] = "WEAPON_CERAMICPISTOL"
}

function Ora.Anticheat:IsAnticheatWhitelist()
  local myGroup = Ora.Identity:GetMyGroup()
  if (self.GroupsWhitelist[myGroup] ~= nil) then
    return self.GroupsWhitelist[myGroup]
  end

  return false
end

function Ora.Anticheat:GetModuleName()
  return "Anticheat"
end

function Ora.Anticheat:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Anticheat:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.Anticheat:GetModuleName())


Ora.Anticheat.DisabledExplosion = {7, 9, 31}

Ora.Anticheat.ServerSideDisabledVehicles = {
  LIST = {},
  HAS_BEEN_POPULATED = false
}

Ora.Anticheat.NoRandomSpawnVehicle = {
    `SHAMAL`, -- They spawn on LSIA and try to take off
    `LUXOR`, -- They spawn on LSIA and try to take off
    `LUXOR2`, -- They spawn on LSIA and try to take off
    `JET`, -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
    `LAZER`, -- They spawn on Zancudo and try to take off
    `TITAN`, -- They spawn on Zancudo and try to take off
    `BARRACKS`, -- Regularily driving around the Zancudo airport surface
    `BARRACKS2`, -- Regularily driving around the Zancudo airport surface
    `CRUSADER`, -- Regularily driving around the Zancudo airport surface
    `RHINO`, -- Regularily driving around the Zancudo airport surface
    `AIRTUG`, -- Regularily spawns on the LSsIA airport surface
    `RIPLEY`, -- Regularily spawns on the LSIA airport surface
    `PHANTOM`,
    `HAULER`,
    `RUBBLE`,
    `POLMAV`,
    `BIFF`,
    `TACO`,
    `PACKER`,
    `TRAILERS`,
    `TRAILERS2`,
    `TRAILERS3`,
    `TRAILERS4`,
    `CERBERUS3`,
    `CERBERUS2`,
    `CERBERUS`,
    `BLIMP`,
    `BLIMP2`,
    `BLIMP3`,
    `MOGUL`,
    `CUBAN800`,
    `MICROLIGHT`,
    `DUSTER`,
    `AKULA`,
    `ANNIHILATOR`,
    `BUZZARD`,
    `BUZZARD2`,
    `CARGOBOB`,
    `CARGOBOB2`,
    `CARGOBOB3`,
    `CARGOBOB4`,
    `FROGGER`,
    `FROGGER2`,
    `HAVOK`,
    `HUNTER`,
    `MAVERICK`,
    `SAVAGE`,
    `SEASPARROW`,
    `SKYLIFT`,
    `SUPERVOLITO`,
    `SUPERVOLITO2`,
    `SWIFT`,
    `SWIFT2`,
    `VALKYRIE`,
    `VOLATUS`,
    `VALKYRIE2`,
    `ALPHAZ1`,
    `AVENGER`,
    `AVENGER2`,
    `BESRA`,
    `BOMBUSHKA`,
    `CARGOPLANE`,
    `CUBAN800`,
    `DODO`,
    `DUSTER`,
    `HYDRA`,
    `JET`,
    `MAMMATUS`,
    `MICROLIGHT`,
    `MILJET`,
    `MOGUL`,
    `MOLOTOK`,
    `NIMBUS`,
    `NOKOTA`,
    `PYRO`,
    `ROGUE`,
    `SEABREEZE`,
    `SHAMAL`,
    `STARLING`,
    `STRIKEFORCE`,
    `STUNT`,
    `TITAN`,
    `TULA`,
    `VELUM`,
    `VELUM2`,
    `VESTRA`,
    `DUMP`
}


Ora.Anticheat.HashToName = {
  [`dinghy`] = "dinghy",
  [`dinghy2`] = "dinghy2",
  [`dinghy3`] = "dinghy3",
  [`dinghy4`] = "dinghy4",
  [`jetmax`] = "jetmax",
  [`marquis`] = "marquis",
  [`seashark`] = "seashark",
  [`seashark2`] = "seashark2",
  [`seashark3`] = "seashark3",
  [`speeder`] = "speeder",
  [`speeder2`] = "speeder2",
  [`squalo`] = "squalo",
  [`submersible`] = "submersible",
  [`submersible2`] = "submersible2",
  [`suntrap`] = "suntrap",
  [`toro`] = "toro",
  [`toro2`] = "toro2",
  [`tropic`] = "tropic",
  [`tropic2`] = "tropic2",
  [`tug`] = "tug",
  [`avisa`] = "avisa",
  [`dinghy5`] = "dinghy5",
  [`kosatka`] = "kosatka",
  [`longfin`] = "longfin",
  [`patrolboat`] = "patrolboat",
  [`benson`] = "benson",
  [`biff`] = "biff",
  [`cerberus`] = "cerberus",
  [`cerberus2`] = "cerberus2",
  [`cerberus3`] = "cerberus3",
  [`hauler`] = "hauler",
  [`hauler2`] = "hauler2",
  [`mule`] = "mule",
  [`mule2`] = "mule2",
  [`mule3`] = "mule3",
  [`mule4`] = "mule4",
  [`packer`] = "packer",
  [`phantom`] = "phantom",
  [`phantom2`] = "phantom2",
  [`phantom3`] = "phantom3",
  [`pounder`] = "pounder",
  [`pounder2`] = "pounder2",
  [`stockade`] = "stockade",
  [`stockade3`] = "stockade3",
  [`terbyte`] = "terbyte",
  [`asbo`] = "asbo",
  [`blista`] = "blista",
  [`brioso`] = "brioso",
  [`club`] = "club",
  [`dilettante`] = "dilettante",
  [`dilettante2`] = "dilettante2",
  [`kanjo`] = "kanjo",
  [`issi2`] = "issi2",
  [`issi3`] = "issi3",
  [`issi4`] = "issi4",
  [`issi5`] = "issi5",
  [`issi6`] = "issi6",
  [`panto`] = "panto",
  [`prairie`] = "prairie",
  [`rhapsody`] = "rhapsody",
  [`brioso2`] = "brioso2",
  [`weevil`] = "weevil",
  [`cogcabrio`] = "cogcabrio",
  [`exemplar`] = "exemplar",
  [`f620`] = "f620",
  [`felon`] = "felon",
  [`felon2`] = "felon2",
  [`jackal`] = "jackal",
  [`oracle`] = "oracle",
  [`oracle2`] = "oracle2",
  [`sentinel`] = "sentinel",
  [`sentinel2`] = "sentinel2",
  [`windsor`] = "windsor",
  [`windsor2`] = "windsor2",
  [`zion`] = "zion",
  [`zion2`] = "zion2",
  [`bmx`] = "bmx",
  [`cruiser`] = "cruiser",
  [`fixter`] = "fixter",
  [`scorcher`] = "scorcher",
  [`tribike`] = "tribike",
  [`tribike2`] = "tribike2",
  [`tribike3`] = "tribike3",
  [`ambulance`] = "ambulance",
  [`fbi`] = "fbi",
  [`fbi2`] = "fbi2",
  [`firetruk`] = "firetruk",
  [`lguard`] = "lguard",
  [`pbus`] = "pbus",
  [`police`] = "police",
  [`police2`] = "police2",
  [`police3`] = "police3",
  [`police4`] = "police4",
  [`policeb`] = "policeb",
  [`polmav`] = "polmav",
  [`policeold1`] = "policeold1",
  [`policeold2`] = "policeold2",
  [`policet`] = "policet",
  [`pranger`] = "pranger",
  [`predator`] = "predator",
  [`riot`] = "riot",
  [`riot2`] = "riot2",
  [`sheriff`] = "sheriff",
  [`sheriff2`] = "sheriff2",
  [`akula`] = "akula",
  [`annihilator`] = "annihilator",
  [`buzzard`] = "buzzard",
  [`buzzard2`] = "buzzard2",
  [`cargobob`] = "cargobob",
  [`cargobob2`] = "cargobob2",
  [`cargobob3`] = "cargobob3",
  [`cargobob4`] = "cargobob4",
  [`frogger`] = "frogger",
  [`frogger2`] = "frogger2",
  [`havok`] = "havok",
  [`hunter`] = "hunter",
  [`maverick`] = "maverick",
  [`savage`] = "savage",
  [`seasparrow`] = "seasparrow",
  [`skylift`] = "skylift",
  [`supervolito`] = "supervolito",
  [`supervolito2`] = "supervolito2",
  [`swift`] = "swift",
  [`swift2`] = "swift2",
  [`valkyrie`] = "valkyrie",
  [`valkyrie2`] = "valkyrie2",
  [`volatus`] = "volatus",
  [`annihilator2`] = "annihilator2",
  [`seasparrow2`] = "seasparrow2",
  [`seasparrow3`] = "seasparrow3",
  [`bulldozer`] = "bulldozer",
  [`cutter`] = "cutter",
  [`dump`] = "dump",
  [`flatbed`] = "flatbed",
  [`guardian`] = "guardian",
  [`handler`] = "handler",
  [`mixer`] = "mixer",
  [`mixer2`] = "mixer2",
  [`rubble`] = "rubble",
  [`tiptruck`] = "tiptruck",
  [`tiptruck2`] = "tiptruck2",
  [`apc`] = "apc",
  [`barracks`] = "barracks",
  [`barracks2`] = "barracks2",
  [`barracks3`] = "barracks3",
  [`barrage`] = "barrage",
  [`chernobog`] = "chernobog",
  [`crusader`] = "crusader",
  [`halftrack`] = "halftrack",
  [`khanjali`] = "khanjali",
  [`minitank`] = "minitank",
  [`rhino`] = "rhino",
  [`scarab`] = "scarab",
  [`scarab2`] = "scarab2",
  [`scarab3`] = "scarab3",
  [`thruster`] = "thruster",
  [`trailersmall2`] = "trailersmall2",
  [`vetir`] = "vetir",
  [`akuma`] = "akuma",
  [`avarus`] = "avarus",
  [`bagger`] = "bagger",
  [`bati`] = "bati",
  [`bati2`] = "bati2",
  [`bf400`] = "bf400",
  [`carbonrs`] = "carbonrs",
  [`chimera`] = "chimera",
  [`cliffhanger`] = "cliffhanger",
  [`daemon`] = "daemon",
  [`daemon2`] = "daemon2",
  [`defiler`] = "defiler",
  [`deathbike`] = "deathbike",
  [`deathbike2`] = "deathbike2",
  [`deathbike3`] = "deathbike3",
  [`diablous`] = "diablous",
  [`diablous2`] = "diablous2",
  [`double`] = "double",
  [`enduro`] = "enduro",
  [`esskey`] = "esskey",
  [`faggio`] = "faggio",
  [`faggio2`] = "faggio2",
  [`faggio3`] = "faggio3",
  [`fcr`] = "fcr",
  [`fcr2`] = "fcr2",
  [`gargoyle`] = "gargoyle",
  [`hakuchou`] = "hakuchou",
  [`hakuchou2`] = "hakuchou2",
  [`hexer`] = "hexer",
  [`innovation`] = "innovation",
  [`lectro`] = "lectro",
  [`manchez`] = "manchez",
  [`nemesis`] = "nemesis",
  [`nightblade`] = "nightblade",
  [`oppressor`] = "oppressor",
  [`oppressor2`] = "oppressor2",
  [`pcj`] = "pcj",
  [`ratbike`] = "ratbike",
  [`ruffian`] = "ruffian",
  [`rrocket`] = "rrocket",
  [`sanchez`] = "sanchez",
  [`sanchez2`] = "sanchez2",
  [`sanctus`] = "sanctus",
  [`shotaro`] = "shotaro",
  [`sovereign`] = "sovereign",
  [`stryder`] = "stryder",
  [`thrust`] = "thrust",
  [`vader`] = "vader",
  [`vindicator`] = "vindicator",
  [`vortex`] = "vortex",
  [`wolfsbane`] = "wolfsbane",
  [`zombiea`] = "zombiea",
  [`zombieb`] = "zombieb",
  [`manchez2`] = "manchez2",
  [`blade`] = "blade",
  [`buccaneer`] = "buccaneer",
  [`buccaneer2`] = "buccaneer2",
  [`chino`] = "chino",
  [`chino2`] = "chino2",
  [`clique`] = "clique",
  [`coquette3`] = "coquette3",
  [`deviant`] = "deviant",
  [`dominator`] = "dominator",
  [`dominator2`] = "dominator2",
  [`dominator3`] = "dominator3",
  [`dominator4`] = "dominator4",
  [`dominator5`] = "dominator5",
  [`dominator6`] = "dominator6",
  [`dukes`] = "dukes",
  [`dukes2`] = "dukes2",
  [`dukes3`] = "dukes3",
  [`faction`] = "faction",
  [`faction2`] = "faction2",
  [`faction3`] = "faction3",
  [`ellie`] = "ellie",
  [`gauntlet`] = "gauntlet",
  [`gauntlet2`] = "gauntlet2",
  [`gauntlet3`] = "gauntlet3",
  [`gauntlet4`] = "gauntlet4",
  [`gauntlet5`] = "gauntlet5",
  [`hermes`] = "hermes",
  [`hotknife`] = "hotknife",
  [`hustler`] = "hustler",
  [`impaler`] = "impaler",
  [`impaler2`] = "impaler2",
  [`impaler3`] = "impaler3",
  [`impaler4`] = "impaler4",
  [`imperator`] = "imperator",
  [`imperator2`] = "imperator2",
  [`imperator3`] = "imperator3",
  [`lurcher`] = "lurcher",
  [`moonbeam`] = "moonbeam",
  [`moonbeam2`] = "moonbeam2",
  [`nightshade`] = "nightshade",
  [`peyote2`] = "peyote2",
  [`phoenix`] = "phoenix",
  [`picador`] = "picador",
  [`ratloader`] = "ratloader",
  [`ratloader2`] = "ratloader2",
  [`ruiner`] = "ruiner",
  [`ruiner2`] = "ruiner2",
  [`ruiner3`] = "ruiner3",
  [`sabregt`] = "sabregt",
  [`sabregt2`] = "sabregt2",
  [`slamvan`] = "slamvan",
  [`slamvan2`] = "slamvan2",
  [`slamvan3`] = "slamvan3",
  [`slamvan4`] = "slamvan4",
  [`slamvan5`] = "slamvan5",
  [`slamvan6`] = "slamvan6",
  [`stalion`] = "stalion",
  [`stalion2`] = "stalion2",
  [`tampa`] = "tampa",
  [`tampa3`] = "tampa3",
  [`tulip`] = "tulip",
  [`vamos`] = "vamos",
  [`vigero`] = "vigero",
  [`virgo`] = "virgo",
  [`virgo2`] = "virgo2",
  [`virgo3`] = "virgo3",
  [`voodoo`] = "voodoo",
  [`voodoo2`] = "voodoo2",
  [`yosemite`] = "yosemite",
  [`yosemite2`] = "yosemite2",
  [`yosemite3`] = "yosemite3",
  [`bfinjection`] = "bfinjection",
  [`bifta`] = "bifta",
  [`blazer`] = "blazer",
  [`blazer2`] = "blazer2",
  [`blazer3`] = "blazer3",
  [`blazer4`] = "blazer4",
  [`blazer5`] = "blazer5",
  [`bodhi2`] = "bodhi2",
  [`brawler`] = "brawler",
  [`bruiser`] = "bruiser",
  [`bruiser2`] = "bruiser2",
  [`bruiser3`] = "bruiser3",
  [`brutus`] = "brutus",
  [`brutus2`] = "brutus2",
  [`brutus3`] = "brutus3",
  [`caracara`] = "caracara",
  [`caracara2`] = "caracara2",
  [`dloader`] = "dloader",
  [`dubsta3`] = "dubsta3",
  [`dune`] = "dune",
  [`dune2`] = "dune2",
  [`dune3`] = "dune3",
  [`dune4`] = "dune4",
  [`dune5`] = "dune5",
  [`everon`] = "everon",
  [`freecrawler`] = "freecrawler",
  [`hellion`] = "hellion",
  [`insurgent`] = "insurgent",
  [`insurgent2`] = "insurgent2",
  [`insurgent3`] = "insurgent3",
  [`kalahari`] = "kalahari",
  [`kamacho`] = "kamacho",
  [`marshall`] = "marshall",
  [`mesa3`] = "mesa3",
  [`monster`] = "monster",
  [`monster3`] = "monster3",
  [`monster4`] = "monster4",
  [`monster5`] = "monster5",
  [`menacer`] = "menacer",
  [`outlaw`] = "outlaw",
  [`nightshark`] = "nightshark",
  [`rancherxl`] = "rancherxl",
  [`rancherxl2`] = "rancherxl2",
  [`rebel`] = "rebel",
  [`rebel2`] = "rebel2",
  [`rcbandito`] = "rcbandito",
  [`riata`] = "riata",
  [`sandking`] = "sandking",
  [`sandking2`] = "sandking2",
  [`technical`] = "technical",
  [`technical2`] = "technical2",
  [`technical3`] = "technical3",
  [`trophytruck`] = "trophytruck",
  [`trophytruck2`] = "trophytruck2",
  [`vagrant`] = "vagrant",
  [`zhaba`] = "zhaba",
  [`verus`] = "verus",
  [`winky`] = "winky",
  [`formula`] = "formula",
  [`formula2`] = "formula2",
  [`openwheel1`] = "openwheel1",
  [`openwheel2`] = "openwheel2",
  [`alphaz1`] = "alphaz1",
  [`avenger`] = "avenger",
  [`avenger2`] = "avenger2",
  [`besra`] = "besra",
  [`blimp`] = "blimp",
  [`blimp2`] = "blimp2",
  [`blimp3`] = "blimp3",
  [`bombushka`] = "bombushka",
  [`cargoplane`] = "cargoplane",
  [`cuban800`] = "cuban800",
  [`dodo`] = "dodo",
  [`duster`] = "duster",
  [`howard`] = "howard",
  [`hydra`] = "hydra",
  [`jet`] = "jet",
  [`lazer`] = "lazer",
  [`luxor`] = "luxor",
  [`luxor2`] = "luxor2",
  [`mammatus`] = "mammatus",
  [`microlight`] = "microlight",
  [`miljet`] = "miljet",
  [`mogul`] = "mogul",
  [`molotok`] = "molotok",
  [`nimbus`] = "nimbus",
  [`nokota`] = "nokota",
  [`pyro`] = "pyro",
  [`rogue`] = "rogue",
  [`seabreeze`] = "seabreeze",
  [`shamal`] = "shamal",
  [`starling`] = "starling",
  [`strikeforce`] = "strikeforce",
  [`stunt`] = "stunt",
  [`titan`] = "titan",
  [`tula`] = "tula",
  [`velum`] = "velum",
  [`velum2`] = "velum2",
  [`vestra`] = "vestra",
  [`volatol`] = "volatol",
  [`alkonost`] = "alkonost",
  [`baller`] = "baller",
  [`baller2`] = "baller2",
  [`baller3`] = "baller3",
  [`baller4`] = "baller4",
  [`baller5`] = "baller5",
  [`baller6`] = "baller6",
  [`bjxl`] = "bjxl",
  [`cavalcade`] = "cavalcade",
  [`cavalcade2`] = "cavalcade2",
  [`contender`] = "contender",
  [`dubsta`] = "dubsta",
  [`dubsta2`] = "dubsta2",
  [`fq2`] = "fq2",
  [`granger`] = "granger",
  [`gresley`] = "gresley",
  [`habanero`] = "habanero",
  [`huntley`] = "huntley",
  [`landstalker`] = "landstalker",
  [`landstalker2`] = "landstalker2",
  [`mesa`] = "mesa",
  [`mesa2`] = "mesa2",
  [`novak`] = "novak",
  [`patriot`] = "patriot",
  [`patriot2`] = "patriot2",
  [`radi`] = "radi",
  [`rebla`] = "rebla",
  [`rocoto`] = "rocoto",
  [`seminole`] = "seminole",
  [`seminole2`] = "seminole2",
  [`serrano`] = "serrano",
  [`toros`] = "toros",
  [`xls`] = "xls",
  [`xls2`] = "xls2",
  [`squaddie`] = "squaddie",
  [`asea`] = "asea",
  [`asea2`] = "asea2",
  [`asterope`] = "asterope",
  [`cog55`] = "cog55",
  [`cog552`] = "cog552",
  [`cognoscenti`] = "cognoscenti",
  [`cognoscenti2`] = "cognoscenti2",
  [`emperor`] = "emperor",
  [`emperor2`] = "emperor2",
  [`emperor3`] = "emperor3",
  [`fugitive`] = "fugitive",
  [`glendale`] = "glendale",
  [`glendale2`] = "glendale2",
  [`ingot`] = "ingot",
  [`intruder`] = "intruder",
  [`limo2`] = "limo2",
  [`premier`] = "premier",
  [`primo`] = "primo",
  [`primo2`] = "primo2",
  [`regina`] = "regina",
  [`romero`] = "romero",
  [`stafford`] = "stafford",
  [`stanier`] = "stanier",
  [`stratum`] = "stratum",
  [`stretch`] = "stretch",
  [`superd`] = "superd",
  [`surge`] = "surge",
  [`tailgater`] = "tailgater",
  [`warrener`] = "warrener",
  [`washington`] = "washington",
  [`airbus`] = "airbus",
  [`brickade`] = "brickade",
  [`bus`] = "bus",
  [`coach`] = "coach",
  [`pbus2`] = "pbus2",
  [`rallytruck`] = "rallytruck",
  [`rentalbus`] = "rentalbus",
  [`taxi`] = "taxi",
  [`tourbus`] = "tourbus",
  [`trash`] = "trash",
  [`trash2`] = "trash2",
  [`wastelander`] = "wastelander",
  [`alpha`] = "alpha",
  [`banshee`] = "banshee",
  [`bestiagts`] = "bestiagts",
  [`blista2`] = "blista2",
  [`blista3`] = "blista3",
  [`buffalo`] = "buffalo",
  [`buffalo2`] = "buffalo2",
  [`buffalo3`] = "buffalo3",
  [`carbonizzare`] = "carbonizzare",
  [`comet2`] = "comet2",
  [`comet3`] = "comet3",
  [`comet4`] = "comet4",
  [`comet5`] = "comet5",
  [`coquette`] = "coquette",
  [`coquette4`] = "coquette4",
  [`drafter`] = "drafter",
  [`deveste`] = "deveste",
  [`elegy`] = "elegy",
  [`elegy2`] = "elegy2",
  [`feltzer2`] = "feltzer2",
  [`flashgt`] = "flashgt",
  [`furoregt`] = "furoregt",
  [`fusilade`] = "fusilade",
  [`futo`] = "futo",
  [`gb200`] = "gb200",
  [`hotring`] = "hotring",
  [`komoda`] = "komoda",
  [`imorgon`] = "imorgon",
  [`issi7`] = "issi7",
  [`italigto`] = "italigto",
  [`jugular`] = "jugular",
  [`jester`] = "jester",
  [`jester2`] = "jester2",
  [`jester3`] = "jester3",
  [`khamelion`] = "khamelion",
  [`kuruma`] = "kuruma",
  [`kuruma2`] = "kuruma2",
  [`locust`] = "locust",
  [`lynx`] = "lynx",
  [`massacro`] = "massacro",
  [`massacro2`] = "massacro2",
  [`neo`] = "neo",
  [`neon`] = "neon",
  [`ninef`] = "ninef",
  [`ninef2`] = "ninef2",
  [`omnis`] = "omnis",
  [`paragon`] = "paragon",
  [`paragon2`] = "paragon2",
  [`pariah`] = "pariah",
  [`penumbra`] = "penumbra",
  [`penumbra2`] = "penumbra2",
  [`raiden`] = "raiden",
  [`rapidgt`] = "rapidgt",
  [`rapidgt2`] = "rapidgt2",
  [`raptor`] = "raptor",
  [`revolter`] = "revolter",
  [`ruston`] = "ruston",
  [`schafter2`] = "schafter2",
  [`schafter3`] = "schafter3",
  [`schafter4`] = "schafter4",
  [`schafter5`] = "schafter5",
  [`schafter6`] = "schafter6",
  [`schlagen`] = "schlagen",
  [`schwarzer`] = "schwarzer",
  [`sentinel3`] = "sentinel3",
  [`seven70`] = "seven70",
  [`specter`] = "specter",
  [`specter2`] = "specter2",
  [`streiter`] = "streiter",
  [`sugoi`] = "sugoi",
  [`sultan`] = "sultan",
  [`sultan2`] = "sultan2",
  [`surano`] = "surano",
  [`tampa2`] = "tampa2",
  [`tropos`] = "tropos",
  [`verlierer2`] = "verlierer2",
  [`vstr`] = "vstr",
  [`zr380`] = "zr380",
  [`zr3802`] = "zr3802",
  [`zr3803`] = "zr3803",
  [`italirsx`] = "italirsx",
  [`veto`] = "veto",
  [`veto2`] = "veto2",
  [`ardent`] = "ardent",
  [`btype`] = "btype",
  [`btype2`] = "btype2",
  [`btype3`] = "btype3",
  [`casco`] = "casco",
  [`cheetah2`] = "cheetah2",
  [`coquette2`] = "coquette2",
  [`deluxo`] = "deluxo",
  [`dynasty`] = "dynasty",
  [`fagaloa`] = "fagaloa",
  [`feltzer3`] = "feltzer3",
  [`gt500`] = "gt500",
  [`infernus2`] = "infernus2",
  [`jb700`] = "jb700",
  [`jb7002`] = "jb7002",
  [`mamba`] = "mamba",
  [`manana`] = "manana",
  [`manana2`] = "manana2",
  [`michelli`] = "michelli",
  [`monroe`] = "monroe",
  [`nebula`] = "nebula",
  [`peyote`] = "peyote",
  [`peyote3`] = "peyote3",
  [`pigalle`] = "pigalle",
  [`rapidgt3`] = "rapidgt3",
  [`retinue`] = "retinue",
  [`retinue2`] = "retinue2",
  [`savestra`] = "savestra",
  [`stinger`] = "stinger",
  [`stingergt`] = "stingergt",
  [`stromberg`] = "stromberg",
  [`swinger`] = "swinger",
  [`torero`] = "torero",
  [`tornado`] = "tornado",
  [`tornado2`] = "tornado2",
  [`tornado3`] = "tornado3",
  [`tornado4`] = "tornado4",
  [`tornado5`] = "tornado5",
  [`tornado6`] = "tornado6",
  [`turismo2`] = "turismo2",
  [`viseris`] = "viseris",
  [`z190`] = "z190",
  [`ztype`] = "ztype",
  [`zion3`] = "zion3",
  [`cheburek`] = "cheburek",
  [`toreador`] = "toreador",
  [`adder`] = "adder",
  [`autarch`] = "autarch",
  [`banshee2`] = "banshee2",
  [`bullet`] = "bullet",
  [`cheetah`] = "cheetah",
  [`cyclone`] = "cyclone",
  [`entity2`] = "entity2",
  [`entityxf`] = "entityxf",
  [`emerus`] = "emerus",
  [`fmj`] = "fmj",
  [`furia`] = "furia",
  [`gp1`] = "gp1",
  [`infernus`] = "infernus",
  [`italigtb`] = "italigtb",
  [`italigtb2`] = "italigtb2",
  [`krieger`] = "krieger",
  [`le7b`] = "le7b",
  [`nero`] = "nero",
  [`nero2`] = "nero2",
  [`osiris`] = "osiris",
  [`penetrator`] = "penetrator",
  [`pfister811`] = "pfister811",
  [`prototipo`] = "prototipo",
  [`reaper`] = "reaper",
  [`s80`] = "s80",
  [`sc1`] = "sc1",
  [`scramjet`] = "scramjet",
  [`sheava`] = "sheava",
  [`sultanrs`] = "sultanrs",
  [`t20`] = "t20",
  [`taipan`] = "taipan",
  [`tempesta`] = "tempesta",
  [`tezeract`] = "tezeract",
  [`thrax`] = "thrax",
  [`tigon`] = "tigon",
  [`turismor`] = "turismor",
  [`tyrant`] = "tyrant",
  [`tyrus`] = "tyrus",
  [`vacca`] = "vacca",
  [`vagner`] = "vagner",
  [`vigilante`] = "vigilante",
  [`visione`] = "visione",
  [`voltic`] = "voltic",
  [`voltic2`] = "voltic2",
  [`xa21`] = "xa21",
  [`zentorno`] = "zentorno",
  [`zorrusso`] = "zorrusso",
  [`armytanker`] = "armytanker",
  [`armytrailer`] = "armytrailer",
  [`armytrailer2`] = "armytrailer2",
  [`baletrailer`] = "baletrailer",
  [`boattrailer`] = "boattrailer",
  [`cablecar`] = "cablecar",
  [`docktrailer`] = "docktrailer",
  [`freighttrailer`] = "freighttrailer",
  [`graintrailer`] = "graintrailer",
  [`proptrailer`] = "proptrailer",
  [`raketrailer`] = "raketrailer",
  [`tr2`] = "tr2",
  [`tr3`] = "tr3",
  [`tr4`] = "tr4",
  [`trflat`] = "trflat",
  [`tvtrailer`] = "tvtrailer",
  [`tanker`] = "tanker",
  [`tanker2`] = "tanker2",
  [`trailerlarge`] = "trailerlarge",
  [`trailerlogs`] = "trailerlogs",
  [`trailersmall`] = "trailersmall",
  [`trailers`] = "trailers",
  [`trailers2`] = "trailers2",
  [`trailers3`] = "trailers3",
  [`trailers4`] = "trailers4",
  [`freight`] = "freight",
  [`freightcar`] = "freightcar",
  [`freightcont1`] = "freightcont1",
  [`freightcont2`] = "freightcont2",
  [`freightgrain`] = "freightgrain",
  [`metrotrain`] = "metrotrain",
  [`tankercar`] = "tankercar",
  [`airtug`] = "airtug",
  [`caddy`] = "caddy",
  [`caddy2`] = "caddy2",
  [`caddy3`] = "caddy3",
  [`docktug`] = "docktug",
  [`forklift`] = "forklift",
  [`mower`] = "mower",
  [`ripley`] = "ripley",
  [`sadler`] = "sadler",
  [`sadler2`] = "sadler2",
  [`scrap`] = "scrap",
  [`towtruck`] = "towtruck",
  [`towtruck2`] = "towtruck2",
  [`tractor`] = "tractor",
  [`tractor2`] = "tractor2",
  [`tractor3`] = "tractor3",
  [`utillitruck`] = "utillitruck",
  [`utillitruck2`] = "utillitruck2",
  [`utillitruck3`] = "utillitruck3",
  [`slamtruck`] = "slamtruck",
  [`bison`] = "bison",
  [`bison2`] = "bison2",
  [`bison3`] = "bison3",
  [`bobcatxl`] = "bobcatxl",
  [`boxville`] = "boxville",
  [`boxville2`] = "boxville2",
  [`boxville3`] = "boxville3",
  [`boxville4`] = "boxville4",
  [`boxville5`] = "boxville5",
  [`burrito`] = "burrito",
  [`burrito2`] = "burrito2",
  [`burrito3`] = "burrito3",
  [`burrito4`] = "burrito4",
  [`burrito5`] = "burrito5",
  [`camper`] = "camper",
  [`gburrito`] = "gburrito",
  [`gburrito2`] = "gburrito2",
  [`journey`] = "journey",
  [`minivan`] = "minivan",
  [`minivan2`] = "minivan2",
  [`paradise`] = "paradise",
  [`pony`] = "pony",
  [`pony2`] = "pony2",
  [`rumpo`] = "rumpo",
  [`rumpo2`] = "rumpo2",
  [`rumpo3`] = "rumpo3",
  [`speedo`] = "speedo",
  [`speedo2`] = "speedo2",
  [`speedo4`] = "speedo4",
  [`surfer`] = "surfer",
  [`surfer2`] = "surfer2",
  [`taco`] = "taco",
  [`youga`] = "youga",
  [`youga2`] = "youga2",
  [`youga3`] = "youga3",
}

Ora.Config:SetDataCollection(
    "Anticheat:ServerSideEvents",
    {
      "8321hiue89js",
      "adminmenu:allowall",
      "3dme:shareDisplay",
      "AdminMenu:giveBank",
      "AdminMenu:giveCash",
      "AdminMenu:giveDirtyMoney",
      "Tem2LPs5Para5dCyjuHm87y2catFkMpV",
      "dqd36JWLRC72k8FDttZ5adUKwvwq9n9m",
      "antilynx8:anticheat",
      "antilynxr4:detect",
      "antilynxr6:detection",
      "ynx8:anticheat",
      "antilynx8r4a:anticheat",
      "lynx8:anticheat",
      "AntiLynxR4:kick",
      "AntiLynxR4:log",
      "bank:deposit",
      "bank:withdraw",
      "Banca:deposit",
      "Banca:withdraw",
      "BsCuff:Cuff696999",
      "CheckHandcuff",
      "cuffServer",
      "cuffGranted",
      "DiscordBot:playerDied",
      "DFWM:adminmenuenable",
      "DFWM:askAwake",
      "DFWM:checkup",
      "DFWM:cleanareaentity",
      "DFWM:cleanareapeds",
      "DFWM:cleanareaveh",
      "DFWM:enable",
      "DFWM:invalid",
      "DFWM:log",
      "DFWM:openmenu",
      "DFWM:spectate",
      "DFWM:ViolationDetected",
      "dmv:success",
      "eden_garage:payhealth",
      "ems:revive",
      "esx_ambulancejob:revive",
      "esx_ambulancejob:setDeathStatus",
      "esx_billing:sendBill",
      "esx_banksecurity:pay",
      "esx_blanchisseur:startWhitening",
      "esx_carthief:alertcops",
      "esx_carthief:pay",
      "esx_dmvschool:addLicense",
      "esx_dmvschool:pay",
      "esx_drugs:startHarvestWeed",
      "esx_drugs:startTransformWeed",
      "esx_drugs:startSellWeed",
      "esx_drugs:startHarvestCoke",
      "esx_drugs:startTransformCoke",
      "esx_drugs:startSellCoke",
      "esx_drugs:startHarvestMeth",
      "esx_drugs:startTransformMeth",
      "esx_drugs:startSellMeth",
      "esx_drugs:startHarvestOpium",
      "esx_drugs:startTransformOpium",
      "esx_drugs:startSellOpium",
      "esx_drugs:stopHarvestCoke",
      "esx_drugs:stopTransformCoke",
      "esx_drugs:stopSellCoke",
      "esx_drugs:stopHarvestMeth",
      "esx_drugs:stopTransformMeth",
      "esx_drugs:stopSellMeth",
      "esx_drugs:stopHarvestWeed",
      "esx_drugs:stopTransformWeed",
      "esx_drugs:stopSellWeed",
      "esx_drugs:stopHarvestOpium",
      "esx_drugs:stopTransformOpium",
      "esx_drugs:stopSellOpium",
      "esx:enterpolicecar",
      "esx_fueldelivery:pay",
      "esx:giveInventoryItem",
      "esx_garbagejob:pay",
      "esx_godirtyjob:pay",
      "esx_gopostaljob:pay",
      "esx_handcuffs:cuffing",
      "esx_jail:sendToJail",
      "esx_jail:unjailQuest",
      "esx_jailer:sendToJail",
      "esx_jailer:unjailTime",
      "esx_jobs:caution",
      "esx_mecanojob:onNPCJobCompleted",
      "esx_mechanicjob:startHarvest",
      "esx_mechanicjob:startCraft",
      "esx_pizza:pay",
      "esx_policejob:handcuff",
      "esx_policejob:requestarrest",
      "esx-qalle-jail:jailPlayer",
      "esx-qalle-jail:jailPlayerNew",
      "esx-qalle-hunting:reward",
      "esx-qalle-hunting:sell",
      "esx_ranger:pay",
      "esx:removeInventoryItem",
      "esx_truckerjob:pay",
      "esx_skin:responseSaveSkin",
      "esx_slotmachine:sv:2",
      "esx_society:getOnlinePlayers",
      "esx_society:setJob",
      "esx_vehicleshop:setVehicleOwned",
      "hentailover:xdlol",
      "JailUpdate",
      "js:jailuser",
      "js:removejailtime",
      "LegacyFuel:PayFuel",
      "ljail:jailplayer",
      "lscustoms:payGarage",
      "mellotrainer:adminTempBan",
      "mellotrainer:adminKick",
      "mellotrainer:s_adminKill",
      "NB:destituerplayer",
      "NB:recruterplayer",
      "OG_cuffs:cuffCheckNearest",
      "paramedic:revive",
      "police:cuffGranted",
      "unCuffServer",
      "uncuffGranted",
      "vrp_slotmachine:server:2",
      "whoapd:revive",
      "gcPhone:_internalAddMessageDFWM",
      "gcPhone:tchat_channelDFWM",
      "esx_vehicleshop:setVehicleOwnedDFWM",
      "esx_mafiajob:confiscateDFWMPlayerItem",
      "_chat:messageEntDFWMered",
      "lscustoms:pDFWMayGarage",
      "vrp_slotmachDFWMine:server:2",
      "Banca:dDFWMeposit",
      "bank:depDFWMosit",
      "esx_jobs:caDFWMution",
      "give_back",
      "esx_fueldDFWMelivery:pay",
      "esx_carthDFWMief:pay",
      "esx_godiDFWMrtyjob:pay",
      "esx_pizza:pDFWMay",
      "esx_ranger:pDFWMay",
      "esx_garbageDFWMjob:pay",
      "esx_truckDFWMerjob:pay",
      "AdminMeDFWMnu:giveBank",
      "AdminMDFWMenu:giveCash",
      "esx_goDFWMpostaljob:pay",
      "esx_baDFWMnksecurity:pay",
      "esx_sloDFWMtmachine:sv:2",
      "esx:giDFWMveInventoryItem",
      "NB:recDFWMruterplayer",
      "esx_biDFWMlling:sendBill",
      "esx_jDFWMailer:sendToJail",
      "esx_jaDFWMil:sendToJail",
      "js:jaDFWMiluser",
      "esx-qalle-jail:jailPDFWMlayer",
      "esx_dmvschool:pDFWMay",
      "LegacyFuel:PayFuDFWMel",
      "OG_cuffs:cuffCheckNeDFWMarest",
      "CheckHandcDFWMuff",
      "cuffSeDFWMrver",
      "cuffGDFWMranted",
      "police:cuffGDFWMranted",
      "esx_handcuffs:cufDFWMfing",
      "esx_policejob:haDFWMndcuff",
      "bank:withdDFWMraw",
      "dmv:succeDFWMss",
      "esx_skin:responseSaDFWMveSkin",
      "esx_dmvschool:addLiceDFWMnse",
      "esx_mechanicjob:starDFWMtCraft",
      "esx_drugs:startHarvestWDFWMeed",
      "esx_drugs:startTransfoDFWMrmWeed",
      "esx_drugs:startSellWeDFWMed",
      "esx_drugs:startHarvestDFWMCoke",
      "esx_drugs:startTransDFWMformCoke",
      "esx_drugs:startSellCDFWMoke",
      "esx_drugs:startHarDFWMvestMeth",
      "esx_drugs:startTDFWMransformMeth",
      "esx_drugs:startSellMDFWMeth",
      "esx_drugs:startHDFWMarvestOpium",
      "esx_drugs:startSellDFWMOpium",
      "esx_drugs:starDFWMtTransformOpium",
      "esx_blanchisDFWMseur:startWhitening",
      "esx_drugs:stopHarvDFWMestCoke",
      "esx_drugs:stopTranDFWMsformCoke",
      "esx_drugs:stopSellDFWMCoke",
      "esx_drugs:stopHarvesDFWMtMeth",
      "esx_drugs:stopTranDFWMsformMeth",
      "esx_drugs:stopSellMDFWMeth",
      "esx_drugs:stopHarDFWMvestWeed",
      "esx_drugs:stopTDFWMransformWeed",
      "esx_drugs:stopSellWDFWMeed",
      "esx_drugs:stopHarvestDFWMOpium",
      "esx_drugs:stopTransDFWMformOpium",
      "esx_drugs:stopSellOpiuDFWMm",
      "esx_society:openBosDFWMsMenu",
      "esx_jobs:caDFWMution",
      "esx_tankerjob:DFWMpay",
      "esx_vehicletrunk:givDFWMeDirty",
      "gambling:speDFWMnd",
      "AdminMenu:giveDirtyMDFWMoney",
      "esx_moneywash:depoDFWMsit",
      "esx_moneywash:witDFWMhdraw",
      "mission:completDFWMed",
      "truckerJob:succeDFWMss",
      "99kr-burglary:addMDFWMoney",
      "esx_jailer:unjailTiDFWMme",
      "esx_ambulancejob:reDFWMvive",
      "DiscordBot:plaDFWMyerDied",
      "esx:getShDFWMaredObjDFWMect",
      "esx_society:getOnlDFWMinePlayers",
      "js:jaDFWMiluser",
      "h:xd",
      "adminmenu:setsalary",
      "adminmenu:cashoutall",
      "bank:tranDFWMsfer",
      "paycheck:bonDFWMus",
      "paycheck:salDFWMary",
      "HCheat:TempDisableDetDFWMection",
      "esx_drugs:pickedUpCDFWMannabis",
      "esx_drugs:processCDFWMannabis",
      "esx-qalle-hunting:DFWMreward",
      "esx-qalle-hunting:seDFWMll",
      "esx_mecanojob:onNPCJobCDFWMompleted",
      "BsCuff:Cuff696DFWM999",
      "veh_SR:CheckMonDFWMeyForVeh",
      "esx_carthief:alertcoDFWMps",
      "mellotrainer:adminTeDFWMmpBan",
      "mellotrainer:adminKickDFWM",
      "esx_society:putVehicleDFWMInGarage",
      'bank:transfer',
      'UnJP',
      'esx-qalle-jail:openJailMenu',
      'ambulancier:selfRespawn',
      'esx_inventoryhud:openPlayerInventory',
      'esx:getSharedObject',
      'esx:serverCallback',
      'esx:showNotification',
      'esx:showAdvancedNotification',
      'esx:showHelpNotification',
      'esx:playerLoaded',
      'esx:onPlayerDeath',
      'skinchanger:loadDefaultModel',
      'skinchanger:modelLoaded',
      'esx:restoreLoadout',
      'esx:setAccountMoney',
      'esx:addInventoryItem',
      'esx:removeInventoryItem',
      'esx:setJob',
      'esx:setJob2',
      'esx:addWeapon',
      'esx:addWeaponComponent',
      'esx:removeWeapon',
      'esx:removeWeaponComponent',
      'esx:teleport',
      'esx:spawnVehicle',
      'esx:spawnObject',
      'esx:pickup',
      'esx:removePickup',
      'esx:pickupWeapon',
      'esx:spawnPed',
      'esx:deleteVehicle',
      'es:addedMoney',
      'es:removedMoney',
      'es:addedBank',
      'es:removedBank',
      'es:setPlayerDecorator',
      'skinchanger:getSkin',
      'skinchanger:loadClothes',
      'esx_skin:openRestrictedMenu',
      'esx_skin:getLastSkin',
      'esx_skin:setLastSkin',
      'esx_skin:openSaveableMenu',
      'skinchanger:loadSkin',
      'esx_billing:newBill',
      'esx_status:loaded',
      'esx_optionalneeds:onDrink',
      'esx_status:registerStatus',
      'esx_status:getStatus',
      'esx_property:getProperties',
      'esx_property:getProperty',
      'esx_property:getGateway',
      'esx_property:setPropertyOwned',
      'sendProximityMessage',
      'sendProximityMessageMe',
      'sendProximityMessageDo',
      'esx_skin:openMenu',
      'esx_skin:openSaveableRestrictedMenu',
      'skinchanger:change',
      'esx_status:load',
      'esx_status:set',
      'esx_status:add',
      'esx_status:remove',
      'esx_status:setDisplay',
      'esx_status:onTick',
      'tattoo:buySuccess',
      'esx_weashop:loadLicenses',
      'jsfour-idcard:open',
      'esx_basicneeds:resetStatus',
      'esx_basicneeds:healPlayer',
      'esx_basicneeds:onEat',
      'esx_basicneeds:onDrink',
      'esx_service:notifyAllInService',
      'esx_society:openBossMenu',
      'esx_society:openBossMenu2',
      'esx_society:toggleSocietyHud',
      'esx_society:toggleSociety2Hud',
      'esx_society:setSocietyMoney',
      'esx_society:setSociety2Money',
      'esx_holdupbank:currentlyrobbing',
      'esx_holdupbank:killblip',
      'esx_holdupbank:setblip',
      'esx_holdupbank:toofarlocal',
      'esx_holdupbank:robberycomplete',
      'esx_holdup:currentlyrobbing',
      'esx_holdup:killblip',
      'esx_holdup:setblip',
      'esx_holdup:toofarlocal',
      'esx_holdup:robberycomplete',
      'esx_holdup:starttimer',
      'esx_ambulancejob:heal',
      'esx_ambulancejob:revive',
      'esx_ambulancejob:requestDeath',
      'esx_phone:addSpecialContact',
      'esx_lscustom:installMod',
      'esx_lscustom:cancelInstallMod',
      'esx_basicneeds:isEating',
      'esx:setjob2',
      'esx_jobs:publicTeleports',
      'esx_jobs:action',
      'esx_jobs:spawnJobVehicle',
      'esx_vehiclelock:updatePlayerCars',
      'esx_mecanojob:onHijack',
      'esx_mecanojob:onCarokit',
      'esx_mecanojob:onFixkit',
      'esx_phone:cancelMessage',
      'esx_policejob:handcuff',
      'esx_policejob:unrestrain',
      'esx_policejob:drag',
      'esx_policejob:putInVehicle',
      'esx_policejob:OutVehicle',
      'esx_policejob:updateBlip',
      'esx_phone:removeSpecialContact',
      'esx_vigneronjob:annonce',
      'esx_vigneronjob:annoncestop',
      'esx_truck_inventory:setOwnedVehicule',
      'esx_truck_inventory:getInventoryLoaded',
      'InteractSound_CL:PlayOnOne',
      'InteractSound_CL:PlayOnAll',
      'InteractSound_CL:PlayWithinDistance',
      '::{korioz#0110}::esx:getSharedObject',
    } 
  )