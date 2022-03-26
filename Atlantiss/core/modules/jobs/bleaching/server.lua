RegisterNetEvent("Atlantiss::SE::Job::Bleacher::BleachingMoney")
AddEventHandler(
  "Atlantiss::SE::Job::Bleacher::BleachingMoney",
  function(count)
    local currTime = os.date("*t")

    table.insert(Atlantiss.Jobs.Bleacher.CurrentBleachings, {
      VALUE = math.floor(count * Atlantiss.Jobs.Bleacher.Tax),
      TIMESTAMP = string.format("%s:%s", currTime.hour, currTime.min),
      TIME = GetGameTimer() + (60000 * Atlantiss.Jobs.Bleacher.BleachingTime),
      INITIALVALUE = count
    })
  end
)

RegisterNetEvent("Atlantiss::SE::Job::Bleacher::RetreiveBleaching")
AddEventHandler(
  "Atlantiss::SE::Job::Bleacher::RetreiveBleaching",
  function(id)
    local src = source

    if (not Atlantiss.Jobs.Bleacher.CurrentBleachings[id]) then
      return Atlantiss.Anticheat:YieldGenericMessage(
        "[POTENTIAL CHEAT/USEBUG] L'utilisateur demande un paiement qui n'est pas enregistré dans le systeme.",
        src,
        true
      )
    end

    TriggerEvent(
      Atlantiss.Payment:GetServerEventName() .. ":SERVERSIDE",
      src,
      {
        AMOUNT = Atlantiss.Jobs.Bleacher.CurrentBleachings[id].VALUE,
        SOURCE = "Blanchiment d'argent",
        LEGIT = true
      }
    )

    TriggerClientEvent("RageUI:Popup", src, {message = "~b~Tiens, voilà tes $" .. Atlantiss.Jobs.Bleacher.CurrentBleachings[id].VALUE .. " en propre"})
    table.remove(Atlantiss.Jobs.Bleacher.CurrentBleachings, id)
  end
)


RegisterServerCallback(
  "Atlantiss::SVCB::Job::Bleacher::CanBleach",
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
  "Atlantiss::SVCB::Job::Bleacher::GetFinishedList",
  function(source, callback)
    local finishedOnes = {}

    for id, bleaching in ipairs(Atlantiss.Jobs.Bleacher.CurrentBleachings) do
      if (bleaching.TIME - GetGameTimer() <= 0) then
        table.insert(finishedOnes, Atlantiss.Jobs.Bleacher.CurrentBleachings[id])
      end
    end

    callback(finishedOnes)
  end
)
