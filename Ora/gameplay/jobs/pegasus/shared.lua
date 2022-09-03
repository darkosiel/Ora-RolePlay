pegasus = {}

pegasus.startMission= {
    {pos = vector3(1770.17, 3239.40, 42.13 - 0.98), heading = 358.41, truckPos = vector3(2134.82, 4808.67, 41.14), headingTruck = 176.1},
    {pos = vector3(-286.48, -618.06, 50.33 - 0.98), heading = 4.8, truckPos = vector3(-745.40, -1468.72, 5.00 - 0.98), headingTruck = 278.56},
    {pos = vector3(-1112.53, -2883.91, 13.94 - 0.98), heading = 19.33, truckPos = vector3(-913.54, -378.50, 137.90 - 0.98), headingTruck = 187.89},
    {pos = vector3(-286.48, -618.06, 50.33 - 0.98), heading = 54.96, truckPos = vector3(910.315, 1106.58, 43.07 - 0.98), headingTruck = 240.49},
    {pos = vector3(910.315, -1681.39, 51.31 - 0.98), heading = 148.05, truckPos = vector3(-1010.94, -756.88, 81.74 - 0.98), headingTruck = 47.45},
}

pegasus.endMission= {
    {pos = vector3(-1657.1134, -3137.0097, 13.99 - 0.98), heading = 358.41},
}

pegasus.DropOff = {
    [1] = {
        {pos = vector3(-286.48, -618.06, 50.33 - 0.98)},
        {pos = vector3(-1582.04, -569.02, 116.32 - 0.98)},-- commence
        {pos = vector3(-1391.05, -477.60, 91.25 - 0.98)}
    },
    [2] = {
        {pos = vector3(-1220.20, -831.89, 29.41 - 0.98)},
        {pos = vector3(-745.40, -1468.72, 5.00 - 0.98)},
        {pos = vector3(-1112.53, -2883.91, 13.94 - 0.98)}--
    },
    [3] = {
        {pos = vector3(-75.21, -819.46, 326.17 - 0.98)},
        {pos = vector3(-144.49, -593.19, 211.77 - 0.98)}
    },
    [4] = {
        {pos = vector3(-144.49, -593.19, 211.77 - 0.98)},
        {pos = vector3(-913.54, -378.50, 137.90 - 0.98)},
        {pos = vector3(-597.53, -716.89, 131.04 - 0.98)}
    },
    [5] = {
        {pos = vector3(-1010.94, -756.88, 81.74 - 0.98)},
        {pos = vector3(-1007.72, -416.04, 80.17 - 0.98)},
        {pos = vector3(965.81, 42.24, 123.12 - 0.98)}
    },
    [6] = {
        {pos = vector3(910.315, 1106.58, 43.07 - 0.98)},
        {pos = vector3(393.42, -66.36, 124.37  - 0.98)},
        {pos = vector3(910.315, -1681.39, 51.31 - 0.98)}
    },
}

pegasus.Type = {
    scenarioSettings = {
        clients = {
            "s_m_m_migrant_01",
            "s_m_m_mariachi_01",
            "a_m_y_hasjew_01",
            "s_f_m_maid_01",
            "s_f_y_hooker_03",
            "s_f_y_hooker_02",
            "g_m_y_armgoon_02",
            "g_m_m_armgoon_01",
            "csb_prologuedriver",
            "csb_hao"
        },
        minutes = 30
    },
    rewards = {
        ["items"] = {
            {
                name = "jus",
                data = {}
            },
            {
                name = "tapas",
                data = {}
            }
        },
        ["money"] = {
            amount = {400, 550}
        }
    }
}