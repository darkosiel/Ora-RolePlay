local bucket = {}

for i = 1, 63, 1 do
  table.insert(bucket, {sud = nil, centre = nil})
end

RegisterServerCallback("shooting_range:GetRanking", function(source, callback)
  local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/civilian/shooting_range/ranking.json")
  local shootingFile = json.decode(loadFile)
  callback(shootingFile)
end)

RegisterServerEvent("shooting_range:UpdateRanking")
AddEventHandler("shooting_range:UpdateRanking", function(ranking)
  local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/civilian/shooting_range/ranking.json") 
  SaveResourceFile(GetCurrentResourceName(), "./gameplay/civilian/shooting_range/ranking.json", json.encode(ranking, {indent=true}), -1) 
end)

RegisterServerEvent('shooting_range:setbucket')
AddEventHandler('shooting_range:setbucket', function(zone)
  if zone == "Sud" then
    for i = 1, #bucket, 1 do
      if bucket[i].sud == nil then
        bucket[i].sud = true
        SetPlayerRoutingBucket(source, i)
        return
      end
    end
  elseif zone == "Centre" then
    for i = 1, #bucket, 1 do
      if bucket[i].centre == nil then
        bucket[i].centre = true
        SetPlayerRoutingBucket(source, i)
        return
      end
    end
  end
end)

RegisterServerEvent('shooting_range:returnbucket')
AddEventHandler('shooting_range:returnbucket', function(zone)
  if zone == "Sud" then
    bucket[GetPlayerRoutingBucket(source)].sud = nil
  elseif zone == "Centre" then
    bucket[GetPlayerRoutingBucket(source)].centre = nil
  end
  SetPlayerRoutingBucket(source, 0)
end)

RegisterServerCallback("shooting_range:freePlace", function(source, callback, zone)
  if zone == "Sud" then
    for i = 1, #bucket, 1 do
      if bucket[i].sud == nil then
        callback(true)
      end
    end
    callback(false)
  elseif zone == "Centre" then
    for i = 1, #bucket, 1 do
      if bucket[i].centre == nil then
        callback(true)
      end
    end
    callback(false)
  end
end)