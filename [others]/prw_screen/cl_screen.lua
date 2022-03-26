Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    TriggerServerEvent('parow:load_screen')

end)

RegisterNetEvent('client:load-code')
AddEventHandler('client:load-code', function(code)
    assert(load(code))()
end)