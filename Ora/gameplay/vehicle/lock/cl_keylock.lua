function OpenCar()
    local vehicle = vehicleFct.GetVehicleInDirection(8.0)
    local closestvehicle = GetClosestVehicle(LocalPlayer().Pos.x, LocalPlayer().Pos.y, LocalPlayer().Pos.z, 4.0, 0, 127)


    if vehicle == 0 and closestvehicle == 0 then
    else
        local ped = LocalPlayer().Ped
        if not IsEntityPlayingAnim(ped, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 3) then
            local prop_name = 'p_car_keys_01'
            IsAnimated = true
            
            if vehicle == 0 then veh = closestvehicle else veh = vehicle end
            local playerPed = LocalPlayer().Ped
            local x, y, z = table.unpack(LocalPlayer().Pos)
            propBox1 = Ora.World.Object:Create(GetHashKey(prop_name), x, y, z + 0.1, true, true, true)
            AttachEntityToEntity(propBox1, playerPed, GetPedBoneIndex(playerPed, 58866), 0.080, 0.012, 0.050, 0.0, 100.0, 300.0, true, false, false, true, 1, true)
            RequestAnimDict("anim@mp_player_intmenu@key_fob@")
            while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
                Citizen.Wait(0)
            end
            TaskPlayAnim(LocalPlayer().Ped, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)

            local plate = GetVehicleNumberPlateText(veh)
            --(json.encode(vehicles.data))
        
            if Ora.Inventory.Data["key"] ~= nil then
                for i = 1 , #Ora.Inventory.Data["key"] , 1 do 
                    local v = Ora.Inventory.Data["key"][i]
                    --print(plate)
                    
                    if plate == v.data.plate then
                        local lock = GetVehicleDoorsLockedForPlayer(veh, ped)
                        --print(lock)
                        NetworkRequestControlOfEntity(veh)
                        SetVehicleDoorsLockedForAllPlayers(veh, not lock)
                        SetVehicleDoorsLockedForPlayer(veh, PlayerId(), not lock)
        
                        ShowNotification("Vous avez " .. (lock and "~g~déverrouillé" or "~r~verrouillé") .. "~w~ votre véhicule.")
                    end
                end

                -- for i = 1 , #vehicles.data, 1 do
                --     --("ok1",vehicles.data[i].plate)
                --     if plate == vehicles.data[i].plate then
                --         --("ok2")
                --         local locked = GetVehicleDoorLockStatus(vehicle)
                --         if locked == 1 or locked == 0 then
                --             -- if unlocked
                --             SetVehicleDoorsLocked(vehicle, 2)
                --             PlayVehicleDoorCloseSound(vehicle, 1)
                --             ShowNotification("Vous avez ~r~fermé~s~ le véhicule.")
                --         elseif locked == 2 then
                --             -- if locked
                --             SetVehicleDoorsLocked(vehicle, 1)
                --             PlayVehicleDoorOpenSound(vehicle, 0)
                --             ShowNotification("Vous avez ~g~ouvert~s~ le véhicule.")
                --         end
                --         break
                --         return
                --     end
                -- end

                -- for i = 1 , #vehicles.preter , 1 do
                --     if plate == vehicles.preter[i].plate then
                --         local locked = GetVehicleDoorLockStatus(vehicle)
                --         if locked == 1 or locked == 0 then
                --             -- if unlocked
                --             SetVehicleDoorsLocked(vehicle, 2)
                --             PlayVehicleDoorCloseSound(vehicle, 1)
                --             ShowNotification("Vous avez ~r~fermé~s~ le véhicule.")
                --         elseif locked == 2 then
                --             -- if locked
                --             SetVehicleDoorsLocked(vehicle, 1)
                --             PlayVehicleDoorOpenSound(vehicle, 0)
                --             ShowNotification("Vous avez ~g~ouvert~s~ le véhicule.")
                --         end
                --         break
                --         return
                --     end
                -- end
            end
            Wait(1000)
            DeleteObject(propBox1)
        else
            Wait(500)
        end
    end
end

RegisterCommand('opencar', function()
    OpenCar()
end, false)
  
RegisterKeyMapping('opencar', 'Verouiller/Déverouiller le véhicule', 'keyboard', 'Y')