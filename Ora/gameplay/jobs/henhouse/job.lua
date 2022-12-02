local function craftRecettes(data)
    local hasOneMissing = false

    for i = 1, #data.required, 1 do
        if Ora.Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
            ShowNotification(
                "~b~[" ..
                    data.title ..
                        "]\n" ..
                            Items[data.required[i].name].label ..
                                "~s~ : ~r~" ..
                                    Ora.Inventory:GetItemCount(data.required[i].name) ..
                                        "/" .. data.required[i].count .. "~s~"
            )
            hasOneMissing = true
        else
            ShowNotification(
                "~b~[" ..
                    data.title ..
                        "]\n" ..
                            Items[data.required[i].name].label ..
                                "~s~ : ~g~" ..
                                    Ora.Inventory:GetItemCount(data.required[i].name) ..
                                        "/" .. data.required[i].count .. "~s~"
            )
        end
    end

    if not hasOneMissing then
        SetFarmLimit(1)
        local timeWait = (data.time / 1000) / 60

        -- for i = 1, #data.required, 1 do
        --     Ora.Inventory:RemoveFirstItem(data.required[i].name)
        -- end
        for i = 1, #data.required, 1 do
            for i2 = 1, data.required[i].count, 1 do
                Ora.Inventory:RemoveFirstItem(data.required[i].name)
            end
        end

        exports["mythic_progbar"]:Progress(
            {
                name = data.item,
                duration = data.time,
                label = "Création d'un cocktail en cours...",
                useWhileDead = true,
                canCancel = false,
                controlDisables = {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = false
                },
            },
            function(cancelled)
            end
        )

        for i = 1, (data.addQuantity == nil and 1 or data.addQuantity), 1 do
            Ora.Inventory:AddItem({name = data.item, data = {}})  
        end  
    else
        ShowNotification("~r~Action impossible car certains ingrédients manquent~s~")
        return
    end
end

henhouseCrafts = {}
-- Pistols
henhouseCrafts["recettes"] = {
    kirroyal = {
        title = "Kir Royal",
        label = "Kir Royal",
        item = "kirroyal",
        addQuantity = 5,
        time = 1000, -- temps de craft je pense
        required = {
            {name = "sirup", count = 5}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "champagne", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = henhouseCrafts["recettes"]["kirroyal"]
            craftRecettes(data)
        end
    },
    monacodrink = {
        title = "Monaco",
        label = "Monaco",
        item = "monacodrink",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "sirup", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "beer", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = henhouseCrafts["recettes"]["monacodrink"]
            craftRecettes(data)
        end
    },
    grenadine = {
        title = "Grenadine",
        label = "Grenadine",
        item = "grenadine",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "sirup", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "water", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = henhouseCrafts["recettes"]["grenadine"]
            craftRecettes(data)
        end
    },
    mojito = {
        title = "Mojito",
        label = "Mojito",
        item = "mojito",
        addQuantity = 5,
        time = 1000, -- temps de craft je pense
        required = {
            {name = "mint", count = 5}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "water", count = 5},
            {name = "rhum", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = henhouseCrafts["recettes"]["mojito"]
            craftRecettes(data)
        end
    },
    pinacolada = {
        title = "Piña Colada",
        label = "Piña Colada",
        item = "pinacolada",
        addQuantity = 5,
        time = 1000, -- temps de craft je pense
        required = {
            {name = "pineapplejuice", count = 5}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "latecoco", count = 5},
            {name = "rhum", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = henhouseCrafts["recettes"]["pinacolada"]
            craftRecettes(data)
        end
    },
    tipunch = {
        title = "Ti-punch",
        label = "Ti-punch",
        item = "tipunch",
        addQuantity = 5,
        time = 1000, -- temps de craft je pense
        required = {
            {name = "sirup", count = 5}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "lemon", count = 5},
            {name = "rhum", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = henhouseCrafts["recettes"]["tipunch"]
            craftRecettes(data)
        end
    },
    orangevodka = {
        title = "Vodka orange",
        label = "Vodka orange",
        item = "orangevodka",
        addQuantity = 5,
        time = 1000, -- temps de craft je pense
        required = {
            {name = "orangejuice", count = 5}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "vodka", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = henhouseCrafts["recettes"]["orangevodka"]
            craftRecettes(data)
        end
    },
    tequilapaf = {
        title = "Tequila paf",
        label = "Tequila paf",
        item = "tequilapaf",
        addQuantity = 5,
        time = 1000, -- temps de craft je pense
        required = {
            {name = "lemon", count = 5}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "tequila", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = henhouseCrafts["recettes"]["tequilapaf"]
            craftRecettes(data)
        end
    },
    tequilasunrise = {
        title = "Tequila sunrise",
        label = "Tequila sunrise",
        item = "tequilasunrise",
        addQuantity = 5,
        time = 1000, -- temps de craft je pense
        required = {
            {name = "orangejuice", count = 5}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "tequila", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = henhouseCrafts["recettes"]["tequilasunrise"]
            craftRecettes(data)
        end
    },
    whiskycoke = {
        title = "Whisky Coca",
        label = "Whisky Coca",
        item = "whiskycoke",
        addQuantity = 5,
        time = 1000, -- temps de craft je pense
        required = {
            {name = "cola", count = 5}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "whisky", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = henhouseCrafts["recettes"]["whiskycoke"]
            craftRecettes(data)
        end
    },
}

Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("henhouseCrafts", "main", RageUI.CreateMenu("Hen House", "Catégories disponibles", 10, 100))
        -- creata acc
        RMenu.Add(
            "henhouseCrafts",
            "create_henhouse",
            RageUI.CreateSubMenu(RMenu:Get("henhouseCrafts", "main"), "Hen House", "Craft", 10, 100)
        )
    end
)

function EntercrafthenhouseZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour faire des cocktails")
    KeySettings:Add("keyboard", "E", OpenhenhouseMenu, "ALCOOL")
    KeySettings:Add("controller", 46, OpenhenhouseMenu, "ALCOOL")
end

function ExitcrafthenhouseZone()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard", "E", "ALCOOL")
    KeySettings:Clear("controller", "E", "ALCOOL")
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
end

function OpenhenhouseMenu()
    RageUI.Visible(RMenu:Get("henhouseCrafts", "main"), true)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("henhouseCrafts", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Faire des cocktails",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("henhouseCrafts", "create_henhouse")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("henhouseCrafts", "create_henhouse")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(henhouseCrafts["recettes"]) do
                            RageUI.Button(
                                v.title,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        if (type(v.selected) == "function") then
                                            v.selected()
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
)


