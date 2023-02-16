local Elevator = {
  --Exemple
  --[[ ["FBI"] = {
    {label = "Etage 1", pos = vector3(-76.333, -2398.854, 5.10), msg = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu"},
    {label = "Etage 2", pos = vector3(-64.891, -2398.482, 5.10), msg = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu2"},
  } ]]

  ["FBI"] = {
    {label = "Etage 1", pos = vector3(2497.13, -349.51, 94.09), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage 3 (vestiaires)", pos = vector3(2497.13, -349.51, 101.89), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage 4 (Cellules)", pos = vector3(2497.13, -349.51, 105.69), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
  },

  ["FIB"] = {
    {label = "Etage 1", pos = vector3(2504.50, -342.08, 94.09), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage 2 (salle de presse)", pos = vector3(2504.29, -433.31, 99.11), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage 4 (bureaux)", pos = vector3(2504.38, -433.23, 106.91), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},

  },

  -- ["AGENCE IMMO"] = {
  --   {label = "Parking", pos = vector3(-1537.28, -577.91, 25.71), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
  --   {label = "Agence", pos = vector3(-1581.25, -562.07, 108.52), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    
  -- },

  -- ["UNICORN"] = {
  --   {label = "", pos = vector3(133.06, -1293.65, 28.0), msg = "Appuyez sur ~INPUT_CONTEXT~ pour aller derrière le bar"},
  --   {label = "", pos = vector3(132.5, -1287.54, 28.0), msg = "Appuyez sur ~INPUT_CONTEXT~ pour retourner dans la salle"},
    
  -- },

  ["SALLE CRISE"] = {
    {label = "", pos = vector3(-1042.672, -828.539, 10.8801-0.99), msg = "Appuyez sur ~INPUT_CONTEXT~ pour descendre."},
    {label = "", pos = vector3(2154.83, 2920.93, -62.9), msg = "Appuyez sur ~INPUT_CONTEXT~ pour remonter."},  
  },
  
  ["Ascenseur"] = {
    {label = "1", pos = vector3(4981.21, -5709.86, 19.88), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "2", pos = vector3(4990.48, -5717.98, 19.88), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
  },
  ["Los Santos Event"] = {
    {label = "Hall Principal", pos = vector3(-285.104, -1942.060, 30.147), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Bar", pos = vector3(-285.193, -1942.914, 42.047), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
  },

--[[  ["ascenseur"] = {
    {label = "Départ", pos = vector3(-144.33, -576.54, 32.42), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Arrivé", pos = vector3(-133.92,  -586.76, 201.73), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
  },]]

  ["Cafe Coretto"] = {
    {label = "Rez-de-chaussé", pos = vector3(-1192.0448, -1399.7055, 4.4924), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage", pos = vector3(-1192.1966,  -1399.4130, 10.5240), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
  },

  ["HOPITAL"] = {
    {label = "Etage 8 - Admin", pos = vector3(-1829.09, -336.67, 84.06), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage 2", pos = vector3(-1835.31, -339.11, 58.15), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage 1", pos = vector3(-1839.63, -335.05, 53.78), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Lobby", pos = vector3(-1843.41, -342.00, 49.45), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Parking - IRM - Radio", pos = vector3(-1848.86, -340.71, 41.24), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Morgue", pos = vector3(246.82, -1372.16, 23.60), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
  },

  ["LSPD"] = {
    {label = "Etage  6 - Hélipad", pos = vector3(-1096.15, -850.35, 37.24), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage  5 - Bureaux", pos = vector3(-1096.15, -850.35, 33.36), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage  4 - Opérations", pos = vector3(-1096.15, -850.35, 29.75), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage  3 - Dispatch-Gym", pos = vector3(-1096.15, -850.35, 25.82), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage  2 - Restauration", pos = vector3(-1096.15, -850.35, 22.03), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage  1 - Entrée principal", pos = vector3(-1096.15, -850.35, 18.00), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage -3 - Armurerie-SWAT", pos = vector3(-1096.15, -850.35, 12.68), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage -2 - Laboratoire-Saisies", pos = vector3(-1096.15, -850.35, 9.27), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage -1 - Garages-Cellules", pos = vector3(-1096.15, -850.35, 3.88), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    
  },

  ["LSPD2"] = {
    {label = "Etage  3 - Dispatch-Gym", pos = vector3(-1066.27, -833.69, 26.03), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage  1 - Entrée principal", pos = vector3(-1066.27, -833.69, 18.03), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage -3 - Armurerie-SWAT", pos = vector3(-1066.27, -833.69, 13.88), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage -2 - Laboratoire-Saisies", pos = vector3(-1066.27, -833.69, 10.04), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage -1 - Garages-Cellules", pos = vector3(-1066.27, -833.69, 4.48), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    
  },

  ["Gouvernement"] = {
    {label = "Etage  5 - Hélipad", pos = vector3(-1320.90, -567.29, 42.07), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage  3 - Bureaux", pos = vector3(-1309.52, -563.62, 37.37), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage  2 - USSS-Bureaux", pos = vector3(-1309.52, -563.62, 34.37), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage  1 - Accueil", pos = vector3(-1309.52, -563.62, 30.57), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage -1 - Garages", pos = vector3(-1309.52, -559.15, 20.80), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    
  },
  ["Gouvernement2"] = {
    {label = "Etage  4 - Salle privée", pos = vector3(-1309.02, -563.80, 41.18), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    {label = "Etage -1 - Garages", pos = vector3(-1307.45, -557.41, 20.80), msg = "Appuyez sur ~INPUT_CONTEXT~ prendre l'ascenseur"},
    
  },

  ["HOTEL"] = {
    {label = "Terrasse", pos = vector3(-98.189, 367.36, 112.27), msg = "Appuyez sur ~INPUT_CONTEXT~ pour monter"},
    {label = "Jardin", pos = vector3(-84.19, 326.49, 141.59), msg = "Appuyez sur ~INPUT_CONTEXT~ pour descendre"},
    
  },

  ["PSY"] = {
    {label = "", pos = vector3(-996.81, 518.09, 82.77), msg = "Appuyez sur ~INPUT_CONTEXT~ pour entrer."},
    {label = "", pos = vector3(-1902.34, -572.51, 18.1), msg = "Appuyez sur ~INPUT_CONTEXT~ pour sortir."},
    
  },

  ["HOTEL2"] = {
    {label = "Terrasse", pos = vector3(-1384.70, -976.10, 8.93), msg = "Appuyez sur ~INPUT_CONTEXT~ pour monter."},
    {label = "Sortie", pos = vector3(-1403.86, -979.68, 19.38), msg = "Appuyez sur ~INPUT_CONTEXT~ pour descendre."},
  },

  ["Luxuary"] = {
    {label = "Terrasse", pos = vector3(-843.84, -236.18, 61.01), msg = "Appuyez sur ~INPUT_CONTEXT~ pour descendre."},
    {label = "Sortie", pos = vector3(-841.74, -229.56, 37.24), msg = "Appuyez sur ~INPUT_CONTEXT~ pour monter."},
  },

--[[  ["MADRAZO"] = {
    {label = "Entrée", pos = vector3(1393.91, 1141.72, 114.47), msg = "Appuyez sur ~INPUT_CONTEXT~ pour entrer."},
    {label = "Sortie", pos = vector3(1396.52, 1141.75, 114.33), msg = "Appuyez sur ~INPUT_CONTEXT~ pour sortir."},
  },

  ["MADRAZO2"] = {
    {label = "Sortie", pos = vector3(1408.26, 1147.39, 114.33), msg = "Appuyez sur ~INPUT_CONTEXT~ pour sortir."},
    {label = "Entrée", pos = vector3(1410.99, 1147.39, 114.33), msg = "Appuyez sur ~INPUT_CONTEXT~ pour entrer."},
  },]]

  ["BLANCHISSEMENT"] = {
    {label = "Entrée", pos = vector3(639.48, 2772.1, 42.04), msg = "Appuyez sur ~INPUT_CONTEXT~ pour entrer."},
    {label = "Sortie", pos = vector3(1118.81, -3193.46, -40.39), msg = "Appuyez sur ~INPUT_CONTEXT~ pour sortir."},
  },

}

local elevator, lpos, msg, menu, tp
local canOpen = false

RMenu.Add("elevator", "main", RageUI.CreateMenu("Ascenseur", "Actions disponibles", 10, 100))

local function Interact(msg)
  if not IsHelpMessageOnScreen() then
    SetTextComponentFormat('STRING')
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  end
end
  
local function canTeleport()
  local ped = PlayerPedId()
  local pedCoords = GetEntityCoords(ped)

  if lpos == nil then
    for k, v in pairs(Elevator) do
      for t, u in ipairs(v) do 
        local dist = #(pedCoords - u.pos)
        if dist < 1.50 then
          elevator = v
          lpos = u.pos
          msg = u.msg
          canOpen = true
          if #v > 2 then
            menu = true
          else
            menu = false
            if t == 1 then
              tp = 2
            else
              tp = 1
            end
          end
          return
        else
          canOpen = false
        end
      end
    end
  else
    if #(pedCoords - lpos) > 2.0 then
      canOpen = false
      lpos = nil
    end
  end
end
  
Citizen.CreateThread(function()
  while true do
    local wait = 1000
    canTeleport()
    if canOpen and RageUI.CurrentMenu == nil then
      if menu == true then
        Interact(msg)
        if IsControlJustPressed(1, 38) then
          RageUI.Visible(RMenu:Get("elevator", "main"), true)
        end
      else
        Interact(msg)
        if IsControlJustPressed(1, 38) then
          DoScreenFadeOut(500)
          Wait(500)
          DoScreenFadeIn(500)
          SetEntityCoords(PlayerPedId(), elevator[tp].pos)
        end
      end
      wait = 0
    end
    Wait(wait)
  end
end)
  
Citizen.CreateThread(function()
  while true do
    local wait = 1000
    if RageUI.Visible(RMenu:Get("elevator", "main")) then
      RageUI.DrawContent({header = true, glare = false}, function()
        for k, v in ipairs(elevator) do
          RageUI.Button(v.label, nil, {}, true, function(_, _, S)
            if S then
              DoScreenFadeOut(500)
              Wait(500)
              DoScreenFadeIn(500)
              SetEntityCoords(PlayerPedId(), v.pos)
            end
          end)
        end
      end)
      wait = 0
    end
    Wait(wait)
  end
end)