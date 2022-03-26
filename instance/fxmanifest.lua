fx_version "adamant"

game "gta5"

description "Instance"

version "1.1.0"

function _U(string)
    return string
end

server_scripts {
    "config.lua",
    "server/main.lua"
}

client_scripts {
    "config.lua",
    "client/main.lua"
}
