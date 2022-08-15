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
    if (vehicle == 0) then return RageUI.Popup({message="~r~Aucun véhicule"}) end

    if (Ora.Inventory:GetItemCount("repairbox2") == 0) then return RageUI.Popup({ message = "~r~Vous n'avez pas de kit de réparation" })
    else
        local canRepair = false
        local StorageVector
        local GarageVector

        
        local job = Ora.Identity.Job:Get()
        local orga = Ora.Identity.Orga:Get()
        local group

        if job.isMechanics then group = job
        elseif orga.isMechanics then group = orga end

        if (group) then
            local storagePos = group.Storage[1].Pos
            local garagePos = group.garage.Pos
            StorageVector = vector3(storagePos.x, storagePos.y, storagePos.z)
            GarageVector = vector3(garagePos.x, garagePos.y, garagePos.z)

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

        if (not canRepair) then return RageUI.Popup({message="~r~Vous êtes trop loin d'une dépanneuse ou de votre garage"}) 
        else 
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
                            Ora.Inventory:RemoveAnyItemsFromName("repairbox2", 1)
                            ShowNotification(string.format("Le véhicule ~h~%s~h~ a été ~g~réparé~s~", GetVehicleNumberPlateText(vehicle)))
                            player.isBusy = false
                        end)
                    else
                        ShowNotification(string.format("~r~Vous avez annulé, véhicule ~h~%s~h~ non réparé", GetVehicleNumberPlateText(vehicle)))
                    end
                end
            )
        end
    end    
end

function Mecano.CleanVehicule()
    local vehicle = GetClosestVeh()
    if vehicle == 0 then return RageUI.Popup({message="~r~Aucun véhicule"}) end
    if Ora.Inventory:GetItemCount("lavage") == 0  then return RageUI.Popup({message="~r~Vous n'avez pas de kit de lavage"})
    else
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
                        Ora.Inventory:RemoveAnyItemsFromName("lavage", 1)
                        ShowNotification(string.format("Le véhicule ~h~%s~h~ a été ~g~nettoyé~s~", GetVehicleNumberPlateText(vehicle)))
                        player.isBusy = false
                    end)

                else
                    ShowNotification(string.format("~r~Vous avez annulé, véhicule ~h~%s~h~ non nettoyé", GetVehicleNumberPlateText(vehicle)))
                end
            end
        )
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


function Mecano.SpawnCarRemorque()

    Ora.Jobs.Jetsam.Trailer = Ora.World.Vehicle:Create("tr2", {x = 121.54, y = -1059.86, z = 28.19}, 246.81, {customs = {}, warp_into_vehicle = false, maxFuel = true, health = {}})
    SetNewWaypoint(121.54, -1059.86)
    RageUI.Popup({message = "~b~Votre remorque est sortie ici, ~h~attachez-là à votre camion avant de la remplir~h~"})

end

function Mecano.SpawnTruckRemorque()

    Ora.Jobs.Jetsam.Trailer = Ora.World.Vehicle:Create("trflat", {x = 121.54, y = -1059.86, z = 28.19}, 246.81, {customs = {}, warp_into_vehicle = false, maxFuel = true, health = {}})
    SetNewWaypoint(121.54, -1059.86)
    RageUI.Popup({message = "~b~Votre remorque est sortie ici, ~h~attachez-là à votre camion avant de la remplir~h~"})

end

function Mecano.RangerRemorque()

    if (#(vector3(121.54, -1059.86, 28.19) - GetEntityCoords(GetPlayerPed(-1))) > 15.0) then
        return RageUI.Popup({message = "~r~Vous êtes trop loin du garage entreprise"})
    end

    if (GetVehicleInDirection(15.0) == Ora.Jobs.Jetsam.Trailer) then
        DeleteEntity(Ora.Jobs.Jetsam.Trailer)
        Ora.Jobs.Jetsam.Trailer = nil
        RageUI.Popup({message = "~b~Vous avez rangé votre remorque"})
    else
        RageUI.Popup({message = "~r~Vous n'avez pas sorti de remorque vous-même ou alors elle n'est pas en face de vous"})
    end

end

function Mecano.SortirRampe()

    local player = PlayerPedId()
	local playerCoords = GetEntityCoords(player)
	local radius = 5.0
									
	local vehicle = nil
									
	if IsAnyVehicleNearPoint(playerCoords, radius) then
		vehicle = getClosestVehicle(playerCoords)
		local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
									
		if contains(vehicleName, whitelist) then
			local vehicleCoords = GetEntityCoords(vehicle)
							
			for _, value in pairs(offsets) do
				if vehicleName == value.model then
					local ramp = CreateObject(RampHash, vector3(value.offset.x, value.offset.y, value.offset.z), true, false, false)
					AttachEntityToEntity(ramp, vehicle, GetEntityBoneIndexByName(vehicle, 'chassis'), value.offset.x, value.offset.y, value.offset.z , 180.0, 180.0, 0.0, 0, 0, 1, 0, 0, 1)
					RageUI.Popup({message = "~g~La rampe est bien sortie."})
				end
			end
			return
		end
		return
		RageUI.Popup({message = "~r~Vous devez être sur la remorque."})
	end

end

function Mecano.RangerRampe()

    local player = PlayerPedId()
	local playerCoords = GetEntityCoords(player)
									
	local object = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 5.0, RampHash, false, 0, 0)
									
	if not IsPedInAnyVehicle(player, false) then
		if GetHashKey(RampHash) == GetEntityModel(object) then
			DeleteObject(object)
			RageUI.Popup({message = "~g~La rampe est bien rentrée."})
			return
		end
		RageUI.Popup({message = "~r~Vous devez être sur la rampe."})
	end

end

function Mecano.AttacherVehicle()

    local player = PlayerPedId()
	local vehicle = nil
									
	if IsPedInAnyVehicle(player, false) then
		vehicle = GetVehiclePedIsIn(player, false)
		if GetPedInVehicleSeat(vehicle, -1) == player then
			local vehicleCoords = GetEntityCoords(vehicle)
			local vehicleOffset = GetOffsetFromEntityInWorldCoords(vehicle, 1.0, 0.0, -1.5)
			local vehicleRotation = GetEntityRotation(vehicle, 2)
			local belowEntity = GetVehicleBelowMe(vehicleCoords, vehicleOffset)
			local vehicleBelowRotation = GetEntityRotation(belowEntity, 2)
			local vehicleBelowName = GetDisplayNameFromVehicleModel(GetEntityModel(belowEntity))
					
			local vehiclesOffset = GetOffsetFromEntityGivenWorldCoords(belowEntity, vehicleCoords)
						
			local vehiclePitch = vehicleRotation.x - vehicleBelowRotation.x
			local vehicleYaw = vehicleRotation.z - vehicleBelowRotation.z
							
			if contains(vehicleBelowName, whitelist) then
				if not IsEntityAttached(vehicle) then
					AttachEntityToEntity(vehicle, belowEntity, GetEntityBoneIndexByName(belowEntity, 'chassis'), vehiclesOffset, vehiclePitch, 0.0, vehicleYaw, false, false, true, false, 0, true)
					return RageUI.Popup({message = "~g~Véhicule bien attaché."})
				end
				return RageUI.Popup({message = "~g~Véhicule bien attaché."})
			end
					return RageUI.Popup({message = 'Vous ne pouvez pas attacher : ' .. vehicleBelowName})
		end
		return RageUI.Popup({message = "~r~Vous devez être conducteur."})
	end
	RageUI.Popup({message = "~r~Vous devez être dans un véhicule."})

end

function Mecano.DetacherVehicle()

    local player = PlayerPedId()
	local vehicle = nil
	
    if IsPedInAnyVehicle(player, false) then
		vehicle = GetVehiclePedIsIn(player, false)
		if GetPedInVehicleSeat(vehicle, -1) == player then
			if IsEntityAttached(vehicle) then
				DetachEntity(vehicle, false, true)
				return RageUI.Popup({message = "~g~Véhicule bien détaché."})
			else
				return RageUI.Popup({message = "~g~Véhicule pas attaché."})
			end
		else
			return RageUI.Popup({message = "~r~Vous devez être conducteur."})
		end
	else
		return RageUI.Popup({message = "~r~Vous devez être dans un véhicule."})
	end

end