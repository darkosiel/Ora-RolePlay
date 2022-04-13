ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local menu = {
    {x = 823.18, y = -885.25, z= 25.34}    
}  

local rapport = false
local accrocher = false


---<MENU>---

local open = false
local LBanc = RageUI.CreateMenu("Rapport de puissance","...")
local LPerf = RageUI.CreateSubMenu(LBanc, "Banc de puissance", "Choisissez...")
LBanc.Display.Header = true 
LBanc.Closed = function()
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
                            PlaySoundFrontend(-1, "On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true)
                            ESX.ShowNotification("Poussez le véhicule a son maximum sans le faire chauffer au dela de 105° ! ~n~ Au boulot !")
                            Wait(20000)
                            local rpm = GetVehicleCurrentRpm(GetVehiclePedIsIn(GetPlayerPed(-1), false))
                            if rpm <= 0.23 then 
                                PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                                ESX.ShowNotification("C'est pas en laissant le véhicule a l'arret sur le banc qu'ont vas savoir quel est sa puissance !")
                                SetVehicleBurnout(vehicle, false)
                                rapport = false
                                accrocher = false
                                RageUI.CloseAll()
                            else
                                rapport = true
                                PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                                ESX.ShowNotification("Le banc de puissance a rendu son verdict ! ~n~ Allez voir !")
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
                    RageUI.Button('⚙️ Améliorez les performances', "Améliore le moteur -> ~r~ Nv 2 ~n~~s~Améliore les freins -> ~r~ Nv 2 ~n~~s~Améliore la transmission -> ~r~ Nv 2 ~n~~s~Installe un turbo", {RightLabel = "~h~>>"}, true, {
                        onSelected = function()
                            rapport = false
                        Wait(1000)
                            local plyVeh = GetVehiclePedIsUsing(PlayerPedId())
                            local vehicleProps = ESX.Game.GetVehicleProperties(plyVeh)
                            vehicleProps.modEngine = 2
                            vehicleProps.modBrakes = 2
                            vehicleProps.modTransmission = 2
                            vehicleProps.modTurbo = true
                            ESX.Game.SetVehicleProperties(plyVeh, vehicleProps)
                            ESX.ShowNotification("Le véhicule vient d'etre mit ~r~stage 2~s~. ~n~Passez le au banc pour constater l'amélioration")
                        end
                    }, upgradeMenu) 
                end
                if rapport == true then
                    RageUI.Button('📋 Rapport de puissance', nil, {RightLabel = "~h~>>"}, true, {
                        onSelected = function()
                            Citizen.CreateThread(function()
                                while rapport do
                                    local accel = GetVehicleAcceleration(GetVehiclePedIsIn(GetPlayerPed(-1), false))
                                    local maxspeed = GetVehicleEstimatedMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
                                    local couple = GetVehicleAcceleration(GetVehiclePedIsIn(GetPlayerPed(-1), false))
                                    local LiseretColor = {255, 255, 255}
                                    local baseX = 0.85 -- gauche / droite ( plus grand = droite )
                                    local baseY = 0.45 -- Hauteur ( Plus petit = plus haut )
                                    local baseWidth = 0.20 -- Longueur
                                    local baseHeight = 0.03 -- Epaisseur
                                    DrawRect(baseX, baseY - 0.017, baseWidth, baseHeight - 0.025, LiseretColor[1], LiseretColor[2], LiseretColor[3], 255) -- Liseret
                                    DrawRect(baseX, baseY, baseWidth, baseHeight, 28, 28, 28, 170) -- Bannière
                                    DrawTexts(baseX, baseY - 0.013, "💻 Rapport de puissance 💻", true, 0.35, {255, 255, 255, 255}, 6, 0) -- title
                                    DrawRect(baseX, baseY + (0.018 * 2), baseWidth, baseHeight, 28, 28, 28, 180)
                                    DrawTexts(baseX, baseY + (0.018 * 2) - 0.013, "💨 Puissance Maximale Théorique : " ..accel * Config.perf.accel .. " Ch 💨", true, 0.35, {255, 255, 255, 255}, 6, 0) -- Delete Entité
                                    DrawRect(baseX, baseY + (0.024 * 3), baseWidth, baseHeight, 28, 28, 28, 180)
                                    DrawTexts(baseX, baseY + (0.024 * 3) - 0.013, "⏲ Vitesse Maximale Théorique : " ..maxspeed * Config.perf.maxspeed .. " Km/h ⏲", true, 0.35, {255, 255, 255, 255}, 6, 0) -- level
                                    DrawRect(baseX, baseY + (0.026 * 4), baseWidth, baseHeight, 28, 28, 28, 180)
                                    DrawTexts(baseX, baseY + (0.026 * 4) - 0.013, "☄️ Couple Maximale Théorique : " ..couple  * Config.perf.couple .. " Nm ☄️", true, 0.35, {255, 255, 255, 255}, 6, 0) -- level
                                    Wait(0)
                                end
                            end)
                        end
                    })
                end
			end)

            local rpm = GetVehicleCurrentRpm(GetVehiclePedIsIn(GetPlayerPed(-1), false))
            local temp = GetVehicleEngineTemperature(GetVehiclePedIsIn(GetPlayerPed(-1), false))
            local turbo = GetVehicleTurboPressure(GetVehiclePedIsIn(GetPlayerPed(-1), false))

			RageUI.IsVisible(LPerf, function()
                RageUI.Separator("↓↓ Compteur : ↓↓")                
                RageUI.Button("|  ~r~" ..rpm * 10000 .. " ~s~| Tour/Minute |" , nil, {}, true, {onSelected = function()end})
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


function DrawTexts(x, y, text, center, scale, rgb, font, justify)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(rgb[1], rgb[2], rgb[3], rgb[4])
    SetTextEntry("STRING")
    SetTextCentre(center)
    AddTextComponentString(text)
    EndTextCommandDisplayText(x,y)
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
                ESX.ShowHelpNotification("Appuyez sur ~b~E~w~ pour passez le véhicule au banc")
                if IsControlJustPressed(1,51) then
                    PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS", true)
                    DoScreenFadeIn(1000) -- Ecran Noir
                    Visual.Subtitle('~h~~r~Mise en place du véhicule sur le banc...', 8100)
                    DoScreenFadeOut(3000)  -- Ecran Noir
                    Citizen.Wait(3000)
                    DoScreenFadeIn(1000) -- Ecran Noir
                    SetEntityCoords(vehicle, 823.18, -885.25, 25.34, true, true, true, false)
                    SetEntityHeading(vehicle, 178.9)
                    OpenLBanc()
                end  
                end
            end
        end
    end
end)
    

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
            Draw3DText(v1.x,v1.y,v1.z, "Garer le véhicule ~r~en marche arrière !")
        end
    end
end)
