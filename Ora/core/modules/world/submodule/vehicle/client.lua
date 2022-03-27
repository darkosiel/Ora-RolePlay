Ora.World.Vehicle.JackedVehicles = {}


DecorRegister("drifttyres", 2)
DecorRegister("hydraulicSystem", 2)


function Ora.World.Vehicle:Create(model, position, heading, options)
    options = options or {}
    heading = heading or GetEntityHeading(LocalPlayer().Ped)
    local playerPed = LocalPlayer().Ped
    local modelHash = GetHashKey(model)
    if not IsModelValid(model) or not IsModelInCdimage(model) then
        ShowNotification(string.format("Le véhicule de type ~h~%s~h~ n'existe pas.", model))
        return
    end

    Ora.Utils:RequestAndWAitForModel(model)
    SetVehRadioStation(vehicle, "OFF")
  
    local canSend = false
    local vehicle = nil
    Ora.World:Debug(string.format("Vehicle ^5%s^3 will be registered as a legit vehicle", model))
    TriggerServerCallback("Ora::SE::Anticheat:RegisterVehicle", 
        function()
            vehicle = CreateVehicle(model, position.x, position.y, position.z, heading + 0.0, true, true)
            Ora.World:Debug(string.format("Vehicle ^5%s^3 is now created at position ^5%s %s %s^3", model, position.x, position.y, position.z))
            Ora.World.Vehicle:AddSpawnedVehicle(VehToNet(vehicle), LocalPlayer().Ped)
            canSend = true
        end,
        modelHash
    )

    local localTime = GetGameTimer()
   
    while (canSend == false and localTime + 5000 > GetGameTimer()) do
        Ora.World:Debug(string.format("Vehicle ^5%s^3 is waiting callback from anticheat", model))
        Wait(100)
    end

    if (vehicle == nil) then
        ShowNotification(string.format("Le vehicle ~h~%s~h~ n'a pas pu être créé", model))
        return
    end

    SetModelAsNoLongerNeeded(modelHash)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleOnGroundProperly(vehicle)
    SetVehicleCanLeakOil(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehicleCanLeakPetrol(vehicle, true)
  
    if options.plate then
        SetVehicleNumberPlateText(vehicle, options.plate)
    end
    SetVehicleRadioLoud(vehicle, true)
  
    if IsThisModelABoat(modelHash) then
        SetBoatFrozenWhenAnchored(vehicle, true)
        SetBoatAnchor(vehicle, false)
    end

    if options.maxFuel then
        local fuel = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fPetrolTankVolume")
        self:SetFuel(vehicle, fuel)
    end
  
    if options.warp_into_vehicle and options.warp_into_vehicle == true then
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    end
  
    local hasWeapon, weaponHash = GetCurrentPedVehicleWeapon(playerPed)
    if hasWeapon then
        DisableVehicleWeapon(true, weaponHash, vehicle, playerPed)
    end

    self:ApplyCustomsToVehicle(vehicle, options.customs)
    self:ApplyDamagesToVehicle(vehicle, options.health)
  
    TriggerServerCallback(
        'Ora::SE::World:Vehicle:GetHandling',
        function(status, res)
            if (status == true) then
                for _, val in pairs(res) do
                    self:SetVehicleHandlingData(vehicle, val.name, val.value)
                end
            end
        end,
        self:GetIdentifier(vehicle)
    )
    
    Citizen.CreateThread(function()
      local vehicleNetworkId
    
      if not options.localized then
          local localTime = GetGameTimer()
          vehicleNetworkId = NetworkGetNetworkIdFromEntity(vehicle)
          while (not vehicleNetworkId or not NetworkDoesNetworkIdExist(vehicle)) and localTime + 5000 > GetGameTimer() and DoesEntityExist(vehicle) do
              Citizen.Wait(500)
              Ora.World:Debug(string.format("waiting for network entity id"))
              NetworkRegisterEntityAsNetworked(vehicle)
              vehicleNetworkId = NetworkGetNetworkIdFromEntity(vehicle)
          end
          if not vehicleNetworkId then
              Ora.World:Debug(string.format("Cannot retrieve netid for vehicle entity ^5%s^3", vehicle))
              return
          end
          Ora.World:Debug(string.format("Vehicle network id is ^5%s^3", vehicleNetworkId))
          SetNetworkIdExistsOnAllMachines(vehicleNetworkId, true)
      end
    end)

    return vehicle
  -- Logic to create vehicle
end

function Ora.World.Vehicle:ApplyCustomsToVehicle(vehicle, props)
  props = props or {}
    SetVehicleModKit(vehicle, 0)

    if props.plate ~= nil then
        SetVehicleNumberPlateText(vehicle, props.plate)
    end

    if props.livery ~= nil then
        SetVehicleLivery(vehicle, props.livery)
    end

    if props.plateIndex ~= nil then
        SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
    end

    if props.health ~= nil then
        SetEntityHealth(vehicle, props.health)
    end

    if props.dirtLevel ~= nil then
        SetVehicleDirtLevel(vehicle, props.dirtLevel)
    end
    if props.fuelLevel ~= nil then
      self:SetFuel(vehicle, props.fuelLevel)
    end
    if props.motorHealth ~= nil then
        SetVehicleEngineHealth(vehicle, props.motorHealth)
    end

    if props.modXenonColor ~= nil then
        SetVehicleHeadlightsColour(vehicle, props.modXenonColor)
    end

    if props.color1 ~= nil then
        local _, color2 = GetVehicleColours(vehicle)
        SetVehicleColours(vehicle, props.color1, color2)
    end

    if props.interiorColor ~= nil then
        SetVehicleInteriorColour(vehicle, props.interiorColor)
    end

    if props.wheelLevel ~= nil then
        for i = 1, #props.wheelLevel, 1 do
            if props.wheelLevel[i] and props.wheelLevel[i] ~= nil then
                SetVehicleTyreBurst(vehicle, i - 1, true, 1000.0)
            end
        end
    end
    if props.doorStat ~= nil then
        for i = 1, #props.doorStat, 1 do
            if props.doorStat[i] and props.doorStat[i] ~= nil then
                SetVehicleDoorBroken(vehicle, i - 1, props.doorStat[i])
            end
        end
    end
    if props.windowStatus ~= nil then
    -- for i = 1 ,#props.windowStatus , 1 do
    -- 	if not props.windowStatus[i] and props.windowStatus[i] ~= nil then
    -- 		SmashVehicleWindow(vehicle, i-1)
    -- 	end
    -- end
    end

    if props.color2 ~= nil then
        local color1, _ = GetVehicleColours(vehicle)
        SetVehicleColours(vehicle, color1, props.color2)
    end

    if props.pearlescentColor ~= nil then
        local _, wheelColor = GetVehicleExtraColours(vehicle)
        SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
    end

    if props.wheelColor ~= nil then
        local pearlescentColor, _ = GetVehicleExtraColours(vehicle)
        SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
    end

    if props.wheels ~= nil then
        SetVehicleWheelType(vehicle, props.wheels)
    end

    if props.windowTint ~= nil then
        SetVehicleWindowTint(vehicle, props.windowTint)
    end

    if props.neonEnabled ~= nil then
        SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
        SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
        SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
        SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
    end

    if props.neonColor ~= nil then
        SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
    end
    if props.extras ~= nil then
        for i = 1, #props.extras, 1 do
            SetVehicleExtra(vehicle, i - 1, props.extras[i])
        end
    end
    if props.modSmokeEnabled ~= nil then
        ToggleVehicleMod(vehicle, 20, true)
    end

    if props.tyreSmokeColor ~= nil then
        SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
    end

    if props.modSpoilers ~= nil then
        SetVehicleMod(vehicle, 0, props.modSpoilers, false)
    end

    if props.modFrontBumper ~= nil then
        SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
    end

    if props.modRearBumper ~= nil then
        SetVehicleMod(vehicle, 2, props.modRearBumper, false)
    end

    if props.modSideSkirt ~= nil then
        SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
    end

    if props.modExhaust ~= nil then
        SetVehicleMod(vehicle, 4, props.modExhaust, false)
    end

    if props.modFrame ~= nil then
        SetVehicleMod(vehicle, 5, props.modFrame, false)
    end

    if props.modGrille ~= nil then
        SetVehicleMod(vehicle, 6, props.modGrille, false)
    end

    if props.modHood ~= nil then
        SetVehicleMod(vehicle, 7, props.modHood, false)
    end

    if props.modFender ~= nil then
        SetVehicleMod(vehicle, 8, props.modFender, false)
    end

    if props.modRightFender ~= nil then
        SetVehicleMod(vehicle, 9, props.modRightFender, false)
    end

    if props.modRoof ~= nil then
        SetVehicleMod(vehicle, 10, props.modRoof, false)
    end

    if props.modEngine ~= nil then
        SetVehicleMod(vehicle, 11, props.modEngine, false)
    end

    if props.modBrakes ~= nil then
        SetVehicleMod(vehicle, 12, props.modBrakes, false)
    end

    if props.modTransmission ~= nil then
        SetVehicleMod(vehicle, 13, props.modTransmission, false)
    end

    if props.modHorns ~= nil then
        SetVehicleMod(vehicle, 14, props.modHorns, false)
    end

    if props.modSuspension ~= nil then
        SetVehicleMod(vehicle, 15, props.modSuspension, false)
    end

    if props.modArmor ~= nil then
        SetVehicleMod(vehicle, 16, props.modArmor, false)
    end

    if props.modTurbo ~= nil then
        ToggleVehicleMod(vehicle, 18, props.modTurbo)
    end

    if props.modXenon ~= nil then
        ToggleVehicleMod(vehicle, 22, props.modXenon)
    end

    if props.modFrontWheels ~= nil then
        SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
    end

    if props.modBackWheels ~= nil then
        SetVehicleMod(vehicle, 24, props.modBackWheels, false)
    end

    if props.modPlateHolder ~= nil then
        SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
    end

    if props.modVanityPlate ~= nil then
        SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
    end

    if props.modTrimA ~= nil then
        SetVehicleMod(vehicle, 27, props.modTrimA, false)
    end

    if props.modOrnaments ~= nil then
        SetVehicleMod(vehicle, 28, props.modOrnaments, false)
    end

    if props.modDashboard ~= nil then
        SetVehicleMod(vehicle, 29, props.modDashboard, false)
    end

    if props.modDial ~= nil then
        SetVehicleMod(vehicle, 30, props.modDial, false)
    end

    if props.modDoorSpeaker ~= nil then
        SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
    end

    if props.modSeats ~= nil then
        SetVehicleMod(vehicle, 32, props.modSeats, false)
    end

    if props.modSteeringWheel ~= nil then
        SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
    end

    if props.modShifterLeavers ~= nil then
        SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
    end

    if props.modAPlate ~= nil then
        SetVehicleMod(vehicle, 35, props.modAPlate, false)
    end

    if props.modSpeakers ~= nil then
        SetVehicleMod(vehicle, 36, props.modSpeakers, false)
    end

    if props.modTrunk ~= nil then
        SetVehicleMod(vehicle, 37, props.modTrunk, false)
    end

    if props.modHydrolic ~= nil then
        SetVehicleMod(vehicle, 38, props.modHydrolic, false)
    end

    if props.modEngineBlock ~= nil then
        SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
    end

    if props.modAirFilter ~= nil then
        SetVehicleMod(vehicle, 40, props.modAirFilter, false)
    end

    if props.modStruts ~= nil then
        SetVehicleMod(vehicle, 41, props.modStruts, false)
    end

    if props.modArchCover ~= nil then
        SetVehicleMod(vehicle, 42, props.modArchCover, false)
    end

    if props.modAerials ~= nil then
        SetVehicleMod(vehicle, 43, props.modAerials, false)
    end

    if props.modTrimB ~= nil then
        SetVehicleMod(vehicle, 44, props.modTrimB, false)
    end

    if props.modTank ~= nil then
        SetVehicleMod(vehicle, 45, props.modTank, false)
    end

    if props.modWindows ~= nil then
        SetVehicleMod(vehicle, 46, props.modWindows, false)
    end

    if props.modLivery ~= nil then
        SetVehicleMod(vehicle, 48, props.modLivery, false)
    end

    if props.hasDriftTyres ~= nil then
			SetDriftTyresEnabled(vehicle, props.hasDriftTyres)
			DecorSetBool(vehicle, "drifttyres", props.hasDriftTyres)
    end

    if props.hasHydraulic ~= nil then
			DecorSetBool(vehicle, "hydraulicSystem", props.hasHydraulic)
    end
end

function Ora.World.Vehicle:ApplyDamagesToVehicle(vehicle, health)
  health = health or {}

  health.tires = health.tires or {}
  for _, tireIndex in pairs(health.tires) do
      SetVehicleTyreBurst(vehicle, tonumber(tireIndex), true, 1000.0)
  end

  if health.engine then
      SetVehicleEngineHealth(vehicle, tonumber(health.engine))
  end

  if (health.doors) then
    for k, v in pairs(health.doors) do
      if v == 0 then
        pcall(
          function(vehicle, k) 
            SetVehicleDoorBroken(vehicle, k, true)
          end, 
          vehicle,
          k
        )
      end
    end
  end

  --[[ if (health.windows) then
    for _,v in pairs(health.windows) do
      SmashVehicleWindow(vehicle, v)
    end
  end ]]
  
  if health.body then
      SetVehicleBodyHealth(vehicle, tonumber(health.body))
      self:ApplyVisualDamages(vehicle, tonumber(health.body))
  end
end

function Ora.World.Vehicle:AddItemIntoTrunk(vehicle, itemName)
  local vehicleStorageName = self:GetIdentifier(vehicle)
  local items = {
    {id = generateUUIDV2(), name = itemName, metadata = {}, label = nil}
  }

  TriggerServerEvent("rage-reborn:TransfertToStorage", items, itemName, vehicleStorageName)
end

function Ora.World.Vehicle:RemoveAllItemsNameFromTrunk(vehicle, itemName)
  local vehicleStorageName = self:GetIdentifier(vehicle)
  TriggerServerEvent("Ora::SE::World:Vehicle:RemoveAllItemsNameFromTrunk", vehicleStorageName, itemName)
end

function Ora.World.Vehicle:GetVehicleCustoms(vehicle)
	local color1, color2 = GetVehicleColours(vehicle)
  local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

  return {
      livery = GetVehicleLivery(vehicle),
      model = GetEntityModel(vehicle),
      plate = GetVehicleNumberPlateText(vehicle),
      plateIndex = GetVehicleNumberPlateTextIndex(vehicle),
      health = GetEntityHealth(vehicle),
      dirtLevel = GetVehicleDirtLevel(vehicle),
      motorHealth = GetVehicleEngineHealth(vehicle),
      fuelLevel = GetFuel(vehicle),
      color1 = color1,
      color2 = color2,
      interiorColor = GetVehicleInteriorColour(vehicle),
      pearlescentColor = pearlescentColor,
      wheelColor = wheelColor,
      extras = {
          not IsVehicleExtraTurnedOn(vehicle, 0),
          not IsVehicleExtraTurnedOn(vehicle, 1),
          not IsVehicleExtraTurnedOn(vehicle, 2),
          not IsVehicleExtraTurnedOn(vehicle, 3),
          not IsVehicleExtraTurnedOn(vehicle, 4),
          not IsVehicleExtraTurnedOn(vehicle, 5),
          not IsVehicleExtraTurnedOn(vehicle, 6),
          not IsVehicleExtraTurnedOn(vehicle, 7),
          not IsVehicleExtraTurnedOn(vehicle, 8),
          not IsVehicleExtraTurnedOn(vehicle, 9),
          not IsVehicleExtraTurnedOn(vehicle, 10),
          not IsVehicleExtraTurnedOn(vehicle, 11),
          not IsVehicleExtraTurnedOn(vehicle, 12),
          not IsVehicleExtraTurnedOn(vehicle, 13),
          not IsVehicleExtraTurnedOn(vehicle, 14),
          not IsVehicleExtraTurnedOn(vehicle, 15)
      },
      wheels = GetVehicleWheelType(vehicle),
      windowTint = GetVehicleWindowTint(vehicle),
      wheelLevel = {
          IsVehicleTyreBurst(vehicle, 0),
          IsVehicleTyreBurst(vehicle, 1),
          IsVehicleTyreBurst(vehicle, 2),
          IsVehicleTyreBurst(vehicle, 3)
      },
      windowStatus = {
          IsVehicleWindowIntact(vehicle, 0),
          IsVehicleWindowIntact(vehicle, 1),
          IsVehicleWindowIntact(vehicle, 2),
          IsVehicleWindowIntact(vehicle, 3),
          IsVehicleWindowIntact(vehicle, 4)
      },
      doorStat = {
          IsVehicleDoorDamaged(vehicle, 0),
          IsVehicleDoorDamaged(vehicle, 1),
          IsVehicleDoorDamaged(vehicle, 2),
          IsVehicleDoorDamaged(vehicle, 3),
          IsVehicleDoorDamaged(vehicle, 4),
          IsVehicleDoorDamaged(vehicle, 5)
      },
      neonEnabled = {
          IsVehicleNeonLightEnabled(vehicle, 0),
          IsVehicleNeonLightEnabled(vehicle, 1),
          IsVehicleNeonLightEnabled(vehicle, 2),
          IsVehicleNeonLightEnabled(vehicle, 3)
      },
      neonColor = table.pack(GetVehicleNeonLightsColour(vehicle)),
      tyreSmokeColor = table.pack(GetVehicleTyreSmokeColor(vehicle)),
      modSpoilers = GetVehicleMod(vehicle, 0),
      modFrontBumper = GetVehicleMod(vehicle, 1),
      modRearBumper = GetVehicleMod(vehicle, 2),
      modSideSkirt = GetVehicleMod(vehicle, 3),
      modExhaust = GetVehicleMod(vehicle, 4),
      modFrame = GetVehicleMod(vehicle, 5),
      modGrille = GetVehicleMod(vehicle, 6),
      modHood = GetVehicleMod(vehicle, 7),
      modFender = GetVehicleMod(vehicle, 8),
      modRightFender = GetVehicleMod(vehicle, 9),
      modRoof = GetVehicleMod(vehicle, 10),
      modEngine = GetVehicleMod(vehicle, 11),
      modBrakes = GetVehicleMod(vehicle, 12),
      modTransmission = GetVehicleMod(vehicle, 13),
      modHorns = GetVehicleMod(vehicle, 14),
      modSuspension = GetVehicleMod(vehicle, 15),
      modArmor = GetVehicleMod(vehicle, 16),
      modTurbo = IsToggleModOn(vehicle, 18),
      modSmokeEnabled = IsToggleModOn(vehicle, 20),
      modXenon = IsToggleModOn(vehicle, 22),
      modXenonColor = GetVehicleHeadlightsColour(vehicle),
      modFrontWheels = GetVehicleMod(vehicle, 23),
      modBackWheels = GetVehicleMod(vehicle, 24),
      modPlateHolder = GetVehicleMod(vehicle, 25),
      modVanityPlate = GetVehicleMod(vehicle, 26),
      modTrimA = GetVehicleMod(vehicle, 27),
      modOrnaments = GetVehicleMod(vehicle, 28),
      modDashboard = GetVehicleMod(vehicle, 29),
      modDial = GetVehicleMod(vehicle, 30),
      modDoorSpeaker = GetVehicleMod(vehicle, 31),
      modSeats = GetVehicleMod(vehicle, 32),
      modSteeringWheel = GetVehicleMod(vehicle, 33),
      modShifterLeavers = GetVehicleMod(vehicle, 34),
      modAPlate = GetVehicleMod(vehicle, 35),
      modSpeakers = GetVehicleMod(vehicle, 36),
      modTrunk = GetVehicleMod(vehicle, 37),
      modHydrolic = GetVehicleMod(vehicle, 38),
      modEngineBlock = GetVehicleMod(vehicle, 39),
      modAirFilter = GetVehicleMod(vehicle, 40),
      modStruts = GetVehicleMod(vehicle, 41),
      modArchCover = GetVehicleMod(vehicle, 42),
      modAerials = GetVehicleMod(vehicle, 43),
      modTrimB = GetVehicleMod(vehicle, 44),
      modTank = GetVehicleMod(vehicle, 45),
      modWindows = GetVehicleMod(vehicle, 46),
      modLivery = GetVehicleMod(vehicle, 48),
      label = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))),
      hasDriftTyres = DecorGetBool(vehicle, "drifttyres") or false,
      hasHydraulic = DecorGetBool(vehicle, "hydraulicSystem") or false
  }
end

function Ora.World.Vehicle:GetVehicleHealth(vehicle)
	if not vehicle or not DoesEntityExist(vehicle) then return {} end
	local vehicleHealth = { doors = {}, tires = {}, windows = {}, body = GetVehicleBodyHealth(vehicle), engine = GetVehicleEngineHealth(vehicle), fuel = GetVehicleFuelLevel(vehicle)}

	for i=0, GetNumberOfVehicleDoors(vehicle) - 1 do
		if IsVehicleDoorDamaged(vehicle, i) then
			vehicleHealth.doors[i] = 0
		end
	end

	for i=0, GetVehicleNumberOfWheels(vehicle) - 1 do
		if IsVehicleTyreBurst(vehicle, i, true) then
			vehicleHealth.tires[i] = 0
		elseif IsVehicleTyreBurst(vehicle, i, false) then
			vehicleHealth.tires[i] = 1
		end
	end

  for i=0, 7 do
		if not IsVehicleWindowIntact(vehicle, i) then
			vehicleHealth.windows[#vehicleHealth.windows + 1] = i
		end
	end

	return vehicleHealth
end

function Ora.World.Vehicle:GetIdentifier(vehicle)
  local status, vehicleIdentifier = pcall(
    function(vehicle) 
      if (DoesEntityExist(vehicle)) then
        return GetEntityModel(vehicle) .. "|" .. GetVehicleNumberPlateText(vehicle)    
      end

      return false
    end, 
    vehicle
  )

  if (status == true) then
      return vehicleIdentifier
  end
end

function Ora.World.Vehicle:SetFuel(vehicle, value)
    if type(value) == 'number' and value >= 0.0 and value <= 100.0 then
		SetVehicleFuelLevel(vehicle, value + 0.0)
        DecorSetFloat(vehicle, "FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
	end
end

function Ora.World.Vehicle:ApplyVisualDamages(vehicle, damageLevel)
    local currentDamageLevel
    for bodyHealth, damage in pairs(Ora.World.Vehicle.DataDamagesLevelMapper) do
        if bodyHealth >= damageLevel and (not currentDamageLevel or currentDamageLevel >= bodyHealth) then
          currentDamageLevel = bodyHealth
        end
    end
    if not currentDamageLevel then
      return
    end
    local dammageMapperValue = Ora.World.Vehicle.DataDamagesLevelMapper[currentDamageLevel]
    local damageIndicator = 0
    for damageFactorX = 0, 4 do
        local xOffset = -.5 + .5 * damageFactorX
        for damageFactorY = 0, 4 do
            local yOffset = -.5 + .5 * damageFactorY
            for damageFactorZ = 0, 4 do
                damageIndicator = damageIndicator + 1
                SetVehicleDamage(vehicle, xOffset, yOffset, -.5 + .5 * damageFactorZ, dammageMapperValue + .0, 500.0, true)
            end
        end
    end
end

function Ora.World.Vehicle:Delete(entity)
  -- Logic to delete vehicle  
  if DoesEntityExist(entity) then
    DeleteEntity(entity)
    self:RemoveSpawnedVehicle(NetToVeh(entity))
  end

end

function Ora.World.Vehicle:SetVehicleHasBeenOwnedByPlayer(vehicle)
  -- Logic to make a vehicle owned by a player
  if not HasVehicleBeenOwnedByPlayer(vehicle) then
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
  end
end

function Ora.World.Vehicle:HasBeenOwnedByPlayer(vehicle)
  return HasVehicleBeenOwnedByPlayer(vehicle)
end

function Ora.World.Vehicle:SetPedAsDriver(vehicle, ped)
  -- Teleport the ped in the vehicle and set him at the driver seat
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
end

function Ora.World.Vehicle:SetPedAsPassenger(vehicle, ped, seat)
    -- Teleport the ped in the vehicle and set him at the driver seat
    TaskWarpPedIntoVehicle(ped, vehicle, seat)
end

function Ora.World.Vehicle:GetNPCVehicleAround(position, radius, specificModel)
  -- Return a NPC vehicle around for a given radius
  for vehicle in EnumerateVehicles() do
    if vehicle and DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(vehicle), position, true) < (radius + 0.0) then
      local pedDriving = GetPedInVehicleSeat(vehicle, -1)
      if (pedDriving and DoesEntityExist(pedDriving) and not IsPedAPlayer(pedDriving)) then
        return vehicle
      end
    end
  end

  return false
end

function Ora.World.Vehicle:AddDriver(vehicle, pedModel)
    local driverPed = Ora.World.Ped:Create(5, pedModel, GetEntityCoords(vehicle), 0.0)
    self:SetPedAsDriver(vehicle, driverPed)
    return driverPed
end

function Ora.World.Vehicle:AddPassenger(vehicle, pedModel, seat)
    local passengerPed = Ora.World.Ped:Create(5, pedModel, GetEntityCoords(vehicle), 0.0)
    self:SetPedAsPassenger(vehicle, passengerPed, seat)

    return passengerPed
end

function Ora.World.Vehicle:IsPlayerInAnyVehicle(playerPed, returnEntity)
  returnEntity = returnEntity or false
  if (returnEntity == false) then
    return IsPedInAnyVehicle(playerPed, false)
  end

  if (IsPedInAnyVehicle(playerPed, false)) then
    return GetVehiclePedIsIn(playerPed, false), IsPedInAnyVehicle(playerPed, false)
  end

  return false, false
  -- Returns true or false wether the player ped is in vehicle, and if returnEntity is true, it returns the vehicle
end

function Ora.World.Vehicle:IsPlayerInVehicle(playerPed, vehicle, returnEntity)
  returnEntity = returnEntity or false
  if (returnEntity == false) then
    return IsPedInVehicle(playerPed, vehicle, false)
  end

  if (IsPedInVehicle(playerPed, vehicle, false)) then
    return GetVehiclePedIsIn(playerPed, false), IsPedInVehicle(playerPed, vehicle, false)
  end

  return false, false
  -- Returns true or false wether the player ped is in specific vehicle, and if returnEntity is true, it returns the vehicle
end

local handlingData = {
	-- generic handling data
	"handlingName",
	"fMass",
	"fInitialDragCoeff",
	"fPercentSubmerged",
	"vecCentreOfMassOffset",
	"vecInertiaMultiplier",
	"fDriveBiasFront",
	"nInitialDriveGears",
	"fInitialDriveForce",
	"fDriveInertia",
	"fClutchChangeRateScaleUpShift",
	"fClutchChangeRateScaleDownShift",
	"fInitialDriveMaxFlatVel",
	"fBrakeForce",
	"fBrakeBiasFront",
	"fHandBrakeForce",
	"fSteeringLock",
	"fTractionCurveMax",
	"fTractionCurveMin",
	"fTractionCurveLateral",
	"fTractionSpringDeltaMax",
	"fLowSpeedTractionLossMult",
	"fCamberStiffnesss",
	"fTractionBiasFront",
	"fTractionLossMult",
	"fSuspensionForce",
	"fSuspensionCompDamp",
	"fSuspensionReboundDamp",
	"fSuspensionUpperLimit",
	"fSuspensionLowerLimit",
	"fSuspensionRaise",
	"fSuspensionBiasFront",
	"fTractionCurveMax",
	"fAntiRollBarForce",
	"fAntiRollBarBiasFront",
	"fRollCentreHeightFront",
	"fRollCentreHeightRear",
	"fCollisionDamageMult",
	"fWeaponDamageMult",
	"fDeformationDamageMult",
	"fEngineDamageMult",
	"fPetrolTankVolume",
	"fOilVolume",
	"fSeatOffsetDistX",
	"fSeatOffsetDistY",
	"fSeatOffsetDistZ",
	"nMonetaryValue",
	"strModelFlags",
	"strHandlingFlags",
	"strDamageFlags",
	"AIHandling",
	-- CFlyingHandlingData
	"fThrust",
	"fThrustFallOff",
	"fThrustVectoring",
	"fYawMult",
	"fYawStabilise",
	"fSideSlipMult",
	"fRollMult",
	"fRollStabilise",
	"fPitchMult",
	"fPitchStabilise",
	"fFormLiftMult",
	"fAttackLiftMult",
	"fAttackDiveMult",
	"fGearDownDragV",
	"fGearDownLiftMult",
	"fWindMult",
	"fMoveRes",
	"vecTurnRes",
	"vecSpeedRes",
	"fGearDoorFrontOpen",
	"fGearDoorRearOpen",
	"fGearDoorRearOpen2",
	"fGearDoorRearMOpen",
	"fTurublenceMagnitudeMax",
	"fTurublenceForceMulti",
	"fTurublenceRollTorqueMulti",
	"fTurublencePitchTorqueMulti",
	"fBodyDamageControlEffectMult",
	"fInputSensitivityForDifficulty",
	"fOnGroundYawBoostSpeedPeak",
	"fOnGroundYawBoostSpeedCap",
	"fEngineOffGlideMulti",
	"handlingType",
	"fThrustFallOff",
	"fThrustFallOff",
	-- CCarHandlingData
	"fBackEndPopUpCarImpulseMult",
	"fBackEndPopUpBuildingImpulseMult",
	"fBackEndPopUpMaxDeltaSpeed",
	-- CBikeHandlingData
	"fLeanFwdCOMMult",
	"fLeanFwdForceMult",
	"fLeanBakCOMMult",
	"fLeanBakForceMult",
	"fMaxBankAngle",
	"fFullAnimAngle",
	"fDesLeanReturnFrac",
	"fStickLeanMult",
	"fBrakingStabilityMult",
	"fInAirSteerMult",
	"fWheelieBalancePoint",
	"fStoppieBalancePoint",
	"fWheelieSteerMult",
	"fRearBalanceMult",
	"fFrontBalanceMult",
	"fBikeGroundSideFrictionMult",
	"fBikeWheelGroundSideFrictionMult",
	"fBikeOnStandLeanAngle",
	"fBikeOnStandSteerAngle",
	"fJumpForce",
}

-- sets the vehicle handling data, useful for setting single values
function Ora.World.Vehicle:SetVehicleHandlingData(Vehicle, Data, Value)
    if DoesEntityExist(Vehicle) and Data and Value then
        for theKey, property in pairs(handlingData) do 
            if property == Data then
                local intfind = string.find(property, "n")
                local floatfind = string.find(property, "f")
                local strfind = string.find(property, "str")
                local vecfind = string.find(property, "vec")
                
                
                if intfind ~= nil and intfind == 1 then
                    SetVehicleHandlingInt(Vehicle, "CHandlingData", Data, tonumber(Value))
                elseif floatfind ~= nil and floatfind == 1 then
                    local Value = tonumber(Value)+.0
                    SetVehicleHandlingFloat(Vehicle, "CHandlingData", Data, tonumber(Value))
                elseif strfind ~= nil and strfind == 1 then
                    SetVehicleHandlingField(Vehicle, "CHandlingData", Data, Value)
                elseif vecfind ~= nil and vecfind == 1 then
                    SetVehicleHandlingVector(Vehicle, "CHandlingData", Data, Value)
                else
                    SetVehicleHandlingField(Vehicle, "CHandlingData", Data, Value)
                end
            end
        end
    end
end

-- this returns the data that, although not necesarilly needed, useful if you just want to get the value of one single property property
function Ora.World.Vehicle:GetVehicleHandlingData(Vehicle, Data)
    if DoesEntityExist(Vehicle) then
        for theKey, property in pairs(handlingData) do 
            if property == Data then
                local intfind = string.find(property, "n")
                local floatfind = string.find(property, "f")
                local strfind = string.find(property, "str")
                local vecfind = string.find(property, "vec")
                
                if intfind ~= nil and intfind == 1 then
                    return GetVehicleHandlingInt(Vehicle, "CHandlingData", Data)
                elseif floatfind ~= nil and floatfind == 1 then
                    return GetVehicleHandlingFloat(Vehicle, "CHandlingData", Data)
                elseif vecfind ~= nil and vecfind == 1 then
                    return GetVehicleHandlingVector(Vehicle, "CHandlingData", Data)
                else
                    return false
                end
            end
        end
    end
end

-- this returns **all** handling properties and their values in a table, the table will have following contents: "name" = the name of the property, "value" = a number, string or vector3, "type" = the type, int, float or vector3
function Ora.World.Vehicle:GetAllVehicleHandlingData(Vehicle)
    local VehicleHandlingData = {}
    if DoesEntityExist(Vehicle) then
        for i, theData in pairs(handlingData) do 
            local intfind = string.find(theData, "n")
            local floatfind = string.find(theData, "f")
            local strfind = string.find(theData, "str")
            local vecfind = string.find(theData, "vec")
            
            if intfind ~= nil and intfind == 1 and GetVehicleHandlingInt(Vehicle, "CHandlingData", theData) then
                table.insert(VehicleHandlingData, { name = theData, value = GetVehicleHandlingInt(Vehicle, "CHandlingData", theData), type = "int"})
            elseif floatfind ~= nil and floatfind == 1 and GetVehicleHandlingFloat(Vehicle, "CHandlingData", theData) then
                table.insert(VehicleHandlingData, { name = theData, value = GetVehicleHandlingFloat(Vehicle, "CHandlingData", theData), type = "float"})
            elseif vecfind ~= nil and vecfind == 1 and GetVehicleHandlingVector(Vehicle, "CHandlingData", theData) then
                table.insert(VehicleHandlingData, { name = theData, value = GetVehicleHandlingVector(Vehicle, "CHandlingData", theData), type = "vector3"})
            end
        end
        return VehicleHandlingData
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        if (GetIsTaskActive(LocalPlayer().Ped, 160)) then
            local playerPosition = GetEntityCoords(LocalPlayer().Ped)
            for object in EnumerateObjects() do
                if object and DoesEntityExist(object) and IsEntityAttached(object) and GetDistanceBetweenCoords(GetEntityCoords(object), playerPosition) <= 1.0  then
                    DeleteEntity(object)   
                end
            end
            Citizen.Wait(2000)
        end

    end
end)