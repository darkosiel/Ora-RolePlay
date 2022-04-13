
---<MENU BANC>---

local menu = {
    {x = 819.9, y = -918.64, z= 25.76}
} 
function showHelpNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(1, 0)
end

function ShowNotification(message)
    message = message.."."
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

local rapport = false
local accrocher = false

local open = false
local LBanc = RageUI.CreateMenu("Banc de puissance", "Choisissez...")
local LPerf = RageUI.CreateSubMenu(LBanc, "Banc de puissance", "Choisissez...")
LBanc.Display.Header = true 
LBanc:DisplayPageCounter(false)
LBanc.Closed = function()
    RageUI.Visible(LBanc, false)
    open = false
end

function OpenLBanc()
    if open then 
        open = false 
        RageUI.Visible(LBanc,false)
        return
    else
        open = true 
        RageUI.Visible(LBanc, true)
        Citizen.CreateThread(function ()
        while open do 
            RageUI.IsVisible(LBanc, function()
                if accrocher == false then
                    RageUI.Button('🔒 Attacher le véhicule au banc', false , {RightLabel = "~h~>>"} , true , {
                        onSelected = function()
                            PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", true)
                            local playerPed = PlayerPedId()
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            SetVehicleBurnout(vehicle, true)
                            accrocher = true
                        end
                    })
                elseif accrocher == true then
                    RageUI.Button('🎚 Passer au banc', false , {RightLabel = "~h~>>"} , true , {
                        onSelected = function()
                            local temp = GetVehicleEngineTemperature(GetVehiclePedIsIn(GetPlayerPed(-1), false))
                            PlaySoundFrontend(-1, "On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true)
                            ShowNotification("Poussez le véhicule a son maximum sans le faire chauffer au dela de 105° ! ~n~ Au boulot !")
                            if temp > 105 then     
                                SetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1), false), -3000)
                            end
                            Wait(15000)
                            local rpm = GetVehicleCurrentRpm(GetVehiclePedIsIn(GetPlayerPed(-1), false))
                            if rpm <= 0.23 then 
                                PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                                ShowNotification("C'est pas en laissant le véhicule à l'arret sur le banc qu'on vas savoir quel sont ses performances!")
                                SetVehicleBurnout(vehicle, false)
                                rapport = false
                                accrocher = false
                                RageUI.CloseAll()
                            else
                                rapport = true
                                RageUI.CloseAll()
                                PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                                ShowNotification("Le banc de puissance a rendu son verdict ! ~n~ Allez voir !")
                            end
                        end
                    }, LPerf)
                    RageUI.Button('🔓 Décrochez le véhicule du banc', false , {RightLabel = "~h~>>"} , true , {
                        onSelected = function()
                            PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", true)
                            local playerPed = PlayerPedId()
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            SetVehicleBurnout(vehicle, false)
                            rapport = false
                            accrocher = false
                            RageUI.CloseAll()
                        end
                    })
                end
			end)
            
            local rpm = GetVehicleCurrentRpm(GetVehiclePedIsIn(GetPlayerPed(-1), false))
            local temp = GetVehicleEngineTemperature(GetVehiclePedIsIn(GetPlayerPed(-1), false))
            local turbo = GetVehicleTurboPressure(GetVehiclePedIsIn(GetPlayerPed(-1), false))

			RageUI.IsVisible(LPerf, function()
                RageUI.Separator("↓↓ Compteur : ↓↓")                
                RageUI.Button("|  ~r~" ..rpm * 8000 .. " ~s~| Tour/Minute |" , nil, {}, true, {onSelected = function()end})
                RageUI.Separator("↓↓ Temperature : ↓↓")                
                RageUI.Button("| ~r~"..temp.. "~s~ | ° |" , nil, {}, true, {onSelected = function()end})
                RageUI.Separator("↓↓ Pression Turbo : ↓↓")                
                RageUI.Button("|  ~r~" ..turbo.. "~s~| Bar |" , nil, {}, true, {onSelected = function()end})

			end)
            Wait(0)
		end
	 end)
  end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(menu) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, menu[k].x, menu[k].y, menu[k].z)
            if dist <= 2.0 then
                    local playerPed = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    if IsPedInAnyVehicle(playerPed) then
                    showHelpNotification("Appuyez sur ~b~E~w~ pour passez le véhicule au banc")
                    if IsControlJustPressed(1,51) then
                        PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS", true)
                        DoScreenFadeIn(1000) -- Ecran Noir
                        Visual.Subtitle('~h~~r~Mise en place du véhicule sur le banc...', 8100)
                        DoScreenFadeOut(3000)  -- Ecran Noir
                        Citizen.Wait(3000)
                        DoScreenFadeIn(1000) -- Ecran Noir
                        SetEntityCoords(vehicle, 819.9, -918.64, 25.76, true, true, true, false)
                        SetEntityHeading(vehicle, 178.9)
                        OpenLBanc()
                    end  
                    end
            end
        end
    end
end)

---<MENU RAPPORT>---

local banc = {
    {x = 835.8, y = -921.55, z= 26.04}    
} 

local open = false
local LRapport = RageUI.CreateMenu("Rapport du Banc","Choisissez")
LRapport.Display.Header = true 
LRapport.Closed = function()
  open = false
end

function OpenLRapport()
    if open then 
        open = false 
        RageUI.Visible(LRapport,false)
        return
    else
        open = true 
        RageUI.Visible(LRapport, true)
        Citizen.CreateThread(function ()
        while open do 
            RageUI.IsVisible(LRapport, function()
                if rapport == true then
                    -------------------------------------------------------
                    local playerPed = PlayerPedId()
                    local vehicle = GetLastDrivenVehicle(playerPed, false)
                    -------------------------------------------------------
                    local accel = GetVehicleAcceleration(GetLastDrivenVehicle(GetPlayerPed(-1), false))
                    local couple = GetVehicleAcceleration(GetLastDrivenVehicle(GetPlayerPed(-1), false))
                    local maxspeed = GetVehicleEstimatedMaxSpeed(GetLastDrivenVehicle(GetPlayerPed(-1), false))
                    local plaque = GetVehicleNumberPlateText(GetLastDrivenVehicle(GetPlayerPed(-1), false))
                    -------------------------------------------------------
                    RageUI.Button('📋 Rapport de ~h~~r~' ..plaque, nil, {RightLabel = "~h~>>"}, true, {
                        onSelected = function()
                            PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", true)
                            Citizen.CreateThread(function()
                                while rapport do
                                    local LiseretColor = {255, 255, 255}
                                    local baseX = 0.85 -- gauche / droite ( plus grand = droite )
                                    local baseY = 0.45 -- Hauteur ( Plus petit = plus haut )
                                    local baseWidth = 0.20 -- Longueur
                                    local baseHeight = 0.03 -- Epaisseur
                                    DrawRect(baseX, baseY - 0.017, baseWidth, baseHeight - 0.025, LiseretColor[1], LiseretColor[2], LiseretColor[3], 255) -- Liseret
                                    DrawRect(baseX, baseY, baseWidth, baseHeight, 28, 28, 28, 170) -- Bannière
                                    DrawTexts(baseX, baseY - 0.013, "💻 Rapport de puissance 💻", true, 0.35, {255, 255, 255, 255}, 6, 0) -- title
                                    DrawRect(baseX, baseY + (0.018 * 2), baseWidth, baseHeight, 28, 28, 28, 180)
                                    DrawTexts(baseX, baseY + (0.018 * 2) - 0.013, "💨 Puissance Maximale Théorique : " ..accel * Config.perf.accel .. " Ch 💨", true, 0.35, {255, 255, 255, 255}, 6, 0)
                                    DrawRect(baseX, baseY + (0.024 * 3), baseWidth, baseHeight, 28, 28, 28, 180)
                                    DrawTexts(baseX, baseY + (0.026 * 3) - 0.013, "⏲ Vitesse Maximale Théorique : " ..maxspeed * Config.perf.maxspeed .. " Km/h ⏲", true, 0.35, {255, 255, 255, 255}, 6, 0)
                                    DrawRect(baseX, baseY + (0.028 * 4), baseWidth, baseHeight, 28, 28, 28, 180)
                                    DrawTexts(baseX, baseY + (0.030 * 4) - 0.013, "☄️ Couple Maximale Théorique : " ..couple * Config.perf.couple .. " Nm ☄️", true, 0.35, {255, 255, 255, 255}, 6, 0) 
                                    DrawRect(baseX, baseY + (0.032 * 4), baseWidth, baseHeight, 28, 28, 28, 180)
                                    Wait(0)
                                end
                            end)
                        end
                    })
                    RageUI.Button('💻 Eteindre l\'ordinateur ', nil, {RightLabel = "~h~>>"}, true, {
                        onSelected = function()
                            rapport = false
                            PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", true)
                            RageUI.CloseAll()
                        end
                    })
                else 
                    RageUI.Separator("~h~Aucun véhicule passer au banc")
                end
            end)
            Wait(0)
		end
	 end)
  end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(banc) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, banc[k].x, banc[k].y, banc[k].z)
            if dist <= 4.0 then
                DrawMarker(22, 826.75, -880.66, 25.25, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 0, 81, 255 , 255, true, true, p19, true)  
                if dist <= 1.0 then
        
                        showHelpNotification("Appuyez sur ~b~E~w~ pour regarder le résultat du banc")
                            if IsControlJustPressed(1,51) then
                                PlaySoundFrontend(-1, "Start", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true)
                                DoScreenFadeIn(1000) -- Ecran Noir
                                Visual.Subtitle('~h~~r~Chargement en cours des données du banc...', 8100)
                                DoScreenFadeOut(3000)  -- Ecran Noir
                                Citizen.Wait(3000)
                                DoScreenFadeIn(1000) -- Ecran Noir
                                OpenLRapport()
                            end 
                        elseif dist >= 1.5 then
                            RageUI.CloseAll(OpenLRapport)
                        end 
            end
        end
    end
end)

function DrawTexts(x, y, text, center, scale, rgb, font, justify)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(rgb[1], rgb[2], rgb[3], rgb[4])
    SetTextEntry("STRING")
    SetTextCentre(center)
    AddTextComponentString(text)
    EndTextCommandDisplayText(x,y)
end

function draw2dText(text, pos)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(table.unpack(pos))
end

local v1 = vector3(823.18, -885.25, 25.84)
function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local distance = 30

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < distance then
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if IsPedInAnyVehicle(playerPed) and accrocher == false then
                Draw3DText(v1.x,v1.y,v1.z, "Garer le véhicule ~r~en marche arrière !")
            end
        end
    end
end)
