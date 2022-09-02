ConfigTax = 21
function GeneratePhoneNumber()
   return Ora.Player:GenerateNewPhoneNumber()
end

function GeneratePoliceSerial()
    local serial = "POLICE-"
    math.randomseed(GetGameTimer())
    local num = math.random(11111, 99999)
    return serial .. num
end

local function isPolice()
    if Ora.Identity.Job:GetName() == "police" or Ora.Identity.Job:GetName() == "lssd" then
        return true
    end
    return false
end

local function isSAMS()
    if Ora.Identity.Job:GetName() == "lsms" then
        return true
    end
    return false
end

function HasNoLtdSouth()
    local result = nil
    TriggerServerCallback(
        "Ora::SE::Service:GetInServiceCount",
        function(nb)
            if nb == 0 then
                result = true
            else
                RageUI.Popup({message = "~r~Aller voir un LTD joueur Sud"})
                result = false
            end
        end,
        "ltdsud"
    )

    while (result == nil) do
        Wait(10)
    end

    return result
end

function HasNoLtdNorth()
    local result = nil
    TriggerServerCallback(
        "Ora::SE::Service:GetInServiceCount",
        function(nb)
            if nb == 0 then
                result = true
            else
                RageUI.Popup({message = "~r~Aller voir un LTD joueur Nord"})
                result = false
            end
        end,
        "ltdnord"
    )

    while (result == nil) do
        Wait(10)
    end

    return result
end

function GenerateApuSerial()
    local serial = "LTD-"
    local num = math.random(11111, 99999)
    math.randomseed(GetGameTimer())
    return  serial .. num .. GetGameTimer()
end
local BasicShopsNorth = {
    {
        name = "tel",
        price = 150,
        data = {battery = 99},
        fct = GeneratePhoneNumber,
        type = "number",
        beforePayment = HasNoLtdNorth,
        tax = 1.00
    },
    --    {
    --        name = "battery",
    --        price = 500,
    --        data = {}
    --    },
    -- {
    --     name = "bread",
    --     price = 3,
    --     data = {}
    -- },
    -- {
    --     name = "burger",
    --     price = 8,
    --     data = {}
    -- },
    {
        name = "tapas",
        price = 8,
        data = {},
        beforePayment = HasNoLtdNorth,
        tax = 1.00
    },
    {
        name = "cafe",
        price = 20,
        data = {},
        beforePayment = HasNoLtdNorth,
        tax = 1.00
    },
    -- {
    --     name = "jus_pomme",
    --     price = 6,
    --     data = {}
    -- },
    {
        name = "jus",
        price = 30,
        data = {},
        beforePayment = HasNoLtdNorth,
        tax = 1.00
    },
    {
        name = "cola",
        price = 15,
        data = {},
        beforePayment = HasNoLtdNorth,
        tax = 1.00
    },
    {
        name = "water",
        price = 45,
        data = {},
        beforePayment = HasNoLtdNorth,
        tax = 1.00
    },
    {
        name = "fishingrod",
        price = 50,
        data = {},
        beforePayment = HasNoLtdNorth,
        tax = 1.00
    },
    {
        name = "gascan",
        price = 35,
        data = {},
        tax = 1.00,
        fct = GenerateApuSerial,
        type = "serial"
    },
    {
        name = "blocnote",
        price = 10,
        data = {},
        beforePayment = HasNoLtdNorth,
        tax = 1.00
    },
    {
        name = "makeup",
        price = 50,
        data = {},
        beforePayment = HasNoLtdNorth,
        tax = 1.00
    }
    -- {
    --     name = "speaker",
    --     price = 1000,
    --     data = {},
    --     beforePayment = HasNoLtdNorth,
    --     tax = 1.00
    -- }

    -- {
    --     name = "biere",
    --     price = 10,
    --     data = {}
    -- }
}
local BasicShopsSouth = {
    {
        name = "tel",
        price = 150,
        data = {battery = 99},
        fct = GeneratePhoneNumber,
        type = "number",
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    --    {
    --        name = "battery",
    --        price = 500,
    --        data = {}
    --    },
    -- {
    --     name = "bread",
    --     price = 3,
    --     data = {}
    -- },
    -- {
    --     name = "burger",
    --     price = 8,
    --     data = {}
    -- },
    {
        name = "tapas",
        price = 8,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "cafe",
        price = 20,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    -- {
    --     name = "jus_pomme",
    --     price = 6,
    --     data = {}
    -- },
    {
        name = "jus",
        price = 30,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "cola",
        price = 15,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "water",
        price = 45,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "fishingrod",
        price = 50,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "gascan",
        price = 35,
        data = {},
        tax = 1.00,
        fct = GenerateApuSerial,
        type = "serial"
    },
    {
        name = "blocnote",
        price = 10,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "makeup",
        price = 50,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    }
    -- {
    --     name = "speaker",
    --     price = 1000,
    --     data = {},
    --     beforePayment = HasNoLtdNorth,
    --     tax = 1.00
    -- }

    -- {
    --     name = "biere",
    --     price = 10,
    --     data = {}
    -- }
}
local LittleSeoulShop = {
    {
        name = "tel",
        price = 150,
        data = {battery = 99},
        fct = GeneratePhoneNumber,
        type = "number",
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "nem",
        price = 8,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "ricemilk",
        price = 6,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "mentos",
        price = 3,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "jus",
        price = 30,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "water",
        price = 45,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "fishingrod",
        price = 50,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    },
    {
        name = "gascan",
        price = 35,
        data = {},
        tax = 1.00,
        fct = GenerateApuSerial,
        type = "serial"
    },
    {
        name = "blocnote",
        price = 10,
        data = {},
        beforePayment = HasNoLtdSouth,
        tax = 1.00
    }
    -- {
    --     name = "speaker",
    --     price = 1000,
    --     data = {},
    --     beforePayment = HasNoLtdNorth,
    --     tax = 1.00
    -- }

    -- {
    --     name = "biere",
    --     price = 10,
    --     data = {}
    -- }
}
local _identity = {}
function SetMyIdentity(id)
    id[1].serial = math.random(111111111, 9999999999)
    id[1].male = Ora.World.Ped:IsPedMale(LocalPlayer().Ped) and "M" or "F"
    _identity = id[1]
end
function GetIdentity()
    return _identity
end

function sendTax(amount)
    TriggerServerEvent("entreprise:Add", "gouvernement", math.ceil(amount))
end

function HasNoMedic()
    local result = nil

    TriggerServerCallback("Ora::SE::Service:GetInServiceCount", 
        function(nb)
            if nb == 0 then
                RageUI.Popup({message = "~g~Mes collègues ne sont pas en service, je vais m'occuper de vous après paiement"})
                result = true
            else
                TriggerServerCallback("Ora::SE::Job::Ambulance:IsAllowedNPCAmbulance", 
                    function(isAllowed)
                        if (isAllowed) then
                            RageUI.Popup({message = "~g~Mes collègues m'ont autorisé a soigner, je vais m'occuper de vous après paiement"})
                            result = true
                        else
                            RageUI.Popup({message = "~r~Mes collègues sont à l'intérieur. Merci d'aller les rencontrer"})
                            result = false
                        end
                    end
                )

            end
        end,
        "lsms"
    )

    while (result == nil) do
        Wait(10)
    end

    return result
end

function HealPlayerFromMedic(item)
    local timeATA = 1000 * 60 * 2
    LoadingPrompt("Veuillez patienter pendant que je vous soigne... (" .. math.ceil((timeATA / 1000) / 60) .. " minutes)", 4)
    local playerPed = LocalPlayer().Ped
    TriggerServerEvent("Ora:sendToDiscord", 16, "S'est heal avec Doug à l'accueil. Vie: "..GetEntityHealth(playerPed).."/"..GetEntityMaxHealth(playerPed), "info")
    RequestAnimDict("amb@medic@standing@timeofdeath@idle_a")
    local j = 0
    while not HasAnimDictLoaded("amb@medic@standing@timeofdeath@idle_a") and j <= 50 do
        Citizen.Wait(100)
        j = j + 1
    end

    if j >= 50 then
        ShowNotification("~r~~h~ERREUR ~h~~w~: Animation trop longue a charger.")
    else
        TaskPlayAnim(playerPed, "amb@medic@standing@timeofdeath@idle_a", "idle_a", 8.0, 1.0, -1, 2)
        RemoveAnimDict("amb@medic@standing@timeofdeath@idle_a")
    end
    FreezeEntityPosition(playerPed, true)
    Wait(timeATA)
    FreezeEntityPosition(playerPed, false)
    RemoveLoadingPrompt()
    ClearPedTasks(LocalPlayer().Ped)
    Ora.Health:SetMyHealthPercent(70)
    ClearPedBloodDamage(playerPed)
    Ora.Health:RemoveInjuredEffects()
    RageUI.Popup({message = "~g~Vous êtes soigné à 70% !\n~y~Pensez à appliquer les ATA~w~"})
    TriggerServerEvent("entreprise:Add", "lsms", 500)
end

function ReviveAndHealPlayerFromMedic(item)
    local timeATA = 1000 * 60 * 5
    TriggerEvent("player:Revive")
    Ora.Health:SetIsDead(false)
    LoadingPrompt("Veuillez patienter pendant que je vous soigne... (" .. math.ceil((timeATA / 1000) / 60) .. " minutes)", 4)
    local playerPed = LocalPlayer().Ped
    TriggerServerEvent("Ora:sendToDiscord", 16, "S'est revive avec Doug à l'accueil. Vie: "..GetEntityHealth(playerPed).."/"..GetEntityMaxHealth(playerPed), "info")
    RequestAnimDict("amb@medic@standing@timeofdeath@idle_a")
    local j = 0
    while not HasAnimDictLoaded("amb@medic@standing@timeofdeath@idle_a") and j <= 50 do
        Citizen.Wait(100)
        j = j + 1
    end

    if j >= 50 then
        ShowNotification("~r~~h~ERREUR ~h~~w~: Animation trop longue a charger.")
    else
        TaskPlayAnim(playerPed, "amb@medic@standing@timeofdeath@idle_a", "idle_a", 8.0, 1.0, -1, 2)
        RemoveAnimDict("amb@medic@standing@timeofdeath@idle_a")
    end
    FreezeEntityPosition(playerPed, true)
    Wait(timeATA)
    FreezeEntityPosition(playerPed, false)
    RemoveLoadingPrompt()
    Ora.Health:SetMyHealthPercent(70)
    ClearPedBloodDamage(playerPed)
    Ora.Health:RemoveInjuredEffects()
    RageUI.Popup({message = "~g~Vous êtes soigné à 70% !\n~y~Pensez à appliquer les ATA~w~"})
    TriggerServerEvent("entreprise:Add", "lsms", 1000)
end

function SpawnBike(item)
    local itemData = item.data

    if (itemData["model"] ~= nil) then
        RageUI.Popup({message = "~g~Voila votre Location !\n~y~Pensez à la ramener pour récupérer votre argent~w~"})

        local positionStart = itemData["positionStart"]
        local itemPrice = itemData["price"]

        vehicleFct.SpawnVehicle(
            itemData["model"],
            positionStart,
            itemData["positionHeading"],
            function(vehicle)
                local tankV = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fPetrolTankVolume")
                SetEntityAsMissionEntity(vehicle, true, true)
                SetVehicleOnGroundProperly(vehicle)
                TaskWarpPedIntoVehicle(LocalPlayer().Ped, vehicle, -1)
                SetFuel(vehicle, tankV)
                local entityIdentifier = GetEntityModel(vehicle) .. "|" .. GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent("Ora_rental:addVehicle", entityIdentifier, itemPrice)
            end
        )
    end
end

function UnspawnRental(item)
    if not IsPedInAnyVehicle(LocalPlayer().Ped) then
        ShowNotification("~w~Veuillez ~y~monter sur votre véhicule~w~ avant de le rendre~s~")
    else
        local vehicle = GetVehiclePedIsIn(LocalPlayer().Ped)

        if (GetPedInVehicleSeat(vehicle, -1) ~= LocalPlayer().Ped) then
            ShowNotification("~w~Veuillez ~y~monter sur le siege conducteur~w~ avant de le rendre~s~")
        else
            local entityIdentifier = GetEntityModel(vehicle) .. "|" .. GetVehicleNumberPlateText(vehicle)
            TriggerServerCallback(
                "Ora_rental:getRentalPrice",
                function(price)
                    if (price == false) then
                        ShowNotification("~w~Veuillez ramener un véhicule ~y~que je vous ai loué~s~")
                    else
                        ShowNotification("~g~Merci d'avoir rendu le véhicule, bonne journée~s~")
                        SetEntityAsMissionEntity(vehicle, false, false)
                        DeleteEntity(vehicle)

                        TriggerServerCallback(
                            "Ora::SE::Money:AuthorizePayment", 
                            function(token)
                                TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = price, SOURCE = "Location", LEGIT = true})
                            end,
                            {}
                        )

                        ShowNotification("Voici votre caution de ~g~" .. price .. "$~s~")
                    end
                end,
                entityIdentifier
            )
        end
    end
end

function PubWeazel()
    RageUI.GoBack()
    Wait(20)
    RageUI.GoBack()
    Wait(20)
    local subjectWZL = KeyboardInput("Auteur de la pub ? ", nil, 50)
    local textWZL = KeyboardInput("Ecrivez la pub que vous souhaitez ", nil, 150)
    TriggerServerEvent("Job:WZLgive", 500)
    if textWZL ~= nil and textWZL ~= "" then
        if subjectWZL == "" or subjectWZL == nil then
            subjectWZL = "Publicité"
        end
        TriggerServerEvent("Job:Annonce", "Weazel News", subjectWZL, textWZL, "CHAR_WEAZEL", 8)
    end
end

local Shops =
    setmetatable(
    {
        {
            Title = "Préfecture",
            Pos = {x = -1098.34, y = -838.49, z = 18.1, a = 109.74},
            Blips = {
                sprite = nil,
                color = 17,
                name = "Préfecture"
            },
            Ped = {
                model = "a_f_y_femaleagent",
                name = "Linda"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Hidden = true,
            Items = {
                {
                    name = "identity",
                    price = 15,
                    data = {},
                    type = "identity",
                    fct = GetIdentity
                }
            }
        },
        {
            Title = "Medecin de garde",
            Pos = {x = -1851.66, y = -336.90, z = 49.44 - 0.98, a = 136.38},
            Blips = {
                sprite = nil,
                color = 17,
                name = "Medecin de garde"
            },
            Ped = {
                model = "s_m_m_doctor_01",
                name = "Doug"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "soinurgence",
                    price = 500,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = HasNoMedic,
                    afterPayment = HealPlayerFromMedic
                },
                {
                    name = "soinurgence2",
                    price = 1000,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = HasNoMedic,
                    afterPayment = ReviveAndHealPlayerFromMedic
                }
            }
        },
        {
            Title = "Medecin de garde",
            Pos = {x = 1831.51, y = 3677.23, z = 34.27 - 0.98, a = 232.65},
            Blips = {
                sprite = nil,
                color = 17,
                name = "Medecin de garde"
            },
            Ped = {
                model = "s_m_m_doctor_01",
                name = "Heck"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "soinurgence",
                    price = 500,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = HasNoMedic,
                    afterPayment = HealPlayerFromMedic
                },
                {
                    name = "soinurgence2",
                    price = 1000,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = HasNoMedic,
                    afterPayment = ReviveAndHealPlayerFromMedic
                }
            }
        },
        {
            Title = "Medecin de garde",
            Pos = {x = 320.69, y = -588.66, z = 43.28 - 0.98, a = 151.15},
            Blips = {
                sprite = nil,
                color = 17,
                name = "Medecin de garde"
            },
            Ped = {
                model = "s_m_m_doctor_01",
                name = "Albert"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "soinurgence",
                    price = 500,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = HasNoMedic,
                    afterPayment = HealPlayerFromMedic
                },
                {
                    name = "soinurgence2",
                    price = 1000,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = HasNoMedic,
                    afterPayment = ReviveAndHealPlayerFromMedic
                }
            }
        },
        {
            Title = "Loueur de Velo/Quad/Motocross",
            Pos = {x = 2439.09, y = 5180.47, z = 54.48, a = 202.35},
            Blips = {
                sprite = 1,
                color = 16,
                name = "Loueur de Velo/Quad/Motocross"
            },
            Ped = {
                model = "a_m_y_ktown_01",
                name = "Duncan"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "rentalbike2",
                    price = 75,
                    data = {
                        model = "scorcher",
                        positionStart = vector3(2441.87, 5176.18, 53.72),
                        positionHeading = 2.96,
                        price = 75
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike",
                    price = 150,
                    data = {
                        model = "bf400",
                        positionStart = vector3(2441.87, 5176.18, 53.72),
                        positionHeading = 2.96,
                        price = 150
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike4",
                    price = 150,
                    data = {
                        model = "sanchez",
                        positionStart = vector3(2441.87, 5176.18, 53.72),
                        positionHeading = 2.96,
                        price = 150
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike5",
                    price = 150,
                    data = {
                        model = "manchez",
                        positionStart = vector3(2441.87, 5176.18, 53.72),
                        positionHeading = 2.96,
                        price = 150
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike3",
                    price = 250,
                    data = {
                        model = "blazer4",
                        positionStart = vector3(2441.87, 5176.18, 53.72),
                        positionHeading = 2.96,
                        price = 250
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "unrentalbike",
                    price = 0,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = UnspawnRental
                }
            }
        },
        {
            Title = "Loueur de Velo/Quad/Motocross",
            Pos = {x = -1492.07, y = 4968.38, z = 62.88, a = 89.92},
            Blips = {
                sprite = 1,
                color = 16,
                name = "Loueur de Velo/Quad/Motocross"
            },
            Ped = {
                model = "a_m_y_ktown_01",
                name = "Raoul"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "rentalbike2",
                    price = 75,
                    data = {
                        model = "scorcher",
                        positionStart = vector3(-1495.78, 4969.82, 62.66),
                        positionHeading = 186.45,
                        price = 75
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike",
                    price = 150,
                    data = {
                        model = "bf400",
                        positionStart = vector3(-1495.78, 4969.82, 62.66),
                        positionHeading = 186.45,
                        price = 150
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike4",
                    price = 150,
                    data = {
                        model = "sanchez",
                        positionStart = vector3(-1495.78, 4969.82, 62.66),
                        positionHeading = 186.45,
                        price = 150
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike5",
                    price = 150,
                    data = {
                        model = "manchez",
                        positionStart = vector3(-1495.78, 4969.82, 62.66),
                        positionHeading = 186.45,
                        price = 150
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike3",
                    price = 250,
                    data = {
                        model = "blazer4",
                        positionStart = vector3(-1495.78, 4969.82, 62.66),
                        positionHeading = 186.45,
                        price = 250
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "unrentalbike",
                    price = 0,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = UnspawnRental
                }
            }
        },
        {
            Title = "Loueur de Velo/Quad/Motocross",
            Pos = {x = 486.86, y = 5549.91, z = 784.36, a = 302.63},
            Blips = {
                sprite = 1,
                color = 16,
                name = "Loueur de Velo/Quad/Motocross"
            },
            Ped = {
                model = "a_m_y_ktown_01",
                name = "Edward"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "rentalbike2",
                    price = 75,
                    data = {
                        model = "scorcher",
                        positionStart = vector3(486.7, 5554.16, 784.37),
                        positionHeading = 292.27,
                        price = 75
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike",
                    price = 150,
                    data = {
                        model = "bf400",
                        positionStart = vector3(486.7, 5554.16, 784.37),
                        positionHeading = 292.27,
                        price = 150
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike4",
                    price = 150,
                    data = {
                        model = "sanchez",
                        positionStart = vector3(486.7, 5554.16, 784.37),
                        positionHeading = 292.27,
                        price = 150
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike5",
                    price = 150,
                    data = {
                        model = "manchez",
                        positionStart = vector3(486.7, 5554.16, 784.37),
                        positionHeading = 292.27,
                        price = 150
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike3",
                    price = 250,
                    data = {
                        model = "blazer4",
                        positionStart = vector3(486.7, 5554.16, 784.37),
                        positionHeading = 292.27,
                        price = 250
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "unrentalbike",
                    price = 0,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = UnspawnRental
                }
            }
        },
        {
            Title = "Loueur de véhicules - Cayo Perico",
            Pos = {x = 4493.665, y = -4516.681, z = 3.05, a = 36.00},
            Blips = {
                sprite = 1,
                color = 16,
                name = "Loueur de véhicules - Cayo Perico"
            },
            Ped = {
                model = "csb_gustavo",
                name = "Fernando"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "rentalbike5",
                    price = 150,
                    data = {
                        model = "manchez2",
                        positionStart = vector3(4493.537, -4514.080, 3.50),
                        positionHeading = 287.05,
                        price = 150
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike3",
                    price = 250,
                    data = {
                        model = "verus",
                        positionStart = vector3(4493.537, -4514.080, 3.50),
                        positionHeading = 287.05,
                        price = 250
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike6",
                    price = 400,
                    data = {
                        model = "winky",
                        positionStart = vector3(4493.537, -4514.080, 3.50),
                        positionHeading = 287.05,
                        price = 400
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalbike7",
                    price = 500,
                    data = {
                        model = "squaddie",
                        positionStart = vector3(4493.537, -4514.080, 3.50),
                        positionHeading = 287.05,
                        price = 500
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "unrentalbike",
                    price = 0,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = UnspawnRental
                }
            }
        },
        {
            Title = "Loueur de bateaux - Cayo Perico",
            Pos = {x = 4966.43, y = -5164.38, z = 0.80 - 0.92, a = 72.86},
            Blips = {
                sprite = 410,
                color = 16,
                name = "Loueur de bateaux"
            },
            Ped = {
                model = "u_m_y_mani",
                name = "Diego"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "rentalboat1",
                    price = 10000,
                    data = {
                        model = "dinghy",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 10000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat2",
                    price = 15000,
                    data = {
                        model = "jetmax",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 15000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat3",
                    price = 30000,
                    data = {
                        model = "marquis",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 30000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat4",
                    price = 5000,
                    data = {
                        model = "seashark3",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 5000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat5",
                    price = 20000,
                    data = {
                        model = "speeder",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 20000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat6",
                    price = 10000,
                    data = {
                        model = "squalo",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 10000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat7",
                    price = 12000,
                    data = {
                        model = "suntrap",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 12000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat8",
                    price = 35000,
                    data = {
                        model = "toro2",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 35000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat9",
                    price = 12000,
                    data = {
                        model = "tropic",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 12000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat10",
                    price = 50000,
                    data = {
                        model = "avisa",
                        positionStart = vector3(4927.67, -5149.46, 1.70),
                        positionHeading = 62.56,
                        price = 50000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat11",
                    price = 50000,
                    data = {
                        model = "longfin",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 50000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat12",
                    price = 10,
                    data = {
                        model = "predator",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 10
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = isPolice,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat13",
                    price = 10,
                    data = {
                        model = "dinghy",
                        positionStart = vector3(4956.12, -5163.31, -0.20),
                        positionHeading = 62.56,
                        price = 10
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = isSAMS,
                    afterPayment = SpawnBike
                },
                {
                    name = "unrentalboat",
                    price = 0,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = UnspawnRental
                }
            }
        },
        {
            Title = "Loueur de bateaux",
            Pos = {x = -850.20, y = -1367.54, z = 0.60, a = 284.72},
            Blips = {
                sprite = 410,
                color = 16,
                name = "Loueur de bateaux"
            },
            Ped = {
                model = "a_m_m_malibu_01",
                name = "Francis"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "rentalboat1",
                    price = 10000,
                    data = {
                        model = "dinghy",
                        positionStart = vector3(-846.73, -1364.29, -0.474),
                        positionHeading = 111.02,
                        price = 10000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat2",
                    price = 15000,
                    data = {
                        model = "jetmax",
                        positionStart = vector3(-846.73, -1364.29, -0.474),
                        positionHeading = 111.02,
                        price = 15000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat3",
                    price = 30000,
                    data = {
                        model = "marquis",
                        positionStart = vector3(-846.73, -1364.29, -0.474),
                        positionHeading = 111.02,
                        price = 30000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat4",
                    price = 5000,
                    data = {
                        model = "seashark3",
                        positionStart = vector3(-846.73, -1364.29, -0.474),
                        positionHeading = 111.02,
                        price = 5000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat5",
                    price = 20000,
                    data = {
                        model = "speeder",
                        positionStart = vector3(-846.73, -1364.29, -0.474),
                        positionHeading = 111.02,
                        price = 20000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat6",
                    price = 10000,
                    data = {
                        model = "squalo",
                        positionStart = vector3(-846.73, -1364.29, -0.474),
                        positionHeading = 111.02,
                        price = 10000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat7",
                    price = 12000,
                    data = {
                        model = "suntrap",
                        positionStart = vector3(-846.73, -1364.29, -0.474),
                        positionHeading = 111.02,
                        price = 12000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat8",
                    price = 35000,
                    data = {
                        model = "toro2",
                        positionStart = vector3(-846.73, -1364.29, -0.474),
                        positionHeading = 111.02,
                        price = 35000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat9",
                    price = 12000,
                    data = {
                        model = "tropic",
                        positionStart = vector3(-846.73, -1364.29, -0.474),
                        positionHeading = 111.02,
                        price = 12000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat10",
                    price = 50000,
                    data = {
                        model = "avisa",
                        positionStart = vector3(-850.48, -1363.29, -0.474),
                        positionHeading = 354.00,
                        price = 50000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat11",
                    price = 50000,
                    data = {
                        model = "longfin",
                        positionStart = vector3(-855.44, -1370.09, -0.301),
                        positionHeading = 354.00,
                        price = 50000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat12",
                    price = 10,
                    data = {
                        model = "predator",
                        positionStart = vector3(-855.44, -1370.09, -0.301),
                        positionHeading = 200.00,
                        price = 10
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = isPolice,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat13",
                    price = 10,
                    data = {
                        model = "dinghy",
                        positionStart = vector3(-855.44, -1370.09, -0.301),
                        positionHeading = 200.00,
                        price = 10
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = isSAMS,
                    afterPayment = SpawnBike
                },
                {
                    name = "unrentalboat",
                    price = 0,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = UnspawnRental
                }
            }
        },
        {
            Title = "Loueur de bateaux",
            Pos = {x = 3843.73, y = 4444.73, z = -0.50, a = 92.67},
            Blips = {
                sprite = 410,
                color = 16,
                name = "Loueur de bateaux"
            },
            Ped = {
                model = "a_m_m_malibu_01",
                name = "Julien"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "rentalboat1",
                    price = 10000,
                    data = {
                        model = "dinghy",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 10000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat2",
                    price = 15000,
                    data = {
                        model = "jetmax",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 15000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat3",
                    price = 30000,
                    data = {
                        model = "marquis",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 30000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat4",
                    price = 5000,
                    data = {
                        model = "seashark3",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 5000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat5",
                    price = 20000,
                    data = {
                        model = "speeder",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 20000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat6",
                    price = 10000,
                    data = {
                        model = "squalo",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 10000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat7",
                    price = 12000,
                    data = {
                        model = "suntrap",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 12000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat8",
                    price = 35000,
                    data = {
                        model = "toro2",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 35000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat9",
                    price = 12000,
                    data = {
                        model = "tropic",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 12000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat12",
                    price = 10,
                    data = {
                        model = "predator",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 10
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = isPolice,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat13",
                    price = 10,
                    data = {
                        model = "dinghy",
                        positionStart = vector3(3851.37, 4443.097, -0.474),
                        positionHeading = 256.71,
                        price = 10
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = isSAMS,
                    afterPayment = SpawnBike
                },
                {
                    name = "unrentalboat",
                    price = 0,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = UnspawnRental
                }
            }
        },
        {
            Title = "Loueur de bateaux",
            Pos = {x = 1437.46, y = 3819.74, z = 29.47, a = 308.90},
            Blips = {
                sprite = 410,
                color = 16,
                name = "Loueur de bateaux"
            },
            Ped = {
                model = "a_m_m_malibu_01",
                name = "Carl"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "rentalboat1",
                    price = 10000,
                    data = {
                        model = "dinghy",
                        positionStart = vector3(1440.11, 3823.43, 29.80),
                        positionHeading = 354.00,
                        price = 10000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat2",
                    price = 15000,
                    data = {
                        model = "jetmax",
                        positionStart = vector3(1440.11, 3823.43, 29.80),
                        positionHeading = 354.00,
                        price = 15000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                -- {
                --     name = "rentalboat3",
                --     price = 75,
                --     data = {
                --         model = "marquis",
                --         positionStart = vector3(-846.73, -1364.29, -0.474),
                --         positionHeading = 111.02,
                --         price = 75
                --     },
                --     noCount = true,
                --     noItem = true,
                --     beforePayment = nil,
                --     afterPayment = SpawnBike
                -- },
                {
                    name = "rentalboat4",
                    price = 5000,
                    data = {
                        model = "seashark3",
                        positionStart = vector3(1440.11, 3823.43, 29.80),
                        positionHeading = 354.00,
                        price = 5000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat5",
                    price = 20000,
                    data = {
                        model = "speeder",
                        positionStart = vector3(1440.11, 3823.43, 29.80),
                        positionHeading = 354.00,
                        price = 20000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat6",
                    price = 10000,
                    data = {
                        model = "squalo",
                        positionStart = vector3(1440.11, 3823.43, 29.80),
                        positionHeading = 354.00,
                        price = 10000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat7",
                    price = 12000,
                    data = {
                        model = "suntrap",
                        positionStart = vector3(1440.11, 3823.43, 29.80),
                        positionHeading = 354.00,
                        price = 12000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat8",
                    price = 35000,
                    data = {
                        model = "toro2",
                        positionStart = vector3(1440.11, 3823.43, 29.80),
                        positionHeading = 354.00,
                        price = 35000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat9",
                    price = 12000,
                    data = {
                        model = "tropic",
                        positionStart = vector3(1440.11, 3823.43, 29.80),
                        positionHeading = 354.00,
                        price = 12000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat12",
                    price = 10,
                    data = {
                        model = "predator",
                        positionStart = vector3(1440.11, 3823.43, 29.80),
                        positionHeading = 354.00,
                        price = 10
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = isPolice,
                    afterPayment = SpawnBike
                },
                {
                    name = "rentalboat13",
                    price = 10,
                    data = {
                        model = "dinghy",
                        positionStart = vector3(1440.11, 3823.43, 29.80),
                        positionHeading = 354.00,
                        price = 10
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = isSAMS,
                    afterPayment = SpawnBike
                },
                {
                    name = "unrentalboat",
                    price = 0,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = UnspawnRental
                }
            }
        },
        {
            Title = "Loueur de Jetski",
            Pos = {x = -1632.49, y = -1160.98, z = 1.04, a = 308.90},
            Blips = {
                sprite = 410,
                color = 16,
                name = "Loueur de Jetski"
            },
            Ped = {
                model = "a_m_y_jetski_01",
                name = "Billy"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "rentalboat4",
                    price = 5000,
                    data = {
                        model = "seashark3",
                        positionStart = vector3(-1634.30, -1158.49, 0.10),
                        positionHeading = 122.34,
                        price = 5000
                    },
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = SpawnBike
                },
                {
                    name = "unrentalboat",
                    price = 0,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = UnspawnRental
                }
            }
        },
        {
            Title = "Préfecture",
            Pos = {x = -448.32, y = 6012.58, z = 30.72, a = 310.20},
            Blips = {
                sprite = nil,
                color = 17,
                name = "Préfecture"
            },
            Ped = {
                model = "s_m_y_sheriff_01",
                name = "Marco"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Hidden = true,
            Items = {
                {
                    name = "identity",
                    price = 15,
                    data = {},
                    type = "identity",
                    fct = GetIdentity
                }
            }
        },
        {
            Title = "Préfecture",
            Pos = {x = 1853.14, y = 3689.05, z = 33.25, a = 206.83},
            Blips = {
                sprite = nil,
                color = 17,
                name = "Préfecture"
            },
            Ped = {
                model = "s_m_y_sheriff_01",
                name = "John"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Hidden = true,
            Items = {
                {
                    name = "identity",
                    price = 15,
                    data = {},
                    type = "identity",
                    fct = GetIdentity
                }
            }
        },
        {
            Title = "Supérette El Rancho Boulevard",
            Pos = {x = 1134.182, y = -982.477, z = 45.416, a = 275.432},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_y_indian_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShopsSouth,
            bzone = "police"
        },
        {
            Title = "Joé",
            Pos = {x = 1119.98, y = -639.6, z = 55.81, a = 293.06},
            Blips = {
                sprite = 1,
                color = 6,
                name = "Joé"
            },
            Ped = {
                model = "u_m_o_taphillbilly"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "radio",
                    price = 80,
                    data = {}
                },
                {
                    name = "parapluie",
                    price = 10,
                    data = {}
                },
                {
                    name = "ciseaux",
                    price = 10,
                    data = {}
                },
                {
                    name = "binoculars",
                    price = 100,
                    data = {}
                },
            }
        },
        {
            Title = "Mike",
            Pos = {x = -348.67, y = -46.88, z = 53.42, a = 339.53},
            Blips = {
                Enabled = false
                -- sprite = 1,
                -- color = 6,
                -- name = "Joé"
            },
            Ped = {
                model = "a_m_m_skater_01"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "pinces",
                    price = 15,
                    data = {}
                },
                -- {
                --     name = "fertz",
                --     price = 100,
                --     data = {}
                -- },
                {
                    name = "crochetage",
                    price = 200,
                    data = {}
                },
                {
                    name = "menottes",
                    price = 70,
                    data = {}
                },
                {
                    name = "darknet",
                    price = 500,
                    data = {}
                },
                {
                    name = "molotov",
                    price = 15000,
                    data = {}
                },
                -- {
                --     name = "can",
                --     price = 1,
                --     data = {},
                -- },
                {
                    name = "pelle",
                    price = 500,
                    data = {}
                },
                {
                    name = "masse",
                    price = 500,
                    data = {}
                },
                {
                    name = "katana",
                    price = 1000,
                    data = {}
                },
                {
                    name = "pioche",
                    price = 2000,
                    data = {}
                },
                -- {
                --     name = "allumette",
                --     price = 100,
                --     data = {}
                -- },
                {
                    name = "molotovartisanal",
                    price = 500,
                    data = {}
                }
            }
        },
        {
            Title = "Casino",
            Pos = {x = -1633.951, y = -2994.321, z = -79.15, a = 181.00},
            Blips = {},
            Ped = {
                model = "s_f_y_clubbar_01"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "casinopiece",
                    price = 10,
                    data = {}
                }
            }
        },
        {
            Title = "Casino",
            Pos = {x = 967.82, y = 46.80, z = 71.70 - 0.98, a = 145.76},
            Blips = {},
            Ped = {
                model = "s_f_y_clubbar_01"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            isCasino = true,
            Items = {
                {
                    name = "casinopiece",
                    price = 10,
                    data = {}
                }
            }
        },
        {
            Title = "Prison",
            Pos = {x = 1689.62, y = 2551.88, z = 45.56 - 0.98, a = 209.72},
            Blips = {},
            Ped = {
                model = "s_m_y_robber_01"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "water",
                    price = 15,
                    data = {}
                },
                {
                    name = "bread",
                    price = 2,
                    data = {}
                }
            }
        },
        {
            Title = "Prison",
            Pos = {x = 1689.62, y = 2551.88, z = 45.56 - 0.98, a = 209.72},
            Blips = {
                sprite = nil,
                color = 6,
                name = "Le marmiton"
            },
            Ped = {
                model = "s_m_y_robber_01"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "water",
                    price = 15,
                    data = {}
                },
                {
                    name = "bread",
                    price = 2,
                    data = {}
                }
            }
        },
        {
            Title = "Raoul bon plan",
            Pos = {x = 1715.75, y = 2618.86, z = 45.56 - 0.98, a = 313.17},
            Blips = {
                sprite = nil,
                color = 6,
                name = "Raoul bon plan"
            },
            Ped = {
                model = "s_m_y_robber_01"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "knife1",
                    price = 8000,
                    data = {}
                },
                {
                    name = "casinopiece",
                    price = 10,
                    data = {}
                },
                {
                    name = "bottle",
                    price = 5500,
                    data = {}
                },
                {
                    name = "tel",
                    price = 7500,
                    data = {}
                }
            }
        },
        -- {
        --     Pos = {x = 24.376, y = -1345.558, z = 28.421, a = 267.940},
        --     Blips = {
        --         sprite = 59,
        --         color = 43,
        --         name = "Magasin"
        --     },
        --     Ped = {
        --         model = "mp_m_shopkeep_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = true
        --     },
        --     Items = BasicShopsSouth,
        --     bzone = "police"
        -- },
        {
            Title = "LTD Vinewood",
            Pos = {x = 373.015, y = 328.332, z = 102.566, a = 257.309},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_m_indian_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShopsSouth,
            bzone = "police"
        },
        { --LTD NORD
            Title = "LTD Grapeseed",
            Pos = {x = 1697.58, y = 4923.24, z = 41.06, a = 328.71},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_m_indian_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShopsNorth,
            bzone = "lssd"
        },
        {
            Title = "Fournisseur Post OP",
            Hidden = true,
            RestrictedJob = {"grossiste"},
            RestrictedGrade = {"chef","drh", "boss"},
            Pos = {x = 1198.2707, y = -3276.7304, z = 4.51, a = 262.6681}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Post Op"
            },
            Ped = {
                model = "s_m_y_airworker",
                name = "Henry"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "batte",
                    price = 80,
                    data = {}
                },
                {
                    name = "metalpiece9",
                    price = 400,
                    data = {}
                },
                {
                    name = "metalpiece10",
                    price = 500,
                    data = {}
                },
                {
                    name = "metalpiece6",
                    price = 8000,
                    data = {}
                },
                {
                    name = "metalpiece3",
                    price = 300,
                    data = {}
                },
                {
                    name = "metalpiece5",
                    price = 1800,
                    data = {}
                },
                {
                    name = "metalpiece2",
                    price = 300,
                    data = {}
                },
                {
                    name = "metalpiece4",
                    price = 1200,
                    data = {}
                },
                {
                    name = "metalpiece1",
                    price = 600,
                    data = {}
                },
                {
                    name = "metalpiece11",
                    price = 150,
                    data = {}
                },
                {
                    name = "golf",
                    price = 80,
                    data = {}
                },
                {
                    name = "knife",
                    price = 80,
                    data = {}
                },
                {
                    name = "knife1",
                    price = 200,
                    data = {}
                },
                {
                    name = "plasticpiece3",
                    price = 90,
                    data = {}
                },
                {
                    name = "woodpiece3",
                    price = 200,
                    data = {}
                },
                ---
                {
                    name = "teargas",
                    price = 20,
                    data = {}
                },
                {
                    name = "hatchet",
                    price = 150,
                    data = {}
                },
                {
                    name = "flashlight",
                    price = 20,
                    data = {}
                },
                {
                    name = "nightstick",
                    price = 20,
                    data = {}
                },
                {
                    name = "hammer",
                    price = 80,
                    data = {}
                },
                {
                    name = "snip",
                    price = 1,
                    data = {}
                },
                {
                    name = "cab",
                    price = 1,
                    data = {}
                },
                {
                    name = "acp45",
                    price = 1,
                    data = {}
                },
                {
                    name = "cab2",
                    price = 1,
                    data = {}
                },
                {
                    name = "mm9",
                    price = 1,
                    data = {}
                },
                {
                    name = "calibre12",
                    price = 1,
                    data = {}
                },
                {
                    name = "crowbar",
                    price = 80,
                    data = {}
                },
                {
                    name = "plasticpiece2",
                    price = 40,
                    data = {}
                },
                {
                    name = "metalpiece13",
                    price = 200,
                    data = {}
                },
                {
                    name = "metalpiece14",
                    price = 350,
                    data = {}
                },
                {
                    name = "woodpiece2",
                    price = 75,
                    data = {}
                },
                {
                    name = "plasticpiece1",
                    price = 20,
                    data = {}
                },
                {
                    name = "woodpiece1",
                    price = 100,
                    data = {}
                },
                {
                    name = "knuckle",
                    price = 80,
                    data = {}
                },
                {
                    name = "poolcue",
                    price = 80,
                    data = {}
                },
                {
                    name = "plasticpiece4",
                    price = 70,
                    data = {}
                },
                {
                    name = "metalpiece7",
                    price = 100,
                    data = {}
                },
                {
                    name = "plasticpiece5",
                    price = 70,
                    data = {}
                },
                {
                    name = "metalpiece8",
                    price = 100,
                    data = {}
                },
                {
                    name = "metalpiece12",
                    price = 200,
                    data = {}
                },
                {
                    name = "woodpiece4",
                    price = 500,
                    data = {}
                },
                {
                    name = "menottes",
                    price = 1,
                    data = {}
                },


            }
        },
        -- {
        --     Title = "Liquor Ace Sandy Shores",
        --     Pos = {x = 1392.94, y = 3606.44, z = 33.98, a = 192.91},
        --     Blips = {
        --         sprite = 59,
        --         color = 43,
        --         name = "Magasin"
        --     },
        --     Ped = {
        --         model = "a_m_m_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = true
        --     },
        --     Items = BasicShopsNorth,
        --     bzone = "lssd"
        -- },
        {
            Title = "LTD Mirror Park",
            Pos = {x = 1164.565, y = -322.121, z = 68.205, a = 100.492},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_y_indian_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShopsSouth,
            bzone = "police"
        },
        {
            Title = "Liquor Ace Del Perro",
            Pos = {x = -1486.530, y = -377.768, z = 39.163, a = 147.669},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_y_indian_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShopsSouth,
            bzone = "police"
        },
        {
            Title = "Liquor Ace Vespucci",
            Pos = {x = -1221.568, y = -908.121, z = 11.326, a = 31.739},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_y_indian_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShopsSouth,
            bzone = "police"
        },
        {
            Title = "LTD Paleto Est",
            Pos = {x = 1728.614, y = 6416.729, z = 34.037, a = 247.369},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_m_indian_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShopsNorth,
            bzone = "lssd"
        },
        {
            Title = "LTD Sandy Shores",
            Pos = {x = 1958.960, y = 3741.979, z = 31.344, a = 303.196},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_m_indian_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShopsNorth,
            bzone = "lssd"
        },
        -- {
        --     Title = "LTD YOU TOOL",
        --     Pos = {x = 2676.389, y = 3280.362, z = 54.241, a = 332.305},
        --     Blips = {
        --         sprite = 59,
        --         color = 43,
        --         name = "Magasin"
        --     },
        --     Ped = {
        --         model = "a_m_m_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = true
        --     },
        --     Items = BasicShopsNorth,
        --     bzone = "lssd"
        -- },
        -- {
        --     Title = "LTD Chumash",
        --     Pos = {x = -3243.99, y = 999.86, z = 11.83, a = 0.0},
        --     Blips = {
        --         sprite = 59,
        --         color = 43,
        --         name = "Magasin"
        --     },
        --     Ped = {
        --         model = "a_m_y_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = true
        --     },
        --     Items = BasicShopsNorth,
        --     bzone = "lssd"
        -- },
        -- {
        --     Title = "Liquor Ace Banham Canyon",
        --     Pos = {x = -2966.391, y = 391.324, z = 14.043, a = 88.867},
        --     Blips = {
        --         sprite = 59,
        --         color = 43,
        --         name = "Magasin"
        --     },
        --     Ped = {
        --         model = "a_m_y_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = true
        --     },
        --     Items = BasicShopsNorth,
        --     bzone = "lssd"
        -- },
        -- {
        --     Title = "LTD Palomino Freeway",
        --     Pos = {x = 2555.474, y = 380.909, z = 107.623, a = 355.737},
        --     Blips = {
        --         sprite = 59,
        --         color = 43,
        --         name = "Magasin"
        --     },
        --     Ped = {
        --         model = "a_m_y_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = true
        --     },
        --     Items = BasicShopsNorth,
        --     bzone = "lssd"
        -- },
        {
            Title = "LTD North Rockford Drive",
            Pos = {x = -1820.230, y = 794.343, z = 137.089, a = 130.327},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_m_indian_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShopsSouth,
            bzone = "police"
        },
        -- {
        --     Title = "LTD Banham Canyon",
        --     Pos = {x = -3041.18, y = 583.85, z = 6.91, a = 16.09},
        --     Blips = {
        --         sprite = 59,
        --         color = 43,
        --         name = "Magasin"
        --     },
        --     Ped = {
        --         model = "a_m_m_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = true
        --     },
        --     Items = BasicShopsNorth,
        --     bzone = "lssd"
        -- },
        -- {
        --     Title = "LTD Route 68 Ouest",
        --     Pos = {x = 549.35, y = 2669.06, z = 41.16, a = 90.0},
        --     Blips = {
        --         sprite = 59,
        --         color = 43,
        --         name = "Magasin"
        --     },
        --     Ped = {
        --         model = "a_m_m_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = true
        --     },
        --     Items = BasicShopsNorth,
        --     bzone = "lssd"
        -- },
        -- {
        --     Title = "Liquor Ace Route 68 Est",
        --     Pos = {x = 1165.91, y = 2710.77, z = 37.16, a = 180.0},
        --     Blips = {
        --         sprite = 59,
        --         color = 43,
        --         name = "Magasin"
        --     },
        --     Ped = {
        --         model = "a_m_y_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = true
        --     },
        --     Items = BasicShopsNorth,
        --     bzone = "lssd"
        -- },
        { -- LTD SUD
            Title = "LTD Little Seoul",
            Pos = {x = -705.9, y = -913.5, z = 18.22, a = 92.47},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_y_ktown_01",
                name = "Tao"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = LittleSeoulShop,
            bzone = "police"
        },
        -- {
        --     Pos = {x = 161.89, y = 6642.98, z = 30.71, a = 218.23},
        --     Blips = {
        --         sprite = 59,
        --         color = 43,
        --         name = "Magasin"
        --     },
        --     Ped = {
        --         model = "a_m_y_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = true
        --     },
        --     Items = BasicShopsNorth,
        --     bzone = "lssd"
        -- }, --LTD NORD
        {
            Title = "LTD Grove Street",
            Pos = {x = -47.321, y = -1758.669, z = 28.45, a = 57.08},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "a_m_y_indian_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShopsNorth,
            bzone = "lssd",
            braquable = false
        },
        -- {
        --     Title = "Fournisseur Osaka Tsubaki",
        --     Hidden = true,
        --     RestrictedJob = {"osakatsubaki"},
        --     RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
        --     Pos = {x = -175.2, y = 321.92, z = 96.99, a = 182.87}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Osakatsubaki"
        --     },
        --     Ped = {
        --         model = "s_m_y_chef_01",
        --         name = "Kiyo"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "aperitif",
        --             price = 1,
        --             data = {}
        --         },
        --         {
        --             name = "rice",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "filet",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "bouillon",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "noddle",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "fish12",
        --             price = 20,
        --             data = {}
        --         },
        --         {
        --             name = "feuillenori",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "sake",
        --             price = 20,
        --             data = {}
        --         },
        --         {
        --             name = "milk",
        --             price = 5,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Fournisseur Pearl's",
        --     Hidden = true,
        --     RestrictedJob = {"restaurant"},
        --     RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
        --     Pos = {x = -1852.43, y = -1197.92, z = 12.02, a = 241.75}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Restaurant"
        --     },
        --     Ped = {
        --         model = "s_m_y_chef_01",
        --         name = "Bob"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "aperitif",
        --             price = 1,
        --             data = {}
        --         },
        --         {
        --             name = "entreepearl",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "entreepearl2",
        --             price = 5,
        --             data = {}
        --         },
        --         -- {
        --         --     name = "platpearl",
        --         --     price = 5,
        --         --     data = {}
        --         -- },
        --         {
        --             name = "boissonpearl",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "bread",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "poissontahitienne",
        --             price = 20,
        --             data = {}
        --         },
        --         {
        --             name = "burgerpoisson",
        --             price = 20,
        --             data = {}
        --         },
        --         {
        --             name = "tatakithon",
        --             price = 20,
        --             data = {}
        --         }
        --     }
        -- },
        {
            Title = "Vendeur de parachute",
            Hidden = true,
            Pos = {x = -1620.59, y = -3151.68, z = 13.99 - 0.98, a = 49.82}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Parachute"
            },
            Ped = {
                model = "csb_ramp_hipster",
                name = "Mickael"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "parachute",
                    price = 100,
                    data = {}
                }
            }
        },
        -- {
        --     Title = "Fournisseur BurgerShot",
        --     Hidden = true,
        --     RestrictedJob = {"burgershot"},
        --     RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
        --     Pos = {x = -1338.8, y = -941.74, z = 11.35, a = 335.06}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Cuisto FoodTruck"
        --     },
        --     Ped = {
        --         model = "s_m_y_chef_01",
        --         name = "Darnell"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "meat",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "cola",
        --             price = 3,
        --             data = {}
        --         },
        --         {
        --             name = "bread",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "donut",
        --             price = 3,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Fournisseur Ammunation",
        --     Hidden = true,
        --     RestrictedJob = {"ammunation"},
        --     RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
        --     Pos = {x = 814.16, y = -2153.12, z = 28.61, a = 90.76}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Vendeur de pièces en métal"
        --     },
        --     Ped = {
        --         model = "mp_m_waremech_01",
        --         name = "Pierce"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "metalpiece1",
        --             price = 1250,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece2",
        --             price = 750,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece3",
        --             price = 750,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece4",
        --             price = 2450,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece5",
        --             price = 3950,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece6",
        --             price = 17500,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece7",
        --             price = 300,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece8",
        --             price = 300,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece9",
        --             price = 850,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece10",
        --             price = 1050,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece11",
        --             price = 250,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece12",
        --             price = 400,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece13",
        --             price = 400,
        --             data = {}
        --         },
        --         {
        --             name = "metalpiece14",
        --             price = 800,
        --             data = {}
        --         }
        --     }
        -- },
        
        {
            Title = "Fournisseur armes blanches",
            Hidden = true,
            RestrictedJob = {"condenados"},
            RestrictedGrade = {"cdd", "drh", "boss"},
            Pos = {x = 3810.65, y = 4489.95, z = 4.99, a = 290.17}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Fournisseur"
            },
            Ped = {
                model = "mp_m_weapexp_01",
                name = "Juan"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "machete",
                    price = 250,
                    data = {}
                },
                {
                    name = "hatchet",
                    price = 250,
                    data = {}
                },
                {
                    name = "dagger",
                    price = 250,
                    data = {}
                },
                {
                    name = "knuckle",
                    price = 250,
                    data = {}
                },
                {
                    name = "knife1",
                    price = 250,
                    data = {}
                },
                {
                    name = "knife",
                    price = 250,
                    data = {}
                },
                {
                    name = "hammer",
                    price = 250,
                    data = {}
                },
                {
                    name = "batte",
                    price = 250,
                    data = {}
                },
                {
                    name = "golf",
                    price = 250,
                    data = {}
                },
                {
                    name = "crowbar",
                    price = 250,
                    data = {}
                },
                {
                    name = "bottle",
                    price = 250,
                    data = {}
                }
            }
        },
        -- {
        --     Title = "Fournisseur Ammunation",
        --     Hidden = true,
        --     RestrictedJob = {"ammunation"},
        --     RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
        --     Pos = {x = -584.38, y = 5289.39, z = 69.26, a = 55.68}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Vendeur de pièces en bois"
        --     },
        --     Ped = {
        --         model = "s_m_m_lathandy_01",
        --         name = "Woody"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "woodpiece1",
        --             price = 300,
        --             data = {}
        --         },
        --         {
        --             name = "woodpiece2",
        --             price = 200,
        --             data = {}
        --         },
        --         {
        --             name = "woodpiece3",
        --             price = 500,
        --             data = {}
        --         },
        --         {
        --             name = "woodpiece4",
        --             price = 12000,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Fournisseur Ammunation",
        --     Hidden = true,
        --     RestrictedJob = {"ammunation"},
        --     RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
        --     Pos = {x = 286.32, y = -3029.06, z = 4.69, a = 259.22}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Vendeur de pièces en plastique"
        --     },
        --     Ped = {
        --         model = "s_m_y_dockwork_01",
        --         name = "Tulio"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "plasticpiece1",
        --             price = 50,
        --             data = {}
        --         },
        --         {
        --             name = "plasticpiece2",
        --             price = 100,
        --             data = {}
        --         },
        --         {
        --             name = "plasticpiece3",
        --             price = 200,
        --             data = {}
        --         },
        --         {
        --             name = "plasticpiece4",
        --             price = 150,
        --             data = {}
        --         },
        --         {
        --             name = "plasticpiece5",
        --             price = 150,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Fournisseur Mécano",
        --     Hidden = true,
        --     RestrictedJob = {"bennys"},
        --     RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
        --     Pos = {x = -196.25, y = -1315.54, z = 30.09, a = 117.28}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Mécano"
        --     },
        --     Ped = {
        --         model = "ig_benny",
        --         name = "Jesus"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "repairbox",
        --             price = 150,
        --             data = {}
        --         },
        --         {
        --             name = "repairbox2",
        --             price = 450,
        --             data = {}
        --         },
        --         {
        --             name = "chariot",
        --             price = 10,
        --             data = {}
        --         },
        --         {
        --             name = "cone",
        --             price = 50,
        --             data = {}
        --         },
        --         {
        --             name = "wrench",
        --             price = 250,
        --             data = {}
        --         },
        --         {
        --             name = "hammer",
        --             price = 250,
        --             data = {}
        --         },
        --         {
        --             name = "crowbar",
        --             price = 250,
        --             data = {}
        --         },
        --         {
        --             name = "masse",
        --             price = 250,
        --             data = {}
        --         },
        --         {
        --             name = "lavage",
        --             price = 25,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Fournisseur Mécano",
        --     Hidden = true,
        --     RestrictedJob = {"mecano"},
        --     RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
        --     Pos = {x = -351.73, y = -120.49, z = 38.43, a = 71.11}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Mécano"
        --     },
        --     Ped = {
        --         model = "ig_benny",
        --         name = "Angel"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "repairbox",
        --             price = 150,
        --             data = {}
        --         },
        --         {
        --             name = "repairbox2",
        --             price = 450,
        --             data = {}
        --         },
        --         {
        --             name = "chariot",
        --             price = 10,
        --             data = {}
        --         },
        --         {
        --             name = "cone",
        --             price = 50,
        --             data = {}
        --         },
        --         {
        --             name = "wrench",
        --             price = 250,
        --             data = {}
        --         },
        --         {
        --             name = "hammer",
        --             price = 250,
        --             data = {}
        --         },
        --         {
        --             name = "crowbar",
        --             price = 250,
        --             data = {}
        --         },
        --         {
        --             name = "masse",
        --             price = 250,
        --             data = {}
        --         },
        --         {
        --             name = "lavage",
        --             price = 25,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Fournisseur Mécano",
        --     Hidden = true,
        --     RestrictedJob = {"mecano2"},
        --     RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
        --     Pos = {x = 103.14, y = 6614.50, z = 31.43, a = 346.46},
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Mécano"
        --     },
        --     Ped = {
        --         model = "mp_f_bennymech_01",
        --         name = "Jessy"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "repairbox",
        --             price = 150,
        --             data = {}
        --         },
        --         {
        --             name = "repairbox2",
        --             price = 450,
        --             data = {}
        --         },
        --         {
        --             name = "chariot",
        --             price = 10,
        --             data = {}
        --         },
        --         {
        --             name = "cone",
        --             price = 50,
        --             data = {}
        --         },
        --         {
        --             name = "lavage",
        --             price = 25,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Fournisseur Larry's",
        --     Hidden = true,
        --     RestrictedJob = {"caroccasions"},
        --     RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
        --     Pos = {x = 1171.62, y = 2637.16, z = 36.78, a = 290.37},
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Assistant"
        --     },
        --     Ped = {
        --         model = "s_m_y_xmech_01",
        --         name = "Stan"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "repairbox",
        --             price = 150,
        --             data = {}
        --         },
        --         {
        --             name = "repairbox2",
        --             price = 450,
        --             data = {}
        --         },
        --         {
        --             name = "chariot",
        --             price = 10,
        --             data = {}
        --         },
        --         {
        --             name = "cone",
        --             price = 50,
        --             data = {}
        --         },
        --         {
        --             name = "lavage",
        --             price = 25,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Fournisseur Car Wash",
        --     Hidden = true,
        --     RestrictedJob = {"carwash"},
        --     RestrictedGrade = {"drh", "boss"},
        --     Pos = {x = 171.18, y = -1722.91, z = 28.39, a = 147.96}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "CarWash"
        --     },
        --     Ped = {
        --         model = "g_m_y_ballasout_01",
        --         name = "Tyron"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
                
        --         {
        --             name = "lavage",
        --             price = 25,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Fournisseur SAMS",
        --     Hidden = true,
        --     RestrictedJob = {"lsms"},
        --     RestrictedGrade = {"infirmier", "medecin", "medecinchef", "drh", "boss"},
        --     Pos = {x = 1828.23, y = 3675.16, z = 33.27, a = 233.9}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Médecin"
        --     },
        --     Ped = {
        --         model = "s_m_m_doctor_01",
        --         name = "John"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "medbox",
        --             price = 150,
        --             data = {}
        --         },
        --         {
        --             name = "medikit",
        --             price = 200,
        --             data = {}
        --         },
        --         {
        --             name = "mec",
        --             price = 75,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Fournisseur SAMS",
        --     Hidden = true,
        --     RestrictedJob = {"lsms"},
        --     RestrictedGrade = {"infirmier", "medecin", "medecinchef", "drh", "boss"},
        --     Pos = {x = 311.67, y = -594.04, z = 42.28, a = 335.15}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Médecin"
        --     },
        --     Ped = {
        --         model = "s_m_m_doctor_01",
        --         name = "Karl"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "medbox",
        --             price = 100,
        --             data = {}
        --         },
        --         {
        --             name = "medbag",
        --             price = 100,
        --             data = {}
        --         },
        --         {
        --             name = "medikit",
        --             price = 200,
        --             data = {}
        --         },
        --         {
        --             name = "mec",
        --             price = 75,
        --             data = {}
        --         }
        --     }
        -- },
        {
            Title = "Fournisseur Gouv",
            Hidden = true,
            RestrictedJob = {"gouv", "doj"},
            RestrictedGrade = {"agent", "irs", "usdss"},
            Pos = {x = -583.170, y = -203.226, z = 41.70, a = 206.37}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Armurerie Agent sécu"
            },
            Ped = {
                model = "cs_fbisuit_01",
                name = "Rico"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "mm9",
                    price = 2,
                    data = {}
                },
                -- {
                --     name = "cab",
                --     price = 2,
                --     data = {}
                -- },
                -- {
                --     name = "calibre12",
                --     price = 2,
                --     data = {}
                -- },
                -- {
                --     name = "acp45",
                --     price = 2,
                --     data = {}
                -- },
                -- {
                --     name = "pistol",
                --     price = 1200,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "pistolcombat",
                --     price = 1890,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "pistol50",
                --     price = 1560,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "stungun",
                --     price = 530,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "flaregun",
                --     price = 250,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "assaultsmg",
                --     price = 15000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "nightstick",
                --     price = 50,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "teargas",
                --     price = 75,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "carrabine",
                --     price = 20000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "shootguncompact",
                --     price = 3400,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "shootgun",
                --     price = 4300,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "assaultsmg",
                --     price = 14000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- }
                -- {
                --     name = "heavysniper",
                --     price = 50000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "compactrifle",
                --     price = 25000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
            }
        },
--         {
--             Title = "Fournisseur police",
--             Hidden = true,
--             RestrictedJob = {"police"},
--             RestrictedGrade = {"drh", "boss"},
--             Pos = {x = -1103.76, y = -821.33, z = 13.28, a = 213.79}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
--             Blips = {
--                 sprite = 478,
--                 Enabled = false, -- Image off
--                 color = 43,
--                 name = "Police"
--             },
--             Ped = {
--                 model = "s_m_y_cop_01",
--                 name = "John"
--             },
--             Menus = {
--                 Sprite = "shopui_title_conveniencestore",
--                 Enabled = false
--             },
--             braquable = false,
--             Items = {
--                 {
--                     name = "mm9",
--                     price = 2,
--                     data = {}
--                 },
--                 {
--                     name = "cab",
--                     price = 2,
--                     data = {}
--                 },
--                 {
--                     name = "cab2",
--                     price = 2,
--                     data = {}
--                 },
--                 {
--                     name = "calibre12",
--                     price = 2,
--                     data = {}
--                 },
--                 {
--                     name = "acp45",
--                     price = 2,
--                     data = {}
--                 },
--                 -- {
--                 --     name = "pistol",
--                 --     price = 1200,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type =  "serial"
--                 -- },
--                 -- {
--                 --     name = "pistolcombat",
--                 --     price = 1890,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type = "serial"
--                 -- },
--                 -- {
--                 --     name = "pistol50",
--                 --     price = 1560,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type =  "serial"
--                 -- },
--                 -- {
--                 --     name = "stungun",
--                 --     price = 530,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type = "serial"
--                 -- },
--                 {
--                     name = "flaregun",
--                     price = 250,
--                     data = {},
--                     fct = GeneratePoliceSerial,
--                     type = "serial"
--                 },
--                 -- {
--                 --     name = "assaultsmg",
--                 --     price = 15000,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type =  "serial"
--                 -- },
--                 -- {
--                 --     name = "nightstick",
--                 --     price = 50,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type = "serial"
--                 -- },
--                 -- {
--                 --     name = "teargas",
--                 --     price = 75,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type = "serial"
--                 -- },
--                 -- {
--                 --     name = "carrabine",
--                 --     price = 20000,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type = "serial"
--                 -- },
--                 -- {
--                 --     name = "beanbag",
--                 --     price = 3400,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type = "serial"
--                 -- },
--                 -- {
--                 --     name = "shootgun",
--                 --     price = 4300,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type = "serial"
--                 -- },
--                 -- {
--                 --     name = "smg",
--                 --     price = 14000,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type = "serial"
--                 -- },
-- --[[                 {
--                     name = "kevlar",
--                     price = 3000,
--                     data = {status = 25, showLabel = "Kevlar Léger", label = "Léger"},
--                     fct = GeneratePoliceSerial,
--                     type = "serial"
--                   },
--                   {
--                     name = "kevlar",
--                     price = 6000,
--                     data = {status = 50, showLabel = "Kevlar Renforcé", label = "Renforcé"},
--                     fct = GeneratePoliceSerial,
--                     type = "serial"
--                   },
--                   {
--                     name = "kevlar",
--                     price = 9000,
--                     data = {status = 75, showLabel = "Kevlar SWAT", label = "SWAT"},
--                     fct = GeneratePoliceSerial,
--                     type = "serial"
--                   } ]]
--                 -- {
--                 --     name = "heavysniper",
--                 --     price = 50000,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type =  "serial"
--                 -- },
--                 -- {
--                 --     name = "compactrifle",
--                 --     price = 25000,
--                 --     data = {},
--                 --     fct = GeneratePoliceSerial,
--                 --     type =  "serial"
--                 -- },
--             }
--         },
        {
            Title = "Fournisseur USMS",
            Hidden = true,
            RestrictedJob = {"usms"},
            RestrictedGrade = {"drh", "boss"},
            Pos = {x = 480.32, y = -996.76, z = 30.68, a = 86.11}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "USMS"
            },
            Ped = {
                model = "s_m_m_fibsec_01",
                name = "Bob"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "menottes",
                    price = 70,
                    data = {}
                },
                {
                    name = "radio",
                    price = 80,
                    data = {}
                },
                {
                    name = "mm9",
                    price = 2,
                    data = {}
                },
                {
                    name = "cab2",
                    price = 2,
                    data = {}
                },
                {
                    name = "calibre12",
                    price = 2,
                    data = {}
                },
                {
                    name = "acp45",
                    price = 2,
                    data = {}
                },
                -- {
                --     name = "pistol",
                --     price = 1200,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "pistolcombat",
                --     price = 1890,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "pistol50",
                --     price = 1560,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "stungun",
                --     price = 530,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                {
                    name = "flaregun",
                    price = 250,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                -- {
                --     name = "assaultsmg",
                --     price = 15000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "nightstick",
                --     price = 50,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "teargas",
                --     price = 75,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "carrabine",
                --     price = 20000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "beanbag",
                --     price = 3400,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "shootgun",
                --     price = 4300,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "smg",
                --     price = 14000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "kevlar",
                --     price = 3000,
                --     data = {status = 25, showLabel = "Kevlar Léger", label = "Léger"},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                --   },
                --   {
                --     name = "kevlar",
                --     price = 6000,
                --     data = {status = 50, showLabel = "Kevlar Renforcé", label = "Renforcé"},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                --   },
                --   {
                --     name = "kevlar",
                --     price = 9000,
                --     data = {status = 75, showLabel = "Kevlar SWAT", label = "SWAT"},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                --   },
                --   {
                --     name = "kevlar",
                --     price = 12000,
                --     data = {status = 100, showLabel = "Kevlar Militaire", label = "Militaire"},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                --   }
                -- {
                --     name = "heavysniper",
                --     price = 50000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "compactrifle",
                --     price = 25000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
            }
        },
        --[[{
            Title = "Annonce Weazel News",
            Hidden = true,
            Pos = {x = -599.38, y = -933.59, z = 22.86, a = 86.92},
            Ped = {
                model = "u_f_m_promourn_01",
                name = "Michelle"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "wzlAnnouncement",
                    price = 500,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = nil,
                    afterPayment = PubWeazel
                }
            }
        },]]
        -- {
        --     Title = "Grossiste LTD",
        --     Hidden = true,
        --     RestrictedJob = {"ltdnord"},
        --     RestrictedGrade = {"chef", "drh", "boss"},
        --     Pos = {x = 67.73, y = 6310.69, z = 30.38, a = 214.87},
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Grossiste"
        --     },
        --     Ped = {
        --         model = "a_m_y_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "tel",
        --             price = 20,
        --             data = {battery = 99},
        --             fct = GeneratePhoneNumber,
        --             type = "number"
        --         },
        --         {
        --             name = "pinces",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "radio",
        --             price = 5,
        --             data = {}
        --         },
        --         -- {
        --         --     name = "fertz",
        --         --     price = 2,
        --         --     data = {}
        --         -- },
        --         {
        --             name = "parapluie",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "ciseaux",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "menottes",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "binoculars",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "gascan",
        --             price = 2,
        --             data = {},
        --             fct = GenerateApuSerial,
        --             type = "serial"
        --         },
        --         {
        --             name = "blocnote",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "makeup",
        --             price = 25,
        --             data = {}
        --         },
        --         {
        --             name = "tapas",
        --             price = 3,
        --             data = {}
        --         },
        --         {
        --             name = "cafe",
        --             price = 1,
        --             data = {}
        --         },
        --         {
        --             name = "jus",
        --             price = 3,
        --             data = {}
        --         },
        --         {
        --             name = "mentos",
        --             price = 1,
        --             data = {}
        --         },
        --         {
        --             name = "water",
        --             price = 1,
        --             data = {}
        --         },
        --         {
        --             name = "cola",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "ricemilk",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "chips",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "fishingrod",
        --             price = 25,
        --             data = {}
        --         }
        --     }
        -- },
        -- {
        --     Title = "Grossiste LTD",
        --     Hidden = true,
        --     RestrictedJob = {"ltdsud"},
        --     RestrictedGrade = {"chef", "drh", "boss"},
        --     Pos = {x = 671.41, y = -2672.64, z = 5.26, a = 89.09},
        --     Blips = {
        --         sprite = 478,
        --         Enabled = false, -- Image off
        --         color = 43,
        --         name = "Grossiste"
        --     },
        --     Ped = {
        --         model = "a_m_y_indian_01",
        --         name = "Apu"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     braquable = false,
        --     Items = {
        --         {
        --             name = "tel",
        --             price = 20,
        --             data = {battery = 99},
        --             fct = GeneratePhoneNumber,
        --             type = "number"
        --         },
        --         {
        --             name = "pinces",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "radio",
        --             price = 5,
        --             data = {}
        --         },
        --         -- {
        --         --     name = "fertz",
        --         --     price = 2,
        --         --     data = {}
        --         -- },
        --         {
        --             name = "parapluie",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "ciseaux",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "menottes",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "binoculars",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "gascan",
        --             price = 2,
        --             data = {},
        --             fct = GenerateApuSerial,
        --             type = "serial"
        --         },
        --         {
        --             name = "blocnote",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "makeup",
        --             price = 25,
        --             data = {}
        --         },
        --         {
        --             name = "tapas",
        --             price = 3,
        --             data = {}
        --         },
        --         {
        --             name = "cafe",
        --             price = 1,
        --             data = {}
        --         },
        --         {
        --             name = "jus",
        --             price = 3,
        --             data = {}
        --         },
        --         {
        --             name = "mentos",
        --             price = 1,
        --             data = {}
        --         },
        --         {
        --             name = "water",
        --             price = 1,
        --             data = {}
        --         },
        --         {
        --             name = "cola",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "ricemilk",
        --             price = 2,
        --             data = {}
        --         },
        --         {
        --             name = "chips",
        --             price = 5,
        --             data = {}
        --         },
        --         {
        --             name = "fishingrod",
        --             price = 25,
        --             data = {}
        --         }
        --     }
        -- },
        {
            Title = "Fournisseur LSSD",
            Hidden = true,
            RestrictedJob = {"lssd"},
            RestrictedGrade = {"deputychef", "drh", "boss"},
            Pos = {x = -435.92, y = 5999.82, z = 30.71, a = 43.10}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Sherif"
            },
            Ped = {
                model = "s_f_y_sheriff_01",
                name = "Anna"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "mm9",
                    price = 2,
                    data = {}
                },
                {
                    name = "cab2",
                    price = 2,
                    data = {}
                },
                {
                    name = "calibre12",
                    price = 2,
                    data = {}
                },
                {
                    name = "acp45",
                    price = 2,
                    data = {}
                },
                -- {
                --     name = "pistolcombat",
                --     price = 1890,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "stungun",
                --     price = 530,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                {
                    name = "flaregun",
                    price = 250,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                }
                -- {
                --     name = "nightstick",
                --     price = 50,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "teargas",
                --     price = 75,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "carrabine",
                --     price = 20000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "beanbag",
                --     price = 3400,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "shootgun",
                --     price = 4300,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "smg",
                --     price = 14000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "kevlar",
                --     price = 3000,
                --     data = {status = 25, showLabel = "Kevlar Léger", label = "Léger"},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                --   },
                --   {
                --     name = "kevlar",
                --     price = 6000,
                --     data = {status = 50, showLabel = "Kevlar Renforcé", label = "Renforcé"},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                --   },
                --   {
                --     name = "kevlar",
                --     price = 9000,
                --     data = {status = 75, showLabel = "Kevlar SWAT", label = "SWAT"},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                --   }
            }
        },
        {
            Title = "Fournisseur LSSD",
            Hidden = true,
            RestrictedJob = {"lssd"},
            RestrictedGrade = {"deputychef", "drh", "boss"},
            Pos = {x = 1860.93, y = 3693.39, z = 33.27, a = 117.82}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Sherif"
            },
            Ped = {
                model = "s_f_y_sheriff_01",
                name = "Jenny"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "mm9",
                    price = 2,
                    data = {}
                },
                {
                    name = "cab2",
                    price = 2,
                    data = {}
                },
                {
                    name = "calibre12",
                    price = 2,
                    data = {}
                },
                {
                    name = "acp45",
                    price = 2,
                    data = {}
                },
                -- {
                --     name = "pistol",
                --     price = 1200,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "pistolcombat",
                --     price = 1890,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "pistol50",
                --     price = 1560,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "stungun",
                --     price = 530,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                {
                    name = "flaregun",
                    price = 250,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                }
                -- {
                --     name = "assaultsmg",
                --     price = 15000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "nightstick",
                --     price = 50,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "teargas",
                --     price = 75,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "carrabine",
                --     price = 20000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "beanbag",
                --     price = 3400,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "shootgun",
                --     price = 4300,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "smg",
                --     price = 14000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "kevlar",
                --     price = 3000,
                --     data = {status = 25, showLabel = "Kevlar Léger", label = "Léger"},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                --   },
                --   {
                --     name = "kevlar",
                --     price = 6000,
                --     data = {status = 50, showLabel = "Kevlar Renforcé", label = "Renforcé"},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                --   },
                --   {
                --     name = "kevlar",
                --     price = 9000,
                --     data = {status = 75, showLabel = "Kevlar SWAT", label = "SWAT"},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                --   }
                -- {
                --     name = "heavysniper",
                --     price = 50000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "compactrifle",
                --     price = 25000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
            }
        },
        -- {
        --     -- PLC
        --     Title = "",
        --     Hidden = true,
        --     RestrictedJob = {"ltd"},
        --     RestrictedGrade = {"drh", "boss", "tresorier", "employe"},
        --     Pos = {x = 159.1, y = -3075.11, z = 5.01, a = 267.08},
        --     Blips = {
        --         sprite = 354,
        --         color = 66,
        --         name = "Batteries"
        --     },
        --     Ped = {
        --         model = "a_m_m_fatlatin_01",
        --         name = "Grottony"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     Items = {
        --         {
        --             name = "batterypack",
        --             price = 50,
        --             data = {}
        --         },
        --         {
        --             name = "telpack",
        --             price = 200,
        --             data = {}
        --         }
        --     }
        -- }

        -- { -- PLC
        --     Hidden = true,
        --     RestrictedJob = {"mecano2"},
        --     RestrictedGrade = {"drh","boss","tresorier","employe"},
        --     Pos = { x = 1765.27, y = 3323.49, z = 40.45, a = 328.91 },
        --     Blips = {
        --         sprite = 354,
        --         color = 66,
        --         name = "Batteries",
        --     },
        --     Ped = {
        --         model = "a_m_m_fatlatin_01",
        --         name = "Grottony"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     Items = {
        --         {
        --             name = "repairbox",
        --             price = 5,
        --             data = {},
        --         },

        --     }
        -- },
    },
    Shops
)


function Shops:CreateShops()
    for i = 1, #Shops, 1 do
        v = Shops[i]
        if not v.Hidden then
            local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(blip, v.Blips.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, v.Blips.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.Blips.name)
            EndTextCommandSetBlipName(blip)
            Blips:AddBlip(blip, "Magasin", v.Blips)
        end
        Zone:Add(v.Pos, self.EnterZone, self.ExitZone, i, 2.5)
        Ped:Add(v.Ped.name, v.Ped.model, v.Pos, nil)
        RMenu.Add("shops", i, RageUI.CreateMenu(nil, "Objets disponibles", 10, 100, v.Menus.Sprite, v.Menus.Sprite))
    end
end

local CurrentZone = nil
function Shops.Open()
    RageUI.Visible(RMenu:Get("shops", CurrentZone), not RageUI.Visible(RMenu:Get("shops", CurrentZone)))
end

function Shops.Close()
end

-- Citizen.CreateThread(function()
--     while true do
--         Wait(1)
--         local vehicle = (GetVehiclePedIsIn(LocalPlayer().Ped))
--         --print(vehicle)
--             local roll = GetEntityRoll(vehicle)
--             --print(roll)
--             if (roll > 15.0 or roll < -15.0) and GetEntitySpeed(vehicle) < 2 then
--                 DisableControlAction(2,59,true) -- Disable left/right
--                 DisableControlAction(2,60,true) -- Disable up/down
--             end

--     end

-- end)
function Shops.EnterZone(zone)
    while Ora.Player.HasLoaded == false do
        Wait(50)
    end
    local jobname = Ora.Identity.Job:GetName()
    local jobgrade = nil
    if Ora.Identity.Job:Get().grade[Ora.Identity.Job:Get().gradenum] ~= nil then
        jobgrade = Ora.Identity.Job:Get().grade[Ora.Identity.Job:Get().gradenum].name
    end
    local orgagrade = nil
    local organame = ""
    if (Ora.Identity.Orga:Get().label ~= "👤 Citoyen") then
        organame = Ora.Identity.Orga:GetName()
        if Ora.Identity.Orga:Get().grade[Ora.Identity.Orga:Get().gradenum] ~= nil then
            orgagrade = Ora.Identity.Orga:Get().grade[Ora.Identity.Orga:Get().gradenum].name
        end
    end
    local found1 = false
    if Shops[zone].RestrictedJob == nil then
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
        KeySettings:Add("keyboard", "E", Shops.Open, "Shop")
        KeySettings:Add("controller", 46, Shops.Open, "Shop")
        CurrentZone = zone
    else
        for i = 1, #Shops[zone].RestrictedJob, 1 do
            if Shops[zone].RestrictedJob[i] == jobname or Shops[zone].RestrictedJob[i] == organame then
                found1 = true
                break
            end
        end

        if found1 then
            local found2 = false
            for i = 1, #Shops[zone].RestrictedGrade, 1 do
                if Shops[zone].RestrictedGrade[i] == jobgrade or Shops[zone].RestrictedGrade[i] == orgagrade then
                    found2 = true
                    break
                end
            end
            if found2 then
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
                KeySettings:Add("keyboard", "E", Shops.Open, "Shop")
                KeySettings:Add("controller", 46, Shops.Open, "Shop")
                CurrentZone = zone
            end
        end
    end
end

function Shops.ExitZone(zone)
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        if RageUI.Visible(RMenu:Get("shops", CurrentZone)) then
            RageUI.Visible(RMenu:Get("shops", CurrentZone), not RageUI.Visible(RMenu:Get("shops", CurrentZone)))
        end
        KeySettings:Clear("keyboard", "E", "Shop")
        KeySettings:Clear("controller", 46, "Shop")
        Shops.Close()
        CurrentZone = nil
    end
end

Shops:CreateShops()
local currentHeader = true
dataonWait = {}
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if CurrentZone ~= nil then
                if RageUI.Visible(RMenu:Get("shops", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = Shops[CurrentZone].Menus.Enabled, glare = false},
                        function()
                            for i = 1, #Shops[CurrentZone].Items, 1 do

                                local productName = Items[Shops[CurrentZone].Items[i].name].label
                                if (Shops[CurrentZone].Items[i].data ~= nil and Shops[CurrentZone].Items[i].data.showLabel ~= nil) then
                                    productName = Shops[CurrentZone].Items[i].data.showLabel
                                end

                                RageUI.Button(
                                    productName,
                                    nil,
                                    {RightLabel = Shops[CurrentZone].Items[i].price .. "$"},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            local m = nil
                                            if Shops[CurrentZone].Items[i].fct ~= nil then
                                                m = Shops[CurrentZone].Items[i].fct()
                                                if Shops[CurrentZone].Items[i].type == "serial" then
                                                    Shops[CurrentZone].Items[i].data.serial = m
                                                elseif Shops[CurrentZone].Items[i].type == "number" then
                                                    Shops[CurrentZone].Items[i].data.num = m
                                                else
                                                    --("ods")
                                                    Shops[CurrentZone].Items[i].data[Shops[CurrentZone].Items[i].type] =
                                                        m
                                                end
                                            end

                                            local count = 1
                                            if
                                                (Shops[CurrentZone].Items[i].noCount ~= nil and
                                                    Shops[CurrentZone].Items[i].noCount == true)
                                            then
                                                count = 1
                                            else
                                                exports['Snoupinput']:ShowInput("Combien ?", 1000, "number", "1", true)
                                                count = exports['Snoupinput']:GetInput()
                                            end
                                            if (count == nil or count == false) then return end
                                            count = tonumber(count)

                                            if (Shops[CurrentZone].Items[i].beforePayment ~= nil) then
                                                local beforePayementResult = Shops[CurrentZone].Items[i].beforePayment()
                                                if beforePayementResult == false then
                                                    return
                                                end
                                            end

                                            if (
                                                count ~= nil and
                                                count > 0 and
                                                (
                                                    Ora.Inventory:CanReceive(Shops[CurrentZone].Items[i].name, count) or
                                                    (Shops[CurrentZone].Items[i].noItem ~= nil and Shops[CurrentZone].Items[i].noItem == true)
                                                )
                                            ) then
                                                RageUI.GoBack()
                                                local noItemDelivery =
                                                    Shops[CurrentZone].Items[i].noItem ~= nil and
                                                    Shops[CurrentZone].Items[i].noItem == true
                                                local afterPaymentFct = nil
                                                local tax = nil

                                                if (Shops[CurrentZone].Items[i].afterPayment ~= nil) then
                                                    afterPaymentFct = Shops[CurrentZone].Items[i].afterPayment
                                                end
                                                if (Shops[CurrentZone].Items[i].tax ~= nil) then
                                                    tax = Shops[CurrentZone].Items[i].tax
                                                end

                                                ShowNotification(
                                                    "~g~Prix : " .. Shops[CurrentZone].Items[i].price * count .. "$"
                                                )
                                                items = {
                                                    name = Shops[CurrentZone].Items[i].name,
                                                    data = Shops[CurrentZone].Items[i].data,
                                                    noItem = noItemDelivery,
                                                    afterPayment = afterPaymentFct
                                                }

                                                if (Shops[CurrentZone].isCasino) then
                                                    TriggerServerCallback(
                                                        "Ora::SE::Job::Casino::CanBuy",
                                                        function(bool)
                                                            if (bool) then
                                                                dataonWait = {
                                                                    item = items,
                                                                    price = Shops[CurrentZone].Items[i].price * count,
                                                                    count = count,
                                                                    tax = tax,
                                                                    title = Shops[CurrentZone].Title,
                                                                    fct = function()
                                                                        TriggerServerEvent("entreprise:Add", "casino", Shops[CurrentZone].Items[i].price * count)
                                                                    end
                                                                }

                                                                if Shops[CurrentZone].Items[i].name == "casinopiece" then
                                                                    exports['Snoupinput']:ShowInput("Type de paiement (propre) | $" .. (Shops[CurrentZone].Items[i].price * count) .. " ou $" .. math.floor(Ora.Illegal.FakeMoneyTax * (Shops[CurrentZone].Items[i].price * count)) .. " en argent sale", 30, "text", "propre", true)
                                                                    local type = exports['Snoupinput']:GetInput()
                
                                                                    if (type and type == "propre") then
                                                                        TriggerEvent("payWith?")
                                                                    elseif (type ~= false) then
                                                                        RageUI.Popup({message = '~r~Vous devez simplement mettre "propre" sans les guillemets'})
                                                                    end
                                                                else
                                                                    TriggerEvent("payWith?")
                                                                end
                                                            else
                                                                RageUI.Popup({message = "Je vais laisser un autre collègue en service s'occuper de vous."})
                                                            end
                                                        end
                                                    )
                                                else
                                                    dataonWait = {
                                                        item = items,
                                                        price = Shops[CurrentZone].Items[i].price * count,
                                                        count = count,
                                                        tax = tax,
                                                        title = Shops[CurrentZone].Title,
                                                        fct = function()
                                                            if Shops[CurrentZone].RestrictedJob and Shops[CurrentZone].RestrictedJob[1] == "ammunation" then
                                                                TriggerServerEvent("business:SetProductivity", GetPlayerServerId(source), "ammunation", Shops[CurrentZone].Items[i].price * count, false)
                                                            end
                                                            
                                                            if (Shops[CurrentZone].isCasino) then
                                                                TriggerServerEvent("entreprise:Add", "casino", Shops[CurrentZone].Items[i].price * count)
                                                            end
                                                        end
                                                    }

                                                    if Shops[CurrentZone].Items[i].name == "casinopiece" then
                                                        exports['Snoupinput']:ShowInput("Type de paiement (propre) | $" .. (Shops[CurrentZone].Items[i].price * count) .. " ou $" .. math.floor(Ora.Illegal.FakeMoneyTax * (Shops[CurrentZone].Items[i].price * count)) .. " en argent sale", 30, "text", "propre", true)
                                                        local type = exports['Snoupinput']:GetInput()
    
                                                        if (type and type == "propre") then
                                                            TriggerEvent("payWith?")
                                                        elseif (type ~= false) then
                                                            RageUI.Popup({message = '~r~Vous devez simplement mettre "propre" sans les guillemets'})
                                                        end
                                                    else
                                                        TriggerEvent("payWith?")
                                                    end
                                                end
                                            --items = {name=Shops[CurrentZone].Items[i].name,data=Shops[CurrentZone].Items[i].data}
                                            -- AddItemtoInv(items)
                                            -- TriggerServerEvent("money:Pay", Shops[CurrentZone].Items[i].price )
                                            end
                                        end
                                    end
                                )
                            end
                            if #Shops[CurrentZone].Items == 0 then
                                RageUI.Button(
                                    "Vide",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                    end
                                )
                            end
                            if Shops[CurrentZone].braquable ~= false then
                                RageUI.Button(
                                    "~r~Braquer",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            if Shops[CurrentZone].bzone ~= "all" then
                                                TriggerServerCallback("Ora::SE::Service:GetInServiceCount", 
                                                    function(nb)
                                                        if nb >= Ora.Illegal:GetCopsRequired("roberry") then
                                                            TriggerServerCallback(
                                                                "braquage:canHoldup",
                                                                function(bool)
                                                                    if (bool == true) then
                                                                        TriggerServerCallback(
                                                                            "braquage:Get",
                                                                            function(bool)
                                                                                if bool then
                                                                                    RageUI.GoBack()
                                                                                    if not IsPedArmed(LocalPlayer().Ped, 7) then
                                                                                        return ShowNotification("~o~Même pas peur")
                                                                                    end
                                                                                    TriggerServerEvent("braquage:addHoldup")
                                                                                    StartBraquo(Shops[CurrentZone].bzone)
                                                                                    TriggerServerEvent("braquage:Add", CurrentZone)
                                                                                else
                                                                                    ShowNotification("Les caisses sont ~r~vides")
                                                                                end
                                                                            end,
                                                                            CurrentZone
                                                                        )
                                                                    else
                                                                        ShowNotification("~r~Vous avez déjà réalisé trop de superettes~s~")
                                                                    end
                                                                end
                                                            )
                                                        else
                                                            ShowNotification(
                                                                "Les caisses sont ~r~vides\n~y~Repassez plus tard"
                                                            )
                                                        end
                                                    end,
                                                    Shops[CurrentZone].bzone
                                                )
                                            else
                                                TriggerServerCallback(
                                                    "Ora::SE::Service:GetTotalServiceCountForJobs",
                                                    function(allcount)
                                                        if allcount >= Ora.Illegal:GetCopsRequired("roberry") then
                                                            TriggerServerCallback(
                                                                "braquage:Get",
                                                                function(bool)
                                                                    if bool then
                                                                        RageUI.GoBack()
                                                                        if not IsPedArmed(LocalPlayer().Ped, 7) then
                                                                            return ShowNotification(
                                                                                "~o~Même pas peur"
                                                                            )
                                                                        end
                                                                        StartBraquo(Shops[CurrentZone].bzone)
                                                                        TriggerServerEvent(
                                                                            "braquage:Add",
                                                                            CurrentZone
                                                                        )
                                                                    else
                                                                        ShowNotification(
                                                                            "Les caisses sont ~r~vides"
                                                                        )
                                                                    end
                                                                end,
                                                                CurrentZone
                                                            )
                                                        else
                                                            ShowNotification(
                                                                "Les caisses sont ~r~vides\n~y~Repassez plus tard"
                                                            )
                                                        end
                                                    end,
                                                    {"police", "lssd"}
                                                )
                                            end
                                        end
                                    end
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
local filter = {"dollar1", "dollar5", "dollar10", "dollar50", "dollar100", "dollar500"}
local am = {1, 5, 10, 50, 100, 500}
local m = {
    dollar1 = {
        index = 1,
        label = {0}
    },
    dollar5 = {
        index = 1,
        label = {0}
    },
    dollar10 = {
        index = 1,
        label = {0}
    },
    dollar50 = {
        index = 1,
        label = {0}
    },
    dollar100 = {
        index = 1,
        label = {0}
    },
    dollar500 = {
        index = 1,
        label = {0}
    }
}

local function GetCurrentMoneySelected()
    local mo = 0
    for k, v in pairs(m) do
        if v.visible then
            local p = string.gsub(tostring(k), "dollar", "")
            p = tonumber(p)
            mo = mo + (p * (v.index - 1))
        end
    end

    return mo
end

local function Refresh()
    for k, v in pairs(m) do
        if Ora.Inventory.Data[k] ~= nil then
            v.visible = true
            v.total = #Ora.Inventory.Data[k]
            v.label = {0}
            for i = 0, #Ora.Inventory.Data[k], 1 do
                v.label[i + 1] = i
            end
            v.index = 1
        else
            v.total = 0
            v.visible = false
        end
    end
end

AddEventHandler(
    "payByCard",
    function()
        if Ora.Inventory:GetItemCount("bank_card") < 1 then
            if dataonWait.no ~= nil then
                dataonWait.no()
            end
            dataonWait = {}
            return ShowNotification("~r~Vous n'avez pas de cartes bancaires")
        else
            RageUI.Visible(RMenu:Get("personnal", "choose_card"), true)
        end
    end
)

AddEventHandler(
    "payByCash",
    function()
        --[[ if dataonWait.price > 10000 and (dataonWait.isLimited == nil or dataonWait.isLimited == true) then
            if dataonWait.no ~= nil then
                dataonWait.no()
            end
            dataonWait = {}
            return ShowNotification("~r~Vous ne pouvez pas payer plus de 10 000$ en liquide")
        else ]]if Ora.Payment:GetTotalCash() < dataonWait.price then
            if dataonWait.no ~= nil then
                dataonWait.no()
            end
            dataonWait = {}
            return ShowNotification("~r~Vous n'avez pas assez d'argent")
        else
            Refresh()

            RageUI.Visible(RMenu:Get("personnal", "choose_money"), true)
        end
    end
)

-- AddEventHandler(
--     "payByFakeCash",
--     function()
--         if (Ora.Payment.Fake:GetTotalFakeCash() < dataonWait.price) then
--             dataonWait = {}
--             return ShowNotification("~r~Vous n'avez pas assez d'argent sale")
--         else
--             RefreshFake()
--             RageUI.Visible(RMenu:Get("personnal", "choose_fake_money"), true)
--         end
--     end
-- )

RMenu.Add("personnal", "choose_card", RageUI.CreateMenu("Ora", "Cartes bancaire disponibles", 10, 200))
RMenu.Add("personnal", "choose_money", RageUI.CreateMenu("Ora", "Billets disponibles", 10, 200))
-- RMenu.Add("personnal", "choose_fake_money", RageUI.CreateMenu("Ora", "Faux billets disponibles", 10, 200))
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("personnal", "choose_money")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        for k, v in pairs(m) do
                            if v.total > 0 then
                                RageUI.List(
                                    Items[k].label .. " (" .. v.total .. "x)",
                                    v.label,
                                    v.index,
                                    nil,
                                    {},
                                    v.visible,
                                    function(_, Active, Selected, Index)
                                        v.index = Index
                                        if Selected then
                                            exports['Snoupinput']:ShowInput("Combien ? (MAX " .. v.total .. ")", 10, "number", nil, true)
                                            local ask = exports['Snoupinput']:GetInput()

                                            if (ask ~= false and ask ~= nil) then
                                                ask = tonumber(ask)
                                                if (ask <= v.total) then
                                                    v.index = ask + 1
                                                else
                                                    ShowNotification("~r~Il faut indiquer un chiffre")
                                                end
                                            end
                                        end
                                    end
                                )
                            else
                                v.index = 1
                            end
                        end

                        RageUI.Button(
                            "Payer ",
                            nil,
                            {
                                RightLabel = "~g~(" ..
                                    dataonWait.price ..
                                        "$)~s~-" ..
                                            GetCurrentMoneySelected() ..
                                                "$ = " ..
                                                    math.floor(dataonWait.price - GetCurrentMoneySelected()) .. "$"
                            },
                            true,
                            function(_, H, S)
                                if S then
                                    local mT = math.floor(dataonWait.price - GetCurrentMoneySelected())
                                    if (mT <= 0) and ((GetCurrentMoneySelected() <= (0.5 * dataonWait.price + dataonWait.price)) or GetCurrentMoneySelected() <= 500) then
                                        RageUI.GoBack()
                                        ShowNotification("~b~Paiement effectué")
                                        local t = {}
                                        for k, v in pairs(m) do
                                            if #v.label > 1 then
                                                t[k] = v
                                            end
                                            --v.index = 1
                                        end
                                        TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", GetCurrentMoneySelected(), true)
                                        Ora.Payment:PayMoney(t)

                                        if m ~= 0 then
                                            ShowNotification("~y~Le vendeur vous rend " .. -mT .. "$")
                                            TriggerServerCallback(
                                                "Ora::SE::Money:AuthorizePayment", 
                                                function(token)
                                                    TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = -mT, SOURCE = "Rendu monnaie", LEGIT = true})
                                                    TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", -mT, false)
                                                end,
                                                {}
                                            )
                                        end
                                        if
                                            dataonWait.count ~= nil and dataonWait.item ~= nil and
                                                dataonWait.item.noItem ~= true
                                         then
                                            local localItems = {}
                                            for i = 1, dataonWait.count, 1 do
                                                local currentLabel = nil
                                                if (dataonWait.item.data ~= nil and dataonWait.item.data.label ~= nil) then
                                                    currentLabel = dataonWait.item.data.label
                                                end
                                                table.insert(
                                                    localItems,
                                                    {
                                                        id = nil,
                                                        name = dataonWait.item.name,
                                                        label = currentLabel,
                                                        data = dataonWait.item.data
                                                    }
                                                )
                                            end
                                            Ora.Inventory:AddItems(localItems)
                                        end
                                        if dataonWait.fct ~= nil then
                                            dataonWait.fct("money")
                                        end

                                        if dataonWait.tax ~= nil then
                                            sendTax(dataonWait.price * dataonWait.tax)
                                        end

                                        if dataonWait.item ~= nil and dataonWait.item.afterPayment ~= nil then
                                            dataonWait.item.afterPayment(dataonWait.item)
                                        end
                                    elseif dataonWait.price < 500 and GetCurrentMoneySelected() == 500 then
                                        RageUI.GoBack()
                                        ShowNotification("~b~Paiement effectué")
                                        local t = {}
                                        for k, v in pairs(m) do
                                            if #v.label > 1 then
                                                t[k] = v
                                            end
                                            --v.index = 1
                                        end
                                        TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", GetCurrentMoneySelected(), true)
                                        Ora.Payment:PayMoney(t)

                                        if m ~= 0 then
                                            ShowNotification("~y~Le vendeur vous rend " .. -mT .. "$")
                                            TriggerServerCallback(
                                                "Ora::SE::Money:AuthorizePayment", 
                                                function(token)
                                                    TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = -mT, SOURCE = "Rendu monnaie", LEGIT = true})
                                                    TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", -mT, false)
                                                end,
                                                {}
                                            )
                                        end
                                        if
                                            dataonWait.count ~= nil and dataonWait.item ~= nil and
                                                dataonWait.item.noItem ~= true
                                         then
                                            local localItems = {}
                                            for i = 1, dataonWait.count, 1 do
                                                local currentLabel = nil
                                                if (dataonWait.item.data ~= nil and dataonWait.item.data.label ~= nil) then
                                                    currentLabel = dataonWait.item.data.label
                                                end
                                                table.insert(
                                                    localItems,
                                                    {
                                                        id = nil,
                                                        name = dataonWait.item.name,
                                                        label = currentLabel,
                                                        data = dataonWait.item.data
                                                    }
                                                )
                                            end
                                            Ora.Inventory:AddItems(localItems)
                                        end
                                        if dataonWait.fct ~= nil then
                                            dataonWait.fct("money")
                                        end

                                        if dataonWait.tax ~= nil then
                                            sendTax(dataonWait.price * dataonWait.tax)
                                        end

                                        if dataonWait.item ~= nil and dataonWait.item.afterPayment ~= nil then
                                            dataonWait.item.afterPayment(dataonWait.item)
                                        end
                                    elseif GetCurrentMoneySelected() > (0.5 * dataonWait.price + dataonWait.price) then
                                        ShowNotification("~r~T'es un malade ou quoi ? Tu crois que je suis là pour te faire des petites coupures ?!")
                                        if dataonWait.no ~= nil then
                                            dataonWait.no()
                                        end
                                    else
                                        ShowNotification("~r~Vous n'avez pas donné assez d'argent")
                                        if dataonWait.no ~= nil then
                                            dataonWait.no()
                                        end
                                    end
                                end
                            end
                        )
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("personnal", "choose_card")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        for i = 1, #Ora.Inventory.Data["bank_card"], 1 do
                            RageUI.Button(
                                Items["bank_card"].label .. " #" .. Ora.Inventory.Data["bank_card"][i].data.number,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local param = Ora.Inventory.Data["bank_card"][i].data
                                        local code = KeyboardInput("Veuillez entrer le code", nil, 4)
                                        code = tonumber(code)
                                        if code ~= nil then
                                            if code == param.code then
                                                TriggerServerCallback(
                                                    "getBankingAccountsPly2",
                                                    function(result)
                                                        local acc = result[1]
                                                        if acc.amount >= dataonWait.price then
                                                            ShowNotification("Paiement ~g~effectué")
                                                            local x, y, z = LocalPlayer().Pos
                                                            local current_zone = GetLabelText(GetNameOfZone(x, y, z))
                                                            local price = {
                                                                math.floor(
                                                                    (dataonWait.price - (dataonWait.price / 100)) *
                                                                        (100 - ConfigTax),
                                                                    0
                                                                ),
                                                                math.floor(
                                                                    (dataonWait.price - (dataonWait.price / 100)) *
                                                                        ConfigTax,
                                                                    0
                                                                )
                                                            }

                                                            TriggerServerEvent(
                                                                "bankingRemoveFromAccount2",
                                                                acc.iban,
                                                                dataonWait.price
                                                            )

                                                            local accountLabel = getCompanyLabel(dataonWait.account) or dataonWait.account or dataonWait.title or "Service Ville"
                                                            local transactionTitle = dataonWait.title or "Facture : "..current_zone
                                                            TriggerServerEvent(
                                                                "newTransaction",
                                                                acc.iban,
                                                                accountLabel,
                                                                dataonWait.price,
                                                                transactionTitle,
                                                                "CB N°"..param.number
                                                            )
                                                            if dataonWait.item ~= nil and dataonWait.item.noItem ~= true then
                                                                if type(dataonWait.count) == "number" then
                                                                    local localItems = {}
                                                                    for i = 1, dataonWait.count, 1 do
                                                                        table.insert(
                                                                            localItems,
                                                                            {
                                                                                id = nil,
                                                                                name = dataonWait.item.name,
                                                                                label = nil,
                                                                                data = dataonWait.item.data
                                                                            }
                                                                        )
                                                                    end
                                                                    Ora.Inventory:AddItems(localItems)
                                                                end
                                                            end

                                                            if dataonWait.fct ~= nil then
                                                                dataonWait.fct("bank")
                                                            end

                                                            if
                                                                dataonWait.item ~= nil and
                                                                    dataonWait.item.afterPayment ~= nil
                                                             then
                                                                dataonWait.item.afterPayment(dataonWait.item)
                                                            end
                                                            if dataonWait.tax ~= nil then
                                                                sendTax(dataonWait.price * dataonWait.tax)
                                                            end
                                                            --TriggerServerEvent("gcPhone:_internalAddMessage","Banque",ATM.Selected.phone_number,"Nouvel achat " .. amount .."$ vers " .. rib1 .. " à partir du compte " .. ATM.Selected.iban,false)
                                                            RageUI.GoBack()
                                                        else
                                                            ShowNotification("Paiement ~g~refusé !")
                                                        end
                                                    end,
                                                    param.account
                                                )
                                            else
                                                ShowNotification("~r~Code incorrect")
                                                RageUI.GoBack()
                                                if dataonWait.no ~= nil then
                                                    dataonWait.no()
                                                end
                                                dataonWait = {}
                                            end
                                        end
                                    end
                                end
                            )
                        end
                    end
                )
            end
        end
    end
)
