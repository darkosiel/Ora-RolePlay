local numbers = {}
local messages = {}
local calls = {}
local contacts = {}
local apparts = {}
local vehicles = {}
local infoPlayers = {}
local timeGetInfo = 10
local policeHackCall = {"police", "lssd"}
local policeIndex = 1
local i_lastName, i_firstName, i_dBirth, i_origin, i_sex, l_lastName, l_firstName, l_dBirth, c_plate, c_model, c_lastName, c_firstName

RMenu.Add("hacker", "main", RageUI.CreateMenu("Hackeur", "Actions disponibles", 10, 50))
RMenu.Add("hacker", "fake_id", RageUI.CreateSubMenu(RMenu:Get("hacker", "main"), "Faux papiers", "Listes"))
RMenu.Add("hacker", "fake_identity", RageUI.CreateSubMenu(RMenu:Get("hacker", "fake_id"), "Identité", "Listes"))
RMenu.Add("hacker", "fake_license", RageUI.CreateSubMenu(RMenu:Get("hacker", "fake_id"), "Permis", "Listes"))
RMenu.Add("hacker", "fake_registration", RageUI.CreateSubMenu(RMenu:Get("hacker", "fake_id"), "Carte grise", "Listes"))
RMenu.Add("hacker", "tel", RageUI.CreateSubMenu(RMenu:Get("hacker", "main"), "Téléphone", "Listes"))
RMenu.Add("hacker", "infos", RageUI.CreateSubMenu(RMenu:Get("hacker", "main"), "Informations", "Listes"))
RMenu.Add("hacker", "players", RageUI.CreateSubMenu(RMenu:Get("hacker", "infos"), "Identité", "Listes"))
RMenu.Add("hacker", "players_infos", RageUI.CreateSubMenu(RMenu:Get("hacker", "players"), "Informations", "Listes"))
RMenu.Add("hacker", "players_apartment_infos", RageUI.CreateSubMenu(RMenu:Get("hacker", "players_infos"), "Habitation", "Listes"))
RMenu.Add("hacker", "players_vehicles_infos", RageUI.CreateSubMenu(RMenu:Get("hacker", "players_infos"), "Véhicules", "Listes"))
RMenu.Add("hacker", "vehicle", RageUI.CreateSubMenu(RMenu:Get("hacker", "main"), "Véhicule", "Listes"))
RMenu.Add("hacker", "cl_player_tel", RageUI.CreateSubMenu(RMenu:Get("hacker", "tel"), "Player", "Listes"))
RMenu.Add("hacker", "cl_player_tel_action", RageUI.CreateSubMenu(RMenu:Get("hacker", "cl_player_tel"), "Actions", "Listes"))
RMenu.Add("hacker", "get_numbers", RageUI.CreateSubMenu(RMenu:Get("hacker", "tel"), "Numéros", "Listes"))
RMenu.Add("hacker", "get_number_infos", RageUI.CreateSubMenu(RMenu:Get("hacker", "get_numbers"), "Informations", "Listes"))
RMenu.Add("hacker", "get_number_messages", RageUI.CreateSubMenu(RMenu:Get("hacker", "get_number_infos"), "Messages", "Listes"))
RMenu.Add("hacker", "get_number_calls", RageUI.CreateSubMenu(RMenu:Get("hacker", "get_number_infos"), "Appels", "Listes"))
RMenu.Add("hacker", "get_number_contacts", RageUI.CreateSubMenu(RMenu:Get("hacker", "get_number_infos"), "Contacts", "Listes"))

local function ELoadingPrompt(text, spinnerType)
  if BusyspinnerIsOn() then
    BusyspinnerOff()
  end
  if text ~= nil then
    BeginTextCommandBusyspinnerOn("STRING")
    AddTextComponentSubstringPlayerName(text)
  end
  EndTextCommandBusyspinnerOn(spinnerType)
end

local function ERemoveLoadingPrompt()
  BusyspinnerOff()
end

local function distanceV(d1, d2)
  return #(d1-d2)
end

local function numberH(num)
  for k, v in pairs(numbers) do
    if v == num then
      return true
    end
  end
  return false
end

local function playersH(fName, lName)
  for k, v in pairs(infoPlayers) do
    if v.firstName == fName and v.lastName == lName then
      return true
    end
  end
  return false
end

local function loadAnimDict(dict)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Wait(100)
  end
end

local function attachPhone()
  local phoneModel = GetHashKey("prop_phone_ing_03")
  RequestModel(phoneModel)
  while not HasModelLoaded(phoneModel) do
      Citizen.Wait(1)
  end
  phoneProp = Ora.World.Object:Create(phoneModel, 1.0, 1.0, 1.0, 1, 1, 0)
  local bone = GetPedBoneIndex(LocalPlayer().Ped, 28422)
  AttachEntityToEntity(phoneProp, LocalPlayer().Ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

local function phoneAnim()
  attachPhone()
  loadAnimDict("cellphone@str")
  TaskPlayAnim(LocalPlayer().Ped, "cellphone@str", "cellphone_text_press_a", 2.0, 0.0, -1, 16, 0.0, false, false, false)
  Wait(3500)
  TaskPlayAnim(LocalPlayer().Ped, "cellphone@", "cellphone_text_out", 8.0, 8.0, -1, 16, 0.0, false, false, false)
  DeleteObject(phoneProp)
end

local function getInfoAnim()
  busyHacker = true
  attachPhone()
  loadAnimDict("cellphone@")
  TaskPlayAnim(LocalPlayer().Ped, "cellphone@", "cellphone_text_in", 3.0, -1, -1, 50)
  Wait(timeGetInfo * 1000)
  ClearPedTasks(LocalPlayer().Ped)
  DeleteObject(phoneProp)
  busyHacker = false
end

local function successInfo(info, target)
  if info == "num" then
    TriggerServerCallback("hacker:getNum",function(number)
      if number ~= nil then
        ShowNotification("~g~Succès!~s~~n~Numéro de téléphone de l'individu : ~b~"..number)
      else
        ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
      end
    end, target)
  elseif info == "identity" then
    TriggerServerCallback("hacker:getIdentity",function(fName, lName)
      if fName ~= nil then
        ShowNotification("~g~Succès!~s~~n~Identité : ~b~"..fName.." "..lName)
      else
        ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
      end
    end, target)
  elseif info == "message" then
    TriggerServerCallback("hacker:getMessage",function(number, message, Time)
      if number ~= nil then
        ShowNotification("~g~Succès!~s~~n~Récupération des messages à partir du numéro : ~b~"..number)
        if message ~= nil then
          local nbr = tostring(number)
          if numberH(nbr) == false then
            table.insert(numbers, nbr)
          end
          for i, v in pairs(message) do
            table.insert(messages, {number = nbr, message = v.message, sender = v.receiver, receiver = v.transmitter, time = Time[i]})
          end
        else
          ShowNotification("~r~Erreur!~s~~n~Aucun messages trouvés !")
        end
      else
        ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
      end
    end, target)
  elseif info == "calls" then
    TriggerServerCallback("hacker:getCalls",function(number, call, Time)
      if number ~= nil then
        ShowNotification("~g~Succès!~s~~n~Récupération de l'historique des appels à partir du numéro: ~b~"..number)
        if call ~= nil then
          local nbr = tostring(number)
          if numberH(nbr) == false then
            table.insert(numbers, nbr)
          end
          for i, v in pairs(call) do
            table.insert(calls, {number = nbr, sender = v.owner, receiver = v.num, time = Time[i], accept = v.accepts})
          end
        else
          ShowNotification("~r~Erreur!~s~~n~Historique d'appels vides !")
        end
      else
        ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
      end
    end, target)
  elseif info == "contacts" then
    TriggerServerCallback("hacker:getContacts",function(number, contact)
      if number ~= nil then
        ShowNotification("~g~Succès!~s~~n~Récupération des contacts à partir du numéro: ~b~"..number)
        if contact ~= nil then
          local nbr = tostring(number)
          if numberH(nbr) == false then
            table.insert(numbers, nbr)
          end
          for i, v in pairs(contact) do
            table.insert(contacts, {number = nbr, num = v.number, display = v.display})
          end
        else
          ShowNotification("~r~Erreur!~s~~n~Listes des contacts vides !")
        end
      else
        ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
      end
    end, target)
  elseif info == "clone" then
    TriggerServerCallback("hacker:clonePhone", function(tnumber, snumber)
      for k, v in pairs(Ora.Inventory:GetInventory()) do
        if k == "tel" then
          for i, u in ipairs(v) do
            if u.data.num == snumber then
              u.data.num = tnumber
              u.label = tostring(tnumber)
              ShowNotification("~g~Succès!~s~~n~Téléphone cloné, numéro : ~b~"..tnumber)
            end
          end     
        end
      end
    end, target)
  elseif info == "deleteAll" then
    TriggerServerCallback("hacker:deleteAll",function(number)
      if number ~= nil then
        ShowNotification("~g~Succès!~s~~n~Téléphone formaté, numéro : ~b~"..number)
      else
        ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
      end
    end, target)
  end
end

local function getTelInfo(target, info)
  local time = 0
  local timeFail = 10
  local player = LocalPlayer().Ped
  Citizen.CreateThread(function()
    while true do
      Wait(1000)
      local playerCoords = GetEntityCoords(player)
      local targetCoords = GetEntityCoords(target.ped)
      if distanceV(playerCoords, targetCoords) < 25.0 then
        if timeFail ~= 10 then
          ERemoveLoadingPrompt()
          timeFail = 10
        end
        time = time + 1
        ELoadingPrompt("Ne vous éloignez pas! - Temps restant : "..time.."/"..timeGetInfo)
        if time >= timeGetInfo then
          ERemoveLoadingPrompt()
          successInfo(info, target.id)
          break
        end
      else
        timeFail = timeFail - 1
        ELoadingPrompt("Vous êtes trop éloigné! - Temps restant : "..timeFail)
        if timeFail <= 0 then
          ERemoveLoadingPrompt()
          ShowNotification("~r~Echec!~s~~n~Vous vous êtes trop éloigné!")
          break
        end
      end
    end
  end)
end

function createHackerMenu()
  Citizen.CreateThread(function()
    local jobType = Ora.Identity.Job:GetName() == "hacker" and "job" or "orga"
    KeySettings:Add(
      "keyboard",
      jobType == "job" and "F6" or "F7",
      function()
        RageUI.Visible(RMenu:Get("hacker", "main"), true)
      end,
      "hackeur"
    )

    while (Ora.Identity.Job.ChangingJob == true or Ora.Identity.Orga.ChangingJob == true) do
      Wait(50)
    end

    while true do
      Wait(0)

      if (jobType == "job") then
        if (Ora.Identity.Job.ChangingJob == true) then KeySettings:Clear("keyboard", "F6", "hackeur") end
      elseif (jobType == "orga") then
        if (Ora.Identity.Orga.ChangingJob == true) then KeySettings:Clear("keyboard", "F7", "hackeur") end
      end

      if RageUI.Visible(RMenu:Get("hacker", "main")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Faux papiers", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "fake_id"))
          RageUI.Button("Interaction téléphone", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "tel"))
          RageUI.Button("Autres informations", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "infos"))
          RageUI.Button("Interaction véhicule", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "vehicle"))
          RageUI.List("Envoyer une alerte à", policeHackCall, policeIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
            policeIndex = Index
            if Selected then
              exports['Snoupinput']:ShowInput("Message", 255, nil, "", true, true)
              local text = exports['Snoupinput']:GetInput()
              if text ~= false and text ~= "" then
                local pos = GetBlipCoords(GetFirstBlipInfoId(8))
                TriggerServerEvent("call:makeCall", policeHackCall[policeIndex], pos, text)
              end
            end
          end)
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "fake_id")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Créer une fausse pièce d'identité", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "fake_identity"))
          RageUI.Button("Créer un faux permis de conduire", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "fake_license"))
          RageUI.Button("Créer une fausse carte grise", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "fake_registration"))
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "fake_identity")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Nom : ", nil, {RightLabel = i_lastName}, true, function(_, _, Selected)
            if Selected then
              i_lastName = KeyboardInput("Nom", "", 20)
            end
          end)
          RageUI.Button("Prénom : ", nil, {RightLabel = i_firstName}, true, function(_, _, Selected)
            if Selected then
              i_firstName = KeyboardInput("Prénom", "", 20)
            end
          end)
          RageUI.Button("Date de naissance : ", nil, {RightLabel = i_dBirth}, true, function(_, _, Selected)
            if Selected then
              i_dBirth = KeyboardInput("Date de naissance", "", 20)
            end
          end)
          RageUI.Button("Origine : ", nil, {RightLabel = i_origin}, true, function(_, _, Selected)
            if Selected then
              i_origin = KeyboardInput("Origine", "", 20)
            end
          end)
          RageUI.Button("Sexe : ", nil, {RightLabel = i_sex}, true, function(_, _, Selected)
            if Selected then
              i_sex = KeyboardInput("Sexe", "", 1)
            end
          end)
          RageUI.Button("Crée la pièce d'identité", nil, {Color = {BackgroundColor = { 0, 100, 0, 25 }}}, true, function(_, _, Selected)
            if Selected then
              local serial = math.random(111111111, 9999999999)
              local items = {name = "fake_identity", label = i_firstName.." "..i_lastName, data = {identity = {last_name = i_lastName, first_name = i_firstName, birth_date = i_dBirth, origine = i_origin, male = i_sex, serial = serial, face_picture = "N/A"}}}
              Ora.Inventory:AddItem(items)
              RageUI.GoBack()
              i_lastName, i_firstName, i_dBirth, i_origin, i_sex = nil, nil, nil, nil, nil
            end
          end)
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "fake_license")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Nom : ", nil, {RightLabel = l_lastName}, true, function(_, _, Selected)
            if Selected then
              l_lastName = KeyboardInput("Nom", "", 20)
            end
          end)
          RageUI.Button("Prénom : ", nil, {RightLabel = l_firstName}, true, function(_, _, Selected)
            if Selected then
              l_firstName = KeyboardInput("Prénom", "", 20)
            end
          end)
          RageUI.Button("Date de naissance : ", nil, {RightLabel = l_dBirth}, true, function(_, _, Selected)
            if Selected then
              l_dBirth = KeyboardInput("Date de naissance", "", 20)
            end
          end)
          RageUI.Button("Crée le permis de conduire", nil, {Color = {BackgroundColor = { 0, 100, 0, 25 }}}, true, function(_, _, Selected)
            if Selected then
              local serial = math.random(111111111, 9999999999)
              local items = {name = "fake-permis-conduire", label = l_firstName.." "..l_lastName, data = {points = 12, uid = "LS-" .. Random(99999999), identity = {last_name = l_lastName, first_name = l_firstName, birth_date = l_dBirth, serial = serial, face_picture = "N/A"}}}
              Ora.Inventory:AddItem(items)
              RageUI.GoBack()
              l_lastName, l_firstName, l_dBirth = nil, nil, nil
            end
          end)
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "fake_registration")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Plaque : ", nil, {RightLabel = c_plate}, true, function(_, _, Selected)
            if Selected then
              c_plate = KeyboardInput("Plaque d'immatriculation", "", 8)
            end
          end)
          RageUI.Button("Modèle : ", nil, {RightLabel = c_model}, true, function(_, _, Selected)
            if Selected then
              c_model = KeyboardInput("Modèle", "", 20)
            end
          end)
          RageUI.Button("Nom : ", nil, {RightLabel = c_lastName}, true, function(_, _, Selected)
            if Selected then
              c_lastName = KeyboardInput("Nom", "", 20)
            end
          end)
          RageUI.Button("Prénom : ", nil, {RightLabel = c_firstName}, true, function(_, _, Selected)
            if Selected then
              c_firstName = KeyboardInput("Prénom", "", 20)
            end
          end)
          RageUI.Button("Crée la carte grise", nil, {Color = {BackgroundColor = { 0, 100, 0, 25 }}}, true, function(_, _, Selected)
            if Selected then
              local items = {name = "fake_carte_grise", data = {plate = c_plate, model = c_model, identity = {last_name = c_lastName, first_name = c_firstName}}, label = plate}
              Ora.Inventory:AddItem(items)
              RageUI.GoBack()
              c_plate, c_model, c_lastName, c_firstName = nil, nil, nil, nil
            end
          end)
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "tel")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Intéraction joueurs proches", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "cl_player_tel"))
          RageUI.Button("Localiser un téléphone", nil, {}, true, function(_, _, Selected)
            if Selected then
              local number = KeyboardInput("Numéro de téléphone", "", 7)
              if number ~= nil and number ~= "" then
                phoneAnim()
                ELoadingPrompt("Détermination de la position en cours...")
                Wait(12000)
                ERemoveLoadingPrompt()
                TriggerServerCallback("hacker:getTelPos", function(id, ped, coords)
                  if id ~= nil then
                      local pPed = NetworkGetEntityFromNetworkId(ped)
                      local found = false
                      TriggerServerCallback("getInventoryOtherPPL", function(Inv, Money, black_money)
                          local inventory = json.decode(Inv)
                          for k, v in pairs(inventory["tel"]) do
                              if v.data.num == number then
                                  found = true
                                  SetNewWaypoint(coords.x, coords.y)
                                  ShowNotification("~g~Succès!~s~\nLe téléphone a été localisé!\n~b~Emplacement : ~s~"..GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z)))
                                  break
                              end
                          end
                          if found then
                              Citizen.CreateThread(function()
                                  local timing = 0
                                  Ora.Anticheat.Alert.BLIPS = false
                                  while pPed ~= nil do
                                      local blip = GetBlipFromEntity(pPed)
                                      if not DoesBlipExist(blip) then
                                          blip = AddBlipForEntity(pPed)
                                          SetBlipSprite(blip, 1)
                                          ShowHeadingIndicatorOnBlip(blip, true)
                                      end
                                      timing = timing + 1
                                      if timing >= 800 then
                                          pPed = nil
                                      end
                                      Wait(0)
                                  end
                                  Ora.Anticheat.Alert.BLIPS = true
                              end)
                          else
                              ShowNotification("~r~Erreur!~s~~n~Impossible de localiser le téléphone!")
                          end
                      end, id)
                  else
                      ShowNotification("~r~Erreur!~s~~n~Impossible de localiser le téléphone!")
                  end
                end, number)
              end
            end
          end)
          RageUI.Button("Informations récupérés", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "get_numbers"))
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "cl_player_tel")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          for k, v in ipairs(GetActivePlayers()) do
            if NetworkIsPlayerActive(v) and GetPlayerPed(v) ~= LocalPlayer().Ped then
              local ped = GetPlayerPed(v)
              local id = GetPlayerServerId(v)
              local pedCoords = GetEntityCoords(ped)
              if distanceV(LocalPlayer().Pos, pedCoords) < 20.0 then
                RageUI.Button("Individu n°"..k, nil, {}, true, function(_, A, Selected)
                  if A then
                    DrawMarker(0, pedCoords.x, pedCoords.y, pedCoords.z + 1.3, nil, nil, nil, nil, nil, nil, 0.5, 0.5, 0.5, 255, 0, 0, 100)
                  end
                  if Selected then
                    sPlayer = {ped = GetPlayerPed(v), id = id}
                  end
                end, RMenu:Get("hacker", "cl_player_tel_action"))
              end
            end
          end
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "cl_player_tel_action")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Récupérer le numéro de téléphone", nil, {}, true, function(_, _, Selected)
            if Selected then
              if not busyHacker then
                TriggerServerCallback("Ora::SE::Inventory:GetItemCount", function(count)
                  if count >= 1 then
                    timeGetInfo = 8
                    getTelInfo(sPlayer, "num")
                    RageUI.GoBack()
                    RageUI.Visible(RMenu:Get("hacker", "main"), false)
                    getInfoAnim()
                  else
                    ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
                  end
                end, "tel", sPlayer.id)
              end
            end
          end)
          RageUI.Button("Récupérer l'identité de la personne", nil, {}, true, function(_, _, Selected)
            if Selected then
              if not busyHacker then
                TriggerServerCallback("Ora::SE::Inventory:GetItemCount", function(count)
                  if count >= 1 then
                    timeGetInfo = 15
                    getTelInfo(sPlayer, "identity")
                    RageUI.GoBack()
                    RageUI.Visible(RMenu:Get("hacker", "main"), false)
                    getInfoAnim()
                  else
                    ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
                  end
                end, "tel", sPlayer.id)
              end
            end
          end)
          RageUI.Button("Récupérer les derniers messages", nil, {}, true, function(_, _, Selected)
            if Selected then
              if not busyHacker then
                TriggerServerCallback("Ora::SE::Inventory:GetItemCount", function(count)
                  if count >= 1 then
                    timeGetInfo = 20
                    getTelInfo(sPlayer, "message")
                    RageUI.GoBack()
                    RageUI.Visible(RMenu:Get("hacker", "main"), false)
                    getInfoAnim()
                  else
                    ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
                  end
                end, "tel", sPlayer.id)
              end
            end
          end)
          RageUI.Button("Récupérer l'historique des appels", nil, {}, true, function(_, _, Selected)
            if Selected then
              if not busyHacker then
                TriggerServerCallback("Ora::SE::Inventory:GetItemCount", function(count)
                  if count >= 1 then
                    timeGetInfo = 20
                    getTelInfo(sPlayer, "calls")
                    RageUI.GoBack()
                    RageUI.Visible(RMenu:Get("hacker", "main"), false)
                    getInfoAnim()
                  else
                    ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
                  end
                end, "tel", sPlayer.id)
              end
            end
          end)
          RageUI.Button("Récupérer la listes des contacts", nil, {}, true, function(_, _, Selected)
            if Selected then
              if not busyHacker then
                TriggerServerCallback("Ora::SE::Inventory:GetItemCount", function(count)
                  if count >= 1 then
                    timeGetInfo = 15
                    getTelInfo(sPlayer, "contacts")
                    RageUI.GoBack()
                    RageUI.Visible(RMenu:Get("hacker", "main"), false)
                    getInfoAnim()
                  else
                    ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
                  end
                end, "tel", sPlayer.id)
              end
            end
          end)
          RageUI.Button("Cloner le téléphone", nil, {}, true, function(_, _, Selected)
            if Selected then
              if not busyHacker then
                TriggerServerCallback("Ora::SE::Inventory:GetItemCount", function(count)
                  if count >= 1 then
                    timeGetInfo = 60
                    getTelInfo(sPlayer, "clone")
                    RageUI.GoBack()
                    RageUI.Visible(RMenu:Get("hacker", "main"), false)
                    getInfoAnim()
                  else
                    ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
                  end
                end, "tel", sPlayer.id)
              end
            end
          end)
          RageUI.Button("Formater le téléphone", nil, {}, true, function(_, _, Selected)
            if Selected then
              if not busyHacker then
                TriggerServerCallback("Ora::SE::Inventory:GetItemCount", function(count)
                  if count >= 1 then
                    timeGetInfo = 90
                    getTelInfo(sPlayer, "deleteAll")
                    RageUI.GoBack()
                    RageUI.Visible(RMenu:Get("hacker", "main"), false)
                    getInfoAnim()
                  else
                    ShowNotification("~r~Erreur!~s~~n~Le téléphone n'est pas allumé !")
                  end
                end, "tel", sPlayer.id)
              end
            end
          end)
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "get_numbers")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          for k, v in pairs(numbers) do
            RageUI.Button(v, nil, {}, true, function(_, _, Selected)
              sNumber = v
            end, RMenu:Get("hacker", "get_number_infos"))
          end
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "get_number_infos")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Messages", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "get_number_messages"))
          RageUI.Button("Appels", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "get_number_calls"))
          RageUI.Button("Contacts", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "get_number_contacts"))
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "get_number_messages")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          for k, v in pairs(messages) do
            if sNumber == v.number then
              local desc = "~b~Expéditeur : ~s~"..v.sender.."~n~~b~Destinataire : ~s~"..v.receiver.."~n~~b~Message : ~s~"..v.message
              RageUI.Button("Date : "..v.time, desc, {}, true, function(_, _, Selected)
              end)
            end
          end
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "get_number_calls")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          for k, v in pairs(calls) do
            if sNumber == v.number then
              local desc = "~b~Origine : ~s~"..v.sender.."~n~~b~Destinataire : ~s~"..v.receiver.."~n~~b~Acceptés : ~s~"..v.accept
              RageUI.Button("Date : "..v.time, desc, {}, true, function(_, _, Selected)
              end)
            end
          end
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "get_number_contacts")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          for k, v in pairs(contacts) do
            if sNumber == v.number then
              RageUI.Button(v.display, nil, {RightLabel = v.num}, true, function(_, _, Selected)
              end)
            end
          end
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "infos")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Trouver une propriété", "Trouver une propriété avec le prénom et le nom de la personne", {}, true, function(_, _, Selected)
            if Selected then
              local first_name = KeyboardInput("Prénom", "", 20)
              local last_name = KeyboardInput("Nom", "", 20)
              if first_name ~= nil and first_name ~= "" and last_name ~= nil and last_name ~= "" then
                phoneAnim()
                ELoadingPrompt("Recherche en cours...")
                Wait(17000)
                ERemoveLoadingPrompt()
                TriggerServerCallback("hacker:getApartment", function(appart)
                  if appart ~= nil then
                    if playersH(first_name, last_name) == false then
                      table.insert(infoPlayers, {firstName = first_name, lastName = last_name})
                    end 
                    for k, v in pairs(appart) do
                      table.insert(apparts, {name = v.name, firstName = first_name, lastName = last_name})
                    end
                    ShowNotification("~g~Succès!~s~~n~Une ou plusieurs propriétés a été trouvés!")
                  else
                    ShowNotification("~r~Erreur!~s~~n~Aucune propriété trouvé!")
                  end
                end, first_name, last_name)
              else
                ShowNotification("~r~Erreur!~s~~n~Informations erronés!")
              end
            end
          end)
          RageUI.Button("Trouver le propiétaire avec la plaque", "", {}, true, function(_, _, Selected)
            if Selected then
              local plate = KeyboardInput("Plaque d'immatriculation", "", 8)
              if plate ~= nil and plate ~= ""  then
                phoneAnim()
                ELoadingPrompt("Recherche en cours...")
                Wait(12000)
                ERemoveLoadingPrompt()
                TriggerServerCallback("hacker:getVehiclesOwner", function(name, vlabel)
                  if name ~= nil then
                    for k, v in pairs(name) do
                      if playersH(v.first_name, v.last_name) == false then
                        table.insert(infoPlayers, {firstName = v.first_name, lastName = v.last_name})
                      end
                      table.insert(vehicles, {plate = plate, label = vlabel, firstName = v.first_name, lastName = v.last_name})
                    end
                    ShowNotification("~g~Succès!~s~~n~Le propriétaire du véhicule immatriculé "..plate.." a été trouvé.")
                  else
                    ShowNotification("~r~Erreur!~s~~n~Aucun propriétaire trouvé!")
                  end
                end, plate)
              else
                ShowNotification("~r~Erreur!~s~~n~Informations erronés!")
              end
            end
          end)
          RageUI.Button("Trouver les véhicules d'un individu", "", {}, true, function(_, _, Selected)
            if Selected then
              local first_name = KeyboardInput("Prénom", "", 20)
              local last_name = KeyboardInput("Nom", "", 20)
              if first_name ~= nil and first_name ~= "" and last_name ~= nil and last_name ~= "" then
                phoneAnim()
                ELoadingPrompt("Recherche en cours...")
                Wait(17000)
                ERemoveLoadingPrompt()
                TriggerServerCallback("hacker:getVehicles", function(vehicle)
                  if vehicles ~= nil then
                    if playersH(first_name, last_name) == false then
                      table.insert(infoPlayers, {firstName = first_name, lastName = last_name})
                    end
                    for k, v in pairs(vehicle) do
                      table.insert(vehicles, {plate = v.plate, label = v.label, firstName = first_name, lastName = last_name})
                    end
                    ShowNotification("~g~Succès!~s~~n~Véhicule(s) trouvé(s)")
                  else
                    ShowNotification("~r~Erreur!~s~~n~Aucun véhicules trouvés!")
                  end
                end, first_name, last_name)
              else
                ShowNotification("~r~Erreur!~s~~n~Informations erronés!")
              end
            end
          end)
          RageUI.Button("Informations récupérés", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "players"))
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "players")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          for k, v in pairs(infoPlayers) do
            RageUI.Button(v.firstName.." "..v.lastName, nil, {}, true, function(_, _, Selected)
              sPlayer = v.firstName
            end, RMenu:Get("hacker", "players_infos"))
          end
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "players_infos")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Propriétés", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "players_apartment_infos"))
          RageUI.Button("Véhicules", nil, {}, true, function(_, _, Selected)
          end, RMenu:Get("hacker", "players_vehicles_infos"))
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "players_apartment_infos")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          for k, v in pairs(apparts) do
            if sPlayer == v.firstName then
              RageUI.Button(v.name, nil, {}, true, function(_, _, Selected)
              end)
            end
          end
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "players_vehicles_infos")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          for k, v in pairs(vehicles) do
            if sPlayer == v.firstName then
              RageUI.Button(v.label, nil, {RightLabel = v.plate}, true, function(_, _, Selected)
              end)
            end
          end
        end)
      end

      if RageUI.Visible(RMenu:Get("hacker", "vehicle")) then
        RageUI.DrawContent({header = true, glare = true}, function()
          RageUI.Button("Localiser un véhicule", nil, {}, true, function(_, _, Selected)
            if Selected then
              local plaque = KeyboardInput("Plaque d'immatriculation", "", 8)
              if plaque ~= nil and plaque ~= "" then
                phoneAnim()
                ELoadingPrompt("Détermination de la position en cours...")
                Wait(17000)
                ERemoveLoadingPrompt()
                TriggerServerCallback("hacker:getVehiclePos", function(veh, pos)
                  if pos ~= nil then
                    SetNewWaypoint(pos.x, pos.y)
                    ShowNotification("~g~Succès!~s~~n~Véhicule localisé, point gps mis en place!")
                  else
                    ShowNotification("~r~Erreur!~s~~n~Impossible de localiser le véhicule !")
                  end
                end, plaque)
              end
            end
          end)
          RageUI.Button("Dévérouillage centralisé", nil, {}, true, function(_, _, Selected)
            if Selected then
              local veh = ClosestVeh()
              if veh ~= 0 then
                phoneAnim()
                Wait(1500)
                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleDoorsLocked(veh, 1)
                SetVehicleDoorsLockedForPlayer(veh, false)
                SetVehicleDoorsLockedForAllPlayers(veh, false)
                RageUI.Popup({message = "~g~Véhicule déverouillé"})   
              end
            end
          end)
        end)
      end
    end
  end)
end