guiEnabled = false

Citizen.CreateThread(function()
  while true do
      if guiEnabled then
          DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
          DisableControlAction(0, 2, guiEnabled) -- LookUpDown
          DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
          DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
      else
        Wait(500)
      end
      Citizen.Wait(0) --MH LUA
  end
end)

RegisterNUICallback('escape', function()
  print('close')
  local playerPed = PlayerPedId()
  SetNuiFocus(false)
  guiEnabled = false
  DeleteEntity(tablet)
  ClearPedTasks(playerPed)

end)

RegisterCommand("mdt", function(source, args, rawCommand)
  local playerPed = PlayerPedId()
  if not guiEnabled then
    local dict = "amb@world_human_seat_wall_tablet@female@base"
    RequestAnimDict(dict)

    exports["Ora"]:TriggerServerCallback("Atlantiss::SE::Anticheat:RegisterObject", 
        function()
          tablet = CreateObject(GetHashKey('prop_cs_tablet'), GetEntityCoords(playerPed), 1, 1, 1)
          AttachEntityToEntity(tablet, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
          while not HasAnimDictLoaded(dict) do 
            Citizen.Wait(100) 
          end
          if not IsEntityPlayingAnim(playerPed, dict, 'base', 3) then
            TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
          end
          guiEnabled = true
          SetNuiFocus(true, true)
          SendNUIMessage({type = "enableui", enable = true})
        end,
        GetHashKey('prop_cs_tablet')
    )
  else
    SendNUIMessage({type = "enableui", enable = false})
    SetNuiFocus(false)
    DeleteEntity(tablet)
    ClearPedTasks(playerPed)
    guiEnabled = false
  end
end, false)

AddEventHandler('onClientResourceStart', function(resourceName) --When resource starts, stop the GUI showing. 
  if(GetCurrentResourceName() ~= resourceName) then
    return
  end
end)

--RegisterNetEvent("output")
--AddEventHandler("output", function(argument)
  --  TriggerEvent("chatMessage", "[Success]", {0,255,0}, argument)
--end)