C.TimeBetweenRobberies = 1 * 60 -- In seconds
C.RequiredNumberOfCops = 0
C.Alert                = {
    Message = "Braquage bijouterie : alarme déclenchée à la bijouterie Vangelico.",
    Coords  = C.VangelicoCoords
}
C.WaitToCallCops       = 2 * 60 * 1000 -- In ms

rewardsProbability     = {
    [iTypes[1]] = { -- Vitrines types 1
        items             = {
            [1] = {
                ["name"]               = "jh_bracelet",
                ["probability"]        = 1.0,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.800,
                    [3] = 0.425,
                    [4] = 0.100,
                    [5] = 0.005,
                }
            },
            [2] = {
                ["name"]               = "jh_necklace",
                ["probability"]        = 0.8,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [3] = {
                ["name"]               = "jh_watch",
                ["probability"]        = 0.65,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [4] = {
                ["name"]               = "jh_ring",
                ["probability"]        = 0.5,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [5] = {
                ["name"]               = "jh_brooch",
                ["probability"]        = 0.25,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            }
        },
        quantity_of_items = {
            [1] = 1,
            [2] = 0.75,
            [3] = 0.5,
            [4] = 0.15,
            [5] = 0.045,
            [6] = 0.005
        },

    },

    [iTypes[2]] = { -- Vitrines types 2
        items             = {
            [1] = {
                ["name"]               = "jh_bracelet",
                ["probability"]        = 1.0,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.800,
                    [3] = 0.425,
                    [4] = 0.100,
                    [5] = 0.005,
                }
            },
            [2] = {
                ["name"]               = "jh_necklace",
                ["probability"]        = 0.8,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [3] = {
                ["name"]               = "jh_watch",
                ["probability"]        = 0.65,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [4] = {
                ["name"]               = "jh_ring",
                ["probability"]        = 0.5,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [5] = {
                ["name"]               = "jh_brooch",
                ["probability"]        = 0.25,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            }
        },
        quantity_of_items = {
            [1] = 1,
            [2] = 0.75,
            [3] = 0.5,
            [4] = 0.15,
            [5] = 0.045,
            [6] = 0.005
        },

    },

    [iTypes[3]] = { -- Vitrines types 3
        items             = {
            [1] = {
                ["name"]               = "jh_bracelet",
                ["probability"]        = 1.0,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.800,
                    [3] = 0.425,
                    [4] = 0.100,
                    [5] = 0.005,
                }
            },
            [2] = {
                ["name"]               = "jh_necklace",
                ["probability"]        = 0.8,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [3] = {
                ["name"]               = "jh_watch",
                ["probability"]        = 0.65,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [4] = {
                ["name"]               = "jh_ring",
                ["probability"]        = 0.5,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [5] = {
                ["name"]               = "jh_brooch",
                ["probability"]        = 0.25,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            }
        },
        quantity_of_items = {
            [1] = 1,
            [2] = 0.75,
            [3] = 0.5,
            [4] = 0.15,
            [5] = 0.045,
            [6] = 0.005
        },

    },

    [iTypes[4]] = { -- Vitrines types 4
        items             = {
            [1] = {
                ["name"]               = "jh_bracelet",
                ["probability"]        = 1.0,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.800,
                    [3] = 0.425,
                    [4] = 0.100,
                    [5] = 0.005,
                }
            },
            [2] = {
                ["name"]               = "jh_necklace",
                ["probability"]        = 0.8,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [3] = {
                ["name"]               = "jh_watch",
                ["probability"]        = 0.65,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [4] = {
                ["name"]               = "jh_ring",
                ["probability"]        = 0.5,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            },
            [5] = {
                ["name"]               = "jh_brooch",
                ["probability"]        = 0.25,
                ["rarety_probability"] = {
                    [1] = 1.000,
                    [2] = 0.600,
                    [3] = 0.225,
                    [4] = 0.050,
                    [5] = 0.005,
                }
            }
        },
        quantity_of_items = {
            [1] = 1,
            [2] = 0.75,
            [3] = 0.5,
            [4] = 0.15,
            [5] = 0.045,
            [6] = 0.005
        },

    }
} 
-- Items                  = {
--     jh_brooch   = {
--         label = "Broche",
--         weight = 0.5,
--     },
--     jh_necklace = {
--         label = "Collier",
--         weight = 1.0,
--     },
--     jh_bracelet = {
--         label = "Bracelet",
--         weight = 0.8,
--     },
--     jh_ring     = {
--         label = "Bague",
--         weight = 0.2,
--     },
--     jh_watch    = {
--         label = "Montre",
--         weight = 1,
--     },
--     jh_earings  = {
--         label = "Boucles d'oreilles",
--         weight = 0.4,
--     }
-- }
