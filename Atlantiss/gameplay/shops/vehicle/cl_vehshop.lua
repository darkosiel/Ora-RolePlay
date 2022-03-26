local VehShop =
    setmetatable(
    {
        -- veh
        {
            Pos = {x = -44.08, y = -1097.99, z = 25.42, a = 67.85},
            SpawnPos = {x = -16.38, y = -1083.92, z = 26.88, h = 76.68},
            Blips = {
                sprite = 523,
                color = 84,
                name = "Concessionnaire voiture"
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
                    {name = "emsnspeedo", price = 30000},
                    {name = "firetruk", price = 30000},
                    {name = "lsfd", price = 20000},
                    {name = "lsfd2", price = 30000},
                    {name = "lsfd3", price = 30000},
                    {name = "lsfd5", price = 45000},
                    {name = "lsfdtruck2", price = 50000},
                    {name = "lsfdtruck3", price = 60000},
                    {name = "safeteam", price = 50000},
                    {name = "beachp", price = 50000},
                    {name = "police", price = 20000},
                    {name = "lspd2", price = 30000},
                    {name = "police3slick", price = 40000},
                    {name = "pscout", price = 50000},
                    {name = "polraiden", price = 60000},
                    {name = "newsvan", price = 30000},
                    {name = "taxi", price = 20000},
                    {name = "police3umk", price = 40000},
                    {name = "umkscout", price = 50000},
                    {name = "polmerit2", price = 20000},
                    {name = "police4", price = 20000},
                    {name = "fbi", price = 20000},
                    {name = "fbi2", price = 50000},
                    {name = "sebalamo2", price = 50000},
                    {name = "policeslick", price = 20000},
                    {name = "police3", price = 40000},
                    {name = "sheriffscoutnew", price = 50000},
                    {name = "police42", price = 30000},
                    {name = "halfback", price = 60000},
                    {name = "roadrunner", price = 60000},
                    {name = "usssvan", price = 20000},
                    {name = "scorcherpolice", price = 140},
                    {name = "prevolter", price = 60000},
                    {name = "polschafter3", price = 60000}
                },
                ["Compacts"] = {
                    {name = "issi2", price = 2502},
                    {name = "asbo", price = 3412},
                    {name = "club", price = 4225},
                    {name = "brioso2", price = 5400},
                    {name = "brioso", price = 8400},
                    {name = "dilettante", price = 8000},
                    {name = "blista", price = 4550},
                    {name = "panto", price = 8000},
                    {name = "prairie", price = 8320},
                    {name = "rhapsody", price = 4550},
                    {name = "issi3", price = 8320},
                    {name = "kanjo", price = 15600}
                },
                ["Coupés"] = {
                    {name = "cogcabrio", price = 77350},
                    {name = "exemplar", price = 49725},
                    {name = "f620", price = 50775},
                    {name = "felon", price = 44200},
                    {name = "felon2", price = 36000},
                    {name = "jackal", price = 44200},
                    {name = "oracle", price = 44200},
                    {name = "oracle2", price = 22000},
                    {name = "sentinel", price = 22880},
                    {name = "sentinel2", price = 22880},
                    {name = "windsor", price = 122400},
                    {name = "windsor2", price = 162000},
                    {name = "zion", price = 26000},
                    {name = "zion2", price = 31200},
                    {name = "zion3", price = 38000}
                },
                ["Sport"] = {
                    {name = "alpha", price = 49725},
                    {name = "banshee", price = 77350},
                    {name = "bestiagts", price = 110500},
                    {name = "blista2", price = 14000},
                    {name = "buffalo", price = 16640},
                    {name = "buffalo2", price = 20800},
                    {name = "calico", price = 47500},
                    {name = "carbonizzare", price = 107100},
                    {name = "comet2", price = 104975},
                    {name = "comet3", price = 112200},
                    {name = "comet5", price = 112200},
                    {name = "comet6", price = 130000},
                    {name = "cypher", price = 140000},
                    {name = "coquette", price = 82875},
                    {name = "coquette4", price = 134200},
                    {name = "drafter", price = 112200},
                    {name = "elegy", price = 104975},
                    {name = "elegy2", price = 130000},
                    {name = "euros", price = 112200},
                    {name = "feltzer2", price = 83427},
                    {name = "flashgt", price = 76000},
                    {name = "furoregt", price = 110500},
                    {name = "fusilade", price = 15600},
                    {name = "futo", price = 12480},
                    {name = "futo2", price = 20200},
                    {name = "gb200", price = 66300},
                    {name = "growler", price = 138000},
                    {name = "imorgon", price = 162000},
                    {name = "issi7", price = 31200},
                    {name = "jester", price = 88400},
                    {name = "jester2", price = 93925},
                    {name = "jester3", price = 75140},
                    {name = "jester4", price = 135000},
                    {name = "jugular", price = 112200},
                    {name = "khamelion", price = 82875},
                    {name = "komoda", price = 107100},
                    {name = "kuruma", price = 60775},
                    {name = "locust", price = 107100},
                    {name = "lynx", price = 104975},
                    {name = "massacro", price = 112200},
                    {name = "massacro2", price = 119000},
                    {name = "neo", price = 194400},
                    {name = "ninef", price = 110500},
                    {name = "ninef2", price = 101660},
                    {name = "omnis", price = 90610},
                    {name = "paragon", price = 117300},
                    {name = "pariah", price = 117300},
                    {name = "penumbra", price = 14560},
                    {name = "penumbra2", price = 52900},
                    {name = "previon", price = 30000},
                    {name = "raiden", price = 112400},
                    {name = "rapidgt", price = 93925},
                    {name = "rapidgt2", price = 96135},
                    {name = "revolter", price = 88400},
                    {name = "remus", price = 30000},
                    {name = "rt3000", price = 42000},
                    {name = "ruston", price = 66300},
                    {name = "schafter2", price = 51825},
                    {name = "schafter3", price = 77350},
                    {name = "schafter4", price = 81440},
                    {name = "schlagen", price = 183600},
                    {name = "schwarzer", price = 76500},
                    {name = "sentinel3", price = 55250},
                    {name = "seven70", price = 107100},
                    {name = "specter", price = 104040},
                    {name = "specter2", price = 110500},
                    {name = "streiter", price = 55250},
                    {name = "sugoi", price = 64090},
                    {name = "sultan", price = 31200},
                    {name = "sultan2", price = 77350},
                    {name = "surano", price = 99450},
                    {name = "tropos", price = 88400},
                    {name = "verlierer2", price = 107100},
                    {name = "vstr", price = 112200},
                    {name = "vectre", price = 130000},
                    {name = "neon", price = 130200},
                    {name = "zr350", price = 65000}
                },
                ["Supersportive"] = {
                    {name = "adder", price = 205200},
                    {name = "banshee2", price = 122400},
                    {name = "autarch", price = 217800},
                    {name = "bullet", price = 99450},
                    {name = "cheetah", price = 122400},
                    {name = "cyclone", price = 162000},
                    {name = "emerus", price = 212850},
                    {name = "entity2", price = 202500},
                    {name = "entityxf", price = 156600},
                    {name = "fmj", price = 207900},
                    {name = "furia", price = 227700},
                    {name = "gp1", price = 202500},
                    {name = "infernus", price = 122400},
                    {name = "italigtb", price = 349650},
                    {name = "italigtb2", price = 349650},
                    {name = "italigto", price = 450000},
                    {name = "krieger", price = 396900},
                    {name = "nero", price = 250000},
                    {name = "nero2", price = 275000},
                    {name = "osiris", price = 170000},
                    {name = "penetrator", price = 205200},
                    {name = "pfister811", price = 396900},
                    {name = "prototipo", price = 792650},
                    {name = "reaper", price = 172800},
                    {name = "sc1", price = 183600},
                    {name = "sheava", price = 216000},
                    {name = "sultanrs", price = 112200},
                    {name = "t20", price = 216000},
                    {name = "taipan", price = 207900},
                    {name = "tempesta", price = 297000},
                    {name = "tezeract", price = 792650},
                    {name = "thrax", price = 302400},
                    {name = "turismor", price = 202950},
                    {name = "tyrant", price = 217800},
                    {name = "vacca", price = 122400},
                    {name = "visione", price = 227700},
                    {name = "voltic", price = 117300},
                    {name = "xa21", price = 216000},
                    {name = "zentorno", price = 183600},
                    {name = "zorrusso", price = 242550},
                    {name = "vagner", price = 580000},
                    {name = "italirsx", price = 580000}
                },
                   
                ["Sedans"] = {
                    {name = "asea", price = 8840},
                    {name = "asterope", price = 8320},
                    {name = "cog55", price = 59850},
                    {name = "cognoscenti", price = 61825},
                    --   {name="cognoscenti2",price=70000},
                    {name = "emperor", price = 5915},
                    {name = "emperor2", price = 2800},
                    {name = "fugitive", price = 9880},
                    {name = "glendale", price = 9880},
                    {name = "glendale2", price = 11880},
                    {name = "ingot", price = 8580},
                    {name = "intruder", price = 8580},
                    {name = "premier", price = 5915},
                    {name = "primo", price = 8060},
                    {name = "primo2", price = 8320},
                    {name = "regina", price = 3185},
                    {name = "stanier", price = 6597},
                    {name = "stratum", price = 8840},
                    {name = "stretch", price = 110500},
                    {name = "superd", price = 55250},
                    {name = "surge", price = 13000},
                    {name = "tailgater", price = 10920},
                    {name = "tailgater2", price = 75000},
                    {name = "warrener", price = 8840},
                    {name = "warrener2", price = 25000},
                    {name = "washington", price = 13520}
                },
                ["Classique"] = {
                    {name = "tornado", price = 4095},
                    {name = "tornado2", price = 4095},
                    {name = "tornado5", price = 4322},
                    {name = "tornado3", price = 2730},
                    {name = "tornado4", price = 2730},
                    {name = "tornado6", price = 2730},
                    {name = "cheburek", price = 5005},
                    {name = "fagaloa", price = 6370},
                    {name = "dynasty", price = 9880},
                    {name = "nebula", price = 18920},
                    --   {name="ardent",price=1},
                    {name = "casco", price = 108290},
                    {name = "cheetah2", price = 112200},
                    {name = "tigon", price = 109200},
                    {name = "coquette2", price = 69135},
                    {name = "gt500", price = 112200},
                    {name = "infernus2", price = 99450},
                    {name = "manana", price = 8320},
                    {name = "manana2", price = 10320},
                    {name = "michelli", price = 21440},
                    {name = "monroe", price = 104975},
                    {name=  "stafford",price=112500},
                    {name = "peyote", price = 3640},
                    {name = "peyote3", price = 7640},
                    {name = "pigalle", price = 23660},
                    {name = "rapidgt3", price = 104975},
                    {name = "retinue", price = 23920},
                    {name = "retinue2", price = 24400},
                    {name = "savestra", price = 24960},
                    {name = "btype", price = 88400},
                    {name = "stinger", price = 88400},
                    {name = "stingergt", price = 110500},
                    {name = "swinger", price = 112200},
                    {name = "torero", price = 107100},
                    {name = "ztype", price = 194400},
                    {name = "z190", price = 88400},
                    {name = "btype3", price = 110500},
                    {name = "mamba", price = 112200},
                    {name = "weevil", price = 46700},
                    {name = "btype2", price = 119000},
                    {name = "feltzer3", price = 140400},
                    {name = "turismo2", price = 140400}
                },
                ["Velos"] = {
                    {name = "bmx", price = 245},
                    {name = "cruiser", price = 560},
                    {name = "fixter", price = 595},
                    {name = "scorcher", price = 700},
                    {name = "tribike", price = 1260},
                    {name = "tribike2", price = 1260},
                    {name = "tribike3", price = 1260}
                }
            }
        }
    },
    VehShop
)

function VehShop:CreateShops()
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
            "VehShop",
            i,
            RageUI.CreateMenu(nil, "Catégories disponibles", 10, 20, v.Menus.Sprite, v.Menus.Sprite)
        )
        Marker:Add(v.Pos, v.Marker)

        for k, v in pairs(v.Vehicles) do
            RMenu.Add("VehShop_sub", k, RageUI.CreateSubMenu(RMenu:Get("VehShop", i), nil, k))
        end
        RMenu.Add("VehShop_sub", "list", RageUI.CreateSubMenu(RMenu:Get("VehShop", i), nil, "Actions disponibles"))
        RMenu.Add(
            "VehShop_sub",
            "playerList",
            RageUI.CreateSubMenu(RMenu:Get("VehShop_sub", "list"), nil, "Listes des joueurs")
        )
        RMenu.Add(
            "VehShop_sub",
            "joblist",
            RageUI.CreateSubMenu(RMenu:Get("VehShop_sub", "list"), nil, "Listes des joueurs")
        )
        RMenu.Add(
            "VehShop_sub",
            "confirm",
            RageUI.CreateSubMenu(RMenu:Get("VehShop_sub", "list"), nil, "Confirmer")
        )
    end
end

local CurrentZone = nil

function VehShop.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard", "E", VehShop.Open, "VehShop")
    KeySettings:Add("controller", 46, VehShop.Open, "VehShop")
    CurrentZone = zone
end

function VehShop.ExitZone(zone)
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", "VehShop")
        KeySettings:Clear("controller", 46, "VehShop")
        Marker:Visible(VehShop[CurrentZone].Pos, true)
        VehShop.Close()
        CurrentZone = nil
    end
end

function VehShop.Open()
    RageUI.Visible(RMenu:Get("VehShop", CurrentZone), true)
    Marker:Visible(VehShop[CurrentZone].Pos, false)
end

function VehShop.Close()
    if RageUI.Visible(RMenu:Get("VehShop", CurrentZone)) then
        RageUI.Visible(RMenu:Get("VehShop", CurrentZone), false)
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
        VehShop[CurrentZone].Pos,
        69.34,
        function(veh)
            SetPedIntoVehicle(LocalPlayer().Ped, veh, -1)
            FreezeEntityPosition(veh, true)
            SetVehicleDoorsLocked(veh, 4)
            currentveh = veh
        end
    )
    --   SetEntityVisible(LocalPlayer().Ped, false)
    t = vehicleFct.GetVehiclesInArea(VehShop[CurrentZone].Pos, 4.0)

    for i = 1, #t, 1 do
        DeleteEntity(t[i])
    end
    RMenu:Get("VehShop", CurrentZone).Closed = function()
        --SetEntityVisible(LocalPlayer().Ped, true)
        local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
        if veh ~= nil then
            DeleteEntity(veh)
        end
        t = vehicleFct.GetVehiclesInArea(VehShop[CurrentZone].Pos, 4.0)
        Marker:Visible(VehShop[CurrentZone].Pos, true)
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
        VehShop:CreateShops()
        while true do
            Wait(1)
            if CurrentZone ~= nil then
                if RageUI.Visible(RMenu:Get("VehShop", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            for k, v in pairs(VehShop[CurrentZone].Vehicles) do
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
                                    RMenu:Get("VehShop_sub", k)
                                )
                            end
                        end,
                        function()
                        end
                    )
                else
                    --[[ if RageUI.Visible(RMenu:Get("VehShop_sub", "playerList")) then
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
                                                        if (amount - amountVeh >= 0) then
                                                            local veh = Atlantiss.World.Vehicle:GetVehicleCustoms(GetVehiclePedIsIn(LocalPlayer().Ped))

                                                            TriggerServerCallback(
                                                                "vehicleshop:BuyVehicle",
                                                                function(_, plate)
                                                                    TriggerServerEvent(
                                                                        "Atlantiss::SE::Jobs:Jetsam:Order",
                                                                        {
                                                                            plate = plate,
                                                                            customs = veh
                                                                        },
                                                                        Atlantiss.Identity:GetMyUuid(),
                                                                        "concess"
                                                                    )

                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                    TriggerServerEvent(
                                                                        "banking:removeAmountFromAccount",
                                                                        "concess",
                                                                        amountVeh
                                                                    )

                                                                    RageUI.Popup({message = "~g~Commande effectuée !"})
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
                                                    "concess"
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
                    if RageUI.Visible(RMenu:Get("VehShop_sub", "joblist")) then
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
                                                        if (amount - amountVeh >= 0) then
                                                            local veh = Atlantiss.World.Vehicle:GetVehicleCustoms(GetVehiclePedIsIn(LocalPlayer().Ped))

                                                            TriggerServerCallback(
                                                                "vehicleshop:BuyVehicle",
                                                                function(_, plate)
                                                                    TriggerServerEvent(
                                                                        "Atlantiss::SE::Jobs:Jetsam:Order",
                                                                        {
                                                                            plate = plate,
                                                                            customs = veh
                                                                        },
                                                                        Atlantiss.Identity:GetMyUuid(),
                                                                        "concess"
                                                                    )

                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                    TriggerServerEvent(
                                                                        "banking:removeAmountFromAccount",
                                                                        "concess",
                                                                        amountVeh
                                                                    )

                                                                    RageUI.Popup({message = "~g~Commande effectuée !"})
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
                                                    "concess"
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
                    
                    if (RageUI.Visible(RMenu:Get("VehShop_sub", "confirm"))) then
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
                                                                        "vehicleshop:BuyVehicle",
                                                                        function(_, plate)
                                                                            TriggerServerEvent(
                                                                                "Atlantiss::SE::Jobs:Jetsam:Order",
                                                                                {
                                                                                    plate = plate,
                                                                                    customs = veh
                                                                                },
                                                                                Atlantiss.Identity:GetMyUuid(),
                                                                                "concess"
                                                                            )
                    
                                                                            CloseAllMenus()
                                                                            DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                            TriggerServerEvent(
                                                                                "banking:removeAmountFromAccount",
                                                                                "concess",
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
                                                            "concess"
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

                    if RageUI.Visible(RMenu:Get("VehShop_sub", "list")) then
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
                                    RMenu:Get("VehShop_sub", "playerList")
                                )

                                RageUI.Button(
                                    "Métiers",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("VehShop_sub", "joblist")
                                ) ]]

                                RageUI.Button(
                                    "Acheter",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("VehShop_sub", "confirm")
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
                                            spawnedVehicle = Atlantiss.World.Vehicle:Create(veh.model, VehShop[CurrentZone].SpawnPos, VehShop[CurrentZone].SpawnPos.h, {})
                                            Atlantiss.World.Vehicle:ApplyCustomsToVehicle(spawnedVehicle, veh)
                                            SetVehicleNumberPlateText(spawnedVehicle, "CONCESS") 
                                            DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                            SetPedIntoVehicle(LocalPlayer().Ped, spawnedVehicle, -1)
                                        end
                                    end
                                )
                            end,
                            function()
                            end
                        )
                    end
                    for k, v in pairs(VehShop[CurrentZone].Vehicles) do
                        if RageUI.Visible(RMenu:Get("VehShop_sub", k)) then
                            RageUI.DrawContent(
                                {header = true, glare = false},
                                function()
                                    for i = 1, #v, 1 do
                                        p = "~r~MASQUÉ"
                                        if Atlantiss.Identity:HasAnyJob("concess") then
                                            p = v[i].price .. "$"
                                        end
                                        RageUI.Button(
                                            GetLabelText(GetDisplayNameFromVehicleModel(v[i].name)),
                                            nil,
                                            {RightLabel = p},
                                            true,
                                            function(_, Active, Selected)
                                                if Atlantiss.Identity:HasAnyJob("concess") then
                                                    menu = RMenu:Get("VehShop_sub", "list")
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
                                                    if Atlantiss.Identity:HasAnyJob("concess") then
                                                        amountVeh = v[i].price
                                                        menu = RMenu:Get("VehShop_sub", "list")
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
