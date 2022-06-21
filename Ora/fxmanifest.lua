fx_version "adamant"
games {"gta5"}

server_script "@mysql-async/lib/MySQL.lua"

ui_page('ui/menus/ui_inventory/ui/dist/index.html')

lua54 "yes"

dependencies {
    "Snoupinput",
    "PolyZone",
    "qtarget"
}

files{
    -- PlayersName
    "ui/menus/playersnames/template/template.lua",
    -- BossMenu
	'ui/menus/bossMenu/ui/job.jpg',
	'ui/menus/bossMenu/ui/script.js',
	'ui/menus/bossMenu/ui/Multicolore.ttf',
	'ui/menus/bossMenu/ui/pcdown.ttf',
	'ui/menus/bossMenu/ui/style.css',
    -- Inventory
	'ui/menus/ui_inventory/ui/ui/assets/img/items/*.png',
	'ui/menus/ui_inventory/ui/dist/index.html',
	'ui/menus/ui_inventory/ui/dist/main.js',
    -- Grossiste
    'core/modules/npc_jobs/wholesaler/ui/main.js',
    'core/modules/npc_jobs/wholesaler/ui/style.css',
    -- Jetsam
    'core/modules/jobs/jetsam/ui/main.js',
}

client_script "random.js"
server_script "sv_random.js"
files {
    "statics/data/*.json",
    "core/modules/world/submodule/ped/data/female_peds.json",
    "core/modules/world/submodule/ped/data/gang_peds.json",
}

server_scripts {
    "utils/vendor/sha1.js",
    "utils/vendor/uuid.js"
}


--- Statics data
client_script {
    "statics/assets/Animations.lua",
    "gameplay/illegal/xp/client.lua",
    "statics/assets/coffres.lua",
    "statics/assets/Items.lua",
    "statics/assets/peds.lua",
    "statics/assets/PublicsFarming.lua",
    "statics/assets/tenue_police.lua"
}
server_scripts {
    "statics/assets/Items.lua",
    "statics/assets/Jobs.lua"
}

client_scripts {
    "utils/sha1.lua",
    "utils/car_names.lua",
    "utils/vendor/rageui/rageui/RageUI.lua",
    "utils/vendor/rageui/rageui/Menu.lua",
    "utils/vendor/rageui/rageui/MenuController.lua",
    "utils/vendor/rageui/components/*.lua",
    "utils/vendor/rageui/rageui/elements/*.lua",
    "utils/vendor/rageui/rageui/items/*.lua",
    "utils/vendor/rageui/rageui/panels/*.lua",
    "utils/vendor/rageui/rageui/windows/UIHeritage.lua",
    "utils/vendor/natives-libraries/entity/client/basic.lua",
    "utils/vendor/natives-libraries/entity/client/ped.lua",
    "utils/vendor/natives-libraries/entity/client/animations.lua",
    "utils/vendor/natives-libraries/entity/client/freemode.lua",
    "utils/vendor/natives-libraries/entity/client.lua",
    "utils/vendor/natives-libraries/streaming/client.lua",
    "utils/vendor/natives-libraries/scaleform/client.lua",
    "utils/vendor/natives-libraries/screen/Prompt.lua",
    "utils/vendor/natives-libraries/screen/KeyboardInput.lua",
    "utils/vendor/natives-libraries/math/client.lua",
    "utils/vendor/natives-libraries/blips/client.lua",
    "utils/vendor/natives-libraries/zones/client.lua",
    "utils/vendor/natives-libraries/vehicle/client.lua",
    "utils/vendor/natives-libraries/zones/marker.lua",
    "utils/vendor/server-callback/client.lua",
    "utils/vendor/RageIB/client.lua",
    "utils/cl_zoneName.lua",
    "utils/crouch.lua",
    "utils/discord.lua",
    "utils/cl_drop.lua",
    "utils/dlarme_cl.lua",
    "utils/cl_deadLog.lua",
    "utils2/pause.lua"
}

server_scripts {
    "utils/vendor/server-callback/server.lua",
    "utils/vendor/natives-libraries/player/server.lua",
    "utils/vendor/player-event/sv_trigger.lua",
    "libs/helper/functions.lua",
    "libs/cartracking/server.lua",
    "libs/helper/uuid.lua",
    "utils/sv_users.lua",
    "utils/sv_admin_commands.lua",
    "utils/dlarme_sv.lua",
    "utils/sv_discord_webhooks.lua"
}


client_script {
    "libs/handler/commands/cl_commands.lua",
    "libs/handler/commands/help.lua",
    "libs/handler/position/client.lua",
    "libs/handler/spawned/client.lua",
    "libs/helper/uuid.lua",
    "libs/handler/call.lua",
    "libs/handler/comas.lua",
    "libs/handler/key.lua",
    "libs/cartracking/client.lua",
    "libs/mugroom/selector/class/camera.lua",
    "libs/mugroom/selector/class/ped.lua",
    "libs/mugroom/selector/selector.lua",
    "libs/mugroom/creator/class/camera.lua",
    "libs/mugroom/creator/class/ped.lua",
    "libs/mugroom/creator/class/ia.lua",
    "libs/mugroom/creator/creator.lua",
    "libs/mugroom/client.lua",
    "libs/player/client/handcuff.lua",
    "libs/player/client/job_handler.lua",
    "libs/player/client/money_handler.lua",
    "libs/player/client/player_handler.lua",
    --"libs/fuel/cl_fuel.lua",
    "libs/compass/cm_essentials.lua",
    "libs/compass/streetname_and_compass.lua",
    "libs/jumelles/binoculars.lua"
}

server_scripts {
    "libs/handler/commands/sv_commands.lua",
    "libs/handler/position/server.lua",
    "libs/handler/spawned/server.lua",
    "libs/mugroom/server.lua",
    "libs/player/server/inventory.lua",
    "libs/player/server/player_class.lua",
    "libs/player/server/position.lua",
    "libs/player/server/service.lua",
    "libs/player/server/settings.lua",
    "libs/player/server/skin.lua",
    "libs/player/server/status.lua",
    "libs/player/server/stockages.lua",
    --"libs/fuel/sv_fuel.lua"
}

client_script {
    "core/sh_core.lua",
    "core/cl_core.lua",
    "core/cl_misc.js",
    "core/modules/config/shared.lua",
    "core/modules/config/client.lua",
    "core/modules/consumable/shared.lua",
    "core/modules/consumable/submodules/alcohol/shared.lua",
    "core/modules/consumable/submodules/alcohol/client.lua",
    "core/modules/utils/shared.lua",
    "core/modules/utils/client.lua",
    "core/modules/config/data/*.lua",
    "core/modules/player/shared.lua",
    "core/modules/player/client.lua",
    "core/modules/inventory/shared.lua",
    "core/modules/inventory/client.lua",
    "core/modules/identity/shared.lua",
    "core/modules/identity/client.lua",
    "core/modules/identity/submodules/job/shared.lua",
    "core/modules/identity/submodules/job/client.lua",
    "core/modules/identity/submodules/orga/shared.lua",
    "core/modules/identity/submodules/orga/client.lua",
    "core/modules/zoneSystem/shared.lua",
    "core/modules/zoneSystem/client.lua",
    "ui/menus/handler.lua",
    --"ui/menus/cl_fuel.lua",
    "ui/menus/coffre.lua",
    "ui/menus/stockage.lua",
    "ui/menus/personnal/main.lua",
    "ui/menus/personnal/inventory.lua",
    "ui/menus/personnal/animations.lua",
    "ui/menus/personnal/admin.lua",
    "ui/menus/personnal/other.lua",
    "ui/menus/personnal/boss.lua",
    "ui/menus/personnal/vehicule.lua",
    "ui/menus/personnal/wallet.lua",
    "ui/menus/personnal/fouille.lua",
    "ui/menus/playersnames/playernames_api.lua",
    "ui/menus/playersnames/playernames_cl.lua",
    "ui/menus/mugroom/selector.lua",
    "ui/menus/mugroom/creator/main.lua",
    "ui/menus/mugroom/creator/categories/appearance.lua",
    "ui/menus/mugroom/creator/categories/clothes.lua",
    "ui/menus/mugroom/creator/categories/faceFeature.lua",
    "ui/menus/mugroom/creator/categories/heritage.lua",
    "ui/menus/mugroom/creator/categories/roleplayContent.lua",
    "ui/menus/jobs/ambulance.lua",
    "ui/menus/jobs/mecano.lua",
    "ui/menus/jobs/menuHandlerJob.lua",
    "ui/menus/jobs/police.lua",
    "ui/menus/jobs/tow_menu.lua",
    "ui/menus/crafting/main.lua",
}

client_script {
    "@PolyZone/client.lua",
    "core/modules/health/shared.lua",
    "core/modules/health/client.lua",
    "core/modules/world/shared.lua",
    "core/modules/world/client.lua",
    "core/modules/world/submodule/vehicle/shared.lua",
    "core/modules/world/submodule/vehicle/client.lua",
    "core/modules/world/submodule/ped/shared.lua",
    "core/modules/world/submodule/ped/client.lua",
    "core/modules/world/submodule/object/shared.lua",
    "core/modules/world/submodule/object/client.lua",
    "core/modules/world/submodule/appart/client.lua",
    "core/modules/world/submodule/weapon/shared.lua",
    "core/modules/world/submodule/weapon/client.lua",
    "core/modules/world/submodule/hunt/shared.lua",
    "core/modules/world/submodule/hunt/client.lua",
    "core/modules/payment/shared.lua",
    "core/modules/payment/client.lua",
    "core/modules/service/shared.lua",
    "core/modules/service/client.lua",
    "core/modules/drugselling/shared.lua",
    "core/modules/drugselling/client.lua",
    "core/modules/jobs/shared.lua",
    "core/modules/jobs/immo/shared.lua",
    "core/modules/jobs/immo/client.lua",
    "core/modules/jobs/immo/menu/edit.lua",
    "core/modules/jobs/immo/menu/informations.lua",
    "core/modules/jobs/immo/menu/sell_and_rent.lua",
    "core/modules/jobs/bleaching/shared.lua",
    "core/modules/jobs/bleaching/client.lua",
    "core/modules/jobs/casino/shared.lua",
    "core/modules/jobs/casino/client.lua",
    "core/modules/jobs/casino/submodules/insidetrack/shared.lua",
    "core/modules/jobs/casino/submodules/insidetrack/client/utils.lua",
    "core/modules/jobs/casino/submodules/insidetrack/client/presets.lua",
    "core/modules/jobs/casino/submodules/insidetrack/client/client.lua",
    "core/modules/jobs/casino/submodules/insidetrack/client/bigScreen.lua",
    "core/modules/jobs/casino/submodules/insidetrack/client/screens/*.lua",
    "core/modules/jobs/jetsam/shared.lua",
    "core/modules/jobs/jetsam/config.lua",
    "core/modules/jobs/jetsam/client.lua",
    "core/modules/jobs/firefighter/shared.lua",
    "core/modules/jobs/firefighter/client.lua",
    "core/modules/jobs/firefighter/client/utils.lua",
    "core/modules/jobs/firefighter/client/fire.lua",
    "core/modules/jobs/firefighter/client/dispatch.lua",
    "core/modules/jobs/firefighter/client/main.lua",
    "core/modules/jobs/drivingschool/shared.lua",
    "core/modules/jobs/drivingschool/client.lua",
    "core/modules/npc_jobs/shared.lua",
    "core/modules/npc_jobs/client.lua",
    "core/modules/npc_jobs/bank/shared.lua",
    "core/modules/npc_jobs/bank/client.lua",
    "core/modules/npc_jobs/wholesaler/shared.lua",
    "core/modules/npc_jobs/wholesaler/client.lua",
    "core/modules/npc_jobs/drivingschool/shared.lua",
    "core/modules/npc_jobs/drivingschool/client.lua",
    "core/modules/anticheat/shared.lua",
    "core/modules/anticheat/client.lua",
    "core/modules/illegal/shared.lua",
    "core/modules/illegal/client.lua",
    "core/modules/illegal/config/*.lua",
    "core/modules/illegal/missions/carjacking/client.lua",
    "core/modules/illegal/missions/gofast/shared.lua",
    "core/modules/illegal/missions/gofast/data/loading_positions.lua",
    "core/modules/illegal/missions/gofast/data/delivery_positions.lua",
    "core/modules/illegal/missions/gofast/client.lua",
    "core/modules/illegal/missions/carRoberry/shared.lua",
    "core/modules/illegal/missions/carRoberry/client.lua",

    -- "core/modules/dev/shared.lua",
    -- "core/modules/dev/client.lua"
}

server_script {
    "core/sh_core.lua",
    "core/sv_core.lua",
    "core/modules/config/shared.lua",
    "core/modules/config/server.lua",
    "core/modules/consumable/shared.lua",
    "core/modules/consumable/submodules/alcohol/shared.lua",
    "core/modules/consumable/submodules/alcohol/server.lua",
    "core/modules/utils/shared.lua",
    "core/modules/utils/server.lua",
    "core/modules/identity/shared.lua",
    "core/modules/identity/server.lua",
    "core/modules/identity/submodules/job/shared.lua",
    "core/modules/identity/submodules/job/server.lua",
    "core/modules/identity/submodules/orga/shared.lua",
    "core/modules/identity/submodules/orga/server.lua",
    "core/modules/player/shared.lua",
    "core/modules/player/server.lua",
    "core/modules/health/shared.lua",
    "core/modules/health/server.lua",
    "core/modules/world/shared.lua",
    "core/modules/world/server.lua",
    "core/modules/world/submodule/vehicle/shared.lua",
    "core/modules/world/submodule/vehicle/server.lua",
    "core/modules/world/submodule/appart/server.lua",
    "core/modules/world/submodule/object/shared.lua",
    "core/modules/world/submodule/object/server.lua",
    "core/modules/world/submodule/ped/shared.lua",
    "core/modules/world/submodule/ped/server.lua",
    "core/modules/routingBucket/shared.lua",
    "core/modules/routingBucket/server.lua",
    "core/modules/instance/shared.lua",
    "core/modules/instance/server.lua",
    "core/modules/inventory/shared.lua",
    "core/modules/inventory/server.lua",
    "core/modules/payment/shared.lua",
    "core/modules/payment/server.lua",
    "core/modules/service/shared.lua",
    "core/modules/service/server.lua",
    "core/modules/drugselling/shared.lua",
    "core/modules/drugselling/server.lua",
    "core/modules/jobs/shared.lua",
    "core/modules/jobs/server.lua",
    "core/modules/jobs/immo/shared.lua",
    "core/modules/jobs/immo/server.lua",
    "core/modules/jobs/bleaching/shared.lua",
    "core/modules/jobs/bleaching/server.lua",
    "core/modules/jobs/casino/shared.lua",
    "core/modules/jobs/casino/server.lua",
    "core/modules/jobs/casino/submodules/insidetrack/shared.lua",
    "core/modules/jobs/casino/submodules/insidetrack/server/server.lua",
    "core/modules/jobs/jetsam/shared.lua",
    "core/modules/jobs/jetsam/server.lua",
    "core/modules/jobs/firefighter/shared.lua",
    "core/modules/jobs/firefighter/server.lua",
    "core/modules/jobs/firefighter/server/utils.lua",
    "core/modules/jobs/firefighter/server/whitelist.lua",
    "core/modules/jobs/firefighter/server/fire.lua",
    "core/modules/jobs/firefighter/server/dispatch.lua",
    "core/modules/jobs/firefighter/server/main.lua",
    "core/modules/jobs/drivingschool/shared.lua",
    "core/modules/jobs/drivingschool/server.lua",
    "core/modules/npc_jobs/shared.lua",
    "core/modules/npc_jobs/server.lua",
    "core/modules/npc_jobs/bank/shared.lua",
    "core/modules/npc_jobs/bank/server.lua",
    "core/modules/npc_jobs/ambulance/shared.lua",
    "core/modules/npc_jobs/ambulance/server.lua",
    "core/modules/npc_jobs/wholesaler/shared.lua",
    "core/modules/npc_jobs/wholesaler/server.lua",
    "core/modules/npc_jobs/drivingschool/shared.lua",
    "core/modules/npc_jobs/drivingschool/server.lua",
    "core/modules/anticheat/shared.lua",
    "core/modules/anticheat/server.lua",
    "core/modules/illegal/shared.lua",
    "core/modules/illegal/server.lua",
    "core/modules/illegal/config/*.lua",
    "core/modules/illegal/missions/gofast/shared.lua",
    "core/modules/illegal/missions/gofast/server.lua",
    "core/modules/zoneSystem/shared.lua",
    "core/modules/zoneSystem/server.lua",

    -- "core/modules/dev/shared.lua",
    -- "core/modules/dev/server.lua"
}

server_script {
    "gameplay/illegal/orga/sh_orga.class.lua",
    "gameplay/illegal/orga/sv_orga.class.lua",
    "gameplay/illegal/pneu/sv_pneu.lua",
    "gameplay/illegal/labo_weapon_warehouse/sh_labo_warehouse.class.lua",
    "gameplay/illegal/labo_weapon_warehouse/sh_lab_warehouse_attack.class.lua",
    "gameplay/illegal/labo_weapon_warehouse/sv_labo_warehouse.class.lua",
    "gameplay/illegal/labo_weapon_warehouse/sv_labo_warehouse_attack.class.lua",
}

client_script {
    "utils/cl_blips.lua",
    "utils/cl_carjack.lua",
    "utils/cl_sit.lua",
    "utils/cl_suicide.lua",
    "utils/test/cl_test.lua",
    "utils/vendor/player-event/cl_trigger.lua"
}

client_script {
    "gameplay/illegal/drugs/cl_drugbuyer.lua",
    "gameplay/illegal/atm_robbery/client.lua",
    "gameplay/illegal/atm_robbery/config.lua",
    "gameplay/illegal/burglary/cl_burglary.lua",
    "gameplay/illegal/burglary/sh_config.lua",
    "gameplay/illegal/fleeca/client.lua",
    "gameplay/illegal/pneu/cl_pneu.lua",
    "gameplay/illegal/fleeca/utk.lua",
    "gameplay/illegal/prison/client.lua",
    "gameplay/illegal/mission/config.lua",
    "gameplay/illegal/mission/client/*.lua",
    "gameplay/illegal/drugs/npc_sell.lua",
    "gameplay/illegal/otage/cl_takehostage.lua",
    "gameplay/illegal/clown/cl_central.lua",
    "gameplay/illegal/braquages/cl_shop.lua",
    "gameplay/items/item_handler_cl.lua",
    "gameplay/items/newspaper_stand.lua",
    "gameplay/jobs/facture.lua",
    "gameplay/jobs/banking/job/client.lua",
    "gameplay/jobs/ammunation/job.lua",
    "gameplay/jobs/distillerie/job.lua",
    "gameplay/jobs/police/job.lua",
    "gameplay/jobs/basic/basicWork.lua",
    "gameplay/jobs/basic/cl_farming.lua",
    "gameplay/jobs/basic/clotheRoom.lua",
    "gameplay/jobs/concess/*.lua",
    "gameplay/jobs/haircut/client.lua",
    "gameplay/jobs/tatoo/client.lua",
    -- "gameplay/jobs/taxi/client.lua",
    -- "gameplay/jobs/taxi/config.lua",
    "gameplay/jobs/weazle/client.lua",
    "gameplay/jobs/ponsoboy/client.lua",
    "gameplay/jobs/binco/client.lua",
    "gameplay/jobs/binco/nord_cl.lua",
    "gameplay/jobs/immo/cl_immo.lua",
    "gameplay/jobs/labo_placer/cl_labo.lua",
    "gameplay/jobs/jobLister/jobLister.lua",
    "gameplay/jobs/fueler/config.lua",
    "gameplay/jobs/fueler/client.lua",
    "gameplay/jobs/hacker/cl_hacker.lua",
    "gameplay/shops/clothes/*.lua",
    "gameplay/shops/shop/sh_illegal.lua",
    "gameplay/shops/shop/cl_*.lua",
    "gameplay/shops/vehicle/cl_vehshop.lua",
    "gameplay/shops/vehicle/cl_vehshop_nord.lua",
    "gameplay/shops/vehicle/cl_motoshop.lua",
    "gameplay/world/cl_banweapon.lua",
    "gameplay/vehicle/cl_coffre.lua",
    "gameplay/vehicle/cl_permis.lua",
    "gameplay/vehicle/garage/garage.lua",
    "gameplay/vehicle/chopper_cam/heli_client.lua",
    "gameplay/vehicle/lock/*.lua",
    "gameplay/vehicle/sirene/client.lua",
    "gameplay/vehicle/mecanos/*.lua",
    "gameplay/vehicle/mecanos/tow/cl_tow.lua",
    "gameplay/world/cl_appart.lua",
    "gameplay/world/cl_computer.lua",
    "gameplay/world/cl_anticarjack.lua",
    --"gameplay/civilian/treasurehunt/config.lua",
    --"gameplay/civilian/treasurehunt/client.lua",
    "gameplay/civilian/Carry/cl_carry.lua",
    "gameplay/civilian/gym/gym_cfg.lua",
    "gameplay/civilian/gym/gym_cl.lua",
    "gameplay/civilian/fishing/fishing_cfg.lua",
    "gameplay/civilian/fishing/fishing_cl.lua", 
    "gameplay/civilian/clubspeaker/config.lua",
    "gameplay/civilian/clubspeaker/client/main.lua",
    "gameplay/civilian/shooting_range/config.lua",
    "gameplay/civilian/shooting_range/client.lua",
    "gameplay/civilian/karting/config.lua",
    "gameplay/civilian/karting/client.lua",
    "gameplay/illegal/race/config.lua",
    "gameplay/illegal/race/races_cl.lua",
    "ui/menus/bossMenu/client/cl_boss.lua",
    "ui/menus/ui_inventory/client/main.lua",
}

server_scripts {
    "ui/menus/playersnames/playernames_api.lua",
    "ui/menus/playersnames/playernames_sv.lua",
    "gameplay/civilian/casino/server.lua",
    "gameplay/civilian/Carry/sv_carry.lua",
    --"gameplay/civilian/treasurehunt/server.lua",

    "gameplay/civilian/shooting_range/server.lua",
    "gameplay/civilian/karting/server.lua",
    "gameplay/illegal/drugs/sv_drugbuyer.lua",
    "gameplay/illegal/otage/sv_takehostage.lua",
    "gameplay/illegal/atm_robbery/config.lua",
    "gameplay/illegal/atm_robbery/server.lua",
    "gameplay/illegal/burglary/sv_burglary.lua",
    "gameplay/illegal/burglary/sh_config.lua",
    "gameplay/illegal/fleeca/server.lua",
    "gameplay/illegal/fleeca/utk.lua",
    "gameplay/illegal/clown/sv_central.lua",
    "gameplay/illegal/mission/config.lua",
    "gameplay/illegal/mission/server/*.lua",
    "gameplay/illegal/status/sv_persistantStatus.lua",
    "gameplay/jobs/banking/banking_class.lua",
    "gameplay/jobs/basic/sv_farming.lua",
    "gameplay/jobs/immo/sv_immo.lua",
    "gameplay/jobs/labo_placer/sv_labo.lua",
    "gameplay/jobs/joblister/sv_jobLister.lua",
    "gameplay/jobs/weazle/server.lua",
    "gameplay/jobs/fueler/config.lua",
    "gameplay/jobs/fueler/server.lua",
    -- "gameplay/jobs/taxi/config.lua",
    -- "gameplay/jobs/taxi/server.lua",
    "gameplay/jobs/hacker/sv_hacker.lua",
    "gameplay/shops/shop/sh_illegal.lua",
    "gameplay/shops/shop/sv_*.lua",
    "gameplay/shops/vehicle/sv_vehshop.lua",
    "gameplay/shops/vehicle/sv_vehshop_nord.lua",
    "gameplay/shops/vehicle/sv_motoshop.lua",
    "gameplay/vehicle/garage/sv_garage.lua",
    "gameplay/vehicle/sirene/server.lua",
    "gameplay/vehicle/chopper_cam/heli_server.lua",
    "gameplay/vehicle/mecanos/tow/sv_tow.lua",
    "gameplay/world/sv_computer.lua",
    "gameplay/world/sv_banweapon.lua",
    "gameplay/civilian/clubspeaker/server/main.lua",
    "gameplay/illegal/race/config.lua",
    "gameplay/illegal/race/races_sv.lua",
    "ui/menus/bossMenu/server/sv_boss.lua",
    "gameplay/jobs/unicorn/server.lua",
    "gameplay/jobs/police/job_sv.lua",
    "gameplay/vehicle/sv_permis.lua",
}

client_scripts {
    "statics/assets/Jobs.lua",
    "libs/helper/functions.lua",
    "libs/teleport.lua"
}

-- Class Object
client_script {
    "gameplay/illegal/orga/sh_orga.class.lua",
    "gameplay/illegal/orga/cl_orga.class.lua",
    -- Labo & Weapon Warehouse
    "gameplay/illegal/labo_weapon_warehouse/sh_labo_warehouse.class.lua",
    "gameplay/illegal/labo_weapon_warehouse/cl_labo_warehouse.class.lua",
    -- Lab & Weapon Warehouse Attack
    "gameplay/illegal/labo_weapon_warehouse/sh_lab_warehouse_attack.class.lua",
    "gameplay/illegal/labo_weapon_warehouse/cl_lab_warehouse_attack.class.lua",
    -- Lab & Weapon Menu
    "gameplay/illegal/labo_weapon_warehouse/menu/cl_druglab.lua",
    "gameplay/illegal/labo_weapon_warehouse/menu/cl_gunleader.lua",
    -- Lab & Weapon Delivery
    "gameplay/illegal/labo_weapon_warehouse/delivery/cl_gunleader_delivery.lua"
}


------------ EXPORTS

export "OnNewPlayerSpawn"
export "OnPlayerSpawn"
export "ShowNotification"
export "TriggerServerCallback"
export "LoadingPrompt"
export "SetCoords"
export "UpdatePlayerPedFreemodeCharacter"
export "GenerateEntityFace"
export "GenerateEntityTattoo"
export "GenerateEntityOutfit"
export "GenerateFreemodeModel"
export "GetItemsData"
export "TriggerPlayerEvent"
server_export "RegisterServerCallback"
export "GetGroup"
export "OpenCar"

-- Inventory exports

export "AddItem"
export "RemoveItem"
export "GetItemCount"
export "RemoveFirstItem"

-- Identity exports

export "OraGetJob"
export "OraGetOrga"

-- Player exports

export "OraPlayerHasLoaded"
