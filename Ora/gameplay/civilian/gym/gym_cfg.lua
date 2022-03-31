ConfigGym = {}

ConfigGym.FarmLimit = false

ConfigGym.Exercises = {
    ["Pompes"] = {
        ["idleDict"] = "amb@world_human_push_ups@male@idle_a",
        ["idleAnim"] = "idle_c",
        ["actionDict"] = "amb@world_human_push_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 1100,
        ["enterDict"] = "amb@world_human_push_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 3050,
        ["exitDict"] = "amb@world_human_push_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3400,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 4
    },
    ["Abdos"] = {
        ["idleDict"] = "amb@world_human_sit_ups@male@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@world_human_sit_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3400,
        ["enterDict"] = "amb@world_human_sit_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 4200,
        ["exitDict"] = "amb@world_human_sit_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10
    },
    ["Developpé couché"] = {
        ["idleDict"] = "amb@prop_human_seat_muscle_beach_press@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@prop_human_seat_muscle_bench_press@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3400,
        ["enterDict"] = "amb@prop_human_seat_muscle_bench_press@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 4200,
        ["exitDict"] = "amb@prop_human_seat_muscle_bench_press@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10
    },
    ["Lever de poids"] = {
        ["idleDict"] = "amb@world_human_muscle_free_weights@male@barbell@base",
        ["idleAnim"] = "base",
        ["actionDict"] = "amb@world_human_muscle_free_weights@male@barbell@idle_a",
        ["actionAnim"] = "idle_a",
        ["actionTime"] = 3400,
        ["enterDict"] = "amb@prop_human_seat_muscle_bench_press@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 4200,
        ["exitDict"] = "amb@prop_human_seat_muscle_bench_press@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10
    },
    ["Tractions"] = {
        ["idleDict"] = "amb@prop_human_muscle_chin_ups@male@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@prop_human_muscle_chin_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3000,
        ["enterDict"] = "amb@prop_human_muscle_chin_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 1600,
        ["exitDict"] = "amb@prop_human_muscle_chin_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10
    }
}

ConfigGym.Locations = {
    -- REMINDER. If you want it to set coords+heading then enter heading, else put nil ( ["h"] )
    {["x"] = -1200.08, ["y"] = -1571.15, ["z"] = 4.6115 - 0.98, ["h"] = 214.37, ["exercise"] = "Tractions"},
    {
        ["x"] = -1205.0118408203,
        ["y"] = -1560.0671386719,
        ["z"] = 4.614236831665 - 0.98,
        ["h"] = nil,
        ["exercise"] = "Abdos"
    },
    {
        ["x"] = -1771.68,
        ["y"] = 193.78,
        ["z"] = 64.37 - 0.98,
        ["h"] = nil,
        ["exercise"] = "Abdos"
    },
    {
        ["x"] = 234.4101,
        ["y"] = -267.2107,
        ["z"] = 60.0357 - 0.98,
        ["h"] = 161.4518,
        ["exercise"] = "Abdos"
    },
    {
        ["x"] = 235.5499,
        ["y"] = -267.5675,
        ["z"] = 60.0357 - 0.98,
        ["h"] = 163.9164,
        ["exercise"] = "Abdos"
    },
    {
        ["x"] = 233.2097,
        ["y"] = -266.8580,
        ["z"] = 60.0356 - 0.98,
        ["h"] = 173.6165,
        ["exercise"] = "Abdos"
    },
    {
        ["x"] = -1203.3094482422,
        ["y"] = -1570.6759033203,
        ["z"] = 4.6079330444336 - 0.98,
        ["h"] = nil,
        ["exercise"] = "Pompes"
    },
    {
        ["x"] = -1777.78,
        ["y"] = 185.97,
        ["z"] = 64.37 - 0.98,
        ["h"] = nil,
        ["exercise"] = "Pompes"
    },
    {
        ["x"] = 1639.62,
        ["y"] = 2526.64,
        ["z"] = 45.56 - 0.98,
        ["h"] = nil,
        ["exercise"] = "Pompes"
    },
    {
        ["x"] = 68.71,
        ["y"] = 6945.57,
        ["z"] = 12.18 - 0.98,
        ["h"] = nil,
        ["exercise"] = "Pompes"
    },
    {
        ["x"] = 250.7595,
        ["y"] = -256.4869,
        ["z"] = 59.9176 - 0.98,
        ["h"] = 340.7068,
        ["exercise"] = "Pompes"
    },
    {
        ["x"] = 254.8253,
        ["y"] = -264.3497,
        ["z"] = 59.9176 - 0.98,
        ["h"] = 253.0081,
        ["exercise"] = "Pompes"
    },
    {
        ["x"] = 250.7595,
        ["y"] = -256.4869,
        ["z"] = 59.9176 - 0.98,
        ["h"] = 340.7068,
        ["exercise"] = "Pompes"
    },
    {
        ["x"] = 254.8253,
        ["y"] = -264.3497,
        ["z"] = 59.9176 - 0.98,
        ["h"] = 253.0081,
        ["exercise"] = "Pompes"
    },
    {
        ["x"] = 252.2926,
        ["y"] = -272.1432,
        ["z"] = 59.9176 - 0.98,
        ["h"] = 252.8855,
        ["exercise"] = "Pompes"
    },
    {
        ["x"] = 1647.98,
        ["y"] = 2534.22,
        ["z"] = 45.56 - 0.98,
        ["h"] = nil,
        ["exercise"] = "Abdos"
    },
    {
        ["x"] = 63.13,
        ["y"] = 6932.76,
        ["z"] = 13.13 - 0.98,
        ["h"] = nil,
        ["exercise"] = "Abdos"
    },
    {["x"] = 1643.17, ["y"] = 2528.05, ["z"] = 45.56 - 0.98, ["h"] = 230.43, ["exercise"] = "Tractions"},
    {["x"] = -1204.65, ["y"] = -1564.4, ["z"] = 4.61 - 0.98, ["h"] = 33.82, ["exercise"] = "Tractions"},
    {["x"] = -1784.15, ["y"] = 189.0, ["z"] = 64.38 - 0.98, ["h"] = 48.76, ["exercise"] = "Tractions"},
    {["x"] = -1776.27, ["y"] = 198.57, ["z"] = 64.37 - 0.98, ["h"] = 304.19, ["exercise"] = "Tractions"},
    {["x"] = -1773.13, ["y"] = 201.53, ["z"] = 64.37 - 0.98, ["h"] = 132.33, ["exercise"] = "Tractions"},
    {["x"] = 64.84, ["y"] = 6938.34, ["z"] = 13.27 - 0.98, ["h"] = 238.01, ["exercise"] = "Tractions"},
    {["x"] = 249.0196, ["y"] = -268.4542, ["z"] = 59.9177 - 0.98, ["h"] = 256.9382, ["exercise"] = "Tractions"},
    {["x"] = 251.0108, ["y"] = -266.9087, ["z"] = 59.9177 - 0.98, ["h"] = 86.5335, ["exercise"] = "Tractions"},


    --{["x"] = -1206.76, ["y"] = -1572.93, ["z"] = 4.61 - 0.98, ["h"] = nil, ["exercise"] = "Pushups"},
    -- ^^ You can add more locations like this
}

ConfigGym.Blips = {
    [1] = {
        ["x"] = 257.702087,
        ["y"] = -255.876312,
        ["z"] = 53.999408,
        ["id"] = 311,
        ["color"] = 49,
        ["scale"] = 0.8,
        ["text"] = "Sport - LA Fitness"
    },
    [2] = {
        ["x"] = -1775.21,
        ["y"] = 194.34,
        ["z"] = 64.41,
        ["id"] = 311,
        ["color"] = 49,
        ["scale"] = 0.8,
        ["text"] = "Sport - Université"
    },
    [3] = {
        ["x"] = 63.29,
        ["y"] = 6939.13,
        ["z"] = 13.15,
        ["id"] = 311,
        ["color"] = 49,
        ["scale"] = 0.8,
        ["text"] = "Sport - Paleto"
    },
    [4] = {
        ["x"] = -1201.0078125,
        ["y"] = -1568.3903808594,
        ["z"] = 4.6110973358154,
        ["id"] = 311,
        ["color"] = 49,
        ["scale"] = 0.8,
        ["text"] = "Sport - Vespucci Beach"
    },
}
