Ora.Illegal.Carjacking = Ora.Illegal.Carjacking or {}
Ora.Illegal.Carjacking.Current = {
  VEHICLE = nil,
  STEP = 0,
  BLIP = nil,
  RUNNING = false,
  START_POSITION = nil,
  VEHICLE_POSITION = nil,
  VEHICLE_SPAWNED = false,
  PLAYER_HAS_CARJACKED = false,
  VEHICLE_MODEL = nil,
  END_POSITION = nil,
  MISSION_LEVEL = nil,
  MISSION_ID = nil,
  VEHICLE_HAS_CHANGED_STYLE = false,
  HELP_VEHICLE_STARTED = false,
  PED_HAS_BEEN_CARJACKED = false,
  FINAL_DIRECTION_SHOWED = false,
  CURRENT_MISSION = {}
}

Ora.Illegal:Register("Carjacking")

function Ora.Illegal.Carjacking:Initialize()
  self:InitializeConfig()
end

function Ora.Illegal.Carjacking:SetStartPosition(position)
  self.Current.START_POSITION = position
end

function Ora.Illegal.Carjacking:SetEndPosition(position)
  self.Current.END_POSITION = position
end

function Ora.Illegal.Carjacking:SetVehiclePosition(position)
  self.Current.VEHICLE_POSITION = position
end

function Ora.Illegal.Carjacking:SetVehicleModel(vehicleModel)
  self.Current.VEHICLE_MODEL = vehicleModel
end

function Ora.Illegal.Carjacking:SetMissionLevel(missionLevel)
  self.Current.MISSION_LEVEL = missionLevel
end

function Ora.Illegal.Carjacking:SetMissionId(missionId)
  self.Current.MISSION_ID = missionId
end

function Ora.Illegal.Carjacking:GetMissionVehicle()
  return self.Current.VEHICLE
end

function Ora.Illegal.Carjacking:IsMissionRunning()
  return self.Current.RUNNING == true
end

function Ora.Illegal.Carjacking:SetMissionObject(mission)
  self.Current.CURRENT_MISSION = mission
end

function Ora.Illegal.Carjacking:GetMissionObject()
  return self.Current.CURRENT_MISSION
end

function Ora.Illegal.Carjacking:GetStartPosition()
  if (self.Current.START_POSITION == nil or self.Current.START_POSITION.pos == nil or self.Current.START_POSITION.pos == vector3(0,0,0)) then
    self:SetStartPosition(self:GetRandomStartPosition())
  end

  return self.Current.START_POSITION
end

function Ora.Illegal.Carjacking:GetEndPosition()
  return self.Current.END_POSITION
end

function Ora.Illegal.Carjacking:GetVehiclePosition()
  return self.Current.VEHICLE_POSITION
end

function Ora.Illegal.Carjacking:GetMissionLevel()
  return self.Current.MISSION_LEVEL
end

function Ora.Illegal.Carjacking:GetMissionId()
  return self.Current.MISSION_ID
end

function Ora.Illegal.Carjacking:GetVehicleModel()
  return self.Current.VEHICLE_MODEL
end

function Ora.Illegal.Carjacking:GetRandomStartPosition()
    local config = self:GetConfig()
    return config.START_POSITIONS[math.random(1, #config.START_POSITIONS)]
end

function Ora.Illegal.Carjacking:GetRandomEndPosition()
  local config = self:GetConfig()
  return config.END_POSITIONS[math.random(1, #config.END_POSITIONS)]
end

function Ora.Illegal.Carjacking:GetDefautVehicleModel()
  return {
    'brioso',
    'blista',
    'blista2',
    'buffalo',
    'huntley'
  }
end

function Ora.Illegal.Carjacking:GetRandomVehicleModelForMissionLevel()
  local config = self:GetConfig()
  local missionLevel = self:GetMissionLevel()
  local vehicleList = {}
  if (config.MISSION_LEVELS[missionLevel] ~= nil and config.MISSION_LEVELS[missionLevel].cars ~= nil) then
    vehicleList = config.MISSION_LEVELS[missionLevel].cars
  else
    vehicleList = self:GetDefautVehicleModel() 
  end

  return vehicleList[math.random(1, #vehicleList)]
end


function Ora.Illegal.Carjacking:GetRandomDriverModel()
  local config = self:GetConfig()
  return config.PEDS[math.random(1, #config.PEDS)]
end

function Ora.Illegal.Carjacking:CanStart()
  return self.Current.RUNNING == false
end

function Ora.Illegal.Carjacking:StartCarjacking()
  if (Ora.Illegal.Carjacking:CanStart() == false) then
    Ora.Illegal.Carjacking:StopCarjacking()
  end
  self.Current.RUNNING = true
  self:SetStartPosition(self:GetRandomStartPosition())

  self:SetEndPosition(self:GetRandomEndPosition())
  self:SetVehicleModel(self:GetRandomVehicleModelForMissionLevel())
  self:SetMissionId(GetGameTimer())

  TriggerServerEvent(
      "Ora:sendToDiscord", 7,
      string.format("[%s] Lance une mission Carjack", self:GetMissionId()), 
      "info"
  )

  ShowAdvancedNotification(
      "Josh",
      "~b~Dialogue",
      "Une ~h~voiture~h~ m'interesse, Elle appartient a un mec que je surveille depuis pas mal de temps!",
      "CHAR_LESTER",
      1
  )

  self.Current.BLIP = AddBlipForCoord(self:GetStartPosition().pos.x, self:GetStartPosition().pos.y, self:GetStartPosition().pos.z)
  SetBlipRoute(self.Current.BLIP, true)
  SetBlipRouteColour(self.Current.BLIP, 1)
  self:StartVehicleSpawnerThread()
end

function Ora.Illegal.Carjacking:CallPolice(message)
  local vehicle = Ora.Illegal.Carjacking.Current.VEHICLE
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

function Ora.Illegal.Carjacking:GetMaxTimeForMission()
  return 15
end

function Ora.Illegal.Carjacking:StartVehicleSpawnerThread()
  Citizen.CreateThread(function()
    while self.Current.VEHICLE_SPAWNED == false and self:GetStartPosition() ~= nil do
      Citizen.Wait(1000)
      local myPedPosition = LocalPlayer().Pos
      local distanceBetweenObjective = GetDistanceBetweenCoords(myPedPosition, self:GetStartPosition().pos, false)

      if (distanceBetweenObjective <= 100.0 and self.Current.VEHICLE_SPAWNED == false) then
        ClearAreaOfVehicles(self:GetStartPosition().pos.x, self:GetStartPosition().pos.y, self:GetStartPosition().pos.z, 10.0, false, false, false, false, false)
        Citizen.Wait(100)
        local vehicleModel = self:GetVehicleModel()
        TriggerServerCallback("Ora::SE::Anticheat:RegisterVehicle", 
          function()
            spawnedVehicle = Ora.World.Vehicle:Create(vehicleModel,  self:GetStartPosition().pos, self:GetStartPosition().heading, {customs = {}, warp_into_vehicle = false, health = {}})
            Citizen.Wait(250)
            if (DoesEntityExist(spawnedVehicle)) then
              self.Current.VEHICLE_SPAWNED = true
              self.Current.VEHICLE = spawnedVehicle
              SetEntityAsMissionEntity(self.Current.VEHICLE, true, true)
              SetVehicleOnGroundProperly(self.Current.VEHICLE)
              Citizen.InvokeNative(0x06FAACD625D80CAA, self.Current.VEHICLE)
              pedModel = self:GetRandomDriverModel()
              self.Current.DRIVER = Ora.World.Ped:Create(5, pedModel, vector3(self:GetStartPosition().pos.x + 0.5, self:GetStartPosition().pos.y, self:GetStartPosition().pos.z), 0.0)
              SetPedIntoVehicle(self.Current.DRIVER, self.Current.VEHICLE, -1)
              TaskVehicleDriveWander(self.Current.DRIVER, self.Current.VEHICLE, 35.0, 536871311)
              SetPedRelationshipGroupHash(self.Current.DRIVER, GetHashKey("CarjackVehicle"))
              SetDriverAbility(self.Current.DRIVER, 10.0)
              SetPedFleeAttributes(self.Current.DRIVER, 0, 1)
              SetPedCombatAbility(self.Current.DRIVER, 1)
              SetVehicleDoorsLockedForAllPlayers(self.Current.DRIVER, false)

              local chanceToHaveWeapon = math.random(1, 100)
              if (chanceToHaveWeapon > 50) then
                  GiveWeaponToPed(self.Current.DRIVER, GetHashKey("WEAPON_WRENCH"), -1, 0, 1)
              end

              SetPedAccuracy(self.Current.DRIVER, 25)
              self:StartVehicleTrackingThread()
              self:StartCarjackingThread()   
            end
          end,
          GetHashKey(vehicleModel)
        )
      end
    end
  end)
end

function Ora.Illegal.Carjacking:StartVehicleTrackingThread()
  Citizen.CreateThread(function()
    while self.Current.PLAYER_HAS_CARJACKED == false do
      Citizen.Wait(1000)
      local vehiclePosition = GetEntityCoords(self.Current.VEHICLE)
      
      if self.Current.BLIP ~= nil then
        RemoveBlip(self.Current.BLIP)
      end

      self.Current.BLIP = AddBlipForCoord(vehiclePosition.x, vehiclePosition.y, vehiclePosition.z)
      SetBlipRoute(self.Current.BLIP, true)
      SetBlipRouteColour(self.Current.BLIP, 1)
    end
  end)
end

function Ora.Illegal.Carjacking:StartCarjackingThread()
  Citizen.CreateThread(function()
    while self.Current.PLAYER_HAS_CARJACKED == false do
      Citizen.Wait(200)
      local vehiclePosition = GetEntityCoords(self.Current.VEHICLE)
      local myPed = LocalPlayer().Ped
      local myPosition = GetEntityCoords(myPed)
      local distanceBetweenObjective = GetDistanceBetweenCoords(vehiclePosition, myPosition, true)
      if (distanceBetweenObjective < 100.0 and self.Current.VEHICLE_HAS_CHANGED_STYLE == false) then
        TaskVehicleDriveWander(self.Current.DRIVER, self.Current.VEHICLE, 35.0, 262702)
        self.Current.VEHICLE_HAS_CHANGED_STYLE = true
        self:CallPolice("Un individu veut voler ma voiture")
      end

      if distanceBetweenObjective <= 15.0 and IsPlayerFreeAiming(myPed) and self.Current.PED_HAS_BEEN_CARJACKED == false then
        local _, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
        if (entity == self.Current.VEHICLE or entity == self.Current.DRIVER) then
          if (IsPedInAnyVehicle(self.Current.DRIVER, false)) then
            TaskLeaveVehicle(self.Current.DRIVER, self.Current.VEHICLE, 256)
            Wait(2000)
          end
          ShowAdvancedNotification(
                "Josh",
                "~b~Dialogue",
                string.format("Le conducteur leve ses mains, prend le controle de son véhicule"),
                "CHAR_LESTER",
                1
          )
          self:CallPolice("Un individu se fait voler sa voiture")
          self.Current.PED_HAS_BEEN_CARJACKED = true
          self.Current.PLAYER_HAS_CARJACKED = true
          TaskHandsUp(self.Current.DRIVER, 2000, -1, -1, false)
          Wait(2000)
          TaskCombatPed(self.Current.DRIVER, myPed, 0, 16)
          TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = self.Current.DRIVER, network_id = NetworkGetNetworkIdFromEntity(self.Current.DRIVER), seconds = 30})
          self.Current.DRIVER = nil
          self:StartDeliveryThread()
          self:StartDrivingMonitoring()
        end

      end

      if distanceBetweenObjective < 5.0 and (GetEntitySpeed(self.Current.VEHICLE) * 3.6) < 20.0 and self.Current.PED_HAS_BEEN_CARJACKED == false then
        self.Current.PED_HAS_BEEN_CARJACKED = true
        self.Current.PLAYER_HAS_CARJACKED = true
          if (IsPedInAnyVehicle(self.Current.DRIVER, false)) then
            TaskLeaveVehicle(self.Current.DRIVER, self.Current.VEHICLE, 256)
            Wait(2000)
          end
          ShowAdvancedNotification(
                "Josh",
                "~b~Dialogue",
                string.format("Le conducteur leve ses mains, prend le controle de son véhicule"),
                "CHAR_LESTER",
                1
          )
          self:CallPolice("Un individu se fait voler sa voiture")
          TaskHandsUp(self.Current.DRIVER, 2000, -1, -1, false)
          Wait(2000)
          TaskCombatPed(self.Current.DRIVER, myPed, 0, 16)
          TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = self.Current.DRIVER, network_id = NetworkGetNetworkIdFromEntity(self.Current.DRIVER), seconds = 30})
          self.Current.DRIVER = nil
          self:StartDeliveryThread()
          self:StartDrivingMonitoring()
      end
    end
  end)
end


function Ora.Illegal.Carjacking:StartDrivingMonitoring()
  Citizen.CreateThread(function()
    while self.Current.RUNNING == true do
      Citizen.Wait(math.random(1000 * 60, 1000 * 120))
      local myPed = LocalPlayer().Ped
      local entitySpeed = GetEntitySpeed(self.Current.VEHICLE) * 3.6

      if entitySpeed > 145.0 then
        self:CallPolice("Véhicule recherché : radar automatique à " .. math.ceil(entitySpeed) .. " km/h")
      end
    end
  end)
end

function Ora.Illegal.Carjacking:StartDeliveryThread()
  Citizen.CreateThread(function()
    while self.Current.FINAL_DIRECTION_SHOWED == false do
      Citizen.Wait(100)
      local myPed = LocalPlayer().Ped

      if (IsPedInVehicle(myPed, self.Current.VEHICLE, false)) then
        if self.Current.BLIP ~= nil then
          RemoveBlip(self.Current.BLIP)
        end

        if (math.random(1,10) > 8) then
          for vehicle in EnumerateVehicles() do
            if vehicle and DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(vehicle), GetEntityCoords(self.Current.VEHICLE), true) < 75.0 then
              local pedDriving = GetPedInVehicleSeat(vehicle, -1)
              if (pedDriving and DoesEntityExist(pedDriving) and not IsPedAPlayer(pedDriving)) then
                Ora.Illegal:Debug(string.format("Found a ped to make a pursuit"))
                TaskVehicleChase(pedDriving, LocalPlayer().Ped)
                break
              end
            end
          end
        end
  
        self.Current.BLIP = AddBlipForCoord(self:GetEndPosition().pos.x, self:GetEndPosition().pos.y, self:GetEndPosition().pos.z)
        SetBlipRoute(self.Current.BLIP, true)
        SetBlipRouteColour(self.Current.BLIP, 1)

        ShowAdvancedNotification(
              "Josh",
              "~b~Dialogue",
              string.format("Ramene vite la voiture ici avant que la police soit prévenue."),
              "CHAR_LESTER",
              1
        )
        self.Current.FINAL_DIRECTION_SHOWED = true
      end
    end
  end)
end

function Ora.Illegal.Carjacking:StopCarjacking()
  if Ora.Illegal.Carjacking.Current.BLIP ~= nil then
    RemoveBlip(Ora.Illegal.Carjacking.Current.BLIP)
  end

  if Ora.Illegal.Carjacking.Current.VEHICLE ~= nil and DoesEntityExist(Ora.Illegal.Carjacking.Current.VEHICLE) then
    DeleteEntity(Ora.Illegal.Carjacking.Current.VEHICLE)
  end
  
  Ora.Illegal.Carjacking.Current = {
    VEHICLE = nil,
    STEP = 0,
    BLIP = nil,
    RUNNING = false,
    START_POSITION = nil,
    VEHICLE_POSITION = nil,
    END_POSITION = nil,
    MISSION_LEVEL = nil,
    VEHICLE_MODEL = nil,
    MISSION_ID = nil,
    VEHICLE_SPAWNED = false,
    PLAYER_HAS_CARJACKED = false,
    VEHICLE_HAS_CHANGED_STYLE = false,
    HELP_VEHICLE_STARTED = false,
    PED_HAS_BEEN_CARJACKED = false,
    FINAL_DIRECTION_SHOWED = false
  }
end