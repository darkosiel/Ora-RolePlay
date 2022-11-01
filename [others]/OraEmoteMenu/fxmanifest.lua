fx_version "cerulean"
games { "gta5" }

ui_page "html/index.html"

shared_scripts {
    'AnimationList.lua',
}

client_scripts {
    "Config.lua",
    "client/main.lua",
}

server_scripts {
    "server/main.lua",
    -- '@mysql-async/lib/MySQL.lua',
    "@Ora_dep/MySQL/lib/MySQL.lua"
}

files {
    "html/style.css",
    "html/script.js",
    "html/index.html",
}