local function IsPositionAvailable(horse)
    for i = 1, #Atlantiss.Jobs.Casino.Insidetrack.HorsesPositions do
        if (Atlantiss.Jobs.Casino.Insidetrack.HorsesPositions[i] == horse) then
            return false
        end
    end
    return true
end

local function GenerateHorsesOrder()
    while (#Atlantiss.Jobs.Casino.Insidetrack.HorsesPositions < 6) do
        Wait(0)
        for i = 1, 6 do
            local horse = Atlantiss.Jobs.Casino.Insidetrack.RandomHorse[math.random(#Atlantiss.Jobs.Casino.Insidetrack.RandomHorse)]    
            if IsPositionAvailable(horse) then
                table.insert(Atlantiss.Jobs.Casino.Insidetrack.HorsesPositions, horse)
            end
        end
    end
end

function Atlantiss.Jobs.Casino.Insidetrack:StartRace()
    GenerateHorsesOrder()

    self.CurrentWinner = self.HorsesPositions[1]

    BeginScaleformMovieMethod(self.Scaleform, 'START_RACE')
    ScaleformMovieMethodAddParamFloat(15000.0) -- Race duration (in MS)
    ScaleformMovieMethodAddParamInt(4)

    -- Add each horses by their index (win order)
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[1])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[2])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[3])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[4])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[5])
    ScaleformMovieMethodAddParamInt(self.HorsesPositions[6])

    ScaleformMovieMethodAddParamFloat(0.0) -- Unk
    ScaleformMovieMethodAddParamBool(false)
    EndScaleformMovieMethod()
end

function Atlantiss.Jobs.Casino.Insidetrack:IsRaceFinished()
    BeginScaleformMovieMethod(self.Scaleform, 'GET_RACE_IS_COMPLETE')

    local raceReturnValue = EndScaleformMovieMethodReturnValue()

    while not IsScaleformMovieMethodReturnValueReady(raceReturnValue) do
        Wait(0)
    end

    return GetScaleformMovieMethodReturnValueBool(raceReturnValue)
end