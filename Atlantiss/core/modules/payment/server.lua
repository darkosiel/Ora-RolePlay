Atlantiss.Payment.EVENT_NAME = nil
Atlantiss.Payment.TOKENS = {}
Atlantiss.Payment.ALLOWED_PAYMENTS = {}

Atlantiss.Payment.Fake.EVENT_NAME = nil
Atlantiss.Payment.Fake.TOKENS = {}
Atlantiss.Payment.Fake.ALLOWED_PAYMENTS = {}


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000 * 120)

    local currentTime = os.time()
    for userId, tokenValues in pairs(Atlantiss.Payment.ALLOWED_PAYMENTS) do
      if (type(tokenValues) == "table") then
        for tokenId, data in pairs(tokenValues) do
          if data.authorized_at + 120 < currentTime then
            Atlantiss.Payment:Debug(string.format("Removed payment authorization for ^5%s^3 token id : ^5%s^3", userId, tokenId))
            Atlantiss.Payment.ALLOWED_PAYMENTS[userId][tokenId] = nil
          end
        end
      end
    end

    for userId, tokenValues in pairs(Atlantiss.Payment.Fake.ALLOWED_PAYMENTS) do
      if (type(tokenValues) == "table") then
        for tokenId, data in pairs(tokenValues) do
          if data.authorized_at + 120 < currentTime then
            Atlantiss.Payment:Debug(string.format("Removed payment authorization for ^5%s^3 token id : ^5%s^3", userId, tokenId))
            Atlantiss.Payment.Fake.ALLOWED_PAYMENTS[userId][tokenId] = nil
          end
        end
      end
    end
  end
end)

function Atlantiss.Payment:PropagateEventName(playerServerId)
    Atlantiss.Payment:Debug(string.format("Propagating event ^5%s^3 to player : ^5%s^3", self:GetServerEventName(), playerServerId))
    TriggerClientEvent("Atlantiss::CE::Money:RegisterEventName", playerServerId, self:GetServerEventName())
end

function Atlantiss.Payment:GetServerEventName()
    if (self.EVENT_NAME == nil) then
        self.EVENT_NAME = self:GenerateServerEventName()
        Atlantiss.Payment:Debug(string.format("Generating server event ^5%s^3", self.EVENT_NAME))
    end

    return self.EVENT_NAME
end

function Atlantiss.Payment:AddToken(token, data)
    Atlantiss.Payment:Debug(string.format("Added token ^5%s^3 to the token list", token))
    self.TOKENS[token] = data
end

function Atlantiss.Payment:VerifyToken(token, source)
    if (self.TOKENS[token] == nil) then
        Atlantiss.Payment:Debug(string.format("Token ^5%s^3 cannot be verified", token))
        return false
    end

    local tokenData = self:GetTokenData(token)

    if (tokenData.PLAYERID ~= nil) then
        Atlantiss.Payment:Debug(string.format("Token ^5%s^3 has been verified", token))
        return true
    end

    Atlantiss.Payment:Debug(string.format("Token ^5%s^3 cannot be verified", token))
    return false
end

function Atlantiss.Payment:GetTokenData(token)
    if (self.TOKENS[token] == nil) then
        Atlantiss.Payment:Debug(string.format("Token ^5%s^3 has no data to be returned", token))
        return {}
    end

    Atlantiss.Payment:Debug(string.format("Returning data for token : ^5%s^3", token))
    return self.TOKENS[token]
end

function Atlantiss.Payment:RemoveToken(token)
    Atlantiss.Payment:Debug(string.format("Removing token : ^5%s^3", token))
    self.TOKENS[token] = nil
end

function Atlantiss.Payment:GenerateServerEventName()
    return "Atlantiss::SE::Money:GiveMoney" .. "-" .. GetGameTimer() .. "-" .. os.time()
end

function Atlantiss.Payment:GenerateNewToken()
    local uuid = nil
    local canSend = false

    TriggerEvent('uuid', function(result)
      uuid = result
      canSend = true
    end)

    while (canSend == false) do Wait(10) end
    Atlantiss.Payment:Debug(string.format("New token : ^5%s^3 has been generated", uuid))
    return uuid
end



function Atlantiss.Payment.Fake:PropagateEventName(playerServerId)
    Atlantiss.Payment:Debug(string.format("Propagating event ^5%s^3 to player : ^5%s^3", self:GetServerEventName(), playerServerId))
    TriggerClientEvent("Atlantiss::CE::Money:Fake:RegisterEventName", playerServerId, self:GetServerEventName())
end

function Atlantiss.Payment.Fake:GetServerEventName()
    if (self.EVENT_NAME == nil) then
        self.EVENT_NAME = self:GenerateServerEventName()
        Atlantiss.Payment:Debug(string.format("Generating server event ^5%s^3", self.EVENT_NAME))
    end

    return self.EVENT_NAME
end

function Atlantiss.Payment.Fake:AddToken(token, data)
    Atlantiss.Payment:Debug(string.format("Added token ^5%s^3 to the token list", token))
    self.TOKENS[token] = data
end

function Atlantiss.Payment.Fake:VerifyToken(token, source)
    if (self.TOKENS[token] == nil) then
        Atlantiss.Payment:Debug(string.format("Token ^5%s^3 cannot be verified", token))
        return false
    end

    local tokenData = self:GetTokenData(token)

    if (tokenData.PLAYERID ~= nil) then
        Atlantiss.Payment:Debug(string.format("Token ^5%s^3 has been verified", token))
        return true
    end

    Atlantiss.Payment:Debug(string.format("Token ^5%s^3 cannot be verified", token))
    return false
end

function Atlantiss.Payment.Fake:GetTokenData(token)
    if (self.TOKENS[token] == nil) then
        Atlantiss.Payment:Debug(string.format("Token ^5%s^3 has no data to be returned", token))
        return {}
    end

    Atlantiss.Payment:Debug(string.format("Returning data for token : ^5%s^3", token))
    return self.TOKENS[token]
end

function Atlantiss.Payment.Fake:RemoveToken(token)
    Atlantiss.Payment:Debug(string.format("Removing token : ^5%s^3", token))
    self.TOKENS[token] = nil
end

function Atlantiss.Payment.Fake:GenerateServerEventName()
    return "Atlantiss::SE::Money:Fake:GiveMoney" .. "-" .. GetGameTimer() .. "-" .. os.time()
end

function Atlantiss.Payment.Fake:GenerateNewToken()
    local uuid = nil
    local canSend = false

    TriggerEvent('uuid', function(result)
      uuid = result
      canSend = true
    end)

    while (canSend == false) do Wait(10) end
    Atlantiss.Payment:Debug(string.format("New token : ^5%s^3 has been generated", uuid))
    return uuid
end

RegisterServerEvent("Atlantiss::SE::Money::AssociateScreenshot")
AddEventHandler(
    "Atlantiss::SE::Money::AssociateScreenshot",
    function(data)
        local _source = source
            Atlantiss.Payment:Debug(string.format("Screenshot has been associated with token ^5%s^3 and url is : ^5%s^3", data.TOKEN, data.PICTURE_URL))
            TriggerEvent(
                  "atlantiss:sendToDiscordFromServer",
                  source,
                  26,
                  data.TOKEN .. "\n[Voir le screenshot](".. data.PICTURE_URL ..")",
                  "info"
            )
    end
)

RegisterServerEvent(Atlantiss.Payment:GetServerEventName())
AddEventHandler(
    Atlantiss.Payment:GetServerEventName(),
    function(data)
        local _source = source

        if (data.ROUTING ~= nil) then 
            _source = data.ROUTING
        end

        if (data.TOKEN == nil) then
          Atlantiss.Payment:Debug(string.format("No data token provided"))
          Atlantiss.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if Atlantiss.Payment.ALLOWED_PAYMENTS[_source] == nil then
          Atlantiss.Payment:Debug(string.format("Any payment registered for ^5%s^3", _source))
          Atlantiss.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if Atlantiss.Payment.ALLOWED_PAYMENTS[_source][data.TOKEN] == nil then
          Atlantiss.Payment:Debug(string.format("Token unknown for ^5%s^3", _source))
          Atlantiss.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if ((os.time() - Atlantiss.Payment.ALLOWED_PAYMENTS[_source][data.TOKEN].authorized_at) > 60) then
          Atlantiss.Payment:Debug(string.format("Whitelist delay for payment is overdue ^5%s^3 secs", (os.time() - Atlantiss.Payment.ALLOWED_PAYMENTS[_source][data.TOKEN].authorized_at)))
          Atlantiss.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] Temps de grâce dépassé pour l'obtention d'argent. Possible Use Bug.",
            source,
            true
          )
          return
        end

        if (data.AMOUNT > 20000) then
            Atlantiss.Payment:Debug(string.format("Triggering a screenshot because amount is > ^5%s^3", "20000$"))
            TriggerClientEvent("Atlantiss::CE::General:Snap", _source, {TOKEN = data.TOKEN, SERVER_EVENT = "Atlantiss::SE::Money::AssociateScreenshot"})
        end

        Atlantiss.Payment:AddToken(data.TOKEN, {AMOUNT = data.AMOUNT, PLAYERID = _source, SOURCE = data.SOURCE})
        TriggerClientEvent("Atlantiss::CE::Money:AddMoney", _source, data.TOKEN)
    end
)

RegisterServerEvent(Atlantiss.Payment.Fake:GetServerEventName())
AddEventHandler(
    Atlantiss.Payment.Fake:GetServerEventName(),
    function(data)
      local _source = source

        if (data.ROUTING ~= nil) then 
            _source = data.ROUTING
        end

        if (data.TOKEN == nil) then
          Atlantiss.Payment:Debug(string.format("No data token provided"))
          Atlantiss.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if (Atlantiss.Payment.Fake.ALLOWED_PAYMENTS[_source] == nil) then
          Atlantiss.Payment:Debug(string.format("Any payment registered for ^5%s^3", _source))
          Atlantiss.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if (Atlantiss.Payment.Fake.ALLOWED_PAYMENTS[_source][data.TOKEN] == nil) then
          Atlantiss.Payment:Debug(string.format("Token unknown for ^5%s^3", _source))
          Atlantiss.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
            source,
            true
          )
          return
        end

        if ((os.time() - Atlantiss.Payment.Fake.ALLOWED_PAYMENTS[_source][data.TOKEN].authorized_at) > 60) then
          Atlantiss.Payment:Debug(string.format("Whitelist delay for payment is overdue ^5%s^3 secs", (os.time() - Atlantiss.Payment.Fake.ALLOWED_PAYMENTS[_source][data.TOKEN].authorized_at)))
          Atlantiss.Anticheat:YieldGenericMessage(
            "[POTENTIAL USEBUG] Temps de grâce dépassé pour l'obtention d'argent. Possible Use Bug.",
            source,
            true
          )
          return
        end

        if (data.AMOUNT > 20000) then
            Atlantiss.Payment:Debug(string.format("Triggering a screenshot because amount is > ^5%s^3", "20000$"))
            TriggerClientEvent("Atlantiss::CE::General:Snap", _source, {TOKEN = data.TOKEN, SERVER_EVENT = "Atlantiss::SE::Money::AssociateScreenshot"})
        end

        Atlantiss.Payment.Fake:AddToken(data.TOKEN, {AMOUNT = data.AMOUNT, PLAYERID = _source, SOURCE = data.SOURCE})
        TriggerClientEvent("Atlantiss::CE::Money:Fake:AddMoney", _source, data.TOKEN)
    end
)

RegisterServerEvent(Atlantiss.Payment:GetServerEventName() .. ":SERVERSIDE")
AddEventHandler(
    Atlantiss.Payment:GetServerEventName() .. ":SERVERSIDE",
    function(source, data)
        local _source = source
        local newToken = _source .. "-" .. Atlantiss.Payment:GenerateNewToken() .. "-" .. os.time()
        Atlantiss.Payment:AddToken(newToken, {AMOUNT = data.AMOUNT, PLAYERID = _source, SOURCE = data.SOURCE})
        TriggerClientEvent("Atlantiss::CE::Money:AddMoney", _source, newToken)
    end
)

RegisterServerEvent(Atlantiss.Payment.Fake:GetServerEventName() .. ":SERVERSIDE")
AddEventHandler(
    Atlantiss.Payment.Fake:GetServerEventName() .. ":SERVERSIDE",
    function(source, data)
        local _source = source
        local newToken = _source .. "-" .. Atlantiss.Payment.Fake:GenerateNewToken() .. "-" .. os.time()
        Atlantiss.Payment.Fake:AddToken(newToken, {AMOUNT = data.AMOUNT, PLAYERID = _source, SOURCE = data.SOURCE})
        TriggerClientEvent("Atlantiss::CE::Money:Fake:AddMoney", _source, newToken)
    end
)

AddEventHandler(
    "Atlantiss::SE::PlayerLoaded",
    function(source)
        Atlantiss.Payment:PropagateEventName(source)
        Atlantiss.Payment.Fake:PropagateEventName(source)
    end
)

RegisterServerCallback("Atlantiss::SE::Money:RetrieveServerEventName", 
  function(source, cb) 
        Atlantiss.Payment:Debug(string.format("Player ^5%s^3 is asking for ServerEventName", source))
        cb(Atlantiss.Payment:GetServerEventName())
  end
)

RegisterServerCallback("Atlantiss::SE::Money:Fake:RetrieveServerEventName", 
  function(source, cb) 
        Atlantiss.Payment:Debug(string.format("Player ^5%s^3 is asking for ServerEventName", source))
        cb(Atlantiss.Payment.Fake:GetServerEventName())
  end
)


RegisterServerCallback("Atlantiss::SE::Money:RetrieveMoneyFromToken", 
  function(source, cb, token) 
      if (Atlantiss.Payment:VerifyToken(token, source) == true) then
          local tokenData = Atlantiss.Payment:GetTokenData(token)
          Atlantiss.Payment:RemoveToken(token)

          local message = token .. "\nRécupère : " .. tokenData.AMOUNT .. "$ / source : " .. tokenData.SOURCE

          if (tokenData.URL ~= nil) then
                message = message .. "\nScreenshot : " .. tokenData.URL
          end

          if (tokenData.AMOUNT > 5000) then
            TriggerEvent(
                  "atlantiss:sendToDiscordFromServer",
                  source,
                  26,
                  message,
                  "info"
            )
          end
          Atlantiss.Payment:Debug(string.format("Player ^5%s^3 is retrieving ^5%s^3$", source, tokenData.AMOUNT))

          cb(tokenData.AMOUNT)
      end
  end
)

RegisterServerCallback("Atlantiss::SE::Money:Fake:RetrieveMoneyFromToken", 
  function(source, cb, token) 
      if (Atlantiss.Payment.Fake:VerifyToken(token, source) == true) then
          local tokenData = Atlantiss.Payment.Fake:GetTokenData(token)
          Atlantiss.Payment.Fake:RemoveToken(token)

          local message = token .. "\nRécupère : " .. tokenData.AMOUNT .. "$ / source : " .. tokenData.SOURCE

          if (tokenData.URL ~= nil) then
                message = message .. "\nScreenshot : " .. tokenData.URL
          end

          if (tokenData.AMOUNT > 5000) then
            TriggerEvent(
                  "atlantiss:sendToDiscordFromServer",
                  source,
                  26,
                  message,
                  "info"
            )
          end
          Atlantiss.Payment:Debug(string.format("Player ^5%s^3 is retrieving ^5%s^3$", source, tokenData.AMOUNT))

          cb(tokenData.AMOUNT)
      end
  end
)

RegisterServerCallback("Atlantiss::SE::Money:AuthorizePayment", 
  function(source, cb, data) 
      if (Atlantiss.Payment.ALLOWED_PAYMENTS[source] == nil) then
        Atlantiss.Payment.ALLOWED_PAYMENTS[source] = {}
      end
        
      if (data.ROUTING ~= nil) then 
        source = data.ROUTING
      end

      local token = source .. "-" .. Atlantiss.Payment:GenerateNewToken() .. "-" .. os.time()
      Atlantiss.Payment.ALLOWED_PAYMENTS[source][token] = {authorized_at = os.time(), verifToken = token}
      cb(token)
  end
)

RegisterServerCallback("Atlantiss::SE::Money:Fake:AuthorizePayment", 
  function(source, cb, data) 
      if (Atlantiss.Payment.Fake.ALLOWED_PAYMENTS[source] == nil) then
        Atlantiss.Payment.Fake.ALLOWED_PAYMENTS[source] = {}
      end
        
      if (data.ROUTING ~= nil) then 
        source = data.ROUTING
      end

      local token = source .. "-" .. Atlantiss.Payment.Fake:GenerateNewToken() .. "-" .. os.time()
      Atlantiss.Payment.Fake.ALLOWED_PAYMENTS[source][token] = {authorized_at = os.time(), verifToken = token}
      cb(token)
  end
)
