function Ora.World.Ped:CreatePedInsideVehicle(vehicle, pedType, modelHash, seat, isNetwork, netMissionEntity)
  local canSend = false
  local ped = nil

  Ora.Utils:RequestAndWAitForModel(modelHash)
  Ora.World:Debug(string.format("Ped ^5%s^3 will be registered as a legit ped", modelHash))
  TriggerServerCallback("Ora::SE::Anticheat:RegisterPed", 
      function()
        ped = CreatePedInsideVehicle(vehicle, pedType, modelHash, seat, isNetwork, netMissionEntity)
        canSend = true
      end,
      modelHash
  )
  
  local localTime = GetGameTimer()
   
  while (canSend == false and localTime + 5000 > GetGameTimer()) do
      Ora.World:Debug(string.format("Ped ^5%s^3 is waiting callback from anticheat", model))
      Wait(100)
  end

  return ped

end

function Ora.World.Ped:Create(pedType, model, position, heading)
  pedType = pedType or 5
  model = model or "a_m_m_prolhost_01"
  position = position or LocalPlayer().Pos
  heading = heading or 0.0
  local modelHash = GetHashKey(model)
  local canSend = false
  local ped = nil

  Ora.Utils:RequestAndWAitForModel(modelHash)
  Ora.World:Debug(string.format("Ped ^5%s^3 will be registered as a legit ped", model))
  TriggerServerCallback("Ora::SE::Anticheat:RegisterPed",
      function()
        ped = CreatePed(pedType, modelHash, position.x, position.y, position.z, heading, true, false)
        SetModelAsNoLongerNeeded(modelHash)
        canSend = true
      end,
      modelHash
  )
  
  local localTime = GetGameTimer()
   
  while (canSend == false and localTime + 5000 > GetGameTimer()) do
      Ora.World:Debug(string.format("Ped ^5%s^3 is waiting callback from anticheat", model))
      Wait(100)
  end

  return ped
end

function Ora.World.Ped:GetRandomNPCAroundPosition(position, radius)
  radius = radius + 0.0 or 50.0

  for outdoorPed in EnumeratePeds() do
      if
          DoesEntityExist(outdoorPed) and not IsEntityDead(outdoorPed) and not IsPedInAnyVehicle(outdoorPed) and
              GetDistanceBetweenCoords(GetEntityCoords(outdoorPed), position) <= radius and
              HasEntityClearLosToEntityInFront(outdoorPed, playerPed) and outdoorPed ~= playerPed and not IsPedAPlayer(outdoorPed)
      then
          return outdoorPed
      end
  end

  return nil
end


function Ora.World.Ped:MakePedCallPoliceAnimation(ped)
  forceAnim({"missfbi3_steve_phone", "steve_phone_idle_b"}, 49, {time = 4000, ped = ped})
end