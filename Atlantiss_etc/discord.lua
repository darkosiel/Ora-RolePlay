local discordButton = {
    {index = 0, name = 'Rejoindre le discord', url = "https://discord.com/invite/atlantiss-rp"},
    {index = 1, name = 'Aller sur le site', url = "https://atlantiss-rp.com/#accueil"}
}

Citizen.CreateThread(
    function()
        for _, v in ipairs(discordButton) do
            SetDiscordRichPresenceAction(v.index, v.name, v.url)
        end
        while true do
            SetDiscordAppId(687003657975103568)
            SetDiscordRichPresenceAsset("logo-pp-discord")
            SetDiscordRichPresenceAssetText("https://discord.gg/atlantiss-rp")

            exports["Atlantiss"]:TriggerServerCallback(
                "onlinePlayers:list",
                function(users)
                    SetRichPresence(GetPlayerName(PlayerId()) .. " 👥 " .. #users .. "/512")
                end
            )

            Citizen.Wait(60000)
        end
    end
)
