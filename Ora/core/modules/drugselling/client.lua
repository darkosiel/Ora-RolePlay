Ora.DrugDealing.System = {
  IS_ACTIVATED = false,
  CURRENT_DESTINATION = nil,
  CURRENT_DESTINATION_COORDS = nil,
  NEXT_MISSION_WAIT = math.random(1000 * 10, 1000 * 50),
  NEXT_MISSION_COUNT = math.random(1, 2),
  NEXT_MISSION_SELECTED_DRUG = nil,
  NEXT_MISSION_PED = nil,
  LAST_MISSION_TIME = 0,
  HAS_BEEN_CALLED = false,
  CHARACTER = nil,
  KEYS =  {["E"] = 38, ["SPACE"] = 22, ["DELETE"] = 178},
  WARNING_GIVEN = 0,
  ALLOW_REFRESH = false,
  ZONES = {},
  LAST_FETCH = 0,
  CURRENT_ZONE_ID = nil,
  QUALITY_TYPES = nil,
  HAS_BEEN_CALLED = false,
  CURRENT_DESTINATION_HEADING = 0.0,
  COUNTER_STARTED = false,
  PED_HAS_BEEN_CREATED = false
}

Ora.DrugDealing.Characters = {
  "CHAR_SIMEON",
  "CHAR_STRETCH",
  "CHAR_STEVE",
  "CHAR_SOLOMON",
  "CHAR_SAEEDA",
  "CHAR_TANISHA",
  "CHAR_TENNIS_COACH",
  "CHAR_WADE",
  "CHAR_TOW_TONYA",
  "CHAR_TRACEY",
  "CHAR_RON",
  "CHAR_OSCAR",
  "CHAR_ORTEGA",
  "CHAR_ONEIL"
}

Ora.DrugDealing.Peds = {
  "a_m_m_eastsa_01",
  "a_m_m_bevhills_01",
  "a_m_m_fatlatin_01",
  "a_m_m_mexlabor_01",
  "a_m_m_paparazzi_01",
  "a_m_y_soucent_02",
  "g_m_m_armlieut_01",
  "g_m_m_chigoon_02",
  "g_m_importexport_01",
  "s_m_m_autoshop_02",
  "s_m_m_ccrew_01",
  "s_m_y_barman_01"
}

Ora.DrugDealing.AvailableDrugs = {
  "coke1",
  "meth",
  "weed_pooch",
  "lsd_pooch",
  "crack",
  "matiere"
}

Ora.DrugDealing.PolicePhrase = {
  "Vente de drogue",
  "Dealer en action",
}

Ora.DrugDealing.Props = {
  weed_pooch = "bkr_prop_weed_bag_01a",
  meth = "p_meth_bag_01_s",
  coke1 = "bkr_prop_coke_cutblock_01",
  lsd_pooch = "bkr_prop_coke_cutblock_01",
  crack = "bkr_prop_coke_cutblock_01"
}

Ora.DrugDealing.Prices = {
    weed_pooch = {30, 50},
    coke1 = {250, 280},
    meth = {60, 80},
    lsd_pooch = {130, 150},
    crack = {200, 230}
}

Ora.DrugDealing.Demand = {
  weed_pooch = {4, 5},
  coke1 = {3, 4},
  meth = {3, 4},
  lsd_pooch = {1, 2},
  crack = {1 ,2}
}


Ora.DrugDealing.Locations = {}

RegisterNetEvent("Ora::CE::DrugDealing:StopDealing")
AddEventHandler(
    "Ora::CE::DrugDealing:StopDealing",
    function()
        Ora.Payment:Debug(string.format("Received event to stop drug dealing"))     
        Ora.DrugDealing:StopDealing()
    end
)

function Ora.DrugDealing:StartTimebar()
    local timeleft = 4 * 60 * 1000 + GetGameTimer()
    Ora.DrugDealing.System.COUNTER_STARTED = true

    Citizen.CreateThread(function()
        scaleform = RequestScaleformMovie_2("INSTRUCTIONAL_BUTTONS")
        local hPQ, R1FIoQI, NsoTwDs, HGli = .925, .975, .14, .03
        local iy = {".", "..", "...", ""}
        repeat Wait(0) until HasScaleformMovieLoaded(scaleform)

        while true do Wait(0)
            if renderScaleform == true then
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            end
            local timeleft = (timeleft - GetGameTimer()) / 1000
            local barCount = {1}

            if Ora.DrugDealing.System.COUNTER_STARTED == true and timeleft ~= nil then
                if timeleft > 0 then
                    -- DrawTimerBar(barCount, "TEMPS RESTANT", s2m(timeleft))
                    DrawNiceText(
                      hPQ,
                      R1FIoQI - .05,
                      .5,
                      string.format("TEMPS RESTANT : "..s2m(timeleft)),
                      4,
                      0
                  )
                else
                    ShowNotification("~r~Vous n'avez pas été assez rapide pour vendre.~s~")
                    Ora.DrugDealing:StopDealing()
                end
            end

            if timeleft < 0 or Ora.DrugDealing.System.COUNTER_STARTED == false then
                break
            end
        end
    end)
end

function Ora.DrugDealing:SetBoostedZoneId(zoneId)
  self.System.BOOSTED_ZONE_ID = zoneId
end

function Ora.DrugDealing:GetBoostedZoneId()
  return self.System.BOOSTED_ZONE_ID
end

function Ora.DrugDealing:IsDealingInBoostedZone()
  return self.System.CURRENT_ZONE_ID == self.System.BOOSTED_ZONE_ID
end

function Ora.DrugDealing:StartDealingAt(zoneId)
    self.Locations = {}
    self.System.CURRENT_ZONE_ID = zoneId
    self.System.IS_ACTIVATED = true
    self:GetPositionsForZoneId(zoneId)
    self:StartDealerThread()
    self:StartDealerAntiBikeThread()
end

function Ora.DrugDealing:StopDealing()
  TriggerServerEvent("Ora::SE::DrugDealing:RemoveDealerForZone", self.System.CURRENT_ZONE_ID)
  self.System.IS_ACTIVATED = false
  self.System.CURRENT_ZONE_ID = nil
  self:ResetAllComponentsForNextMission()
end

function Ora.DrugDealing:CanStartDealingAt(zoneId)
  self:Debug(string.format("User is trying to start selling at zone id ^5%s^3", zoneId))
  local canStart = false
  local noCops = false
  local canSend = false

  if Ora.DrugDealing.System.LAST_MISSION_TIME < GetGameTimer() - 60000 then
    TriggerServerCallback("Ora::SE::DrugDealing:CanRegisterForDealingIntoZoneId", 
        function(canStartDealing)
            if (canStartDealing) then
                for key, value in ipairs(Ora.DrugDealing.AvailableDrugs) do
                    if (Ora.Inventory:GetItemCount(value) > 0) then
                        canStart = true
                    end
                end

                if (canStart == false) then
                  Ora.DrugDealing:Debug(string.format("player has no items to sell for zone id ^5%s^3", zoneId))
                  ShowNotification("~r~Vous n'avez pas le necessaire pour vendre.~s~")
                else
                  TriggerServerEvent("Ora::SE::DrugDealing:AddDealerForZone", zoneId)
                  Ora.DrugDealing:StartDealingAt(zoneId)
                end
            end

            canSend = true
        end,
        zoneId
    )

    while (canSend == false) do 
      self:Debug(string.format("Waiting data pulling to check if user can sell for zone id ^5%s^3", zoneId))
      Wait(100)
    end

    return canStart
  else
    ShowNotification("~r~Vous devez patienter avant de pouvoir recommencer à dealer.~s~")
  end
end

function Ora.DrugDealing:GetPositionsForZoneId(zoneId)
  local canSend = false
  local positions = {}
  self:Debug(string.format("Fetching dealing positions for zone id for zone id ^5%s^3", zoneId))
  TriggerServerCallback("Ora::SE::DrugDealing:GetPositionsForZoneId", function(data)
    positions = data
    canSend = true
  end, zoneId)
  
  while (canSend == false) do
    self:Debug(string.format("Waiting data pulling for zone id ^5%s^3", zoneId))
    Wait(100)      
  end

  self:Debug(string.format("Returning dealing positions for zone id ^5%s^3", zoneId))
  self.Locations = positions
end

function Ora.DrugDealing:FetchZones()
  local canSend = false
  local zones = {}
  self:Debug(string.format("Fetching all zones"))
  TriggerServerCallback("Ora::SE::DrugDealing:GetZones", function(data)
    zones = data
    canSend = true
  end, 1)
  
  while (canSend == false) do
    self:Debug(string.format("Waiting data pulling for getting all zones infos"))
    Wait(100)      
  end

  self:Debug(string.format("Replacing the zone informations"))
  self.System.LAST_FETCH = GetGameTimer()
  self.System.ZONES = zones 
end

function Ora.DrugDealing:ImDealing()
    return self.System.IS_ACTIVATED
end

function Ora.DrugDealing:GetZones()
  if (#self.System.ZONES == 0 or (GetGameTimer() - self.System.LAST_FETCH) > (1000 * 60)) then
    self:Debug(string.format("Refetching informations because last fetch is too old"))
    Ora.DrugDealing:FetchZones()
  end
  return self.System.ZONES
end

function Ora.DrugDealing:AllowRefreshOfZones(allowRefresh)
  if (allowRefresh ~= self.System.ALLOW_REFRESH) then
    if (allowRefresh) then
      self:Debug(string.format("Allowing refresh of zones"))
    else
      self:Debug(string.format("Removing refresh of zones"))
    end
    self.System.ALLOW_REFRESH = allowRefresh
  end
end

function Ora.DrugDealing:IsCorrectLocation(coords1, coords2) 
    return GetDistanceBetweenCoords(coords1, coords2, false) > 75.0 
end

function Ora.DrugDealing:StartDealerAntiBikeThread()
  Citizen.CreateThread(
    function()
        while (true) do
          if (self.System.IS_ACTIVATED == false) then
            self:Debug(string.format("Looks like the system is not activated anymore. Removing thread"))
            break
          end
          local pedIsInVehicle = IsPedInAnyVehicle(LocalPlayer().Ped, false)
          if (pedIsInVehicle) then
              local vehicleUsedByPed = GetVehiclePedIsUsing(LocalPlayer().Ped)
              if (DoesEntityExist(vehicleUsedByPed) and GetVehicleClass(vehicleUsedByPed) == 8) then
                self:Debug(string.format("Players is on motorcycles, stopping dealer mode"))
                ShowNotification("~r~Vous ne pouvez pas vendre à moto.~s~")
                Ora.DrugDealing:StopDealing()
              end
          end
          Citizen.Wait(1000)
        end
      end
    )
end

function Ora.DrugDealing:StartDealerThread()
  Citizen.CreateThread(
      function()
          while (true) do
              if (self.System.IS_ACTIVATED == false) then
                  self:Debug(string.format("Looks like the system is not activated anymore. Removing thread"))
                  Citizen.Wait(1)
                  break
              else
                  if (self.System.CURRENT_DESTINATION == nil) then
                      self:Debug(string.format("Current destination is empty, starting a new appointment"))
                      local inventoryDrugs = {}
                      for key, value in ipairs(Ora.DrugDealing.AvailableDrugs) do
                          local itemQuantity = Ora.Inventory:GetItemCount(value)
                          if (itemQuantity > 0) then
                              table.insert(inventoryDrugs, {name = value, qty = itemQuantity})
                          end
                      end

                      if (#inventoryDrugs == 0) then
                          Ora.DrugDealing:StopDealing()
                          ShowAdvancedNotification(
                              "Client",
                              "~b~Dialogue",
                              "T'as plus de matos. Arret des commandes.",
                              Ora.DrugDealing.Characters[math.random(#Ora.DrugDealing.Characters)],
                              1
                          )
                          self:Debug(string.format("No more drug in inventory. Stopping dealer mode"))
                      else
                          self:Debug(string.format("Script is now waiting ^5%s^3 ms", Ora.DrugDealing.System.NEXT_MISSION_WAIT))
                          self.System.LAST_MISSION_TIME = GetGameTimer()
                          Citizen.Wait(Ora.DrugDealing.System.NEXT_MISSION_WAIT)

                          if (self.System.IS_ACTIVATED == false) then
                            self:Debug(string.format("Looks like the system is not activated anymore. Removing thread"))
                            break
                          end

                          local drugObject = inventoryDrugs[math.random(#inventoryDrugs)]
                          Ora.DrugDealing.System.NEXT_MISSION_SELECTED_DRUG = drugObject.name
                          self:Debug(string.format("Next drug selected is ^5%s^3 ms", drugObject.name))
                          if (Ora.DrugDealing.Demand[drugObject.name] ~= nil) then
                            local askedQtyMax = Ora.DrugDealing.Demand[drugObject.name][1]
                            if (drugObject.qty < Ora.DrugDealing.Demand[drugObject.name][2]) then
                              Ora.DrugDealing.System.NEXT_MISSION_COUNT = drugObject.qty
                            else
                              Ora.DrugDealing.System.NEXT_MISSION_COUNT = math.random(Ora.DrugDealing.Demand[drugObject.name][1], Ora.DrugDealing.Demand[drugObject.name][2])
                            end
                          else
                            Ora.DrugDealing.System.NEXT_MISSION_COUNT = math.random(1, 2)
                          end

                          local newLocation = Ora.DrugDealing.Locations[math.random(#Ora.DrugDealing.Locations)]
                          local newLocationCoords =
                              vector3(newLocation.pos.x, newLocation.pos.y, newLocation.pos.z)
                          local newLocationHeading = newLocation.heading
                          local loopCounter = 0

                          while (Ora.DrugDealing:IsCorrectLocation(newLocationCoords, LocalPlayer().Pos) == false and
                              loopCounter < 500) do
                              math.randomseed(GetGameTimer() * math.random(10000, 50000))
                              newLocation = Ora.DrugDealing.Locations[math.random(#Ora.DrugDealing.Locations)]
                              newLocationCoords = vector3(newLocation.pos.x, newLocation.pos.y, newLocation.pos.z)
                              newLocationHeading = newLocation.heading
                              loopCounter = loopCounter + 1
                          end

                          self:Debug(string.format("New locations selected is ^5%s^3", newLocationCoords))
                          Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS = newLocationCoords
                          Ora.DrugDealing.System.CURRENT_DESTINATION_HEADING = newLocationHeading
                          Ora.DrugDealing.System.CURRENT_DESTINATION = AddBlipForCoord(newLocationCoords.x, newLocationCoords.y, newLocationCoords.z)
                          SetBlipRoute(Ora.DrugDealing.System.CURRENT_DESTINATION, true)
                          SetBlipRouteColour(Ora.DrugDealing.System.CURRENT_DESTINATION, 1)

                          character = Ora.DrugDealing.Characters[math.random(#Ora.DrugDealing.Characters)]
                          ShowAdvancedNotification(
                              "Client",
                              "~b~Dialogue",
                              "J'ai besoin de " ..
                              Ora.DrugDealing.System.NEXT_MISSION_COUNT .. " " .. Items[Ora.DrugDealing.System.NEXT_MISSION_SELECTED_DRUG].label .. ".",
                              character,
                              1
                          )
                          Ora.DrugDealing.StartTimebar()
                      end
                  else
                      Citizen.Wait(1)
                      playerPosition = LocalPlayer().Pos
                      if
                          (Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS ~= nil and
                              GetDistanceBetweenCoords(
                                Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS.x,
                                Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS.y,
                                Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS.z,
                                  playerPosition.x,
                                  playerPosition.y,
                                  playerPosition.z,
                                  true
                              ) < 75.0 and
                              Ora.DrugDealing.System.PED_HAS_BEEN_CREATED == false)
                       then
                          local pedModel = Ora.DrugDealing.Peds[math.random(#Ora.DrugDealing.Peds)]
                          self:Debug(string.format("Ped model ^5%s^3 is selected", pedModel))
                          Ora.DrugDealing.System.PED_HAS_BEEN_CREATED = true

                          Citizen.CreateThread(
                              function()
                                  Ora.DrugDealing.System.NEXT_MISSION_PED = Ora.World.Ped:Create(5, pedModel, vector3(Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS.x, Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS.y, Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS.z), Ora.DrugDealing.System.CURRENT_DESTINATION_HEADING)
                                  self:Debug(string.format("Ped with model ^5%s^3 is now created", pedModel))
                                  FreezeEntityPosition(Ora.DrugDealing.System.NEXT_MISSION_PED, true)
                              end
                          )
                      end

                      if
                          (Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS ~= nil and
                              GetDistanceBetweenCoords(
                                Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS.x,
                                Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS.y,
                                Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS.z,
                                  playerPosition.x,
                                  playerPosition.y,
                                  playerPosition.z,
                                  true
                              ) < 3.0)
                       then
                          if (Ora.DrugDealing.System.NEXT_MISSION_COUNT > 0) then
                              SetTextComponentFormat("STRING")
                              AddTextComponentString(
                                  "~r~Appuyez sur ~INPUT_CONTEXT~ pour vendre votre marchandise (Encore " ..
                                  Ora.DrugDealing.System.NEXT_MISSION_COUNT .. " fois)"
                              )
                              DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                          end
                          if IsControlJustPressed(0, Keys["E"]) then
                              if (Ora.DrugDealing.System.NEXT_MISSION_COUNT > 0) then
                                  if (IsPedInAnyVehicle(LocalPlayer().Ped, true)) then
                                      ShowAdvancedNotification(
                                          "Client",
                                          "~b~Dialogue",
                                          "J'suis pas ton chien putain, descend au moins de ta caisse",
                                          character,
                                          1
                                      )
                                  else
                                    
                                    if (Ora.DrugDealing.System.HAS_BEEN_CALLED == false) then
                                      local random = math.random(1, 20)
                                      Ora.DrugDealing.System.HAS_BEEN_CALLED = true
                                      if random > 10 then 
                                          Citizen.SetTimeout(
                                              math.random(2500, 3500),
                                              function()
                                                math.randomseed(GetGameTimer() * math.random(17000, 22000))
                                                msg = Ora.DrugDealing.PolicePhrase[math.random(#Ora.DrugDealing.PolicePhrase)]
                                                self:Debug(string.format("Police is now called with message ^5%s^3", msg))
                                                TriggerServerEvent("call:makeCall2", Ora.DrugDealing:GetCopsJuridictionForZoneId(Ora.DrugDealing.System.CURRENT_ZONE_ID), Ora.DrugDealing.System.CURRENT_DESTINATION_COORDS, msg)
                                              end
                                          )
                                      end
                                    end
                                      Ora.Player:FreezePlayer(LocalPlayer().Ped, true)  
                                      prop_name = Ora.DrugDealing.Props[Ora.DrugDealing.System.NEXT_MISSION_SELECTED_DRUG]
                                      local _prop = nil
                                      local x, y, z = table.unpack(LocalPlayer().Pos)

                                      SpawnObject(
                                          prop_name,
                                          {x = x, y = y, z = z},
                                          function(prop)
                                              _prop = prop
                                              AttachEntityToEntity(
                                                  prop,
                                                  playerPed,
                                                  GetPedBoneIndex(playerPed, 6286),
                                                  0.12,
                                                  -0.020,
                                                  0.010,
                                                  -85.0,
                                                  175.0,
                                                  0.0,
                                                  true,
                                                  true,
                                                  false,
                                                  true,
                                                  1,
                                                  true
                                              )
                                          end
                                      )

                                      TaskPlayAnim(LocalPlayer().Ped, "mp_common","givetake1_a",8.0,1.0,-1,49,0,0,0,0)
                                      Wait(2000)
                                      
                                      Ora.Player:FreezePlayer(LocalPlayer().Ped, false)  
                                      math.randomseed(GetGameTimer())
                                      local xp = math.random(10, 25)
                                      math.randomseed(GetGameTimer())
                                      local price = 0
                                      local object = Ora.Inventory.Data[Ora.DrugDealing.System.NEXT_MISSION_SELECTED_DRUG][1]
                                      local qualitySummary = ""

                                      if (object ~= nil) then
                                          local dataDrug = object.data
                                          local quality = 10
                                          qualitySummary = "~r~Merdique~w~"

                                          price =
                                              price +
                                              math.random(
                                                Ora.DrugDealing.Prices[Ora.DrugDealing.System.NEXT_MISSION_SELECTED_DRUG][1],
                                                Ora.DrugDealing.Prices[Ora.DrugDealing.System.NEXT_MISSION_SELECTED_DRUG][2]
                                              )

                                          if (dataDrug ~= nil and type(dataDrug) == "table") then
                                              if dataDrug.quality ~= nil then
                                                  quality = dataDrug.quality
                                              end
                                          end

                                          if (quality == 10) then
                                            Ora.DrugDealing.System.WARNING_GIVEN = Ora.DrugDealing.System.WARNING_GIVEN + 1
                                          end


                                          if (quality > 10 and quality <= 35) then
                                              typeQuality = "~r~Basse~w~"
                                              Ora.DrugDealing.System.WARNING_GIVEN = Ora.DrugDealing.System.WARNING_GIVEN + 1
                                              price = price + (price * ((quality / 100) / 2))
                                          end

                                          if (quality > 35 and quality < 50) then
                                              qualitySummary = "~o~Moyenne~w~"
                                              price = price + ((price*1.1) * ((quality / 100) / 2))
                                          end

                                          if (quality >= 50 and quality < 75) then
                                              qualitySummary = "~y~Bonne~w~"
                                              price = price + ((price*2.1) * ((quality / 100) / 2))
                                          end

                                          if (quality >= 75 and quality <= 99) then
                                              qualitySummary = "~g~Exceptionnelle~w~"
                                              price = price + ((price*2.1) * ((quality / 100) / 2))
                                          end

                                          if (quality == 100) then
                                              qualitySummary = "~g~Inégalable~w~"
                                              price = price + ((price*3.1) * ((quality / 100) / 2))
                                          end

                                          if (Ora.DrugDealing:IsDealingInBoostedZone()) then
                                            price = price + 5.0
                                            ShowNotification(string.format("Deal en zone bonus : ~h~~g~%s~h~~s~", "+ 5$"))
                                          end

                                          self:Debug(string.format("Selling to PED with price ^5%s^3 and quality ^5%s^3", price, quality))

                                          if (Ora.DrugDealing.System.WARNING_GIVEN == 2 or Ora.DrugDealing.System.WARNING_GIVEN == 7 and quality <= 35) then
                                              ShowAdvancedNotification(
                                                  "Client Mécontent",
                                                  "~b~Dialogue",
                                                  "~r~Man, arrete la ~h~basse qualité~h~, Sinon j'arrete de bosser avec toi~s~",
                                                  character,
                                                  1
                                              )
                                          end

                                          if (Ora.DrugDealing.System.WARNING_GIVEN > 10 and quality <= 35) then
                                              math.randomseed(GetGameTimer() * math.random(5000, 90000))
                                              local chanceToFight = math.random(0, 100)

                                              if (chanceToFight >= 70 and Ora.DrugDealing.System.NEXT_MISSION_COUNT == 1) then
                                                  ShowAdvancedNotification(
                                                      "Client Mécontent",
                                                      "~b~Dialogue",
                                                      "~r~Tu fais chier avec ta drogue de ~h~basse qualité~h~!\nVa faire de la qualité bouffon~s~",
                                                      character,
                                                      1
                                                  )

                                                  math.randomseed(GetGameTimer() * math.random(5000, 90000))
                                                  local weaponType = math.random(0, 100)

                                                  if (weaponType >= 90) then
                                                      GiveWeaponToPed(
                                                        Ora.DrugDealing.System.NEXT_MISSION_PED,
                                                          GetHashKey("WEAPON_CROWBAR"),
                                                          -1,
                                                          0,
                                                          1
                                                      )
                                                  elseif (weaponType >= 85) then
                                                      GiveWeaponToPed(
                                                        Ora.DrugDealing.System.NEXT_MISSION_PED,
                                                          GetHashKey("WEAPON_WRENCH"),
                                                          -1,
                                                          0,
                                                          1
                                                      )
                                                  elseif (weaponType >= 80) then
                                                      GiveWeaponToPed(
                                                        Ora.DrugDealing.System.NEXT_MISSION_PED,
                                                          GetHashKey("WEAPON_HAMMER"),
                                                          -1,
                                                          0,
                                                          1
                                                      )
                                                  elseif (weaponType >= 75) then
                                                      GiveWeaponToPed(
                                                        Ora.DrugDealing.System.NEXT_MISSION_PED,
                                                          GetHashKey("WEAPON_KNUCKLE"),
                                                          -1,
                                                          0,
                                                          1
                                                      )
                                                  else
                                                  end

                                                  FreezeEntityPosition(Ora.DrugDealing.System.NEXT_MISSION_PED, false)
                                                  TaskCombatPed(Ora.DrugDealing.System.NEXT_MISSION_PED, LocalPlayer().Ped, 0, 16)
                                                  SetPedCombatAttributes(Ora.DrugDealing.System.NEXT_MISSION_PED, 46, true)
                                                  SetPedFleeAttributes(Ora.DrugDealing.System.NEXT_MISSION_PED, 0, 0)
                                                  SetPedAsEnemy(Ora.DrugDealing.System.NEXT_MISSION_PED, true)
                                                  SetPedMaxHealth(Ora.DrugDealing.System.NEXT_MISSION_PED, 900)
                                                  SetPedAlertness(Ora.DrugDealing.System.NEXT_MISSION_PED, 3)
                                                  SetPedCombatRange(Ora.DrugDealing.System.NEXT_MISSION_PED, 0)
                                                  SetPedCombatMovement(Ora.DrugDealing.System.NEXT_MISSION_PED, 3)
                                                  Wait(10000)
                                              end
                                          end

                                          Ora.Inventory:RemoveFirstItem(Ora.DrugDealing.System.NEXT_MISSION_SELECTED_DRUG)
                                          -- monopoly logic
                                          local zoneId = self.System.CURRENT_ZONE_ID
                                          local info = exports["drug_monopoly"]:getZoneInfo(zoneId)
                                          if info == nil then
                                            Wait(1000)
                                            info = exports["drug_monopoly"]:getZoneInfo(zoneId)
                                          end
                                          if info then
                                            price = math.ceil(info.priceModifier * price * (info.double and 2 or 1))
                                          end
                                          TriggerServerEvent("drug_monopoly:newTransaction", zoneId, price)
                                          -- end monopoly logic
                                          
                                          ShowAdvancedNotification(
                                              "Client",
                                              "~b~Dialogue",
                                              "Merci mon pote !\n~g~+" .. price .."$\n~y~+" .. xp .. " points d'expérience~s~\nQualité : " .. qualitySummary,
                                              character,
                                              1
                                          )

                                          XNL_AddPlayerXP(math.floor(xp))
                                          ClearPedSecondaryTask(LocalPlayer().Ped)

                                          PlayAmbientSpeech2(Ora.DrugDealing.System.NEXT_MISSION_PED, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
                                          show = false

                                          Wait(800)

                                          ClearPedSecondaryTask(LocalPlayer().Ped)
                                          FreezeEntityPosition(Ora.DrugDealing.System.NEXT_MISSION_PED, false)
                                          
                                          -- monopoly can block payments
                                          if not (info and info.dollarLock) then
                                            TriggerServerCallback(
                                              "Ora::SE::Money:AuthorizePayment", 
                                              function(token)
                                                TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = price, SOURCE = "Vente drogue", LEGIT = false})
                                                TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", price, false)
                                              end,
                                              {}
                                            )
                                          end
                                      end

                                      Citizen.Wait(1200)
                                      DeleteObject(_prop)
                                      Ora.DrugDealing.System.NEXT_MISSION_COUNT = Ora.DrugDealing.System.NEXT_MISSION_COUNT - 1

                                      if (Ora.DrugDealing.System.NEXT_MISSION_COUNT == 0) then
                                          Wait(3000)
                                          Ora.DrugDealing:ResetAllComponentsForNextMission()
                                      end
                                  end
                              else
                                  Wait(3000)
                                  Ora.DrugDealing:ResetAllComponentsForNextMission()
                              end
                          end
                      end
                  end
              end
          end
      end
  )
end

function Ora.DrugDealing:ResetAllComponentsForNextMission()
  RemoveBlip(self.System.CURRENT_DESTINATION)
  local tmpPed = self.System.NEXT_MISSION_PED
  TaskSmartFleePed(tmpPed, LocalPlayer().Ped, 100.0, 15000, 0, 0)
  TriggerServerEvent("Ora::SE::World:Entity:Delete", {handle = tmpPed, network_id = NetworkGetNetworkIdFromEntity(tmpPed), seconds = 15})

  self.System.NEXT_MISSION_PED = nil
  self.System.CURRENT_DESTINATION = nil
  self.System.CURRENT_DESTINATION_COORDS = nil
  self.System.NEXT_MISSION_WAIT = math.random(1000 * 10, 1000 * 50)
  self.System.NEXT_MISSION_COUNT = math.random(1,2)
  self.System.NEXT_MISSION_SELECTED_DRUG = nil
  self.System.QUALITY_TYPES = nil
  self.System.HAS_BEEN_CALLED = false
  self.System.CURRENT_DESTINATION_HEADING = 0.0
  self.System.COUNTER_STARTED = false
  self.System.PED_HAS_BEEN_CREATED = false
  ShowNotification("~y~Vous attendez un nouveau client. Veuillez patienter~s~")
end