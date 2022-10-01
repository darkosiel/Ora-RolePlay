KoiCraft = {}
KoiCraft["recettes"] = {
    beignetcrevette = {
        title = "Beignet de crevette",
        label = "Beignet de crevette",
        item = "beignetcrevette",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "feuillenori", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "fish15", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["beignetcrevette"]
            craftRecettes(data)
        end
    },
    rouleauprintemps = {
        title = "Rouleau de printemps",
        label = "Rouleau de printemps",
        item = "rouleauprintemps",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "feuillenori", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "salade", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["rouleauprintemps"]
            craftRecettes(data)
        end
    },
    canardlaque = {
        title = "Canard laque",
        label = "Canard laque",
        item = "canardlaque",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "duck", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "caramel", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["canardlaque"]
            craftRecettes(data)
        end
    },
    maki = {
        title = "Maki radis concombre",
        label = "Maki radis concombre",
        item = "maki",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "concombre", count = 1},
            {name = "radish", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "feuillenori", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["maki"]
            craftRecettes(data)
        end
    },
    soupechinoise = {
        title = "Soupe chinoise",
        label = "Soupe chinoise",
        item = "soupechinoise",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "bouillon", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["soupechinoise"]
            craftRecettes(data)
        end
    },
    Pouletimperial = {
        title = "Poulet impérial",
        label = "Poulet impérial",
        item = "Pouletimperial",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "chicken", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "caramel", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["Pouletimperial"]
            craftRecettes(data)
        end
    },
    Nouillessautees = {
        title = "Nouilles sautées",
        label = "Nouilles sautées",
        item = "Nouillessautees",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "noddle", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "salade", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["Nouillessautees"]
            craftRecettes(data)
        end
    },
    Beignetsesame = {
        title = "Beignet de sésame",
        label = "Beignet de sésame",
        item = "Beignetsesame",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "farine", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "cereale", count = 1},
            {name = "sesame", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["Beignetsesame"]
            craftRecettes(data)
        end
    },
    perlecoco = {
        title = "Perle de coco",
        label = "Perle de coco",
        item = "perlecoco",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "oeuf", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "coco", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["perlecoco"]
            craftRecettes(data)
        end
    },
    fortunecookie = {
        title = "Fortune cookie",
        label = "Fortune cookie",
        item = "fortunecookie",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "farine", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chocolat", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["fortunecookie"]
            craftRecettes(data)
        end
    },
    nem = {
        title = "Nem Poulet",
        label = "Nem Poulet",
        item = "nem",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "chicken", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "feuillenori", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = KoiCraft["recettes"]["nem"]
            craftRecettes(data)
        end
    }
}

Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("KoiCraft", "main", RageUI.CreateMenu("BurgerShot", "Catégories disponibles", 10, 100))
        -- creata acc
        RMenu.Add(
            "KoiCraft",
            "create_koi",
            RageUI.CreateSubMenu(RMenu:Get("KoiCraft", "main"), "BurgerShot", "Craft", 10, 100)
        )
    end
)

function EntercraftKoiZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
    KeySettings:Add("keyboard", "E", OpenKoiMenu, "ALCOOL")
    KeySettings:Add("controller", 46, OpenKoiMenu, "ALCOOL")
end

function ExitcraftkoiZone()
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

function OpenKoiMenu()
    RageUI.Visible(RMenu:Get("KoiCraft", "main"), true)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("KoiCraft", "main")) then
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
                            RMenu:Get("KoiCraft", "create_koi")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("KoiCraft", "create_koi")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(KoiCraft["recettes"]) do
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
