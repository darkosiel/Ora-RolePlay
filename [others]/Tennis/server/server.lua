RegisterNetEvent('lsrp_tennis:setBallData')
AddEventHandler('lsrp_tennis:setBallData', function(courtName, hitType, ballPos, newVelocity)
    TriggerClientEvent('lsrp_tennis:setBallData', -1, source, courtName, hitType, ballPos, newVelocity)
end)

RegisterNetEvent('lsrp_tennis:requestPosition')
AddEventHandler('lsrp_tennis:requestPosition', function(courtName, positionName)
    local Source = source

    if not TennisCourts[courtName].players then 
        TennisCourts[courtName].players = {}
    end

    if not TennisCourts[courtName].players[positionName] then
        TennisCourts[courtName].players[positionName] = Source
        TriggerClientEvent('lsrp_tennis:grantPosition', Source, courtName, positionName, true)
    end

    TriggerClientEvent('lsrp_tennis:setBallInHand', -1, source, courtName)
end)