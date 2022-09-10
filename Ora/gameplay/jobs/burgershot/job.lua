burgerCrafts = {}
burgerCrafts["recettes"] = {
    tacos2 = {
        title = "Chicken Mexican",
        label = "Chicken Mexican",
        item = "tacos2",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "cereale", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chicken", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["tacos2"]
            craftRecettes(data)
        end
    },
    tender = {
        title = "Crazy Tenders",
        label = "Crazy Tenders",
        item = "tender",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "chicken", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chips", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["tender"]
            craftRecettes(data)
        end
    },
    burger1 = {
        title = "Double Shot",
        label = "Double Shot",
        item = "burger1",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "meat", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "bread", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["burger1"]
            craftRecettes(data)
        end
    },
    wraps1 = {
        title = "Goat Cheese",
        label = "Goat Cheese",
        item = "wraps1",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "cereale", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "meat", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["wraps1"]
            craftRecettes(data)
        end
    },
    burger2 = {
        title = "The Prickly",
        label = "The Prickly",
        item = "burger2",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "bread", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chicken", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["burger2"]
            craftRecettes(data)
        end
    },
    burger3 = {
        title = "Stopper 6lb burguer",
        label = "Stopper 6lb burguer",
        item = "burger3",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "bread", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "meat", count = 1},
            {name = "cheddar", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["burger3"]
            craftRecettes(data)
        end
    },
    sunday1 = {
        title = "Sunday chocolat",
        label = "Sunday chocolat",
        item = "sunday1",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "milk", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chocolat", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["sunday1"]
            craftRecettes(data)
        end
    },
    sunday2 = {
        title = "Sunday fraise",
        label = "Sunday fraise",
        item = "sunday2",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "milk", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "fraise", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["sunday2"]
            craftRecettes(data)
        end
    },
    burger4 = {
        title = "The Bleeder",
        label = "The Bleeder",
        item = "burger4",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "meat", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "cheddar", count = 1},
            {name = "bread", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["burger4"]
            craftRecettes(data)
        end
    },
    burger5 = {
        title = "The Glorious",
        label = "The Glorious",
        item = "burger5",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "meat", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "bread", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["burger5"]
            craftRecettes(data)
        end
    },
    burger6 = {
        title = "The Simply",
        label = "The Simply",
        item = "burger6",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "chicken", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "bread", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["burger6"]
            craftRecettes(data)
        end
    },
    wraps2 = {
        title = "Wraps Poulet",
        label = "Wraps Poulet",
        item = "wraps2",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "cereale", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chicken", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["wraps2"]
            craftRecettes(data)
        end
    },
    frites = {
        title = "Frites",
        label = "Frites",
        item = "frites",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "pommeterre", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["frites"]
            craftRecettes(data)
        end
    },
    milkshack = {
        title = "MilkShake",
        label = "MilkShake",
        item = "milkshack",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "milk", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = burgerCrafts["recettes"]["milkshack"]
            craftRecettes(data)
        end
    }
}

Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("burgerCrafts", "main", RageUI.CreateMenu("BurgerShot", "Catégories disponibles", 10, 100))
        -- creata acc
        RMenu.Add(
            "burgerCrafts",
            "create_burger",
            RageUI.CreateSubMenu(RMenu:Get("burgerCrafts", "main"), "BurgerShot", "Craft", 10, 100)
        )
    end
)

function EntercraftBurgerZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
    KeySettings:Add("keyboard", "E", OpenburgerMenu, "ALCOOL")
    KeySettings:Add("controller", 46, OpenburgerMenu, "ALCOOL")
end

function ExitcraftburgerZone()
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

function OpenburgerMenu()
    RageUI.Visible(RMenu:Get("burgerCrafts", "main"), true)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("burgerCrafts", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Cuisiner",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("burgerCrafts", "create_burger")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("burgerCrafts", "create_burger")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(burgerCrafts["recettes"]) do
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

function craftRecettes(data)
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

        for i = 1, #data.required, 1 do
            Ora.Inventory:RemoveFirstItem(data.required[i].name)
        end

        exports["mythic_progbar"]:Progress(
            {
                name = data.item,
                duration = data.time,
                label = "Création du plat en cours...",
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

       Ora.Inventory:AddItem({name = data.item, data = {}})  
    else
        ShowNotification("~r~Action impossible car certains ingrédients manquent~s~")
        return
    end
end
