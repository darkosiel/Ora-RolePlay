Config = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Drücke ~g~E~s~, um auf das DJ Pult zuzugreifen',
        ['title_does_not_exist'] = '~r~Dieser Titel existiert nicht!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Press ~g~E~s~, to access the DJ desk',
        ['title_does_not_exist'] = '~r~This title does not exist!',
    },

    ['fr'] = {
        ['DJ_interact'] = 'Appuyer sur ~g~E~s~, pour accéder aux platines',
        ['title_does_not_exist'] = '~r~Ce titre est inexistant !',
    }
}

Config.Locale = 'fr'

Config.useESX = false -- can not be disabled without changing the callbacks
Config.enableCommand = false

Config.enableMarker = true -- purple marker at the DJ stations

Config.DJPositions = {
    {
        name = 'bahama',
        pos = vector3(-1378.5733, -629.3204, 30.62),
        requiredJob = nil, 
        range = 25.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'unicorn',
        pos = vector3(120.71, -1281.43, 29.48 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'yellowjack',
        pos = vector3(1987.3769, 3051.1013, 47.21 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Studio musique',
        pos = vector3(-890.4815, -449.0027, 161.21 - 0.98),
        requiredJob = nil, 
        range = 10.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Studio musique2',
        pos = vector3(-883.8588, -444.9008, 161.21 - 0.98),
        requiredJob = nil, 
        range = 10.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'mirror',
        pos = vector3(-1297.10, -1036.75, 13.16 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Little Seoul',
        pos = vector3(-162.1517, 298.0057, 93.76 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'tequilala',
        pos = vector3(-560.61, 281.97, 87.67 - 0.98),
        requiredJob = nil, 
        range = 15.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Galaxy',
        pos = vector3(-1603.9594, -3012.4260, -77.96 - 0.98),
        requiredJob = nil, 
        range = 15.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'henhouse',
        pos = vector3(-312.4682, 6264.6762, 32.0590 - 0.98),
        requiredJob = nil, 
        range = 19.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Mayans MC',
        pos = vector3(12.7061, 6457.2084, 31.55 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'biker',
        pos = vector3(9799.5449, -1468.5621, 31.51 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'djset',
        pos = vector3(683.78, 569.74, 130.46 - 0.98),
        requiredJob = nil, 
        range = 90.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    }

    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}