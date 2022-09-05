local function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

mirorCrafts = {}
-- Pistols
mirorCrafts["recettes"] = {
    tartareviande = {
        title = "Tartare de viande",
        label = "Tartare de viande",
        item = "tartareviande",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "meat", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "oeuf", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = mirorCrafts["recettes"]["tartareviande"]
            craftRecettes(data)
        end
    },

    carpaccioboeuf = {
        title = "Carpaccio de boeuf",
        label = "Carpaccio de boeuf",
        item = "carpaccioboeuf",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "meat", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "salade", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = mirorCrafts["recettes"]["carpaccioboeuf"]
            craftRecettes(data)
        end
    },

    charcuterie = {
        title = "Plateau de charcuterie",
        label = "Plateau de charcuterie",
        item = "charcuterie",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "fish15", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "milk", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = mirorCrafts["recettes"]["charcuterie"]
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
            local data = mirorCrafts["recettes"]["frites"]
            craftRecettes(data)
        end
    },

    pouletbraise = {
        title = "Poulet braisé pommes de terre",
        label = "Poulet braisé pommes de terre",
        item = "pouletbraise",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "chicken", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "pommeterre", count = 1},
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = mirorCrafts["recettes"]["pouletbraise"]
            craftRecettes(data)
        end
    },

    fajitas = {
        title = "Fajitas",
        label = "Fajitas",
        item = "fajitas",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "rice", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chicken", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = mirorCrafts["recettes"]["fajitas"]
            craftRecettes(data)
        end
    },

    raclette = {
        title = "Raclette",
        label = "Raclette",
        item = "raclette",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "milk", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "pommeterre", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = mirorCrafts["recettes"]["raclette"]
            craftRecettes(data)
        end
    },

    pierrade = {
        title = "Pierrade 3 viandes",
        label = "Pierrade 3 viandes",
        item = "pierrade",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "chicken", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "meat", count = 1},
            {name = "piecedeboeuf", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = mirorCrafts["recettes"]["pierrade"]
            craftRecettes(data)
        end
    },

    cremebrule = {
        title = "Crème brulée",
        label = "Crème brulée",
        item = "cremebrule",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "oeuf", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "milk", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = mirorCrafts["recettes"]["cremebrule"]
            craftRecettes(data)
        end
    },

    ileflottante = {
        title = "Ile flottante",
        label = "Ile flottante",
        item = "ileflottante",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "oeuf", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "milk", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = mirorCrafts["recettes"]["ileflottante"]
            craftRecettes(data)
        end
    },

    tiramisu = {
        title = "Tiramisu",
        label = "Tiramisu",
        item = "tiramisu",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "oeuf", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "cafe", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = mirorCrafts["recettes"]["tiramisu"]
            craftRecettes(data)
        end
    },
}

Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("mirorCrafts", "main", RageUI.CreateMenu("Mirror", "Catégories disponibles", 10, 100))
        -- creata acc
        RMenu.Add(
            "mirorCrafts",
            "create_miror",
            RageUI.CreateSubMenu(RMenu:Get("mirorCrafts", "main"), "Mirror", "Craft", 10, 100)
        )
    end
)

function EntercraftmirorZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
    KeySettings:Add("keyboard", "E", OpenmirorMenu, "ALCOOL")
    KeySettings:Add("controller", 46, OpenmirorMenu, "ALCOOL")
end

function ExitcraftmirorZone()
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

function OpenmirorMenu()
    RageUI.Visible(RMenu:Get("mirorCrafts", "main"), true)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("mirorCrafts", "main")) then
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
                            RMenu:Get("mirorCrafts", "create_miror")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("mirorCrafts", "create_miror")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(mirorCrafts["recettes"]) do
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

function GenerateparlsSerial()
    local serial = "DIST-"
    math.randomseed(GetGameTimer())
    local num = math.random(11111, 99999)
    return serial .. num .. "-" .. GetGameTimer()
end

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
        showMessageInformation("~b~Création du plat en cours (" .. timeWait .. " minute(s))...", data.time)

        for i = 1, #data.required, 1 do
            Ora.Inventory:RemoveFirstItem(data.required[i].name)
        end

        local playerPed = LocalPlayer().Ped

        RequestAnimDict("anim@arena@celeb@podium@no_prop@")
        local j = 0
        while not HasAnimDictLoaded("anim@arena@celeb@podium@no_prop@") and j <= 50 do
            Citizen.Wait(100)
            j = j + 1
        end

        if j >= 50 then
            SendNotification("~r~~h~ERROR ~h~~w~: The animation dictionnary took too long to load.")
        else
            TaskPlayAnim(playerPed, "anim@arena@celeb@podium@no_prop@", "cocky_a_2nd", 8.0, 1.0, -1, 1)
        end
        Wait(data.time / 4)
        RemoveAnimDict("anim@arena@celeb@podium@no_prop@")

        RequestAnimDict("anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal")
        local j = 0
        while not HasAnimDictLoaded("anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal") and j <= 50 do
            Citizen.Wait(100)
            j = j + 1
        end

        if j >= 50 then
            SendNotification("~r~~h~ERROR ~h~~w~: The animation dictionnary took too long to load.")
        else
            TaskPlayAnim(
                playerPed,
                "anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal",
                "idle",
                8.0,
                1.0,
                -1,
                1
            )
        end
        Wait(data.time / 4)

        TaskPlayAnim(
            playerPed,
            "anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal",
            "glass_hold",
            8.0,
            1.0,
            -1,
            1
        )
        Wait(data.time / 4)

        TaskPlayAnim(
            playerPed,
            "anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal",
            "pour_one",
            8.0,
            1.0,
            -1,
            1
        )
        RemoveAnimDict("anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal")
        Wait(data.time / 4)

        ClearPedTasksImmediately(LocalPlayer().Ped)

        serial = GenerateparlsSerial()
        Ora.Inventory:AddItem({name = data.item, id = generateUUIDV2(), data = {serial = serial}, label = serial})
    else
        ShowNotification("~r~Action impossible car certains ingrédients manquent~s~")
        return
    end
end
