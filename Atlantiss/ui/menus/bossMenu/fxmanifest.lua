fx_version "adamant"
games {"gta5"}

ui_page('ui/index.html')

lua54 "yes"

files{
	'ui/index.html',
	'ui/job.jpg',
	'ui/script.js',
	'ui/Multicolore.ttf',
	'ui/pcdown.ttf',
	'ui/style.css'
}

client_script {
	"client/cl_boss.lua",
}

server_script {
	"server/sv_boss.lua"
}
