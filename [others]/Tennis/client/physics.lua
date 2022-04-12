BallEntity = nil
BallPosition = nil
BallVelocity = nil
PredictedCollisionCoords = nil
COLLISION_SHAPETEST_FLAG = 1 + 2 + 4 + 16

Citizen.CreateThread(function()

    local starts = {
        vector3(-769.88, 163.03, 67.92),
        vector3(-772.25, 163.03, 67.98),
        vector3(-775.28, 163.32, 68.15),
        vector3(-776.2, 163.3, 68.33),
    }

    local ends = {
        vector3(-776.17, 143.9, 69.170000000001)
    }

    if GetPlayerServerId(PlayerId()) == 1 then
        while true do
            Wait(6000)
            TriggerServerEvent('lsrp_tennis:setBallData', 'desanta', CONST_HIT_NORMAL, vector3(-775.96, 165.34, 67.72), vector3(2.0, -15.0, 5.0))
        end
    end
end)

RegisterNetEvent('lsrp_tennis:setBallData')
AddEventHandler('lsrp_tennis:setBallData', function(senderServerId, courtName, hitType, pos, velocity)
    local player = GetPlayerFromServerId(senderServerId)

    if NetworkIsPlayerActive(player) then
        local ped = GetPlayerPed(player)

        PlaySoundFromEntity(-1, "TENNIS_PLYR_SMASH_MASTER", ped, 0, false, 0)

        if TennisCourts[courtName].entity and DoesEntityExist(TennisCourts[courtName].entity) then
            DeleteEntity(TennisCourts[courtName].entity)
        end

        if TennisCourts[courtName].ptfx then
            StopParticleFxLooped(TennisCourts[courtName].ptfx, 1)
        end
        TennisCourts[courtName].ballPos = pos
        TennisCourts[courtName].spin = hitType
        TennisCourts[courtName].ballVelocity = velocity
        TennisCourts[courtName].predictedCollisionCoords = ComputeFirstGroundCollisionPosition(TennisCourts[courtName].spin, TennisCourts[courtName].ballPos, TennisCourts[courtName].ballVelocity, TennisCourts[courtName].z)
        TennisCourts[courtName].entity = CreateObject(`prop_tennis_ball`, TennisCourts[courtName].ballPos, false, false, false)
    end
end)

RegisterNetEvent('lsrp_tennis:setBallInHand')
AddEventHandler('lsrp_tennis:setBallInHand', function(senderServerId, courtName)
    local player = GetPlayerFromServerId(senderServerId)

    if NetworkIsPlayerActive(player) then
        local ped = GetPlayerPed(player)

        if TennisCourts[courtName].entity and DoesEntityExist(TennisCourts[courtName].entity) then
            DeleteEntity(TennisCourts[courtName].entity)
        end
        
        if TennisCourts[courtName].ptfx then
            StopParticleFxLooped(TennisCourts[courtName].ptfx, 1)
        end

        TennisCourts[courtName].ballPos = nil
        TennisCourts[courtName].spin = nil
        TennisCourts[courtName].ballVelocity = nil
        TennisCourts[courtName].predictedCollisionCoords = nil

        local coords = GetEntityCoords(ped)

        TennisCourts[courtName].entity = CreateObject(`prop_tennis_ball`, coords.x, coords.y, coords.z + 2.0, false, false, false)
        AttachEntityToEntity(TennisCourts[courtName].entity, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 0, 0, 0, 2, 1)
    end
end)

function OnBallCollision(courtName, collisionCoords, collisionMaterial, collisionEntity)
    if PlayerSettings and PlayerSettings.courtName == courtName then
        local ballHitData = GetPointData(
            TennisCourts[courtName].courtCenter, 
            TennisCourts[courtName].courtHeading, 
            TennisCourts[courtName].courtWidth, 
            TennisCourts[courtName].courtLength, 
            collisionCoords
        )

        if not ballHitData.isInArea then
            print("Ball hit outside area")
        elseif collisionMaterial == 122789469 then
            print("Net collision")
        else
            local abSide = ballHitData.isASide and 'a' or 'b'
            local lrSide = ballHitData.isLeftSide and 'left' or 'right'

            print("Hit inside", abSide, lrSide)
        end
    end
end

Citizen.CreateThread(function()
    -- TennisCourts.desanta.ballPos = vector3(-773.83, 143.59, 68.35)
    -- TennisCourts.desanta.ballVelocity = vector3(0.1465, 0.9677, -0.2047) * 10
    -- TennisCourts.desanta.predictedCollisionCoords = ComputeFirstGroundCollisionPosition(TennisCourts.desanta.spin, TennisCourts.desanta.ballPos, TennisCourts.desanta.ballVelocity, TennisCourts.desanta.z)

    -- TennisCourts.desanta.entity = CreateObject(`prop_tennis_ball`, TennisCourts.desanta.ballPos, false, false, false)
    -- TennisCourts.desanta.entity = CreateObject(`prop_tennis_ball`, TennisCourts.desanta.ballPos, false, false, false)
    -- SetEntityCollision(TennisCourts.desanta.entity, false, false)

    Wait(2000)

    StartAudioScene("TENNIS_SCENE");

    RequestScriptAudioBank("SCRIPT\\Tennis", false, -1)
    RequestScriptAudioBank("SCRIPT\\TENNIS_VER2_A", false, -1)

    local isCollisionDisabled = false

    while true do
        Wait(0)

        local frameTime = GetFrameTime()
        local gameTimer = GetGameTimer()

        for courtName, courtData in pairs(TennisCourts) do
            if courtData.isActive and courtData.ballPos then
                if gameTimer > courtData.collisionSuspendedUntil then
                    courtData.collisionSuspendedUntil = gameTimer + 100
                    courtData.isCollisionActive = ShouldCollisionBeActive(courtData.entity, courtData.z, courtData.spin, courtData.ballPos, courtData.ballVelocity)
                end

                courtData.ballPos, courtData.ballVelocity, collisionCoords, collisionMaterial, collisionEntity = SimulatePhysicsStep(frameTime, courtData.spin, courtData.ballPos, courtData.ballVelocity, courtData.z, courtData.isCollisionActive, not isCollisionDisabled)

                HandleBallTrailer(courtData)

                isCollisionDisabled = false

                if collisionCoords then
                    courtData.spin = CONST_HIT_NORMAL
                    isCollisionDisabled = true -- prevents double collision
                    Citizen.CreateThread(function()
                        courtData.predictedCollisionCoords = ComputeFirstGroundCollisionPosition(courtData.spin, courtData.ballPos, courtData.ballVelocity, courtData.z)
                    end)

                    OnBallCollision(courtName, collisionCoords, collisionMaterial, collisionEntity)
                end

                if courtData.predictedCollisionCoords then
                    DrawMarker(
                        25, 
                        courtData.predictedCollisionCoords.x, courtData.predictedCollisionCoords.y, courtData.predictedCollisionCoords.z + 0.03, 
                        0.0, 0.0, 0.0, 
                        0.0, 0.0, 0.0, 
                        0.5, 0.5, 0.5, 
                        255, 255, 255, 150, 
                        false, false, false, false, nil, nil, false
                    )
                end

                SetEntityCoordsNoOffset(courtData.entity, courtData.ballPos + vector3(0.0, 0.0, Config.BallRadius), false, false, false)
            end
        end
    end
end)

function ShouldCollisionBeActive(ent, groundZ, spin, pos, velocity)
    local endPos, _, _ = SimulatePhysicsStep(130/1000, spin, pos, velocity, groundZ, false)


    local capsuleRay = StartShapeTestCapsule(pos, endPos, 0.2, COLLISION_SHAPETEST_FLAG, ent, 4)
    local retval, hit = GetShapeTestResult(capsuleRay)

    return hit == 1
end

function ComputeFirstGroundCollisionPosition(spin, ballPos, ballVel, groundZ)
    local frameTime = GetFrameTime()
    local fps = 1/frameTime
    local predictFrames = fps*4

    local intersperse = 10

    for i = 1, predictFrames do
        if intersperse <= 0 then
            Wait(0)
            intersperse = 10
        end
        intersperse = intersperse - 1
        ballPos, ballVel, collisionCoords = SimulatePhysicsStep(frameTime, spin, ballPos, ballVel, groundZ, true)

        if collisionCoords then
            spin = CONST_HIT_NORMAL
        end

        if collisionCoords and (collisionCoords.z - groundZ) < 0.05 then
            return collisionCoords
        end
    end

    return nil
end

function PredictBallPosition(spin, ballPos, ballVel, groundZ)
    local elapsedMs = 0
    local secondsToPredict = math.max(ANIM_HIT_DELAY[CONST_DIST_CLOSE], ANIM_HIT_DELAY[CONST_DIST_NORMAL], ANIM_HIT_DELAY[CONST_DIST_DIVE]) + 0.2
    local frameTime = GetFrameTime()

    local predictionPoints = {
        CONST_DIST_CLOSE = false,
        CONST_DIST_NORMAL = false,
        CONST_DIST_DIVE = false,
    }

    while secondsToPredict > 0 do
        ballPos, ballVel, collision = SimulatePhysicsStep(frameTime, spin, ballPos, ballVel, groundZ, true, false)

        if collision then
            spin = CONST_HIT_NORMAL
        end

        secondsToPredict = secondsToPredict - frameTime
        elapsedMs = elapsedMs + frameTime*1000

        for dist, pos in pairs(predictionPoints) do
            if not pos and ANIM_HIT_DELAY[dist] <= elapsedMs then
                predictionPoints[dist] = {pos = ballPos, vel = ballVel}
            end
        end
    end

    Wait(0)

    local closestDistAbs = nil
    local closestPos = nil
    local closestVel = nil
    local closestSide = nil
    local closestDistName = nil

    local ped = PlayerPedId()
    
    for _, side in pairs({CONST_SIDE_BACKHAND, CONST_SIDE_FOREHAND}) do
        for _, dist in pairs({CONST_DIST_CLOSE, CONST_DIST_NORMAL, CONST_DIST_DIVE}) do
            local relOffset = ANIM_DIST_OFFSET[side][dist]
            local offsetCoords = GetOffsetFromEntityInWorldCoords(ped, relOffset.x, relOffset.y, 0.0)

            local nowDist = #(offsetCoords - predictionPoints[dist].pos)

            if not closestDistAbs or closestDistAbs > nowDist then
                if dist ~= CONST_DIST_DIVE or nowDist < 3.0 then
                    closestDistAbs = nowDist
                    closestPos = predictionPoints[dist].pos
                    closestVel = predictionPoints[dist].vel
                    closestSide = side
                    closestDistName = dist
                end
            end
        end
    end

    return closestSide, closestDistName, closestPos, closestVel
end

function SimulatePhysicsStep(frameTime, spin, ballPos, ballVel, groundZ, detectCollision, shakeNet)
    local isOnGround = (ballPos.z - groundZ) < 0.01 and ballVel.z <= 0.01
    local collisionCoords = nil
    local collisionEntHit = nil
    local collisionMaterial = nil

    if #ballVel < 0.04 then
        ballVel = vector3(0.0, 0.0, 0.0)
    else
        if isOnGround then
            ballVel = ballVel - ballVel * Config.RollingResistance * frameTime
        else
            ballVel = ballVel + Config.Gravity[spin] * frameTime
            ballVel = ballVel - ballVel * Config.Drag * frameTime
        end

        local candidateNewBallPos = ballPos + ballVel * frameTime

        if detectCollision then
            local ray = StartExpensiveSynchronousShapeTestLosProbe(
                ballPos,
                candidateNewBallPos,
                COLLISION_SHAPETEST_FLAG,
                0,
                0
            )
            local retval, hit, endCoords, surfaceNormal, material, hitEnt = GetShapeTestResultEx(ray)
            
            if hit == 1 then
                local isNetCollision = material == 122789469

                if isNetCollision then
                    ballVel = ballVel * 0.3
                end

                if shakeNet and (isNetCollision or material == 125958708) then
                    if isNetCollision then
                        
                        -- AUDIO::PLAY_SOUND_FROM_COORD(-1, "TENNIS_NET_BALL_MEDIUM_MASTER", *uParam1, 0, false, 0, 1);
                        -- AUDIO::PLAY_SOUND_FROM_COORD(-1, "TENNIS_NET_BALL_SKIM_MASTER", *uParam1, 0, false, 0, 1);
                        -- AUDIO::PLAY_SOUND_FROM_COORD(-1, "TENNIS_CLS_BALL_HARD_MASTER", *uParam1, 0, false, 0, 1);
                        -- AUDIO::PLAY_SOUND_FROM_COORD(-1, "TENNIS_CLS_BALL_MASTER", *uParam1, 0, false, 0, 1);
						-- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, "TENNIS_PLYR_SMASH_MASTER", func_1425(uParam0[iParam5 /*94*/]), 0, false, 0);
						-- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, "TENNIS_PLYR_SERVE_MASTER", func_1425(uParam0[iParam5 /*94*/]), 0, false, 0);
                        -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_SMASH_MASTER", "TENNIS_NPC_SMASH_MASTER"), func_1425(uParam0), 0, false, 0);
                        -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_SMASH_BACKSLICE_MASTER", "TENNIS_NPC_SMASH_BACKSLICE_MASTER"), func_1425(uParam0), 0, false, 0);
                        -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_SMASH_MASTER", "TENNIS_NPC_SMASH_MASTER"), func_1425(uParam0), 0, false, 0);
                        -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_LOB_MASTER", "TENNIS_NPC_LOB_MASTER"), func_1425(uParam0), 0, false, 0);
                        -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_FOREARM_MASTER", "TENNIS_NPC_FOREARM_MASTER"), func_1425(uParam0), 0, false, 0);
                        -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_BACKSLICE_MASTER", "TENNIS_NPC_BACKSLICE_MASTER"), func_1425(uParam0), 0, false, 0);
                        -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, func_172(uParam0->f_31 != 4, "TENNIS_PLYR_TOPSPIN_MASTER", "TENNIS_NPC_TOPSPIN_MASTER"), func_1425(uParam0), 0, false, 0);
                        -- AUDIO::PLAY_SOUND_FROM_ENTITY(-1, "TENNIS_FOOT_SQUEAKS_MASTER", func_1425(uParam0), 0, false, 0);
                        -- AUDIO::PLAY_SOUND_FRONTEND(-1, "TENNIS_POINT_WON", "HUD_AWARDS", true);
                        -- AUDIO::PLAY_SOUND_FRONTEND(-1, "TENNIS_MATCH_POINT", "HUD_AWARDS", true);

                        -- if (!AUDIO::REQUEST_SCRIPT_AUDIO_BANK("SCRIPT\Tennis", false, -1))
                        -- if (!AUDIO::REQUEST_SCRIPT_AUDIO_BANK("SCRIPT\TENNIS_VER2_A", false, -1))
                        -- AUDIO::START_AUDIO_SCENE("TENNIS_SCENE");


                        PlaySoundFromCoord(-1, "TENNIS_NET_BALL_MEDIUM_MASTER", ballPos.x, ballPos.y, ballPos.z, 0, false, 0, 1);
                    end

                    for i = -6, 6 do
                        local impulseVector = (ballVel/#ballVel)*0.5
                        local impulseStart = ballPos - impulseVector*(i/20)
                        
                        ApplyImpulseToCloth(impulseStart.x, impulseStart.y, impulseStart.z, impulseVector.x, impulseVector.y, impulseVector.z, 2.0)
                    end
                elseif shakeNet then
                    PlayBallHitSound(ballPos, ballVel, material)
                end 

                -- compute reflection vector
                local reflectedBallVec = ballVel - 2 * ballVel*(surfaceNormal * surfaceNormal * Config.BallElasticity)
                reflectedBallVec = reflectedBallVec/#reflectedBallVec * #ballVel -- conservation of energy biatch

                local distToCollision = #(ballPos - endCoords)
                local distFull = #(ballVel*frameTime)

                local portionToCollision = distToCollision / distFull

                local newBallVec = reflectedBallVec * Config.GroundBounceEnergyLoss
                collisionCoords = endCoords
                collisionEntHit = hitEnt
                collisionMaterial = material

                if newBallVec.z <= Config.StopHorizontalBounceTreshold and isOnGround then
                    local zPortion = newBallVec.z / #newBallVec
                    newBallVec = vector3(newBallVec.x * (1.0 + zPortion/2), newBallVec.y * (1.0 + zPortion/2), 0.0)

                    -- when we stop vertical bouncing, move the ball up a bit to prevent it from colliding with ground
                    ballPos = vector3(ballPos.x, ballPos.y, groundZ)
                end

                ballPos = ballPos + (ballVel*frameTime) * portionToCollision + (newBallVec*frameTime) * (1.0 - portionToCollision)
                ballVel = newBallVec

                ReleaseScriptGuidFromEntity(ray)
                ReleaseScriptGuidFromEntity(hitEnt)
            else
                ballPos = candidateNewBallPos
            end
        else
            ballPos = candidateNewBallPos
        end
    end

    return ballPos, ballVel, collisionCoords, collisionMaterial, collisionEntHit
end

function PlayBallHitSound(pos, velocity, material)
    if #velocity > 1.5 then
        -- @TODO: HARD sound for hard surfaces - concrete/metal/whatevs
        -- AUDIO::PLAY_SOUND_FROM_COORD(-1, "TENNIS_CLS_BALL_HARD_MASTER", *uParam1, 0, false, 0, 1);
        PlaySoundFromCoord(-1, "TENNIS_CLS_BALL_MASTER", pos.x, pos.y, pos.z, 0, false, 0, 1);
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    for _, courtData in pairs(TennisCourts) do
        DeleteEntity(courtData.entity)
    end
end)

function HandleBallTrailer(courtData)
    local pos = courtData.ballPos

    if not HasNamedPtfxAssetLoaded('scr_minigametennis') then
        RequestNamedPtfxAsset('scr_minigametennis')
    else
        if #courtData.ballVelocity > 0.1 then
            if not courtData.ptfx or not DoesParticleFxLoopedExist(courtData.ptfx) then
                UseParticleFxAssetNextCall('scr_minigametennis')
                courtData.ptfx = StartParticleFxLoopedAtCoord("scr_tennis_ball_trail", pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 1065353216, 0, 0, 0, true)
                SetParticleFxLoopedColour(courtData.ptfx, 255/255, 234/255, 8/255, false)
            else
                SetParticleFxLoopedOffsets(courtData.ptfx, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0)
            end
        elseif courtData.ptfx and DoesParticleFxLoopedExist(courtData.ptfx) then
            StopParticleFxLooped(courtData.ptfx, 1)
            courtData.ptfx = nil
        end
    end
end