RegisterNetEvent("Ora:Jobs:G6:GenerateAtms", function(atms)
	print(atms)
	SaveResourceFile(GetCurrentResourceName(), "gameplay/jobs/g6/atms.json", atms, -1)
end)

------------------

RegisterServerEvent("g6:getCases", function(amount)
	local src = source
	-- Check if the player has the job

	-- If the job is not g6, return

end)

local REQUIRED_VEHICLE_HASH <const> = GetHashKey("stockade")
local DEPOT_COORDS <const> = vector3(-3.433605, -672.838806, 31.946930)
local MIN_NUMBER_IN_SERVICE <const> = 3
local MIN_NUMBER_IN_SESSION <const> = 3
local G6_MAX_STOPS_PER_DAY <const> = 60
local REWARD_AMOUNT <const> = 1500

local AtmIsBeingFilled = false
local G6_Current_Session = nil
local G6_Number_Of_Stops_Of_The_Day = 0
local G6_Session_ROUTES = {}

local function IsEnoughInService()
	local numberOfAgentsInService = Ora.Service:GetTotalServiceCountForJob("g6")
	return numberOfAgentsInService >= MIN_NUMBER_IN_SERVICE
end

local function IsEnoughInSession()
	local numberOfAgentsInSession = #G6_Current_Session.agents
	return numberOfAgentsInSession >= MIN_NUMBER_IN_SESSION
end

local function notifyPlayer(src, message)
	TriggerClientEvent("g6:notifyPlayer", src, message)
	print(message)
end

RegisterServerEvent("g6:createSession", function(vehicle)
	local src = source

	-- Check if the source player is in service
	if not Ora.Service:IsPlayerInService(src, "g6") then
		-- If the player isn't in service, return
		notifyPlayer(src, "~r~Vous n'êtes pas en service.")
		return
	end

	if not IsEnoughInService() then
		notifyPlayer(src, "~r~Il n'y pas assez d'agents en service")
		return
	end

	-- Check if there is already a Session in progress
	if G6_Current_Session ~= nil then
		notifyPlayer(src, "~r~Il y a déjà une session en cours. Vous ne pouvez pas en créer une nouvelle.")
		return
	end

	if G6_Number_Of_Stops_Of_The_Day >= G6_MAX_STOPS_PER_DAY then
		notifyPlayer(src, "~r~Il y a déjà eu trop d'arrêts aujourd'hui. Vous ne pouvez pas en créer une nouvelle.")
		return
	end

	if vehicle == nil then
		notifyPlayer(src, "~r~Vous n'êtes pas dans un véhicule.")
		return
	end

	-- Check if the vehicle is the correct vehicle model
	if GetEntityModel(NetworkGetEntityFromNetworkId(vehicle)) ~= REQUIRED_VEHICLE_HASH then
		notifyPlayer(src, "~r~Vous n'êtes pas dans le bon véhicule.")
		return
	end

	-- Create a new Session
	G6_Current_Session = {
		host = src,
		agents = {},
		depotCoords = DEPOT_COORDS,
		vehicle = {
			serverId = vehicle,
			plate = GetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(vehicle)),
		},
		currentRouteStop = 0,
		route = nil,
		startTime = os.date("%H:%M:%S"),
		--SessionId = nil,
	}

	-- If we're here, means the player is in service, add him
	table.insert(G6_Current_Session.agents, src )

	G6_Current_Session.route = CalculateGpsRoute()
	notifyPlayer(src, "~g~Session créée avec succès.")
	--TriggerClientEvent("g6:debugRoute", -1, json.encode(G6_Current_Session.route))

	-- Tell every g6 employees in service that a Session has been created

	TriggerMultiClientsEvent("g6:sessionCreated", Ora.Service:GetServiceArray()["g6"], G6_Current_Session)

	-- for _, ply in pairs(Ora.Service:GetServiceArray()["g6"]) do
	-- 	TriggerClientEvent("g6:sessionCreated", ply, G6_Current_Session)
	-- end
end)

RegisterServerCallback("g6:getCurrentSession", function(source, cb)
	-- Check if the player is a g6 agent

	-- Check if there is a Session in progress
	if G6_Current_Session == nil then
		cb(nil)
		return
	end

	-- -- Check if the player is in the Session
	-- local isInSession = false
	-- for i = 1, #G6_Current_Session.agents, 1 do
	-- 	if G6_Current_Session.agents[i] == source then
	-- 		isInSession = true
	-- 		break
	-- 	end
	-- end

	cb(G6_Current_Session)

end)

RegisterServerEvent("g6:startSession", function()
	local src = source
	-- Check if the player has the job
	-- If the job is not g6, return

	if G6_Current_Session == nil then
		notifyPlayer(src, "~r~Il n'y a pas de session en cours.")
		return
	end

	-- Check if enought agents are in service to start a Session
	if not IsEnoughInService() then
		notifyPlayer(src, "~r~Il n'y pas assez d'agents en service")
		G6_Current_Session = nil
		return
	end

	if not IsEnoughInSession() then
		notifyPlayer(src, ("~r~Il n'y pas assez d'agents dans la session (min: %s)"):format(MIN_NUMBER_IN_SESSION))
		G6_Current_Session = nil
		return
	end

	G6_Current_Session.startTime = os.date("%H:%M:%S")
	G6_Current_Session.hasStarted = true

	TriggerMultiClientsEvent("g6:sessionStarted", G6_Current_Session.agents, G6_Current_Session)

	-- for k, v in pairs(G6_Current_Session.agents) do
	-- 	TriggerClientEvent("g6:SessionStarted", src, G6_Current_Session)
	-- end

	Citizen.CreateThread(function()
		while G6_Current_Session do
			if not IsEnoughInService() or not IsEnoughInSession() then
				notifyPlayer(src, "~r~Il n'y plus assez d'agents en service ou dans la session. La session va s'arrêter.")
				TriggerEvent("g6:endSession")
				return
			end

			Citizen.Wait(1000.0)
		end
	end)

end)

RegisterServerEvent("g6:fillATM", function()
	local src = source
	-- Check if the player has the job
	-- If the job is not g6, return

	if G6_Current_Session == nil then
		notifyPlayer(src, "~r~Il n'y a pas de session en cours.")
		return
	end

	-- Check if enought agents are in service to start a Session
	if not IsEnoughInService() then
		notifyPlayer(src, "~r~Il n'y pas assez d'agents en service")
		G6_Current_Session = nil
		return
	end

	if not IsEnoughInSession() then
		notifyPlayer(src, ("~r~Il n'y pas assez d'agents dans la session (min: %s)"):format(MIN_NUMBER_IN_SESSION))
		G6_Current_Session = nil
		return
	end

	-- Check if the player is in the Session
	local isInSession = false
	for i = 1, #G6_Current_Session.agents, 1 do
		if G6_Current_Session.agents[i] == src then
			isInSession = true
			break
		end
	end

	if not isInSession then
		notifyPlayer(src, "~r~Vous n'êtes pas dans la session.")
		return
	end

	-- Check if the player is close to the ATM
	local playerPed = GetPlayerPed(src)
	local playerCoords = GetEntityCoords(playerPed)
	local distance = #(playerCoords - vector3(G6_Current_Session.route[G6_Current_Session.currentRouteStop].coords.x, G6_Current_Session.route[G6_Current_Session.currentRouteStop].coords.y, G6_Current_Session.route[G6_Current_Session.currentRouteStop].coords.z))
	if distance > 3.0 then
		notifyPlayer(src, "~r~Vous n'êtes pas assez proche de l'ATM.")
		return
	end

	AtmIsBeingFilled = true
	TriggerClientEvent("g6:fillATM_cb", src)
end)

RegisterServerEvent("g6:nextRouteStop", function()
	local src = source
	-- Check if the player has the job
	-- If the job is not g6, return
	if G6_Current_Session == nil then
		notifyPlayer(src,  "~r~Il n'y a pas de session en cours. Comment avez-vous fait pour appeler cette fonction ?")
		--BAN PLAYER
		return
	end

	-- Check if the player is in the Session
	local isInSession = false
	for i = 1, #G6_Current_Session.agents, 1 do
		if G6_Current_Session.agents[i] == src then
			isInSession = true
			break
		end
	end

	if not isInSession then
		notifyPlayer(src, "~r~Vous n'êtes pas dans la session.")
		return
	end
	-- Increment the currentRouteStop
	G6_Number_Of_Stops_Of_The_Day = G6_Number_Of_Stops_Of_The_Day + (G6_Current_Session.currentRouteStop <= 0 and 0 or 1)
	G6_Current_Session.currentRouteStop = G6_Current_Session.currentRouteStop + 1

	-- Check if the Session is not finished
	if G6_Current_Session.currentRouteStop >= #G6_Current_Session.route then
		notifyPlayer(src, "~g~Vous avez effectué tous les arrêts. La session est terminée.")
		TriggerEvent("g6:endSession")
		return
	end

	TriggerMultiClientsEvent("g6:sessionUpdated", G6_Current_Session.agents, G6_Current_Session)

	-- -- Tell every g6 employees in the Session that
	-- for _, ply in pairs(G6_Current_Session.agents) do
	-- 	TriggerClientEvent("g6:sessionUpdated", ply, G6_Current_Session)
	-- end
end)

RegisterServerEvent("g6:fillTheTrunk", function()
	local src = source
	-- Check if the player has the job
	-- If the job is not g6, return

	if G6_Current_Session == nil then
		notifyPlayer(src, "~r~Il n'y a pas de session en cours.")
		return
	end

	-- Check if enought agents are in service to start a Session
	if not IsEnoughInService() then
		notifyPlayer(src, "~r~Il n'y pas assez d'agents en service")
		G6_Current_Session = nil
		return
	end

	if not IsEnoughInSession() then
		notifyPlayer(src, ("~r~Il n'y pas assez d'agents dans la session (min: %s)"):format(MIN_NUMBER_IN_SESSION))
		G6_Current_Session = nil
		return
	end

	-- Check if the player is in the Session
	local isInSession = false
	for i = 1, #G6_Current_Session.agents, 1 do
		if G6_Current_Session.agents[i] == src then
			isInSession = true
			break
		end
	end

	if not isInSession then
		notifyPlayer(src, "~r~Vous n'êtes pas dans la session.")
		return
	end

	-- Check if the player is close to the ATM
	local playerPed = GetPlayerPed(src)

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	if NetworkGetNetworkIdFromEntity(vehicle) ~= G6_Current_Session.vehicle.serverId then
		notifyPlayer(src, "~r~Vous n'êtes pas dans le véhicule de la session.")
		return
	end

	if GetPedInVehicleSeat(vehicle, -1) ~= playerPed then
		notifyPlayer(src, "~r~Vous n'êtes pas le conducteur du véhicule.")
		return
	end

	local vehCoords = GetEntityCoords(vehicle)
	local distance = #(vehCoords - G6_Current_Session.depotCoords)
	if distance > 5 then
		notifyPlayer(src, "~r~Vous n'êtes pas assez proche du dépôt.")
		return
	end

	local quantity = #G6_Current_Session.route

	TriggerClientEvent("g6:fillTheTrunk_cb", src, quantity)
end)

RegisterServerEvent("g6:endSession", function()
	local src = source
	if src ~= "" and src > 0 then
		-- Check if the player has the job
		-- If the job is not g6, return

		if G6_Current_Session == nil then
			notifyPlayer(src, "~r~Il n'y a pas de session en cours. BAN PLAYER")
			return
		end

		-- Check if the player is in the Session
		local isInSession = false
		for i = 1, #G6_Current_Session.agents, 1 do
			if G6_Current_Session.agents[i] == src then
				isInSession = true
				break
			end
		end

		if not isInSession then
			notifyPlayer(src, "~r~Vous n'êtes pas dans la session.")
			return
		end
	else
		print("Event called from the server")
	end
	-- -- Check if the Session is not finished
	-- if G6_Current_Session.currentRouteStop < #G6_Current_Session.route then
	-- 	notifyPlayer(src, "Session is not finished")
	-- 	return
	-- end

	-- Increment the number of Sessions of the day
	--G6_Number_Of_Sessions_Of_The_Day = G6_Number_Of_Sessions_Of_The_Day + 1

	-- Tell every g6 employees in the Session that the Session has ended
	TriggerMultiClientsEvent("g6:sessionEnded", G6_Current_Session.agents)

	--TriggerMultiClientsEvent("g6:sessionUpdated", G6_Current_Session.agents, G6_Current_Session)

	-- Calculate reward
	local reward = REWARD_AMOUNT * (G6_Current_Session.currentRouteStop - 1)
	-- for i = 1, #G6_Current_Session.route, 1 do
	-- 	reward = reward + G6_Current_Session.route[i].reward
	-- end

	-- Add the money to the g6 account
	--print("Reward: " .. reward)
	if reward == nil then
		reward = 0
	end
	TriggerEvent(
		"Ora_bank:addMoneyToBankAccount",
		"g6",
		reward
	)
	TriggerEvent(
		"newTransaction",
		"mazegroup",
		"Pacific Bank",
		reward,
		"Prime versée par l'entreprise.",
		""
	)

	-- Delete the Session
	G6_Current_Session = nil

end)

RegisterServerEvent("g6:joinSession", function()
	local src = source
	-- Check if the player has the job
	-- If the job is not g6, return

	-- Check if there is a Session in progress
	if G6_Current_Session == nil then
		notifyPlayer(src, "~r~Il n'y a pas de session en cours.")
		return
	end

	-- Check if the player is already in the Session
	-- Check if the player is already in the Session
	for _, agent in pairs(G6_Current_Session.agents) do
		if agent == src then
			notifyPlayer(src, "~r~Vous êtes déjà dans la session.")
			return
		end
	end

	-- Add the player to the Session
	table.insert(G6_Current_Session.agents, src)
	if G6_Current_Session.hasStarted then
		TriggerClientEvent("g6:sessionStarted", src, G6_Current_Session)
	end

	TriggerMultiClientsEvent("g6:sessionUpdated", G6_Current_Session.agents, G6_Current_Session)
end)

RegisterServerEvent("g6:leaveSession", function()
	local src = source

	RemovePlayerFromSession(src)
end)

AddEventHandler("playerDropped", function()
	local src = source
	-- Check if the player has the job
	-- If the job is not g6, return
	print("Player "..src.." dropped and left the G6 session.")
	-- Check if there is a Session in progress
	
	RemovePlayerFromSession(src)
end)

function RemovePlayerFromSession(source)
	local src = source
	notifyPlayer(src, "~r~Vous avez quitté la session.")
	if G6_Current_Session == nil then
		notifyPlayer(src, "~r~Il n'y a pas de session en cours.")
		return
	end

	-- Check if the player is already in the Session
	for i, agent in pairs(G6_Current_Session.agents) do
		print("Agent: "..agent)
		if agent == src then
			print("Removing player "..src.." from the session.")
			-- Remove the player from the Session
			table.remove(G6_Current_Session.agents, i)
			break
		end
	end

	if G6_Current_Session.host == src then
		-- If the creator has left, transfer the creator to the first agent in the Session
		G6_Current_Session.host = G6_Current_Session.agents[1]
	end

	if #G6_Current_Session.agents == 0 then
		-- If there is no more agents in the Session, delete the Session
		notifyPlayer(src, "~r~Session deleted because there is no more agents in the Session")
		TriggerEvent("g6:endSession")
		return
	end

	-- If there isn't enough agents in the Session, delete the Session
	if not IsEnoughInService() then
		notifyPlayer(src, "~r~Il n'y a plus assez de g6 en service pour continuer la session.")
		TriggerEvent("g6:endSession")
		return
	end

	if not IsEnoughInSession()  then
		-- If there is no more agents in the Session, delete the Session
		notifyPlayer(src, "~r~Il n'y a plus assez d'agents g6 dans la session pour continuer.")
		TriggerEvent("g6:endSession")
		return
	end

	TriggerMultiClientsEvent("g6:sessionUpdated", G6_Current_Session.agents, G6_Current_Session)
	TriggerClientEvent("g6:sessionUpdated", src, G6_Current_Session)
end

RegisterServerCallback("g6:getPlayersInSession", function(source, cb)
	local src = source
	-- Check if the player has the job
	-- If the job is not g6, return

	-- Check if there is a Session in progress
	if G6_Current_Session == nil then
		notifyPlayer(src, "~r~Il n'y a pas de session en cours.")
		return
	end

	-- Check if the player is in service
	if not Ora.Service:IsPlayerInService(src, "g6") then
		-- If the player isn't in service, return
		notifyPlayer(src, "~r~Vous n'êtes pas en service.")
		return
	end

	local msg = "Les agents dans la session sont: \n"
	for i = 1, #G6_Current_Session.agents, 1 do
		local agent = G6_Current_Session.agents[i]
		local agentName = Ora.Identity:GetFullname(agent)
		msg = msg.."- " .. agentName
		if i ~= #G6_Current_Session.agents then
			msg = msg.."\n"
		end
	end

	cb(msg)
end)

local points = json.decode(LoadResourceFile(GetCurrentResourceName(), "gameplay/jobs/g6/atms.json"))

function CalculateGpsRoute()
	-- Algo that generate route randomly between points, but choose from one of the five closest points
	local route = {}
	local startPointIndex = math.random(1, #points)
	local currentPoint = points[startPointIndex]
	local numberOfPoints = G6_MAX_STOPS_PER_DAY - G6_Number_Of_Stops_Of_The_Day
	for i = 1, numberOfPoints, 1 do
		local closestPoints = {}
		for j = 1, #points, 1 do
			local distance = CalculateDistanceBetweenVectors(currentPoint.coords, points[j].coords)
			if #closestPoints < 5 then
				table.insert(closestPoints, {
					point = points[j],
					distance = distance,
					index = j
				})
			else
				-- TODO : Check for a minimum distante to avoid having to go like from A1 to B1 and then having to come back to the atm next to A1 
				-- (maybe check for a distance smaller than 10 and select this one)
				table.sort(closestPoints, function(a, b)
					return a.distance < b.distance
				end)
				if distance < closestPoints[5].distance then
					closestPoints[5] = {
						point = points[j],
						distance = distance,
						index = j
					}
				end
			end
		end
		local randomIndex = math.random(1, 5)
		table.insert(route, {
			coords = closestPoints[randomIndex].point.coords,
			distance = closestPoints[randomIndex].distance,
			reward = math.random(100, 1000)
		})
		table.remove(points, closestPoints[randomIndex].index)
		currentPoint = closestPoints[randomIndex].point
	end
	return route
end

-- Calculate distance between two three dimensional vectors
function CalculateDistanceBetweenVectors(vector1, vector2)
	return math.sqrt((vector1.x - vector2.x) ^ 2 + (vector1.y - vector2.y) ^ 2 + (vector1.z - vector2.z) ^ 2)
end