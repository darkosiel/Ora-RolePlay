Atlantiss.Jobs.DrivingSchool = {}


function Atlantiss.Jobs.DrivingSchool:GetJobName()
  return "DrivingSchool"
end

function Atlantiss.Jobs.DrivingSchool:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Atlantiss.Jobs:GetModuleName(), Atlantiss.Jobs.DrivingSchool:GetJobName(), message))
  end
end

Atlantiss.Jobs:Register(Atlantiss.Jobs.DrivingSchool:GetJobName())
