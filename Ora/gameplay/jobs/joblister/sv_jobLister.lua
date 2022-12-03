local AnnounceData = {}
local AnnounceDataByJob = {}
RegisterServerEvent("joblisting:SyncMyJobAnnounce")
AddEventHandler("joblisting:SyncMyJobAnnounce",function(job,_table,table2)
    --print(job)
    if AnnounceDataByJob[job] == nil then
        AnnounceDataByJob[job] = {}
    end
    table.insert( AnnounceDataByJob[job], _table )
    AnnounceData = table2
end)



RegisterServerEvent("job:AddMails")
AddEventHandler("job:AddMails",function(job,msg)

end)


RegisterServerCallback('joblisting:RequestData', function(source, callback,job)
    callback(AnnounceData,AnnounceDataByJob[job])
end)

RegisterServerEvent("storevehicletow")
AddEventHandler("storevehicletow",function(pl)
    Ora.World.Vehicle:SetVehicleToPound_Plate(pl)
end)

RegisterServerEvent("facture:pay")
AddEventHandler("facture:pay",function(_facture)
    TriggerClientEvent("facture:paied", _facture.source)
end)

RegisterServerEvent("facture:send")
AddEventHandler("facture:send",function(_facture)
    local _s = source
    _facture.source = _s
    TriggerClientEvent("facture:get", _facture.playerId, _facture)
end)

RegisterServerEvent("fake_facture:pay")
AddEventHandler("fake_facture:pay",function(_facture)
    TriggerClientEvent("fake_facture:paied", _facture.source)
end)

RegisterServerEvent("fake_facture:send")
AddEventHandler("fake_facture:send",function(_facture)
    local _s = source
    _facture.source = _s
    TriggerClientEvent("fake_facture:get", _facture.playerId, _facture)
end)

RegisterServerEvent('Ora:logInvoice')
AddEventHandler('Ora:logInvoice', function(company, reason, src, amount, method)
    local _source = source
    MySQL.Async.fetchAll(
        'INSERT INTO invoices (company, reason, method, src, dest, amount, time) VALUES(@company, @reason, @method, @src, @dest, @amount, NOW())',
        {
            ["@company"] = company,
            ["@reason"] = reason,
            ["@method"] = method,
            ["@src"] =  Ora.Identity:GetUuid(src),
            ["@dest"] = Ora.Identity:GetUuid(_source),
            ["@amount"] = amount
        }
    )
end)
