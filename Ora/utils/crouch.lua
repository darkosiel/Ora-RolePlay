local crouched = false

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if IsControlPressed(0, 61) then DisableControlAction(0, 26, true) end
		if (IsControlPressed(0, 26) or IsDisabledControlJustPressed(0, 26)) and IsControlPressed(0, 61) then
			local ped = GetPlayerPed(-1)
			if DoesEntityExist(ped) and not IsEntityDead(ped) then
				RequestAnimSet("move_ped_crouched")
				RequestAnimSet("MOVE_M@TOUGH_GUY@")
				
				while (not HasAnimSetLoaded("move_ped_crouched")) do 
					Citizen.Wait(100)
				end

				while (not HasAnimSetLoaded("MOVE_M@TOUGH_GUY@")) do 
					Citizen.Wait(100)
				end

				if crouched then 
					ResetPedMovementClipset(ped, 0)
					ResetPedStrafeClipset(ped)
					SetPedMovementClipset(ped, "MOVE_M@TOUGH_GUY@", 0.5)
					Wait(500)
					ResetPedMovementClipset(ped, 0)
					crouched = false 
				elseif not crouched then
					SetPedMovementClipset(ped, "move_ped_crouched", 0.55)
					SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
					crouched = true 
				end
			end
		end    
	end
end)
