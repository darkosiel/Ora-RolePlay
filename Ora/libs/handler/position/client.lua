local oldF = 0
function setOldF(o)
    oldF = o
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000) --5M
        if Atlantiss.Player.HasLoaded == true then
            if oldF ~= LocalPlayer().FarmLimit then
                TriggerServerEvent('save:FarmLimit', LocalPlayer().FarmLimit)
                oldF = LocalPlayer().FarmLimit
            end
        end
    end
end)
