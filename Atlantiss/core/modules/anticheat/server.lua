Atlantiss.Anticheat.AllowedVehicles = {}
Atlantiss.Anticheat.AllowedNPCs = {}
Atlantiss.Anticheat.AllowedObjects = {}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000 * 120)
    local currentTime = os.time()
    for key, value in pairs(Atlantiss.Anticheat.AllowedVehicles) do
      if (type(value) == "table") then
        for entityModel, timeValue in pairs(value) do
          if timeValue.authorized_at + 120 < currentTime then
            Atlantiss.Anticheat:Debug(string.format("Removed vehicle entity ^5%s^3 as whitelist for user ^5%s^3 time is over", entityModel, key))
            Atlantiss.Anticheat.AllowedVehicles[key][entityModel] = nil
          end
        end
      end
    end

    for key, value in pairs(Atlantiss.Anticheat.AllowedNPCs) do
      if (type(value) == "table") then
        for entityModel, timeValue in pairs(value) do
          if timeValue.authorized_at + 120 < currentTime then
            Atlantiss.Anticheat:Debug(string.format("Removed NPC entity ^5%s^3 as whitelist for user ^5%s^3 time is over", entityModel, key))
            Atlantiss.Anticheat.AllowedNPCs[key][entityModel] = nil
          end
        end
      end
    end

    for key, value in pairs(Atlantiss.Anticheat.AllowedObjects) do
      if (type(value) == "table") then
        for entityModel, timeValue in pairs(value) do
          if timeValue.authorized_at + 120 < currentTime then
            Atlantiss.Anticheat:Debug(string.format("Removed Object entity ^5%s^3 as whitelist for user ^5%s^3 time is over", entityModel, key))
            Atlantiss.Anticheat.AllowedObjects[key][entityModel] = nil
          end
        end
      end
    end

    if collectgarbage("count") > 13000 then
        collectgarbage()
        Atlantiss.Anticheat:Debug(string.format("Running garbage collector as it stores more than ^5%s^3 KB", collectgarbage("count")))
    end
  end
end)

function Atlantiss.Anticheat:Initialize()
  local serverEvents = Atlantiss.Config:GetDataCollection("Anticheat:ServerSideEvents")

  for i, eventName in ipairs(serverEvents) do
    Atlantiss.Anticheat:Debug(string.format("Registering ^5%s^3 as Honey Pot event", eventName))
    RegisterNetEvent(eventName)
    AddEventHandler(
        eventName,
        function()
            local _source = source
            Atlantiss.Anticheat:YieldInvalidEventDetected(eventName, _source)
        end
    )
  end
end

function Atlantiss.Anticheat:TakeScreenshot()

end

function Atlantiss.Anticheat:RegisterVehicleCreation(playerId, entityModel)
  if (self.AllowedVehicles[playerId] == nil) then
    self.AllowedVehicles[playerId] = {}
  end
  self.AllowedVehicles[playerId][entityModel] = {authorized_at = os.time()}
end

function Atlantiss.Anticheat:IsVehicleAllowed(entity, owner)
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

function Atlantiss.Anticheat:RegisterObjectCreation(playerId, entityModel)
  if (self.AllowedObjects[playerId] == nil) then
    self.AllowedObjects[playerId] = {}
  end
  self.AllowedObjects[playerId][entityModel] = {authorized_at = os.time()}
end


function Atlantiss.Anticheat:IsObjectAllowed(entity, owner)
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

function Atlantiss.Anticheat:RegisterNPCCreation(playerId, entityModel)
  if (self.AllowedNPCs[playerId] == nil) then
    self.AllowedNPCs[playerId] = {}
  end
  self.AllowedNPCs[playerId][entityModel] = {authorized_at = os.time()}
end


function Atlantiss.Anticheat:IsNPCAllowed(entity, owner)
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

function Atlantiss.Anticheat:GetIdentifiersAsString(source)
  local identifiers = Atlantiss.Identity:GetIdentifiers(source)
  local identifiersMessage = ""
  for key, value in pairs(identifiers) do
    identifiersMessage = identifiersMessage .. "\n* " .. key .. " = " .. value 
  end

  return identifiersMessage
end

function Atlantiss.Anticheat:IsObjectWhitelist(entityModel)
  if (Atlantiss.Anticheat.ObjectWhitelist[entityModel] ~= nil and Atlantiss.Anticheat.ObjectWhitelist[entityModel] == true) then
    return true
  end
  
  return false
end

function Atlantiss.Anticheat:YieldResourceIsStopped(resourceName, _source)
  TriggerEvent(
      "atlantiss:sendToDiscordFromServer",
      _source,
      12,
      string.format("La ressource : %s semble avoir été stoppée côté client\n%s", resourceName, Atlantiss.Anticheat:GetIdentifiersAsString(_source)),
      "error"
  )
end

function Atlantiss.Anticheat:YieldGenericMessage(message, _source, takeScreenshot)
  takeScreenshot = takeScreenshot or false
  if (takeScreenshot == true) then
    TriggerClientEvent("Atlantiss::CE::General:Snap", _source, {TOKEN = message, SERVER_EVENT = "Atlantiss::SE::Anticheat:ScreenshotProof"})
  end

  TriggerEvent(
      "atlantiss:sendToDiscordFromServer",
      _source,
      12,
      message .. Atlantiss.Anticheat:GetIdentifiersAsString(_source),
      "error"
  )
end

function Atlantiss.Anticheat:YieldInvalidEventDetected(eventName, _source)
  TriggerClientEvent("Atlantiss::CE::General:Snap", _source, {TOKEN = eventName, SERVER_EVENT = "Atlantiss::SE::Anticheat:Detected"})
  TriggerEvent(
      "atlantiss:sendToDiscordFromServer",
      _source,
      12,
      "Execution d'un evenement qui n'existe pas : CHEAT\n\nLe client à lancé l'evenement : " .. eventName .. Atlantiss.Anticheat:GetIdentifiersAsString(_source),
      "error"
  )
end

RegisterServerEvent("Atlantiss::SE::Anticheat:ResourceStopped")
AddEventHandler(
    "Atlantiss::SE::Anticheat:ResourceStopped",
    function(resourceName)
        local _source = source
        Atlantiss.Anticheat:YieldResourceIsStopped(resourceName, _source)
    end
)

RegisterServerEvent("Atlantiss::SE::Anticheat:Detected")
AddEventHandler(
    "Atlantiss::SE::Anticheat:Detected",
    function(data)
        local _source = source
            TriggerEvent(
                  "atlantiss:sendToDiscordFromServer",
                  _source,
                  12,
                  data.TOKEN .. "\nExecution d'un event non connu : [Voir le screenshot](".. data.PICTURE_URL ..")",
                  "error"
            )
    end
)

RegisterServerEvent("Atlantiss::SE::Anticheat:ScreenshotTaken")
AddEventHandler(
    "Atlantiss::SE::Anticheat:ScreenshotTaken",
    function(data)
        local _source = source
            TriggerEvent(
                  "atlantiss:sendToDiscordFromServer",
                  _source,
                  31,
                  data.TOKEN .. "\n[Voir le screenshot](".. data.PICTURE_URL ..")",
                  "error"
            )
    end
)

RegisterServerEvent("Atlantiss::SE::Anticheat:ScreenshotProof")
AddEventHandler(
    "Atlantiss::SE::Anticheat:ScreenshotProof",
    function(data)
        local _source = source
            TriggerEvent(
                  "atlantiss:sendToDiscordFromServer",
                  _source,
                  12,
                  data.TOKEN .. "\n[Voir le screenshot](".. data.PICTURE_URL ..")",
                  "error"
            )
    end
)

RegisterServerEvent("Atlantiss::SE::Anticheat:ReportMessage")
AddEventHandler(
    "Atlantiss::SE::Anticheat:ReportMessage",
    function(type,  message, needScreenshot)
        local _source = source
            TriggerEvent(
                  "atlantiss:sendToDiscordFromServer",
                  _source,
                  12,
                  message,
                  type
            )

            if (needScreenshot ~= nil and needScreenshot == true) then
              TriggerClientEvent("Atlantiss::CE::General:Snap", _source, {TOKEN = message, SERVER_EVENT = "Atlantiss::SE::Anticheat:ScreenshotProof"})
            end
    end
)

RegisterServerCallback("Atlantiss::SE::Anticheat:RegisterVehicle", function(source, callback, entityModel)
  Atlantiss.Anticheat:RegisterVehicleCreation(source, entityModel)
  callback()
end)

RegisterServerCallback("Atlantiss::SE::Anticheat:RegisterPed", function(source, callback, entityModel)
  Atlantiss.Anticheat:RegisterNPCCreation(source, entityModel)
  callback()
end)

RegisterServerCallback("Atlantiss::SE::Anticheat:RegisterPeds", function(source, callback, entityModels)
  for key, value in pairs(entityModels) do
    Atlantiss.Anticheat:RegisterNPCCreation(source, value)
  end
  callback()
end)

RegisterServerCallback("Atlantiss::SE::Anticheat:RegisterObject", function(source, callback, entityModel)
  Atlantiss.Anticheat:RegisterObjectCreation(source, entityModel)
  callback()
end)

AddEventHandler(
    "explosionEvent",
    function(sender, ev)
        for _, v in ipairs(Atlantiss.Anticheat.DisabledExplosion) do
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
            if (Atlantiss.Anticheat.ServerSideDisabledVehicles.HAS_BEEN_POPULATED == false) then
              for i = 1, #Atlantiss.Anticheat.NoRandomSpawnVehicle, 1 do
                Atlantiss.Anticheat.ServerSideDisabledVehicles.LIST[Atlantiss.Anticheat.NoRandomSpawnVehicle[i]] = true
              end
              Atlantiss.Anticheat.ServerSideDisabledVehicles.HAS_BEEN_POPULATED = true
            end
      
            if not Atlantiss.Anticheat.ServerSideDisabledVehicles.LIST[model] then
                return
            end
            CancelEvent()
          end

          -- Object spawned by user
          if (GetEntityType(entity) == 3 and GetEntityPopulationType(entity) == 0) then
            local entityModel = GetEntityModel(entity)
            if (not Atlantiss.Anticheat:IsObjectWhitelist(GetEntityModel(entity)) and not Atlantiss.Anticheat:IsObjectAllowed(entity, NetworkGetEntityOwner(entity))) then
              Atlantiss.Anticheat:YieldGenericMessage(
                "Tentative de création d'un objet (" .. entityModel ..")\n\nLe client souhaite créer un objet non déclaré dans l'anticheat.",
                NetworkGetEntityOwner(entity),
                true
              )
              CancelEvent()
            end
          end

           -- NPC spawned by user
           if (GetEntityType(entity) == 1 and GetEntityPopulationType(entity) == 7) then
            if (not Atlantiss.Anticheat:IsNPCAllowed(entity, NetworkGetEntityOwner(entity))) then
              Atlantiss.Anticheat:YieldGenericMessage(
                "Tentative de création d'un ped \n\nLe client souhaite créer un ped non déclaré dans l'anticheat.",
                NetworkGetEntityOwner(entity),
                true
              )
              CancelEvent()
            end
           end

          -- Vehicle spawned by user
          if (HasVehicleBeenOwnedByPlayer(entity) ~= false and GetEntityType(entity) == 2 and GetEntityPopulationType(entity) == 7) then
              if (not Atlantiss.Anticheat:IsVehicleAllowed(entity, NetworkGetEntityOwner(entity))) then
                local modelName = "Modèle inconnu"
                if (Atlantiss.Anticheat.HashToName[model] ~= nil) then
                  modelName = Atlantiss.Anticheat.HashToName[model]
                end

                Atlantiss.Anticheat:YieldGenericMessage(
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