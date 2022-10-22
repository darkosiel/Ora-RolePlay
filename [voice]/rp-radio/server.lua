RegisterServerEvent("rp-radio:turnOnRadio")
AddEventHandler(
    "rp-radio:turnOnRadio",
    function(turnOn)
        --[[         if (turnOn == true) then
            print("Turning radio ON for " .. source)
        else
            print("Turning radio OFF for " .. source)
        end ]]
        exports.saltychat:SetPlayerRadioSpeaker(source, false)
    end
)

RegisterServerEvent("rp-radio:setPlayerRadioChannel")
AddEventHandler(
    "rp-radio:setPlayerRadioChannel",
    function(channelName, isPrimary)
        --print("Added " .. source .. " to channel " .. channelName)
        exports.saltychat:SetPlayerRadioChannel(source, channelName, isPrimary)
    end
)

RegisterServerEvent("rp-radio:removePlayerRadioChannel")
AddEventHandler(
    "rp-radio:removePlayerRadioChannel",
    function(channelName)
        --print("removed " .. source .. " from channel " .. channelName)
        if (channelName ~= nil) then
            exports.saltychat:RemovePlayerRadioChannel(source, channelName)
        end
    end
)
