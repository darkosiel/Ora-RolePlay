Jobs = {
    chomeur = {
        label = "Citoyen",
        grade = {
            {
                label = "",
                salary = 50
            }
        }
    },
    admin_drug = {
        label = "Référent Illégal",
        grade = {
            {
                label = "",
                salary = 0
            }
        }
    },
    bleacher = {
        label = "Blanchisseur",
        label2 = "Blanchisseur",
        grade = {
            {
                label = "Employé",
                name = "cdd",
                salary = 0,
                show = true
            }
        }
    },
 
    mecano2 = {
        label = "Beeker's Garage",
        label2 = "Beekers Garage",
        iban = "mecano2",
        isMechanics = true,
        grade = {
            {
                label = "CDD",
                salary = 75,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 100,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 125,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 150,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 175,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Beeker's Garage",
            Pos = {x = 110.03, y = 6606.81, z = 31.85},
            Properties = {
                type = 3,
                Limit = 20,
                zonesize = 1.0,
                vehicles = {},
                spawnpos = {x = 110.03, y = 6606.81, z = 31.85, h = 310.49}
            },
            Blipdata = {
                Pos = {x = 110.03, y = 6606.81, z = 31.87},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Menu = {
            menu = {
                title = "Mécano",
                subtitle = "Actions disponibles",
                name = "mecano_menuperso"
            },
            submenus = {
                ["Actions véhicule"] = {
                    submenu = "mecano_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Inspecter l'état du véhicule",
                                onSelected = function()
                                    Mecano.CheckVehicle()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Ouvrir le capot",
                                onSelected = function()
                                    Mecano.OpenTrunk()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Réparer",
                                onSelected = function()
                                    Mecano.Repair()
                                    RageUI.CloseAll()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Nettoyer",
                                onSelected = function()
                                    Mecano.CleanVehicule()
                                    RageUI.CloseAll()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Mettre/Retirer le véhicule du plateau",
                                onSelected = function()
                                    Mecano.PutPlateau()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Mise en fourière",
                                onSelected = function()
                                    Mecano.Fouriere()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            }
                        },
                        submenus = {}
                    }
                }
            },
            buttons = {
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Beeker's", "Annonce", text, "CHAR_BEEKERS", 8, "Beekers Garage")
                        end
                    end
                },
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("mecano2")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
        Extrapos = {
            Tow = {
                Pos = {
                    {x = 117.729, y = 6598.982, z = 31.70}
                },
                Enter = EnterZoneTow,
                Exit = ExitZoneTow,
                zonesize = 1.5,
                Blips = {
                    sprite = 473,
                    color = 81,
                    name = "Fourrière Beekers Garage"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            },
            LSCustoms = {
                Pos = {
                    {x = 110.63, y = 6626.31, z = 31.78},
                    {x = 103.75, y = 6622.61, z = 31.78},
                    {x = 105.88, y = 6640.58, z = 31.43}
                },
                Enter = function()
                    EnterZoneLSC_NORD()
                end,
                Exit = function()
                    ExitZoneLSC_NORD()
                end,
                zonesize = 3.0,
                Blips = {--[[ 
                    sprite = 72,
                    color = 81,
                    name = "LSCustom"
                 ]]},
                Marker = {--[[ 
                    type = 23,
                    scale = {x = 4.5, y = 4.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                 ]]}
            }
        },
        Storage = {
            {
                Pos = {x = 97.68, y = 6619.96, z = 31.63},
                Limit = 100,
                Name = "coffre_mecano2"
            }
        }
    },
    -- coiffeur = {
    --     label = "Coiffeur",
    --     label2 = "Coiffeur",
    --     iban = "coiffeur",
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 150,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "CDI",
    --             salary = 160,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 170,
    --             name = "chef",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 180,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 200,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -808.87, y = -179.8, z = 36.57},
    --             Limit = 100,
    --             Name = "coffre_coiffeur"
    --         }
    --     },
    --     garage = {
    --         Name = "Garage Coiffeur",
    --         Pos = {x = -794.15, y = -172.96, z = 36.29},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {
    --                 {}
    --             },
    --             spawnpos = {x = -794.15, y = -172.96, z = 36.29, h = 26.32}
    --         },
    --         Blipdata = {
    --             Pos = {},
    --             Blipcolor = 7,
    --             Blipname = "Garage - coiffeur"
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "coiffeur",
    --             subtitle = "Action",
    --             name = "coiffeur_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("coiffeur")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             },
    --             {
    --                 label = "Coiffure",
    --                 onSelected = function()
    --                     for i = 1, 10, 1 do
    --                         Wait(1)
    --                         RageUI.GoBack()
    --                     end
    --                     RageUI.Visible(RMenu:Get("haircuts", "main"), true)
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                     local text = exports['Snoupinput']:GetInput()
    --                     if text ~= false and text ~= "" then
    --                         TriggerServerEvent("Job:Annonce", "Coiffeur Sud", "Annonce", text, "CHAR_BARBER", 8, "Coiffeur")
    --                     end
    --                 end
    --             }
    --         }
    --     }
    -- },
    -- coiffeurnord = {
    --     label = "Coiffeur Nord",
    --     label2 = "Coiffeur Nord",
    --     iban = "coiffeurnord",
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 150,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "CDI",
    --             salary = 160,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 170,
    --             name = "chef",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 180,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 200,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -276.76, y = 6224.07, z = 30.70},
    --             Limit = 100,
    --             Name = "coffre_coiffeur_nord"
    --         }
    --     },
    --     garage = {
    --         Name = "Garage Coiffeur Nord",
    --         Pos = {x = -243.98, y = 6237.29, z = 31.48},
    --         Properties = {
    --             type = 3,
    --             Limit = 10,
    --             vehicles = {
    --                 {}
    --             },
    --             spawnpos = {x = -243.98, y = 6237.29, z = 31.48, h = 226.59}
    --         },
    --         Blipdata = {
    --             Pos = {},
    --             Blipcolor = 7,
    --             Blipname = "Garage Coiffeur Nord"
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "Coiffeur Nord",
    --             subtitle = "Action",
    --             name = "coiffeur_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("coiffeurnord")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             },
    --             {
    --                 label = "Coiffure",
    --                 onSelected = function()
    --                     for i = 1, 10, 1 do
    --                         Wait(1)
    --                         RageUI.GoBack()
    --                     end
    --                     RageUI.Visible(RMenu:Get("haircuts", "main"), true)
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                     local text = exports['Snoupinput']:GetInput()
    --                     if text ~= false and text ~= "" then
    --                         TriggerServerEvent("Job:Annonce", "Coiffeur Nord", "Annonce", text, "CHAR_BARBER", 8, "Coiffeur Nord")
    --                     end
    --                 end
    --             }
    --         }
    --     }
    -- },
    carwash = {
        label = "Car Wash",
        label2 = "Car Wash",
        iban = "carwash",
        grade = {
            {
                label = "CDI",
                salary = 150,
                name = "cdi",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 162.75, y = -1716.70, z = 28.29},
                Limit = 100,
                Name = "coffre_carwash"
            }
        },
        Menu = {
            menu = {
                title = "carwash",
                subtitle = "Action",
                name = "carwash_menuperso"
            },
            buttons = {

                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("carwash")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "CarWash", "Annonce", text, "CHAR_CARWASH", 8, "Car Wash")
                        end
                    end
                }
            }
        }
    },
    ammunation = {
        label = "Ammunation",
        label2 = "Ammunation",
        iban = "ammunation",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 818.11, y = -2155.71, z = 28.71},
                Limit = 300,
                Name = "coffre_ammunation"
            }
        },
        garage = {
            Name = "Garage Ammunation",
            Pos = {x = 822.65, y = -2145.30, z = 27.71},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {
                    {}
                },
                spawnpos = {x = 822.65, y = -2145.30, z = 27.71, h = 0.04}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Ammunation - Garage Ammunation"
            }
        },
        Extrapos = {
            CraftWeapon = {
                Pos = {
                    {x = 809.022, y = -2159.48, z = 29.61}
                },
                restricted = {2, 3, 4, 5},
                Enter = function()
                    EnterCraftWeaponZone()
                end,
                Exit = function()
                    ExitCraftWeaponZone()
                end,
                zonesize = 2.5,
                Blips = {
                    sprite = 150,
                    color = 69,
                    name = "Ammunation - Confection d'armes"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.2},
                    color = {r = 255, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        },
        Extrablips = {
            --[[ {
                Pos = {x = 1079.79, y = -1982.99, z = 30.47},
                Blips = {
                    sprite = 478,
                    color = 43,
                    name = "Ammunation - Pièces en métal"
                }
            }, ]]
            {
                Pos = {x = -584.38, y = 5289.39, z = 69.26, a = 55.68}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
                Blips = {
                    sprite = 478,
                    Enabled = false, -- Image off
                    color = 43,
                    name = "Ammunation - Pièces en bois"
                }
            },
            {
                Pos = {x = 286.32, y = -3029.06, z = 4.69, a = 259.22}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
                Blips = {
                    sprite = 478,
                    Enabled = false, -- Image off
                    color = 43,
                    name = "Ammunation - Pièces en plastique"
                }
            }
        },
        Menu = {
            menu = {
                title = "ammunation",
                subtitle = "Action",
                name = "ammunation_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("ammunation")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Ammunation", "Annonce", text, "CHAR_AMMUNATION", 8, "Ammunation")
                        end
                    end
                }
            }
        }
    },
    ammunationnord = {
        label = "Ammunation Nord",
        label2 = "Ammunation Nord",
        iban = "ammunationnord",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 1689.43, y = 3757.62, z = 33.71},
                Limit = 300,
                Name = "coffre_ammunationnord"
            }
        },
        garage = {
            Name = "Garage Ammunation Nord",
            Pos = {x = 1701.49, y = 3768.63, z = 33.47},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {
                    {}
                },
                spawnpos = {x = 1701.49, y = 3768.63, z = 33.47, h = 242.45}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Ammunation - Garage Ammunation Nord"
            }
        },
        Extrapos = {
            CraftWeapon = {
                Pos = {
                    {x = 1696.52, y = 3760.71, z = 33.71}
                },
                restricted = {2, 3, 4, 5},
                Enter = function()
                    EnterCraftWeaponZone()
                end,
                Exit = function()
                    ExitCraftWeaponZone()
                end,
                zonesize = 2.5,
                Blips = {
                    sprite = 150,
                    color = 69,
                    name = "Ammunation - Confection d'armes nord"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.2},
                    color = {r = 255, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        },
        Extrablips = {
            --[[ {
                Pos = {x = 1079.79, y = -1982.99, z = 30.47},
                Blips = {
                    sprite = 478,
                    color = 43,
                    name = "Ammunation - Pièces en métal"
                }
            }, ]]
            {
                Pos = {x = -584.38, y = 5289.39, z = 69.26, a = 55.68}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
                Blips = {
                    sprite = 478,
                    Enabled = false, -- Image off
                    color = 43,
                    name = "Ammunation - Pièces en bois nord"
                }
            },
            {
                Pos = {x = 286.32, y = -3029.06, z = 4.69, a = 259.22}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
                Blips = {
                    sprite = 478,
                    Enabled = false, -- Image off
                    color = 43,
                    name = "Ammunation - Pièces en plastique nord"
                }
            }
        },
        Menu = {
            menu = {
                title = "Ammunation",
                subtitle = "Action",
                name = "ammunationnord_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("ammunationnord")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Ammunation Nord", "Annonce", text, "CHAR_AMMUNATION", 8, "Ammunation")
                        end
                    end
                }
            }
        }
    },
    tatoo = {
        label = "Tatoueur",
        label2 = "Tatoueur",
        iban = "tatoo",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 322.16, y = 185.76, z = 102.59},
                Limit = 100,
                Name = "coffre_tatoo"
            }
        },
        Menu = {
            menu = {
                title = "Tatoueur",
                subtitle = "Action",
                name = "tatoueur_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("tatoo")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Tatouage",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("tatoo", "main"), true)
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Tattoo sud", "Annonce", text, "CHAR_TATTOO", 8, "Tatoueur")
                        end
                    end
                }
            }
        }
    },
    tatoo2 = {
        label = "Tatoueur Nord",
        label2 = "Tatoueur Nord",
        iban = "tatoo2",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 1865.211, y = 3749.206, z = 32.30},
                Limit = 100,
                Name = "coffre_tatoo_nord"
            }
        },
        Menu = {
            menu = {
                title = "Tatoueur",
                subtitle = "Action",
                name = "tatoueur_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("tatoo2")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Tatouage",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("tatoo", "main"), true)
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Tattoo nord", "Annonce", text, "CHAR_TATTOO", 8, "Tatoueur Nord")
                        end
                    end
                }
            }
        }
    },
    fermier = {
        label = "Fermier",
        label2 = "Fermier",
        iban = "fermier",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 2317.07, y = 4896.36, z = 40.81},
                Limit = 500,
                Name = "coffre_fermier"
            }
        },
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 645.62, y = 6470.61, z = 30.6},
                giveitem = "blez",
                blipcolor = 7,
                blipname = "Fermier - Récolte du blé",
                add = "~p~+ 1 Blé",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte2 = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 1869.3, y = 4814.88, z = 44.05},
                giveitem = "pommeterre",
                blipcolor = 7,
                blipname = "Fermier - Récolte de pomme de terre",
                add = "~p~+ 1 Pomme de terre",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte3 = {
                type = "recolte",
                workSize = 2.0,
                Pos = {x = 2306.9, y = 4881.98, z = 41.81},
                giveitem = "milk",
                blipcolor = 7,
                blipname = "Fermier - Récupérer du lait",
                add = "~p~+ 1 Bouteille de Lait",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte4 = {
                type = "recolte",
                workSize = 2.0,
                Pos = {x = 2313.76, y = 4888.14, z = 41.81},
                giveitem = "chicken",
                blipcolor = 7,
                blipname = "Fermier - Récupérer du Poulet",
                add = "~p~+ 1 Poulet",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            traitement = {
                type = "traitement",
                workSize = 7.45,
                blipcolor = 7,
                blipname = "Fermier - Produire des céréales",
                Pos = {x = 2553.31, y = 4670.74, z = 32.95},
                required = "blez",
                giveitem = "cereale",
                add = "~p~+ 1  Céréale"
            },
            traitement2 = {
                type = "traitement",
                workSize = 7.45,
                blipcolor = 7,
                blipname = "Fermier - Produire de la farine",
                Pos = {x = 387.95, y = 3586.49, z = 33.29},
                required = "blez",
                giveitem = "farine",
                add = "~p~+ 1  Sac de farine"
            },
            -- traitement3 = {
            --     type = "traitement",
            --     workSize = 7.45,
            --     blipcolor =7,
            --     blipname = "Traitement de la farine",
            --     Pos =  {x=2680.62,y=3508.35,z=53.3},
            --     required = "farine",
            --     giveitem = "pain",
            --     add = "~p~+ 1  Pain"
            -- },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Fermier - Vente",
                Pos = {x = 1677.87, y = 4881.57, z = 41.04},
                required = "farine",
                price = math.random(18, 25),
                add = "~p~- 1 Sac de farine"
            }
        },
        garage = {
            Name = "Garage Fermier",
            Pos = {x = 2306.05, y = 4894.52, z = 41.71},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 2306.05, y = 4894.52, z = 41.71, h = 333.27}
            },
            Blipdata = {
                Pos = {x = 2306.05, y = 4894.52, z = 41.71},
                Blipcolor = 5,
                Blipname = "Garage Fermier"
            }
        },
        Menu = {
            menu = {
                title = "Fermier",
                subtitle = "Action",
                name = "fermier_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("fermier")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Fermier",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("fermier", "main"), true)
                    end
                },
                {
                    label = "Annonces",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Ferme", "Annonce", text, "CHAR_FERME", 8, "Fermier")
                        end
                    end
                }
            }
        }
    },
    restaurant = {
        label = "Restaurant",
        label2 = "Restaurant",
        iban = "restaurant",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Restaurant",
                subtitle = "Actions disponibles",
                name = "restaurant_menuperso"
            },
            buttons = {
                -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("restaurant")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Pearls", "Annonce", text, "CHAR_PEARLS", 8, "Restaurant")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage restaurant",
            Pos = {x = -1796.88, y = -1180.76, z = 12.31},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -1796.88, y = -1180.76, z = 12.31, h = 318.24}
            },
            Blipdata = {
                Pos = {x = -1796.88, y = -1180.76, z = 12.31, h = 318.24},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = -1839.74, y = -1189.69, z = 13.32},
                Limit = 500,
                Name = "coffre_restaurant"
            },
            {
                Pos = {x = -1855.52, y = -1195.06, z = 12.10},
                Limit = 500,
                Name = "coffre_caveresto"
            },
            {
                Pos = {x = -1840.72, y = -1183.35, z = 18.20},
                Limit = 500,
                Name = "coffre_pearls_club"
            },
            {
                Pos = {x = -1836.73, y = -1176.40, z = 18.20},
                Limit = 200,
                Name = "coffre_pearls_bureau"
            }
        },
        requiredService = false,
        work = {
            traitement2 = {
                --Filet de daurade
                type = "traitement",
                workSize = 1.20,
                blipcolor = 7,
                blipname = "planche",
                Pos = {x = -1842.25, y = -1185.11, z = 13.33},
                required = "fish6",
                giveitem = "filetdaurade",
                RemoveItem = "fish6",
                add = "~p~+ 1  Filet de daurade mariné à la japonaise"
            },
            traitement = {
                --milkshack
                type = "traitement",
                workSize = 1.20,
                blipcolor = 7,
                blipname = "Traitement milkshack",
                Pos = {x = -1838.36, y = -1183.82, z = 13.33},
                required = "milk",
                giveitem = "milkshack",
                RemoveItem = "milk",
                add = "~p~+ 1  Milkshack"
            },
            traitement3 = {
                --pizza au saumon
                type = "traitement",
                workSize = 1.20,
                blipcolor = 7,
                blipname = "four",
                Pos = {x = -1836.62, y = -1184.59, z = 13.33},
                required = {
                    {name = "bread", count = 1},
                    {name = "fish12", count = 1}
                },
                giveitem = "pizzasaumon",
                RemoveItem = {
                    {name = "bread", count = 1},
                    {name = "fish12", count = 1}
                },
                add = "~p~+ 1  Pizza au saumon"
            },
            traitement4 = {
                --cupcake
                type = "traitement",
                workSize = 1.20,
                blipcolor = 7,
                blipname = "Traitement Cupcake",
                Pos = {x = -1837.41, y = -1186.21, z = 13.33},
                required = "bread",
                giveitem = "cupcake",
                RemoveItem = "bread",
                add = "~p~+ 1  Cupcake"
            }
        }
    },
    -- fujiwaratofu = {
    --     label = "Fujiwara Tofu",
    --     label2 = "Fujiwara Tofu",
    --     iban = "fujiwaratofu",
    --     FreeAccess = false,
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 150,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "CDI",
    --             salary = 160,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 170,
    --             name = "chef",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 180,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 200,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "Fujiwara Tofu",
    --             subtitle = "Actions disponibles",
    --             name = "fujiwaratofu_menuperso"
    --         },
    --         buttons = {
    --             -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("fujiwaratofu")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                     local text = exports['Snoupinput']:GetInput()
    --                     if text ~= false and text ~= "" then
    --                         TriggerServerEvent("Job:Annonce", "Fujiwara Tofu", "Annonce", text, "CHAR_OSAKA", 8, "Fujiwara Tofu")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    --     garage = {
    --         Name = "Garage fujiwara tofu",
    --         Pos = {x = -202.76, y = 310.14, z = 95.95},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = -202.76, y = 310.14, z = 95.95, h = 285.33}
    --         },
    --         Blipdata = {
    --             Pos = {x = -202.76, y = 310.14, z = 95.95, h = 285.33},
    --             Blipcolor = 5,
    --             Blipname = "Garage"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -178.94, y = 305.7, z = 96.46},
    --             Limit = 500,
    --             Name = "coffre_fujiwaratofu"
    --         },
    --         {
    --             Pos = {x = -172.53, y = 308.16, z = 96.99},
    --             Limit = 500,
    --             Name = "coffre_fujiwaratofu_bouteilles"
    --         },
    --         {
    --             Pos = {x = -138.46, y = 299.05, z = 97.88},
    --             Limit = 200,
    --             Name = "coffre_fujiwaratofu_bureau"
    --         }
    --     },
    --     requiredService = false,
    --     work = {
    --         traitement2 = {
    --             --tonkatsu
    --             type = "traitement",
    --             workSize = 1.20,
    --             blipcolor = 7,
    --             blipname = "planche",
    --             Pos = {x = -175.45, y = 301.44, z = 96.46},
    --             required = "filet",
    --             giveitem = "tonkatsu",
    --             RemoveItem = "filet",
    --             add = "~p~+ 1  Tonkatsu"
    --         },
    --         traitement = {
    --             --Ramen
    --             type = "traitement",
    --             workSize = 1.20,
    --             blipcolor = 7,
    --             blipname = "planche",
    --             Pos = {x = -178.2, y = 301.4, z = 96.46},
    --             required = {
    --                 {name = "bouillon", count = 1},
    --                 {name = "noddle", count = 1}
    --             },
    --             giveitem = "ramen",
    --             RemoveItem = {
    --                 {name = "bouillon", count = 1},
    --                 {name = "noddle", count = 1}
    --             },
    --             add = "~p~+ 1  Ramen"
    --         },
    --         traitement5 = {
    --             --Milkshake
    --             type = "traitement",
    --             workSize = 1.20,
    --             blipcolor = 7,
    --             blipname = "Traitement milkshack",
    --             Pos = {x = -176.58, y = 308.93, z = 96.99},
    --             required = "milk",
    --             giveitem = "milkshack",
    --             RemoveItem = "milk",
    --             add = "~p~+ 1  Milkshake"
    --         },
    --         traitement3 = {
    --             --Onigiri
    --             type = "traitement",
    --             workSize = 1.20,
    --             blipcolor = 7,
    --             blipname = "planche",
    --             Pos = {x = -174.89, y = 304.67, z = 96.46},
    --             required = {
    --                 {name = "rice", count = 1},
    --                 {name = "feuillenori", count = 1}
    --             },
    --             giveitem = "onigiri",
    --             RemoveItem = {
    --                 {name = "rice", count = 1},
    --                 {name = "feuillenori", count = 1}
    --             },
    --             add = "~p~+ 1  Onigiri"
    --         },
    --         traitement4 = {
    --             --sushi
    --             type = "traitement",
    --             workSize = 1.20,
    --             blipcolor = 7,
    --             blipname = "planche",
    --             Pos = {x = -172.2, y = 301.53, z = 96.46},
    --             required = {
    --                 {name = "rice", count = 1},
    --                 {name = "fish12", count = 1}
    --             },
    --             giveitem = "sushi",
    --             RemoveItem = {
    --                 {name = "rice", count = 1},
    --                 {name = "fish12", count = 1}
    --             },
    --             add = "~p~+ 1  Sushi"
    --         }
    --     }
    -- },
    taxi = {
        label = "Taxi",
        label2 = "Taxi",
        iban = "taxi",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Taxi",
                subtitle = "Actions disponibles",
                name = "taxi_menuperso"
            },
            buttons = {
                -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Employés en service",
                    onSelected = function()
                        TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "taxi")
                    end
                },
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("taxi")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Taxi", "Annonce", text, "CHAR_TAXI", 8, "Taxi")
                        end
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
        garage = {
            Name = "Garage taxi",
            Pos = {x = 896.011, y = -153.520, z = 76.00},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 896.011, y = -153.520, z = 76.00, h = 337.38}
            },
            Blipdata = {
                Pos = {x = 896.011, y = -153.520, z = 76.00, h = 337.38},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = 906.683, y = -151.317, z = 73.20},
                Limit = 100,
                Name = "coffre_taxi"
            }
        },
        requiredService = true
    },
    ltdnord = {
        label = "LTD Nord",
        label2 = "ltd nord",
        iban = "ltdnord",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "LTD Nord",
                subtitle = "Actions disponibles",
                name = "ltdnord_menuperso"
            },
            buttons = {
                -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("ltdnord")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Ltd Nord", "Annonce", text, "CHAR_LTD", 8, "ltd nord")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage LTD Nord",
            Pos = {x = 143.79, y = 6641.69, z = 30.56},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 143.79, y = 6641.69, z = 30.56}
            },
            Blipdata = {
                Pos = {x = 143.79, y = 6641.69, z = 30.56},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = 170.24, y = 6642.11, z = 30.62},
                Limit = 2000,
                Name = "coffre_ltdnord"
            }
        },
        requiredService = false
        -- work = {
        --     traitement2 = {
        --         --frites
        --         type = "traitement",
        --         workSize = 1.20,
        --         blipcolor = 5,
        --         blipname = "Friteuse",
        --         Pos = {x = -1201.48, y = -897.85, z = 12.99},
        --         required = "pommeterre",
        --         giveitem = "frites",
        --         noFarm = true,
        --         RemoveItem = "pommeterre",
        --         add = "~p~+ 1  Barquette de frites"
        --     },
        --     traitement = {
        --         --milkshack
        --         type = "traitement",
        --         workSize = 1.20,
        --         blipcolor = 6,
        --         blipname = "Traitement Milkshake",
        --         Pos = {x = -1198.65, y = -895.58, z = 12.99},
        --         required = "milk",
        --         giveitem = "milkshack",
        --         RemoveItem = "milk",
        --         noFarm = true,
        --         add = "~p~+ 1  Milkshake"
        --     },
        --     traitement3 = {
        --         --hamburger
        --         type = "traitement",
        --         workSize = 1.20,
        --         blipcolor = 7,
        --         noFarm = true,
        --         blipname = "Grill Burger Poulet",
        --         Pos = {x = -1197.93, y = -892.60, z = 12.99},
        --         required = {
        --             {name = "bread", count = 1},
        --             {name = "chicken", count = 1}
        --         },
        --         giveitem = "burger",
        --         RemoveItem = {
        --             {name = "bread", count = 1},
        --             {name = "chicken", count = 1}
        --         },
        --         add = "~p~+ 1  Hamburger poulet"
        --     },
        --     traitement5 = {
        --         --hamburger
        --         type = "traitement",
        --         workSize = 1.20,
        --         blipcolor = 8,
        --         noFarm = true,
        --         blipname = "Grill Burger Healthy",
        --         Pos = {x = -1198.83, y = -902.08, z = 12.99},
        --         required = {
        --             {name = "bread", count = 1},
        --             {name = "meat", count = 1}
        --         },
        --         giveitem = "burgerhealthy",
        --         RemoveItem = {
        --             {name = "bread", count = 1},
        --             {name = "meat", count = 1}
        --         },
        --         add = "~p~+ 1  Hamburger Healthy"
        --     }
        -- }
    },
    ltdsud = {
        label = "LTD Sud",
        label2 = "ltd sud",
        iban = "ltdsud",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "LTD Sud",
                subtitle = "Actions disponibles",
                name = "ltdsud_menuperso"
            },
            buttons = {
                -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("ltdsud")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "24/7 - Supermarket", "Annonce", text, "CHAR_LTDSUD", 8, "ltd sud")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage LTD SUD",
            Pos = {x = 15.9, y = -1350.09, z = 28.32},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 15.9, y = -1350.09, z = 28.32, h = 179.85}
            },
            Blipdata = {
                Pos = {x = 15.9, y = -1350.09, z = 28.32, h = 179.85},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = 30.76, y = -1340.13, z = 28.5},
                Limit = 2000,
                Name = "coffre_ltdsud"
            }
        },
        requiredService = false
        -- work = {
        --     traitement2 = {
        --         --frites
        --         type = "traitement",
        --         workSize = 1.20,
        --         blipcolor = 5,
        --         blipname = "Friteuse",
        --         Pos = {x = -1201.48, y = -897.85, z = 12.99},
        --         required = "pommeterre",
        --         giveitem = "frites",
        --         noFarm = true,
        --         RemoveItem = "pommeterre",
        --         add = "~p~+ 1  Barquette de frites"
        --     },
        --     traitement = {
        --         --milkshack
        --         type = "traitement",
        --         workSize = 1.20,
        --         blipcolor = 6,
        --         blipname = "Traitement Milkshake",
        --         Pos = {x = -1198.65, y = -895.58, z = 12.99},
        --         required = "milk",
        --         giveitem = "milkshack",
        --         RemoveItem = "milk",
        --         noFarm = true,
        --         add = "~p~+ 1  Milkshake"
        --     },
        --     traitement3 = {
        --         --hamburger
        --         type = "traitement",
        --         workSize = 1.20,
        --         blipcolor = 7,
        --         noFarm = true,
        --         blipname = "Grill Burger Poulet",
        --         Pos = {x = -1197.93, y = -892.60, z = 12.99},
        --         required = {
        --             {name = "bread", count = 1},
        --             {name = "chicken", count = 1}
        --         },
        --         giveitem = "burger",
        --         RemoveItem = {
        --             {name = "bread", count = 1},
        --             {name = "chicken", count = 1}
        --         },
        --         add = "~p~+ 1  Hamburger poulet"
        --     },
        --     traitement5 = {
        --         --hamburger
        --         type = "traitement",
        --         workSize = 1.20,
        --         blipcolor = 8,
        --         noFarm = true,
        --         blipname = "Grill Burger Healthy",
        --         Pos = {x = -1198.83, y = -902.08, z = 12.99},
        --         required = {
        --             {name = "bread", count = 1},
        --             {name = "meat", count = 1}
        --         },
        --         giveitem = "burgerhealthy",
        --         RemoveItem = {
        --             {name = "bread", count = 1},
        --             {name = "meat", count = 1}
        --         },
        --         add = "~p~+ 1  Hamburger Healthy"
        --     }
        -- }
    },
    burgershot = {
        label = "Burger Shot",
        label2 = "burger shot",
        iban = "burgershot",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Burger Shot",
                subtitle = "Actions disponibles",
                name = "burgershot_menuperso"
            },
            buttons = {
                -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("burgershot")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Burgershot", "Annonce", text, "CHAR_BURGERSHOT", 8, "burger shot")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage burgershot",
            Pos = {x = -1242.4321, y = -333.9221, z = 68.0821},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -1242.4321, y = -333.9221, z = 68.0821, h = 28.85}
            },
            Blipdata = {
                Pos = {x = -1242.4321, y = -333.9221, z = 68.0821, h = 28.85},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = 1246.4328, y = -352.0784, z = 69.1846},
                Limit = 1000,
                Name = "coffre_restaurantfood"
            }
        },
        requiredService = false,
        work = {
            traitement2 = {
                --frites
                type = "traitement",
                workSize = 1.20,
                blipcolor = 5,
                blipname = "Friteuse",
                Pos = {x = 1249.9007, y = -352.7587, z = 69.1846},
                required = "pommeterre",
                giveitem = "frites",
                noFarm = true,
                RemoveItem = "pommeterre",
                add = "~p~+ 1  Barquette de frites"
            },
            traitement = {
                --milkshack
                type = "traitement",
                workSize = 1.20,
                blipcolor = 6,
                blipname = "Traitement Milkshake",
                Pos = {x = 1251.9968, y = -358.9071, z = 69.1846},
                required = "milk",
                giveitem = {
                    {name = "milkshack", count = 5},
                },
                RemoveItem = "milk",
                noFarm = true,
                add = "~p~+ 5  Milkshake"
            },
            traitement3 = {
                --hamburger
                type = "traitement",
                workSize = 1.20,
                blipcolor = 7,
                noFarm = true,
                blipname = "Grill Burger Poulet",
                Pos = {x = 1249.9069, y = -356.2945, z = 69.1846},
                required = {
                    {name = "bread", count = 1},
                    {name = "chicken", count = 1}
                },
                giveitem = "burger",
                RemoveItem = {
                    {name = "bread", count = 1},
                    {name = "chicken", count = 1}
                },
                add = "~p~+ 1  Hamburger poulet"
            },
            traitement5 = {
                --hamburger
                type = "traitement",
                workSize = 1.20,
                blipcolor = 8,
                noFarm = true,
                blipname = "Grill Burger Healthy",
                Pos = {x = 1253.2602, y = -9353.9359, z = 69.1846},
                required = {
                    {name = "bread", count = 1},
                    {name = "meat", count = 1}
                },
                giveitem = "burgerhealthy",
                RemoveItem = {
                    {name = "bread", count = 1},
                    {name = "meat", count = 1}
                },
                add = "~p~+ 1  Hamburger Healthy"
            }
        }
    },
    -- tabac = {
    -- 	label = "Tabac",
    -- 	FreeAccess = false,
    -- 	grade = {
    -- 		{
    -- 			label = "Recrue",
    -- 			salary = 110,
    -- 			name = "recrue",
    -- 		},
    -- 		{
    -- 			label = "Tabac",
    -- 			salary = 120,
    -- 			name = "tabac",
    -- 		},
    -- 		{
    -- 			label = "Patron",
    -- 			salary = 135,
    -- 			name = "boss",
    -- 		}
    -- 	},
    -- 	Menu = {
    -- 		menu = {
    -- 			title = "Tabac",
    -- 			subtitle = "Action",
    -- 			name = "tabac_menuperso"
    -- 		},
    -- 		buttons = {
    -- 			{label="Facturation",onSelected=function() CreateFacture("tabac") end,ActiveFct=function() HoverPlayer() end},
    -- 		},
    -- 	},
    -- 	garage = {
    --         Name = "Garage Tabac",
    --         Pos =  {x = 1996.21,  y = 3037.2,  z =47.03},
    --         Properties = {
    --             type = 1,
    --             Limit = 5,
    --             vehicles = {
    --                 {name="bison",label="Voiture de service",job=true,tuning = {
    --                     modXenon = false
    --                 }},
    --             },
    --             spawnpos = {x = 1996.21,  y = 3037.2,  z =47.03, h = 147.69},

    --         },
    --         Blipdata = {
    --             Pos = {x = 1996.21,  y = 3037.2,  z =47.03},
    --             Blipcolor  =5,
    --             Blipname = "Garage Tabac"
    --         --  },
    --         },
    --     },
    --     requiredService = false,

    --     work = {

    --         recolte = {
    --             type = "recolte",
    --             workSize = 2.0,
    --             Pos = {x=268.4737, y=6478.4584, z=29.70},
    --             giveitem = "feuillecigarette",
    --             blipcolor = 2,
    --             blipname = "Récolte",
    --             add = "~p~+ 1 Feuille de Cigarette",
    --             anim = {

    --                 lib = "anim@mp_snowball",
    --                 anim = "pickup_snowball"

    --             },
    --         },

    --         traitement = {
    --             type = "traitement",
    --             workSize = 2.40,
    --             blipcolor = 2,
    --             blipname = "Traitement",
    --             Pos = {x=1543.567, y=2176.943, z=77.814},
    --             required = "feuillecigarette",
    --             giveitem = "tabac",
    --             RemoveItem = "feuillecigarette",
    --             add = "~p~+ 1  Tabac"
    --         },

    --         traitement2 = {
    --             type = "traitement",
    --             workSize = 2.0,
    --             blipcolor = 2,
    --             blipname = "Traitement 2",
    --             Pos = {x=811.337, y=2179.402, z=51.388},
    --             required = "tabac",
    --             giveitem = "cigarette",
    --             RemoveItem = "tabac",
    --             add = "~p~+ 1  Tabac"
    --         },

    --         vente = {
    --             type = "vente",
    --             blipcolor = 2,
    --             workSize = 2.0,
    --             blipname = "Vente",
    --             Pos = {x = -158.737, y = -54.651, z = 53.410},
    --             required = "cigarette",
    --             RemoveItem = "cigarette",
    --             price = math.random( 1,2 ),
    --             add = "~p~- 1 Cigarette"
    --         },
    --     }
    -- },

    journaliste = {
        label = "Journaliste",
        label2 = "Journaliste",
        iban = "journaliste",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Journaliste",
                subtitle = "Actions",
                name = "journaliste_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("journaliste")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Weazel News", "Annonce", text, "CHAR_WEAZEL", 8, "Journaliste")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage Journaliste",
            Pos = {x = -535.52, y = -894.27, z = 24.22},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -535.52, y = -894.27, z = 24.22, h = 149.57}
            },
            Blipdata = {
                Pos = {x = -535.52, y = -894.27, z = 24.22},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        garage2 = {
            Name = "Helipad Weazel",
            Pos = {x = -584.11, y = -930.23, z = 35.83},
            Properties = {
                type = 2,
                Limit = 20,
                zonesize = 1.5,
                vehicles = {
                    {
                        name = "newsheli",
                        label = "Helicoptere Weazel",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = -584.11, y = -930.23, z = 35.83, h = 76.47}
            },
            Blipdata = {
                Pos = {x = -584.11, y = -930.23, z = 35.83},
                Blipcolor = 5,
                Blipname = "Helipad Weazel"
            }
        },
        Storage = {
            {
                Pos = {x = -589.56, y = -921.00, z = 28.00},
                Limit = 1000,
                Name = "coffre_weazel"
            }
        },
    },
    -- avocat = {
    --     label = "Cabinet Blue Dragon",
    --     label2 = "Cabinet Blue Dragon",
    --     iban = "avocat",
    --     FreeAccess = false,
    --     grade = {
    --         {
    --             label = "AVOCAT",
    --             salary = 150,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "ASSOCIE",
    --             salary = 180,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 200,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "Avocat",
    --             subtitle = "Actions",
    --             name = "avocat_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("avocat")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                     local text = exports['Snoupinput']:GetInput()
    --                     if text ~= false and text ~= "" then
    --                         TriggerServerEvent("Job:Annonce", "Cabinet Blue Dragon", "Annonce", text, "CHAR_LAWYER", 8, "Cabinet Blue Dragon")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    -- },
    -- avocatn = {
    --     label = "Cabinet Nemesis Associate",
    --     label2 = "Cabinet Nemesis Associate",
    --     iban = "avocatn",
    --     grade = {
    --         {
    --             label = "AVOCAT",
    --             salary = 150,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "ASSOCIE",
    --             salary = 180,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 200,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "Avocat",
    --             subtitle = "Actions",
    --             name = "avocat_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("avocatn")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                     local text = exports['Snoupinput']:GetInput()
    --                     if text ~= false and text ~= "" then
    --                         TriggerServerEvent("Job:Annonce", "Cabinet Nemesis Associate", "Annonce", text, "CHAR_LAWYER", 8, "Cabinet Nemesis Associate")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    -- },
    -- avocatj = {
    --     label = "Cabinet F&K",
    --     label2 = "Cabinet F&K",
    --     iban = "avocatj",
    --     grade = {
    --         {
    --             label = "AVOCAT",
    --             salary = 150,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "ASSOCIE",
    --             salary = 180,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 200,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "Avocat",
    --             subtitle = "Actions",
    --             name = "avocatj_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("avocatj")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                     local text = exports['Snoupinput']:GetInput()
    --                     if text ~= false and text ~= "" then
    --                         TriggerServerEvent("Job:Annonce", "Cabinet F&K", "Annonce", text, "CHAR_LAWYER", 8, "Cabinet F&K")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    -- },
    night = {
        label = "Night-Club",
        label2 = "Night-Club",
        iban = "night",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Night-Club",
                subtitle = "Actions",
                name = "night_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("night")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Galaxy", "Annonce", text, "CHAR_GALAXY", 8, "Night-Club")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage Night-Club",
            Pos = {x = 367.85, y = 296.09, z = 102.50},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 367.85, y = 296.09, z = 102.50, h = 353.35}
            },
            Blipdata = {
                Pos = "none"
            }
        },
        Storage = {
            {
                Pos = {x = -1619.848, y = -3020.409, z = -76.20},
                Limit = 500,
                Name = "coffre_NightClub"
            },
            {
                Pos = {x = -1583.104, y = -3014.27, z = -77.00},
                Limit = 1000,
                Name = "Frigo_1"
            },
            {
                Pos = {x = -1580.260, y = -3018.293, z = -80.00},
                Limit = 1000,
                Name = "Frigo_2"
            }
        }
    },
    caroccasions = {
        label = "Car Occasions",
        label2 = "Car Occasions",
        iban = "caroccasions",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Car Occasions",
                subtitle = "Actions",
                name = "caroccasions_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("caroccasions")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Larry's", "Annonce", text, "CHAR_LARRYS", 8, "Car Occasions")
                        end
                    end
                },
                {
                    label = "Créer une clé",
                    onSelected = function()
                        Clef()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Créer une carte grise",
                    onSelected = function()
                        CarteGrise()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Changer un propriétaire de véhicule - Personne en face",
                    onSelected = function()
                        local playerID = GetPlayerServerIdInDirection(5.0)
                        
                        if (playerID and playerID ~= false) then
                            CGNvxProprioPlyrID(playerID)
                        end
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Changer un propriétaire de véhicule - Nom/Prénom",
                    onSelected = function()
                        CGNvxProprioPlyr()
                    end
                },
                {
                    label = "Changer un propriétaire de véhicule - Entreprise",
                    onSelected = function()
                        CGNvxProprioJob()
                    end
                },
                {
                    label = "Mettre/Retirer le véhicule du plateau",
                    onSelected = function()
                        Mecano.PutPlateau()
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Retourner le véhicule",
                    onSelected = function()
                        SetVehicleOnGroundProperly(GetVehicleInDirection(5.0))
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            },
            submenus = {
                ["Actions véhicule"] = {
                    submenu = "caroccasions_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Inspecter l'état du véhicule",
                                onSelected = function()
                                    Mecano.CheckVehicle()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Inspecter les performances du véhicule",
                                onSelected = function()
                                    Mecano.CheckPerfs()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Ouvrir le capot",
                                onSelected = function()
                                    Mecano.OpenTrunk()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Réparer",
                                onSelected = function()
                                    Mecano.Repair()
                                    RageUI.CloseAll()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Nettoyer",
                                onSelected = function()
                                    Mecano.CleanVehicule()
                                    RageUI.CloseAll()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Mettre/Retirer le véhicule du plateau",
                                onSelected = function()
                                    Mecano.PutPlateau()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Mise en fourière",
                                onSelected = function()
                                    Mecano.Fouriere()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            }
                        },
                        submenus = {}
                    }
                }
            }
        },
        garage = {
            Name = "Garage_caroccasions",
            Pos = {x = 1210.015, y = 2714.235, z = 37.20},
            Properties = {
                type = 3, --job public
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 1210.015, y = 2714.235, z = 37.20, h = 351.93}
            },
            Blipdata = {
                Pos = {x = 1210.015, y = 2714.235, z = 37.20},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = 1226.933, y = 2738.123, z = 37.00},
                Limit = 100,
                Name = "coffre_caroccasions"
            }
        }
    },
    -- Mosley = {
    --     label = "Mosley",
    --     label2 = "Mosley",
    --     FreeAccess = false,
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 0,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "CDI",
    --             salary = 0,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 0,
    --             name = "chef",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 0,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 0,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "Mosley'S",
    --             subtitle = "Actions",
    --             name = "mosley_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("mosley")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             }
    --         }
    --     },
    --     garage = {
    --         Name = "Garage_mosley",
    --         Pos = {x = -12.16, y = -1664.4, z = 28.48},
    --         Properties = {
    --             type = 3, --job
    --             Limit = 10,
    --             vehicles = {},
    --             spawnpos = {x = -12.16, y = -1664.4, z = 28.48, h = 139.54}
    --         },
    --         Blipdata = {
    --             Pos = {x = -12.16, y = -1664.4, z = 28.48},
    --             Blipcolor = 5,
    --             Blipname = "Garage"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -33.56, y = -1668.81, z = 28.48},
    --             Limit = 100,
    --             Name = "coffre_mosley"
    --         }
    --     }
    -- },
    distillerie = {
        label = "Distillerie",
        label2 = "Distillerie",
        iban = "distillerie",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Distillerie",
                subtitle = "Actions disponibles",
                name = "distillerie_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("distillerie")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Distillerie", "Annonce", text, "CHAR_DISTILLERIE", 8, "Distillerie")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage distillerie",
            Pos = {x = -1906.30, y = 2030.05, z = 140.73},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -1906.30, y = 2030.05, z = 140.73, h = 339.66}
            },
            Blipdata = {
                Pos = {x = -1906.30, y = 2030.05, z = 140.73},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = -1912.07, y = 2073.65, z = 139.40},
                Limit = 1000,
                Name = "coffre_distillerie"
            }
        },
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = -1812.54, y = 2206.83, z = 92.37},
                giveitem = "raisin",
                blipcolor = 7,
                blipname = "Distillerie - Récolte de raisin",
                add = "~p~+ 1 Raisin",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte2 = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = -1922.77, y = 1963.893, z = 149.18},
                giveitem = "agave",
                blipcolor = 7,
                blipname = "Distillerie - Récolte d'agave",
                add = "~p~+ 1 Agave",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte3 = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = -1597.12, y = 2266.27, z = 68.63},
                giveitem = "c_sucre",
                blipcolor = 7,
                blipname = "Distillerie - Récolte de canne a sucre",
                add = "~p~+ 1 Canne a sucre",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte4 = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 2151.64, y = 5167.51, z = 54.67},
                giveitem = "levure",
                blipcolor = 7,
                blipname = "Distillerie - Récolte de levure",
                add = "~p~+ 1 Levure",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte5 = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = -1897.64, y = 2167.62, z = 113.09 - 0.98},
                giveitem = "houblon",
                blipcolor = 7,
                blipname = "Distillerie - Récolte de houblon",
                add = "~p~+ 1 Houblon",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            -- recolte6 = {
            --     type = "recolte",
            --     workSize = 10.0,
            --     Pos = {x = 2640.3, y = 4690.04, z = 35.13 - 0.98},
            --     giveitem = "cereale",
            --     blipcolor = 7,
            --     blipname = "Distillerie - Récolte de cereales",
            --     add = "~p~+ 1 Cereale",
            --     anim = {
            --         lib = "anim@mp_snowball",
            --         anim = "pickup_snowball"
            --     }
            -- },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor = 7,
                blipname = "Distillerie - Traitement raisin",
                Pos = {x = 472.59, y = 3566.54, z = 33.24},
                required = "raisin",
                giveitem = "jus_raisin",
                RemoveItem = "raisin",
                add = "~p~+ 1  Jus de raisin"
            },
            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor = 7,
                blipname = "Distillerie - Traitement vin",
                Pos = {x = -1929.02, y = 1779.09, z = 173.07},
                required = "jus_raisin",
                giveitemType = 1,
                add = "~p~+ 1  Bouteille de vin",
                giveitem = {
                    {name = "red_wine", count = 2, chanceDrop = 65},
                    {name = "high_quality_wine", count = 2, chanceDrop = 35}
                }
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 5.45,
                blipname = "Distillerie - Revente",
                Pos = {x = 1677.34, y = 4882.38, z = 42.04},
                required = "jus_raisin",
                RemoveItem = "jus_raisin",
                price = math.random(18, 25),
                add = "~p~- 1 Jus de raisin"
            }
        },
        Extrapos = {
            CraftSpiritueux = {
                Pos = {
                    {x = -1928.61, y = 2060.05, z = 140.84 - 0.98}
                },
                restricted = {1, 2, 3, 4, 5},
                Enter = function()
                    EntercraftAlcoolZone()
                end,
                Exit = function()
                    ExitcraftAlcoolZone()
                end,
                zonesize = 3.5,
                Blips = {
                    sprite = 93,
                    color = 81,
                    name = "Distillerie - Alambique"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.2},
                    color = {r = 255, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        }
    },
    raffinerie = {
        label = "Raffinerie",
        label2 = "Raffinerie",
        iban = "raffinerie",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Raffinerie",
                subtitle = "Actions disponibles",
                name = "Raffinerie_menuperso"
            },
            buttons = {
                {
                    label = "Niveau citerne",
                    onSelected = function()
                        local ped = PlayerPedId()
                        if IsPedInAnyVehicle(ped, false) then
                            local veh = GetVehiclePedIsIn(ped, false)
                            local bool, trailer = GetVehicleTrailerVehicle(veh)
                            if bool then
                                if DecorExistOn(trailer, "FUEL_TR") then
                                    ShowNotification("~b~Quantité d'essence :~w~"..DecorGetFloat(trailer, "FUEL_TR"))
                                end
                            else
                                ShowNotification("~r~Aucune citerne attelé")
                            end
                        end
                    end
                },
                {
                    label = "Niveau station essence",
                    onSelected = function()
                        GetAllPumpLevel()
                    end
                }
            }
        },
        requiredService = true,
        garage = {
            Name = "Garage Raffinerie",
            Pos = {x = -122.291, y = -2538.134, z = 5.10},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -122.291, y = -2538.134, z = 5.10, h = 243.62}
            },
            Blipdata = {
                Pos = {x = -122.291, y = -2538.134, z = 5.10},
                Blipcolor = 5,
                Blipname = "Garage Raffinerie"
            }
        },
        Storage = {
            {
                Pos = {x = -62.096, y = -2516.604, z = 6.40},
                Limit = 500,
                Name = "coffre raffinerie"
            }
        }
    },
    lssd = {
        label = "LSSD",
        label2 = "LSSD",
        iban = "lssd",
        -- radios = {1,2},
        grade = {
            {
                label = "Deputy Trainee",
                salary = 325,
                name = "recrue"
            },
            {
                label = "Deputy",
                salary = 340,
                name = "ranger"
            },
            {
                label = "Deputy II",
                salary = 340,
                name = "ranger2"
            },
            {
                label = "Deputy III",
                salary = 340,
                name = "ranger3"
            },
            {
                label = "Sergent",
                salary = 360,
                name = "deputy"
            },
            {
                label = "Lieutenant",
                salary = 370,
                name = "deputychef"
            },
            {
                label = "Shérif Adjoint",
                salary = 390,
                name = "drh"
            },
            {
                label = "Shérif",
                salary = 430,
                name = "boss"
            }
        },
        garage = {
            Name = "Garage LSSD SandyShore",
            Pos = {x = 1873.98, y = 3686.96, z = 32.59},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 1873.98, y = 3686.96, z = 33.59, h = 197.337}
            },
            Blipdata = {
                Pos = {x = 1873.98, y = 3686.96, z = 33.59},
                Blipcolor = 5,
                Blipname = "Garage LSSD SandyShore"
            }
        },
        garage2 = {
            Name = "Garage LSSD Paleto",
            Pos = {x = -469.92, y = 6019.82, z = 30.34},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = -469.92, y = 6019.82, z = 31.34, h = 294.42}
            },
            Blipdata = {
                Pos = {x = -469.92, y = 6019.82, z = 31.34},
                Blipcolor = 5,
                Blipname = "Garage LSSD Paleto"
            }
        },
        garage3 = {
            Name = "Helipad Sherif",
            Pos = {x = -475.13, y = 5988.67, z = 31.34},
            Properties = {
                type = 2,
                Limit = 10,
                zonesize = 1.5,
                vehicles = {
                    {
                        name = "as350",
                        label = "Helicoptere de police",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = -475.13, y = 5988.67, z = 31.34, h = 315.34}
            },
            Blipdata = {
                Pos = {x = -475.13, y = 5988.67, z = 31.34},
                Blipcolor = 5,
                Blipname = "LSSD - Helipad Sherif"
            }
        },
        garage4 = {
            Name = "Marina Sherif",
            Pos = {x = -1605.05, y = 5258.63, z = 2.08},
            Properties = {
                type = 2,
                Limit = 10,
                zonesize = 1.5,
                vehicles = {
                    {
                        name = "predator",
                        label = "Bateau de police",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = -1601.89, y = 5259.27, z = -0.47, h = 20.14}
            },
            Blipdata = {
                Pos = {x = -1605.05, y = 5258.63, z = 2.08},
                Blipcolor = 5,
                Blipname = "LSSD - Marina Sherif"
            }
        },
        garage5 = {
            Name = "Garage Personnel LSSD Sandy Shores",
            Pos = {x = 1872.247, y = 3705.467, z = 32.00},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 1872.247, y = 3705.467, z = 32.00, h = 303.109}
            },
            Blipdata = {
                Pos = {x = 1872.247, y = 3705.467, z = 32.00},
                Blipcolor = 5,
                Blipname = "LSSD - Garage Personnel"
            }
        },
        Menu = {
            menu = {
                title = "Sherif",
                subtitle = "Actions disponibles",
                name = "police_menuperso"
            },
            submenus = {
                ["Actions citoyen"] = {
                    submenu = "police_menuperso",
                    title = "Actions citoyen",
                    menus = {
                        buttons = {
                            {
                                label = "Menotter",
                                onSelected = function()
                                    Police.HandcuffPly()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Démenotter",
                                onSelected = function()
                                    Police.CutMenottes()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Retrait/Ajout de points de permis",
                                onSelected = function()
                                    Police.RetraitPermis()
                                end
                            },
                            {
                                label = "Autoriser un repassage de permis",
                                onSelected = function()
                                    Police.AuthorizeLicence()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Amendes",
                                onSelected = function()
                                    CreateFacture("gouvernement")
                                end
                            },
                            {
                                label = "Test poudre à feu",
                                onSelected = function()
                                    Police.Powder()
                                end
                            },
                            {
                                label = "Test stupéfiant",
                                onSelected = function()
                                    Police.Stup()
                                end
                            },
                            {
                                label = "Photo d'identité",
                                onSelected = function()
                                    Police.PhotoIdent()
                                end
                            },
                            {
                                label = "Délivrer le port d'arme",
                                onSelected = function()
                                    Police.PutPortWeapon()
                                    Police.AutorizePpa()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Délivrer le permis de chasse",
                                onSelected = function()
                                    RageUI.CloseAll()
                                    Wait(100)
                                    RageUI.Visible(RMenu:Get("police","hunting_license"), true)
                                end
                            },
                            {
                                label = "Mettre dans le véhicule",
                                onSelected = function()
                                    Police.PutInVeh()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Sortir du véhicule",
                                onSelected = function()
                                    Police.SortirVeh()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Bracelet électronique",
                                onSelected = function()
                                    Police.Bracelet()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Actions traffic"] = {
                    submenu = "police_menuperso",
                    title = "Actions traffic",
                    menus = {
                        buttons = {
                            {
                                label = "Modifier la zone",
                                onSelected = function()
                                    Police.EditZone()
                                end
                            },
                            {
                                label = "Changer la vitesse de la zone",
                                desc = "0 pour que les véhicules soient immobiles",
                                onSelected = function()
                                    Police.ChangeZone()
                                end
                            },
                            {
                                label = "Supprimer la limite de vitesse",
                                onSelected = function()
                                    Police.RemoveZone()
                                end
                            },
                            {
                                label = "Afficher la zone",
                                onSelected = function()
                                end,
                                ActiveFct = function()
                                    Police.ShowZone()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Actions véhicule"] = {
                    submenu = "police_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Inspecter la plaque",
                                onSelected = function()
                                    Police.PlateCheck()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Crocheter",
                                onSelected = function()
                                    Police.Crocheter()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Immobiliser",
                                onSelected = function()
                                    Police.Immobiliser()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Désimmobiliser",
                                onSelected = function()
                                    Police.Desimmobiliser()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Informations effectifs"] = {
                    submenu = "police_menuperso",
                    title = "Effectifs",
                    menus = {
                        buttons = {
                            {
                                label = "Sherifs en service",
                                onSelected = function()
                                    TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "lssd")
                                end
                            },
                            {
                                label = "[COOP] Agents LSPD en service",
                                onSelected = function()
                                    TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "police")
                                end
                            },
                            {
                                label = "Recevoir/Ne plus recevoir les appels LSPD",
                                onSelected = function()
                                    if not getOtherPoliceCalls then
                                        TriggerServerEvent("Ora::SE::Service:SetPlayerInService", "police")
                                        RageUI.Popup({message = "~g~Vous recevez désormais les appels LSPD"})
                                        getOtherPoliceCalls = not getOtherPoliceCalls
                                    else
                                        TriggerServerEvent("Ora::SE::Service:RemovePlayerFromService", "police")
                                        RageUI.Popup({message = "~r~Vous ne recevez plus désormais les appels LSPD"})
                                        getOtherPoliceCalls = not getOtherPoliceCalls
                                    end
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Action objets"] = {
                    submenu = "police_menuperso",
                    title = "Placer objets",
                    menus = {
                        buttons = {
                            {
                                label = "Mettre une herse",
                                onSelected = function()
                                    useHerse()
                                end
                            },
                            {
                                label = "Mettre un cone",
                                onSelected = function()
                                    useCone()
                                end
                            },
                            {
                                label = "Mettre une barriere",
                                onSelected = function()
                                    useBarrier()
                                end
                            },
                            {
                                label = "Supprimer herse",
                                onSelected = function()
                                    DeleteHerse()
                                end
                            },
                            {
                                label = "Supprimer un cone",
                                onSelected = function()
                                    DeleteCone()
                                end
                            },
                            {
                                label = "Supprimer une barriere",
                                onSelected = function()
                                    DeleteBarrier()
                                end
                            }
                        },
                        submenu = {}
                    }
                },
                ["Action renforts"] = {
                    submenu = "police_menuperso",
                    title = "Renforts",
                    menus = {
                        buttons = {
                            {
                                label = "Renforts",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "lssd",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~2 \n~b~Importance : ~s~Légère"
                                    )
                                end,
                                ActiveFct = function()
                                end
                            },
                            {
                                label = "Renforts ~o~important",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "lssd",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~3 \n~b~Importance : ~o~Importante"
                                    )
                                end,
                                ActiveFct = function()
                                end
                            },
                            {
                                label = "Renforts ~r~~h~urgent",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "lssd",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~99 \n~b~Importance : ~r~~h~URGENTE"
                                    )
                                    Police.code99()
                                end,
                                ActiveFct = function()
                                end
                            }
                        },
                        submenu = {}
                    }
                }
            },
            buttons = {
                -- {label="Activer/Désactiver le tracking",onSelected=function()
                --     Police.ActivateTrack()
                -- end},
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "LSSD", "Annonce", text, "CHAR_LSSD", 8)
                        end
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                },
                {
                    label = "Supervision",
                    onSelected = function()
                        if policeMatricule == nil then
                            policeMatricule = KeyboardInput("Votre matricule", nil, 255)
                            local policeMatricule2 = KeyboardInput("Confirmer votre matricule", nil, 255)
                            if policeMatricule == nil or policeMatricule == "" or policeMatricule ~= policeMatricule2 then
                                policeMatricule = nil
                            else
                                policeType, policeGrade = Ora.Identity.Job:GetName(), Ora.Identity.Job:Get().gradenum
                                RageUI.CloseAll()
                                Wait(100)
                                RageUI.Visible(RMenu:Get("jobs", "police_supervisor"), true)
                            end
                        else
                            RageUI.CloseAll()
                            Wait(100)
                            RageUI.Visible(RMenu:Get("jobs", "police_supervisor"), true)
                        end
                    end
                }
            }
        },
        Storage = {
            -- SandyShore
            {
                Pos = {x = 1849.82, y = 3694.15, z = 29.27},
                Limit = 99999999,
                Name = "coffre Saisies"
            },
            {
                Pos = {x = 1860.7, y = 3688.35, z = 33.27},
                Limit = 99999999,
                Name = "coffre LSSD"
            },
            {
                Pos = {x = 1855.627, y = 3692.631, z = 37.10},
                Limit = 99999999,
                Name = "Frigo LSSD"
            },
            {
                Pos = {x = 1845.678, y = 3692.368, z = 33.27},
                Limit = 99999999,
                Name = "Vestiaire LSSD"
            },
            -- PALETO
            {
                Pos = {x = -438.51, y = 6010.13, z = 26.98},
                Limit = 99999999,
                Name = "coffre Saisies"
            },
            {
                Pos = {x = -434.03, y = 6002.44, z = 30.71},
                Limit = 99999999,
                Name = "coffre LSSD"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = 1849.57, y = 3696.18, z = 33.27},
                vestiaire = {
                    type = "Vestiaire",
                    workSize = 1.45,
                    Pos = {x = 1849.57, y = 3696.18, z = 33.27},
                    Tenues = TenueLSSD
                }
            }
        },
        Extrapos = {
            ExtraVehicle = {
                Pos = {
                    {x = 1864.83, y = 3700.57, z = 32.55}
                },
                restricted = {1, 2, 3, 4, 5, 6, 7, 8},
                Enter = function()
                    EnterExtraPoliceVehicleZone()
                end,
                Exit = function()
                    ExitExtraPoliceVehicleZone()
                end,
                zonesize = 3.5,
                Blips = {
                    sprite = 402,
                    color = 81,
                    name = "LSSD - Extras"
                },
                Marker = {
                    type = 1,
                    scale = {x = 3.5, y = 3.5, z = 0.1},
                    color = {r = 255, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        }
    },
    police = {
        label = "LSPD",
        label2 = "LSPD",
        iban = "police",
        radios = {1, 2},
        grade = {
            {
                label = "Cadet",
                salary = 325,
                name = "cadet"
            },
            {
                label = "Officier I",
                salary = 340,
                name = "officier1"
            },
            {
                label = "Officier II",
                salary = 340,
                name = "officier2"
            },
            {
                label = "Officier III",
                salary = 340,
                name = "officier3"
            },
            {
                label = "Sergent I",
                salary = 360,
                name = "sergent1"
            },
            {
                label = "Sergent II",
                salary = 360,
                name = "sergent2"
            },
            {
                label = "Lieutenant",
                salary = 390,
                name = "drh"
            },
            {
                label = "Capitaine",
                salary = 430,
                name = "boss"
            }
        },
        garage = {
            Name = "Garage police",
            Pos = {x = -1072.52, y = -856.42, z = 4.87},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = -1072.52, y = -856.42, z = 4.87, h = 206.45}
            },
            Blipdata = {
                Pos = {x = -1072.52, y = -856.42, z = 4.87},
                Blipcolor = 5,
                Blipname = "LSPD - Garage"
            }
        },
        garage2 = {
            Name = "Garage police2",
            Pos = {x = -1068.78, y = -852.61, z = 4.87},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = -1068.78, y = -852.61, z = 4.87, h = 221.91}
            },
            Blipdata = {
                Pos = {x = -1068.78, y = -852.61, z = 4.87},
                Blipcolor = 5,
                Blipname = "LSPD - Garage"
            }
        },
        garage3 = {
            Name = "GarageLSBateau",
            Pos = {x = -800.45, y = -1514.03, z = 1.6},
            Properties = {
                type = 3,
                Limit = 6,
                zonesize = 5.0,
                vehicles = {},
                spawnpos = {x = -795.98, y = -1515.0, z = 0.12, h = 112.53}
            },
            Blipdata = {
                Pos = {x = -800.45, y = -1514.03, z = 1.6},
                Blipcolor = 5,
                Blipname = "LSPD - Bateaux"
            }
        },
        garage4 = {
            Name = "Garage Helipad",
            Pos = {x = -1096.74, y = -833.14, z = 37.7},
            Properties = {
                type = 2,
                Limit = 10,
                zonesize = 1.5,
                vehicles = {
                    {
                        name = "as350",
                        label = "Helicoptere de police",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = -1096.74, y = -833.14, z = 37.7, h = 128.28}
            },
            Blipdata = {
                Pos = {x = -1096.74, y = -833.14, z = 37.7},
                Blipcolor = 5,
                Blipname = "LSPD - Helipad"
            }
        },
        garage5 = {
            Name = "Garage police3",
            Pos = {x = -1124.378, y = -842.148, z = 13.42},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = -1124.378, y = -842.148, z = 13.42},
            },
            Blipdata = {
                Pos = {x = -1124.378, y = -842.148, z = 13.42},
                Blipcolor = 5,
                Blipname = "LSPD - Garage Personnel"
            }
        },
        Menu = {
            menu = {
                title = "Police",
                subtitle = "Actions disponibles",
                name = "police_menuperso"
            },
            submenus = {
                ["Actions citoyen"] = {
                    submenu = "police_menuperso",
                    title = "Actions citoyen",
                    menus = {
                        buttons = {
                            {
                                label = "Menotter",
                                onSelected = function()
                                    Police.HandcuffPly()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Démenotter",
                                onSelected = function()
                                    Police.CutMenottes()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Retrait/Ajout de points de permis",
                                onSelected = function()
                                    Police.RetraitPermis()
                                end
                            },
                            {
                                label = "Autoriser un repassage de permis",
                                onSelected = function()
                                    Police.AuthorizeLicence()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Amendes",
                                onSelected = function()
                                    CreateFacture("gouvernement")
                                end
                            },
                            {
                                label = "Test poudre à feu",
                                onSelected = function()
                                    Police.Powder()
                                end
                            },
                            {
                                label = "Test stupéfiant",
                                onSelected = function()
                                    Police.Stup()
                                end
                            },
                            {
                                label = "Photo d'identité",
                                onSelected = function()
                                    Police.PhotoIdent()
                                end
                            },
                            {
                                label = "Délivrer le port d'arme",
                                onSelected = function()
                                    Police.PutPortWeapon()
                                    Police.AutorizePpa()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Retirer le port d'arme",
                                onSelected = function()
                                    Police.RetirePpa()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Mettre dans le véhicule",
                                onSelected = function()
                                    Police.PutInVeh()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Sortir du véhicule",
                                onSelected = function()
                                    Police.SortirVeh()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Bracelet électronique",
                                onSelected = function()
                                    Police.Bracelet()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Actions traffic"] = {
                    submenu = "police_menuperso",
                    title = "Actions traffic",
                    menus = {
                        buttons = {
                            {
                                label = "Modifier la zone",
                                onSelected = function()
                                    Police.EditZone()
                                end
                            },
                            {
                                label = "Changer la vitesse de la zone",
                                desc = "0 pour que les véhicules soient immobiles",
                                onSelected = function()
                                    Police.ChangeZone()
                                end
                            },
                            {
                                label = "Supprimer la limite de vitesse",
                                onSelected = function()
                                    Police.RemoveZone()
                                end
                            },
                            {
                                label = "Afficher la zone",
                                onSelected = function()
                                end,
                                ActiveFct = function()
                                    Police.ShowZone()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Actions véhicule"] = {
                    submenu = "police_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Inspecter la plaque",
                                onSelected = function()
                                    Police.PlateCheck()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Crocheter",
                                onSelected = function()
                                    Police.Crocheter()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Immobiliser",
                                onSelected = function()
                                    Police.Immobiliser()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Désimmobiliser",
                                onSelected = function()
                                    Police.Desimmobiliser()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Placer une sirène",
                                onSelected = function()
                                    if (Ora.Identity:GetMyGroup() == "superadmin") then
                                        Police.Sirens()
                                    else
                                        RageUI.Popup({message = "~r~Vous ne pouvez pas faire ça !"})
                                    end
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Action objets"] = {
                    submenu = "police_menuperso",
                    title = "Placer objets",
                    menus = {
                        buttons = {
                            {
                                label = "Mettre une herse",
                                onSelected = function()
                                    useHerse()
                                end
                            },
                            {
                                label = "Mettre un cone",
                                onSelected = function()
                                    useCone()
                                end
                            },
                            {
                                label = "Mettre une barriere",
                                onSelected = function()
                                    useBarrier()
                                end
                            },
                            {
                                label = "Supprimer herse",
                                onSelected = function()
                                    DeleteHerse()
                                end
                            },
                            {
                                label = "Supprimer un cone",
                                onSelected = function()
                                    DeleteCone()
                                end
                            },
                            {
                                label = "Supprimer une barriere",
                                onSelected = function()
                                    DeleteBarrier()
                                end
                            }
                        },
                        submenu = {}
                    }
                },
                ["Informations effectifs"] = {
                    submenu = "police_menuperso",
                    title = "Effectifs",
                    menus = {
                        buttons = {
                            {
                                label = "Agents LSPD en service",
                                onSelected = function()
                                    TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "police")
                                end
                            },
                            {
                                label = "[COOP] Sherifs en service",
                                onSelected = function()
                                    TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "lssd")
                                end
                            },
                            {
                                label = "Recevoir/Ne plus recevoir les appels LSSD",
                                onSelected = function()
                                    if not getOtherPoliceCalls then
                                        TriggerServerEvent("Ora::SE::Service:SetPlayerInService", "lssd")
                                        RageUI.Popup({message = "~g~Vous recevez désormais les appels LSSD"})
                                        getOtherPoliceCalls = not getOtherPoliceCalls
                                    else
                                        TriggerServerEvent("Ora::SE::Service:RemovePlayerFromService", "lssd")
                                        RageUI.Popup({message = "~r~Vous ne recevez plus désormais les appels LSSD"})
                                        getOtherPoliceCalls = not getOtherPoliceCalls
                                    end
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Action renforts"] = {
                    submenu = "police_menuperso",
                    title = "Renforts",
                    menus = {
                        buttons = {
                            {
                                label = "Renforts",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "police",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~2 \n~b~Importance : ~s~Légère"
                                    )
                                end,
                                ActiveFct = function()
                                end
                            },
                            {
                                label = "Renforts ~o~important",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "police",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~3 \n~b~Importance : ~o~Importante"
                                    )
                                end,
                                ActiveFct = function()
                                end
                            },
                            {
                                label = "Renforts ~r~~h~urgent",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "police",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~99 \n~b~Importance : ~r~~h~URGENTE"
                                    )
                                    Police.code99()
                                end,
                                ActiveFct = function()
                                end
                            }
                        },
                        submenu = {}
                    }
                }
            },
            buttons = {
                -- {label="Activer/Désactiver le tracking",onSelected=function()
                --     Police.ActivateTrack()
                -- end},
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "LSPD", "Annonce", text, "CHAR_LSPD", 8)
                        end
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                },
                {
                    label = "Supervision",
                    onSelected = function()
                        if policeMatricule == nil then
                            policeMatricule = KeyboardInput("Votre matricule", nil, 255)
                            local policeMatricule2 = KeyboardInput("Confirmer votre matricule", nil, 255)
                            if policeMatricule == nil or policeMatricule == "" or policeMatricule ~= policeMatricule2 then
                                policeMatricule = nil
                            else
                                policeType, policeGrade = Ora.Identity.Job:GetName(), Ora.Identity.Job:Get().gradenum
                                RageUI.CloseAll()
                                Wait(100)
                                RageUI.Visible(RMenu:Get("jobs", "police_supervisor"), true)
                            end
                        else
                            RageUI.CloseAll()
                            Wait(100)
                            RageUI.Visible(RMenu:Get("jobs", "police_supervisor"), true)
                        end
                    end
                }
            }
        },
        Storage = {
            {
                Pos = {x = -1098.83, y = -825.99, z = 13.28},
                Limit = 99999999,
                Name = "coffre"
            },
            {
                Pos = {x = -1078.51, y = -815.81, z = 10.04},
                Limit = 5000,
                Name = "coffre des saisies"
            },
            {
                Pos = {x = -1099.21, y = -830.74, z = 13.28},
                Limit = 99999999,
                Name = "coffre personnel"
            },
            {
                Pos = {x = 379.5462, y = -1609.8751, z = 30.2027 - 0.98},
                Limit = 2000,
                Name = "coffre Saisies DB"
            },
            {
                Pos = {x = -1079.99, y = -823.06, z = 13.88},
                Limit = 99999999,
                Name = "coffre SWAT"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = -1096.24, y = -832.15, z = 14.28},
                vestiaire = {
                    type = "Vestiaire",
                    workSize = 1.45,
                    Pos = {x = -1096.24, y = -832.15, z = 14.28},
                    Tenues = TenueLSPD
                }
            }
        },
        Extrapos = {
            ExtraVehicle = {
                Pos = {
                    {x = -1078.94, y = -884.94, z = 4.61}
                },
                restricted = {1, 2, 3, 4, 5, 6, 7, 8},
                Enter = function()
                    EnterExtraPoliceVehicleZone()
                end,
                Exit = function()
                    ExitExtraPoliceVehicleZone()
                end,
                zonesize = 3.5,
                Blips = {
                    sprite = 402,
                    color = 81,
                    name = "LSPD - Extras"
                },
                Marker = {
                    type = 1,
                    scale = {x = 3.5, y = 3.5, z = 0.1},
                    color = {r = 255, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        }
    },
    -- usms = {
    --     label = "US MARSHALS",
    --     label2 = "US MARSHALS",
    --     iban = "usms",
    --     -- radios = {1,2},
    --     grade = {
    --         {
    --             label = "candidat",
    --             salary = 325,
    --             name = "recrue"
    --         },
    --         {
    --             label = "US Marshal",
    --             salary = 340,
    --             name = "marshal"
    --         },
    --         {
    --             label = "Superviseur",
    --             salary = 340,
    --             name = "marshal2"
    --         },
    --         {
    --             label = "Commandant de secteur",
    --             salary = 360,
    --             name = "marshal3"
    --         },
    --         {
    --             label = "Assistant chef",
    --             salary = 390,
    --             name = "drh"
    --         },
    --         {
    --             label = "Chef",
    --             salary = 430,
    --             name = "boss"
    --         }
    --     },
    --     garage = {
    --         Name = "Garage usms",
    --         Pos = {x = 452.60, y = -987.21, z = 25.69},
    --         Properties = {
    --             type = 3,
    --             Limit = 64,
    --             vehicles = {},
    --             spawnpos = {x = 452.15, y = -982.06, z = 25.69, h = 88.97}
    --         },
    --         Blipdata = {
    --             Pos = {x = 452.60, y = -987.21, z = 25.69},
    --             Blipcolor = 5,
    --             Blipname = "Garage USMS"
    --         }
    --     },
    --     garage2 = {
    --         Name = "Helipad USMS",
    --         Pos = {x = 449.92, y = -981.35, z = 43.69},
    --         Properties = {
    --             type = 2,
    --             Limit = 10,
    --             zonesize = 1.5,
    --             vehicles = {
    --                 {
    --                     name = "annihilator",
    --                     label = "Helicoptere USMS",
    --                     job = true,
    --                     tuning = {
    --                         modXenon = false,
    --                         modLivery = 0
    --                     }
    --                 }
    --             },
    --             spawnpos = {x = 449.92, y = -981.35, z = 43.69, h = 87.53}
    --         },
    --         Blipdata = {
    --             Pos = {x = 449.92, y = -981.35, z = 43.69},
    --             Blipcolor = 5,
    --             Blipname = "USMS - Helipad"
    --         }
    --     },
    --     garage3 = {
    --         Name = "Garage 2 USMS",
    --         Pos = {x = 436.00, y = -986.44, z = 25.69},
    --         Properties = {
    --             type = 3,
    --             Limit = 64,
    --             vehicles = {},
    --             spawnpos = {x = 432.49, y = -984.28, z = 25.69, h = 175.82}
    --         },
    --         Blipdata = {
    --             Pos = {x = 436.00, y = -986.44, z = 25.69},
    --             Blipcolor = 5,
    --             Blipname = "Garage 2 USMS"
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "USMS",
    --             subtitle = "Actions disponibles",
    --             name = "police_menuperso"
    --         },
    --         submenus = {
    --             ["Actions citoyen"] = {
    --                 submenu = "police_menuperso",
    --                 title = "Actions citoyen",
    --                 menus = {
    --                     buttons = {
    --                         {
    --                             label = "Menotter",
    --                             onSelected = function()
    --                                 Police.HandcuffPly()
    --                             end,
    --                             ActiveFct = function()
    --                                 HoverPlayer()
    --                             end
    --                         },
    --                         {
    --                             label = "Démenotter",
    --                             onSelected = function()
    --                                 Police.CutMenottes()
    --                             end,
    --                             ActiveFct = function()
    --                                 HoverPlayer()
    --                             end
    --                         },
    --                         {
    --                             label = "Amendes",
    --                             onSelected = function()
    --                                 CreateFacture("usms")
    --                             end
    --                         },
    --                         {
    --                             label = "Test poudre à feu",
    --                             onSelected = function()
    --                                 Police.Powder()
    --                             end
    --                         },
    --                         {
    --                             label = "Test stupéfiant",
    --                             onSelected = function()
    --                                 Police.Stup()
    --                             end
    --                         },
    --                         {
    --                             label = "Photo d'identité",
    --                             onSelected = function()
    --                                 Police.PhotoIdent()
    --                             end
    --                         },
    --                         {
    --                             label = "Mettre dans le véhicule",
    --                             onSelected = function()
    --                                 Police.PutInVeh()
    --                             end,
    --                             ActiveFct = function()
    --                                 HoverPlayer()
    --                             end
    --                         },
    --                         {
    --                             label = "Sortir du véhicule",
    --                             onSelected = function()
    --                                 Police.SortirVeh()
    --                             end,
    --                             ActiveFct = function()
    --                                 HoverPlayer()
    --                             end
    --                         },
    --                         {
    --                             label = "Bracelet électronique",
    --                             onSelected = function()
    --                                 Police.Bracelet()
    --                             end,
    --                             ActiveFct = function()
    --                                 HoverPlayer()
    --                             end
    --                         }
    --                     },
    --                     submenus = {}
    --                 }
    --             },
    --             ["Actions traffic"] = {
    --                 submenu = "police_menuperso",
    --                 title = "Actions traffic",
    --                 menus = {
    --                     buttons = {
    --                         {
    --                             label = "Modifier la zone",
    --                             onSelected = function()
    --                                 Police.EditZone()
    --                             end
    --                         },
    --                         {
    --                             label = "Changer la vitesse de la zone",
    --                             desc = "0 pour que les véhicules soient immobiles",
    --                             onSelected = function()
    --                                 Police.ChangeZone()
    --                             end
    --                         },
    --                         {
    --                             label = "Supprimer la limite de vitesse",
    --                             onSelected = function()
    --                                 Police.RemoveZone()
    --                             end
    --                         },
    --                         {
    --                             label = "Afficher la zone",
    --                             onSelected = function()
    --                             end,
    --                             ActiveFct = function()
    --                                 Police.ShowZone()
    --                             end
    --                         }
    --                     },
    --                     submenus = {}
    --                 }
    --             },
    --             ["Actions véhicule"] = {
    --                 submenu = "police_menuperso",
    --                 title = "Actions véhicule",
    --                 menus = {
    --                     buttons = {
    --                         {
    --                             label = "Inspecter la plaque",
    --                             onSelected = function()
    --                                 Police.PlateCheck()
    --                             end,
    --                             ActiveFct = function()
    --                                 Mecano.ShowMarker()
    --                             end
    --                         },
    --                         {
    --                             label = "Crocheter",
    --                             onSelected = function()
    --                                 Police.Crocheter()
    --                             end,
    --                             ActiveFct = function()
    --                                 Mecano.ShowMarker()
    --                             end
    --                         },
    --                         {
    --                             label = "Immobiliser",
    --                             onSelected = function()
    --                                 Police.Immobiliser()
    --                             end,
    --                             ActiveFct = function()
    --                                 Mecano.ShowMarker()
    --                             end
    --                         },
    --                         {
    --                             label = "Désimmobiliser",
    --                             onSelected = function()
    --                                 Police.Desimmobiliser()
    --                             end,
    --                             ActiveFct = function()
    --                                 Mecano.ShowMarker()
    --                             end
    --                         }
    --                     },
    --                     submenus = {}
    --                 }
    --             },
    --             ["Action objets"] = {
    --                 submenu = "police_menuperso",
    --                 title = "Placer objets",
    --                 menus = {
    --                     buttons = {
    --                         {
    --                             label = "Mettre une herse",
    --                             onSelected = function()
    --                                 useHerse()
    --                             end
    --                         },
    --                         {
    --                             label = "Mettre un cone",
    --                             onSelected = function()
    --                                 useCone()
    --                             end
    --                         },
    --                         {
    --                             label = "Mettre une barriere",
    --                             onSelected = function()
    --                                 useBarrier()
    --                             end
    --                         },
    --                         {
    --                             label = "Supprimer herse",
    --                             onSelected = function()
    --                                 DeleteHerse()
    --                             end
    --                         },
    --                         {
    --                             label = "Supprimer un cone",
    --                             onSelected = function()
    --                                 DeleteCone()
    --                             end
    --                         },
    --                         {
    --                             label = "Supprimer une barriere",
    --                             onSelected = function()
    --                                 DeleteBarrier()
    --                             end
    --                         }
    --                     },
    --                     submenu = {}
    --                 }
    --             },
    --             ["Action renforts"] = {
    --                 submenu = "police_menuperso",
    --                 title = "Renforts",
    --                 menus = {
    --                     buttons = {
    --                         {
    --                             label = "Renforts",
    --                             onSelected = function()
    --                                 local plyCoords = GetEntityCoords(PlayerPedId())
    --                                 local x, y, z = table.unpack(plyCoords)
    --                                 TriggerServerEvent(
    --                                     "call:makeCall",
    --                                     "usms",
    --                                     {x = x, y = y, z = z},
    --                                     "Besoin de renforts\n~b~Code : ~s~2 \n~b~Importance : ~s~Légère"
    --                                 )
    --                             end,
    --                             ActiveFct = function()
    --                             end
    --                         },
    --                         {
    --                             label = "Renforts ~o~important",
    --                             onSelected = function()
    --                                 local plyCoords = GetEntityCoords(PlayerPedId())
    --                                 local x, y, z = table.unpack(plyCoords)
    --                                 TriggerServerEvent(
    --                                     "call:makeCall",
    --                                     "usms",
    --                                     {x = x, y = y, z = z},
    --                                     "Besoin de renforts\n~b~Code : ~s~3 \n~b~Importance : ~o~Importante"
    --                                 )
    --                             end,
    --                             ActiveFct = function()
    --                             end
    --                         },
    --                         {
    --                             label = "Renforts ~r~~h~urgent",
    --                             onSelected = function()
    --                                 local plyCoords = GetEntityCoords(PlayerPedId())
    --                                 local x, y, z = table.unpack(plyCoords)
    --                                 TriggerServerEvent(
    --                                     "call:makeCall",
    --                                     "usms",
    --                                     {x = x, y = y, z = z},
    --                                     "Besoin de renforts\n~b~Code : ~s~99 \n~b~Importance : ~r~~h~URGENTE"
    --                                 )
    --                                 Police.code99()
    --                             end,
    --                             ActiveFct = function()
    --                             end
    --                         }
    --                     },
    --                     submenu = {}
    --                 }
    --             }
    --         },
    --         buttons = {
    --             -- {label="Activer/Désactiver le tracking",onSelected=function()
    --             --     Police.ActivateTrack()
    --             -- end},
    --             {
    --                 label = "Informations effectifs",
    --                 onSelected = function()
    --                     TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "usms")                    
    --                 end
    --             },
    --             {
    --                 label = "Actions Directeur",
    --                 onSelected = function()
    --                     if Ora.Identity.Job:GetName() == "usms" and Ora.Identity.Job:Get().gradenum == 6 then
    --                         RageUI.CloseAll()
    --                         Wait(100)
    --                         RageUI.Visible(RMenu:Get("jobs", "usms_director"), true)
    --                     end
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                     local text = exports['Snoupinput']:GetInput()
    --                     if text ~= false and text ~= "" then
    --                         TriggerServerEvent("Job:Annonce", "USMS", "Annonce", text, "CHAR_FIB", 8)
    --                     end
    --                 end
    --             }
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = 485.58, y = -996.10, z = 29.68},
    --             Limit = 99999999,
    --             Name = "coffre USMS"
    --         },
    --         {
    --             Pos = {x = 462.46, y = -980.89, z = 29.68},
    --             Limit = 99999999,
    --             Name = "coffre cuisine"
    --         },
    --         {
    --             Pos = {x = 474.83, y = -995.82, z = 25.27},
    --             Limit = 99999999,
    --             Name = "coffre USMS Saisies"
    --         }
    --     }
    -- },
    -- merryweather = {
    --     label = "👁Merry Weather",
    --     label2 = "Merry Weather",
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 0,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "CDI",
    --             salary = 0,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 0,
    --             name = "chef",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 0,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 0,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     garage = {
    --         Name = "Garage Merry Weather",
    --         Pos = {x = 486.78, y = -3153.63, z = 5.07},
    --         Properties = {
    --             type = 3,
    --             Limit = 64,
    --             zonesize = 1.0,
    --             vehicles = {},
    --             spawnpos = {x = 486.78, y = -3153.63, z = 5.07, h = 0.11}
    --         },
    --         Blipdata = {
    --             Pos = {x = 486.78, y = -3153.63, z = 5.07},
    --             Blipcolor = 5,
    --             Blipname = "Garage"
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "Merry Weather",
    --             subtitle = "Actions disponibles",
    --             name = "merryweather_menuperso"
    --         },
    --         buttons = {
    --             -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("merryweather")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     local text = KeyboardInput("Texte de l'annonce", nil, 255)
    --                     if text ~= nil and text ~= "" then
    --                         TriggerServerEvent(
    --                             "Job:Annonce",
    --                             "Merryweather",
    --                             "Annonce",
    --                             text,
    --                             "CHAR_MP_MERRYWEATHER",
    --                             8
    --                         )
    --                     end
    --                 end
    --             }
    --         }
    --     },
    --     requiredService = false,
    --     work = {
    --         recolte = {
    --             type = "recolte",
    --             workSize = 10.0,
    --             Pos = {x = 667.96, y = -2672.78, z = 5.08},
    --             giveitem = "pellicule",
    --             blipcolor = 7,
    --             blipname = "Récupérer pellicules",
    --             add = "~p~+ 1 Pellicule Photo",
    --             anim = {
    --                 lib = "anim@mp_snowball",
    --                 anim = "pickup_snowball"
    --             }
    --         },
    --         traitement = {
    --             type = "traitement",
    --             workSize = 7.45,
    --             blipcolor = 7,
    --             blipname = "Développer la photo",
    --             Pos = {x = 498.72, y = -576.41, z = 24.75},
    --             required = "pellicule",
    --             giveitem = "photo",
    --             add = "~p~+ 1 Photo développer"
    --         },
    --         vente = {
    --             type = "vente",
    --             blipcolor = 7,
    --             workSize = 7.45,
    --             blipname = "Vente",
    --             Pos = {x = 70.08, y = -727.27, z = 44.22},
    --             required = "photo",
    --             price = math.random(18, 25),
    --             add = "~p~- 1 Photo développer"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = 503.71, y = -3121.72, z = 5.07},
    --             Limit = 500,
    --             Name = "coffre_merryweather"
    --         },
    --         {
    --             Pos = {x = 563.74, y = -3121.59, z = 17.77},
    --             Limit = 500,
    --             Name = "coffre_merryweather2"
    --         }
    --     }
    -- },
    banker = {
        label = "Banquier",
        label2 = "Banquier",
        iban = "banker",
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Banquier",
                subtitle = "Actions disponibles",
                name = "Banquier_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("banker")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Banque", "Annonce", text, "CHAR_PACIFIC", 8, "Banquier")
                        end
                    end
                }
            }
        },
        Storage = {
            {
                Pos = {x = 262.56, y = 220.52, z = 100.75},
                Limit = 200,
                Name = "coffre_banque"
            }
        },
        garage = {
            Name = "Garage Banque",
            Pos = {x = 220.31, y = 217.78, z = 105.44},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {
                    {}
                },
                spawnpos = {x = 220.31, y = 217.78, z = 105.44, h = 337.33}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage_banque"
            }
        },
        Extrapos = {
            Banker = {
                Pos = {
                    {x = 249.93, y = 230.25, z = 106.29}
                },
                restricted = {2, 3, 4, 5},
                Enter = function()
                    EnterBankZone()
                end,
                Exit = function()
                    ExitBankZone()
                end,
                zonesize = 1.5,
                Blips = {
                    sprite = 500,
                    color = 69,
                    name = "Gestion comptes"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.2},
                    color = {r = 255, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        }
    },
    gouv = {
        label = "Gouvernement",
        label2 = "Gouvernement",
        iban = "gouvernement",
        grade = {
            {
                label = "Agent USDSS",
                salary = 230,
                name = "agent",
                show = true
            },
            {
                label = "Directeur USDSS",
                salary = 330,
                name = "usdss",
                show = true
            },
            {
                label = "Procureur",
                salary = 350,
                name = "proc",
                show = true
            },
            {
                label = "Chef de cabinet",
                salary = 380,
                name = "drh",
                show = true
            },
            {
                label = "Gouverneur",
                salary = 530,
                name = "boss",
                show = true
            }
        },
        CustomMenu = true,
        Menu = {
            menu = {
                title = "Gouvernement",
                subtitle = "Actions disponibles",
                name = "Gouvernement_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("gouvernement")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Gouvernement", "Annonce", text, "CHAR_GOUV", 8, "Gouvernement")
                        end
                    end
                }
            }
        },
        Storage = {
            {
                Pos = {x = -574.84, y = -198.57, z = 41.70},
                Limit = 200,
                Name = "coffre_gouvernement"
            },
            {
                Pos = {x = -539.94, y = -176.78, z = 41.70},
                Limit = 200,
                Name = "coffre_gouvernement"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = -572.24, y = -202.69, z = 42.70},
                Tenues = {
                    ["Classe A Agent"] = {
                        male = {
                            ["tshirt_1"] = 11,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 5,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 5,
                            ["pants_1"] = 11,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 11,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 39,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ['bags_1'] = 69,
                            ['bags_2'] = 0
                        },
                        female = {
                            ["tshirt_1"] = 38,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 7,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 6,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 0,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 22,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ['bags_1'] = 66,
                            ['bags_2'] = 0
                        }
                    },
                    ["Classe A Superviseur"] = {
                        male = {
                            ["tshirt_1"] = 11,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 5,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 5,
                            ["pants_1"] = 11,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 11,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 39,
                            ["chain_2"] = 06,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ['bags_1'] = 69,
                            ['bags_2'] = 0
                        },
                        female = {
                            ["tshirt_1"] = 38,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 7,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 6,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 0,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 22,
                            ["chain_2"] = 06,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ['bags_1'] = 66,
                            ['bags_2'] = 0
                        }
                    },
                    ["Classe A Directeur"] = {
                        male = {
                            ["tshirt_1"] = 11,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 5,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 5,
                            ["pants_1"] = 11,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 11,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 39,
                            ["chain_2"] = 15,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ['bags_1'] = 69,
                            ['bags_2'] = 0
                        },
                        female = {
                            ["tshirt_1"] = 38,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 7,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 6,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 0,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 22,
                            ["chain_2"] = 15,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ['bags_1'] = 66,
                            ['bags_2'] = 0
                        }
                    }
                }
            }
        },
        garage = {
            Name = "Garage gouvernement",
            Pos = {x = -549.45, y = -158.33, z = 38.25},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {
                    {}
                },
                spawnpos = {x = -558.6, y = -162.17, z = 38.16, h = 292.43}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage Gouvernement"
            }
        },
        garage2 = {
            Name = "Garage saisies",
            Pos = {x = -575.95, y = -148.92, z = 37.02},
            Properties = {
                type = 3,
                Limit = 128,
                vehicles = {
                    {}
                },
                spawnpos = {x = -575.95, y = -148.92, z = 37.0, h = 197.80}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage Gouvernement Saisies"
            }
        }

    },
    doj = {
        label = "Departement de la justice",
        label2 = "Departement de la justice",
        iban = "doj",
        grade = {
            {
                label = "Agent de Sécurité",
                salary = 230,
                name = "agent",
                show = true
            },
            {
                label = "IRS",
                salary = 250,
                name = "irs",
                show = true
            },
            {
                label = "avocat",
                salary = 250,
                name = "avocat",
                show = true
            },
            {
                label = "procureur",
                salary = 350,
                name = "avocat",
                show = true
            },
            {
                label = "Juge",
                salary = 400,
                name = "boss",
                show = true
            }
        },
        CustomMenu = true,
        Menu = {
            menu = {
                title = "Departement de la justice",
                subtitle = "Actions disponibles",
                name = "doj_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("doj")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                }
            }
        },
        Storage = {
            {
                Pos = {x = -528.69, y = -192.78, z = 37.21},
                Limit = 200,
                Name = "coffre_avocat"
            },
            {
                Pos = {x = -517.31, y = -172.85, z = 37.21},
                Limit = 200,
                Name = "coffre_juge"
            },
            {
                Pos = {x = -512.66, y = -181.99, z = 37.21},
                Limit = 200,
                Name = "coffre_juge_sup"
            },
            {
                Pos = {x = -574.15, y = -198.90, z = 41.70},
                Limit = 200,
                Name = "coffre_irs"
            }
        },
        garage = {
            Name = "Garage DOJ",
            Pos = {x = -569.09, y = -149.74, z = 37.02},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {
                    {}
                },
                spawnpos = {x = -569.01, y = -149.74, z = 37.02, h = 209.11}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage DOJ"
            }
        }

    },
    -- psychologue = {
    --     label = "Psychologue",
    --     label2 = "Psychologue",
    --     iban = "psychologue",
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 150,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "CDI",
    --             salary = 160,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 170,
    --             name = "chef",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 180,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 200,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     -- Storage = {
    --     --     {
    --     --         Pos = {x = -1904.99, y = -570.9, z = 18.1},
    --     --         Limit = 200,
    --     --         Name = "coffre_psycho"
    --     --     }
    --     -- },
    --     -- garage = {
    --     --     Name = "Garage Psychologue",
    --     --     Pos = {x = -1010.35, y = 510.64, z = 78.57},
    --     --     Properties = {
    --     --         type = 3,
    --     --         Limit = 20,
    --     --         vehicles = {},
    --     --         spawnpos = {x = -1010.35, y = 510.64, z = 78.57, h = 189.36}
    --     --     },
    --     --     Blipdata = {
    --     --         Pos = {x = -1010.35, y = 510.64, z = 78.57},
    --     --         Blipcolor = 7,
    --     --         Blipname = "Garage Psychologue"
    --     --     }
    --     -- },
    --     Menu = {
    --         menu = {
    --             title = "Psychologue",
    --             subtitle = "Action",
    --             name = "psycho_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("psychologue")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                     local text = exports['Snoupinput']:GetInput()
    --                     if text ~= false and text ~= "" then
    --                         TriggerServerEvent("Job:Annonce", "Psychologue", "Annonce", text, "CHAR_PSYCHO", 8, "Psychologue")
    --                     end
    --                 end
    --             }
    --         }
    --     }
    -- },
    binco = {
        label = "Binco",
        label2 = "Binco",
        iban = "Binco",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = -823.16, y = -1069.61, z = 10.33},
                Limit = 200,
                Name = "coffre_binco"
            }
        },
        garage = {
            Name = "Garage Binco",
            Pos = {x = -826.17, y = -1063.7, z = 10.61},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -826.17, y = -1063.7, z = 10.61, h = 300.3}
            },
            Blipdata = {
                Pos = {x = -826.17, y = -1063.7, z = 10.61},
                Blipcolor = 7,
                Blipname = "Garage Binco"
            }
        },
        Menu = {
            menu = {
                title = "Binco",
                subtitle = "Action",
                name = "binco_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("binco")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "binco", "Annonce", text, "CHAR_BINCO", 8)
                        end
                    end
                },
                {
                    label = "Création tenue",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("binco", "main"), true)
                    end
                }
            }
        },
        extraPos = {
            Manequin = {
                Pos = {
                    {x = -168.4, y = -298.3, z = 39.79}
                }
            }
        }
    },
    binconord = {
        label = "Binco Nord",
        label2 = "Binco Nord",
        iban = "binconord",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 619.16, y = 2767.06, z = 42.09},
                Limit = 200,
                Name = "coffre_binco_nord"
            }
        },
        garage = {
            Name = "Garage Binco Nord",
            Pos = {x = 636.82, y = 2743.52, z = 40.98},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 636.82, y = 2743.52, z = 40.98, h = 198.14}
            },
            Blipdata = {
                Pos = {x = 636.82, y = 2743.52, z = 40.98},
                Blipcolor = 7,
                Blipname = "Garage Binco Nord"
            }
        },
        Menu = {
            menu = {
                title = "Suburban",
                subtitle = "Action",
                name = "bincoN_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("binconord")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Suburban", "Annonce", text, "CHAR_SUBURBAN", 8)
                        end
                    end
                },
                {
                    label = "Création tenue",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("bincoN", "main"), true)
                    end
                }
            }
        }
    },
    ponsonbys = {
        label = "Ponsonbys",
        label2 = "Ponsonbys",
        iban = "ponsonbys",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = -704.32, y = -159.78, z = 36.42},
                Limit = 200,
                Name = "coffre_ponsonbys"
            }
        },
        garage = {
            Name = "Garage Ponsonbys",
            Pos = {x = -699.41, y = -141.32, z = 36.68},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -699.41, y = -141.32, z = 36.68, h = 297.93}
            },
            Blipdata = {
                Pos = {x = -699.41, y = -141.32, z = 36.68},
                Blipcolor = 7,
                Blipname = "Garage Ponsonbys"
            }
        },
        Menu = {
            menu = {
                title = "Ponsonbys",
                subtitle = "Action",
                name = "ponsonbys_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("ponsonbys")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Ponsonbys", "Annonce", text, "CHAR_PONSONBYS", 8, "Ponsonbys")
                        end
                    end
                },
                {
                    label = "Création tenue",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("ponsonbys", "main"), true)
                    end
                }
            }
        },
        extraPos = {
            Manequin = {
                Pos = {
                    {x = -168.4, y = -298.3, z = 39.79}
                }
            }
        }
    },
    lsms = {
        label = "SAMS",
        label2 = "SAMS",
        iban = "lsms",
        grade = {
            {
                label = "Ambulancier",
                salary = 200,
                name = "ambulancier",
                show = true
            },
            {
                label = "Infirmier",
                salary = 220,
                name = "infirmier",
                show = true
            },
            {
                label = "Médecin",
                salary = 240,
                name = "medecin",
                show = true
            },
            {
                label = "Directeur adjoint",
                salary = 270,
                name = "drh",
                show = true
            },
            {
                label = "Directeur",
                salary = 330,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage SAMS Los Santos",
            Pos = {x = 325.63, y = -574.23, z = 28.79},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 325.63, y = -574.23, z = 28.79, h = 304.65}
            },
            Blipdata = {
                Pos = {x = 325.63, y = -574.23, z = 28.79},
                Blipcolor = 7,
                Blipname = "SAMS - Garage Los Santos"
            }
        },
        garage2 = {
            Name = "Garage SAMS Sandy Shores",
            Pos = {x = 1840.37, y = 3667.2, z = 32.68},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 1840.37, y = 3667.2, z = 32.68, h = 215.38}
            },
            Blipdata = {
                Pos = {x = 1840.37, y = 3667.2, z = 32.68},
                Blipcolor = 7,
                Blipname = "SAMS - Garage Sandy Shores"
            }
        },
        Storage = {
            -- SandyShore
            {
                Pos = {x = 1843.83, y = 3681, z = 33.27},
                Limit = 200,
                Name = "Coffre SAMS"
            },
            -- Los Santos
            {
                Pos = {x = 306.94, y = -601.6, z = 42.37},
                Limit = 200,
                Name = "Coffre SAMS"
            }
        },
        garage3 = {
            Name = "Helipad Hopital",
            Pos = {x = 350.97, y = -587.84, z = 74.16},
            Properties = {
                type = 2,
                Limit = 10,
                zonesize = 1.5,
                vehicles = {
                    {
                        name = "medevac",
                        label = "Helicoptere de secours",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = 350.97, y = -587.84, z = 74.16, h = 344.34}
            },
            Blipdata = {
                Pos = {x = 350.97, y = -587.84, z = 74.16},
                Blipcolor = 5,
                Blipname = "SAMS - Helipad Hopital"
            }
        },
        garage4 = {
            Name = "Bateau Hopital",
            Pos = {x = -800.45, y = -1514.03, z = 1.6},
            Properties = {
                type = 2,
                Limit = 10,
                zonesize = 5.0,
                vehicles = {
                    {
                        name = "dinghy",
                        label = "Bateau de secours",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = -795.98, y = -1515.0, z = 0.12, h = 112.53}
            },
            Blipdata = {
                Pos = {x = -800.45, y = -1514.03, z = 1.6},
                Blipcolor = 5,
                Blipname = "SAMS - Port Hopital"
            }
        },
        Menu = {
            menu = {
                title = "Ambulance",
                subtitle = "Actions disponibles",
                name = "ambulance_menuperso"
            },
            submenus = {
                ["Soins"] = {
                    submenu = "ambulance_menuperso",
                    title = "Soins",
                    menus = {
                        buttons = {
                            {
                                label = "Petite blessure",
                                onSelected = function()
                                    Ambulance.Heal(25)
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Blessure grave",
                                onSelected = function()
                                    Ambulance.Heal(200)
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Réanimation",
                                onSelected = function()
                                    Ambulance.Revive()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Mettre Doug en Service",
                                onSelected = function()
                                    Ambulance.AllowNpcAmbulance(true)
                                end
                            },
                            {
                                label = "Mettre Doug Hors Service",
                                onSelected = function()
                                    Ambulance.AllowNpcAmbulance(false)
                                end
                            }
                        }
                    }
                },
                ["Actions véhicule"] = {
                    submenu = "ambulance_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Mettre dans le véhicule",
                                onSelected = function()
                                    Police.PutInVeh()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Sortir du véhicule",
                                onSelected = function()
                                    Police.SortirVeh()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            }
                        }
                    }
                },
                ["Actions brancard"] = {
                    submenu = "ambulance_menuperso",
                    title = "Actions brancard",
                    menus = {
                        buttons = {
                            {
                                label = "Sortir le brancard de l'ambulance",
                                onSelected = function()
                                    Ambulance.GetOffStretcher()
                                end,
                                ActiveFct = function()
                                    Ambulance.DrawMarkerVehicle()
                                end
                            },
                            {
                                label = "Mettre le brancard dans l'ambulance",
                                onSelected = function()
                                    Ambulance.PutStretcherOnVehicle()
                                end,
                                ActiveFct = function()
                                    Ambulance.DrawMarkerVehicle()
                                end
                            },
                            {
                                label = "Prendre/Déposer le brancard",
                                onSelected = function()
                                    Ambulance.PickPutStretcher()
                                end,
                                ActiveFct = function()
                                    if not pickStretcher then
                                        Ambulance.DrawMarkerStretcher(true)
                                    end
                                end
                            },
                            {
                                label = "Mettre/Descendre la personne du brancard",
                                onSelected = function()
                                    Ambulance.PutOnStretcher()
                                end,
                                ActiveFct = function()
                                    Ambulance.DrawMarkerStretcher(false)
                                    Ambulance.DrawMarkerOnPed()
                                end
                            },
                            {
                                label = "Ranger le brancard",
                                onSelected = function()
                                    Ambulance.RemoveStretcher()
                                end,
                                ActiveFct = function()
                                    Ambulance.DrawMarkerStretcher(true)
                                end
                            }
                        }
                    }
                }
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("gouvernement")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Test stupéfiant",
                    onSelected = function()
                        Police.Stup()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Retirer un tatouage",
                    onSelected = function()
                        Ambulance.Tattoo()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Informations effectifs",
                    onSelected = function()
                        TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "lsms")
                    end
                },
                {
                    label = "Appliquer des ATA",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Nombre d'ATA (en heures entre 1 et 10)", 20, "number")
                        local number = exports['Snoupinput']:GetInput()
                        local playerID = GetPlayerServerIdInDirection(5.0)
                        if number ~= false and number ~= "" and math.tointeger(number) > 0 and math.tointeger(number) <= 10 and playerID ~= false then
                            local targetName = Ora.Identity:GetFullname(playerID)
                            TriggerServerEvent("Ora:PlayerClass:RemoveStrength", playerID, math.tointeger(number))
                            TriggerServerEvent("Ora:sendToDiscord", 5, string.format('A appliqué %s ATA à %s', math.tointeger(number), targetName), "info")
                            RageUI.Popup({message = string.format('~g~Vous avez appliqué ~y~%s~g~ ATA à ~y~%s~g~', math.tointeger(number), targetName)})
                        end
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "SAMS", "Annonce", text, "CHAR_CALL911", 8, "SAMS")
                        end
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = 298.79, y = -598.68, z = 42.28},
                Tenues = {
                    ["Tenue de service manches courtes"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 74,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 92,
                            ["pants_1"] = 35,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 30,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 106,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue de service manches longues"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 75,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 94,
                            ["pants_1"] = 35,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 30,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 99,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue ambulancier manches courtes"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 74,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 92,
                            ["pants_1"] = 35,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 30,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 106,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue ambulancier manches longues"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 75,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 94,
                            ["pants_1"] = 35,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 30,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 99,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue de service chirurgien"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 86,
                            ["torso_2"] = 3,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 92,
                            ["pants_1"] = 27,
                            ["pants_2"] = 7,
                            ["shoes_1"] = 7,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 30,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 9,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    }
                }
            }
        }
    },

    lsfd = {
        label = "LSFD",
        label2 = "LSFD",
        iban = "lsfd",
        grade = {
            {
                label = "volontaire",
                salary = 0,
                name = "recrue",
                show = true
            },
            {
                label = "recrue",
                salary = 200,
                name = "recrue",
                show = true
            },
            {
                label = "Ambulancier",
                salary = 220,
                name = "ambulancier",
                show = true
            },
            {
                label = "Pompier",
                salary = 240,
                name = "pompier",
                show = true
            },
            {
                label = "lieutenant",
                salary = 270,
                name = "lieutenant",
                show = true
            },
            {
                label = "Capitaine",
                salary = 300,
                name = "drh",
                show = true
            },
            {
                label = "Chef",
                salary = 330,
                name = "boss",
                show = true
            }
        },
        garage2 = {
            Name = "Garage LSFD 1",
            Pos = {x = 1208.38, y = -1504.45, z = 34.69 - 0.98},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 1208.38, y = -1504.45, z = 34.69 - 0.98, h = 98.28}
            },
            Blipdata = {
                Pos = {x = 1208.38, y = -1504.45, z = 34.69 - 0.98},
                Blipcolor = 7,
                Blipname = "LSFD - Garage 1"
            }
        },
        Storage = {
            -- Garage
            {
                Pos = {x = 1211.65, y = -1487.35, z = 34.69 - 0.90},
                Limit = 9999,
                Name = "Coffre LSFD"
            }
        },
        garage4 = {
            Name = "Bateau LSFD",
            Pos = {x = -806.34, y = -1497.43, z = 1.59},
            Properties = {
                type = 2,
                Limit = 10,
                zonesize = 5.0,
                vehicles = {
                    {
                        name = "dinghy",
                        label = "Bateau de secours",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = -806.28, y = -1500.85, z = 0.12, h = 112.53}
            },
            Blipdata = {
                Pos = {x = -806.34, y = -1497.43, z = 1.59},
                Blipcolor = 5,
                Blipname = "LSFD - Port"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = 1226.83, y = -1490.88, z = 34.69 - 0.98},
                Tenues = {
                    ["EMT manches courtes"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 74,
                            ["torso_2"] = 3,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 92,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 106,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["EMT manches longues"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 75,
                            ["torso_2"] = 3,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 86,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 99,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Service Tshirt"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 73,
                            ["torso_2"] = 9,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 0,
                            ["pants_1"] = 120,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 99,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue lsfd"] = {
                        male = {
                            ["tshirt_1"] = 0,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 314,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 166,
                            ["pants_1"] = 120,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 45,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 9,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue lsfd Cpt"] = {
                        male = {
                            ["tshirt_1"] = 0,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 314,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 166,
                            ["pants_1"] = 120,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 45,
                            ["helmet_2"] = 1,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 9,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue lsfd Chef"] = {
                        male = {
                            ["tshirt_1"] = 0,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 314,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 166,
                            ["pants_1"] = 120,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 45,
                            ["helmet_2"] = 2,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 9,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue feu"] = {
                        male = {
                            ["tshirt_1"] = 151,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 314,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 166,
                            ["pants_1"] = 120,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 45,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 9,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue feu Cpt"] = {
                        male = {
                            ["tshirt_1"] = 151,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 314,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 166,
                            ["pants_1"] = 120,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 45,
                            ["helmet_2"] = 1,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 9,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue feu Chef"] = {
                        male = {
                            ["tshirt_1"] = 151,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 314,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 166,
                            ["pants_1"] = 120,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 45,
                            ["helmet_2"] = 2,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 9,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue chef"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 75,
                            ["torso_2"] = 1,
                            ["decals_1"] = 78,
                            ["decals_2"] = 0,
                            ["arms"] = 12,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 99,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Tenue cpt"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 75,
                            ["torso_2"] = 1,
                            ["decals_1"] = 44,
                            ["decals_2"] = 0,
                            ["arms"] = 12,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 82,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 99,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Chef Cérémonie"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 118,
                            ["torso_2"] = 1,
                            ["decals_1"] = 78,
                            ["decals_2"] = 0,
                            ["arms"] = 12,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 10,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 99,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Cpt Cérémonie"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 118,
                            ["torso_2"] = 0,
                            ["decals_1"] = 45,
                            ["decals_2"] = 0,
                            ["arms"] = 12,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 10,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 99,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["lsfd Cérémonie"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 118,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 12,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 10,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 99,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 96,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                }
            }
        }
    },

    bennys = {
        label = "Benny's",
        label2 = "Benny's",
        iban = "bennys",
        isMechanics = true,
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Benny's",
            Pos = {x = -187.55, y = -1272.58, z = 30.19},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -187.55, y = -1272.58, z = 30.19, h = 184.8}
            },
            Blipdata = {
                Pos = {x = -187.55, y = -1272.58, z = 30.19},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Menu = {
            menu = {
                title = "Benny's",
                subtitle = "Actions disponibles",
                name = "bennys_menuperso"
            },
            submenus = {
                ["Actions véhicule"] = {
                    submenu = "bennys_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Inspecter l'état du véhicule",
                                onSelected = function()
                                    Mecano.CheckVehicle()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Ouvrir le capot",
                                onSelected = function()
                                    Mecano.OpenTrunk()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Réparer",
                                onSelected = function()
                                    Mecano.Repair()
                                    RageUI.CloseAll()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Nettoyer",
                                onSelected = function()
                                    Mecano.CleanVehicule()
                                    RageUI.CloseAll()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Mettre/Retirer le véhicule du plateau",
                                onSelected = function()
                                    Mecano.PutPlateau()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Mise en fourière",
                                onSelected = function()
                                    Mecano.Fouriere()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            }
                        },
                        submenus = {}
                    }
                }
            },
            buttons = {
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Benny's", "Annonce", text, "CHAR_BENNYS", 8, "Benny's")
                        end
                    end
                },
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("bennys")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
        Extrapos = {
            Tow = {
                Pos = {
                    {x = -162.45, y = -1304.8, z = 30.31}
                },
                Enter = EnterZoneTow,
                Exit = ExitZoneTow,
                zonesize = 5.5,
                Blips = {
                    sprite = 473,
                    color = 81,
                    name = "Fourrière"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            },
            LSCustoms = {
                Pos = {
                    {x = -182.26, y = -1320.08, z = 31.3},
                    {x = -233.87, y = -1317.19, z = 30.9},
                    {x = -237.23, y = -1337.12, z = 30.9},
                    {x = -234.21, y = -1315.72, z = 18.47},
                    {x = -218.19, y = -1312.3, z = 18.47}
                },
                Enter = function()
                    EnterZoneLSC_BENNYS()
                end,
                Exit = function()
                    ExitZoneLSC_BENNYS()
                end,
                zonesize = 3.5,
                Blips = {},
                Marker = {
                    type = 1,
                    scale = {x = 4.5, y = 4.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = false
                }
            }
        },
        Storage = {
            {
                Pos = {x = -196.01, y = -1340.04, z = 33.9},
                Limit = 100,
                Name = "coffre_bennys"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = -212.92, y = -1331.96, z = 22.14},
                Tenues = {
                    ["Tenue de services"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 65,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 17,
                            ["pants_1"] = 38,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 0,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 14,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 59,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 18,
                            ["pants_1"] = 38,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 0,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    }
                }
            }
        }
    },
    mecano = {
        label = "Mécano Sud",
        label2 = "Mécano Sud",
        iban = "mecano",
        isMechanics = true,
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Mécano",
            Pos = {x = -364.68, y = -147.09, z = 37.25},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -364.68, y = -147.09, z = 37.25, h = 112.37}
            },
            Blipdata = {
                Pos = {x = -364.68, y = -147.09, z = 37.25},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Menu = {
            menu = {
                title = "Mécano",
                subtitle = "Actions disponibles",
                name = "mecano_menuperso"
            },
            submenus = {
                ["Actions véhicule"] = {
                    submenu = "mecano_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Inspecter l'état du véhicule",
                                onSelected = function()
                                    Mecano.CheckVehicle()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Ouvrir le capot",
                                onSelected = function()
                                    Mecano.OpenTrunk()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Réparer",
                                onSelected = function()
                                    Mecano.Repair()
                                    RageUI.CloseAll()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Nettoyer",
                                onSelected = function()
                                    Mecano.CleanVehicule()
                                    RageUI.CloseAll()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Mettre/Retirer le véhicule du plateau",
                                onSelected = function()
                                    Mecano.PutPlateau()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Mise en fourière",
                                onSelected = function()
                                    Mecano.Fouriere()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            }
                        },
                        submenus = {}
                    }
                }
            },
            buttons = {
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "LS Custom", "Annonce", text, "CHAR_LSCUSTOM", 8, "Mécano Sud")
                        end
                    end
                },
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("mecano")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
        Extrapos = {
            Tow = {
                Pos = {
                    {x = -376.76, y = -105.69, z = 37.7}
                },
                Enter = EnterZoneTow,
                Exit = ExitZoneTow,
                zonesize = 5.5,
                Blips = {
                    sprite = 473,
                    color = 81,
                    name = "Fourrière"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            },
            LSCustoms = {
                Pos = {
                    {x = -323.22, y = -132.31, z = 37.96},
                    {x = -320.78, y = -126.07, z = 37.97},
                    {x = -318.71, y = -120.1, z = 38.01},
                    {x = -394.47, y = -135.08, z = 37.53}
                },
                Enter = function()
                    EnterZoneLSC()
                end,
                Exit = function()
                    ExitZoneLSC()
                end,
                zonesize = 3.5,
                Blips = {},
                Marker = {
                    type = 1,
                    scale = {x = 4.5, y = 4.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = false
                }
            }
        },
        Storage = {
            {
                Pos = {x = -311.08, y = -136.7, z = 38.01},
                Limit = 100,
                Name = "coffre_mecano"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = -312.64, y = -130.54, z = 38.01},
                Tenues = {
                    ["Tenue de services"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 65,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 17,
                            ["pants_1"] = 38,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 0,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 14,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 59,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 18,
                            ["pants_1"] = 38,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 0,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    }
                }
            }
        }
    },
    uber = {
        label = "Uber",
        label2 = "Uber",
        iban = "uber",
        isSelf = true,
        grade = {
            {
                label = "Auto-entrepreneur",
                salary = 200,
                name = "cdd",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Uber",
                subtitle = "Action",
                name = "Uber_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("uber")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "LS Custom", "Annonce", text, "CHAR_LSCUSTOM", 8, "Mécano Sud")
                        end
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
    },
    -- soinsnaturels = {
    --     label = "Soins Naturels",
    --     label2 = "soins naturels",
    --     iban = "soinsnaturels",
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 0,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "CDI",
    --             salary = 0,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 0,
    --             name = "chef",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 0,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 0,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "Soins Naturels Gaël",
    --             subtitle = "Action",
    --             name = "Sng_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("sngael")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             }
    --         }
    --     },
    -- },
    -- ltd = {
    --     label = "🍕 Épicier",
    --     label2 = "Épicier",
    --     grade = {
    --         {
    --             label = "Employé",
    --             salary = 20,
    --             name = "employe",
    --             show = true
    --         },
    --         {
    --             label = "Trésorier",
    --             salary = 20,
    --             name = "tresorier",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 20,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 20,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     garage = {
    --         Name = "Garage épicier",
    --         Pos =  {x = -40.92,  y = -1747.97,  z =29.33},
    --         Properties = {
    --             type = 2,-- = garage self service
    --             Limit = 10,
    --             vehicles = {
    --                 -- {name="bison",label="Voiture de service",job=true,tuning = {
    --                 --     modXenon = true
    --                 -- }},
    --             },
    --             spawnpos = {x = -38.99,  y = -1745.07,  z =29.33,h=224.97},

    --         },
    --         Blipdata = {
    --             Pos = {x = -40.92,  y = -1747.97,  z =29.33},
    --             Blipcolor  =7,
    --             Blipname = "Garage"
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "LTD",
    --             subtitle = "Actions disponibles",
    --             name = "LTD_menuperso"
    --         },

    --         buttons = {
    --             {label="Facture",onSelected=function() CreateFacture("ltd") end,ActiveFct=function() HoverPlayer() end},
    --         },
    --     },
    --     Storage = {
    --         {
    --             Pos = {x=-43.38,y=-1748.37,z=29.42},
    --             Limit = 100,
    --             Name = "coffre"
    --         },
    --     },
    --     work = {

    --         traitement = {
    --             type = "traitement",
    --             workSize = 10.45,
    --             blipcolor =51,
    --             blipname = "Déballage batteries",
    --             Pos = {x=2919.98,y=4298.13,z=50.91},
    --             required = "batterypack",
    --             giveitem = "battery",
    --             add = "~b~+ 1  Batterie"
    --         },
    --         traitement2 = {
    --             type = "traitement",
    --             workSize = 10.45,
    --             blipcolor =51,
    --             blipname = "Déballage téléphones",
    --             Pos = {x=2919.98,y=4298.13,z=50.91},
    --             required = "telpack",
    --             giveitem = "tel",
    --             add = "~o~+ 1  Téléphone"
    --         },
    --     }
    -- },

    concess = {
        label = "Concessionnaire",
        label2 = "Concessionnaire",
        iban = "concess",
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Concessionnaire",
                subtitle = "Actions disponibles",
                name = "Concessionnaire_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("concess")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Listes des ventes",
                    onSelected = function()
                        ListesVentes()
                    end
                },
                {
                    label = "Rendre véhicule de test",
                    onSelected = function()
                        local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
                        local plate = GetVehicleNumberPlateText(veh)
                        print(veh)
                        print(plate)
                        if plate == "CONCESS " then
                            DeleteEntity(veh)
                        else
                            ShowNotification("~r~Ce véhicule n'appartient pas à la concession.")
                        end
                    end
                },
                {
                    label = "Rentrer véhicule",
                    onSelected = function()
                        RentrerVeh()
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Créer une clé",
                    onSelected = function()
                        Clef()
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Créer une carte grise",
                    onSelected = function()
                        CarteGrise()
                    end
                },
                {
                    label = "Changer un propriétaire de véhicule - Joueur",
                    onSelected = function()
                        CGNvxProprioPlyr()
                    end
                },
                {
                    label = "Changer un propriétaire de véhicule - Entreprise",
                    onSelected = function()
                        CGNvxProprioJob()
                    end
                },
                {
                    label = "Mettre/Retirer le véhicule du plateau",
                    onSelected = function()
                        Mecano.PutPlateau()
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Retourner le véhicule",
                    onSelected = function()
                        SetVehicleOnGroundProperly(GetVehicleInDirection(5.0))
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "PDM", "Annonce", text, "CHAR_BIKESITE", 8, "Concessionnaire")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage Concessionnaire",
            Pos = {x = -10.42692, y = -1095.666, z = 25.7030},
            illimity = true,
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -10.42692, y = -1095.666, z = 25.7030, h = 68.3758926}
            },
            Blipdata = {
                Pos = {x = -16.07, y = -1103.06, z = 26.67},
                Blipcolor = 5,
                Blipname = "Garage Concessionnaire"
            }
        },
        Storage = {
            {
                Pos = {x = -24.5188, y = -1104.5971, z = 26.2743},
                Limit = 100,
                Name = "coffre PDM"
            }
        }
    },
    bikershop = {
        label = "Concessionnaire Moto",
        label2 = "Concessionnaire Moto",
        iban = "bikershop",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Concessionnaire Moto",
                subtitle = "Actions disponibles",
                name = "Concessionnaire_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("bikershop")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Listes des ventes",
                    onSelected = function()
                        ListesVentesmoto()
                    end
                },
                {
                    label = "Rentrer véhicule",
                    onSelected = function()
                        RentrerVeh()
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Créer une clé",
                    onSelected = function()
                        Clef()
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Créer une carte grise",
                    onSelected = function()
                        CarteGrise()
                    end
                },
                {
                    label = "Changer un propriétaire de véhicule - Joueur",
                    onSelected = function()
                        CGNvxProprioPlyr()
                    end
                },
                {
                    label = "Changer un propriétaire de véhicule - Entreprise",
                    onSelected = function()
                        CGNvxProprioJob()
                    end
                },
                {
                    label = "Mettre/Retirer le véhicule du plateau",
                    onSelected = function()
                        Mecano.PutPlateau()
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Retourner le véhicule",
                    onSelected = function()
                        SetVehicleOnGroundProperly(GetVehicleInDirection(5.0))
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Concessionaire moto", "Annonce", text, "CHAR_BIKEDEALER", 8, "Concessionnaire Moto")
                        end
                    end
                }
            }
        },
        Storage = {
            {
                Pos = {x = 291.9, y = -1166.95, z = 28.24},
                Limit = 100,
                Name = "coffre bikershop"
            }
        },
        garage = {
            Name = "Garage Moto Shop",
            Pos = {x = 274.77, y = -1161.40, z = 28.24},
            Properties = {
                type = 3,
                -- = garage societe
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 1174.54, y = 2638.48, z = 36.76, h = 351.51}
            },
            Blipdata = {
                Pos = {x = -40.92, y = -1747.97, z = 29.33},
                Blipcolor = 7,
                Blipname = "Garage"
            }
        }
    },
    autoshop = {
        label = "Concessionnaire Nord",
        label2 = "Concessionnaire Nord",
        iban = "autoshop",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Concessionnaire",
                subtitle = "Actions disponibles",
                name = "Concessionnaire_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("autoshop")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Listes des ventes",
                    onSelected = function()
                        ListesVentesnord()
                    end
                },
                {
                    label = "Rentrer véhicule",
                    onSelected = function()
                        RentrerVeh()
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Créer une clé",
                    onSelected = function()
                        Clef()
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Créer une carte grise",
                    onSelected = function()
                        CarteGrise()
                    end
                },
                {
                    label = "Changer un propriétaire de véhicule - Joueur",
                    onSelected = function()
                        CGNvxProprioPlyr()
                    end
                },
                {
                    label = "Changer un propriétaire de véhicule - Entreprise",
                    onSelected = function()
                        CGNvxProprioJob()
                    end
                },
                {
                    label = "Mettre/Retirer le véhicule du plateau",
                    onSelected = function()
                        Mecano.PutPlateau()
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Retourner le véhicule",
                    onSelected = function()
                        SetVehicleOnGroundProperly(GetVehicleInDirection(5.0))
                    end,
                    ActiveFct = function()
                        Mecano.ShowMarker()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Helmut's", "Annonce", text, "CHAR_HELMUTS", 8, "Concessionnaire Nord")
                        end
                    end
                }
            }
        },
        Storage = {
            {
                Pos = {x = -234.456, y = 6216.920, z = 30.90},
                Limit = 100,
                Name = "coffre autoshop"
            }
        },
        garage = {
            Name = "Garage Autoshop",
            Pos = {x = -218.57, y = 6254.46, z = 31.48},
            illimity = true,
            Properties = {
                type = 3,
                -- = garage societe
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -230.939, y = 6223.483, z = 31.55, a = 243.75}
            },
            Blipdata = {
                Pos = {x = -230.939, y = 6223.483, z = 31.55},
                Blipcolor = 7,
                Blipname = "Garage"
            }
        }
    },
    hacker = {
        label = "Hackeur",
        label2 = "hackeur",
        grade = {
            {
                label = "Hackeur",
                salary = 0,
                name = "recrue"
            },
            {
                label = "Chef Hackeur",
                salary = 0,
                name = "boss"
            }
        },
        garage = {
            Name = "Garage Hackeur",
            Pos = {x = -594.419, y = 201.161, z = 70.80},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -595.064, y = 201.345, z = 71.00, h = 1.17}
            },
            Blipdata = {
                Pos = {x = -589.293, y = 197.247, z = 71.00},
                Blipcolor = 5,
                Blipname = "Garage Hackeur"
            }
        },
        Storage = {
            {
                Pos = {x = -578.955, y = 229.933, z = 73.80},
                Limit = 500,
                Name = "coffre hackeur"
            }
        }
    },
    casino = {
        label = "Casino",
        label2 = "Casino",
        iban = "casino",
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Casino",
            Pos = {x = 957.595, y = 13.845, z = 81.15},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 957.595, y = 13.845, z = 81.15, h = 335.39}
            },
            Blipdata = {
                Pos = {x = 957.595, y = 13.845, z = 81.15, h = 335.39},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = 964.304, y = 8.311, z = 71.83 - 0.94},
                Limit = 100,
                Name = "coffre_casino"
            }
        }
    },
    -- pegasus = {
    --     label = "Pegasus",
    --     label2 = "Pegasus",
    --     iban = "pegasus",
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 0,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "CDI",
    --             salary = 0,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 0,
    --             name = "chef",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 0,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 0,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     garage = {
    --         Name = "Garage Pegasus",
    --         Pos = {x = -1661.75, y = -3159.05, z = 13.99},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = -1661.75, y = -3159.05, z = 13.99, h = 329.37}
    --         },
    --         Blipdata = {
    --             Pos = {x = -1661.75, y = -3159.05, z = 13.99},
    --             Blipcolor = 5,
    --             Blipname = "Garage Pegasus"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -1631.18, y = -3163.04, z = 12.99},
    --             Limit = 500,
    --             Name = "coffre pegasus"
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "Pegasus",
    --             subtitle = "Actions disponibles",
    --             name = "pegasus_menuperso"
    --         },
    --         buttons = {
    --             {
    --             label = "Facture",
    --             onSelected = function()
    --                 CreateFacture("pegasus")
    --             end,
    --             ActiveFct = function()
    --                 HoverPlayer()
    --             end
    --             },
    --             {
    --             label = "Annonce",
    --             onSelected = function()
    --                 exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                 local text = exports['Snoupinput']:GetInput()
    --                 if text ~= false and text ~= "" then
    --                     TriggerServerEvent("Job:Annonce", "Pegasus", "Annonce", text, "CHAR_PEGASUS", 8, "Pegasus")
    --                 end
    --             end
    --             }
    --         }    
    --     }    
    -- },

    immo = {
        label = "Agent Immobilier",
        label2 = "Agent Immobilier",
        iban = "immo",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Immobilier",
            Pos = {x = -760.303405, y = 276.9277, z = 84.7320},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -760.303405, y = 276.9277, z = 84.7320, h = 7.31228637}
            },
            Blipdata = {
                Pos = {x = -760.303405, y = 276.9277, z = 84.7320},
                Blipcolor = 5,
                Blipname = "Garage Immobilier"
            }
        },
        Storage = {
            {
                Pos = {x = -717.8853, y = 260.5183105, z = 83.1377},
                Limit = 300,
                Name = "Coffre Immobilier"
            }
        }
    },
    unicorn = {
        label = "Unicorn",
        label2 = "Unicorn",
        iban = "unicorn",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Unicorn",
            Pos = {x = 162.71, y = -1281.98, z = 29.09},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 162.71, y = -1281.98, z = 29.09, h = 144.98}
            },
            Blipdata = {
                Pos = {x = 162.71, y = -1281.98, z = 29.09},
                Blipcolor = 5,
                Blipname = "Garage Unicorn"
            }
        },
        Storage = {
            {
                Pos = {x = 131.47, y = -1285.02, z = 28.27},
                Limit = 1000,
                Name = "Frigo Unicorn"
            },
            {
                Pos = {x = 93.21, y = -1291.99, z = 28.27},
                Limit = 100,
                Name = "Coffre Patron"
            }
        },
        Menu = {
            menu = {
                title = "Unicorn",
                subtitle = "Actions disponibles",
                name = "unicorn_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("unicorn")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Unicorn", "Annonce", text, "CHAR_MP_STRIPCLUB_PR", 8, "Unicorn")
                        end
                    end
                },
                {
                    label = "Faire travailler les danseuses",
                    onSelected = function()
                        local foodPeds = {
                            -- { model="s_f_y_stripper_02", x=112.68, y=-1288.3, z=28.46, a=238.85, animation="mini@strip_club@private_dance@idle", animationName="priv_dance_idle"},
                            -- { model="s_f_y_stripperlite", x=111.99, y=-1286.03, z=28.46, a=308.8, animation="mini@strip_club@lap_dance@ld_girl_a_song_a_p1", animationName="ld_girl_a_song_a_p1_f"},
                          --  { model="s_f_y_stripperlite", x=113.00, y=-1287.01, z=28.46, a=294.26, animation="mini@strip_club@pole_dance@pole_dance1", animationName="pd_dance_01"}
                            { model="csb_stripper_01", x=109.18, y=-1289.12, z=28.25, a=299.15, animation="mini@strip_club@private_dance@part2", animationName="priv_dance_p2"},
                            { model="s_f_y_stripper_01", x=103.21, y=-1292.59, z=29.26, a=296.21, animation="mini@strip_club@private_dance@part1", animationName="priv_dance_p1"},
                            { model="s_f_y_stripper_02", x=104.66, y=-1294.46, z=29.26, a=287.12, animation="mini@strip_club@lap_dance@ld_girl_a_song_a_p1", animationName="ld_girl_a_song_a_p1_f"},
                            { model="a_f_y_topless_01", x=102.26, y=-1289.92, z=29.26, a=292.05, animation="mini@strip_club@private_dance@idle", animationName="priv_dance_idle"},
                        }
                        local spawnedPeds = {}
                        TriggerServerCallback(
                            'strip:spawn',
                            function(spawned, peds)
                                if spawned then
                                    if peds then
                                        for k,v in pairs(peds) do
                                            local e = NetworkGetEntityFromNetworkId(v)
                                            if DoesEntityExist(e) then DeleteEntity(e) end
                                        end
                                    end
                                else
                                    for k,v in ipairs(foodPeds) do
                                        RequestModel(GetHashKey(v.model))
                                        while not HasModelLoaded(GetHashKey(v.model)) do
                                            Wait(0)
                                        end
                                        RequestAnimDict(v.animation)
                                        while not HasAnimDictLoaded(v.animation) do
                                            Wait(1)
                                        end
                                        local storePed = Ora.World.Ped:Create(5, v.model, vector3(v.x, v.y, v.z), v.a)
                                        SetBlockingOfNonTemporaryEvents(storePed, false)
                                        SetPedFleeAttributes(storePed, 0, 0)
                                        SetPedArmour(storePed, 100)
                                        SetPedMaxHealth(storePed, 100)
                                        SetPedDiesWhenInjured(storePed, false)
                                        SetAmbientVoiceName(storePed, v.voice)
                        
                                        TaskPlayAnim(storePed, v.animation, v.animationName, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                                        SetModelAsNoLongerNeeded(GetHashKey(v.model))
                                        table.insert(spawnedPeds, NetworkGetNetworkIdFromEntity(storePed))
                                    end
                                    TriggerServerEvent('strip:sendPeds', spawnedPeds)
                                end
                            end
                        )
                    end
                }
            }
        }
    },
    -- billards = {
    --     label = "8 Billards",
    --     label2 = "Billards",
    --     iban = "billards",
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 150,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "CDI",
    --             salary = 160,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 170,
    --             name = "chef",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 180,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 200,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     garage = {
    --         Name = "Garage 8 billards",
    --         Pos = {x = -1591.84, y = -1013.39, z = 12.02},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = -1591.84, y = -1013.39, z = 12.02, h = 123.53}
    --         },
    --         Blipdata = {
    --             Pos = {x = -1591.84, y = -1013.39, z = 12.02},
    --             Blipcolor = 5,
    --             Blipname = "Garage 8 billards"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -1586.14, y = -995.74, z = 12.08},
    --             Limit = 1000,
    --             Name = "Frigo 8 billards"
    --         },
    --         {
    --             Pos = {x = -1574.76, y = -982.47, z = 12.08},
    --             Limit = 100,
    --             Name = "Coffre Patron"
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "8 Billards",
    --             subtitle = "Actions disponibles",
    --             name = "billards_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facture",
    --                 onSelected = function()
    --                     CreateFacture("billards")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                     local text = exports['Snoupinput']:GetInput()
    --                     if text ~= false and text ~= "" then
    --                         TriggerServerEvent("Job:Annonce", "8 Billards", "Annonce", text, "CHAR_BILLARDS", 8, "8 Billards")
    --                     end
    --                 end
    --             }
    --         }
    --     }
    -- },
    bahamas = {
        label = "Bahamas",
        label2 = "Bahamas",
        iban = "bahamas",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Bahama's",
            Pos = {x = -1399.1, y = -644.22, z = 27.67},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -1399.1, y = -644.22, z = 27.67, h = 248.6}
            },
            Blipdata = {
                Pos = {x = -1399.1, y = -644.22, z = 27.67},
                Blipcolor = 5,
                Blipname = "Garage Bahama's"
            }
        },
        Storage = {
            {
                Pos = {x = -1385.48, y = -609.29, z = 29.32},
                Limit = 1000,
                Name = "Frigo Bahama's"
            },
            {
                Pos = {x = -1369.14, y = -624.43, z = 29.32},
                Limit = 100,
                Name = "Coffre Patron"
            }
        },
        Menu = {
            menu = {
                title = "Bahama's",
                subtitle = "Actions disponibles",
                name = "bahamas_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("bahamas")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Bahama's", "Annonce", text, "CHAR_BAHAMAS", 8, "Bahama's")
                        end
                    end
                }
            }
        }
    },
    tequilala = {
        label = "Tequi-La-La",
        label2 = "Tequi-La-La",
        iban = "tequilala",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Tequilala",
            Pos = {x = -563.89, y = 301.78, z = 82.14},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -563.89, y = 301.78, z = 82.14, h = 265.55}
            },
            Blipdata = {
                Pos = {x = -563.89, y = 301.78, z = 82.14},
                Blipcolor = 5,
                Blipname = "Garage Tequilala"
            }
        },
        Storage = {
            {
                Pos = {x = -562.10, y = 287.13, z = 81.17},
                Limit = 1000,
                Name = "Frigo Tequilala"
            },
            {
                Pos = {x = -573.45, y = 292.75, z = 78.17},
                Limit = 100,
                Name = "Coffre Boss Tequilala"
            }
        },
        Menu = {
            menu = {
                title = "Tequilala",
                subtitle = "Actions disponibles",
                name = "tequilala_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("tequilala")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Tequilala", "Annonce", text, "CHAR_TEQUILALA", 8, "Tequi-La-La")
                        end
                    end
                }
            }
        }
    },
    yellowjack = {
        label = "Yellow Jack",
        label2 = "Yellow Jack",
        iban = "yellowjack",
        grade = {
            {
                label = "CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 170,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 180,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Yellow Jack",
            Pos = {x = 1994.50, y = 3035.33, z = 47.02},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 1994.50, y = 3035.33, z = 47.02}
            },
            Blipdata = {
                Pos = {x = 1994.50, y = 3035.33, z = 47.02},
                Blipcolor = 5,
                Blipname = "Garage Yellow Jack"
            }
        },
        Storage = {
            {
                Pos = {x = 1985.31, y = 3048.90, z = 47.21},
                Limit = 1000,
                Name = "Frigo Yellow Jack"
            },
            {
                Pos = {x = 1982.46, y = 3053.32, z = 47.21},
                Limit = 100,
                Name = "Coffre Boss Yellow Jack"
            }
        },
        Menu = {
            menu = {
                title = "YellowJack",
                subtitle = "Actions disponibles",
                name = "yellowjack_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("yellowjack")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Yellow Jack", "Annonce", text, "CHAR_TEQUILALA", 8, "Yellow Jack")
                        end
                    end
                }
            }
        }
    },
    -- henhouse = {
    --     label = "The Hen House",
    --     label2 = "The Hen House",
    --     iban = "henhouse",
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 150,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "CDI",
    --             salary = 160,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 170,
    --             name = "chef",
    --             show = true
    --         },
    --         {
    --             label = "DRH",
    --             salary = 180,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 200,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     garage = {
    --         Name = "Garage The Hen House",
    --         Pos = {x = -313.14, y = 6275.55, z = 30.50},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = -313.14, y = 6275.55, z = 30.50, h = 140.74}
    --         },
    --         Blipdata = {
    --             Pos = {x = -313.14, y = 6275.55, z = 30.50},
    --             Blipcolor = 5,
    --             Blipname = "Garage The Hen House"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -294.92, y = 6264.51, z = 30.48},
    --             Limit = 800,
    --             Name = "Bar Hen House"
    --         },
    --         {
    --             Pos = {x = -300.56, y = 6272.43, z = 30.48},
    --             Limit = 800,
    --             Name = "frigo2 Hen House"
    --         },
    --         {
    --             Pos = {x = -292.31, y = 6265.57, z = 33.80},
    --             Limit = 100,
    --             Name = "Coffre Boss Hen House"
    --         }
    --     },
    --     requiredService = false,
    --     work = {
    --         traitement = {
    --             --Coktail
    --             type = "traitement",
    --             workSize = 1.20,
    --             blipcolor = 7,
    --             blipname = "cocktail",
    --             Pos = {x = -297.18, y = 6261.88, z = 31.48},
    --             required = {
    --                 {name = "vodka", count = 1},
    --                 {name = "milk", count = 3}
    --             },
    --             giveitem = "boissonhenhouse",
    --             RemoveItem = {
    --                 {name = "vodka", count = 1},
    --                 {name = "milk", count = 3}
    --             },
    --             add = "~p~+ 1  Coktail HenHouse"
    --         },
    --         traitement2 = {
    --             --Saucisse
    --             type = "traitement",
    --             workSize = 1.20,
    --             blipcolor = 7,
    --             blipname = "Traitement Saucisse",
    --             Pos = {x = -303.70, y = 6265.58, z = 31.48},
    --             required = "meat2",
    --             giveitem = "saucisse",
    --             RemoveItem = "chicken",
    --             add = "~p~+ 1  Saucisse fumée"
    --         },
    --         traitement3 = {
    --             --assiete de gibier
    --             type = "traitement",
    --             workSize = 1.20,
    --             blipcolor = 7,
    --             blipname = "cuisson",
    --             Pos = {x = -297.96, y = 6271.77, z = 31.48},
    --             required = "meat1",
    --             giveitem = "plathenhouse",
    --             RemoveItem = "meat1",
    --             add = "~p~+ 1  Assiete de Gibier"
    --         }
    --     },
    --     Menu = {
    --         menu = {
    --             title = "TheHenHouse",
    --             subtitle = "Actions disponibles",
    --             name = "henhouse_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facture",
    --                 onSelected = function()
    --                     CreateFacture("henhouse")
    --                 end,
    --                 ActiveFct = function()
    --                     HoverPlayer()
    --                 end
    --             },
    --             {
    --                 label = "Annonce",
    --                 onSelected = function()
    --                     exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
    --                     local text = exports['Snoupinput']:GetInput()
    --                     if text ~= false and text ~= "" then
    --                         TriggerServerEvent("Job:Annonce", "The Hen House", "Annonce", text, "CHAR_HENHOUSE", 8, "The Hen House")
    --                     end
    --                 end
    --             }
    --         }
    --     }
    -- },
    jetsam = {
        label = "Jetsam",
        label2 = "Jetsam",
        iban = "jetsam",
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Jetsam",
            Pos = {x = 814.74, y = -2941.26, z = 5.9},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 814.74, y = -2941.26, z = 5.9, h = 269.7}
            },
            Blipdata = {
                Pos = {x = 814.74, y = -2941.26, z = 5.9},
                Blipcolor = 5,
                Blipname = "Garage Jetsam"
            }
        },
        Storage = {
            {
                Pos = {x = 813.4, y = -2982.56, z = 6.02 - 0.9},
                Limit = 100,
                Name = "Coffre Jetsam"
            }
        }
    }
    -- drivingschool = {
    --     label = "Auto school",
    --     label2 = "Auto school",
    --     iban = "drivingschool",
    --     grade = {
    --         {
    --             label = "Moniteur",
    --             salary = 0,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Chef",
    --             salary = 0,
    --             name = "drh",
    --             show = true
    --         },
    --         {
    --             label = "PDG",
    --             salary = 0,
    --             name = "boss",
    --             show = true
    --         }
    --     },
    --     garage = {
    --         Name = "Garage Auto school",
    --         Pos = {x = 232.67, y = 385.44, z = 106.42},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = 232.67, y = 385.44, z = 106.42, h = 76.92}
    --         },
    --         Blipdata = {
    --             Pos = {x = 232.67, y = 385.44, z = 106.42},
    --             Blipcolor = 5,
    --             Blipname = "Garage Auto school"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = 813.4, y = -2982.56, z = 6.02 - 0.9},
    --             Limit = 100,
    --             Name = "Coffre Auto school"
    --         }
    --     }
    -- }
}