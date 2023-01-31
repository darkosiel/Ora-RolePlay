local Keys = {["E"] = 38, ["SPACE"] = 22, ["DELETE"] = 178}
local canExercise = false
local exercising = false
local procent = 0
local motionProcent = 0
local doingMotion = false
local motionTimesDone = 0

Citizen.CreateThread(
    function()
        while true do
            local sleep = 500
            local coords = LocalPlayer().Pos
            for i, v in pairs(ConfigGym.Locations) do
                local pos = ConfigGym.Locations[i]
                local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
                if dist <= 1.5 and not exercising then
                    sleep = 0
                    DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, "[E] " .. pos["exercise"])
                    if IsControlJustPressed(0, Keys["E"]) then
                        startExercise(ConfigGym.Exercises[pos["exercise"]], pos)
                    end
                else
                    if dist <= 3.0 and not exercising then
                        sleep = 0
                        DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, pos["exercise"])
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end
)

function startExercise(animInfo, pos)
    if not ConfigGym.FarmLimit or (ConfigGym.FarmLimit and GetFarmLimit() < 600) then
        local playerPed = LocalPlayer().Ped

        LoadDict(animInfo["idleDict"])
        LoadDict(animInfo["enterDict"])
        LoadDict(animInfo["exitDict"])
        LoadDict(animInfo["actionDict"])

        if pos["h"] ~= nil then
            SetEntityCoords(playerPed, pos["x"], pos["y"], pos["z"])
            SetEntityHeading(playerPed, pos["h"])
        end

        TaskPlayAnim(
            playerPed,
            animInfo["enterDict"],
            animInfo["enterAnim"],
            8.0,
            -8.0,
            animInfo["enterTime"],
            0,
            0.0,
            0,
            0,
            0
        )
        Citizen.Wait(animInfo["enterTime"])

        canExercise = true
        exercising = true

        Citizen.CreateThread(
            function()
                while exercising do
                    Citizen.Wait(0)
                    if procent <= 24.99 then
                        color = "~r~"
                    elseif procent <= 49.99 then
                        color = "~o~"
                    elseif procent <= 74.99 then
                        color = "~b~"
                    elseif procent <= 100 then
                        color = "~g~"
                    end
                    DrawText2D(0.505, 0.925, 1.0, 1.0, 0.33, "Pourcentage: " .. color .. procent .. "%", 255, 255, 255, 255)
                    DrawText2D(
                        0.505,
                        0.95,
                        1.0,
                        1.0,
                        0.33,
                        "Appuyez sur ~g~[ESPACE]~w~ pour faire une série",
                        255,
                        255,
                        255,
                        255
                    )
                    DrawText2D(
                        0.505,
                        0.975,
                        1.0,
                        1.0,
                        0.33,
                        "Appuyez sur ~r~[SUPP]~w~ pour arreter la série",
                        255,
                        255,
                        255,
                        255
                    )
                end
            end
        )

        Citizen.CreateThread(
            function()
                while canExercise do
                    Citizen.Wait(0)
                    local playerCoords = LocalPlayer().Pos
                    if procent <= 99 then
                        TaskPlayAnim(playerPed, animInfo["idleDict"], animInfo["idleAnim"], 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
                        if IsControlJustPressed(0, Keys["SPACE"]) then -- press space to train
                            canExercise = false
                            TaskPlayAnim(
                                playerPed,
                                animInfo["actionDict"],
                                animInfo["actionAnim"],
                                8.0,
                                -8.0,
                                animInfo["actionTime"],
                                0,
                                0.0,
                                0,
                                0,
                                0
                            )
                            AddProcent(
                                animInfo["actionProcent"],
                                animInfo["actionProcentTimes"],
                                animInfo["actionTime"] - 70
                            )
                            canExercise = true
                        end
                        if IsControlJustPressed(0, Keys["DELETE"]) then -- press delete to exit training
                            ExitTraining(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])

                            RageUI.Popup({message = "💪 ~b~Salle de Gym~s~"})
                            RageUI.Popup({message = "~r~Tu as annulé ton entraînement~s~"})
                            TriggerServerCallback(
                                "Ora:getStrength",
                                function(strength, isFull)
                                    LocalPlayer().Strength = strength * 10
                                    RageUI.Popup({message = "~b~Progression actuelle ~g~+" .. strength .. "/100%~s~"})
                                end
                            )
                        end
                    else
                        -- Here u can put a event to update some sort of skill or something.
                        -- this is when u finished your exercise
                        local newStrength = 1 / 10
                        TriggerServerEvent("newStrength", newStrength)

                        ExitTraining(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
                        RageUI.Popup({message = "💪 ~b~Salle de Gym~s~"})
                        RageUI.Popup({message = "~b~Tu viens de gagner ~g~+" .. newStrength .. "%~b~ de force~s~"})

                        TriggerServerCallback(
                            "Ora:getStrength",
                            function(strength, isFull)
                                LocalPlayer().Strength = strength * 10
                                if (isFull == true) then
                                    RageUI.Popup({message = "~r~Vous avez déjà pris 3% aujourd'hui, reposez vous~s~"})
                                    RageUI.Popup({message = "~b~Force actuelle ~g~+" .. strength .. "/100%~s~"})
                                else
                                    if ConfigGym.FarmLimit then SetFarmLimit(1) end
                                    RageUI.Popup({message = "~b~Progression actuelle ~g~+" .. strength .. "/100%~s~"})
                                    RageUI.Popup(
                                        {
                                            message = "~b~Tu obtiendras + ~y~d'endurance~b~, de ~y~force~b~ dans tes poings et de ~y~vitesse~b~ de sprint~s~"
                                        }
                                    )
                                end
                            end
                        )
                    end
                end
            end
        )
    else
        RageUI.Popup({message = "~r~Vous avez assez travaillé aujourd'hui, reposez vous~s~"})
    end
end

Citizen.CreateThread(
    function()
        while (true) do
            Citizen.Wait(1000 * 60) -- 1 Minute
            local strength = LocalPlayer().Strength
            PlayerPed = PlayerPedId

            if strength == nil then
                LocalPlayer().Strength = 0
                strength = 0
            end

            if (strength > 0) then
                strength = strength / 10
            end

            if (strength >= 90) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 30, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 30, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.38)
                SetSwimMultiplierForPlayer(playerPed, 1.38)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.20)
            elseif (strength >= 80) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 27, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 27, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.36)
                SetSwimMultiplierForPlayer(playerPed, 1.36)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.17)
            elseif (strength >= 70) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 23, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 23, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.34)
                SetSwimMultiplierForPlayer(playerPed, 1.34)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.16)
            elseif (strength >= 60) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 18, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 18, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.32)
                SetSwimMultiplierForPlayer(playerPed, 1.32)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.15)
            elseif (strength >= 50) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 15, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 15, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.30)
                SetSwimMultiplierForPlayer(playerPed, 1.30)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.14)
            elseif (strength >= 45) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 14, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 14, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.27)
                SetSwimMultiplierForPlayer(playerPed, 1.27)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.13)
            elseif (strength >= 40) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 13, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 13, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.25)
                SetSwimMultiplierForPlayer(playerPed, 1.25)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.12)
            elseif (strength >= 35) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 11, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 11, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.22)
                SetSwimMultiplierForPlayer(playerPed, 1.22)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.10)
            elseif (strength >= 30) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 10, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 10, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.20)
                SetSwimMultiplierForPlayer(playerPed, 1.20)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.09)
            elseif (strength >= 25) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 8, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 8, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.17)
                SetSwimMultiplierForPlayer(playerPed, 1.17)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.08)
            elseif (strength >= 20) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 7, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 7, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.15)
                SetSwimMultiplierForPlayer(playerPed, 1.15)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.07)
            elseif (strength >= 15) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 6, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 6, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.12)
                SetSwimMultiplierForPlayer(playerPed, 1.12)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.06)
            elseif (strength >= 10) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 5, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 5, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.10)
                SetSwimMultiplierForPlayer(playerPed, 1.10)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.05)
            elseif (strength >= 7) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 3, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 3, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.08)
                SetSwimMultiplierForPlayer(playerPed, 1.08)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.04)
            elseif (strength >= 5) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 2, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 2, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.05)
                SetSwimMultiplierForPlayer(playerPed, 1.05)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.03)
            elseif (strength >= 2) then
                StatSetInt(GetHashKey("MP0_STAMINA"), 1, true)
                StatSetInt(GetHashKey("MP0_STRENGTH"), 1, true)
                SetRunSprintMultiplierForPlayer(playerPed, 1.02)
                SetSwimMultiplierForPlayer(playerPed, 1.02)
                SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.02)
            end            
        end
    end
)

RegisterCommand(
    "motion",
    function()
        motionProcent = 0
        doingMotion = not doingMotion

        Citizen.CreateThread(
            function()
                while doingMotion do
                    Citizen.Wait(7)
                    if IsPedSprinting(LocalPlayer().Ped) then
                        motionProcent = motionProcent + 9
                    elseif IsPedRunning(LocalPlayer().Ped) then
                        motionProcent = motionProcent + 6
                    elseif IsPedWalking(LocalPlayer().Ped) then
                        motionProcent = motionProcent + 3
                    end

                    DrawText2D(
                        0.505,
                        0.95,
                        1.0,
                        1.0,
                        0.4,
                        "~b~Pourcentage :~w~ " .. tonumber(string.format("%.1f", motionProcent / 1000)) .. "%",
                        255,
                        255,
                        255,
                        255
                    )
                    if motionProcent >= 100000 then
                        doingMotion = false
                        motionProcent = 0
                        ShowNotification("Tu as ~g~terminé~w~ ta course.")
                        local newStrength = 2
                        TriggerServerEvent("newStrength", newStrength)

                        RageUI.Popup({message = "💪 ~b~Course~s~"})
                        RageUI.Popup({message = "~b~Tu viens de gagner ~g~+" .. newStrength .. "%~b~ de force~s~"})

                        TriggerServerCallback(
                            "Ora:getStrength",
                            function(strength, isFull)
                                LocalPlayer().Strength = strength * 10

                                RageUI.Popup({message = "~b~Progression actuelle ~g~+" .. strength .. "/100%~s~"})

                            end
                        )
                    end
                end
            end
        )

        if doingMotion then
            motionTimesDone = motionTimesDone + 1
            if motionTimesDone <= 2 then
                ShowNotification("Tu as ~y~commencé~w~ une course.")
            else
                ShowNotification("Tu es trop ~r~fatigué.e~w~ pour faire ça!")
                doingMotion = false
            end
        else
            ShowNotification("Tu as ~r~arreté~w~ ta course.")
        end
    end
)

function ExitTraining(exitDict, exitAnim, exitTime)
    TaskPlayAnim(LocalPlayer().Ped, exitDict, exitAnim, 8.0, -8.0, exitTime, 0, 0.0, 0, 0, 0)
    Citizen.Wait(exitTime)
    canExercise = false
    exercising = false
    procent = 0
end

function AddProcent(amount, amountTimes, time)
    for i = 1, amountTimes do
        Citizen.Wait(time / amountTimes)
        procent = procent + amount
    end
end

function LoadDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
end

Citizen.CreateThread(
    function()
        for i = 1, #ConfigGym.Blips, 1 do
            local Blip = ConfigGym.Blips[i]
            blip = AddBlipForCoord(Blip["x"], Blip["y"], Blip["z"])
            SetBlipSprite(blip, Blip["id"])
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Blip["scale"])
            SetBlipColour(blip, Blip["color"])
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Blip["text"])
            EndTextCommandSetBlipName(blip)
        end
    end
)

function Notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(msg)
    DrawNotification(false, true)
end
