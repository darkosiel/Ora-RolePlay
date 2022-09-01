fx_version "cerulean"
games { "gta5" }

dependencies {
    'pma-voice',
}

server_scripts {
    'server/server.js',
}
client_scripts {
    'client/client.js',
}

ui_page "html/index.html"

files {
    "html/assets/styles/font/*.woff",
    "html/assets/styles/font/SF-Pro/*.woff",
    "html/assets/*.png",
    "html/assets/images/*.jpg",
    "html/assets/images/wallpaper/*.jpg",
    "html/assets/images/app-icon/*.png",
    "html/assets/images/contacts-profile-icon/*.png",
    "html/assets/sounds/*.mp3",
    "html/assets/sounds/alarms/*.mp3",
    "html/assets/sounds/notifications/*.mp3",
    "html/assets/sounds/ringings/*.mp3",
	"html/font/style.css",
    "html/assets/styles/style.css",
	"html/jquery.textfill.min.js",
    "html/script.js",
    "html/index.html",
}