ShowHelpNotification = function(msg, thisFrame, beep, duration)
    AddTextEntry("esxHelpNotification", msg)

    if thisFrame then
        DisplayHelpTextThisFrame("esxHelpNotification", false)
    else
        if beep == nil then
            beep = true
        end
        BeginTextCommandDisplayHelp("esxHelpNotification")
        EndTextCommandDisplayHelp(0, false, beep, duration or -1)
    end
end

Citizen.CreateThread(
    function()
        while true do
            local wait = 500
            local pPed = PlayerPedId()
            if IsPedSittingInAnyVehicle(pPed) then
                local pVeh = GetVehiclePedIsIn(pPed, 0)
                local vSpeed = GetEntitySpeed(pVeh)
                if vSpeed == 0.0 then
                    if GetVehicleClass(pVeh) == 8 then
                        SetPedConfigFlag(pPed, 35, false)
                        wait = 0
                    end
                end
            end
            Wait(wait)
        end
    end
)

local function Engine()
    local pPed = PlayerPedId()
    if IsPedSittingInAnyVehicle(pPed) then
        local pVeh = GetVehiclePedIsIn(pPed, 0)
        local vSpeed = GetEntitySpeed(pVeh)
        if vSpeed == 0.0 then
            if GetIsVehicleEngineRunning(pVeh) then
                SetVehicleEngineOn(pVeh, 0, 0, 1)
            else
                SetVehicleEngineOn(pVeh, 1, 0, 0)
            end
        end
    end
end

RegisterCommand(
    "moteur",
    function()
        Engine()
    end,
    false
)

RegisterKeyMapping("moteur", "Allumer/Eteindre moteur", "keyboard", "UP")

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
            if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
                    SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
                    wait = 0
                end
            else
                wait = 500
            end
        else
            wait = 500
        end
        Wait(wait)
    end
end)

local function distanceV(d1, d2)
    return #(d1-d2)
end

local function VehicleInFront(ped)
    local pos = GetEntityCoords(ped)
    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 5.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
	
    return result
end

local function Notif(msg)
    if not IsHelpMessageOnScreen() then
        SetTextComponentFormat('STRING')
        AddTextComponentString(msg)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        
        if not IsPedInAnyVehicle(ped, true) then
            local veh = VehicleInFront(ped)
            if DoesEntityExist(veh) then
                if (GetNumberOfVehicleDoors(veh) > 2) then
                    for i = 1, GetNumberOfVehicleDoors(veh), 1 do
                        local doorCoords = GetEntryPositionOfDoor(veh, i)
                        if i~= 1 and distanceV(pedCoords, doorCoords) < 0.75 and not DoesEntityExist(GetPedInVehicleSeat(veh, i - 1)) then
                            Notif("Appuyez sur ~INPUT_VEH_HEADLIGHT~ pour rentrer par la porte en face de vous")
                            if IsControlJustReleased(0, 74) then
                                TaskEnterVehicle(ped, veh, 10000, i - 1, 1.0, 1, 0);
                            end
                        end
                    end
                end
            else
                Wait(500)
            end
        else
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        if IsPedSittingInAnyVehicle(plyPed) then
            local plyVehicle = GetVehiclePedIsIn(plyPed, false)
			CarSpeed = GetEntitySpeed(plyVehicle) * 3.6
			if CarSpeed <= 60.0 then
				if IsControlJustReleased(0, 157) then -- conducteur
					SetPedIntoVehicle(plyPed, plyVehicle, -1)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 158) then -- avant droit
					SetPedIntoVehicle(plyPed, plyVehicle, 0)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 160) then -- arriere gauche
					SetPedIntoVehicle(plyPed, plyVehicle, 1)
					Citizen.Wait(10)
				end
				if IsControlJustReleased(0, 164) then -- arriere gauche
					SetPedIntoVehicle(plyPed, plyVehicle, 2)
					Citizen.Wait(10)
				end
			end
		end
		Citizen.Wait(10)
	end
end)