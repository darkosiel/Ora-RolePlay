local webhookreport = 13

RegisterServerEvent("addReportMenuS")
AddEventHandler("addReportMenuS",function(message, job, orga)
  local date = os.date("%d/%m/%y %X")
  TriggerClientEvent("addReportMenu", -1, source, Ora.Identity:GetFullname(source), message, date, job, orga)
end)

RegisterServerEvent("sendMessageReport")
AddEventHandler("sendMessageReport",function(id, msg)
  TriggerClientEvent("RageUI:Popup", id,{message = "~r~Staff : ~s~"..msg})
end)

RegisterServerEvent("closeReportS")
AddEventHandler("closeReportS",function(index)
  TriggerClientEvent("RageUI:Popup", source,{message = "~b~Report numéro #"..index.." clôturé."})
  TriggerClientEvent("closeReport", -1, index)
  TriggerEvent("Ora:sendToDiscordFromServer", source, webhookreport, Ora.Identity:GetFullname(source) .." a clôturé le ticket n°"..index, "info")
end)

RegisterServerEvent("takeReportS")
AddEventHandler("takeReportS",function(index, id, name, msg, date, status)
  local who = Ora.Identity:GetFullname(source)
  TriggerClientEvent("takeReport", -1, index, id, name, msg, date, who, status)
  if status == "true" then pris = " a pris en charge le ticket n°" else pris = " ne prend plus en charge le ticket n°" end
  TriggerEvent("Ora:sendToDiscordFromServer", source, webhookreport, Ora.Identity:GetFullname(source) ..pris..index.." de "..name, "info")
end)