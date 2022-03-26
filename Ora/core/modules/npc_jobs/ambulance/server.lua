
RegisterServerEvent("Atlantiss::SE::Job::Ambulance:AllowNPCAmbulance")
AddEventHandler(
    "Atlantiss::SE::Job::Ambulance:AllowNPCAmbulance",
    function(data)
      Atlantiss.NpcJobs.Ambulance.IS_ALLOWED = data.IS_ALLOWED
    end
)


RegisterServerCallback("Atlantiss::SE::Job::Ambulance:IsAllowedNPCAmbulance", 
  function(source, cb) 
      cb(Atlantiss.NpcJobs.Ambulance.IS_ALLOWED)
  end
)
