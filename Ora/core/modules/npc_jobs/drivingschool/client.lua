-- Ora.NpcJobs.DrivingSchool.CurrentZone = nil
-- Ora.NpcJobs.DrivingSchool.Blip = nil
-- Ora.NpcJobs.DrivingSchool.CurrentVehicle = nil
-- Ora.NpcJobs.DrivingSchool.AlreadyCreated = false
-- Ora.NpcJobs.DrivingSchool.Config = {
--     ["start"] = {x = 221.49, y = 370.27, z = 105.27, a = 72.21}, -- pos ped
--     ["end"] = {x = 235.24, y = -1509.56, z = 28.65},
--     price = 200
-- }


-- RegisterNetEvent("Ora::CE::NpcJobs:DrivingSchool::SetDB")
-- AddEventHandler(
-- 	"Ora::CE::NpcJobs:DrivingSchool::SetDB",
-- 	function(bool)
-- 		TriggerServerEvent("Ora::SE::NpcJobs:DrivingSchool::SetDB", bool)
-- 	end
-- )

-- RegisterNetEvent("Ora::CE::NpcJobs:DrivingSchool::Enable")
-- AddEventHandler(
-- 	"Ora::CE::NpcJobs:DrivingSchool::Enable",
-- 	function()
-- 		Ora.NpcJobs.DrivingSchool.Create()
-- 	end
-- )


-- local function Enter(arg)
--     if arg == "start" then
--         Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour commencer le test ~r~(200$)")
--         KeySettings:Add("keyboard", "E", Ora.NpcJobs.DrivingSchool.StartTest, "permis")
--         KeySettings:Add("controller", 46, Ora.NpcJobs.DrivingSchool.StartTest, "permis")
--         Ora.NpcJobs.DrivingSchool.CurrentZone = arg
--     else
--         if Ora.NpcJobs.DrivingSchool.CurrentVehicle ~= nil then
--             Ora.NpcJobs.DrivingSchool.FinishedWell()
--         end
--     end
-- end

-- local function Exit()
--     KeySettings:Clear("keyboard", "E", "permis")
--     KeySettings:Clear("controller", 46, "permis")
--     Hint:RemoveAll()
-- end


-- function Ora.NpcJobs.DrivingSchool.FinishedFailed(reason)
--     DeleteEntity(Ora.NpcJobs.DrivingSchool.CurrentVehicle)
--     Ora.NpcJobs.DrivingSchool.CurrentVehicle = nil
--     ClearAllBlipRoutes()
--     RemoveBlip(Ora.NpcJobs.DrivingSchool.Blip)
--     SetEntityCoordsNoOffset(LocalPlayer().Ped, 219.95, 371.27, 106.29, false, false, false, true)
--     RageUI.Popup({message = "~r~Vous avez échoué\n Raison : " .. reason})
-- end

-- function Ora.NpcJobs.DrivingSchool.FinishedWell()
--     DeleteEntity(Ora.NpcJobs.DrivingSchool.CurrentVehicle)
--     Ora.NpcJobs.DrivingSchool.CurrentVehicle = nil
--     ClearAllBlipRoutes()
--     RemoveBlip(Ora.NpcJobs.DrivingSchool.Blip)
--     SetEntityCoordsNoOffset(LocalPlayer().Ped, 219.95, 371.27, 106.29, false, false, false, true)
--     RageUI.Popup({message = "~g~Vous avez réussi votre test"})

--     TriggerEvent("Ora::CE::NpcJobs:DrivingSchool::SetDB", 1)

--     Ora.Inventory:AddItem({name = "permis-conduire", data = {points = 12, uid = "LS-" .. Random(99999999), identity = GetIdentity()}})
-- end

-- function Ora.NpcJobs.DrivingSchool.StartTest()
--     TriggerServerCallback(
--         "Ora::SE::NpcJobs:DrivingSchool::CanPass",
--         function(bool)
--             if (bool) then
--                 dataonWait = {
--                     title = "Permis de conduire",
--                     price = Ora.NpcJobs.DrivingSchool.Config.price,
--                     fct = function()
--                         coords = {x = 213.78, y = 390.19, z = 106.85, a = 173.14}
--                         local vehArea = vehicleFct.GetVehiclesInArea({x = coords.x, y = coords.y, z = coords.z}, 3.0)
                        
--                         if #vehArea ~= 0 then
--                             for i = 1, #vehArea, 1 do
--                                 DeleteVehicle(vehArea[i])
--                             end
--                         end

--                         vehicleFct.SpawnVehicle(
--                             "blista2",
--                             coords,
--                             235.32,
--                             function(vehicle)
--                               Ora.NpcJobs.DrivingSchool.CurrentVehicle = vehicle
--                               SetPedIntoVehicle(LocalPlayer().Ped, vehicle, -1)
--                               SetVehicleDoorsLocked(vehicle, 4)
--                               math.randomseed(GetGameTimer())
--                               SetVehicleNumberPlateText(vehicle, "PERMIS" .. math.random(1000, 9999))
--                             end
--                         )

--                         RageUI.Popup({message = "Conduisez jusqu'au point."})
--                         Wait(5)
--                         Ora.NpcJobs.DrivingSchool.Blip = AddBlipForCoord(235.24, -1509.56, 28.65)
--                         SetBlipSprite(Ora.NpcJobs.DrivingSchool.Blip, 1)
--                         SetBlipDisplay(Ora.NpcJobs.DrivingSchool.Blip, 4)
--                         SetBlipScale(Ora.NpcJobs.DrivingSchool.Blip, 1.0)
--                         SetBlipColour(Ora.NpcJobs.DrivingSchool.Blip, 81)
--                         SetBlipAsShortRange(Ora.NpcJobs.DrivingSchool.Blip, true)
--                         BeginTextCommandSetBlipName("STRING")
--                         AddTextComponentString("Destination")
--                         EndTextCommandSetBlipName(Ora.NpcJobs.DrivingSchool.Blip)
--                         SetBlipRouteColour(Ora.NpcJobs.DrivingSchool.Blip, 81)
--                         SetBlipRoute(Ora.NpcJobs.DrivingSchool.Blip, true)
--                         KeySettings:Clear("keyboard", "E", "permis")
--                         KeySettings:Clear("controller", 46, "permis")
--                         Hint:RemoveAll()
--                     end
--                 }

--                 TriggerEvent("payWith?")
--             else
--                 RageUI.Popup({message = "~r~Vous ne pouvez pas passer votre permis une énième fois."})
--                 RageUI.Popup({message = "~r~Voyez avec les forces de l'odre pour récupérer vos points/votre permis."})
--             end
--         end
--     )
-- end

-- function Ora.NpcJobs.DrivingSchool.Create()
-- 	if (Ora.NpcJobs.DrivingSchool.AlreadyCreated == true) then return end

--     local Pos = Ora.NpcJobs.DrivingSchool.Config["start"]
--     local blip = AddBlipForCoord(Pos.x, Pos.y, Pos.z)
--     SetBlipSprite(blip, 225)
--     SetBlipDisplay(blip, 4)
--     SetBlipScale(blip, 0.8)
--     SetBlipColour(blip, 84)
--     SetBlipAsShortRange(blip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString("Auto-école")
--     EndTextCommandSetBlipName(blip)

--     Zone:Add(Pos, Enter, Exit, "start", 2.5)
--     Ped:Add("David", "a_m_y_bevhills_01", Pos, nil)
--     Zone:Add(Ora.NpcJobs.DrivingSchool.Config["end"], Enter, Exit, "end", 2.5)
-- end


-- Citizen.CreateThread(
--     function()
-- 		while (Ora.Player.HasLoaded == false) do Wait(100) end

--         TriggerServerCallback(
--             "Ora::SE::NpcJobs:DrivingSchool::IsNPCEnabled",
--             function(isEnabled)
--                 if (isEnabled) then
--                     Ora.NpcJobs.DrivingSchool.Create()
--                     Ora.NpcJobs.DrivingSchool.AlreadyCreated = true
--                 end
--             end
--         )

-- 		local Pos = Ora.NpcJobs.DrivingSchool.Config["start"]
-- 		local blip = AddBlipForCoord(Pos.x, Pos.y, Pos.z)
-- 		SetBlipSprite(blip, 225)
-- 		SetBlipDisplay(blip, 4)
-- 		SetBlipScale(blip, 0.8)
-- 		SetBlipColour(blip, 84)
-- 		SetBlipAsShortRange(blip, true)
-- 		BeginTextCommandSetBlipName("STRING")
-- 		AddTextComponentString("Auto-école")
-- 		EndTextCommandSetBlipName(blip)

--         while true do
--             Wait(1000)

--             if Ora.NpcJobs.DrivingSchool.CurrentVehicle ~= nil then
--                 if GetVehicleBodyHealth(Ora.NpcJobs.DrivingSchool.CurrentVehicle) ~= 1000 then
--                     Ora.NpcJobs.DrivingSchool.FinishedFailed("~r~Vous avez endommagé le véhicule")
--                 end
--                 if GetEntitySpeed(Ora.NpcJobs.DrivingSchool.CurrentVehicle) * 3.6 > 100 then
--                     Ora.NpcJobs.DrivingSchool.FinishedFailed("~r~Excès de vitesse (" .. GetEntitySpeed(Ora.NpcJobs.DrivingSchool.CurrentVehicle) * 3.6 .. "km/h)")
--                 end
--             end
--         end

-- 		-- Reset de position débile en haut de la tour sur le spawn de base V2 du ped à la base militaire
--         --[[ Zone:Add(
--             {x = -2357.33, y = 3250.93, z = 106.05},
--             function()
--                 Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour reset votre position")
--                 KeySettings:Add(
--                     "keyboard",
--                     "E",
--                     function()
--                         SetEntityCoords(LocalPlayer().Ped, 0.0, 0.0, 0.0)
--                     end,
--                     "spawn"
--                 )
--                 KeySettings:Add("controller", 46, Ora.NpcJobs.DrivingSchool.StartTest, "spawn")
--             end,
--             function()
--                 KeySettings:Clear("keyboard", "E", "spawn")
--                 KeySettings:Clear("controller", 46, "spawn")
--                 Hint:RemoveAll()
--             end,
--             "posReset",
--             10.5
--         ) ]]
--     end
-- )
local CurrentZone = nil
local _blip = nil
local currentVehicle = nil
local Permis_config = {
    ["start"] = {x = 221.72, y = 372.58, z = 105.21, a = 73.27}, -- pos ped
    ["end"] = {x = 235.24, y = -1509.56, z = 28.65},
    price = 200
}

local function StopVehicule(reason)
    DeleteEntity(currentVehicle)
    currentVehicle = nil
    ClearAllBlipRoutes()
    RemoveBlip(_blip)
    SetEntityCoordsNoOffset(LocalPlayer().Ped, 219.95, 371.27, 106.29, false, false, false, true)
    RageUI.Popup({message = "~r~Vous avez échoué\n Raison : " .. reason})
end

local function StopVehicule2()
    DeleteEntity(currentVehicle)
    currentVehicle = nil
    ClearAllBlipRoutes()
    RemoveBlip(_blip)
    SetEntityCoordsNoOffset(LocalPlayer().Ped, 219.95, 371.27, 106.29, false, false, false, true)
    RageUI.Popup({message = "~g~Vous avez réussi votre test"})

    Ora.Inventory:AddItem({name = "permis-conduire", data = {points = 12, uid = "LS-" .. Random(99999999), identity = GetIdentity()}})
end

local function startTest()
    dataonWait = {
        detail = "Permis de conduire ",
        price = Permis_config.price,
        fct = function()
            coords = {x = 221.08856, y = 381.79013, z = 106.85, a = 161.9154052}
            vehicleFct.SpawnVehicle("blista2",
                coords,
                235.32,
                function(vehicle)
                    currentVehicle = vehicle
                    SetPedIntoVehicle(LocalPlayer().Ped, vehicle, -1)
                    SetVehicleDoorsLocked(vehicle, 4)
                    SetVehicleNumberPlateText(vehicle, "PERMIS")
                end
            )
            RageUI.Popup({message = "Conduisez jusqu'au point."})
            Wait(5)
            _blip = AddBlipForCoord(235.24, -1509.56, 28.65)
            SetBlipSprite(_blip, 1)
            SetBlipDisplay(_blip, 4)
            SetBlipScale(_blip, 0.8)
            SetBlipColour(_blip, 81)
            SetBlipAsShortRange(_blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Destination")
            EndTextCommandSetBlipName(_blip)
            SetBlipRouteColour(_blip, 81)
            SetBlipRoute(_blip, true)
            KeySettings:Clear("keyboard", "E", "permis")
            KeySettings:Clear("controller", 46, "permis")
            Hint:RemoveAll()
        end
    }

    TriggerEvent("payWith?")
end

local function Enter(z)
    if z == "start" then
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour commencer le test ~r~(200$)")
        KeySettings:Add("keyboard", "E", startTest, "permis")
        KeySettings:Add("controller", 46, startTest, "permis")
        CurrentZone = z
    else
        if currentVehicle ~= nil then
            StopVehicule2()
        end
    end
end

local function Exit(z)
    KeySettings:Clear("keyboard", "E", "permis")
    KeySettings:Clear("controller", 46, "permis")
    Hint:RemoveAll()
end
local function Create()
    local Pos = Permis_config["start"]
    local blip = AddBlipForCoord(Pos.x, Pos.y, Pos.z)
    SetBlipSprite(blip, 225)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 84)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Auto-école")
    EndTextCommandSetBlipName(blip)
    Zone:Add(Pos, Enter, Exit, "start", 2.5)
    Ped:Add("David", "a_m_y_bevhills_01", Pos, nil)
    Zone:Add(Permis_config["end"], Enter, Exit, "end", 2.5)
end

Citizen.CreateThread(
    function()
        Wait(30000)
        local pos = {x = -2357.33, y = 3250.93, z = 106.05}

        Zone:Add(
            pos,
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour reset votre position")
                KeySettings:Add("keyboard","E",
                    function()
                        SetEntityCoords(LocalPlayer().Ped, -1039.66, -2741.95, 20.0)
                    end,
                    "spawn"
                )
                KeySettings:Add("controller", 46, startTest, "spawn")
            end,
            function()
                KeySettings:Clear("keyboard", "E", "spawn")
                KeySettings:Clear("controller", 46, "spawn")
                Hint:RemoveAll()
            end,
            "posReset",
            10.5
        )
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(500)
            if currentVehicle ~= nil then
                if GetVehicleBodyHealth(currentVehicle) ~= 1000 then
                    StopVehicule("~r~Vous avez endommagé le véhicule")
                end
                if GetEntitySpeed(currentVehicle) * 3.6 > 100 then
                    StopVehicule("~r~Excès de vitesse (" .. GetEntitySpeed(currentVehicle) * 3.6 .. "km/h)")
                end
            end
        end
    end
)
Create()
