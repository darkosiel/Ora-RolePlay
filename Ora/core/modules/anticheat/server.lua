Ora.Anticheat.AllowedVehicles = {}
Ora.Anticheat.AllowedNPCs = {}
Ora.Anticheat.AllowedObjects = {}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000 * 120)
    local currentTime = os.time()
    for key, value in pairs(Ora.Anticheat.AllowedVehicles) do
      if (type(value) == "table") then
        for entityModel, timeValue in pairs(value) do
          if timeValue.authorized_at + 120 < currentTime then
            Ora.Anticheat:Debug(string.format("Removed vehicle entity ^5%s^3 as whitelist for user ^5%s^3 time is over", entityModel, key))
            Ora.Anticheat.AllowedVehicles[key][entityModel] = nil
          end
        end
      end
    end

    for key, value in pairs(Ora.Anticheat.AllowedNPCs) do
      if (type(value) == "table") then
        for entityModel, timeValue in pairs(value) do
          if timeValue.authorized_at + 120 < currentTime then
            Ora.Anticheat:Debug(string.format("Removed NPC entity ^5%s^3 as whitelist for user ^5%s^3 time is over", entityModel, key))
            Ora.Anticheat.AllowedNPCs[key][entityModel] = nil
          end
        end
      end
    end

    for key, value in pairs(Ora.Anticheat.AllowedObjects) do
      if (type(value) == "table") then
        for entityModel, timeValue in pairs(value) do
          if timeValue.authorized_at + 120 < currentTime then
            Ora.Anticheat:Debug(string.format("Removed Object entity ^5%s^3 as whitelist for user ^5%s^3 time is over", entityModel, key))
            Ora.Anticheat.AllowedObjects[key][entityModel] = nil
          end
        end
      end
    end

    if collectgarbage("count") > 13000 then
        collectgarbage()
        Ora.Anticheat:Debug(string.format("Running garbage collector as it stores more than ^5%s^3 KB", collectgarbage("count")))
    end
  end
end)

function Ora.Anticheat:Initialize()
  local serverEvents = Ora.Config:GetDataCollection("Anticheat:ServerSideEvents")

  for i, eventName in ipairs(serverEvents) do
    Ora.Anticheat:Debug(string.format("Registering ^5%s^3 as Honey Pot event", eventName))
    RegisterNetEvent(eventName)
    AddEventHandler(
        eventName,
        function()
            local _source = source
            Ora.Anticheat:YieldInvalidEventDetected(eventName, _source)
        end
    )
  end
end

function Ora.Anticheat:TakeScreenshot()

end

function Ora.Anticheat:RegisterVehicleCreation(playerId, entityModel)
  if (self.AllowedVehicles[playerId] == nil) then
    self.AllowedVehicles[playerId] = {}
  end
  self.AllowedVehicles[playerId][entityModel] = {authorized_at = os.time()}
end

function Ora.Anticheat:IsVehicleAllowed(entity, owner)
  if (entity == nil or entity == 0) then
    return true
  end

  if (owner == nil or owner == 0) then
    return true
  end

  local entityModel = GetEntityModel(entity)

  if (entityModel == nil or entityModel == 0) then
    return true
  end

  local entityHaskey = GetHashKey(entityModel)

  if (self.AllowedVehicles[owner] == nil) then
    return false
  end

  if (self.AllowedVehicles[owner][entityHaskey] == nil and self.AllowedVehicles[owner][entityModel] == nil) then
    return false
  end

  local now = os.time()

  if (self.AllowedVehicles[owner][entityHaskey] ~= nil and (now - self.AllowedVehicles[owner][entityHaskey].authorized_at) < 60) then
    return true
  end

  if (self.AllowedVehicles[owner][entityModel] ~= nil and (now - self.AllowedVehicles[owner][entityModel].authorized_at) < 60) then
    return true
  end

  return false
end

function Ora.Anticheat:RegisterObjectCreation(playerId, entityModel)
  if (self.AllowedObjects[playerId] == nil) then
    self.AllowedObjects[playerId] = {}
  end
  self.AllowedObjects[playerId][entityModel] = {authorized_at = os.time()}
end


function Ora.Anticheat:IsObjectAllowed(entity, owner)
  if (entity == nil or entity == 0) then
    return true
  end

  if (owner == nil or owner == 0) then
    return true
  end

  local entityModel = GetEntityModel(entity)

  if (entityModel == nil or entityModel == 0) then
    return true
  end

  local entityHaskey = GetHashKey(entityModel)


  if (self.AllowedObjects[owner] == nil) then
    return false
  end

  if (self.AllowedObjects[owner][entityHaskey] == nil and self.AllowedObjects[owner][entityModel] == nil) then
    return false
  end

  local now = os.time()

  if (self.AllowedObjects[owner][entityHaskey] ~= nil and (now - self.AllowedObjects[owner][entityHaskey].authorized_at) < 60) then
    return true
  end

  if (self.AllowedObjects[owner][entityModel] ~= nil and (now - self.AllowedObjects[owner][entityModel].authorized_at) < 60) then
    return true
  end

  return false
end

function Ora.Anticheat:RegisterNPCCreation(playerId, entityModel)
  if (self.AllowedNPCs[playerId] == nil) then
    self.AllowedNPCs[playerId] = {}
  end
  self.AllowedNPCs[playerId][entityModel] = {authorized_at = os.time()}
end


function Ora.Anticheat:IsNPCAllowed(entity, owner)
  if (entity == nil or entity == 0) then
    return true
  end

  if (owner == nil or owner == 0) then
    return true
  end

  local entityModel = GetEntityModel(entity)

  if (entityModel == nil or entityModel == 0) then
    return true
  end

  local entityHaskey = GetHashKey(entityModel)

  if (self.AllowedNPCs[owner] == nil) then
    return false
  end

  if (self.AllowedNPCs[owner][entityHaskey] == nil and self.AllowedNPCs[owner][entityModel] == nil) then
    return false
  end

  local now = os.time()

  if (self.AllowedNPCs[owner][entityHaskey] ~= nil and (now - self.AllowedNPCs[owner][entityHaskey].authorized_at) < 60) then
    return true
  end

  if (self.AllowedNPCs[owner][entityModel] ~= nil and (now - self.AllowedNPCs[owner][entityModel].authorized_at) < 60) then
    return true
  end

  return false
end

function Ora.Anticheat:GetIdentifiersAsString(source)
  local identifiers = Ora.Identity:GetIdentifiers(source)
  local identifiersMessage = ""
  for key, value in pairs(identifiers) do
    identifiersMessage = identifiersMessage .. "\n* " .. key .. " = " .. value 
  end

  return identifiersMessage
end

function Ora.Anticheat:IsObjectWhitelist(entityModel)
  if (Ora.Anticheat.ObjectWhitelist[entityModel] ~= nil and Ora.Anticheat.ObjectWhitelist[entityModel] == true) then
    return true
  end
  
  return false
end

function Ora.Anticheat:YieldResourceIsStopped(resourceName, _source)
  TriggerEvent(
      "Ora:sendToDiscordFromServer",
      _source,
      12,
      string.format("La ressource : %s semble avoir été stoppée côté client\n%s", resourceName, Ora.Anticheat:GetIdentifiersAsString(_source)),
      "error"
  )
end

function Ora.Anticheat:YieldGenericMessage(message, _source, takeScreenshot)
  takeScreenshot = takeScreenshot or false
  if (takeScreenshot == true) then
    TriggerClientEvent("Ora::CE::General:Snap", _source, {TOKEN = message, SERVER_EVENT = "Ora::SE::Anticheat:ScreenshotProof"})
  end

  TriggerEvent(
      "Ora:sendToDiscordFromServer",
      _source,
      12,
      message .. Ora.Anticheat:GetIdentifiersAsString(_source),
      "error"
  )
end

function Ora.Anticheat:YieldInvalidEventDetected(eventName, _source)
  TriggerClientEvent("Ora::CE::General:Snap", _source, {TOKEN = eventName, SERVER_EVENT = "Ora::SE::Anticheat:Detected"})
  TriggerEvent(
      "Ora:sendToDiscordFromServer",
      _source,
      12,
      "Execution d'un evenement qui n'existe pas : CHEAT\n\nLe client à lancé l'evenement : " .. eventName .. Ora.Anticheat:GetIdentifiersAsString(_source),
      "error"
  )
end

RegisterServerEvent("Ora::SE::Anticheat:ResourceStopped")
AddEventHandler(
    "Ora::SE::Anticheat:ResourceStopped",
    function(resourceName)
        local _source = source
        Ora.Anticheat:YieldResourceIsStopped(resourceName, _source)
    end
)

RegisterServerEvent("Ora::SE::Anticheat:Detected")
AddEventHandler(
    "Ora::SE::Anticheat:Detected",
    function(data)
        local _source = source
            TriggerEvent(
                  "Ora:sendToDiscordFromServer",
                  _source,
                  12,
                  data.TOKEN .. "\nExecution d'un event non connu : [Voir le screenshot](".. data.PICTURE_URL ..")",
                  "error"
            )
    end
)

RegisterServerEvent("Ora::SE::Anticheat:ScreenshotTaken")
AddEventHandler(
    "Ora::SE::Anticheat:ScreenshotTaken",
    function(data)
        local _source = source
            TriggerEvent(
                  "Ora:sendToDiscordFromServer",
                  _source,
                  31,
                  data.TOKEN .. "\n[Voir le screenshot](".. data.PICTURE_URL ..")",
                  "error"
            )
    end
)

RegisterServerEvent("Ora::SE::Anticheat:ScreenshotProof")
AddEventHandler(
    "Ora::SE::Anticheat:ScreenshotProof",
    function(data)
        local _source = source
            TriggerEvent(
                  "Ora:sendToDiscordFromServer",
                  _source,
                  12,
                  data.TOKEN .. "\n[Voir le screenshot](".. data.PICTURE_URL ..")",
                  "error"
            )
    end
)

RegisterServerEvent("Ora::SE::Anticheat:ReportMessage")
AddEventHandler(
    "Ora::SE::Anticheat:ReportMessage",
    function(type,  message, needScreenshot)
        local _source = source
            TriggerEvent(
                  "Ora:sendToDiscordFromServer",
                  _source,
                  12,
                  message,
                  type
            )

            if (needScreenshot ~= nil and needScreenshot == true) then
              TriggerClientEvent("Ora::CE::General:Snap", _source, {TOKEN = message, SERVER_EVENT = "Ora::SE::Anticheat:ScreenshotProof"})
            end
    end
)

RegisterServerCallback("Ora::SE::Anticheat:RegisterVehicle", function(source, callback, entityModel)
  Ora.Anticheat:RegisterVehicleCreation(source, entityModel)
  callback()
end)

RegisterServerCallback("Ora::SE::Anticheat:RegisterPed", function(source, callback, entityModel)
  Ora.Anticheat:RegisterNPCCreation(source, entityModel)
  callback()
end)

RegisterServerCallback("Ora::SE::Anticheat:RegisterPeds", function(source, callback, entityModels)
  for key, value in pairs(entityModels) do
    Ora.Anticheat:RegisterNPCCreation(source, value)
  end
  callback()
end)

RegisterServerCallback("Ora::SE::Anticheat:RegisterObject", function(source, callback, entityModel)
  Ora.Anticheat:RegisterObjectCreation(source, entityModel)
  callback()
end)

AddEventHandler(
    "explosionEvent",
    function(sender, ev)
        for _, v in ipairs(Ora.Anticheat.DisabledExplosion) do
            if ev.explosionType == v then
                CancelEvent()
            end
        end
    end
)

AddEventHandler(
    "entityCreating",
    function(entity)
        if DoesEntityExist(entity) then
          local model = GetEntityModel(entity)

          if (GetEntityType(entity) == 2 and GetEntityPopulationType(entity) ~= 7) then
            if (Ora.Anticheat.ServerSideDisabledVehicles.HAS_BEEN_POPULATED == false) then
              for i = 1, #Ora.Anticheat.NoRandomSpawnVehicle, 1 do
                Ora.Anticheat.ServerSideDisabledVehicles.LIST[Ora.Anticheat.NoRandomSpawnVehicle[i]] = true
              end
              Ora.Anticheat.ServerSideDisabledVehicles.HAS_BEEN_POPULATED = true
            end
      
            if not Ora.Anticheat.ServerSideDisabledVehicles.LIST[model] then
                return
            end
            CancelEvent()
          end

          -- Object spawned by user
          if (GetEntityType(entity) == 3 and GetEntityPopulationType(entity) == 0) then
            local entityModel = GetEntityModel(entity)
            if (not Ora.Anticheat:IsObjectWhitelist(GetEntityModel(entity)) and not Ora.Anticheat:IsObjectAllowed(entity, NetworkGetEntityOwner(entity))) then
              Ora.Anticheat:YieldGenericMessage(
                "Tentative de création d'un objet (" .. entityModel ..")\n\nLe client souhaite créer un objet non déclaré dans l'anticheat.",
                NetworkGetEntityOwner(entity),
                true
              )
              CancelEvent()
            end
          end

           -- NPC spawned by user
           if (GetEntityType(entity) == 1 and GetEntityPopulationType(entity) == 7) then
            if (not Ora.Anticheat:IsNPCAllowed(entity, NetworkGetEntityOwner(entity))) then
              Ora.Anticheat:YieldGenericMessage(
                "Tentative de création d'un ped \n\nLe client souhaite créer un ped non déclaré dans l'anticheat.",
                NetworkGetEntityOwner(entity),
                true
              )
              CancelEvent()
            end
           end

          -- Vehicle spawned by user
          if (HasVehicleBeenOwnedByPlayer(entity) ~= false and GetEntityType(entity) == 2 and GetEntityPopulationType(entity) == 7) then
              if (not Ora.Anticheat:IsVehicleAllowed(entity, NetworkGetEntityOwner(entity))) then
                local modelName = "Modèle inconnu"
                if (Ora.Anticheat.HashToName[model] ~= nil) then
                  modelName = Ora.Anticheat.HashToName[model]
                end

                Ora.Anticheat:YieldGenericMessage(
                  "Tentative de création d'un véhicule (".. modelName .. ") \n\nLe client souhaite créer un véhicule non déclaré dans l'anticheat.",
                  NetworkGetEntityOwner(entity),
                  true
                )
                CancelEvent()
              end
          end
        end
    end
)