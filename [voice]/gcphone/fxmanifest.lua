fx_version "adamant"
games {"gta5"}

ui_page "html/index.html"

files {
    "html/index.html",
    "html/static/css/app.css",
    "html/static/js/app.js",
    "html/static/js/manifest.js",
    "html/static/js/vendor.js",
    "html/static/config/config.json",
    -- Coque
    "html/static/img/coque/s8.png",
    "html/static/img/coque/iphonex.png",
    "html/static/img/coque/iphone.png",
    "html/static/img/coque/base.png",
    "html/static/img/coque/transparent.png",
    "html/static/img/coque/wiko.png",
    "html/static/img/coque/huawei.png",
    -- Background
    "html/static/img/background/back000.jpg",
    "html/static/img/background/back001.jpg",
    "html/static/img/background/back002.jpg",
    "html/static/img/background/back003.jpg",
    "html/static/img/background/back004.jpg",
    "html/static/img/background/back005.jpg",
    "html/static/img/background/back006.jpg",
    "html/static/img/background/back007.jpg",
    "html/static/img/background/back008.jpg",
    "html/static/img/background/back009.jpg",
    "html/static/img/background/back010.jpg",
    "html/static/img/background/back011.jpg",
    "html/static/img/background/back012.jpg",
    "html/static/img/background/back013.jpg",
    "html/static/img/background/back014.jpg",
    "html/static/img/background/back015.jpg",
    "html/static/img/background/back016.jpg",
    "html/static/img/background/back017.jpg",
    "html/static/img/background/back018.jpg",
    "html/static/img/background/back019.jpg",
    "html/static/img/background/back020.jpg",
    "html/static/img/background/back021.jpg",
    "html/static/img/background/back022.jpg",
    "html/static/img/background/back023.jpg",
    "html/static/img/background/back024.jpg",
    "html/static/img/background/back025.jpg",
    "html/static/img/background/back026.jpg",
    "html/static/img/background/back027.jpg",
    "html/static/img/background/back028.jpg",
    "html/static/img/background/back029.jpg",
    "html/static/img/background/back030.jpg",
    "html/static/img/background/back031.jpg",
    "html/static/img/icons_app/call.png",
    "html/static/img/icons_app/contacts.png",
    "html/static/img/icons_app/sms.png",
    "html/static/img/icons_app/settings.png",
    "html/static/img/icons_app/menu.png",
    "html/static/img/icons_app/bourse.png",
    "html/static/img/icons_app/tchat.png",
    "html/static/img/icons_app/photo.png",
    "html/static/img/icons_app/bank.png",
    "html/static/img/icons_app/9gag.png",
    "html/static/img/icons_app/twitter.png",
    "html/static/img/contact/lspd.png",
    "html/static/img/contact/lssd.png",
    "html/static/img/contact/lsms.png",
    "html/static/img/contact/lsfd.png",
    "html/static/img/contact/bennys.png",
    "html/static/img/contact/lscustoms.png",
    "html/static/img/contact/fib.png",
    "html/static/img/contact/weazel.png",
    "html/static/img/contact/flywheelsatl.png",
    "html/static/img/contact/state.png",
    "html/static/img/contact/taxi.png",
    "html/static/img/contact/uber.png",
    "html/static/img/contact/avocat.png",
    "html/static/img/contact/larrys.png",
    "html/static/img/contact/beekers.png",
    "html/static/img/contact/ltd.png",
    "html/static/img/app_bank/logo_mazebank.jpg",
    "html/static/img/app_tchat/splashtchat.png",
    "html/static/img/twitter/bird.png",
    "html/static/img/twitter/default_profile.png",
    "html/static/sound/Twitter_Sound_Effect.ogg",
    "html/static/img/courbure.png",
    "html/static/fonts/fontawesome-webfont.ttf",
    "html/static/sound/ring.ogg",
    "html/static/sound/ring2.ogg",
    "html/static/sound/tchatNotification.ogg",
    "html/static/sound/Phone_Call_Sound_Effect.ogg"
}

dependencies {
    "saltychat"
}

client_script {
    "config.lua",
    "client/animation.lua",
    "client/client.lua",
    "client/photo.lua",
    "client/app_tchat.lua",
    "client/bank.lua",
    "client/twitter.lua"
}

server_script {
    "@mysql-async/lib/MySQL.lua",
    "config.lua",
    "server/server.lua",
    "server/app_tchat.lua",
    "server/twitter.lua"
}
