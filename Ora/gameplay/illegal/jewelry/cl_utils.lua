function TaskPlayAnim2(ped, dict, anim, blendIn, blendOut, duration, flag, playbackRate, lockX, lockY, lockZ)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, anim, blendIn, blendOut, duration, flag, playbackRate, lockX, lockY, lockZ)
end

local function AddLongString(txt)
    for i = 100, string.len(txt), 99 do
        local sub = string.sub(txt, i, i + 99)
        AddTextComponentSubstringPlayerName(sub)
    end
end

function DisplayHelpMessage(text)
    BeginTextCommandDisplayHelp("jamyfafi")
    AddTextComponentSubstringPlayerName(text)
    if string.len(text) > 99 then
        AddLongString(text)
    end
    EndTextCommandDisplayHelp(0, loop or 0, sound or true, -1)
end

function Notification(message, flash, save)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    if string.len(message) > 99 then
        AddLongString(message)
    end
    return EndTextCommandThefeedPostTicker(flash or false, save or false)
end