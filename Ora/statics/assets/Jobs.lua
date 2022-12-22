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
    autojap = {
        label = "Japonnais",
        label2 = "Japonnais",
        iban = "autojap",
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
                title = "Japonnais",
                subtitle = "Actions disponibles",
                name = "Concessionnaire_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("Japonnais")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Listes des ventes",
                    onSelected = function()
                        ListesVentesautojap()
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
            }
        },
        Storage = {
            {
                Pos = {x = 908.666, y = -1807.8575, z = 21.34},
                Limit = 100,
                Name = "coffre Japonnais"
            }
        },
        garage = {
            Name = "Garage Autojap",
            Pos = {x = 940.9163, y = -1808.4111, z = 20.03},
            illimity = true,
            Properties = {
                type = 3,
                -- = garage societe
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 940.9163, y = -1808.4111, z = 20.03, a = 243.75}
            },
            Blipdata = {
                Pos = {x = -940.9163, y = -1808.4111, z = 20.03},
                Blipcolor = 7,
                Blipname = "Garage"
            }
        }
    },
    mecano2 = {
        label = "Autorepairs",
        label2 = "Autorepairs",
        iban = "mecano2",
        isMechanics = true,
        grade = {
            {
                label = "CDD",
                salary = 120,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 140,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 160,
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
            Name = "Garage Harmony Repair",
            Pos = {x = 1203.5927, y = 2639.0180, z = 36.75},
            Properties = {
                type = 3,
                Limit = 20,
                zonesize = 1.0,
                vehicles = {},
                spawnpos = {x = 1203.5927, y = 2639.0180, z = 36.75, h = 310.49}
            },
            Blipdata = {
                Pos = {x = 1203.5927, y = 2639.0180, z = 36.75},
                Blipcolor = 5,
                Blipname = "Garage Harmony Repair"
            }
        },
        Menu = {
            menu = {
                title = "Harmony Repair",
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
                            TriggerServerEvent("Job:Annonce", "Auto Repairs", "Annonce", text, "CHAR_HARMONY", 8, "Autorepairs")
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
                    {x = 1174.4519, y = 2663.7224, z = 37.95}
                },
                Enter = EnterZoneTow,
                Exit = ExitZoneTow,
                zonesize = 1.5,
                Blips = {
                    sprite = 473,
                    color = 81,
                    name = "Fourrière Harmory Repair"
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
                    {x = 1175.2818, y = 2639.6523, z = 37.0559},
                    {x = 1182.6738, y = 2638.2207, z = 37.0559},
                    {x = 1164.0825, y = 2632.5297, z = 37.18}
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
                Marker = {
                    type = 23,
                    scale = {x = 4.5, y = 4.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        },
        Storage = {
            {
                Pos = {x = 1187.2065, y = 2636.0888, z = 37.40},
                Limit = 200,
                Name = "coffre_mecano2"
            },
            {
                Pos = {x = 1204.6300, y = 2647.87, z = 36.80},
                Limit = 200,
                Name = "coffre_mecano3"
            }
        }
    },
    grossiste = {
        label = "Post OP",
        label2 = "Post OP",
        iban = "grossiste",
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
                title = "Post OP",
                subtitle = "Actions disponibles",
                name = "grossiste_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("grossiste")
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
                            TriggerServerEvent("Job:Annonce", "Post OP", "Annonce", text, "CHAR_POSTOP", 8, "Post OP")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage Post OP",
            Pos = {x = 1222.9278, y = -3280.9433, z = 5.5155},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 1222.9278, y = -3280.9433, z = 5.5155, h = 179.85}
            },
            Blipdata = {
                Pos = {x = 1222.9278, y = -3280.9433, z = 5.5155, h = 179.85},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = 1211.4298, y = -3254.6970, z = 7.08 - 0.98},
                Limit = 200,
                Name = "coffre_grossiste"
            },
            {
                Pos = {x = 1188.7767, y = -3261.7687, z = 7.08 - 0.98},
                Limit = 2000,
                Name = "coffre_grossiste1"
            },
            {
                Pos = {x = 1187.2518, y = -3314.9147, z = 5.51 - 0.98},
                Limit = 2000,
                Name = "coffre_grossiste2"
            }
        },
        requiredService = false
    },
    coiffeur = {
        label = "Coiffeur",
        label2 = "Coiffeur",
        iban = "coiffeur",
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
                Pos = {x = 138.1916, y = -1703.6922, z = 28.2916},
                Limit = 100,
                Name = "coffre_coiffeur"
            }
        },
        garage = {
            Name = "Garage Coiffeursud",
            Pos = {x = 142.0619, y = -1692.8919, z = 29.2917},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {
                    {}
                },
                spawnpos = {x = 142.0619, y = -1692.8919, z = 29.2917, h = 26.32}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage - coiffeur"
            }
        },
        Menu = {
            menu = {
                title = "coiffeur",
                subtitle = "Action",
                name = "coiffeur_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("coiffeur")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Coiffure",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("haircuts", "main"), true)
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Coiffeur Sud", "Annonce", text, "CHAR_BARBER", 8, "Coiffeur")
                        end
                    end
                }
            }
        }
    },
    coiffeur2 = {
        label = "Coiffeur Hawick",
        label2 = "Coiffeur Hawick",
        iban = "coiffeur2",
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
                Pos = {x = -36.48, y = -155.96, z = 57.07 - 0.98},
                Limit = 100,
                Name = "coffre_coiffeur2"
            }
        },
        garage = {
            Name = "Garage Coiffeur",
            Pos = {x = -19.92, y = -139.68, z = 56.83 - 0.98},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {
                    {}
                },
                spawnpos = {x = -19.92, y = -139.68, z = 56.83 - 0.98, h = 337.18}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage - coiffeur"
            }
        },
        Menu = {
            menu = {
                title = "coiffeur",
                subtitle = "Action",
                name = "coiffeur_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("coiffeur2")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Coiffure",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("haircuts", "main"), true)
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Coiffeur Hawick", "Annonce", text, "CHAR_BARBER", 8, "Coiffeur Hawick")
                        end
                    end
                }
            }
        }
    },
    coiffeur3 = {
        label = "Coiffeur Miror",
        label2 = "Coiffeur Miror",
        iban = "coiffeur3",
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
                Pos = {x = 1215.9256, y = -475.6717, z = 66.20 - 0.98},
                Limit = 100,
                Name = "coffre_coiffeur3"
            }
        },
        garage = {
            Name = "Garage Coiffeurmiror",
            Pos = {x = 1225.0465, y = -433.5716, z = 67.53 - 0.98},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {
                    {}
                },
                spawnpos = {x = 1225.0465, y = -433.5716, z = 67.53 - 0.98, h = 337.18}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage - coiffeur"
            }
        },
        Menu = {
            menu = {
                title = "coiffeur",
                subtitle = "Action",
                name = "coiffeur_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("coiffeur3")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Coiffure",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("haircuts", "main"), true)
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Coiffeur Mirror park", "Annonce", text, "CHAR_BARBER", 8, "Coiffeur Miror")
                        end
                    end
                }
            }
        }
    },
    coiffeurnord = {
        label = "Coiffeur Nord",
        label2 = "Coiffeur Nord",
        iban = "coiffeurnord",
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
                Pos = {x = -276.76, y = 6224.07, z = 30.70},
                Limit = 100,
                Name = "coffre_coiffeur_nord"
            }
        },
        garage = {
            Name = "Garage Coiffeur Nord",
            Pos = {x = -243.98, y = 6237.29, z = 31.48},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {
                    {}
                },
                spawnpos = {x = -243.98, y = 6237.29, z = 31.48, h = 226.59}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage Coiffeur Nord"
            }
        },
        Menu = {
            menu = {
                title = "Coiffeur Nord",
                subtitle = "Action",
                name = "coiffeur_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("coiffeurnord")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Coiffure",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("haircuts", "main"), true)
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Coiffeur Nord", "Annonce", text, "CHAR_BARBER", 8, "Coiffeur Nord")
                        end
                    end
                }
            }
        }
    },
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
                Limit = 700,
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
                    {x = 813.088, y = -2155.940, z = 29.619}
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
                Pos = {x = -294.3665, y = 6198.5332, z = 31.5136},
                Limit = 500,
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
    tatoo3 = {
        label = "Tatoueur Plage",
        label2 = "Tatoueur Plage",
        iban = "tatoo3",
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
                Pos = {x = -1149.7503, y = -1428.5909, z = 3.95},
                Limit = 100,
                Name = "coffre_tatoo_plage"
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
                        CreateFacture("tatoo3")
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
                            TriggerServerEvent("Job:Annonce", "Tattoo Plage", "Annonce", text, "CHAR_TATTOO", 8, "Tatoueur Plage")
                        end
                    end
                }
            }
        }
    },
    tatoo4 = {
        label = "Tatoueur El burro",
        label2 = "Tatoueur El burro",
        iban = "tatoo4",
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
                Pos = {x = 1327.2299, y = -1654.8265, z = 51.27},
                Limit = 100,
                Name = "coffre_tatoo4"
            }
        },
        garage = {
            Name = "Garage Tatoueur",
            Pos = {x = 1316.29, y = -1665.51, z = 51.23},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 1316.29, y = -1665.51, z = 51.23, h = 221.53}
            },
            Blipdata = {
                Pos = {x = 1316.29, y = -1665.51, z = 51.23},
                Blipcolor = 5,
                Blipname = "Garage tatoueur"
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
                        CreateFacture("tatoo4")
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
                            TriggerServerEvent("Job:Annonce", "Tattoo elburro", "Annonce", text, "CHAR_MS18", 8, "Tatoueur El burro")
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
                salary = 120,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 140,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 160,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 170,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 190,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 2878.1599, y = 4488.7207, z = 47.25},
                Limit = 1000,
                Name = "coffre_fermier"
            },
            {
                Pos = {x = 2896.8911, y = 4480.5156, z = 47.2669},
                Limit = 1000,
                Name = "coffre_fermier1"
            },
            {
                Pos = {x = 2909.3869, y = 4467.7944, z = 47.1664},
                Limit = 1000,
                Name = "coffre_fermier2"
            }
        },
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 2567., y = 4446.8232, z = 38.3462},
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
                Pos = {x = 1854.73, y = 4826.85, z = 44.80},
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
                workSize = 6.0,
                Pos = {x = 2309.68, y = 4890.52, z = 41.80},
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
                workSize = 6.0,
                Pos = {x = 2099.47, y = 5007.82, z = 41.10},
                giveitem = "chicken",
                blipcolor = 7,
                blipname = "Fermier - Récupérer du Poulet",
                add = "~p~+ 1 Poulet",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte5 = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 1974.08, y = 4868.47, z = 45.45},
                giveitem = "salade",
                blipcolor = 7,
                blipname = "Fermier - Récupérer de la salade",
                add = "~p~+ 1 Salade",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            -- recolte6 = {
            --     type = "recolte",
            --     workSize = 10.0,
            --     Pos = {x = 2163.14, y = 5179.13, z = 56.82},
            --     giveitem = "levure",
            --     blipcolor = 7,
            --     blipname = "Fermier - Récupérer de la levure",
            --     add = "~p~+ 1 Levure",
            --     anim = {
            --         lib = "anim@mp_snowball",
            --         anim = "pickup_snowball"
            --     }
            -- },
            recolte7 = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 1935.30, y = 5044.97, z = 43.52},
                giveitem = "tomate",
                blipcolor = 7,
                blipname = "Fermier - Récupérer de la Tomate",
                add = "~p~+ 1 Tomate",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte8 = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 2128.30, y = 4979.23, z = 41.31},
                giveitem = "meat6",
                blipcolor = 7,
                blipname = "Fermier - Récupérer de la viande de porc",
                add = "~p~+ 1 Viande de porc",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte9 = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 2319.59, y = 4926.21, z = 41.42},
                giveitem = "meat7",
                blipcolor = 7,
                blipname = "Fermier - Récupérer de la viande de boeuf",
                add = "~p~+ 1 Viande de boeuf",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            recolte9 = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 1822.59, y = 5017.86, z = 57.54},
                giveitem = "fraise",
                blipcolor = 7,
                blipname = "Fermier - Récupérer des fraises",
                add = "~p~+ 1 Fraise",
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
                Pos = {x = 2034.79, y = 4981.47, z = 41.09},
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
            traitement3 = {
                type = "traitement",
                workSize = 7.45,
                blipcolor =7,
                blipname = "Traitement de la farine",
                Pos =  {x=2680.62,y=3508.35,z=53.3},
                required = "farine",
                giveitem = {
                    {name = "bread", count = 2},
                },
                add = "~p~+ 2  Pain"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Fermier - Vente",
                Pos = {x = 1656.78, y = 4874.64, z = 42.04},
                required = "farine",
                price = math.random(18, 25),
                add = "~p~- 1 Sac de farine"
            }
        },
        garage = {
            Name = "Garage Ferme",
            Pos = {x = 2891.3745, y = 4468.7949, z = 48.1319},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 2891.3745, y = 4468.7949, z = 48.1319, h = 221.53}
            },
            Blipdata = {
                Pos = {x = 2891.3745, y = 4468.7949, z = 48.1319},
                Blipcolor = 5,
                Blipname = "Garage Ferme"
            }
        },
        garage2 = {
            Name = "Garage employés Ferme",
            Pos = {x = 2930.9077, y = 4312.9755, z = 50.7443},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 2930.9077, y = 4312.9755, z = 50.7443, h = 221.53}
            },
            Blipdata = {
                Pos = {x = 2930.9077, y = 4312.9755, z = 50.7443},
                Blipcolor = 5,
                Blipname = "Garage employés"
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
                            TriggerServerEvent("Job:Annonce", "Union Farm", "Annonce", text, "CHAR_FERME", 8, "Fermier")
                        end
                    end
                }
            }
        }
    },
    pearls = {
        label = "Pearls",
        label2 = "Pearls",
        iban = "pearls",
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
                title = "Pearls",
                subtitle = "Actions disponibles",
                name = "pearls_menuperso"
            },
            buttons = {
                -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("pearls")
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
                            TriggerServerEvent("Job:Annonce", "Pearls", "Annonce", text, "CHAR_PEARLS", 8, "Pearls")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage Pearls",
            Pos = {x = -1798.1511, y = -1177.2968, z = 12.31},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -1798.1511, y = -1177.2968, z = 12.31, h = 318.24}
            },
            Blipdata = {
                Pos = {x = -1798.1511, y = -1177.2968, z = 12.31, h = 318.24},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = -1836.73, y = -1176.40, z = 18.20},
                Limit = 500,
                Name = "coffre_pearls_bureau"
            },
            {
                Pos = {x = -1839.74, y = -1189.69, z = 13.32},
                Limit = 1000,
                Name = "coffre_caveresto2"
            },
            {
                Pos = {x = -1838.21, y = -1183.83, z = 13.50},
                Limit = 1000,
                Name = "coffre_caveresto1"
            },
            {
                Pos = {x = -1840.72, y = -1183.35, z = 18.20},
                Limit = 1000,
                Name = "coffre_pearls_club"
            }

        },
        Extrapos = {
            CraftSpiritueux = {
                Pos = {
                    {x = -1842.6386, y = -1186.4794, z = 14.32 - 0.98}
                },
                restricted = {1, 2, 3, 4, 5},
                Enter = function()
                    EntercraftpearlsZone()
                end,
                Exit = function()
                    ExitcraftpearlsZone()
                end,
                zonesize = 3.5,
                Blips = {
                    sprite = 93,
                    color = 81,
                    name = "Pearls - Alambique"
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
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 803.1325, y = 2175.2553, z = 53.0708 - 0.98},
                giveitem = "graincafe1",
                blipcolor = 7,
                blipname = "Pearl's - Récolte du café",
                add = "~p~+ 1 Graine de Café",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            traitement5 = {
                --Café
                type = "traitement",
                workSize = 10.0,
                blipcolor = 7,
                blipname = "Pearl's - Traitement Café",
                Pos = {x = 2542.21, y = 2584.90, z = 37.00},
                required = "graincafe1",
                giveitem = "cafe",
                RemoveItem = "graincafe1",
                add = "~p~+ 1  Café"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Pearls - Vente",
                Pos = {x = 1249.4327, y = -349.8305, z = 69.20 - 0.98},
                required = "cafe",
                price = math.random(13,16),
                add = "~p~- 1 Café"
            }
        }
    },
    -- tacoloco = {
    --     label = "Taco Loco",
    --     label2 = "Taco Loco",
    --     iban = "tacoloco",
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
    --             title = "Taco Loco",
    --             subtitle = "Actions disponibles",
    --             name = "restaurant_menuperso"
    --         },
    --         buttons = {
    --             -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("tacoloco")
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
    --                         TriggerServerEvent("Job:Annonce", "Taco Loco", "Annonce", text, "CHAR_TACOLOCO", 8, "Taco Loco")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    --     garage = {
    --         Name = "Garage Taco Loco",
    --         Pos = {x = 416.2844, y = -1929.2210, z = 23.43},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x =  416.2844, y = -1929.2210, z = 23.43, h = 318.24}
    --         },
    --         Blipdata = {
    --             Pos = {x =  416.2844, y = -1929.2210, z = 23.43, h = 318.24},
    --             Blipcolor = 5,
    --             Blipname = "Garage"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = 426.0520, y = -1911.7979, z = 24.47},
    --             Limit = 500,
    --             Name = "coffre_tacoloco2"
    --         },
    --         {
    --             Pos = {x = 418.2400, y = -1916.0034, z = 24.47},
    --             Limit = 500,
    --             Name = "coffre_tacoloco1"
    --         },
    --         {
    --             Pos = {x = 429.8100, y = -1915.5762, z = 24.47},
    --             Limit = 500,
    --             Name = "coffre_tacoloco"
    --         }
    --     },
    --     Extrapos = {
    --         CraftSpiritueux = {
    --             Pos = {
    --                 {x = 425.4309, y = -1917.5015, z = 25.47}
    --             },
    --             restricted = {1, 2, 3, 4, 5},
    --             Enter = function()
    --                 EntercrafttacoZone()
    --             end,
    --             Exit = function()
    --                 ExitcrafttacoZone()
    --             end,
    --             zonesize = 3.5,
    --             Blips = {
    --                 sprite = 93,
    --                 color = 81,
    --                 name = "Taco Loco - Alambique"
    --             },
    --             Marker = {
    --                 type = 1,
    --                 scale = {x = 1.5, y = 1.5, z = 0.2},
    --                 color = {r = 255, g = 255, b = 255, a = 120},
    --                 Up = false,
    --                 Cam = false,
    --                 Rotate = false,
    --                 visible = true
    --             }
    --         }
    --     },
    --     requiredService = false,
    --     work = {
    --         recolte = {
    --             type = "recolte",
    --             workSize = 10.0,
    --             Pos = {x = 803.1325, y = 2175.2553, z = 53.0708 - 0.98},
    --             giveitem = "graincafe1",
    --             blipcolor = 7,
    --             blipname = "Taco Loco - Récolte du café",
    --             add = "~p~+ 1 Graine de Café",
    --             anim = {
    --                 lib = "anim@mp_snowball",
    --                 anim = "pickup_snowball"
    --             }
    --         },
    --         traitement = {
    --             type = "traitement",
    --             workSize = 10.0,
    --             blipcolor = 7,
    --             blipname = "Taco Loco - Traitement Café",
    --             Pos = {x = 2542.21, y = 2584.90, z = 37.00},
    --             required = "graincafe1",
    --             giveitem = "cafe",
    --             RemoveItem = "graincafe1",
    --             add = "~p~+ 1  Café"
    --         },
    --         vente = {
    --             type = "vente",
    --             blipcolor = 7,
    --             workSize = 7.45,
    --             blipname = "Taco Loco - Vente",
    --             Pos = {x = 1249.4327, y = -349.8305, z = 69.20 - 0.98},
    --             required = "cafe",
    --             price = math.random(13,16),
    --             add = "~p~- 1 Café"
    --         }
    --     }
    -- },
    -- restaurant = {
    --     label = "Mirror",
    --     label2 = "Mirror",
    --     iban = "restaurant",
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
    --             title = "Mirror",
    --             subtitle = "Actions disponibles",
    --             name = "restaurant_menuperso"
    --         },
    --         buttons = {
    --             -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("restaurant")
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
    --                         TriggerServerEvent("Job:Annonce", "Mirror", "Annonce", text, "CHAR_MIROR", 8, "Mirror")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    --     garage = {
    --         Name = "Garage Mirror",
    --         Pos = {x = -1330.91149, y = -1035.2799, z = 7.37 - 0.98},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = -1330.91149, y = -1035.2799, z = 7.37 - 0.98, h = 118.64}
    --         },
    --         Blipdata = {
    --             Pos = {x = -1321.20, y = -1051.51, z = 7.37 - 0.98, h = 118.64},
    --             Blipcolor = 5,
    --             Blipname = "Garage"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -1338.05, y = -1072.20, z = 6.98 - 0.98},
    --             Limit = 500,
    --             Name = "coffre_restaurant"
    --         },
    --         {
    --             Pos = {x = -1353.03, y = -1055.21, z = 3.51 - 0.98},
    --             Limit = 500,
    --             Name = "coffre_caveresto"
    --         },
    --         {
    --             Pos = {x = -1351.72, y = -1064.70, z = 11.46 - 0.98},
    --             Limit = 500,
    --             Name = "coffre_Mirror_club"
    --         }
    --     },
    --     Extrapos = {
    --         CraftSpiritueux = {
    --             Pos = {
    --                 {x = -1352.6164, y = -1068.4773, z = 6.98}
    --             },
    --             restricted = {1, 2, 3, 4, 5},
    --             Enter = function()
    --                 EntercraftmirorZone()
    --             end,
    --             Exit = function()
    --                 ExitcraftmirorZone()
    --             end,
    --             zonesize = 3.5,
    --             Blips = {
    --                 sprite = 93,
    --                 color = 81,
    --                 name = "Mirror - Alambique"
    --             },
    --             Marker = {
    --                 type = 1,
    --                 scale = {x = 1.5, y = 1.5, z = 0.2},
    --                 color = {r = 255, g = 255, b = 255, a = 120},
    --                 Up = false,
    --                 Cam = false,
    --                 Rotate = false,
    --                 visible = true
    --             }
    --         }
    --     },
    --     requiredService = false,
    --     work = {
    --         recolte = {
    --             type = "recolte",
    --             workSize = 10.0,
    --             Pos = {x = 803.1325, y = 2175.2553, z = 53.0708 - 0.98},
    --             giveitem = "graincafe1",
    --             blipcolor = 7,
    --             blipname = "Miror - Récolte du café",
    --             add = "~p~+ 1 Graine de Café",
    --             anim = {
    --                 lib = "anim@mp_snowball",
    --                 anim = "pickup_snowball"
    --             }
    --         },
    --         traitement6 = {
    --             --Café
    --             type = "traitement",
    --             workSize = 10.0,
    --             blipcolor = 7,
    --             blipname = "Miror - Traitement Café",
    --             Pos = {x = 2542.21, y = 2584.90, z = 37.00},
    --             required = "graincafe1",
    --             giveitem = "cafe",
    --             RemoveItem = "graincafe1",
    --             add = "~p~+ 1  Café"
    --         },
    --         vente = {
    --             type = "vente",
    --             blipcolor = 7,
    --             workSize = 7.45,
    --             blipname = "Miror - Vente",
    --             Pos = {x = 1249.4327, y = -349.8305, z = 69.20 - 0.98},
    --             required = "cafe",
    --             price = math.random(13,16),
    --             add = "~p~- 1 Café"
    --         }
    --     }
    -- },
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
                label = "Taxi CDD",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "Taxi CDI",
                salary = 160,
                name = "cdi",
                show = true
            },
            {
                label = "Uber",
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
                    label = "Commencer une mission",
                    onSelected = function()
                        if LocalPlayer().FarmLimit >= 600 then
                            ShowNotification("Vous avez atteint votre limite de missions journalière.")
                        else
                            StartTaxiMission()
                        end
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
                Pos = {x = 890.2208, y = -177.6278, z = 80.59},
                Limit = 500,
                Name = "coffre_taxi"
            },
            {
                Pos = {x = 906.99, y = -152.06, z = 82.49},
                Limit = 500,
                Name = "coffre_taxi2"
            }
        },
        requiredService = true
    },
    -- rappeur = {
    --     label = "District Records",
    --     label2 = "District Records",
    --     iban = "rappeur",
    --     FreeAccess = false,
    --     grade = {
    --         {
    --             label = "Employé",
    --             salary = 150,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "Responsable de projet",
    --             salary = 160,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Directeur artistique",
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
    --             title = "District Records",
    --             subtitle = "Actions disponibles",
    --             name = "rappeur_menuperso"
    --         },
    --         buttons = {
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("rappeur")
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
    --                         TriggerServerEvent("Job:Annonce", "District Records", "Annonce", text, "CHAR_RAPPEUR", 8, "District Records")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    --     garage = {
    --         Name = "Garage District Records",
    --         Pos = {x = -973.4893, y = -269.6187, z = 37.31},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = -973.4893, y = -269.6187, z = 37.31, h = 179.85}
    --         },
    --         Blipdata = {
    --             Pos = {x =  -973.4893, y = -269.6187, z = 37.31, h = 179.85},
    --             Blipcolor = 5,
    --             Blipname = "Garage"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -996.6784, y = -257.2656, z = 39.03 - 0.98},
    --             Limit = 200,
    --             Name = "coffre_rappeur"
    --         },
    --         {
    --             Pos = {x = -977.5216, y = -257.2708, z = 38.47 - 0.98},
    --             Limit = 2000,
    --             Name = "coffre_rappeur1"
    --         },
    --         {
    --             Pos = {x = -1008.1710, y = -265.2815, z = 44.79 - 0.98},
    --             Limit = 2000,
    --             Name = "coffre_rappeur2"
    --         }
    --     },
    --     requiredService = false
    -- },
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
        label = "LTD Davis",
        label2 = "LTD Davis",
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
                title = "LTD Davis",
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
                            TriggerServerEvent("Job:Annonce", "LTD Davis", "Annonce", text, "CHAR_LTDSUD", 8, "LTD Davis")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage LTD Davis",
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
                Pos = {x = 26.69, y = -1339.10, z = 29.49 - 0.98},
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
    -- ltdsud2 = {
    --     label = "LTD Grove Street",
    --     label2 = "LTD Grove Street",
    --     iban = "ltdsud2",
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
    --             title = "LTD Grove Street",
    --             subtitle = "Actions disponibles",
    --             name = "ltdsud2_menuperso"
    --         },
    --         buttons = {
    --             -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
    --             {
    --                 label = "Facturation",
    --                 onSelected = function()
    --                     CreateFacture("ltdsud2")
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
    --                         TriggerServerEvent("Job:Annonce", "LTD Grove Street", "Annonce", text, "CHAR_LTDSUD2", 8, "LTD Grove Street")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    --     garage = {
    --         Name = "Garage LTD Grove Street",
    --         Pos = {x = -46.9176, y = -1738.4676, z = 29.1648},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = -46.9176, y = -1738.4676, z = 29.1648, h = 229.7284}
    --         },
    --         Blipdata = {
    --             Pos = {x = -46.9176, y = -1738.4676, z = 29.1648, h = 229.7284},
    --             Blipcolor = 5,
    --             Blipname = "Garage"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -42.3382, y = -1748.9405, z = 29.4210, h = 167.2710},
    --             Limit = 2000,
    --             Name = "coffre_ltdsud2"
    --         }
    --     },
    -- },
    burgershot = {
        label = "BurgerShot",
        label2 = "BurgerShot",
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
                title = "BurgerShot",
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
                            TriggerServerEvent("Job:Annonce", "BurgerShot", "Annonce", text, "CHAR_BURGERSHOT", 8, "BurgerShot")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage BurgerShot",
            Pos = {x = -1171.692505, y = -893.373413, z = 13.28 - 0.98},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -1171.692505, y = -893.373413, z = 13.28 - 0.98, h = 32.3272209}
            },
            Blipdata = {
                Pos = {x = 1248.37, y = -341.43, z = 69.08 - 0.98, h = 75.27},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = -1200.6992, y = -901.47088, z = 13.97 - 0.98},
                Limit = 1000,
                Name = "coffre_restaurantfood"
            },
            {
                Pos = {x = -1182.4001, y = -899.5428, z = 13.97 - 0.98},
                Limit = 1000,
                Name = "coffre_restaurantfood1"
            },
            {
                Pos = {x = -1193.0552, y = -897.1772, z = 13.97 - 0.98},
                Limit = 1000,
                Name = "coffre_restaurantfood2"
            } ,
            {
                Pos = {x = -1179.2254, y = -894.7935, z = 13.97 - 0.98},
                Limit = 100,
                Name = "coffre_restaurantfood3"
            } 
        },
        Extrapos = {
            CraftSpiritueux = {
                Pos = {
                    {x = -1198.1027, y = -896.0474, z = 13.97}
                },
                restricted = {1, 2, 3, 4, 5},
                Enter = function()
                    EntercraftBurgerZone()
                end,
                Exit = function()
                    ExitcraftburgerZone()
                end,
                zonesize = 3.5,
                Blips = {
                    sprite = 93,
                    color = 81,
                    name = "BurgerShot - Alambique"
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
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 803.1325, y = 2175.2553, z = 53.0708 - 0.98},
                giveitem = "graincafe1",
                blipcolor = 7,
                blipname = "BurgerShot - Récolte du café",
                add = "~p~+ 1 Graine de Café",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            traitement = {
                --Café
                type = "traitement",
                workSize = 10.0,
                blipcolor = 7,
                blipname = "BurgerShot - Traitement Café",
                Pos = {x = 2542.21, y = 2584.90, z = 37.00},
                required = "graincafe1",
                giveitem = "cafe",
                RemoveItem = "graincafe1",
                add = "~p~+ 1  Café"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "BurgerShot - Vente",
                Pos = {x = -423.8536, y = 284.0237, z = 83.19 - 0.98},
                required = "cafe",
                price = math.random(13,16),
                add = "~p~- 1 Café"
            }
        }
    },
    malonebar = {
        label = "Malone's Bar",
        label2 = "Malone's Bar",
        iban = "malonebar",
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
                title = "Malone's Bar",
                subtitle = "Actions disponibles",
                name = "malonebar_menuperso"
            },
            buttons = {
                -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("malonebar")
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
                            TriggerServerEvent("Job:Annonce", "Malone's Bar", "Annonce", text, "CHAR_MALONE", 8, "Malone's Bar")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage Malone's Bar",
            Pos = {x = 412.89, y = -1515.52, z = 29.29 - 0.98},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 412.89, y = -1515.52, z = 29.29 - 0.98, h = 215.81}
            },
            Blipdata = {
                Pos = {x = 412.89, y = -1515.52, z = 29.29 - 0.98, h = 215.81},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = 414.65, y = -1499.45, z = 30.15 - 0.98}, -- Bar
                Limit = 1000,
                Name = "coffre_malonebar"
            },
            {
                Pos = {x = 418.18, y = -1502.47, z = 30.15 - 0.98},  -- Cuisine
                Limit = 1000,
                Name = "coffre_malonebar1"
            },
            {
                Pos = {x = 427.69, y = -1505.58, z = 29.31 - 0.98}, -- Vestiaire
                Limit = 1000,
                Name = "coffre_malonebar2"
            },
            {
                Pos = {x = 411.78, y = -1503.82, z = 33.80 - 0.98}, -- Patron
                Limit = 100,
                Name = "coffre_restaurantfood3"
            } 
        },
        Extrapos = {
            CraftSpiritueux = {
                Pos = {
                    {x = 413.60, y = -1504.81, z = 30.15}
                },
                restricted = {1, 2, 3, 4, 5},
                Enter = function()
                    EntercraftMaloneZone()
                end,
                Exit = function()
                    ExitcraftMaloneZone()
                end,
                zonesize = 3.5,
                Blips = {
                    sprite = 93,
                    color = 81,
                    name = "Malone's Bar - Alambique"
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
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 803.1325, y = 2175.2553, z = 53.0708 - 0.98},
                giveitem = "graincafe1",
                blipcolor = 7,
                blipname = "Malone's Bar - Récolte du café",
                add = "~p~+ 1 Graine de Café",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            traitement = {
                --Café
                type = "traitement",
                workSize = 10.0,
                blipcolor = 7,
                blipname = "Malone's Bar - Traitement Café",
                Pos = {x = 2542.21, y = 2584.90, z = 37.00},
                required = "graincafe1",
                giveitem = "cafe",
                RemoveItem = "graincafe1",
                add = "~p~+ 1  Café"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Malone's Bar - Vente",
                Pos = {x = -423.8536, y = 284.0237, z = 83.19 - 0.98},
                required = "cafe",
                price = math.random(13,16),
                add = "~p~- 1 Café"
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
        label = "Weazel News",
        label2 = "Weazel News",
        iban = "journaliste",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 120,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 140,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 160,
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
                salary = 190,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Weazel News",
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
                            TriggerServerEvent("Job:Annonce", "Weazel News", "Annonce", text, "CHAR_WEAZEL", 8, "Weazel News")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage Weazel News",
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
                            modLivery = 4
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
                Pos = {x = -584.6451, y = -938.3806, z = 22.86},
                Limit = 1000,
                Name = "coffre_weazel"
            }
        },
    },
    goldstallion = {
        label = "Gold Stallion",
        label2 = "Gold Stallion",
        iban = "goldstallion",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 120,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 140,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 160,
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
                salary = 190,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Gold Stallion",
                subtitle = "Actions",
                name = "journaliste_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("goldstallion")
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
                            TriggerServerEvent("Job:Annonce", "Gold Stallion", "Annonce", text, "CHAR_LAWYER", 8, "Gold Stallion")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage Gold Stallion",
            Pos = {x = -579.1892, y = -726.4684, z = 26.73},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -579.1892, y = -726.4684, z = 26.73, h = 10.2296}
            },
            Blipdata = {
                Pos = {x = -579.1892, y = -726.4684, z = 26.73},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
    
        Storage = {
            {
                Pos = {x = -601.0551 y = -709.7877, z = 121.6045},
                Limit = 1000,
                Name = "coffre_stallion"
            }
        }
    },
    avocat = {
        label = "Cabinet Hermerion",
        label2 = "Cabinet Hermerion",
        iban = "avocat",
        FreeAccess = false,
        grade = {
            {
                label = "AVOCAT",
                salary = 150,
                name = "cdi",
                show = true
            },
            {
                label = "ASSOCIE",
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
                title = "Avocat",
                subtitle = "Actions",
                name = "avocat_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("avocat")
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
                            TriggerServerEvent("Job:Annonce", "Cabinet Hermerion", "Annonce", text, "CHAR_HERMERION", 8, "Cabinet Hermerion")
                        end
                    end
                }
            }
        },
    },
    -- avocat2 = {
    --     label = "Cabinet Lysias",
    --     label2 = "Cabinet Lysias",
    --     iban = "avocat2",
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
    --                     CreateFacture("avocat2")
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
    --                         TriggerServerEvent("Job:Annonce", "Cabinet Lysias", "Annonce", text, "CHAR_WALTER", 8, "Cabinet Lysias")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    -- },
    -- avocat3 = {
    --     label = "Cabinet Genovese",
    --     label2 = "Cabinet Genovese",
    --     iban = "avocat3",
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
    --                     CreateFacture("avocat3")
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
    --                         TriggerServerEvent("Job:Annonce", "Cabinet Genovese", "Annonce", text, "CHAR_GENOVESE", 8, "Cabinet Genovese")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    --     garage = {
    --         Name = "Garage Avocat",
    --         Pos = {x = -1171.73, y = -1390.28, z = 4.20},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = -1171.73, y = -1390.28, z = 4.20, h = 166.45}
    --         },
    --         Blipdata = {
    --             Pos = {x = -1171.73, y = -1390.28, z = 4.20},
    --             Blipcolor = 5,
    --             Blipname = "Garage"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -1180.58, y = -1406.70, z = 13.22},
    --             Limit = 500,
    --             Name = "coffre_avocatge"
    --         },
    --         {
    --             Pos = {x = -1194.90, y = -1397.00, z = 9.80},
    --             Limit = 500,
    --             Name = "coffre_avocatge2"
    --         }
    --     },
    -- },
    -- avocat4 = {
    --     label = "Cabinet Wistaria",
    --     label2 = "Cabinet Wistaria",
    --     iban = "avocat4",
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
    --                     CreateFacture("avocat4")
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
    --                         TriggerServerEvent("Job:Annonce", "Cabinet Wistaria", "Annonce", text, "CHAR_HERMERION", 8, "Cabinet Wistaria")
    --                     end
    --                 end
    --             }
    --         }
    --     },
    -- },
    records = {
        label = "Stray Boyz Records",
        label2 = "Stray Boyz Records",
        iban = "records",
        grade = {
            {
                label = "Sécurité",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "Autres",
                salary = 150,
                name = "cdi",
                show = true
            },
            {
                label = "Rappeur",
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
                title = "Stray Boyz Records",
                subtitle = "Actions",
                name = "avocat_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("records")
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
                            TriggerServerEvent("Job:Annonce", "Stray Boyz Records", "Annonce", text, "CHAR_STAY", 8, "Stray Boyz Records")
                        end
                    end
                }
            }
        },
    },
    drecords = {
        label = "Death Row Records",
        label2 = "Death Row Records",
        iban = "drecords",
        grade = {
            {
                label = "Sécurité",
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "Autres",
                salary = 150,
                name = "cdi",
                show = true
            },
            {
                label = "Rappeur",
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
                title = "Death Row Records",
                subtitle = "Actions",
                name = "avocat_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("drecords")
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
                            TriggerServerEvent("Job:Annonce", "Death Row Records", "Annonce", text, "CHAR_RECORDS", 8, "Death Row Records")
                        end
                    end
                }
            }
        },
    },
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
        label = "Galaxy",
        label2 = "Galaxy",
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
                title = "Galaxy",
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
                            TriggerServerEvent("Job:Annonce", "Galaxy", "Annonce", text, "CHAR_GALAXY", 8, "Galaxy")
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
                            { model="s_f_y_hooker_01", x=372.91, y=280.18, z=91.97 - 0.98, a=101.25, animation="mini@strip_club@private_dance@part2", animationName="priv_dance_p2"},
                            { model="a_f_y_clubcust_02", x=364.30, y=275.71, z=91.97 - 0.98, a=295.00, animation="mini@strip_club@private_dance@part1", animationName="priv_dance_p1"},
                            --{ model="s_f_y_stripper_02", x=104.66, y=-1294.46, z=29.26, a=287.12, animation="mini@strip_club@lap_dance@ld_girl_a_song_a_p1", animationName="ld_girl_a_song_a_p1_f"},
                            --{ model="a_f_y_topless_01", x=102.26, y=-1289.92, z=29.26, a=292.05, animation="mini@strip_club@private_dance@idle", animationName="priv_dance_idle"},
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
                                        SetBlockingOfNonTemporaryEvents(storePed, true)
                                        SetPedFleeAttributes(storePed, 0, 0)
                                        SetPedArmour(storePed, 100)
                                        SetPedMaxHealth(storePed, 100)
                                        SetPedDiesWhenInjured(storePed, true)
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
        },
        garage = {
            Name = "Garage Galaxy",
            Pos = {x = 359.9612, y = 272.1847, z = 103.1023},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 359.96, y = 272.18, z = 103.10, h = 353.35}
            },
            Blipdata = {
                Pos = "none"
            }
        },
        Storage = {
            {
                Pos = {x = 393.50, y = 278.77, z = 94.10},
                Limit = 500,
                Name = "coffre_NightClub"
            },
            {
                Pos = {x = 354.91, y = 287.35, z = 90.40},
                Limit = 1000,
                Name = "Frigo_1"
            },
            {
                Pos = {x = 409.72, y = 248.17, z = 92.05 - 0.98},
                Limit = 1000,
                Name = "Frigo_3"
            },
            {
                Pos = {x = 356.42, y = 282.57, z = 93.40},
                Limit = 1000,
                Name = "Frigo_2"
            }
        },
        Extrapos = {
            CraftSpiritueux = {
                Pos = {
                    {x = 354.91, y = 279.98, z = 94.19}
                },
                restricted = {1, 2, 3, 4, 5},
                Enter = function()
                    EntercraftnightZone()
                end,
                Exit = function()
                    ExitcraftnightZone()
                end,
                zonesize = 2.5,
                Blips = {
                    sprite = 93,
                    color = 81,
                    name = "Galaxy - Alambique"
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
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 803.1325, y = 2175.2553, z = 53.0708 - 0.98},
                giveitem = "graincafe1",
                blipcolor = 7,
                blipname = "Galaxy - Récolte du café",
                add = "~p~+ 1 Graine de Café",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            traitement6 = {
                --Café
                type = "traitement",
                workSize = 10.0,
                blipcolor = 7,
                blipname = "Galaxy - Traitement Café",
                Pos = {x = 2542.21, y = 2584.90, z = 37.00},
                required = "graincafe1",
                giveitem = "cafe",
                RemoveItem = "graincafe1",
                add = "~p~+ 1  Café"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Galaxy - Vente",
                Pos = {x = 1249.4327, y = -349.8305, z = 69.20 - 0.98},
                required = "cafe",
                price = math.random(13,16),
                add = "~p~- 1 Café"
            }
        }
        -- garage = {
        --     Name = "Garage_caroccasions",
        --     Pos = {x = 1210.015, y = 2714.235, z = 37.20},
        --     Properties = {
        --         type = 3, --job public
        --         Limit = 20,
        --         vehicles = {},
        --         spawnpos = {x = 1210.015, y = 2714.235, z = 37.20, h = 351.93}
        --     },
        --     Blipdata = {
        --         Pos = {x = 1210.015, y = 2714.235, z = 37.20},
        --         Blipcolor = 5,
        --         Blipname = "Garage"
        --     }
        -- },
        -- Storage = {
        --     {
        --         Pos = {x = 1226.933, y = 2738.123, z = 37.00},
        --         Limit = 100,
        --         Name = "coffre_caroccasions"
        --     }
        -- }
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
    pawnshop = {
        label = "Pawn Shop",
        label2 = "Pawn Shop",
        iban = "pawnshop",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 130,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 140,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 150,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 200,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 230,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Pawn Shop",
                subtitle = "Actions",
                name = "pawnshop_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("pawnshop")
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
                            TriggerServerEvent("Job:Annonce", "PawnShop", "Annonce", text, "CHAR_PAWNSHOP", 8, "Pawn Shop")
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
                    submenu = "pawnshop_menuperso",
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
                                label = "Mettre/Retirer le véhicule du plateau",
                                onSelected = function()
                                    Mecano.PutPlateau()
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
            Name = "Garage_pawnshop",
            Pos = {x = 74.73, y = 18.13, z = 69.14},
            Properties = {
                type = 3, --job public
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 74.73, y = 18.13, z = 69.14, h = 159.84}
            },
            Blipdata = {
                Pos = {x = 74.73, y = 18.13, z = 69.14},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = 106.56, y = 18.44, z = 67.25},
                Limit = 1000,
                Name = "coffre_pawnshop"
            }
        }
    },
    distillerie = {
        label = "Distillerie",
        label2 = "Distillerie",
        iban = "distillerie",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 120,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 140,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 160,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 170,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 190,
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
                Pos = {x = -1896.6995, y = 2067.8933, z = 140.02},
                Limit = 9999,
                Name = "coffre_distillerie_gestion"
            },
            {
                Pos = {x = -1905.6743, y = 2072.8759, z = 139.48},
                Limit = 9999,
                Name = "coffre_distillerie"
            },
            {
                Pos = {x = -1924.4666, y = 2054.6787, z = 139.81},
                Limit = 9999,
                Name = "coffre_distillerie1"
            },
            {
                Pos = {x = -1925.9760, y = 2048.2673, z = 139.81},
                Limit = 9999,
                Name = "coffre_distillerie2"
            },
            {
                Pos = {x = -1927.3668, y = 2042.1761, z = 140.00},
                Limit = 9999,
                Name = "coffre_distillerie3"
            },
            {
                Pos = {x = -1880.4583, y = 2069.9509, z = 140.00},
                Limit = 9999,
                Name = "coffre_distillerie4"
            },
            --new coffre
            {
                Pos = {x = -1875.4757, y = 2054.1853, z = 140.06},
                Limit = 9999,
                Name = "coffre_distillerie_vestiaire"
            },
            {
                Pos = {x = -1910.5480, y = 2075.4038, z = 139.58},
                Limit = 9999,
                Name = "coffre_distillerie_drh"
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
                    {name = "red_wine", count = 2, chanceDrop = 75},
                    {name = "high_quality_wine", count = 2, chanceDrop = 25}
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
                price = math.random(13, 15),
                add = "~p~- 1 Jus de raisin"
            }
        },
        Extrapos = {
            CraftSpiritueux = {
                Pos = {
                    {x = -1931.4281, y = 2053.1835, z = 140.84 - 0.98}
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
                salary = 100,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 120,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 140,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 160,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 180,
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
                                if DecorExistOn(trailer, "tanker") then
                                    ShowNotification("~b~Quantité d'essence :~w~"..DecorGetFloat(trailer, "tanker"))
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
        label = "BCSO",
        label2 = "BCSO",
        iban = "bcso",
        -- radios = {1,2},
        grade = {
            {
                label = "Rookie",
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
            Name = "Garage BCSO Paleto",
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
                Blipname = "Garage BCSO Paleto"
            }
        },
        garage2 = {
            Name = "Helipad Sherif",
            Pos = {x = -475.13, y = 5988.67, z = 31.34},
            Properties = {
                type = 2,
                Limit = 10,
                zonesize = 1.5,
                vehicles = {
                    {
                        name = "bcsomav",
                        label = "Helicoptere du BCSO",
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
                Blipname = "BCSO - Helipad Sherif"
            }
        },
        garage3 = {
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
                Blipname = "BCSO - Marina Sherif"
            }
        },
        garage4 = {
            Name = "Garage Personnel BCSO",
            Pos = {x = -445.601, y = 6047.075, z = 31.340},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = -445.601, y = 6047.075, z = 31.340, h = 303.109}
            },
            Blipdata = {
                Pos = {x = -445.601, y = 6047.075, z = 31.340},
                Blipcolor = 5,
                Blipname = "BCSO - Garage Personnel"
            }
        },
        garage5 = {
            Name = "Garage Personnel BCSO Sandy Shores",
            Pos = {x = 1868.2619, y = 3682.0087, z = 33.70},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 1868.2619, y = 3682.0087, z = 33.70, h = 303.109}
            },
            Blipdata = {
                Pos = {x = 1868.2619, y = 3682.0087, z = 33.70},
                Blipcolor = 5,
                Blipname = "BCSO - Garage Personnel"
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
                                label = "[COOP] Agents SAHP en service",
                                onSelected = function()
                                    TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "police")
                                end
                            },
                            {
                                label = "Recevoir/Ne plus recevoir les appels SAHP",
                                onSelected = function()
                                    if not getOtherPoliceCalls then
                                        TriggerServerEvent("Ora::SE::Service:SetPlayerInService", "police")
                                        RageUI.Popup({message = "~g~Vous recevez désormais les appels SAHP"})
                                        getOtherPoliceCalls = not getOtherPoliceCalls
                                    else
                                        TriggerServerEvent("Ora::SE::Service:RemovePlayerFromService", "police")
                                        RageUI.Popup({message = "~r~Vous ne recevez plus désormais les appels SAHP"})
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
                            TriggerServerEvent("Job:Annonce", "BCSO", "Annonce", text, "CHAR_LSSD", 8)
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
                Pos = {x = -448.1734, y = 6013.8608, z = 36.00},
                Limit = 99999999,
                Name = "coffre chef_bcso"
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
                Pos = {x = -454.86, y = 6015.88, z = 31.71},
                vestiaire = {
                    type = "Vestiaire",
                    workSize = 1.45,
                    Pos = {x = -454.86, y = 6015.88, z = 31.71},
                    Tenues = TenueBCSO
                }
            }
        },
        Extrapos = {
            ExtraVehicle = {
                Pos = {
                    {x = -462.558, y = 6045.449, z = 31.340}
                },
                restricted = {1, 2, 3, 4, 5, 6, 7},
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
                    name = "BCSO - Extras"
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
        label = "SAHP",
        label2 = "SAHP",
        iban = "police",
        radios = {1, 2},
        grade = {
            {
                label = "Cadet",
                salary = 325,
                name = "cadet"
            },
            {
                label = "Traffic Officer",
                salary = 340,
                name = "officier1"
            },
            {
                label = "Sergent",
                salary = 340,
                name = "sergent1"
            },
            {
                label = "Officier III",
                salary = 340,
                name = "officier3"
            },
            {
                label = "Lieutenant",
                salary = 360,
                name = "sergent1"
            },
            {
                label = "Capitaine",
                salary = 360,
                name = "sergent2"
            },
            {
                label = "Assistant Chief",
                salary = 390,
                name = "boss"
            },
            {
                label = "Chief",
                salary = 430,
                name = "boss"
            }
        },
        garage = {
            Name = "Garage police",
            Pos = {x = 823.2741, y = -1369.5996, z = 26.1356},
            Properties = {
                type = 3,
                Limit = 99,
                vehicles = {},
                spawnpos = {x = 823.2741, y = -1369.5996, z = 26.1356, h = 2.5655}
            },
            Blipdata = {
                Pos = {x = 823.2741, y = -1369.5996, z = 26.1356},
                Blipcolor = 5,
                Blipname = "SAHP - Garage Marked"
            }
        },
        garage2 = {
            Name = "Garage police2",
            Pos = {x = 832.5797, y = -1369.8060, z = 26.1322},
            Properties = {
                type = 3,
                Limit = 99,
                vehicles = {},
                spawnpos = {x = 832.5797, y = -1369.8060, z = 26.1322, h = 359.4103}
            },
            Blipdata = {
                Pos = {x = 832.5797, y = -1369.8060, z = 26.1322},
                Blipcolor = 5,
                Blipname = "SAHP - Garage Unmarked"
            }
        },
        garage6 = {
            Name = "Garage police6",
            Pos = {x = 855.8529, y = -1301.9434, z = 24.3203},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 855.8529, y = -1301.9434, z = 24.3203, h = 2.5217}
            },
            Blipdata = {
                Pos = {x = 855.8529, y = -1301.9434, z = 24.3203},
                Blipcolor = 5,
                Blipname = "SAHP - Garage Saisie"
            }
        },
        garage7 = {
            Name = "Garage policeacademy",
            Pos = {x = -1645.1019, y = 269.5713, z = 59.55},
            Properties = {
                type = 3,
                Limit = 30,
                vehicles = {},
                spawnpos = {x = -1645.1019, y = 269.5713, z = 59.55, h = 25.345}
            },
            Blipdata = {
                Pos = {x = -1645.1019, y = 269.5713, z = 58.57},
                Blipcolor = 5,
                Blipname = "SAHP - Garage"
            }
        },
        garagesed = {
            Name = "Garage sed",
            Pos = {x = 853.6597, y = -1357.9885, z = 26.0939},
            Properties = {
                type = 3,
                Limit = 30,
                vehicles = {},
                spawnpos = {x = 853.6597, y = -1357.9885, z = 26.0939, h = 77.3380}
            },
            Blipdata = {
                Pos = {x = 853.6597, y = -1357.9885, z = 26.0939},
                Blipcolor = 5,
                Blipname = "SAHP - Garage SED"
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
                Blipname = "SAHP - Bateaux"
            }
        },
        garage4 = {
            Name = "Garage Helipad",
            Pos = {x = -745.6586, y = -1468.9907, z = 5},
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
                spawnpos = {x = -745.6586, y = -1468.9907, z = 5, h = 318.5589}
            },
            Blipdata = {
                Pos = {x = -745.6586, y = -1468.9907, z = 5},
                Blipcolor = 5,
                Blipname = "SAHP - Helipad"
            }
        },
        garage5 = {
            Name = "Garage police3",
            Pos = {x = 862.3458, y = -1382.8272, z = 26.1439},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 862.3458, y = -1382.8272, z = 26.1439},
            },
            Blipdata = {
                Pos = {x = 862.3458, y = -1382.8272, z = 26.1439},
                Blipcolor = 5,
                Blipname = "SAHP - Garage Personnel"
            }
        },
        Menu = {
            menu = {
                title = "SAHP",
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
                                label = "Agents SAHP en service",
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
                            TriggerServerEvent("Job:Annonce", "SAHP", "Annonce", text, "CHAR_sahp", 8)
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
                Pos = {x = 834.8974, y = -1299.3896, z = 24.3203}, -- Coffre armurerie
                Limit = 99999999,
                Name = "coffre"
            },
            {
                Pos = {x = 843.1442, y = -1307.0839, z = 24.3203},
                Limit = 1000,
                Name = "coffre cellules"
            },
            {
                Pos = {x = 854.1108, y = -1318.2130, z = 24.3203}, -- Saisie SAHP
                Limit = 5000,
                Name = "coffre des saisies"
            },
            {
                Pos = {x = 846.6671, y = -1282.4407, z = 24.3203},  -- Coffre vestiaire 
                Limit = 99999999,
                Name = "coffre personnel"
            },
            {
                Pos = {x = -1087.4049, y = -820.5991, z = 11.0358},  -- Saisie DB
                Limit = 2000,
                Name = "coffre Saisies DB"
            },
            {
                Pos = {x = 876.19, y = -1352.45, z = 26.32},
                Limit = 99999999,
                Name = "coffre SWAT"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = 844.9340, y = -1284.5042, z = 24.3187},
                vestiaire = {
                    type = "Vestiaire",
                    workSize = 1.45,
                    Pos = {x = 844.9340, y = -1284.5042, z = 24.3187},
                    Tenues = TenueSAHP
                }
            }
        },
        Extrapos = {
            ExtraVehicle = {
                Pos = {
                    {x = 827.7247, y = -1351.0211, z = 26.0985}
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
                    name = "SAHP - Extras"
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

    
    fib = {
        label = "FIB",
        label2 = "FIB",
        iban = "fib",
        radios = {1, 2},
        grade = {
            {
                label = "Agent Special",
                salary = 325,
                name = "agent"
            },
            {
                label = "Agent Special Senior",
                salary = 340,
                name = "agent2"
            },
            {
                label = "Agent Special en charge",
                salary = 350,
                name = "agent2"
            },
            {
                label = "Directeur Adjoint",
                salary = 390,
                name = "drh"
            },
            {
                label = "Directeur",
                salary = 430,
                name = "boss"
            }
        },
        garage = {
            Name = "Garage fib",
            Pos = {x = 2523.86, y = -377.82, z = 91.99},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 2523.86, y = -377.82, z = 91.99, h = 182.90}
            },
            Blipdata = {
                Pos = {x = 2523.86, y = -377.82, z = 91.99},
                Blipcolor = 5,
                Blipname = "FIB - Garage"
            }
        },
        garage2 = {
            Name = "Garage fib2",
            Pos = {x = 2531.11, y = -401.88, z = 91.99},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = 2531.11, y = -401.88, z = 91.99},
            },
            Blipdata = {
                Pos = {x = 2531.11, y = -401.88, z = 91.99},
                Blipcolor = 5,
                Blipname = "FIB - Garage Personnel"
            }
        },
        Menu = {
            menu = {
                title = "FIB",
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
                            TriggerServerEvent("Job:Annonce", "fib", "Annonce", text, "CHAR_FIB", 8)
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
        Storage = {
            {
                Pos = {x = 2525.64, y = -342.12, z = 100.89},
                Limit = 99999999,
                Name = "coffre fib"
            },
            {
                Pos = {x = 2518.30, y = -323.38, z = 100.89},
                Limit = 99999999,
                Name = "coffre saisies"
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

    --banker = {
    mazegroup = {
        label = "Maze Group",
        label2 = "Maze Group",
        iban = "mazegroup",
        grade = {
            {
                label = "CDD",
                salary = 120,
                name = "cdd",
                show = true,
                accessImmo = true,
                accessBank = false
            },
            {
                label = "Conseiller",
                salary = 140,
                name = "adviser",
                show = true,
                accessImmo = true,
                accessBank = false
            },
            {
                label = "Banquier",
                salary = 140,
                name = "banker",
                show = true,
                accessImmo = false,
                accessBank = true
            },
            {
                label = "Associé Junior",
                salary = 160,
                name = "junior",
                show = true,          
                accessImmo = false,
                accessBank = true
            },
            {
                label = "Chef d'équipe Immo",
                salary = 170,
                name = "teamleader",
                show = true,
                accessImmo = true,
                accessBank = false
            },
            {
                label = "Associé Senior",
                salary = 180,
                name = "senior",
                show = true,
                accessImmo = false,
                accessBank = true
            },
            {
                label = "Managing Partner",
                salary = 190,
                name = "managing",
                show = true,
                accessImmo = true,
                accessBank = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "pdg",
                show = true,
                accessImmo = true,
                accessBank = true
            }

        },
        -- Menu = {
        --     menu = {
        --         --title = "Banquier",
        --         title = "Maze Group"
        --         subtitle = "Actions disponibles",
        --         name = "Banquier_menuperso"
        --     },
        --     buttons = {
        --         {
        --             label = "Facture",
        --             onSelected = function()
        --                 CreateFacture("mazegroup")
        --             end,
        --             ActiveFct = function()
        --                 HoverPlayer()
        --             end
        --         },
        --         {
        --             label = "Annonce",
        --             onSelected = function()
        --                 exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
        --                 local text = exports['Snoupinput']:GetInput()
        --                 if text ~= false and text ~= "" then
        --                     TriggerServerEvent("Job:Annonce", "Banque", "Annonce", text, "CHAR_PACIFIC", 8, "Banquier")
        --                 end
        --             end
        --         },
        --     }
        --},
        Storage = {
            {
                Pos = {x = -1348.28, y = -491.69, z = 33.17},
                Limit = 500,
                Name = "Coffre PDG"
            },
            {
                Pos = {x = -1336.92, y = -493.50, z = 33.44},
                Limit = 500,
                Name = "Coffre Nourriture"
            },
            {
                Pos = {x = -1385.3851, y = -487.7128, z = 33.3436},
                Limit = 500,
                Name = "Coffre Cartes"
            }
        },
        garage = {
            Name = "Garage Banque",
            Pos = {x = -1372.063354, y = -478.504333, z = 31.594715},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {
                    {}
                },
                spawnpos = {x = -1372.063354, y = -478.504333, z = 31.594715, h = 10.00}
            },
            Blipdata = {
                Pos = {x = -1372.063354, y = -478.504333, z = 31.594715},
                Blipcolor = 7,
                Blipname = "Garage Maze Bank"
            }
        },
        garage2 = {
            Name = "Garage Immobilier",
            Pos = {x = -1373.6710, y = -468.852692, z = 31.594715},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -1373.6710, y = -468.852692, z = 31.594715, h = 190.00}
            },
            Blipdata = {
                Pos = {x = -1373.6710, y = -468.852692, z = 31.594715},
                Blipcolor = 5,
                Blipname = "Garage Maze Immo"
            }
        },
        Extrapos = {
            Banker = {
                Pos = {
                    --{x = 249.93, y = 230.25, z = 106.29}
                    {x = -1343.753296, y = -486.443207, z = 33.175743},
                    {x = -1332.736084, y = -500.569305, z = 33.175232},
                    {x = -1341.557617, y = -502.238342, z = 33.175751},
                    {x = -1350.048096, y = -503.473572, z = 33.175739},
                    {x = -1357.767456, y = -489.018005, z = 33.175743},
                    {x = -1380.793945, y = -486.817902, z = 33.343670},

                    --{x = -1303.006348, y = -498.962677, z = 33.761589}
                },
                restricted = {3, 4, 6, 7, 8},
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
        },
    },
    gouv = {
        label = "Gouvernement",
        label2 = "Gouvernement",
        iban = "gouvernement",
        grade = {
            {
                label = "Conseiller",
                salary = 350,
                name = "agent",
                show = true
            },
            {
                label = "Secrétaire d'état",
                salary = 400,
                name = "usdss",
                show = true
            },
            {
                label = "Chef de cabinet",
                salary = 430,
                name = "drh",
                show = true
            },
            {
                label = "Vice-Gouverneur",
                salary = 450,
                name = "drh",
                show = true
            },
            {
                label = "Gouverneur",
                salary = 500,
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
                Pos = {x = -1289.1510, y = -567.5328, z = 41.1882 - 0.98}, -- Bon coffre
                Limit = 2000,
                Name = "coffre_gouvernement2"
            },
            {
                Pos = {x = -1300.9404, y = -556.4752, z = 30.5667 - 0.98}, -- armurerie gouv
                Limit = 2000,
                Name = "coffre_gouvernement"
            },
            {
                Pos = {x = -1305.1618, y = -566.6479, z = 41.1881 - 0.98},  -- Coffre privé gouv
                Limit = 2000,
                Name = "coffre_gouvernement3"
            }
        },
        garage = {
            Name = "Garage gouvernement",
            Pos = {x = -1322.3785, y = -541.9343, z = 20.8027},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {
                    {}
                },
                spawnpos = {x = -1322.3785, y = -541.9343, z = 20.8027, h = 113.5321}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage Gouvernement"
            }
        },
        garage2 = {
            Name = "Garage saisies",
            Pos = {x = -1339.5908, y = -557.0335, z = 20.8027},
            Properties = {
                type = 3,
                Limit = 128,
                vehicles = {
                    {}
                },
                spawnpos = {x = -1339.5908, y = -557.0335, z = 20.8027, h = 241.20512}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage Gouvernement Saisies"
            }
        },
    },
    usss = {
        label = "Usss",
        label2 = "Usss",
        iban = "usss",
        grade = {
            {
                label = "Agent spécial",
                salary = 150,
                name = "agent",
                show = true
            },
            {
                label = "Agent Spécial ADJ en charge",
                salary = 200,
                name = "usdss",
                show = true
            },
            {
                label = "Agent Spécial principal",
                salary = 250,
                name = "proc",
                show = true
            },
            {
                label = "Directeur Adjoint",
                salary = 300,
                name = "drh",
                show = true
            },
            {
                label = "Directeur USSS",
                salary = 350,
                name = "boss",
                show = true
            }
        },
        CustomMenu = true,
        Menu = {
            menu = {
                title = "USSS",
                subtitle = "Actions disponibles",
                name = "Usss_menuperso"
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
                Pos = {x = -1300.9404, y = -556.4752, z = 30.5667 - 0.98}, -- Armurerie
                Limit = 2000,
                Name = "coffre_usss"
            },
            {
                Pos = {x = -1293.9604, y = -581.9467, z = 34.3748 - 0.98}, -- Coffre
                Limit = 2000,
                Name = "coffre_usss2"
            }
        },
        garage = {
            Name = "Garage saisies",
            Pos = {x = -1339.5908, y = -557.0335, z = 20.8027},
            Properties = {
                type = 3,
                Limit = 128,
                vehicles = {
                    {}
                },
                spawnpos = {x = -1339.5908, y = -557.0335, z = 20.8027, h = 241.20512}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage Gouvernement Saisies"
            }
        },
        garage2 = {
            Name = "Garage USSS",
            Pos = {x = -1320.8983, y = -557.3989, z = 20.8027},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {
                    {}
                },
                spawnpos = {x = -1320.8983, y = -557.3989, z = 20.8027, h = 89.453}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage USSS"
            }
        },
        garage3 = {
            Name = "Garage Helipad",
            Pos = {x = -1311.5385, y = -551.7341, z = 43.9235},
            Properties = {
                type = 2,
                Limit = 10,
                zonesize = 1.5,
                vehicles = {
                    {
                        name = "presheli2",
                        label = "Helicoptere Marine One",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = -1311.5385, y = -551.7341, z = 43.9235, h = 128.28}
            },
            Blipdata = {
                Pos = {x = -1311.5385, y = -551.7341, z = 43.9235},
                Blipcolor = 5,
                Blipname = "USSS - Helipad"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = -1290.15, y = -584.87, z = 34.37},
                vestiaire = {
                    type = "Vestiaire",
                    workSize = 1.45,
                    Pos = {x = -1290.15, y = -584.87, z = 34.37},
                    Tenues = TenueUSSS
                }
            }
        },
        Extrapos = {
            ExtraVehicle = {
                Pos = {
                    {x = -1330.87, y = -584.88, z = 20.80}
                },
                restricted = {1, 2, 3, 4, 5},
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
                    name = "USSS - Extras"
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
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "D.O.J", "Annonce", text, "CHAR_DOJ", 8, "D.O.J")
                        end
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
                Pos = {x = 612.56, y = 2765.39, z = 41.09},
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
                salary = 300,
                name = "ambulancier",
                show = true
            },
            {
                label = "Infirmier",
                salary = 320,
                name = "infirmier",
                show = true
            },
            {
                label = "Médecin",
                salary = 340,
                name = "medecin",
                show = true
            },
            {
                label = "Spécialiste",
                salary = 360,
                name = "medecin",
                show = true
            },
            {
                label = "Chef de service",
                salary = 380,
                name = "drh",
                show = true
            },
            {
                label = "Directeur adjoint",
                salary = 400,
                name = "drh",
                show = true
            },
            {
                label = "Directeur",
                salary = 430,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage SAMS Los Santos",
            Pos = {x = -1841.22, y = -379.95, z = 40.73 - 0.98},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = -1841.22, y = -379.95, z = 40.73, h = 319.38}
            },
            Blipdata = {
                Pos = {x = -1841.22, y = -379.95, z = 40.73},
                Blipcolor = 7,
                Blipname = "SAMS - Garage Los Santos"
            }
        },
        garage2 = {
            Name = "Garage SAMS Sandy Shores",
            Pos = {x = 1840.37, y = 3667.2, z = 32.68 - 0.98},
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
        garage3 = {
            Name = "Garage SAMS Los Santos 2",
            Pos = {x = -1822.6702, y = -381.0412, z = 40.73 - 0.98},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = -1822.6702, y = -381.0412, z = 40.73, h = 319.38}
            },
            Blipdata = {
                Pos = {x = -1822.6702, y = -381.0412, z = 40.73},
                Blipcolor = 7,
                Blipname = "SAMS - Garage Los Santos 2"
            }
        },
        garage4 = {
            Name = "Garage SAMS Los Santos 3",
            Pos = {x = -1822.7004, y = -381.4256, z = 40.73 - 0.98},
            Properties = {
                type = 3,
                Limit = 64,
                vehicles = {},
                spawnpos = {x = -1822.7004, y = -381.4256, z = 40.73, h = 319.38}
            },
            Blipdata = {
                Pos = {x = -1822.7004, y = -381.4256, z = 40.73},
                Blipcolor = 7,
                Blipname = "SAMS - Garage Los Santos 3"
            }
        },
        Storage = {
            {
                Pos = {x = -1870.05, y = -338.50, z = 53.75 - 0.98},
                Limit = 2500,
                Name = "Coffre SAMS"
            },

            {
                Pos = {x = -1829.19, y = -384.37, z = 49.39 - 0.98},
                Limit = 2500,
                Name = "Coffre Pharmacie"
            },
            
            {
                Pos = {x = 1843.83, y = 3681, z = 33.27},
                Limit = 2500,
                Name = "Coffre SAMS"
            }
        },
        garage3 = {
            Name = "Helipad Hopital",
            Pos = {x = -1867.18, y = -352.69, z = 58.03 - 0.98},
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
                spawnpos = {x = -1867.18, y = -352.69, z = 58.03, h = 151.11}
            },
            Blipdata = {
                Pos = {x = -1867.18, y = -352.69, z = 58.03},
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
                ["Action objets"] = {
                    submenu = "ambulance_menuperso",
                    title = "Placer objets",
                    menus = {
                        buttons = {
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
                            },
                            {
                                label = "Sortir une chaise roulante",
                                onSelected = function()
                                    ExecuteCommand("wheelchair")
                                end
                            },
                            {
                                label = "Ranger une chaise roulante",
                                onSelected = function()
                                    ExecuteCommand("removewheelchair")
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
                        CreateFacture("lsms")
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
                Pos = {x = -1813.41, y = -357.94, z = 49.46 - 0.98},
                Tenues = {
                    ["Biohazard"] = {
                        male = {
                            ["tshirt_1"] = 62,
                            ["tshirt_2"] = 3,
                            ["torso_1"] = 67,
                            ["torso_2"] = 3,
                            ["decals_1"] = -1,
                            ["decals_2"] = 0,
                            ["arms"] = 88,
                            ["pants_1"] = 40,
                            ["pants_2"] = 3,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 42,
                            ["tshirt_2"] = 3,
                            ["torso_1"] = 61,
                            ["torso_2"] = 3,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 101,
                            ["pants_1"] = 40,
                            ["pants_2"] = 3,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Chirurgien"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 32,
                            ["torso_2"] = 1,
                            ["decals_1"] = -1,
                            ["decals_2"] = 0,
                            ["arms"] = 85,
                            ["pants_1"] = 45,
                            ["pants_2"] = 1,
                            ["shoes_1"] = 42,
                            ["shoes_2"] = 2,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 102,
                            ["chain_2"] = 3,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 14,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 31,
                            ["torso_2"] = 1,
                            ["decals_1"] = -1,
                            ["decals_2"] = 0,
                            ["arms"] = 109,
                            ["pants_1"] = 47,
                            ["pants_2"] = 1,
                            ["shoes_1"] = 10,
                            ["shoes_2"] = 1,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 102,
                            ["chain_2"] = 3,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        }
                    },
                    ["Medecin"] = {
                        male = {
                            ["tshirt_1"] = 40,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 115,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 4,
                            ["pants_1"] = 45,
                            ["pants_2"] = 1,
                            ["shoes_1"] = 99,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 116,
                            ["chain_2"] = 6,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 16,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 107,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 109,
                            ["pants_1"] = 47,
                            ["pants_2"] = 1,
                            ["shoes_1"] = 10,
                            ["shoes_2"] = 1,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 87,
                            ["chain_2"] = 6,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Coroner"] = {
                        male = {
                            ["tshirt_1"] = 178,
                            ["tshirt_2"] = 5,
                            ["torso_1"] = 307,
                            ["torso_2"] = 20,
                            ["decals_1"] = -1,
                            ["decals_2"] = 0,
                            ["arms"] = 88,
                            ["pants_1"] = 10,
                            ["pants_2"] = 4,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 38,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 38,
                            ["tshirt_2"] = 2,
                            ["torso_1"] = 294,
                            ["torso_2"] = 20,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 3,
                            ["pants_2"] = 4,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 20,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        },
                    },
                    ["Class A"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 215,
                            ["torso_2"] = 6,
                            ["decals_1"] = -1,
                            ["decals_2"] = 0,
                            ["arms"] = 4,
                            ["pants_1"] = 35,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 93,
                            ["bags_2"] = 1
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 219,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 93,
                            ["bags_2"] = 1
                        }
                    },
                    ["Class B"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 214,
                            ["torso_2"] = 6,
                            ["decals_1"] = -1,
                            ["decals_2"] = 0,
                            ["arms"] = 86,
                            ["pants_1"] = 101,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 30,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 93,
                            ["bags_2"] = 1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 218,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 101,
                            ["pants_1"] = 105,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 14,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 93,
                            ["bags_2"] = 1
                        }
                    },
                    ["Class C"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 213,
                            ["torso_2"] = 6,
                            ["decals_1"] = -1,
                            ["decals_2"] = 0,
                            ["arms"] = 92,
                            ["pants_1"] = 101,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 30,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 93,
                            ["bags_2"] = 1
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 217,
                            ["torso_2"] = 6,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 109,
                            ["pants_1"] = 105,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 14,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 93,
                            ["bags_2"] = 1
                        }
                    },
                    ["Pull"] = {
                        male = {
                            ["tshirt_1"] = 54,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 239,
                            ["torso_2"] = 15,
                            ["decals_1"] = -1,
                            ["decals_2"] = 0,
                            ["arms"] = 86,
                            ["pants_1"] = 101,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
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
                            ["torso_1"] = 223,
                            ["torso_2"] = 15,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 101,
                            ["pants_1"] = 105,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 14,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                    ["Patient"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 104,
                            ["torso_2"] = 0,
                            ["decals_1"] = -1,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 29,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 34,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1
                        },
                        female = {
                            ["tshirt_1"] = 14,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 95,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 8,
                            ["pants_1"] = 17,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 35,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0
                        }
                    },
                },
            },
        },
        Extrapos = {
            ExtraVehicle = {
                Pos = {
                    {x = -1826.30, y = -387.30, z = 40.64}
                },
                restricted = {1, 2, 3, 4, 5, 6, 7},
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
                    name = "SAMS - Extras"
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

    lsfd = {
        label = "LSFD",
        label2 = "LSFD",
        iban = "lsfd",
        grade = {
            {
                label = "Recrue",
                salary = 300,
                name = "recrue",
                show = true
            },
            {
                label = "pompier class 2",
                salary = 310,
                name = "ambulancier",
                show = true
            },
            {
                label = "pompier class 1 ",
                salary = 320,
                name = "pompier",
                show = true
            },
            {
                label = "sergent",
                salary = 340,
                name = "lieutenant",
                show = true
            },
            {
                label = "lieutenant",
                salary = 370,
                name = "drh",
                show = true
            },
            {
                label = "capitaine",
                salary = 390,
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
        Menu = {
            menu = {
                title = "Pompier",
                subtitle = "Actions disponibles",
                name = "pompier_menuperso"
            },
            submenus = {
                ["Soins"] = {
                    submenu = "pompier_menuperso",
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
                            }
                        }
                    }
                },
                ["Actions véhicule"] = {
                    submenu = "pompier_menuperso",
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
                ["Action objets"] = {
                    submenu = "pompier_menuperso",
                    title = "Placer objets",
                    menus = {
                        buttons = {
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
                                label = "Sortir/Ranger l'écarteur hydraulique",
                                onSelected = function()
                                    ExecuteCommand("spreaders script")
                                end
                            },
                            {
                                label = "Sortir les pistons hydrauliques",
                                onSelected = function()
                                    ExecuteCommand("stabilisers setup script")
                                end
                            },
                            {
                                label = "Sortir les pistons hydrauliques",
                                onSelected = function()
                                    ExecuteCommand("stabilisers remove script")
                                end
                            },
                            {
                                label = "Supprimer un cone",
                                onSelected = function()
                                    DeleteCone()
                                end
                            }
                        },
                        submenu = {}
                    }
                },
                ["Actions brancard"] = {
                    submenu = "pompier_menuperso",
                    title = "Actions brancard",
                    menus = {
                        buttons = {
                            {
                                label = "Sortir le brancard de l'ambulance",
                                onSelected = function()
                                    Pompier.GetOffStretcher()
                                end,
                                ActiveFct = function()
                                    Pompier.DrawMarkerVehicle()
                                end
                            },
                            {
                                label = "Mettre le brancard dans l'ambulance",
                                onSelected = function()
                                    Pompier.PutStretcherOnVehicle()
                                end,
                                ActiveFct = function()
                                    Pompier.DrawMarkerVehicle()
                                end
                            },
                            {
                                label = "Prendre/Déposer le brancard",
                                onSelected = function()
                                    Pompier.PickPutStretcher()
                                end,
                                ActiveFct = function()
                                    if not pickStretcher then
                                        Pompier.DrawMarkerStretcher(true)
                                    end
                                end
                            },
                            {
                                label = "Mettre/Descendre la personne du brancard",
                                onSelected = function()
                                    Pompier.PutOnStretcher()
                                end,
                                ActiveFct = function()
                                    Pompier.DrawMarkerStretcher(false)
                                    Pompier.DrawMarkerOnPed()
                                end
                            },
                            {
                                label = "Ranger le brancard",
                                onSelected = function()
                                    Pompier.RemoveStretcher()
                                end,
                                ActiveFct = function()
                                    Pompier.DrawMarkerStretcher(true)
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
                        CreateFacture("lsfd")
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
                    label = "Informations effectifs",
                    onSelected = function()
                        TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "lsfd")
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "LSFD ", "Annonce", text, "CHAR_CALL911", 8, "LSFD")
                            --TriggerServerEvent("Job:Annonce", "LSFD", "Annonce", text, "CHAR_CALL911", 8, "LSFD")
                        end
                    end
                },
                {
                    label = "Bipeur: Supprimer les interventions",
                    onSelected = function()
                        Ora.Jobs.Firefighter.Dispatch:clear(0)
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
                Pos = {x = 1227.15, y = -1491.41, z = 34.49},
                Tenues = {
                    ["Batallion chief chemise"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 215,
                            ["torso_2"] = 10,
                            ["decals_1"] = 26,
                            ["decals_2"] = 0,
                            ["arms"] = 4,
                            ["pants_1"] = 35,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 3
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 219,
                            ["torso_2"] = 10,
                            ["decals_1"] = 25,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 34,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 3
                        }
                    },
                    ["Class A Captain"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 118,
                            ["torso_2"] = 0,
                            ["decals_1"] = 27,
                            ["decals_2"] = 0,
                            ["arms"] = 4,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 2
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 18,
                            ["torso_2"] = 0,
                            ["decals_1"] = 26,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 3,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 2
                        }
                    },
                    ["Class B Captain"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 75,
                            ["torso_2"] = 1,
                            ["decals_1"] = 29,
                            ["decals_2"] = 0,
                            ["arms"] = 4,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 2
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 1,
                            ["decals_1"] = 28,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 3,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 2
                        }
                    },
                    ["Class C Captain"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 74,
                            ["torso_2"] = 1,
                            ["decals_1"] = 29,
                            ["decals_2"] = 0,
                            ["arms"] = 11,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 2
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 1,
                            ["decals_1"] = 0,
                            ["decals_2"] = 28,
                            ["arms"] = 9,
                            ["pants_1"] = 3,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 2
                        }
                    },
                    ["Class A Lieutnant"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 118,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 4,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 18,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 3,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        }
                    },
                    ["Class B Lieutnant"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 75,
                            ["torso_2"] = 1,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 4,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 1,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 3,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        }
                    },
                    ["Class C Lieutnant"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 74,
                            ["torso_2"] = 1,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 11,
                            ["pants_1"] = 10,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 1,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 9,
                            ["pants_1"] = 3,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        }
                    },
                    ["Class A LSFD"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 118,
                            ["torso_2"] = 7,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 4,
                            ["pants_1"] = 25,
                            ["pants_2"] = 3,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 18,
                            ["torso_2"] = 7,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 3,
                            ["pants_2"] = 3,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        }
                    },
                    ["Class B LSFD"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 75,
                            ["torso_2"] = 7,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 4,
                            ["pants_1"] = 25,
                            ["pants_2"] = 3,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 7,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 3,
                            ["pants_2"] = 3,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        }
                    },
                    ["Class C LSFD"] = {
                        male = {
                            ["tshirt_1"] = 88,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 74,
                            ["torso_2"] = 7,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 11,
                            ["pants_1"] = 25,
                            ["pants_2"] = 3,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        },
                        female = {
                            ["tshirt_1"] = 7,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 7,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 8,
                            ["pants_1"] = 3,
                            ["pants_2"] = 3,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 1
                        }
                    },
                    ["Class A EMT"] = {
                        male = {
                            ["tshirt_1"] = 87,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 118,
                            ["torso_2"] = 1,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 86,
                            ["pants_1"] = 101,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 65,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 18,
                            ["torso_2"] = 1,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 101,
                            ["pants_1"] = 105,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 0
                        }
                    },
                    ["Class B EMT"] = {
                        male = {
                            ["tshirt_1"] = 87,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 75,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 86,
                            ["pants_1"] = 101,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 65,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 26,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 101,
                            ["pants_1"] = 105,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 0
                        }
                    },
                    ["Class C EMT"] = {
                        male = {
                            ["tshirt_1"] = 87,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 74,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 92,
                            ["pants_1"] = 101,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 57,
                            ["bags_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 65,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 25,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 106,
                            ["pants_1"] = 105,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 57,
                            ["bags_2"] = 0
                        }
                    },
                    ["Tenue Feu"] = {
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
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 45,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 28,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 187,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 325,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 207,
                            ["pants_1"] = 126,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 44,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 28,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue Feu Engineer"] = {
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
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 45,
                            ["helmet_2"] = 1,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 28,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 187,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 325,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 207,
                            ["pants_1"] = 126,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 44,
                            ["helmet_2"] = 1,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 28,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue Feu A/O"] = {
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
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 45,
                            ["helmet_2"] = 2,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 28,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 187,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 325,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 207,
                            ["pants_1"] = 126,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 44,
                            ["helmet_2"] = 2,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 28,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue Feu Captain"] = {
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
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 44,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 28,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 187,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 325,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 207,
                            ["pants_1"] = 126,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 43,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 28,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue Feu Battalion chief"] = {
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
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 44,
                            ["helmet_2"] = 1,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 28,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 187,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 325,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 207,
                            ["pants_1"] = 126,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 43,
                            ["helmet_2"] = 1,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 28,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue Apres feu"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 73,
                            ["torso_2"] = 16,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 0,
                            ["pants_1"] = 120,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 14,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 224,
                            ["torso_2"] = 21,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 14,
                            ["pants_1"] = 126,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue Apres feu"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 73,
                            ["torso_2"] = 16,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 0,
                            ["pants_1"] = 120,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 18,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 14,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 224,
                            ["torso_2"] = 21,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 14,
                            ["pants_1"] = 126,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 12,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue Extraction feu"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 314,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 0,
                            ["pants_1"] = 101,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 137,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 14,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 325,
                            ["torso_2"] = 0,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 109,
                            ["pants_1"] = 105,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 136,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue Fire Investigator"] = {
                        male = {
                            ["tshirt_1"] = 28,
                            ["tshirt_2"] = 3,
                            ["torso_1"] = 307,
                            ["torso_2"] = 21,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 1,
                            ["pants_1"] = 86,
                            ["pants_2"] = 6,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 138,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 58,
                            ["bags_2"] = 9,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 23,
                            ["tshirt_2"] = 3,
                            ["torso_1"] = 318,
                            ["torso_2"] = 21,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 104,
                            ["pants_1"] = 90,
                            ["pants_2"] = 6,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 137,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 58,
                            ["bags_2"] = 9,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue Air Operations"] = {
                        male = {
                            ["tshirt_1"] = 15,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 108,
                            ["torso_2"] = 5,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 4,
                            ["pants_1"] = 64,
                            ["pants_2"] = 2,
                            ["shoes_1"] = 25,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 78,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 14,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 99,
                            ["torso_2"] = 5,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 3,
                            ["pants_1"] = 66,
                            ["pants_2"] = 2,
                            ["shoes_1"] = 24,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 78,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue t-shirt"] = {
                        male = {
                            ["tshirt_1"] = 87,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 73,
                            ["torso_2"] = 16,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 85,
                            ["pants_1"] = 101,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 6,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 224,
                            ["torso_2"] = 21,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 109,
                            ["pants_1"] = 105,
                            ["pants_2"] = 0,
                            ["shoes_1"] = 52,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = -1,
                            ["helmet_2"] = 0,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 0,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        }
                    },
                    ["Tenue USAR"] = {
                        male = {
                            ["tshirt_1"] = 68,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 73,
                            ["torso_2"] = 16,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 171,
                            ["pants_1"] = 120,
                            ["pants_2"] = 1,
                            ["shoes_1"] = 51,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 89,
                            ["helmet_2"] = 4,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = -1,
                            ["ears_2"] = -1,
                            ["bags_1"] = 19,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        },
                        female = {
                            ["tshirt_1"] = 48,
                            ["tshirt_2"] = 0,
                            ["torso_1"] = 224,
                            ["torso_2"] = 21,
                            ["decals_1"] = 0,
                            ["decals_2"] = 0,
                            ["arms"] = 44,
                            ["pants_1"] = 126,
                            ["pants_2"] = 1,
                            ["shoes_1"] = 55,
                            ["shoes_2"] = 0,
                            ["helmet_1"] = 88,
                            ["helmet_2"] = 4,
                            ["chain_1"] = 0,
                            ["chain_2"] = 0,
                            ["ears_1"] = 0,
                            ["ears_2"] = 0,
                            ["bags_1"] = 19,
                            ["bags_2"] = 0,
                            ["mask_1"] = 0,
                            ["mask_2"] = 0
                        }
                    },
                }
            }
        },
        Extrapos = {
            ExtraVehicle = {
                Pos = {
                    {x = 1219.14, y = -1522.11, z = 34.69 - 0.98}
                },
                restricted = {1, 2, 3, 4, 5, 6, 7},
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
                    name = "LSFD - Extras"
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

    bennys = {
        label = "Benny's",
        label2 = "Benny's",
        iban = "bennys",
        isMechanics = true,
        grade = {
            {
                label = "CDD",
                salary = 120,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 140,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 160,
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
                salary = 120,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 140,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 160,
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
                zonesize = 3,
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
                    {x = -329.2701, y = -160.3248, z = 35.60},
                    {x = -327.2104, y = -152.2423, z = 35.60},
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
                Limit = 500,
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
                salary = 150,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 150,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 150,
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
                    label = "Inspecter la plaque",
                    onSelected = function()
                        Police.PlateCheck()
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
                    label = "Sortir la remorque à voitures",
                    onSelected = function()
                        if (Ora.Identity.Job:GetRank() >= 3) then
                            Mecano.SpawnCarRemorque()
                        else
                            RageUI.Popup({message = "~r~Vous ne pouvez pas faire ça !"})
                        end
                    end
                },
                {
                    label = "Sortir la remorque à camions",
                    onSelected = function()
                        if (Ora.Identity.Job:GetRank() >= 3) then
                            Mecano.SpawnTruckRemorque()
                        else
                            RageUI.Popup({message = "~r~Vous ne pouvez pas faire ça !"})
                        end
                    end
                },
                {
                    label = "Ranger la remorque",
                    onSelected = function()
                        Mecano.RangerRemorque()
                    end
                },
                {
                    label = "Sortir la rampe",
                    onSelected = function()
                        Mecano.SortirRampe()
                    end
                },
                {
                    label = "Ranger la rampe",
                    onSelected = function()
                        Mecano.RangerRampe()
                    end
                },
                {
                    label = "Attacher le véhicule",
                    onSelected = function()
                        Mecano.AttacherVehicle()
                    end
                },
                {
                    label = "Détacher le véhicule",
                    onSelected = function()
                        Mecano.DetacherVehicle()
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
                            TriggerServerEvent("Job:Annonce", "EVANS MotorSport", "Annonce", text, "CHAR_EVANS", 8, "Concessionnaire")
                        end
                    end
                }
            }
        },
        Extrapos = {
            LSCustoms = {
                Pos = {
                    {x = 135.13, y = -1091.72, z = 28.61}
                },
                Enter = function()
                    EnterZoneLSC_CONCESS()
                end,
                Exit = function()
                    ExitZoneLSC_CONCESS()
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
        garage = {
            Name = "Garage Concessionnaire",
            Pos = {x = 142.71, y = -1064.21, z = 28.19},
            illimity = true,
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 142.71, y = -1064.21, z = 28.19, h = 80.18}
            },
            Blipdata = {
                Pos = {x = 142.71, y = -1064.21, z = 28.19},
                Blipcolor = 5,
                Blipname = "Garage Concessionnaire"
            }
        },
        garage2 = {
            Name = "Garage Concessionnaire2",
            Pos = {x = 126.96, y = -1104.08, z = 28.19},
            illimity = true,
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 126.96, y = -1104.08, z = 28.19, h = 113.24}
            },
            Blipdata = {
                Pos = {x = 126.96, y = -1104.08, z = 28.19},
                Blipcolor = 5,
                Blipname = "Garage Concessionnaire2"
            }
        },
        Storage = {
            {
                Pos = {x = 131.5, y = -1088.93, z = 28.2},
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
                Pos = {x = 292.54, y = -1166.52, z = 29.24},
                Limit = 100,
                Name = "coffre Moto"
            }
        },
        garage = {
            Name = "Garage Moto",
            Pos = {x = 315.78, y = -1157.97, z = 29.29},
            illimity = true,
            Properties = {
                type = 3,
                -- = garage societe
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 315.78, y = -1157.97, z = 29.29, a = 357.20}
            },
            Blipdata = {
                Pos = {x = 315.78, y = -1157.97, z = 29.29},
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
                    label = "Sortir la remorque à camions",
                    onSelected = function()
                        if (Ora.Identity.Job:GetRank() >= 3) then
                            Mecano.SpawnTruckRemorqueN()
                        else
                            RageUI.Popup({message = "~r~Vous ne pouvez pas faire ça !"})
                        end
                    end
                },
                {
                    label = "Ranger la remorque",
                    onSelected = function()
                        Mecano.RangerRemorqueN()
                    end
                },
                {
                    label = "Sortir la rampe",
                    onSelected = function()
                        Mecano.SortirRampe()
                    end
                },
                {
                    label = "Ranger la rampe",
                    onSelected = function()
                        Mecano.RangerRampe()
                    end
                },
                {
                    label = "Attacher le véhicule",
                    onSelected = function()
                        Mecano.AttacherVehicle()
                    end
                },
                {
                    label = "Détacher le véhicule",
                    onSelected = function()
                        Mecano.DetacherVehicle()
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
            Name = "Garage Cerberus",
            Pos = {x = 4971.57, y = -5746.44, z = 19.88},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 4971.57, y = -5746.44, z = 19.88, h = 1.17}
            },
            Blipdata = {
                Pos = {x = 4971.57, y = -5746.44, z = 19.88},
                Blipcolor = 5,
                Blipname = "Garage Cerberus"
            }
        },
        garage2 = {
            Name = "Garage Cerberus2",
            Pos = {x = 4487.63, y = -4465.17, z = 4.22},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = 4487.63, y = -4465.17, z = 4.22, h = 1.17}
            },
            Blipdata = {
                Pos = {x = 4487.63, y = -4465.17, z = 4.22},
                Blipcolor = 5,
                Blipname = "Garage Cerberus2"
            }
        },
        garage3 = {
            Name = "Garage Cerberus3",
            Pos = {x = -970.16, y = -3000.53, z = 13.94},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -970.16, y = -3000.53, z = 13.94, h = 1.17}
            },
            Blipdata = {
                Pos = {x = -970.16, y = -3000.53, z = 13.94},
                Blipcolor = 5,
                Blipname = "Garage Cerberus3"
            }
        },
        garage4 = {
            Name = "Garage Cerberus3",
            Pos = {x = -169.15, y =  -589.18, z = 32.42},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x =  -169.15, y =  -589.18, z = 32.42, h = 1.17}
            },
            Blipdata = {
                Pos = {x =  -169.15, y =  -589.18, z = 32.42},
                Blipcolor = 5,
                Blipname = "Garage Cerberus3"
            }
        },
        Storage = {
            {
                Pos = {x = 5005.33, y = -5754.53, z = 28.84},
                Limit = 5000,
                Name = "coffre cerberus"
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
                Pos = {x = 980.90, y = 24.39, z = 71.46 - 0.94},
                Limit = 1000,
                Name = "coffre_casino"
            }
        }
    },
    pegasus = {
        label = "Pegasus",
        label2 = "Pegasus",
        iban = "pegasus",
        grade = {
            {
                label = "CDD",
                salary = 120,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 140,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 160,
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
            Name = "Garage Pegasus",
            Pos = {x = -1661.75, y = -3159.05, z = 13.99},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -1661.75, y = -3159.05, z = 13.99, h = 329.37}
            },
            Blipdata = {
                Pos = {x = -1661.75, y = -3159.05, z = 13.99},
                Blipcolor = 5,
                Blipname = "Garage Pegasus"
            }
        },
        garage2 = {
            Name = "Garage Bateau",
            Pos = {x = -806.63, y = -1491.58, z = 1.6},
            Properties = {
                type = 3,
                Limit = 6,
                zonesize = 5.0,
                vehicles = {},
                spawnpos = {x = -806.63, y = -1491.58, z = 0.12, h = 112.53}
            },
            Blipdata = {
                Pos = {x = -806.63, y = -1491.58, z = 1.6},
                Blipcolor = 5,
                Blipname = "Pegasus - Bateaux"
            }
        },
        Storage = {
            {
                Pos = {x = -1631.18, y = -3163.04, z = 12.99},
                Limit = 500,
                Name = "coffre pegasus"
            }
        },
        Menu = {
            menu = {
                title = "Pegasus",
                subtitle = "Actions disponibles",
                name = "pegasus_menuperso"
            },
            buttons = {
                {
                label = "Facture",
                onSelected = function()
                    CreateFacture("pegasus")
                end,
                ActiveFct = function()
                    HoverPlayer()
                end
                },
                {
                    label = "Employés en service",
                    onSelected = function()
                        TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "pegasus")
                    end
                },
                {
                    label = "Commencer une mission",
                    onSelected = function()
                        if LocalPlayer().FarmLimit >= 600 then
                            ShowNotification("Vous avez atteint votre limite de missions journalière.")
                        else
                            StartpegasusMission()
                        end
                    end
                },
                {
                label = "Annonce",
                onSelected = function()
                    exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                    local text = exports['Snoupinput']:GetInput()
                    if text ~= false and text ~= "" then
                        TriggerServerEvent("Job:Annonce", "Pegasus", "Annonce", text, "CHAR_PEGASUS", 8, "Pegasus")
                    end
                end
                }
            }
        }
    },
    -- immo = {
    --     label = "Agent Immobilier",
    --     label2 = "Agent Immobilier",
    --     iban = "immo",
    --     grade = {
    --         {
    --             label = "CDD",
    --             salary = 150,
    --             name = "cdd",
    --             show = true
    --         },
    --         {
    --             label = "Conseiller",
    --             salary = 160,
    --             name = "cdi",
    --             show = true
    --         },
    --         {
    --             label = "Responsable d'équipe",
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
    --         Name = "Garage Immobilier",
    --         Pos = {x = -760.303405, y = 276.9277, z = 84.7320},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = -760.303405, y = 276.9277, z = 84.7320, h = 7.31228637}
    --         },
    --         Blipdata = {
    --             Pos = {x = -760.303405, y = 276.9277, z = 84.7320},
    --             Blipcolor = 5,
    --             Blipname = "Garage Immobilier"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = -717.8853, y = 260.5183105, z = 83.1377},
    --             Limit = 300,
    --             Name = "Coffre Immobilier"
    --         }
    --     }
    -- },
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
        },
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 803.1325, y = 2175.2553, z = 53.0708 - 0.98},
                giveitem = "graincafe1",
                blipcolor = 7,
                blipname = "Unicorn - Récolte du café",
                add = "~p~+ 1 Graine de Café",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            traitement2 = {
                --Café
                type = "traitement",
                workSize = 10.0,
                blipcolor = 7,
                blipname = "Unicorn - Traitement Café",
                Pos = {x = 2542.21, y = 2584.90, z = 37.00},
                required = "graincafe1",
                giveitem = "cafe",
                RemoveItem = "graincafe1",
                add = "~p~+ 1  Café"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Unicorn - Vente",
                Pos = {x = 1093.24, y = -364.12, z = 67.04 - 0.98},
                required = "cafe",
                price = math.random(13, 16),
                add = "~p~- 1 Café"
            }
        },
    },
    koi = {
        label = "Koi",
        label2 = "Koi",
        iban = "koi",
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
                title = "Koi",
                subtitle = "Actions disponibles",
                name = "restaurant_menuperso"
            },
            buttons = {
                -- {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("koi")
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
                            TriggerServerEvent("Job:Annonce", "Koi", "Annonce", text, "CHAR_PEARLS", 8, "Koi")
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage Koi",
            Pos = {x = -1012.4503, y = -1462.4267, z = 5.01},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -1012.4503, y = -1462.4267, z = 5.01, h = 318.24}
            },
            Blipdata = {
                Pos = {x = -1012.4503, y = -1462.4267, z = 5.01, h = 318.24},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = -1039.4825, y = -1477.8227, z = 1.63},
                Limit = 500,
                Name = "coffre_koi2"
            },
            {
                Pos = {x = -1023.2456, y = -1470.3432, z = 5.30},
                Limit = 500,
                Name = "coffre_koi"
            },
            {
                Pos = {x = -1836.73, y = -1176.40, z = 18.20},
                Limit = 200,
                Name = "coffre_koi_bureau"
            }
        },
        Extrapos = {
            CraftSpiritueux = {
                Pos = {
                    {x = -1026.1946, y = -1472.5821, z = 5.30 - 0.98}
                },
                restricted = {1, 2, 3, 4, 5},
                Enter = function()
                    EntercraftKoiZone()
                end,
                Exit = function()
                    ExitcraftkoiZone()
                end,
                zonesize = 3.5,
                Blips = {
                    sprite = 93,
                    color = 81,
                    name = "Koi - Alambique"
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
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 803.1325, y = 2175.2553, z = 53.0708 - 0.98},
                giveitem = "graincafe1",
                blipcolor = 7,
                blipname = "koi - Récolte du café",
                add = "~p~+ 1 Graine de Café",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            traitement = {
                --Café
                type = "traitement",
                workSize = 10.0,
                blipcolor = 7,
                blipname = "koi - Traitement Café",
                Pos = {x = 2542.21, y = 2584.90, z = 37.00},
                required = "graincafe1",
                giveitem = "cafe",
                RemoveItem = "graincafe1",
                add = "~p~+ 1  Café"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "koi - Vente",
                Pos = {x = 1249.4327, y = -349.8305, z = 69.20 - 0.98},
                required = "cafe",
                price = math.random(13,16),
                add = "~p~- 1 Café"
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
                Pos = {x = -1378.0623, y = -625.5050, z = 35.00},
                Limit = 100,
                Name = "Coffre_Patronbahama"
            },
            {
                Pos = {x = -1378.5832, y = -594.6552, z = 29.30},
                Limit = 1000,
                Name = "Frigo_Bahama"
            },
            {
                Pos = {x = -1385.6295, y = -627.2821, z = 35.00},
                Limit = 1000,
                Name = "Frigo_Bahama2"
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
                            TriggerServerEvent("Job:Annonce", "Bahama's", "Annonce", text, "CHAR_BAHAMAS", 8, "Bahamas")
                        end
                    end
                }
            }
        },
        Extrapos = {
            CraftSpiritueux = {
                Pos = {
                    {x = -1378.0197, y = -598.6028, z = 30.2164}
                },
                restricted = {1, 2, 3, 4, 5},
                Enter = function()
                    EntercraftbahamasZone()
                end,
                Exit = function()
                    ExitcraftbahamasZone()
                end,
                zonesize = 2.5,
                Blips = {
                    sprite = 93,
                    color = 81,
                    name = "Bahamas - Alambique"
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
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 717.60, y = -978.55, z = 24.11},
                giveitem = "aperitif",
                blipcolor = 7,
                blipname = "Bahama's- Récolte",
                add = "~p~+ 1 Apéritif",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            traitement = {
                type = "traitement",
                workSize = 7.45,
                blipcolor = 7,
                blipname = "Bahama's - Traitement",
                Pos = {x = 2553.31, y = 4670.74, z = 32.95},
                required = "aperitif",
                giveitem = "tacos",
                add = "~p~+ 1  tacos"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Bahama's - Vente",
                Pos = {x = -1113.61, y = -1367.55, z = 5.01},
                required = "tacos",
                price = math.random(13, 16),
                add = "~p~- 1 tacos"
            }
        },
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
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 717.60, y = -978.55, z = 24.11},
                giveitem = "aperitif",
                blipcolor = 7,
                blipname = "Bar - Vendeur de bretzel",
                add = "~p~+ 1 Apéritif",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            traitement = {
                type = "traitement",
                workSize = 7.45,
                blipcolor = 7,
                blipname = "Bar - Produire des céréales",
                Pos = {x = 2553.31, y = 4670.74, z = 32.95},
                required = "aperitif",
                giveitem = "tacos",
                add = "~p~+ 1  tacos"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Bar - Vente",
                Pos = {x = -1113.61, y = -1367.55, z = 5.01},
                required = "tacos",
                price = math.random(13, 16),
                add = "~p~- 1 tacos"
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
                            TriggerServerEvent("Job:Annonce", "Yellow Jack", "Annonce", text, "CHAR_YELLOW", 8, "Yellow Jack")
                        end
                    end
                }
            }
        },
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 2308.1484, y = 4753.1831, z = 37.1395},
                giveitem = "chairsaucisse",
                blipcolor = 7,
                blipname = "Yellow Jack - Récolte",
                add = "~p~+ 1 Chair à saucisse",
                anim = {
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
                }
            },
            traitement = {
                type = "traitement",
                workSize = 7.45,
                blipcolor = 7,
                blipname = "Yellow Jack - Traitement",
                Pos = {x = -119.5579, y = 6214.8745, z = 31.1982},
                required = "chairsaucisse",
                giveitem = "saucissonsec",
                add = "~p~+ 1  Saucisson Sec"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Yellow Jack - Vente",
                Pos = {x = 1964.8208, y = 3752.9167, z = 32.2464},
                required = "saucissonsec",
                price = math.random(13, 16),
                add = "~p~- 1 Saucisson Sec"
            }
        }
    },
    henhouse = {
        label = "The Hen House",
        label2 = "The Hen House",
        iban = "henhouse",
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
            Name = "Garage The Hen House",
            Pos = {x = -313.14, y = 6275.55, z = 30.50},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -313.14, y = 6275.55, z = 30.50, h = 140.74}
            },
            Blipdata = {
                Pos = {x = -313.14, y = 6275.55, z = 30.50},
                Blipcolor = 5,
                Blipname = "Garage The Hen House"
            }
        },
        Storage = {
            {
                Pos = {x = -294.92, y = 6264.51, z = 30.48},
                Limit = 800,
                Name = "Bar Hen House"
            },
            {
                Pos = {x = -300.56, y = 6272.43, z = 30.48},
                Limit = 800,
                Name = "frigo2 Hen House"
            },
            {
                Pos = {x = -292.31, y = 6265.57, z = 33.80},
                Limit = 100,
                Name = "Coffre Boss Hen House"
            }
        },
        Extrapos = {
            CraftSpiritueux = {
                Pos = {
                    {x = -296.95, y = 6262.42, z = 31.48}
                },
                restricted = {1, 2, 3, 4, 5},
                Enter = function()
                    EntercrafthenhouseZone()
                end,
                Exit = function()
                    ExitcrafthenhouseZone()
                end,
                zonesize = 1.5,
                Blips = {
                    sprite = 93,
                    color = 81,
                    name = "Hen House - Alambique"
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
        requiredService = false,
        work = {

            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 418.3330, y = 6511.2543, z = 27.6969},
                giveitem = "chairsaucisse",
                blipcolor = 7,
                blipname = "Hen House - Récolte",
                add = "~p~+ 1  Chair à saucisse"
            },
            traitement = {
                type = "traitement",
                workSize = 7.45,
                blipcolor = 7,
                blipname = "Hen House  - Traitement",
                Pos = {x = 2478.2470, y = 4121.3378, z = 38.0253},
                required = "chairsaucisse",
                giveitem = "saucissonsec",
                add = "~p~+ 1  Saucisson sec"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Hen House  - Vente",
                Pos = {x = -3.0644, y = 6488.3999, z = 31.5080},
                required = "saucissonsec",
                price = math.random(13,16),
                add = "~p~- 1 Saucisson sec"
            }
        },
        Menu = {
            menu = {
                title = "TheHenHouse",
                subtitle = "Actions disponibles",
                name = "henhouse_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("henhouse")
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
                            TriggerServerEvent("Job:Annonce", "The Hen House", "Annonce", text, "CHAR_HENHOUSE", 8, "The Hen House")
                        end
                    end
                }
            }
        }
    },
    littleseaoul = {
        label = "San-Inn",
        label2 = "San-Inn",
        iban = "littleseaoul",
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
            Name = "Garage Bar Little Seoul",
            Pos = {x = -209.45, y = 308.36, z = 95.95},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -209.45, y = 308.36, z = 95.95, h = 274.82}
            },
            Blipdata = {
                Pos = {x = -209.45, y = 308.36, z = 95.95},
                Blipcolor = 5,
                Blipname = "Garage Bar Little Seoul"
            }
        },
        Storage = {
            {
                Pos = {x = -144.8333, y = 295.7938, z = 97.87},
                Limit = 800,
                Name = "Bar Little Seoul"
            },
            {
                Pos = {x = -172.2112, y = 288.7464, z = 92.76},
                Limit = 100,
                Name = "Vestiaire Bar Little Seoul"
            },
            {
                Pos = {x = -179.1901, y = 305.7939, z = 97.46},
                Limit = 1000,
                Name = "Frigo Bar Little Seoul"
            },
            {
                Pos = {x = -172.3963, y = 291.7341, z = 92.76},
                Limit = 800,
                Name = "Coffre Boss Bar Little Seoul"
            }
        },
        Extrapos = {
            CraftSpiritueux = {
                Pos = {
                    {x = -175.9085, y = 301.9834, z = 97.45}
                },
                restricted = {1, 2, 3, 4, 5},
                Enter = function()
                    EntercraftsanZone()
                end,
                Exit = function()
                    ExitcraftsanZone()
                end,
                zonesize = 3.5,
                Blips = {
                    sprite = 93,
                    color = 81,
                    name = "San-In - Alambique"
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
        requiredService = false,
        work = {

            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x = 953.4779, y = -2108.9062, z = 30.55},
                giveitem = "chairsaucisse",
                blipcolor = 7,
                blipname = "Bar Little Seoul - Récolte",
                add = "~p~+ 1  Chair à saucisse"
            },
            traitement = {
                type = "traitement",
                workSize = 7.45,
                blipcolor = 7,
                blipname = "Bar Little Seoul - Traitement",
                Pos = {x = 932.9300, y = -1803.9852, z = 30.7150},
                required = "chairsaucisse",
                giveitem = "saucissonsec",
                add = "~p~+ 1  Saucisson sec"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 7.45,
                blipname = "Bar Little Seoul - Vente",
                Pos = {x = 61.8119, y = -1726.7955, z = 29.4971},
                required = "saucissonsec",
                price = math.random(13,16),
                add = "~p~- 1 Saucisson sec"
            }
        },
        Menu = {
            menu = {
                title = "Bar Little Seoul",
                subtitle = "Actions disponibles",
                name = "henhouse_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("littleseaoul")
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
                            TriggerServerEvent("Job:Annonce", "San-Inn", "Annonce", text, "CHAR_LITTLE", 8, "San-Inn")
                        end
                    end
                }
            }
        }
    },
    -- jetsam = {
    --     label = "Jetsam",
    --     label2 = "Jetsam",
    --     iban = "jetsam",
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
    --         Name = "Garage Jetsam",
    --         Pos = {x = 814.74, y = -2941.26, z = 5.9},
    --         Properties = {
    --             type = 3,
    --             Limit = 20,
    --             vehicles = {},
    --             spawnpos = {x = 814.74, y = -2941.26, z = 5.9, h = 269.7}
    --         },
    --         Blipdata = {
    --             Pos = {x = 814.74, y = -2941.26, z = 5.9},
    --             Blipcolor = 5,
    --             Blipname = "Garage Jetsam"
    --         }
    --     },
    --     Storage = {
    --         {
    --             Pos = {x = 813.4, y = -2982.56, z = 6.02 - 0.9},
    --             Limit = 100,
    --             Name = "Coffre Jetsam"
    --         }
    --     }
    -- },
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
    g6 = {
        label = "Gruppe Sechs",
        label2 = "Gruppe Sechs",
        iban = "g6",
        grade = {
            {
                label = "CDD",
                salary = 120,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 140,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 160,
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
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = -219.14, y = -823.18, z = 30.68},
                vestiaire = {
                    type = "Vestiaire",
                    workSize = 1.45,
                    Pos = {x = -219.14, y = -823.18, z = 30.68},
                    Tenues = TenueG6
                }
            }
        },
        garage = {
            Name = "Garage employé G6",
            Pos = {x = -284.51, y = -918.18, z = 31.08},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -284.51, y = -918.18, z = 31.08, h = 76.92}
            },
            Blipdata = {
                Pos = {x = -284.51, y = -918.18, z = 31.08},
                Blipcolor = 5,
                Blipname = "Garage employé G6"
            }
        },
        garage2 = {
            Name = "Garage G6",
            Pos = {x = -18.33, y = -699.53, z = 32.33},
            Properties = {
                type = 3,
                Limit = 20,
                vehicles = {},
                spawnpos = {x = -18.33, y = -699.53, z = 32.33, h = 76.92}
            },
            Blipdata = {
                Pos = {x = -18.33, y = -699.53, z = 32.33},
                Blipcolor = 5,
                Blipname = "Garage G6"
            }
        },
        Menu = {
            menu = {
                title = "Gruppe Sechs",
                subtitle = "Actions disponibles",
                name = "g6_menujob"
            },
            buttons = {
                {
                    label = "Annonce",
                    onSelected = function()
                        exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                        local text = exports['Snoupinput']:GetInput()
                        if text ~= false and text ~= "" then
                            TriggerServerEvent("Job:Annonce", "Gruppe Sechs", "Annonce", text, "CHAR_g6", 8, "Gruppe Sechs")
                        end
                    end
                },
                {
                    label = "Agents en service",
                    onSelected = function()
                        TriggerServerEvent("Ora::SE::Service:ShowOnDutyPlayers", "g6")
                    end
                },
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("g6")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Gestion des missions",
                    onSelected = function()
                        OpenSessionMenu()
                    end,
                },
            },
            submenus = {
                ["Actions citoyen"] = {
                    submenu = "g6_menujob",
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
                        },
                        submenus = {}
                    }
                },
                ["Appels d'urgence"] = {
                    submenu = "g6_menujob",
                    title = "Appels d'urgence",
                    menus = {
                        buttons = {
                            {
                                label = "Demande de renfort",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "g6",
                                        {x = x, y = y, z = z},
                                        "Demande de renfort"
                                    )
                                end
                            },
                            {
                                label = "Appel SAHP",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "police",
                                        {x = x, y = y, z = z},
                                        "S.O.S G6"
                                    )
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "lssd", 
                                        {x = x, y = y, z = z},
                                        "S.O.S G6"
                                    )
                                    -- Basically the same behaviour as the police functionnality
                                    exports['Ora_utils']:sendME("* L'individu appuie sur un bouton de sa radio *")
                                end,
                                ActiveFct = function()
                                end
                            }
                        }
                    }
                }
            },
        },
        Storage = {
            {
                Pos = {x = -224.65, y = -822.10, z = 30.68 - 0.9},
                Limit = 1000,
                Name = "Frigo G6"
            },
            {
                Pos = {x = -226.38, y = -842.34, z = 30.68 - 0.9},
                Limit = 1000,
                Name = "Armurerie G6"
            },
            {
                Pos = {x = 11.7070, y = -661.5366, z = 33.44 - 0.9},
                Limit = 1000,
                Name = "dépot G6"
            }
        },
        Extrapos = {
            ExtraVehicle = {
                Pos = {
                    {x = 0.89, y = -701.03, z = 32.33}
                },
                restricted = {1, 2, 3, 4, 5},
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
                    name = "G6 - Extras"
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
    }
}