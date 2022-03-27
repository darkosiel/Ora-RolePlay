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

function CreateTaxiPed(vehicle)
	local model = GetHashKey("a_m_y_stlat_01")

	if DoesEntityExist(vehicle) then
		if IsModelValid(model) then
			RequestModel(model)
			while not HasModelLoaded(model) do
				Wait(1)
			end
			canSend = false
			local ped = nil

			exports["Ora"]:TriggerServerCallback("Ora::SE::Anticheat:RegisterPed", 
					function()
						ped = CreatePedInsideVehicle(vehicle, 26, model, -1, true, false)
						SetAmbientVoiceName(ped, "A_M_M_EASTSA_02_LATINO_FULL_01")	
						SetBlockingOfNonTemporaryEvents(ped, true)
						SetEntityAsMissionEntity(ped, true, true)
			
						SetModelAsNoLongerNeeded(model)
						canSend = true
					end,
					model
			)

			local localTime = GetGameTimer()
			
			while (canSend == false and localTime + 5000 > GetGameTimer()) do
					Wait(100)
			end

			return ped
		end
	end
end

function CreateTaxi(x, y, z)
	local taxiModel = GetHashKey("taxi")

	if IsModelValid(taxiModel) then
		if IsThisModelACar(taxiModel) then
			RequestModel(taxiModel)
			while not HasModelLoaded(taxiModel) do
				Wait(1)
			end

			if not DoesEntityExist(taxiVeh) then
				local _, vector = GetNthClosestVehicleNode(x, y, z, math.random(5, 10), 0, 0, 0)
				-- GetClosestVehicleNodeWithHeading(x, y, z, outPosition, outHeading, nodeType, p6, p7)
				local sX, sY, sZ = table.unpack(vector)

				DisplayNotify(i18n.translate("taxi_contact"), i18n.translate("taxi_dispatch"))
				PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
				Wait(2000)

				taxiVeh = nil
				canSend = false

				exports["Ora"]:TriggerServerCallback("Ora::SE::Anticheat:RegisterVehicle", 
						function()
								taxiVeh = CreateVehicle(taxiModel, sX, sY, sZ, 0, true, false)
								canSend = true
						end,
						taxiModel
				)

				local localTime = GetGameTimer()
				while (canSend == false and localTime + 5000 > GetGameTimer()) do
						Wait(100)
				end
		
				if (taxiVeh == nil) then
					DisplayNotify("Taxi", "Le véhicule ne peut pas venir")
					return
				end
		
			
				SetEntityAsMissionEntity(taxiVeh, true, true)
				SetVehicleEngineOn(taxiVeh, true, true, false)
				
				DecorSetBool(taxiVeh, "TAXI_AI", true)

				local blip = AddBlipForEntity(taxiVeh)
				SetBlipSprite(blip, 198)
				SetBlipFlashes(blip, true)
				SetBlipFlashTimer(blip, 5000)

				SetModelAsNoLongerNeeded(taxiModel)

				SetHornEnabled(taxiVeh, true)
				StartVehicleHorn(taxiVeh, 1000, GetHashKey("NORMAL"), false)

				return taxiVeh
			else
				DisplayNotify(i18n.translate("taxi_contact"), i18n.translate("drivers_busy"))
			end
		end
	end	
end

function DeleteTaxi(vehicle, driver)
	if DoesEntityExist(vehicle) then
		if IsPedInVehicle(PlayerPedId(), vehicle, false) then
			TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
			Wait(2000)			
		end

		local blip = GetBlipFromEntity(vehicle)

		if DoesBlipExist(blip) then
			RemoveBlip(blip)
		end

		DeleteEntity(driver)
		DeleteEntity(vehicle)
	end

	if not DoesEntityExist(vehicle) and DoesEntityExist(driver) then
		DeleteEntity(driver)
	end
end

RegisterNetEvent("fs_taxi:payment-status")
AddEventHandler("fs_taxi:payment-status", function(state)
	local player = PlayerId()
	Wait(1200)
	
	if state then
		PlayAmbientSpeech1(taxiPed, "THANKS", "SPEECH_PARAMS_FORCE_NORMAL")
	else
		PlayAmbientSpeech1(taxiPed, "TAXID_NO_MONEY", "SPEECH_PARAMS_FORCE_NORMAL")
		Wait(1000)
		if not IsPlayerWantedLevelGreater(player, 0) then
			SetPlayerWantedLevel(player, 3, false)
			SetPlayerWantedLevelNow(player, true)
			SetDispatchCopsForPlayer(player, true)
		end
	end

	TaskVehicleDriveWander(taxiPed, taxiVeh, 20.0, 319)
	Wait(5000)
	DeleteEntity(taxiVeh)
	DeleteEntity(taxiPed)
	DeleteTaxi(taxiVeh, taxiPed)
	parking = false
	PlayerEntersTaxi = false
end)