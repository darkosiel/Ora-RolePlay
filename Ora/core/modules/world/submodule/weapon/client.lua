local holstered = true
local canFire = true
local currWeapon = `WEAPON_UNARMED`

function Ora.World.Weapon:PlayAnimationForWeapon(weaponHash)
  if (self.Animation[weaponHash] ~= nil) then
    if DoesEntityExist(LocalPlayer().Ped) and not IsEntityDead(LocalPlayer().Ped) and not IsPedInAnyVehicle(LocalPlayer().Ped, true) then
			Citizen.CreateThread(
				function()
					Wait(100)
					while true do
						Citizen.Wait(0)
						if not canFire then
							DisableControlAction(0, 25, true) -- Aiming
							DisableControlAction(0, 157, true) -- 1
							DisableControlAction(0, 158, true) -- 2
							DisableControlAction(0, 160, true) -- 3
							DisablePlayerFiring(LocalPlayer().Ped, true)
						else
							break
						end
					end
				end
			)

			if currWeapon ~= GetSelectedPedWeapon(LocalPlayer().Ped) then
				pos = GetEntityCoords(LocalPlayer().Ped, true)
				rot = GetEntityHeading(LocalPlayer().Ped)

				local newWeap = GetSelectedPedWeapon(LocalPlayer().Ped)
				SetCurrentPedWeapon(LocalPlayer().Ped, currWeapon, true)
				loadAnimDict( "reaction@intimidation@1h" )

				if CheckWeapon(newWeap) then
					if holstered then
						canFire = false
						TaskPlayAnimAdvanced(LocalPlayer().Ped, "reaction@intimidation@1h", "intro", GetEntityCoords(LocalPlayer().Ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
						Citizen.Wait(1000)
						SetCurrentPedWeapon(LocalPlayer().Ped, newWeap, true)
						currWeapon = newWeap
						Citizen.Wait(2000)
						ClearPedTasks(LocalPlayer().Ped)
						holstered = false
						canFire = true
					elseif newWeap ~= currWeapon and CheckWeapon(currWeapon) then
						canFire = false
						TaskPlayAnimAdvanced(LocalPlayer().Ped, "reaction@intimidation@1h", "outro", GetEntityCoords(LocalPlayer().Ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
						Citizen.Wait(1600)
						SetCurrentPedWeapon(LocalPlayer().Ped, GetHashKey('WEAPON_UNARMED'), true)
						TaskPlayAnimAdvanced(LocalPlayer().Ped, "reaction@intimidation@1h", "intro", GetEntityCoords(LocalPlayer().Ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
						Citizen.Wait(1000)
						SetCurrentPedWeapon(LocalPlayer().Ped, newWeap, true)
						currWeapon = newWeap
						Citizen.Wait(2000)
						ClearPedTasks(LocalPlayer().Ped)
						holstered = false
						canFire = true
					else
						SetCurrentPedWeapon(LocalPlayer().Ped, GetHashKey('WEAPON_UNARMED'), true)
						TaskPlayAnimAdvanced(LocalPlayer().Ped, "reaction@intimidation@1h", "intro", GetEntityCoords(LocalPlayer().Ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
						Citizen.Wait(1000)
						SetCurrentPedWeapon(LocalPlayer().Ped, newWeap, true)
						currWeapon = newWeap
						Citizen.Wait(2000)
						ClearPedTasks(LocalPlayer().Ped)
						holstered = false
						canFire = true
					end
				else
					if not holstered and CheckWeapon(currWeapon) then
						canFire = false
						TaskPlayAnimAdvanced(LocalPlayer().Ped, "reaction@intimidation@1h", "outro", GetEntityCoords(LocalPlayer().Ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
						Citizen.Wait(1600)
						SetCurrentPedWeapon(LocalPlayer().Ped, GetHashKey('WEAPON_UNARMED'), true)
						ClearPedTasks(LocalPlayer().Ped)
						SetCurrentPedWeapon(LocalPlayer().Ped, newWeap, true)
						holstered = true
						canFire = true
						currWeapon = newWeap
					else
						SetCurrentPedWeapon(LocalPlayer().Ped, newWeap, true)
						holstered = false
						canFire = true
						currWeapon = newWeap
					end
				end
			end
		end
  	end
end

function CheckWeapon(newWeap)
  return Ora.World.Weapon.Animation[newWeap]
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
