local timeMessages = {}
local timeCalls = {}

RegisterServerCallback("hacker:getNum", function(source, callback, target)
  local identifiers = GetIdentifiers(target).steam
  MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifiers",
    {
      ["@identifiers"] = identifiers
    },
  function(result)
    local number = result[1].phone_number or nil
    if number ~= nil then
      callback(result[1].phone_number)
    else
      callback(nil)
    end
  end)
end)

RegisterServerCallback("hacker:getIdentity", function(source, callback, target)
  local uuid = Atlantiss.Identity:GetUuid(target)
  
  MySQL.Async.fetchAll("SELECT first_name, last_name FROM players_identity WHERE uuid = @uuid",
    {
      ["@uuid"] = uuid
    },
  function(result)
    if result[1] ~= nil then
      local firstName = result[1].first_name
      local lastName = result[1].last_name
      callback(firstName, lastName)
    else
      callback(nil)
    end
  end)
end)

RegisterServerCallback("hacker:getMessage", function(source, callback, target)
  local identifiers = GetIdentifiers(target).steam
  MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifiers",
    {
      ["@identifiers"] = identifiers
    },
  function(result)
    local number = result[1].phone_number or nil
    if number ~= nil then
      MySQL.Async.fetchAll("SELECT transmitter, receiver, message, time FROM phone_messages WHERE transmitter = @transmitter AND owner = 1 OR receiver = @receiver AND owner = 1 ORDER BY id DESC LIMIT 20",
        {
          ["@transmitter"] = number,
          ["@receiver"] = number
        },
      function(results)
        if results[1] ~= nil then
          for i = 1, #results, 1 do
            local time = results[i].time
            table.insert(timeMessages, os.date('%d/%m/%Y %H:%M:%S', string.sub(time,1,10)))
          end
          callback(number, results, timeMessages)
        else
          callback(number, nil, nil)
        end
      end)
    else
      callback(nil, nil, nil)
    end
  end)
end)

RegisterServerCallback("hacker:getCalls", function(source, callback, target)
  local identifiers = GetIdentifiers(target).steam
  MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifiers",
    {
      ["@identifiers"] = identifiers
    },
  function(result)
    local number = result[1].phone_number or nil
    if number ~= nil then
      MySQL.Async.fetchAll("SELECT owner, num, time, accepts FROM phone_calls WHERE owner = @owner AND incoming = 1 OR num = @num AND incoming = 1 ORDER BY id DESC LIMIT 20",
        {
          ["@owner"] = number,
          ["@num"] = number
        },
      function(results)
        if results[1] ~= nil then
          for i = 1, 20, 1 do
            local time = results[i].time
            table.insert(timeCalls, os.date('%d/%m/%Y %H:%M:%S', string.sub(time,1,10)))
          end
          callback(number, results, timeCalls)
        else
          callback(number, nil, nil)
        end
      end)
    else
      callback(nil, nil, nil)
    end
  end)
end)

RegisterServerCallback("hacker:getContacts", function(source, callback, target)
  local identifiers = GetIdentifiers(target).steam
  MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifiers",
    {
      ["@identifiers"] = identifiers
    },
  function(result)
    local number = result[1].phone_number
    if number ~= nil then
      MySQL.Async.fetchAll("SELECT number, display FROM phone_users_contacts WHERE identifier = @identifier",
        {
          ["@identifier"] = identifiers
        },
      function(results)
        if results[1] ~= nil then
          callback(number, results)
        else
          callback(number, nil)
        end
      end)
    else
      callback(nil, nil)
    end
  end)
end)

RegisterServerCallback("hacker:deleteAll", function(source, callback, target)
  local identifiers = GetIdentifiers(target).steam
  MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifiers",
    {
      ["@identifiers"] = identifiers
    },
  function(result)
    local number = result[1].phone_number
    if number ~= nil then
      MySQL.Sync.execute("DELETE FROM phone_messages WHERE receiver = @number", {["@number"] = result[1].phone_number})
      MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE identifier = @identifier", {["@identifier"] = identifiers})
      MySQL.Sync.execute("DELETE FROM phone_calls WHERE owner = @number", {["@number"] = result[1].phone_number})
      callback(number)
    else
      callback(nil)
    end
  end)
end)

RegisterServerCallback("hacker:getTelPos", function(source, callback, number)
  MySQL.Async.fetchAll("SELECT identifier FROM users WHERE phone_number = @number",
    {
      ["@number"] = number
    },
  function(result)
    local pExist = nil
    if result[1] ~= nil then
      for k, v in ipairs(GetPlayers()) do
        local steam = GetIdentifiers(v).steam
        if steam == result[1].identifier then
          callback(v, NetworkGetNetworkIdFromEntity(GetPlayerPed(v)), GetEntityCoords(GetPlayerPed(v)))
          pExist = true
        end
      end
      if pExist == nil then
        callback(nil)
      end
    else
      callback(nil)
    end
  end)
end)

RegisterServerCallback("hacker:getVehiclePos", function(source, callback, plate)
  local veh = nil
  for k, v in ipairs(GetAllVehicles()) do
    if DoesEntityExist(v) then
      local plateV = GetVehicleNumberPlateText(v)
      if plate == plateV then
        local coords = GetEntityCoords(v)
        callback(v, coords)
        veh = true
      end
    end
  end
  if veh == nil then
    callback(nil)
  end
end)

RegisterServerCallback("hacker:getApartment", function(source, callback, fName, lName)
  MySQL.Async.fetchAll("SELECT uuid FROM players_identity WHERE first_name = @first_name AND last_name = @last_name",
    {
      ["@first_name"] = fName,
      ["@last_name"] = lName
    },
  function(result)
    if result[1] ~= nil then
      local uuid = result[1].uuid
      if uuid ~= nil then
        MySQL.Async.fetchAll("SELECT name FROM players_appartement WHERE owner = @owner",
          {
            ["@owner"] = uuid
          },
        function(results)
          if results[1] ~= nil then
            callback(results, fName, lName)
          else
            callback(nil)
          end
        end)
      else
        callback(nil)
      end
    else
      callback(nil)
    end
  end)
end)
--[[ RegisterServerCallback("hacker:getBankAccount", function(source, callback)

end) ]]

RegisterServerCallback("hacker:getVehiclesOwner", function(source, callback, plate)
  MySQL.Async.fetchAll("SELECT uuid, label FROM players_vehicles WHERE plate = @plate",
  {
    ["@plate"] = plate
  },
  function(result)
    if result[1] ~= nil then
      local label = result[1].label
      local uuid = result[1].uuid
      MySQL.Async.fetchAll("SELECT first_name, last_name FROM players_identity WHERE uuid = @uuid",
        {
          ["@uuid"] = uuid
        },
      function(results)
        if results[1] ~= nil then
          callback(results, label)
        else
          callback(nil)
        end
      end)
    else
      callback(nil)
    end
  end)  
end)

RegisterServerCallback("hacker:getVehicles", function(source, callback, fName, lName)
  MySQL.Async.fetchAll("SELECT uuid FROM players_identity WHERE first_name = @first_name AND last_name = @last_name",
    {
      ["@first_name"] = fName,
      ["@last_name"] = lName,
    },
  function(result)
    if result[1] ~= nil then
      local uuid = result[1].uuid
      MySQL.Async.fetchAll("SELECT label, plate FROM players_vehicles WHERE uuid = @uuid",
        {
          ["@uuid"] = uuid
        },
      function(results)
        if results[1] ~= nil then
          callback(results)
        else
          callback(nil)
        end
      end)
    else
      callback(nil)
    end
  end)
end)

RegisterServerCallback("hacker:clonePhone", function(source, callback, target)
  local targetSteam = GetIdentifiers(target).steam
  local sourceSteam = GetIdentifiers(source).steam
  MySQL.Async.fetchAll("SELECT number, display FROM phone_users_contacts WHERE identifier = @id",
    {
      ["@id"] = targetSteam
    },
  function(result)
    for i = 1, #result, 1 do
      MySQL.Async.execute("INSERT INTO phone_users_contacts(identifier, number, display) VALUES(@id, @number, @display)",
        {
          ["@id"] = sourceSteam,
          ["@number"] = result[i].number,
          ["@display"] = result[i].display
        }
      )
    end
  end)

  MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE identifier = @target",
    {
      ["@target"] = targetSteam
    },
  function(result)
    MySQL.Async.fetchAll("SELECT phone_number FROM users WHERE identifier = @source",
    {
      ["@source"] = sourceSteam
    },
    function(result1)
      callback(result[1].phone_number, result1[1].phone_number)
    end)
  end)
end)