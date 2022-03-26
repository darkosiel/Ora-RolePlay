Atlantiss.NpcJobs.DrivingSchool.CurrentZone = nil
Atlantiss.NpcJobs.DrivingSchool.Blip = nil
Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle = nil
Atlantiss.NpcJobs.DrivingSchool.AlreadyCreated = false
Atlantiss.NpcJobs.DrivingSchool.Config = {
    ["start"] = {x = 221.49, y = 370.27, z = 105.27, a = 72.21}, -- pos ped
    ["end"] = {x = 235.24, y = -1509.56, z = 28.65},
    price = 200
}


RegisterNetEvent("Atlantiss::CE::NpcJobs:DrivingSchool::SetDB")
AddEventHandler(
	"Atlantiss::CE::NpcJobs:DrivingSchool::SetDB",
	function(bool)
		TriggerServerEvent("Atlantiss::SE::NpcJobs:DrivingSchool::SetDB", bool)
	end
)

RegisterNetEvent("Atlantiss::CE::NpcJobs:DrivingSchool::Enable")
AddEventHandler(
	"Atlantiss::CE::NpcJobs:DrivingSchool::Enable",
	function()
		Atlantiss.NpcJobs.DrivingSchool.Create()
	end
)


local function Enter(arg)
    if arg == "start" then
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour commencer le test ~r~(200$)")
        KeySettings:Add("keyboard", "E", Atlantiss.NpcJobs.DrivingSchool.StartTest, "permis")
        KeySettings:Add("controller", 46, Atlantiss.NpcJobs.DrivingSchool.StartTest, "permis")
        Atlantiss.NpcJobs.DrivingSchool.CurrentZone = arg
    else
        if Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle ~= nil then
            Atlantiss.NpcJobs.DrivingSchool.FinishedWell()
        end
    end
end

local function Exit()
    KeySettings:Clear("keyboard", "E", "permis")
    KeySettings:Clear("controller", 46, "permis")
    Hint:RemoveAll()
end


function Atlantiss.NpcJobs.DrivingSchool.FinishedFailed(reason)
    DeleteEntity(Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle)
    Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle = nil
    ClearAllBlipRoutes()
    RemoveBlip(Atlantiss.NpcJobs.DrivingSchool.Blip)
    SetEntityCoordsNoOffset(LocalPlayer().Ped, 219.95, 371.27, 106.29, false, false, false, true)
    RageUI.Popup({message = "~r~Vous avez échoué\n Raison : " .. reason})
end

function Atlantiss.NpcJobs.DrivingSchool.FinishedWell()
    DeleteEntity(Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle)
    Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle = nil
    ClearAllBlipRoutes()
    RemoveBlip(Atlantiss.NpcJobs.DrivingSchool.Blip)
    SetEntityCoordsNoOffset(LocalPlayer().Ped, 219.95, 371.27, 106.29, false, false, false, true)
    RageUI.Popup({message = "~g~Vous avez réussi votre test"})

    TriggerEvent("Atlantiss::CE::NpcJobs:DrivingSchool::SetDB", 1)

    Atlantiss.Inventory:AddItem({name = "permis-conduire", data = {points = 12, uid = "LS-" .. Random(99999999), identity = GetIdentity()}})
end

function Atlantiss.NpcJobs.DrivingSchool.StartTest()
    TriggerServerCallback(
        "Atlantiss::SE::NpcJobs:DrivingSchool::CanPass",
        function(bool)
            if (bool) then
                dataonWait = {
                    title = "Permis de conduire",
                    price = Atlantiss.NpcJobs.DrivingSchool.Config.price,
                    fct = function()
                        coords = {x = 213.78, y = 390.19, z = 106.85, a = 173.14}
                        local vehArea = vehicleFct.GetVehiclesInArea({x = coords.x, y = coords.y, z = coords.z}, 3.0)
                        
                        if #vehArea ~= 0 then
                            for i = 1, #vehArea, 1 do
                                DeleteVehicle(vehArea[i])
                            end
                        end

                        vehicleFct.SpawnVehicle(
                            "blista2",
                            coords,
                            235.32,
                            function(vehicle)
                              Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle = vehicle
                              SetPedIntoVehicle(LocalPlayer().Ped, vehicle, -1)
                              SetVehicleDoorsLocked(vehicle, 4)
                              math.randomseed(GetGameTimer())
                              SetVehicleNumberPlateText(vehicle, "PERMIS" .. math.random(1000, 9999))
                            end
                        )

                        RageUI.Popup({message = "Conduisez jusqu'au point."})
                        Wait(5)
                        Atlantiss.NpcJobs.DrivingSchool.Blip = AddBlipForCoord(235.24, -1509.56, 28.65)
                        SetBlipSprite(Atlantiss.NpcJobs.DrivingSchool.Blip, 1)
                        SetBlipDisplay(Atlantiss.NpcJobs.DrivingSchool.Blip, 4)
                        SetBlipScale(Atlantiss.NpcJobs.DrivingSchool.Blip, 1.0)
                        SetBlipColour(Atlantiss.NpcJobs.DrivingSchool.Blip, 81)
                        SetBlipAsShortRange(Atlantiss.NpcJobs.DrivingSchool.Blip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString("Destination")
                        EndTextCommandSetBlipName(Atlantiss.NpcJobs.DrivingSchool.Blip)
                        SetBlipRouteColour(Atlantiss.NpcJobs.DrivingSchool.Blip, 81)
                        SetBlipRoute(Atlantiss.NpcJobs.DrivingSchool.Blip, true)
                        KeySettings:Clear("keyboard", "E", "permis")
                        KeySettings:Clear("controller", 46, "permis")
                        Hint:RemoveAll()
                    end
                }

                TriggerEvent("payWith?")
            else
                RageUI.Popup({message = "~r~Vous ne pouvez pas passer votre permis une énième fois."})
                RageUI.Popup({message = "~r~Voyez avec les forces de l'odre pour récupérer vos points/votre permis."})
            end
        end
    )
end

function Atlantiss.NpcJobs.DrivingSchool.Create()
	if (Atlantiss.NpcJobs.DrivingSchool.AlreadyCreated == true) then return end

    local Pos = Atlantiss.NpcJobs.DrivingSchool.Config["start"]
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
    Zone:Add(Atlantiss.NpcJobs.DrivingSchool.Config["end"], Enter, Exit, "end", 2.5)
end


Citizen.CreateThread(
    function()
		while (Atlantiss.Player.HasLoaded == false) do Wait(100) end

        TriggerServerCallback(
            "Atlantiss::SE::NpcJobs:DrivingSchool::IsNPCEnabled",
            function(isEnabled)
                if (isEnabled) then
                    Atlantiss.NpcJobs.DrivingSchool.Create()
                    Atlantiss.NpcJobs.DrivingSchool.AlreadyCreated = true
                end
            end
        )

		local Pos = Atlantiss.NpcJobs.DrivingSchool.Config["start"]
		local blip = AddBlipForCoord(Pos.x, Pos.y, Pos.z)
		SetBlipSprite(blip, 225)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 84)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Auto-école")
		EndTextCommandSetBlipName(blip)

        while true do
            Wait(1000)

            if Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle ~= nil then
                if GetVehicleBodyHealth(Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle) ~= 1000 then
                    Atlantiss.NpcJobs.DrivingSchool.FinishedFailed("~r~Vous avez endommagé le véhicule")
                end
                if GetEntitySpeed(Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle) * 3.6 > 100 then
                    Atlantiss.NpcJobs.DrivingSchool.FinishedFailed("~r~Excès de vitesse (" .. GetEntitySpeed(Atlantiss.NpcJobs.DrivingSchool.CurrentVehicle) * 3.6 .. "km/h)")
                end
            end
        end

		-- Reset de position débile en haut de la tour sur le spawn de base V2 du ped à la base militaire
        --[[ Zone:Add(
            {x = -2357.33, y = 3250.93, z = 106.05},
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour reset votre position")
                KeySettings:Add(
                    "keyboard",
                    "E",
                    function()
                        SetEntityCoords(LocalPlayer().Ped, 0.0, 0.0, 0.0)
                    end,
                    "spawn"
                )
                KeySettings:Add("controller", 46, Atlantiss.NpcJobs.DrivingSchool.StartTest, "spawn")
            end,
            function()
                KeySettings:Clear("keyboard", "E", "spawn")
                KeySettings:Clear("controller", 46, "spawn")
                Hint:RemoveAll()
            end,
            "posReset",
            10.5
        ) ]]
    end
)
