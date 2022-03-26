local autoshop =
    setmetatable(
    {
        -- veh
        {
            Pos = {x = -251.134, y = 6224.524, z = 30.50, a = 138.00},
            SpawnPos = {x = -226.135, y = 6247.7001, z = 31.48, a = 132.60},
            Blips = {
                sprite = 523,
                color = 84,
                name = "Auto Shop"
            },
            Menus = {
                Sprite = "shopui_title_ie_modgarage",
                Enabled = true
            },
            Marker = {
                type = 1,
                scale = {x = 2.5, y = 2.5, z = 0.2},
                color = {r = 255, g = 255, b = 255, a = 120},
                Up = false,
                Cam = false,
                Rotate = false,
                visible = true
            },
            Vehicles = {
                ["Entreprise"] = {
                    {name = "benson", price = 35000},
                    {name = "benson2", price = 35000},
                    {name = "mule4", price = 37500},
                    {name = "mule6", price = 37500},
                    {name = "pounder2", price = 40000},
                    {name = "towtruck", price = 30000},
                    {name = "towtruck2", price = 25000},
                    {name = "flatbed", price = 37500},
                    {name = "bison", price = 30000},
                    {name = "bison2", price = 30000},
                    {name = "bison3", price = 30000},
                    {name = "boxville", price = 33000},
                    {name = "slamtruck", price = 30000},
                    {name = "stockade", price = 30000},
                    {name = "emsnspeedo", price = 30000},
                    {name = "safeteam", price = 50000},
                    {name = "taco", price = 30000},
                    {name = "tiptruck2", price = 38000},
                    {name = "tractor2", price = 30000},
                    {name = "brickade", price = 27000},
                    {name = "utillitruck3", price = 30000},
                    {name = "phantom", price = 40000},
                    {name = "phantom3", price = 45000},
                    {name = "newsvan", price = 26000},
                    {name = "insurgent4", price = 80000},
                    {name = "cbicougar4", price = 80000},
                    {name = "sheriff", price = 20000},
                    {name = "sheriff2", price = 40000},
                    {name = "sheriffcoqm", price = 55000},
                    {name = "sherifffug", price = 30000},
                    {name = "sheriffinsurgent", price = 80000},
                    {name = "sheriffscout", price = 50000},
                    {name = "sheriffscoutnew", price = 50000},
                    {name = "sheriffstalker", price = 50000},
                    {name = "sheriffalamo", price = 50000},
                    {name = "sheriffthrust", price = 20000},
                    {name = "suppressor", price = 80000},
                    {name = "police3umk", price = 40000},
                    {name = "umkscout", price = 50000},
                    {name = "polmerit2", price = 20000},
                    {name = "police4", price = 20000},
                    {name = "fbi", price = 20000},
                    {name = "fbi2", price = 50000},
                    {name = "sebalamo2", price = 50000},
                    {name = "police42", price = 30000},
                    {name = "halfback", price = 60000},
                    {name = "roadrunner", price = 60000},
                    {name = "usssvan", price = 20000},
                    {name = "scorcherpolice", price = 140}
                },
                ["4x4"] = {
                    {name = "bobcatxl", price = 10920},
                    {name = "contender", price = 110500},
                    {name = "guardian", price = 82875},
                    {name = "sadler", price = 76500},
                    {name = "squaddie", price = 56500},
                    {name = "winky", price = 36500},
                    {name = "sadler", price = 76500}
                },
                ["Velo"] = {
                    {name = "bmx", price = 70},
                    {name = "cruiser", price = 28},
                    {name = "fixter", price = 140},
                    {name = "scorcher", price = 105},
                    {name = "tribike", price = 175},
                    {name = "tribike2", price = 175},
                    {name = "tribike3", price = 175}
                },
                ["Off-Road"] = {
                    {name = "bfinjection", price = 13520},
                    {name = "bifta", price = 9360},
                    {name = "bodhi2", price = 8684},
                    {name = "brawler", price = 122400},
                    {name = "caracara2", price = 102212},
                    {name = "contender", price = 110500},
                    {name = "dloader", price = 20000},
                    {name = "dubsta3", price = 44200},
                    {name = "dune", price = 9360},
                    {name = "everon", price = 49725},
                    {name = "freecrawler", price = 49725},
                    {name = "granger", price = 26000},
                    {name = "hellion", price = 19240},
                    {name = "kalahari", price = 1820},
                    {name = "kamacho", price = 44200},
                    {name = "marshall", price = 80750},
                    {name = "mesa", price = 10400},
                    {name = "mesa3", price = 31200},
                    {name = "outlaw", price = 12480},
                    {name = "rancherxl", price = 11960},
                    {name = "rebel", price = 11440},
                    {name = "rebel2", price = 11440},
                    {name = "riata", price = 36400},
                    {name = "sandking", price = 36400},
                    {name = "sandking2", price = 49725},
                    {name = "vagrant", price = 26000}
                },
                ["Muscle"] = {
                    {name = "blade", price = 10400},
                    {name = "Buccaneer", price = 12740},
                    {name = "buccaneer2", price = 16640},
                    {name = "chino", price = 10140},
                    {name = "chino2", price = 11440},
                    {name = "clique", price = 15600},
                    {name = "coquette3", price = 96135},
                    {name = "deviant", price = 12480},
                    {name = "dominator", price = 27040},
                    {name = "dominator2", price = 36750},
                    {name = "dominator3", price = 46750},
                    {name = "dominator7", price = 35000},
                    {name = "dominator8", price = 40000},
                    {name = "dukes", price = 14560},
                    {name = "dukes3", price = 7300},
                    {name = "ellie", price = 15600},
                    {name = "faction", price = 17160},
                    {name = "faction2", price = 18200},
                    {name = "faction3", price = 11960},
                    {name = "gauntlet", price = 19240},
                    {name = "gauntlet2", price = 24000},
                    {name = "gauntlet3", price = 31200},
                    {name = "gauntlet4", price = 99450},
                    {name = "gauntlet5", price = 42200},
                    {name = "hermes", price = 55250},
                    {name = "hotknife", price = 17680},
                    {name = "hustler", price = 20800},
                    {name = "impaler", price = 12480},
                    {name = "lurcher", price = 55250},
                    {name = "moonbeam", price = 9360},
                    {name = "moonbeam2", price = 11440},
                    {name = "nightshade", price = 104975},
                    {name = "peyote", price = 31200},
                    {name = "peyote2", price = 45200},
                    {name = "phoenix", price = 23400},
                    {name = "picador", price = 11440},
                    {name = "ratloader", price = 1820},
                    {name = "ratloader2", price = 8320},
                    {name = "ruiner", price = 12740},
                    {name = "sabregt", price = 15600},
                    {name = "sabregt2", price = 17680},
                    {name = "slamvan", price = 8476},
                    {name = "slamvan2", price = 9360},
                    {name = "slamvan3", price = 8476},
                    {name = "stalion", price = 13000},
                    {name = "tampa", price = 12480},
                    {name = "tulip", price = 9880},
                    {name = "vamos", price = 15600},
                    {name = "vigero", price = 14600},
                    {name = "virgo", price = 12960},
                    {name = "virgo2", price = 11440},
                    {name = "virgo3", price = 12400},
                    {name = "voodoo", price = 4095},
                    {name = "voodoo2", price = 2730},
                    {name = "yosemite", price = 82322},
                    {name = "yosemite2", price = 82875},
                    {name = "yosemite3", price = 83200}
                },
                ["Suvs"] = {
                    {name = "baller", price = 36400},
                    {name = "baller2", price = 66300},
                    {name = "baller3", price = 66300},
                    {name = "baller4", price = 76500},
                    {name = "bjxl", price = 16440},
                    {name = "cavalcade", price = 15600},
                    {name = "cavalcade2", price = 8840},
                    {name = "dubsta", price = 36400},
                    {name = "dubsta2", price = 122400},
                    {name = "fq2", price = 14000},
                    {name = "gresley", price = 12792},
                    {name = "huntley", price = 60775},
                    {name = "landstalker", price = 37000},
                    {name = "novak", price = 111500},
                    {name = "landstalker2", price = 76500},
                    {name = "patriot", price = 65000},
                    {name = "patriot2", price = 162000},
                    {name = "radius", price = 6825},
                    {name = "rebla", price = 142000},
                    {name = "rocoto", price = 36400},
                    {name = "seminole", price = 9360},
                    {name = "seminole2", price = 25650},
                    --{name="serrano",price=29000},
                    {name = "toros", price = 162400},
                    {name = "xls", price = 44200},
                    {name = "habanero", price = 7500},
                    {name = "serrano", price = 8000}
                },
                ["Vans"] = {
                    {name = "minivan", price = 9100},
                    {name = "paradise", price = 10140},
                    {name = "youga2", price = 9360},
                    {name = "youga3", price = 11260},
                    {name = "minivan2", price = 9360},
                    {name = "burrito3", price = 10400},
                    {name = "surfer2", price = 6300},
                    {name = "speedo4", price = 12400},
                    {name = "pony", price = 10400},
                    {name = "surfer", price = 9360},
                    {name = "youga", price = 9620},
                    {name = "journey", price = 15600},
                    {name = "camper", price = 31200},
                    {name = "gburrito2", price = 26000},
                    {name = "speedo2", price = 13200},
                    {name = "rumpo3", price = 55250},
                    {name = "speedo", price = 11960},
                    {name = "gburrito", price = 26000}
                }
            }
        }
    },
    autoshop
)

function autoshop:CreateShops()
    for i = 1, #self, 1 do
        Wait(540)
        v = self[i]
        local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
        SetBlipSprite(blip, v.Blips.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, v.Blips.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Blips.name)
        EndTextCommandSetBlipName(blip)
        Blips:AddBlip(blip, "Concessionnaire", v.Blips)
        Zone:Add(v.Pos, self.EnterZone, self.ExitZone, i, 2.5)
        RMenu.Add(
            "autoshop",
            i,
            RageUI.CreateMenu(nil, "Catégories disponibles", 10, 20, v.Menus.Sprite, v.Menus.Sprite)
        )
        Marker:Add(v.Pos, v.Marker)

        for k, v in pairs(v.Vehicles) do
            RMenu.Add("autoshop_sub", k, RageUI.CreateSubMenu(RMenu:Get("autoshop", i), nil, k))
        end
        RMenu.Add("autoshop_sub", "list", RageUI.CreateSubMenu(RMenu:Get("autoshop", i), nil, "Actions disponibles"))
        RMenu.Add(
            "autoshop_sub",
            "playerList",
            RageUI.CreateSubMenu(RMenu:Get("autoshop_sub", "list"), nil, "Listes des joueurs")
        )
        RMenu.Add(
            "autoshop_sub",
            "joblist",
            RageUI.CreateSubMenu(RMenu:Get("autoshop_sub", "list"), nil, "Listes des joueurs")
        )
        RMenu.Add(
            "autoshop_sub",
            "confirm",
            RageUI.CreateSubMenu(RMenu:Get("autoshop_sub", "list"), nil, "Confirmer")
        )
    end
end

local CurrentZone = nil

function autoshop.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard", "E", autoshop.Open, "autoshop")
    KeySettings:Add("controller", 46, autoshop.Open, "autoshop")
    CurrentZone = zone
end

function autoshop.ExitZone(zone)
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", "autoshop")
        KeySettings:Clear("controller", 46, "autoshop")
        Marker:Visible(autoshop[CurrentZone].Pos, true)
        autoshop.Close()
        CurrentZone = nil
    end
end

function autoshop.Open()
    RageUI.Visible(RMenu:Get("autoshop", CurrentZone), true)
    Marker:Visible(autoshop[CurrentZone].Pos, false)
end

function autoshop.Close()
    if RageUI.Visible(RMenu:Get("autoshop", CurrentZone)) then
        RageUI.Visible(RMenu:Get("autoshop", CurrentZone), false)
    end
end

local currentHeader = true
local currentveh = 0
local function DrawVehicle(vehicleName)
    local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
    if veh ~= nil then
        DeleteEntity(veh)
    end
    vehicleFct.SpawnLocalVehicle(
        vehicleName,
        autoshop[CurrentZone].Pos,
        autoshop[CurrentZone].Pos.a,
        function(veh)
            SetPedIntoVehicle(LocalPlayer().Ped, veh, -1)
            FreezeEntityPosition(veh, true)
            SetVehicleDoorsLocked(veh, 4)
            currentveh = veh
        end
    )
    --   SetEntityVisible(LocalPlayer().Ped, false)
    t = vehicleFct.GetVehiclesInArea(autoshop[CurrentZone].Pos, 8.0)

    for i = 1, #t, 1 do
        DeleteEntity(t[i])
    end
    RMenu:Get("autoshop", CurrentZone).Closed = function()
        --SetEntityVisible(LocalPlayer().Ped, true)
        local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
        if veh ~= nil then
            DeleteEntity(veh)
        end
        t = vehicleFct.GetVehiclesInArea(autoshop[CurrentZone].Pos, 8.0)
        Marker:Visible(autoshop[CurrentZone].Pos, true)
        for i = 1, #t, 1 do
            DeleteEntity(t[i])
        end
    end
end
local CurrentVehicle = nil
local menu = nil
local currentInd = {}
local amountVeh = nil
Citizen.CreateThread(
    function()
        Wait(100)
        autoshop:CreateShops()
        while true do
            Wait(1)
            if CurrentZone ~= nil then
                if RageUI.Visible(RMenu:Get("autoshop", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            for k, v in pairs(autoshop[CurrentZone].Vehicles) do
                                RageUI.Button(
                                    k,
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            CurrentVehicle = v[1].name
                                            if IsModelValid(v[1].name) then
                                                DrawVehicle(v[1].name)
                                            end
                                        end
                                    end,
                                    RMenu:Get("autoshop_sub", k)
                                )
                            end
                        end,
                        function()
                        end
                    )
                else
                    --[[ if RageUI.Visible(RMenu:Get("autoshop_sub", "playerList")) then
                        RageUI.DrawContent(
                            {header = true, glare = false},
                            function()
                                for k, v in pairs(GetActivePlayers()) do
                                    local i = v
                                    RageUI.Button(
                                        Atlantiss.Identity:GetFullname(GetPlayerServerId(i)),
                                        nil,
                                        {},
                                        true,
                                        function(_, Active, Selected)
                                            if Selected then
                                                TriggerServerCallback(
                                                    "getBankingAccountsPly3",
                                                    function(result)
                                                        amount = result[1].amount
                                                        if amount - amountVeh >= 0 then
                                                            local veh = Atlantiss.World.Vehicle:GetVehicleCustoms(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                            
                                                            TriggerServerCallback(
                                                                "autoshop:BuyVehicle",
                                                                function(bool, plate)
                                                                    local spawnedVehicle = nil
                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                    if bool then
                                                                        TriggerServerEvent(
                                                                            "banking:removeAmountFromAccount",
                                                                            "autoshop",
                                                                            amountVeh
                                                                        )
                                                                        spawnedVehicle = Atlantiss.World.Vehicle:Create(veh.model, autoshop[CurrentZone].SpawnPos, autoshop[CurrentZone].SpawnPos.h, {})
                                                                        Atlantiss.World.Vehicle:ApplyCustomsToVehicle(spawnedVehicle, veh)
                                                                        if GetVehicleNumberPlateText(spawnedVehicle) ~= plate then 
                                                                            SetVehicleNumberPlateText(spawnedVehicle, plate) 
                                                                        end
                                                                    end

                                                                    while spawnedVehicle == nil do
                                                                        Wait(100)
                                                                    end

                                                                    items = {
                                                                        name = "key",
                                                                        data = {
                                                                            plate = veh.plate,
                                                                            vehicleIdentifier = getVehicleIdentifier(
                                                                                spawnedVehicle
                                                                            )
                                                                        },
                                                                        label = veh.plate
                                                                    }
                                                                    Atlantiss.Inventory:AddItem(items)
                                                                    CloseAllMenus()
                                                                end,
                                                                currentInd.price,
                                                                GetPlayerServerId(i),
                                                                veh
                                                            )
                                                        else
                                                            RageUI.Popup(
                                                                {
                                                                    message = "Les fonds de la société ne sont pas suffisants pour l'achat de ce véhicule"
                                                                }
                                                            )
                                                        end
                                                    end,
                                                    "autoshop"
                                                )
                                            end
                                        end
                                    )
                                end
                            end,
                            function()
                            end
                        )
                    end
                    if RageUI.Visible(RMenu:Get("autoshop_sub", "joblist")) then
                        RageUI.DrawContent(
                            {header = true, glare = false},
                            function()
                                for k, v in pairs(Jobs) do
                                    RageUI.Button(
                                        v.label,
                                        nil,
                                        {},
                                        true,
                                        function(_, Active, Selected)
                                            if Selected then
                                                TriggerServerCallback(
                                                    "getBankingAccountsPly3",
                                                    function(result)
                                                        amount = result[1].amount
                                                        if amount - amountVeh >= 0 then
                                                            local veh = Atlantiss.World.Vehicle:GetVehicleCustoms(GetVehiclePedIsIn(LocalPlayer().Ped))

                                                            TriggerServerCallback(
                                                                "autoshop:BuyVehicleForCompany",
                                                                function(bool, plate)
                                                                    spawnedVehicle = nil
                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                    if bool then
                                                                        TriggerServerEvent(
                                                                            "banking:removeAmountFromAccount",
                                                                            "autoshop",
                                                                            amountVeh
                                                                        )
                                                                        spawnedVehicle = Atlantiss.World.Vehicle:Create(veh.model, autoshop[CurrentZone].SpawnPos, autoshop[CurrentZone].SpawnPos.h, {})
                                                                        Atlantiss.World.Vehicle:ApplyCustomsToVehicle(spawnedVehicle, veh)
                                                                        if GetVehicleNumberPlateText(spawnedVehicle) ~= plate then 
                                                                            SetVehicleNumberPlateText(spawnedVehicle, plate) 
                                                                        end
                                                                    end

                                                                    while spawnedVehicle == nil do
                                                                        Wait(100)
                                                                    end

                                                                    items = {
                                                                        name = "key",
                                                                        data = {
                                                                            plate = veh.plate,
                                                                            vehicleIdentifier = getVehicleIdentifier(
                                                                                spawnedVehicle
                                                                            )
                                                                        },
                                                                        label = veh.plate
                                                                    }
                                                                    Atlantiss.Inventory:AddItem(items)
                                                                    -- SetEntityVisible(LocalPlayer().Ped,true)
                                                                    CloseAllMenus()
                                                                end,
                                                                currentInd.price,
                                                                k,
                                                                veh
                                                            )
                                                        else
                                                            RageUI.Popup(
                                                                {
                                                                    message = "Les fonds de la société ne sont pas suffisants pour l'achat de ce véhicule"
                                                                }
                                                            )
                                                        end
                                                    end,
                                                    "autoshop"
                                                )
                                            end
                                        end
                                    )
                                end
                            end,
                            function()
                            end
                        )
                    end ]]

                    if (RageUI.Visible(RMenu:Get("autoshop_sub", "confirm"))) then
                        RageUI.DrawContent(
                            {header = true, glare = false},
                            function()
                                RageUI.Button(
                                    "Confirmer l'achat ?",
                                    nil,
                                    {Color = {HightLightColor = {0, 155, 0, 150}}},
                                    true,
                                    function(_, Active, Selected)
                                        if (Selected) then
                                            TriggerServerCallback(
                                                "Atlantiss::SVCB::Jobs:Jetsam:CanOrder",
                                                function(canOrder)
                                                    if (canOrder == true) then
                                                        TriggerServerCallback(
                                                            "getBankingAccountsPly3",
                                                            function(result)
                                                                if (result[1].amount - amountVeh >= 0) then
                                                                    local veh = Atlantiss.World.Vehicle:GetVehicleCustoms(GetVehiclePedIsIn(LocalPlayer().Ped))
                    
                                                                    TriggerServerCallback(
                                                                        "autoshop:BuyVehicle",
                                                                        function(_, plate)
                                                                            TriggerServerEvent(
                                                                                "Atlantiss::SE::Jobs:Jetsam:Order",
                                                                                {
                                                                                    plate = plate,
                                                                                    customs = veh
                                                                                },
                                                                                Atlantiss.Identity:GetMyUuid(),
                                                                                "autoshop"
                                                                            )
                    
                                                                            CloseAllMenus()
                                                                            DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                            TriggerServerEvent(
                                                                                "banking:removeAmountFromAccount",
                                                                                "autoshop",
                                                                                amountVeh
                                                                            )
                    
                                                                            RageUI.Popup({message = "~g~Commande effectuée !"})
                                                                        end,
                                                                        currentInd.price,
                                                                        0,
                                                                        veh
                                                                    )
                                                                else
                                                                    RageUI.Popup(
                                                                        {
                                                                            message = "Les fonds de la société ne sont pas suffisants pour l'achat de ce véhicule"
                                                                        }
                                                                    )
                                                                end
                                                            end,
                                                            "autoshop"
                                                        )
                                                    end
                                                end
                                            )
                                        end
                                    end
                                )
                            end,
                            function()
                            end
                        )
                    end

                    if RageUI.Visible(RMenu:Get("autoshop_sub", "list")) then
                        RageUI.DrawContent(
                            {header = true, glare = false},
                            function()
                                --[[ RageUI.Button(
                                    "Joueurs",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("autoshop_sub", "playerList")
                                )

                                RageUI.Button(
                                    "Métiers",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("autoshop_sub", "joblist")
                                ) ]]

                                RageUI.Button(
                                    "Acheter",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("autoshop_sub", "confirm")
                                )

                                RageUI.Button(
                                    "Sortir le véhicule",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                        if Selected then
                                            CloseAllMenus()
                                            local veh = Atlantiss.World.Vehicle:GetVehicleCustoms(GetVehiclePedIsIn(LocalPlayer().Ped))
                                            spawnedVehicle = Atlantiss.World.Vehicle:Create(veh.model, autoshop[CurrentZone].SpawnPos, autoshop[CurrentZone].SpawnPos.h, {})
                                            Atlantiss.World.Vehicle:ApplyCustomsToVehicle(spawnedVehicle, veh)
                                            SetVehicleNumberPlateText(spawnedVehicle, "CONCESS") 
                                            DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                            SetPedIntoVehicle(LocalPlayer().Ped, _veh, -1)
                                        end
                                    end
                                )
                            end,
                            function()
                            end
                        )
                    end
                    for k, v in pairs(autoshop[CurrentZone].Vehicles) do
                        if RageUI.Visible(RMenu:Get("autoshop_sub", k)) then
                            RageUI.DrawContent(
                                {header = true, glare = false},
                                function()
                                    for i = 1, #v, 1 do
                                        p = "~r~MASQUÉ"
                                        if Atlantiss.Identity:HasAnyJob("autoshop") then
                                            p = v[i].price .. "$"
                                        end
                                        RageUI.Button(
                                            GetLabelText(GetDisplayNameFromVehicleModel(v[i].name)),
                                            nil,
                                            {RightLabel = p},
                                            true,
                                            function(_, Active, Selected)
                                                if Atlantiss.Identity:HasAnyJob("autoshop") then
                                                    menu = RMenu:Get("autoshop_sub", "list")
                                                else
                                                    menu = nil
                                                end
                                                if Active then
                                                    --         Citizen.CreateThread(function()
                                                    if IsModelValid(v[i].name) and CurrentVehicle ~= v[i].name then
                                                        --("oload")
                                                        RequestModel(v[i].name)

                                                        while not HasModelLoaded(v[i].name) do
                                                            Citizen.Wait(0)
                                                        end
                                                        CurrentVehicle = v[i].name
                                                        DrawVehicle(CurrentVehicle)
                                                        if (type(v[i].name) == "string") then
                                                            SetModelAsNoLongerNeeded(GetHashKey(v[i].name))
                                                        else
                                                            SetModelAsNoLongerNeeded(v[i].name)
                                                        end
                                                    end
                                                --       end)
                                                end

                                                if Selected then
                                                    if Atlantiss.Identity:HasAnyJob("autoshop") then
                                                        amountVeh = v[i].price
                                                        menu = RMenu:Get("autoshop_sub", "list")
                                                        currentInd = v[i]
                                                    else
                                                        menu = nil
                                                        RageUI.Popup(
                                                            {message = "Merci de contacter un ~b~concessionnaire"}
                                                        )
                                                    end
                                                end
                                            end,
                                            menu
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
        end
    end
)
