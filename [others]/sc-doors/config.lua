-- https://discord.gg/Zyq7kjw --
-- REWRITE BY Max Golf#0001   --
-- https://discord.gg/Zyq7kjw --

Config = {}

Config.DoorList = {
    --
    -- Mission Row First Floor
    --

    -- Entrance Doors
   --[[  {
        textCoords = vector3(434.7, -982.0, 31.5),
        authorizedJobs = {"police", "lssd"},
        locked = false,
        maxDistance = 2.5,
        doors = {
            {objHash = GetHashKey("v_ilev_ph_door01"), objHeading = 270.0, objCoords = vector3(434.7, -980.6, 30.8)},
            {objHash = GetHashKey("v_ilev_ph_door002"), objHeading = 270.0, objCoords = vector3(434.7, -983.2, 30.8)}
        }
    },
    -- To locker room & roof
    {
        objHash = GetHashKey("v_ilev_ph_gendoor004"),
        objHeading = 90.0,
        objCoords = vector3(449.6, -986.4, 30.6),
        textCoords = vector3(450.1, -986.3, 31.7),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    -- Rooftop
    {
        objHash = GetHashKey("v_ilev_gtdoor02"),
        objHeading = 90.0,
        objCoords = vector3(464.3, -984.6, 43.8),
        textCoords = vector3(464.3, -984.0, 44.8),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    -- Hallway to roof
    {
        objHash = GetHashKey("v_ilev_arm_secdoor"),
        objHeading = 90.0,
        objCoords = vector3(461.2, -985.3, 30.8),
        textCoords = vector3(461.5, -986.0, 31.5),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    -- Armory
    {
        objHash = GetHashKey("v_ilev_arm_secdoor"),
        objHeading = 270.0,
        objCoords = vector3(452.6, -982.7, 30.6),
        textCoords = vector3(453.0, -982.6, 31.7),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    -- Captain Office
    {
        objHash = GetHashKey("v_ilev_ph_gendoor002"),
        objHeading = 180.0,
        objCoords = vector3(447.2, -980.6, 30.6),
        textCoords = vector3(447.2, -980.0, 31.7),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    -- To downstairs (double doors)
    {
        textCoords = vector3(444.6, -989.4, 31.7),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 4,
        doors = {
            {objHash = GetHashKey("v_ilev_ph_gendoor005"), objHeading = 180.0, objCoords = vector3(443.9, -989.0, 30.6)},
            {objHash = GetHashKey("v_ilev_ph_gendoor005"), objHeading = 0.0, objCoords = vector3(445.3, -988.7, 30.6)}
        }
    },
    --
    -- Mission Row Cells
    --

    -- Main Cells
    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 0.0,
        objCoords = vector3(463.8, -992.6, 24.9),
        textCoords = vector3(463.3, -992.6, 25.1),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    -- Cell 1
    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 270.0,
        objCoords = vector3(462.3, -993.6, 24.9),
        textCoords = vector3(461.8, -993.3, 25.0),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    -- Cell 2
    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 90.0,
        objCoords = vector3(462.3, -998.1, 24.9),
        textCoords = vector3(461.8, -998.8, 25.0),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    -- Cell 3
    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 90.0,
        objCoords = vector3(462.7, -1001.9, 24.9),
        textCoords = vector3(461.8, -1002.4, 25.0),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    -- To Back
    {
        objHash = GetHashKey("v_ilev_gtdoor"),
        objHeading = 0.0,
        objCoords = vector3(463.4, -1003.5, 25.0),
        textCoords = vector3(464.0, -1003.5, 25.5),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    --
    -- Mission Row Back
    --

    -- Back (double doors)
    {
        textCoords = vector3(468.6, -1014.4, 27.1),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 2.25,
        doors = {
            {objHash = GetHashKey("v_ilev_rc_door2"), objHeading = 0.0, objCoords = vector3(467.3, -1014.4, 26.5)},
            {objHash = GetHashKey("v_ilev_rc_door2"), objHeading = 180.0, objCoords = vector3(469.9, -1014.4, 26.5)}
        }
    },
    -- Back Gate
    {
        objHash = GetHashKey("hei_prop_station_gate"),
        objHeading = 90.0,
        objCoords = vector3(488.8, -1017.2, 27.1),
        textCoords = vector3(488.8, -1020.2, 30.0),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 14,
        size = 2
    }, ]]
    --
    -- Sandy Shores
    --

    -- Entrance
    {
        objHash = GetHashKey("v_ilev_shrfdoor"),
        objHeading = 30.0,
        objCoords = vector3(1855.1, 3683.5, 34.2),
        textCoords = vector3(1855.1, 3683.5, 35.0),
        authorizedJobs = {"lssd"},
        locked = false,
        maxDistance = 1.25
    },
    --
    -- Paleto Bay
    --

    -- Entrance (double doors)
    {
        textCoords = vector3(-443.5, 6016.3, 32.0),
        authorizedJobs = {"lssd"},
        locked = false,
        maxDistance = 2.5,
        doors = {
            {objHash = GetHashKey("v_ilev_shrf2door"), objHeading = 315.0, objCoords = vector3(-443.1, 6015.6, 31.7)},
            {objHash = GetHashKey("v_ilev_shrf2door"), objHeading = 135.0, objCoords = vector3(-443.9, 6016.6, 31.7)}
        }
    },
    -- VESPUCCI POLICE DEPARTMENT

    {
        textCoords = vector3(-1072.58, -826.48, 5.63),
        authorizedJobs = {"police", "lssd"},
        locked = false,
        maxDistance = 2.5,
        doors = {
            {
                objHash = GetHashKey("v_ilev_ph_cellgate"),
                objHeading = 217.70,
                objCoords = vector3(-1072.58, -827.48, 5.63)
            }
        }
    },
    -- CELLULES

    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 307.45,
        objCoords = vector3(-1088.7, -830.2, 5.6),
        textCoords = vector3(-1089.7, -829.2, 5.6),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 307.58,
        objCoords = vector3(-1091.1, -827.0, 5.6),
        textCoords = vector3(-1092.7, -826.0, 5.6),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 307.45,
        objCoords = vector3(-1093.5, -823.8, 5.6),
        textCoords = vector3(-1094.5, -822.8, 5.6),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 307.45,
        objCoords = vector3(-1095.9, -820.7, 5.6),
        textCoords = vector3(-1096.9, -819.7, 5.6),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 307.45,
        objCoords = vector3(-1090.6, -821.6, 5.6),
        textCoords = vector3(-1091.6, -820.6, 5.6),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 307.45,
        objCoords = vector3(-1088.2, -824.7, 5.6),
        textCoords = vector3(-1089.2, -823.7, 5.6),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    {
        objHash = GetHashKey("v_ilev_ph_cellgate"),
        objHeading = 307.45,
        objCoords = vector3(-1085.8, -827.8, 5.6),
        textCoords = vector3(-1086.8, -826.8, 5.6),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.25
    },
    {
        textCoords = vector3(-1089.9, -847.3, 5.0),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("v_ilev_rc_door2"), objHeading = 307.45, objCoords = vector3(-1091.0, -846.6, 5.0)},
            {objHash = GetHashKey("v_ilev_rc_door2"), objHeading = 127.28, objCoords = vector3(-1089.4, -848.7, 5.0)}
        }
    },
    ----- PILLBOX
    {
        textCoords = vector3(303.87, -582.28, 43.28),
        authorizedJobs = {"lsms"},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = -434783486, objHeading = 339.34, objCoords = vector3(302.80, -581.42, 43.43)},
            {objHash = -1700911976, objHeading = 340.00, objCoords = vector3(305.22, -582.31, 43.43)}
        }
    },
    {
        textCoords = vector3(325.16, -590.03, 43.28),
        authorizedJobs = {"lsms"},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = -434783486, objHeading = 340.00, objCoords = vector3(324.24, -589.23, 43.43)},
            {objHash = -1700911976, objHeading = 340.00, objCoords = vector3(326.65, -590.11, 43.43)}
        }
    },
    {
        textCoords = vector3(327.27, -593.89, 43.28),
        authorizedJobs = {"lsms"},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = -434783486, objHeading = 250.00, objCoords = vector3(328.14, -592.78, 43.43)},
            {objHash = -1700911976, objHeading = 250.00, objCoords = vector3(327.26, -595.20, 43.43)}
        }
    },
    {
        textCoords = vector3(326.109, -579.249, 43.28),
        authorizedJobs = {"lsms"},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = -434783486, objHeading = 250.00, objCoords = vector3(326.549, -578.040, 43.43)},
            {objHash = -1700911976, objHeading = 250.00, objCoords = vector3(325.669, -580.459, 43.43)}
        }
    },
    ----------- PILLBOX RDC ------


    ----- UNICORN
    {
        objHash = GetHashKey("prop_strip_door_01"),
        objHeading = 30.00,
        objCoords = vector3(127.9, -1298.5, 29.41),
        textCoords = vector3(128.9, -1297.5, 29.41),
        authorizedJobs = {"unicorn"},
        locked = true,
        maxDistance = 1.50
    },
    {
        objHash = GetHashKey("prop_magenta_door"),
        objHeading = 210.18,
        objCoords = vector3(96.0, -1284.8, 29.4),
        textCoords = vector3(97.0, -1286.8, 29.4),
        authorizedJobs = {"unicorn"},
        locked = true,
        maxDistance = 1.50
    },
    {
        objHash = GetHashKey("v_ilev_roc_door2"),
        objHeading = 27.74,
        objCoords = vector3(134.48, -1290.6, 29.27),
        textCoords = vector3(134.48, -1290.6, 29.27),
        authorizedJobs = {"unicorn"},
        locked = true,
        maxDistance = 1.50
    },
    {
        objHash = GetHashKey("v_ilev_roc_door2"),
        objHeading = 298.04,
        objCoords = vector3(135.67, -1279.44, 29.42),
        textCoords = vector3(135.67, -1279.44, 29.42),
        authorizedJobs = {"unicorn"},
        locked = true,
        maxDistance = 1.50
    },
    {
        objHash = 390840000,
        objHeading = 299.5,
        objCoords = vector3(113.83, -1296.9, 29.27),
        textCoords = vector3(113.76, -1296.7, 29.27),
        authorizedJobs = {"unicorn"},
        locked = true,
        maxDistance = 1.50
    },
    -------- PRISON

    {
        objHash = GetHashKey("prop_gate_prison_01"),
        objHeading = 90.0,
        objCoords = vector3(1844.9, 2604.8, 44.6),
        textCoords = vector3(1844.9, 2608.5, 48.0),
        authorizedJobs = {"police", "lssd", "fib"},
        locked = true,
        maxDistance = 14.0
    },
    {
        objHash = GetHashKey("prop_gate_prison_01"),
        objHeading = 90.0,
        objCoords = vector3(1818.5, 2604.8, 44.6),
        textCoords = vector3(1818.5, 2608.4, 48.0),
        authorizedJobs = {"police", "lssd", "fib"},
        locked = true,
        maxDistance = 14.0
    },
    -------- MECANO

    -- {
    --     objHash = GetHashKey("lr_prop_supermod_door_01"),
    --     objCoords = vector3(-205.6, -1310.6, 30.2),
    --     textCoords = vector3(-205.6, -1310.6, 32.2),
    --     authorizedJobs = {"mecano"},
    --     locked = true,
    --     maxDistance = 5.0
    -- },
    -------- PONSONBYS

    --[[ {
        objHash = GetHashKey("v_ilev_ch_glassdoor"),
        objCoords = vector3(-716, -156.25, 37.42),
        textCoords = vector3(-716, -156.25, 37.42),
        authorizedJobs = {"ponsonbys"},
        locked = true,
        maxDistance = 5.0
    },
    {
        objHash = GetHashKey("v_ilev_ch_glassdoor"),
        objCoords = vector3(-715, -156.25, 37.42),
        textCoords = vector3(-716, -156.25, 37.42),
        authorizedJobs = {"ponsonbys"},
        locked = true,
        maxDistance = 5.0
    }, ]]
    {
        textCoords = vector3(-716, -156.25, 37.42),
        authorizedJobs = {'ponsonbys'},
        locked = true,
        maxDistance = 5.0,
        doors = {
            {objHash = GetHashKey("v_ilev_ch_glassdoor"), objCoords = vector3(-716, -156.25, 37.42)},
            {objHash = GetHashKey("v_ilev_ch_glassdoor"), objCoords = vector3(-715, -156.25, 37.42)}
        }
    },

    -------- HEN HOUSE BAR 

    {
        textCoords = vector3(-300.95, 6256.84, 31.49),
        authorizedJobs = {"henhouse"},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = 633547679, objHeading = 43.83, objCoords = vector3(-301.63, 6256.37, 31.49)},
            {objHash = 1286502769, objHeading = 43.83, objCoords = vector3(-300.43, 6257.25, 31.49)}
        }
    },

    {
        objHash = -1671830748,
        objCoords = vector3(-309.51, 6271.83, 31.49),
        textCoords = vector3(-309.51, 6271.83, 31.49),
        authorizedJobs = {"henhouse"},
        locked = true,
        maxDistance = 1.50
    },

    {
        objHash = -1671830748,
        objCoords = vector3(-298.67, 6273.4, 31.49),
        textCoords = vector3(-298.67, 6273.4, 31.49),
        authorizedJobs = {"henhouse"},
        locked = true,
        maxDistance = 1.50
    },

    -------- COIFFEUR

    {
        textCoords = vector3(-822.75, -187.48, 37.57),
        authorizedJobs = {'coiffeur'},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("v_ilev_hd_door_l"), objHeading = 300.90, objCoords = vector3(-822.75, -187.48, 37.57)},
            {objHash = GetHashKey("v_ilev_hd_door_r"), objHeading = 300.90, objCoords = vector3(-822.70, -188.03, 37.57)}
        }
    },

        -- {
    --     objHash = -1844444717,
    --     objCoords = vector3(132.56, -1711.00, 29.44),
    --     textCoords = vector3(132.56, -1711.00, 29.44),
    --     authorizedJobs = {"coiffeur"},
    --     locked = true,
    --     maxDistance = 5.0
    -- },
    -------- BURGERSHOT

    {
        objHash = GetHashKey("p_bs_map_door_01_s"),
        objCoords = vector3(-1178.82, -892.03, 13.97),
        textCoords = vector3(-1178.82, -892.03, 13.97),
        authorizedJobs = {"burgershot"},
        locked = true,
        maxDistance = 1.50
    },

    {
        textCoords = vector3(-1184.10, -884.65, 13.99),
        authorizedJobs = {'burgershot'},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = 167687243, objHeading = 124.50, objCoords = vector3(-1184.35, -883.86, 13.99)},
            {objHash = 1800304361, objHeading = 124.50, objCoords = vector3(-1183.62, -885.37, 13.99)}
        }
    },

    {
        textCoords = vector3(-1197.83, -884.30, 13.99),
        authorizedJobs = {'burgershot'},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = 1800304361, objHeading = 213.86, objCoords = vector3(-1197.09, -883.98, 13.99)},
            {objHash = 167687243, objHeading = 213.86, objCoords = vector3(-1198.51, -884.85, 13.99)}
        }
    },


    -------- PDM

    {
        textCoords = vector3(-38.26, -1108.62, 26.46),
        authorizedJobs = {'concess'},
        locked = true,
        maxDistance = 2.0,
        doors = {
            {objHash = GetHashKey("v_ilev_csr_door_r"), objHeading = 339.00, objCoords = vector3(-38.91, -1108.68, 26.43)},
            {objHash = GetHashKey("v_ilev_csr_door_l"), objHeading = 341.00, objCoords = vector3(-37.80, -1109.05, 26.43)}
        }
    },

    -------- BANQUE

    {
        objHash = GetHashKey("hei_v_ilev_bk_gate_pris"),
        objCoords = vector3(257.09, 220.59, 106.29),
        textCoords = vector3(257.09, 220.59, 106.29),
        authorizedJobs = {"banker"},
        locked = true,
        maxDistance = 1.50
    },
    {
        objHash = GetHashKey("v_ilev_bk_door"),
        objCoords = vector3(237.15, 228.26, 106.28),
        textCoords = vector3(237.15, 228.26, 106.28),
        authorizedJobs = {"banker"},
        locked = true,
        maxDistance = 1.50
    },
    -- GALAXY --

    {
    	objHash = 390840000,
    	objHeading = 179.999,
    	objCoords = vector3(-1610.125, -3004.970, -78.840),
    	textCoords = vector3(-1610.125, -3004.970, -78.840),
    	authorizedJobs = {'night'},
    	locked = true,
    	maxDistance = 1.5

    },
    {
    	objHash = -1555108147,
    	objHeading = 270.00,
    	objCoords = vector3(-1607.535, -3005.431, -75.05),
    	textCoords = vector3(-1607.535, -3005.431, -75.05),
    	authorizedJobs = {'night'},
    	locked = true,
    	maxDistance = 1.5

    },

        -- THE PEARLS --

        {
            objHash = -1197804771,
            objHeading = 151.22,
            objCoords = vector3(-1836.90, -1190.34, 19.08),
            textCoords = vector3(-1836.90, -1190.34, 19.08),
            authorizedJobs = {'pearls'},
            locked = true,
            maxDistance = 1.5
    
        },
        {
            objHash = -1196002204,
            objHeading = 331.25,
            objCoords = vector3(-1830.24, -1181.78, 19.40),
            textCoords = vector3(-1830.24, -1181.78, 19.40),
            authorizedJobs = {'pearls'},
            locked = true,
            maxDistance = 1.5
    
        },
        {
            objHash = -1285189121,
            objHeading = 329.11,
            objCoords = vector3(-1847.27, -1189.99, 14.47),
            textCoords = vector3(-1847.27, -1189.99, 14.47),
            authorizedJobs = {'pearls'},
            locked = true,
            maxDistance = 1.5
    
        },

    

    -- STUDIO LABEL --

    {
        objHash = -1995612459,
        objHeading = 270.00,
        objCoords = vector3(731.99, 2522.13, 73.67),
        textCoords = vector3(731.99, 2522.13, 73.67),
        authorizedJobs = {"--"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1995612459,
        objHeading = 90.00,
        objCoords = vector3(731.99, 2524.66, 73.67),
        textCoords = vector3(731.99, 2524.66, 73.67),
        authorizedJobs = {"--"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1576989776,
        objHeading = 90.00,
        objCoords = vector3(715.11, 2531.74, 73.55),
        textCoords = vector3(715.11, 2531.74, 73.55),
        authorizedJobs = {"--"},
        locked = false,
        maxDistance = 1.5
    },
    {
        objHash = -1576989776,
        objHeading = 180.00,
        objCoords = vector3(713.50, 2530.03, 73.55),
        textCoords = vector3(713.50, 2530.03, 73.55),
        authorizedJobs = {"--"},
        locked = false,
        maxDistance = 1.5
    },
    {
        objHash = 42511143,
        objHeading = 359.87,
        objCoords = vector3(726.024, 2521.33, 73.95),
        textCoords = vector3(726.024, 2521.33, 73.95),
        authorizedJobs = {"--"},
        locked = false,
        maxDistance = 1.5
    },
    {
        objHash = 42511143,
        objHeading = 180.14,
        objCoords = vector3(723.83, 2521.33, 73.95),
        textCoords = vector3(723.83, 2521.33, 73.95),
        authorizedJobs = {"--"},
        locked = false,
        maxDistance = 1.5
    },
    {
        objHash = -612979079,
        objCoords = vector3(-583.688, 228.596, 78.372),
        textCoords = nil,
        authorizedJobs = {"hacker"},
        locked = true,
        maxDistance = 5.0
    },

    ---- TEQUILALA ------

    {
        objHash = GetHashKey("v_ilev_roc_door4"),
        objHeading = 174.89,
        objCoords = vector3(-561.28, 293.50, 87.77),
        textCoords = vector3(-561.28, 293.50, 87.77),
        authorizedJobs = {"tequilala"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = GetHashKey("v_ilev_roc_door4"),
        objHeading = 355.13,
        objCoords = vector3(-565.17, 276.62, 83.28),
        textCoords = vector3(-565.17, 276.62, 83.28),
        authorizedJobs = {"tequilala"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = GetHashKey("v_ilev_roc_door2"),
        objHeading = 264.99,
        objCoords = vector3(-560.23, 293.01, 82.32),
        textCoords = vector3(-560.23, 293.01, 82.32),
        authorizedJobs = {"tequilala"},
        locked = false,
        maxDistance = 1.5
    },
    --- BINCO
    {
        textCoords = vector3(-817.779, -1079.00, 11.48),
        authorizedJobs = {"binco"},
        locked = true,
        maxDistance = 2.5,
        doors = {
            {objHash = GetHashKey("v_ilev_cs_door01"), objHeading = 210.50, objCoords = vector3(-818.764, -1079.544, 11.48)},
            {objHash = GetHashKey("v_ilev_cs_door01_r"), objHeading = 30.50, objCoords = vector3(-816.793, -1078.406, 11.48)}
        }
    },
    --- BINCO NORD
    {
        objHash = GetHashKey("v_ilev_clothmiddoor"),
        objHeading = 3.98,
        objCoords = vector3(617.24, 2751.02, 42.75),
        textCoords = vector3(618.03, 2750.71, 42.75),
        authorizedJobs = {"binconord"},
        locked = true,
        maxDistance = 2.5
    },
    --YELLOW JACK
    {
        objHash = -287662406,
        objHeading = 147.62,
        objCoords = vector3(1991.106, 3053.105, 47.36),
        textCoords = vector3(1991.106, 3053.105, 47.36),
        authorizedJobs = {"yellowjack"},
        locked = true,
        maxDistance = 2.0
    },
    --  HARMONY REPAIRS / LARRY'S
    {
        textCoords = vector3(1187.202, 2644.949, 38.55),
        authorizedJobs = {"mecano2"}, 
        locked = true,
        maxDistance = 7.0,
        doors = {
            {objHash = 1335311341, objHeading = 180.07, objCoords = vector3(1187.202, 2644.949, 38.55)},
            {objHash = -822900180, objCoords = vector3(1174.654, 2645.221, 38.63)},
            {objHash = -822900180, objCoords =  vector3(1182.305, 2645.240, 38.67)}
        }
    },
        --Miror
    {
        objHash = -1540703659,
        objHeading = 23.23,
        objCoords = vector3(-1342.5236, -1076.1541, 6.9394),
        textCoords = vector3(-1342.5236, -1076.1541, 6.9394),
        authorizedJobs = {"restaurant"},
        locked = true,
        maxDistance = 0.5
    },
    
    {
        objHash = -1132262566,
        objHeading = 23.23,
        objCoords = vector3(-1341.4703, -1075.5009, 6.9394),
        textCoords = vector3(-1341.4703, -1075.5009, 6.9394),
        authorizedJobs = {"restaurant"},
        locked = true,
        maxDistance = 0.5
    },

    --Ammunation 
    
    {
        objHash = GetHashKey("v_ilev_gc_door04"),
        objHeading = 177.22,
        objCoords = vector3(813.1779174804688, -2148.26953125, 29.768924713134766),
        textCoords = vector3(813.1779174804688, -2148.26953125, 29.768924713134766),
        authorizedJobs = {"ammunation"},
        locked = true,
        maxDistance = 0.5
    },
        
    {
        objHash = GetHashKey("v_ilev_gc_door03"),
        objHeading = 23.23,
        objCoords = vector3(810.576904296875, -2148.26953125, 29.768924713134766),
        textCoords = vector3(810.576904296875, -2148.26953125, 29.768924713134766),
        authorizedJobs = {"ammunation"},
        locked = true,
        maxDistance = 0.5
    },

    --CFX RECORDS

    {
        objHash = 2001816392,
        objCoords = vector3(-826.4025268554688, -695.8140258789062, 28.490825653076172),
        textCoords = vector3(-826.4025268554688, -695.8140258789062, 28.490825653076172),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = 2001816392,
        objCoords = vector3(-826.4025268554688, -697.994384765625, 28.490825653076172),
        textCoords = vector3(-826.4025268554688, -697.994384765625, 28.490825653076172),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 1.5
    },

    --
    {
        objHash = 2001816392,
        objCoords = vector3(-826.4025268554688, -698.747802734375, 28.490825653076172),
        textCoords = vector3(-826.4025268554688, -698.747802734375, 28.490825653076172),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = 2001816392,
        objCoords = vector3(-826.4025268554688, -700.9301147460938, 28.490825653076172),
        textCoords = vector3(-826.4025268554688, -700.9301147460938, 28.490825653076172),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 1.5
    },
      
        --MECANO
    
    {
        objHash = GetHashKey("lr_prop_supermod_door_01"),
        objCoords = vector3(-205.6, -1310.6, 30.2),
        textCoords = vector3(-205.6, -1310.6, 32.2),
        authorizedJobs = {"bennys"},
        locked = true,
        maxDistance = 5.0
    },

}

-- EXAMPLE HOW TO DO DOORS WITH OBJECT HASHES
--[[{
    objHash = -930593859,
    objHeading = 43.0,
    objCoords  = vector3(959.24,  -139.58,  74.48),
    textCoords = vector3(959.24,  -139.58,  74.48),
    authorizedJobs = { 'thelostmc', 'police' },
    locked = true,
    maxDistance = 1.5,
    size = 2

},--]]
