Citizen.CreateThread(function()
    while RMenu == nil do
        Wait(1)
    end
    RMenu.Add("lspdExtra", "main", RageUI.CreateMenu("Garagiste LSPD", "Extra disponibles", 10, 100))
    while RMenu:Get("jobs", "police_menuperso") == nil do
        Wait(100)
    end
    RMenu.Add("jobs", "police_supervisor", RageUI.CreateSubMenu(RMenu:Get("jobs", "police_menuperso"), "Units", "Listes", 1350, 50))
    RMenu.Add("jobs", "police_create_unit", RageUI.CreateSubMenu(RMenu:Get("jobs", "police_supervisor"), "Unit", "Listes"))
    RMenu.Add("jobs", "police_change_status", RageUI.CreateSubMenu(RMenu:Get("jobs", "police_supervisor"), "Status", "Listes"))
    RMenu.Add("jobs", "dispatch_police_supervisor", RageUI.CreateSubMenu(RMenu:Get("jobs", "police_supervisor"), "Dispatch", "Listes"))
    RMenu.Add("jobs", "dispatch_police_create_unit", RageUI.CreateSubMenu(RMenu:Get("jobs", "dispatch_police_supervisor"), "Unit", "Listes"))
    RMenu.Add("jobs", "dispatch_police_change_status", RageUI.CreateSubMenu(RMenu:Get("jobs", "dispatch_police_supervisor"), "Status", "Listes"))

    -- FIB
    RMenu.Add("jobs", "fib_director", RageUI.CreateSubMenu(RMenu:Get("jobs", "police_menuperso"), "Actions", "Listes"))
    RMenu.Add("jobs", "fib_create_papers", RageUI.CreateSubMenu(RMenu:Get("jobs", "fib_director"), "Faux papiers", "Listes"))
    RMenu.Add("jobs", "fib_create_identity", RageUI.CreateSubMenu(RMenu:Get("jobs", "fib_create_papers"), "Pièce d'identité", "Listes"))
    RMenu.Add("jobs", "fib_create_driverlicense", RageUI.CreateSubMenu(RMenu:Get("jobs", "fib_create_papers"), "Permis", "Listes"))
end)

local lspdVehicleExtras = {}
local i_lastName, i_firstName, i_dBirth, i_origin, i_sex, l_lastName, l_firstName, l_dBirth
policeMatricule, policeType, policeGrade = nil, nil, nil
getOtherPoliceCalls = false
local matricule, sector, sUnit
local unitCreateType = ""
local statusIndex, typeIndex = 1, 1
local allUnits = {
    ["police"] = {
        ["Lincoln"] = {},
        ["Adam"] = {},
        ["Tom"] = {},
        ["Mary"] = {},
        ["William"] = {},
        ["Robert"] = {},
        ["Air"] = {},
        ["supervisor"] = nil,
        ["commander"] = nil
    },
    ["lssd"] = {
        ["Lincoln"] = {},
        ["Adam"] = {},
        ["India"] = {},
        ["Mary"] = {},
        ["Tango"] = {},
        ["William"] = {},
        ["X-Ray"] = {},
        ["Predator"] = {},
        ["Henry"] = {},
        ["supervisor"] = nil,
        ["commander"] = nil
    }
}
local allUnitsDispatch = {
    ["police"] = {
        ["supervisor"] = "",
        ["commander"] = "",
        ["Lincoln"] = {},
        ["Adam"] = {},
        ["Tom"] = {},
        ["Mary"] = {},
        ["William"] = {},
        ["Robert"] = {},
        ["Air"] = {},
        ["supervisor"] = nil,
        ["commander"] = nil
    },
    ["lssd"] = {
        ["Lincoln"] = {},
        ["Adam"] = {},
        ["India"] = {},
        ["Mary"] = {},
        ["Tango"] = {},
        ["William"] = {},
        ["X-Ray"] = {},
        ["Predator"] = {},
        ["Henry"] = {},
        ["supervisor"] = nil,
        ["commander"] = nil
      }
}
local unitType = {
    ["police"] = {
        "Lincoln",
        "Adam",
        "Tom",
        "Mary",
        "William",
        "Robert",
        "Air"
    },
    ["lssd"] = {
        "Lincoln",
        "Adam",
        "India",
        "Mary",
        "Tango",
        "William",
        "X-Ray",
        "Predator",
        "Henry"
    }
}

local unitStatus = {
    "Code 6",
    "Code 7",
    "10-6",
    "10-8",
    "10-10",
    "10-14",
    "10-15",
    "10-38",
    "10-50",
    "10-56",
}

function EnterExtraPoliceVehicleZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour gérer les extras")
    KeySettings:Add("keyboard", "E", OpenLspdExtraMenu, "LSPDEXTRA")
    KeySettings:Add("controller", 46, OpenLspdExtraMenu, "LSPDEXTRA")
end

function EnterExtraPompierVehicleZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour gérer les extras")
    KeySettings:Add("keyboard", "E", OpenLspdExtraMenu, "LSPDEXTRA")
    KeySettings:Add("controller", 46, OpenLspdExtraMenu, "LSPDEXTRA")
end

function ExitExtraPoliceVehicleZone()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard", "E", "LSPDEXTRA")
    KeySettings:Clear("controller", "E", "LSPDEXTRA")
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
end

function ExitExtraPompierVehicleZone()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard", "E", "LSPDEXTRA")
    KeySettings:Clear("controller", "E", "LSPDEXTRA")
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
end

function OpenLspdExtraMenu()
    lspdVehicleExtras = {}
    if (IsPedInAnyVehicle(LocalPlayer().Ped, false)) then
        local vehicle = GetVehiclePedIsIn(LocalPlayer().Ped, true)
        if (GetPedInVehicleSeat(vehicle, -1) == LocalPlayer().Ped) then
            for i = 0, 29, 1 do
                if DoesExtraExist(vehicle, i) then
                    if (lspdVehicleExtras[tostring(i)] == nil) then
                        lspdVehicleExtras[tostring(i)] = IsVehicleExtraTurnedOn(vehicle, i)
                    end
                end
            end

            RageUI.Visible(RMenu:Get("lspdExtra", "main"), true)
        else
            ShowNotification("~r~Vous devez être a la place conducteur pour effectuer cela~s~")
        end
    else
        ShowNotification("~r~Veuillez être dans un véhicule pour effectuer cette action~s~")
    end
end

RegisterNetEvent("police:AddUnit")
AddEventHandler("police:AddUnit", function(tble, police, unit, newUnit)
    if Ora.Service:isInService("police") or Ora.Service:isInService("lssd") then
        if tble == "current" then
            table.insert(allUnits[police][unit], newUnit)
        else
            table.insert(allUnitsDispatch[police][unit], newUnit)
        end
    end
end)

RegisterNetEvent("police:DeleteUnit")
AddEventHandler("police:DeleteUnit", function(tble, police, unit, index)
    if Ora.Service:isInService("police") or Ora.Service:isInService("lssd") then
        if tble == "current" then
            table.remove(allUnits[police][unit], index)
        else
            table.remove(allUnitsDispatch[police][unit], index)
        end
    end
end)

RegisterNetEvent("Ora::CE::NpcJobs:DrivingSchool::SetDB")
AddEventHandler(
	"Ora::CE::NpcJobs:DrivingSchool::SetDB",
	function(bool)
		TriggerServerEvent("Ora::SE::NpcJobs:DrivingSchool::SetDB", bool)
	end
)

RegisterNetEvent("police:Reset")
AddEventHandler("police:Reset", function(tble, police)
    if tble == "current" then
        for k, v in pairs(allUnits[police]) do
            if type(v) == "table" then
                allUnits[police][k] = {}
            end
        end
        allUnits[police]["supervisor"] = nil
        allUnits[police]["commander"] = nil
    else
        for k, v in pairs(allUnitsDispatch[police]) do
            if type(v) == "table" then
                allUnitsDispatch[police][k] = {}
            end
        end
        allUnitsDispatch[police]["supervisor"] = nil
        allUnitsDispatch[police]["commander"] = nil
    end
end)

RegisterNetEvent("police:ChangeChief")
AddEventHandler("police:ChangeChief", function(tble, police, chief, name)
    if tble == "current" then
        allUnits[police][chief] = name
    else
        allUnitsDispatch[police][chief] = name
    end
end)

RegisterNetEvent("police:ChangeStatus")
AddEventHandler("police:ChangeStatus", function(police, unit, index, status, desc)
    if Ora.Service:isInService("police") or Ora.Service:isInService("lssd") then
        allUnits[police][unit][index].status = status
        allUnits[police][unit][index].desc = desc
    end
end)

RegisterNetEvent("police:ChangeSector")
AddEventHandler("police:ChangeSector", function(tble, police, unit, index, sector)
    if Ora.Service:isInService("police") or Ora.Service:isInService("lssd") then
        if tble == "current" then
            allUnits[police][unit][index].sector = sector
        else
            allUnitsDispatch[police][unit][index].sector = sector
        end
    end
end)

RegisterNetEvent("police:PostDispatch")
AddEventHandler("police:PostDispatch", function(police, tble)
    allUnits[police] = tble
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get("lspdExtra", "main")) then
            RageUI.DrawContent({header = true, glare = false}, function()
                for indexKey, indexValue in pairs(lspdVehicleExtras) do
                    RageUI.Checkbox("Extras n°" .. indexKey, nil, not lspdVehicleExtras[indexKey], {}, function(Hovered, Ative, Selected, Checked)
                        if Selected then
                            local vehicle = GetVehiclePedIsIn(LocalPlayer().Ped, true)
                            local vehBodyDamages = math.floor(GetVehicleBodyHealth(vehicle) / 10,2)
                            local vehMotorDamages =  math.floor(GetVehicleEngineHealth(vehicle) / 10,2)

                            if (indexValue == false) then
                                lspdVehicleExtras[indexKey] = true
                            else
                                lspdVehicleExtras[indexKey] = false
                            end

                            SetVehicleExtra(vehicle, math.tointeger(indexKey), lspdVehicleExtras[indexKey])
                            
                            if (vehBodyDamages <= 90 or vehMotorDamages <= 90) then
                                SetVehicleDamage(vehicle, 0.0, 0.0, 0.44, 500.0, 300.0, true)
                                SetVehicleBodyHealth(vehicle, 700.0)
                            end
                        end
                    end)
                end
            end)
        end

        if RageUI.Visible(RMenu:Get("jobs", "police_supervisor")) then
            RageUI.DrawContent({header = true, glare = true}, function()
                local myUnitIndex = nil
                for k, v in pairs(unitType[policeType]) do
                    for t, u in pairs(allUnits[policeType][v]) do
                        local fCharacter, lastCharacter, nextCharacter = string.find(u.matricule, policeMatricule.."(.)")
                        if string.find(u.matricule, policeMatricule) ~= nil and (nextCharacter == nil or nextCharacter == "+" or nextCharacter == " ") then
                            myUnitIndex = u
                            local color
                            if u.status == "10-8" then
                                color = "~g~"
                            else
                                color = "~r~"
                            end
                            local description = "~b~ Heure : ~s~"..u.desc.time.."~n~~b~ Emplacement : ~s~"..u.desc.zone.." - "..u.desc.street
                            RageUI.Button("~b~"..v.." : ~s~"..u.matricule.." ~p~"..u.sector, description, {RightLabel = color..u.status}, true, function(_, _, Selected)
                                if Selected then
                                    sUnit = {unit = v, index = t, table = u}
                                end
                            end, RMenu:Get("jobs", "police_change_status"))
                            break
                        end
                    end
                end

                for k, v in pairs(unitType[policeType]) do
                    for t, u in pairs(allUnits[policeType][v]) do
                        if u.status == "10-8" and u ~= myUnitIndex then
                            local description = "~b~ Heure : ~s~"..u.desc.time.."~n~~b~ Emplacement : ~s~"..u.desc.zone.." - "..u.desc.street
                            RageUI.Button("~b~"..v.." : ~s~"..u.matricule.." ~p~"..u.sector, description, {RightLabel = "~g~"..u.status}, true, function(_, _, Selected)
                                if Selected then
                                    sUnit = {unit = v, index = t, table = u}
                                end
                            end, RMenu:Get("jobs", "police_change_status"))
                        end
                    end
                end

                for k, v in pairs(unitType[policeType]) do
                    for t, u in pairs(allUnits[policeType][v]) do
                        if u.status ~= "10-8" and u ~= myUnitIndex then
                            local description = nil
                            if u.desc ~= nil then
                                description = "~b~ Heure : ~s~"..u.desc.time.."~n~~b~ Emplacement : ~s~"..u.desc.zone.." - "..u.desc.street
                            end
                            RageUI.Button("~b~"..v.." : ~s~"..u.matricule.." ~p~"..u.sector, description, {RightLabel = "~r~"..u.status}, true, function(_, _, Selected)
                                if Selected then
                                    sUnit = {unit = v, index = t, table = u}
                                end
                            end, RMenu:Get("jobs", "police_change_status"))
                        end
                    end
                end

                RageUI.Button("~o~Superviseur", nil, {RightLabel = allUnits[policeType]["supervisor"]}, true, function(_, _, Selected)
                    if Selected then
                        if policeGrade >= 5 then
                            local name = KeyboardInput("Nom", nil, 50)
                            if name ~= "" then
                                TriggerServerEvent("police:ChangeChief", "current", policeType, "supervisor", name)
                            end
                        else
                            RageUI.Popup({message = "~r~Vous n'avez pas les accès pour cela."})
                        end
                    end
                end)
                RageUI.Button("~o~Watch Commander", nil, {RightLabel = allUnits[policeType]["commander"]}, true, function(_, _, Selected)
                    if Selected then
                        if policeGrade >= 5 then
                            local name = KeyboardInput("Nom", nil, 50)
                            if name ~= "" then
                                TriggerServerEvent("police:ChangeChief", "current", policeType, "commander", name)
                            end
                        else
                            RageUI.Popup({message = "~r~Vous n'avez pas les accès pour cela."})
                        end
                    end
                end)
                RageUI.CenterButton("~b~___________________", nil, {}, true, function()
                end)
                if policeGrade >= 5 then
                    RageUI.Button("Ajouter une unité", nil, {}, true, function()
                    end, RMenu:Get("jobs", "police_create_unit"))
                    RageUI.Button("Tout réinitialiser", nil, {Color = {HightLightColor = {155, 0, 0, 150 }}}, true, function(_, _, Selected)
                        if Selected then
                            local reset = KeyboardInput("Êtes vous sûr? (o/n)", nil, 1)
                            if reset == "o" then
                                TriggerServerEvent("police:Reset", "current", policeType)
                            end
                        end
                    end)
                    RageUI.Button("Préparer le dispatch", nil, {}, true, function()
                    end, RMenu:Get("jobs", "dispatch_police_supervisor"))
                end
                RageUI.Button("Rafraichir", nil, {Color = {HightLightColor = {0, 155, 0, 150 }}}, true, function(_, _, Selected)
                    if Selected  then
                        if Ora.Service:isInService(policeType) then
                            TriggerServerCallback("police:GetAllUnits", function(unitsTable)
                                allUnits = unitsTable
                            end, "current")
                        else
                            RageUI.Popup({message = "~o~Vous devez être en service"})
                        end
                    end
                end)
            end)
        elseif RageUI.Visible(RMenu:Get("jobs", "police_create_unit")) then
            RageUI.DrawContent({header = true, glare = true}, function()
                RageUI.List("~b~Type d'unité : ~s~"..unitCreateType, unitType[policeType], typeIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        typeIndex = Index
                    end
                    if Selected then
                        unitCreateType = unitType[policeType][typeIndex]
                    end
                end)
                RageUI.Button("~b~Matricule :", nil, {RightLabel = matricule}, true, function(_,_,Selected)
                    if Selected then
                        matricule = KeyboardInput("Matricule", nil, 20)
                    end
                end)
                RageUI.Button("~b~Secteur :", nil, {RightLabel = sector}, true, function(_,_,Selected)
                    if Selected then
                        sector = KeyboardInput("Secteur", nil, 50)
                    end
                end)
                RageUI.Button("Valider", nil, {Color = {HightLightColor = {0, 155, 0, 150 }}}, true, function(_,_,Selected)
                    if Selected then
                        if unitCreateType ~= nil and unitCreateType ~= "" and matricule ~= nil and matricule ~= "" and sector ~= nil and sector ~= "" then
                            TriggerServerEvent("police:AddUnit", "current", policeType, unitCreateType, matricule, sector)
                            RageUI.GoBack()
                            matricule, sector, unitCreateType = nil, nil, ""
                        else
                            RageUI.Popup({message = "~r~Veuillez remplir tous les champs."})
                        end
                    end
                end)
            end)
        elseif RageUI.Visible(RMenu:Get("jobs", "police_change_status")) then
            RageUI.DrawContent({header = true, glare = true}, function()
                RageUI.List("Status", unitStatus, statusIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        statusIndex = Index
                    end
                    if Selected then
                        if string.find(sUnit.table.matricule, policeMatricule) ~= nil or policeGrade >= 5 then
                            local coords = LocalPlayer().Pos
                            local zone = GetZoneLabelTextFromZoneCode(GetNameOfZone(coords.x, coords.y, coords.z))
                            local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
                            local desc = {time = nil, zone = zone, street = street}
                            TriggerServerEvent("police:ChangeStatus", policeType, sUnit.unit, sUnit.index, unitStatus[statusIndex], desc)
                        else
                            RageUI.Popup({message = "~r~Ce n'est pas votre unité!"})
                        end
                    end
                end)
                if policeGrade >= 5 then
                    RageUI.Button("Changer le secteur", nil, {}, true, function(_,_,Selected)
                        if Selected then
                            local sector = KeyboardInput("Secteur", nil, 50)
                            if sector ~= "" and sector ~= nil then
                                RageUI.GoBack()
                                TriggerServerEvent("police:ChangeSector", "current", policeType, sUnit.unit, sUnit.index, sector)
                            end
                        end
                    end) 
                    RageUI.Button("Supprimer l'unité", nil, {Color = {HightLightColor = {155, 0, 0, 150 }}}, true, function(_,_,Selected)
                        if Selected then
                            RageUI.GoBack()
                            TriggerServerEvent("police:DeleteUnit", "current", policeType, sUnit.unit, sUnit.index)
                        end
                    end)
                end
            end)
            -------- DISPATCH --------
        elseif RageUI.Visible(RMenu:Get("jobs", "dispatch_police_supervisor")) then
            RageUI.DrawContent({header = true, glare = true}, function()
                for k, v in pairs(unitType[policeType]) do
                    for t, u in pairs(allUnitsDispatch[policeType][v]) do
                        RageUI.Button("~b~"..v.." : ~s~"..u.matricule.." ~p~"..u.sector, nil, {RightLabel = "~g~"..u.status}, true, function(_, _, Selected)
                            if Selected then
                                sUnit = {unit = v, index = t, table = u}
                            end
                        end, RMenu:Get("jobs", "dispatch_police_change_status"))
                    end
                end

                RageUI.Button("~o~Superviseur", nil, {RightLabel = allUnitsDispatch[policeType]["supervisor"]}, true, function(_, _, Selected)
                    if Selected then
                        local name = KeyboardInput("Nom", nil, 50)
                        if name ~= "" and name ~= nil then
                            TriggerServerEvent("police:ChangeChief", "dispatch", policeType, "supervisor", name)
                        end
                    end
                end)
                RageUI.Button("~o~Watch Commander", nil, {RightLabel = allUnitsDispatch[policeType]["commander"]}, true, function(_, _, Selected)
                    if Selected then
                        local name = KeyboardInput("Nom", nil, 50)
                        if name ~= "" and name ~= nil then
                            TriggerServerEvent("police:ChangeChief", "dispatch", policeType, "commander", name)
                        end
                    end
                end)
                RageUI.CenterButton("~b~___________________", nil, {}, true, function()
                end)
                RageUI.Button("Ajouter une unité", nil, {}, true, function()
                end, RMenu:Get("jobs", "dispatch_police_create_unit"))
                RageUI.Button("Tout réinitialiser", nil, {Color = {HightLightColor = {155, 0, 0, 150 }}}, true, function(_, _, Selected)
                    if Selected then
                        local reset = KeyboardInput("Êtes vous sûr? (o/n)", nil, 1)
                        if reset == "o" then
                            TriggerServerEvent("police:Reset", "dispatch", policeType)
                        end
                    end
                end)
                RageUI.Button("Rafraichir", nil, {Color = {HightLightColor = {0, 155, 0, 150 }}}, true, function(_, _, Selected)
                    if Selected  then
                        if Ora.Service:isInService(policeType) then
                            TriggerServerCallback("police:GetAllUnits", function(unitsTable)
                                allUnitsDispatch = unitsTable
                            end, "dispatch")
                        else
                            RageUI.Popup({message = "~o~Vous devez être en service"})
                        end
                    end
                end)
                RageUI.Button("[SUPERVISION] Poster le dispatch", nil, {Color = {HightLightColor = {0, 155, 0, 150 }}}, true, function(_, _, Selected)
                    if Selected then
                        if allUnitsDispatch[policeType]["supervisor"] ~= nil and allUnitsDispatch[policeType]["commander"] ~= nil then
                            TriggerServerEvent("police:PostSupervisorDispatch", policeType)
                        else
                            RageUI.Popup({message = "~o~Veuillez remplir tous les champs"})
                        end
                    end
                end)
                RageUI.Button("[ALL] Poster le dispatch", nil, {Color = {HightLightColor = {0, 155, 0, 150 }}}, true, function(_, _, Selected)
                    if Selected then
                        if allUnitsDispatch[policeType]["supervisor"] ~= nil and allUnitsDispatch[policeType]["commander"] ~= nil then
                            TriggerServerEvent("police:PostDispatch", policeType)
                        else
                            RageUI.Popup({message = "~o~Veuillez remplir tous les champs"})
                        end
                    end
                end)
            end)
        elseif RageUI.Visible(RMenu:Get("jobs", "dispatch_police_create_unit")) then
            RageUI.DrawContent({header = true, glare = true}, function()
                RageUI.List("~b~Type d'unité : ~s~"..unitCreateType, unitType[policeType], typeIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        typeIndex = Index
                    end
                    if Selected then
                        unitCreateType = unitType[policeType][typeIndex]
                    end
                end)
                RageUI.Button("~b~Matricule :", nil, {RightLabel = matricule}, true, function(_,_,Selected)
                    if Selected then
                        matricule = KeyboardInput("Matricule", nil, 20)
                    end
                end)
                RageUI.Button("~b~Secteur :", nil, {RightLabel = sector}, true, function(_,_,Selected)
                    if Selected then
                        sector = KeyboardInput("Secteur", nil, 50)
                    end
                end)
                RageUI.Button("Valider", nil, {Color = {HightLightColor = {0, 155, 0, 150 }}}, true, function(_,_,Selected)
                    if Selected then
                        if unitCreateType ~= nil and unitCreateType ~= "" and matricule ~= nil and matricule ~= "" and sector ~= nil and sector ~= "" then
                            TriggerServerEvent("police:AddUnit", "dispatch", policeType, unitCreateType, matricule, sector)
                            RageUI.GoBack()
                            matricule, sector, unitCreateType = nil, nil, ""
                        else
                            RageUI.Popup({message = "~r~Veuillez remplir tous les champs."})
                        end
                    end
                end)
            end)
        elseif RageUI.Visible(RMenu:Get("jobs", "dispatch_police_change_status")) then
            RageUI.DrawContent({header = true, glare = true}, function()
                RageUI.Button("Changer le secteur", nil, {}, true, function(_,_,Selected)
                    if Selected then
                        local sector = KeyboardInput("Secteur", nil, 50)
                        if sector ~= "" and sector ~= nil then
                            RageUI.GoBack()
                            TriggerServerEvent("police:ChangeSector", "dispatch", policeType, sUnit.unit, sUnit.index, sector)
                        end
                    end
                end)
                RageUI.Button("Supprimer l'unité", nil, {Color = {HightLightColor = {155, 0, 0, 150 }}}, true, function(_,_,Selected)
                    if Selected then  
                        RageUI.GoBack()
                        TriggerServerEvent("police:DeleteUnit", "dispatch", policeType, sUnit.unit, sUnit.index)
                    end
                end)
            end)
        end

        -- FIB
        if RageUI.Visible(RMenu:Get("jobs", "fib_director")) then
            RageUI.DrawContent({header = true, glare = true}, function()
                RageUI.Button("Faux papiers", nil, {}, true, function()
                end, RMenu:Get("jobs", "fib_create_papers"))
            end)
            RageUI.Button("Envoyer une alerte à la police", "Envoie une alerte à la position du marker mis sur la map", {}, true, function(_, _, Selected)
                if Selected then
                  local alert = KeyboardInput("Description", "", 250)
                  local pos = GetBlipCoords(GetFirstBlipInfoId(8))
                  if alert ~= nil and alert ~= "" and pos ~= vector3(0, 0, 0) then
                    TriggerServerEvent("call:makeCall", "police", pos, alert)
                  end
                end
            end)
            RageUI.Button("Localiser un téléphone", nil, {}, true, function(_, _, Selected)
                if Selected then
                    local number = KeyboardInput("Numéro de téléphone", "", 7)
                    if number ~= nil and number ~= "" then
                        TriggerServerEvent("Ora:sendToDiscord", 34, "Lance la localisation sur le numéro de téléphone : "..number, "info")
                        local phoneProp = Ora.World.Object:Create(`prop_police_phone`, GetEntityCoords(PlayerPedId()), true, true, false)
                        local bone = GetPedBoneIndex(PlayerPedId(), 28422)
                        AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                        RequestAnimDict("cellphone@str")
                        while not HasAnimDictLoaded("cellphone@str") do
                            Wait(100)
                        end
                        TaskPlayAnim(PlayerPedId(), "cellphone@str", "cellphone_text_press_a", 2.0, 0.0, -1, 16, 0.0, false, false, false)
                        Wait(3500)
                        TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_out", 8.0, 8.0, -1, 16, 0.0, false, false, false)
                        DeleteObject(phoneProp)
                        LoadingPrompt("Détermination de la position en cours...")
                        Wait(12000)
                        RemoveLoadingPrompt()
                        TriggerServerCallback("hacker:getTelPos", function(id, ped, coords)
                            if id ~= nil then
                                local pPed = NetworkGetEntityFromNetworkId(ped)
                                local found = false
                                TriggerServerCallback("getInventoryOtherPPL", function(Inv, Money, black_money)
                                    local inventory = json.decode(Inv)
                                    for k, v in pairs(inventory["tel"]) do
                                        if v.data.num == number then
                                            found = true
                                            SetNewWaypoint(coords.x, coords.y)
                                            ShowNotification("~g~Succès!~s~\nLe téléphone a été localisé!\n~b~Emplacement : ~s~"..GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z)))
                                            break
                                        end
                                    end
                                    if found then
                                        Citizen.CreateThread(function()
                                            local timing = 0
                                            Ora.Anticheat.Alert.BLIPS = false
                                            while pPed ~= nil do
                                                local blip = GetBlipFromEntity(pPed)
                                                if not DoesBlipExist(blip) then
                                                    blip = AddBlipForEntity(pPed)
                                                    SetBlipSprite(blip, 1)
                                                    ShowHeadingIndicatorOnBlip(blip, true)
                                                end
                                                timing = timing + 1
                                                if timing >= 800 then
                                                    pPed = nil
                                                end
                                                Wait(0)
                                            end
                                            Ora.Anticheat.Alert.BLIPS = true
                                        end)
                                    else
                                        ShowNotification("~r~Erreur!~s~~n~Impossible de localiser le téléphone!")
                                    end
                                end, id)
                            else
                                ShowNotification("~r~Erreur!~s~~n~Impossible de localiser le téléphone!")
                            end
                        end, number)
                    end
                end
            end)
        elseif RageUI.Visible(RMenu:Get("jobs", "fib_create_papers")) then
            RageUI.DrawContent({header = true, glare = true}, function()
                RageUI.Button("Pièce d'identité", nil, {}, true, function()
                end, RMenu:Get("jobs", "fib_create_identity"))
                RageUI.Button("Permis de conduire", nil, {}, true, function()
                end, RMenu:Get("jobs", "fib_create_driverlicense"))
            end)
        elseif RageUI.Visible(RMenu:Get("jobs", "fib_create_identity")) then
            RageUI.DrawContent({header = true, glare = true}, function()
                RageUI.Button("Nom : ", nil, {RightLabel = i_lastName}, true, function(_, _, Selected)
                    if Selected then
                      i_lastName = KeyboardInput("Nom", "", 20)
                    end
                end)
                RageUI.Button("Prénom : ", nil, {RightLabel = i_firstName}, true, function(_, _, Selected)
                    if Selected then
                        i_firstName = KeyboardInput("Prénom", "", 20)
                    end
                end)
                RageUI.Button("Date de naissance : ", nil, {RightLabel = i_dBirth}, true, function(_, _, Selected)
                    if Selected then
                        i_dBirth = KeyboardInput("Date de naissance", "", 20)
                    end
                end)
                RageUI.Button("Origine : ", nil, {RightLabel = i_origin}, true, function(_, _, Selected)
                    if Selected then
                        i_origin = KeyboardInput("Origine", "", 20)
                    end
                end)
                RageUI.Button("Sexe : ", nil, {RightLabel = i_sex}, true, function(_, _, Selected)
                    if Selected then
                        i_sex = KeyboardInput("Sexe", "", 1)
                    end
                end)
                RageUI.Button("Crée la pièce d'identité", nil, {Color = {BackgroundColor = { 0, 100, 0, 25 }}}, true, function(_, _, Selected)
                    if Selected then
                        local serial = math.random(111111111, 9999999999)
                        local items = {name = "identity", label = i_firstName.." "..i_lastName, data = {identity = {last_name = i_lastName, first_name = i_firstName, birth_date = i_dBirth, origine = i_origin, male = i_sex, serial = serial, face_picture = "N/A"}}}
                        Ora.Inventory:AddItem(items)
                        TriggerServerEvent("Ora:sendToDiscord", 34, "Création d'une pièce d'identité : "..i_firstName.." "..i_lastName, "info")
                        RageUI.GoBack()
                        i_lastName, i_firstName, i_dBirth, i_origin, i_sex = nil, nil, nil, nil, nil
                    end
                end)
            end)
        elseif RageUI.Visible(RMenu:Get("jobs", "fib_create_driverlicense")) then
            RageUI.DrawContent({header = true, glare = true}, function()
                RageUI.Button("Nom : ", nil, {RightLabel = l_lastName}, true, function(_, _, Selected)
                    if Selected then
                      l_lastName = KeyboardInput("Nom", "", 20)
                    end
                end)
                RageUI.Button("Prénom : ", nil, {RightLabel = l_firstName}, true, function(_, _, Selected)
                    if Selected then
                        l_firstName = KeyboardInput("Prénom", "", 20)
                    end
                end)
                RageUI.Button("Date de naissance : ", nil, {RightLabel = l_dBirth}, true, function(_, _, Selected)
                    if Selected then
                        l_dBirth = KeyboardInput("Date de naissance", "", 20)
                    end
                end)
                RageUI.Button("Crée le permis de conduire", nil, {Color = {BackgroundColor = { 0, 100, 0, 25 }}}, true, function(_, _, Selected)
                    if Selected then
                        local serial = math.random(111111111, 9999999999)
                        local items = {name = "permis-conduire", label = l_firstName.." "..l_lastName, data = {points = 12, uid = "LS-" .. Random(99999999), identity = {last_name = l_lastName, first_name = l_firstName, birth_date = l_dBirth, serial = serial, face_picture = "N/A"}}}
                        Ora.Inventory:AddItem(items)
                        TriggerServerEvent("Ora:sendToDiscord", 34, "Création d'un permis de conduire : "..l_firstName.." "..l_lastName, "info")
                        RageUI.GoBack()
                        l_lastName, l_firstName, l_dBirth = nil, nil, nil
                    end
                end)
            end)
        end
    end
end)