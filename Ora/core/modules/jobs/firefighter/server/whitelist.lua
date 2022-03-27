--================================--
--       FIRE SCRIPT v1.6.10      --
--  by GIMI (+ foregz, Albo1125)  --
--      License: GNU GPL 3.0      --
--================================--

Ora.Jobs.Firefighter.Whitelist = {
	players = {},
	config = {},
	__index = self,
	init = function(object)
		object = object or {players = {}, config = {}}
		setmetatable(object, self)
		return object
	end
}

function Ora.Jobs.Firefighter.Whitelist:check(serverId)
	if serverId > 0 then
		local steamID = GetPlayerIdentifier(serverId, 0)
		if self.config[steamID] == true or IsPlayerAceAllowed(serverId, "firescript.all") then
			self.players[serverId] = true
		elseif self.players[serverId] ~= nil then
			self.players[serverId] = nil
		end
	end
end

function Ora.Jobs.Firefighter.Whitelist:isWhitelisted(serverId, ace)
	ace = tostring(ace)
	return (serverId > 0 and (self.players[serverId] == true or (ace and IsPlayerAceAllowed(serverId, ace))))
end

function Ora.Jobs.Firefighter.Whitelist:addPlayer(serverId, steamId)
	if steamId then
		self.config[steamId] = true
		self:save()
	end
	if serverId then
		self.players[serverId] = true
	end
end

function Ora.Jobs.Firefighter.Whitelist:removePlayer(serverId, steamId)
	if steamId then
		self.config[steamId] = nil
		self:save()
	end
	if serverId then
		self.players[serverId] = nil
	end
end

function Ora.Jobs.Firefighter.Whitelist:load()
	local whitelistFile = loadData("whitelist")
	if whitelistFile ~= nil then
		self.config = whitelistFile
		for _, playerId in ipairs(GetPlayers()) do
			self:check(tonumber(playerId))
		end
	else
		saveData({}, "whitelist")
	end
end

function Ora.Jobs.Firefighter.Whitelist:save()
	saveData(self.config, "whitelist")
end