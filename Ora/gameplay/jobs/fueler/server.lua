RegisterServerCallback("fueler:checkFuel", function(source, callback, id)
  local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/fueler/station.json") 
  local stationFile = json.decode(loadFile)
  callback(stationFile[id].stock)
end)

RegisterServerCallback("fueler:getAllPumpLevel", function(source, callback)
  local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/fueler/station.json") 
  local stationFile = json.decode(loadFile)
  callback(stationFile)
end)

RegisterServerEvent("fueler:removeLiters")
AddEventHandler("fueler:removeLiters", function(id, liters)
  local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/fueler/station.json") 
  local stationFile = json.decode(loadFile)
  stationFile[id].stock = stationFile[id].stock - liters
  SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/fueler/station.json", json.encode(stationFile, {indent=true}), -1) 
end)

RegisterServerEvent("fueler:addLiters")
AddEventHandler("fueler:addLiters", function(id, liters)
  local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/fueler/station.json") 
  local stationFile = json.decode(loadFile)
  stationFile[id].stock = stationFile[id].stock + liters
  SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/fueler/station.json", json.encode(stationFile, {indent=true}), -1) 
end)

if Station.autoFuel then
  Citizen.CreateThread(function()
    while true do
      Wait(Station.autoRemoveTime*60000)
      local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/fueler/station.json") 
      local stationFile = json.decode(loadFile)
      for k, v in ipairs(Station.pos.cars) do
        if v.id ~= nil then
          local qty = math.random(Station.autoMinFuel, Station.autoMaxFuel)
          if (stationFile[v.id].stock - qty) > 0 then
            TriggerEvent("fueler:removeLiters", v.id, qty)
            TriggerEvent("entreprise:Add", "raffinerie", qty*v.priceL)
          end
        end
      end
    end
  end)
end