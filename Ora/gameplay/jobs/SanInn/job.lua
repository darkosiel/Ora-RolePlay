local function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

sanCrafts = {}
-- Pistols
sanCrafts["recettes"] = {
    bouillon = {
        title = "Bouillon de légume",
        label = "Bouillon de légume",
        item = "bouillon",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "water", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "salade", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = sanCrafts["recettes"]["bouillon"]
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
            local data = sanCrafts["recettes"]["nem"]
            craftRecettes(data)
        end
    },
    salade2 = {
        title = "Salade assaisonnée",
        label = "Salade assaisonnée",
        item = "salade2",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "salade", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = sanCrafts["recettes"]["salade2"]
            craftRecettes(data)
        end
    },
    entreepearl = {
        title = "Tartare de thon-rouge",
        label = "Tartare de thon-rouge",
        item = "entreepearl",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "fish4", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "cereale", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = sanCrafts["recettes"]["entreepearl"]
            craftRecettes(data)
        end
    },
    boeufkobe2 = {
        title = "Boeuf de Kobe Riz",
        label = "Boeuf de Kobe Riz",
        item = "boeufkobe2",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "boeufkobe", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "rice", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = sanCrafts["recettes"]["boeufkobe2"]
            craftRecettes(data)
        end
    },
    ramen = {
        title = "Ramen",
        label = "Ramen",
        item = "ramen",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "oeuf", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "meat", count = 1},
            {name = "salade", count = 1},
            {name = "noddle", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = sanCrafts["recettes"]["ramen"]
            craftRecettes(data)
        end
    },
    sushi = {
        title = "Sushi",
        label = "Sushi",
        item = "sushi",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "fish12", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "rice", count = 1},
            {name = "feuillenori", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = sanCrafts["recettes"]["sushi"]
            craftRecettes(data)
        end
    },
    tonkatsu = {
        title = "Tonkatsu",
        label = "Tonkatsu",
        item = "tonkatsu",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "pommeterre", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "chicken", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = sanCrafts["recettes"]["tonkatsu"]
            craftRecettes(data)
        end
    },
    tatakithon = {
        title = "Tataki de thon",
        label = "Tataki de thon",
        item = "tatakithon",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "fish4", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "sake", count = 1},
            {name = "cereale", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = sanCrafts["recettes"]["tatakithon"]
            craftRecettes(data)
        end
    },
    mochi = {
        title = "Mochi",
        label = "Mochi",
        item = "mochi",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "rice", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "milk", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = sanCrafts["recettes"]["mochi"]
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
            local data = sanCrafts["recettes"]["perlecoco"]
            craftRecettes(data)
        end
    },
    coupelitchi = {
        title = "Coupe de litchi",
        label = "Coupe de litchi",
        item = "coupelitchi",
        time = 1000, -- temps de craft je pense
        required = {
            {name = "litchi", count = 1}, -- duppliquer cette ligne pour ajouter un ingrédient
            {name = "milk", count = 1}
        },
        selected = function() -- !! Ne pas toucher en dessous sauf la 3ème ligne !!
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = sanCrafts["recettes"]["coupelitchi"]
            craftRecettes(data)
        end
    }
}

Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("sanCrafts", "main", RageUI.CreateMenu("San-Inn", "Catégories disponibles", 10, 100))
        -- creata acc
        RMenu.Add(
            "sanCrafts",
            "create_san",
            RageUI.CreateSubMenu(RMenu:Get("sanCrafts", "main"), "San-Inn", "Craft", 10, 100)
        )
    end
)

function EntercraftsanZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour cuisiner")
    KeySettings:Add("keyboard", "E", OpensanMenu, "ALCOOL")
    KeySettings:Add("controller", 46, OpensanMenu, "ALCOOL")
end

function ExitcraftsanZone()
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

function OpensanMenu()
    RageUI.Visible(RMenu:Get("sanCrafts", "main"), true)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("sanCrafts", "main")) then
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
                            RMenu:Get("sanCrafts", "create_san")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("sanCrafts", "create_san")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(sanCrafts["recettes"]) do
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
