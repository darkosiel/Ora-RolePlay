Atlantiss.Jobs.Bleacher = {}
Atlantiss.Jobs.Bleacher.CurrentBleachings = {}
Atlantiss.Jobs.Bleacher.Pos = vector3(639.48, 2772.1, 42.04)
Atlantiss.Jobs.Bleacher.Tax = 0.9 -- percentage of what's gonna be given after the bleaching
Atlantiss.Jobs.Bleacher.BleachingTime = 60 -- in minutes

function Atlantiss.Jobs.Bleacher:GetJobName()
  return "Bleacher"
end

function Atlantiss.Jobs.Bleacher:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Atlantiss.Jobs:GetModuleName(), Atlantiss.Jobs.Bleacher:GetJobName(), message))
  end
end

Atlantiss.Jobs:Register(Atlantiss.Jobs.Bleacher:GetJobName())
