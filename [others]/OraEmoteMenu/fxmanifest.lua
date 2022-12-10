fx_version "cerulean"
games { "gta5" }

lua54 'yes'

ui_page "html/index.html"

client_scripts {
    "Config.lua",
    "client/main.lua",
}

shared_scripts {
    'AnimationList.lua',
}

server_scripts {
    "server/main.lua",
    '@mysql-async/lib/MySQL.lua',
    -- "@Ora_dep/MySQL/lib/MySQL.lua"
}

files {
    "html/style.css",
    "html/script.js",
    "html/index.html",
}