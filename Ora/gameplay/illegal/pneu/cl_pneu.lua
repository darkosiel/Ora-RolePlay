local function Draw3DText(x, y, z, text)
	--print("Hello")
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*0.75
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	local allowedWeapons = {GetHashKey("WEAPON_KNIFE"), GetHashKey("WEAPON_BOTTLE"), GetHashKey("WEAPON_DAGGER"), GetHashKey("WEAPON_HATCHET"), GetHashKey("WEAPON_MACHETE"), GetHashKey("WEAPON_SWITCHBLADE")}
	local animDict = "melee@knife@streamed_core_fps"
	local animName = "ground_attack_on_spot"
	local unarmedHash = GetHashKey("WEAPON_UNARMED")
	
	while true do
		if LocalPlayer().Weapon ~= unarmedHash then
			local plyPed = LocalPlayer().Ped
			local vehicle = GetClosestVehicleToPlayer()

			if vehicle ~= 0 then
				if CanUseWeapon(allowedWeapons) then
					local closestTire = GetClosestVehicleTire(vehicle)
					if closestTire ~= nil then

						if IsVehicleTyreBurst(vehicle, closestTire.tireIndex, 0) == false then
							Draw3DText(closestTire.bonePos.x, closestTire.bonePos.y, closestTire.bonePos.z, tostring("~r~[E] CREVER PNEU"))
							if IsControlJustPressed(1, 38) then

								RequestAnimDict(animDict)
								while not HasAnimDictLoaded(animDict) do
									Citizen.Wait(100)
								end

								local animDuration = GetAnimDuration(animDict, animName)
								TaskPlayAnim(plyPed, animDict, animName, 8.0, -8.0, animDuration, 15, 1.0, 0, 0, 0)
								Citizen.Wait((animDuration / 2) * 1000)

								-- local driverOfVehicle = GetDriverOfVehicle(vehicle)
								-- local driverServer = GetPlayerServerId(driverOfVehicle)

								if #(LocalPlayer().Pos - GetEntityCoords(vehicle)) < 5.0 then

									local driverServer = GetPlayerServerId(NetworkGetEntityOwner(vehicle))
									local vehicleServerId = NetworkGetEntityNetScriptId(vehicle)
									--print(driverServer, vehicleServerId)
									if driverServer == LocalPlayer().ServerID then
										SetVehicleTyreBurst(vehicle, closestTire.tireIndex, 0, 100.0)
									else
										TriggerServerEvent("SlashTires:TargetClient", driverServer, vehicleServerId, closestTire.tireIndex)
									end
									local fullName = Ora.Identity:GetFullname(LocalPlayer().ServerID)
									local ownerFullname = Ora.Identity:GetFullname(driverServer)
									local vehPos = GetEntityCoords(vehicle)
									local street, crossing = GetStreetNameAtCoord(vehPos.x, vehPos.y, vehPos.z)
									print(street, crossing)
									local names = GetStreetNameFromHashKey(street) .. (crossing ~= 0 and (" / " .. GetStreetNameFromHashKey(crossing)) or "") 
									local plateText = GetVehicleNumberPlateText(vehicle)
									local entityModel = GetEntityModel(vehicle)
									TriggerServerEvent("Ora:sendToDiscord", "Pneu", fullName .. " a crevé le pneu " .. closestTire.tireIndex .. " du véhicule " .. plateText .. " (" .. entityModel .. "). \nL'entité est possédée par : " .. ownerFullname.."\nPosition : " .. vehPos .. "\n("..names..").", 16711680)

									Citizen.Wait((animDuration / 2) * 1000)
									ClearPedTasksImmediately(plyPed)
								end
							end
						end
					end
				end
			else
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(2000)
		end
		Citizen.Wait(0)
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		local ped = PlayerPedId()
-- 		PlayerWeapon = GetSelectedPedWeapon(ped)
-- 		Citizen.Wait(1000.0)
-- 	end
-- end)

RegisterNetEvent("SlashTires:SlashClientTire")
AddEventHandler("SlashTires:SlashClientTire", function(vehicleNetId, tireIndex)
	-- local player = PlayerId()
	-- local plyPed = GetPlayerPed(player)
	local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
	SetVehicleTyreBurst(vehicle, tireIndex, 0, 100.0)
end)

-- function GetDriverOfVehicle(vehicle)
-- 	local dPed = GetPedInVehicleSeat(vehicle, -1)
-- 	for a = 0, 32 do
-- 		if dPed == GetPlayerPed(a) then
-- 			return a
-- 		end
-- 	end
-- 	return -1
-- end

function CanUseWeapon(allowedWeapons)
	-- local player = PlayerId()
	-- local plyPed = GetPlayerPed(player)
	-- local plyCurrentWeapon = GetSelectedPedWeapon(plyPed)
	for k, v in pairs(allowedWeapons) do
		if v == LocalPlayer().Weapon then
			return true
		end
	end
	return false
end

function GetClosestVehicleToPlayer()
	local player = LocalPlayer()
	local plyPos = player.Pos
	local fwdVector = GetEntityMatrix(player.Ped)
	local plyOffset = plyPos+fwdVector*2
	local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z-0.5, 2, player.Ped, 7)
	local retval, hit, endcoords, surfaceNormal, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end

function GetClosestVehicleTire(vehicle)
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	local tireIndex = {
		["wheel_lf"] = 0,
		["wheel_rf"] = 1,
		["wheel_lm1"] = 2,
		["wheel_rm1"] = 3,
		["wheel_lm2"] = 45,
		["wheel_rm2"] = 47,
		["wheel_lm3"] = 46,
		["wheel_rm3"] = 48,
		["wheel_lr"] = 4,
		["wheel_rr"] = 5,
	}
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local minDistance = 1.0
	local closestTire = nil

	for a = 1, #tireBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
		local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, bonePos.x, bonePos.y, bonePos.z)

		if closestTire == nil then
			if distance <= minDistance then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		else
			if distance < closestTire.boneDist then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		end
	end

	return closestTire
end
