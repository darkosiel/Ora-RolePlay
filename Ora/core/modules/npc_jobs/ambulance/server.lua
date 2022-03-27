
RegisterServerEvent("Ora::SE::Job::Ambulance:AllowNPCAmbulance")
AddEventHandler(
    "Ora::SE::Job::Ambulance:AllowNPCAmbulance",
    function(data)
      Ora.NpcJobs.Ambulance.IS_ALLOWED = data.IS_ALLOWED
    end
)


RegisterServerCallback("Ora::SE::Job::Ambulance:IsAllowedNPCAmbulance", 
  function(source, cb) 
      cb(Ora.NpcJobs.Ambulance.IS_ALLOWED)
  end
)
