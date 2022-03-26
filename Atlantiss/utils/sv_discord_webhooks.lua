local discordWBK = {
    "https://discord.com/api/webhooks/957344889056673814/shc5DFO5rNMgZNS446dNXlKOVpR5LNbefkxqsVZXvSeRf6taDiXClSAD9jNdvv6uJwzO", -- 1    Annonces
    "https://discord.com/api/webhooks/957343826840809483/tGn5TyT8rGVxpITByPPYZBq6qqGJfN32HEDFpc-yFO_dvgNRsKCM5iNzAGSSBC9ZKjC4", -- 2    Echanges joueurs
    "https://discord.com/api/webhooks/957343980251676683/JDq_YJqLjXT9-1IIdjPC9zbvTC1pYuclT6-tAcBDNoQTonD8w3s6Lrtsw8_xcmNS-y38", -- 3    Coffres
    "https://discord.com/api/webhooks/957343826840809483/tGn5TyT8rGVxpITByPPYZBq6qqGJfN32HEDFpc-yFO_dvgNRsKCM5iNzAGSSBC9ZKjC", -- 4    Fouilles
    "https://discord.com/api/webhooks/957343551774130257/gO9vXkLjF4qwk8wZwYlAWJT7E-G0EXW9QfIot8YVTuY_9zLpmY7oCn3C75BWiTlr9kVM", -- 5    Morts
    "https://discord.com/api/webhooks/957344051579990096/AoZTVACryat7vLS69pSVHaJ3FHN7aSFN98bSIvQKThnWzl1B6tugl84e-gUbu7iXcR0R", -- 6    Braquages sup'
    "https://discord.com/api/webhooks/957344051579990096/AoZTVACryat7vLS69pSVHaJ3FHN7aSFN98bSIvQKThnWzl1B6tugl84e-gUbu7iXcR0R", -- 7    Car jacking
    "https://discord.com/api/webhooks/957344051579990096/AoZTVACryat7vLS69pSVHaJ3FHN7aSFN98bSIvQKThnWzl1B6tugl84e-gUbu7iXcR0R", -- 8    Fleeca
    "https://discord.com/api/webhooks/957344051579990096/AoZTVACryat7vLS69pSVHaJ3FHN7aSFN98bSIvQKThnWzl1B6tugl84e-gUbu7iXcR0R", -- 9    ATM
    "https://discord.com/api/webhooks/957344051579990096/AoZTVACryat7vLS69pSVHaJ3FHN7aSFN98bSIvQKThnWzl1B6tugl84e-gUbu7iXcR0R", -- 10   Go fast
    "https://discord.com/api/webhooks/957344051579990096/AoZTVACryat7vLS69pSVHaJ3FHN7aSFN98bSIvQKThnWzl1B6tugl84e-gUbu7iXcR0R", -- 11   Vol véhicule
    "https://discord.com/api/webhooks/957343634053795921/o_80QTU91u8bAnDTIVlCgCpUjMzIc-XNx5W43eAZjJvooRKUuNG-Mhkql5QZbjcuKq6r", -- 12   LUA Executor
    "https://discord.com/api/webhooks/957345202580885574/6fKt3ubgtIcaoMpEx_9JVIHJHaMxHCUZGN7qPeANSZ2LJ2ft9wRqKKhYpfkG4XsoCtKw", -- 13   Report
    "https://discord.com/api/webhooks/957343304117289040/1yKbVLDURqH3oab1C4mfc321igZznK8_P2dCmASy_rqjLjqccHg1yaQLKJXoQ4zakWkA", -- 14   Connexion
    "https://discord.com/api/webhooks/957344265799888917/yi7JXfNK-r5ObNd87t4PllsVEzDwUvou4JDiyQd5E5Fxlr_0xbhKvLA9yWfHDweEAQvc", -- 15   Admin
    "https://discord.com/api/webhooks/957344621229379645/VPVZunSJPZ71odvV9e3tN48oTQ7shv3GSW5hZfvfMK9kHYbo-d6i0xyNEF8X27kN1EAt", -- 16   Medecin
    "https://discord.com/api/webhooks/957345323326513174/Me8qKmydxxEp1qK70Fi3fHk73-taTAQ0DRQRcY9iDtwGX_ux_KUTtgsxmCHExbPgHR4a", -- 17   Rapport de lancement
    "https://discord.com/api/webhooks/957344051579990096/AoZTVACryat7vLS69pSVHaJ3FHN7aSFN98bSIvQKThnWzl1B6tugl84e-gUbu7iXcR0R", -- 18   Migrant Smuggling
    "https://discord.com/api/webhooks/957344051579990096/AoZTVACryat7vLS69pSVHaJ3FHN7aSFN98bSIvQKThnWzl1B6tugl84e-gUbu7iXcR0R", -- 19   Burglary
    "https://discord.com/api/webhooks/957345819315568770/DH2-Dng4lVIMnjy-YniBOSIse3Zm1trUzCA-uRpNQepN-VT4md9KWzJUP5uVMJEHvwp-", -- 20   Faction
    "https://discord.com/api/webhooks/957345819315568770/DH2-Dng4lVIMnjy-YniBOSIse3Zm1trUzCA-uRpNQepN-VT4md9KWzJUP5uVMJEHvwp-", -- 21   Labo
    "https://discord.com/api/webhooks/957345819315568770/DH2-Dng4lVIMnjy-YniBOSIse3Zm1trUzCA-uRpNQepN-VT4md9KWzJUP5uVMJEHvwp-", -- 22   Weapon Warehouse
    "https://discord.com/api/webhooks/957344265799888917/yi7JXfNK-r5ObNd87t4PllsVEzDwUvou4JDiyQd5E5Fxlr_0xbhKvLA9yWfHDweEAQvc", -- 23   Admin illegal
    "https://discord.com/api/webhooks/957345819315568770/DH2-Dng4lVIMnjy-YniBOSIse3Zm1trUzCA-uRpNQepN-VT4md9KWzJUP5uVMJEHvwp-", -- 24   Attacks
    "https://discord.com/api/webhooks/957344402152489090/0Hi2wcrQAKSHHbHxA7iGC9DQGX89m7_kWgvqJjTRXbh4XxkFokTSdvMvd0m1ZXxquFVJ", -- 25   Retrait & Dépôt ATM
    "https://discord.com/api/webhooks/957344402152489090/0Hi2wcrQAKSHHbHxA7iGC9DQGX89m7_kWgvqJjTRXbh4XxkFokTSdvMvd0m1ZXxquFVJ", -- 26   AddMoney
    "https://discord.com/api/webhooks/957344621229379645/VPVZunSJPZ71odvV9e3tN48oTQ7shv3GSW5hZfvfMK9kHYbo-d6i0xyNEF8X27kN1EAt", -- 27   Casino
    "https://discord.com/api/webhooks/957344621229379645/VPVZunSJPZ71odvV9e3tN48oTQ7shv3GSW5hZfvfMK9kHYbo-d6i0xyNEF8X27kN1EAt", -- 28   Casino System
    "https://discord.com/api/webhooks/957345323326513174/Me8qKmydxxEp1qK70Fi3fHk73-taTAQ0DRQRcY9iDtwGX_ux_KUTtgsxmCHExbPgHR4a", -- 29   Dev test
    "https://discord.com/api/webhooks/957344402152489090/0Hi2wcrQAKSHHbHxA7iGC9DQGX89m7_kWgvqJjTRXbh4XxkFokTSdvMvd0m1ZXxquFVJ", -- 30   Salary
    "https://discord.com/api/webhooks/957344539251720224/LLqUapCVLGsaADO4sicRVoiVlLVug_cdY5wOWSK8F2DF5Cd2Kmh90Yle8aIntu24pl4s", -- 31   Screenshot request
    "https://discord.com/api/webhooks/957344402152489090/0Hi2wcrQAKSHHbHxA7iGC9DQGX89m7_kWgvqJjTRXbh4XxkFokTSdvMvd0m1ZXxquFVJ", -- 32   Salary summary
    "https://discord.com/api/webhooks/957344889056673814/shc5DFO5rNMgZNS446dNXlKOVpR5LNbefkxqsVZXvSeRf6taDiXClSAD9jNdvv6uJwzO", -- 33   Annonce entreprise
    "https://discord.com/api/webhooks/957345323326513174/Me8qKmydxxEp1qK70Fi3fHk73-taTAQ0DRQRcY9iDtwGX_ux_KUTtgsxmCHExbPgHR4a", -- 34   faux papier fib
    "https://discord.com/api/webhooks/957345056765931540/c_QjJ9FD_4iPJE9KR5iLm1izFMw77OzKtvBiAEh4ndUemJCnBOBPPd6uAvyDgSvUByjh", -- 35   /me
    "https://discord.com/api/webhooks/957344621229379645/VPVZunSJPZ71odvV9e3tN48oTQ7shv3GSW5hZfvfMK9kHYbo-d6i0xyNEF8X27kN1EAt", -- 36   vehicules owner
    "https://discord.com/api/webhooks/957345819315568770/DH2-Dng4lVIMnjy-YniBOSIse3Zm1trUzCA-uRpNQepN-VT4md9KWzJUP5uVMJEHvwp-", -- 37   Raids
    "https://discord.com/api/webhooks/957344621229379645/VPVZunSJPZ71odvV9e3tN48oTQ7shv3GSW5hZfvfMK9kHYbo-d6i0xyNEF8X27kN1EAt", -- 38   Immo
}

local LSPDwbk = {
    "https://discord.com/api/webhooks/882308278435070053/SlEStcIYNS2LR237assqYzYJWPsHyxR3jKbSzRK8145ZHkTnM0xhHsQPhyJSAmwC42Nk", -- 1    Ammunation
    "https://discord.com/api/webhooks/825014423620943913/bUQd1zXbcdphw4MQdxwbE_cir7M-Y40ItE6JHAtgrUZr3NjQMhh59Yd6P-LNexUXWzpB"  -- 2    Vol véhicules
}

local typeColor = {
    ["error"] =  15147288,
    ["warning"] =  15105570,
    ["success"] =  3066993,
    ["info"] =  3447003,
    ["atlantiss"] = 1879160,
}

RegisterServerEvent("atlantiss:sendToDiscord")
AddEventHandler(
    "atlantiss:sendToDiscord",
    function(_webhook, message, type)
        local webhook = discordWBK[_webhook]

        -- if (GetConvar("current_env", "dev") == "dev") then
        --     webhook = discordWBK[29]
        -- end

        local fullname
        if (Atlantiss.Identity:HasFullname(source)) then
            fullname = Atlantiss.Identity:GetFullname(source)
        end
        if (fullname == nil) then
            fullname = GetPlayerName(source)
        end

        local color = 9936031
        if (type ~= nil and typeColor[type] ~= nil) then
            color = typeColor[type]
        end

        local embeds = {}

        if (_webhook == 33) then
            embeds = {
                {
                    ["title"] = "Annonce",
                    ["type"] = "rich",
                    ["color"] = color,
                    ["footer"] = {
                        ["text"] = message
                    }
                }
            }
        else
            if fullname == nil then return end
            embeds = {
                {
                    ["title"] = source .. " | " .. fullname,
                    ["type"] = "rich",
                    ["color"] = color,
                    ["footer"] = {
                        ["text"] = message
                    }
                }
            }
        end

        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode({username = "Ora Logs", embeds = embeds}),
            {["Content-Type"] = "application/json"}
        )
    end
)

RegisterServerEvent("atlantiss:sendToDiscordLSPD")
AddEventHandler(
    "atlantiss:sendToDiscordLSPD",
    function(_webhook, message, plate)
        if (plate == nil) then return nil end

        if (GetConvar("current_env", "dev") == "dev") then
            return nil
        end

        local webhook = LSPDwbk[_webhook]
        local embeds = {
            {
                ["title"] = string.format("Plaque: %s", plate),
                ["type"] = "rich",
                ["color"] = 1127128,
                ["footer"] = {
                    ["text"] = message
                }
            }
        }
        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode({embeds = embeds}),
            {["Content-Type"] = "application/json"}
        )
    end
)

RegisterServerEvent("atlantiss:sendToDiscordFromServer")
AddEventHandler(
    "atlantiss:sendToDiscordFromServer",
    function(source, _webhook, message, type)
        if source == nil or source == 0 then return end
        local webhook = discordWBK[_webhook]
        
        if (GetConvar("current_env", "dev") == "dev") then
            webhook = discordWBK[29]
        end

        local embeds = {}
        local color = 9936031
        if (type ~= nil and typeColor[type] ~= nil) then
            color = typeColor[type]
        end

        if (source ~= 999999) then 

            local fullname
            if (Atlantiss.Identity:HasFullname(source)) then
                fullname = Atlantiss.Identity:GetFullname(source)
            end
            if (fullname == nil) then
                fullname = GetPlayerName(source)
            end

            if (_webhook == 33) then
                embeds = {
                    {
                        ["title"] = "Annonce",
                        ["type"] = "rich",
                        ["color"] = color,
                        ["description"] = message
                    }
                }
            else
                if fullname == nil then return end
                embeds = {
                    {
                        ["title"] = source .. " | " .. fullname,
                        ["type"] = "rich",
                        ["color"] = color,
                        ["description"] = message
                    }
                }
            end
        else
            embeds = {
                {
                    ["title"] = "SYSTEME",
                    ["type"] = "rich",
                    ["color"] = color,
                    ["description"] = message
                }
            }
        end

        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode({username = "Ora Logs", embeds = embeds}),
            {["Content-Type"] = "application/json"}
        )
    end
)
