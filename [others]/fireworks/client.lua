local box = nil
local animlib = 'anim@mp_fireworks'

function msg(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(false, true)
end

RegisterCommand("sf", function()
	TriggerServerEvent('fireworks')
end)

RegisterCommand("sf2", function()
	TriggerServerEvent('fireworks2')
end)

RegisterCommand("sf3", function()
	TriggerServerEvent('fireworks3')
end)


RegisterNetEvent('frobski-fireworks:start')
AddEventHandler('frobski-fireworks:start', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(663.08, 574.44, 129.04 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(2000)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start2')
AddEventHandler('frobski-fireworks:start2', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(700.25, 560.07, 129.04 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(2000)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start3')
AddEventHandler('frobski-fireworks:start3', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(684.08, 520.94, 130.35 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(2000)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start4')
AddEventHandler('frobski-fireworks:start4', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(652.63, 532.17, 130.35 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(2000)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start5')
AddEventHandler('frobski-fireworks:start5', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(663.08, 574.44, 129.04 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(800)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start6')
AddEventHandler('frobski-fireworks:start6', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(700.25, 560.07, 129.04 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(800)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start7')
AddEventHandler('frobski-fireworks:start7', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(684.08, 520.94, 130.35 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(800)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start8')
AddEventHandler('frobski-fireworks:start8', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(652.63, 532.17, 130.35 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(800)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start9')
AddEventHandler('frobski-fireworks:start9', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(696.14, 565.35, 151.70 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(1500)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start9')
AddEventHandler('frobski-fireworks:start9', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(686.70, 557.06, 152.46 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(1500)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start10')
AddEventHandler('frobski-fireworks:start10', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(672.07, 559.76, 152.46 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(1500)
	until(times == 0)
	box = nil
end)

RegisterNetEvent('frobski-fireworks:start11')
AddEventHandler('frobski-fireworks:start11', function()

        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local ped = GetPlayerPed(-1)
	local times = 20

	Citizen.Wait(1000)
		   
	local firecoords = vec3(670.67, 574.42, 151.70 - 0.98)

	Citizen.Wait(1000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(1500)
	until(times == 0)
	box = nil
end)