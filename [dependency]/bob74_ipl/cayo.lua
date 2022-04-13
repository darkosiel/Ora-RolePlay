local islandVec = vector3(4840.571, -5174.425, 2.0)
Citizen.CreateThread(function()
    while true do
		local pCoords = GetEntityCoords(GetPlayerPed(-1))
			local dist = #(pCoords - islandVec)
			if dist < 2000.0 then
        Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", true)  -- load the map and removes the city
        Citizen.InvokeNative("0x5E1460624D194A38", true) -- load the minimap/pause map and removes the city minimap/pause map
        
        -- misc natives
        Citizen.InvokeNative(0xF74B1FFA4A15FBEA, true)
        Citizen.InvokeNative(0x53797676AD34A9AA, false)    
        SetScenarioGroupEnabled('Heist_Island_Peds', true)

        -- audio stuff
        SetAudioFlag('PlayerOnDLCHeist4Island', true)
        SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
        SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
			else
        Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", false)
        Citizen.InvokeNative("0x5E1460624D194A38", false)
			end
		Citizen.Wait(5000)
    end
end)
