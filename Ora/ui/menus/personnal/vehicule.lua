RMenu.Add(
    "personnal",
    "vehicule",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "Véhicule", "Actions disponibles")
)
local pos = {
    {name = "Poste de police - Vespucci", pos = {x = -1072.52, y = -856.42, z = 4.87}},
    {name = "Hopital LS", pos = {x = -1858.35, y = -324.27, z = 53.77}},
    {name = "Gouvernement", pos = {x = -542.13, y = -209.36, z = 36.65}},
    {name = "Pacific Bank", pos = {x = 238.11, y = 196.64, z = 105.13}},
    {name = "Supprimer", pos = false}
}
local Ind = 1
local IndW = 1
local IndD = 1
local IndL = 1
local IndC = 1
local slideNameToBlip = {
    ["Superette"] = 52,
    ["ATM"] = 434,
    ["Station service"] = 361,
    ["Vêtements"] = 73,
    ["Barbier"] = 71,
    ["Armes"] = 313,
    ["Tatouages"] = 75
}
local windowsData = {}
local windowsDataLabel = {"Avant gauche", "Avant droite", "Arrière gauche", "Arrière droite"}
local doorDataLabel = {"Avant gauche", "Avant droite", "Arrière gauche", "Arrière droite", "Capot", "Coffre"}
local limiteDataLabel = {
    "Aucun",
    "30 km/h",
    "40 km/h",
    "50 km/h",
    "70 km/h",
    "80 km/h",
    "90 km/h",
    "110 km/h",
    "130 km/h",
    "150 km/h"
}
local cligno = {
    "Warnings",
    "Gauche",
    "Droite"
}
local clignoA = {
    warnings = false,
    left = false,
    right = false
}
local hydraulicMode = true

Citizen.CreateThread(
    function()
        local xPos = {}
        for i = 1, #pos, 1 do
            xPos[i] = pos[i].name
        end

        for k, v in pairs(slideNameToBlip) do
            table.insert(xPos, k)
            pos[#pos + 1] = {name = k, pos = v}
        end

        if #windowsData == 0 then
            for i = 0, 3 do
                windowsData[i] = true
            end
        end

        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("personnal", "vehicule")) then
                local veh = GetVehiclePedIsIn(PlayerPedId())
                if veh == 0 then
                    RageUI.GoBack()
                end

                RageUI.DrawContent(
                    {header = true, glare = true},
                    function()
                        RageUI.List(
                            "GPS Rapide",
                            xPos,
                            Ind,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                if Active then
                                    Ind = Index
                                end

                                if Selected then
                                    local plyPos = GetEntityCoords()
                                    local target = pos[Ind].pos
                                    if not target then
                                        ClearGpsPlayerWaypoint()
                                        SetNewWaypoint(GetEntityCoords(LocalPlayer().Ped))
                                        ShowAboveRadarMessage("~r~Marqueur supprimé.")
                                        return
                                    end
                                    if type(target) ~= "table" then
                                        local blip = GetFirstBlipInfoId(target)
                                        if blip == 0 or isSearching then
                                            return
                                        end

                                        Citizen.CreateThread(
                                            function()
                                                local nextBlip = blip
                                                isSearching = true
                                                while nextBlip ~= 0 do
                                                    Citizen.Wait(50)
                                                    if
                                                        GetDistanceBetweenCoords(plyPos, GetBlipCoords(nextBlip), true) <
                                                            GetDistanceBetweenCoords(plyPos, GetBlipCoords(blip), true)
                                                     then
                                                        blip = nextBlip
                                                    end
                                                    nextBlip = GetNextBlipInfoId(target)
                                                end

                                                isSearching = false
                                                SetNewWaypoint(GetBlipCoords(blip))
                                                ShowAboveRadarMessage(
                                                    "Vous avez placé un marqueur sur ~g~" ..
                                                        xPos[Ind] ..
                                                            "~w~ à ~g~" ..
                                                                math.floor(
                                                                    GetDistanceBetweenCoords(
                                                                        LocalPlayer().Pos,
                                                                        GetBlipCoords(blip),
                                                                        true
                                                                    )
                                                                ) ..
                                                                    "m"
                                                )
                                            end
                                        )
                                    else
                                        SetNewWaypoint(target.x, target.y, target.z)
                                        ShowAboveRadarMessage(
                                            "Vous avez placé un marqueur sur ~g~" ..
                                                xPos[Ind] ..
                                                    "~w~ à ~g~" ..
                                                        math.floor(
                                                            GetDistanceBetweenCoords(
                                                                LocalPlayer().Pos,
                                                                target.x,
                                                                target.y,
                                                                target.z,
                                                                true
                                                            )
                                                        ) ..
                                                            "m"
                                        )
                                    end
                                end
                            end
                        )

                        RageUI.List(
                            "Fenêtre",
                            windowsDataLabel,
                            IndW,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                IndW = Index
                                if Selected then
                                    local i = Index - 1
                                    local boolOpen = windowsData[i]
                                    if boolOpen then
                                        TriggerServerEvent("SetVehicleWindowSV", not boolOpen, i)
                                    else
                                        TriggerServerEvent("SetVehicleWindowSV", not boolOpen, i)
                                    end
                                    ShowAboveRadarMessage(
                                        "Fenêtre ~b~" ..
                                            windowsDataLabel[Index] ..
                                                "~w~ " .. (boolOpen and "baissée" or "relevée") .. "."
                                    )
                                    windowsData[i] = not boolOpen
                                end
                            end
                        )

                        RageUI.List(
                            "Portes",
                            doorDataLabel,
                            IndD,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                IndD = Index
                                if Selected then
                                    local i = Index - 1
                                    local boolOpen = GetVehicleDoorAngleRatio(veh, i) > .0
                                    if not boolOpen or boolOpen == 0 then
                                        SetVehicleDoorOpen(veh, i)
                                    else
                                        SetVehicleDoorShut(veh, i)
                                    end
                                    ShowAboveRadarMessage(
                                        "Porte ~b~" ..
                                            doorDataLabel[Index] ..
                                                "~w~ " .. (not boolOpen and "fermée" or "ouverte") .. "."
                                    )
                                end
                            end
                        )

                        RageUI.List(
                            "Limitateur",
                            limiteDataLabel,
                            IndL,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                IndL = Index
                                if Selected then
                                    if limiteDataLabel[IndL] == "Aucun" then
                                        Citizen.InvokeNative(0xBAA045B4E42F3C06, veh, 20000.0)
                                    else
                                        local speed = stringsplit(limiteDataLabel[IndL], " ")
                                        speed = tonumber(speed[1])
                                        if not speed then
                                            Citizen.InvokeNative(0xBAA045B4E42F3C06, veh, -1)
                                            SetVehicleEngineTorqueMultiplier(veh, 1.0)
                                            return
                                        end

                                        Citizen.InvokeNative(0xBAA045B4E42F3C06, veh, speed / 3.6)
                                        SetVehicleEnginePowerMultiplier(veh, math.max(0.0, math.min(1.0, speed / 100)))
                                    end
                                end
                            end
                        )

                        RageUI.Checkbox(
                            "Moteur",
                            nil,
                            GetIsVehicleEngineRunning(veh),
                            {},
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    SetVehicleEngineOn(veh, not GetIsVehicleEngineRunning(veh), false, true)
                                end
                            end
                        )
                        
                        RageUI.Button(
                            "Gérer la radio",
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                if (Selected) then
                                    ExecuteCommand('radiocar')
                                    RageUI.Visible(RMenu:Get("personnal", "vehicule"), false)
                                end
                            end
                        )

                        RageUI.Button(
                            "Créer une course",
                            nil,
                            {},
                            true,
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    RageUI.GoBack()
                                    RageUI.Visible(RMenu:Get("personnal", "vehicule"), false)
                                    ExecuteCommand("race r")
                                end
                            end
                        )

                        RageUI.Button(
                                "Renommer le véhicule",
                                nil,
                                {},
                                true,
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        exports['Snoupinput']:ShowInput("Nouveau nom", 25, "text", "", true)
                                        local text = exports['Snoupinput']:GetInput()
                                        TriggerServerEvent("Garage:UpdateCarLabel", GetVehicleNumberPlateText(veh), text)
                                        RageUI.Popup({message = "~g~Nom du véhicule modifié !~b~"})
                                        RageUI.GoBack()
                                        RageUI.Visible(RMenu:Get("personnal", "vehicule"), false)
                                    end
                                end
                        )

                        RageUI.List(
                            "Clignotants",
                            cligno,
                            IndC,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                IndC = Index
                                if Selected then
                                    if cligno[IndC] == "Warnings" then
                                        clignoA.warnings = not clignoA.warnings
                                        SetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()), 1, clignoA.warnings)
                                        SetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()), 0, clignoA.warnings)
                                    elseif cligno[IndC] == "Gauche" then
                                        if clignoA.right then
                                            clignoA.right = false
                                            SetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()), 0, clignoA.right)
                                        end
                                        clignoA.left = not clignoA.left
                                        SetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()), 1, clignoA.left)
                                    elseif cligno[IndC] == "Droite" then
                                        if clignoA.left then
                                            clignoA.left = false
                                            SetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()), 1, clignoA.left)
                                        end
                                        clignoA.right = not clignoA.right
                                        SetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()), 0, clignoA.right)
                                    end
                                end
                            end
                        )

                        if (DecorGetBool(veh, "hydraulicSystem")) then
                            RageUI.Button(
                                hydraulicMode == true and "Hydraulique: Abaisser le véhicule" or "Hydraulique: Remonter le véhicule",
                                nil,
                                {},
                                true,
                                function(Hovered, Active, Selected, Index)
                                    if (Selected) then
                                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                                        if veh ~= 0 then
                                            RageUI.CloseAll()
                                            exports["mythic_progbar"]:Progress(
                                                {
                                                    name = "hydraulic",
                                                    duration = 2000,
                                                    label = hydraulicMode == true and "Le véhicule s'abaisse..." or "Le véhicule remonte...",
                                                    useWhileDead = true,
                                                    canCancel = false,
                                                    controlDisables = {
                                                        disableMovement = false,
                                                        disableCarMovement = false,
                                                        disableMouse = false,
                                                        disableCombat = false
                                                    },
                                                },
                                                function(cancelled)
                                                    if not cancelled then
                                                        SetReduceDriftVehicleSuspension(veh, hydraulicMode)
                                                        hydraulicMode = not hydraulicMode
                                                    end
                                                end
                                            )
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
function stringsplit(inputstr, sep)
    if not inputstr then
        return
    end
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

RegisterNetEvent('VehicleWindowCL')
AddEventHandler("VehicleWindowCL", function(playerID, windowsDown, i)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(playerID)), false)
    if windowsDown then
        RollUpWindow(vehicle, i)
    else
        RollDownWindow(vehicle, i)
    end
end)

-- Citizen.CreateThread(
--     function()
-- 		local x = true
--         while true do
--             Wait(0)
--             if IsControlPressed(0, 38) then
-- 				local veh = GetVehiclePedIsIn(PlayerPedId(), false)
-- 				if veh ~= 0 then
-- 					SetDriftTyresEnabled(veh, x)
-- 					SetReduceDriftVehicleSuspension(veh, x)
-- 					x = not x
-- 					Wait(1000)
-- 				end
--             end
--         end
--     end
-- )
