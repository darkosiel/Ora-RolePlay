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
        pos = vector3(-1390.0961, -605.7287, 31.51 - 0.98),
        requiredJob = nil, 
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'unicorn',
        pos = vector3(111.42, -1299.72, 22.07 - 0.98),
        requiredJob = nil, 
        range = 45.0, 
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
        pos = vector3(375.42, 275.95, 92.40 - 0.98),
        requiredJob = nil, 
        range = 26.5, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Galaxy2',
        pos = vector3(398.35, 251.16, 92.05 - 0.98),
        requiredJob = nil, 
        range = 25.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'CafeCoretto',
        pos = vector3(-1191.6643, -1392.5897, 10.92 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
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
        pos = vector3(979.5449, -1468.5621, 31.51 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'yolac',
        pos = vector3(-165.06, 866.18, 232.69 - 0.98),
        requiredJob = nil, 
        range = 35.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'djset',
        pos = vector3(683.78, 569.74, 130.46 - 0.98),
        requiredJob = nil, 
        range = 90.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'malone',
        pos = vector3(420.4986, -1492.7403, 33.80 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
       name = 'cityhall',
       pos = vector3(-1719.62, -193.47, 64.27),
       requiredJob = nil, 
       range = 70.0, 
       volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'pearls',
        pos = vector3(-1831.36, -1190.14, 19.64),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
     },
    {
        name = 'gouvhouse',
        pos = vector3(-1433.413208, 208.506119, 57.823853 - 0.98),
        requiredJob = nil, 
        range = 30.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Houseplaya',
        pos = vector3(-3022.3198, 39.7840, 10.1177 - 0.98),
        requiredJob = nil, 
        range = 60.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Cayo',
        pos = vector3(4893.51, -4904.50, 3.48 - 0.98),
        requiredJob = nil, 
        range = 80.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Human',
        pos = vector3(59.6, -1018.26, 79.77 - 0.98),
        requiredJob = nil, 
        range = 14000.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Bennys',
        pos = vector3(-214.7577, -1313.6761, 34.6970 - 0.98),
        requiredJob = nil, 
        range = 50.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'LS Custom',
        pos = vector3(-337.0431, -133.8932,  39.0096 - 0.98),
        requiredJob = nil, 
        range = 50.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Tatoo plage',
        pos = vector3(-1150.2399, -1425.6680, 4.9559 - 0.98),
        requiredJob = nil, 
        range = 13.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Tatoo Empayeur',
        pos = vector3(320.2938, 183.2700, 103.58 - 0.98),
        requiredJob = nil, 
        range = 13.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Label',
        pos = vector3(722.2350, 2534.0502, 73.50 - 0.98),
        requiredJob = nil, 
        range = 13.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Boxe',
        pos = vector3(1051.8131, -2395.9929, 25.89 - 0.98),
        requiredJob = nil, 
        range = 20.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    {
        name = 'Paleto',
        pos = vector3(170.89, 6446.63, 31.63),
        requiredJob = nil, 
        range = 30.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    
    -----------
    -- Event Halloween ; Domaine Viticole
    -- {
    --     name = 'zeze',
    --     pos = vector3(-1915.95, 2043.90, 140.73 - 0.98),
    --     requiredJob = nil, 
    --     range = 30.0, 
    --     volume = 1.0 --[[ do not touch the volume! --]]
    -- },
    -- {
    --     name = 'zeze2',
    --     pos = vector3(-1883.45, 2062.95, 153.88 - 0.98),
    --     requiredJob = nil, 
    --     range = 350.0, 
    --     volume = 1.0 --[[ do not touch the volume! --]]
    -- },
    -- {
    --     name = 'zeze3',
    --     pos = vector3(-1888.91, 2091.32, 141.66 - 0.98),
    --     requiredJob = nil, 
    --     range = 30.0, 
    --     volume = 1.0 --[[ do not touch the volume! --]]
    -- },

    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}