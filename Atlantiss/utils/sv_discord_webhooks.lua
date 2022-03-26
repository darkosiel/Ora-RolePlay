local discordWBK = {
    "https://discord.com/api/webhooks/809517091072901201/bZY_RChn8iZPzMdDehDk4oxe43lgrlbF4gjOUCzugdSSmYF6lHLfIEURTRsIoyyFfy8q", -- 1    Annonces
    "https://discord.com/api/webhooks/809517364563279942/v55YE7VXuOLb30dRGY1jvpjvLu5aYuNvzo6KTdlnu7bUNoD09I7Myt1xq3rp1mhFvWfD", -- 2    Echanges joueurs
    "https://discord.com/api/webhooks/809517631044321321/E_X1Zfjb6bLTgExywqIOknSjbFkKVyTBwCRYsHgJduuwjevxr45cAkV5AIuH3Ge6pLG7", -- 3    Coffres
    "https://discord.com/api/webhooks/809517779317161996/5Q_jPnnydHrIUecRiOn3YCiBo1Biw03fkrmA3dvG0x8v51UYuiGWLDyfYVRND_zOQFGZ", -- 4    Fouilles
    "https://discord.com/api/webhooks/809520534848667708/TkkOn26HDae39geuXL1wNrBiLUmUgop8RCKJj0CBYFBZj6g66GBzcFSeq44P71CWa7tA", -- 5    Morts
    "https://discord.com/api/webhooks/809518270025433218/JWoUfc3hfLmHW2gHheS-NgOZgLzujVTMSJpyuski74ZIoq7tRJBk-53uu4_FObQMU-gN", -- 6    Braquages sup'
    "https://discord.com/api/webhooks/809518914228453376/yWyHTFyuObIJo8i7t1v9MepMNilXc_ZSzN5iqB62Z-hJ0AiZNZofxBsF9CSC3mUPZSgE", -- 7    Car jacking
    "https://discord.com/api/webhooks/809518032396615713/J8uJMQqLttw_d2BiPYQiWS-vPGdcrb9Qsm01rXMxIWQ00l5kmHznASBHjdjtu9jXQg5Q", -- 8    Fleeca
    "https://discord.com/api/webhooks/809518154509582366/Tj1hVPxn1ZuG1StUHP_TL_4VcIDuK6YEoN73IPOvMpBjxWz9PRIYwJTP8j76DWqIKipk", -- 9    ATM
    "https://discord.com/api/webhooks/809518400312573993/d2ip3a6NZtNOq_wCiEmpkHEYUrlJXsekZc6YlCV_HQpEfvUGCfYbEeC4Ut95aHrVol_a", -- 10   Go fast
    "https://discord.com/api/webhooks/809518636552683530/ry8chyzxCSFsBvgA8B_OxhReSkGDNvTMebeVEl6dDY0DZZps6iC7AmCM3hM2h5cEqipD", -- 11   Vol véhicule
    "https://discord.com/api/webhooks/809520384645791744/3-x5aHiims1aGlFcRUaYWEc39AuCikjKvsnOvFVQg3dGuFsmMc9r9X5OnmnT7VGMCr3M", -- 12   LUA Executor
    "https://discord.com/api/webhooks/809518497225900162/j2Qi52Zx9Zu0doRC48n82F_uQfmtoXd9a7AYKi5qjXPK59-jQT0zdmCy06blh9wEkqAu", -- 13   Report
    "https://discord.com/api/webhooks/809520670597054534/EgUuUcgS6AF6LMIYqIhBb50PlddCx68QG5ZM9aVE303-UlL5VRh7p3aHuIEuXZBeUp6H", -- 14   Connexion
    "https://discord.com/api/webhooks/810164998789398578/cKbo_fqGoU_5klBZcBpNK5SCgYqQhkdRaeiP1ZCAjYo7VoHf6lv7beVqSYzEjj0uZLja", -- 15   Admin
    "https://discord.com/api/webhooks/791672257738309643/3vz2DHp91C9uHNWPXtjOmmqfBB7z0SRB-bsAtGXLtRKqAv0X5RYcevsEhdb4OZka0H1U", -- 16   Medecin
    "https://discord.com/api/webhooks/795306221829095445/r2RGhpqqOMpN6I-jUp7YAnCNtQKJCiR68qk7VO1H7H0wc_9NrTbF16nPAJkasdOCIh8G", -- 17   Rapport de lancement
    "https://discord.com/api/webhooks/809519670536568842/_5q62GdDVdr6vH8fkrtmSD_zRfLyZEP9FcINAUmV4N2KC0rA9JzHD63LCsB5JrEzoQpy", -- 18   Migrant Smuggling
    "https://discord.com/api/webhooks/809519532342771763/5fu807TKl36ymcQ5s3kCNPAWiJf7874m5od14XwbPPOmIuTx5P6lSCJsrEOce0ahcOs8", -- 19   Burglary
    "https://discord.com/api/webhooks/809519779424895056/OHOND7_zFT99aVCKPgISPwn7D9qBoPJQTcWL1mky7DaqD_003-BNnCxTLwNPhwg9wZU3", -- 20   Faction
    "https://discord.com/api/webhooks/809519927156801569/ri7A-SaG_-MKrGxxnUR3ehi2zZv3eY6zG8QTYJy9Nm7ETHCFy9P91RfcNXaEiqmZ-rLo", -- 21   Labo
    "https://discord.com/api/webhooks/809520023096918047/g_v9kVHZ4uCgjGc5rDgpvx5eAgUcXeZILfUxzSJ82U7OUEWQk9iwF82kdhG-U_B0SYnY", -- 22   Weapon Warehouse
    "https://discord.com/api/webhooks/810164866827943956/ZT4guaNStc3QBGMYteW1j0Rc9jRAQwzpPB6QjNlQ8jdDlu1BjIFhz0Vydut685Jg3mli", -- 23   Admin illegal
    "https://discord.com/api/webhooks/809520121541820486/0V4yPRd06qW1YsHEqp4tvfBzNUHIg8a4J1j-FqgvXGHk_sj2-QGAsEYIhl_tVM4yPLQV", -- 24   Attacks
    "https://discord.com/api/webhooks/802571835635007568/hAOrT3eky9H9aFbEsl6_Km6nHzkcG9A42cYaLMVV0-KjBiePIuoaYi1l8D8KwXijWf4V", -- 25   Retrait & Dépôt ATM
    "https://discord.com/api/webhooks/809520286998200320/8Nklfn-9UlpiIM38_ZnG8xVPb_OmgOdtIljVtQKAJ6AzILV61gvP-TJjuuacdeCUgXXJ", -- 26   AddMoney
    "https://discord.com/api/webhooks/811523262642389022/azaVYy7K_JARsBDZ4csWc9p3ROPiluKWMU9rLr2xS7qa5yB7SLp-zDo7HZyK-2qZFijD", -- 27   Casino
    "https://discord.com/api/webhooks/811537298889506826/LHpYLnXbMBsYRT39J4OSaJKf6Tv_HBmMkTYciBgntOKoIT50BGBc7LGVuGxVNnNkm9lo", -- 28   Casino System
    "https://discord.com/api/webhooks/817293889743486986/8Cqz_VtXwF9zdf-Fl47vLyNzvTdQU-DvraKvKVz7h1kQjRvaYbJOf7tOi6xK8pwMGvlr", -- 29   Dev test
    "https://discord.com/api/webhooks/818064451089203220/zFytIch3nU1-QFeIgz3vIQCeFxxIm6L_MprCb-oG_JQtas0_a_dlcz3VptkIwB74EBnS", -- 30   Salary
    "https://discord.com/api/webhooks/818507810002305055/UbjuE4qiACLrP1louGL0pC1bB1nO7ojoSHk64y7pv0XA5KBFpmRPRdYKXyCJf3qALBZm", -- 31   Screenshot request
    "https://discord.com/api/webhooks/818509890087551017/RKQ168RuSkDEXn4I8i0IUCnZXSZAmmoUAATedUiUH09S0M7WsYLFbW9IX7nRbr_A5ZuV", -- 32   Salary summary
    "https://discord.com/api/webhooks/824649455466708992/KMf7rirwefq9W_27GsrMZ3fiJRRSgCFA6e_HW13qzfo07ksr1bmvN6xVrNSsi3oVjYps", -- 33   Annonce entreprise
    "https://discord.com/api/webhooks/830847201777025054/z_LPi5FtBULifMU6LfCTxhxJ1R2yTi2K-uaUVcXOuG65CRZUGprjdmTcOpO9tGHBvC7d", -- 34   faux papier fib
    "https://discord.com/api/webhooks/839822338929590312/TZfekrR7NYyExxAkAcIMeM8vnyUhag6i_RefMtr3jcSobvxo1bgTA9NYOtRVk6qQRUaW", -- 35   /me
    "https://discord.com/api/webhooks/862373071162703903/hmpyYtS03I7fVw2AtUM2vGkL3KTw2MMvuhdx8wzflOfFqzxtTAOk4kzCcWWdaCIRJ6RC", -- 36   vehicules owner
    "https://discord.com/api/webhooks/879859019081216050/iku0RbtP2g3yTrlsqOye9Inhb4-ly603f-7R1Tj30plOBvJo9U3qlcWntHlePQ_qhzNi", -- 37   Raids
    "https://discord.com/api/webhooks/881842062008385637/h4AKMdqaXbXjIjPq-UlhRUgGIR_fJWpDWrZjoB3tTPzCtqrtSVu3B75rry5-NP65ZExq", -- 38   Immo
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

        if (GetConvar("current_env", "dev") == "dev") then
            webhook = discordWBK[29]
        end

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
            json.encode({username = "Atlantiss Logs", embeds = embeds}),
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
            json.encode({username = "Atlantiss Logs", embeds = embeds}),
            {["Content-Type"] = "application/json"}
        )
    end
)
