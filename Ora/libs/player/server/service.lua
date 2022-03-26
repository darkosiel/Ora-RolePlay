RegisterServerEvent("call:makeCall")
RegisterServerEvent("call:makeCall2")
RegisterServerEvent("call:getCall")

local callActive = {
    ["ltd"] = {taken = false},
    ["police"] = {taken = false},
    ["lssd"] = {taken = false},
    ["lsms"] = {taken = false},
    ["mecano"] = {taken = false},
    ["mecano2"] = {taken = false},
    ["uber"] = {taken = false},
    ["caroccasions"] = {taken = false}
}
local timing = 30000

AddEventHandler(
    "call:makeCall2",
    function(job, pos, message, author)
        local source = source
        --job)
        --(job,pos,message)
        if callActive[job] == nil then
            callActive[job] = {}
        end
        -- Players can't call simultanously the same service
        if callActive[job].taken then
            --    TriggerClientEvent("target:call:taken", callActive[job].target, 2)
            CancelEvent()
        end
        -- Save the target of the call
        callActive[job].target = source
        callActive[job].taken = true
 
        for _, player in pairs(Atlantiss.Service:GetJobService(job)) do
            TriggerClientEvent("call:callIncoming2", player, job, pos, message, author)
        end
        -- Say to the target after 'timing' seconds that nobody will come
        SetTimeout(
            timing,
            function()
                if callActive[job].taken then
                -- TriggerClientEvent("target:call:taken", callActive[job].target, 0)
                end
                callActive[job].taken = false
            end
        )
    end
)

-- Receive call event
AddEventHandler(
    "call:makeCall",
    function(job, pos, message, author)
        local source = source
        --job)
        --(job,pos,message)
        if callActive[job] == nil then
            callActive[job] = {}
        end
        -- Players can't call simultanously the same service
        if callActive[job].taken then
            --  TriggerClientEvent("target:call:taken", callActive[job].target, 2)
            CancelEvent()
        end

        callActive[job].target = source
        callActive[job].taken = true
  
        for _, player in pairs(Atlantiss.Service:GetJobService(job)) do
            TriggerClientEvent("call:callIncoming", player, job, pos, message, author)
        end

        if job == "taxi" and Atlantiss.Service:GetTotalServiceCountForJob(job) == 0 then
            TriggerClientEvent("gcphone:taxicall", source)
        end

        -- Say to the target after 'timing' seconds that nobody will come
        if not job == "taxi" then
            SetTimeout(
                timing,
                function()
                    if callActive[job].taken then
                        TriggerClientEvent("target:call:taken", callActive[job].target, 0)
                    end
                    callActive[job].taken = false
                end
            )
        elseif job == "taxi" and Atlantiss.Service:GetTotalServiceCountForJob(job) ~= 0 then
            SetTimeout(
                timing,
                function()
                    if callActive[job].taken then
                        TriggerClientEvent("target:call:taken", callActive[job].target, 0)
                        TriggerClientEvent("gcphone:taxicall", source)
                    end
                    callActive[job].taken = false
                end
            )
        end
    end
)

AddEventHandler(
    "call:getCall2",
    function(job)
        callActive[job].taken = false
        -- Say to other in service people that the call is taken
        for _, player in pairs(Atlantiss.Service:GetJobService(job)) do
            if player ~= source then
                TriggerClientEvent("call:taken", player, Atlantiss.Identity:GetFullname(source))
            end
        end
        -- Say to a target that someone come
        if not callActive[job].taken then
        --  TriggerClientEvent("target:call:taken", callActive[job].target, 1)
        end
    end
)

AddEventHandler(
    "call:getCall",
    function(job, y)
        callActive[job].taken = false
        -- Say to other in service people that the call is taken
        for _, player in pairs(Atlantiss.Service:GetJobService(job)) do
            if player ~= source then
                TriggerClientEvent("call:taken", player, Atlantiss.Identity:GetFullname(source))
            end
        end
        -- Say to a target that someone come
        if not callActive[job].taken and not y then
            TriggerClientEvent("target:call:taken", callActive[job].target, 1)
        end
    end
)

RegisterServerCallback('Atlantiss:call:uber:isTaken', function(src, cb) cb(not callActive["uber"].taken and true or false) end)


local mmm = {}
RegisterServerEvent("braquage:Add")
AddEventHandler(
    "braquage:Add",
    function(cur)
        if (cur ~= nil) then
            mmm[cur] = GetGameTimer()
        end
    end
)
RegisterServerCallback(
    "braquage:Get",
    function(_source, callback, cur)
        if (mmm[cur] == nil) then
            callback(true)
        elseif (mmm[cur] ~= nil and (((GetGameTimer() - mmm[cur]) / 1000) > 3600)) then
            callback(true)
        else
            callback(false)
        end
    end
)

local holdupMax = 2
local holdUpsBySteam = {}

RegisterServerCallback(
    "braquage:canHoldup",
    function(source, callback)
        local identifiers = GetIdentifiers(source).steam
        if (holdUpsBySteam[identifiers] == nil) then
            callback(true)
        elseif (holdUpsBySteam[identifiers] ~= nil and holdUpsBySteam[identifiers] < holdupMax) then
            callback(true)
        else
            callback(false)
        end
    end
)


RegisterServerEvent("braquage:addHoldup")
AddEventHandler(
    "braquage:addHoldup",
    function()
        local identifiers = GetIdentifiers(source).steam
        if (holdUpsBySteam[identifiers] == nil) then
            holdUpsBySteam[identifiers] = 0
        end

        holdUpsBySteam[identifiers] = holdUpsBySteam[identifiers] + 1
    end
)

local jobTimeout = {}

for _, job in pairs(Jobs) do
    if job.label2 then
        jobTimeout[job.label2] = 0
    end
end

RegisterServerEvent('Job:Annonce')
AddEventHandler('Job:Annonce', function(society, title, text, icon, icont, societyLabel2)
    if societyLabel2 and jobTimeout[societyLabel2] - GetGameTimer() <= 0 then
        TriggerClientEvent('Job:Annonce', -1, society, title, text, icon, icont)
        local titre = society == "Atlantiss" and "Annonce staff" or society
        if titre ~= "Annonce staff" then
            TriggerEvent(
                "atlantiss:sendToDiscordFromServer",
                source,
                33,
                titre.."\n"..text,
                "atlantiss"
            )
            TriggerEvent(
                "atlantiss:sendToDiscordFromServer",
                source,
                1, 
                titre.."\n"..text, 
                "info"
            )
        else
            TriggerEvent(
                "atlantiss:sendToDiscordFromServer",
                source,
                1, 
                titre.."\n"..text, 
                "info"
            )
        end
        jobTimeout[societyLabel2] = GetGameTimer() + 300000 -- 5min
    elseif societyLabel2 == nil then
        TriggerClientEvent('Job:Annonce', -1, society, title, text, icon, icont)
        local titre = society == "Atlantiss" and "Annonce staff" or society
        if titre ~= "Annonce staff" then
            TriggerEvent(
                "atlantiss:sendToDiscordFromServer",
                source,
                33,
                titre.."\n"..text,
                "atlantiss"
            )
            TriggerEvent(
                "atlantiss:sendToDiscordFromServer",
                source,
                1, 
                titre.."\n"..text, 
                "info"
            )
        else
            TriggerEvent(
                "atlantiss:sendToDiscordFromServer",
                source,
                1, 
                titre.."\n"..text, 
                "info"
            )
        end
    else
        TriggerClientEvent('RageUI:Popup', source, {message = "~r~Une annonce a déjà été faite il y a moins de 5 minutes."})
    end
end)

RegisterServerEvent('Job:WZLgive')
AddEventHandler('Job:WZLgive', function(number)
    MySQL.Async.fetchAll('UPDATE banking_account SET amount = amount + @nbr WHERE iban = "journaliste"', {["@nbr"] = number})
end)
