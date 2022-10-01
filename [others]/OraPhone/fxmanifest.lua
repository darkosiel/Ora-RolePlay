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
    'client/main.lua',
}

ui_page "html/index.html"

files {
    "html/module/*.js",
    "html/module/animation/tracks/*.js",
    "html/module/animation/*.js",
    "html/module/audio/*js",
    "html/module/cameras/*.js",
    "html/module/core/*.js",
    "html/module/extras/core/*.js",
    "html/module/extras/curves/*.js",
    "html/module/extras/objects/*.js",
    "html/module/extras/*.js",
    "html/module/geometries/*.js",
    "html/module/helpers/*.js",
    "html/module/lights/*.js",
    "html/module/loaders/*.js",
    "html/module/materials/*.js",
    "html/module/math/interpolants/*.js",
    "html/module/math/*.js",
    "html/module/objects/*.js",
    "html/module/renderers/shaders/*.js",
    "html/module/renderers/shaders/ShaderChunk/*.js",
    "html/module/renderers/shaders/ShaderLib/*.js",
    "html/module/renderers/webgl/*.js",
    "html/module/renderers/webxr/*.js",
    "html/module/renderers/webvr/*.js",
    "html/module/renderers/*.js",
    "html/module/scenes/*.js",
    "html/module/textures/*.js",
    "html/utk_render.js",
    "html/assets/styles/font/**/*.woff",
    "html/assets/*.png",
    "html/assets/images/**/*.png",
    "html/assets/images/**/*.jpg",
    "html/assets/sounds/**/*.mp3",
	"html/font/style.css",
    "html/assets/styles/style.css",
	"html/jquery.textfill.min.js",
    "html/script.js",
    "html/index.html",
}

export 'print_table'
server_export 'RegisterNewPhone'