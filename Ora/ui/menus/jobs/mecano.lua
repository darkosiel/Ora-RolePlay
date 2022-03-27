Mecano = {}

local function GetClosestVeh()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    local clstVh = GetClosestVehicle(x, y, z, 2.5, 0, 70)
    local result = 0

    if GetEntityType(vehicleFct.GetVehicleInDirection()) == 2 then
        result = vehicleFct.GetVehicleInDirection()
    end
    
    if clstVh ~= 0 and clstVh ~= nil then
        result = clstVh
    end

    return result or 0
end

function Mecano.CheckVehicle()
    local veh = GetClosestVeh()
    if veh ~= 0 then
        local carosserie = math.floor(GetVehicleBodyHealth(veh) / 10,2)
        local motor =  math.floor(GetVehicleEngineHealth(veh) / 10,2)
        local moyenne = (motor + carosserie) / 2 
        RageUI.Popup({message="État de la carosserie : ~b~"..carosserie.."%\n~s~État du moteur : ~b~"..motor.."%~s~\nL'état global est de : ~b~"..moyenne.."%"})
    else
        RageUI.Popup({message="~r~Aucun véhicule"})
    end      
end

function Mecano.CheckPerfs()
    local veh = GetClosestVeh()
    if veh ~= 0 then
        local turbo = IsToggleModOn(veh, 18) and "Oui" or "Non"
        local motor =  GetVehicleMod(veh, 11) + 2
        local transmi = GetVehicleMod(veh, 13) + 2
        local freins = GetVehicleMod(veh, 12) + 2
        local suspension = GetVehicleMod(veh, 15) + 2
        RageUI.Popup({
            message = string.format(
                "~b~Turbo ? ~y~%s~b~.\nMoteur ~y~%s~b~.\nTransmission ~y~%s~b~.\nFreins ~y~%s~b~.\nSuspension ~y~%s~b~.",
                turbo,
                motor,
                transmi,
                freins,
                suspension
            )
        })
    else
        RageUI.Popup({message="~r~Aucun véhicule"})
    end      
end

function Mecano.OpenTrunk()
    local veh = GetClosestVeh()
    if veh ~= 0 then
        if GetVehicleDoorAngleRatio(veh, 4) > 0.0  then
            Jobs.mecano.Menu.submenus["Actions véhicule"].menus.buttons[2].label = "Fermer le capot"
            SetVehicleDoorShut(veh, 4, false)
        else
            Jobs.mecano.Menu.submenus["Actions véhicule"].menus.buttons[2].label = "Ouvrir le capot"
            
            SetVehicleDoorOpen(veh, 4, false, false)
        end
    else
        RageUI.Popup({message="~r~Aucun véhicule"})
    end
end

local CurrentlyTowedVehicle = nil

function Mecano.PutPlateau()
    local playerPed = PlayerPedId()
    local flatbeds = {}
    local flatbed = nil

    for veh in EnumerateVehicles() do
        if (GetEntityModel(veh) == `flatbed` and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(veh)) < 20.0) then
            table.insert(flatbeds, veh)
            flatbed = veh
        end
    end

    if (#flatbeds > 1) then
        for i, veh in ipairs(flatbeds) do
            if (#(GetEntityCoords(PlayerPedId()) - GetEntityCoords(veh)) < 10.0) then
                flatbed = veh
                break
            end
        end
    end

    if (flatbed ~= nil) then
        local targetVehicle = GetVehicleInDirection()

        if (CurrentlyTowedVehicle == nil) then
            if (targetVehicle ~= 0 and not IsPedInAnyVehicle(playerPed, true)) then
                if (flatbed ~= targetVehicle) then
                    AttachEntityToEntity(targetVehicle, flatbed, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, true, true, true, false, 20, true)
                    CurrentlyTowedVehicle = targetVehicle
                    ShowNotification("~g~Véhicule attaché")
                else
                    ShowNotification("~r~Vous ne pouvez pas attacher votre propre dépaneuse")
                end
            else
                ShowNotification("~r~Aucun véhicule à attacher en visuel")
            end
        else
            AttachEntityToEntity(CurrentlyTowedVehicle, flatbed, 20, -0.5, -12.5, 1.0, 0.0, 0.0, 0.0, true, true, true, false, 20, true)
            DetachEntity(CurrentlyTowedVehicle, true, true)

            CurrentlyTowedVehicle = nil
            ShowNotification("~g~Véhicule détaché")
        end
    else
        ShowNotification("~r~Il vous faut un plateau !")
    end
end

function Mecano.Repair()
    local vehicle = GetClosestVeh()

    if (vehicle ~= 0 and Ora.Inventory:GetItemCount("repairbox") > 0) then
        local canRepair = false
        local StorageVector
        local GarageVector

        if (Ora.Identity.Job:Get().isMechanics) then
            StorageVector = vector3(Ora.Identity.Job:Get().Storage[1].Pos.x, Ora.Identity.Job:Get().Storage[1].Pos.y, Ora.Identity.Job:Get().Storage[1].Pos.z)
            GarageVector = vector3(Ora.Identity.Job:Get().garage.Pos.x, Ora.Identity.Job:Get().garage.Pos.y, Ora.Identity.Job:Get().garage.Pos.z)

            if (
                #(GetEntityCoords(PlayerPedId()) - GarageVector) < 35.5 or
                #(GetEntityCoords(PlayerPedId()) - StorageVector) < 55.5
            ) then
                canRepair = true
            else
                for vehicle in EnumerateVehicles() do
                    if (
                        #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicle)) < 10.0 and
                        (
                            GetEntityModel(vehicle) == `flatbed` or
                            GetEntityModel(vehicle) == `towtruck` or
                            GetEntityModel(vehicle) == `towtruck2`
                        )
                    ) then
                        canRepair = true
                    end
                end
            end
        elseif (Ora.Identity.Orga:Get().isMechanics) then
            StorageVector = vector3(Ora.Identity.Orga:Get().Storage[1].Pos.x, Ora.Identity.Orga:Get().Storage[1].Pos.y, Ora.Identity.Orga:Get().Storage[1].Pos.z)
            GarageVector = vector3(Ora.Identity.Orga:Get().garage.Pos.x, Ora.Identity.Orga:Get().garage.Pos.y, Ora.Identity.Orga:Get().garage.Pos.z)

            if (
                #(GetEntityCoords(PlayerPedId()) - GarageVector) < 35.5 or
                #(GetEntityCoords(PlayerPedId()) - StorageVector) < 55.5
            ) then
                canRepair = true
            else
                for vehicle in EnumerateVehicles() do
                    if (
                        #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicle)) < 10.0 and
                        (
                            GetEntityModel(vehicle) == `flatbed` or
                            GetEntityModel(vehicle) == `towtruck` or
                            GetEntityModel(vehicle) == `towtruck2`
                        )
                    ) then
                        canRepair = true
                    end
                end
            end
        end

        if (canRepair == true) then
            player = LocalPlayer()
            player.isBusy = true
            TaskStartScenarioInPlace(LocalPlayer().Ped, 'PROP_HUMAN_BUM_BIN', 0, true)
            exports["mythic_progbar"]:Progress(
                {
                    name = "repair",
                    duration = 20000,
                    label = "Réparation...",
                    useWhileDead = false,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = false,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    }
                },
                function(cancelled)
                    if not cancelled then
                        Citizen.CreateThread(function()   
                            SetVehicleFixed(vehicle)
                            SetVehicleDeformationFixed(vehicle)
                            SetVehicleUndriveable(vehicle, false)
                            SetVehicleEngineOn(vehicle, true, true)
                            removeall()
                
                            ShowNotification(string.format("Le véhicule ~h~%s~h~ a été ~g~réparé~s~", GetVehicleNumberPlateText(vehicle)))
                            player.isBusy = false
                        end)
                    else
                        ShowNotification(string.format("~r~Vous avez annulé, véhicule ~h~%s~h~ non réparé", GetVehicleNumberPlateText(vehicle)))
                    end
                end
            )
        else
            RageUI.Popup({message="~r~Vous êtes trop loin d'une dépanneuse ou de votre garage"})
        end
    elseif vehicle == 0 then
        RageUI.Popup({message="~r~Aucun véhicule"})
    else
        RageUI.Popup({message="~r~Vous n'avez pas de boite a outil"})
    end    
end

function Mecano.CleanVehicule()
    local vehicle = GetClosestVeh()
    if vehicle ~= 0 and Ora.Inventory:GetItemCount("lavage") > 0  then
        TaskStartScenarioInPlace(LocalPlayer().Ped, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
        player = LocalPlayer()
        player.isBusy = true
        exports["mythic_progbar"]:Progress(
            {
                name = "clean",
                duration = 10000,
                label = "Nettoyage...",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = false,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = false
                }
            },
            function(cancelled)
                if not cancelled then
                    Citizen.CreateThread(function()
                        SetVehicleDirtLevel(vehicle, 0)
                        removeall()
                        ShowNotification(string.format("Le véhicule ~h~%s~h~ a été ~g~nettoyé~s~", GetVehicleNumberPlateText(vehicle)))
                        player.isBusy = false
                    end)

                else
                    ShowNotification(string.format("~r~Vous avez annulé, véhicule ~h~%s~h~ non nettoyé", GetVehicleNumberPlateText(vehicle)))
                end
            end
        )
    elseif vehicle == 0 then
        RageUI.Popup({message="~r~Aucun véhicule"})
    else
        RageUI.Popup({message="~r~Vous n'avez pas de kit de lavage"})
    end
end

function Mecano.Fouriere()
    local vehicle = GetClosestVeh()
    if vehicle ~= 0 then
        DeleteEntity(vehicle)
    else
        RageUI.Popup({message="~r~Aucun véhicule"})
    end
end

function Mecano.ShowMarker()
    local veh = GetClosestVeh()
    if veh ~= 0 then
        if GetVehicleDoorAngleRatio(veh,4) > 0.0 then
            Jobs.mecano.Menu.submenus["Actions véhicule"].menus.buttons[2].label = "Fermer le capot"
        else
            Jobs.mecano.Menu.submenus["Actions véhicule"].menus.buttons[2].label = "Ouvrir le capot"
        end
        local coords = GetEntityCoords(veh)
        local x,y,z = table.unpack(coords)
        --DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
        DrawMarker(2, x, y, z + 1.5, 0, 0, 0, 180.0, nil, nil, 0.5, 0.5, 0.5, 52, 177, 74, 255, false, true, 2, true)
    end
end
