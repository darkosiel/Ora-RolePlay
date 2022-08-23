local autojap =
    setmetatable(
    {
        --veh
        {
            Pos = {x = 977.1851, y = -2398.0607, z = 21.32, a = 183.5447},
            SpawnPos = {x = 977.8609, y = -2387.9807, z = 21.71, a = 87.0860},
            Blips = {},
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
                ["Véhicule"] = {
                    {name = "primo3", price = 9000},
                    {name = "altior", price = 10000},
                    {name = "doubled", price = 45000},
                    {name = "dubsta22", price = 40000},
                    {name = "dubstaenus", price = 50000},
                    {name = "elegyrh7", price = 115000},
                    {name = "gauntlets", price = 60000},
                    {name = "oracleta", price = 30000},
                    {name = "oraclestd", price = 30000},
                    {name = "scheisser", price = 50000},
                    {name = "sentinelsg3a2", price = 35000},
                    {name = "sentinelsg3b2", price = 35000},
                    {name = "sentinelsg3c2", price = 30000},
                    {name = "sentinelsg32", price = 37000},
                    {name = "sigma2", price = 90000},
                    {name = "patriots", price = 65000},
                    {name = "stratumc", price = 40000},
                    {name = "sunrise1", price = 130000},
                    {name = "tampar", price = 55000},
                    {name = "buffaloac", price = 25000}
                }
            }
        }
    },
    autojap
)

function autojap:CreateShops()
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
            "autojap",
            i,
            RageUI.CreateMenu(nil, "Catégories disponibles", 10, 20, v.Menus.Sprite, v.Menus.Sprite)
        )
        Marker:Add(v.Pos, v.Marker)

        for k, v in pairs(v.Vehicles) do
            RMenu.Add("autojap_sub", k, RageUI.CreateSubMenu(RMenu:Get("autojap", i), nil, k))
        end
        RMenu.Add("autojap_sub", "list", RageUI.CreateSubMenu(RMenu:Get("autojap", i), nil, "Actions disponibles"))
        RMenu.Add(
            "autojap_sub",
            "playerList",
            RageUI.CreateSubMenu(RMenu:Get("autojap_sub", "list"), nil, "Listes des joueurs")
        )
        RMenu.Add(
            "autojap_sub",
            "joblist",
            RageUI.CreateSubMenu(RMenu:Get("autojap_sub", "list"), nil, "Listes des joueurs")
        )
        RMenu.Add(
            "autojap_sub",
            "confirm",
            RageUI.CreateSubMenu(RMenu:Get("autojap_sub", "list"), nil, "Confirmer")
        )
    end
end

local CurrentZone = nil

function autojap.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard", "E", autojap.Open, "autojap")
    KeySettings:Add("controller", 46, autojap.Open, "autojap")
    CurrentZone = zone
end

function autojap.ExitZone(zone)
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", "autojap")
        KeySettings:Clear("controller", 46, "autojap")
        Marker:Visible(autojap[CurrentZone].Pos, true)
        autojap.Close()
        CurrentZone = nil
    end
end

function autojap.Open()
    RageUI.Visible(RMenu:Get("autojap", CurrentZone), true)
    Marker:Visible(autojap[CurrentZone].Pos, false)
end

function autojap.Close()
    if RageUI.Visible(RMenu:Get("autojap", CurrentZone)) then
        RageUI.Visible(RMenu:Get("autojap", CurrentZone), false)
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
        autojap[CurrentZone].Pos,
        autojap[CurrentZone].Pos.a,
        function(veh)
            SetPedIntoVehicle(LocalPlayer().Ped, veh, -1)
            FreezeEntityPosition(veh, true)
            SetVehicleDoorsLocked(veh, 4)
            currentveh = veh
        end
    )
    t = vehicleFct.GetVehiclesInArea(autojap[CurrentZone].Pos, 8.0)

    for i = 1, #t, 1 do
        DeleteEntity(t[i])
    end
    RMenu:Get("autojap", CurrentZone).Closed = function()
        local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
        if veh ~= nil then
            DeleteEntity(veh)
        end
        t = vehicleFct.GetVehiclesInArea(autojap[CurrentZone].Pos, 8.0)
        Marker:Visible(autojap[CurrentZone].Pos, true)
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
        autojap:CreateShops()
        while true do
            Wait(1)
            if CurrentZone ~= nil then
                if RageUI.Visible(RMenu:Get("autojap", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            for k, v in pairs(autojap[CurrentZone].Vehicles) do
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
                                    RMenu:Get("autojap_sub", k)
                                )
                            end
                        end,
                        function()
                        end
                    )
                else
                    if RageUI.Visible(RMenu:Get("autojap_sub", "playerList")) then
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
                                                                "autojap:BuyVehicle",
                                                                function(bool, plate)
                                                                    local spawnedVehicle = nil
                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                    if bool then
                                                                        TriggerServerEvent(
                                                                            "banking:removeAmountFromAccount",
                                                                            "autojap",
                                                                            amountVeh
                                                                        )
                                                                        spawnedVehicle = Ora.World.Vehicle:Create(veh.model, autojap[CurrentZone].SpawnPos, autojap[CurrentZone].SpawnPos.h, {})
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
                                                    "autojap"
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
                    if RageUI.Visible(RMenu:Get("autojap_sub", "joblist")) then
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
                                                                "autojap:BuyVehicleForCompany",
                                                                function(bool, plate)
                                                                    spawnedVehicle = nil
                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                    if bool then
                                                                        TriggerServerEvent(
                                                                            "banking:removeAmountFromAccount",
                                                                            "autojap",
                                                                            amountVeh
                                                                        )
                                                                        spawnedVehicle = Ora.World.Vehicle:Create(veh.model, autojap[CurrentZone].SpawnPos, autojap[CurrentZone].SpawnPos.h, {})
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
                                                    "autojap"
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

                    if RageUI.Visible(RMenu:Get("autojap_sub", "list")) then
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
                                    RMenu:Get("autojap_sub", "playerList")
                                )

                                RageUI.Button(
                                    "Métiers",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("autojap_sub", "joblist")
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
                                            spawnedVehicle = Ora.World.Vehicle:Create(veh.model, autojap[CurrentZone].SpawnPos, autojap[CurrentZone].SpawnPos.h, {})
                                            Ora.World.Vehicle:ApplyCustomsToVehicle(spawnedVehicle, veh)
                                            SetVehicleNumberPlateText(spawnedVehicle, "CONCESS") 
                                            DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                            --SetPedIntoVehicle(LocalPlayer().Ped, _veh, -1)
                                            SetVehicleDirtLevel(spawnedVehicle, 0.0)
                                        end
                                    end
                                )
                            end,
                            function()
                            end
                        )
                    end
                    for k, v in pairs(autojap[CurrentZone].Vehicles) do
                        if RageUI.Visible(RMenu:Get("autojap_sub", k)) then
                            RageUI.DrawContent(
                                {header = true, glare = false},
                                function()
                                    for i = 1, #v, 1 do
                                        p = "~r~MASQUÉ"
                                        if Ora.Identity:HasAnyJob("autojap") then
                                            p = v[i].price .. "$"
                                        end
                                        RageUI.Button(
                                            GetLabelText(GetDisplayNameFromVehicleModel(v[i].name)),
                                            nil,
                                            {RightLabel = p},
                                            true,
                                            function(_, Active, Selected)
                                                if Ora.Identity:HasAnyJob("autojap") then
                                                    menu = RMenu:Get("autojap_sub", "list")
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
                                                    if Ora.Identity:HasAnyJob("autojap") then
                                                        amountVeh = v[i].price
                                                        menu = RMenu:Get("autojap_sub", "list")
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
