PublicFarm = {
    -- Weed = {
    --     recolte = {
    --         type = "recolte",
    --         workSize = 1.5,
    --         Pos = {x = -1169.15, y = -1572.85, z = 4.66},
    --         giveitem = "weed_pot",
    --         blip = "none",
    --         add = "~p~+ 1 Pot graines cannabis",
    --         anim = {
    --             lib = "anim@mp_snowball",
    --             anim = "pickup_snowball"
    --         }
    --     },
    --     traitement = {
    --         type = "traitement",
    --         workSize = 1.5,
    --         blip = "none",
    --         copsQuality = true,
    --         Pos = {x = -1247.79, y = -1109.72, z = 0.78},
    --         required = "weed_plant",
    --         giveitem = "weed_pooch",
    --         add = "~p~+ 1 Pochon de cannabis"
    --     }
    -- },
    -- Acide = {
    --     recolte = {
    --         type = "recolte",
    --         workSize = 1.5,
    --         Pos = {x = 2463.01, y = 1589.29, z = 32.82},
    --         giveitem = "acidecoke",
    --         blip = "none",
    --         add = "~p~+ 1 Acide Sulfurique",
    --         anim = {
    --             lib = "anim@mp_snowball",
    --             anim = "pickup_snowball"
    --         }
    --     }
    -- },
    -- Acetone = {
    --     recolte = {
    --         type = "recolte",
    --         workSize = 1.5,
    --         Pos = {x = 114.55, y = -5.65, z = 67.81},
    --         giveitem = "acetone",
    --         blip = "none",
    --         add = "~p~+ 1 Acetone",
    --         anim = {}
    --     }
    -- },
    -- Cocaine = {
    --     -- recolte = {
    --     --     type = "recolte",
    --     --     workSize = 2.5,
    --     --     Pos = {x = -287.68, y = 2211.87, z = 129.21},
    --     --     giveitem = "coke",
    --     --     blip = "none",
    --     --     add = "~p~+ 1 Coca",
    --     --     anim = {
    --     --         lib = "anim@mp_snowball",
    --     --         anim = "pickup_snowball"
    --     --     }
    --     -- },
    --     traitement = {
    --         type = "traitement",
    --         workSize = 1.5,
    --         blip = "none",
    --         copsQuality = nil,
    --         Pos = {x = 554.45, y = 2688.59, z = 35.04},
    --         required = {
    --             {name = "poupee", count = 1}
    --         },
    --         giveitem = "coke",
    --         add = "~p~+ 1 Pochon de Cocaïne pure"
    --     }
    -- },
    -- Cocaine2 = {
    --     traitement = {
    --         type = "traitement",
    --         workSize = 1.5,
    --         blip = "none",
    --         copsQuality = true,
    --         Pos = {x = 930.39, y = -1468.87, z = 23.04},
    --         required = {
    --             {name = "coke", count = 1},
    --             {name = "acidecoke", count = 1}
    --         },
    --         giveitem = "coke1",
    --         add = "~p~+ 1 Pochon de Cocaïne"
    --     }
    -- },
    --  Lsd = {

    --     recolte = {
    --         type = "recolte",
    --         workSize = 2.5,
    --         Pos = {x = -1562.75, y = 4422.22, z = 6.46},
    --         giveitem = "champignon",
    --         blip = "none",
    --         add = "~p~+ 1 Blue Widow",
    --         anim = {
    --             lib = "anim@mp_snowball",
    --             anim = "pickup_snowball"
    --         }
    --      },
    --     traitement = {
    --         type = "traitement",
    --         workSize = 1.5,
    --         blip = "none",
    --         copsQuality = nil,
    --         Pos = {x = 1401, y = -2092.08, z = 46.00},
    --         required = {
    --             {name = "acidecoke", count = 1},
    --             {name = "champignon", count = 1}
    --         },
    --         giveitem = "lsd",
    --         add = "~p~+ 1 LSD pure",
    --         anim = {
    --             lib = "anim@amb@business@meth@meth_smash_weight_check@",
    --             anim = "break_weigh_char01"
    --         }
    --     }
    -- },
    -- Lsdpochon = {
    --     traitement = {
    --         type = "traitement",
    --         workSize = 1.5,
    --         blip = "none",
    --         copsQuality = true,
    --         Pos = {x = 2545.28, y = 4123.02, z = 31.46},
    --         required = {
    --             {name = "lsd", count = 1}
    --         },
    --         giveitem = "lsd_pooch",
    --         add = "~p~+ 1 pochon de LSD",
    --         anim = {
    --             lib = "anim@amb@business@meth@meth_smash_weight_check@",
    --             anim = "break_weigh_char02"
    --         }
    --     }
    --},
    Cueilleur = {
        recolte = {
            type = "recolte",
            workSize = 1.5,
            Pos = {x = 363.24, y = 6516.56, z = 28.28},
            giveitem = "pomme",
            -- blip = "none",
            blipcolor = 9,
            blipname = "Récolte de Pomme",
            add = "~p~ +1 Pomme",
            anim = {
                lib = "amb@prop_human_movie_bulb@base",
                anim = "base"
            }
        },
        traitement = {
            type = "traitement",
            workSize = 1.5,
            blipcolor = 9,
            blipname = "Traitement de Pomme",
            Pos = {x = 460.49, y = 3568.85, z = 33.24},
            required = "pomme",
            giveitem = "jus_pomme",
            RemoveItem = "pomme",
            add = "~p~ +1 Jus de pomme"
        },
        vente = {
            type = "vente",
            workSize = 1.5,
            Pos = {x = 1708.9, y = 4795.37, z = 40.97},
            blipcolor = 9,
            blipname = "Vente jus de pomme",
            required = "jus_pomme",
            RemoveItem = "jus_pomme",
            price = math.random(5, 6),
            add = "~p~- 1 Jus de pomme"
        }
    },
    ChercheurPrecieux = {
        recolte = {
            type = "recolte",
            workSize = 30.0,
            Pos = {x = 2963.81, y = 2785.74, z = 38.71},
            giveitem = "rock",
            -- blip = "none",
            blipcolor = 76,
            blipname = "Orpailleur - Carrière de pierre",
            add = "~p~ +1 Pierre à concasser",
            anim = {
                lib = "anim@mp_snowball",
                anim = "pickup_snowball"
            },
            closedHours = {
                20,
                21,
                22,
                23
            },
            closedHoursMessage = "La mine est fermée de 20h00 a 00h00. Allez recontrer des gens."
        },
        traitement = {
            type = "traitement",
            workSize = 1.5,
            blipcolor = 76,
            blipname = "Orpailleur - Concassage de pierre",
            --Pos = {x = 1337.52, y = 4310.58, z = 37.04},
            Pos = {x = 2582.98, y = 4686.30, z = 34.07},
            required = "rock",
            giveitemType = 2,
            giveitem = {
                {name = "goldpepite1", count = 1, drop = math.random(60, 80)},
                {name = "goldpepite2", count = 1, drop = math.random(50, 70)},
                {name = "goldpepite3", count = 1, drop = math.random(20, 40)},
                {name = "goldpepite4", count = 1, drop = math.random(20, 40)},
                {name = "goldpepite5", count = 1, drop = math.random(5, 20)},
                {name = "goldpepite6", count = 1, drop = math.random(5, 5)},
                {name = "jewels5", count = 1, drop = math.random(2, 5)},
                {name = "jewels6", count = 1, drop = math.random(1, 3)}
            },
            RemoveItem = "rock",
            add = "~p~ Vous avez concassé une pierre"
        }
    }
    -- Meth = {
    --     recolte = {
    --         type = "recolte",
    --         workSize = 1.5,
    --         Pos = {x = 2857.52, y = 4462.72, z = 41.32},
    --         giveitem = "ephedrine",
    --         blip = "none",
    --         add = "~p~+ 1 Ephedrine",
    --         anim = {
    --             lib = "anim@amb@business@meth@meth_monitoring_cooking@monitoring@",
    --             anim = "button_press_monitor"
    --         }
    --     },
    --     traitement = {
    --         type = "traitement",
    --         workSize = 2.0,
    --         blip = "none",
    --         copsQuality = true,
    --         Pos = {x = 2867.00, y = 4465.75, z = 41.32},
    --         required = {
    --             {name = "ephedrine", count = 1},
    --             {name = "acetone", count = 1}
    --         },
    --         giveitem = "meth",
    --         add = "~p~+ 1 Pochon de meth",
    --         anim = {
    --             lib = "anim@amb@business@meth@meth_smash_weight_check@",
    --             anim = "break_weigh_char02"
    --         }
    --     }
    -- },

    -- Meth2 = {
    --     recolte = {
    --         type = "recolte",
    --         workSize = 1.5,
    --         Pos = {x = 1394.42, y = 3601.74, z = 39.94},
    --         giveitem = "ephedrine",
    --         blip = "none",
    --         add = "~p~+ 1 Ephedrine",
    --         anim = {
    --             lib = "anim@amb@business@meth@meth_monitoring_cooking@monitoring@",
    --             anim = "button_press_monitor"
    --         }
    --     },
    --     traitement = {
    --         type = "traitement",
    --         workSize = 2.0,
    --         blip = "none",
    --         copsQuality = true,
    --         Pos = {x = 1389.06, y = 3605.49, z = 39.94},
    --         required = {
    --             {name = "ephedrine", count = 1},
    --             {name = "acetone", count = 1}
    --         },
    --         giveitem = "meth",
    --         add = "~p~+ 1 Pochon de meth",
    --         anim = {
    --             lib = "anim@amb@business@meth@meth_smash_weight_check@",
    --             anim = "break_weigh_char02"
    --         }
    --     }
    -- }
}

local knockedOut = false
local wait = 15
local count = 60

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
