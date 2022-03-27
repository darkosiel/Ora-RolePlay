Ora.Player = {}

Ora.Player.SessionDataMapper = {
  ["SALARY_DETAILS"] = function(value) 
    local message = ""
    message = message .. "\n**DETAIL DES SALAIRES**\n"
    if (type(value) == "string") then
        message = message .. value .. "\n"
    end
    if (type(value) == "table") then
        message = message .. "\n```markdown\n"
        for key2, value2 in pairs(value) do
            message = message .. "* " .. value2 .. "\n"
        end
        message = message .. "\n```"
    end

    return message
  end,
  ["SALARY_TOTAL"] = function(value) 
    local total = 0
    for key2, value2 in pairs(value) do
      total = total + value2
    end
    local message = "\n\n**Total salaire reçu : ".. total .."$**\n"
    return message
  end
}

Ora.Player.State = {
  CANT_RUN = false,
  CANT_SHOOT = false,
  FREEZED = false,
  STEALING = false,
  CREATED = false,
}

function Ora.Player:GetModuleName()
  return "Player"
end

function Ora.Player:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Ora:GetServerName(), Ora.Player:GetModuleName(), message))
  end
end

Ora.Modules:Register(Ora.Player:GetModuleName())