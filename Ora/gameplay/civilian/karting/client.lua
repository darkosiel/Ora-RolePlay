RMenu.Add("karting", "main", RageUI.CreateMenu("Karting", "Actions disponibles", 10, 100))
RMenu.Add("karting", "join_race", RageUI.CreateSubMenu(RMenu:Get("karting", "main"), "Courses disponible", "Listes"))
RMenu.Add("karting", "ranking", RageUI.CreateSubMenu(RMenu:Get("karting", "main"), "Classement", "Top 20"))
RMenu.Add("karting", "joined_race", RageUI.CreateSubMenu(RMenu:Get("karting", "join_race"), "Participants", "Listes"))

local races = {}
local racesQueue = {}
local ranking = {}
local sRace, host, joined, canOpen, yourTurn, beReady, playerName

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Karting.pos)

	SetBlipSprite(blip, 38)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 0)
	SetBlipDisplay(blip, 4)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Karting")
  EndTextCommandSetBlipName(blip)

end)

local function Interact(msg)
  if not IsHelpMessageOnScreen() then
      SetTextComponentFormat('STRING')
      AddTextComponentString(msg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  end
end

local function s2m(s)
  if s <= 0 then
    return "00:00"
  else
    local m = string.format("%02.f", math.floor(s/60))
    return m..":"..string.format("%02.f", math.floor(s - m * 60))
  end
end

function Karting:CountdownScaleform()
  local scaleform = RequestScaleformMovie("COUNTDOWN")
  while not HasScaleformMovieLoaded(scaleform) do
    Wait(0)
  end
  BeginScaleformMovieMethod(scaleform, "FADE_MP")
  ScaleformMovieMethodAddParamTextureNameString(self.countdown)
  ScaleformMovieMethodAddParamInt(self.countdownColor.r)
  ScaleformMovieMethodAddParamInt(self.countdownColor.g)
  ScaleformMovieMethodAddParamInt(self.countdownColor.b)
  EndScaleformMovieMethod()
  return scaleform
end

function Karting:CountdownStart()
  Citizen.CreateThread(function()
    while self.countdown ~= 0 do
      local scaleform = self:CountdownScaleform()
      DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
      DisableControlAction(0, 75, true)
      Wait(0)
    end
  end)
  while self.countdown ~= 0 do
    PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", true)
    Wait(1000) 
    if self.countdown - 1 == 0 then 
      PlaySoundFrontend(-1, "GO", "HUD_MINI_GAME_SOUNDSET", true)
      self.countdown = "GO"
      self.countdownColor = {r = 50, g = 215, b = 50}
      Wait(1000)
      self.countdown = 0
      FreezeEntityPosition(self.veh, false)
      self.inRace = true
      self:TimerCount()
      break
    elseif self.countdown - 1 ~= 0 then
      self.countdown = self.countdown - 1
    end
  end
end

function Karting:TimerCount()
  self.time = 0
  Citizen.CreateThread(function()
    while self.inRace do
      self.time = self.time + 1
      Wait(1000)
    end
  end)
  Citizen.CreateThread(function()
    while self.inRace do
      local barCount = {1}
      DrawTimerBar(barCount, "TEMPS", s2m(self.time))
      DrawTimerBar(barCount, "TOUR", (self.laps + 1).."/"..self.maxLaps)
      DisableControlAction(0, 75, true)
      Wait(0)
    end
  end)
end

function Karting:StartRace(index)
  inQueue, yourTurn = false, true
  timeLeft = self.startTime
  self.countdown = 3
  self.countdownColor = {r = 244, g = 215, b = 66}
  self.veh = nil
  while timeLeft > 0 do
    Wait(1000)
    timeLeft = timeLeft - 1
  end
  if RageUI.CurrentMenu ~= nil then
    RageUI.CloseAll()
  end
  RequestModel(self.vehicle)
  while not HasModelLoaded(self.vehicle) do
    Wait(100)
  end
  self.veh = Atlantiss.World.Vehicle:Create(self.vehicle, self.spawn[index], self.spawn[index].w, {warp_into_vehicle = true, maxFuel = true})
  SetEntityInvincible(self.veh, true)
  FreezeEntityPosition(self.veh, true)
  TriggerServerEvent("karting:RegisterVehicle", NetworkGetNetworkIdFromEntity(self.veh))
  self:CountdownStart()
  self.laps = 0
  local checkpoint = 0
  while self.inRace do
    for i = 1, #Karting.checkpoint, 1 do
      if #(Karting.checkpoint[i].pos - LocalPlayer().Pos) < Karting.checkpoint[i].radius then
        if not Karting.checkpoint[i].passed and (i == 1 or Karting.checkpoint[i-1].passed) then
          Karting.checkpoint[i].passed = true
          checkpoint = checkpoint + 1
        end
      end
    end
    if checkpoint == #Karting.checkpoint then
      self.laps = self.laps + 1
      checkpoint = 0
      for k, v in ipairs(Karting.checkpoint) do
        v.passed = false
      end
      if self.laps == self.maxLaps then
        RageUI.Popup({message = "Temps enregistré : "..s2m(self.time)})
        self.inRace = false
        host, yourTurn, joined, beReady = false, false, false, false
        Wait(4000)
        DeleteVehicle(self.veh)
        SetEntityCoords(LocalPlayer().Ped, self.finishPos)
        TriggerServerEvent("karting:PlayerFinishRace", playerName, self.time)
      end
    end
    Wait(100)
  end
end

RegisterNetEvent("karting:RefreshRace")
AddEventHandler("karting:RefreshRace", function(raceId, race)
  races[raceId] = race
end)

RegisterNetEvent("karting:LeaveQueue")
AddEventHandler("karting:LeaveQueue", function(queue)
  inQueue = false
  racesQueue = queue
end)

RegisterNetEvent("karting:RefreshQueue")
AddEventHandler("karting:RefreshQueue", function(queue)
  racesQueue = queue
end)

RegisterNetEvent("karting:NextRace")
AddEventHandler("karting:NextRace", function(index)
  Karting:StartRace(index)
end)

RegisterNetEvent("karting:KickRace")
AddEventHandler("karting:KickRace", function(allraces)
  RageUI.GoBack()
  Wait(100)
  beReady = false
  races = allraces
  if #races == 0 then
    RMenu:Get("karting", "join_race").Description = nil
  end
  TriggerServerEvent("money:Add", Karting.price)
end)

Citizen.CreateThread(function()
  while true do
    if RageUI.Visible(RMenu:Get("karting", "main")) then
      RageUI.DrawContent({header = true, glare = true}, function()
        RageUI.Button("Rejoindre une course", nil, {}, true, function(_, _, Selected)
          if Selected then
            RMenu:Get("karting", "join_race").Description = nil
            TriggerServerCallback("karting:GetAllRaces", function(allraces)
              races = allraces
            end)
          end
        end, RMenu:Get("karting", "join_race"))
        RageUI.Button("Créer une course", nil, {}, true, function(_, _, Selected)
          if Selected then
            if not host then
              local name = KeyboardInput("Nom de course", "", 15)
              local owner = KeyboardInput("Pseudo", "", 15)
              if name ~= "" and name ~= nil and owner ~= "" and owner ~= nil then
                RageUI.CloseAll()
                dataonWait = {
                  title = "Karting",
                  price = Karting.price,
                  fct = function()
                    TriggerServerCallback("karting:CreateRace", function(allraces)
                      races = allraces
                    end, name, owner)
                    host = true
                    playerName = name
                  end
                }
                TriggerEvent("payWith?")
              else
                RageUI.Popup({message = "~r~Veuillez réessayer en complétant bien tous les champs"})
              end
            else
              RageUI.Popup({message = "~r~Vous êtes déjà l'hôte d'une partie, vous ne pouvez en créer une autre."})
            end
          end    
        end)
        RageUI.Button("Classement", nil, {}, true, function(_, _, Selected)
          if Selected then
            TriggerServerCallback("karting:GetRanking", function(rkng)
              ranking = rkng
            end)
          end
        end, RMenu:Get("karting", "ranking"))
      end)

    elseif RageUI.Visible(RMenu:Get("karting", "ranking")) then
      RageUI.DrawContent({header = true, glare = true}, function()
        for k, v in ipairs(ranking) do
          RageUI.Button("Top "..k.." : "..v.name, nil, {RightLabel = s2m(v.time)}, true, function(_, _, Selected)
          end)
        end
      end)
    elseif RageUI.Visible(RMenu:Get("karting", "join_race")) then
      RageUI.DrawContent({header = true, glare = true}, function()
        for k, v in ipairs(races) do
          RageUI.Button(v.id.." - "..v.name, "~b~Crée à : ~s~"..v.time.."~n~~b~Propriétaire : ~s~"..v.owner, {}, true, function(_, _, Selected)
            if Selected then
              sRace = k
            end
          end, RMenu:Get("karting", "joined_race"))
        end
      end)

    elseif RageUI.Visible(RMenu:Get("karting", "joined_race")) then
      RageUI.DrawContent({header = true, glare = true}, function()
        if races[sRace].id ~= GetPlayerServerId(PlayerId()) then
          if #races[sRace].players < 4 and not joined and races[sRace].avaible then
            RageUI.Button("Rejoindre la course", nil, {Color = {HightLightColor = {0, 155, 0, 150 }}}, true, function(_, _, Selected)
              if Selected then
                if not host then
                  local name = KeyboardInput("Pseudo", "", 15)
                  if name ~= "" then    
                    TriggerServerCallback("karting:RaceAvaible", function(avaible)
                      if avaible then
                        RageUI.CloseAll()
                        Wait(100)
                        dataonWait = {
                          title = "Karting",
                          price = Karting.price,
                          fct = function()
                            TriggerServerCallback("karting:GetNbPlayersInRace", function(nb)
                              if nb < 4 then
                                local racePlayers = {}
                                joined = true
                                local player = {id = GetPlayerServerId(PlayerId()), name = name, ready = false}
                                for i = 1, #races[sRace].players, 1 do
                                  table.insert(racePlayers, races[sRace].players[i].id)
                                end
                                TriggerServerEvent("karting:JoinRace", races[sRace].id, player, racePlayers)
                                playerName = name
                              else
                                RageUI.Popup({message = "~r~Il n'y a plus de place."})
                                TriggerServerEvent("money:Add", Karting.price)
                              end
                            end, races[sRace].id)
                          end
                        }
                        TriggerEvent("payWith?")
                      else
                        RageUI.Popup({message = "~r~Vous ne pouvez pas rejoindre la course."})
                      end    
                    end, races[sRace].id)
                  end
                else
                  RageUI.Popup({message = "~r~Vous êtes déjà l'hôte d'une partie, vous ne pouvez en rejoindre une autre."})
                end
              end
            end)
            RageUI.Separator("~b~___________________")
          elseif joined then
            if inQueue then
              for i = 1, #racesQueue, 1 do
                if racesQueue[i] == races[sRace].id then
                  RageUI.Button("File d'attente", nil, {RightLabel = i}, true, function()
                  end)
                  break
                end
              end
            elseif yourTurn then
              RageUI.CenterButton("Début de la course dans ~b~"..timeLeft.."~s~ secondes", nil, {}, true, function()
              end)
            else
              local text, color
              if not beReady then
                text = "Se mettre prêt"
                color = {HightLightColor = {0, 155, 0, 150 }}
              else
                text = "Annuler prêt"
                color = {HightLightColor = {155, 0, 0, 150 }}
              end
              RageUI.Button(text, nil, {Color = color}, true, function(_, _, Selected)
                if Selected then
                  local racePlayers = {}
                  beReady = not beReady
                  for i = 1, #races[sRace].players, 1 do
                    table.insert(racePlayers, races[sRace].players[i].id)
                  end
                  TriggerServerEvent("karting:BeReady", races[sRace].id, beReady, racePlayers)
                end
              end)
              RageUI.Button("Quitter la course", nil, {Color = {HightLightColor = {155, 0, 0, 150 }}}, true, function(_, _, Selected)
                if Selected then
                  joined = false
                  local playerId = GetPlayerServerId(PlayerId())
                  local racePlayers = {}
                  for i = 1, #races[sRace].players, 1 do
                    table.insert(racePlayers, races[sRace].players[i].id)
                  end
                  for k, v in ipairs(races[sRace].players) do
                    if v.id == playerId then
                      TriggerServerEvent("karting:LeaveRace", races[sRace].id, racePlayers)
                      break
                    end
                  end
                  TriggerServerEvent("money:Add", Karting.price)
                end
              end)
            end
            RageUI.Separator("~b~___________________")
          end
        else
          if not inQueue and not yourTurn then
            RageUI.Button("Démarrer la course", nil, {Color = {HightLightColor = {0, 155, 0, 150}}}, true, function(_, _, Selected)
              if Selected then
                local readyPlayers = 0
                for i = 1, #races[sRace].players, 1 do
                  if races[sRace].players[i].ready then
                    readyPlayers = readyPlayers + 1
                  end
                end
                if #races[sRace].players == readyPlayers then
                  TriggerServerCallback("karting:GetRaceStatus", function(inProgress)
                    if inProgress == nil then
                      local racePlayers = {}
                      for i = 1, #races[sRace].players, 1 do
                        table.insert(racePlayers, races[sRace].players[i].id)
                      end
                      TriggerServerEvent("karting:NextRace", races[sRace].id, racePlayers)
                    else
                      TriggerServerCallback("karting:AddToQueue", function(queue)
                        racesQueue = queue
                        inQueue = true
                      end, races[sRace].id)
                    end
                  end)
                else
                  RageUI.Popup({message = "~r~Tous les joueurs ne sont pas prêts."})
                end
              end
            end)
            RageUI.Button("Supprimer la course", nil, {Color = {HightLightColor = {155, 0, 0, 150 }}}, true, function(_, _, Selected)
              if Selected then
                local delete = KeyboardInput("Êtes-vous sûr? (oui/non)", "", 3)
                if delete == "oui" then
                  local racePlayers = {}
                  for i = 1, #races[sRace].players, 1 do
                    table.insert(racePlayers, races[sRace].players[i].id)
                  end
                  TriggerServerEvent("karting:DeleteRace", races[sRace].id, racePlayers)
                  host = false
                end
              end
            end)
          else
            if yourTurn then
              RageUI.CenterButton("Début de la course dans ~b~"..timeLeft.."~s~ secondes", nil, {}, true, function()
              end)
            else
              for i = 1, #racesQueue, 1 do
                if racesQueue[i] == races[sRace].id then
                  RageUI.Button("File d'attente", nil, {RightLabel = i}, true, function()
                  end)
                  break
                end
              end
              RageUI.Button("Quitter la file d'attente", nil, {Color = {HightLightColor = {155, 0, 0, 150 }}}, true, function(_, _, Selected)
                if Selected then
                  local racePlayers = {}
                  for i = 1, #races[sRace].players, 1 do
                    table.insert(racePlayers, races[sRace].players[i].id)
                  end
                  TriggerServerEvent("karting:LeaveQueue", races[sRace].id, racePlayers)
                end
              end)
            end
          end
          RageUI.Separator("~b~___________________")
        end

        if races[sRace] then
          RageUI.Button("~b~Propriétaire : ~s~"..races[sRace].owner, nil, {}, true, function()
          end)
          for i = 2, #Karting.spawn, 1 do
            if races[sRace].players[i] == nil then
              RageUI.Button("Place disponible", nil, {}, true, function()
              end)
            else
              local ready
              if races[sRace].players[i].ready then 
                ready = "~g~Prêt" 
              else 
                ready = "~r~En attente" 
              end
              RageUI.Button(races[sRace].players[i].name, nil, {RightLabel = ready}, true, function()
              end)
            end
          end
        end
      end)

    elseif not Karting.inRace and RageUI.CurrentMenu == nil and canOpen then
      Interact("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
      if IsControlJustPressed(0, 51) then
        RageUI.Visible(RMenu:Get("karting", "main"), true)
      end
    else
      Wait(500)
    end
    Wait(0)
  end
end)

Citizen.CreateThread(function()
  while true do
    if not Karting.inRace and RageUI.CurrentMenu == nil then
      if #(Karting.pos - LocalPlayer().Pos) < 2.0 then
        canOpen = true
      else
        canOpen = false
      end
    end
    Wait(1000)
  end
end)