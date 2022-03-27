function Ora.Illegal.CarRoberry:GetConfigForMissionLevel()
  if (self.MissionConfig[self:GetMissionLevel()] ~= nil) then
    return self.MissionConfig[self:GetMissionLevel()]
  end

  return { cars = {self:GetDefaultVehicle()}, minutes = 15}
end

function Ora.Illegal.CarRoberry:GetVehiclePosition()
  if (self.Current.VEHICLE_POSITION == nil) then 
    self.Current.VEHICLE_POSITION = self:GetRandomPositionForMissionLevel()
  end

  return self.Current.VEHICLE_POSITION
end

function Ora.Illegal.CarRoberry:GetFinalPosition()
  return self.FinalPositions[1]
end 

function Ora.Illegal.CarRoberry:GetVehicleModel()
  if (self.Current.VEHICLE_MODEL == nil) then 
    self.Current.VEHICLE_MODEL = self:GetRandomVehicleForMissionLevel()
  end

  return self.Current.VEHICLE_MODEL
end

function Ora.Illegal.CarRoberry:GetPaintingBoothPosition()
  if (self.Current.PAINTING_BOOTH_POSITION == nil) then 
    self.Current.PAINTING_BOOTH_POSITION = self:GetRandomPaintingBoothForMissionLevel()
  end
  
  return self.Current.PAINTING_BOOTH_POSITION
end

function Ora.Illegal.CarRoberry:GetRandomPaintingBoothForMissionLevel()
  return self.PaintingBoothPositions[math.random(1, #self.PaintingBoothPositions)]
end

function Ora.Illegal.CarRoberry:GetRandomPositionForMissionLevel()
  return self.CarPositions[math.random(1, #self.CarPositions)]
end

function Ora.Illegal.CarRoberry:GetRandomVehicleForMissionLevel()
  local missionConfig = self:GetConfigForMissionLevel()
  if (missionConfig.cars ~= nil) then
    return missionConfig.cars[math.random(1, #missionConfig.cars)]
  end

  return self:GetDefaultVehicle() 
end

function Ora.Illegal.CarRoberry:GetMissionLevel()
  return self.Current.MISSION_LEVEL
end

function Ora.Illegal.CarRoberry:GetMissionId()
  return self.Current.MISSION_ID
end

function Ora.Illegal.CarRoberry:LogToDiscord(message, type)
  type = type or "info"
  TriggerServerEvent(
      "Ora:sendToDiscord",
      11,
      "Vol Véhicule #" .. Ora.Illegal.CarRoberry:GetMissionId() .. "\n" .. message, 
      type
  )
end

function Ora.Illegal.CarRoberry:SetMissionLevel(missionLevel)
  self.Current.MISSION_LEVEL = missionLevel
end

function Ora.Illegal.CarRoberry:SetMissionId(missionId)
  self.Current.MISSION_ID = missionId
end

function Ora.Illegal.CarRoberry:IsMissionRunning()
  return self.Current.RUNNING == true
end

function Ora.Illegal.CarRoberry:GetMissionVehicle()
  return self.Current.VEHICLE
end


function Ora.Illegal.CarRoberry:CanStart()
  return self.Current.RUNNING ~= true
end

function Ora.Illegal.CarRoberry:Start(missionLevel)
  if (self:CanStart() == false) then
    ShowNotification(string.format("Vous êtes ~h~déjà~h~ en mission"))
    return
  end

  self.Current = self:GetEmptyCurrentObject()
  self:SetMissionLevel(missionLevel)
  self:SetMissionId(GetGameTimer())
  self.Current.RUNNING = true
  self:LogToDiscord("Lance une mission vol de véhicule")
  self:ShowAdvancedNotification("Je recherche un véhicule particulier et je sais qu'il se trouve la bas.")
  self:ShowAdvancedNotification("Trouve ce véhicule et crochette le.")

  if self.Current.BLIP ~= nil then
    RemoveBlip(self.Current.BLIP)
  end

  self:StartGoToVehicleThread()
end

--[[ function Ora.Illegal.CarRoberry:GetRandomPlate()
  local plates = {
    "55USA156",
    "55FRA156",
    "55LOL156",
    "55MDR156",
    "55FOU156",
    "55UHU156",
  }

  return plates[math.random(1, #plates)]
end ]]

function Ora.Illegal.CarRoberry:StartGoToVehicleThread()

  local vehiclePosition = self:GetVehiclePosition()
  local vehicleModel = self:GetVehicleModel()
  local playerPed = LocalPlayer().Ped

  self.Current.BLIP = AddBlipForCoord(vehiclePosition.pos.x, vehiclePosition.pos.y, vehiclePosition.pos.z)
  SetBlipRoute(self.Current.BLIP, true)
  SetBlipRouteColour(self.Current.BLIP, 2)

  Citizen.CreateThread(function()
    while (self.Current.VEHICLE_IS_CREATED == false) do
      Citizen.Wait(1000)
      local distance = GetDistanceBetweenCoords(vehiclePosition.pos, LocalPlayer().Pos)

      if (distance < 200.0 and self.Current.VEHICLE_IS_CREATED == false) then
        ClearAreaOfVehicles(vehiclePosition.pos, 10.0, false, false, false, false, false)
        Wait(500)
        self.Current.VEHICLE = Ora.World.Vehicle:Create(vehicleModel,  vehiclePosition.pos, vehiclePosition.a, {customs = {}, warp_into_vehicle = false, health = {}})
        if (DoesEntityExist(self.Current.VEHICLE)) then
          self.Current.VEHICLE_PLATE = GetVehicleNumberPlateText(self.Current.VEHICLE)
          self:ShowAdvancedNotification(string.format("Trouve le véhicule %s, immatriculé %s.", GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(self.Current.VEHICLE))), GetVehicleNumberPlateText(self.Current.VEHICLE)))
          SetVehicleDoorsLockedForAllPlayers(self.Current.VEHICLE, true)
          SetVehicleDoorsLocked(self.Current.VEHICLE, 2)
          self:StartPlayerIsInsideVehicleThread()
          self.Current.VEHICLE_IS_CREATED = true
        else
          DeleteEntity(self.Current.VEHICLE)
        end
      end
    end
  end)
end

function Ora.Illegal.CarRoberry:StartPlayerIsInsideVehicleThread()
  local playerPed = LocalPlayer().Ped
  local playerPedCoords = LocalPlayer().Pos
  Citizen.CreateThread(function()
    while (self.Current.IS_INSIDE_STOLEN_VEHICLE == false) do
      Citizen.Wait(1000)
      if (IsPedInAnyVehicle(playerPed, false) and GetVehicleNumberPlateText(GetVehiclePedIsIn(playerPed, false)) == self.Current.VEHICLE_PLATE) then    
        self:LogToDiscord("A crocheté la voiture", "info")
  
        if (math.random(1,10) > 8) then
          self:CallPolice("Vol de véhicule")
        end

        if self.Current.BLIP ~= nil then
          RemoveBlip(self.Current.BLIP)
        end

        self:ShowAdvancedNotification(string.format("Maintenant, tu vas aller faire repeindre ce véhicule, et changer les plaques."))
        local paintingBoothLocation = self:GetPaintingBoothPosition()
        self.Current.BLIP = AddBlipForCoord(paintingBoothLocation.pos.x, paintingBoothLocation.pos.y, paintingBoothLocation.pos.z)
        SetBlipRoute(self.Current.BLIP, true)
        SetBlipRouteColour(self.Current.BLIP, 2)
        self.Current.IS_INSIDE_STOLEN_VEHICLE = true
        self:StartCopsCallingThread()
        self:StartPlayerGoToPaintingBooth()
      end
    end
  end)
end

function Ora.Illegal.CarRoberry:StartPlayerGoToPaintingBooth()
  local playerPed = LocalPlayer().Ped
  local paintingBoothLocation = self:GetPaintingBoothPosition()

  Citizen.CreateThread(function()
    while (self.Current.VEHICLE_HAS_BEEN_SPRAYED == false) do
      Citizen.Wait(1000)
      local distance = GetDistanceBetweenCoords(paintingBoothLocation.pos, LocalPlayer().Pos)

      if (distance <= 4.0) then
        if (GetVehicleNumberPlateText(GetVehiclePedIsIn(playerPed, false)) ~= self.Current.VEHICLE_PLATE) then      
          self:ShowAdvancedNotification(string.format("Il faut venir avec le véhicule, sinon je peux rien faire."))
        else
          self:LogToDiscord("Fait repreindre la voiture", "info")
          LoadingPrompt("Changement de peinture de la voiture", 4)
          SetVehicleUndriveable(self.Current.VEHICLE, true)
          FreezeEntityPosition(self.Current.VEHICLE, true)
          Citizen.Wait(1000)
          SetVehicleDoorOpen(self.Current.VEHICLE, 5, false, false)
          Citizen.Wait(5000)
          SetVehicleDoorShut(self.Current.VEHICLE, 5, false, false)
          SetVehicleDoorOpen(self.Current.VEHICLE, 4, false, false)
          Citizen.Wait(5000)
          SetVehicleDoorShut(self.Current.VEHICLE, 4, false, false)
          SetVehicleDoorOpen(self.Current.VEHICLE, 3, false, false)
          Citizen.Wait(5000)
          SetVehicleDoorShut(self.Current.VEHICLE, 3, false, false)
          SetVehicleDoorOpen(self.Current.VEHICLE, 2, false, false)
          Citizen.Wait(5000)
          SetVehicleDoorShut(self.Current.VEHICLE, 2, false, false)
          SetVehicleDoorOpen(self.Current.VEHICLE, 1, false, false)
          Citizen.Wait(5000)
          SetVehicleDoorShut(self.Current.VEHICLE, 1, false, false)
          SetVehicleDoorOpen(self.Current.VEHICLE, 0, false, false)
          Citizen.Wait(5000)
          SetVehicleDoorShut(self.Current.VEHICLE, 0, false, false)
          Citizen.Wait(500)
          SetVehicleModColor_1(self.Current.VEHICLE, 0, math.random(8, 39))
          SetVehicleModColor_2(self.Current.VEHICLE, 0, math.random(8, 39))
          SetVehicleUndriveable(self.Current.VEHICLE, false)
          FreezeEntityPosition(self.Current.VEHICLE, false)
          RemoveLoadingPrompt()
          self:ShowAdvancedNotification(string.format("Ramène le véhicule a mon contact. Te fais pas chopper."))
          self:StartGoToFinalPositionThread()
          self.Current.VEHICLE_HAS_BEEN_SPRAYED = true
          self:LogToDiscord("A fini la peinture du véhicule", "success")
        end
      end
    end
  end)
end

function Ora.Illegal.CarRoberry:StartGoToFinalPositionThread()
  local playerPed = LocalPlayer().Ped
  local finalPosition = self:GetFinalPosition()

  if self.Current.BLIP ~= nil then
    RemoveBlip(self.Current.BLIP)
  end

  self.Current.BLIP = AddBlipForCoord(finalPosition.pos.x, finalPosition.pos.y, finalPosition.pos.z)
  SetBlipRoute(self.Current.BLIP, true)
  SetBlipRouteColour(self.Current.BLIP, 2)

end

function Ora.Illegal.CarRoberry:VehicleHasBeenSprayed()
  return self.Current.VEHICLE_HAS_BEEN_SPRAYED
end

function Ora.Illegal.CarRoberry:Finish()
  if self.Current.BLIP ~= nil then
    RemoveBlip(self.Current.BLIP)
  end
  self:LogToDiscord("La mission est terminée", "success")
  
  self.Current = self:GetEmptyCurrentObject()
  self.Current.RUNNING = false
end

function Ora.Illegal.CarRoberry:StartCopsCallingThread()
  Citizen.CreateThread(function()
    while self.Current.RUNNING == true do
      Citizen.Wait(math.random(1000 * 90, 1000 * 120))
      if (self.Current.VEHICLE ~= nil and self.Current.VEHICLE_HAS_BEEN_SPRAYED == false) then
        local myPed = LocalPlayer().Ped
        local entitySpeed = GetEntitySpeed(self.Current.VEHICLE) * 3.6
  
        if entitySpeed > 145.0 then
          self:LogToDiscord("S'est fait flasher par un radar", "info")
          self:CallPolice("Radar automatique " .. math.ceil(entitySpeed) .. " km/h")
        end
      end
    end
  end)
end

function Ora.Illegal.CarRoberry:CallPolice(message)
  local vehicle = self.Current.VEHICLE
  local vehiclePosition = GetEntityCoords(vehicle)
  TriggerServerEvent(
      "call:makeCall2",
      "police",
      vehiclePosition,
      message .. string.format("\n* immat : %s\n* Modèle : %s", GetVehicleNumberPlateText(vehicle), GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
  )

  TriggerServerEvent(
      "call:makeCall2",
      "lssd",
      vehiclePosition,
      message .. string.format("\n* immat : %s\n* Modèle : %s", GetVehicleNumberPlateText(vehicle), GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
  )
end