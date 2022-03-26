AddEventHandler(
    "SaltyChat_TalkStateChanged",
    function(isTalking)
        if (isTalking) then
            SendNUIMessage(
                {
                    Function = "showTalking"
                }
            )
        else
            SendNUIMessage(
                {
                    Function = "stopTalking"
                }
            )
        end
    end
)

AddEventHandler(
    "SaltyChat_VoiceRangeChanged",
    function(voiceRange, index, availableVoiceRanges)
        SendNUIMessage(
            {
                Function = "setTalkingDistance",
                Params = {range = math.tointeger(voiceRange)}
            }
        )
    end
)

RegisterNUICallback(
    "SaltyChat_OnConnected",
    function(data, cb)
        exports["Atlantiss"]:ShowNotification("~h~~g~Connecté au vocal Teamspeak~s~")
    end
)

RegisterNUICallback(
    "SaltyChat_OnDisconnected",
    function(data, cb)
        exports["Atlantiss"]:ShowNotification("~h~~r~Déconnecté du vocal Teamspeak~s~")
    end
)
