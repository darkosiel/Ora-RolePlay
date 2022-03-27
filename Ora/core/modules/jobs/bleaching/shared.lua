Ora.Jobs.Bleacher = {}
Ora.Jobs.Bleacher.CurrentBleachings = {}
Ora.Jobs.Bleacher.Pos = vector3(639.48, 2772.1, 42.04)
Ora.Jobs.Bleacher.Tax = 0.9 -- percentage of what's gonna be given after the bleaching
Ora.Jobs.Bleacher.BleachingTime = 60 -- in minutes

function Ora.Jobs.Bleacher:GetJobName()
  return "Bleacher"
end

function Ora.Jobs.Bleacher:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Ora.Jobs:GetModuleName(), Ora.Jobs.Bleacher:GetJobName(), message))
  end
end

Ora.Jobs:Register(Ora.Jobs.Bleacher:GetJobName())
