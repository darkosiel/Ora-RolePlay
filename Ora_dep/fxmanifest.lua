fx_version 'adamant'
games { 'gta5', 'rdr3' }

server_script 'MySQL/mysql-async.js'
client_script 'MySQL/mysql-async-client.lua'

server_script "@mysql-async/lib/MySQL.lua"
server_script 'uuid.js'
server_script 'server.lua'

client_scripts {
    'module/base/shared/*.lua',
    'module/base/client/*.lua',
}

server_scripts {
    'MySQL/lib/MySQL.lua',
    'module/base/shared/*.lua',
    'module/base/server/*.lua',
}

client_scripts {
    'module/activity/tv/config.lua',
    'module/activity/tv/client.lua',
	'module/activity/3dme/3dme_cl.lua',
	--'module/activity/bennys/client.lua',
	'module/Utils/cl_status.lua',
	'module/Utils/cl_utils.lua',
	'module/Utils/clear_ped.lua.lua',
	'weapon/client.lua',
}
server_scripts {
    'module/activity/tv/config.lua',
    'module/activity/tv/server.lua',
	'module/activity/3dme/3dme_sv.lua',
	--'module/activity/bennys/server.lua',
	'module/Utils/sv_utils.lua',
}

client_scripts {
	"module/ipl/lib/common.lua"
	, "module/ipl/lib/observers/interiorIdObserver.lua"
	, "module/ipl/lib/observers/officeSafeDoorHandler.lua"
	, "module/ipl/cayo.lua"
	, "module/ipl/client.lua"

	-- GTA V
	, "module/ipl/gtav/base.lua"   -- Base IPLs to fix holes
	, "module/ipl/gtav/ammunations.lua"
	, "module/ipl/gtav/bahama.lua"
	, "module/ipl/gtav/floyd.lua"
	, "module/ipl/gtav/franklin.lua"
	, "module/ipl/gtav/franklin_aunt.lua"
	, "module/ipl/gtav/graffitis.lua"
	, "module/ipl/gtav/pillbox_hospital.lua"
	, "module/ipl/gtav/lester_factory.lua"
	, "module/ipl/gtav/michael.lua"
	, "module/ipl/gtav/north_yankton.lua"
	, "module/ipl/gtav/red_carpet.lua"
	, "module/ipl/gtav/simeon.lua"
	, "module/ipl/gtav/stripclub.lua"
	, "module/ipl/gtav/trevors_trailer.lua"
	, "module/ipl/gtav/ufo.lua"
	, "module/ipl/gtav/zancudo_gates.lua"

	-- GTA Online
	, "module/ipl/gta_online/apartment_hi_1.lua"
	, "module/ipl/gta_online/apartment_hi_2.lua"
	, "module/ipl/gta_online/house_hi_1.lua"
	, "module/ipl/gta_online/house_hi_2.lua"
	, "module/ipl/gta_online/house_hi_3.lua"
	, "module/ipl/gta_online/house_hi_4.lua"
	, "module/ipl/gta_online/house_hi_5.lua"
	, "module/ipl/gta_online/house_hi_6.lua"
	, "module/ipl/gta_online/house_hi_7.lua"
	, "module/ipl/gta_online/house_hi_8.lua"
	, "module/ipl/gta_online/house_mid_1.lua"
	, "module/ipl/gta_online/house_low_1.lua"

	-- DLC High Life
	, "module/ipl/dlc_high_life/apartment1.lua"
	, "module/ipl/dlc_high_life/apartment2.lua"
	, "module/ipl/dlc_high_life/apartment3.lua"
	, "module/ipl/dlc_high_life/apartment4.lua"
	, "module/ipl/dlc_high_life/apartment5.lua"
	, "module/ipl/dlc_high_life/apartment6.lua"

	-- DLC Heists
	, "module/ipl/dlc_heists/carrier.lua"
	, "module/ipl/dlc_heists/yacht.lua"

	-- DLC Executives & Other Criminals
	, "module/ipl/dlc_executive/apartment1.lua"
	, "module/ipl/dlc_executive/apartment2.lua"
	, "module/ipl/dlc_executive/apartment3.lua"

	-- DLC Finance & Felony
	, "module/ipl/dlc_finance/office1.lua"
	, "module/ipl/dlc_finance/office2.lua"
	, "module/ipl/dlc_finance/office3.lua"
	, "module/ipl/dlc_finance/office4.lua"
	, "module/ipl/dlc_finance/organization.lua"

	-- DLC Bikers
	, "module/ipl/dlc_bikers/cocaine.lua"
	, "module/ipl/dlc_bikers/counterfeit_cash.lua"
	, "module/ipl/dlc_bikers/document_forgery.lua"
	, "module/ipl/dlc_bikers/meth.lua"
	, "module/ipl/dlc_bikers/weed.lua"
	, "module/ipl/dlc_bikers/clubhouse1.lua"
	, "module/ipl/dlc_bikers/clubhouse2.lua"
	, "module/ipl/dlc_bikers/gang.lua"

	-- DLC Import/Export
	, "module/ipl/dlc_import/garage1.lua"
	, "module/ipl/dlc_import/garage2.lua"
	, "module/ipl/dlc_import/garage3.lua"
	, "module/ipl/dlc_import/garage4.lua"
	, "module/ipl/dlc_import/vehicle_warehouse.lua"

	-- DLC Gunrunning
	, "module/ipl/dlc_gunrunning/bunkers.lua"
	, "module/ipl/dlc_gunrunning/yacht.lua"

	-- DLC Smuggler's Run
	, "module/ipl/dlc_smuggler/hangar.lua"

	-- DLC Doomsday Heist
	, "module/ipl/dlc_doomsday/facility.lua"

	-- DLC After Hours
	, "module/ipl/dlc_afterhours/nightclubs.lua"
	
	-- DLC Diamond Casino (Requires forced build 2060 or higher)
	, "module/ipl/dlc_casino/casino.lua"
	, "module/ipl/dlc_casino/penthouse.lua"

	-- DLC Tuners (Requires forced build 2372 or higher)
	, "module/ipl/dlc_tuner/garage.lua"
	, "module/ipl/dlc_tuner/meetup.lua"
	, "module/ipl/dlc_tuner/methlab.lua"
	
	-- DLC The Contract (Requires forced build 2545 or higher)
	, "module/ipl/dlc_security/studio.lua"
	, "module/ipl/dlc_security/billboards.lua"
	, "module/ipl/dlc_security/musicrooftop.lua"
	, "module/ipl/dlc_security/garage.lua"
	, "module/ipl/dlc_security/office1.lua"
	, "module/ipl/dlc_security/office2.lua"
	, "module/ipl/dlc_security/office3.lua"
	, "module/ipl/dlc_security/office4.lua"
}

--Maps

data_file 'TIMECYCLEMOD_FILE' 'nxp_firedep_timecycle.xml'

files {
	'nxp_firedep_timecycle.xml',
	----STREAM WEAPON
	'weapon/weapons/weaponsnowball.meta',
	'weapon/weapons/weapons.meta',
	'weapon/weapons/weaponpipebomb.meta',
	'weapon/weapons/weaponrailgun.meta',
	'weapon/weapons/weapons_spacerangers.meta',
	'weapon/weapons/weapons_pistol_mk2.meta',
	'weapon/weapons/weaponstonehatchet.meta',
	'weapon/weapons/weapons_doubleaction.meta',
	'weapon/weapons/weaponflaregun.meta',

	'weapon/weapons/loadouts.meta',
	'weapon/weapons/weaponarchetypes.meta',
	'weapon/weapons/weaponanimations.meta',
	'weapon/weapons/weaponanimations2.meta',
	'weapon/weapons/pedpersonality.meta',
	'weapon/weapons/pedpersonality2.meta',
	'weapon/weapons/weaponsora.meta',
	'weapon/weapons/explosion.ymt',
    'weapon/weapons/recul/weaponautoshotgun.meta',
	'weapon/weapons/recul/weaponbullpuprifle.meta',
	'weapon/weapons/recul/weaponcombatpdw.meta',
	'weapon/weapons/recul/weaponcompactrifle.meta',
	'weapon/weapons/recul/weapondbshotgun.meta',
	'weapon/weapons/recul/weaponfirework.meta',
	'weapon/weapons/recul/weapongusenberg.meta',
	'weapon/weapons/recul/weaponheavypistol.meta',
	'weapon/weapons/recul/weaponheavyshotgun.meta',
	'weapon/weapons/recul/weaponmachinepistol.meta',
	'weapon/weapons/recul/weaponmarksmanpistol.meta',
	'weapon/weapons/recul/weaponmarksmanrifle.meta',
	'weapon/weapons/recul/weaponminismg.meta',
	'weapon/weapons/recul/weaponmusket.meta',
	'weapon/weapons/recul/weaponrevolver.meta',
	'weapon/weapons/recul/weapons_assaultrifle_mk2.meta',
	'weapon/weapons/recul/weapons_bullpuprifle_mk2.meta',
	'weapon/weapons/recul/weapons_carbinerifle_mk2.meta',
	'weapon/weapons/recul/weapons_combatmg_mk2.meta',
	'weapon/weapons/recul/weapons_heavysniper_mk2.meta',
	'weapon/weapons/recul/weapons_marksmanrifle_mk2.meta',
	'weapon/weapons/recul/weapons_pumpshotgun_mk2.meta',
	'weapon/weapons/recul/weapons_revolver_mk2.meta',
	'weapon/weapons/recul/weapons_smg_mk2.meta',
	'weapon/weapons/recul/weapons_snspistol_mk2.meta',
	'weapon/weapons/recul/weapons_specialcarbine_mk2.meta',
	'weapon/weapons/recul/weaponsnspistol.meta',
	'weapon/weapons/recul/weaponspecialcarbine.meta',
	'weapon/weapons/recul/weaponvintagepistol.meta',
	'weapon/weapons/melee/weaponknuckle.meta',
	'weapon/weapons/melee/weaponswitchblade.meta',
	'weapon/weapons/melee/weaponbottle.meta',
	'weapon/weapons/melee/weaponpoolcue.meta',
	--lesslethal
	'weapon/weapons/lesslethal/weaponarchetypes.meta',
	'weapon/weapons/lesslethal/weaponcomponents.meta',
	'weapon/weapons/lesslethal/weaponanimations.meta',
	'weapon/weapons/lesslethal/weapon_lesslethal.meta'
}

data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/weaponsnowball.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/weapons_doubleaction.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/weaponflaregun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/weapons.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/weaponrailgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/weapons_spacerangers.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/weapons_pistol_mk2.meta'

data_file 'WEAPON_METADATA_FILE' 'weapon/weapons/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weapon/weapons/weaponanimations.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weapon/weapons/weaponanimations2.meta'
data_file 'LOADOUTS_FILE' 'weapon/weapons/loadouts.meta'
data_file 'WEAPONINFO_FILE' 'weapon/weapons/weaponsora.meta'
data_file 'PED_PERSONALITY_FILE' 'weapon/weapons/pedpersonality.meta'
data_file 'PED_PERSONALITY_FILE' 'weapon/weapons/pedpersonality2.meta'
data_file 'EXPLOSION_INFO_FILE' 'weapon/weapons/explosion.ymt'

data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponautoshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponbullpuprifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponcombatpdw.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponcompactrifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapondbshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponfirework.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapongusenberg.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponheavypistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponheavyshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponmachinepistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponmarksmanpistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponmarksmanrifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponminismg.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponmusket.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponrevolver.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_assaultrifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_bullpuprifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_carbinerifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_combatmg_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_heavysniper_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_marksmanrifle_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_pumpshotgun_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_revolver_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_smg_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_snspistol_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weapons_specialcarbine_mk2.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponsnspistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponspecialcarbine.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/recul/weaponvintagepistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/melee/weaponknuckle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/melee/weaponswitchblade.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/melee/weaponbottle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapon/weapons/melee/weaponpoolcue.meta'

--lesslethal
data_file 'WEAPON_METADATA_FILE' 'weapon/weapons/lesslethal/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weapon/weapons/lesslethal/weaponanimations.meta'
data_file 'WEAPON_COMPONENTS_FILE' 'weapon/weapons/lesslethal/weaponcomponents.meta'
data_file 'WEAPONCOMPONENTSINFO_FILE' 'weapon/weapons/lesslethal/weaponcomponents.meta'
data_file 'WEAPONINFO_FILE' 'weapon/weapons/lesslethal/weapon_lesslethal.meta'


export "GetCore"
export "GetPlayerHUD"
export "GetPlayerBars"
export "SetPlayerHUD"
export "sendME"
export "ToggleDrain"
export "InitHungerThirst"


server_exports {
    'GetCore',
    "getCurrentGameType",
    "getCurrentMap",
    "changeGameType",
    "changeMap",
    "doesMapSupportGameType",
    "getMaps",
    "roundEnded"
}