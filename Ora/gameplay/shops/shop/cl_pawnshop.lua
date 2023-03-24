local PawnShops = {
    pawnshop_4 = {
        position = vector3(112.33, -5.95, 67.84-0.98),
        heading = 161.47,
        seller_ped = "cs_bankman",
        seller_name = "Edouard",
        pawnshop_receipt = "PawnShop",
        seller_identifier = "pawnshop_4",
        isPawnshop = true,
        blips = {
            show = false,
            sprite = 7,
            color = 7,
            name = "Pawnshop"
        },
        items = {
            markedcheck = {
                unitPrice = 20
            },
            goldpepite1 = {
                unitPrice = 2
            },
            goldpepite2 = {
                unitPrice = 5
            },
            goldpepite3 = {
                unitPrice = 8
            },
            goldpepite4 = {
                unitPrice = 10
            },
            goldpepite5 = {
                unitPrice = 15
            },
            goldpepite6 = {
                unitPrice = 19
            },
            jewels1 = {
                unitPrice = 225
            },
            jewels2 = {
                unitPrice = 125
            },
            jewels3 = {
                unitPrice = 125
            },
            jewels4 = {
                unitPrice = 150
            },
            jewels5 = {
                unitPrice = 30
            },
            jewels6 = {
                unitPrice = 40
            },
            burglary_item = {
                illegal = true,
                unitPrice = {min = 10, max = 15}
            },
            burglary_tel = {
                illegal = true,
                unitPrice = {min = 100, max = 120}
            },
            burglary_cd = {
                illegal = true,
                unitPrice = {min = 10, max = 15}
            },
            burglary_printer = {
                illegal = true,
                unitPrice = {min = 30, max = 45}
            },
            burglary_tv = {
                illegal = true,
                unitPrice = {min = 110, max = 130}
            },
            burglary_binocular = {
                illegal = true,
                unitPrice = {min = 100, max = 150}
            },
            burglary_alarmclock = {
                illegal = true,
                unitPrice = {min = 30, max = 45}
            },
            burglary_vanity = {
                illegal = true,
                unitPrice = {min = 60, max = 70}
            },
            burglary_alcoolbottle = {
                illegal = true,
                unitPrice = {min = 20, max = 35}
            },
            burglary_shampoo = {
                illegal = true,
                unitPrice = {min = 5, max = 15}
            },
            burglary_bose = {
                illegal = true,
                unitPrice = {min = 80, max = 110}
            },
            burglary_pan = {
                illegal = true,
                unitPrice = {min = 20, max = 30}
            },
            burglary_microwave = {
                illegal = true,
                unitPrice = {min = 50, max = 60}
            },
            burglary_toaster = {
                illegal = true,
                unitPrice = {min = 30, max = 50}
            },
            burglary_bong = {
                illegal = true,
                unitPrice = {min = 10, max = 15}
            },
            burglary_flowerbucket = {
                illegal = true,
                unitPrice = {min = 100, max = 200}
            },
            burglary_lamp = {
                illegal = true,
                unitPrice = {min = 40, max = 55}
            },
            burglary_jewels = {
                illegal = true,
                unitPrice = {min = 200, max = 250}
            },
            burglary_precious = {
                illegal = true,
                unitPrice = {min = 300, max = 350}
            },
            burglary_cam = {
                illegal = true,
                unitPrice = {min = 100, max = 150}
            },
            burglary_guitar = {
                illegal = true,
                unitPrice = {min = 200, max = 250}
            },
            burglary_boombox = {
                illegal = true,
                unitPrice = {min = 150, max = 200}
            },
            burglary_shoes = {
                illegal = true,
                unitPrice = {min = 200, max = 250}
            },
            burglary_xbox = {
                illegal = true,
                unitPrice = {min = 100, max = 150}
            },
            burglary_flatscreen = {
                illegal = true,
                unitPrice = {min = 50, max = 150}
            },
            burglary_oldtv = {
                illegal = true,
                unitPrice = {min = 250, max = 300}
            },
        }
    },
    pawnshop_2 = {
        position = vector3(961.13, -2186.07, 29.53),
        heading = 78.22,
        seller_ped = "mp_m_meth_01",
        seller_name = "Roger Balker",
        pawnshop_receipt = "Boucherie",
        seller_identifier = "pawnshop_2",
        blips = {
            show = true,
            sprite = 7,
            color = 7,
            name = "Viandes"
        },
        items = {
            meat = {
                unitPrice = {min = 1, max = 2}
            },
            meat1 = {
                unitPrice = {min = math.random(8, 15), max = math.random(16, 20)}
            },
            meat2 = {
                unitPrice = {min = math.random(4, 6), max = math.random(13, 15)}
            },
            meat3 = {
                unitPrice = {min = math.random(7, 9), max = math.random(12, 13)}
            },
            meat4 = {
                unitPrice = {min = math.random(8, 15), max = math.random(16, 20)}
            },
            meat5 = {
                unitPrice = {min = math.random(20, 25), max = math.random(30, 40)}
            },
            meat6 = {
                unitPrice = {min = math.random(1, 3), max = math.random(3, 4)}
            },
            meat7 = {
                unitPrice = {min = math.random(1, 3), max = math.random(3, 4)}
            }
        }
    },
    pawnshop_3 = {
        position = vector3(3798.89, 4447.13, 3.34), --vector3(1299.13, 4322.45, 37.26),
        heading = 2.33, --295.13,
        seller_ped = "ig_jimmyboston",
        seller_name = "Bob Rowans",
        pawnshop_receipt = "Poissonnerie",
        seller_identifier = "pawnshop_3",
        blips = {
            show = true,
            sprite = 389,
            color = 7,
            name = "Poissons"
        },
        items = {
            fish1 = {
                unitPrice = {min = math.random(2, 3), max = math.random(4, 7)}
            },
            fish2 = {
                unitPrice = {min = math.random(1, 2), max = math.random(3, 5)}
            },
            fish3 = {
                unitPrice = {min = math.random(2, 4), max = math.random(5, 8)}
            },
            fish4 = {
                unitPrice = {min = math.random(2, 3), max = math.random(4, 7)}
            },
            fish5 = {
                unitPrice = {min = math.random(1, 2), max = math.random(3, 5)}
            },
            fish6 = {
                unitPrice = {min = math.random(1, 2), max = math.random(3, 5)}
            },
            fish7 = {
                unitPrice = {min = math.random(1, 2), max = math.random(3, 5)}
            },
            fish8 = {
                unitPrice = {min = math.random(2, 3), max = math.random(4, 7)}
            },
            fish9 = {
                unitPrice = {min = math.random(2, 3), max = math.random(4, 7)}
            },
            fish10 = {
                unitPrice = {min = math.random(1, 2), max = math.random(3, 5)}
            },
            fish11 = {
                unitPrice = {min = math.random(1, 2), max = math.random(3, 5)}
            },
            fish12 = {
                unitPrice = {min = math.random(1, 2), max = math.random(3, 5)}
            },
            fish13 = {
                unitPrice = {min = math.random(1, 2), max = math.random(3, 5)}
            },
            fish14 = {
                unitPrice = {min = math.random(1, 2), max = math.random(3, 5)}
            }
        }
    },
    pawnshop_5 = {
        position = vector3(1632.33, 2590.27, 45.56 - 0.98),
        heading = 311.07,
        seller_ped = "s_m_y_robber_01",
        seller_name = "Filou le planteux",
        pawnshop_receipt = "Prison",
        seller_identifier = "pawnshop_5",
        blips = {
            show = false,
            sprite = 7,
            color = 7,
            name = "Filou"
        },
        items = {
            info = {
                unitPrice = 2
            },
            info2 = {
                unitPrice = 5
            },
            info3 = {
                unitPrice = 8
            },
            info4 = {
                unitPrice = 10
            },
            chocolat = {
                unitPrice = 12
            },
            cigarette = {
                unitPrice = 12
            },
            beer = {
                unitPrice = 30
            },
            weed_pooch = {
                unitPrice = 50
            },
            meth = {
                unitPrice = 80
            },
            coke1 = {
                unitPrice = 110
            },
            casinopiece = {
                unitPrice = 10
            }
        }
    },
    pawnshop_6 = {
        position = vector3(-1636.828, -2994.335, -79.15),
        heading = 194.285,
        seller_ped = "s_f_m_shop_high",
        seller_name = "Caissiere Jackie",
        pawnshop_receipt = "Casino",
        seller_identifier = "pawnshop_6",
        blips = {
            show = false,
            sprite = 7,
            color = 7,
            name = "Casino - Caisse"
        },
        items = {
            casinopiece = {
                unitPrice = 10
            }
        }
    },
    pawnshop_7 = {
        position = vector3(990.31, 30.26, 71.46 - 0.98),
        heading = 39.03,
        seller_ped = "s_f_m_shop_high",
        seller_name = "Caissiere Jessifer",
        pawnshop_receipt = "Casino",
        seller_identifier = "pawnshop_7",
        isCasino = true,
        blips = {
            show = false,
            sprite = 7,
            color = 7,
            name = "Casino - Caisse"
        },
        items = {
            casinopiece = {
                unitPrice = 10
            }
        }
    },
    pawnshop_8 = {
        position = vector3(-1593.00, 5202.89, 4.31 - 0.98),
        heading = 294.35,
        seller_ped = "s_f_y_factory_01",
        seller_name = "Maria",
        pawnshop_receipt = "Recu illegal",
        seller_identifier = "pawnshop_8",
        blips = {
            show = false,
            sprite = 7,
            color = 7,
            name = "Poissons"
        },
        items = {
            fishilleg1 = {
                unitPrice = {min = 200, max = 250},
                illegal = true
            },
            fishilleg2 = {
                unitPrice = {min = 200, max = 300},
                illegal = true
            },
            fishilleg3 = {
                unitPrice = {min = 200, max = 350},
                illegal = true
            },
            fishilleg4 = {
                unitPrice = {min = 200, max = 300},
                illegal = true
            }
        }
    },
}
local Pawnshop = {}
local CurrentZone = nil
function Pawnshop.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard", "E", Pawnshop.Open, "Shop")
    KeySettings:Add("controller", 46, Pawnshop.Open, "Shop")
    CurrentZone = zone
end

function Pawnshop.ExitZone()
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        if RageUI.Visible(RMenu:Get("pawnshop", CurrentZone)) then
            RageUI.GoBack()
            RageUI.Visible(RMenu:Get("pawnshop", CurrentZone), false)
        elseif RageUI.Visible(RMenu:Get("pawnshop", "pawnseller_sell_" .. CurrentZone)) then
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()
            RageUI.Visible(RMenu:Get("pawnshop", "pawnseller_sell_" .. CurrentZone), false)
        elseif  RageUI.Visible(RMenu:Get("pawnshop", "pawnseller_info_" .. CurrentZone)) then
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()
            RageUI.Visible(RMenu:Get("pawnshop", "pawnseller_info_" .. CurrentZone), false)
        end
        KeySettings:Clear("keyboard", "E", "Shop")
        CurrentZone = nil
    end
end

function Pawnshop.Open()
    RageUI.Visible(RMenu:Get("pawnshop", CurrentZone), not RageUI.Visible(RMenu:Get("pawnshop", CurrentZone)))
end

-- Threads linked to Menu

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if (CurrentZone ~= nil) then
                if RageUI.Visible(RMenu:Get("pawnshop", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            RageUI.Button(
                                "Vendre mes biens recherchés",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                end,
                                RMenu:Get("pawnshop", "pawnseller_sell_" .. CurrentZone)
                            )
                            RageUI.Button(
                                "Liste des biens recherchés",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                end,
                                RMenu:Get("pawnshop", "pawnseller_info_" .. CurrentZone)
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("pawnshop", "pawnseller_sell_" .. CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            if (PawnShops[CurrentZone] ~= nil and PawnShops[CurrentZone].items ~= nil) then
                                for tmpKey, tmpValue in pairs(PawnShops[CurrentZone].items) do
                                    if (Items[tmpKey] ~= nil) then
                                        local itemCount = Ora.Inventory:GetItemCount(tmpKey)
                                        if (itemCount > 0) then
                                            local priceRange = ""
                                            local finalPrice = 0
                                            if (type(tmpValue.unitPrice) == "table") then
                                                priceRange =
                                                    "~b~De " ..
                                                    tmpValue.unitPrice.min * itemCount ..
                                                        "$ à " .. tmpValue.unitPrice.max * itemCount .. "$~s~"

                                                math.randomseed(GetGameTimer())
                                                finalPrice =
                                                    math.random(
                                                    tmpValue.unitPrice.min * itemCount,
                                                    tmpValue.unitPrice.max * itemCount
                                                )
                                            else
                                                priceRange = "~b~" .. tmpValue.unitPrice * itemCount .. "$~s~"
                                                finalPrice = tmpValue.unitPrice * itemCount
                                            end

                                            RageUI.Button(
                                                "~h~~r~" .. itemCount .. " x ~s~" .. Items[tmpKey].label,
                                                nil,
                                                {RightLabel = priceRange},
                                                true,
                                                function(_, _, Selected)
                                                    if Selected then
                                                        if (PawnShops[CurrentZone].isCasino) then
                                                            TriggerServerCallback(
                                                                "Ora::SE::Job::Casino::CanBuy",
                                                                function(bool)
                                                                    if (bool) then
                                                                        Ora.Inventory:RemoveAnyItemsFromName(tmpKey, itemCount)
                                                                        
                                                                        
                                                                        TriggerServerCallback(
                                                                            "Ora::SE::Money:AuthorizePayment", 
                                                                            function(token)
                                                                                ShowNotification(
                                                                                    "~h~~b~L'acheteur vous achete ~r~" ..
                                                                                        itemCount ..
                                                                                            "x~s~ " ..
                                                                                                Items[tmpKey].label ..
                                                                                                    "~s~ pour ~g~" .. finalPrice .. "$~s~"
                                                                                )
                                                                                TriggerServerEvent("Ora::SE::Receipt:CreateReceipt", {PRICE = finalPrice, PAWNSHOP = PawnShops[CurrentZone]})
                                                                                TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = finalPrice, SOURCE = PawnShops[CurrentZone].pawnshop_receipt, LEGIT = true})
                                                                            end,
                                                                            {}
                                                                        )
                                                                        

                                                                        TriggerServerEvent("Ora:RemoveFromBankAccount", "casino", finalPrice)
                                                                    else
                                                                        RageUI.Popup({message = "Je vais laisser un autre collègue en service s'occuper de vous."})
                                                                    end
                                                                end
                                                            )
                                                        elseif (PawnShops[CurrentZone].isPawnshop) then
                                                            Ora.Inventory:RemoveAnyItemsFromName(tmpKey, itemCount)

                                                            TriggerServerCallback(
                                                                "Ora::SE::Money:AuthorizePayment", 
                                                                function(token)
                                                                    ShowNotification(
                                                                        "~h~~b~L'acheteur vous achete ~r~" ..
                                                                            itemCount ..
                                                                                "x~s~ " ..
                                                                                    Items[tmpKey].label ..
                                                                                        "~s~ pour ~g~" .. finalPrice .. "$~s~"
                                                                    )
                                                                    TriggerServerEvent("Ora::SE::Receipt:CreateReceipt", {PRICE = finalPrice, PAWNSHOP = PawnShops[CurrentZone]})
                                                                    TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = finalPrice, SOURCE = PawnShops[CurrentZone].pawnshop_receipt, LEGIT = true})
                                                                end,
                                                                {}
                                                            )

                                                        else
                                                            Ora.Inventory:RemoveAnyItemsFromName(tmpKey, itemCount)
                                                                
                                                                
                                                            TriggerServerCallback(
                                                                "Ora::SE::Money:AuthorizePayment", 
                                                                function(token)
                                                                    ShowNotification(
                                                                        "~h~~b~L'acheteur vous achete ~r~" ..
                                                                            itemCount ..
                                                                                "x~s~ " ..
                                                                                    Items[tmpKey].label ..
                                                                                        "~s~ pour ~g~" .. finalPrice .. "$~s~"
                                                                    )
                                                                    TriggerServerEvent("Ora::SE::Receipt:CreateReceipt", {PRICE = finalPrice, PAWNSHOP = PawnShops[CurrentZone]})
                                                                    TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = finalPrice, SOURCE = PawnShops[CurrentZone].pawnshop_receipt, LEGIT = true})
                                                                end,
                                                                {}
                                                            )
                                                        end
                                                    end
                                                end,
                                                nil
                                            )
                                        end
                                    else
                                        ShowNotification(
                                            "~r~Erreur systeme : L'item : " .. tmpKey .. " n'existe pas~s~"
                                        )
                                    end
                                end
                            else
                                ShowNotification(
                                    "~r~Erreur systeme : l'acheteur " ..
                                        CurrentZone .. " n'existe pas ou n'a pas de biens recherchés~s~"
                                )
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("pawnshop", "pawnseller_info_" .. CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            if (PawnShops[CurrentZone] ~= nil and PawnShops[CurrentZone].items ~= nil) then
                                for tmpKey, tmpValue in pairs(PawnShops[CurrentZone].items) do
                                    if (Items[tmpKey] ~= nil) then
                                        local priceRange = ""
                                        if (type(tmpValue.unitPrice) == "table") then
                                            priceRange =
                                                "~b~De " ..
                                                tmpValue.unitPrice.min .. "$ à " .. tmpValue.unitPrice.max .. "$~s~"
                                        else
                                            priceRange = "~b~" .. tmpValue.unitPrice .. "$~s~"
                                        end

                                        RageUI.Button(
                                            Items[tmpKey].label,
                                            nil,
                                            {RightLabel = priceRange},
                                            true,
                                            function(_, _, Selected)
                                                if Selected then
                                                    ShowNotification(
                                                        "~b~" .. Items[tmpKey].label .. "~s~ est acheté " .. priceRange
                                                    )
                                                end
                                            end,
                                            nil
                                        )
                                    else
                                        ShowNotification(
                                            "~r~Erreur systeme : L'item : " .. tmpKey .. " n'existe pas~s~"
                                        )
                                    end
                                end
                            else
                                ShowNotification(
                                    "~r~Erreur systeme : le pawnshop " ..
                                        CurrentZone .. " n'existe pas ou n'a pas de biens recherchés~w~"
                                )
                            end
                        end,
                        function()
                        end
                    )
                end
            end
        end
    end
)

-- Threads Linked to Blips & PED creation at start up

Citizen.CreateThread(
    function()
        for key, value in pairs(PawnShops) do
            Ped:Add(
                value.seller_name,
                value.seller_ped,
                {x = value.position.x, y = value.position.y, z = value.position.z, a = value.heading},
                nil
            )

            if (value.blips.show == nil or value.blips.show == true) then
                local blip = AddBlipForCoord(value.position.x, value.position.y, value.position.z)
                SetBlipSprite(blip, value.blips.sprite)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.8)
                SetBlipColour(blip, value.blips.color)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Vente - " .. value.blips.name)
                EndTextCommandSetBlipName(blip)

                Blips:AddBlip(blip, "Vente", value.blips)
            end

            Zone:Add(value.position, Pawnshop.EnterZone, Pawnshop.ExitZone, value.seller_identifier, 2.5)
            RMenu.Add(
                "pawnshop",
                value.seller_identifier,
                RageUI.CreateMenu(
                    nil,
                    value.seller_name .. " - " .. value.blips.name,
                    10,
                    100,
                    "shopui_title_lowendfashion",
                    "shopui_title_lowendfashion"
                )
            )
            RMenu.Add(
                "pawnshop",
                "pawnseller_sell_" .. value.seller_identifier,
                RageUI.CreateSubMenu(RMenu:Get("pawnshop", value.seller_identifier), nil, "Vendre des biens")
            )
            RMenu.Add(
                "pawnshop",
                "pawnseller_info_" .. value.seller_identifier,
                RageUI.CreateSubMenu(RMenu:Get("pawnshop", value.seller_identifier), nil, "Liste des biens recherchés")
            )

            RMenu:Get("pawnshop", value.seller_identifier).Closed = function()
            end
        end
    end
)

RegisterNetEvent("Ora::CE::Receipt:ShowInformation")
AddEventHandler(
    "Ora::CE::Receipt:ShowInformation",
    function(item)
        if item.data == nil then
            ShowNotification("~r~Reçu invalide")
        end

        if item.data.date == nil or item.data.pawnshop == nil or item.data.price == nil then
            ShowNotification("~r~Reçu invalide. Manque d'information")
        end

        ShowNotification("~b~---- RECU " .. item.data.pawnshop .. " ----~s~")
        ShowNotification("~o~Certification de ".. item.data.price .. "$\nle : " .. item.data.date .. "~s~")
        
    end
)

