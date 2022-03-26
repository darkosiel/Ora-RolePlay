local title = "Aucune musique"
local pause = false
local timer = 0.0
local indexM = 1
local nMusic = {}
local volume = 5
local timeMax = 0.0
local quit = 0
local iquit = false
local job = ''

Citizen.CreateThread(function()
  TriggerServerCallback("music:getPlaylist", function(list)
    playlist = list
  end)
  while playlist == nil do 
    Wait(100)
  end
  Config()
  while Atlantiss.Player.HasLoaded == false do
    Wait(100)
  end
  for k, v in pairs(speaker) do
    if Atlantiss.Identity.Job:GetName() == v.name or Atlantiss.Identity.Orga:Get().label == v.label then
      job = k
      club = v.name
      createSpeakerMenu()
      break
    end
  end
  TriggerServerEvent('music:getVolumeConnect')
  Wait(1000)
end)

local function distanceV(d1, d2)
  return #(d1-d2)
end

local function Notif(msg)
  if not IsHelpMessageOnScreen() then
      SetTextComponentFormat('STRING')
      AddTextComponentString(msg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  end
end

local function OpenMusicMenu()
  RageUI.Visible(RMenu:Get("music", "main"), not RageUI.Visible(RMenu:Get("music", "main")))
end

RMenu.Add("music", "main", RageUI.CreateMenu("Music", "Actions disponibles", 10, 200, nil, nil, 52, 177, 74, 1.0))

RMenu.Add("music", "playlist", RageUI.CreateSubMenu(RMenu:Get("music", "main"), "Playlist", "Listes"))
RMenu.Add("music", "playlist_option", RageUI.CreateSubMenu(RMenu:Get("music", "playlist"), "Playlist", "Actions disponibles"))

function createSpeakerMenu()
  Citizen.CreateThread(function()
    while true do
      Wait(0)

      if RageUI.Visible(RMenu:Get("music", "main")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button(title, nil, {RightLabel = timer.."/"..timeMax}, true, function(_, _, Selected)
            if Selected then
              TriggerServerEvent('music:pause', club)
            end
          end)
          RageUI.List("Musique", {"suivante", "précédente"}, indexM, nil, {}, true, function(_, _, Selected, Index)
            indexM = Index
            if Selected then
              if Index == 1 then
                if clubp[nMusic.index + 1] ~= nil then
                  nMusic.index = nMusic.index + 1
                  local timeMax = tonumber(clubp[nMusic.index].duration)
                  local title = clubp[nMusic.index].title
                  TriggerServerEvent('music:playAll', club, clubp[nMusic.index].id, timeMax, nMusic.index, title)
                   
                end
              else
                if clubp[nMusic.index - 1] ~= nil then
                  nMusic.index = nMusic.index - 1
                  local timeMax = tonumber(clubp[nMusic.index].duration)
                  local title = clubp[nMusic.index].title
                  TriggerServerEvent('music:playAll', club, clubp[nMusic.index].id, timeMax, nMusic.index, title)
                  
                end
              end
            end
          end)

          RageUI.Button("Volume", nil, {RightLabel = volume.."%"}, true, function(_, _, Selected)
            if Selected then
              volume = KeyboardInput("Volume 0-100", "", 3)
              if volume ~= nil and volume ~= "" then
                TriggerServerEvent('music:changeVolume', club, volume)
              end
            end
          end)

          RageUI.Button("Playlist", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("music", "playlist"))
        end)
      end

      if RageUI.Visible(RMenu:Get("music", "playlist")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Ajouter une musique", nil, {}, true, function(_, _, Selected)
            if Selected then
              exports['Snoupinput']:ShowInput("Lien de la musique (exemple : WNeLUngb-Xg)", 255, nil, "", true)
              local id = exports['Snoupinput']:GetInput()
              if id ~= false and id ~= "" then
                SendNUIMessage({eventType = 'addplaylist', link = id})
              end
            end
          end)
          for i=1, #clubp, 1 do
            
            RageUI.Button(clubp[i].title, nil, {}, true, function(_, _, Selected)
              if Selected then
                nMusic = {title = clubp[i].title, id = clubp[i].id, index = i, duration = clubp[i].duration}
              end
            end, RMenu:Get("music", "playlist_option"))
          end
        end)
      end

      if RageUI.Visible(RMenu:Get("music", "playlist_option")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Jouer la musique", nil, {}, true, function(_, _, Selected)
            if Selected then
              local timeMax = tonumber(nMusic.duration)
              local title = nMusic.title
              TriggerServerEvent('music:playAll', club, nMusic.id, timeMax, nMusic.index, title)           
              RageUI.GoBack()
              RageUI.GoBack()
            end
          end)
          RageUI.Button("~r~Supprimer de la playlist", nil, {}, true, function(_, _, Selected)
            if Selected then
              TriggerServerEvent('music:deleteMusic', club, nMusic.index)
              RageUI.GoBack()
            end
          end)
        end)
      end
    end
  end)

  Citizen.CreateThread(function()
    while true do
      Wait(1000)
      local ped = LocalPlayer().Ped
      local pcoords = GetEntityCoords(ped)
      for k, v in pairs(speaker) do 
        if job == k then
          if distanceV(pcoords, v.pos) < 2.0 then
            v.canOpen = true
          else
            v.canOpen = false
          end
        end
      end
    end 
  end)

  Citizen.CreateThread(function()
    while true do
      Wait(0)
      for k, v in pairs(speaker) do
        if job == k then
          if v.canOpen then
            Notif("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
            if IsControlJustPressed(0, 38) then
              OpenMusicMenu()
            end
            break
          else
            Wait(500)
          end
        end
      end
    end
  end)

  Citizen.CreateThread(function()
    while true do
      local wait = 0
      if pause == false and timer < tonumber(timeMax) then
        timer = timer + 0.01
        if string.sub(timer, 3) == tostring(6) then
          timer = timer - 0.60 + 1.00 
        end
        wait = 1000
      end
      Wait(wait)
    end
  end)
end

Citizen.CreateThread(function()
  Wait(2000)
  while true do
    local pcoords = LocalPlayer().Pos
    local playerInterior = GetInteriorAtCoords(pcoords)

    if (playerInterior ~= 0) then
      for k, v in pairs(speaker) do
        if GetInteriorAtCoords(pcoords) == v.interiorId then
          v.inclub = true
          clubp = v.playlist
          quit = 0
          if iquit == true then
            iquit = false
          end
          if not v.play then
            TriggerServerEvent('music:getMusic', v.name)
            v.play = true
          end
          dvol = distanceV(pcoords, v.soundpos) * 0.2
  
          if IsInteriorScene() ~= 1 then dvol = 100 end
  
          getVolume(v.name)
          break
        else
          v.inclub = false
          v.play = false
          if quit < 2 then
            quit = quit +1
          end
        end
        if quit >= 2 and iquit == false then
          SendNUIMessage({eventType = 'stop'})
          iquit = true
        end
      end
    end
    Wait(1000)
  end
end)

function getVolume(club)
  for k, v in pairs(speaker) do
    if club == v.name and job == k then
      volume = v.volume
    end
    if v.name == club and v.volume ~= nil then
      sVol = v.volume - dvol
      SendNUIMessage({eventType = "volume", volume = sVol})
    end
  end
end

RegisterNetEvent('music:playAll')
AddEventHandler('music:playAll', function(club, link, tm, index, titleM)
  local pcoords = LocalPlayer().Pos
  for k, v in pairs(speaker) do
    if club == v.name and job == k then
      timer = 0.0
      pause = false
      title = titleM
      timeMax = tm
      nMusic.index = index
    end
    if club == v.name and v.inclub then
      SendNUIMessage({eventType = "play", link = link, startSeconds = 0})
    end
  end
end)

RegisterNetEvent('music:nextMusic')
AddEventHandler('music:nextMusic', function(club, link, index)
  local pcoords = LocalPlayer().Pos
  for k, v in pairs(speaker) do
    if club == v.name and job == k then
      timer = 0.0
      timeMax = clubp[index].duration
      title = clubp[index].title
      nMusic.index = nMusic.index + 1 
    end
    if club == v.name and v.inclub then
      SendNUIMessage({eventType = "play", link = link, startSeconds = 0})
    end
  end
end)

RegisterNetEvent('music:pause')
AddEventHandler('music:pause', function(club, pauseS)
  for k, v in pairs(speaker) do
    if v.name == club and job == k then
      pause = not pause
    end
    if v.name == club and v.inclub then
      SendNUIMessage({eventType = 'pause', state = pauseS}) 
    end
  end
end)

RegisterNetEvent('music:setVolume')
AddEventHandler('music:setVolume', function(club, vol)
  for k, v in pairs(speaker) do
    if v.name == club then
      v.volume = vol
      if job == k then
        volume = vol
      end
    end
  end
end)

RegisterNetEvent('music:getVolumeConnect')
AddEventHandler('music:getVolumeConnect', function(unicornV, nightV, restaurantV)
  speaker.unicorn.volume = unicornV
  speaker.night.volume = nightV
  speaker.restaurant.volume = restaurantV
end)

RegisterNetEvent('music:getMusic')
AddEventHandler('music:getMusic', function(club, id, index, titleM, seconds, timerM, pause)
  while seconds == nil do
    Wait(100)
  end
  for k, v in pairs(speaker) do
    if v.name == club and job == k then
      title = titleM
      timeMax = timerM
      nMusic.index = index
      local seconds = seconds - 4
      local minutes = seconds / 60
      if minutes < 1.0 then
        minutes = 0
      else
        if seconds > 599 then
          minutes = string.sub(minutes, 1, 2)
        else
          minutes = string.sub(minutes, 1)
        end
      end
      local scd = seconds - (minutes * 60)
      local secds = scd / 100
      ctimer = minutes + secds
      timer = tonumber(ctimer)
    end
  end
  SendNUIMessage({eventType = "play", link = id, startSeconds = seconds})
  if pause == true then
    SendNUIMessage({eventType = 'pause', state = pause})
  end
end)

RegisterNetEvent('music:addToPlaylist')
AddEventHandler('music:addToPlaylist', function(club, data)
  for k, v in pairs(speaker) do
    if k == club then
      table.insert(speaker[club].playlist, data)
    end
  end
end)

RegisterNetEvent('music:deleteMusic')
AddEventHandler('music:deleteMusic', function(club, index)
  table.remove(speaker[club].playlist, index)
end)

RegisterNUICallback('getinfo', function(data, cb)
  if string.len(data.title) > 40 then
    TriggerServerEvent("music:addToPlaylist", club, {title = string.sub(data.title, 1, 40).."...", id = data.id, duration = data.duration})
  else
    TriggerServerEvent("music:addToPlaylist", club, {title = data.title, id = data.id, duration = data.duration})
  end
end)

Citizen.CreateThread(function()
  Wait(3000)
  while true do
    speaker.night.interiorId = GetInteriorAtCoords(speaker.night.soundpos)
    speaker.restaurant.interiorId = GetInteriorAtCoords(speaker.restaurant.soundpos)
    Wait(10000)
  end
end)