local stationType = {
  [0] = Station.pos.cars,
  [1] = Station.pos.cars,
  [2] = Station.pos.cars,
  [3] = Station.pos.cars,
  [4] = Station.pos.cars,
  [5] = Station.pos.cars,
  [6] = Station.pos.cars,
  [7] = Station.pos.cars,
  [8] = Station.pos.cars,
  [9] = Station.pos.cars,
  [10] = Station.pos.cars,
  [11] = Station.pos.cars,
  [12] = Station.pos.cars,
  [13] = Station.pos.cars,
  [14] = Station.pos.boats,
  [15] = Station.pos.air,
  [16] = Station.pos.air,
  [17] = Station.pos.cars,
  [18] = Station.pos.cars,
  [19] = Station.pos.cars,
  [20] = Station.pos.cars,
  [21] = Station.pos.cars
}
local msg = ""
local fuelLiters, fuelT = 0, 0
local nofuel, fuelSynced, fbusy = false, false, false
local sVeh, stationInfo, vehTrailer, pumpLevels = {}, {}, {}, {}
local safeZone = (1.0 - GetSafeZoneSize()) * 0.5
local timerBar = {
    baseX = 0.918,
    baseY = 0.984,
    baseWidth = 0.165,
    baseHeight = 0.035,
    baseGap = 0.038,
    titleX = 0.012,
    titleY = -0.009,
    textX = 0.0785,
    textY = -0.0165,
    progressX = 0.047,
    progressY = 0.0015,
    progressWidth = 0.0616,
    progressHeight = 0.0105,
    txtDict = "timerbars",
    txtName = "all_black_bg",
}

RMenu.Add("essence", "main", RageUI.CreateMenu(nil, "Actions disponibles", 10, 100, "shopui_title_gasstation", "shopui_title_gasstation"))
RMenu.Add("essence", "main_fueler", RageUI.CreateSubMenu(RMenu:Get("essence", "main"), nil, "Actions disponibles"))
RMenu.Add("essence", "main_level", RageUI.CreateMenu(nil, "Actions disponibles", 10, 100, "shopui_title_gasstation", "shopui_title_gasstation"))

local function DrawTimerProgressBar(idx, title, progress, titleColor, fgColor, bgColor, usePlayerStyle)
  local title = title or ""
  local titleColor = titleColor or { 255, 255, 255, 255 }
  local progress = progress or false
  local fgColor = fgColor or { 255, 255, 255, 255 }
  local bgColor = bgColor or { 255, 255, 255, 255 }
  local titleScale = usePlayerStyle and 0.465 or 0.3
  local titleFont = usePlayerStyle and 4 or 0
  local titleFontOffset = usePlayerStyle and 0.00625 or 0.0
  local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

  if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
    RequestStreamedTextureDict(timerBar.txtDict, true)
    local t = GetGameTimer() + 5000
    repeat
      Citizen.Wait(0)
    until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
  end

  DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

  BeginTextCommandDisplayText("CELL_EMAIL_BCON")
  SetTextFont(titleFont)
  SetTextScale(titleScale, titleScale)
  SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
  SetTextRightJustify(true)
  SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
  AddTextComponentString(title)
  EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

  local progress = (progress < 0.0) and 0.0 or ((progress > 1.0) and 1.0 or progress)
  local progressX = (timerBar.baseX - safeZone) + timerBar.progressX
  local progressY = yOffset + timerBar.progressY
  local progressWidth = timerBar.progressWidth * progress

  DrawRect(progressX, progressY, timerBar.progressWidth, timerBar.progressHeight, bgColor[1], bgColor[2], bgColor[3], bgColor[4])
  DrawRect((progressX - timerBar.progressWidth / 2) + progressWidth / 2, progressY, progressWidth, timerBar.progressHeight, fgColor[1], fgColor[2], fgColor[3], fgColor[4])

  if idx ~= nil then
    if idx[1] then
      idx[1] = idx[1] + 1
    end
  end
end

local function distanceV(d1, d2)
  return #(d1-d2)
end

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function CreateBlip(coords, title)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 361)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 1)
	SetBlipDisplay(blip, 4)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(title)
  EndTextCommandSetBlipName(blip)
  return blip
end

local function CreateJobBlip(coords, title)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 1)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 1)
	SetBlipDisplay(blip, 4)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(title)
  EndTextCommandSetBlipName(blip)
  table.insert(Ora.Identity.Job:GetName() == 'raffinerie' and Ora.Identity.Job.Data.Blips or Ora.Identity.Orga.Data.Blips, blip)
  return blip
end

function GetAllPumpLevel()
  pumpLevels = {}
  TriggerServerCallback("fueler:getAllPumpLevel", function(pumpLevel)
    pumpLevels = pumpLevel
  end)
  while #pumpLevels == 0 do 
    Wait(100)
  end
  RageUI.Visible(RMenu:Get("essence", "main_level"), true)
end

local function noFuelLeft(vehicle)
  while nofuel do
    if GetIsVehicleEngineRunning(vehicle) then
      SetVehicleUndriveable(vehicle, true)
    end
    if GetVehiclePedIsIn(LocalPlayer().Ped, false) == 0 then
      SetVehicleUndriveable(vehicle, false)
      nofuel = false
      break
    end
    Wait(300)
  end
end

local function isVehicleElectric(veh)
  for _, model in ipairs(Station.electric.cars) do
    if model == GetEntityModel(veh) then
      return true
    end
  end
  return false
end

local function refuel(vehicle, liters, time)
  local vCoords = GetEntityCoords(vehicle)
  local time = time * 500
  local debug = 0
  local ped = nil
  local pedCoords = nil
  SetVehicleEngineOn(vehicle, false, false, true)
  FreezeEntityPosition(vehicle, true)
  if stationInfo.pedPos ~= nil then
    RequestModel(Station.ped.model)
    while not HasModelLoaded(Station.ped.model) do
      Citizen.Wait(100)
    end
    ped = Ora.World.Ped:Create(5, Station.ped.model, vector3(stationInfo.pedPos.x, stationInfo.pedPos.y, stationInfo.pedPos.z), stationInfo.pedPos.w)
    pedCoords = GetEntityCoords(ped)
    SetEntityInvincible(ped, true)
    TaskGoToEntity(ped, vehicle, -1, 0.5, 1.40)
    SetBlockingOfNonTemporaryEvents(ped, true)
    while distanceV(vCoords, pedCoords) > 2.50 do
      debug = debug + 1
      pedCoords = GetEntityCoords(ped)
      if debug >= 60 then
        debug = 0
        print("^4[DEBUG] Distance npc-car too high")
        break
      end
      Wait(500)
    end
    debug = 0
    TaskTurnPedToFaceEntity(ped, vehicle, -1)
    PlayAmbientSpeech1(ped, "GENERIC_HI", "SPEECH_PARAMS_STANDARD")
    Wait(2000)
    loadAnimDict(Station.ped.dict)
    TaskPlayAnim(ped, Station.ped.dict, Station.ped.anim, 2.0, 8.0, time, 50, 0, 0, 0, 0)
    Wait(time)
    SetFuel(vehicle, liters)
    PlayAmbientSpeech1(ped, "GENERIC_BYE", "SPEECH_PARAMS_FORCE")
    TaskGoToCoordAnyMeans(ped, stationInfo.pedPos.x, stationInfo.pedPos.y, stationInfo.pedPos.z, 1.40)
  else
    Wait(time)
    SetFuel(vehicle, liters)
  end
  SetVehicleEngineOn(vehicle, true, false, false)
  FreezeEntityPosition(vehicle, false)
  
  if stationInfo.pedPos ~= nil then
    while distanceV(pedCoords, vector3(stationInfo.pedPos.x, stationInfo.pedPos.y, stationInfo.pedPos.z)) > 2.00 do
      debug = debug + 1
      pedCoords = GetEntityCoords(ped)
      if debug >= 60 then
        debug = 0
        print("^4[DEBUG] Distance npc-pos too high")
        break
      end
      Wait(500)
    end
    TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = ped, network_id = NetworkGetNetworkIdFromEntity(ped), seconds = 30})
    DeletePed(ped)
  end
end

function GetFuel(vehicle)
	return DecorGetFloat(vehicle, Station.decor)
end

function SetFuel(vehicle, fuel)
  if type(fuel) == 'number' and fuel >= 1.00 and fuel <= 100 then
		SetVehicleFuelLevel(vehicle, fuel + 0.0)
    DecorSetFloat(vehicle, Station.decor, GetVehicleFuelLevel(vehicle))
    nofuel = false
  elseif fuel < 1.00 and GetIsVehicleEngineRunning(vehicle) then
    SetVehicleEngineOn(vehicle, false, true, true)
    if not nofuel then
      nofuel = true
      noFuelLeft(vehicle)
    end
	end
end

local function fuelFill()
  local farmLimit = GetFarmLimit()
  if farmLimit < 600 then
    local missingFuel = Station.max_fuel-stationInfo.fuel
    local qty = vehTrailer.fuel - missingFuel
    local ped = LocalPlayer().Ped
    local progress = 0
    local progressP = 1.0/Station.work.harvest.time
    local p
    
    if vehTrailer.fuel > missingFuel and (farmLimit + math.floor(Station.limitLiters*missingFuel)) < 600 then
      progressP = 1.0/(0.12*missingFuel)
      p = 1
    elseif vehTrailer.fuel < missingFuel and (farmLimit + math.floor(Station.limitLiters*vehTrailer.fuel)) < 600 then
      progressP = 1.0/(0.12*vehTrailer.fuel)
      p = 2
    else
      local limit = 600 - farmLimit
      progressP = 1.0/(0.12*(limit/Station.limitLiters))
      p = 3
    end
    if IsPedInAnyVehicle(ped, false) then
      local veh = GetVehiclePedIsIn(ped, false)
      if GetEntityModel(vehTrailer.trailer) == `tanker` then
        fbusy = true
        FreezeEntityPosition(veh, true)
        SetVehicleEngineOn(veh, false, false, true)
        Citizen.CreateThread(function()
          while progress < 1.0 do
            DrawTimerProgressBar({1}, "Remplissage", progress, nil, {255, 0, 0, 255})
            Wait(0)
          end
        end)
        Citizen.CreateThread(function()
          while progress < 1.0 do
            progress = progress + progressP
            Wait(1000)
          end
          
          if p == 1 then
            DecorSetFloat(vehTrailer.trailer, Station.decor_treatment, qty)
            SetFarmLimit(math.floor(Station.limitLiters*missingFuel))
            TriggerServerEvent("fueler:addLiters", stationInfo.id, missingFuel)
            TriggerServerEvent("business:SetProductivity", GetPlayerServerId(PlayerId()), "raffinerie", missingFuel*stationInfo.priceL, true)
            TriggerServerEvent("entreprise:Add", "raffinerie", missingFuel*stationInfo.priceL)
          elseif p == 2 then
            DecorRemove(vehTrailer.trailer, Station.decor_treatment)
            SetFarmLimit(math.floor(Station.limitLiters*vehTrailer.fuel))
            TriggerServerEvent("fueler:addLiters", stationInfo.id, vehTrailer.fuel)
            TriggerServerEvent("business:SetProductivity", GetPlayerServerId(PlayerId()), "raffinerie", vehTrailer.fuel*stationInfo.priceL, true)
            TriggerServerEvent("entreprise:Add", "raffinerie", vehTrailer.fuel*stationInfo.priceL)
          elseif p == 3 then
            local limit = 600 - farmLimit
            local liters = vehTrailer.fuel-(limit/Station.limitLiters)
            DecorSetFloat(vehTrailer.trailer, Station.decor_treatment, liters)
            SetFarmLimit(limit)
            if (limit/Station.limitLiters) + stationInfo.fuel > Station.max_fuel then
              TriggerServerEvent("fueler:addLiters", stationInfo.id, missingFuel)
              TriggerServerEvent("business:SetProductivity", GetPlayerServerId(PlayerId()), "raffinerie", missingFuel*stationInfo.priceL, true)
              TriggerServerEvent("entreprise:Add", "raffinerie", missingFuel*stationInfo.priceL)
            else
              TriggerServerEvent("fueler:addLiters", stationInfo.id, limit/Station.limitLiters)
              TriggerServerEvent("business:SetProductivity", GetPlayerServerId(PlayerId()), "raffinerie", (limit/Station.limitLiters)*stationInfo.priceL, true)
              TriggerServerEvent("entreprise:Add", "raffinerie", (limit/Station.limitLiters)*stationInfo.priceL)
            end
          end
          FreezeEntityPosition(veh, false)
          SetVehicleEngineOn(veh, true, false, false)
          fbusy = false
        end)
      else
        RageUI.Popup({message = "~r~Où est ta citerne?"})
      end
    else
      RageUI.Popup({message = "~r~Remonte dans ton véhicule"})
    end
  else
    RageUI.Popup({message = "~r~Vous avez atteint votre limite de farm"})
  end
end

local function isNearStation(veh, class)
  local distP = 3.00
  local pedCoords = LocalPlayer().Pos
  for _, v in ipairs(stationType[class]) do
    if (distanceV(pedCoords, v.coords) < v.radius) or (v.coords2 and (distanceV(pedCoords, v.coords2) < v.radius2)) then
      if isVehicleElectric(veh) then
        local clPump = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, distP, Station.electric.pump, false, false, false)
        if DoesEntityExist(clPump) then
          msg = "Appuyez sur ~INPUT_CONTEXT~ pour recharger"
          return true, v.id, (v.priceL * 0.50), v.pedPos, 0.50
        else
          return false
        end
      end

      for _, model in ipairs(Station.pumpModel) do
        if stationType[class] == Station.pos.air then
          distP = 8.5
        end
        local clPump = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, distP, model, false, false, false)
        if DoesEntityExist(clPump) then
          msg = "Appuyez sur ~INPUT_CONTEXT~ pour acheter de l'essence"
          return true, v.id, v.priceL, v.pedPos, 1.00
        end
      end
    end
  end
  return false
end

local function ManageFuelUsage(vehicle)
  if not DecorExistOn(vehicle, Station.decor) then
    local tankV = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fPetrolTankVolume")
    if tankV == 0 then tankV = 60 end
		SetFuel(vehicle, tankV * 0.75)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))
		fuelSynced = true
	end
  if GetIsVehicleEngineRunning(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Station.vehUsageByRPM[round(GetVehicleCurrentRpm(vehicle), 1)] * (Station.vehClasses[GetVehicleClass(vehicle)] or 1.0) / 10)
	end
end

local function Interact(msg)
  if not IsHelpMessageOnScreen() then
    SetTextComponentFormat('STRING')
    AddTextComponentString(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
  end
end

RegisterNetEvent("fueler:spawnTanker")
AddEventHandler("fueler:spawnTanker", function()
  local coords = Station.work.tanker.spawn
  if #vehicleFct.GetVehiclesInArea({x = Station.work.tanker.spawn.x, y = Station.work.tanker.spawn.y, z = Station.work.tanker.spawn.z}, 5.0) == 0 then
    local tanker = Ora.World.Vehicle:Create("tanker", Station.work.tanker.spawn, Station.work.tanker.spawn.w, {customs = {}, warp_into_vehicle = false, health = {}})
    SetEntityInvincible(tanker, true)
  else
    RageUI.Popup({message = "~r~Une citerne est déjà sortie"})
  end
end)

RegisterNetEvent("fueler:harvest")
AddEventHandler("fueler:harvest", function()
  local ped = LocalPlayer().Ped
  local progress = 0
  local progressP = 1.0/Station.work.harvest.time
  if IsPedInAnyVehicle(ped, false) then
    local veh = GetVehiclePedIsIn(ped, false)
    local bool, trailer = GetVehicleTrailerVehicle(veh)
    if GetEntityModel(trailer) == `tanker` then
      fbusy = true
      FreezeEntityPosition(veh, true)
      SetVehicleEngineOn(veh, false, false, true)
      Citizen.CreateThread(function()
        while progress < 1.0 do
          DrawTimerProgressBar({1}, "Remplissage", progress, nil, {255, 0, 0, 255})
          Wait(0)
        end
      end)
      while progress < 1.0 do
        progress = progress + progressP
        Wait(1000)
      end
      DecorSetFloat(trailer, Station.decor_harvest, Station.work.harvest.qty)
      FreezeEntityPosition(veh, false)
      SetVehicleEngineOn(veh, true, false, false)
      fbusy = false
    else
      RageUI.Popup({message = "~r~Où est ta citerne?"})
    end
  else
    RageUI.Popup({message = "~r~Remonte dans ton véhicule"})
  end
end)

RegisterNetEvent("fueler:treatment")
AddEventHandler("fueler:treatment", function()
  local ped = LocalPlayer().Ped
  local progress = 0
  local progressP = 1.0/Station.work.treatment.time
  if IsPedInAnyVehicle(ped, false) then
    local veh = GetVehiclePedIsIn(ped, false)
    local bool, trailer = GetVehicleTrailerVehicle(veh)
    if GetEntityModel(trailer) == `tanker` then
      if DecorGetFloat(trailer, Station.decor_harvest) == Station.work.harvest.qty then
        fbusy = true
        FreezeEntityPosition(veh, true)
        SetVehicleEngineOn(veh, false, false, true)
        Citizen.CreateThread(function()
          while progress < 1.0 do
            DrawTimerProgressBar({1}, "Traitement", progress, nil, {255, 0, 0, 255})
            Wait(0)
          end
        end)
        while progress < 1.0 do
          progress = progress + progressP
          Wait(1000)
        end
        DecorRemove(trailer, Station.decor_harvest)
        DecorSetFloat(trailer, Station.decor_treatment, Station.work.harvest.qty)
        FreezeEntityPosition(veh, false)
        SetVehicleEngineOn(veh, true, false, false)
        fbusy = false
      else
        RageUI.Popup({message = "~r~Ta citerne est vide"})
      end
    else
      RageUI.Popup({message = "~r~Où est ta citerne?"})
    end
  else
    RageUI.Popup({message = "~r~Remonte dans ton véhicule"})
  end
end)

function createFuelerJob()
  for k, v in pairs(Station.work) do
    if type(v.pos) == "vector3" then
      CreateJobBlip(v.pos, v.blipTitle)
    else
      for t, u in ipairs(v.pos) do
        CreateJobBlip(u, v.blipTitle)
      end
    end
  end

  Citizen.CreateThread(function()
    while true do
      local wait = 1000
      if not fbusy then
        for k, v in pairs(Station.work) do
          if type(v.pos) == "vector3" then
            if #(GetEntityCoords(ped) - v.pos) < v.radius then
              Interact(v.msg)
              if IsControlJustPressed(1, 38) then
                TriggerEvent(v.action)
              end
              wait = 0
            end
          else
            if IsPedInAnyVehicle(LocalPlayer().Ped, false) then
              for t, u in ipairs(v.pos) do
                if #(GetEntityCoords(ped) - u) < v.radius then
                  Interact(v.msg)
                  if IsControlJustPressed(1, 38) then
                    TriggerEvent(v.action)
                  end
                  wait = 0
                end
              end
            end
          end
        end
      end
      Wait(wait)
    end
  end)
end

Citizen.CreateThread(function()
  while true do
    local ped = LocalPlayer().Ped
    local waitF = 2000
    if RageUI.CurrentMenu == nil and not fbusy then
      if IsPedInAnyVehicle(ped, false) then
        local vehPed = GetVehiclePedIsIn(ped, false)
        if GetPedInVehicleSeat(vehPed, -1) == ped then
          if GetEntitySpeed(vehPed) < 2.0 then
            local station, id, price, pPos, qtyPerLiter = isNearStation(vehPed, GetVehicleClass(vehPed))
            if station then
              Interact(msg)
              if IsControlJustPressed(1, 38) then
                fuelLiters = 0
                stationInfo = nil
                sVeh = {veh = vehPed, vehFuel = math.floor(GetFuel(vehPed)), pVehFuel = math.floor(GetFuel(vehPed)), vehMaxFuel = math.floor(GetVehicleHandlingFloat(vehPed, "CHandlingData", "fPetrolTankVolume"))}
                if sVeh.vehMaxFuel == 0.0 then
                  sVeh.vehMaxFuel = 60
                end
                stationInfo = {id = id, priceL = price, pedPos = pPos, qpl = qtyPerLiter, fuel = nil}
                if Ora.Identity.Job:GetName() == "raffinerie" or Ora.Identity.Orga:Get().label == "Raffinerie" then
                  local veh = GetVehiclePedIsIn(LocalPlayer().Ped, false)
                  local bool, trailer = GetVehicleTrailerVehicle(veh)
                  if bool then
                    vehTrailer = {fuel = DecorGetFloat(trailer, Station.decor_treatment) or 0, trailer = trailer}
                  else
                    vehTrailer = {fuel = 0, trailer = nil}
                  end
                end
                if id ~= nil then
                  TriggerServerCallback("fueler:checkFuel", function(fuelQty)
                    stationInfo.fuel = fuelQty
                  end, id)
                  while stationInfo == nil do
                    Wait(100)
                  end
                end
                RageUI.Visible(RMenu:Get("essence", "main"), true)
              end
              waitF = 0
            end
          end
        end
      end
    end
    Wait(waitF)
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if RageUI.Visible(RMenu:Get("essence", "main")) then
      RageUI.DrawContent({header = true, glare = false}, function()
        local fuelS = stationInfo.fuel or ""
        RageUI.Button("Station "..stationInfo.priceL.."$/litres", nil, {RightLabel = fuelS}, true,function()
        end)
        RageUI.Progress("Réservoir", sVeh.pVehFuel, sVeh.vehMaxFuel, nil, false, true, function(_, _, Selected, Index)
          if Index > sVeh.vehFuel then
            sVeh.pVehFuel = Index 
            fuelLiters = sVeh.pVehFuel - sVeh.vehFuel
          end
          if Selected then
            local nFuel = tonumber(KeyboardInput("Combien de litres souhaitez vous prendre?", "", 3))
            if (nFuel ~= "" and nFuel ~= nil) and (nFuel + sVeh.vehFuel) > sVeh.vehFuel and (nFuel + sVeh.vehFuel) <= sVeh.vehMaxFuel then
              fuelLiters = nFuel - sVeh.pVehFuel
              sVeh.pVehFuel = nFuel + sVeh.vehFuel
            end
          end
        end)
        RageUI.Button("Acheter "..fuelLiters.." litres", nil, {Color = {BackgroundColor = {37, 41, 91, 25}},RightLabel = (stationInfo.priceL * fuelLiters).. "$"}, true,function(_, _, Selected)
          if Selected then
            if stationInfo.fuel ~= nil then 
              TriggerServerCallback("fueler:checkFuel", function(fuelQty)
                if fuelLiters <= fuelQty then
                  dataonWait = {
                    title = "Achat essence",
                    price = math.floor(stationInfo.priceL * fuelLiters),
                    fct = function()
                      TriggerServerEvent("fueler:removeLiters", stationInfo.id, fuelLiters*stationInfo.qpl)
                      TriggerServerEvent("entreprise:Add", "raffinerie", (stationInfo.priceL * fuelLiters))
                      refuel(sVeh.veh, (sVeh.vehFuel+fuelLiters), fuelLiters)
                    end
                  }
                  TriggerEvent("payWith?")
                else
                  ShowNotification("La station ne dispose plus que de ~b~"..stationInfo.fuel.." litres.")
                end
              end, stationInfo.id)
            else
              dataonWait = {
                title = "Achat essence",
                price = math.floor(stationInfo.priceL * fuelLiters),
                fct = function()
                  refuel(sVeh.veh, (sVeh.vehFuel+fuelLiters), fuelLiters)
                end
              }
              TriggerEvent("payWith?")
            end
          end
        end)
        local refuelV = sVeh.vehMaxFuel - sVeh.vehFuel
        RageUI.Button("Faire le plein "..refuelV.." litres", nil, {Color = {BackgroundColor = {37, 41, 91, 25}},RightLabel = (stationInfo.priceL * refuelV).. "$"}, true,function(_, _, Selected)
          if Selected then
            if stationInfo.fuel ~= nil then
              TriggerServerCallback("fueler:checkFuel", function(fuelQty)
                if refuelV <= fuelQty then
                  dataonWait = {
                    title = "Achat essence",
                    price = math.floor(stationInfo.priceL * refuelV),
                    fct = function()
                      TriggerServerEvent("fueler:removeLiters", stationInfo.id, refuelV*stationInfo.qpl)
                      TriggerServerEvent("entreprise:Add", "raffinerie", (stationInfo.priceL * refuelV))
                      refuel(sVeh.veh, (sVeh.vehFuel+refuelV), refuelV)
                    end
                  }
                  TriggerEvent("payWith?")
                else
                  ShowNotification("La station ne dispose plus que de ~b~"..stationInfo.fuel.." litres.")
                end
              end, stationInfo.id)
            else
              dataonWait = {
                title = "Achat essence",
                price = math.floor(stationInfo.priceL * refuelV),
                fct = function()
                  refuel(sVeh.veh, (sVeh.vehFuel+refuelV), refuelV)         
                end
              }
              TriggerEvent("payWith?")
            end
          end
        end)
        if stationInfo.id ~= nil and (Ora.Identity.Job:GetName() == "raffinerie" or Ora.Identity.Orga:Get().label == "Raffinerie") then
          RageUI.Button("Remplir la station", nil, {Color = {BackgroundColor = {37, 41, 91, 25}}}, true,function()
          end, RMenu:Get("essence", "main_fueler"))
        end
      end)
    elseif RageUI.Visible(RMenu:Get("essence", "main_fueler")) then
      RageUI.DrawContent({header = true, glare = false}, function()
        local fuelS = stationInfo.fuel or ""
        RageUI.Button("Contenu de la station", nil, {RightLabel = fuelS.."/"..Station.max_fuel}, true, function()
        end)
        RageUI.Button("Contenu de la citerne", nil, {RightLabel = vehTrailer.fuel.." litres"}, true, function()
        end)
        if Station.max_fuel ~= stationInfo.fuel then
          if vehTrailer.fuel > (Station.max_fuel-stationInfo.fuel) then
            RageUI.Button("Faire le plein "..(Station.max_fuel-stationInfo.fuel).." litres", nil, {Color = {BackgroundColor = {37, 41, 91, 25}}}, true, function(_, _, S)
              if S then
                RageUI.CloseAll()
                fuelFill()
              end
            end)
          else
            RageUI.Button("Mettre tout le contenu de la citerne : "..vehTrailer.fuel.." litres", nil, {Color = {BackgroundColor = {37, 41, 91, 25}}}, true, function(_, _, S)
              if S then
                if vehTrailer.fuel ~= 0 then
                  RageUI.CloseAll()
                  fuelFill()
                else
                  RageUI.Popup({message = "~r~ Votre citerne est vide"})
                end
              end
            end)
          end
        end
      end)
    elseif RageUI.Visible(RMenu:Get("essence", "main_level")) then
      RageUI.DrawContent({header = true, glare = false}, function()
        for k, v in ipairs(pumpLevels) do
          for t, u in ipairs(Station.pos.cars) do
            if k == u.id then
              RageUI.Button("Station n°"..k, nil, {RightLabel = v.stock.." litres"}, true,function(_, _, S)
                if S then
                  SetNewWaypoint(u.coords.x, u.coords.y)
                end
              end)
            end
          end
        end
      end)
    else
      Wait(500)
    end
  end
end)

Citizen.CreateThread(function()
	DecorRegister(Station.decor, 1)
  DecorRegister(Station.decor_harvest, 1)
  DecorRegister(Station.decor_treatment, 1)
	while true do
		Citizen.Wait(3500)
		local ped = LocalPlayer().Ped

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
      if GetPedInVehicleSeat(vehicle, -1) == ped then
        ManageFuelUsage(vehicle)
      end
		else
			if fuelSynced then
				fuelSynced = false
			end
		end
	end
end)

Citizen.CreateThread(function()
  local blipStations = {}
  local vehClass
  local vehElec
  while true do
    Wait(8000)
    local ped = LocalPlayer().Ped
    if IsPedInAnyVehicle(ped, false) then
      local vehPed = GetVehiclePedIsIn(ped, false)
      if GetVehicleClass(vehPed) ~= vehClass or isVehicleElectric(vehPed) ~= vehElec then
        if next(blipStations) then
          for _, v in ipairs(blipStations) do
            RemoveBlip(v)
          end
          blipStations = {}
        end
        vehClass = GetVehicleClass(vehPed)
        if isVehicleElectric(vehPed) then 
          vehElec = true
          for _, v in ipairs (stationType[vehClass]) do
            if v.coords2 ~= nil then
              local blip = CreateBlip(v.coords2, stationType[vehClass].blip.title2)
              table.insert(blipStations, blip)
            end
          end
        else
          vehElec = false
          for _, v in ipairs (stationType[vehClass]) do
            local blip = CreateBlip(v.coords, stationType[vehClass].blip.title)
            table.insert(blipStations, blip)
          end
        end
      end
    else
      if next(blipStations) then
        for _, v in ipairs(blipStations) do
          RemoveBlip(v)
        end
        blipStations = {}
        vehClass = nil
      end
    end
  end
end)