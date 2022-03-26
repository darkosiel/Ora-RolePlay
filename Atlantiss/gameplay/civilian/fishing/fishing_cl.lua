local Keys = {["E"] = 38, ["SPACE"] = 22, ["DELETE"] = 178}
local canExercise = false
local exercising = false
local procent = 0
local motionProcent = 0
local doingMotion = false
local motionTimesDone = 0
local fishRod = nil
local rewards = {}



Citizen.CreateThread(
    function()
        while true do
            local sleep = 500
            local coords = LocalPlayer().Pos
            for i, v in pairs(ConfigFishing.Locations) do
                local pos = ConfigFishing.Locations[i]
                local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
                if dist <= 10.0 and not exercising then
                    sleep = 0
                    DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, "[E] " .. pos["exercise"])
                    if IsControlJustPressed(0, Keys["E"]) then
                        fishRod = nil
                        if (Atlantiss.Inventory:GetItemCount("fishingrod") > 0) then
                            startExerciseFishing(ConfigFishing.Exercises[pos["exercise"]], pos)
                        else
                            ShowNotification(
                                "~y~Vous n'êtes pas équipé pour la pêche !\n~h~~r~Il vous manque une canne à peche~s~"
                            )
                        end
                    end
                else
                    if dist <= 15.0 and not exercising then
                        sleep = 0
                        DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, pos["exercise"])
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end
)

function AttachEntityToPed(prop, bone_ID, x, y, z, RotX, RotY, RotZ)
    BoneID = GetPedBoneIndex(LocalPlayer().Ped, bone_ID)
    obj = Atlantiss.World.Object:Create(prop, LocalPlayer().Pos, true, true, true)
    vX, vY, vZ = table.unpack(LocalPlayer().Pos)
    xRot, yRot, zRot = table.unpack(GetEntityRotation(LocalPlayer().Ped, 2))
    AttachEntityToEntity(obj, LocalPlayer().Ped, BoneID, x, y, z, RotX, RotY, RotZ, false, false, false, false, 2, true)
    return obj
end

function startExerciseFishing(animInfo, pos)
    local playerPed = LocalPlayer().Ped

    fishRod = AttachEntityToPed("prop_fishing_rod_01", 60309, 0, 0, 0, 0, 0, 0)

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
                    "Appuyez sur ~g~[E]~w~ pour agiter l'hameçon",
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
                    "Appuyez sur ~r~[SUPP]~w~ pour arreter de pecher",
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
                    if IsControlJustPressed(0, Keys["E"]) then -- press space to train
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
                        AddProcentFishing(
                            animInfo["actionProcent"],
                            animInfo["actionProcentTimes"],
                            animInfo["actionTime"] - 70
                        )
                        canExercise = true
                    end
                    if IsControlJustPressed(0, Keys["DELETE"]) then -- press delete to exit training
                        ExitTrainingFishing(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
                    end
                else
                    math.randomseed(GetGameTimer())
                    local chanceToHaveAFish = math.random(0, 100)

                    if (chanceToHaveAFish <= 90) then
                        local itemWin = Atlantiss.Utils:GetRandomValueFromDropTable(pos["item"])
                        local chanceToWinTheFish = math.random(0, 100)

                        if Atlantiss.Inventory:CanReceive(itemWin.name, 1) then
                            Atlantiss.Inventory:AddItem({name = itemWin.name, data = {weight = math.random(1, 5)}})
                            ShowNotification(
                                "Vous avez récupéré ~b~1~w~ ~g~" .. Items[itemWin.name].label .. "~w~."
                            )
                        else
                            ShowNotification("~r~Vous n'avez plus assez de place~w~.")
                        end
                    else
                        ShowNotification("~h~~r~Votre prise s'est échapée !~s~")
                    end

                    ExitTrainingFishing(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
                end
            end
        end
    )
end

function AddProcentFishing(amount, amountTimes, time)
    for i = 1, amountTimes do
        Citizen.Wait(time / amountTimes)
        procent = procent + amount
    end
end

function ExitTrainingFishing(exitDict, exitAnim, exitTime)
    TaskPlayAnim(LocalPlayer().Ped, exitDict, exitAnim, 8.0, -8.0, exitTime, 0, 0.0, 0, 0, 0)
    DeleteEntity(fishRod)
    Citizen.Wait(exitTime)
    canExercise = false
    exercising = false
    procent = 0
end

Citizen.CreateThread(
    function()
        for i = 1, #ConfigFishing.Blips, 1 do
            local Blip = ConfigFishing.Blips[i]
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
