inMission = false
currentMission = {}
function StartIllegalMission(mission, k)
    local lvl = GetPlyLevel()

    TriggerServerCallback("Atlantiss::SE::Service:GetTotalServiceCountForJobs", 
        function(allcount)
            if allcount >= mission.policeRequired then
                if mission.levelRequired <= lvl then
                    TriggerServerCallback(
                        "Atlantiss::illegal:canDoIllegalMission",
                        function(bool)
                            if (bool == true) then
                                TriggerServerEvent("Atlantiss::illegal:addCount", mission.scenarioType)
                                mission.label = k
                                currentMission = mission
                                illegalscenario[mission.scenarioIndex](mission.scenarioSettings)
                                inMission = true
                                if (currentMission.scenarioSettings ~= nil) then
                                    if (currentMission.scenarioSettings.hours ~= nil) then
                                        currentMission.timeLeft =
                                            (currentMission.scenarioSettings.hours * 60 * 1000 * 60.0) +
                                            GetGameTimer()
                                    end
                                    if (currentMission.scenarioSettings.minutes ~= nil) then
                                        currentMission.timeLeft =
                                            (currentMission.scenarioSettings.minutes * 60 * 1000) +
                                            GetGameTimer()
                                    end
                                end
                            else
                                ShowNotification("~r~Il n'y a plus de contrats pour vous aujourd'hui !")
                                return
                            end
                        end,
                        mission.scenarioType
                    )
                else
                    ShowNotification("~r~Faites vous d'abord un nom dans le milieu !")
                end
            else
                ShowNotification("~r~Pas de commande aujourd'hui")
            end
        end,
        {"police", "lssd"}
    )
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("personnal", "illegal")) then
                if currentMission.label == nil then
                    CloseAllMenus()
                end
                RageUI.DrawContent(
                    {header = true, glare = true},
                    function()
                        RageUI.Button(
                            "Recruter",
                            "Permet de ne pas perdre d'expérience et de pouvoir partager l'expérience avec les personnes participantes à la missions",
                            {},
                            true,
                            function(_, A, Selected)
                                if A then
                                    HoverPlayer()
                                end
                                if Selected then
                                    local ply = GetPlayerServerIdInDirection(1.5)
                                    if ply then
                                        local f = false
                                        for i = 1, #currentMission.participant, 1 do
                                            if ply == currentMission.participant[i] then
                                                f = true
                                                break
                                            end
                                        end
                                        if not f then
                                            table.insert(currentMission.participant, ply)
                                            TriggerServerEvent("editIllegalMission", currentMission)
                                            TriggerPlayerEvent("currentMissionIs", ply, currentMission)
                                        end
                                    else
                                        ShowNotification("Aucun joueur proche")
                                    end
                                end
                            end
                        )
                        RageUI.Button(
                            "Intitulé",
                            nil,
                            {RightLabel = currentMission.label},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        if currentMission.streetName ~= nil then
                            RageUI.Button(
                                "Quartier",
                                nil,
                                {RightLabel = currentMission.streetName},
                                true,
                                function(_, _, Selected)
                                end
                            )
                        end

                        if currentMission.goalCar ~= nil then
                            RageUI.Button(
                                "Véhicule à voler",
                                nil,
                                {RightLabel = currentMission.goalCar},
                                true,
                                function(_, _, Selected)
                                end
                            )
                        end

                        RageUI.Button(
                            "Temps restant",
                            nil,
                            {RightLabel = returnTime(currentMission.timeLeft - GetGameTimer(), true)},
                            true,
                            function(_, _, Selected)
                            end
                        )
                    end,
                    function()
                    end
                )
            end
        end
    end
)

RegisterNetEvent("currentMissionIs")
AddEventHandler(
    "currentMissionIs",
    function(_x)
        currentMission = _x
    end
)
