Ora.Jobs.Casino.Insidetrack = {
    Scaleform = -1,
    ChooseHorseVisible = false,
    BetVisible = false,
    PlayerBalance = 0,
    CurrentHorse = -1,
    CurrentBet = 100,
    CurrentGain = 200,
    HorsesList = {},
    HorsesPositions = {},
    OddsList = {},
    RandomHorse = {},
    CurrentWiner = -1,
    CurrentSoundId = -1,
    InsideTrackActive = false,
    BigScreen = {
        enable = true, -- Set it to false if you don't need the big screen
        coords = vector3(973.41, 83.39, 69.66)
    }
}

function Ora.Jobs.Casino.Insidetrack:GetMouseClickedButton()
    local returnValue = -1

    CallScaleformMovieMethodWithNumber(self.Scaleform, 'SET_INPUT_EVENT', 237.0, -1082130432, -1082130432, -1082130432, -1082130432)
    BeginScaleformMovieMethod(self.Scaleform, 'GET_CURRENT_SELECTION')

    returnValue = EndScaleformMovieMethodReturnValue()

    while not IsScaleformMovieMethodReturnValueReady(returnValue) do
        Wait(0)
    end

    return GetScaleformMovieMethodReturnValueInt(returnValue)
end

function Ora.Jobs.Casino.Insidetrack.GetRandomHorseName()
    local random = math.random(0, 99)
    local randomName = (random < 10) and ('ITH_NAME_00'..random) or ('ITH_NAME_0'..random)

    return randomName
end

function Ora.Jobs.Casino.Insidetrack:FindRotation(x1, y1, x2, y2)
    local t = -math.deg(math.atan2(x2-x1, y2-y1))
    return t < -180 and t + 180 or t
end