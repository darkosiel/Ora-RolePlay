RegisterServerEvent("savefood")
AddEventHandler("savefood", function(eau,f)
    local _source = source
    local uuid = Ora.Identity:GetUuid(_source)
    MySQL.Async.execute(
        'UPDATE users SET food= @food, thirst = @eau where uuid=@uuid',
           {
                ['@eau']  = eau,
                ['@food'] = f,
                ['@uuid'] = uuid
            }
    )
end)