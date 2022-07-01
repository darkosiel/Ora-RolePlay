local discordButton = {
    {index = 0, name = 'Rejoindre le discord', url = "https://discord.com/invite/orarp"}
}

Citizen.CreateThread(
    function()
        for _, v in ipairs(discordButton) do
            SetDiscordRichPresenceAction(v.index, v.name, v.url)
        end
        while true do
            SetDiscordAppId(817747736854003742)
            SetDiscordRichPresenceAsset("logoora")
            SetDiscordRichPresenceAssetText("https://discord.gg/orarp")

            TriggerServerCallback(
                "onlinePlayers:list",
                function(users)
                    SetRichPresence(GetPlayerName(PlayerId()) .. " 👥 " .. #users .. "/256")
                end
            )

            Citizen.Wait(60000)
        end
    end
)
