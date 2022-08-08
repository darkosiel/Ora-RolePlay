local bikershop =
    setmetatable(
    {
        --veh
        {
            Pos = {x = 258.1, y = -1154.86, z = 28.29, a = 87.99},
            SpawnPos = {x = 275.31, y = -1159.71, z = 28.24, a = 86.11},
            Blips = {
                sprite = 226,
                color = 84,
                name = "Concessionnaire moto"
            },
            Menus = {
                Sprite = "shopui_title_ie_modgarage",
                Enabled = false
            },
            Marker = {
                type = 23,
                scale = {x = 1.5, y = 1.5, z = 0.2},
                color = {r = 255, g = 255, b = 255, a = 120},
                Up = false,
                Cam = false,
                Rotate = false,
                visible = false
            },
            Vehicles = {
                ["Motos"] = {
                    {name = "akuma", price = 8200},
                    {name = "avarus", price = 7500},
                    {name = "bagger", price = 10100},
                    {name = "bati", price = 9000},
                    {name = "bati2", price = 10800},
                    {name = "bf400", price = 5600},
                    {name = "carbonrs", price = 9000},
                    {name = "chimera", price = 17000},
                    {name = "cliffhanger", price = 6400},
                    {name = "daemon", price = 2600},
                    {name = "daemon2", price = 3000},
                    {name = "diablous", price = 7500},
                    {name = "diablous2", price = 7900},
                    {name = "defiler", price = 5000},
                    {name = "double", price = 9000},
                    {name = "enduro", price = 3000},
                    {name = "esskey", price = 2400},
                    {name = "fcr", price = 2100},
                    {name = "fcr2", price = 2100},
                    {name = "faggio", price = 1000},
                    {name = "faggio2", price = 2200},
                    {name = "faggio3", price = 1800},
                    {name = "gargoyle", price = 7500},
                    {name = "hakuchou", price = 10500},
                    {name = "hakuchou2", price = 25000},
                    {name = "hexer", price = 4800},
                    {name = "innovation", price = 8000},
                    {name = "lectro", price = 3300},
                    {name = "nemesis", price = 3000},
                    {name = "nightblade", price = 8600},
                    {name = "manchez", price = 3000},
                    {name = "manchez2", price = 3500},
                    {name = "pcj", price = 1800},
                    {name = "ratbike", price = 2700},
                    {name = "ruffian", price = 2400},
                    {name = "sanchez", price = 2100},
                    {name = "sanchez2", price = 2400},
                    {name = "sanctus", price = 4450},
                    {name = "sovereign", price = 10100},
                    {name = "thrust", price = 9000},
                    {name = "vader", price = 3000},
                    {name = "vindicator", price = 9000},
                    {name = "vortex", price = 4500},
                    {name = "wolfsbane", price = 4200},
                    {name = "zombiea", price = 4000},
                    {name = "zombieb", price = 4700},
                    {name = "reever", price = 8000},
                    {name = "shinobi", price = 12000}
                },
                ["Motos Biker"] = {
                    {name = "foxharley2", price = 15000},
                    --{name = "hvrod", price = 15000},
                    --{name = "na252", price = 15000},
                    {name = "dyna", price = 15000},
                    {name = "dyne", price = 15000},
                    {name = "softail1", price = 15000},
                    {name = "na25", price = 15000},
                    {name = "lv", price = 15000},
                    {name = "rk2019", price = 15000},
                    {name = "softail2", price = 15000},
                    {name = "indian", price = 15000},
                    {name = "acknodlow", price = 15000}
                   -- {name = "scout", price = 15000}
                },
                ["Quad"] = {
                    {name = "blazer", price = 2700},
                    {name = "blazer2", price = 2000},
                    {name = "blazer3", price = 6100},
                    {name = "blazer4", price = 4500},
                    {name = "verus", price = 5500}
                },
                ["Police"] = {
                    {name = "lspdb", price = 25000}
                    --{name = "sheriffb3", price = 2500}
                },
                ["Velo"] = {
                    {name = "bmx", price = 70},
                    {name = "cruiser", price = 28},
                    {name = "fixter", price = 140},
                    {name = "scorcher", price = 105},
                    {name = "tribike", price = 175},
                    {name = "tribike2", price = 175},
                    {name = "tribike3", price = 175}
                }
            }
        }
    },
    bikershop
)

function bikershop:CreateShops()
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
            "bikershop",
            i,
            RageUI.CreateMenu(nil, "Catégories disponibles", 10, 20, v.Menus.Sprite, v.Menus.Sprite)
        )
        Marker:Add(v.Pos, v.Marker)

        for k, v in pairs(v.Vehicles) do
            RMenu.Add("bikershop_sub", k, RageUI.CreateSubMenu(RMenu:Get("bikershop", i), nil, k))
        end
        RMenu.Add("bikershop_sub", "list", RageUI.CreateSubMenu(RMenu:Get("bikershop", i), nil, "Actions disponibles"))
        RMenu.Add(
            "bikershop_sub",
            "playerList",
            RageUI.CreateSubMenu(RMenu:Get("bikershop_sub", "list"), nil, "Listes des joueurs")
        )
        RMenu.Add(
            "bikershop_sub",
            "joblist",
            RageUI.CreateSubMenu(RMenu:Get("bikershop_sub", "list"), nil, "Listes des joueurs")
        )
        RMenu.Add(
            "bikershop_sub",
            "confirm",
            RageUI.CreateSubMenu(RMenu:Get("bikershop_sub", "list"), nil, "Confirmer")
        )
    end
end

local CurrentZone = nil

function bikershop.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard", "E", bikershop.Open, "bikershop")
    KeySettings:Add("controller", 46, bikershop.Open, "bikershop")
    CurrentZone = zone
end

function bikershop.ExitZone(zone)
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", "bikershop")
        KeySettings:Clear("controller", 46, "bikershop")
        Marker:Visible(bikershop[CurrentZone].Pos, true)
        bikershop.Close()
        CurrentZone = nil
    end
end

function bikershop.Open()
    RageUI.Visible(RMenu:Get("bikershop", CurrentZone), true)
    Marker:Visible(bikershop[CurrentZone].Pos, false)
end

function bikershop.Close()
    if RageUI.Visible(RMenu:Get("bikershop", CurrentZone)) then
        RageUI.Visible(RMenu:Get("bikershop", CurrentZone), false)
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
        bikershop[CurrentZone].Pos,
        bikershop[CurrentZone].Pos.a,
        function(veh)
            SetPedIntoVehicle(LocalPlayer().Ped, veh, -1)
            FreezeEntityPosition(veh, true)
            SetVehicleDoorsLocked(veh, 4)
            currentveh = veh
        end
    )
    t = vehicleFct.GetVehiclesInArea(bikershop[CurrentZone].Pos, 8.0)

    for i = 1, #t, 1 do
        DeleteEntity(t[i])
    end
    RMenu:Get("bikershop", CurrentZone).Closed = function()
        local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
        if veh ~= nil then
            DeleteEntity(veh)
        end
        t = vehicleFct.GetVehiclesInArea(bikershop[CurrentZone].Pos, 8.0)
        Marker:Visible(bikershop[CurrentZone].Pos, true)
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
        bikershop:CreateShops()
        while true do
            Wait(1)
            if CurrentZone ~= nil then
                if RageUI.Visible(RMenu:Get("bikershop", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            for k, v in pairs(bikershop[CurrentZone].Vehicles) do
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
                                    RMenu:Get("bikershop_sub", k)
                                )
                            end
                        end,
                        function()
                        end
                    )
                else
                    if RageUI.Visible(RMenu:Get("bikershop_sub", "playerList")) then
                        RageUI.DrawContent(
                            {header = true, glare = false},
                            function()
                                for k, v in pairs(GetActivePlayers()) do
                                    local i = v
                                    RageUI.Button(
                                        Ora.Identity:GetFullname(GetPlayerServerId(i)),
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
                                                            local veh = Ora.World.Vehicle:GetVehicleCustoms(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                            
                                                            TriggerServerCallback(
                                                                "bikershop:BuyVehicle",
                                                                function(bool, plate)
                                                                    local spawnedVehicle = nil
                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                    if bool then
                                                                        TriggerServerEvent(
                                                                            "banking:removeAmountFromAccount",
                                                                            "bikershop",
                                                                            amountVeh
                                                                        )
                                                                        spawnedVehicle = Ora.World.Vehicle:Create(veh.model, bikershop[CurrentZone].SpawnPos, bikershop[CurrentZone].SpawnPos.h, {})
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
                                                                    Ora.Inventory:AddItem(items)
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
                                                    "bikershop"
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
                    if RageUI.Visible(RMenu:Get("bikershop_sub", "joblist")) then
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
                                                            local veh = Ora.World.Vehicle:GetVehicleCustoms(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                            

                                                            TriggerServerCallback(
                                                                "bikershop:BuyVehicleForCompany",
                                                                function(bool, plate)
                                                                    spawnedVehicle = nil
                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                    if bool then
                                                                        TriggerServerEvent(
                                                                            "banking:removeAmountFromAccount",
                                                                            "bikershop",
                                                                            amountVeh
                                                                        )
                                                                        spawnedVehicle = Ora.World.Vehicle:Create(veh.model, bikershop[CurrentZone].SpawnPos, bikershop[CurrentZone].SpawnPos.h, {})
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
                                                                    Ora.Inventory:AddItem(items)
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
                                                    "bikershop"
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

                    if RageUI.Visible(RMenu:Get("bikershop_sub", "list")) then
                        RageUI.DrawContent(
                            {header = true, glare = false},
                            function()
                                RageUI.Button(
                                    "Joueurs",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("bikershop_sub", "playerList")
                                )

                                RageUI.Button(
                                    "Métiers",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("bikershop_sub", "joblist")
                                )

                                RageUI.Button(
                                    "Sortir le véhicule",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                        if Selected then
                                            CloseAllMenus()
                                            
                                            local veh = Ora.World.Vehicle:GetVehicleCustoms(GetVehiclePedIsIn(LocalPlayer().Ped))
                                            spawnedVehicle = Ora.World.Vehicle:Create(veh.model, bikershop[CurrentZone].SpawnPos, bikershop[CurrentZone].SpawnPos.h, {})
                                            Ora.World.Vehicle:ApplyCustomsToVehicle(spawnedVehicle, veh)
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
                    for k, v in pairs(bikershop[CurrentZone].Vehicles) do
                        if RageUI.Visible(RMenu:Get("bikershop_sub", k)) then
                            RageUI.DrawContent(
                                {header = true, glare = false},
                                function()
                                    for i = 1, #v, 1 do
                                        p = "~r~MASQUÉ"
                                        if Ora.Identity:HasAnyJob("bikershop") then
                                            p = v[i].price .. "$"
                                        end
                                        RageUI.Button(
                                            GetLabelText(GetDisplayNameFromVehicleModel(v[i].name)),
                                            nil,
                                            {RightLabel = p},
                                            true,
                                            function(_, Active, Selected)
                                                if Ora.Identity:HasAnyJob("bikershop") then
                                                    menu = RMenu:Get("bikershop_sub", "list")
                                                else
                                                    menu = nil
                                                end
                                                if Active then
                                                            Citizen.CreateThread(function()
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
                                                      end)
                                                end

                                                if Selected then
                                                    if Ora.Identity:HasAnyJob("bikershop") then
                                                        amountVeh = v[i].price
                                                        menu = RMenu:Get("bikershop_sub", "list")
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
