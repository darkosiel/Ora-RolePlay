local display = false

Citizen.CreateThread(function()
    Citizen.Wait(500)
    GetPhoneSettings()
end)

Citizen.CreateThread(function()
    Citizen.Wait(500)
    while true do
        Citizen.Wait(0)
        if not display then
            if IsControlPressed(1, 288) then
                SetDisplay(true)
            end
        end
        if display then
            DisableControlAction(0, 1, display) -- LookLeftRight
            DisableControlAction(0, 2, display) -- LookUpDown
            DisableControlAction(0, 142, display) -- MeleeAttackAlternate
            DisableControlAction(0, 18, display) -- Enter
            DisableControlAction(0, 322, display) -- ESC
            DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
            DisableControlAction(0, 3, true) -- disable mouse look
            DisableControlAction(0, 4, true) -- disable mouse look
            DisableControlAction(0, 5, true) -- disable mouse look
            DisableControlAction(0, 6, true) -- disable mouse look
            DisableControlAction(0, 263, true) -- disable melee
            DisableControlAction(0, 264, true) -- disable melee
            DisableControlAction(0, 257, true) -- disable melee
            DisableControlAction(0, 140, true) -- disable melee
            DisableControlAction(0, 141, true) -- disable melee
            DisableControlAction(0, 143, true) -- disable melee
            DisableControlAction(0, 177, true) -- disable escape
            DisableControlAction(0, 200, true) -- disable escape
            DisableControlAction(0, 202, true) -- disable escape
            DisableControlAction(0, 244, true) -- disable phone
            DisableControlAction(0, 245, true) -- disable chat
        end
    end
end)

function SetDisplay(statut)
    SetNuiFocus(statut, statut)
    SetNuiFocusKeepInput(statut)
    if statut then
        SendNUIMessage({
            type = "ui",
            display = statut
        })
    else
        Citizen.Wait(100);
    end
    display = not display
end

function GetPhoneSettings()
    TriggerServerEvent("OraPhone:server:GetPhoneSettings")
end

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback('EnableInput', function()
    SetNuiFocusKeepInput(true)
end)

RegisterNUICallback('DisableInput', function()
    SetNuiFocusKeepInput(false)
end)