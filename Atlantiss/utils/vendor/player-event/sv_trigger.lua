RegisterServerEvent('rage-reborn:PlayerEventHandler')
AddEventHandler("rage-reborn:PlayerEventHandler",function(name,_source,...)
    --print(name .. " event triggered to " .. _source)
    if _source and _source ~= nil then
        TriggerClientEvent(name,_source,...)
    end
end)





MySQL.ready(function ()
    MySQL.Async.execute("UPDATE users SET farm_limit = 0", {})
    MySQL.Async.execute('DELETE FROM phone_messages WHERE TIME < (CURRENT_TIMESTAMP - INTERVAL 3 MONTH)', {})
    MySQL.Async.execute('DELETE FROM phone_calls WHERE TIME < (CURRENT_TIMESTAMP - INTERVAL 3 MONTH)', {})
end)