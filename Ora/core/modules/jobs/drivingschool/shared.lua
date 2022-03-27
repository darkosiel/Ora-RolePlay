Ora.Jobs.DrivingSchool = {}


function Ora.Jobs.DrivingSchool:GetJobName()
  return "DrivingSchool"
end

function Ora.Jobs.DrivingSchool:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Ora.Jobs:GetModuleName(), Ora.Jobs.DrivingSchool:GetJobName(), message))
  end
end

Ora.Jobs:Register(Ora.Jobs.DrivingSchool:GetJobName())
