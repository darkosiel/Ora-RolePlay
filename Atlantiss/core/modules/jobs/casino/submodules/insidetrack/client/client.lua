local cooldown = 60
local tick = 0
local checkRaceStatus = false
local casinoAudioBank = 'DLC_VINEWOOD/CASINO_GENERAL' -- Do not edit
local animDict, animClip
local chairCoords, chairRotation

local function OpenInsideTrack()
    Atlantiss.Jobs.Casino.Insidetrack.CurrentBet = 100
    if Atlantiss.Jobs.Casino.Insidetrack.InsideTrackActive then
        return
    end

    Atlantiss.Jobs.Casino.Insidetrack.InsideTrackActive = true

    -- Scaleform
    Atlantiss.Jobs.Casino.Insidetrack.Scaleform = RequestScaleformMovie('HORSE_RACING_CONSOLE')

    while not HasScaleformMovieLoaded(Atlantiss.Jobs.Casino.Insidetrack.Scaleform) do
        Wait(0)
    end

    DisplayHud(false)
    SetPlayerControl(PlayerId(), false, 0)

    while not RequestScriptAudioBank(casinoAudioBank) do
        Wait(0)
    end

    Atlantiss.Jobs.Casino.Insidetrack:ShowMainScreen()
    Atlantiss.Jobs.Casino.Insidetrack:SetMainScreenCooldown(cooldown)

    -- Add horses
    Atlantiss.Jobs.Casino.Insidetrack:AddHorses(Atlantiss.Jobs.Casino.Insidetrack.Scaleform)

    Atlantiss.Jobs.Casino.Insidetrack:DrawInsideTrack()
    Atlantiss.Jobs.Casino.Insidetrack:HandleControls()
end

local function LeaveInsideTrack()
    Atlantiss.Jobs.Casino.Insidetrack.InsideTrackActive = false
    DisplayHud(true)
    SetPlayerControl(PlayerId(), true, 0)
    SetScaleformMovieAsNoLongerNeeded(Atlantiss.Jobs.Casino.Insidetrack.Scaleform)
    ReleaseNamedScriptAudioBank(casinoAudioBank)
    Atlantiss.Jobs.Casino.Insidetrack.Scaleform = -1

    local ped = LocalPlayer().Ped
    local animClip = (animClip == "enter_left_readyidle" and "exit_left") or "exit_right"
    local scene = NetworkCreateSynchronisedScene(chairCoords, chairRotation, 2, true, true, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, scene, animDict, animClip, 2.0, -2.0, 13, 16, 1148846080, 0)
    NetworkStartSynchronisedScene(scene)
    Wait(2000)
    NetworkStopSynchronisedScene(scene)
end

function Atlantiss.Jobs.Casino.Insidetrack:DrawInsideTrack()
    Citizen.CreateThread(function()
        while self.InsideTrackActive do
            Wait(0)

            local xMouse, yMouse = GetDisabledControlNormal(2, 239), GetDisabledControlNormal(2, 240)

            -- Fake cooldown
            tick = (tick + 10)

            if (tick == 1000) then
                if (cooldown == 1) then
                    cooldown = 60
                end
                
                cooldown = (cooldown - 1)
                tick = 0

                self:SetMainScreenCooldown(cooldown)
            end
            
            -- Mouse control
            BeginScaleformMovieMethod(self.Scaleform, 'SET_MOUSE_INPUT')
            ScaleformMovieMethodAddParamFloat(xMouse)
            ScaleformMovieMethodAddParamFloat(yMouse)
            EndScaleformMovieMethod()

            -- Draw
            DrawScaleformMovieFullscreen(self.Scaleform, 255, 255, 255, 255)
        end
    end)
end

function Atlantiss.Jobs.Casino.Insidetrack:HandleControls()
    Citizen.CreateThread(function()
        while self.InsideTrackActive do
            Wait(0)

            if IsControlJustPressed(2, 194) then
                LeaveInsideTrack()

                self:HandleBigScreen()
            end

            -- Left click
            if IsControlJustPressed(2, 237) then
                local clickedButton = self:GetMouseClickedButton()

                if self.ChooseHorseVisible then
                    if (clickedButton ~= 12) and (clickedButton ~= -1) then
                        self.CurrentHorse = (clickedButton - 1)
                        local odd = math.tointeger(tonumber(self.HorsesList[self.CurrentHorse])/1)
                        self.CurrentGain = (self.CurrentBet * odd) + self.CurrentBet
                        self:ShowBetScreen(self.CurrentHorse)
                        self.ChooseHorseVisible = false
                    end
                end

                -- Rules button
                if (clickedButton == 15) then
                    self:ShowRules()
                end

                -- Close buttons
                if (clickedButton == 12) then
                    if self.ChooseHorseVisible then
                        self.ChooseHorseVisible = false
                    end
                    
                    if self.BetVisible then
                        self:ShowHorseSelection()
                        self.BetVisible = false
                        self.CurrentHorse = -1
                    else
                        self:ShowMainScreen()
                    end
                end

                -- Start bet
                if (clickedButton == 1) then
                    self:ShowHorseSelection()
                end

                -- Start race
                if (clickedButton == 10) then
                    self.CurrentSoundId = GetSoundId()
                    PlaySoundFrontend(self.CurrentSoundId, 'race_loop', 'dlc_vw_casino_inside_track_betting_single_event_sounds')
                    Atlantiss.Inventory:RemoveAnyItemsFromName("casinopiece", self.CurrentBet)
                    TriggerServerEvent("Atlantiss::SE::NpcJobs:Bank:UpdateMainAccount", "casino", self.CurrentBet * 10, true)
                    self:StartRace()
                    checkRaceStatus = true
                end

                -- Change bet
                if (clickedButton == 8) then
                    if (self.CurrentBet < self.PlayerBalance) then
                        local odd = math.tointeger(tonumber(self.HorsesList[self.CurrentHorse])/1)
                        self.CurrentBet = (self.CurrentBet + 100)
                        self.CurrentGain = (self.CurrentBet * odd) + self.CurrentBet
                        self:UpdateBetValues(self.CurrentHorse, self.CurrentBet, self.PlayerBalance, self.CurrentGain)
                    end
                end

                if (clickedButton == 9) then
                    if (self.CurrentBet > 100) then
                        local odd = math.tointeger(tonumber(self.HorsesList[self.CurrentHorse])/1)
                        self.CurrentBet = self.CurrentBet - 100
                        self.CurrentGain = (self.CurrentBet * odd) + self.CurrentBet
                        self:UpdateBetValues(self.CurrentHorse, self.CurrentBet, self.PlayerBalance, self.CurrentGain)
                    end
                end

                if (clickedButton == 13) then
                    self:ShowMainScreen()
                end

                -- Check race
                while checkRaceStatus do
                    Wait(0)

                    local raceFinished = self:IsRaceFinished()

                    if (raceFinished) then
                        StopSound(self.CurrentSoundId)
                        ReleaseSoundId(self.CurrentSoundId)

                        self.CurrentSoundId = -1

                        if (self.CurrentHorse == self.CurrentWinner) then
                            local givetable = {}
                            for i = 1, self.CurrentGain, 1 do
                                table.insert(givetable, {name = "casinopiece", data = {}})
                            end
                            Atlantiss.Inventory:AddItems(givetable)
                            TriggerServerEvent("Atlantiss::SE::NpcJobs:Bank:UpdateMainAccount", "casino", self.CurrentGain * 10, false)

                            -- Refresh player balance
                            self.PlayerBalance = (self.PlayerBalance + self.CurrentGain)
                            self:UpdateBetValues(self.CurrentHorse, self.CurrentBet, self.PlayerBalance, self.CurrentGain)
                        else
                            self.PlayerBalance = (self.PlayerBalance - self.CurrentBet)
                        end

                        self:ShowResults()

                        self.CurrentHorse = -1
                        self.CurrentWinner = -1
                        self.HorsesPositions = {}

                        checkRaceStatus = false
                    end
                end
            end
        end
    end)
end

RegisterNetEvent("Atlantiss::CE::Jobs::Casino::Insidetrack::Seatchair")
AddEventHandler("Atlantiss::CE::Jobs::Casino::Insidetrack::Seatchair", function(data)
    local ped = LocalPlayer().Ped
    local pCoords = GetEntityCoords(ped)
    chairCoords, chairRotation = GetEntityCoords(data.entity), GetEntityRotation(data.entity) 
    local angle = chairRotation.z - Atlantiss.Jobs.Casino.Insidetrack:FindRotation(chairCoords.x, chairCoords.y, pCoords.x, pCoords.y) + 90.0
    local anim = "anim_casino_a@amb@casino@games@insidetrack@"
    animDict = (Atlantiss.World.Ped:IsPedMale(ped) and anim.."male") or anim.."female"
    animClip = angle < 0 and "enter_left_readyidle" or "enter_right_readyidle"
    Atlantiss.Jobs.Casino.Insidetrack.PlayerBalance = Atlantiss.Inventory:GetItemCount("casinopiece")


    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
      Wait(100)
    end
    local scene = NetworkCreateSynchronisedScene(chairCoords, chairRotation, 2, true, true, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(ped, scene, animDict, animClip, 2.0, -2.0, 13, 16, 1148846080, 0)
    NetworkStartSynchronisedScene(scene)
    Wait(3000)
    OpenInsideTrack()
end)

exports.qtarget:AddTargetModel({-1005355458}, {
    options = {
        {
            event = "Atlantiss::CE::Jobs::Casino::Insidetrack::Seatchair",
            icon = "fas fa-chair",
            label = "S'asseoir pour parier"
        }
    },
    distance = 1.0
})