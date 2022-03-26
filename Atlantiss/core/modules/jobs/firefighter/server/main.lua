--================================--
--       FIRE SCRIPT v1.7.6       --
--  by GIMI (+ foregz, Albo1125)  --
--      License: GNU GPL 3.0      --
--================================--

--================================--
--          INITIALIZE            --
--================================--

function onResourceStart(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		Atlantiss.Jobs.Firefighter.Whitelist:load()
		Atlantiss.Jobs.Firefighter.Fire:loadRegistered()
		if Atlantiss.Jobs.Firefighter.Config.Fire.spawner.enableOnStartup and Atlantiss.Jobs.Firefighter.Config.Fire.spawner.interval then
			if not Atlantiss.Jobs.Firefighter.Fire:startSpawner() then
				sendMessage(0, "Couldn't start fire spawner.")
			end
		end
	end
end

RegisterNetEvent('onResourceStart')
AddEventHandler(
	'onResourceStart',
	onResourceStart
)

--================================--
--           CLEAN-UP             --
--================================--

function onPlayerDropped()
	Atlantiss.Jobs.Firefighter.Whitelist:removePlayer(source)
	Atlantiss.Jobs.Firefighter.Dispatch:unsubscribe(source)
end

RegisterNetEvent('playerDropped')
AddEventHandler(
	'playerDropped',
	onPlayerDropped
)

--================================--
--           COMMANDS             --
--================================--

RegisterNetEvent('fireManager:command:startfire')
AddEventHandler(
	'fireManager:command:startfire',
	function(coords, maxSpread, chance, triggerDispatch, dispatchMessage)
		if not Atlantiss.Jobs.Firefighter.Whitelist:isWhitelisted(source, "firescript.start") then
			sendMessage(source, "Insufficient permissions.")
			return
		end

		local _source = source

		local maxSpread = (maxSpread ~= nil and tonumber(maxSpread) ~= nil) and tonumber(maxSpread) or Atlantiss.Jobs.Firefighter.Config.Fire.maximumSpreads
		local chance = (chance ~= nil and tonumber(chance) ~= nil) and tonumber(chance) or Atlantiss.Jobs.Firefighter.Config.Fire.fireSpreadChance

		local fireIndex = Atlantiss.Jobs.Firefighter.Fire:create(coords, maxSpread, chance)

		Citizen.SetTimeout(
			math.random(Atlantiss.Jobs.Firefighter.Config.Fire.selfRemoveMIN, Atlantiss.Jobs.Firefighter.Config.Fire.selfRemoveMAX),
			function()
				Atlantiss.Jobs.Firefighter.Fire:remove(fireIndex)
			end
		)

		if triggerDispatch then
			Citizen.SetTimeout(
				Atlantiss.Jobs.Firefighter.Config.Dispatch.timeout,
				function()
					if Atlantiss.Jobs.Firefighter.Config.Dispatch.enabled and not Atlantiss.Jobs.Firefighter.Config.Dispatch.disableCalls then
						if dispatchMessage then
							Atlantiss.Jobs.Firefighter.Dispatch:create(dispatchMessage, coords)
						else
							Atlantiss.Jobs.Firefighter.Dispatch.expectingInfo[_source] = true
							TriggerClientEvent('fd:dispatch', _source, coords)
						end
					end
				end
			)
		end
	end
)

RegisterNetEvent('fireManager:command:registerscenario')
AddEventHandler(
	'fireManager:command:registerscenario',
	function(coords)
		if not Atlantiss.Jobs.Firefighter.Whitelist:isWhitelisted(source, "firescript.manage") then
			sendMessage(source, "Insufficient permissions.")
			return
		end

		local registeredFireID = Atlantiss.Jobs.Firefighter.Fire:register(coords)

		sendMessage(source, "Created scenario #" .. registeredFireID)
	end
)

RegisterNetEvent('fireManager:command:addflame')
AddEventHandler(
	'fireManager:command:addflame',
	function(registeredFireID, coords, spread, chance)
		if not Atlantiss.Jobs.Firefighter.Whitelist:isWhitelisted(source, "firescript.manage") then
			sendMessage(source, "Insufficient permissions.")
			return
		end

		local registeredFireID = tonumber(registeredFireID)
		local spread = tonumber(spread)
		local chance = tonumber(chance)

		if not (coords and registeredFireID and spread and chance) then
			return
		end

		local flameID = Atlantiss.Jobs.Firefighter.Fire:addFlame(registeredFireID, coords, spread, chance)

		if not flameID then
			sendMessage(source, "No such scenario.")
			return
		end

		sendMessage(source, "Added flame #" .. flameID)
	end
)

RegisterCommand(
	'stopfire',
	function(source, args, rawCommand)
		if not Atlantiss.Jobs.Firefighter.Whitelist:isWhitelisted(source, "firescript.stop") then
			sendMessage(source, "Insufficient permissions.")
			return
		end

		local fireIndex = tonumber(args[1])

		if not fireIndex then
			return
		end

		if Atlantiss.Jobs.Firefighter.Fire:remove(fireIndex) then
			sendMessage(source, "Stopping fire #" .. fireIndex)
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = "Fire " .. fireIndex .. " going out...",
				type = "info",
				timeout = 5000,
				layout = "centerRight",
				queue = "fire"
			})
		end
	end,
	false
)

RegisterCommand(
	'stopallfires',
	function(source, args, rawCommand)
		if not Atlantiss.Jobs.Firefighter.Whitelist:isWhitelisted(source, "firescript.stop") then
			sendMessage(source, "Insufficient permissions.")
			return
		end

		Atlantiss.Jobs.Firefighter.Fire:removeAll()

		sendMessage(source, "Stopping fires")
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = "Fires going out...",
			type = "info",
			timeout = 5000,
			layout = "centerRight",
			queue = "fire"
		})
	end,
	false
)

RegisterCommand(
	'removeflame',
	function(source, args, rawCommand)
		if not Atlantiss.Jobs.Firefighter.Whitelist:isWhitelisted(source, "firescript.manage") then
			sendMessage(source, "Insufficient permissions.")
			return
		end

		local registeredFireID = tonumber(args[1])
		local flameID = tonumber(args[2])

		if not (registeredFireID and flameID) then
			return
		end

		local success = Atlantiss.Jobs.Firefighter.Fire:deleteFlame(registeredFireID, flameID)

		if not success then
			sendMessage(source, "No such fire or flame registered.")
			return
		end

		sendMessage(source, "Removed flame #" .. flameID)
	end,
	false
)

RegisterCommand(
	'removescenario',
	function(source, args, rawCommand)
		if not Atlantiss.Jobs.Firefighter.Whitelist:isWhitelisted(source, "firescript.manage") then
			sendMessage(source, "Insufficient permissions.")
			return
		end
		local registeredFireID = tonumber(args[1])
		if not registeredFireID then
			return
		end

		local success = Atlantiss.Jobs.Firefighter.Fire:deleteRegistered(registeredFireID)

		if not success then
			sendMessage(source, "No such scenario.")
			return
		end

		sendMessage(source, "Removed scenario #" .. registeredFireID)
	end,
	false
)

RegisterCommand(
	'startscenario',
	function(source, args, rawCommand)
		if not Atlantiss.Jobs.Firefighter.Whitelist:isWhitelisted(source, "firescript.start") then
			sendMessage(source, "Insufficient permissions.")
			return
		end
		local _source = source
		local registeredFireID = tonumber(args[1])
		local triggerDispatch = args[2] == "true"

		if not registeredFireID then
			return
		end

		local success = Atlantiss.Jobs.Firefighter.Fire:startRegistered(registeredFireID, triggerDispatch, source)

		if not success then
			sendMessage(source, "No such scenario.")
			return
		end

		sendMessage(source, "Started scenario #" .. registeredFireID)
	end,
	false
)

RegisterCommand(
	'stopscenario',
	function(source, args, rawCommand)
		if not Atlantiss.Jobs.Firefighter.Whitelist:isWhitelisted(source, "firescript.stop") then
			sendMessage(source, "Insufficient permissions.")
			return
		end
		local _source = source
		local registeredFireID = tonumber(args[1])

		if not registeredFireID then
			return
		end

		local success = Atlantiss.Jobs.Firefighter.Fire:stopRegistered(registeredFireID)

		if not success then
			sendMessage(source, "No such scenario active.")
			return
		end

		sendMessage(source, "Stopping scenario #" .. registeredFireID)

		TriggerClientEvent("pNotify:SendNotification", source, {
			text = "Fire going out...",
			type = "info",
			timeout = 5000,
			layout = "centerRight",
			queue = "fire"
		})
	end,
	false
)

RegisterCommand(
	'firewl',
	function(source, args, rawCommand)
		local _source = source
		local action = args[1]
		local serverId = tonumber(args[2])

		if not (action and serverId) or serverId < 1 then
			return
		end

		local identifier = GetPlayerIdentifier(serverId, 0)

		if not identifier then
			sendMessage(source, "Player not online.")
			return
		end

		if action == "add" then
			Atlantiss.Jobs.Firefighter.Whitelist:addPlayer(serverId, identifier)
			sendMessage(source, ("Added %s to the whitelist."):format(GetPlayerName(serverId)))
		elseif action == "remove" then
			Atlantiss.Jobs.Firefighter.Whitelist:removePlayer(serverId, identifier)
			sendMessage(source, ("Removed %s from the whitelist."):format(GetPlayerName(serverId)))
		else
			sendMessage(source, "Invalid action.")
		end
	end,
	true
)

RegisterCommand(
	'firewlreload',
	function(source, args, rawCommand)
		Atlantiss.Jobs.Firefighter.Whitelist:load()
		sendMessage(source, "Reloaded whitelist from Atlantiss.Jobs.Firefighter.Config.")
	end,
	true
)

RegisterCommand(
	'firewlsave',
	function(source, args, rawCommand)
		Atlantiss.Jobs.Firefighter.Whitelist:save()
		sendMessage(source, "Saved whitelist.")
	end,
	true
)

RegisterCommand(
	'firedispatch',
	function(source, args, rawCommand)
		local _source = source
		local action = args[1]
		local serverId = tonumber(args[2])

		if not (action and serverId) or serverId < 1 then
			return
		end

		if action == "scenario" then
			if not Atlantiss.Jobs.Firefighter.Fire.registered[serverId] then
				sendMessage(source, "The specified scenario hasn't been found.")
				return
			end

			table.remove(args, 1)
			table.remove(args, 1)

			Atlantiss.Jobs.Firefighter.Fire.registered[serverId].message = next(args) and table.concat(args, " ") or nil
			Atlantiss.Jobs.Firefighter.Fire:saveRegistered()
			sendMessage(source, ("Changed scenario's (#%s) dispatch message."):format(serverId))
		else
			local identifier = GetPlayerIdentifier(serverId, 0)

			if not identifier then
				sendMessage(source, "Player not online.")
				return
			end

			if action == "add" then
				Atlantiss.Jobs.Firefighter.Dispatch:subscribe(serverId, (not args[3] or args[3] ~= "false"))
				sendMessage(source, ("Subscribed %s to dispatch."):format(GetPlayerName(serverId)))
			elseif action == "remove" then
				Atlantiss.Jobs.Firefighter.Dispatch:unsubscribe(serverId, identifier)
				sendMessage(source, ("Unsubscribed %s from the dispatch."):format(GetPlayerName(serverId)))
			else
				sendMessage(source, "Invalid action.")
			end
		end
	end,
	true
)

RegisterCommand(
	'randomfires',
	function(source, args, rawCommand)
		if not Atlantiss.Jobs.Firefighter.Whitelist:isWhitelisted(source, "firescript.manage") then
			sendMessage(source, "Insufficient permissions.")
			return
		end

		local _source = source
		local action = args[1]
		local registeredFireID = tonumber(args[2])

		if not action then
			return
		end

		if action == "add" then
			if not registeredFireID then
				sendMessage(source, "Invalid argument (2).")
				return
			end
			Atlantiss.Jobs.Firefighter.Fire:setRandom(registeredFireID, true)
			sendMessage(source, ("Set scenario #%s to start randomly."):format(registeredFireID))
		elseif action == "remove" then
			if not registeredFireID then
				sendMessage(source, "Invalid argument (2).")
				return
			end
			Atlantiss.Jobs.Firefighter.Fire:setRandom(registeredFireID, false)
			sendMessage(source, ("Set scenario #%s not to start randomly."):format(registeredFireID))
		elseif action == "disable" then
			Atlantiss.Jobs.Firefighter.Fire:stopSpawner()
			sendMessage(source, "Disabled random fire spawn.")
		elseif action == "enable" then
			Atlantiss.Jobs.Firefighter.Fire:startSpawner()
			sendMessage(source, "Enabled random fire spawn.")
		else
			sendMessage(source, "Invalid action.")
		end
	end,
	false
)

--================================--
--           FIRE SYNC            --
--================================--

RegisterNetEvent('fireManager:requestSync')
AddEventHandler(
	'fireManager:requestSync',
	function()
		if source > 0 then
			TriggerClientEvent('fireClient:synchronizeFlames', source, Atlantiss.Jobs.Firefighter.Fire.active)
		end
	end
)

RegisterNetEvent('fireManager:createFlame')
AddEventHandler(
	'fireManager:createFlame',
	function(fireIndex, coords)
		Atlantiss.Jobs.Firefighter.Fire:createFlame(fireIndex, coords)
	end
)

RegisterNetEvent('fireManager:createFire')
AddEventHandler(
	'fireManager:createFire',
	function()
		Atlantiss.Jobs.Firefighter.Fire:create(coords, maximumSpread, spreadChance)
	end
)

RegisterNetEvent('fireManager:removeFire')
AddEventHandler(
	'fireManager:removeFire',
	function(fireIndex)
		Atlantiss.Jobs.Firefighter.Fire:remove(fireIndex)
	end
)

RegisterNetEvent('fireManager:removeAllFires')
AddEventHandler(
	'fireManager:removeAllFires',
	function()
		Atlantiss.Jobs.Firefighter.Fire:removeAll()
	end
)

RegisterNetEvent('fireManager:removeFlame')
AddEventHandler(
	'fireManager:removeFlame',
	function(fireIndex, flameIndex)
		Atlantiss.Jobs.Firefighter.Fire:removeFlame(fireIndex, flameIndex)
	end
)

--================================--
--           DISPATCH             --
--================================--

RegisterNetEvent('fireDispatch:registerPlayer')
AddEventHandler(
	'fireDispatch:registerPlayer',
	function(playerSource, isFirefighter)
		source = tonumber(source)
		playerSource = tonumber(playerSource)
		if (source and source > 0) or not playerSource or playerSource < 0 then
			return
		end

		Atlantiss.Jobs.Firefighter.Dispatch:subscribe(playerSource, not (isFirefighter))
	end
)

RegisterNetEvent('fireDispatch:removePlayer')
AddEventHandler(
	'fireDispatch:removePlayer',
	function(playerSource)
		source = tonumber(source)
		playerSource = tonumber(playerSource)
		if (source and source > 0) or not playerSource or playerSource < 0 then
			return
		end

		Atlantiss.Jobs.Firefighter.Dispatch:subscribe(playerSource)
	end
)

RegisterNetEvent('fireDispatch:create')
AddEventHandler(
	'fireDispatch:create',
	function(text, coords)
		if Atlantiss.Service.Jobs["lsfd"][source] ~= nil and (source < 1 or Atlantiss.Jobs.Firefighter.Dispatch.expectingInfo[source]) then
			Atlantiss.Jobs.Firefighter.Dispatch:create(text, coords)
			if source > 0 then
				Atlantiss.Jobs.Firefighter.Dispatch.expectingInfo[source] = nil
			end
		end
	end
)

--================================--
--          WHITELIST             --
--================================--

RegisterNetEvent('fireManager:checkWhitelist')
AddEventHandler(
	'fireManager:checkWhitelist',
	function(serverId)
		if serverId then
			source = tonumber(serverId) or source
		end

		Atlantiss.Jobs.Firefighter.Whitelist:check(source)
	end
)
