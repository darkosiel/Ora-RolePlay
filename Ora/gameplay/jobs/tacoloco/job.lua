tacoCrafts = {}
-- Pistols
tacoCrafts["recettes"] = {
    nachos = {
        title = "Nachos",
        label = "Nachos",
        item = "nachos",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "pommeterre", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chips", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = tacoCrafts["recettes"]["nachos"]
            craftRecettes(data)
        end
    },

    ceviche = {
        title = "Ceviche",
        label = "Ceviche",
        item = "ceviche",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "moules", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "fish15", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = tacoCrafts["recettes"]["ceviche"]
            craftRecettes(data)
        end
    },

    pozole = {
        title = "Pozole",
        label = "Pozole",
        item = "pozole",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "veloute", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = tacoCrafts["recettes"]["pozole"]
            craftRecettes(data)
        end
    },

    enchiladas = {
        title = "Enchiladas",
        label = "Enchiladas",
        item = "enchiladas",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "bread", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "meat", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = tacoCrafts["recettes"]["enchiladas"]
            craftRecettes(data)
        end
    },

    mole = {
        title = "Mole",
        label = "Mole",
        item = "mole",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "aperitif", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chicken", count = 1},
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = tacoCrafts["recettes"]["mole"]
            craftRecettes(data)
        end
    },

    capirotada = {
        title = "Capirotada",
        label = "Capirotada",
        item = "capirotada",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "bread", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "aperitif", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = tacoCrafts["recettes"]["capirotada"]
            craftRecettes(data)
        end
    },
    panuchos = {
        title = "Panuchos",
        label = "Panuchos",
        item = "panuchos",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "meat", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "pommeterre", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = TacoCraft["recettes"]["panuchos"]
            craftRecettes(data)
        end
    },
    pastel = {
        title = "Pastel tres leche",
        label = "Pastel tres leche",
        item = "pastel",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "milk", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = tacoCrafts["recettes"]["pastel"]
            craftRecettes(data)
        end
    }
}

Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("tacoCrafts", "main", RageUI.CreateMenu("Taco Loco", "Catégories disponibles", 10, 100))
        -- creata acc
        RMenu.Add(
            "tacoCrafts",
            "create_taco",
            RageUI.CreateSubMenu(RMenu:Get("tacoCrafts", "main"), "Taco Loco", "Craft", 10, 100)
        )
    end
)

function EntercrafttacoZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
    KeySettings:Add("keyboard", "E", OpentacoMenu, "ALCOOL")
    KeySettings:Add("controller", 46, OpentacoMenu, "ALCOOL")
end

function ExitcrafttacoZone()
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

function OpentacoMenu()
    RageUI.Visible(RMenu:Get("tacoCrafts", "main"), true)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("tacoCrafts", "main")) then
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
                            RMenu:Get("tacoCrafts", "create_taco")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("tacoCrafts", "create_taco")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(tacoCrafts["recettes"]) do
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
