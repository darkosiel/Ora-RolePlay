RegisterNetEvent("core:teleport")
AddEventHandler(
    "core:teleport",
    function(pos)
        pos.x = pos.x + 0.0
        pos.y = pos.y + 0.0
        pos.z = pos.z + 0.0

        RequestCollisionAtCoord(pos.x, pos.y, pos.z)

        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
            RequestCollisionAtCoord(pos.x, pos.y, pos.z)
            Citizen.Wait(1)
        end

        SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
    end
)

local commands = {
    {
        text = "giveitem",
        fct = function(args)
            if tonumber(args[3]) == nil then
                return ShowNotification("~r~Nombre invalide")
            end

            local sendItems = {}
            local itemSent = 0

            if (Items[args[2]] ~= nil and Items[args[2]].label ~= nil) then
                TriggerPlayerEvent(
                    "RageUI:Popup",
                    args[1],
                    {
                        message = "~r~~h~ADMIN~h~~s~\n~g~Vous avez reçu " ..
                            args[3] .. "x " .. Items[args[2]].label .. "~s~"
                    }
                )

                ShowNotification(
                    "~r~~h~ADMIN~h~~s~\n~g~Vous avez envoyé " .. args[3] .. "x " .. Items[args[2]].label .. "~s~"
                )
            end

            for i = 1, args[3], 1 do
                itemSent = itemSent + 1
                table.insert(sendItems, {name = args[2]})

                if (itemSent >= 150) then
                    math.randomseed(GetGameTimer())
                    TriggerPlayerEvent("Ora::CE::Inventory:AddItems", args[1], sendItems)
                    sendItems = {}
                    itemSent = 0
                    Wait(100)
                end
            end

            if (itemSent > 0) then
                TriggerPlayerEvent("Ora::CE::Inventory:AddItems", args[1], sendItems)
                sendItems = {}
                itemSent = 0
            end
        end
    },
    {
        text = "car",
        fct = function(args)
            local ModelName = args[1]
            TriggerServerCallback("Ora::SE::Anticheat:RegisterVehicle", 
                function()
                    vehicle = Ora.World.Vehicle:Create(ModelName, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), {customs = {}, warp_into_vehicle = true, maxFuel = true, health = {}})
                end,
                GetHashKey(ModelName)
            )
        end
    },
    {
        text = "setjob",
        fct = function(args)
            TriggerServerEvent("Ora::SE::Identity:Job:Save", args[2], args[3], args[1])
            TriggerPlayerEvent("Ora::CE::Identity:Job:Set", args[1], args[2], args[3])
        end
    },
    {
        text = "clear",
        fct = function()
            TriggerServerEvent('chat:clearall')
        end
    },
    {
        text = "tp",
        fct = function(args)
            for i = 1, #args, 1 do
                args[i] = tonumber(args[i])
            end
            TriggerEvent("core:teleport", {x = args[1], y = args[2], z = args[3]})
        end
    },
    {
        text = "dv",
        fct = function(args)
            if IsPedInAnyVehicle(LocalPlayer().Ped) then
                DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
            else
                if ClosestVeh() ~= 0 then
                    DeleteEntity(ClosestVeh())
                end
            end
        end
    },
    {
        text = "startCooperScenario",
        fct = function(args)
            TriggerEvent("startCooperScenario")
        end
    },
    {
        text = "stopCooperScenario",
        fct = function(args)
            TriggerEvent("stopCooperScenario")
        end
    },
    {
        text = "revive",
        fct = function(args)
            TriggerPlayerEvent("player:Revive", args[1])
        end
    },
    {
        text = "heal",
        fct = function(args)
            TriggerPlayerEvent("player:Heal", args[1])
        end
    }
}

Citizen.CreateThread(
    function()
        for i = 1, #commands, 1 do
            if Ora.Identity:GetMyGroup() == "superadmin" then
                RegisterCommand(
                    commands[i].text,
                    function(_, args)
                        commands[i].fct(args)
                    end
                )
            end
        end
    end
)

RegisterCommand(
    "report",
    function(_, args)
        TriggerServerEvent(
            "Ora:sendToDiscord",
            13,
            table.concat(args, " "),
            "error"
        )

        TriggerServerEvent("addReportMenuS", table.concat(args, " "), Ora.Identity.Job:Get(), Ora.Identity.Orga:Get())
        TriggerEvent(
            "RageUI:Popup",
            {
                message = "(~r~REPORT~w~)\nVotre message a bien été envoyé aux modérateurs."
            }
        )
    end
)
