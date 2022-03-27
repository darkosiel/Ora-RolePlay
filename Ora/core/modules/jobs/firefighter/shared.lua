Ora.Jobs.Firefighter = {}
Ora.Jobs.Firefighter.Config = {}
Ora.Jobs.Firefighter.Config.Fire = {
    fireSpreadChance = 5, -- Out of 100 chances, how many lead to fire spreading? (not exactly percents)
    maximumSpreads = 8,
    selfRemoveMIN = 2700000, -- in ms, 45min, the min time a fire can burn (random between min and max)
    selfRemoveMAX = 4500000, -- in ms, 1h15, the max time a fire can burn
    spawner = { -- Requires the use of the built-in dispatch system
        enableOnStartup = true,
        interval = 1800000, -- Random fire spawn interval (set to nil or false if you don't want to spawn random fires) in ms
        chance = 70, -- Fire spawn chance (out of 100 chances, how many lead to spawning a fire?); Set to values between 1-100
        players = 1, -- Sets the minimum number of players subscribed to dispatch for the spawner to spawn fires.
        firefighterJobs = { -- Specify which players will count as firefighters in Config.Fire.spawner.players above and be subscribed to the dispatch
            ["lsfd"] = true -- Always set the job name in the key, value has to be true
        }
    }
}
Ora.Jobs.Firefighter.Config.Dispatch = {
    enabled = true, -- Set this to false if you don't want to use the default dispatch system
    timeout = 15000, -- The amount of time in ms to delay the dispatch after the fire has been created
    storeLast = 5, -- The client will store the last five dispatch coordinates for use with /remindme <dispatchNumber>
    clearGpsRadius = 20.0, -- If you don't want to automatically clear the route upon arrival, leave this to false
    removeBlipTimeout = 120000, -- The amount of time in ms after which the dispatch call blip will be automatically removed
    playSound = false
}


function Ora.Jobs.Firefighter:GetJobName()
  return "Firefighter"
end

function Ora.Jobs.Firefighter:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Ora.Jobs:GetModuleName(), Ora.Jobs.Firefighter:GetJobName(), message))
  end
end

Ora.Jobs:Register(Ora.Jobs.Firefighter:GetJobName())
