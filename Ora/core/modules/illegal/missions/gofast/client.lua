function Ora.Illegal.Gofast:GetMaxTimeForMission()
  return 15
end

function Ora.Illegal.Gofast:SetMissionLevel(missionLevel)
  self.Current.MISSION_LEVEL = missionLevel
end

function Ora.Illegal.Gofast:SetMissionId(missionId)
  self.Current.MISSION_ID = missionId
end

function Ora.Illegal.Gofast:IsMissionRunning()
  return self.Current.RUNNING
end

function Ora.Illegal.Gofast:GetMissionVehicle()
  return self.Current.PLAYER_VEHICLE
end

function Ora.Illegal.Gofast:GetLoadingPosition()
  if self.Current.LOADING_POSITION == nil then
    self.Current.LOADING_POSITION = self.LoadingPositions[math.random(1, #self.LoadingPositions)]
  end

  return self.Current.LOADING_POSITION
end

function Ora.Illegal.Gofast:GetMissionLevel()
  return self.Current.MISSION_LEVEL
end

function Ora.Illegal.Gofast:GetMissionId()
  return self.Current.MISSION_ID
end

function Ora.Illegal.Gofast:GetDeliveryPosition()
  if self.Current.DELIVERY_POSITION == nil then
    self.Current.DELIVERY_POSITION = self.DeliveryPositions[math.random(1, #self.DeliveryPositions)]
  end

  return self.Current.DELIVERY_POSITION
end

function Ora.Illegal.Gofast:LogToDiscord(message, type)
  type = type or "info"
  TriggerServerEvent(
      "Ora:sendToDiscord",
      10,
      "GoFast #" .. Ora.Illegal.Gofast:GetMissionId() .. "\n" .. message, 
      type
  )
end

function Ora.Illegal.Gofast:CanStart()
  return self.Current.RUNNING == false
end

function Ora.Illegal.Gofast:Start()
  if (self:CanStart() == false) then
    ShowNotification(string.format("Vous êtes ~h~déjà~h~ en train de faire un GoFast."))
    return
  end

  self.Current = self:GetEmptyCurrentObject()
  self.Current.RUNNING = true
  self:SetMissionId(GetGameTimer())
  Ora.Illegal.Gofast:LogToDiscord("lance une mission Gofast", "info")
  self:StartCopsCallingThread()
  self:StartHeadingToLoadingZoneThread()
end

function Ora.Illegal.Gofast:Finish()
  if self.Current.BLIP ~= nil then
    RemoveBlip(self.Current.BLIP)
  end
  
  self.Current = self:GetEmptyCurrentObject()
  self.Current.RUNNING = false
end

function Ora.Illegal.Gofast:StartHeadingToLoadingZoneThread()
  ShowNotification(string.format("Rendez vous à la position indiquée pour ~h~charger~h~ la marchandise."))

  local loadingPosition = Ora.Illegal.Gofast:GetLoadingPosition()
  local playerPed = LocalPlayer().Ped

  if (self.Current.BLIP ~= nil) then
    RemoveBlip(self.Current.BLIP)
  end

  self.Current.BLIP = AddBlipForCoord(loadingPosition.pos.x, loadingPosition.pos.y, loadingPosition.pos.z)
  SetBlipRoute(self.Current.BLIP, true)
  SetBlipRouteColour(self.Current.BLIP, 2)

  Citizen.CreateThread(function()
    while Ora.Illegal.Gofast.Current.IS_ON_LOADING_ZONE == false do
      Wait(1000)
      if Ora.Illegal.Gofast.Current.PLAYER_VEHICLE == nil then
        if (IsPedInAnyVehicle(playerPed)) then
          Ora.Illegal.Gofast.Current.PLAYER_VEHICLE = GetVehiclePedIsIn(playerPed)
          Ora.Illegal.Gofast.Current.PLAYER_VEHICLE_PLATE = GetVehicleNumberPlateText(vehicle)
          Ora.Illegal.Gofast:LogToDiscord("Véhicule enregistré pour la mission " .. GetVehicleNumberPlateText(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE), "info")
          ShowNotification(string.format("Le véhicule enregistré pour cette mission est : ~h~%s~h~ ne changez pas.", GetVehicleNumberPlateText(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE)))
        end
      end
      local distanceBetweenCoords = GetDistanceBetweenCoords(loadingPosition.pos.x, loadingPosition.pos.y, loadingPosition.pos.z, LocalPlayer().Pos, true)
      if (distanceBetweenCoords < 5.0) then
        Ora.Illegal.Gofast.Current.IS_ON_LOADING_ZONE = true
        Ora.Illegal.Gofast:StartLoadingCarThread()
      end
    end
  end)
end

function Ora.Illegal.Gofast:GetItemToPutInTrunk()
  return self.Current.ITEM_IN_TRUNK
end

function Ora.Illegal.Gofast:SetItemToPutInTrunk(itemName)
  self.Current.ITEM_IN_TRUNK = itemName
end

function Ora.Illegal.Gofast:StartLoadingCarThread()
  if (self.Current.BLIP ~= nil) then
    RemoveBlip(self.Current.BLIP)
  end

  local loadingPosition = self:GetLoadingPosition()

  Citizen.CreateThread(function()
    while (Ora.Illegal.Gofast.Current.HAS_BEEN_LOADED == false) do
      Wait(500)
      trunkPosition = GetWorldPositionOfEntityBone(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, GetEntityBoneIndexByName(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, "boot"))
      
      if trunkPosition == vector3(0,0,0) then
        trunkPosition = LocalPlayer().Pos
      end

      if (Ora.Illegal.Gofast.Current.HAS_BOX == false) then
        Ora.Illegal.Gofast.Current.HAS_BOX = true
        Ora.Illegal.Gofast.Current.LOADING_PED = Ora.World.Ped:Create(5, "s_m_y_dealer_01", loadingPosition.ped, loadingPosition.heading_ped)
        PlaySimpleForceAnim({"anim@heists@box_carry@", "idle"}, 49, {ped = Ora.Illegal.Gofast.Current.LOADING_PED})
        Ora.Utils:RequestAndWAitForModel("prop_cs_cardbox_01")

        Ora.Illegal.Gofast.Current.BOX = Ora.World.Object:CreateObjectNoOffset("prop_cs_cardbox_01", GetEntityCoords(Ora.Illegal.Gofast.Current.LOADING_PED), true, true, false)
        AttachEntityToEntity(Ora.Illegal.Gofast.Current.BOX, Ora.Illegal.Gofast.Current.LOADING_PED, GetPedBoneIndex(Ora.Illegal.Gofast.Current.LOADING_PED, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0,false,false,false, false, 0, 1 )
        SetModelAsNoLongerNeeded(GetHashKey("prop_cs_cardbox_01"))
      end

      TaskGoToCoordAnyMeans(Ora.Illegal.Gofast.Current.LOADING_PED, trunkPosition, 2.0, 0, 0, 786603, 0xbf800000)
      local loadingPedPosition = GetEntityCoords(Ora.Illegal.Gofast.Current.LOADING_PED)
      distanceToTarget = GetDistanceBetweenCoords(trunkPosition, loadingPedPosition, true)
      TaskGoToCoordAnyMeans(Ora.Illegal.Gofast.Current.LOADING_PED, trunkPosition, 2.0, 0, 0, 786603, 0xbf800000)
      
        if distanceToTarget <= 5.0 and distanceToTarget > 4.0 then 
          TaskGoToCoordAnyMeans(Ora.Illegal.Gofast.Current.LOADING_PED, trunkPosition, 1.0, 0, 0, 786603, 0xbf800000)
        elseif (distanceToTarget <= 3.0 and Ora.Illegal.Gofast.Current.HAS_BEEN_LOADED == false) then
          local timeout = 0
          local vehPlate = GetVehicleNumberPlateText(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE)
          while vehPlate == nil do
              if timeout == 10 then break end
              Wait(100)
              vehPlate = GetVehicleNumberPlateText(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE)
              timeout = timeout + 1
          end
          Ora.Illegal.Gofast:LogToDiscord(string.format("Lancement du chargement du véhicule %s", vehPlate), "info")
          LoadingPrompt("Chargement de la cargaison", 4)
          SetVehicleUndriveable(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, true)
          FreezeEntityPosition(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, true)
          Citizen.Wait(1000)
          SetVehicleDoorOpen(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, 5, false, false)
          TaskTurnPedToFaceCoord(Ora.Illegal.Gofast.Current.LOADING_PED, GetEntityCoords(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE), -1)
          TaskStartScenarioInPlace(Ora.Illegal.Gofast.Current.LOADING_PED, "PROP_HUMAN_BUM_BIN", 0, 1)
          Citizen.Wait(30000)
          if (DoesEntityExist(Ora.Illegal.Gofast.Current.BOX)) then
            DeleteEntity(Ora.Illegal.Gofast.Current.BOX)
            Ora.Illegal.Gofast.Current.BOX = nil
          end
          ClearPedTasks(Ora.Illegal.Gofast.Current.LOADING_PED)
          Ora.World.Vehicle:AddItemIntoTrunk(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, Ora.Illegal.Gofast:GetItemToPutInTrunk())
          SetVehicleDoorShut(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, 5, false, false)
          SetVehicleUndriveable(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, false)
          FreezeEntityPosition(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, false)
          RemoveLoadingPrompt()
        
          Ora.Illegal.Gofast:LogToDiscord("Véhicule " .. GetVehicleNumberPlateText(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE) .. " chargé", "success")
          TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = Ora.Illegal.Gofast.Current.LOADING_PED, network_id = NetworkGetNetworkIdFromEntity(Ora.Illegal.Gofast.Current.LOADING_PED), seconds = 30})
          Ora.Illegal.Gofast.Current.LOADING_PED = nil
          TaskGoToCoordAnyMeans(Ora.Illegal.Gofast.Current.LOADING_PED, loadingPosition.ped, 1.0, 0, 0, 786603, 0xbf800000)
          Ora.Illegal.Gofast.Current.HAS_BEEN_LOADED = true
          Ora.Illegal.Gofast.Current.HAS_BOX = false
          Ora.Illegal.Gofast:StartHeadingToDeliveryZoneThread()

          Citizen.SetTimeout(math.random(15000, 30000), function()
            if (math.random(1,10) > 0) then
              Ora.Illegal.Gofast:CallPolice("Un voisin a vu une voiture se faire remplir de matiere louche")
            end
          end)
        

        end
    end
  end)
end

function Ora.Illegal.Gofast:StartHeadingToDeliveryZoneThread()
  local deliveryPosition = self:GetDeliveryPosition()
  local playerPed = LocalPlayer().Ped

  if (self.Current.BLIP ~= nil) then
    RemoveBlip(self.Current.BLIP)
  end

  self.Current.BLIP = AddBlipForCoord(deliveryPosition.pos.x, deliveryPosition.pos.y, deliveryPosition.pos.z)
  SetBlipRoute(self.Current.BLIP, true)
  SetBlipRouteColour(self.Current.BLIP, 2)

  ShowNotification(string.format("Amène le ~h~chargement~h~ au point de livraison."))

  Citizen.SetTimeout(math.random(60000, 90000), function()
    if (math.random(1,10) > 0) then
      Ora.Illegal.Gofast:CallPolice("Le véhicule suspect est passé par ici")
    end
  end)


  Citizen.CreateThread(function()
    while Ora.Illegal.Gofast.Current.IS_ON_DELIVERY_ZONE == false do
      Wait(1000)
     
      local distanceBetweenCoords = GetDistanceBetweenCoords(deliveryPosition.pos.x, deliveryPosition.pos.y, deliveryPosition.pos.z, LocalPlayer().Pos, true)
      if (distanceBetweenCoords < 5.0) then
        local veh = GetVehiclePedIsUsing(LocalPlayer().Ped)

        if (Ora.Illegal.Gofast.Current.PLAYER_VEHICLE ~= veh) then
          ShowNotification(string.format("Véhicule attendu : %s, Véhicule actuel : %s.", GetVehicleNumberPlateText(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE), GetVehicleNumberPlateText(veh)))
        else
          Ora.Illegal.Gofast.Current.IS_ON_DELIVERY_ZONE = true
          Ora.Illegal.Gofast:StartDeliveryThread()
        end
      end
    end
  end)
end

function Ora.Illegal.Gofast:StartDeliveryThread()

  if (self.Current.BLIP ~= nil) then
    RemoveBlip(self.Current.BLIP)
  end

  ShowNotification(string.format("Patiente pendant le ~h~déchargement~h~ de la marchandise."))

  if (self.Current.BLIP ~= nil) then
    RemoveBlip(self.Current.BLIP)
  end

  local deliveryPosition = self:GetDeliveryPosition()

  Citizen.CreateThread(function()
    while (Ora.Illegal.Gofast.Current.HAS_BEEN_DELIVERED == false) do
      Wait(500)

      if (Ora.Illegal.Gofast.Current.HAS_BOX == false) then
        Ora.Illegal.Gofast.Current.HAS_BOX = true
        Ora.Illegal.Gofast.Current.UNLOADING_PED = Ora.World.Ped:Create(5, "s_m_y_dealer_01", deliveryPosition.ped, deliveryPosition.heading_ped)
      end

      trunkPosition = GetWorldPositionOfEntityBone(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, GetEntityBoneIndexByName(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, "boot"))
      
      if trunkPosition == vector3(0,0,0) then
        trunkPosition = LocalPlayer().Pos
      end

      TaskGoToCoordAnyMeans(Ora.Illegal.Gofast.Current.UNLOADING_PED, trunkPosition, 2.0, 0, 0, 786603, 0xbf800000)
      local unloadingPedPosition = GetEntityCoords(Ora.Illegal.Gofast.Current.UNLOADING_PED)
      distanceToTarget = GetDistanceBetweenCoords(trunkPosition, unloadingPedPosition, true)
      TaskGoToCoordAnyMeans(Ora.Illegal.Gofast.Current.UNLOADING_PED, trunkPosition, 2.0, 0, 0, 786603, 0xbf800000)
      
        if distanceToTarget <= 5.0 and distanceToTarget > 4.0 then 
          TaskGoToCoordAnyMeans(Ora.Illegal.Gofast.Current.UNLOADING_PED, trunkPosition, 1.0, 0, 0, 786603, 0xbf800000)
        elseif (distanceToTarget <= 3.0 and Ora.Illegal.Gofast.Current.HAS_BEEN_DELIVERED == false) then
          Ora.Illegal.Gofast:LogToDiscord("Déchargement du véhicule " .. GetVehicleNumberPlateText(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE), "info")
          LoadingPrompt("Déchargement de la cargaison", 4)
          SetVehicleUndriveable(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, true)
          FreezeEntityPosition(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, true)
          Citizen.Wait(1000)
          SetVehicleDoorOpen(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, 5, false, false)
          TaskTurnPedToFaceCoord(Ora.Illegal.Gofast.Current.UNLOADING_PED, GetEntityCoords(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE), -1)
          TaskStartScenarioInPlace(Ora.Illegal.Gofast.Current.UNLOADING_PED, "PROP_HUMAN_BUM_BIN", 0, 1)
          Citizen.Wait(20000)
          if (DoesEntityExist(Ora.Illegal.Gofast.Current.BOX)) then
            DeleteEntity(Ora.Illegal.Gofast.Current.BOX)
            Ora.Illegal.Gofast.Current.BOX = nil
          end
          ClearPedTasks(Ora.Illegal.Gofast.Current.UNLOADING_PED)

          PlaySimpleForceAnim({"anim@heists@box_carry@", "idle"}, 49, {ped = Ora.Illegal.Gofast.Current.UNLOADING_PED})
          Ora.Utils:RequestAndWAitForModel("prop_cs_cardbox_01")
          Ora.Illegal.Gofast.Current.BOX = Ora.World.Object:CreateObjectNoOffset("prop_cs_cardbox_01", GetEntityCoords(Ora.Illegal.Gofast.Current.UNLOADING_PED), true, true, false)
          AttachEntityToEntity(Ora.Illegal.Gofast.Current.BOX, Ora.Illegal.Gofast.Current.UNLOADING_PED, GetPedBoneIndex(Ora.Illegal.Gofast.Current.UNLOADING_PED, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0,false,false,false, false, 0, 1 )
          SetModelAsNoLongerNeeded(GetHashKey("prop_cs_cardbox_01"))
    
          Ora.World.Vehicle:RemoveAllItemsNameFromTrunk(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, Ora.Illegal.Gofast:GetItemToPutInTrunk())
          SetVehicleDoorShut(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, 5, false, false)
          SetVehicleUndriveable(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, false)
          FreezeEntityPosition(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE, false)
          RemoveLoadingPrompt()

          Ora.Illegal.Gofast:LogToDiscord("Véhicule " .. GetVehicleNumberPlateText(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE) .. " a été déchargé", "success")
          TaskGoToCoordAnyMeans(Ora.Illegal.Gofast.Current.UNLOADING_PED, deliveryPosition.ped, 1.0, 0, 0, 786603, 0xbf800000)
          Ora.Illegal.Gofast.Current.HAS_BEEN_DELIVERED = true

          if (DoesEntityExist(Ora.Illegal.Gofast.Current.BOX)) then
            DeleteEntity(Ora.Illegal.Gofast.Current.BOX)
            Ora.Illegal.Gofast.Current.BOX = nil
          end

          if (DoesEntityExist(Ora.Illegal.Gofast.Current.UNLOADING_PED)) then
            DeleteEntity(Ora.Illegal.Gofast.Current.UNLOADING_PED)
            Ora.Illegal.Gofast.Current.UNLOADING_PED = nil
          end
          Ora.Illegal.Gofast:GetRewards()

        end
    end
  end)

end

function Ora.Illegal.Gofast:GetRewards()
  if (self:IsMissionRunning()) then
    local veh = GetVehiclePedIsUsing(LocalPlayer().Ped)
    if (self.Current.PLAYER_VEHICLE == nil or (veh ~= nil and self.Current.PLAYER_VEHICLE == veh)) then
        TriggerServerCallback("Ora::SE::RetrieveMissionById", function(mission)
            local currentMission = mission
            TriggerEvent("Ora:illegal:counterStop")
            local playerCoords = LocalPlayer().Pos
            ShowAdvancedNotification(
                "Josh",
                "~b~Dialogue",
                "Merci on va faire affaire plus souvent nous deux !",
                "CHAR_LESTER",
                1
            )
          

            local f = false
            for i = 1, #currentMission.participant, 1 do
                if
                    currentMission.participant[i] ==
                        GetPlayerServerId(PlayerId())
                    then
                    f = true
                    break
                end
            end

            for k, v in pairs(currentMission.rewards) do
                if k == "xp" then
                    local xp = math.random(v[1], v[2])
                    if f then
                        for i = 1, #currentMission.participant, 1 do
                            TriggerPlayerEvent(
                                "XNL_NET:AddPlayerXP",
                                currentMission.participant[i],
                                math.floor(xp / #currentMission.participant)
                            )
                        end
                    end
                end

                if k == "money" then
                    local r = math.random(v.amount[1], v.amount[2])
                    Ora.Illegal.Gofast:LogToDiscord("Gain de " .. r .. "$", "success")

                    TriggerServerCallback(
                      "Ora::SE::Money:AuthorizePayment", 
                      function(token)
                        TriggerServerEvent(Ora.Payment.Fake:GetServerEventName(), {TOKEN = token, AMOUNT = r, SOURCE = "Gofast", LEGIT = false})
                        TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", r, false)
                      end,
                      {}
                    )

                    ShowNotification(string.format("Merci pour ta collaboration, tu gagnes %s $", r))
                end

                if k == "items" then
                  Ora.Inventory:AddItems(v)
                end
            end
            TriggerServerEvent("missionEnd", currentMission)
            TriggerServerEvent("MissionFinished", currentMission)
            self:Finish()
            end,
            Ora.Illegal.Gofast:GetMissionId()
        )
    else 
        if (DoesEntityExist(veh)) then
          ShowAdvancedNotification(
              "Josh",
              "~b~Dialogue",
              "C'est pas la voiture que j'attendais.",
              "CHAR_LESTER",
              1
          )
          Ora.Illegal.Gofast:LogToDiscord("La plaque de la voiture n'est pas la bonne", "error")
          ShowNotification(string.format("Véhicule attendu : %s, véhicule sur place : %s", GetVehicleNumberPlateText(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE), GetVehicleNumberPlateText(veh)))
        else
          Ora.Illegal.Gofast:LogToDiscord("Ne semble pas être dans une voiture", "error")
          ShowAdvancedNotification(
              "Josh",
              "~b~Dialogue",
              "Tu te fous de ma gueule ? Y'a aucune voiture",
              "CHAR_LESTER",
              1
          )
        end
    end
  end
end

function Ora.Illegal.Gofast:StartCopsCallingThread()
  Citizen.CreateThread(function()
    while self.Current.RUNNING == true do
      Citizen.Wait(math.random(1000 * 90, 1000 * 120))
      if (Ora.Illegal.Gofast.Current.PLAYER_VEHICLE ~= nil and Ora.Illegal.Gofast.Current.HAS_BEEN_LOADED == true) then
        local myPed = LocalPlayer().Ped
        local entitySpeed = GetEntitySpeed(Ora.Illegal.Gofast.Current.PLAYER_VEHICLE) * 3.6
  
        if entitySpeed > 145.0 then
          self:LogToDiscord("S'est fait flasher par un radar", "info")
          self:CallPolice("Véhicule recherché : radar automatique a " .. math.ceil(entitySpeed) .. " km/h")
        end
      end
    end
  end)
end

function Ora.Illegal.Gofast:CallPolice(message)
  local vehicle = self.Current.PLAYER_VEHICLE
  local vehiclePosition = GetEntityCoords(vehicle)
  TriggerServerEvent(
      "call:makeCall2",
      "police",
      vehiclePosition,
      message .. string.format(" - immat : %s", GetVehicleNumberPlateText(vehicle))
  )

  TriggerServerEvent(
      "call:makeCall2",
      "lssd",
      vehiclePosition,
      message .. string.format(" - immat : %s", GetVehicleNumberPlateText(vehicle))
  )
end