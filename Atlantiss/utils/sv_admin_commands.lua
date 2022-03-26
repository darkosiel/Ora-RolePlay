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
      "https://discordapp.com/api/webhooks/780579006033952789/mkAcPxB8cetRNxD2Ale3sITdDf961xyZX4YJwSqVqyCZOJwxkMIMIkuW5sTYdJIxXZdR",
      function(err, text, headers)
      end,
      "POST",
      json.encode({username = "Atlantiss Report", embeds = embeds}),
      {["Content-Type"] = "application/json"}
    )

  end,
  {help = "Report a player or an issue", params = {{name = "report", help = "What you want to report"}}}
)
