pegasus = {}

pegasus.startMission= {
    {pos = vector3(1120.58, 2647.91, 38.0 - 0.98), heading = 358.41, truckPos = vector3(929.13, 2714.88, 40.52), headingTruck = 176.1},
    {pos = vector3(627.04, 2724.55, 41.81 - 0.98), heading = 4.8, truckPos = vector3(474.61, 2617.78, 43.09), headingTruck = 278.56},
    {pos = vector3(333.29, 3406.55, 36.72 - 0.98), heading = 19.33, truckPos = vector3(80.97, 3482.59, 39.73), headingTruck = 187.89},
    {pos = vector3(1496.71, 3579.4, 35.18 - 0.98), heading = 54.96, truckPos = vector3(1400.41, 3701.01, 33.7), headingTruck = 240.49},
    {pos = vector3(43.67, 2802.14, 57.88 - 0.98), heading = 148.05, truckPos = vector3(227.18, 2611.53, 46.26), headingTruck = 47.45},
}

pegasus.endMission= {
    {pos = vector3(901.74, -183.43, 73.89 - 0.98), heading = 358.41},
}

pegasus.DropOff = {
    [1] = {
        {pos = vector3(2683.84, 3276.83, 55.24 - 0.98)},
        {pos = vector3(2700.78, 3443.92, 55.8 - 0.98)},
        {pos = vector3(2591.74, 3174.72, 51.8 - 0.98)}
    },
    [2] = {
        {pos = vector3(2539.24, 2618.61, 37.94 - 0.98)},
        {pos = vector3(2552.65, 2794.68, 35.12 - 0.98)},
        {pos = vector3(2389.97, 2524.58, 46.66 - 0.98)}
    },
    [3] = {
        {pos = vector3(2566.51, 382.81, 108.46 - 0.98)},
        {pos = vector3(2554.57, 296.4, 108.46 - 0.98)}
    },
    [4] = {
        {pos = vector3(30.84, -1040.98, 29.35 - 0.98)},
        {pos = vector3(21.24, -1305.52, 29.15 - 0.98)},
        {pos = vector3(-331.27, -1356.12, 31.3 - 0.98)}
    },
    [5] = {
        {pos = vector3(-588.06, -1106.58, 22.18 - 0.98)},
        {pos = vector3(-610.44, -993.72, 21.79 - 0.98)},
        {pos = vector3(-602.25, -888.06, 25.25 - 0.98)}
    },
    [6] = {
        {pos = vector3(-1518.64, -551.22, 33.16 - 0.98)},
        {pos = vector3(-1382.38, -456.74, 34.48 - 0.98)},
        {pos = vector3(-1571.6, -265.91, 48.28 - 0.98)}
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