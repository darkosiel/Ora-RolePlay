local function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

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
            {name = "bouteille_vin", count = 1},
            {name = "levure", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des ingrédients necessaires~s~")
            found = false
            local data = DistillerieCrafts["alcools"]["champagne"]
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

function GenerateDistillerieSerial()
    local serial = "DIST-"
    math.randomseed(GetGameTimer())
    local num = math.random(11111, 99999)
    return serial .. num .. "-" .. GetGameTimer()
end

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
        showMessageInformation("~b~Création du spiritueux en cours (" .. timeWait .. " minute(s))...", data.time)

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

        serial = GenerateDistillerieSerial()
        Ora.Inventory:AddItem({name = data.item, id = generateUUIDV2(), data = {serial = serial}, label = serial})

        serial = GenerateDistillerieSerial()
        Ora.Inventory:AddItem({name = data.item, id = generateUUIDV2(), data = {serial = serial}, label = serial})
    else
        ShowNotification("~r~Action impossible car certains ingrédients manquent~s~")
        return
    end
end
