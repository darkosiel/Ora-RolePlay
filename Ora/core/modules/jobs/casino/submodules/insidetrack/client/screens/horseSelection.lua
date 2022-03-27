local function IsOddsAvailable(odds)
    for i = 1, #Ora.Jobs.Casino.Insidetrack.OddsList, 1 do
        if Ora.Jobs.Casino.Insidetrack.OddsList[i] == odds then
            return false
        end
    end
    return true
end

local function GenerateOdds(i)
    local odds = tostring(math.random(i*3) + 1)
    if IsOddsAvailable(odds) then
        table.insert(Ora.Jobs.Casino.Insidetrack.OddsList, odds)
        return odds
    else
        return GenerateOdds(i)
    end
end

local function AddHorseOddToRandomPick(horse, odd)
    local chance = math.round((1/math.tointeger(odd))*100, 0)
    for i = 1, chance, 1 do
        table.insert(Ora.Jobs.Casino.Insidetrack.RandomHorse, horse)
    end
end

function Ora.Jobs.Casino.Insidetrack:ShowHorseSelection()
    self.ChooseHorseVisible = true

    BeginScaleformMovieMethod(self.Scaleform, 'SHOW_SCREEN')
    ScaleformMovieMethodAddParamInt(1)
    EndScaleformMovieMethod()
end

function Ora.Jobs.Casino.Insidetrack:AddHorses(scaleform)
    self.HorsesList = {}
    self.OddsList = {}
    self.RandomHorse = {}

    for i = 1, 6 do
        local name = self.GetRandomHorseName()
        local odds = GenerateOdds(i)

        BeginScaleformMovieMethod(scaleform, 'SET_HORSE')
        ScaleformMovieMethodAddParamInt(i) -- Horse index

        -- Horse name
        BeginTextCommandScaleformString(name)
        EndTextCommandScaleformString()

        ScaleformMovieMethodAddParamPlayerNameString((odds.."/1"))

        -- Horse style (TODO: Random preset, different one for each horse)
        ScaleformMovieMethodAddParamInt(self.HorseStyles[i][1])
        ScaleformMovieMethodAddParamInt(self.HorseStyles[i][2])
        ScaleformMovieMethodAddParamInt(self.HorseStyles[i][3])
        ScaleformMovieMethodAddParamInt(self.HorseStyles[i][4])
        EndScaleformMovieMethod()

        table.insert(self.HorsesList, i, odds)
        AddHorseOddToRandomPick(i, odds)
    end
end