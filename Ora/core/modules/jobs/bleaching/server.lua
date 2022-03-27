RegisterNetEvent("Ora::SE::Job::Bleacher::BleachingMoney")
AddEventHandler(
  "Ora::SE::Job::Bleacher::BleachingMoney",
  function(count)
    local currTime = os.date("*t")

    table.insert(Ora.Jobs.Bleacher.CurrentBleachings, {
      VALUE = math.floor(count * Ora.Jobs.Bleacher.Tax),
      TIMESTAMP = string.format("%s:%s", currTime.hour, currTime.min),
      TIME = GetGameTimer() + (60000 * Ora.Jobs.Bleacher.BleachingTime),
      INITIALVALUE = count
    })
  end
)

RegisterNetEvent("Ora::SE::Job::Bleacher::RetreiveBleaching")
AddEventHandler(
  "Ora::SE::Job::Bleacher::RetreiveBleaching",
  function(id)
    local src = source

    if (not Ora.Jobs.Bleacher.CurrentBleachings[id]) then
      return Ora.Anticheat:YieldGenericMessage(
        "[POTENTIAL CHEAT/USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
        src,
        true
      )
    end

    TriggerEvent(
      Ora.Payment:GetServerEventName() .. ":SERVERSIDE",
      src,
      {
        AMOUNT = Ora.Jobs.Bleacher.CurrentBleachings[id].VALUE,
        SOURCE = "Blanchiment d'argent",
        LEGIT = true
      }
    )

    TriggerClientEvent("RageUI:Popup", src, {message = "~b~Tiens, voilà tes $" .. Ora.Jobs.Bleacher.CurrentBleachings[id].VALUE .. " en propre"})
    table.remove(Ora.Jobs.Bleacher.CurrentBleachings, id)
  end
)


RegisterServerCallback(
  "Ora::SVCB::Job::Bleacher::CanBleach",
  function(source, callback, count)
    local currTime = os.date("*t")

    if (currTime.hour == 18 or (currTime.hour == 17 and currTime.min >= 45)) then
      return callback(false, "~r~J'ai plus le temps de gérer ça, une tempête arrive, reviens ce soir")
		end

    if (count < 1000) then
      return callback(false, "~r~Je prends pas moins de $1000")
    end

    callback(true)
  end
)

RegisterServerCallback(
  "Ora::SVCB::Job::Bleacher::GetFinishedList",
  function(source, callback)
    local finishedOnes = {}

    for id, bleaching in ipairs(Ora.Jobs.Bleacher.CurrentBleachings) do
      if (bleaching.TIME - GetGameTimer() <= 0) then
        table.insert(finishedOnes, Ora.Jobs.Bleacher.CurrentBleachings[id])
      end
    end

    callback(finishedOnes)
  end
)
