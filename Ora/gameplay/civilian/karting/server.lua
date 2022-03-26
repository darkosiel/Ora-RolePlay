local races = {}
local racesQueue = {}
local raceInProgress = {}
raceInProgress.id = nil
raceInProgress.players = {}
raceInProgress.vehicles = {}

AddEventHandler("playerDropped", function()
  for k, v in ipairs(raceInProgress.players) do
    if source == v then
      table.remove(raceInProgress.players, k)
      if #raceInProgress.players == 0 then
        TriggerEvent("karting:FinishRace")
      end
      break
    end
  end
  for i = 1, #racesQueue, 1 do
    if source == racesQueue[i] then
      table.remove(racesQueue, i)
      for _, v in ipairs(races) do
        if v.id == source then
          local playersR = {}
          for _, u in ipairs(v.players) do
            table.insert(playersR, u.id)
          end
          TriggerEvent("karting:DeleteRace", v.id, playersR)
          break
        end
      end
    end
  end
end)

RegisterServerCallback("karting:GetAllRaces", function(source, callback)
  callback(races)
end)

RegisterServerCallback("karting:GetRaceStatus", function(source, callback)
  callback(raceInProgress.id)
end)

RegisterServerCallback("karting:GetNbPlayersInRace", function(source, callback, raceId)
  for k, v in ipairs(races) do
    if v.id == raceId then
      callback(#v.players)
    end
  end
end)

RegisterServerCallback("karting:RaceAvaible", function(source, callback, raceId)
  for k, v in ipairs(races) do
    if v.id == raceId then
      callback(v.avaible)
    end
  end
end)

RegisterServerCallback("karting:GetRanking", function(source, callback)
  local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/civilian/karting/ranking.json")
  local kartingRanking = json.decode(loadFile)
  callback(kartingRanking)
end)

RegisterServerEvent("karting:RegisterVehicle")
AddEventHandler("karting:RegisterVehicle", function(vehicle)
  table.insert(raceInProgress.vehicles, NetworkGetEntityFromNetworkId(vehicle))
end)

RegisterServerCallback("karting:CreateRace", function(source, callback, name, owner)
  local time = os.date("%X")
  local race = {id = source, owner = owner, name = name, time = time, avaible = true, players = {{id = source, name = name, ready = true}}}
  table.insert(races, race)
  callback(races)
end)

RegisterServerEvent("karting:NextRace")
AddEventHandler("karting:NextRace", function(raceId, racePlayers)
  raceInProgress.id = racePlayers[1]
  raceInProgress.players = {}
  for k, v in ipairs(races) do
    if v.id == raceId then
      v.avaible = false
      break
    end
  end
  for i = 1, #racePlayers, 1 do
    table.insert(raceInProgress.players, racePlayers[i])
    TriggerClientEvent("karting:NextRace", racePlayers[i], i)
  end
end)

RegisterServerEvent("karting:DeleteRace")
AddEventHandler("karting:DeleteRace", function(raceId, racePlayers)
  for k, v in ipairs(races) do
    if v.id == raceId then
      table.remove(races, k)
      break
    end
  end
  for i = 1, #racePlayers, 1 do
    TriggerClientEvent("karting:KickRace", racePlayers[i], races)
  end
end)

RegisterServerEvent("karting:JoinRace")
AddEventHandler("karting:JoinRace", function(raceId, player, racePlayers)
  local index
  for k, v in ipairs(races) do
    if v.id == raceId then
      index = k
      table.insert(v.players, player)
      break
    end
  end
  table.insert(racePlayers, source)
  for i = 1, #racePlayers, 1 do
    TriggerClientEvent("karting:RefreshRace", racePlayers[i], index, races[index])
  end
end)

RegisterServerEvent("karting:LeaveRace")
AddEventHandler("karting:LeaveRace", function(raceId, racePlayers)
  local index
  for k, v in ipairs(races) do
    if v.id == raceId then
      index = k
      for t, u in ipairs(v.players) do
        if u.id == source then
          table.remove(v.players, t)
          break
        end
      end
      break
    end
  end
  for i = 1, #racePlayers, 1 do
    TriggerClientEvent("karting:RefreshRace", racePlayers[i], index, races[index])
  end
end)

RegisterServerEvent("karting:BeReady")
AddEventHandler("karting:BeReady", function(raceId, ready, racePlayers)
  local index
  for k, v in ipairs(races) do
    if v.id == raceId then
      index = k
      for _, u in ipairs(v.players) do
        if u.id == source then
          u.ready = ready
          break
        end
      end
      break
    end
  end
  for i = 1, #racePlayers, 1 do
    TriggerClientEvent("karting:RefreshRace", racePlayers[i], index, races[index])
  end
end)

RegisterServerCallback("karting:GetQueue", function(source, callback)
  callback(racesQueue)
end)

RegisterServerCallback("karting:AddToQueue", function(source, callback, raceId)
  for k, v in ipairs(races) do
    if v.id == raceId then
      v.avaible = false
      break
    end
  end
  table.insert(racesQueue, raceId)
  callback(racesQueue)
end)

RegisterServerEvent("karting:LeaveQueue")
AddEventHandler("karting:LeaveQueue", function(raceId, racePlayers)
  for k, v in ipairs(races) do
    if v.id == raceId then
      v.avaible = true
      break
    end
  end
  for i = 1, #racesQueue, 1 do
    if racesQueue[i] == raceId then
      for i = 1, #racesQueue, 1 do
        TriggerClientEvent("karting:RefreshQueue", racesQueue[i], racesQueue)
      end
      table.remove(racesQueue, i)
      break
    end
  end
  for i = 1, #racePlayers, 1 do
    TriggerClientEvent("karting:LeaveQueue", racePlayers[i])
  end
end)

RegisterServerEvent("karting:PlayerFinishRace")
AddEventHandler("karting:PlayerFinishRace", function(name, time)
  local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/civilian/karting/ranking.json")
  local kartingRanking = json.decode(loadFile)
  for k, v in ipairs(kartingRanking) do
    if time < v.time then
      table.insert(kartingRanking, k, {time = time, name = name})
      table.remove(kartingRanking, 21)
      SaveResourceFile(GetCurrentResourceName(), "./gameplay/civilian/karting/ranking.json", json.encode(kartingRanking, {indent=true}), -1) 
      break
    end
  end
  if #raceInProgress.players > 1 then
    for k, v in ipairs(raceInProgress.players) do
      if v == source then
        table.remove(raceInProgress.players, k)
      end
    end
  else
    for k, v in ipairs(races) do
      if v.id == raceInProgress.id then
        table.remove(races, k)
        break
      end
    end
    TriggerEvent("karting:FinishRace")
  end
end)

RegisterServerEvent("karting:FinishRace")
AddEventHandler("karting:FinishRace", function()
  for k, v in ipairs(raceInProgress.vehicles) do
    if DoesEntityExist(v) then
      DeleteEntity(v)
    end
  end
  raceInProgress.vehicles = {}
  raceInProgress.players = {}
  if #racesQueue == 0 then
    raceInProgress.id = nil
  else
    for k, v in ipairs(races) do 
      if v.id == racesQueue[1] then
        for t, u in ipairs(v.players) do
          table.insert(raceInProgress.players, u.id)
          TriggerClientEvent("karting:NextRace", u.id, t)
        end
        raceInProgress.id = racesQueue[1]
        break
      end
    end
    table.remove(racesQueue, 1)
    for i = 1, #racesQueue, 1 do
      TriggerClientEvent("karting:RefreshQueue", racesQueue[i], racesQueue)
    end
  end
end)