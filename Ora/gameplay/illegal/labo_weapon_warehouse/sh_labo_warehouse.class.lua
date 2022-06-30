
--[[
********************************************************
********************************************************
***********   ILLEGAL LABS AND WAREHOUSES  *************
********************************************************
********************************************************

* Methods related to the IllegalLabsAndWarehouse class
]]

IllegalLabsAndWarehouse = IllegalLabsAndWarehouse or {}


IllegalLabsAndWarehouse.ORDER_STATUS = {
  processing = "En cours de traitement",
  waiting_delivery = "En attente de livraison",
  delivered = "Livrée",
}

--[[
****************   CONFIGURATIONS   *******************
]]

IllegalLabsAndWarehouse.AVAILABLE_DRUGS = {
  -- WEED
  weed = {
    label = "CANNABIS",
    description = "Weed - feuille de cannabis",
    interior = vector3(1065.99, -3183.42, -39.16),
    vault = vector3(1039.67, -3193.3, -38.17 - 0.95),
    computer = vector3(1044.55, -3194.71, -38.16 - 0.95),
    workplaces = {
        [1] = {
            id = "workplace_1",
            pos = vector3(1038.0,-3202.95,-38.17 - 0.95)
        },
        [2] = {
            id = "workplace_2",
            pos = vector3(1039.2,-3205.77,-38.17 - 0.95)
        },
        [3] = {
            id = "workplace_3",
            pos = vector3(1034.65, -3206.08, -38.18 - 0.95)
        },
        [4] = {
            id = "workplace_4",
            pos = vector3(1032.39,-3202.96, -38.18 - 0.95)
        }
    },
    attackTime = 900,
    limitations = {
        craft_time = 60,
        item_quality = 35,
        required = {
          {name = "weed_plant", count = 15}
        },
        give_item = "weed_pooch",
        give_item_count = 40
    },
    delivery = {
      {start = vector3(-39.71, -2531.21, 6.01), startHeading = 320.88, finish = vector3(-159.7, -2401.63, 6.0)},
      {start = vector3(115.55, -2635.47, 6.03), startHeading = 177.85, finish = vector3(-120.16, -2675.29, 6.01)},
      {start = vector3(-887.01, -2270.08, 6.71), startHeading = 340.05, finish = vector3(-911.71, -2051.22, 9.3)},
      {start = vector3(-1037.67, -1441.2, 5.09), startHeading = 202.0, finish = vector3(-969.22, -1583.45, 5.02)},
      {start = vector3(697.2, -845.69, 24.32), startHeading = 273.09, finish = vector3(803.83, -818.15, 26.18)},
      {start = vector3(892.8580, -2249.0532, 30.5401), startHeading = 352.06, finish = vector3(893.3366, -2355.1560, 30.4310)},
      {start = vector3(-332.61, -2171.81, 10.32), startHeading = 359.17, finish = vector3(-486.6180, -2170.4899, 9.2401)},
      {start = vector3(1247.91, -3143.93, 5.75), startHeading = 287.09, finish = vector3(1184.32, -3021.78, 5.9)}
    },
    ingredients = {
      weed_plant = { price = 7, max_qty = 35 }
    },
    security = {
      [1] = {
          label = "Sécurité améliorée niveau 1",
          description = "Pour 100 000$ vous obtenez 20 minutes au total pour défendre votre labo en cas d'attaque (15 minutes de base)",
          price = 100000,
          time = 300
      },
      [2] = {
          label = "Sécurité améliorée niveau 2",
          description = "Pour 150 000$ vous obtenez 30 minutes au total pour défendre votre labo en cas d'attaque (15 minutes de base)",
          price = 150000,
          time = 900
      }
    },
    production = {
      -- This is not cumulative, so you always have to start from the base limitation
      [1] = {
          label = "Production niveau 1",
          description = "Pour 30 000$ vous produisez de la qualité : Moyenne",
          price = 30000,
          addon = {
            item_quality = 49
          }
      },
      [2] = {
          label = "Production niveau 2",
          description = "Pour 70 000$ vous produisez de la qualité : Bonne",
          price = 70000,
          addon = {
            item_quality = 74
          }
      },
      [3] = {
        label = "Production niveau 3",
        description = "Pour 100 000$ vous produisez autant avec moins de composants (-3 composants de chaque)",
        price = 50000,
        addon = {
          item_quality = 74,
          required = {
            {name = "weed_plant", count = 12}
          }
        }
      },
      [4] = {
        label = "Production niveau 4",
        description = "Pour 70 000$ vous produisez en 45 minutes au lieu de 1 heure",
        price = 70000,
        addon = {
          craft_time = 45,
          item_quality = 74,
          required = {
            {name = "weed_plant", count = 12}
          }
        }
      },
      [5] = {
        label = "Production niveau 5",
        description = "Pour 100 000$ vous produisez de la qualité : Excellente",
        price = 50000,
        addon = {
          craft_time = 45,
          item_quality = 90,
          required = {
            {name = "weed_plant", count = 12}
          }
        }
      },
      [6] = {
        label = "Production niveau 6",
        description = "Pour 70 000$ vous produisez en 30 minutes au lieu de 1 heure",
        price = 70000,
        addon = {
          craft_time = 30,
          item_quality = 90,
          required = {
            {name = "weed_plant", count = 12}
          }
        }
      },
      [7] = {
          label = "Production niveau 7",
          description = "Pour 100 000$ vous produisez de la qualité : Inegalable",
          price = 50000,
          addon = {
            craft_time = 30,
            item_quality = 100,
            required = {
              {name = "weed_plant", count = 12}
            }
          }
      },
    },
  },
  -- METH
  meth = {
    label = "METH",
    description = "Meth (Necessite ephedrine, et acétone)",
    interior = vector3(997.13, -3200.83, -36.39),
    vault = vector3(998.14, -3200.1, -38.99 - 0.95),
    computer = vector3(1001.99, -3194.96, -38.99 - 0.95),
    workplaces = {
        [1] = {
            id = "workplace_1",
            pos = vector3(1011.03,-3200.19,-38.99 - 0.95)
        },
        [2] = {
            id = "workplace_2",
            pos = vector3(1014.93,-3198.32,-38.99 - 0.95)
        },
        [3] = {
            id = "workplace_3",
            pos = vector3(1010.87,-3196.35,-38.99 - 0.95)
        },
        [4] = {
            id = "workplace_4",
            pos = vector3(1005.92,-3197.97, -38.99 - 0.95)
        }
    },
    attackTime = 900,
    limitations = {
        craft_time = 60,
        item_quality = 35,
        required = {
          {name = "ephedrine", count = 15},
          {name = "acetone", count = 15}
        },
        give_item = "meth",
        give_item_count = 25
    },
    ingredients = {
        ephedrine = { price = 5, max_qty = 90 },
        acetone = { price = 2, max_qty = 90 },
    },
    delivery = {
      {start = vector3(-39.71, -2531.21, 6.01), startHeading = 320.88, finish = vector3(-159.7, -2401.63, 6.0)},
      {start = vector3(115.55, -2635.47, 6.03), startHeading = 177.85, finish = vector3(-120.16, -2675.29, 6.01)},
      {start = vector3(-887.01, -2270.08, 6.71), startHeading = 340.05, finish = vector3(-911.71, -2051.22, 9.3)},
      {start = vector3(-1037.67, -1441.2, 5.09), startHeading = 202.0, finish = vector3(-969.22, -1583.45, 5.02)},
      {start = vector3(697.2, -845.69, 24.32), startHeading = 273.09, finish = vector3(803.83, -818.15, 26.18)},
      {start = vector3(892.8580, -2249.0532, 30.5401), startHeading = 352.06, finish = vector3(893.3366, -2355.1560, 30.4310)},
      {start = vector3(-332.61, -2171.81, 10.32), startHeading = 359.17, finish = vector3(-611.46, -2169.79, 5.99)},
      {start = vector3(1247.91, -3143.93, 5.75), startHeading = 287.09, finish = vector3(1184.32, -3021.78, 5.9)}
    },
    security = {
      [1] = {
          label = "Sécurité améliorée niveau 1",
          description = "Pour 100 000$ vous obtenez 20 minutes au total pour défendre votre labo en cas d'attaque (15 minutes de base)",
          price = 100000,
          time = 300
      },
      [2] = {
          label = "Sécurité améliorée niveau 2",
          description = "Pour 100 000$ vous obtenez 30 minutes au total pour défendre votre labo en cas d'attaque (15 minutes de base)",
          price = 150000,
          time = 900
      }
    },
    production = {
      -- This is not cumulative, so you always have to start from the base limitation
      [1] = {
          label = "Production niveau 1",
          description = "Pour 30 000$ vous produisez de la qualité : Moyenne",
          price = 30000,
          addon = {
            item_quality = 49
          }
      },
      [2] = {
          label = "Production niveau 2",
          description = "Pour 70 000$ vous produisez de la qualité : Bonne",
          price = 70000,
          addon = {
            item_quality = 74
          }
      },
      [3] = {
        label = "Production niveau 3",
        description = "Pour 100 000$ vous produisez autant avec moins de composants (-3 composants de chaque)",
        price = 100000,
        addon = {
          item_quality = 74,
          required = {
            {name = "ephedrine", count = 12},
            {name = "acetone", count = 12}
          }
        }
      },
      [4] = {
        label = "Production niveau 4",
        description = "Pour 70 000$ vous produisez en 45 minutes au lieu de 1 heure",
        price = 70000,
        addon = {
          craft_time = 45,
          item_quality = 74,
          required = {
            {name = "ephedrine", count = 12},
            {name = "acetone", count = 12}
          }
        }
      },
      [5] = {
        label = "Production niveau 5",
        description = "Pour 100 000$ vous produisez de la qualité : Excellente",
        price = 100000,
        addon = {
          craft_time = 45,
          item_quality = 90,
          required = {
            {name = "ephedrine", count = 12},
            {name = "acetone", count = 12}
          }
        }
      },
      [6] = {
        label = "Production niveau 6",
        description = "Pour 70 000$ vous produisez en 30 minutes au lieu de 1 heure",
        price = 70000,
        addon = {
          craft_time = 30,
          item_quality = 90,
          required = {
            {name = "ephedrine", count = 12},
            {name = "acetone", count = 12}
          }
        }
      },
      [7] = {
          label = "Production niveau 7",
          description = "Pour 100 000$ vous produisez de la qualité : Inegalable",
          price = 100000,
          addon = {
            craft_time = 30,
            item_quality = 100,
            required = {
              {name = "ephedrine", count = 12},
              {name = "acetone", count = 12}
            }
          }
      },
    }
  },
   -- LSD
   lsd = {
    label = "LSD",
    description = "LSD (Necessite champignons, et acide sulfurique)",
    interior = vector3(1088.51, -3188.0, -38.99),
    vault = vector3(1100.64, -3198.39, -38.99 - 0.95),
    computer = vector3(1087.27, -3194.23, -38.99 - 0.95),
    attackTime = 900,
    limitations = {
        craft_time = 60,
        item_quality = 35,
        required = {
          {name = "acidecoke", count = 15},
          {name = "champignon", count = 15}
        },
        give_item = "lsd_pooch",
        give_item_count = 20
    },
    delivery = {
      {start = vector3(-39.71, -2531.21, 6.01), startHeading = 320.88, finish = vector3(-159.7, -2401.63, 6.0)},
      {start = vector3(115.55, -2635.47, 6.03), startHeading = 177.85, finish = vector3(-120.16, -2675.29, 6.01)},
      {start = vector3(-887.01, -2270.08, 6.71), startHeading = 340.05, finish = vector3(-911.71, -2051.22, 9.3)},
      {start = vector3(-1037.67, -1441.2, 5.09), startHeading = 202.0, finish = vector3(-969.22, -1583.45, 5.02)},
      {start = vector3(697.2, -845.69, 24.32), startHeading = 273.09, finish = vector3(803.83, -818.15, 26.18)},
      {start = vector3(1146.39, -1481.27, 34.69), startHeading = 352.06, finish = vector3(1206.02, -1269.38, 35.23)},
      {start = vector3(-332.61, -2171.81, 10.32), startHeading = 359.17, finish = vector3(-611.46, -2169.79, 5.99)},
      {start = vector3(1247.91, -3143.93, 5.75), startHeading = 287.09, finish = vector3(1184.32, -3021.78, 5.9)}
    },
    ingredients = {
        acidecoke = { price = 3, max_qty = 60 },
        champignon = { price = 7, max_qty = 60 },
    },
    security = {
      [1] = {
          label = "Sécurité améliorée niveau 1",
          description = "Pour 100 000$ vous obtenez 20 minutes au total pour défendre votre labo en cas d'attaque (15 minutes de base)",
          price = 100000,
          time = 300
      },
      [2] = {
          label = "Sécurité améliorée niveau 2",
          description = "Pour 150 000$ vous obtenez 30 minutes au total pour défendre votre labo en cas d'attaque (15 minutes de base)",
          price = 150000,
          time = 900
      }
    },
    production = {
      -- This is not cumulative, so you always have to start from the base limitation
      [1] = {
          label = "Production niveau 1",
          description = "Pour 30 000$ vous produisez de la qualité : Moyenne",
          price = 30000,
          addon = {
            item_quality = 49
          }
      },
      [2] = {
          label = "Production niveau 2",
          description = "Pour 70 000$ vous produisez de la qualité : Bonne",
          price = 70000,
          addon = {
            item_quality = 74
          }
      },
      [3] = {
        label = "Production niveau 3",
        description = "Pour 100 000$ vous produisez autant avec moins de composants (-3 composants de chaque)",
        price = 100000,
        addon = {
          item_quality = 74,
          required = {
            {name = "acidecoke", count = 12},
            {name = "champignon", count = 12}
          }
        }
      },
      [4] = {
        label = "Production niveau 4",
        description = "Pour 70 000$ vous produisez en 45 minutes au lieu de 1 heure",
        price = 70000,
        addon = {
          craft_time = 45,
          item_quality = 74,
          required = {
            {name = "acidecoke", count = 12},
            {name = "champignon", count = 12}
          }
        }
      },
      [5] = {
        label = "Production niveau 5",
        description = "Pour 100 000$ vous produisez de la qualité : Excellente",
        price = 100000,
        addon = {
          craft_time = 45,
          item_quality = 90,
          required = {
            {name = "acidecoke", count = 12},
            {name = "champignon", count = 12}
          }
        }
      },
      [6] = {
        label = "Production niveau 6",
        description = "Pour 70 000$ vous produisez en 30 minutes au lieu de 1 heure",
        price = 70000,
        addon = {
          craft_time = 30,
          item_quality = 90,
          required = {
            {name = "acidecoke", count = 12},
            {name = "champignon", count = 12}
          }
        }
      },
      [7] = {
          label = "Production niveau 7",
          description = "Pour 100 000$ vous produisez de la qualité : Inegalable",
          price = 100000,
          addon = {
            craft_time = 30,
            item_quality = 100,
            required = {
              {name = "acidecoke", count = 12},
              {name = "champignon", count = 12}
            }
          }
      },
    },
    workplaces = {
        [1] = {
            id = "workplace_1",
            pos = vector3(1095.34, -3197.0, -38.99 - 0.95)
        },
        [2] = {
            id = "workplace_2",
            pos = vector3(1090.38,-3196.86,-38.99 - 0.95)
        },
        [3] = {
            id = "workplace_3",
            pos = vector3(1090.31,-3194.7,-38.99 - 0.95)
        },
        [4] = {
            id = "workplace_4",
            pos = vector3(1095.26,-3194.59, -38.99 - 0.95)
        }
    }
  },
   -- COCAINE
   cocaine = {
    label = "COCAINE",
    description = "Cocaine (Necessite cocaine pure, et acide sulfurique)",
    interior = vector3(1088.51, -3188.0, -38.99),
    vault = vector3(1100.64, -3198.39, -38.99 - 0.95),
    computer = vector3(1087.27, -3194.23, -38.99 - 0.95),
    attackTime = 900,
    delivery = {
      {start = vector3(-39.71, -2531.21, 6.01), startHeading = 320.88, finish = vector3(-159.7, -2401.63, 6.0)},
      {start = vector3(115.55, -2635.47, 6.03), startHeading = 177.85, finish = vector3(-120.16, -2675.29, 6.01)},
      {start = vector3(-887.01, -2270.08, 6.71), startHeading = 340.05, finish = vector3(-911.71, -2051.22, 9.3)},
      {start = vector3(-1037.67, -1441.2, 5.09), startHeading = 202.0, finish = vector3(-969.22, -1583.45, 5.02)},
      {start = vector3(697.2, -845.69, 24.32), startHeading = 273.09, finish = vector3(803.83, -818.15, 26.18)},
      {start = vector3(1146.39, -1481.27, 34.69), startHeading = 352.06, finish = vector3(1206.02, -1269.38, 35.23)},
      {start = vector3(-332.61, -2171.81, 10.32), startHeading = 359.17, finish = vector3(-611.46, -2169.79, 5.99)},
      {start = vector3(1247.91, -3143.93, 5.75), startHeading = 287.09, finish = vector3(1184.32, -3021.78, 5.9)}
    },
    limitations = {
        craft_time = 60,
        item_quality = 35,
        required = {
          {name = "coke", count = 15},
          {name = "acidecoke", count = 15}
        },
        give_item = "coke1",
        give_item_count = 20
    },
    ingredients = {
        acidecoke = { price = 3, max_qty = 60 },
        coke = { price = 5, max_qty = 60 },
    },
    security = {
      [1] = {
          label = "Sécurité améliorée niveau 1",
          description = "Pour 100 000$ vous obtenez 20 minutes au total pour défendre votre labo en cas d'attaque (15 minutes de base)",
          price = 100000,
          time = 300
      },
      [2] = {
          label = "Sécurité améliorée niveau 2",
          description = "Pour 150 000$ vous obtenez 30 minutes au total pour défendre votre labo en cas d'attaque (15 minutes de base)",
          price = 150000,
          time = 900
      }
    },
    production = {
      -- This is not cumulative, so you always have to start from the base limitation
      [1] = {
          label = "Production niveau 1",
          description = "Pour 30 000$ vous produisez de la qualité : Moyenne",
          price = 30000,
          addon = {
            item_quality = 49
          }
      },
      [2] = {
          label = "Production niveau 2",
          description = "Pour 70 000$ vous produisez de la qualité : Bonne",
          price = 70000,
          addon = {
            item_quality = 74
          }
      },
      [3] = {
        label = "Production niveau 3",
        description = "Pour 100 000$ vous produisez autant avec moins de composants (-3 composants de chaque)",
        price = 100000,
        addon = {
          item_quality = 74,
          required = {
            {name = "coke", count = 12},
            {name = "acidecoke", count = 12}
          }
        }
      },
      [4] = {
        label = "Production niveau 4",
        description = "Pour 70 000$ vous produisez en 45 minutes au lieu de 1 heure",
        price = 70000,
        addon = {
          craft_time = 45,
          item_quality = 74,
          required = {
            {name = "coke", count = 12},
            {name = "acidecoke", count = 12}
          }
        }
      },
      [5] = {
        label = "Production niveau 5",
        description = "Pour 100 000$ vous produisez de la qualité : Excellente",
        price = 100000,
        addon = {
          craft_time = 45,
          item_quality = 90,
          required = {
            {name = "coke", count = 12},
            {name = "acidecoke", count = 12}
          }
        }
      },
      [6] = {
        label = "Production niveau 6",
        description = "Pour 70 000$ vous produisez en 30 minutes au lieu de 1 heure",
        price = 70000,
        addon = {
          craft_time = 30,
          item_quality = 90,
          required = {
            {name = "coke", count = 12},
            {name = "acidecoke", count = 12}
          }
        }
      },
      [7] = {
          label = "Production niveau 7",
          description = "Pour 100 000$ vous produisez de la qualité : Inegalable",
          price = 100000,
          addon = {
            craft_time = 30,
            item_quality = 100,
            required = {
              {name = "coke", count = 12},
              {name = "acidecoke", count = 12}
            }
          }
      }
    },
    workplaces = {
        [1] = {
            id = "workplace_1",
            pos = vector3(1095.34, -3197.0, -38.99 - 0.95)
        },
        [2] = {
            id = "workplace_2",
            pos = vector3(1090.38,-3196.86,-38.99 - 0.95)
        },
        [3] = {
            id = "workplace_3",
            pos = vector3(1090.31,-3194.7,-38.99 - 0.95)
        },
        [4] = {
            id = "workplace_4",
            pos = vector3(1095.26,-3194.59, -38.99 - 0.95)
        }
    }
  }
}


IllegalLabsAndWarehouse.AVAILABLE_GUNLEADS = {
  reselleur = {
    label = "Item illégaux",
    description = "Divers items illégaux",
    interior = vector3(179.17, -1000.68, -99.0),
    vault = vector3(169.76, -1005.82, -150.0 - 0.95),
    computer = vector3(172.92, -1000.34, -99.0 - 0.95),
    attackTime = 900,
    delivery = {
      {start = vector3(-1153.26, 2674.54, 18.09), startHeading = 151.48, finish = vector3(-900.03, 2576.89, 57.44)},
      {start = vector3(-350.13, 2953.2, 25.78), startHeading = 265.89, finish = vector3(-173.5, 2860.82, 31.88)},
      {start = vector3(2461.79, 3432.88, 50.15), startHeading = 203.46, finish = vector3(2671.62, 3514.82, 52.71)},
      {start = vector3(886.83, 2831.92, 56.29), startHeading = 117.13, finish = vector3(657.55, 2974.55, 42.94)}
    },
    limitations = {
      {name = "pinces", byWeek = 50, price = 15},
      {name = "fertz", byWeek = 1000, price = 10},
      {name = "crochetage", byWeek = 200, price = 20},
      {name = "menottes", byWeek = 100, price = 70},
      {name = "darknet", byWeek = 50, price = 500},
      {name = "molotov", byWeek = 50, price = 15000},
      {name = "allumette", byWeek = 550, price = 250},
      {name = "molotovartisanal", byWeek = 50, price = 1500}
    },
    security = {
      [1] = {
          label = "",
          description = "",
          price = 0,
          time = 0
      }
    },
    production = {
      [1] = {
          label = "",
          description = "",
          price = 0,
          addon = {}
      }
    }
  },
  gunlead1 = {
    label = "Gunlead 1",
    description = "Pétoire, Beretta, Pistolet Lourd, Calibre.50, Machette, Hache de guerre, Dague antique, Explosif artisanal",
    interior = vector3(179.17, -1000.68, -99.0),
    vault = vector3(169.76, -1005.82, -99.0 - 0.95),
    computer = vector3(172.92, -1000.34, -99.0 - 0.95),
    attackTime = 900,
    delivery = {
      {start = vector3(-1153.26, 2674.54, 18.09), startHeading = 151.48, finish = vector3(-900.03, 2576.89, 57.44)},
      {start = vector3(-350.13, 2953.2, 25.78), startHeading = 265.89, finish = vector3(-173.5, 2860.82, 31.88)},
      {start = vector3(2461.79, 3432.88, 50.15), startHeading = 203.46, finish = vector3(2671.62, 3514.82, 52.71)},
      {start = vector3(886.83, 2831.92, 56.29), startHeading = 117.13, finish = vector3(657.55, 2974.55, 42.94)}
    },
    limitations = {
      {name = "machete", byWeek = 15, price = 200},
      {name = "dagger", byWeek = 15, price = 200},
      {name = "combathatchet", byWeek =15, price = 200},
      {name = "snspistol", byWeek = 10, price = 3500},
      {name = "pistol", byWeek = 15, price = 5000},
      {name = "pitollourd", byWeek = 3, price = 9000},
      {name = "mm9", byWeek = 1000, price = 2},
      {name = "acp45", byWeek = 500, price = 2},
      {name = "stickybomb", byWeek = 10, price = 1500},
      ----
      {name = "shootguncompact", byWeek = 0, price = 30000},
      {name = "revolver", byWeek = 0, price = 22000},
      {name = "minismg", byWeek = 0, price = 25000},
      {name = "machinepistol", byWeek = 0, price = 55000},
      {name = "microsmg", byWeek = 0, price = 75000},
      {name = "snip", byWeek = 0, price = 4},
      {name = "calibre12", byWeek = 0, price = 3},


    },
    security = {
      [1] = {
          label = "Sécurité améliorée niveau 1",
          description = "Pour 100 000$ vous obtenez 20 minutes au total pour défendre votre dépot d'arme en cas d'attaque (15 minutes de base)",
          price = 100000,
          time = 300
      },
      [2] = {
          label = "Sécurité améliorée niveau 2",
          description = "Pour 150 000$ vous obtenez 30 minutes au total pour défendre votre dépot d'arme en cas d'attaque (15 minutes de base)",
          price = 150000,
          time = 900
      }
    },
    production = {
      -- This is not cumulative, so you always have to start from the base limitation
      [1] = {
          label = "Confiance commerciale 1",
          description = "Pour 35 000$ vous obtenez 3 Berettas, 2 pistolets lourds, 250 balles de 9mm et 2 explosifs artisanaux en plus par semaine par rapport à la limite de base",
          price = 35000,
          addon = {
            pistol = 3,
            pitollourd = 2,
            mm9 = 250,
            stickybomb = 2,
          }
      },
      [2] = {
          label = "Confiance commerciale 2",
          description = "Pour 75 000$ vous obtenez 5 Berettas, 3 pistolets lourds, 2 canons sciés, 500 balles de 9mm et 5 explosifs artisanaux en plus par semaine par rapport à la limite de base",
          price = 75000,
          addon = {
            pistol = 5,
            pitollourd = 3,
            mm9 = 500,
            calibre12 = 150,
            shootguncompact = 2,
            stickybomb = 5,
          }
      },
      [3] = {
        label = "Confiance commerciale 3",
        description = "Pour 55 000$ vous obtenez 5 Berettas, 2 pistolets lourds, 2 canons sciés, 1 Skorpion, 2 Revolvers,  750 balles de 9mm et 3 explosifs artisanaux en plus par semaine par rapport à la limite de base",
        price = 55000,
        addon = {
          pistol = 5,
          pitollourd = 2,
          shootguncompact = 2,
          revolver = 2,
          minismg = 1,
          mm9 = 750,
          stickybomb = 3,
          snip = 200,
        }
      },
      [4] = {
        label = "Confiance commerciale 4",
        description = "Pour 85 000$ vous obtenez 5 Berettas, 3 pistolets lourds, 2 Skorpions, 1 Tec9, 60 Calibre 12, 750 balles de 9mm et 3 explosifs artisanaux en plus par semaine par rapport à la limite de base",
        price = 85000,
        addon = {
          pistol = 5,
          pitollourd = 3,
          minismg = 2,
          machinepistol = 1,
          mm9 = 750,
          stickybomb = 3,
          shootguncompact = 2,
          calibre12 = 60,
        }
      },
      [5] = {
        label = "Confiance commerciale 5",
        description = "Pour 45 000$ vous obtenez 5 berettas, 2 canons sciés, 2 Skorpions, 1500 balles de 9mm, 2 Tec9, 60 Calibre 12, et 2 explosifs artisanaux en plus par semaine par rapport à la limite de base",
        price = 45000,
        addon = {
          pistol = 5,
          shootguncompact = 2,
          minismg = 3,
          machinepistol = 2,
          mm9 = 1500,
          stickybomb = 2,
          calibre12 = 60,
        }
      },
      -- This is not cumulative, so you always have to start from the base limitation
      [6] = {
          label = "Confiance commerciale 6",
          description = "Pour 85 000$ vous obtenez 10 Berettas, 5 pistolets lourds, 2 Skorpions, 2500 balles de 9mm, 2 Tec9, 2 Uzis 60 Calibre 12 et 10 explosifs artisanaux en plus par semaine par rapport à la limite de base",
          price = 85000,
          addon = {
            pistol = 10,
            pitollourd = 5,
            minismg = 2,
            microsmg = 2,
            machinepistol = 2,
            mm9 = 2500,
            stickybomb = 10,
            calibre12 = 60,
          }
      }
    }
  },
  gunlead2 = {
    label = "Gunlead 2",
    description = "Beretta, Desert Eagle, UZI, Fusil a pompe",
    interior = vector3(179.17, -1000.68, -99.0),
    vault = vector3(169.76, -1005.82, -99.0 - 0.95),
    computer = vector3(172.92, -1000.34, -99.0 - 0.95),
    attackTime = 900,
    delivery = {
      {start = vector3(2728.6, 4826.18, 40.43), startHeading = 12.92, finish = vector3(2605.29, 4553.25, 35.57)},
      {start = vector3(-497.66, 4925.52, 147.14), startHeading = 47.74, finish = vector3(-649.35, 5089.68, 132.38)},
      {start = vector3(-2357.45, 2846.17, 3.8), startHeading = 78.18, finish = vector3(-2648.92, 2952.82, 8.74)},
      {start = vector3(-761.56, -2288.9, 12.86), startHeading = 65.52, finish = vector3(-1013.16, -2223.1, 8.99)}
    },
    limitations = {
      {name = "pistol", byWeek = 15, price = 5000},
      {name = "pistol50", byWeek = 3, price = 10000},
      {name = "microsmg", byWeek = 1, price = 60000},
      {name = "shootgun", byWeek = 2, price = 38500},
      {name = "dagger", byWeek = 5, price = 50},
      {name = "stickybomb", byWeek = 10, price = 1500},
      {name = "mm9", byWeek = 1000, price = 2},
      {name = "snip", byWeek = 108, price = 7},
      {name = "calibre12", byWeek = 50, price = 5}
    },
    security = {
      [1] = {
          label = "Sécurité améliorée niveau 1",
          description = "Pour 100 000$ vous obtenez 20 minutes au total pour défendre votre dépot d'arme en cas d'attaque (15 minutes de base)",
          price = 100000,
          time = 300
      },
      [2] = {
          label = "Sécurité améliorée niveau 2",
          description = "Pour 150 000$ vous obtenez 30 minutes au total pour défendre votre dépot d'arme en cas d'attaque (15 minutes de base)",
          price = 150000,
          time = 900
      }
    },
    production = {
      -- This is not cumulative, so you always have to start from the base limitation
      [1] = {
          label = "Confiance commerciale 1",
          description = "Pour 35 000$ vous obtenez 3 berettas, 1 Desert Eagle, 250 balles de 9mm et 35 balles de .300 Magnum en plus par semaine par rapport à la limite de base",
          price = 35000,
          addon = {
            pistol = 3,
            pistol50 = 1,
            mm9 = 250,
            snip = 35
          }
      },
      [2] = {
          label = "Confiance commerciale 2",
          description = "Pour 75 000$ vous obtenez 6 berettas, 3 Desert Eagle, 500 balles de 9mm et 75 balles de .300 Magnum en plus par semaine par rapport à la limite de base",
          price = 75000,
          addon = {
            pistol = 6,
            pistol50 = 2,
            mm9 = 500,
            snip = 75
          }
      },
      [3] = {
        label = "Confiance commerciale 3",
        description = "Pour 55 000$ vous obtenez 15 berettas, 750 balles de 9mm et 5 Bombes artisanal en plus par semaine par rapport à la limite de base",
        price = 55000,
        addon = {
          pistol = 15,
          pistol50 = 3,
          mm9 = 750,
          snip = 75,
          stickybomb = 5,
        }
      },
      [4] = {
        label = "Confiance commerciale 4",
        description = "Pour 85 000$ vous obtenez 20 berettas, 1000 balles de 9mm et 7 Bombes artisanal en plus par semaine par rapport à la limite de base",
        price = 85000,
        addon = {
          pistol = 20,
          pistol50 = 3,
          mm9 = 1000,
          snip = 75,
          stickybomb = 7,
        }
      },
      [5] = {
        label = "Confiance commerciale 5",
        description = "Pour 45 000$ vous obtenez 25 berettas, 4 Desert Eagle, 1500 balles de 9mm, 150 balles de .300 et 10 Bombes artisanal en plus par semaine par rapport à la limite de base",
        price = 45000,
        addon = {
          pistol = 25,
          pistol50 = 4,
          mm9 = 1500,
          snip = 150,
          stickybomb = 10,
        }
      },
      -- This is not cumulative, so you always have to start from the base limitation
      [6] = {
          label = "Confiance commerciale 6",
          description = "Pour 85 000$ vous obtenez 35 berettas, 5 Desert Eagle, 2500 balles de 9mm, 250 balles de .300 Magnum et 15 Bombes artisanal en plus par semaine par rapport à la limite de base",
          price = 85000,
          addon = {
            pistol = 35,
            pistol50 = 5,
            mm9 = 2500,
            snip = 250,
            stickybomb = 15,
          }
      }
    }
  },
  gunlead3 = {
    label = "Gunlead 3",
    description = "Beretta, Desert Eagle, Skorpion, Fusil a pompe",
    interior = vector3(179.17, -1000.68, -99.0),
    vault = vector3(169.76, -1005.82, -99.0 - 0.95),
    computer = vector3(172.92, -1000.34, -99.0 - 0.95),
    attackTime = 900,
    delivery = {
      {start = vector3(1684.89, 4638.78, 44.08), startHeading = 303.98, finish = vector3(1717.83, 4805.65, 41.72)},
      {start = vector3(-139.53, 6351.38, 31.49), startHeading = 137.43, finish = vector3(33.69, 6287.19, 31.25)},
      {start = vector3(2905.63, 4553.33, 47.97), startHeading = 104.85, finish = vector3(2892.47, 4467.1, 48.15)},
      {start = vector3(-141.45, -2568.68, 6.0), startHeading = 85.68, finish = vector3(-308.12, -2720.16, 6.0)}
    },
    limitations = {
      {name = "pistol", byWeek = 15, price = 5000},
      {name = "pistol50", byWeek = 3, price = 10000},
      {name = "minismg", byWeek = 1, price = 60000},
      {name = "shootgun", byWeek = 2, price = 38500},
      {name = "stickybomb", byWeek = 10, price = 1500},
      {name = "combathatchet", byWeek = 5, price = 50},
      {name = "mm9", byWeek = 1000, price = 2},
      {name = "snip", byWeek = 108, price = 7},
      {name = "calibre12", byWeek = 50, price = 5}
    },
    security = {
      [1] = {
          label = "Sécurité améliorée niveau 1",
          description = "Pour 100 000$ vous obtenez 20 minutes au total pour défendre votre dépot d'arme en cas d'attaque (15 minutes de base)",
          price = 100000,
          time = 300
      },
      [2] = {
          label = "Sécurité améliorée niveau 2",
          description = "Pour 150 000$ vous obtenez 30 minutes au total pour défendre votre dépot d'arme en cas d'attaque (15 minutes de base)",
          price = 150000,
          time = 900
      }
    },
    production = {
      -- This is not cumulative, so you always have to start from the base limitation
      [1] = {
          label = "Confiance commerciale 1",
          description = "Pour 80 000$ vous obtenez 3 berettas, 1 Desert Eagle, 250 balles de 9mm et 35 balles de .300 Magnum en plus par semaine par rapport à la limite de base",
          price = 80000,
          addon = {
            pistol = 3,
            pistol50 = 1,
            mm9 = 250,
            snip = 35
          }
      },
      [2] = {
          label = "Confiance commerciale 2",
          description = "Pour 150 000$ vous obtenez 6 berettas, 2 Desert Eagle, 500 balles de 9mm et 75 balles de .300 Magnum en plus par semaine par rapport à la limite de base",
          price = 150000,
          addon = {
            pistol = 6,
            pistol50 = 2,
            mm9 = 500,
            snip = 75
          }
      },
      [3] = {
        label = "Confiance commerciale 3",
        description = "Pour 80 000$ vous obtenez 15 berettas, 750 balles de 9mm et 5 Bombes artisanal en plus par semaine par rapport à la limite de base",
        price = 80000,
        addon = {
          pistol = 15,
          pistol50 = 2,
          mm9 = 750,
          snip = 75,
          stickybomb = 5,
        }
      },
      [4] = {
        label = "Confiance commerciale 4",
        description = "Pour 150 000$ vous obtenez 20 berettas, 1000 balles de 9mm et 7 Bombes artisanal en plus par semaine par rapport à la limite de base",
        price = 150000,
        addon = {
          pistol = 20,
          pistol50 = 3,
          mm9 = 1000,
          snip = 75,
          stickybomb = 7,
        }
      },
      [5] = {
        label = "Confiance commerciale 5",
        description = "Pour 85 000$ vous obtenez 25 berettas, 4 Desert Eagle, 1500 balles de 9mm, 150 balles de .300 et 10 Bombes artisanal en plus par semaine par rapport à la limite de base",
        price = 85000,
        addon = {
          pistol = 25,
          pistol50 = 4,
          mm9 = 1500,
          snip = 150,
          stickybomb = 10,
        }
      },
      -- This is not cumulative, so you always have to start from the base limitation
      [6] = {
          label = "Confiance commerciale 6",
          description = "Pour 150 000$ vous obtenez 35 berettas, 5 Desert Eagle, 2500 balles de 9mm, 250 balles de .300 Magnum et 15 Bombes artisanal en plus par semaine par rapport à la limite de base",
          price = 150000,
          addon = {
            pistol = 35,
            pistol50 = 5,
            mm9 = 2500,
            snip = 250,
            stickybomb = 15,
          }
      }
    }
  },
}

IllegalLabsAndWarehouse.GUNLABELS = {
  pistol = "BERETTA | 9MM",
  pistol50 = "DEAGLE | .300",
  minismg = "SKORPION | 9MM",
  shootgun = "MOSSBERG 590 | CAL12",
  microsmg = "UZI | 9MM",
  pitollourd = "COLT 1911 | 9MM",
  machinepistol = "TEC9 | 9MM"
}

--[[
****************   CLASS METHODS   *******************
]]

IllegalLabsAndWarehouse.MIN_COPS_TO_SHIP = 0
IllegalLabsAndWarehouse.CURRENT_LAB = {}
IllegalLabsAndWarehouse.CURRENT_WAREHOUSE = {}
IllegalLabsAndWarehouse.LAB_OWN_LIST = {}
IllegalLabsAndWarehouse.WAREHOUSE_OWN_LIST = {}
IllegalLabsAndWarehouse.DELIVERY = {}


function IllegalLabsAndWarehouse.GetDrugQualityLabel(quality)

    local qualityLabel = "Qualité Merdique"

    if (quality > 10 and quality <= 35) then
        qualityLabel = "Qualité Basse"
    end

    if (quality > 35 and quality < 50) then
      qualityLabel = "Qualité Moyenne"
    end

    if (quality >= 50 and quality < 75) then
      qualityLabel = "Qualité Bonne"
    end

    if (quality >= 75 and quality <= 99) then
      qualityLabel = "Qualité Exceptionnelle"
    end

    if (quality == 100) then
      qualityLabel = "Qualité Inégalable"
    end

    return qualityLabel
end

function IllegalLabsAndWarehouse.GetDrugQualityForBusinessIdAndProductionLevel(businessId, productionLevel)
  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
  local defaultTime = 60

  if (business == nil) then
    print("^1[ERROR] No business with ID " .. businessId)
    return defaultTime
  end

  if (business.production == nil) then
    print("^1[ERROR] No production with ID " .. businessId)
    return defaultTime
  end

  if (productionLevel > 0 and business.production[productionLevel] == nil) then
    print("^1[ERROR] No production level : ".. productionLevel .." does not exists for business ID " .. businessId)
    return defaultTime
  end

  if (productionLevel == 0 or (business.production[productionLevel].addon ~= nil and business.production[productionLevel].addon.item_quality == nil)) then
      if (business.limitations.item_quality == nil) then
          print("^1[ERROR] No item_quality for level : ".. productionLevel .." and business ID " .. businessId)
          return defaultTime
      else
          return business.limitations.item_quality
      end
  else
    return business.production[productionLevel].addon.item_quality
  end
end

function IllegalLabsAndWarehouse.GetIngredientsForBusinessId(businessId)
  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
  local defaultIngredient = {}

  if (business == nil) then
    print("^1[ERROR] No business with ID " .. businessId)
    return defaultIngredient
  end

  if (business.ingredients == nil) then
    print("^1[ERROR] No ingredients with ID " .. businessId)
    return defaultIngredient
  end

  return business.ingredients
end

function IllegalLabsAndWarehouse.GetGiveItemForBusinessId(businessId)
  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)

  if (business == nil) then
      print("^1[ERROR] No business with ID " .. businessId)
      return nil
    end

  if (business.limitations == nil) then
    print("^1[ERROR] No limitations with ID " .. businessId)
    return nil
  end

  if (business.limitations.give_item == nil) then
    print("^1[ERROR] No give_item for business ID " .. businessId)
    return nil
  end

  return business.limitations.give_item
end

function IllegalLabsAndWarehouse.GetGiveItemCountBusinessId(businessId)
  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
  local defaultCount = 15

  if (business == nil) then
      print("^1[ERROR] No business with ID " .. businessId)
      return defaultCount
    end

  if (business.limitations == nil) then
    print("^1[ERROR] No limitations with ID " .. businessId)
    return defaultCount
  end

  if (business.limitations.give_item_count == nil) then
    print("^1[ERROR] No give_item_count for business ID " .. businessId)
    return defaultCount
  end

  return business.limitations.give_item_count
end

function IllegalLabsAndWarehouse.GetNeededMaterialForDrug(businessId, productionLevel)
  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)

  if (business == nil) then
      print("^1[ERROR] No business with ID " .. businessId)
      return {}
    end

  if (business.production == nil) then
    print("^1[ERROR] No production with ID " .. businessId)
    return {}
  end

  if (productionLevel > 0 and business.production[productionLevel] == nil) then
    print("^1[ERROR] No production level : ".. productionLevel .." does not exists for business ID " .. businessId)
    return {}
  end

  if (productionLevel == 0 or (business.production[productionLevel].addon ~= nil and business.production[productionLevel].addon.required == nil)) then
      if (business.limitations.required == nil) then
          print("^1[ERROR] No required items for level : ".. productionLevel .." and business ID " .. businessId)
          return {}
      else
          return business.limitations.required
      end
  else
      return business.production[productionLevel].addon.required
  end
end

function IllegalLabsAndWarehouse.GetNeededMaterialLabelsForDrug(businessId, productionLevel)
  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
  local neededMaterials = ""
  if (business == nil) then
      print("^1[ERROR] No business with ID " .. businessId)
      return neededMaterials
  end

  if (business.production == nil) then
    print("^1[ERROR] No production with ID " .. businessId)
    return neededMaterials
  end

  if (productionLevel > 0 and business.production[productionLevel] == nil) then
    print("^1[ERROR] No production level : ".. productionLevel .." does not exists for business ID " .. businessId)
    return neededMaterials
  end

  if (productionLevel == 0 or (business.production[productionLevel].addon ~= nil and business.production[productionLevel].addon.required == nil)) then
      if (business.limitations.required == nil) then
          print("^1[ERROR] No required items for level : ".. productionLevel .." and business ID " .. businessId)
          return "Aucun matériel"
      else
          for index, value in pairs(business.limitations.required) do
            local itemName = value.name
            if (Items[value.name] ~= nil and Items[value.name].label ~= nil) then
                itemName = Items[value.name].label
            end

            neededMaterials = neededMaterials .. "~b~" .. itemName .. "~w~ x ~r~" .. value.count .. "~s~\n"
          end

          return neededMaterials
      end
  else
      for index, value in pairs(business.production[productionLevel].addon.required) do
        local itemName = value.name
        if (Items[value.name] ~= nil and Items[value.name].label ~= nil) then
            itemName = Items[value.name].label
        end
        neededMaterials = neededMaterials .. "~b~" .. itemName .. "~w~ x ~r~" .. value.count .. "~s~\n"
      end

      return neededMaterials
  end
end

function IllegalLabsAndWarehouse.GetNeededTimeForDrug(businessId, productionLevel)
    local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
    local defaultTime = 60

    if (business == nil) then
      print("^1[ERROR] No business with ID " .. businessId)
      return defaultTime
    end

    if (business.production == nil) then
      print("^1[ERROR] No production with ID " .. businessId)
      return defaultTime
    end

    if (productionLevel > 0 and business.production[productionLevel] == nil) then
      print("^1[ERROR] No production level : ".. productionLevel .." does not exists for business ID " .. businessId)
      return defaultTime
    end

    if (productionLevel == 0 or (business.production[productionLevel].addon ~= nil and business.production[productionLevel].addon.craft_time == nil)) then
        if (business.limitations.craft_time == nil) then
            print("^1[ERROR] No craft_time for level : ".. productionLevel .." and business ID " .. businessId)
            return defaultTime
        else
            return business.limitations.craft_time
        end
    else
      return business.production[productionLevel].addon.craft_time
    end
end

-- Returns capacity of storage label
-- @returns string|nil
function IllegalLabsAndWarehouse.GetGunLabel(itemName)
    if (IllegalLabsAndWarehouse.GUNLABELS[itemName] ~= nil) then
        return IllegalLabsAndWarehouse.GUNLABELS[itemName]
    end

    return nil
end

-- Returns capacity of storage label
-- @returns string|nil
function IllegalLabsAndWarehouse.GetAttackTotalTime(businessId, securityLevel)
    local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
    local defaultAttackTime = 900
    
    if (business == nil) then
      print("^1[ERROR] No business with ID " .. businessId)
      return defaultAttackTime
    end

    if (business.attackTime == nil) then
      print("^1[ERROR] No attackTime with ID " .. businessId)
      return defaultAttackTime
    end

    if (securityLevel > 0 and business.security[securityLevel] == nil) then
      print("^1[ERROR] Security level : ".. productionLevel .." does not exists for business ID " .. businessId)
      return defaultAttackTime
    end

    local baseAttackTime = business.attackTime
    if (securityLevel > 0) then
        baseAttackTime = baseAttackTime + business.security[securityLevel].time
    end

    return baseAttackTime 
end

-- Returns capacity of storage label
-- @returns string|nil
function IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
  for index, value in pairs(IllegalLabsAndWarehouse.AVAILABLE_GUNLEADS) do
      if (index == businessId) then
         return value
      end
  end

  for index, value in pairs(IllegalLabsAndWarehouse.AVAILABLE_DRUGS) do
      if (index == businessId) then
          return value
      end
  end    
  
  print("^1[ERROR] No business configuration for key : " .. businessId)
  return nil
end

-- Returns capacity of storage label
-- @returns string
function IllegalLabsAndWarehouse.GetCapacityLabel(capacity)
    return capacity .. "KG"
end

-- Returns the business label by providing business id
-- @returns string
function IllegalLabsAndWarehouse.GetBusinessLabel(businessId)

  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)

    if (business ~= nil) then
        return business.label
    end

    print("^1[ERROR] No label configured for business : " .. businessId)
    return ""
end

-- Returns the type label by providing type id
-- @returns string
function IllegalLabsAndWarehouse.GetTypeLabel(typeId)
    if (typeId == "drug") then
        return "Laboratoire de drogue"
    else
        return "Dépot d'armes"
    end
end

-- Returns the interior coords for given business id
-- @returns table
function IllegalLabsAndWarehouse.GetInteriorCoordsByBusinessId(businessId)
    local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
    
    if (business ~= nil) then
        return business.interior
    end

    print("^1[ERROR] No interior configured for business : " .. businessId)
    return nil
end

-- Returns properly configured limitation for a business given the production level
-- @returns table
function IllegalLabsAndWarehouse.ApplyProductionToLimitation(businessId, limitation, type, level)
  local productionLevels = IllegalLabsAndWarehouse.GetProductionEvolutionsByBusinessId(businessId)

  if (limitation == nil) then
      return {}
  end

  if (productionLevels == nil) then 
      return limitation
  end

  if (level == 0) then
      return limitation
  end

  if (productionLevels[level] == nil) then
      return limitation
  end

  local productionLevel = productionLevels[level]

  if (productionLevel.addon ~= nil) then
      local addon = productionLevel.addon
      if (IllegalLabsAndWarehouse.IsDrugType(type)) then
          --
      else
          for index, value in ipairs(limitation) do
              local itemName = value.name
              if (addon[itemName] ~= nil) then
                  limitation[index].byWeek = value.byWeek + addon[itemName]
              end
          end
      end
  end

  return limitation
end


-- Returns limitations for given business id
-- @returns table
function IllegalLabsAndWarehouse.GetLimitationsByBusinessId(businessId)

    local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
      
    if (business ~= nil) then
        return business.limitations
    end

    print("^1[ERROR] No limitations configured for business : " .. businessId)
    return nil
end

-- Returns production evol for given business id
-- @returns table|nil
function IllegalLabsAndWarehouse.GetProductionEvolutionsByBusinessId(businessId)

  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
      
  if (business ~= nil) then
      return business.production
  end

  print("^1[ERROR] No production configured for business : " .. businessId)
  return nil
end


-- Returns security evol for given business id
-- @returns table|nil
function IllegalLabsAndWarehouse.GetSecurityEvolutionsByBusinessId(businessId)
  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
      
  if (business ~= nil) then
      return business.security
  end

  print("^1[ERROR] No security configured for business : " .. businessId)
  return nil
end

-- Returns available drugs businesses
-- @returns table
function IllegalLabsAndWarehouse.GetAvailableDrugs()
  return IllegalLabsAndWarehouse.AVAILABLE_DRUGS
end

-- Returns available drugs labels and identifiers
-- @returns table, table
function IllegalLabsAndWarehouse.GetAvailableDrugsLabel()
  local availableDrugsLabel = {}
  local availableDrugsIdentifier = {}
  local numberOfDrugs = #IllegalLabsAndWarehouse.GetAvailableDrugs()

  for index, value in pairs(IllegalLabsAndWarehouse.GetAvailableDrugs()) do
    table.insert(availableDrugsLabel, value.label)
    table.insert(availableDrugsIdentifier, index)
  end

  return availableDrugsLabel, availableDrugsIdentifier
end

-- Returns available gunlead
-- @returns table
function IllegalLabsAndWarehouse.GetAvailableGunleads()
  return IllegalLabsAndWarehouse.AVAILABLE_GUNLEADS
end

-- Returns available gunlead labels and identifiers
-- @returns table, table
function IllegalLabsAndWarehouse.GetAvailableGunleadsLabel()
  local availableGunleadLabel = {}
  local availableGunleadIdentifier = {}
  local numberOfGunleadType = #IllegalLabsAndWarehouse.GetAvailableGunleads()

  for index, value in pairs(IllegalLabsAndWarehouse.GetAvailableGunleads()) do
    table.insert(availableGunleadLabel, value.label)
    table.insert(availableGunleadIdentifier, index)
  end

  return availableGunleadLabel, availableGunleadIdentifier
end

-- Returns available gunlead labels and identifiers
-- @returns table, table
function IllegalLabsAndWarehouse.GetVaultPositionByBusinessId(businessId)
    local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
        
    if (business ~= nil) then
        return business.vault
    end

    print("^1[ERROR] No vault configured for business : " .. businessId)
    return nil
end

-- Returns computer coords for given Business Id
-- @returns table, table
function IllegalLabsAndWarehouse.GetComputerPositionByBusinessId(businessId)
    local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
        
    if (business ~= nil) then
        return business.computer
    end

    print("^1[ERROR] No computer configured for business : " .. businessId)
    return nil
end


-- Returns workplaces coords for given Business Id
-- @returns table, table
function IllegalLabsAndWarehouse.GetWorkplacesPositionByBusinessId(businessId)
  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
        
  if (business ~= nil) then
      return business.workplaces
  end

  print("^1[ERROR] No workplaces configured for business : " .. businessId)
  return nil
end

-- Returns delivery position for business id
-- @returns table, table
function IllegalLabsAndWarehouse.GetDeliveryPositionsForBusinessId(businessId)

  local business = IllegalLabsAndWarehouse.GetBusinessConfig(businessId)
        
  if (business ~= nil) then
      return business.delivery
  end

  print("^1[ERROR] No delivery configured for business : " .. businessId)
  return nil
end

function IllegalLabsAndWarehouse.IsDrugType(typeId)
    if (typeId == "drug") then
        return true
    end

    return false
end