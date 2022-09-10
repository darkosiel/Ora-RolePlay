DistillerieCrafts = {}
-- Pistols
DistillerieCrafts["alcools"] = {
    beer = {
        title = "Biere",
        label = "BIERE",
        item = "beer",
        time = 1000,
        required = {
            {name = "houblon", count = 1},
            {name = "levure", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["beer"]
            craftAlcool(data)
        end
    },
    tequila = {
        title = "Tequila ",
        requiredBullet = "9mm",
        item = "tequila",
        label = "TEQUILA",
        time = 1000,
        required = {
            {name = "levure", count = 1},
            {name = "cereale", count = 1},
            {name = "agave", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["tequila"]
            craftAlcool(data)
        end
    },
    rhum = {
        title = "Rhum",
        item = "rhum",
        label = "RHUM",
        time = 1000,
        required = {
            {name = "levure", count = 1},
            {name = "c_sucre", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["rhum"]
            craftAlcool(data)
        end
    },
    cognac = {
        title = "Cognac",
        item = "cognac",
        label = "COGNAC",
        time = 1000,
        required = {
            {name = "red_wine", count = 1},
            {name = "levure", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["cognac"]
            craftAlcool(data)
        end
    },
    vodka = {
        title = "Vodka",
        item = "vodka",
        label = "VODKA",
        time = 1000,
        required = {
            {name = "pommeterre", count = 1},
            {name = "cereale", count = 1},
            {name = "levure", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["vodka"]
            craftAlcool(data)
        end
    },
    whisky = {
        title = "Whisky",
        item = "whisky",
        label = "WHISKY",
        time = 1000,
        required = {
            {name = "water", count = 1},
            {name = "cereale", count = 1},
            {name = "levure", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["whisky"]
            craftAlcool(data)
        end
    },
    champagne = {
        title = "Champagne",
        item = "champagne",
        label = "CHAMPAGNE",
        time = 1000,
        required = {
            {name = "water", count = 1},
            {name = "red_wine", count = 1},
            {name = "levure", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["champagne"]
            craftAlcool(data)
        end
    },
    champagnebleuter = {
        title = "Champagne Bleuter'd",
        item = "champagnebleuter",
        label = "CHAMPAGNEBLEUTER",
        time = 1000,
        required = {
            {name = "water", count = 1},
            {name = "high_quality_wine", count = 1},
            {name = "levure", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["champagnebleuter"]
            craftAlcool(data)
        end 
    },
    red_wine = {
        title = "Bouteille de vin",
        item = "red_wine",
        label = "BOUTEILLE VIN",
        time = 1000,
        required = {
            {name = "water", count = 1},
            {name = "jus_raisin", count = 1},
            {name = "levure", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["red_wine"]
            craftAlcool(data)
        end
    },
    White_wine = {
        title = "Bouteille de vin blanc",
        item = "White_wine",
        label = "BOUTEILLE VIN BLANC",
        time = 1000,
        required = {
            {name = "jus_raisin", count = 1},
            {name = "levure", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["White_wine"]
            craftAlcool(data)
        end
    },
    pink_wine = {
        title = "Bouteille de vin rosé",
        item = "pink_wine",
        label = "BOUTEILLE VIN ROSE",
        time = 1000,
        required = {
            {name = "White_wine", count = 1},
            {name = "red_wine", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["pink_wine"]
            craftAlcool(data)
        end
    }
}

Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("alcoolCraft", "main", RageUI.CreateMenu("Distilleur", "Catégories disponibles", 10, 100))
        -- creata acc
        RMenu.Add(
            "alcoolCraft",
            "create_alcool",
            RageUI.CreateSubMenu(RMenu:Get("alcoolCraft", "main"), "Distilleur", "Craft d'alcool", 10, 100)
        )
    end
)

function EntercraftAlcoolZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour créer des spiritueux")
    KeySettings:Add("keyboard", "E", OpenDistilleurMenu, "ALCOOL")
    KeySettings:Add("controller", 46, OpenDistilleurMenu, "ALCOOL")
end

function ExitcraftAlcoolZone()
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

function OpenDistilleurMenu()
    RageUI.Visible(RMenu:Get("alcoolCraft", "main"), true)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("alcoolCraft", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Confectionner un Spiritueux",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("alcoolCraft", "create_alcool")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("alcoolCraft", "create_alcool")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(DistillerieCrafts["alcools"]) do
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

function craftAlcool(data)
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
                label = "Création du spiritueux en cours...",
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
