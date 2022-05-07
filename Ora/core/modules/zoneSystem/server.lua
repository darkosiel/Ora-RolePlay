Ora.ZoneSystem.HowMuchPlayersNear = function(position, MaxDistance)
  local res = 0

  for _, plyID in ipairs(GetPlayers()) do
    if (#(position - GetEntityCoords(GetPlayerPed(plyID))) < MaxDistance) then
      res = res + 1
    end
  end

  return res
end


Citizen.CreateThread(
  function()
    while true do
      Wait(Ora.ZoneSystem.WaitTime)

      for i = 1, Ora.Utils:TableLength(Ora.ZoneSystem.OpenHours) do
        if (tonumber(os.date("%H", os.time())) == Ora.ZoneSystem.OpenHours[i]) then
          for name, bar in pairs(Ora.ZoneSystem.Bars) do
            local count = Ora.ZoneSystem.HowMuchPlayersNear(bar.Pos, bar.MaxDistance)

            if (count > 0) then
              local pay = count * bar.MoneyPerHour

              TriggerEvent("Ora:AddFromBankAccount", Jobs[bar.JobName].iban, pay)
              TriggerEvent(
                "newTransaction",
                "Client(s)",
                Jobs[bar.JobName].label2,
                pay,
                string.format("Vente(s) dans la soirée pour %s client(s).", count),
                ""
              )

              if (Ora.ZoneSystem.PrintStuff) then
                print(string.format("Le bar %s a été payé $%s pour un nombre total de %s client(s).", name, pay, count))
              end
            end
          end

          goto continue
        end
      end

      ::continue::
    end
  end
)
