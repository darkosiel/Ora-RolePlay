fx_version "cerulean"
games { "gta5" }

ui_page "html/index.html"

shared_scripts {
    'AnimationList.lua',
}

client_scripts {
    "client/main.lua",
    "Config.lua",
}

server_scripts {
    "server/main.lua",
    -- '@Framework/lib/MySQL.lua',
    '@mysql-async/lib/MySQL.lua',
}

files {
    "html/style.css",
    "html/script.js",
    "html/index.html",
}