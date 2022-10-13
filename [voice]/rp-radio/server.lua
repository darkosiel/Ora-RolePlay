RegisterServerEvent("rp-radio:turnOnRadio")
AddEventHandler(
    "rp-radio:turnOnRadio",
    function(turnOn)
        --[[         if (turnOn == true) then
            print("Turning radio ON for " .. source)
        else
            print("Turning radio OFF for " .. source)
        end ]]
    end
)

RegisterServerEvent("rp-radio:setPlayerRadioChannel")
AddEventHandler(
    "rp-radio:setPlayerRadioChannel",
    function(channelName, isPrimary)
        --print("Added " .. source .. " to channel " .. channelName)
    end
)

RegisterServerEvent("rp-radio:removePlayerRadioChannel")
AddEventHandler(
    "rp-radio:removePlayerRadioChannel",
    function(channelName)
        --print("removed " .. source .. " from channel " .. channelName)
        if (channelName ~= nil) then
        end
    end
)
