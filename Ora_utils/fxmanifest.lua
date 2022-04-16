fx_version "adamant"
games {"gta5"}
lua54 "yes"

client_scripts {
    --"3dme_cl.lua",
    --"pause.lua",
    --"cl_fuel.lua",
    --"cl_utils.lua",
    "cl_status.lua",
   -- "ac.lua",
    --"cl_explosion.lua",
    "reticle/Client.net.dll",
    "crouch.lua"
}

server_scripts {
    --"sv_fuel.lua",
    "sv_alcohol.lua",
    "@mysql-async/lib/MySQL.lua",
   -- "3dme_sv.lua",
   -- "sv_explosion.lua",
   --"sv_utils.lua",
}

export "GetPlayerHUD"
export "GetPlayerBars"
export "SetPlayerHUD"
export "sendME"
export "ToggleDrain"
export "InitHungerThirst"
