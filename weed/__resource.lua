resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
server_script '@mysql-async/lib/MySQL.lua'

client_script "cl_main.lua"
server_script "sv_main.lua"

ui_page 'ui/index.html'

files {
	'ui/bg.png',
	'ui/ferti-icone.png',
	'ui/weed-icon.png',
	'ui/water-icon.png',
	'ui/index.html',
	'ui/main.js',
	'ui/main.css',

}

exports "Ora"