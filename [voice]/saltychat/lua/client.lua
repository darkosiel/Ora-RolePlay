
RegisterNUICallback(
    "SaltyChat_OnConnected",
    function(data, cb)
        exports["Ora"]:ShowNotification("~h~~g~Connecté au vocal Teamspeak~s~")
    end
)

RegisterNUICallback(
    "SaltyChat_OnDisconnected",
    function(data, cb)
        exports["Ora"]:ShowNotification("~h~~r~Déconnecté du vocal Teamspeak~s~")
    end
)