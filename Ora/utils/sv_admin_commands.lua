TriggerEvent(
  "es:addCommand",
  "report",
  function(source, args, user)
    TriggerClientEvent(
      "RageUI:Popup",
      source,
      {
        message = "(~r~REPORT~w~) Votre message a bien été envoyé"
      }
    )

    steamID = GetPlayerIdentifiers(source)[1]

    local embeds = {
      {
        ["title"] = source .. " | " .. GetPlayerName(source),
        ["type"] = "rich",
        ["color"] = 16711680,
        ["footer"] = {
          ["text"] = table.concat(args, " ")
        }
      }
    }

    PerformHttpRequest(
      "https://discord.com/api/webhooks/957344265799888917/yi7JXfNK-r5ObNd87t4PllsVEzDwUvou4JDiyQd5E5Fxlr_0xbhKvLA9yWfHDweEAQvc",
      function(err, text, headers)
      end,
      "POST",
      json.encode({username = "Ora Report", embeds = embeds}),
      {["Content-Type"] = "application/json"}
    )

  end,
  {help = "Report a player or an issue", params = {{name = "report", help = "What you want to report"}}}
)
