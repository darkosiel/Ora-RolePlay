RegisterNetEvent('chasse:server:CreateLog', function(name, title, color, message, tagEveryone)         
    local tag = tagEveryone or false
    local webHook = Config.Webhooks[name] or Config.Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Config.Colors[color] or Config.Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Notification', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
end)