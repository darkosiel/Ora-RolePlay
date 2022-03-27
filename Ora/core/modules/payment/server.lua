Ora.Payment.EVENT_NAME = nil
Ora.Payment.TOKENS = {}
Ora.Payment.ALLOWED_PAYMENTS = {}

Ora.Payment.Fake.EVENT_NAME = nil
Ora.Payment.Fake.TOKENS = {}
Ora.Payment.Fake.ALLOWED_PAYMENTS = {}


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000 * 120)

    local currentTime = os.time()
    for userId, tokenValues in pairs(Ora.Payment.ALLOWED_PAYMENTS) do
      if (type(tokenValues) == "table") then
        for tokenId, data in pairs(tokenValues) do
          if data.authorized_at + 120 < currentTime then
            Ora.Payment:Debug(string.format("Removed payment authorization for ^5%s^3 token id : ^5%s^3", userId, tokenId))
            Ora.Payment.ALLOWED_PAYMENTS[userId][tokenId] = nil
          end
        end
      end
    end

    for userId, tokenValues in pairs(Ora.Payment.Fake.ALLOWED_PAYMENTS) do
      if (type(tokenValues) == "table") then
        for tokenId, data in pairs(tokenValues) do
          if data.authorized_at + 120 < currentTime then
            Ora.Payment:Debug(string.format("Removed payment authorization for ^5%s^3 token id : ^5%s^3", userId, tokenId))
            Ora.Payment.Fake.ALLOWED_PAYMENTS[userId][tokenId] = nil
          end
        end
      end
    end
  end
end)

function Ora.Payment:PropagateEventName(playerServerId)
    Ora.Payment:Debug(string.format("Propagating event ^5%s^3 to player : ^5%s^3", self:GetServerEventName(), playerServerId))
    TriggerClientEvent("Ora::CE::Money:RegisterEventName", playerServerId, self:GetServerEventName())
end

function Ora.Payment:GetServerEventName()
    if (self.EVENT_NAME == nil) then
        self.EVENT_NAME = self:GenerateServerEventName()
        Ora.Payment:Debug(string.format("Generating server event ^5%s^3", self.EVENT_NAME))
    end

    return self.EVENT_NAME
end

function Ora.Payment:AddToken(token, data)
    Ora.Payment:Debug(string.format("Added token ^5%s^3 to the token list", token))
    self.TOKENS[token] = data
end

function Ora.Payment:VerifyToken(token, source)
    if (self.TOKENS[token] == nil) then
        Ora.Payment:Debug(string.format("Token ^5%s^3 cannot be verified", token))
        return false
    end

    local tokenData = self:GetTokenData(token)

    if (tokenData.PLAYERID ~= nil) then
        Ora.Payment:Debug(string.format("Token ^5%s^3 has been verified", token))
        return true
    end

    Ora.Payment:Debug(string.format("Token ^5%s^3 cannot be verified", token))
    return false
end

function Ora.Payment:GetTokenData(token)
    if (self.TOKENS[token] == nil) then
        Ora.Payment:Debug(string.format("Token ^5%s^3 has no data to be returned", token))
        return {}
    end

    Ora.Payment:Debug(string.format("Returning data for token : ^5%s^3", token))
    return self.TOKENS[token]
end

function Ora.Payment:RemoveToken(token)
    Ora.Payment:Debug(string.format("Removing token : ^5%s^3", token))
    self.TOKENS[token] = nil
end

function Ora.Payment:GenerateServerEventName()
    return "Ora::SE::Money:GiveMoney" .. "-" .. GetGameTimer() .. "-" .. os.time()
end

function Ora.Payment:GenerateNewToken()
    local uuid = nil
    local canSend = false

    TriggerEvent('uuid', function(result)
      uuid = result
      canSend = true
    end)

    while (canSend == false) do Wait(10) end
    Ora.Payment:Debug(string.format("New token : ^5%s^3 has been generated", uuid))
    return uuid
end



function Ora.Payment.Fake:PropagateEventName(playerServerId)
    Ora.Payment:Debug(string.format("Propagating event ^5%s^3 to player : ^5%s^3", self:GetServerEventName(), playerServerId))
    TriggerClientEvent("Ora::CE::Money:Fake:RegisterEventName", playerServerId, self:GetServerEventName())
end

function Ora.Payment.Fake:GetServerEventName()
    if (self.EVENT_NAME == nil) then
        self.EVENT_NAME = self:GenerateServerEventName()
        Ora.Payment:Debug(string.format("Generating server event ^5%s^3", self.EVENT_NAME))
    end

    return self.EVENT_NAME
end

function Ora.Payment.Fake:AddToken(token, data)
    Ora.Payment:Debug(string.format("Added token ^5%s^3 to the token list", token))
    self.TOKENS[token] = data
end

function Ora.Payment.Fake:VerifyToken(token, source)
    if (self.TOKENS[token] == nil) then
        Ora.Payment:Debug(string.format("Token ^5%s^3 cannot be verified", token))
        return false
    end

    local tokenData = self:GetTokenData(token)

    if (tokenData.PLAYERID ~= nil) then
        Ora.Payment:Debug(string.format("Token ^5%s^3 has been verified", token))
        return true
    end

    Ora.Payment:Debug(string.format("Token ^5%s^3 cannot be verified", token))
    return false
end

function Ora.Payment.Fake:GetTokenData(token)
    if (self.TOKENS[token] == nil) then
        Ora.Payment:Debug(string.format("Token ^5%s^3 has no data to be returned", token))
        return {}
    end

    Ora.Payment:Debug(string.format("Returning data for token : ^5%s^3", token))
    return self.TOKENS[token]
end

function Ora.Payment.Fake:RemoveToken(token)
    Ora.Payment:Debug(string.format("Removing token : ^5%s^3", token))
    self.TOKENS[token] = nil
end

function Ora.Payment.Fake:GenerateServerEventName()
    return "Ora::SE::Money:Fake:GiveMoney" .. "-" .. GetGameTimer() .. "-" .. os.time()
end

function Ora.Payment.Fake:GenerateNewToken()
    local uuid = nil
    local canSend = false

    TriggerEvent('uuid', function(result)
      uuid = result
      canSend = true
    end)

    while (canSend == false) do Wait(10) end
    Ora.Payment:Debug(string.format("New token : ^5%s^3 has been generated", uuid))
    return uuid
end

RegisterServerEvent("Ora::SE::Money::AssociateScreenshot")
AddEventHandler(
    "Ora::SE::Money::AssociateScreenshot",
    function(data)
        local _source = source
            Ora.Payment:Debug(string.format("Screenshot has been associated with token ^5%s^3 and url is : ^5%s^3", data.TOKEN, data.PICTURE_URL))
            TriggerEvent(
                  "Ora:sendToDiscordFromServer",
                  source,
                  26,
                  data.TOKEN .. "\n[Voir le screenshot](".. data.PICTURE_URL ..")",
                  "info"
            )
    end
)

RegisterServerEvent(Ora.Payment:GetServerEventName())
AddEventHandler(
    Ora.Payment:GetServerEventName(),
    function(data)
        local _source = source

        if (data.ROUTING ~= nil) then 
            _source = data.ROUTING
        end

        if (data.TOKEN == nil) then
          Ora.Payment:Debug(string.format("No data token provided"))
          Ora.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if Ora.Payment.ALLOWED_PAYMENTS[_source] == nil then
          Ora.Payment:Debug(string.format("Any payment registered for ^5%s^3", _source))
          Ora.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if Ora.Payment.ALLOWED_PAYMENTS[_source][data.TOKEN] == nil then
          Ora.Payment:Debug(string.format("Token unknown for ^5%s^3", _source))
          Ora.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if ((os.time() - Ora.Payment.ALLOWED_PAYMENTS[_source][data.TOKEN].authorized_at) > 60) then
          Ora.Payment:Debug(string.format("Whitelist delay for payment is overdue ^5%s^3 secs", (os.time() - Ora.Payment.ALLOWED_PAYMENTS[_source][data.TOKEN].authorized_at)))
          Ora.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] Temps de grâce dépassé pour l'obtention d'argent. Possible Use Bug.",
            source,
            true
          )
          return
        end

        if (data.AMOUNT > 20000) then
            Ora.Payment:Debug(string.format("Triggering a screenshot because amount is > ^5%s^3", "20000$"))
            TriggerClientEvent("Ora::CE::General:Snap", _source, {TOKEN = data.TOKEN, SERVER_EVENT = "Ora::SE::Money::AssociateScreenshot"})
        end

        Ora.Payment:AddToken(data.TOKEN, {AMOUNT = data.AMOUNT, PLAYERID = _source, SOURCE = data.SOURCE})
        TriggerClientEvent("Ora::CE::Money:AddMoney", _source, data.TOKEN)
    end
)

RegisterServerEvent(Ora.Payment.Fake:GetServerEventName())
AddEventHandler(
    Ora.Payment.Fake:GetServerEventName(),
    function(data)
      local _source = source

        if (data.ROUTING ~= nil) then 
            _source = data.ROUTING
        end

        if (data.TOKEN == nil) then
          Ora.Payment:Debug(string.format("No data token provided"))
          Ora.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if (Ora.Payment.Fake.ALLOWED_PAYMENTS[_source] == nil) then
          Ora.Payment:Debug(string.format("Any payment registered for ^5%s^3", _source))
          Ora.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if (Ora.Payment.Fake.ALLOWED_PAYMENTS[_source][data.TOKEN] == nil) then
          Ora.Payment:Debug(string.format("Token unknown for ^5%s^3", _source))
          Ora.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if ((os.time() - Ora.Payment.Fake.ALLOWED_PAYMENTS[_source][data.TOKEN].authorized_at) > 60) then
          Ora.Payment:Debug(string.format("Whitelist delay for payment is overdue ^5%s^3 secs", (os.time() - Ora.Payment.Fake.ALLOWED_PAYMENTS[_source][data.TOKEN].authorized_at)))
          Ora.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] Temps de grâce dépassé pour l'obtention d'argent. Possible Use Bug.",
            source,
            true
          )
          return
        end

        if (data.AMOUNT > 20000) then
            Ora.Payment:Debug(string.format("Triggering a screenshot because amount is > ^5%s^3", "20000$"))
            TriggerClientEvent("Ora::CE::General:Snap", _source, {TOKEN = data.TOKEN, SERVER_EVENT = "Ora::SE::Money::AssociateScreenshot"})
        end

        Ora.Payment.Fake:AddToken(data.TOKEN, {AMOUNT = data.AMOUNT, PLAYERID = _source, SOURCE = data.SOURCE})
        TriggerClientEvent("Ora::CE::Money:Fake:AddMoney", _source, data.TOKEN)
    end
)

RegisterServerEvent(Ora.Payment:GetServerEventName() .. ":SERVERSIDE")
AddEventHandler(
    Ora.Payment:GetServerEventName() .. ":SERVERSIDE",
    function(source, data)
        local _source = source
        local newToken = _source .. "-" .. Ora.Payment:GenerateNewToken() .. "-" .. os.time()
        Ora.Payment:AddToken(newToken, {AMOUNT = data.AMOUNT, PLAYERID = _source, SOURCE = data.SOURCE})
        TriggerClientEvent("Ora::CE::Money:AddMoney", _source, newToken)
    end
)

RegisterServerEvent(Ora.Payment.Fake:GetServerEventName() .. ":SERVERSIDE")
AddEventHandler(
    Ora.Payment.Fake:GetServerEventName() .. ":SERVERSIDE",
    function(source, data)
        local _source = source
        local newToken = _source .. "-" .. Ora.Payment.Fake:GenerateNewToken() .. "-" .. os.time()
        Ora.Payment.Fake:AddToken(newToken, {AMOUNT = data.AMOUNT, PLAYERID = _source, SOURCE = data.SOURCE})
        TriggerClientEvent("Ora::CE::Money:Fake:AddMoney", _source, newToken)
    end
)

AddEventHandler(
    "Ora::SE::PlayerLoaded",
    function(source)
        Ora.Payment:PropagateEventName(source)
        Ora.Payment.Fake:PropagateEventName(source)
    end
)

RegisterServerCallback("Ora::SE::Money:RetrieveServerEventName", 
  function(source, cb) 
        Ora.Payment:Debug(string.format("Player ^5%s^3 is asking for ServerEventName", source))
        cb(Ora.Payment:GetServerEventName())
  end
)

RegisterServerCallback("Ora::SE::Money:Fake:RetrieveServerEventName", 
  function(source, cb) 
        Ora.Payment:Debug(string.format("Player ^5%s^3 is asking for ServerEventName", source))
        cb(Ora.Payment.Fake:GetServerEventName())
  end
)


RegisterServerCallback("Ora::SE::Money:RetrieveMoneyFromToken", 
  function(source, cb, token) 
      if (Ora.Payment:VerifyToken(token, source) == true) then
          local tokenData = Ora.Payment:GetTokenData(token)
          Ora.Payment:RemoveToken(token)

          local message = token .. "\nRécupère : " .. tokenData.AMOUNT .. "$ / source : " .. tokenData.SOURCE

          if (tokenData.URL ~= nil) then
                message = message .. "\nScreenshot : " .. tokenData.URL
          end

          if (tokenData.AMOUNT > 5000) then
            TriggerEvent(
                  "Ora:sendToDiscordFromServer",
                  source,
                  26,
                  message,
                  "info"
            )
          end
          Ora.Payment:Debug(string.format("Player ^5%s^3 is retrieving ^5%s^3$", source, tokenData.AMOUNT))

          cb(tokenData.AMOUNT)
      end
  end
)

RegisterServerCallback("Ora::SE::Money:Fake:RetrieveMoneyFromToken", 
  function(source, cb, token) 
      if (Ora.Payment.Fake:VerifyToken(token, source) == true) then
          local tokenData = Ora.Payment.Fake:GetTokenData(token)
          Ora.Payment.Fake:RemoveToken(token)

          local message = token .. "\nRécupère : " .. tokenData.AMOUNT .. "$ / source : " .. tokenData.SOURCE

          if (tokenData.URL ~= nil) then
                message = message .. "\nScreenshot : " .. tokenData.URL
          end

          if (tokenData.AMOUNT > 5000) then
            TriggerEvent(
                  "Ora:sendToDiscordFromServer",
                  source,
                  26,
                  message,
                  "info"
            )
          end
          Ora.Payment:Debug(string.format("Player ^5%s^3 is retrieving ^5%s^3$", source, tokenData.AMOUNT))

          cb(tokenData.AMOUNT)
      end
  end
)

RegisterServerCallback("Ora::SE::Money:AuthorizePayment", 
  function(source, cb, data) 
      if (Ora.Payment.ALLOWED_PAYMENTS[source] == nil) then
        Ora.Payment.ALLOWED_PAYMENTS[source] = {}
      end
        
      if (data.ROUTING ~= nil) then 
        source = data.ROUTING
      end

      local token = source .. "-" .. Ora.Payment:GenerateNewToken() .. "-" .. os.time()
      Ora.Payment.ALLOWED_PAYMENTS[source][token] = {authorized_at = os.time(), verifToken = token}
      cb(token)
  end
)

RegisterServerCallback("Ora::SE::Money:Fake:AuthorizePayment", 
  function(source, cb, data) 
      if (Ora.Payment.Fake.ALLOWED_PAYMENTS[source] == nil) then
        Ora.Payment.Fake.ALLOWED_PAYMENTS[source] = {}
      end
        
      if (data.ROUTING ~= nil) then 
        source = data.ROUTING
      end

      local token = source .. "-" .. Ora.Payment.Fake:GenerateNewToken() .. "-" .. os.time()
      Ora.Payment.Fake.ALLOWED_PAYMENTS[source][token] = {authorized_at = os.time(), verifToken = token}
      cb(token)
  end
)
