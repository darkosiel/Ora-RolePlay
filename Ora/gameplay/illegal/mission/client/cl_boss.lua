local currentZone = nil
local function Build()
    for i = 1, #missionConfig.boss, 1 do
        local v = missionConfig.boss[i]
        Ped:Add(v.name, v.model, v.pos, nil)
        RMenu.Add(
            "illegal",
            "boss_" .. i,
            RageUI.CreateMenu("Missions", "Actions disponibles", nil, nil, nil, nil, 52, 177, 74, 1.0)
        )
        Zone:Add(
            v.pos,
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                currentZone = i
                KeySettings:Add(
                    "keyboard",
                    "E",
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "boss_" .. i), true)
                    end,
                    "illegal_" .. i
                )
                KeySettings:Add(
                    "controller",
                    46,
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "boss_" .. i), true)
                    end,
                    "illegal_" .. i
                )
            end,
            function()
                CloseAllMenus()
                currentZone = nil
                KeySettings:Clear("keyboard", "E", "illegal_" .. i)
                KeySettings:Clear("controller", 46, "illegal_" .. i)
                Hint:RemoveAll()
            end,
            i,
            1.5
        )
    end
    RMenu.Add(
        "illegal",
        "recel",
        RageUI.CreateMenu("Receleur", "Actions disponibles", nil, nil, nil, nil, 52, 177, 74, 1.0)
    )
    for i = 1, #missionConfig.receleurPos, 1 do
        Ped:Add("Malcom", "s_m_y_dealer_01", missionConfig.receleurPos[i], nil)
        Zone:Add(
            missionConfig.receleurPos[i],
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                KeySettings:Add(
                    "keyboard",
                    "E",
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "recel"), true)
                    end,
                    "recel"
                )
                KeySettings:Add(
                    "controller",
                    46,
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "recel"), true)
                    end,
                    "recel"
                )
            end,
            function()
                CloseAllMenus()
                KeySettings:Clear("keyboard", "E", "recel")
                KeySettings:Clear("controller", 46, "recel")
                Hint:RemoveAll()
            end,
            i,
            1.5
        )
    end
   
    RMenu.Add(
        "illegal",
        "carjacking",
        RageUI.CreateMenu("Reception CarJacking", "Actions disponibles", nil, nil, nil, nil, 52, 177, 74, 1.0)
    )
    for i = 1, #missionConfig.receleurCarjackingPos, 1 do
        Ped:Add(
            missionConfig.receleurCarjackingPos[i].name,
            missionConfig.receleurCarjackingPos[i].model,
            missionConfig.receleurCarjackingPos[i].pos,
            nil
        )
        Zone:Add(
            missionConfig.receleurCarjackingPos[i].pos,
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                KeySettings:Add(
                    "keyboard",
                    "E",
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "carjacking"), true)
                    end,
                    "carjacking"
                )
                KeySettings:Add(
                    "controller",
                    46,
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "carjacking"), true)
                    end,
                    "carjacking"
                )
            end,
            function()
                CloseAllMenus()
                KeySettings:Clear("keyboard", "E", "carjacking")
                KeySettings:Clear("controller", 46, "carjacking")
                Hint:RemoveAll()
            end,
            i,
            1.5
        )
    end
end

Citizen.CreateThread(
    function()
        Build()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("illegal", "recel")) then
                RageUI.DrawContent(
                    {header = true, glare = true},
                    function()
                        RageUI.Button(
                            "Rendre un véhicule",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local veh = ClosestVeh()
                                    if (Ora.Illegal.CarRoberry:IsMissionRunning()) then
                                        if (veh == Ora.Illegal.CarRoberry:GetMissionVehicle()) then

                                            if (Ora.Illegal.CarRoberry:VehicleHasBeenSprayed() == false) then
                                                Ora.Illegal.CarRoberry:ShowAdvancedNotification("NON NON NON! LA VOITURE EST PAS REPEINTE ! TU M'AS CRAME !")

                                                TriggerServerCallback("Ora::SE::RetrieveMissionById", function(mission)
                                                    currentMission = mission
                                                    Ora.Illegal.CarRoberry:LogToDiscord("[USEBUG] A tenté de rendre une voiture sans repeindre", "warning")
                                                    TriggerEvent("Ora:illegal:counterStop")
                                                    local playerCoords = LocalPlayer().Pos
                                                    TriggerServerEvent("MissionFinished", currentMission)
                                                    inMission = false
                                                    Ora.Illegal.CarRoberry:Finish()
    
                                                    if currentMission.blip ~= nil then
                                                        RemoveBlip(currentMission.blip)
                                                        currentMission.blip = nil
                                                    end
                                                    TriggerServerEvent("missionEnd", currentMission)
                                                    currentMission = {}
                                                    end,
                                                    Ora.Illegal.CarRoberry:GetMissionId()
                                                ) 

                                                return false
                                            end

                                            TriggerServerCallback("Ora::SE::RetrieveMissionById", function(mission)
                                                currentMission = mission
                                                TriggerEvent("Ora:illegal:counterStop")
                                                local playerCoords = LocalPlayer().Pos
                                                TriggerServerEvent("MissionFinished", currentMission)
                                                DeleteEntity(veh)
                                                inMission = false
                                                Ora.Illegal.CarRoberry:ShowAdvancedNotification("Bon boulot!")
                                                Ora.Illegal.CarRoberry:Finish()

                                                if currentMission.blip ~= nil then
                                                    RemoveBlip(currentMission.blip)
                                                    currentMission.blip = nil
                                                end

                                                local f = false
                                                for i = 1, #currentMission.participant, 1 do
                                                    if
                                                        currentMission.participant[i] ==
                                                            GetPlayerServerId(PlayerId())
                                                        then
                                                        f = true
                                                        break
                                                    end
                                                end

                                                for k, v in pairs(currentMission.rewards) do
                                                    if k == "xp" then
                                                        math.randomseed(GetGameTimer())
                                                        local xp = math.random(v[1], v[2])
                                                        if f then
                                                            for i = 1, #currentMission.participant, 1 do
                                                                TriggerPlayerEvent(
                                                                    "XNL_NET:AddPlayerXP",
                                                                    currentMission.participant[i],
                                                                    math.floor(xp / #currentMission.participant)
                                                                )
                                                            end
                                                        end
                                                    end

                                                    if k == "money" then
                                                        math.randomseed(GetGameTimer())
                                                        local r = math.random(v.amount[1], v.amount[2])
                                                        TriggerServerCallback(
                                                            "Ora::SE::Money:Fake:AuthorizePayment", 
                                                            function(token)
                                                                TriggerServerEvent(Ora.Payment.Fake:GetServerEventName(), {TOKEN = token, AMOUNT = r, SOURCE = "Vol véhicule", LEGIT = false})
                                                                TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", r, false)
                                                            end,
                                                            {}
                                                        )
                                                        ShowNotification("Tiens voilà " .. r .. "$")
                                                    end

                                                    if k == "items" then
                                                        Ora.Inventory:AddItems(v)
                                                    end
                                                end
                                                TriggerServerEvent("missionEnd", currentMission)

                                                currentMission = {}

                                                end,
                                                Ora.Illegal.CarRoberry:GetMissionId()
                                            ) 
                                        else
                                            Ora.Illegal.CarRoberry:ShowAdvancedNotification("C'est pas la voiture que j'ai demandé!")
                                        end
                                    else
                                        Ora.Illegal.CarRoberry:ShowAdvancedNotification("Dégage d'ici avant que je te goume!")
                                    end
                                end
                            end
                        )
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("illegal", "carjacking")) then
                RageUI.DrawContent(
                    {header = true, glare = true},
                    function()
                        RageUI.Button(
                            "Rendre un véhicule",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local veh = ClosestVeh()
                                    if (Ora.Illegal.Carjacking:IsMissionRunning()) then
                                        if (veh == Ora.Illegal.Carjacking:GetMissionVehicle()) then
                                            TriggerServerCallback("Ora::SE::RetrieveMissionById", function(mission)
                                                currentMission = mission
                                                TriggerEvent("Ora:illegal:counterStop")
                                                local playerCoords = LocalPlayer().Pos
                                                TriggerServerEvent("MissionFinished", currentMission)
                                                DeleteEntity(veh)
                                                inMission = false
                                                ShowAdvancedNotification(
                                                    "Josh",
                                                    "~b~Dialogue",
                                                    "Merci on va faire affaire plus souvent nous deux !",
                                                    "CHAR_LESTER",
                                                    1
                                                )
                                                
                                                Ora.Illegal.Carjacking:StopCarjacking()

                                                if currentMission.blip ~= nil then
                                                    RemoveBlip(currentMission.blip)
                                                    currentMission.blip = nil
                                                end

                                                local f = false
                                                for i = 1, #currentMission.participant, 1 do
                                                    if
                                                        currentMission.participant[i] ==
                                                            GetPlayerServerId(PlayerId())
                                                        then
                                                        f = true
                                                        break
                                                    end
                                                end

                                                for k, v in pairs(currentMission.rewards) do
                                                    if k == "xp" then
                                                        math.randomseed(GetGameTimer())
                                                        local xp = math.random(v[1], v[2])
                                                        if f then
                                                            for i = 1, #currentMission.participant, 1 do
                                                                TriggerPlayerEvent(
                                                                    "XNL_NET:AddPlayerXP",
                                                                    currentMission.participant[i],
                                                                    math.floor(xp / #currentMission.participant)
                                                                )
                                                            end
                                                        end
                                                    end

                                                    if k == "money" then
                                                        math.randomseed(GetGameTimer())
                                                        local r = math.random(v.amount[1], v.amount[2])
                                                        TriggerServerCallback(
                                                            "Ora::SE::Money:Fake:AuthorizePayment", 
                                                            function(token)
                                                                TriggerServerEvent(Ora.Payment.Fake:GetServerEventName(), {TOKEN = token, AMOUNT = r, SOURCE = "Carjacking", LEGIT = false})
                                                                TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", r, false)
                                                            end,
                                                            {}
                                                        )
                                                        
                                                        ShowNotification("Tiens voilà " .. r .. "$")
                                                    end

                                                    if k == "items" then
                                                        Ora.Inventory:AddItems(v)
                                                    end
                                                end
                                                TriggerServerEvent("missionEnd", currentMission)

                                                currentMission = {}

                                                end,
                                                Ora.Illegal.Carjacking:GetMissionId()
                                            )
                                        else 
                                            ShowAdvancedNotification(
                                                "Josh",
                                                "~b~Dialogue",
                                                "Tu te fous de ma gueule ? Y'a aucune voiture",
                                                "CHAR_LESTER",
                                                1
                                            )
                                        end
                                    end
                                end
                            end
                        )
                    end
                )
            end

            if currentZone ~= nil then
                if RageUI.Visible(RMenu:Get("illegal", "boss_" .. currentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            for i = 1, #missionConfig.boss[currentZone].missions, 1 do
                                RageUI.Button(
                                    missionConfig.boss[currentZone].missions[i],
                                    nil,
                                    {
                                        RightLabel = "Lvl. " ..
                                            missionConfig.missionLists[missionConfig.boss[currentZone].missions[i]].levelRequired
                                    },
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            StartIllegalMission(
                                                missionConfig.missionLists[missionConfig.boss[currentZone].missions[i]],
                                                missionConfig.boss[currentZone].missions[i]
                                            )
                                        end
                                    end
                                )
                            end
                        end
                    )
                end
            end
        end
    end
)
