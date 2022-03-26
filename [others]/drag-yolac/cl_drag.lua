
local function drawNativeNotification(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 0, -1)
  end
  
  local function GetClosestPlayer(radius)
	local players = GetActivePlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
  
	for _,playerId in ipairs(players) do
	  local targetPed = GetPlayerPed(playerId)
	  if targetPed ~= playerPed then
		local targetCoords = GetEntityCoords(targetPed)
		local distance = #(targetCoords-playerCoords)
		if closestDistance == -1 or closestDistance > distance then
		  closestPlayer = playerId
		  closestDistance = distance
		end
	  end
	end
	if closestDistance ~= -1 and closestDistance <= radius then
	  return closestPlayer
	else
	  return nil
	end
  end
  
  RegisterCommand("drag", function(source, args)
  
  while true do
	RequestAnimDict("combat@drag_ped@injured_drag_ped")
	RequestAnimDict("combat@drag_ped@injured_drag_plyr")
	RequestAnimDict("combat@drag_ped@injured_pickup_back_ped")
	RequestAnimDict("combat@drag_ped@injured_pickup_back_plyr")
  
	Wait(0)
  
  
	if not drag.InProgress then
	  local closestPlayer = GetClosestPlayer(3)
	  if closestPlayer then
		local targetSrc = GetPlayerServerId(closestPlayer)
		if targetSrc ~= -1 then
		  drag.InProgress = true
		  drag.targetSrc = targetSrc
		  TriggerServerEvent("DragPeople:sync",targetSrc)
		  Wait(100)
		  AttachEntityToEntity(ped, targetSrc, GetEntityBoneIndexByName(ped, "MH_L_Knee"), 0, -0.55, 0.27, 0, 0, 0, true, false, true, true, 1, true)
		  TaskPlayAnim(ped, "combat@drag_ped@injured_pickup_back_plyr", "injured_pickup_back_plyr", 8.0, 8.0, 7000, 3, 1.0, 0, 0, 0)
		  TaskPlayAnim(targetSrc, "combat@drag_ped@injured_pickup_back_ped", "injured_pickup_back_ped", 8.0, 8.0, 7000, 3, 1.0, 0, 0, 0)
		  drag.type = "begindragging"
		  Wait(1000)
		  TaskPlayAnim(ped, "combat@drag_ped@injured_drag_plyr", "injured_drag_plyr", 8.0, 8.0, 12000, 1, 1.0, 0, 0, 0)
		  TaskPlayAnim(targetSrc, "combat@drag_ped@injured_drag_ped", "injured_drag_ped", 8.0, 8.0, 12000, 1, 1.0, 0, 0, 0)
		  Wait(500)
		else
		  drawNativeNotification("~r~Personne à tirer !")
		end
	  else
		drawNativeNotification("~r~Personne à tirer !")
	  end
	else
	  drag.InProgress = false
	  ClearPedSecondaryTask(PlayerPedId())
	  DetachEntity(PlayerPedId(), true, false)
	  TriggerServerEvent("DragPeople:stop",drag.targetSrc)
	  drag.targetSrc = 0
	end
  end
  end)
  
  RegisterNetEvent("DragPeople:cl_stop")
  AddEventHandler("DragPeople:cl_stop", function()
  drag.InProgress = false
  ClearPedSecondaryTask(PlayerPedId())
  DetachEntity(PlayerPedId(), true, false)
  
  end)