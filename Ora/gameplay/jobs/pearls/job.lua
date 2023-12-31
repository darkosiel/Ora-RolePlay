pearlsCrafts = {}
-- Pistols
pearlsCrafts["recettes"] = {
    terrinepoisson = {
        title = "Terrine de poisson",
        label = "Terrine de poisson",
        item = "terrinepoisson",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "fish12", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "fish6", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = pearlsCrafts["recettes"]["terrinepoisson"]
            craftRecettes(data)
        end
    },

    tartaresaumon = {
        title = "Tartare de saumon",
        label = "Tartare de saumon",
        item = "tartaresaumon",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "fish12", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "cereale", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = pearlsCrafts["recettes"]["tartaresaumon"]
            craftRecettes(data)
        end
    },

    crevettesail = {
        title = "Crevettes à l'ail",
        label = "Crevettes à l'ail",
        item = "crevettesail",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "fish15", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = pearlsCrafts["recettes"]["crevettesail"]
            craftRecettes(data)
        end
    },

    turbotraisins = {
        title = "Turbot aux raisins",
        label = "Turbot aux raisins",
        item = "turbotraisins",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "fish6", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "raisin", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = pearlsCrafts["recettes"]["turbotraisins"]
            craftRecettes(data)
        end
    },

    paella = {
        title = "Paëlla",
        label = "Paëlla",
        item = "paella",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "rice", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chicken", count = 1},
            {name = "fish15", count = 1},
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = pearlsCrafts["recettes"]["paella"]
            craftRecettes(data)
        end
    },

    saumonchampagne = {
        title = "Saumon au champagne",
        label = "Saumon au champagne",
        item = "saumonchampagne",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "fish12", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "champagne", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = pearlsCrafts["recettes"]["saumonchampagne"]
            craftRecettes(data)
        end
    },

    moulesfrites = {
        title = "Moules frites",
        label = "Moules frites",
        item = "moulesfrites",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "moules", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "pommeterre", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = pearlsCrafts["recettes"]["moulesfrites"]
            craftRecettes(data)
        end
    },

    filetcabillaud = {
        title = "Filet de cabillaud",
        label = "Filet de cabillaud",
        item = "filetcabillaud",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "fish6", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "milk", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = pearlsCrafts["recettes"]["filetcabillaud"]
            craftRecettes(data)
        end
    },

    tarteraisins = {
        title = "Tarte aux raisins",
        label = "Tarte aux raisins",
        item = "tarteraisins",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "raisin", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "rhum", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = pearlsCrafts["recettes"]["tarteraisins"]
            craftRecettes(data)
        end
    },

    rizlait = {
        title = "Riz au lait",
        label = "Riz au lait",
        item = "rizlait",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "rice", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "milk", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = pearlsCrafts["recettes"]["rizlait"]
            craftRecettes(data)
        end
    },
}

Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("pearlsCrafts", "main", RageUI.CreateMenu("Peals", "Catégories disponibles", 10, 100))
        -- creata acc
        RMenu.Add(
            "pearlsCrafts",
            "create_pearls",
            RageUI.CreateSubMenu(RMenu:Get("pearlsCrafts", "main"), "Peals", "Craft d'alcool", 10, 100)
        )
    end
)

function EntercraftpearlsZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
    KeySettings:Add("keyboard", "E", OpenPearlsMenu, "ALCOOL")
    KeySettings:Add("controller", 46, OpenPearlsMenu, "ALCOOL")
end

function ExitcraftpearlsZone()
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

function OpenPearlsMenu()
    RageUI.Visible(RMenu:Get("pearlsCrafts", "main"), true)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("pearlsCrafts", "main")) then
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
                            RMenu:Get("pearlsCrafts", "create_pearls")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("pearlsCrafts", "create_pearls")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(pearlsCrafts["recettes"]) do
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
