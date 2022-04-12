CurrentMovementAnim = nil
CurrentMovementShouldSqeak = false
local CourtCenter = vector3(-773.1, 153.71000000001, 67.47)
local BlockControlUntil = 0

-- court activator/finder
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for _, courtData in pairs(TennisCourts) do
            if #(coords - courtData.courtCenter) < 50.0 then
                courtData.isActive = true
            else
                courtData.isActive = false
            end
            Wait(0)
        end

        Wait(1000)
    end
end)

function GetServeExtremePoints(courtCenter, courtHeading, courtLength, courtWidth, side)
    local sideOffsetHeading = 0

    if side == CONST_SIDE_A then
        sideOffsetHeading = 180.0
    end

    local centerPoint1 = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading - 90.0 + sideOffsetHeading)) * (courtLength-2.0), 
        courtCenter.y + math.sin(math.rad(courtHeading - 90.0 + sideOffsetHeading)) * (courtLength-2.0),
        courtCenter.z
    )
    local centerPoint2 = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading - 90.0 + sideOffsetHeading)) * (courtLength+3.0), 
        courtCenter.y + math.sin(math.rad(courtHeading - 90.0 + sideOffsetHeading)) * (courtLength+3.0),
        courtCenter.z
    )

    local rightPoint1 = vector3(
        centerPoint1.x + math.cos(math.rad(courtHeading + sideOffsetHeading)) * (courtWidth/2 + 0.75), 
        centerPoint1.y + math.sin(math.rad(courtHeading + sideOffsetHeading)) * (courtWidth/2 + 0.75),
        centerPoint1.z
    )

    local rightPoint2 = vector3(
        centerPoint2.x + math.cos(math.rad(courtHeading + sideOffsetHeading)) * (courtWidth/2 + 0.75), 
        centerPoint2.y + math.sin(math.rad(courtHeading + sideOffsetHeading)) * (courtWidth/2 + 0.75),
        centerPoint2.z
    )

    return {centerPoint1, centerPoint2}, {rightPoint1, rightPoint2}
end

function HandleServingFuly(ped, courtPtr, side)
    TaskPlayAnim(ped, 'mini@tennis', 'serve_idle_01', 4.0, 4.0, -1, 1, 1.0, false, false, false)
    local scaleformData = SetupServingScaleformFully()

    while PlayerSettings do
        Wait(0)

        DisablePlayerFiring(PlayerId(), true)
        DisableAllControlActions(0)
        EnableControlAction(0, 249, true)
        EnableControlAction(0, 245, true)

        EnableControlAction(0, 0, true) -- mouse
        EnableControlAction(0, 1, true) -- mouse
        EnableControlAction(0, 2, true) -- mouse
        
        local finalHeading = courtPtr.courtHeading + (side == CONST_SIDE_A and 180.0 or 0.0)
        SetEntityHeading(ped, finalHeading)

        local isLeftClick = IsDisabledControlJustPressed(0, 24)
        local isA = IsDisabledControlPressed(0, 34)
        local isD = IsDisabledControlPressed(0, 35)

        local leftmost, rightmost = GetServeExtremePoints(courtPtr.courtCenter, courtPtr.courtHeading, courtPtr.courtLength, courtPtr.courtWidth, side)
        
        if GetGameTimer() > BlockControlUntil then
            if isLeftClick then
                PlayMovementAnim(ped, 'serve', true, true) -- strafe_lft
                local clickedStartAt = GetGameTimer()
                local isHitSubmitted = false

                while true do
                    Wait(0)

                    local timePassed = (GetGameTimer() - clickedStartAt)

                    if timePassed <= 3550 then
                        if timePassed > 1000 then
                            HandleServingScaleformTick(scaleformData)
                        end

                        if not scaleformData.isServing and not scaleformData.finalStrength and timePassed > 2000 then
                            scaleformData.isServing = true
                        end

                        if scaleformData.isServing and IsDisabledControlJustPressed(0, 24) then
                            scaleformData.isServing = false
                            scaleformData.finalStrength = math.max(0.0, math.min(1.0, 1.0 - scaleformData.progress))
                        end
                    elseif not isHitSubmitted then
                        isHitSubmitted = true
                        
                        local hitVector = ComputeAfterHitVelocity(finalHeading, CONST_DIST_NORMAL, true)
                        local finalStrength = (scaleformData.finalStrength or 0.25) * 1.1

                        TriggerServerEvent(
                            'lsrp_tennis:setBallData', 
                            PlayerSettings.courtName, CONST_HIT_NORMAL, GetEntityCoords(courtPtr.entity), hitVector * finalStrength
                        )
                    elseif timePassed > 5000 then
                        break
                    end
                end

                return
            elseif isA and not IsEntityInAngledArea(ped, leftmost[1], leftmost[2], 1.0, false, false, false) then
                PlayMovementAnim(ped, 'serve_walk_l', true, true) -- strafe_lft
            elseif isD and not IsEntityInAngledArea(ped, rightmost[1], rightmost[2], 1.0, false, false, false) then
                PlayMovementAnim(ped, 'serve_walk_r', true, true) -- strafe_rt
            else
                StopMovementAnimIfPlaying(ped, true, 'serve_idle_01')
            end
        end
    end
end


-- --- @TEST
-- --- @TEST
-- --- @TEST
-- --- @TEST
-- --- @TEST
-- --- @TEST
-- --- @TEST
-- Citizen.CreateThread(function()
--     PlayerSettings = {}
--     PlayerSettings.courtName = 'pbluff_1_green'
--     PlayerSettings.side = 'a'
--     PlayerSettings.isServing = true

--     StartTennisWorker(PlayerPedId(), TennisCourts.pbluff_1_green, 'a')
-- end)
-- -- @ENDTEST
-- -- @ENDTEST
-- -- @ENDTEST
-- -- @ENDTEST
-- -- @ENDTEST
-- -- @ENDTEST
-- -- @ENDTEST
-- -- @ENDTEST
RegisterCommand("endgame", function (source, args, raw)
		PlayerSettings = false
       -- StopAnimTask(PlayerPedId(), 'mini@tennis', CurrentMovementAnim, 1.0)
        --StopAnimTask(PlayerPedId(), 'mini@tennis', CurrentMovementAnim .. '_loop', 1.0)
		StopMovementAnimIfPlaying(ped, true, 'serve_idle_01')
		ClearPedTasks(PlayerPedId()) 
		ClearPedSecondaryTask(PlayerPedId())							
		TriggerEvent("fixprone")
		DeleteEntity(RacketEntity)
		Wait(3000)
		courtData.isActive = false
end)
RacketEntity = nil

function EnsureRacketEntity(ped, coords)
    RacketEntity = CreateObject(`prop_tennis_rack_01b`, coords + vector3(0.0, 1.0, 0.0), true, false, false)
    AttachEntityToEntity(RacketEntity, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 0, 0, 0, 2, 1)
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    DeleteEntity(RacketEntity)
end)

function StartTennisWorker(ped, courtPtr, side)
    local coords = GetEntityCoords(ped)

    LoadAnimDict("mini@tennis")
    LoadAnimDict("weapons@tennis@male")

    EnsureRacketEntity(ped, coords)

    if PlayerSettings.isServing then
        HandleServingFuly(ped, courtPtr, side)
    else
        TaskPlayAnim(ped, 'mini@tennis', 'idle_fh', 4.0, 4.0, -1, 1, 1.0, false, false, false)
    end

    while PlayerSettings do
        Wait(0)
        DisablePlayerFiring(PlayerId(), true)
        DisableAllControlActions(0)
        EnableControlAction(0, 249, true)
        EnableControlAction(0, 245, true)

        EnableControlAction(0, 0, true) -- mouse
        EnableControlAction(0, 1, true) -- mouse
        EnableControlAction(0, 2, true) -- mouse

        local isW = IsDisabledControlPressed(0, 32)
        local isS = IsDisabledControlPressed(0, 33)
        local isA = IsDisabledControlPressed(0, 34)
        local isD = IsDisabledControlPressed(0, 35)
        local ped = PlayerPedId()

        local isSpaceClick = IsDisabledControlJustPressed(0, 22)
        local isLeftClick = IsDisabledControlJustPressed(0, 24)
        local isRightClick = IsDisabledControlJustPressed(0, 25)

        SetEntityHeading(ped, courtPtr.courtHeading + (side == CONST_SIDE_A and 180.0 or 0.0))

        if GetGameTimer() > BlockControlUntil then
            if isLeftClick then
                HandleAttemptHitBall(ped, PlayerSettings.courtName, CONST_HIT_NORMAL)
            elseif isSpaceClick then
                HandleAttemptHitBall(ped, PlayerSettings.courtName, CONST_HIT_BACKSPIN)
            elseif isRightClick then
                HandleAttemptHitBall(ped, PlayerSettings.courtName, CONST_HIT_TOPSPIN)
            elseif isW and isA then
                PlayMovementAnim(ped, 'run_fwd_-45', false, true) -- walk_fwd_-45
            elseif isW and isD then
                PlayMovementAnim(ped, 'run_fwd_45', false, true) -- walk_fwd_45
            elseif isS and isA then
                PlayMovementAnim(ped, 'run_bwd_-135', false, true) -- walk_bwd_-135
            elseif isS and isD then
                PlayMovementAnim(ped, 'run_bwd_135', false, true) -- walk_bwd_135
            elseif isW then
                PlayMovementAnim(ped, 'run_fwd_0', false, true) -- strafe_fwd
            elseif isS then
                PlayMovementAnim(ped, 'strafe_bwd', false, true) -- strafe_bwd
            elseif isA then
                PlayMovementAnim(ped, 'run_bwd_-90_loop', true, true) -- strafe_lft
            elseif isD then
                PlayMovementAnim(ped, 'run_fwd_90_loop', true, true) -- strafe_rt
            else
                if CurrentMovementShouldSqeak then
                    PlaySoundFromEntity(-1, "TENNIS_FOOT_SQUEAKS_MASTER", ped, 0, false, 0)
                    CurrentMovementShouldSqeak = false
                end

                StopMovementAnimIfPlaying(ped, true)
            end
        end
    end
end

function HandleAttemptHitBall(ped, courtName, hitType)
    local side, distName, ballPos, ballVel = PredictBallPosition(
        TennisCourts[courtName].spin, 
        TennisCourts[courtName].ballPos, 
        TennisCourts[courtName].ballVelocity, 
        TennisCourts[courtName].z
    )

    local groundDist = ComputeGroundHitDist(ped, ballPos)


    -- cant reuse "ped" as it could've changed in ComputegRoundHitDist (after wait)
    PlayHitBallAnim(PlayerPedId(), ANIM_TREE[side][distName][hitType][groundDist], side, distName, hitType, TennisCourts[courtName], ballPos)
end

function ComputeGroundHitDist(ped, ballPos)
    local pedCoords = GetEntityCoords(ped)

    local zDiff = (ballPos.z+Config.BallRadius) - pedCoords.z

    local loDist = math.abs(zDiff - ANIM_GND_DIST_OFFSET[CONST_GND_DIST_LO])
    local mdDist = math.abs(zDiff - ANIM_GND_DIST_OFFSET[CONST_GND_DIST_MD])
    local hiDist = math.abs(zDiff - ANIM_GND_DIST_OFFSET[CONST_GND_DIST_HI])

    if loDist < mdDist and loDist < hiDist then
        return CONST_GND_DIST_LO
    end

    if mdDist < loDist and mdDist < hiDist then
        return CONST_GND_DIST_MD
    end

    if hiDist < mdDist and hiDist < loDist then
        return CONST_GND_DIST_HI
    end

    return CONST_GND_DIST_MD
end


-- Citizen.CreateThread(function()
    
--     RequestScriptAudioBank("SCRIPT\\Tennis", false, -1)
--     RequestScriptAudioBank("SCRIPT\\TENNIS_VER2_A", false, -1)

--     Wait(200)

--     local ped = PlayerPedId()
--     local coords = GetEntityCoords(ped)
-- print("playing")
--     PlaySoundFromEntity(-1, "TENNIS_FOOT_SQUEAKS_MASTER", ped, 0, false, 0)
--     -- AUDIO::PLAY_SOUND_FROM_COORD(-1, "TENNIS_NET_BALL_SKIM_MASTER", *uParam1, 0, false, 0, 1);
--     -- AUDIO::PLAY_SOUND_FROM_COORD(-1, "TENNIS_CLS_BALL_HARD_MASTER", *uParam1, 0, false, 0, 1);
--     -- AUDIO::PLAY_SOUND_FROM_COORD(-1, "TENNIS_CLS_BALL_MASTER", *uParam1, 0, false, 0, 1);
--     -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, "TENNIS_PLYR_SMASH_MASTER", func_1425(uParam0[iParam5 /*94*/]), 0, false, 0);
--     -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, "TENNIS_PLYR_SERVE_MASTER", func_1425(uParam0[iParam5 /*94*/]), 0, false, 0);
--     -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_SMASH_MASTER", "TENNIS_NPC_SMASH_MASTER"), func_1425(uParam0), 0, false, 0);
--     -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_SMASH_BACKSLICE_MASTER", "TENNIS_NPC_SMASH_BACKSLICE_MASTER"), func_1425(uParam0), 0, false, 0);
--     -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_SMASH_MASTER", "TENNIS_NPC_SMASH_MASTER"), func_1425(uParam0), 0, false, 0);
--     -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_LOB_MASTER", "TENNIS_NPC_LOB_MASTER"), func_1425(uParam0), 0, false, 0);
--     -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_FOREARM_MASTER", "TENNIS_NPC_FOREARM_MASTER"), func_1425(uParam0), 0, false, 0);
--     -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_BACKSLICE_MASTER", "TENNIS_NPC_BACKSLICE_MASTER"), func_1425(uParam0), 0, false, 0);
--     -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_TOPSPIN_MASTER", "TENNIS_NPC_TOPSPIN_MASTER"), func_1425(uParam0), 0, false, 0);
--     -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, "TENNIS_FOOT_SQUEAKS_MASTER", func_1425(uParam0), 0, false, 0);
--     -- AUDIO::PLAY_SOUND_FRONTEND(-1, "TENNIS_POINT_WON", "HUD_AWARDS", true);
--     -- AUDIO::PLAY_SOUND_FRONTEND(-1, "TENNIS_MATCH_POINT", "HUD_AWARDS", true);
-- end)


local AnimToIdle = {
    ['forehand_ts_md'] = 'idle_bh',
    ['run_fwd_-45'] = 'idle_bh',
    ['run_fwd_45'] = 'idle_fh',
    ['run_bwd_-135'] = 'idle_bh',
    ['run_bwd_135'] = 'idle_fh',
    ['run_fwd_0'] = 'idle_bh',
    ['strafe_bwd'] = 'idle_fh',
    ['run_bwd_-90_loop'] = 'idle_bh',
    ['run_fwd_90_loop'] = 'idle_fh',
}

local lastSidewaysAnim = nil

function StopMovementAnimIfPlaying(ped, setIdle, forcedIdleAnim)
    if CurrentMovementAnim then
        StopAnimTask(ped, 'mini@tennis', CurrentMovementAnim, 1.0)
        StopAnimTask(ped, 'mini@tennis', CurrentMovementAnim .. '_loop', 1.0)


        if setIdle then
            CurrentMovementAnim = forcedIdleAnim or AnimToIdle[lastSidewaysAnim] or AnimToIdle[CurrentMovementAnim] or 'idle_fh'
            TaskPlayAnim(ped, 'mini@tennis', CurrentMovementAnim, 4.0, 4.0, -1, 1, 1.0, false, false, false)
            lastSidewaysAnim = nil
        end

        CurrentMovementShouldSqeak = false
        CurrentMovementAnim = nil
    end
end

function PlayMovementAnim(ped, anim, skipIntro, shouldSqeak)
    if anim ~= CurrentMovementAnim then
        StopMovementAnimIfPlaying(ped)
        CurrentMovementAnim = anim
        
        local isFwdOrBwdMove = CurrentMovementAnim == 'strafe_bwd' or CurrentMovementAnim == 'run_fwd_0'

        if not isFwdOrBwdMove then
            lastSidewaysAnim = CurrentMovementAnim
        end

        CurrentMovementShouldSqeak = shouldSqeak

        if skipIntro then
            TaskPlayAnim(ped, 'mini@tennis', anim, 4.0, 4.0, -1, 1, 1.0, false, false, false)
        else
            TaskPlayAnim(ped, 'mini@tennis', anim .. '_intro', 4.0, 4.0, -1, 0, 1.0, false, false, false)
            TaskPlayAnim(ped, 'mini@tennis', anim .. '_loop', 4.0, 4.0, -1, 1, 1.0, false, false, false)
        end
    end
end

function PlayHitBallAnim(ped, name, side, distName, hitType, courtPtr, predictedBallPos)
    local animDuration = tonumber(math.floor(GetAnimDuration('mini@tennis', name)*1000))

    CurrentMovementAnim = nil
    TaskPlayAnim(ped, 'mini@tennis', name, 4.0, 4.0, animDuration-200, 1, 1.0, false, false, false)
    BlockControlUntil = GetGameTimer() + animDuration-200

    Citizen.SetTimeout(animDuration-200, function()
        CurrentMovementAnim = name
        if side == CONST_SIDE_BACKHAND then
            lastSidewaysAnim = 'run_fwd_0'
        else
            lastSidewaysAnim = 'strafe_bwd'
        end
    end)

    Citizen.SetTimeout(math.max(1, ANIM_HIT_DELAY[distName]-150), function()
        local racketCoords = GetOffsetFromEntityInWorldCoords(RacketEntity, 0.0, 0.0, 0.4)

        if #(racketCoords.xy - courtPtr.ballPos.xy) < 2.8 then
            local finalHeading = courtPtr.courtHeading + (PlayerSettings.side == CONST_SIDE_A and 180.0 or 0.0)
            local newVelocity = ComputeAfterHitVelocity(finalHeading, distName)

            TriggerServerEvent('lsrp_tennis:setBallData', PlayerSettings.courtName, hitType, predictedBallPos, newVelocity)
        end
    end)
end

-- Citizen.CreateThread(function()
--     FreezeEntityPosition(PlayerPedId(), false)
--     while true do
--         Wait(0)

--         local ped = PlayerPedId()
--         local coords = GetOffsetFromEntityInWorldCoords(ped, 0.5, 0.5, 0.5)

--         for _, distName in pairs({CONST_DIST_CLOSE, CONST_DIST_NORMAL, CONST_DIST_DIVE}) do
--             local vec = ComputeAfterHitVelocity(distName)
--             local pos = coords

--             local col = {255, 0, 0}

--             if distName == CONST_DIST_NORMAL then
--                 col = {0, 255, 0}
--             elseif distName == CONST_DIST_DIVE then
--                 col = {0, 0, 255}
--             end

--             local lastPos = pos

--             local spin = CONST_HIT_BACKSPIN

--             for i = 1, 200 do
--                 pos, vec, collision = SimulatePhysicsStep(GetFrameTime()*2, spin, pos, vec, TennisCourts.desanta.ballVelocity.z, true, false)
--                 if collision then
--                     spin = CONST_HIT_NORMAL
--                 end
--                 DrawLine(lastPos, pos, col[1], col[2], col[3], 255)
--                 lastPos = pos
--             end
--         end
--     end
-- end)

function LoadAnimDict(animDict)
	while (not HasAnimDictLoaded(animDict)) do
		RequestAnimDict(animDict)
		Citizen.Wait(0)
    end

    Wait(0)
end

--[[
    /anim mini@tennis idle
    /anim mini@tennis smash
    /anim mini@tennis serve_idle_03
    /anim mini@tennis serve_idle_02
    /anim mini@tennis serve_idle_01
    /anim mini@tennis serve
    /anim mini@tennis dive_bh
    /anim mini@tennis dive_fh
    /anim mini@tennis react_win_01
    /anim mini@tennis forehand
    /anim mini@tennis backhand
    /anim mini@tennis ready_postion_idle_01
    /anim mini@tennis ready_position_idle_02
    /anim mini@tennis ready_position_idle_01
]]

-- Citizen.CreateThread(function()
--     RequestNamedPtfxAsset('scr_minigametennis')

--     while not HasNamedPtfxAssetLoaded('scr_minigametennis') do Wait(0) end
--     print("has loaded", HasNamedPtfxAssetLoaded('scr_minigametennis'))
--     Wait(100)
--     local coords = vector3(-775.03, 147.25, 68.0)
--         UseParticleFxAssetNextCall('scr_minigametennis')
--         local particle = StartParticleFxLoopedAtCoord("scr_tennis_ball_trail", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1065353216, 0, 0, 0, true)
--         SetParticleFxLoopedColour(particle, 222/255, 198/255, 47/255, false)
--         print(particle)

--         local x = 0
--         while true do
--             Wait(0)
--             x = x + GetFrameTime()*5
--             local off = vector3(0.1, 0.1, 0.1)
--             local offZ = math.cos(x)

--             SetParticleFxLoopedOffsets(particle, coords.x, coords.y, coords.z+offZ, 0.0, 0.0, 0.0)
--             DrawBox(coords+off+vector3(0.0, 0.0, offZ), coords-off+vector3(0.0, 0.0, offZ), 0, 255, 0, 100)
--         end

--     Wait(0)
--     print(particle)
-- end)