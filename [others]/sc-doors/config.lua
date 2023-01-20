-- https://discord.gg/Zyq7kjw --
-- REWRITE BY Max Golf#0001   --
-- https://discord.gg/Zyq7kjw --

Config = {}

Config.DoorList = {
    --
    -- Mission Row First Floor
    --

    -- Entrance Doors
   --  {
    --     textCoords = vector3(434.7, -982.0, 31.5),
    --     authorizedJobs = {"police", "lssd"},
    --     locked = false,
    --     maxDistance = 2.5,
    --     doors = {
    --         {objHash = GetHashKey("v_ilev_ph_door01"), objHeading = 270.0, objCoords = vector3(434.7, -980.6, 30.8)},
    --         {objHash = GetHashKey("v_ilev_ph_door002"), objHeading = 270.0, objCoords = vector3(434.7, -983.2, 30.8)}
    --     }
    -- },
    -- -- To locker room & roof
    -- {
    --     objHash = GetHashKey("v_ilev_ph_gendoor004"),
    --     objHeading = 90.0,
    --     objCoords = vector3(449.6, -986.4, 30.6),
    --     textCoords = vector3(450.1, -986.3, 31.7),
    --     authorizedJobs = {"police", "lssd"},
    --     locked = true,
    --     maxDistance = 1.25
    -- },
    -- -- Rooftop
    -- {
    --     objHash = GetHashKey("v_ilev_gtdoor02"),
    --     objHeading = 90.0,
    --     objCoords = vector3(464.3, -984.6, 43.8),
    --     textCoords = vector3(464.3, -984.0, 44.8),
    --     authorizedJobs = {"police", "lssd"},
    --     locked = true,
    --     maxDistance = 1.25
    -- },
    -- -- Hallway to roof
    -- {
    --     objHash = GetHashKey("v_ilev_arm_secdoor"),
    --     objHeading = 90.0,
    --     objCoords = vector3(461.2, -985.3, 30.8),
    --     textCoords = vector3(461.5, -986.0, 31.5),
    --     authorizedJobs = {"police", "lssd"},
    --     locked = true,
    --     maxDistance = 1.25
    -- },
    -- -- Armory
    -- {
    --     objHash = GetHashKey("v_ilev_arm_secdoor"),
    --     objHeading = 270.0,
    --     objCoords = vector3(452.6, -982.7, 30.6),
    --     textCoords = vector3(453.0, -982.6, 31.7),
    --     authorizedJobs = {"police", "lssd"},
    --     locked = true,
    --     maxDistance = 1.25
    -- },
    -- -- Captain Office
    -- {
    --     objHash = GetHashKey("v_ilev_ph_gendoor002"),
    --     objHeading = 180.0,
    --     objCoords = vector3(447.2, -980.6, 30.6),
    --     textCoords = vector3(447.2, -980.0, 31.7),
    --     authorizedJobs = {"police", "lssd"},
    --     locked = true,
    --     maxDistance = 1.25
    -- },
    -- -- To downstairs (double doors)
    -- {
    --     textCoords = vector3(444.6, -989.4, 31.7),
    --     authorizedJobs = {"police", "lssd"},
    --     locked = true,
    --     maxDistance = 4,
    --     doors = {
    --         {objHash = GetHashKey("v_ilev_ph_gendoor005"), objHeading = 180.0, objCoords = vector3(443.9, -989.0, 30.6)},
    --         {objHash = GetHashKey("v_ilev_ph_gendoor005"), objHeading = 0.0, objCoords = vector3(445.3, -988.7, 30.6)}
    --     }
    -- },
    -- --
    -- -- Mission Row Cells
    -- --

    -- Main Cells
    {
        objHash = -801376572,
        objHeading = 270.0,
        objCoords = vector3(484.32, -1004.28, 26.21),
        textCoords = vector3(484.32, -1004.28, 26.21),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.0
    },
    {
        objHash = -801376572,
        objHeading = 270.0,
        objCoords = vector3(484.39, -1006.68, 26.21),
        textCoords = vector3(484.39, -1006.68, 26.21),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.0
    },
    {
        objHash = -801376572,
        objHeading = 270.0,
        objCoords = vector3(484.43, -1009.51, 26.21),
        textCoords = vector3(484.43, -1009.51, 26.21),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.0
    },
    {
        objHash = -801376572,
        objHeading = 270.0,
        objCoords = vector3(484.38, -1012.07, 26.21),
        textCoords = vector3(484.38, -1012.07, 26.21),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 0.5
    },
    {
        objHash = -801376572,
        objHeading = 180.0,
        objCoords = vector3(483.5, -1012.49, 26.21),
        textCoords = vector3(483.5, -1012.49, 26.21),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 0.5
    },
    {
        objHash = -801376572,
        objHeading = 180.0,
        objCoords = vector3(480.89, -1012.49, 26.21),
        textCoords = vector3(480.89, -1012.49, 26.21),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.0
    },
    {
        objHash = -801376572,
        objHeading = 180.0,
        objCoords = vector3(478.29, -1012.49, 26.21),
        textCoords = vector3(478.29, -1012.49, 26.21),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.0
    },
    {
        objHash = -801376572,
        objHeading = 90.0,
        objCoords = vector3(477.74, -1006.54, 26.21),
        textCoords = vector3(477.74, -1006.54, 26.21),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 1.0
    },
    --
    -- Mission Row Back
    --

    -- Back (double doors)
    {
        textCoords = vector3(457.07, -972.75, 30.71),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 2.25,
        doors = {
            {objHash = 1337093550, objHeading = 180.0, objCoords = vector3(456.48, -972.77, 30.71)},
            {objHash = 1337093550, objHeading = 0.0, objCoords = vector3(457.62, -972.76, 30.71)}
        }
    },
    {
        textCoords = vector3(468.57, -1014.99, 26.39),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 2.25,
        doors = {
            {objHash = -1200630391, objHeading = 0.0, objCoords = vector3(468.0, -1015.02, 26.39)},
            {objHash = -1200630391, objHeading = 180.0, objCoords = vector3(469.61, -1015.05, 26.39)}
        }
    },
    -- Back Gate
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
    {
        textCoords = vector3(478.43, -979.82, 28.00),
        authorizedJobs = {"police", "lssd"},
        locked = true,
        maxDistance = 2.25,
        doors = {
            {objHash = 1918799109, objHeading = 0.0, objCoords = vector3(477.57, -979.71, 28.00)},
            {objHash = 1918799109, objHeading = 180.0, objCoords = vector3(479.20, -979.83, 28.00)}
        }
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

    {
        objHash = 1695461688,
        objCoords = vector3(96.09197235107422, -1284.853759765625, 29.438783645629883),
        textCoords = vector3(96.09197235107422, -1284.853759765625, 29.438783645629883),
        authorizedJobs = {"unicorn"},
        locked = true,
        maxDistance = 1.5
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
        authorizedJobs = {'coiffeur4'},
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
    --NEW BURGERSHOT


    {
        objHash = 386432549,
        objCoords = vector3(-1183.2745361328125, -885.6295166015625, 14.16980266571045),
        textCoords = vector3(-1183.2745361328125, -885.6295166015625, 14.16980266571045),
        authorizedJobs = {"burgershot"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = -806752263,
        objCoords = vector3(-1184.7222900390625, -883.499267578125, 14.16980266571045),
        textCoords = vector3(-1184.7222900390625, -883.499267578125, 14.16980266571045),
        authorizedJobs = {"burgershot"},
        locked = true,
        maxDistance = 2.5
    },


    {
        objHash = 386432549,
        objCoords = vector3(-1196.755126953125, -883.5769653320312, 14.16980266571045),
        textCoords = vector3(-1196.755126953125, -883.5769653320312, 14.16980266571045),
        authorizedJobs = {"burgershot"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = -806752263,
        objCoords = vector3(-1198.8846435546875, -885.0240478515625, 14.16980266571045),
        textCoords = vector3(-1198.8846435546875, -885.0240478515625, 14.16980266571045),
        authorizedJobs = {"burgershot"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = -1635579193,
        objHeading = 124.62,
        objCoords = vector3(-1178.57, -891.74, 13.74),
        textCoords = vector3(-1178.57, -891.74, 13.74),
        authorizedJobs = {"burgershot"},
        locked = true,
        maxDistance = 2.5
    },


    -------- PDM

    -- {
    --     textCoords = vector3(-38.26, -1108.62, 26.46),
    --     authorizedJobs = {'concess'},
    --     locked = true,
    --     maxDistance = 2.0,
    --     doors = {
    --         {objHash = GetHashKey("v_ilev_csr_door_r"), objHeading = 339.00, objCoords = vector3(-38.91, -1108.68, 26.43)},
    --         {objHash = GetHashKey("v_ilev_csr_door_l"), objHeading = 341.00, objCoords = vector3(-37.80, -1109.05, 26.43)}
    --     }
    -- },

    {
        objHash = -1867369794,
        objCoords = vector3(141.110107421875, -1097.15771484375, 28.19093894958496),
        textCoords = vector3(141.110107421875, -1097.15771484375, 28.19093894958496),
        authorizedJobs = {"concess"},
        locked = true,
        maxDistance = 5.0
    },

    {
        objHash = 1592189791,
        objCoords = vector3(159.20928955078125, -1087.690673828125, 29.542530059814453),
        textCoords = vector3(159.20928955078125, -1087.690673828125, 29.542530059814453),
        authorizedJobs = {"concess"},
        locked = true,
        maxDistance = 3.0
    },
    {
        objHash = 1428213715,
        objCoords = vector3(161.80357360839844, -1087.690673828125, 29.542530059814453),
        textCoords = vector3(161.80357360839844, -1087.690673828125, 29.542530059814453),
        authorizedJobs = {"concess"},
        locked = true,
        maxDistance = 3.0
    },

    {
        objHash = 152369736,
        objCoords = vector3(161.17208862304688, -1118.35107421875, 30.03493881225586),
        textCoords = vector3(161.17208862304688, -1118.35107421875, 30.03493881225586),
        authorizedJobs = {"concess"},
        locked = true,
        maxDistance = 3.0
    },
    {
        objHash = -764932881,
        objCoords = vector3(163.42013549804688, -1118.35107421875, 30.03493881225586),
        textCoords = vector3(163.42013549804688, -1118.35107421875, 30.03493881225586),
        authorizedJobs = {"concess"},
        locked = true,
        maxDistance = 3.0
    },

    {
        objHash = 701638607,
        objCoords = vector3(120.51622772216797, -1111.1077880859375, 30.023090362548828),
        textCoords = vector3(120.51622772216797, -1111.1077880859375, 30.023090362548828),
        authorizedJobs = {"concess"},
        locked = true,
        maxDistance = 5.0
    },
        --POSTE DAVIS 

    --Porte entrée 
    {
        objHash = 618295057,
        objCoords = vector3(381.7760009765625, -1594.2769775390625, 30.201282501220703),
        textCoords = vector3(381.7760009765625, -1594.2769775390625, 30.201282501220703),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 3.0
    },
    {
        objHash = 1670919150,
        objCoords = vector3(379.7842102050781, -1592.605712890625, 30.201282501220703),
        textCoords = vector3(379.7842102050781, -1592.605712890625, 30.201282501220703),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 3.0
    },

    --Porte derrière
    {
        objHash = 618295057,
        objCoords = vector3(369.5201721191406, -1614.1993408203125, 30.201282501220703),
        textCoords = vector3(369.5201721191406, -1614.1993408203125, 30.201282501220703),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 3.0
    },
    {
        objHash = 1670919150,
        objCoords = vector3(371.511962890625, -1615.8707275390625, 30.201282501220703),
        textCoords = vector3(371.511962890625, -1615.8707275390625, 30.201282501220703),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 3.0
    },

    --Grande barrière coté gauche 
    {
        objHash = GetHashKey("prop_facgate_07b"),
        objCoords = vector3(397.8851013183594, -1607.3861083984375, 28.341655731201172),
        textCoords = vector3(397.8851013183594, -1607.3861083984375, 28.341655731201172),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 12.0
    },
 
    --Petite grille
    {
        objHash = GetHashKey("prop_fnclink_03gate5"),
        objCoords = vector3(391.86016845703125, -1636.0701904296875, 29.974376678466797),
        textCoords = vector3(391.86016845703125, -1636.0701904296875, 29.974376678466797),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 5.0
    },

    --PCellule 

    {
        objHash = -674638964,
        objCoords = vector3(368.266845703125, -1605.0159912109375, 29.942127227783203),
        textCoords = vector3(368.266845703125, -1605.0159912109375, 29.942127227783203),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -674638964,
        objCoords = vector3(369.0669250488281, -1605.6873779296875, 29.942127227783203),
        textCoords = vector3(369.0669250488281, -1605.6873779296875, 29.942127227783203),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },

    --Coté gauche Davis
    {
        objHash = -425870000,
        objCoords = vector3(363.2424011230469, -1589.2093505859375, 31.144569396972656),
        textCoords = vector3(363.2424011230469, -1589.2093505859375, 31.144569396972656),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -425870000,
        objCoords = vector3(358.38262939453125, -1595.0009765625, 31.144569396972656),
        textCoords = vector3(358.38262939453125, -1595.0009765625, 31.144569396972656),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -425870000,
        objCoords = vector3(363.1488952636719, -1592.495849609375, 31.144569396972656),
        textCoords = vector3(363.1488952636719, -1592.495849609375, 31.144569396972656),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -425870000,
        objCoords = vector3(361.6097106933594, -1594.3302001953125, 31.144569396972656),
        textCoords = vector3(361.6097106933594, -1594.3302001953125, 31.144569396972656),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },

    --Coté droit DAVIS

    {
        objHash = -425870000,
        objCoords = vector3(382.8243103027344, -1599.0250244140625, 30.144508361816406),
        textCoords = vector3(382.8243103027344, -1599.0250244140625, 30.144508361816406),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1335406364,
        objCoords = vector3(384.42852783203125, -1601.959716796875, 30.144508361816406),
        textCoords = vector3(384.42852783203125, -1601.959716796875, 30.144508361816406),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1335406364,
        objCoords = vector3(374.6359558105469, -1613.6300048828125, 30.144508361816406),
        textCoords = vector3(374.6359558105469, -1613.6300048828125, 30.144508361816406),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },

    --Sous sol

    {
        objHash = -1335406364,
        objCoords = vector3(379.1722717285156, -1603.8255615234375, 25.5445117950439456),
        textCoords = vector3(379.1722717285156, -1603.8255615234375, 25.544511795043945),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1335406364,
        objCoords = vector3(375.5429992675781, -1608.1507568359375, 25.544511795043945),
        textCoords = vector3(375.5429992675781, -1608.1507568359375, 25.544511795043945),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -728950481,
        objCoords = vector3(371.9581604003906, -1605.1427001953125, 25.545440673828125),
        textCoords = vector3(371.9581604003906, -1605.1427001953125, 25.545440673828125),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1335406364,
        objCoords = vector3(368.89398193359375, -1602.571533203125, 25.545440673828125),
        textCoords = vector3(368.89398193359375, -1602.571533203125, 25.545440673828125),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -674638964,
        objCoords = vector3(375.8779602050781, -1599.1058349609375, 25.34305763244629),
        textCoords = vector3(375.8779602050781, -1599.1058349609375, 25.34305763244629),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -674638964,
        objCoords = vector3(375.077880859375, -1598.4345703125, 25.34305763244629),
        textCoords = vector3(375.077880859375, -1598.4345703125, 25.34305763244629),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1335406364,
        objCoords = vector3(370.41070556640625, -1598.5885009765625, 25.545440673828125),
        textCoords = vector3(370.41070556640625, -1598.5885009765625, 25.545440673828125),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = -1335406364,
        objCoords = vector3(368.864013671875, -1600.4317626953125, 25.545440673828125),
        textCoords = vector3(368.864013671875, -1600.4317626953125, 25.545440673828125),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = -1335406364,
        objCoords = vector3(367.1189880371094, -1601.0821533203125, 25.544511795043945),
        textCoords = vector3(367.1189880371094, -1601.0821533203125, 25.544511795043945),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1335406364,
        objCoords = vector3(363.88836669921875, -1595.471435546875, 25.545440673828125),
        textCoords = vector3(363.88836669921875, -1595.471435546875, 25.545440673828125),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -425870000,
        objCoords = vector3(367.85906982421875, -1594.3126220703125, 25.545513153076172),
        textCoords = vector3(367.85906982421875, -1594.3126220703125, 25.545513153076172),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -425870000,
        objCoords = vector3(369.7023010253906, -1595.859375, 25.545513153076172),
        textCoords = vector3(369.7023010253906, -1595.859375, 25.545513153076172),
        authorizedJobs = {"police"},
        locked = true,
        maxDistance = 1.5
    },


    -------- BANQUE

    {
        objHash = GetHashKey("hei_v_ilev_bk_gate_pris"),
        objCoords = vector3(257.09, 220.59, 106.29),
        textCoords = vector3(257.09, 220.59, 106.29),
        authorizedJobs = {"mazegroup"},
        locked = true,
        maxDistance = 1.50
    },
    {
        objHash = GetHashKey("v_ilev_bk_door"),
        objCoords = vector3(237.15, 228.26, 106.28),
        textCoords = vector3(237.15, 228.26, 106.28),
        authorizedJobs = {"mazegroup"},
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
        objCoords = vector3(-1836.90, -1190.34, 19.08),
        textCoords = vector3(-1836.90, -1190.34, 19.08),
        authorizedJobs = {'pearls'},
        locked = true,
        maxDistance = 1.5
    
    },
    {
        objHash = -1196002204,
        objCoords = vector3(-1830.24, -1181.78, 19.40),
        textCoords = vector3(-1830.24, -1181.78, 19.40),
        authorizedJobs = {'pearls'},
        locked = true,
        maxDistance = 1.5

    },
    {
        objHash = -1285189121,
        objCoords = vector3(-1847.27, -1189.99, 14.47),
        textCoords = vector3(-1847.27, -1189.99, 14.47),
        authorizedJobs = {'pearls'},
        locked = true,
        maxDistance = 1.5
    
    },
    {
        objHash = 1994441020,
        objCoords = vector3(-1815.88427734375, -1194.8330078125, 14.863202095031738),
        textCoords = vector3(-1815.88427734375, -1194.8330078125, 14.863202095031738),
        authorizedJobs = {'pearls'},
        locked = true,
        maxDistance = 1.5
    
    },
    {
        objHash = 1994441020,
        objCoords = vector3(-1817.9013671875, -1193.6683349609375, 14.863202095031738),
        textCoords = vector3(-1817.9013671875, -1193.6683349609375, 14.863202095031738),
        authorizedJobs = {'pearls'},
        locked = true,
        maxDistance = 1.5
    
    },
    {
        objHash = -1643773373,
        objCoords = vector3(-1845.4246826171875, -1194.8035888671875, 19.455190658569336),
        textCoords = vector3(-1845.4246826171875, -1194.8035888671875, 19.455190658569336),
        authorizedJobs = {'pearls'},
        locked = true,
        maxDistance = 1.5
    
    },
    {
        objHash = 1994441020,
        objCoords = vector3(-1843.049560546875, -1200.0379638671875, 14.863687515258789),
        textCoords = vector3(-1843.049560546875, -1200.0379638671875, 14.863687515258789),
        authorizedJobs = {'pearls'},
        locked = true,
        maxDistance = 1.5
    
    },
    {
        objHash = 1994441020,
        objCoords = vector3(-1841.8841552734375, -1198.0194091796875, 14.863687515258789),
        textCoords = vector3(-1841.8841552734375, -1198.0194091796875, 14.863687515258789),
        authorizedJobs = {'pearls'},
        locked = true,
        maxDistance = 1.5
    
    },
    {
        objHash = 1994441020,
        objCoords = vector3(-1823.80810546875, -1202.057373046875, 19.992624282836914),
        textCoords = vector3(-1823.80810546875, -1202.057373046875, 19.992624282836914),
        authorizedJobs = {'pearls'},
        locked = true,
        maxDistance = 1.5
    
    },
    {
        objHash = 1994441020,
        objCoords = vector3(-1822.6376953125, -1200.036376953125, 19.957948684692383),
        textCoords = vector3(-1822.6376953125, -1200.036376953125, 19.957948684692383),
        authorizedJobs = {'pearls'},
        locked = true,
        maxDistance = 1.5
    
    },
    {
        objHash = 1870406214,
        objCoords = vector3(-1831.5758056640625, -1180.9742431640625, 14.749608993530273),
        textCoords = vector3(-1831.5758056640625, -1180.9742431640625, 14.749608993530273),
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
        maxDistance = 0.1
    },
    {
        objHash = -1995612459,
        objHeading = 90.00,
        objCoords = vector3(731.99, 2524.66, 73.67),
        textCoords = vector3(731.99, 2524.66, 73.67),
        authorizedJobs = {"--"},
        locked = true,
        maxDistance = 0.1
    },
    {
        objHash = -1576989776,
        objHeading = 90.00,
        objCoords = vector3(715.11, 2531.74, 73.55),
        textCoords = vector3(715.11, 2531.74, 73.55),
        authorizedJobs = {"--"},
        locked = true,
        maxDistance = 0.1
    },
    {
        objHash = -1576989776,
        objHeading = 180.00,
        objCoords = vector3(713.50, 2530.03, 73.55),
        textCoords = vector3(713.50, 2530.03, 73.55),
        authorizedJobs = {"--"},
        locked = true,
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
    {
        objHash = -770740285,
        objHeading = 250.95,
        objCoords = vector3(105.96, 14.36, 67.86),
        textCoords = vector3(106.37, 14.54, 67.86),
        authorizedJobs = {"pawnshop"},
        locked = true,
        maxDistance = 2.5
    },
    {
        textCoords = vector3(-162.9, 891.82, 233.47),
        authorizedJobs = {"pawnshop"},
        locked = true,
        maxDistance = 2.5,
        doors = {
            {objHash = -1574510328, objHeading = 312.50, objCoords = vector3(-162.27, 891.07, 233.47)},
            {objHash = -1574510328, objHeading = 135.50, objCoords = vector3(-162.9, 891.82, 233.47)}
        }
    },
    {
        textCoords = vector3(-162.9, 891.81, 237.14),
        authorizedJobs = {"pawnshop"},
        locked = true,
        maxDistance = 2.5,
        doors = {
            {objHash = -1574510328, objHeading = 135.50, objCoords = vector3(-163.59, 892.48, 237.14)},
            {objHash = -1574510328, objHeading = 315.50, objCoords = vector3(-162.38, 891.24, 237.14)}
        }
    },
    {
        objHash = -770740285,
        objHeading = 250.95,
        objCoords = vector3(105.96, 14.36, 67.86),
        textCoords = vector3(106.37, 14.54, 67.86),
        authorizedJobs = {"pawnshop"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = -711771128,
        objHeading = 45.95,
        objCoords = vector3(-143.34, 902.16, 235.64),
        textCoords = vector3(-143.34, 902.16, 235.64),
        authorizedJobs = {"pawnshop"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = -1742794577,
        objHeading = 45.95,
        objCoords = vector3(-151.79, 910.72, 235.66),
        textCoords = vector3(-151.79, 910.72, 235.66),
        authorizedJobs = {"pawnshop"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = 2040120023,
        objHeading = 235.95,
        objCoords = vector3(-130.4, 867.66, 232.76),
        textCoords = vector3(-130.4, 867.66, 232.76),
        authorizedJobs = {"pawnshop"},
        locked = true,
        maxDistance = 2.5
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
    {
        objHash = -1989765534,
        objHeading = 165.2,
        objCoords = vector3(355.39, 301.58, 103.75),
        textCoords = vector3(354.97, 301.32, 103.35),
        authorizedJobs = {"night"},
        locked = true,
        maxDistance = 2.0
    },
    {
        objHash = -1555108147,
        objHeading = 75.0,
        objCoords = vector3(378.21, 268.44, 94.99),
        textCoords = vector3(378.21, 268.44, 94.75),
        authorizedJobs = {"night"},
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
        --Mirror
    {
        objHash = -1540703659,
        objCoords = vector3(-1343.294677734375, -1076.096923828125, 7.269369602203369),
        textCoords = vector3(-1343.294677734375, -1076.096923828125, 7.269369602203369),
        authorizedJobs = {"restaurant"},
        locked = true,
        maxDistance = 2.0
    },
    
    {
        objHash = -1132262566,
        objCoords = vector3(-1341.0965576171875, -1074.8541259765625, 7.269369602203369),
        textCoords = vector3(-1341.0965576171875, -1074.8541259765625, 7.269369602203369),
        authorizedJobs = {"restaurant"},
        locked = true,
        maxDistance = 2.0
    },
    
    {
        objHash = GetHashKey("v_ilev_fa_roomdoor"),
        objCoords = vector3(-1349.6475830078125, -1063.7611083984375, 7.036352634429932),
        textCoords = vector3(-1349.6475830078125, -1063.7611083984375, 7.036352634429932),
        authorizedJobs = {"restaurant"},
        locked = true,
        maxDistance = 2.0
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

    {
        objHash = -700626879,
        objCoords = vector3(-816.2236328125, -740.1626586914062, 24.16523551940918),
        textCoords = vector3(-816.2236328125, -740.1626586914062, 24.16523551940918),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 15.5
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
        --Distillerie 

    {
        objHash = 1815716966,
        objCoords = vector3(-1871.9615478515625, 2060.8994140625, 140.07327270507812),
        textCoords = vector3(-1871.9615478515625, 2060.8994140625, 140.07327270507812),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },


    {
        objHash = 1077118233,
        objCoords = vector3(-1861.68896484375, 2054.115966796875, 141.3535919189453),
        textCoords = vector3(-1861.68896484375, 2054.115966796875, 141.3535919189453),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = 1077118233,
        objCoords = vector3(-1859.2139892578125, 2054.117919921875, 141.35350036621094),
        textCoords = vector3(-1859.2139892578125, 2054.117919921875, 141.35350036621094),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --NEW HANGER DISTILLERIE
    {
        objHash = 1815716966,
        objCoords = vector3(-1928.3271484375, 2059.145751953125, 139.8361053466797),
        textCoords = vector3(-1928.3271484375, 2059.145751953125, 139.8361053466797),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = 1815716966,
        objCoords = vector3(-1936.303466796875, 2051.64453125, 139.8461151123047),
        textCoords = vector3(-1936.303466796875, 2051.64453125, 139.8461151123047),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = 1815716966,
        objCoords = vector3(-1934.127197265625, 2040.0555419921875, 139.8362274169922),
        textCoords = vector3(-1934.127197265625, 2040.0555419921875, 139.8362274169922),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --GRANDE PORTES

    {
        objHash = -1592519073,
        objCoords = vector3(-1927.9227294921875, 2040.4224853515625, 139.80450439453125),
        textCoords = vector3(-1927.9227294921875, 2040.4224853515625, 139.80450439453125),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -1537041208,
        objCoords = vector3(-1927.03515625, 2044.07275390625, 139.8050994873047),
        textCoords = vector3(-1927.03515625, 2044.07275390625, 139.8050994873047),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },
    --

    {
        objHash = -1592519073,
        objCoords = vector3(-1926.482177734375, 2046.427734375, 139.80450439453125),
        textCoords = vector3(-1926.482177734375, 2046.427734375, 139.80450439453125),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -1537041208,
        objCoords = vector3(-1925.6065673828125, 2050.0810546875, 139.80419921875),
        textCoords = vector3(-1925.6065673828125, 2050.0810546875, 139.80419921875),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

        --

    {
        objHash = -1592519073,
        objCoords = vector3(-1924.9549560546875, 2052.81201171875, 139.8140411376953),
        textCoords = vector3(-1924.9549560546875, 2052.81201171875, 139.8140411376953),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -1537041208,
        objCoords = vector3(-1924.07470703125, 2056.46484375, 139.81495666503906),
        textCoords = vector3(-1924.07470703125, 2056.46484375, 139.81495666503906),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --

    {
        objHash = 1700020285,
        objCoords = vector3(-1885.2110595703125, 2050.3798828125, 141.30850219726562),
        textCoords = vector3(-1885.2110595703125, 2050.3798828125, 141.30850219726562),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = 1700020285,
        objCoords = vector3(-1887.5340576171875, 2051.23388671875, 141.3125),
        textCoords = vector3(-1887.5340576171875, 2051.23388671875, 141.3125),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --

    {
        objHash = -889651514,
        objCoords = vector3(-1887.903076171875, 2051.386962890625, 141.3115234375),
        textCoords = vector3(-1887.903076171875, 2051.386962890625, 141.3115234375),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -889651514,
        objCoords = vector3(-1890.22509765625, 2052.23583984375, 141.3125),
        textCoords = vector3(-1890.22509765625, 2052.23583984375, 141.3125),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --
    {
        objHash = 1320052052,
        objCoords = vector3(-1907.7320556640625, 2071.8779296875, 140.91310119628906),
        textCoords = vector3(-1907.7320556640625, 2071.8779296875, 140.91310119628906),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -1069282247,
        objCoords = vector3(-1909.6240234375, 2073.471923828125, 140.91519165039062),
        textCoords = vector3(-1909.6240234375, 2073.471923828125, 140.91519165039062),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --

    {
        objHash = 1700020285,
        objCoords = vector3(-1910.208984375, 2073.968994140625, 140.91310119628906),
        textCoords = vector3(-1910.208984375, 2073.968994140625, 140.91310119628906),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = 1700020285,
        objCoords = vector3(-1912.10107421875, 2075.56005859375, 140.91490173339844),
        textCoords = vector3(-1912.10107421875, 2075.56005859375, 140.91490173339844),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --

    {
        objHash = 1700020285,
        objCoords = vector3(-1911.81005859375, 2078.794921875, 140.9114990234375),
        textCoords = vector3(-1911.81005859375, 2078.794921875, 140.9114990234375),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = 1700020285,
        objCoords = vector3(-1910.2020263671875, 2080.678955078125, 140.9114990234375),
        textCoords = vector3(-1910.2020263671875, 2080.678955078125, 140.9114990234375),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --

    {
        objHash = 1320052052,
        objCoords = vector3(-1909.557861328125, 2081.17138671875, 139.38800048828125),
        textCoords = vector3(-1909.557861328125, 2081.17138671875, 139.38800048828125),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -1069282247,
        objCoords = vector3(-1907.9757080078125, 2083.06396484375, 139.38844299316406),
        textCoords = vector3(-1907.9757080078125, 2083.06396484375, 139.38844299316406),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --

    {
        objHash = 1700020285,
        objCoords = vector3(-1902.882080078125, 2086.544921875, 140.9167938232422),
        textCoords = vector3(-1902.882080078125, 2086.544921875, 140.9167938232422),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = 1700020285,
        objCoords = vector3(-1900.993896484375, 2084.947265625, 140.91883850097656),
        textCoords = vector3(-1900.993896484375, 2084.947265625, 140.91883850097656),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --

    {
        objHash = 1700020285,
        objCoords = vector3(-1900.406005859375, 2084.44677734375, 140.9145965576172),
        textCoords = vector3(-1900.406005859375, 2084.44677734375, 140.9145965576172),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = 1700020285,
        objCoords = vector3(-1898.5140380859375, 2082.85205078125, 140.91525268554688),
        textCoords = vector3(-1898.5140380859375, 2082.85205078125, 140.91525268554688),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --

    {
        objHash = 1700020285,
        objCoords = vector3(-1894.72998046875, 2075.967041015625, 141.3125),
        textCoords = vector3(-1894.72998046875, 2075.967041015625, 141.3125),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -889651514,
        objCoords = vector3(-1892.8330078125, 2074.380859375, 141.30850219726562),
        textCoords = vector3(-1892.8330078125, 2074.380859375, 141.30850219726562),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },
--

    {
        objHash = 1700020285,
        objCoords = vector3(-1859.2659912109375, 2054.219970703125, 139.9886932373047),
        textCoords = vector3(-1859.2659912109375, 2054.219970703125, 139.9886932373047),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -889651514,
        objCoords = vector3(-1861.730712890625, 2054.22265625, 139.9886932373047),
        textCoords = vector3(-1861.730712890625, 2054.22265625, 139.9886932373047),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },
    --

    {
        objHash = 1700020285,
        objCoords = vector3(-1887.2430419921875, 2074.307861328125, 141.3125),
        textCoords = vector3(-1887.2430419921875, 2074.307861328125, 141.3125),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -889651514,
        objCoords = vector3(-1884.9210205078125, 2073.4619140625, 141.30850219726562),
        textCoords = vector3(-1884.9210205078125, 2073.4619140625, 141.30850219726562),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    --

    {
        objHash = 1700020285,
        objCoords = vector3(-1875.614013671875, 2070.06787109375, 141.3125),
        textCoords = vector3(-1875.614013671875, 2070.06787109375, 141.3125),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },

    {
        objHash = -889651514,
        objCoords = vector3(-1873.2939453125, 2069.2197265625, 141.30850219726562),
        textCoords = vector3(-1873.2939453125, 2069.2197265625, 141.30850219726562),
        authorizedJobs = {"distillerie"},
        locked = true,
        maxDistance = 1.5
    },
    
        --bahamas
    {
        objHash = 1266543998,
        objCoords = vector3(-1389.4876708984375, -623.2332763671875, 30.36359977722168),
        textCoords = vector3(-1389.4876708984375, -623.2332763671875, 30.36359977722168),
        authorizedJobs = {"bahamas"},
        locked = true,
        maxDistance = 2.5
    },
    --
    {
        objHash = -880376952,
        objCoords = vector3(-1387.0535888671875, -586.5787963867188, 30.386581420898438),
        textCoords = vector3(-1387.0535888671875, -586.5787963867188, 30.386581420898438),
        authorizedJobs = {"bahamas"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = -880376952,
        objCoords = vector3(-1389.2301025390625, -587.9961547851562, 30.3863525390625),
        textCoords = vector3(-1389.2301025390625, -587.9961547851562, 30.3863525390625),
        authorizedJobs = {"bahamas"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = -1266543998,
        objCoords = vector3(-1389.48767089843755, -623.2332763671875, 30.36359977722168),
        textCoords = vector3(-1389.4876708984375, -623.2332763671875, 30.36359977722168),
        authorizedJobs = {"bahamas"},
        locked = true,
        maxDistance = 2.5
    },
    {
        objHash = GetHashKey("prop_ch3_04_door_02"),
        objCoords = vector3(-1379.41748046875, -628.7461547851562, 28.888845443725586),
        textCoords = vector3(-1379.41748046875, -628.7461547851562, 28.888845443725586),
        authorizedJobs = {"bahamas"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1459022116,
        objCoords = vector3(-1379.3011474609375, -636.8530883789062, 29.627294540405273),
        textCoords = vector3(-1379.3011474609375, -636.8530883789062, 29.627294540405273),
        authorizedJobs = {"bahamas"},
        locked = true,
        maxDistance = 7.0
    },
       
    --Japonnais

    {
        objHash = -965106369,
        objCoords = vector3(-170.99729919433594, 285.9325866699219, 93.95906066894531),
        textCoords = vector3(-170.99729919433594, 285.9325866699219, 93.95906066894531),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 2.0
    },
    {
        objHash = 2012678195,
        objCoords = vector3(-168.76629638671875, 285.9325866699219, 93.95906066894531),
        textCoords = vector3(-168.76629638671875, 285.9325866699219, 93.95906066894531),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 2.0
    },
    {
        objHash = -369464256,
        objCoords = vector3(-166.6422882080078, 285.9216003417969, 93.9600601196289),
        textCoords = vector3(-166.6422882080078, 285.9216003417969, 93.9600601196289),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1653288146,
        objCoords = vector3(-153.15528869628906, 287.3235778808594, 93.9600601196289),
        textCoords = vector3(-153.15528869628906, 287.3235778808594, 93.9600601196289),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 1.5
    },
    {
        objHash = -1093560853,
        objCoords = vector3(-150.498291015625, 294.818603515625, 99.09606170654297),
        textCoords = vector3(-150.498291015625, 294.818603515625, 99.09606170654297),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 2.0
    },
    {
        objHash = -726253128,
        objCoords = vector3(-152.8032989501953, 294.818603515625, 99.09606170654297),
        textCoords = vector3(-152.8032989501953, 294.818603515625, 99.09606170654297),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 2.0
    },
    {
        objHash = -1089711493,
        objCoords = vector3(-168.7952880859375, 299.99859619140625, 93.9150619506836),
        textCoords = vector3(-168.7952880859375, 299.99859619140625, 93.9150619506836),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 2.0
    },
    {
        objHash = -1089711493,
        objCoords = vector3(-171.24530029296875, 299.99859619140625, 93.9150619506836),
        textCoords = vector3(-171.24530029296875, 299.99859619140625, 93.9150619506836),
        authorizedJobs = {"littleseaoul"},
        locked = true,
        maxDistance = 2.0
    },
    ---Taco Loco

    {
        objHash = GetHashKey("prop_bs_map_door_01"),
        objCoords = vector3(416.14190673828125, -1903.447509765625, 25.763065338134766),
        textCoords = vector3(416.14190673828125, -1903.447509765625, 25.763065338134766),
        authorizedJobs = {"tacoloco"},
        locked = true,
        maxDistance = 2.0
    },

    {
        objHash = GetHashKey("prop_bs_map_door_01"),
        objCoords = vector3(421.2456970214844, -1923.8768310546875, 25.66853904724121),
        textCoords = vector3(421.2456970214844, -1923.8768310546875, 25.66853904724121),
        authorizedJobs = {"tacoloco"},
        locked = true,
        maxDistance = 2.0
    },

    {
        objHash = -567327289,
        objCoords = vector3(410.99761962890625, -1909.6868896484375, 25.716644287109375),
        textCoords = vector3(410.99761962890625, -1909.6868896484375, 25.716644287109375),
        authorizedJobs = {"tacoloco"},
        locked = true,
        maxDistance = 2.0
    },
    {
        objHash = -567327289,
        objCoords = vector3(410.89947509765625, -1911.7393798828125, 25.714988708496094),
        textCoords = vector3(410.89947509765625, -1911.7393798828125, 25.714988708496094),
        authorizedJobs = {"tacoloco"},
        locked = true,
        maxDistance = 2.0
    },
    {
        objHash = 1973208947,
        objCoords = vector3(1284.107421875, -3198.490234375, 6.268798828125),
        textCoords = vector3(1284.107421875, -3198.490234375, 6.268798828125),
        authorizedJobs = {"admin_drug"},
        locked = true,
        maxDistance = 1.5
    },

    -- Gouv

    -- Porte Bureau Gourverneur
    {
        objHash = -88942360,
        objCoords = vector3(-1292.257, -568.2955, 41.33635),
        objHeading = 39.85,
        textCoords = vector3(-1292.257, -568.2955, 41.33635),
        authorizedJobs = {"gouv", "usss"},
        locked = true,
        maxDistance = 1.5
    },
    -- Porte Bureau Gouverneur Bibliotèque
    {
        objHash = 648668464,
        objCoords = vector3(-1302.737, -569.4383, 40.18527),
        textCoords = vector3(-1302.737, -569.4383, 41.18527),
        authorizedJobs = {"gouv", "usss"},
        shouldCorrectPosition = true,
        locked = true,
        maxDistance = 3.0
    },
    -- 1st Floor : Secured Room
    {
        objHash = -88942360,
        objCoords = vector3(-1291.357, -579.2186, 34.52389),
        objHeading = 130.0,
        textCoords = vector3(-1291.357, -579.2186, 34.52389),
        authorizedJobs = {"gouv", "usss"},
        locked = true,
        maxDistance = 1.5
    },

    -- Ascenseur Secret Room
    {
        textCoords = vector3(-1306.4, -558.6, 20.7996),
        authorizedJobs = {'gouv', 'usss'},
        locked = true,
        maxDistance = 3.0,
        shouldCorrectPosition = true,
        doors = {
            {objHash = -1240156945, objCoords = vector3(-1305.896, -558.2148, 19.7996) },
            {objHash = -1240156945, objCoords = vector3(-1307.047, -559.183, 19.79929) }
        }
    },

    -- Back door

    {
        textCoords = vector3(-1298.4, -578, 30.72524),
        authorizedJobs = {'gouv', 'usss'},
        locked = true,
        maxDistance = 3.0,
        doors = {
            {objHash = 320433149, objHeading = 310.0,  objCoords = vector3(-1297.908, -579.0725, 30.72524) },
            {objHash = -1215222675, objHeading = 310.0, objCoords = vector3(-1299.579, -577.0803, 30.72524) }
        }
    },


    --G6

    {
        objHash = GetHashKey("v_ilev_fib_door1"),
        objCoords = vector3(-225.36578369140625, -850.4068603515625, 30.79456329345703),
        textCoords = vector3(-225.36578369140625, -850.4068603515625, 30.79456329345703),
        authorizedJobs = {"g6"},
        locked = true,
        maxDistance = 3.0
    },
    {
        objHash = GetHashKey("v_ilev_fib_door1"),
        objCoords = vector3(-224.48020935058594, -847.9667358398438, 30.795902252197266),
        textCoords = vector3(-224.48020935058594, -847.9667358398438, 30.795902252197266),
        authorizedJobs = {"g6"},
        locked = true,
        maxDistance = 3.0
    },

    {
        objHash = GetHashKey("v_ilev_fib_door1"),
        objCoords = vector3(-234.9197540283203, -846.9386596679688, 30.832172393798828 ),
        textCoords = vector3(-234.9197540283203, -846.9386596679688, 30.832172393798828),
        authorizedJobs = {"g6"},
        locked = true,
        maxDistance = 3.0
    },
    {
        objHash = GetHashKey("v_ilev_fib_door1"),
        objCoords = vector3(-234.028076171875, -844.4890747070312, 30.832172393798828 ),
        textCoords = vector3(-234.028076171875, -844.4890747070312, 30.832172393798828),
        authorizedJobs = {"g6"},
        locked = true,
        maxDistance = 3.0
    },

    --Galaxy
    {
        objHash = -957944942,
        objCoords = vector3(403.9532165527344, 248.79542541503906, 92.18533325195312),
        textCoords = vector3(403.9532165527344, 248.79542541503906, 92.18533325195312),
        authorizedJobs = {"night"},
        locked = true,
        maxDistance = 1.5
    },
    --PatocheGang
    {
        objHash = -69870955,
        objCoords = vector3(-348.03662109375, 48.77885818481445, 44.076019287109375),
        textCoords = vector3(-348.03662109375, 48.77885818481445, 44.076019287109375),
        authorizedJobs = {"admin_drug"},
        locked = true,
        maxDistance = 1.5
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
