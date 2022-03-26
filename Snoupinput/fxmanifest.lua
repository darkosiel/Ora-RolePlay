fx_version 'adamant'

game 'gta5'

ui_page('index.html')

files {
  "index.html",
  "raphael.min.js",
  "wheelnav.min.js",
  "index.js",
  "script.js",
  "style.css"
}

client_scripts {
	"client.lua"
}

exports "ShowInput"
exports "ShowMultipleInpt"
exports "GetInput"
