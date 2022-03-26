local allUnits = {
  ["police"] = {
    ["Lincoln"] = {},
    ["Adam"] = {},
    ["Tom"] = {},
    ["Mary"] = {},
    ["William"] = {},
    ["Robert"] = {},
    ["Air"] = {},
    ["supervisor"] = nil,
    ["commander"] = nil
  },
  ["lssd"] = {
    ["Lincoln"] = {},
    ["Adam"] = {},
    ["India"] = {},
    ["Mary"] = {},
    ["Tango"] = {},
    ["William"] = {},
    ["X-Ray"] = {},
    ["Predator"] = {},
    ["Henry"] = {},
    ["supervisor"] = nil,
    ["commander"] = nil
  }
}

local allUnitsDispatch = {
  ["police"] = {
    ["Lincoln"] = {},
    ["Adam"] = {},
    ["Tom"] = {},
    ["Mary"] = {},
    ["William"] = {},
    ["Robert"] = {},
    ["Air"] = {},
    ["supervisor"] = nil,
    ["commander"] = nil,
  },
  ["lssd"] = {
    ["Lincoln"] = {},
    ["Adam"] = {},
    ["India"] = {},
    ["Mary"] = {},
    ["Tango"] = {},
    ["William"] = {},
    ["X-Ray"] = {},
    ["Predator"] = {},
    ["Henry"] = {},
    ["supervisor"] = nil,
    ["commander"] = nil
  }
}

local indicatif = {
  ["police"] = "4",
  ["lssd"] = "5"
}

local webhookDispatch = {
  -- Affichage Supervision
  ["s_police"] = {url = "https://discord.com/api/webhooks/830050111550914560/DXXWoexO-5KikaoqerIhiFB4H6GmF668n0mxHg3QFARbCO0pQecfmam8C2whaKY8W6wy", color = 1127128},
  ["s_lssd"] = {url = "https://discord.com/api/webhooks/830050534039617596/KdEfe7nsjfOa5fPvYt6wSYLJB46YUAOqHDlC9koZwWsUndLNI9a1lRHerFylh00J5w39", color = 15105570},
  -- Channel visible par tous
  ["police"] = {url = "https://discord.com/api/webhooks/830051634431524865/qQJAtcdtI5yAG0rT9H3qoSp1VpVv8dpB63dis1gLl4VXRFE9DD2X5BtUFkTrmfeKjHYf", color = 1127128},
  ["lssd"] = {url = "https://discord.com/api/webhooks/830064633720864790/iCCAWgUnONP-BYZTufHobwecTbKtvR_I_OUZpgOirLztHcdFpXuifQxeTOCPRUZ-MVSJ", color = 15105570}
}

Citizen.CreateThread(function()
  local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
  local extract = json.decode(loadFile)
  allUnits = extract.allUnits
  allUnitsDispatch = extract.allUnitsDispatch
end)

RegisterServerCallback("police:GetAllUnits", function(source, callback, tble)
  if tble == "current" then
    callback(allUnits)
  else
    callback(allUnitsDispatch)
  end
end)

RegisterServerEvent("police:AddUnit")
AddEventHandler("police:AddUnit", function(tble, police, unit, matricule, sector)
  if tble == "current" then
    local newUnit = {matricule = matricule, sector = sector, status = "", desc = {time = "", zone = "", street = ""}}
    table.insert(allUnits[police][unit], newUnit)
    for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
      TriggerClientEvent("police:AddUnit", player, tble, police, unit, newUnit)
    end
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
    local extract = json.decode(loadFile)
    table.insert(extract.allUnits[police][unit], newUnit)
    SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 
  else
    local newUnit = {matricule = matricule, sector = sector, status = "", desc = {time = "", zone = "", street = ""}}
    table.insert(allUnitsDispatch[police][unit], newUnit)
    for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
      TriggerClientEvent("police:AddUnit", player, tble, police, unit, newUnit)
    end
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
    local extract = json.decode(loadFile)
    table.insert(extract.allUnitsDispatch[police][unit], newUnit)
    SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 
  end
end)

RegisterServerEvent("police:DeleteUnit")
AddEventHandler("police:DeleteUnit", function(tble, police, unit, index)
  if tble == "current" then
    table.remove(allUnits[police][unit], index)
    for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
      TriggerClientEvent("police:DeleteUnit", player, tble, police, unit, index)
    end
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
    local extract = json.decode(loadFile)
    table.remove(extract.allUnits[police][unit], index)
    SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 
  else
    table.remove(allUnitsDispatch[police][unit], index)
    for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
      TriggerClientEvent("police:DeleteUnit", player, tble, police, unit, index)
    end
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
    local extract = json.decode(loadFile)
    table.remove(extract.allUnitsDispatch[police][unit], index)
    SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 
  end
end)

RegisterServerEvent("police:Reset")
AddEventHandler("police:Reset", function(tble, police)
  if tble == "current" then 
    allUnits[police]["supervisor"] = nil
    allUnits[police]["commander"] = nil
    for k, v in pairs(allUnits[police]) do
      if type(v) == "table" then
        allUnits[police][k] = {}
      end
    end
    for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
      TriggerClientEvent("police:Reset", player, tble, police)
    end
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
    local extract = json.decode(loadFile)
    extract.allUnits = allUnits
    SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 
  else
    allUnitsDispatch[police]["supervisor"] = nil
    allUnitsDispatch[police]["commander"] = nil
    for k, v in pairs(allUnitsDispatch[police]) do
      if type(v) == "table" then
        allUnitsDispatch[police][k] = {}
      end
    end
    for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
      TriggerClientEvent("police:Reset", player, tble, police)
    end
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
    local extract = json.decode(loadFile)
    extract.allUnitsDispatch = allUnitsDispatch
    SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 
  end
end)

RegisterServerEvent("police:ChangeChief")
AddEventHandler("police:ChangeChief", function(tble, police, chief, name)
  if tble == "current" then
    allUnits[police][chief] = name
    for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
      TriggerClientEvent("police:ChangeChief", player, tble, police, chief, name)
    end
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
    local extract = json.decode(loadFile)
    extract.allUnits[police][chief] = name
    SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 
  else
    allUnitsDispatch[police][chief] = name
    for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
      TriggerClientEvent("police:ChangeChief", player, tble, police, chief, name)
    end
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
    local extract = json.decode(loadFile)
    extract.allUnitsDispatch[police][chief] = name
    SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 
  end
end)

RegisterServerEvent("police:ChangeStatus")
AddEventHandler("police:ChangeStatus", function(police, unit, index, status, desc)
  allUnits[police][unit][index].status = status
  allUnits[police][unit][index].desc = desc
  allUnits[police][unit][index].desc.time = os.date("%X")
  for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
    TriggerClientEvent("police:ChangeStatus", player, police, unit, index, status, desc)
  end
end)

RegisterServerEvent("police:ChangeSector")
AddEventHandler("police:ChangeSector", function(tble, police, unit, index, sector)
  if tble == "current" then
    allUnits[police][unit][index].sector = sector
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
    local extract = json.decode(loadFile)
    extract.allUnits[police][unit][index].sector = sector
    SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 
    for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
      TriggerClientEvent("police:ChangeSector", player, tble, police, unit, index, sector)
    end
  else
    allUnitsDispatch[police][unit][index].sector = sector
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
    local extract = json.decode(loadFile)
    extract.allUnitsDispatch[police][unit][index].sector = sector
    SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 
    for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
      TriggerClientEvent("police:ChangeSector", player, tble, police, unit, index, sector)
    end
  end
end)

RegisterServerEvent("police:PostSupervisorDispatch")
AddEventHandler("police:PostSupervisorDispatch", function(police)
  local dispatch = {}
  local lastUnit = nil
  for k, v in pairs(allUnitsDispatch[police]) do
    if type(v) == "table" then
      for t, u in pairs(v) do
        if lastUnit ~= k then  
          table.insert(dispatch, "")
          table.insert(dispatch, "📍 **Patrouille "..k.." ("..string.sub(k, 1, 1)..") : **"..#v)
          table.insert(dispatch, "")
          lastUnit = k
        end
        table.insert(dispatch, indicatif[police].." "..string.sub(k, 1, 1).." "..string.sub(u.matricule, 1, 2).."("..u.matricule..") | "..u.sector)
      end
    end
  end
  table.insert(dispatch, "")
  table.insert(dispatch, "**Superviseur : **"..allUnitsDispatch[police]["supervisor"])
  table.insert(dispatch, "**Watch Commander : **"..allUnitsDispatch[police]["commander"])

  local embeds = {
    {
      ["title"] = "Dispatch",
      ["type"] = "rich",
      ["color"] = webhookDispatch["s_"..police].color,
      ["description"] = table.concat(dispatch, "\n")
    }
  }
  PerformHttpRequest(
    webhookDispatch["s_"..police].url,
    function(err, text, headers)
    end,
    "POST",
    json.encode({embeds = embeds}),
    {["Content-Type"] = "application/json"}
  )
end)

RegisterServerEvent("police:PostDispatch")
AddEventHandler("police:PostDispatch", function(police)
  for k, v in pairs (allUnits[police]) do
    allUnits[police][k] = {}
  end
  for k, v in pairs(allUnitsDispatch[police]) do
    allUnits[police][k] = v
  end

  local loadFile = LoadResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json")
  local extract = json.decode(loadFile)
  extract.allUnits = allUnits
  SaveResourceFile(GetCurrentResourceName(), "./gameplay/jobs/police/dispatch.json", json.encode(extract, {indent=true}), -1) 

  for _, player in pairs(Atlantiss.Service:GetJobService(police)) do
    TriggerClientEvent("police:PostDispatch", player, police, allUnits[police])
  end
  local dispatch = {}
  local lastUnit = nil
  for k, v in pairs(allUnitsDispatch[police]) do
    if type(v) == "table" then
      for t, u in pairs(v) do
        if lastUnit ~= k then  
          table.insert(dispatch, "")
          table.insert(dispatch, "📍 **Patrouille "..k.." ("..string.sub(k, 1, 1)..") : **"..#v)
          table.insert(dispatch, "")
          lastUnit = k
        end
        table.insert(dispatch, indicatif[police].." "..string.sub(k, 1, 1).." "..string.sub(u.matricule, 1, 2).."("..u.matricule..") | "..u.sector)
      end
    end
  end
  table.insert(dispatch, "")
  table.insert(dispatch, "**Superviseur : **"..allUnitsDispatch[police]["supervisor"])
  table.insert(dispatch, "**Watch Commander : **"..allUnitsDispatch[police]["commander"])

  local embeds = {
    {
      ["title"] = "Dispatch",
      ["type"] = "rich",
      ["color"] = webhookDispatch[police].color,
      ["description"] = table.concat(dispatch, "\n")
    }
  }
  PerformHttpRequest(
    webhookDispatch[police].url,
    function(err, text, headers)
    end,
    "POST",
    json.encode({embeds = embeds}),
    {["Content-Type"] = "application/json"}
  )
end)

-- Sirens

local lightbarCars = {}
local lightbarCars2 = {}

RegisterServerEvent('addLightbar')
AddEventHandler('addLightbar', function(hostVehPlate, lightbarNetworkID, hvp)
	local source = source
	for k,v in pairs(lightbarCars) do 
		if v["LP"] == hostVehPlate then
			table.insert(v.lights, lightbarNetworkID)
			return
		end
	end
	table.insert(lightbarCars, {["hostVehiclePointer"] = hvp, ["LP"] = hostVehPlate, ["lights"] = {lightbarNetworkID}, ["lightStatus"] = false, ["sirenStatus"] = false} )
end)			

RegisterServerEvent('toggleLights2')
AddEventHandler('toggleLights2', function(hostVehPlate)
	local source = source
	local veh = nil
	for k,v in pairs(lightbarCars) do 
		if v["LP"] == hostVehPlate then
			TriggerClientEvent("clientToggleLights", source, v.lights, v.lightStatus, v.hostVehiclePointer) 
			v.lightStatus = not v.lightStatus
		end
	end
end)

RegisterServerEvent("ToggleSound1Server")
AddEventHandler("ToggleSound1Server", function(plate)
	local source = source
	local toggle = nil
	for k,v in pairs(lightbarCars) do 
		if v["LP"] == plate then
			toggle = not v.sirenStatus
			v.sirenStatus = toggle
			TriggerClientEvent("sound1Client", -1, source, toggle)
		end
	end
end)

RegisterServerEvent('returnLightBarVehiclePlates')
AddEventHandler('returnLightBarVehiclePlates', function()
	local source = source
	local plates = {}
	for k,v in pairs(lightbarCars) do 
		table.insert(plates, v.LP)
	end
	TriggerClientEvent("sendLightBarVehiclePlates", source, plates) 
end)


RegisterServerEvent('returnLightbarsForMainVeh')
AddEventHandler('returnLightbarsForMainVeh', function(mainVehPlate)
	local source = source
	local plates = {}
	for k,v in pairs(lightbarCars) do 
		if v.LP == mainVehPlate then
			plates = v.lights
			lightbarCars[k] = nil -- removes main vehicle from arr
		end
	end
	--removeAllFromTable(mainVehPlate)
	TriggerClientEvent("updateLightbarArray", source, plates) 
end)

function removeKey(key)
	lightbarCars[key] = nil
end

function removeAllFromTable(mainVehPlate)
	for k,v in pairs(lightbarCars) do 
		if v.LP == mainVehPlate then
			table.remove(k)
			return
		end
	end
end
