local target, zone
onShooting = false
local timeLeft, score, countdown = 60, 0, 3
local nMultiplier, cMultiplier = 1, 0
local ranking = {}
local category

local safeZone = (1.0 - GetSafeZoneSize()) * 0.5
local timerBar = {
  baseX = 0.918,
  baseY = 0.984,
  baseWidth = 0.165,
  baseHeight = 0.035,
  baseGap = 0.038,
  titleX = 0.012,
  titleY = -0.009,
  textX = 0.0785,
  textX2 = 0.040,
  textY = -0.0165,
  progressX = 0.047,
  progressY = 0.0015,
  progressWidth = 0.0616,
  progressHeight = 0.0105,
  bcircleX = {0.964, 0.973, 0.982, 0.991},
  bcircleY = 0.986,
  txtDict = "timerbars",
  txtName = "all_black_bg",
  txtCName = "circle_checkpoints"
}

RMenu.Add("shooting_range", "main", RageUI.CreateMenu("Stand de tir", "Actions disponibles", 10, 100, "shopui_title_gr_gunmod", "shopui_title_gr_gunmod"))
RMenu.Add("shooting_range", "weapons_category", RageUI.CreateSubMenu(RMenu:Get("shooting_range", "main"), "Catégories", "Actions disponibles"))
for k, v in pairs(Shooting_range.weapons) do
  RMenu.Add("shooting_range", k, RageUI.CreateSubMenu(RMenu:Get("shooting_range", "weapons_category"), "Armes", "Choisir une arme", 10, 100))
end
RMenu.Add("shooting_range", "ranking_category", RageUI.CreateSubMenu(RMenu:Get("shooting_range", "main"), "Catégories", "Classement"))
for k, v in pairs(Shooting_range.weapons) do
  RMenu.Add("shooting_range", k.."_ranking", RageUI.CreateSubMenu(RMenu:Get("shooting_range", "ranking_category"), "Top 50", "Actions disponibles"))
end
RMenu.Add("shooting_range", "register_ranking", RageUI.CreateSubMenu(RMenu:Get("shooting_range", "ranking_category"), "Top 50", "Souhaitez vous enregistrez votre record?"))


local function DrawTimerBar(idx, title, text, titleColor, textColor, usePlayerStyle)
  local title = title or ""
  local text = text or ""
  local titleColor = titleColor or { 255, 255, 255, 255 }
  local textColor = textColor or { 255, 255, 255, 255 }
  local titleScale = usePlayerStyle and 0.465 or 0.3
  local titleFont = usePlayerStyle and 4 or 0
  local titleFontOffset = usePlayerStyle and 0.00625 or 0.0
  local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

  if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
    RequestStreamedTextureDict(timerBar.txtDict, true)
    local t = GetGameTimer() + 5000
    repeat
      Wait(0)
    until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
  end

  DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

  BeginTextCommandDisplayText("CELL_EMAIL_BCON")
  SetTextFont(titleFont)
  SetTextScale(titleScale, titleScale)
  SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
  SetTextRightJustify(true)
  SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
  AddTextComponentSubstringPlayerName(title)
  EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

  BeginTextCommandDisplayText("CELL_EMAIL_BCON")
  SetTextFont(0)
  SetTextScale(0.425, 0.425)
  SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
  SetTextRightJustify(true)
  SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.textX)
  AddTextComponentSubstringPlayerName(text)
  EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.textX, yOffset + timerBar.textY)

  if idx ~= nil then
    if idx[1] then
      idx[1] = idx[1] + 1
    end
  end
end

local function DrawTimerBar2(idx, title, text, circle, titleColor, textColor, usePlayerStyle)
  local title = title or ""
  local text = text or ""
  local titleColor = titleColor or { 255, 255, 255, 255 }
  local textColor = textColor or { 255, 255, 255, 255 }
  local titleScale = usePlayerStyle and 0.465 or 0.3
  local titleFont = usePlayerStyle and 4 or 0
  local titleFontOffset = usePlayerStyle and 0.00625 or 0.0
  local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)
  local cyOffset = (timerBar.bcircleY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

  if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
    RequestStreamedTextureDict(timerBar.txtDict, true)
    local t = GetGameTimer() + 5000
    repeat
      Wait(0)
    until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
  end

  DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)
  for i = 1, circle, 1 do
    DrawSprite(timerBar.txtDict, timerBar.txtCName, timerBar.bcircleX[i] - safeZone, cyOffset, 0.0115, 0.02, 0.0, 255, 0, 0, 200)
  end
  for i = 1, 4 - circle, 1 do
    DrawSprite(timerBar.txtDict, timerBar.txtCName, timerBar.bcircleX[i+circle] - safeZone, cyOffset, 0.0115, 0.02, 0.0, 255, 0, 0, 50)
  end

  BeginTextCommandDisplayText("CELL_EMAIL_BCON")
  SetTextFont(titleFont)
  SetTextScale(titleScale, titleScale)
  SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
  SetTextRightJustify(true)
  SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
  AddTextComponentSubstringPlayerName(title)
  EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

  BeginTextCommandDisplayText("CELL_EMAIL_BCON")
  SetTextFont(0)
  SetTextScale(0.425, 0.425)
  SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
  SetTextRightJustify(true)
  SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.textX2)
  AddTextComponentSubstringPlayerName(text)
  EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.textX2, yOffset + timerBar.textY)

  if idx ~= nil then
    if idx[1] then
      idx[1] = idx[1] + 1
    end
  end
end

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

local function countdownScaleform()
  local scaleform = RequestScaleformMovie("COUNTDOWN")
  while not HasScaleformMovieLoaded(scaleform) do
      Citizen.Wait(0)
  end
  BeginScaleformMovieMethod(scaleform, "FADE_MP")
  ScaleformMovieMethodAddParamTextureNameString(countdown)
  ScaleformMovieMethodAddParamInt(r)
  ScaleformMovieMethodAddParamInt(g)
  ScaleformMovieMethodAddParamInt(b)
  EndScaleformMovieMethod()
  return scaleform
end

local function resultScaleform()
  local scaleform = RequestScaleformMovie("mp_big_message_freemode")
  while not HasScaleformMovieLoaded(scaleform) do
    Wait(0)
  end
  BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_CENTERED_TOP_MP_MESSAGE")
  ScaleformMovieMethodAddParamTextureNameString("Terminé")
  ScaleformMovieMethodAddParamTextureNameString("Score : "..score)
  ScaleformMovieMethodAddParamInt(5)
  EndScaleformMovieMethod()
  return scaleform
end

local function startTimer(weapon)
  r, g, b = 244, 215, 66
  timeLeft, score, countdown = 60, 0, 3
  nMultiplier, cMultiplier = 1, 0
  onShooting = true
  TriggerServerEvent("shooting_range:setbucket", zone)
  GiveWeaponToPed(LocalPlayer().Ped, weapon, 350, false, true)
  SetCurrentPedWeapon(LocalPlayer().Ped, weapon, true)
  Wait(2000)
  while countdown ~= 0 do
    PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", true)
    Wait(1000) 
    if countdown - 1 == 0 then 
      PlaySoundFrontend(-1, "GO", "HUD_MINI_GAME_SOUNDSET", true)
      countdown = "GO"
      r, g, b = 50, 215, 50
      Wait(1000)
      countdown = 0
      break
    elseif countdown - 1 ~= 0 then
      countdown = countdown - 1
    end
  end
  while onShooting do
    timeLeft = timeLeft - 1
    if timeLeft <= 0 then
      PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", true)
      onShooting = false
      if DoesEntityExist(target) then
        DeleteObject(target)
      end
      SetCurrentPedWeapon(LocalPlayer().Ped, GetHashKey('WEAPON_UNARMED'), true)
      RemoveWeaponFromPed(LocalPlayer().Ped, weapon)
      local timing = 100
      local scaleform = resultScaleform()
      while timing >= 0 do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        Wait(0)
        timing = timing -1
      end
      if category == "Pistolet" then
        TriggerServerCallback("shooting_range:GetRanking", function(rkng)
          ranking = rkng
          for k, v in ipairs(ranking.pistol) do
            if score > v.score then
              RageUI.Visible(RMenu:Get("shooting_range", "register_ranking"), true)
              break
            end
          end
        end)
      elseif category == "SMG" then
        TriggerServerCallback("shooting_range:GetRanking", function(rkng)
          ranking = rkng
          for k, v in ipairs(ranking.smg) do
            if score > v.score then
              RageUI.Visible(RMenu:Get("shooting_range", "register_ranking"), true)
              break
            end
          end
        end)
      elseif category == "Fusil d'assaut" then
        TriggerServerCallback("shooting_range:GetRanking", function(rkng)
          ranking = rkng
          for k, v in ipairs(ranking.rifle) do
            if score > v.score then
              RageUI.Visible(RMenu:Get("shooting_range", "register_ranking"), true)
              break
            end
          end
        end)
      end
    elseif timeLeft <= 5 then
      PlaySoundFrontend(-1, "10_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", true)
    end
    Wait(1000)
  end
  TriggerServerEvent("shooting_range:returnbucket", zone)
end

local function createTarget()
  local rotation = 90
  local rdmTarget = Shooting_range.localization[zone].targetPos[math.random(#Shooting_range.localization[zone].targetPos)]
  target = Ora.World.Object:Create(Shooting_range.prop.hash, rdmTarget.pos, false, true, true)
  SetEntityRotation(target, rdmTarget.rotX, rdmTarget.rotY, rdmTarget.rotZ)
  while rotation > 0 and rotation <= 90 do
    rotation = rotation - 3.0
    SetEntityRotation(target, rotation, rdmTarget.rotY, rdmTarget.rotZ)
    Wait(0)
  end
end

Citizen.CreateThread(function()
  while true do
    local wait = 0
    if not onShooting and RageUI.CurrentMenu == nil then
      local pedCoords = LocalPlayer().Pos
      for k, v in pairs(Shooting_range.localization) do
        if #(pedCoords - v.pos) < 1.00 then
          Interact("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
          if IsControlJustPressed(0, 51) then
            zone = k
            RageUI.Visible(RMenu:Get("shooting_range", "main"), true)
          end
          zone = k
          wait = 0
          break
        else
          zone = nil
          wait = 1000
        end
      end
    end

    if not onShooting and zone ~= nil then
      if RageUI.Visible(RMenu:Get("shooting_range", "main")) then
        RageUI.DrawContent({header = true, glare = false}, function()
          RageUI.Button("Commencer", nil, {}, true, function()
          end, RMenu:Get("shooting_range", "weapons_category"))
          RageUI.Button("Classement", nil, {}, true, function(_,_,S)
            if S then
              TriggerServerCallback("shooting_range:GetRanking", function(rkng)
                ranking = rkng
              end)
            end
          end, RMenu:Get("shooting_range", "ranking_category"))
        end)
        wait = 0
      end
      if RageUI.Visible(RMenu:Get("shooting_range", "weapons_category")) then
        RageUI.DrawContent({header = true, glare = false}, function()
          for k, v in pairs(Shooting_range.weapons) do
            RageUI.Button(k, nil, {}, true,function()
            end, RMenu:Get("shooting_range", k))
          end
        end)
        wait = 0
      end
      for k, v in pairs(Shooting_range.weapons) do
        if RageUI.Visible(RMenu:Get("shooting_range", k)) then
          RageUI.DrawContent({header = true, glare = false}, function()
            for t, u in ipairs(v) do 
              RageUI.Button(u.label, nil, {RightLabel = u.price.."$"}, true, function(_,_,S)
                if S then
                  TriggerServerCallback("shooting_range:freePlace", function(canShoot)
                    if canShoot then
                      RageUI.CloseAll()
                      dataonWait = {
                        title = "Stand de tir",
                        price = u.price,
                        fct = function()
                          category = k
                          startTimer(u.hash, k)
                        end
                      }
                      TriggerEvent("payWith?")
                    else
                      RageUI.CloseAll()
                      RageUI.Popup({message = "~r~Tout les stands sont pris, veuillez patienter"})
                    end
                  end, zone)
                end
              end)
            end
          end)
          wait = 0
        end
      end
      if RageUI.Visible(RMenu:Get("shooting_range", "ranking_category")) then
        RageUI.DrawContent({header = true, glare = false}, function()
          for k, v in pairs(Shooting_range.weapons) do
            RageUI.Button(k, nil, {}, true,function(_,_,S)
              if S then
              end
            end, RMenu:Get("shooting_range", k.."_ranking"))
          end
        end)
        wait = 0
      end
      if RageUI.Visible(RMenu:Get("shooting_range", "Pistolet_ranking")) then
        RageUI.DrawContent({header = true, glare = false}, function()
          for k, v in ipairs(ranking.pistol) do
            RageUI.Button("Top "..k.." : "..v.name, nil, {RightLabel = v.score}, true, function()
            end)
          end
        end)
        wait = 0
      end
      if RageUI.Visible(RMenu:Get("shooting_range", "SMG_ranking")) then
        RageUI.DrawContent({header = true, glare = false}, function()
          for k, v in ipairs(ranking.smg) do
            RageUI.Button("Top "..k.." : "..v.name, nil, {RightLabel = v.score}, true, function()
            end)
          end
        end)
        wait = 0
      end
      if RageUI.Visible(RMenu:Get("shooting_range", "Fusil d'assaut_ranking")) then
        RageUI.DrawContent({header = true, glare = false}, function()
          for k, v in ipairs(ranking.rifle) do
            RageUI.Button("Top "..k.." : "..v.name, nil, {RightLabel = v.score}, true, function()
            end)
          end
        end)
        wait = 0
      end
      if RageUI.Visible(RMenu:Get("shooting_range", "register_ranking")) then
        RageUI.DrawContent({header = true, glare = false}, function()
          RageUI.Button("Oui", nil, {}, true,function(_, _, S)
            if S then
              local name = KeyboardInput("Pseudo", "", 15)
              if name ~= "" and name ~= nil then
                if category == "Pistolet" then
                  TriggerServerCallback("shooting_range:GetRanking", function(rkng)
                    ranking = rkng
                    for k, v in ipairs(ranking.pistol) do
                      if score > v.score then
                        table.insert(ranking.pistol, k, {name = name, score = score})
                        table.remove(ranking.pistol, 51)
                        TriggerServerEvent('shooting_range:UpdateRanking', ranking)
                        break
                      end
                    end
                  end)
                elseif category == "SMG" then
                  TriggerServerCallback("shooting_range:GetRanking", function(rkng)
                    ranking = rkng
                    for k, v in ipairs(ranking.smg) do
                      if score > v.score then
                        table.insert(ranking.smg, k, {name = name, score = score})
                        table.remove(ranking.smg, 51)
                        TriggerServerEvent('shooting_range:UpdateRanking', ranking)
                        break
                      end
                    end
                  end)
                elseif category == "Fusil d'assaut" then
                  TriggerServerCallback("shooting_range:GetRanking", function(rkng)
                    ranking = rkng
                    for k, v in ipairs(ranking.rifle) do
                      if score > v.score then
                        table.insert(ranking.rifle, k, {name = name, score = score})
                        table.remove(ranking.rifle, 51)
                        TriggerServerEvent('shooting_range:UpdateRanking', ranking)
                        break
                      end
                    end
                  end)
                end
                RageUI.CloseAll()
              end
            end
          end)
          RageUI.Button("Non", nil, {}, true,function(_, _, S)
            if S then
              RageUI.CloseAll()
            end
          end)
        end)
        wait = 0
      end
    end
    Wait(wait)
  end
end) 

Citizen.CreateThread(function()
  local hPQ, R1FIoQI, NsoTwDs, HGli = .925, .975, .14, .03
  local iy = {".", "..", "...", ""}
  while true do
    local wait = 0
    if onShooting then
      local barCount= {1}
      if timeLeft > 5 then
        DrawNiceText(
          hPQ,
          R1FIoQI - .05,
          .5,
          string.format("TEMPS RESTANT : "..s2m(timeleft)),
          4,
          0
      )
      end
      DrawTimerBar(barCount, "TON SCORE", score)
      DrawTimerBar2(barCount, "MULTIPLICATEUR", nMultiplier.."x", cMultiplier)
    else
      wait = 1000
    end
    Wait(wait)
  end
end)

Citizen.CreateThread(function()
  while true do
    local wait = 0
    if onShooting then
      if countdown ~= 0 then
        local scaleform = countdownScaleform()
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
      elseif DoesEntityExist(target) then
        local pPed = LocalPlayer().Ped
        if IsPedShooting(pPed) then
          if HasEntityBeenDamagedByWeapon(target, 0, 2) then
            local bool, hitedCoords = GetPedLastWeaponImpactCoord(pPed)
            local hitedPos = GetOffsetFromEntityGivenWorldCoords(target, hitedCoords)
            if hitedPos.z >= 1.16 then
              for k, v in pairs(Shooting_range.point["head"]) do
                if #(hitedPos - Shooting_range.prop.pos["head"]) < v.dist then
                  score = score + (v.score * nMultiplier)
                  if v.multiplier ~= nil and (cMultiplier + nMultiplier) ~= 7 then
                    cMultiplier = cMultiplier + 1
                    if cMultiplier == 5 then
                      nMultiplier = nMultiplier + 1
                      cMultiplier = 0
                    end
                  else
                    if (cMultiplier + nMultiplier) ~= 1 and v.multiplier == nil then
                      cMultiplier = cMultiplier - 1
                      if cMultiplier == -1 then
                        nMultiplier = nMultiplier - 1
                        cMultiplier = 4
                      end
                    end
                  end
                  PlaySoundFromEntity(-1, v.sound, target, "DLC_GR_Bunker_Shooting_Range_Sounds")
                  break
                end
              end
            else
              for k, v in pairs(Shooting_range.point["body"]) do
                if #(hitedPos - Shooting_range.prop.pos["body"]) < v.dist then
                  score = score + (v.score * nMultiplier)
                  if v.multiplier ~= nil and (cMultiplier + nMultiplier) ~= 7 then
                    cMultiplier = cMultiplier + 1
                    if cMultiplier == 5 then
                      nMultiplier = nMultiplier + 1
                      cMultiplier = 0
                    end
                  else
                    if (cMultiplier + nMultiplier) ~= 1 and v.multiplier == nil then
                      cMultiplier = cMultiplier - 1
                      if cMultiplier == -1 then
                        nMultiplier = nMultiplier - 1
                        cMultiplier = 4
                      end
                    end
                  end
                  PlaySoundFromEntity(-1, v.sound, target, "DLC_GR_Bunker_Shooting_Range_Sounds")
                  break
                end
              end
            end
            DeleteObject(target)
          else
            if (cMultiplier + nMultiplier) ~= 1 then
              cMultiplier = cMultiplier - 1
              if cMultiplier == -1 then
                nMultiplier = nMultiplier - 1
                cMultiplier = 4
              end
            end
          end
        end
      else
        createTarget()
      end
    else
      wait = 1000
    end
    Wait(wait)
  end
end)