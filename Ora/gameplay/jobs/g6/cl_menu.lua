
RMenu.Add("g6", "main", RageUI.CreateMenu("ORA", "Actions disponibles", 10, 200, nil, nil, 52, 177, 74, 1.0))

local MIN_NUMBER_IN_SESSION <const> = 1

function OpenSessionMenu()
	TriggerServerCallback("g6:getCurrentSession", function(data)
		--if data ~= nil then
			UpdateSession(data)
		--end
		RMenu:Get("g6", "main").Controls.Back.Enabled = false
		RageUI.Visible(RMenu:Get("g6", "main"), true)
	end)
end

Citizen.CreateThread(function()
	local visible = false
	while true do
		if RageUI.Visible(RMenu:Get("g6", "main")) then
			visible = true
			RageUI.DrawContent({header = true, glare = true}, function()
				if Current_Session_Data == nil then	
					RageUI.Button("Générer une nouvelle mission", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
						if Selected then
							Player.Vehicle = GetVehiclePedIsIn(Player.Ped, false)
							if Player.Vehicle == 0 then
								ShowNotification("Vous devez être dans un véhicule compatible (Stockade) pour créer une nouvelle mission")
							end
							TriggerServerEvent("g6:createSession", NetworkGetNetworkIdFromEntity(Player.Vehicle))
						end
					end)
				else
					if Current_Session_Data.host == Player.ServerID then
						if Current_Session_Data.hasStarted then
							RageUI.Button("Finir la mission", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
								if Selected then
									TriggerServerEvent("g6:endSession")
								end
							end)
						else
							RageUI.Button("Commencer la mission", nil, {RightLabel = "→"}, (#Current_Session_Data.agents >= MIN_NUMBER_IN_SESSION ), function(Hovered, Active, Selected)
								if Selected then
									TriggerServerEvent("g6:startSession")
								end
							end)
						end
					end
					-- If i'm in Session, then offer the agent to leave the Session
					if Current_Session_Data.clientInSession then
						RageUI.Button("Quitter la mission", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
							if Selected then
								TriggerServerEvent("g6:leaveSession")
							end
						end)
					else
						RageUI.Button("Rejoindre la mission en cours", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
							if Selected then
								TriggerServerEvent("g6:joinSession")
							end
						end)
					end
					RageUI.CenterButton("------", nil, {}, false, function(Hovered, Active, Selected)
					end)
					RageUI.Button("Liste des agents", "Avoir la liste des agents dans la session en cours.", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if Selected then
							TriggerServerCallback("g6:getPlayersInSession", function(message)
								ShowNotification(message)
							end)
						end
					end)
				end
			end, function()
			
			end)

			if IsDisabledControlJustPressed(0, 177) then
				RageUI.Visible(RMenu:Get("g6", "main"), false)
				RageUI.Visible(RMenu:Get('jobs',"g6_menujob"), true)
				RMenu:Get("g6", "main").Controls.Back.Enabled = true
			end
		else
			if visible then
				RMenu:Get("g6", "main").Controls.Back.Enabled = true
				visible = false
			end
		end

		--print("thread runnig")
		Citizen.Wait(0)
	end
end)