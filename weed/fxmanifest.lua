export "Ora"

fx_version "adamant"

game "gta5"

files {
	'ui/bg.png',
	'ui/ferti-icone.png',
	'ui/weed-icon.png',
	'ui/water-icon.png',
	'ui/index.html',
	'ui/main.js',
	'ui/main.css',
}

server_scripts {
    '@Ora_dep/MySQL/lib/MySQL.lua',
    'sv_main.lua'
}

client_script {
	"cl_main.lua"
}

ui_page 'ui/index.html'
