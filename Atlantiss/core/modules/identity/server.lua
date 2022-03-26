-- ALTER TABLE `players_identity` ADD `health` INT NOT NULL DEFAULT '200' AFTER `origine`;

Atlantiss.Identity.List = {}

RegisterServerEvent("Atlantiss::SE::Identity:Loaded")
AddEventHandler(
    "Atlantiss::SE::Identity:Loaded",
    function(source, data)
      Atlantiss.Identity:Debug(string.format("Added user data for player id ^5%s^3", source))
      Atlantiss.Identity.List[source] = data
    end
)

function Atlantiss.Identity:GetIdentity(playerId)
  if (self.List[playerId] ~= nil and self.List[playerId].uuid ~= nil and self.List[playerId].last_name ~= "" and self.List[playerId].first_name ~= "" and self.List[playerId].group ~= nil) then
      self:Debug(string.format("Sending data for player id ^5%s^3", playerId))
      return self.List[playerId]
  end

  self:Debug(string.format("Fetching data for player id ^5%s^3", playerId))
  local playerIdentity = self:FetchPlayerIdentity(playerId)

  if (playerIdentity ~= nil and (playerIdentity.uuid == nil or playerIdentity.last_name == "" or playerIdentity.first_name == "")) then
      return playerIdentity
  end

  self.List[playerId] = playerIdentity
  return self.List[playerId]
end

function Atlantiss.Identity:GetFullname(playerId)
    local playerIdentity = self:GetIdentity(playerId)
    
    if (playerIdentity.first_name == nil or playerIdentity.last_name == nil) then
      return ""
    end

    self:Debug(string.format("Sending fullname for player id ^5%s^3 (^5%s^3)", playerId, playerIdentity.first_name .. " " .. playerIdentity.last_name))
    return playerIdentity.first_name .. " " .. playerIdentity.last_name
end

function Atlantiss.Identity:HasFullname(playerId)
    local playerIdentity = self:GetIdentity(playerId)
    local hasFullname = true
    if ((playerIdentity.first_name == nil or playerIdentity.first_name == "") and (playerIdentity.last_name == nil or playerIdentity.last_name == "")) then
      hasFullname = false
    end
    
    self:Debug(string.format("Verifying if player id ^5%s^3 has a fullname (^5%s^3)", playerId, hasFullname))
    return hasFullname
end

function Atlantiss.Identity:GetUuid(playerId)
  local playerIdentity = self:GetIdentity(playerId)
  self:Debug(string.format("Sending uuid for player id ^5%s^3 (^5%s^3)", playerId, playerIdentity.uuid))
  return playerIdentity.uuid
end

function Atlantiss.Identity:GetGroup(playerId)
  local playerIdentity = self:GetIdentity(playerId)
  self:Debug(string.format("Sending group for player id ^5%s^3 (^5%s^3)", playerId, playerIdentity.group))
  return playerIdentity.group
end

function Atlantiss.Identity:AddPlayer(playerId, data)
  self:Debug(string.format("Adding player id ^5%s^3", playerId))
  self.List[playerId] = data
end

function Atlantiss.Identity:RemovePlayer(playerId)
  self:Debug(string.format("Removing player id ^5%s^3", playerId))
  self.List[playerId] = nil
end

function Atlantiss.Identity:GetIdentifiers(playerId)
  self:Debug(string.format("Retrieving identifiers for player id ^5%s^3", playerId))
  local identifiers = {}
  local playerIdentifiers = GetPlayerIdentifiers(playerId)
  
  for _, v in pairs(playerIdentifiers) do
      local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
      identifiers[before] = playerIdentifiers[_]
  end

  return identifiers
end

function Atlantiss.Identity:FetchPlayerIdentity(playerId)
  local results = MySQL.Sync.fetchAll(
      "SELECT pi.*, u.group FROM `users` as u INNER JOIN `players_identity` as pi ON u.uuid = pi.uuid WHERE u.`identifier` = @identifier",
      {
          ["@identifier"] = GetPlayerIdentifier(playerId)
      }
  )

  if (results ~= nil and results[1] ~= nil) then
      self:Debug(string.format("Fetched data for player id ^5%s^3", playerId))
      return {
        last_name = results[1].last_name,
        first_name = results[1].first_name,
        uuid = results[1].uuid,
        group = results[1].group,
        health = results[1].health,
      }
  end

  self:Debug(string.format("Sending default data for player id ^5%s^3", playerId))
  return {
    last_name = "",
    first_name = GetPlayerName(playerId),
    uuid = nil,
    group = "user",
    health = 200
  }
end

RegisterServerCallback(
    "Atlantiss::SE::Identity:GetIdentity",
    function(source, callback, playerServerId)
      Atlantiss.Identity:Debug(string.format("^5%s^3 triggered ServerEventCallback : Atlantiss::SE::Identity:GetIdentity to retrieve identity of ^5%s^3", source, playerServerId))
      local playerIdentity = Atlantiss.Identity:GetIdentity(playerServerId)
      callback(playerIdentity)
    end
)


RegisterServerCallback(
    "Atlantiss::SE::Identity:GetMyIdentity",
    function(source, callback)
      Atlantiss.Identity:Debug(string.format("^5%s^3 triggered ServerEventCallback : Atlantiss::SE::Identity:GetMyIdentity to retrieve identity of ^5%s^3", source, source))
      local myIdentity = Atlantiss.Identity:GetIdentity(source)
      callback(myIdentity)
    end
)

RegisterServerCallback(
	"Atlantiss::SE::Identity:GetFullNameFromUUID",
	function(source, callback, uuid)
		local fullname = nil
		Atlantiss.Identity:Debug(string.format("^5%s^3 triggered ServerEventCallback : Atlantiss::SE::Identity:GetFullNameFromUUID to retrieve full name of ^5%s^3", source, uuid))

		for _, data in pairs(Atlantiss.Identity.List) do
			for k, v in pairs(data) do
				if (k == "uuid" and v == uuid) then
					fullname = string.format("%s %s", data.first_name, data.last_name)
					break
				end
			end
		end

		Wait(100)

		if (fullname == nil) then
			MySQL.Async.fetchAll(
				"SELECT first_name, last_name FROM players_identity as pi JOIN users ON users.uuid = pi.uuid WHERE users.uuid = @uuid",
				{["@uuid"] = uuid},
				function(result)
					if (not result[1]) then return error("Error MySQL query Atlantiss::SE::Identity:GetFullNameFromUUID") end

					callback(string.format("%s %s", result[1].first_name, result[1].last_name))
				end
			)
		else
			callback(fullname)
		end
	end
)

RegisterServerCallback(
	"Atlantiss::SE::Identity:GetFullNamesFromUUIDs",
	function(source, callback, uuids)
		local fullnames = {}
		local query = string.format("SELECT first_name, last_name, uuid FROM players_identity WHERE uuid = '%s'", table.concat(uuids, "' OR uuid = '"))

		for i=1, #uuids do
			fullnames[uuids[i]] = "Nom non trouvé"
		end

		Atlantiss.Identity:Debug(string.format("^5%s^3 triggered ServerCallback : Identity:GetFullNamesFromUUIDs to retrieve full names of ^5%s^3", source, table.unpack(uuids)))

		MySQL.Async.fetchAll(query, {}, function(results)
			if (not results[1]) then return callback(fullnames) end

			for i=1, #results do
				fullnames[results[i].uuid] = string.format("%s %s", results[i].first_name, results[i].last_name)
			end

			callback(fullnames)
		end)
	end
)



