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
    }

    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}