Station = {
  decor = "FUEL_LEVEL",
  decor_harvest = "FUEL_HA",
  decor_treatment = "FUEL_TR",
  max_fuel = 10000,
  limitLiters = 600/7500, --400 limite de farm / 7500 nombres de litres max pour atteindre la limite de farm - valeur x 7500 = limite de farm

  -- MASSE RP
  autoFuel = true,
  autoRemoveTime = 60, -- minutes
  autoMinFuel = 10,
  autoMaxFuel = 25,
  -----------

  work = {
    tanker = {
      blipTitle = "Garage citerne",
      msg = "Appuyez sur ~INPUT_CONTEXT~ pour sortir une citerne",
      pos = vector3(-116.280, -2516.60, 6.00),
      radius = 1.50,
      spawn = vector4(-103.999, -2512.969, 5.30, 242.00),
      action = "fueler:spawnTanker"
    },

    harvest = {
      blipTitle = "Récolte",
      msg = "Appuyez sur ~INPUT_CONTEXT~ pour remplir votre citerne",
      pos = {
        vector3(1724.212, -1649.600, 112.00),
        vector3(1709.548, -1653.640, 112.00)
      },
      radius = 5.00,
      action = "fueler:harvest",
      time = 20, --secondes / temps approximatif
      qty = 2500.0
    },
    treatment = {
      blipTitle = "Traitement",
      msg = "Appuyez sur ~INPUT_CONTEXT~ pour traiter le contenu de votre citerne",
      pos = {
        vector3(2726.366, 1710.714, 24.00),
        vector3(2784.149, 1710.137, 24.00)
      },
      radius = 3.00,
      action = "fueler:treatment",
      time = 20, --secondes / temps approximatif
   }
  },

  ped = { 
    model = "mp_m_waremech_01",
    dict = "timetable@gardener@filling_can",
    anim = "gar_ig_5_filling_can"
  },

  pumpModel = {
    "prop_gas_pump_1a",
    "prop_gas_pump_1b",
    "prop_gas_pump_1c",
    "prop_gas_pump_1d",
    "prop_gas_pump_old2",
    "prop_gas_pump_old3",
    "prop_vintage_pump"
  },

  electric = {
    pump = "stt_prop_stunt_bowling_pin",
    cars = {
      GetHashKey("AIRTUG"),
      GetHashKey("CADDY"),
      GetHashKey("CYCLONE"),
      GetHashKey("DILETTANTE"),
      GetHashKey("IMORGON"),
      GetHashKey("KHAMELION"),
      GetHashKey("NEON"),
      GetHashKey("RAIDEN"),
      GetHashKey("SURGE"),
      GetHashKey("TEZERACT"),
      GetHashKey("VOLTIC"),
      GetHashKey("POLRAIDEN")
    }
  },

  pos =  {
    cars = {
      blip = {
        title = "Station essence",
        title2 = "Borne électrique"
      },
      {
        id = 1,
        coords = vector3(265.02, -1262.519, 29.00),
        radius = 15.00,
        coords2 = vector3(276.757, -1240.441, 28.70),
        radius2 = 5.00,
        pedPos = vector4(289.167, -1266.818, 28.50, 90.00),
        priceL = 1.60
      }, --Unicorn
      {
        id = 2,
        coords = vector3(-724.114, -935.561, 18.50),
        radius = 12.00,
        coords2 = vector3(-730.581, -909.194, 18.50),
        radius2 = 4.00,
        pedPos = vector4(-707.900, -903.683, 18.50, 182.00),
        priceL = 1.50
      }, --Little Seoul
      {
        id = 3,
        coords = vector3(620.915, 268.641, 102.40),
        radius = 13.00,
        coords2 = vector3(640.592, 285.208, 102.60),
        radius2 = 4.00,
        pedPos = vector4(645.989, 267.520, 102.50, 60.00),
        priceL = 2.00
      }, -- Vinewood
      {
        id = 4,
        coords = vector3(-2096.698, -319.225, 13.16),
        radius = 15.00,
        pedPos = vector4(-2072.919, -327.300, 12.50, 79.56),
        priceL = 1.40
      }, -- Greet Ocean Highway Sud
      {
        id = 5,
        coords = vector3(-2555.518, 2334.439, 32.70),
        radius = 12.50,
        pedPos = vector4(-2554.261, 2316.176, 32.50, 20.00),
        priceL = 1.10
      }, -- Base militaire
      {
        id = 6,
        coords = vector3(1038.903, 2671.105, 39.20),
        radius = 8.00,
        coords2 = vector3(1065.174, 2669.05, 39.10),
        radius2 = 4.00,
        pedPos = vector4(1039.431, 2664.362, 38.70, 2.40),
        priceL = 1.30
      }, -- Route 68
      {
        id = 7,
        coords = vector3(2005.242, 3774.282, 31.80),
        radius = 7.00,
        pedPos = vector4(2001.589, 3779.619, 31.40, 212.86),
        priceL = 1.10
      }, -- PDS
      {
        id = 8, 
        coords = vector3(1701.793, 6416.504, 32.75), 
        radius = 12.50,
        pedPos = vector4(1698.833, 6425.950, 32.00, 160.59),
        priceL = 1.30
      }, --Paleto Freeway Nord-Est
      {
        id = 9,
        coords = vector3(179.769, 6604.841, 31.40),
        radius = 10.50,
        pedPos = vector4(175.087, 6643.103, 31.00, 314.00),
        priceL = 1.20
      }, -- Paleto
      {
        id = 10,
        coords = vector3(2581.034, 361.797, 108.05), 
        radius = 11.50,
        pedPos = vector4(2559.441, 373.684, 107.80, 266.58),
        priceL = 1.30
      }, -- Palomino Freeway
      {
        id = nil, 
        coords = vector3(-64.0269, -2529.3581, 3.07), 
        radius = 5.0, 
        priceL = 2.50
      },-- Raffinerie
      {
        id = 11, 
        coords = vector3(2679.931, 3264.138, 54.80), 
        radius = 5.00, 
        pedPos = vector4(2674.089, 3287.093, 54.50, 154.00), 
        priceL = 1.10
      }, --Sandy Shores You tool
            --Newww
      {
        id = 12, 
        coords = vector3(49.4187, 2778.793, 58.043), 
        radius = 5.00, 
        pedPos = vector4(59.1960, 2795.3947, 57.87, 302.7285), 
        priceL = 1.10
      }, 
      {
        id = 13, 
        coords = vector3(263.894, 2606.463, 44.983), 
        radius = 5.00, 
        pedPos = vector4(265.9018, 2598.2233, 44.8427, 22.30), 
        priceL = 1.10
      },
      {
        id = 14, 
        coords = vector3(1207.260, 2660.175, 37.899), 
        radius = 5.00, 
        pedPos = vector4(1202.1508, 2654.2246, 37.85, 330.9847), 
        priceL = 1.10
      },
      {
        id = 15, 
        coords = vector3(2539.685, 2594.192, 37.944), 
        radius = 5.00, 
        pedPos = vector4(2549.0190, 2581.6379, 37.95, 103.3665), 
        priceL = 1.10
      },
      {
        id = 16, 
        coords = vector3(-94.4619, 6419.594, 31.489), 
        radius = 5.00, 
        pedPos = vector4(-92.6918, 6409.9794, 31.64, 38.87), 
        priceL = 1.10
      },
      {
        id = 17, 
        coords = vector3(-1800.375, 803.661, 138.651), 
        radius = 15.00, 
        pedPos = vector4(-1829.5999, 801.5898, 138.4157, 31.70), 
        priceL = 1.10
      },
      {
        id = 18, 
        coords = vector3(-526.019, -1211.003, 18.184), 
        radius = 15.00, 
        pedPos = vector4(-532.1085, -1220.6647, 18.45, 327.0500), 
        priceL = 1.10
      },
      {
        id = 19, 
        coords = vector3(-70.2148, -1761.792, 29.534), 
        radius = 15.00, 
        pedPos = vector4(-40.8526, -1747.4045, 29.30, 259.77), 
        priceL = 1.10
      },
      {
        id = 20, 
        coords = vector3(1208.951, -1402.567,35.224),
        radius = 15.00, 
        pedPos = vector4(1211.3699, -1389.2189, 35.37, 175.0447), 
        priceL = 1.10
      },
      {
        id = 21, 
        coords = vector3(1181.381, -330.847, 69.316),
        radius = 15.00, 
        pedPos = vector4(1160.6176, -311.9264, 69.27, 332.35), 
        priceL = 1.10
      },
      {
        id = 22, 
        coords = vector3(176.631, -1562.025, 29.263),
        radius = 15.00, 
        pedPos = vector4(167.0162, -1553.1114, 29.26, 228.2322), 
        priceL = 1.10
      },
      {
        id = 23, 
        coords = vector3(-319.292, -1471.715, 30.549),
        radius = 15.00, 
        pedPos = vector4(-342.3093, -1474.9770, 30.74, 276.07), 
        priceL = 1.10
      },
      {
        id = 24, 
        coords = vector3(1784.324, 3330.55, 41.253),
        radius = 5.00, 
        pedPos = vector4(1776.3747, 3327.7448, 41.4332, 301.8170), 
        priceL = 1.10
      },
      {
        id = 25,
        coords = vector3(818.988, -1028.414, 26.40),
        radius = 11.00,
        pedPos = vector4(818.099, -1040.414, 25.80, 6.30),
        priceL = 2.50
      }, --La mesa
      {
        id = 26,
        coords = vector3(1687.271, 4929.771, 42.07),
        radius = 6.50,
        pedPos = vector4(1707.588, 4918.836, 41.50, 53.25),
        priceL = 2.30
      }, --Grapeseed
      {
        id = 27,
        coords = vector3(-1436.879, -276.893, 45.80),
        radius = 11.00,
        pedPos = vector4(-1428.467, -268.639, 45.50, 140.00),
        priceL = 2.80
      }, --Rockford Hills
      {
        id = 28,
        coords = vector3(1141.2871, -3272.8576, 5.89),
        radius = 20.00,
        pedPos = vector4(1107.3109, -3286.9926, 5.8973, 267.4181),
        priceL = 2.80
      }, --B FOX
    },

    boats = {
      blip ={
        title = "Station essence"
      },
      {
        id = nil, 
        coords = vector3(-860.115, -1486.192, 0.50), 
        radius = 12.0, 
        priceL = 3.0
      }, -- Los Santos port
      {
        id = nil, 
        coords = vector3(1343.80, 4225.00, 31.00), 
        radius = 5.0, 
        priceL = 2.50
      }, -- Lac Sandy Shores
      {
        id = nil, 
        coords = vector3(-1603.740, 5260.672, 0.30), 
        radius = 3.0, 
        priceL = 2.20
      } -- Nord Ouest   
    },
    
    air = {
      blip ={
        title = "Station essence"
      },
      {
        id = nil, 
        coords = vector3(-735.045, -1456.415, 5.00), 
        radius = 20.0, 
        priceL = 4.00
      }, -- Los Santos port
      {
        id = nil, 
        coords = vector3(1770.182, 3239.948, 42.50), 
        radius = 3.0, 
        priceL = 4.00
      } -- Sandy Shores Aérodrome
    }
  },

  vehClasses = {
    [0] = 1.5, -- Compacts
    [1] = 1.8, -- Sedans
    [2] = 2.1, -- SUVs
    [3] = 2.4, -- Coupes
    [4] = 2.7, -- Muscle
    [5] = 2.9, -- Sports Classics
    [6] = 3.0, -- Sports
    [7] = 3.3, -- Super
    [8] = 1.5, -- Motorcycles
    [9] = 2.4, -- Off-road
    [10] = 1.5, -- Industrial
    [11] = 1.5, -- Utility
    [12] = 1.5, -- Vans
    [13] = 0.0, -- Cycles
    [14] = 0.1, -- Boats
    [15] = 0.6, -- Helicopters
    [16] = 0.6, -- Planes
    [17] = 1.5, -- Service
    [18] = 1.5, -- Emergency
    [19] = 1.8, -- Military
    [20] = 1.8, -- Commercial
    [21] = 3.0 -- Trains
  },

  vehUsageByRPM = {
    [1.0] = 0.50,
    [0.9] = 0.45,
    [0.8] = 0.40,
    [0.7] = 0.35,
    [0.6] = 0.30,
    [0.5] = 0.25,
    [0.4] = 0.20,
    [0.3] = 0.15,
    [0.2] = 0.10,
    [0.1] = 0.05,
    [0.0] = 0.0
  }
}