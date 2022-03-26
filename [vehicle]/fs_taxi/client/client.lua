--[[
            fs_taxi - Taxi service for FiveM Servers
              Copyright (C) 2018  FiveM-Scripts

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program in the file "LICENSE".  If not, see <http://www.gnu.org/licenses/>.
]]
local entityEnumerator = {
  __gc = function(enum)
      if enum.destructor and enum.handle then
          enum.destructor(enum.handle)
      end

      enum.destructor = nil
      enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(
      function()
          local iter, id = initFunc()
          if not id or id == 0 then
              disposeFunc(iter)
              return
          end

          local enum = {handle = iter, destructor = disposeFunc}
          setmetatable(enum, entityEnumerator)

          local next = true
          repeat
              coroutine.yield(id)
              next, id = moveFunc(iter)
          until not next

          enum.destructor, enum.handle = nil, nil
          disposeFunc(iter)
      end
  )
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local function GetVehicles()
  local vehicles = {}

  for vehicle in EnumerateVehicles() do
      table.insert(vehicles, vehicle)
  end

  return vehicles
end

local function GetVehiclesInArea(coords, area)
  local vehicles = GetVehicles()
  local vehiclesInArea = {}

  for i = 1, #vehicles, 1 do
      local vehicleCoords = GetEntityCoords(vehicles[i])
      local distance = #(vehicleCoords - coords)
      if distance <= area then
          table.insert(vehiclesInArea, vehicles[i])
      end
  end
  return vehiclesInArea
end

local cancel = false
local intravel = false
--- vars
IsDestinationSet = false
parking = false

taxiBlip = nil
taxiVeh = nil
taxiPed = nil
PlayerEntersTaxi = false

z = nil

function DisplayHelpMsg(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandDisplayHelp(0, false, 1, -1)
end

function DisplayNotify(title, text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	SetNotificationMessage("CHAR_TAXI", "CHAR_TAXI", true, 1, GetLabelText("CELL_E_248"), title, text);
	DrawNotification(true, false)
end

function notify(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, true)
end

function getGroundZ(x, y, z)
  local result, groundZ = GetGroundZFor_3dCoord(x+0.0, y+0.0, z+0.0, Citizen.ReturnResultAnyway())
  return groundZ
end

RegisterNetEvent("gcphone:taxicall")
AddEventHandler("gcphone:taxicall", function()
	local playerPed = PlayerPedId()

	if not intravel then
		if not IsPedInAnyVehicle(playerPed, false) or not IsPedInAnyTaxi(playerPed) then
			Px, Py, Pz = table.unpack(GetEntityCoords(playerPed))

			taxiVeh = CreateTaxi(Px, Py, Pz)
			while not DoesEntityExist(taxiVeh) do
				Wait(1)
			end

			taxiPed = CreateTaxiPed(taxiVeh)
			while not DoesEntityExist(taxiPed) do
				Wait(1)
			end

			TaskVehicleDriveToCoord(taxiPed, taxiVeh, Px, Py, Pz, 23.0, 0, GetEntityModel(taxiVeh), 283, 10.0)
			SetDriverAbility(taxiPed, 1.0)
			SetDriverAggressiveness(taxiPed, 0.7)
			--SetDriveTaskDrivingStyle(taxiPed, 283)
			SetDriveTaskDrivingStyle(taxiPed, 447)
			SetPedKeepTask(taxiPed, true)
			intravel = true
		end
	end
end)

--[[ RegisterCommand('taxi', function()
	local playerPed = PlayerPedId()

	if not DoesEntityExist(taxiVeh) then 
		if not IsPedInAnyVehicle(playerPed, false) or not IsPedInAnyTaxi(playerPed) then
			Px, Py, Pz = table.unpack(GetEntityCoords(playerPed))

			taxiVeh = CreateTaxi(Px, Py, Pz)
			while not DoesEntityExist(taxiVeh) do
				Wait(1)
			end

			taxiPed = CreateTaxiPed(taxiVeh)
			while not DoesEntityExist(taxiPed) do
				Wait(1)
			end

			TaskVehicleDriveToCoord(taxiPed, taxiVeh, Px, Py, Pz, 23.0, 0, GetEntityModel(taxiVeh), 283, 10.0)
			SetDriverAbility(taxiPed, 1.0)
			SetDriverAggressiveness(taxiPed, 0.7)
			SetDriveTaskDrivingStyle(taxiPed, 283)
			SetPedKeepTask(taxiPed, true)
			
		end
	end
end)
 ]]

local function ButtonMessage(text)
	BeginTextCommandScaleformString("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandScaleformString()
end

local function Button(ControlButton) N_0xe83a3e3557a56640(ControlButton) end

local function setupScaleform(scaleform)
	local scaleform = RequestScaleformMovie(scaleform)
	while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
	end
	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(2)
	Button(GetControlInstructionalButton(2, 51, true))
	ButtonMessage("Pour démarrer")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(1)
	Button(GetControlInstructionalButton(2, 299, true)) -- The button to display
	ButtonMessage("Pour arrêter la course") -- the message to display next to it
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(80)
	PopScaleformMovieFunctionVoid()

	return scaleform
end

Citizen.CreateThread(function()
	local TaxiInfoTimer = GetGameTimer()
	while true do
		Citizen.Wait(1)
		player = PlayerId()
		playerPed = PlayerPedId()

		if DoesEntityExist(taxiVeh) and intravel then 
			Px, Py, Pz = table.unpack(GetEntityCoords(playerPed))
			vehX, vehY, vehZ = table.unpack(GetEntityCoords(taxiVeh))
			DistanceBetweenTaxi = GetDistanceBetweenCoords(Px, Py, Pz, vehX, vehY, vehZ, true)

			--[[ if IsVehicleStuckOnRoof(taxiVeh) or IsEntityUpsidedown(taxiVeh) or IsEntityDead(taxiVeh) or IsEntityDead(taxiPed) then
				DeleteVehicle(taxiVeh)
				DeletePed(taxiPed)
				intravel = false
				notify("Votre taxi a eu un contretemps, appelez-en un autre.")
			end ]]

			if DoesEntityExist(taxiVeh) and not DoesEntityExist(taxiPed) and not IsVehicleSeatFree(taxiVeh, -1) then
				taxiPed = GetPedInVehicleSeat(taxiVeh, -1)
			elseif DoesEntityExist(taxiPed) and not IsPedInVehicle(taxiPed, taxiVeh, false) then
				DeletePed(taxiPed)
				if DoesEntityExist(taxiVeh) then DeleteVehicle(taxiVeh) end
				intravel = false
				notify("Votre taxi a eu un contretemps, appelez-en un autre.")
			elseif DoesEntityExist(taxiVeh) and (not DoesEntityExist(taxiPed) or not IsPedInVehicle(taxiPed, taxiVeh, false)) then
				DeleteVehicle(taxiVeh)
				if DoesEntityExist(taxiPed) then DeletePed(taxiPed) end
				intravel = false
				notify("Votre taxi a eu un contretemps, appelez-en un autre.")
			end

			if DistanceBetweenTaxi <= 20.0 then
				if not IsPedInAnyVehicle(playerPed, false) then
					if IsControlJustPressed(0, 23) then
						TaskEnterVehicle(playerPed, taxiVeh, -1, 2, 1.0, 1, 0)
						PlayerEntersTaxi = true
						TaxiInfoTimer = GetGameTimer()
					end
				else
					if IsPedInVehicle(playerPed, taxiVeh, false) then
						DrawScaleformMovieFullscreen(setupScaleform("instructional_buttons"), 255, 255, 255, 255, 0)
						local blip = GetBlipFromEntity(taxiVeh)
						if DoesBlipExist(blip) then
							RemoveBlip(blip)
						end

						if IsControlJustPressed(1, 51) then
							if not DoesBlipExist(GetFirstBlipInfoId(8)) then
								notify("Veuillez mettre une destination")	
							end
						end

						if IsControlJustPressed(1, 299) then -- arrow down
							PlayAmbientSpeech1(taxiPed, "GENERIC_BYE", "SPEECH_PARAMS_FORCE_NORMAL")
							if not parking then
								Wait(1250)
								ClearPedTasks(taxiPed)
								PlayAmbientSpeech1(taxiPed, "TAXID_CLOSE_AS_POSS", "SPEECH_PARAMS_FORCE_NORMAL")
								TaskVehicleTempAction(taxiPed, taxiVeh, 6, 2000)
								SetVehicleHandbrake(taxiVeh, true)
								SetVehicleEngineOn(taxiVeh, false, true, false)
								SetPedKeepTask(taxiPed, true)
								TaskLeaveVehicle(playerPed, taxiVeh, 512)
								Wait(4500)
								parking = true
								TriggerEvent("gcphone:canceltaxi")
								TriggerServerEvent("Taxi:Finished", NetworkGetNetworkIdFromEntity(taxiVeh), NetworkGetNetworkIdFromEntity(taxiPed))
								TriggerServerEvent("entreprise:Add", "taxi", 50)
								Citizen.CreateThread(function()
									while true do
										Wait(1000)
										if distance3D(GetEntityCoords(taxiVeh, true), vector3(901.59, -145.12, 76.61)) <= 150.0 then
											TaskVehiclePark(taxiPed, taxiVeh, 901.59, -145.12, 76.61, 149.02, 1, 1.0, false)
										end
										if not DoesEntityExist(taxiVeh) and not DoesEntityExist(taxiPed) then break end
									end
								end)
							end
						end

						if not DoesBlipExist(GetFirstBlipInfoId(8)) then
							if PlayerEntersTaxi then
								PlayAmbientSpeech1(taxiPed, "TAXID_WHERE_TO", "SPEECH_PARAMS_FORCE_NORMAL")
								PlayerEntersTaxi = false
							end

							if GetGameTimer() > TaxiInfoTimer + 1000 and GetGameTimer() < TaxiInfoTimer + 10000 then
								DisplayHelpMsg(i18n.translate("info_waypoint_message"))
							end
						elseif DoesBlipExist(GetFirstBlipInfoId(8)) then
							dx, dy, dz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, GetFirstBlipInfoId(8), Citizen.ResultAsVector()))
							z = getGroundZ(dx, dy, dz)

							if IsControlJustPressed(1, 51) then
								if not IsDestinationSet then
									disttom = CalculateTravelDistanceBetweenPoints(Px, Py, Pz, dx, dy, z)
									IsDestinationSet = true
								end

								PlayAmbientSpeech1(taxiPed, "TAXID_BEGIN_JOURNEY", "SPEECH_PARAMS_FORCE_NORMAL")
								TaskVehicleDriveToCoord(taxiPed, taxiVeh, dx, dy, z, 23.0, 0, GetEntityModel(taxiVeh), 283, 50.0)
								SetPedKeepTask(taxiPed, true)
							elseif IsControlJustPressed(1, 179) then
								if not IsDestinationSet then
									disttom = CalculateTravelDistanceBetweenPoints(Px, Py, Pz, dx, dy, z)
									IsDestinationSet = true
								end
								
								PlayAmbientSpeech1(taxiPed, "TAXID_SPEED_UP", "SPEECH_PARAMS_FORCE_NORMAL")
								
								TaskVehicleDriveToCoord(taxiPed, taxiVeh, dx, dy, z, 29.0, 0, GetEntityModel(taxiVeh), 318, 50.0)
								SetDriverAbility(taxiPed, 1.0)
								SetDriverAggressiveness(taxiPed, 0.7)
								SetDriveTaskDrivingStyle(taxiPed, 283)
								SetPedKeepTask(taxiPed, true)
							elseif distance3D(GetEntityCoords(playerPed, true), vector3(dx, dy, z)) <= 57.0 then
								if not parking then
									ClearPedTasks(taxiPed)
									PlayAmbientSpeech1(taxiPed, "TAXID_CLOSE_AS_POSS", "SPEECH_PARAMS_FORCE_NORMAL")
									TaskVehicleTempAction(taxiPed, taxiVeh, 6, 2000)
									SetVehicleHandbrake(taxiVeh, true)
									SetVehicleEngineOn(taxiVeh, false, true, false)
									SetPedKeepTask(taxiPed, true)
									TaskLeaveVehicle(playerPed, taxiVeh, 512)
									Wait(4500)
									parking = true
									TriggerEvent("gcphone:canceltaxi")
									TriggerServerEvent("Taxi:Finished", NetworkGetNetworkIdFromEntity(taxiVeh), NetworkGetNetworkIdFromEntity(taxiPed))
									TriggerServerEvent("entreprise:Add", "taxi", 50)
									Citizen.CreateThread(function()
										while true do
											Wait(1000)
											if distance3D(GetEntityCoords(taxiVeh, true), vector3(901.59, -145.12, 76.61)) <= 150.0 then
												TaskVehiclePark(taxiPed, taxiVeh, 901.59, -145.12, 76.61, 149.02, 1, 1.0, false)
											end
											if not DoesEntityExist(taxiVeh) and not DoesEntityExist(taxiPed) then break end
										end
									end)
								end
							end
						end
					end
				end
			end
		else 
			Wait(500)
		end
	end
end)

function distance3D(coords1, coords2)
	return #(coords1 - coords2)
end

RegisterNetEvent("gcphone:canceltaxi")
AddEventHandler("gcphone:canceltaxi", function()
	if DoesEntityExist(taxiVeh) then
		TaskVehicleDriveToCoordLongrange(taxiPed, taxiVeh, 901.59, -145.12, 76.61, 15.0, 283, 50)
		SetDriverAbility(taxiPed, 1.0)
		SetDriverAggressiveness(taxiPed, 0.0)
		SetDriveTaskDrivingStyle(taxiPed, 283)
		SetPedKeepTask(taxiPed, true)
		cancel = true
		intravel = false
		parking = false
		local blip = GetBlipFromEntity(taxiVeh)
		if DoesBlipExist(blip) then RemoveBlip(blip) end
		canceltaxi()
	else
		notify("Vous n'avez pas commandé de taxi")
	end
end)

function canceltaxi()
	local ltaxiVeh = taxiVeh
	local ltaxiPed = taxiPed
	while cancel do
		local distance = distance3D(GetEntityCoords(ltaxiVeh), vector3(901.59, -145.12, 76.61))
		Wait(1000)

		if not DoesEntityExist(ltaxiPed) then
			DeleteVehicle(ltaxiVeh)
			cancel = false
		elseif DoesEntityExist(ltaxiPed) and not IsPedInVehicle(ltaxiPed, ltaxiVeh, false) then
			DeletePed(ltaxiPed)
			if DoesEntityExist(ltaxiVeh) then
				DeleteVehicle(ltaxiVeh)
			end
			cancel = false
		elseif DoesEntityExist(ltaxiVeh) and (not DoesEntityExist(ltaxiPed) or not IsPedInVehicle(ltaxiPed, taxiVeh, false)) then
			DeleteVehicle(ltaxiVeh)
			if DoesEntityExist(taxiPed) then
				DeletePed(ltaxiPed)
			end
			cancel = false
		end

		if distance < 6.0 then
			DeleteVehicle(ltaxiVeh)
			DeletePed(ltaxiPed)
      cancel = false
    end
  end
end

RegisterNetEvent("Taxi:deleteEm")
AddEventHandler("Taxi:deleteEm", function(_veh, _ped)
	local veh = NetworkGetEntityFromNetworkId(_veh)
	local ped = NetworkGetEntityFromNetworkId(_ped)
	if DoesEntityExist(ped) then DeletePed(ped) end
	if DoesEntityExist(veh) then DeleteVehicle(veh) end
end)

Citizen.CreateThread(function()
	DecorRegister("TAXI_AI", 2)
	Wait(500)
	local thash = GetHashKey("taxi")
	while true do
		Wait(20000)
		if #(GetEntityCoords(PlayerPedId()) - vector3(901.59, -145.12, 76.61)) < 150 then
			local vehTaxi = GetVehiclesInArea(vector3(901.59, -145.12, 76.61), 20.0)
			if #vehTaxi > 0 then
				for i = 1, #vehTaxi, 1 do
					if not IsVehicleSeatFree(vehTaxi[i], -1) and DecorGetBool(vehTaxi[i], "TAXI_AI") then
						DeleteEntity(GetPedInVehicleSeat(vehTaxi[i], -1))
					end
					if DoesEntityExist(vehTaxi[i]) and GetEntityModel(vehTaxi[i]) == thash and DecorGetBool(vehTaxi[i], "TAXI_AI") then
						DeleteEntity(vehTaxi[i])
					end
				end
			end
		end
		local vehTaxiOnP = GetVehiclesInArea(GetEntityCoords(PlayerPedId()), 20.0)
		if #vehTaxiOnP > 0 then
			for i = 1, #vehTaxiOnP, 1 do
				if DoesEntityExist(vehTaxiOnP[i]) and GetEntityModel(vehTaxiOnP[i]) == thash and DecorGetBool(vehTaxiOnP[i], "TAXI_AI") and IsVehicleSeatFree(vehTaxiOnP[i], -1) then
					DeleteEntity(vehTaxiOnP[i])
				end
			end
		end
	end
end)
