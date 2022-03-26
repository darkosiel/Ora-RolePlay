local LastEntity = false
local LastVehicle = false
local AbleToRob = false
local Robbing = false
local HasKeys = false
local HasKilled = false

local ChanceToFleeWithLethal = 0.25
local ChanceToFleeWithNoLetal = 0.50
local ChanceToGiveKeys = 0.25

local relationshipTypes = {
    "GANG_1",
    "GANG_2",
    "GANG_9",
    "GANG_10",
    "AMBIENT_GANG_LOST",
    "AMBIENT_GANG_MEXICAN",
    "AMBIENT_GANG_FAMILY",
    "AMBIENT_GANG_BALLAS",
    "AMBIENT_GANG_MARABUNTE",
    "AMBIENT_GANG_CULT",
    "AMBIENT_GANG_SALVA",
    "AMBIENT_GANG_WEICHENG",
    "AMBIENT_GANG_HILLBILLY",
    "DEALER",
    "CIVMALE",
    "CIVFEMALE",
    "COP",
    "PRIVATE_SECURITY",
    "SECURITY_GUARD",
    "ARMY",
    "MEDIC",
    "FIREMAN",
    "HATES_PLAYER",
    "NO_RELATIONSHIP",
    "SPECIAL",
    "MISSION2",
    "MISSION3",
    "MISSION4",
    "MISSION5",
    "MISSION6",
    "MISSION7",
    "MISSION8"
}

local vehColors = {
    "Metallic Black",
    "Metallic Graphite Black",
    "Metallic Black Steal",
    "Metallic Dark Silver",
    "Metallic Silver",
    "Metallic Blue Silver",
    "Metallic Steel Gray",
    "Metallic Shadow Silver",
    "Metallic Stone Silver",
    "Metallic Midnight Silver",
    "Metallic Gun Metal",
    "Metallic Anthracite Grey",
    "Matte Black",
    "Matte Gray",
    "Matte Light Grey",
    "Util Black",
    "Util Black Poly",
    "Util Dark silver",
    "Util Silver",
    "Util Gun Metal",
    "Util Shadow Silver",
    "Worn Black",
    "Worn Graphite",
    "Worn Silver Grey",
    "Worn Silver",
    "Worn Blue Silver",
    "Worn Shadow Silver",
    "Metallic Red",
    "Metallic Torino Red",
    "Metallic Formula Red",
    "Metallic Blaze Red",
    "Metallic Graceful Red",
    "Metallic Garnet Red",
    "Metallic Desert Red",
    "Metallic Cabernet Red",
    "Metallic Candy Red",
    "Metallic Sunrise Orange",
    "Metallic Classic Gold",
    "Metallic Orange",
    "Matte Red",
    "Matte Dark Red",
    "Matte Orange",
    "Matte Yellow",
    "Util Red",
    "Util Bright Red",
    "Util Garnet Red",
    "Worn Red",
    "Worn Golden Red",
    "Worn Dark Red",
    "Metallic Dark Green",
    "Metallic Racing Green",
    "Metallic Sea Green",
    "Metallic Olive Green",
    "Metallic Green",
    "Metallic Gasoline Blue Green",
    "Matte Lime Green",
    "Util Dark Green",
    "Util Green",
    "Worn Dark Green",
    "Worn Green",
    "Worn Sea Wash",
    "Metallic Midnight Blue",
    "Metallic Dark Blue",
    "Metallic Saxony Blue",
    "Metallic Blue",
    "Metallic Mariner Blue",
    "Metallic Harbor Blue",
    "Metallic Diamond Blue",
    "Metallic Surf Blue",
    "Metallic Nautical Blue",
    "Metallic Bright Blue",
    "Metallic Purple Blue",
    "Metallic Spinnaker Blue",
    "Metallic Ultra Blue",
    "Metallic Bright Blue",
    "Util Dark Blue",
    "Util Midnight Blue",
    "Util Blue",
    "Util Sea Foam Blue",
    "Util Lightning blue",
    "Util Maui Blue Poly",
    "Util Bright Blue",
    "Matte Dark Blue",
    "Matte Blue",
    "Matte Midnight Blue",
    "Worn Dark blue",
    "Worn Blue",
    "Worn Light blue",
    "Metallic Taxi Yellow",
    "Metallic Race Yellow",
    "Metallic Bronze",
    "Metallic Yellow Bird",
    "Metallic Lime",
    "Metallic Champagne",
    "Metallic Pueblo Beige",
    "Metallic Dark Ivory",
    "Metallic Choco Brown",
    "Metallic Golden Brown",
    "Metallic Light Brown",
    "Metallic Straw Beige",
    "Metallic Moss Brown",
    "Metallic Biston Brown",
    "Metallic Beechwood",
    "Metallic Dark Beechwood",
    "Metallic Choco Orange",
    "Metallic Beach Sand",
    "Metallic Sun Bleeched Sand",
    "Metallic Cream",
    "Util Brown",
    "Util Medium Brown",
    "Util Light Brown",
    "Metallic White",
    "Metallic Frost White",
    "Worn Honey Beige",
    "Worn Brown",
    "Worn Dark Brown",
    "Worn straw beige",
    "Brushed Steel",
    "Brushed Black steel",
    "Brushed Aluminium",
    "Chrome",
    "Worn Off White",
    "Util Off White",
    "Worn Orange",
    "Worn Light Orange",
    "Metallic Securicor Green",
    "Worn Taxi Yellow",
    "police car blue",
    "Matte Green",
    "Matte Brown",
    "Worn Orange",
    "Matte White",
    "Worn White",
    "Worn Olive Army Green",
    "Pure White",
    "Hot Pink",
    "Salmon pink",
    "Metallic Vermillion Pink",
    "Orange",
    "Green",
    "Blue",
    "Mettalic Black Blue",
    "Metallic Black Purple",
    "Metallic Black Red",
    "hunter green",
    "Metallic Purple",
    "Metaillic V Dark Blue",
    "Matte Black",
    "Matte Purple",
    "Matte Dark Purple",
    "Metallic Lava Red",
    "Matte Forest Green",
    "Matte Olive Drab",
    "Matte Desert Brown",
    "Matte Desert Tan",
    "Matte Foilage Green",
    "Alloy",
    "Epsilon Blue",
    "Pure Gold",
    "Brushed Gold",
    "x"
}

function callCopsForVehicle(tryVehicle, vehCoords, haskilled)
    local entityZoneName = GetNameOfZone(vehCoords.x, vehCoords.y, vehCoords.z)
    local entityZoneCops = GetCopsUnitToCall(entityZoneName)
    for callId, callCops in pairs(entityZoneCops) do
        TriggerServerEvent(
            "call:makeCall2",
            callCops,
            {x = vehCoords.x, y = vehCoords.y, z = vehCoords.z},
            string.format("\n[%sNOJACK TRACKING]\n ~r~Véhicule %s a été carjacké %s~s~", GetVehicleNumberPlateText(tryVehicle), getVehicleType(tryVehicle), haskilled == true and "violemment" or "")
        )
    end
end

function SendDiscordWebHook(tryVehicle, vehCoords, haskilled)
    local color1, color2 = GetVehicleColours(tryVehicle)
    color1 = color1 + 1
    color2 = color2 + 1
    local vehColor = (color1 == color2 or color2 == nil) and vehColors[color1] or vehColors[color1].." et "..vehColors[color2]
    local vehPlate = GetVehicleNumberPlateText(tryVehicle)
    local timeout = 0

    while (vehPlate == nil) do
        if (timeout == 10) then break end
        Wait(100)
        vehPlate = GetVehicleNumberPlateText(tryVehicle)
        timeout = timeout + 1
    end

    if (vehPlate ~= nil) then
        TriggerServerEvent(
            "atlantiss:sendToDiscordLSPD",
            2,
            "Couleur:\n"..
            vehColor..
                "\n\nType:\n"..
                    getVehicleType(tryVehicle)..
                        string.format("\n\nVolé %s dans la zone:\n", haskilled == true and "violemment" or "")..
                            string.sub(GetZoneLabelTextFromZoneCode(GetNameOfZone(vehCoords.x, vehCoords.y, vehCoords.z)), 1),
            vehPlate or "illisible"
        )
    end
end

function getVehicleType(vehicle)
    local vehicleClass = GetVehicleClass(vehicle)
    local vehicleClassName = "Inconnue"

    if (vehicleClass == 0) then
        vehicleClassName = "Compact"
    elseif (vehicleClass == 1) then
        vehicleClassName = "Sedans"
    elseif (vehicleClass == 2) then
        vehicleClassName = "SUV"
    elseif (vehicleClass == 3) then
        vehicleClassName = "Coupé"
    elseif (vehicleClass == 4) then
        vehicleClassName = "Muscle Car"
    elseif (vehicleClass == 5) then
        vehicleClassName = "Sport Classic"
    elseif (vehicleClass == 6) then
        vehicleClassName = "Sport"
    elseif (vehicleClass == 7) then
        vehicleClassName = "Super"
    elseif (vehicleClass == 8) then
        vehicleClassName = "Moto"
    elseif (vehicleClass == 9) then
        vehicleClassName = "Off Road"
    elseif (vehicleClass == 10) then
        vehicleClassName = "Industriel"
    elseif (vehicleClass == 11) then
        vehicleClassName = "Utilitaire"
    elseif (vehicleClass == 12) then
        vehicleClassName = "Van"
    elseif (vehicleClass == 13) then
        vehicleClassName = "Vélo"
    elseif (vehicleClass == 14) then
        vehicleClassName = "Bateau"
    elseif (vehicleClass == 15) then
        vehicleClassName = "Helicopter"
    elseif (vehicleClass == 16) then
        vehicleClassName = "Avion"
    elseif (vehicleClass == 17) then
        vehicleClassName = "Bus, camion poubelle"
    elseif (vehicleClass == 18) then
        vehicleClassName = "Véhicule police/EMS"
    elseif (vehicleClass == 19) then
        vehicleClassName = "Véhicule Militaire"
    else
        vehicleClassName = "Classe inconnue"
    end

    return vehicleClassName
end


RegisterNetEvent("Atlantiss::CE::Carjacking:LockState")
AddEventHandler(
    "Atlantiss::CE::Carjacking:LockState",
    function(veh, state)
        if (state == 1) then
            if (Atlantiss.World.Vehicle.JackedVehicles[veh] == nil) then table.insert(Atlantiss.World.Vehicle.JackedVehicles, veh) end
        elseif (state == 2) then
            if (Atlantiss.Utils:HasValue(Atlantiss.World.Vehicle.JackedVehicles, veh)) then
                table.remove(Atlantiss.World.Vehicle.JackedVehicles, Atlantiss.Utils:IndexOf(Atlantiss.World.Vehicle.JackedVehicles, veh))
            end
        end

        SetVehicleDoorsLocked(veh, state)
    end
)


Citizen.CreateThread(function()
    while (not Atlantiss.Player.HasLoaded) do Wait(500) end

	while true do
        Wait(0)
        local FoundEntity, AimedEntity = GetEntityPlayerIsFreeAimingAt(PlayerId())

		if (
            not Atlantiss.Identity:HasAnyJob("police") and not Atlantiss.Identity:HasAnyJob("lssd") and
            FoundEntity and LastEntity ~= AimedEntity and
            IsPedInAnyVehicle(AimedEntity, false) and
            IsPedArmed(PlayerPedId(), 7) and
            GetPedInVehicleSeat(GetVehiclePedIsIn(AimedEntity, false), -1) == AimedEntity and
            #(GetEntityCoords(AimedEntity) - GetEntityCoords(GetPlayerPed(-1))) < 12.0
        ) then
            local aimedPedIsAGangster = Atlantiss.World.Ped:IsPedAGangster(AimedEntity)
            local _, UsedWeapon = GetCurrentPedWeapon(PlayerPedId(), 1)
            local chanceCheck = nil
            local timeout = 0

            if (not aimedPedIsAGangster) then
                for item, weaponName in pairs(weapon_name) do
                    if (GetHashKey(weaponName) == UsedWeapon) then
                        chanceCheck = weapon_munition[item] == nil and ChanceToFleeWithNoLetal or ChanceToFleeWithLethal
                        break
                    end
                end
            end

			LastEntity = AimedEntity
			LastVehicle = GetVehiclePedIsIn(AimedEntity, false)

            if (not aimedPedIsAGangster and math.random() >= chanceCheck) then
                if (not IsPedAPlayer(AimedEntity)) then
					if (not HasAnimDictLoaded("random@mugging3")) then
                        RequestAnimDict("random@mugging3")
						while not HasAnimDictLoaded("random@mugging3") do Wait(0) end
                    end

					TaskLeaveVehicle(AimedEntity, LastVehicle, 256)
					SetVehicleEngineOn(LastVehicle, false, false, false)

					while IsPedInAnyVehicle(AimedEntity, false) do Wait(10) end

					SetBlockingOfNonTemporaryEvents(AimedEntity, true)
					ClearPedTasksImmediately(AimedEntity)
					TaskPlayAnim(AimedEntity, "random@mugging3", "handsup_standing_base", 8.0, -8, 0.01, 49, 0, 0, 0, 0)
					ResetPedLastVehicle(AimedEntity)
					TaskWanderInArea(AimedEntity, 0, 0, 0, 20, 100, 100)

                    Citizen.CreateThread(function()
                        local i = 1

                        while true do
                            Wait(1000)
                            if (i >= 10 or HasKeys == true) then break end

                            if (IsEntityDead(AimedEntity)) then
                                RageUI.Popup({message = "~g~Vous avez récupéré les clés"})
                                Atlantiss.Inventory:AddItem({
                                    name = "key",
                                    data = {
                                        plate = GetVehicleNumberPlateText(LastVehicle),
                                        vehicleIdentifier = getVehicleIdentifier(LastVehicle)
                                    },
                                    label = GetVehicleNumberPlateText(LastVehicle)
                                })
                                HasKeys = true
                                HasKilled = true

                                SetVehicleDoorsLocked(LastVehicle, 1)
                                if (Atlantiss.World.Vehicle.JackedVehicles[LastVehicle] == nil) then table.insert(Atlantiss.World.Vehicle.JackedVehicles, LastVehicle) end
                                callCopsForVehicle(LastVehicle, GetEntityCoords(LastVehicle), HasKilled)
                                SendDiscordWebHook(LastVehicle, GetEntityCoords(LastVehicle), HasKilled)
                                break
                            end
                            i = i + 1
                        end
                    end)
					
					HasKeys = false
                    HasKilled = false
					AbleToRob = true
                    RageUI.Popup({message = "~b~Appuyez sur ~y~E~b~ près de l'individu pour le fouiller"})
					Wait(math.random(4000, 8000))
					AbleToRob = false

					if (not IsEntityDead(AimedEntity) and not Robbing) then
						StopAnimTask(AimedEntity, "random@mugging3", "handsup_standing_base", 1.0)
						ClearPedTasksImmediately(AimedEntity)
						TaskReactAndFleePed(AimedEntity, PlayerPedId())
					end
				end
            elseif (aimedPedIsAGangster) then
                TaskLeaveVehicle(AimedEntity, LastVehicle, 256)
                SetVehicleEngineOn(LastVehicle, false, false, false)

                while IsPedInAnyVehicle(AimedEntity, false) do Wait(10) end

                SetPedShootRate(AimedEntity, 50)
                GiveWeaponToPed(AimedEntity, GetHashKey("weapon_snspistol"), 36, true, true)
                TaskAimGunAtEntity(AimedEntity, LocalPlayer().Ped, -1, true)

                Citizen.CreateThread(
                    function()
                        drawCenterText("~r~Tu as 5 secondes avant que je tire, enfoiré !", 5000)
                        Citizen.Wait(5000)
                        return
                    end
                )

                Wait(5000)

                if (#(GetEntityCoords(AimedEntity) - GetEntityCoords(LocalPlayer().Ped)) > 12.0) then
                    RemoveWeaponFromPed(AimedEntity, GetHashKey("weapon_snspistol"))
                    SetVehicleCanBeUsedByFleeingPeds(LastVehicle, true)
                    TaskEnterVehicle(AimedEntity, LastVehicle, 1000, -1, 2.0, 1, 0)
                    
                    while (GetPedInVehicleSeat(LastVehicle, -1) ~= AimedEntity) do
                        Wait(100)
                        timeout = timeout + 1
                        if (timeout >= 25) then break end
                    end
                    
                    TaskSmartFleePed(AimedEntity, LocalPlayer().Ped, 15.0, -1)
                else
                    SetRelationshipBetweenGroups(4, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
                    SetRelationshipBetweenGroups(4, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
                    SetRelationshipBetweenGroups(4, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
                    SetRelationshipBetweenGroups(4, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
                    SetRelationshipBetweenGroups(4, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
                    SetRelationshipBetweenGroups(4, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
                    SetRelationshipBetweenGroups(4, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
                    SetRelationshipBetweenGroups(4, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
                    SetRelationshipBetweenGroups(4, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
                    SetRelationshipBetweenGroups(4, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
                    SetPedAccuracy(AimedEntity, 0)
                    TaskCombatPed(AimedEntity, LocalPlayer().Ped, 0, 16)
                    SetPedCombatAttributes(AimedEntity, 46, true)
                    SetPedFleeAttributes(AimedEntity, 0, 0)
                    SetPedAsEnemy(AimedEntity, true)
                    SetPedMaxHealth(AimedEntity, 200)
                    SetPedAlertness(AimedEntity, 3)
                    SetPedCombatRange(AimedEntity, 0)
                    SetPedCombatMovement(AimedEntity, 3)

                    Citizen.CreateThread(function()
                        local timeout = 0
                        local timeout2 = 0
                        local function Finished()
                            SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
                            SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
                            SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
                            SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
                            SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
                            SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
                            SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
                            SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
                            SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
                            SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))

                            RemoveWeaponFromPed(AimedEntity, GetHashKey("weapon_snspistol"))
                            callCopsForVehicle(LastVehicle, GetEntityCoords(LastVehicle), HasKilled)
                            SendDiscordWebHook(LastVehicle, GetEntityCoords(LastVehicle), HasKilled)
                        end

                        while true do
                            if (IsEntityDead(AimedEntity)) then
                                SetVehicleDoorsLocked(LastVehicle, 1)

                                HasKeys = true
                                HasKilled = true

                                if (Atlantiss.World.Vehicle.JackedVehicles[LastVehicle] == nil) then table.insert(Atlantiss.World.Vehicle.JackedVehicles, LastVehicle) end
                                
                                RageUI.Popup({message = "~g~Vous avez récupéré les clés"})
                                Atlantiss.Inventory:AddItem({
                                    name = "key",
                                    data = {
                                        plate = GetVehicleNumberPlateText(LastVehicle),
                                        vehicleIdentifier = getVehicleIdentifier(LastVehicle)
                                    },
                                    label = GetVehicleNumberPlateText(LastVehicle)
                                })
                                Finished()
                                break
                            end

                            if (IsEntityDead(LocalPlayer().Ped) or timeout == 10) then
                                Finished()
                                SetPedCombatAttributes(AimedEntity, 46, false)
                                SetPedAsEnemy(AimedEntity, false)
                                SetPedAlertness(AimedEntity, 0)
                                ClearPedTasksImmediately(AimedEntity)
                                SetVehicleCanBeUsedByFleeingPeds(LastVehicle, true)
                                TaskEnterVehicle(AimedEntity, LastVehicle, 5000, -1, 2.0, 1, 0)
                                
                                while (GetPedInVehicleSeat(LastVehicle, -1) ~= AimedEntity) do
                                    Wait(100)
                                    timeout2 = timeout2 + 1
                                    if (timeout2 >= 50) then break end
                                end
                                
                                TaskSmartFleePed(AimedEntity, LocalPlayer().Ped, 15.0, -1)
                                break
                            end

                            timeout = timeout + 1
                            Wait(1000)
                        end
                    end)
                end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		if (AbleToRob and IsControlJustPressed(0, 38) and not IsEntityDead(LastEntity)) then
			local PlayerPed = PlayerPedId()
			local LastEntityCoords = GetEntityCoords(LastEntity)
			local PlayerCoords = GetEntityCoords(PlayerPed)
			local Distance = Vdist(LastEntityCoords.x, LastEntityCoords.y, LastEntityCoords.z, PlayerCoords.x, PlayerCoords.y, PlayerCoords.z)

			if (Distance < 3.5) then
				AbleToRob = false
				Robbing = true

				if (not HasAnimDictLoaded("anim@gangops@morgue@table@")) then
					RequestAnimDict("anim@gangops@morgue@table@")
					while not HasAnimDictLoaded("anim@gangops@morgue@table@") do Wait(0) end
				end

				SetEntityRotation(LastEntity, 0, 0, 90, 0, 0)
				AttachEntityToEntity(PlayerPed, LastEntity, GetEntityBoneIndexByName(LastEntity, "BONETAG_SPINE"), 0.75, 0, 0, 0.0, 0.0, 67.0, false, false, false, true, 0, false)
				TaskPlayAnim(PlayerPed, "anim@gangops@morgue@table@", "player_search", 8.0, -8, 5000, 33, 0, 0, 0, 0)
				
                Wait(5000)

				if (not IsEntityDead(LastEntity)) then
					ClearPedTasksImmediately(LastEntity)
					TaskReactAndFleePed(LastEntity, PlayerPed)
				end

				if (math.random() >= ChanceToGiveKeys) then
                    RageUI.Popup({message = "~g~La personne vous cède les clés"})
                    Atlantiss.Inventory:AddItem({
                        name = "key",
                        data = {
                            plate = GetVehicleNumberPlateText(LastVehicle),
                            vehicleIdentifier = getVehicleIdentifier(LastVehicle)
                        },
                        label = GetVehicleNumberPlateText(LastVehicle)
                    })
					HasKeys = true

                    SetVehicleDoorsLocked(LastVehicle, 1)
                    if (Atlantiss.World.Vehicle.JackedVehicles[LastVehicle] == nil) then table.insert(Atlantiss.World.Vehicle.JackedVehicles, LastVehicle) end
                    callCopsForVehicle(LastVehicle, GetEntityCoords(LastVehicle), HasKilled)
                    SendDiscordWebHook(LastVehicle, GetEntityCoords(LastVehicle), HasKilled)
				else
                    RageUI.Popup({message = "~r~La personne refuse de vous donner les clés"})
					HasKeys = false

                    Citizen.CreateThread(function()
                        local i = 1

                        while true do
                            Wait(1000)
                            if (i >= 30) then break end

                            if (DoesEntityExist(LastEntity) and IsEntityDead(LastEntity)) then
                                RageUI.Popup({message = "~g~Vous avez récupéré les clés"})
                                Atlantiss.Inventory:AddItem({
                                    name = "key",
                                    data = {
                                        plate = GetVehicleNumberPlateText(LastVehicle),
                                        vehicleIdentifier = getVehicleIdentifier(LastVehicle)
                                    },
                                    label = GetVehicleNumberPlateText(LastVehicle)
                                })
                                HasKeys = true
                                HasKilled = true
                                
                                SetVehicleDoorsLocked(LastVehicle, 1)
                                if (Atlantiss.World.Vehicle.JackedVehicles[LastVehicle] == nil) then table.insert(Atlantiss.World.Vehicle.JackedVehicles, LastVehicle) end
                                callCopsForVehicle(LastVehicle, GetEntityCoords(LastVehicle), HasKilled)
                                SendDiscordWebHook(LastVehicle, GetEntityCoords(LastVehicle), HasKilled)
                                break
                            end
                            i = i + 1
                        end
                    end)
				end

				DetachEntity(PlayerPed, false, false)
				StopAnimTask(PlayerPedId(), "anim@gangops@morgue@table@", "player_search", 1.0)
				ClearPedTasksImmediately(PlayerPed)
				ClearPedSecondaryTask(PlayerPed)
				Robbing = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		if (LastVehicle) then
			if (IsPedInAnyVehicle(PlayerPedId(), true)) then
				local PlayerPed = PlayerPedId()

				if (LastVehicle == GetVehiclePedIsIn(PlayerPed, false) and GetPedInVehicleSeat(LastVehicle, -1) and not HasKeys) then
					SetVehicleEngineOn(LastVehicle, false, true, false)
					ClearPedSecondaryTask(PlayerPed)
				end
			end
		end

		if (Robbing) then
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 47, true)
			DisableControlAction(0, 58, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 264, true)
			DisableControlAction(0, 257, true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 141, true)
			DisableControlAction(0, 142, true)
			DisableControlAction(0, 143, true)
		end
	end
end)

Citizen.CreateThread(
    function()
        while (Atlantiss.Player.HasLoaded == false) do Wait(500) end

        local WaitTime = 1250

        while true do
            if (Atlantiss.Illegal.CarRoberry:IsMissionRunning() and Atlantiss.Illegal.CarRoberry.Current.STOLEN_VEHICLE == nil) then
                WaitTime = 250
            else
                WaitTime = 1250
            end

            local tryVehicle = GetVehiclePedIsTryingToEnter(LocalPlayer().Ped)

            if (tryVehicle and DoesEntityExist(tryVehicle)) then
                SetPedStayInVehicleWhenJacked(GetPedInVehicleSeat(tryVehicle, -1), true)

                local veh = tryVehicle
                local mdl, netID = GetEntityModel(veh), VehToNet(veh)
                local vehPlate = GetVehicleNumberPlateText(veh)

                if (
                    (veh == Atlantiss.Illegal.CarRoberry.Current.STOLEN_VEHICLE) or
                    (
                        not IsEntityAMissionEntity(veh) and
                        not Atlantiss.World.Vehicle:IsSpawnedVehicle(netID) and
                        (IsThisModelACar(mdl) or IsThisModelABike(mdl) or IsThisModelAHeli(mdl) or IsThisModelAPlane(mdl)) and
                        not IsThisModelABicycle(mdl)
                    )
                ) then
                    SetPedCanSmashGlass(LocalPlayer().Ped, false, false)

                    if (Atlantiss.Utils:HasValue(Atlantiss.World.Vehicle.JackedVehicles, veh)) then
                        SetVehicleDoorsLockedForAllPlayers(veh, false)
                        SetVehicleDoorsLocked(veh, 1)
                        TriggerPlayerEvent("Atlantiss::CE::Carjacking:LockState", -1, veh, 1)
                        TriggerServerCallback(
                            "Atlantiss::SVCB::World:Vehicle:GetExistingPlates",
                            function(existingPlates)
                                if (vehPlate ~= nil) then
                                    while (Atlantiss.Utils:HasValue(existingPlates, vehPlate)) do
                                        vehPlate = Atlantiss.World.Vehicle:GenerateRandomPlate()
                                    end

                                    SetVehicleNumberPlateText(veh, vehPlate)

                                    if (Atlantiss.Illegal.CarRoberry:IsMissionRunning() and Atlantiss.Illegal.CarRoberry.Current.STOLEN_VEHICLE == veh) then
                                        Atlantiss.Illegal.CarRoberry.Current.VEHICLE_PLATE = vehPlate
                                    end
                                end
                            end
                        )
                    else
                        SetVehicleDoorsLocked(veh, 2)
                    end
                end
            end

            Wait(WaitTime)
        end
    end
)
