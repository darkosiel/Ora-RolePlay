local function controlsText()
  SetTextFont(0)
  SetTextProportional(1)
  SetTextScale(0.0, 0.4)
  SetTextColour(52, 177, 74, 255)
  SetTextDropshadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString("↑ ↓ → ← Pour déplacer, Pg Up and Pg Down pour gérer la hauteur")
  DrawText(0.31, 0.9)
  -- 
  SetTextFont(0)
  SetTextProportional(1)
  SetTextScale(0.0, 0.4)
  SetTextColour(52, 177, 74, 255)
  SetTextDropshadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString("ESPACE pour mettre au sol, ENTRER pour finaliser")
  DrawText(0.355, 0.93)
end

local function bongParticles(lighter)
  Citizen.CreateThread(function()
    RequestNamedPtfxAsset("scr_safehouse")
    while not HasNamedPtfxAssetLoaded("scr_safehouse") do
      Wait(100)
    end
    UseParticleFxAssetNextCall("scr_safehouse")
    Wait(3000)
    StartNetworkedParticleFxNonLoopedOnEntity("scr_sh_lighter_sparks", lighter, 0, 0, 0.06, 0, 0, 0, 1065353216, 0, 0, 0)
    UseParticleFxAssetNextCall("scr_safehouse")
    local lighterFlame = StartNetworkedParticleFxLoopedOnEntity("scr_sh_lighter_flame", lighter, 0, 0, 0.06, 0, 0, 0, 1065353216, 0, 0, 0)
    Wait(3000)
    StopParticleFxLooped(lighterFlame, 0)
    Wait(500)
    UseParticleFxAssetNextCall("scr_safehouse")
    StartNetworkedParticleFxNonLoopedOnPedBone("scr_sh_bong_smoke", PlayerPedId(), -0.025, 0.13, 0, 0, 0, 0, 31086, 1065353216, 0, 0, 0)
  end)
end

local function drinkBeer(bottle, alcohol)
  Citizen.CreateThread(function()
    local count = alcohol.count
    local bottle = bottle
    while true do
      if IsControlJustReleased(0, 54) then
        if IsEntityAttached(bottle) then
          RequestAnimDict(alcohol.anim2.dict)
          while not HasAnimDictLoaded(alcohol.anim2.dict) do
            Wait(100)
          end
          local animDuration = GetAnimDuration(alcohol.anim2.dict, alcohol.anim2.name) * 1000
          local ped = PlayerPedId()
          TaskPlayAnim(ped, alcohol.anim2.dict, alcohol.anim2.name, 1.0, -1.0, 7000, 0, 1, false, false, false)
          Wait(animDuration)
          TriggerServerEvent("Alcohol:Drink", NetworkGetNetworkIdFromEntity(bottle))
          count = count - 1
          if count == 0 then
            break
          end
        else
          break
        end
      end
      Wait(0)
    end
  end)
end

RegisterNetEvent("Ora::CE::Consumable::Alcohol::SpawnProp")
AddEventHandler("Ora::CE::Consumable::Alcohol::SpawnProp", function(item)
  TriggerEvent('Ora:hideInventory')
  local bottleHash, bottle, bottleCoords
  local ped = PlayerPedId()
  local forward, right, up, pos = GetEntityMatrix(ped)
  local pedForward = GetEntityCoords(ped) + forward
  local move_speed = 0.01
  local alcohol = Ora.Consumable.Alcohol.Bottles[item.name]

  if alcohol then
    TriggerServerCallback("Ora::SE::Anticheat:RegisterObject", function()
      RequestModel(alcohol.bottle)
      while not HasModelLoaded(alcohol.bottle) do
        Wait(100)
      end
      bottleHash = GetHashKey(alcohol.bottle)
      bottleCoords = pedForward
      bottle = CreateObject(alcohol.bottle, pedForward, false, true, false)
      SetEntityHasGravity(bottle, false)
      SetEntityCollision(bottle, false)
      SetEntityAlpha(bottle, 150)
    end, alcohol.bottle)
  end

  while true do
    if IsControlPressed(1, 175) then -- move right
      bottleCoords = bottleCoords + (right * move_speed)
      SetEntityCoords(bottle, bottleCoords)
    elseif IsControlPressed(1, 174) then -- move left
      bottleCoords = bottleCoords - (right * move_speed)
      SetEntityCoords(bottle, bottleCoords)
    elseif IsControlPressed(1, 188) then -- move forward
      bottleCoords = bottleCoords + (forward * move_speed)
      SetEntityCoords(bottle, bottleCoords)
    elseif IsControlPressed(1, 187) then -- move back
      bottleCoords = bottleCoords - (forward * move_speed)
      SetEntityCoords(bottle, bottleCoords)
    elseif IsControlPressed(1, 316) then -- move up 
      bottleCoords = vector3(bottleCoords.x, bottleCoords.y, bottleCoords.z + move_speed)
      SetEntityCoords(bottle, bottleCoords)
    elseif IsControlPressed(1, 317) then -- move down
      bottleCoords = vector3(bottleCoords.x, bottleCoords.y, bottleCoords.z - move_speed)
      SetEntityCoords(bottle, bottleCoords)
    elseif IsControlJustPressed(1, 76) then -- on ground
      PlaceObjectOnGroundProperly(bottle)
      bottleCoords = GetEntityCoords(bottle)
    elseif IsControlJustPressed(1, 176) then -- finish
      DeleteObject(bottle)
      TriggerServerCallback("Ora::SE::Anticheat:RegisterObject", function()
        bottle = CreateObject(bottleHash, bottleCoords, true, true, true)
        SetEntityCoords(bottle, bottleCoords)
        FreezeEntityPosition(bottle, true)
        SetModelAsNoLongerNeeded(bottleHash)
        local count = item.data and item.data.count or alcohol.count
        TriggerServerEvent("Ora::SE::Consumable::Alcohol::AddNewBottle", NetworkGetNetworkIdFromEntity(bottle), item.name, count)
      end, bottleHash)
      break
    end
    controlsText()
    Wait(0)
  end
end)

RegisterNetEvent("Ora::CE::Consumable::Alcohol::AddNewBottle")
AddEventHandler("Ora::CE::Consumable::Alcohol::AddNewBottle", function(bottle)
  local entity = NetworkGetEntityFromNetworkId(bottle.id)
  exports["qtarget"]:AddTargetEntity(entity, Ora.Consumable.Alcohol.Settings[Ora.Consumable.Alcohol.Bottles[bottle.alcohol].settings])
end)

RegisterNetEvent("Ora::CE::Consumable::Alcohol::Drink")
AddEventHandler("Ora::CE::Consumable::Alcohol::Drink", function(data)
  local bottle = data.entity
  if not IsEntityAttached(bottle) then
    local alcohol, glass
    local bottleModel = GetEntityModel(bottle)
    local bottleCoords, bottleRotation = GetEntityCoords(bottle), GetEntityRotation(bottle)
    local ped = PlayerPedId()
    local pedCoords, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped, 2)

    for k, v in pairs(Ora.Consumable.Alcohol.Bottles) do
      if v.bottle and GetHashKey(v.bottle) == bottleModel then
        alcohol = Ora.Consumable.Alcohol.Bottles[k]
        break
      end
    end

    RequestAnimDict(alcohol.anim.dict)
    while not HasAnimDictLoaded(alcohol.anim.dict) do
      Wait(100)
    end

    if alcohol.glass then
      local netScene = NetworkCreateSynchronisedScene(pedCoords.x, pedCoords.y, pedCoords.z - 1.0, pedRotation.x, pedRotation.y, pedRotation.z + alcohol.anim.rotation, 2, false, false, 1065353216, 0, 1.0)
      NetworkAddPedToSynchronisedScene(ped, netScene, alcohol.anim.dict, alcohol.anim.ped, -8.0, -8.0, 1, 16, 1148846080, 0)
      if type(alcohol.anim.bottle) == "string" then
        NetworkRequestControlOfEntity(bottle)
        while not NetworkHasControlOfEntity(bottle) do
          Wait(100)
        end
        NetworkAddEntityToSynchronisedScene(bottle, netScene, alcohol.anim.dict, alcohol.anim.bottle, -8.0, -8.0, 1)
      else
        local rightHand = GetPedBoneIndex(ped, 57005)
        AttachEntityToEntity(bottle, ped, rightHand, alcohol.anim.bottle, 90.0, 90.0, 210.0, true, true, false, true, 1, true)
      end

      local glassHash = GetHashKey(alcohol.glass)
      RequestModel(glassHash)
      while not HasModelLoaded(glassHash) do
        Wait(100)
      end
      TriggerServerCallback("Ora::SE::Anticheat:RegisterObject", function()
        glass = CreateObject(glassHash, pedCoords, true, true, false)
        SetModelAsNoLongerNeeded(glassHash)
      end, glassHash)
      while not glass do
        Wait(100)
      end
      NetworkAddEntityToSynchronisedScene(glass, netScene, alcohol.anim.dict, alcohol.anim.glass, -8.0, -8.0, 1)

      NetworkStartSynchronisedScene(netScene)
      if alcohol.bottle == "prop_bong_01" then
        bongParticles(glass)
      end
      Wait(alcohol.anim.duration)
      NetworkStopSynchronisedScene(netScene)

      if IsEntityAttached(bottle) then
        DetachEntity(bottle)
      end
      SetEntityCoords(bottle, bottleCoords)
      SetEntityRotation(bottle, bottleRotation)
      DeleteEntity(glass)
      TriggerServerEvent("Ora::SE::Consumable::Alcohol::Drink", NetworkGetNetworkIdFromEntity(bottle))
    else
      local rightHand = GetPedBoneIndex(ped, 57005)
      NetworkRequestControlOfEntity(bottle)
      while not NetworkHasControlOfEntity(bottle) do
        Wait(100)
      end
      TaskPlayAnim(ped, alcohol.anim.dict, alcohol.anim.name, 8.0, -8.0, -1, 0, 0, false, false, false)
      Wait(500)
      AttachEntityToEntity(bottle, ped, rightHand, 0.10, -0.10, -0.10, 90.0, 90.0, 210.0, true, true, false, true, 1, true)
      drinkBeer(bottle, alcohol)
    end
  end
end)

RegisterNetEvent("Ora::CE::Consumable::Alcohol::StoreIntoInventory")
AddEventHandler("Ora::CE::Consumable::Alcohol::StoreIntoInventory", function(data)
  TriggerServerCallback("Ora::SE::Consumable::Alcohol::GetCount", function(count)
    local entityModel = GetEntityModel(data.entity)
    for k, v in pairs(Ora.Consumable.Alcohol.Bottles) do
      if v.bottle and GetHashKey(v.bottle) == entityModel then
        local item = {name = k, label = count, data = {count = count}}
        Ora.Inventory:AddItem(item)
        DeleteEntity(data.entity)
        break
      end
    end
  end, NetworkGetNetworkIdFromEntity(data.entity))
end)

function Ora.Consumable.Alcohol:Initialize()
  TriggerServerCallback("Ora::SE::Consumable::Alcohol::Initialize", function(bottles)
    for k, v in ipairs(bottles) do
      exports["qtarget"]:AddTargetEntity(NetworkGetEntityFromNetworkId(v.id), Ora.Consumable.Alcohol.Settings[Ora.Consumable.Alcohol.Bottles[v.alcohol].settings])
    end
  end)
end