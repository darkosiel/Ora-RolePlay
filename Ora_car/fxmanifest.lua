fx_version "adamant"
games {"gta5"}

lua54 "yes"

ui_page "ui/index.html"
files {
    "ui/index.html",
    "ui/assets/clignotant-droite.svg",
    "ui/assets/clignotant-gauche.svg",
    "ui/assets/feu-position.svg",
    "ui/assets/feu-route.svg",
    "ui/assets/fuel.svg",
    "ui/fonts/fonts/Roboto-Bold.ttf",
    "ui/fonts/fonts/Roboto-Regular.ttf",
    "ui/script.js",
    "ui/style.css",
    "ui/debounce.min.js"
}
client_script "cl_car.lua"
client_script "speedo.lua"
client_script "drift.lua"

