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
        pos = vector3(-1381.01, -616.17, 31.5),
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
        name = 'mirror',
        pos = vector3(-1297.10, -1036.75, 13.16 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Little Seoul',
        pos = vector3(-841.3932, -717.3964, 29.28 - 0.98),
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
        name = 'djset',
        pos = vector3(683.78, 569.74, 130.46 - 0.98),
        requiredJob = nil, 
        range = 90.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    }

    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}