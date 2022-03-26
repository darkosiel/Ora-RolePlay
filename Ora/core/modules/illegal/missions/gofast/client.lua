function Atlantiss.Illegal.Gofast:GetMaxTimeForMission()
  return 15
end

function Atlantiss.Illegal.Gofast:SetMissionLevel(missionLevel)
  self.Current.MISSION_LEVEL = missionLevel
end

function Atlantiss.Illegal.Gofast:SetMissionId(missionId)
  self.Current.MISSION_ID = missionId
end

function Atlantiss.Illegal.Gofast:IsMissionRunning()
  return self.Current.RUNNING
end

function Atlantiss.Illegal.Gofast:GetMissionVehicle()
  return self.Current.PLAYER_VEHICLE
end

function Atlantiss.Illegal.Gofast:GetLoadingPosition()
  if self.Current.LOADING_POSITION == nil then
    self.Current.LOADING_POSITION = self.LoadingPositions[math.random(1, #self.LoadingPositions)]
  end

  return self.Current.LOADING_POSITION
end

function Atlantiss.Illegal.Gofast:GetMissionLevel()
  return self.Current.MISSION_LEVEL
end

function Atlantiss.Illegal.Gofast:GetMissionId()
  return self.Current.MISSION_ID
end

function Atlantiss.Illegal.Gofast:GetDeliveryPosition()
  if self.Current.DELIVERY_POSITION == nil then
    self.Current.DELIVERY_POSITION = self.DeliveryPositions[math.random(1, #self.DeliveryPositions)]
  end

  return self.Current.DELIVERY_POSITION
end

function Atlantiss.Illegal.Gofast:LogToDiscord(message, type)
  type = type or "info"
  TriggerServerEvent(
      "atlantiss:sendToDiscord",
      10,
      "GoFast #" .. Atlantiss.Illegal.Gofast:GetMissionId() .. "\n" .. message, 
      type
  )
end

function Atlantiss.Illegal.Gofast:CanStart()
  return self.Current.RUNNING == false
end

function Atlantiss.Illegal.Gofast:Start()
  if (self:CanStart() == false) then
    ShowNotification(string.format("Vous êtes ~h~déjà~h~ en train de faire un GoFast."))
    return
  end

  self.Current = self:GetEmptyCurrentObject()
  self.Current.RUNNING = true
  self:SetMissionId(GetGameTimer())
  Atlantiss.Illegal.Gofast:LogToDiscord("lance une mission Gofast", "info")
  self:StartCopsCallingThread()
  self:StartHeadingToLoadingZoneThread()
end

function Atlantiss.Illegal.Gofast:Finish()
  if self.Current.BLIP ~= nil then
    RemoveBlip(self.Current.BLIP)
  end
  
  self.Current = self:GetEmptyCurrentObject()
  self.Current.RUNNING = false
end

function Atlantiss.Illegal.Gofast:StartHeadingToLoadingZoneThread()
  ShowNotification(string.format("Rendez vous à la position indiquée pour ~h~charger~h~ la marchandise."))

  local loadingPosition = Atlantiss.Illegal.Gofast:GetLoadingPosition()
  local playerPed = LocalPlayer().Ped

  if (self.Current.BLIP ~= nil) then
    RemoveBlip(self.Current.BLIP)
  end

  self.Current.BLIP = AddBlipForCoord(loadingPosition.pos.x, loadingPosition.pos.y, loadingPosition.pos.z)
  SetBlipRoute(self.Current.BLIP, true)
  SetBlipRouteColour(self.Current.BLIP, 2)

  Citizen.CreateThread(function()
    while Atlantiss.Illegal.Gofast.Current.IS_ON_LOADING_ZONE == false do
      Wait(1000)
      if Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE == nil then
        if (IsPedInAnyVehicle(playerPed)) then
          Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE = GetVehiclePedIsIn(playerPed)
          Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE_PLATE = GetVehicleNumberPlateText(vehicle)
          Atlantiss.Illegal.Gofast:LogToDiscord("Véhicule enregistré pour la mission " .. GetVehicleNumberPlateText(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE), "info")
          ShowNotification(string.format("Le véhicule enregistré pour cette mission est : ~h~%s~h~ ne changez pas.", GetVehicleNumberPlateText(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE)))
        end
      end
      local distanceBetweenCoords = GetDistanceBetweenCoords(loadingPosition.pos.x, loadingPosition.pos.y, loadingPosition.pos.z, LocalPlayer().Pos, true)
      if (distanceBetweenCoords < 5.0) then
        Atlantiss.Illegal.Gofast.Current.IS_ON_LOADING_ZONE = true
        Atlantiss.Illegal.Gofast:StartLoadingCarThread()
      end
    end
  end)
end

function Atlantiss.Illegal.Gofast:GetItemToPutInTrunk()
  return self.Current.ITEM_IN_TRUNK
end

function Atlantiss.Illegal.Gofast:SetItemToPutInTrunk(itemName)
  self.Current.ITEM_IN_TRUNK = itemName
end

function Atlantiss.Illegal.Gofast:StartLoadingCarThread()
  if (self.Current.BLIP ~= nil) then
    RemoveBlip(self.Current.BLIP)
  end

  local loadingPosition = self:GetLoadingPosition()

  Citizen.CreateThread(function()
    while (Atlantiss.Illegal.Gofast.Current.HAS_BEEN_LOADED == false) do
      Wait(500)
      trunkPosition = GetWorldPositionOfEntityBone(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, GetEntityBoneIndexByName(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, "boot"))
      
      if trunkPosition == vector3(0,0,0) then
        trunkPosition = LocalPlayer().Pos
      end

      if (Atlantiss.Illegal.Gofast.Current.HAS_BOX == false) then
        Atlantiss.Illegal.Gofast.Current.HAS_BOX = true
        Atlantiss.Illegal.Gofast.Current.LOADING_PED = Atlantiss.World.Ped:Create(5, "s_m_y_dealer_01", loadingPosition.ped, loadingPosition.heading_ped)
        PlaySimpleForceAnim({"anim@heists@box_carry@", "idle"}, 49, {ped = Atlantiss.Illegal.Gofast.Current.LOADING_PED})
        Atlantiss.Utils:RequestAndWAitForModel("prop_cs_cardbox_01")

        Atlantiss.Illegal.Gofast.Current.BOX = Atlantiss.World.Object:CreateObjectNoOffset("prop_cs_cardbox_01", GetEntityCoords(Atlantiss.Illegal.Gofast.Current.LOADING_PED), true, true, false)
        AttachEntityToEntity(Atlantiss.Illegal.Gofast.Current.BOX, Atlantiss.Illegal.Gofast.Current.LOADING_PED, GetPedBoneIndex(Atlantiss.Illegal.Gofast.Current.LOADING_PED, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0,false,false,false, false, 0, 1 )
        SetModelAsNoLongerNeeded(GetHashKey("prop_cs_cardbox_01"))
      end

      TaskGoToCoordAnyMeans(Atlantiss.Illegal.Gofast.Current.LOADING_PED, trunkPosition, 2.0, 0, 0, 786603, 0xbf800000)
      local loadingPedPosition = GetEntityCoords(Atlantiss.Illegal.Gofast.Current.LOADING_PED)
      distanceToTarget = GetDistanceBetweenCoords(trunkPosition, loadingPedPosition, true)
      TaskGoToCoordAnyMeans(Atlantiss.Illegal.Gofast.Current.LOADING_PED, trunkPosition, 2.0, 0, 0, 786603, 0xbf800000)
      
        if distanceToTarget <= 5.0 and distanceToTarget > 4.0 then 
          TaskGoToCoordAnyMeans(Atlantiss.Illegal.Gofast.Current.LOADING_PED, trunkPosition, 1.0, 0, 0, 786603, 0xbf800000)
        elseif (distanceToTarget <= 3.0 and Atlantiss.Illegal.Gofast.Current.HAS_BEEN_LOADED == false) then
          local timeout = 0
          local vehPlate = GetVehicleNumberPlateText(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE)
          while vehPlate == nil do
              if timeout == 10 then break end
              Wait(100)
              vehPlate = GetVehicleNumberPlateText(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE)
              timeout = timeout + 1
          end
          Atlantiss.Illegal.Gofast:LogToDiscord(string.format("Lancement du chargement du véhicule %s", vehPlate), "info")
          LoadingPrompt("Chargement de la cargaison", 4)
          SetVehicleUndriveable(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, true)
          FreezeEntityPosition(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, true)
          Citizen.Wait(1000)
          SetVehicleDoorOpen(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, 5, false, false)
          TaskTurnPedToFaceCoord(Atlantiss.Illegal.Gofast.Current.LOADING_PED, GetEntityCoords(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE), -1)
          TaskStartScenarioInPlace(Atlantiss.Illegal.Gofast.Current.LOADING_PED, "PROP_HUMAN_BUM_BIN", 0, 1)
          Citizen.Wait(30000)
          if (DoesEntityExist(Atlantiss.Illegal.Gofast.Current.BOX)) then
            DeleteEntity(Atlantiss.Illegal.Gofast.Current.BOX)
            Atlantiss.Illegal.Gofast.Current.BOX = nil
          end
          ClearPedTasks(Atlantiss.Illegal.Gofast.Current.LOADING_PED)
          Atlantiss.World.Vehicle:AddItemIntoTrunk(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, Atlantiss.Illegal.Gofast:GetItemToPutInTrunk())
          SetVehicleDoorShut(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, 5, false, false)
          SetVehicleUndriveable(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, false)
          FreezeEntityPosition(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, false)
          RemoveLoadingPrompt()
        
          Atlantiss.Illegal.Gofast:LogToDiscord("Véhicule " .. GetVehicleNumberPlateText(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE) .. " chargé", "success")
          TriggerServerEvent("Atlantiss::SE::World:Entity:Delete", {handle = Atlantiss.Illegal.Gofast.Current.LOADING_PED, network_id = NetworkGetNetworkIdFromEntity(Atlantiss.Illegal.Gofast.Current.LOADING_PED), seconds = 30})
          Atlantiss.Illegal.Gofast.Current.LOADING_PED = nil
          TaskGoToCoordAnyMeans(Atlantiss.Illegal.Gofast.Current.LOADING_PED, loadingPosition.ped, 1.0, 0, 0, 786603, 0xbf800000)
          Atlantiss.Illegal.Gofast.Current.HAS_BEEN_LOADED = true
          Atlantiss.Illegal.Gofast.Current.HAS_BOX = false
          Atlantiss.Illegal.Gofast:StartHeadingToDeliveryZoneThread()

          Citizen.SetTimeout(math.random(15000, 30000), function()
            if (math.random(1,10) > 0) then
              Atlantiss.Illegal.Gofast:CallPolice("Un voisin a vu une voiture se faire remplir de matiere louche")
            end
          end)
        

        end
    end
  end)
end

function Atlantiss.Illegal.Gofast:StartHeadingToDeliveryZoneThread()
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
      Atlantiss.Illegal.Gofast:CallPolice("Le véhicule suspect est passé par ici")
    end
  end)


  Citizen.CreateThread(function()
    while Atlantiss.Illegal.Gofast.Current.IS_ON_DELIVERY_ZONE == false do
      Wait(1000)
     
      local distanceBetweenCoords = GetDistanceBetweenCoords(deliveryPosition.pos.x, deliveryPosition.pos.y, deliveryPosition.pos.z, LocalPlayer().Pos, true)
      if (distanceBetweenCoords < 5.0) then
        local veh = GetVehiclePedIsUsing(LocalPlayer().Ped)

        if (Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE ~= veh) then
          ShowNotification(string.format("Véhicule attendu : %s, Véhicule actuel : %s.", GetVehicleNumberPlateText(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE), GetVehicleNumberPlateText(veh)))
        else
          Atlantiss.Illegal.Gofast.Current.IS_ON_DELIVERY_ZONE = true
          Atlantiss.Illegal.Gofast:StartDeliveryThread()
        end
      end
    end
  end)
end

function Atlantiss.Illegal.Gofast:StartDeliveryThread()

  if (self.Current.BLIP ~= nil) then
    RemoveBlip(self.Current.BLIP)
  end

  ShowNotification(string.format("Patiente pendant le ~h~déchargement~h~ de la marchandise."))

  if (self.Current.BLIP ~= nil) then
    RemoveBlip(self.Current.BLIP)
  end

  local deliveryPosition = self:GetDeliveryPosition()

  Citizen.CreateThread(function()
    while (Atlantiss.Illegal.Gofast.Current.HAS_BEEN_DELIVERED == false) do
      Wait(500)

      if (Atlantiss.Illegal.Gofast.Current.HAS_BOX == false) then
        Atlantiss.Illegal.Gofast.Current.HAS_BOX = true
        Atlantiss.Illegal.Gofast.Current.UNLOADING_PED = Atlantiss.World.Ped:Create(5, "s_m_y_dealer_01", deliveryPosition.ped, deliveryPosition.heading_ped)
      end

      trunkPosition = GetWorldPositionOfEntityBone(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, GetEntityBoneIndexByName(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, "boot"))
      
      if trunkPosition == vector3(0,0,0) then
        trunkPosition = LocalPlayer().Pos
      end

      TaskGoToCoordAnyMeans(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED, trunkPosition, 2.0, 0, 0, 786603, 0xbf800000)
      local unloadingPedPosition = GetEntityCoords(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED)
      distanceToTarget = GetDistanceBetweenCoords(trunkPosition, unloadingPedPosition, true)
      TaskGoToCoordAnyMeans(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED, trunkPosition, 2.0, 0, 0, 786603, 0xbf800000)
      
        if distanceToTarget <= 5.0 and distanceToTarget > 4.0 then 
          TaskGoToCoordAnyMeans(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED, trunkPosition, 1.0, 0, 0, 786603, 0xbf800000)
        elseif (distanceToTarget <= 3.0 and Atlantiss.Illegal.Gofast.Current.HAS_BEEN_DELIVERED == false) then
          Atlantiss.Illegal.Gofast:LogToDiscord("Déchargement du véhicule " .. GetVehicleNumberPlateText(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE), "info")
          LoadingPrompt("Déchargement de la cargaison", 4)
          SetVehicleUndriveable(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, true)
          FreezeEntityPosition(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, true)
          Citizen.Wait(1000)
          SetVehicleDoorOpen(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, 5, false, false)
          TaskTurnPedToFaceCoord(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED, GetEntityCoords(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE), -1)
          TaskStartScenarioInPlace(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED, "PROP_HUMAN_BUM_BIN", 0, 1)
          Citizen.Wait(20000)
          if (DoesEntityExist(Atlantiss.Illegal.Gofast.Current.BOX)) then
            DeleteEntity(Atlantiss.Illegal.Gofast.Current.BOX)
            Atlantiss.Illegal.Gofast.Current.BOX = nil
          end
          ClearPedTasks(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED)

          PlaySimpleForceAnim({"anim@heists@box_carry@", "idle"}, 49, {ped = Atlantiss.Illegal.Gofast.Current.UNLOADING_PED})
          Atlantiss.Utils:RequestAndWAitForModel("prop_cs_cardbox_01")
          Atlantiss.Illegal.Gofast.Current.BOX = Atlantiss.World.Object:CreateObjectNoOffset("prop_cs_cardbox_01", GetEntityCoords(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED), true, true, false)
          AttachEntityToEntity(Atlantiss.Illegal.Gofast.Current.BOX, Atlantiss.Illegal.Gofast.Current.UNLOADING_PED, GetPedBoneIndex(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0,false,false,false, false, 0, 1 )
          SetModelAsNoLongerNeeded(GetHashKey("prop_cs_cardbox_01"))
    
          Atlantiss.World.Vehicle:RemoveAllItemsNameFromTrunk(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, Atlantiss.Illegal.Gofast:GetItemToPutInTrunk())
          SetVehicleDoorShut(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, 5, false, false)
          SetVehicleUndriveable(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, false)
          FreezeEntityPosition(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE, false)
          RemoveLoadingPrompt()

          Atlantiss.Illegal.Gofast:LogToDiscord("Véhicule " .. GetVehicleNumberPlateText(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE) .. " a été déchargé", "success")
          TaskGoToCoordAnyMeans(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED, deliveryPosition.ped, 1.0, 0, 0, 786603, 0xbf800000)
          Atlantiss.Illegal.Gofast.Current.HAS_BEEN_DELIVERED = true

          if (DoesEntityExist(Atlantiss.Illegal.Gofast.Current.BOX)) then
            DeleteEntity(Atlantiss.Illegal.Gofast.Current.BOX)
            Atlantiss.Illegal.Gofast.Current.BOX = nil
          end

          if (DoesEntityExist(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED)) then
            DeleteEntity(Atlantiss.Illegal.Gofast.Current.UNLOADING_PED)
            Atlantiss.Illegal.Gofast.Current.UNLOADING_PED = nil
          end
          Atlantiss.Illegal.Gofast:GetRewards()

        end
    end
  end)

end

function Atlantiss.Illegal.Gofast:GetRewards()
  if (self:IsMissionRunning()) then
    local veh = GetVehiclePedIsUsing(LocalPlayer().Ped)
    if (self.Current.PLAYER_VEHICLE == nil or (veh ~= nil and self.Current.PLAYER_VEHICLE == veh)) then
        TriggerServerCallback("Atlantiss::SE::RetrieveMissionById", function(mission)
            local currentMission = mission
            TriggerEvent("Atlantiss:illegal:counterStop")
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
                    Atlantiss.Illegal.Gofast:LogToDiscord("Gain de " .. r .. "$", "success")

                    TriggerServerCallback(
                      "Atlantiss::SE::Money:Fake:AuthorizePayment", 
                      function(token)
                        TriggerServerEvent(Atlantiss.Payment.Fake:GetServerEventName(), {TOKEN = token, AMOUNT = r, SOURCE = "Gofast", LEGIT = false})
                        TriggerServerEvent("Atlantiss::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", r, false)
                      end,
                      {}
                    )

                    ShowNotification(string.format("Merci pour ta collaboration, tu gagnes %s $", r))
                end

                if k == "items" then
                  Atlantiss.Inventory:AddItems(v)
                end
            end
            TriggerServerEvent("missionEnd", currentMission)
            TriggerServerEvent("MissionFinished", currentMission)
            self:Finish()
            end,
            Atlantiss.Illegal.Gofast:GetMissionId()
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
          Atlantiss.Illegal.Gofast:LogToDiscord("La plaque de la voiture n'est pas la bonne", "error")
          ShowNotification(string.format("Véhicule attendu : %s, véhicule sur place : %s", GetVehicleNumberPlateText(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE), GetVehicleNumberPlateText(veh)))
        else
          Atlantiss.Illegal.Gofast:LogToDiscord("Ne semble pas être dans une voiture", "error")
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

function Atlantiss.Illegal.Gofast:StartCopsCallingThread()
  Citizen.CreateThread(function()
    while self.Current.RUNNING == true do
      Citizen.Wait(math.random(1000 * 90, 1000 * 120))
      if (Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE ~= nil and Atlantiss.Illegal.Gofast.Current.HAS_BEEN_LOADED == true) then
        local myPed = LocalPlayer().Ped
        local entitySpeed = GetEntitySpeed(Atlantiss.Illegal.Gofast.Current.PLAYER_VEHICLE) * 3.6
  
        if entitySpeed > 145.0 then
          self:LogToDiscord("S'est fait flasher par un radar", "info")
          self:CallPolice("Véhicule recherché : radar automatique a " .. math.ceil(entitySpeed) .. " km/h")
        end
      end
    end
  end)
end

function Atlantiss.Illegal.Gofast:CallPolice(message)
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