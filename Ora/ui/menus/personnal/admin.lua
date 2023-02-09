RMenu.Add(
    "personnal",
    "admin",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_plylist",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Administration", "Joueurs connectés")
)
RMenu.Add(
    "personnal",
    "world",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "activity",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_activity",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "activity"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "vehicle",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "world2",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "report",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Administration", "Actions disponibles")
)

RMenu.Add(
    "personnal",
    "admin_plyaction",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_plylist"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_action",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_plyaction"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_money",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_plyaction"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_jobs",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_plyaction"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_banned",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_plyaction"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_items",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_money"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_drug_item",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_money"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_banlist",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_banned"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_warnlist",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_banned"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_reportaction",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "report"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_action_report",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_reportaction"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_money_report",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_reportaction"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_reportitems",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_money_report"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_reportitemdrug",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_money_report"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_jobs_report",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_reportaction"), "Administration", "Actions disponibles")
)

joueurs = false
local pblips = false
imWaiting = false
local filterString = nil
local connectedPlayers = {}
local treport = {}
local webhookadmin = 15
local taketicket = false
local TargetSpectate = nil
local LastPosition = nil
local polarAngleDeg = 0
local azimuthAngleDeg = 90
local radius = -3.5
local cam = nil
local PlayerDate = {}
local ShowInfos = false
local group
local lastModel = nil

RegisterNetEvent("addReportMenu")
AddEventHandler("addReportMenu",function(player, name, message, date, job, orga)
    if Ora.Identity:GetMyGroup() == "superadmin" or Ora.Identity:GetMyGroup() == "staff" then
         RageUI.Popup({message = "~r~Nouveau report enregistré"})
        table.insert(treport, {etat = "❌", id = player, name = name, msg = message, date = date, who = "Personne", job = job, orga = orga})
    end
end)

RegisterNetEvent("closeReport")
AddEventHandler("closeReport",function(index)
    if Ora.Identity:GetMyGroup() == "superadmin" or Ora.Identity:GetMyGroup() == "staff" then
        table.remove(treport, index)
    end
end)

RegisterNetEvent("takeReport")
AddEventHandler("takeReport",function(index, id, name, msg, date, who, take)
    if Ora.Identity:GetMyGroup() == "superadmin" or Ora.Identity:GetMyGroup() == "staff" then
        if take == "true" then
            ett = "✅"
        else
            ett = "❌"
            who = "Personne"
        end
        treport[index] = {etat = ett, id = id, name = name, msg = msg, date = date, who = who}
    end
end)

local object = UIInstructionalButton.__constructor()
local noclip_speed = 1.0

local function veh(vehicle)
    SetEntityAsMissionEntity(vehicle, false, true)
    DeleteVehicle(veh)
end
local Freeze = false
RegisterNetEvent("admin:Freeze")
AddEventHandler(
    "admin:Freeze",
    function()
        FreezeEntityPosition(LocalPlayer().Ped, not Freeze)
        Freeze = not Freeze
    end
)
Citizen.CreateThread(
    function()
        while true do
            local sleep_adminfreeze = 200
            object:onTick()
            if Freeze then
                sleep_adminfreeze = 0
                drawTxt(0.5, 0.5, .9, "Vous êtes freeze", 4, 1, nil, 180, 255, 0, 0)
            end
            Wait(sleep_adminfreeze)
        end
    end
)

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry("FMMC_KEY_TIP1", TextEntry .. "")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function Text(text)
    SetTextColour(186, 186, 186, 255)
    SetTextFont(0)
    SetTextScale(0.378, 0.378)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(false)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 205)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.017, 0.977)
end

function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
    -- convert degrees to radians
    local polarAngleRad = polarAngleDeg * math.pi / 180.0
    local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0

    local pos = {
        x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
        y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
        z = entityPosition.z - radius * math.cos(azimuthAngleRad)
    }

    return pos
end

RegisterNetEvent("admin:changePed")
AddEventHandler(
    "admin:changePed",
    function(modelHashKey)
        if IsModelValid(modelHashKey) then
            RequestModel(modelHashKey)
            while not HasModelLoaded(modelHashKey) do
                Citizen.Wait(500)
            end
            SetPlayerModel(PlayerId(), modelHashKey)
            SetPedDefaultComponentVariation(PlayerPedId())
        else
            ShowNotification("Model de ped Invalide")
        end
    end
)

RegisterNetEvent("admin:restoreAppearance")
AddEventHandler(
    "admin:restoreAppearance",
    function()
        TriggerServerCallback(
            "core:GetSKin2",
            function(skin, model)
                local hash = GetHashKey(model)
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Citizen.Wait(500)
                end
                SetPlayerModel(PlayerId(), hash)
                Citizen.CreateThread(
                    function()
                        Wait(500)
                        UpdateEntityFace(PlayerPedId(), json.decode(skin))
                        RefreshClothes()
                    end
                )
            end
        )
    end
)

RegisterNetEvent("admin:tp")
AddEventHandler(
    "admin:tp",
    function(coords)
        TriggerServerEvent("Ora::SE::RoutingBucket:SwitchToDefaultRoutingBucket")
        SetEntityCoords(LocalPlayer().Ped, coords)
    end
)
RegisterNetEvent("admin:tp2")
AddEventHandler(
    "admin:tp2",
    function(eddq)
        TriggerServerEvent("Ora::SE::RoutingBucket:SwitchToDefaultRoutingBucket")
        TriggerPlayerEvent("admin:tp", eddq, GetEntityCoords(PlayerPedId()))
    end
)

RegisterNetEvent("GetPlayersCoords")
AddEventHandler(
    "GetPlayersCoords",
    function(src)
        TriggerPlayerEvent("myCoordsAre", src, GetEntityCoords(PlayerPedId()))
    end
)

local function SortByName(a, b)
    return a < b
end

Citizen.CreateThread(
    function()
        local CurrentPlayer = {}
        local ReportPly = {}
        local invisible, showcoords = false, false
        local labels = {"1H", "2H", "8H", "12H", "1 jour", "3 jours", "7 jours", "14 jours", "1 mois", "Permanent","Ne rien faire"}
        local hours = {3600, 7200, 28800, 86400, 259200, 604800, 1210000, 2628000, 1210000,999999999999999999999999999999999999999}
        --
        local jobListLabel = {}
        local jobList = {}
        local indexJob = 1
        local indexOrga = 1
        --
        local index = 1
        local indexTP = 1
        local indexDrugType = 1
        local indexDrugQuality = 1
        local bList = {}
        local wList = {}
        local myGroup = Ora.Identity:GetMyGroup()
        for k, v in pairs(Jobs) do
            table.insert(jobListLabel, v.label)
            table.insert(jobList, k)
        end
        Wait(100)
        while true do
            Wait(0)
            if myGroup == "superadmin" or myGroup == "staff" then
                if showcoords then
                    local ped = PlayerPedId()
                    local plyCoords = GetEntityCoords(ped, false)
                    Text(
                        "~r~X~s~: " ..
                            plyCoords.x ..
                                " ~b~Y~s~: " ..
                                    plyCoords.y ..
                                        " ~g~Z~s~: " .. plyCoords.z .. " ~y~Angle~s~: " .. GetEntityHeading(ped)
                    )
                end

                if invisible then
                    SetEntityVisible(PlayerPedId(), false, false)
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Liste des joueurs",
                                nil,
                                {
                                    RightLabel = "→"
                                },
                                true,
                                function(_, _, Selected) 
                                    if Selected then
                                        TriggerServerCallback(
                                            "onlinePlayers:list",
                                            function(users)
                                                connectedPlayers = users
                                            end
                                        )
                                    end
                                end,
                                RMenu:Get("personnal", "admin_plylist")
                            )
                            RageUI.Button(
                                "Modération",
                                nil,
                                {
                                    RightLabel = "→"
                                },
                                true,
                                function(_, _, _)
                                end,
                                RMenu:Get("personnal", "world")
                            )

                            RageUI.Button(
                                "Véhicule",
                                nil,
                                {
                                    RightLabel = "→"
                                },
                                true,
                                function(_, _, _)
                                end,
                                RMenu:Get("personnal", "vehicle")
                            )

                            RageUI.Button(
                                "Monde",
                                nil,
                                {
                                    RightLabel = "→"
                                },
                                true,
                                function(_, _, _)
                                end,
                                RMenu:Get("personnal", "world2")
                            )

                            RageUI.Button(
                                "Liste des reports",
                                nil,
                                {RightLabel = "→"},
                                true,
                                function(_, _, _)
                                end,
                                RMenu:Get("personnal", "report")
                            )

                            RageUI.Button(
                                "Activité",
                                nil,
                                {
                                    RightLabel = "→"
                                },
                                true,
                                function(_, _, _)
                                end,
                                RMenu:Get("personnal", "activity")
                            )

                            RageUI.Button(
                                "Faire une annonce",
                                nil,
                                {RightLabel = ""},
                                true,
                                function(_, _, S)
                                    if S then
										exports['Snoupinput']:ShowInput("Texte de l'annonce", 255, "text", "", true, true)
                                        local text = exports['Snoupinput']:GetInput()
                                        if text ~= false and text ~= "" then
                                            TriggerServerEvent(
                                                "Job:Annonce",
                                                "Ora RP",
                                                "~g~Annonce",
                                                text,
                                                "CHAR_ORA",
                                                1
                                            )
                                        end
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("personnal", "admin_action")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Envoyer un message",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
										exports['Snoupinput']:ShowInput("Message", 100, "text", "", true)
                                        local message = exports['Snoupinput']:GetInput()
                                        if message ~= false and message ~= "" then
                                        	TriggerServerEvent("sendMessageReport", CurrentPlayer.serverId, message)
											ShowNotification(string.format('~g~Vous avez envoyé ~s~%s~g~ à ~s~%s', message, CurrentPlayer.name))
										end
                                    end
                                end
                            )
                            RageUI.List(
                                "Téléportation",
                                {
                                    "Sur le joueur",
                                    "Sur vous",
                                    "Sur le marqueur",
                                    "Location - Los Santos",
                                    "Location - Sandy Shore"
                                },
                                indexTP,
                                nil,
                                {},
                                true,
                                function(_, _, Selected, Index)
                                    indexTP = Index
                                    if Selected then
                                        if Index == 1 then
											ShowNotification(string.format('~g~Vous avez été TP à ~s~%s', CurrentPlayer.name))
                                            TriggerPlayerEvent(
                                                "admin:tp2",
                                                CurrentPlayer.serverId,
                                                GetPlayerServerId(PlayerId())
                                            )
                                        elseif Index == 2 then
											ShowNotification(string.format('~g~Vous avez TP ~s~%s~g~ à vous', CurrentPlayer.name))
                                            TriggerPlayerEvent("admin:tp", CurrentPlayer.serverId, LocalPlayer().Pos)
                                        elseif Index == 3 then
                                            local blipCoord = GetBlipCoords(GetFirstBlipInfoId(8))
                                            local foundGround, zCoords, zPos = false, -500.0, 0.0
                                            while not foundGround do
                                                zCoords = zCoords + 10.0
                                                RequestCollisionAtCoord(blipCoord.x, blipCoord.y, zCoords)
                                                foundGround, zPos =
                                                    GetGroundZFor_3dCoord(blipCoord.x, blipCoord.y, zCoords)
                                                if not foundGround and zCoords >= 2000.0 then
                                                    foundGround = true
                                                end
                                                Wait(0)
                                            end
                                            if blipCoord ~= nil and blipCoord ~= vector3(0, 0, 0) then
												ShowNotification(string.format('~g~Vous avez TP ~s~%s~g~ à la position du marqueur', CurrentPlayer.name))
                                                TriggerPlayerEvent(
                                                    "admin:tp",
                                                    CurrentPlayer.serverId,
                                                    vector3(blipCoord.x, blipCoord.y, zPos)
                                                )
                                            else
                                                ShowNotification("~r~Aucun marqueur")
                                            end
                                        elseif Index == 4 then
											ShowNotification(string.format('~g~Vous avez TP ~s~%s~g~ à Los Santos', CurrentPlayer.name))
                                            TriggerPlayerEvent(
                                                "admin:tp",
                                                CurrentPlayer.serverId,
                                                vector3(-274.11, -904.78, 31.22)
                                            )
                                        elseif Index == 5 then
                                            ShowNotification(string.format('~g~Vous avez TP ~s~%s~g~ à Sandy Shores', CurrentPlayer.name))
                                            TriggerPlayerEvent(
                                                "admin:tp",
                                                CurrentPlayer.serverId,
                                                vector3(1709.4, 3595.95, 35.42)
                                            )
                                        end
                                    end
                                end
                            )
                            RageUI.Button(
                                "Heal le joueur",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerPlayerEvent("player:Heal", CurrentPlayer.serverId)
                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            webhookadmin,
                                            Ora.Identity:GetMyName() .. " a heal " .. CurrentPlayer.name
                                        )
										ShowNotification(string.format('~g~Vous avez heal ~s~%s', CurrentPlayer.name))
                                    end
                                end
                            )

                            RageUI.Button(
                                "Revive le joueur",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerPlayerEvent("player:Revive", CurrentPlayer.serverId)
                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            webhookadmin,
                                            Ora.Identity:GetMyName() .. " a revive " .. CurrentPlayer.name
                                        )
										ShowNotification(string.format('~g~Vous avez revive ~s~%s', CurrentPlayer.name))
                                    end
                                end
                            )

                            RageUI.Button(
                                "Changer en Ped",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
										exports['Snoupinput']:ShowInput("Nom du ped", 100, "text", "", true)
                                        local pedModel = exports['Snoupinput']:GetInput()
                                        if pedModel ~= false and pedModel ~= "" and #pedModel ~= 0 then
											if IsModelValid(GetHashKey(pedModel)) then
												TriggerPlayerEvent(
													"admin:changePed",
													CurrentPlayer.serverId,
													GetHashKey(pedModel)
												)

												TriggerServerEvent(
													"Ora:sendToDiscord",
													webhookadmin,
													Ora.Identity:GetMyName() ..
														" a changer le ped de " ..
															CurrentPlayer.name .. " en " .. pedModel
												)
												ShowNotification(string.format('~g~Vous avez changé ~s~%s~g~ en ~s~%s', CurrentPlayer.name, pedModel))
											else
												ShowNotification("~r~Model de ped invalide.")
											end
										else
											ShowNotification("~r~Model de ped invalide.")
										end
                                    end
                                end
                            )

                            RageUI.Button(
                                "Redonner son apparence",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerPlayerEvent("admin:restoreAppearance", CurrentPlayer.serverId)
                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            webhookadmin,
                                            Ora.Identity:GetMyName() ..
                                                " a restauré l'apparence de " .. CurrentPlayer.name
                                        )
										ShowNotification(string.format('Vous avez rendu l\'apparence à ~s~%s', CurrentPlayer.name))
                                    end
                                end
                            )
                            RageUI.Button(
                                "Freeze",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        ShowNotification("~r~Joueur Freeze (" .. CurrentPlayer.name .. ")")
                                        TriggerPlayerEvent("admin:Freeze", CurrentPlayer.serverId)
                                    end
                                end
                            )
                            RageUI.Button(
                                "Inventaire",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        CloseAllMenus()
                                        FouilleAdmin(CurrentPlayer.serverId)
                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            webhookadmin,
                                            Ora.Identity:GetMyName() .. " a fouillé " .. CurrentPlayer.name
                                        )
                                    end
                                end
                            )
                            RageUI.Button(
                                "Réinitialiser le personnage",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerPlayerEvent("Ora::CE::Game:InitGames", CurrentPlayer.serverId)
										ShowNotification(string.format('~g~Le personnage de ~s~%s~g~ a été réinitialisé', CurrentPlayer.name))
                                    end
                                end
                            )
                            RageUI.Button(
                                "Prendre un screenshot",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerPlayerEvent("Ora::CE::General:Snap", CurrentPlayer.serverId, {TOKEN = "Screenshot réclamé par " .. Ora.Identity:GetMyName(), SERVER_EVENT = "Ora::SE::Anticheat:ScreenshotTaken"})
										ShowNotification(string.format('~g~Vous avez prit un Screenshot de ~s~%s', CurrentPlayer.name))
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_money")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Donner argent",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
										exports['Snoupinput']:ShowInput("Montant", 100, "number", "", true)
                                        local Reason = exports['Snoupinput']:GetInput()
                                        if Reason ~= false and Reason ~= "" then
											Reason = tonumber(Reason)
											TriggerServerEvent("money:Add2", Reason, CurrentPlayer.serverId)
											TriggerServerEvent(
												"Ora:sendToDiscord",
												webhookadmin,
												Ora.Identity:GetMyName() ..
													" a give " .. Reason .. "$ à " .. CurrentPlayer.name
											)
											ShowNotification(string.format('~g~Vous avez give $%s d\'argent à ~s~%s', Reason, CurrentPlayer.name))
										end
                                    end
                                end
                            )
                            RageUI.Button(
                                "Donner un item",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_items")
                            )
                            RageUI.Button(
                                "Donner de l'XP illégal",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
										exports['Snoupinput']:ShowInput("Valeur : (Bonne valeur entre 5000 & 10000)", 100, "number", "", true)
                                        local level = exports['Snoupinput']:GetInput()
                                        if level ~= false and level ~= "" and #level ~= 0 then
											TriggerPlayerEvent("XNL_NET:AddPlayerXP", CurrentPlayer.serverId, math.tointeger(level))
											TriggerServerEvent(
												"Ora:sendToDiscord",
												webhookadmin,
												Ora.Identity:GetMyName() ..
													" a donné ".. level .." points d'XP illégal à " .. CurrentPlayer.name
											)
											ShowNotification(string.format('~g~Vous avez donné ~s~%sxp~g~ à ~s~%s', level, CurrentPlayer.name))
										end
                                    end
                                end
                            )
                            RageUI.Button(
                                "Donner Drogue et Qualité",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_drug_item")
                            )
                        end,
                        function()
                        end
                    )
                end 

                if RageUI.Visible(RMenu:Get("personnal", "admin_jobs")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Récupérer les métiers",
                                nil,
                                {},
                                true,
                                function(_, _, Selected, _)
                                    if Selected then
                                        TriggerServerCallback(
                                            "Ora::SVCB::Identity:Job:Get",
                                            function(job)
                                                ShowNotification(string.format('~y~Métier 1:~s~\n%s %s', Jobs[job.name].label, Jobs[job.name].grade[job.rank].label))
                                            end,
                                            CurrentPlayer.serverId
                                        )
                                        TriggerServerCallback(
                                            "Ora::SVCB::Identity:Orga:Get",
                                            function(orga)
                                                ShowNotification(string.format('~y~Métier 2:~s~\n%s %s', Jobs[orga.name].label, Jobs[orga.name].grade[orga.rank].label))
                                            end,
                                            CurrentPlayer.serverId
                                        )
                                    end
                                end
                            )

                            RageUI.List("Changer le métier",jobListLabel,indexJob,nil,{},true,
                            function(_, _, Selected, Index)
                                indexJob = Index
                                if Selected then
                                    currentId = CurrentPlayer.serverId
                                    currentName = CurrentPlayer.name
                                    local NameJob = jobList[indexJob]
                                    exports['Snoupinput']:ShowInput("Grade (MAX : " .. #Jobs[NameJob].grade .. ")", 2, "number", "", true)
                                    local Grade = exports['Snoupinput']:GetInput()
                                    if Grade ~= false and Grade ~= "" and tonumber(Grade) > 0 then
                                        TriggerServerEvent("Ora::SE::Identity:Job:Save", NameJob, Grade, Ora.Identity:GetUuid(currentId))
                                        TriggerPlayerEvent("Ora::CE::Identity:Job:Set", currentId, NameJob, Grade, true)
                                        ShowNotification(string.format('~g~Vous avez changé le job de ~s~%s~g~ en ~s~%s %s', currentName, NameJob, Grade))
                                        TriggerServerEvent("Ora:sendToDiscord",webhookadmin,Ora.Identity:GetMyName() .." a setjob " ..currentName .." en " ..NameJob .." " ..Grade)
                                    end    
                                end
                            end
                        )
                        
                        RageUI.List("Changer le second métier",jobListLabel,indexOrga,nil,{},true,
                            function(_, _, Selected, Index)
                                indexOrga = Index
                                if Selected then
                                    currentId = CurrentPlayer.serverId
                                    currentName = CurrentPlayer.name
                                    local NameJob = jobList[indexOrga]
                                
                                    exports['Snoupinput']:ShowInput("Grade (MAX : " .. #Jobs[NameJob].grade .. ")", 2, "number", "", true)
                                    local Grade = exports['Snoupinput']:GetInput()
                                    if Grade ~= false and Grade ~= "" and tonumber(Grade) > 0 then
                                        TriggerServerEvent("Ora::SE::Identity:Orga:Save", NameJob, Grade, Ora.Identity:GetUuid(currentId))
                                        TriggerPlayerEvent("Ora::CE::Identity:Orga:Set", currentId, NameJob, Grade, true)
                                        ShowNotification(string.format('~g~Vous avez changé le job de ~s~%s~g~ en ~s~%s %s', currentName, NameJob, Grade))
                                        TriggerServerEvent("Ora:sendToDiscord",webhookadmin,Ora.Identity:GetMyName() .." a setjob " ..currentName .." en " ..NameJob .." " ..Grade)
                                    end    
                                end
                            end
                        )
                        end,
                        function()
                        end
                    )
                end 
                if RageUI.Visible(RMenu:Get("personnal", "admin_banned")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Avertir le joueur",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
										exports['Snoupinput']:ShowInput("Raison (obligatoire)", 100, "text", "", true)
                                        local Reason = exports['Snoupinput']:GetInput()
                                        if Reason ~= false and Reason ~= "" then
											TriggerServerEvent("warnPlayer", CurrentPlayer.serverId, Reason)
											ShowNotification(string.format('~g~Vous avez warn ~s~%s~g~ pour ~s~%s', CurrentPlayer.name, Reason))
										end
                                    end
                                end
                            )

                            RageUI.Button(
                                "Exclure le joueur",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
										exports['Snoupinput']:ShowInput("Raison (obligatoire)", 100, "text", "", true)
                                        local Reason = exports['Snoupinput']:GetInput()
                                        if Reason ~= false and Reason ~= "" then
											TriggerServerEvent("kickPlayer", CurrentPlayer.serverId, Reason)
											ShowNotification(string.format('~g~Vous avez kick ~s~%s~g~ pour ~s~%s', CurrentPlayer.name, Reason))
										end
                                    end
                                end
                            )

                            RageUI.Button(
                                "Ban Arme Joueur",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerServerEvent("Ora::Player:banWeapon", CurrentPlayer.serverId, true)
                                        TriggerPlayerEvent("Ora::Player:banWeapon", CurrentPlayer.serverId, true)
                                        TriggerServerEvent("sendMessageReport", CurrentPlayer.serverId, "Vous êtes désormais Ban armes à feu pendant 1 semaine.")
										ShowNotification(string.format('~g~Vous avez ban arme ~s~%s', CurrentPlayer.name))
                                    end
                                end
                            )

                            RageUI.Button(
                                "Unban Arme Joueur",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerServerEvent("Ora::Player:banWeapon", CurrentPlayer.serverId, false)
                                        TriggerPlayerEvent("Ora::Player:banWeapon", CurrentPlayer.serverId, false)
                                        TriggerServerEvent("sendMessageReport", CurrentPlayer.serverId, "Vous n'êtes plus Ban armes à feu.")
										ShowNotification(string.format('~g~Vous avez unban arme ~s~%s', CurrentPlayer.name))
                                    end
                                end
                            )

                            RageUI.List(
                                "Bannir le joueur",
                                labels,
                                index,
                                nil,
                                {},
                                true,
                                function(_, _, Selected, Index)
                                    index = Index
                                    if Selected then
										exports['Snoupinput']:ShowInput("Raison (obligatoire)", 100, "text", "", true)
                                        local Reason = exports['Snoupinput']:GetInput()
                                        if Reason ~= false and Reason ~= "" then
                                        	TriggerServerEvent("banPlayer", CurrentPlayer.serverId, Reason, hours[index])
											ShowNotification(string.format("~g~Le joueur ~s~%s~g~, a été banni ~y~%s~g~ pour ~y~%s", CurrentPlayer.name, labels[index], Reason))
										end
                                    end
                                end
                            )

                            RageUI.CenterButton("~b~↓↓↓ ~s~Historique ~b~↓↓↓",nil,{},true,function(_, _, _)end)
                            RageUI.Button(
                                "Historique bannissement",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerServerCallback(
                                            "GetHistoBan",
                                            function(ban)
                                                bList = ban
                                            end,
                                            CurrentPlayer.serverId
                                        )
                                    end
                                end,
                                RMenu:Get("personnal", "admin_banlist")
                            )

                            RageUI.Button(
                                "Avertissements",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerServerCallback(
                                            "GetHistoWarn",
                                            function(warns)
                                                wList = warns
                                            end,
                                            CurrentPlayer.serverId
                                        )
                                    end
                                end,
                                RMenu:Get("personnal", "admin_warnlist")
                            )
                        end,
                        function()
                        end
                    )
                end 

                if RageUI.Visible(RMenu:Get("personnal", "admin_items")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "🔍 Rechercher",
                                nil,
                                {RightLabel = filterString},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        exports['Snoupinput']:ShowInput("Filtre", 25, "text", "", true)
                                        local text = exports['Snoupinput']:GetInput()
                                        if text ~= false and text ~= "" then
                                            filterString = text
                                        else
                                            filterString = nil
                                        end
                                    end
                                end
                            )
                            for k, v in pairs(Items) do
                                if
                                    filterString == nil or string.find(v.label, filterString) or
                                        string.find(k, filterString)
                                 then
                                    RageUI.Button(
                                        v.label,
                                        nil,
                                        {},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                local ItemName = k
                                                local ItemNb = tonumber(KeyboardInput("Nombre d'item", "", 100))
                                                if ItemNb == nil then
                                                    return
                                                end

                                                if (Items[ItemName] ~= nil and Items[ItemName].label ~= nil) then
                                                    TriggerPlayerEvent(
                                                        "RageUI:Popup",
                                                        CurrentPlayer.serverId,
                                                        {
                                                            message = "~r~~h~ADMIN~h~~s~\n~g~Vous avez reçu " ..
                                                                ItemNb .. "x " .. Items[ItemName].label .. "~s~"
                                                        }
                                                    )

                                                    ShowNotification(
                                                        "~r~~h~ADMIN~h~~s~\n~g~Vous avez envoyé " ..
                                                            ItemNb .. "x " .. Items[ItemName].label .. "~s~"
                                                    )
                                                end

                                                local sendItems = {}
                                                local itemSent = 0

                                                for i = 1, ItemNb, 1 do
                                                    itemSent = itemSent + 1
                                                    table.insert(sendItems, {name = ItemName})

                                                    if (itemSent >= 150) then
                                                        TriggerPlayerEvent(
                                                            "Ora::CE::Inventory:AddItems",
                                                            CurrentPlayer.serverId,
                                                            sendItems
                                                        )
                                                        sendItems = {}
                                                        itemSent = 0
                                                        Wait(100)
                                                    end
                                                end

                                                if (itemSent > 0) then
                                                    TriggerPlayerEvent(
                                                        "Ora::CE::Inventory:AddItems",
                                                        CurrentPlayer.serverId,
                                                        sendItems
                                                    )
                                                    sendItems = {}
                                                    itemSent = 0
                                                end

                                                TriggerServerEvent(
                                                    "Ora:sendToDiscord",
                                                    webhookadmin,
                                                    Ora.Identity:GetMyName() ..
                                                        " a donner " ..
                                                            ItemNb .. " " .. ItemName .. " à " .. CurrentPlayer.name
                                                )
                                            end
                                        end
                                    )
                                end
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_drug_item")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.List(
                                "Type de drogue",
                                {"Weed", "Meth", "Cocaine", "Crack"},
                                indexDrugType,
                                nil,
                                {},
                                true,
                                function(_, _, Selected, Index)
                                    indexDrugType = Index
                                end
                            )
                            RageUI.List(
                                "Qualité",
                                {"Merdique", "Basse", "Moyenne", "Bonne", "Excellente", "Inégalable"},
                                indexDrugQuality,
                                nil,
                                {},
                                true,
                                function(_, _, Selected, Index)
                                    indexDrugQuality = Index
                                    if Selected then
                                        local ItemNb = tonumber(KeyboardInput("Nombre d'item", "", 100))
                                        if ItemNb == nil then
                                            return
                                        end

                                        local itemName = nil
                                        local item = {}
                                        local quality = nil

                                        item["name"] = nil
                                        item["label"] = "Qualité merdique"
                                        item["data"] = {quality = 10}

                                        if (indexDrugType == 1) then
                                            item["name"] = "weed_pooch"
                                            itemName = "weed_pooch"
                                        elseif (indexDrugType == 2) then
                                            item["name"] = "meth"
                                            itemName = "meth"
                                        elseif (indexDrugType == 3) then
                                            item["name"] = "coke1"
                                            itemName = "coke1"
                                        else
                                            item["name"] = "crack"
                                            itemName = "crack"
                                        end

                                        if Index == 1 then
                                            item["label"] = "Qualité merdique"
                                            quality = "Qualité merdique"
                                            item["data"] = {quality = 10}
                                        elseif (Index == 2) then
                                            item["label"] = "Qualité basse"
                                            quality = "Qualité basse"
                                            item["data"] = {quality = 35}
                                        elseif (Index == 3) then
                                            item["label"] = "Qualité moyenne"
                                            quality = "Qualité moyenne"
                                            item["data"] = {quality = 49}
                                        elseif (Index == 4) then
                                            item["data"] = {quality = 74}
                                            item["label"] = "Qualité bonne"
                                            quality = "Qualité bonne"
                                        elseif (Index == 5) then
                                            item["data"] = {quality = 90}
                                            quality = "Qualité excellente"
                                            item["label"] = "Qualité excellente"
                                        else
                                            item["data"] = {quality = 100}
                                            quality = "Qualité inégalable"
                                            item["label"] = "Qualité inégalable"
                                        end

                                        local sendItems = {}
                                        local itemSent = 0

                                        if (Items[itemName] ~= nil and Items[itemName].label ~= nil) then
                                            TriggerPlayerEvent(
                                                "RageUI:Popup",
                                                CurrentPlayer.serverId,
                                                {
                                                    message = "~r~~h~ADMIN~h~~s~\n~g~Vous avez reçu " ..
                                                        ItemNb ..
                                                            "x " ..
                                                                Items[itemName].label ..
                                                                    " de qualité : " .. quality .. "~s~"
                                                }
                                            )

                                            ShowNotification(
                                                "~r~~h~ADMIN~h~~s~\n~g~Vous avez envoyé " ..
                                                    ItemNb ..
                                                        "x " ..
                                                            Items[itemName].label ..
                                                                " de qualité : " .. quality .. "~s~"
                                            )
                                        end

                                        for i = 1, ItemNb, 1 do
                                            itemSent = itemSent + 1
                                            table.insert(
                                                sendItems,
                                                {name = item.name, data = item.data, label = item.label}
                                            )

                                            if (itemSent >= 150) then
                                                TriggerPlayerEvent(
                                                    "Ora::CE::Inventory:AddItems",
                                                    CurrentPlayer.serverId,
                                                    sendItems
                                                )
                                                sendItems = {}
                                                itemSent = 0
                                                Wait(100)
                                            end
                                        end

                                        if (itemSent > 0) then
                                            TriggerPlayerEvent(
                                                "Ora::CE::Inventory:AddItems",
                                                CurrentPlayer.serverId,
                                                sendItems
                                            )
                                            sendItems = {}
                                            itemSent = 0
                                        end

                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            webhookadmin,
                                            Ora.Identity:GetMyName() ..
                                                " a donner " ..
                                                    ItemNb ..
                                                        " " ..
                                                            itemName .. " (" .. quality .. ") à " .. CurrentPlayer.name
                                        )
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_banlist")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            for i = 1, #bList, 1 do
                                local v = bList[i]
                                RageUI.Button(
                                    v.reason .. " (" .. v.moderator .. ")",
                                    nil,
                                    {RightLabel = v.date .. " -> " .. v.unbandate},
                                    true,
                                    function(_, _, Selected)
                                    end
                                )
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_warnlist")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            for i = 1, #wList, 1 do
                                local v = wList[i]
                                RageUI.Button(
                                    v.reason .. " (" .. v.moderator .. ")",
                                    nil,
                                    {RightLabel = v.date},
                                    true,
                                    function(_, _, Selected)
                                    end
                                )
                            end
                        end,
                        function()
                        end
                    )
                end 

                if RageUI.Visible(RMenu:Get("personnal", "admin_action_report")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Envoyer un message",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
										exports['Snoupinput']:ShowInput("Message", 100, "text", "", true)
                                        local text = exports['Snoupinput']:GetInput()
                                        if text ~= false and text ~= "" then
											TriggerServerEvent("sendMessageReport", ReportPly.id, text)
											ShowNotification(string.format('~g~Vous avez envoyé ~s~%s~g~ a ~s~%s', text, ReportPly.name))
										end
                                    end
                                end
                            )
                            RageUI.List(
                                "Téléportation",
                                {
                                    "Sur le joueur",
                                    "Sur vous",
                                    "Sur le marqueur",
                                    "Location - Los Santos",
                                    "Location - Sandy Shore"
                                },
                                indexTP,
                                nil,
                                {},
                                true,
                                function(_, _, Selected, Index)
                                    indexTP = Index
                                    if Selected then
                                        if Index == 1 then
											ShowNotification(string.format('~g~Vous vous êtes TP à ~s~%s', ReportPly.name))
                                            TriggerPlayerEvent("admin:tp2", ReportPly.id, GetPlayerServerId(PlayerId()))
                                        elseif (Index == 2) then
                                            TriggerPlayerEvent("admin:tp", ReportPly.id, LocalPlayer().Pos)
											ShowNotification(string.format('~g~Vous avez TP ~s~%s~g~ à vous', ReportPly.name))
                                        elseif (Index == 3) then
                                            local blipCoord = GetBlipCoords(GetFirstBlipInfoId(8))
                                            local foundGround, zCoords, zPos = false, -500.0, 0.0
                                            while not foundGround do
                                                zCoords = zCoords + 10.0
                                                RequestCollisionAtCoord(blipCoord.x, blipCoord.y, zCoords)
                                                foundGround, zPos =
                                                    GetGroundZFor_3dCoord(blipCoord.x, blipCoord.y, zCoords)
                                                if not foundGround and zCoords >= 2000.0 then
                                                    foundGround = true
                                                end
                                                Wait(0)
                                            end
                                            if blipCoord ~= nil and blipCoord ~= vector3(0, 0, 0) then
												ShowNotification(string.format('~g~Vous avez TP ~s~%s~g~ à la position de votre marqueur', ReportPly.name))
                                                TriggerPlayerEvent(
                                                    "admin:tp",
                                                    ReportPly.id,
                                                    vector3(blipCoord.x, blipCoord.y, zPos)
                                                )
                                            else
                                                ShowNotification("~r~Aucun marqueur")
                                            end
                                        elseif (Index == 4) then
											ShowNotification(string.format('~g~Vous avez TP ~s~%s~g~ à Los Santos', ReportPly.name))
                                            TriggerPlayerEvent(
                                                "admin:tp",
                                                ReportPly.id,
                                                vector3(-274.11, -904.78, 31.22)
                                            )
                                        elseif (Index == 5) then
                                            ShowNotification(string.format('~g~Vous avez TP ~s~%s~g~ à Sandy Shores', ReportPly.name))
                                            TriggerPlayerEvent(
                                                "admin:tp",
                                                ReportPly.id,
                                                vector3(1709.4, 3595.95, 35.42)
                                            )
                                        end
                                    end
                                end
                            )
                            RageUI.Button(
                                "Revive le joueur",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerPlayerEvent("player:Revive", ReportPly.id)
                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            webhookadmin,
                                            Ora.Identity:GetMyName() ..
                                                " a revive " ..
                                                    ReportPly.name .. " pour le ticket n°" .. ReportPly.index
                                        )
										ShowNotification(string.format('~g~Vous avez revie ~s~%s', ReportPly.name))
                                    end
                                end
                            )
                            RageUI.Button(
                                "Heal le joueur",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerPlayerEvent("player:Heal", ReportPly.id)
                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            webhookadmin,
                                            Ora.Identity:GetMyName() ..
                                                " a heal " .. ReportPly.name .. " pour le ticket n°" .. ReportPly.index
                                        )
										ShowNotification(string.format('~g~Vous avez heal ~s~%s', ReportPly.name))
                                    end
                                end
                            )

                            RageUI.Button(
                                "Réinitialiser le personnage",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerPlayerEvent("Ora::CE::Game:InitGames", ReportPly.id)
										ShowNotification(string.format('~g~Vous avez réinitialisé le personnage de ~s~%s', ReportPly.name))
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_money_report")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Give argent",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
										exports['Snoupinput']:ShowInput("Montant", 100, "number", nil, true)
                                        local Reason = exports['Snoupinput']:GetInput()
                                        if Reason ~= false and Reason ~= "" then
											Reason = tonumber(Reason)
											TriggerServerEvent("money:Add2", Reason, ReportPly.id)
											TriggerServerEvent(
												"Ora:sendToDiscord",
												webhookadmin,
												Ora.Identity:GetMyName() ..
													" a give " ..
														Reason ..
															"$ à " ..
																ReportPly.name ..
																	" pour le ticket n°" .. ReportPly.index
											)
											ShowNotification(string.format('~g~Vous avez give $%s d\'argent à ~s~%s', Reason, ReportPly.name))
										end
                                    end
                                end
                            )
                            RageUI.Button(
                                "Donner Item",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        CurrentPlayer.serverId = nil
                                    end
                                end,
                                RMenu:Get("personnal", "admin_reportitems")
                            )

                            RageUI.Button(
                                "Donner Drogue et Qualité",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_reportitemdrug")
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_jobs_report")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            local rightlbl = ReportPly.job and ReportPly.job.label .. " | " .. Jobs[ReportPly.job.name].grade[ReportPly.job.gradenum].label or nil
                            local rightlbl2 = ReportPly.orga and ReportPly.orga.label .. " | " .. Jobs[ReportPly.orga.name].grade[ReportPly.orga.gradenum].label or nil

                            RageUI.Button(
                                "Récupérer les métiers",
                                nil,
                                {},
                                true,
                                function(_, _, Selected, _)
                                    if Selected then
                                        TriggerServerCallback(
                                            "Ora::SVCB::Identity:Job:Get",
                                            function(job)
                                                ShowNotification(string.format('~y~Métier 1:~s~\n%s %s', Jobs[job.name].label, Jobs[job.name].grade[job.rank].label))
                                            end,
                                            ReportPly.id
                                        )
                                        TriggerServerCallback(
                                            "Ora::SVCB::Identity:Orga:Get",
                                            function(orga)
                                                ShowNotification(string.format('~y~Métier 2:~s~\n%s %s', Jobs[orga.name].label, Jobs[orga.name].grade[orga.rank].label))
                                            end,
                                            ReportPly.id
                                        )
                                    end
                                end
                            )

                            RageUI.List("Changer le métier",jobListLabel,indexJob,nil,{},true,
                            function(_, _, Selected, Index)
                                indexJob = Index
                                if Selected then
                                    local NameJob = jobList[indexJob]
                                    exports['Snoupinput']:ShowInput("Grade (MAX : " .. #Jobs[NameJob].grade .. ")", 2, "number", "", true)
                                    local Grade = exports['Snoupinput']:GetInput()
                                    if Grade ~= false and Grade ~= "" and tonumber(Grade) > 0 then
                                        if ReportPly and ReportPly.id ~= nil then
                                            currentId = ReportPly.id
                                            currentName = ReportPly.name
                                            TriggerServerEvent("Ora:sendToDiscord",webhookadmin,Ora.Identity:GetMyName() .." a setjob " ..ReportPly.name .." en " ..NameJob .. " " ..Grade .." pour le ticket n° " .. ReportPly.index)
                                            rightlbl = nil
                                        end
                                        TriggerServerEvent("Ora::SE::Identity:Job:Save", NameJob, Grade, Ora.Identity:GetUuid(currentId))
                                        TriggerPlayerEvent("Ora::CE::Identity:Job:Set", currentId, NameJob, Grade, true)
                                        ShowNotification(string.format('~g~Vous avez changé le job de ~s~%s~g~ en ~s~%s %s', currentName, NameJob, Grade))
                                        TriggerServerEvent("Ora:sendToDiscord",webhookadmin,Ora.Identity:GetMyName() .." a setjob " ..currentName .." en " ..NameJob .." " ..Grade)
                                    end    
                                end
                            end
                        )
                        
                        RageUI.List("Changer le second métier",jobListLabel,indexOrga,nil,{},true,
                            function(_, _, Selected, Index)
                                indexOrga = Index
                                if Selected then
                                    local NameJob = jobList[indexOrga]
                                    exports['Snoupinput']:ShowInput("Grade (MAX : " .. #Jobs[NameJob].grade .. ")", 2, "number", "", true)
                                    local Grade = exports['Snoupinput']:GetInput()
                                    if Grade ~= false and Grade ~= "" and tonumber(Grade) > 0 then
                                        local currentId
                                        local currentName
                                        if ReportPly and ReportPly.id ~= nil then
                                            currentId = ReportPly.id
                                            currentName = ReportPly.name
                                            TriggerServerEvent("Ora:sendToDiscord",webhookadmin,Ora.Identity:GetMyName() .." a setjob " ..ReportPly.name .." en " ..NameJob .. " " ..Grade .." pour le ticket n° " .. ReportPly.index)
                                            rightlbl2 = nil
                                        end
                                        TriggerServerEvent("Ora::SE::Identity:Orga:Save", NameJob, Grade, Ora.Identity:GetUuid(currentId))
                                        TriggerPlayerEvent("Ora::CE::Identity:Orga:Set", currentId, NameJob, Grade, true)
                                        ShowNotification(string.format('~g~Vous avez changé le job de ~s~%s~g~ en ~s~%s %s', currentName, NameJob, Grade))
                                    end    
                                end
                            end
                        )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_reportaction")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Checkbox(
                                "Prendre le ticket",
                                nil,
                                taketicket,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        if not taketicket then
                                            TriggerServerEvent(
                                                "takeReportS",
                                                ReportPly.index,
                                                ReportPly.id,
                                                ReportPly.name,
                                                ReportPly.msg,
                                                ReportPly.date,
                                                "true"
                                            )
                                        else
                                            TriggerServerEvent(
                                                "takeReportS",
                                                ReportPly.index,
                                                ReportPly.id,
                                                ReportPly.name,
                                                ReportPly.msg,
                                                ReportPly.date,
                                                "false"
                                            )
                                        end
                                        taketicket = not taketicket
                                    end
                                end
                            )

                            RageUI.Button(
                                "Actions",
                                nil,
                                {RightLabel = "→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_action_report")
                            )

                            RageUI.Button(
                                "Remboursement",
                                nil,
                                {RightLabel = "→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_money_report")
                            )

                            RageUI.Button(
                                "Gestions Job",
                                nil,
                                {RightLabel = "→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_jobs_report")
                            )
                            RageUI.Button(
                                "Clôturer le report",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
										exports['Snoupinput']:ShowInput("Etes vous sûr? (oui/non)", 3, "text", "", true)
                                        local message = exports['Snoupinput']:GetInput()
                                        if message ~= false and message ~= "" and (message == "oui" or message == "OUI") then
                                            TriggerServerEvent("closeReportS", ReportPly.index)
                                            taketicket = not taketicket
                                            RageUI.GoBack()
                                            RageUI.Refresh()
                                        end
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_reportitemdrug")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.List(
                                "Type de drogue",
                                {"Weed", "Meth", "Cocaine", "Lsd"},
                                indexDrugType,
                                nil,
                                {},
                                true,
                                function(_, _, Selected, Index)
                                    indexDrugType = Index
                                end
                            )
                            RageUI.List(
                                "Qualité",
                                {"Merdique", "Basse", "Moyenne", "Bonne", "Excellente", "Inégalable"},
                                indexDrugQuality,
                                nil,
                                {},
                                true,
                                function(_, _, Selected, Index)
                                    indexDrugQuality = Index
                                    if Selected then
                                        local ItemNb = tonumber(KeyboardInput("Nombre d'item", "", 100))
                                        if ItemNb == nil then
                                            return
                                        end

                                        local itemName = nil
                                        local item = {}
                                        local quality = nil

                                        item["name"] = nil
                                        item["label"] = "Qualité merdique"
                                        item["data"] = {quality = 10}

                                        if (indexDrugType == 1) then
                                            item["name"] = "weed_pooch"
                                            itemName = "weed_pooch"
                                        elseif (indexDrugType == 2) then
                                            item["name"] = "meth"
                                            itemName = "meth"
                                        elseif (indexDrugType == 3) then
                                            item["name"] = "coke1"
                                            itemName = "coke1"
                                        else
                                            item["name"] = "lsd_pooch"
                                            itemName = "lsd_pooch"
                                        end

                                        if Index == 1 then
                                            item["label"] = "Qualité merdique"
                                            quality = "Qualité merdique"
                                            item["data"] = {quality = 10}
                                        elseif (Index == 2) then
                                            item["label"] = "Qualité basse"
                                            quality = "Qualité basse"
                                            item["data"] = {quality = 35}
                                        elseif (Index == 3) then
                                            item["label"] = "Qualité moyenne"
                                            quality = "Qualité moyenne"
                                            item["data"] = {quality = 49}
                                        elseif (Index == 4) then
                                            item["data"] = {quality = 74}
                                            item["label"] = "Qualité bonne"
                                            quality = "Qualité bonne"
                                        elseif (Index == 5) then
                                            item["data"] = {quality = 90}
                                            quality = "Qualité excellente"
                                            item["label"] = "Qualité excellente"
                                        else
                                            item["data"] = {quality = 100}
                                            quality = "Qualité inégalable"
                                            item["label"] = "Qualité inégalable"
                                        end

                                        local sendItems = {}
                                        local itemSent = 0

                                        if (Items[itemName] ~= nil and Items[itemName].label ~= nil) then
                                            TriggerPlayerEvent(
                                                "RageUI:Popup",
                                                ReportPly.id,
                                                {
                                                    message = "~r~~h~ADMIN~h~~s~\n~g~Vous avez reçu " ..
                                                        ItemNb ..
                                                            "x " ..
                                                                Items[itemName].label ..
                                                                    " de qualité : " .. quality .. "~s~"
                                                }
                                            )

                                            ShowNotification(
                                                "~r~~h~ADMIN~h~~s~\n~g~Vous avez envoyé " ..
                                                    ItemNb ..
                                                        "x " ..
                                                            Items[itemName].label ..
                                                                " de qualité : " .. quality .. "~s~"
                                            )
                                        end

                                        for i = 1, ItemNb, 1 do
                                            itemSent = itemSent + 1
                                            table.insert(
                                                sendItems,
                                                {name = item.name, data = item.data, label = item.label}
                                            )

                                            if (itemSent >= 150) then
                                                TriggerPlayerEvent(
                                                    "Ora::CE::Inventory:AddItems",
                                                    ReportPly.id,
                                                    sendItems
                                                )
                                                sendItems = {}
                                                itemSent = 0
                                                Wait(100)
                                            end
                                        end

                                        if (itemSent > 0) then
                                            TriggerPlayerEvent("Ora::CE::Inventory:AddItems", ReportPly.id, sendItems)
                                            sendItems = {}
                                            itemSent = 0
                                        end

                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            webhookadmin,
                                            Ora.Identity:GetMyName() ..
                                                " a donner " ..
                                                    ItemNb ..
                                                        " " ..
                                                            itemName ..
                                                                " (" ..
                                                                    quality ..
                                                                        ") à " ..
                                                                            ReportPly.name ..
                                                                                "pour le ticket n° " .. ReportPly.index
                                        )
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_reportitems")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "🔍 Rechercher",
                                nil,
                                {RightLabel = filterString},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        exports['Snoupinput']:ShowInput("Filtre", 25, "text", "", true)
                                        local text = exports['Snoupinput']:GetInput()
                                        if text ~= false and text ~= "" then
                                            filterString = text
                                        else
                                            filterString = nil
                                        end
                                    end
                                end
                            )
                            for k, v in pairs(Items) do
                                if
                                    filterString == nil or string.find(v.label, filterString) or
                                        string.find(k, filterString)
                                 then
                                    RageUI.Button(
                                        v.label,
                                        nil,
                                        {},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                local ItemName = k
                                                local ItemNb = tonumber(KeyboardInput("Nombre d'item", "", 100))
                                                if ItemNb == nil then
                                                    return
                                                end

                                                local sendItems = {}
                                                local itemSent = 0

                                                if (Items[ItemName] ~= nil and Items[ItemName].label ~= nil) then
                                                    TriggerPlayerEvent(
                                                        "RageUI:Popup",
                                                        ReportPly.id,
                                                        {
                                                            message = "~r~~h~ADMIN~h~~s~\n~g~Vous avez reçu " ..
                                                                ItemNb .. "x " .. Items[ItemName].label .. "~s~"
                                                        }
                                                    )

                                                    ShowNotification(
                                                        "~r~~h~ADMIN~h~~s~\n~g~Vous avez envoyé " ..
                                                            ItemNb .. "x " .. Items[ItemName].label .. "~s~"
                                                    )
                                                end

                                                for i = 1, ItemNb, 1 do
                                                    itemSent = itemSent + 1
                                                    table.insert(sendItems, {name = ItemName})

                                                    if (itemSent >= 150) then
                                                        math.randomseed(GetGameTimer())
                                                        TriggerPlayerEvent(
                                                            "Ora::CE::Inventory:AddItems",
                                                            ReportPly.id,
                                                            sendItems
                                                        )
                                                        sendItems = {}
                                                        itemSent = 0
                                                        Wait(100)
                                                    end
                                                end

                                                if (itemSent > 0) then
                                                    TriggerPlayerEvent(
                                                        "Ora::CE::Inventory:AddItems",
                                                        ReportPly.id,
                                                        sendItems
                                                    )
                                                    sendItems = {}
                                                    itemSent = 0
                                                end

                                                TriggerServerEvent(
                                                    "Ora:sendToDiscord",
                                                    webhookadmin,
                                                    Ora.Identity:GetMyName() ..
                                                        " a donner " ..
                                                            ItemNb ..
                                                                " " ..
                                                                    ItemName ..
                                                                        " à " ..
                                                                            ReportPly.name ..
                                                                                " pour le ticket n°" .. ReportPly.index
                                                )
                                            end
                                        end
                                    )
                                end
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_plyaction")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()

                            RageUI.Button(
                                "Actions",
                                nil,
                                {RightLabel = "→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_action")
                            )

                            RageUI.Button(
                                "Remboursement",
                                nil,
                                {RightLabel = "→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_money")
                            )

                            RageUI.Button(
                                "Gestions Job",
                                nil,
                                {RightLabel = "→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_jobs")
                            )

                            RageUI.Button(
                                "Gestions ban",
                                nil,
                                {RightLabel = "→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_banned")
                            )

                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "world")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Téléporter sur son marqueur",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local playerPed = LocalPlayer().Ped
                                        local WaypointHandle = GetFirstBlipInfoId(8)
                                        if DoesBlipExist(WaypointHandle) then
                                            local coord =
                                                Citizen.InvokeNative(
                                                0xFA7C7F0AADF25D09,
                                                WaypointHandle,
                                                Citizen.ResultAsVector()
                                            )
                                            SetEntityCoordsNoOffset(
                                                playerPed,
                                                coord.x,
                                                coord.y,
                                                -199.9,
                                                false,
                                                false,
                                                false,
                                                true
                                            )
                                        end
                                    end
                                end
                            )
                            RageUI.Button(
                                "Téléporter sur son marqueur avec le véhicule",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local playerPed = LocalPlayer().Ped
                                        local WaypointHandle = GetFirstBlipInfoId(8)
                                        if DoesBlipExist(WaypointHandle) then
                                            Citizen.CreateThread(
                                                function()
                                                    local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
                                                    local foundGround, zCoords, zPos = false, -500.0, 0.0

                                                    while not foundGround do
                                                        zCoords = zCoords + 10.0
                                                        RequestCollisionAtCoord(
                                                            waypointCoords.x,
                                                            waypointCoords.y,
                                                            zCoords
                                                        )
                                                        Citizen.Wait(0)
                                                        foundGround, zPos =
                                                            GetGroundZFor_3dCoord(
                                                            waypointCoords.x,
                                                            waypointCoords.y,
                                                            zCoords
                                                        )

                                                        if not foundGround and zCoords >= 2000.0 then
                                                            foundGround = true
                                                        end
                                                    end

                                                    SetPedCoordsKeepVehicle(
                                                        playerPed,
                                                        waypointCoords.x,
                                                        waypointCoords.y,
                                                        zPos
                                                    )
                                                end
                                            )
                                        end
                                    end
                                end
                            )
                            
                            RageUI.Button(
                                "Changer son ped",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        exports['Snoupinput']:ShowInput("Nom du ped", 100, "text", "", true)
                                        local Reason = exports['Snoupinput']:GetInput()
                                        if Reason ~= false and Reason ~= "" then
                                            if IsModelValid(GetHashKey(Reason)) then
                                                local hash = GetHashKey(Reason)
                                                RequestModel(hash)
                                                while not HasModelLoaded(hash) do
                                                    Citizen.Wait(500)
                                                end
                                                SetPlayerModel(PlayerId(), hash)
                                                SetPedDefaultComponentVariation(PlayerPedId())
                                            else
                                                ShowNotification("Model de ped Invalide")
                                            end
                                        else
                                            ShowNotification("Model de ped Invalide")
                                        end
                                    end
                                end
                            )

                            RageUI.Button(
                                "Récupérer son apparence",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerServerCallback(
                                            "core:GetSKin2",
                                            function(skin, model)
                                                --(dump(skin))

                                                local hash = GetHashKey(model)
                                                RequestModel(hash)
                                                while not HasModelLoaded(hash) do
                                                    Citizen.Wait(500)
                                                end
                                                SetPlayerModel(PlayerId(), hash)
                                                Citizen.CreateThread(
                                                    function()
                                                        Wait(500)
                                                        UpdateEntityFace(PlayerPedId(), json.decode(skin))
                                                        RefreshClothes()
                                                    end
                                                )
                                            end
                                        )
                                    end
                                end
                            )
                            RageUI.Checkbox(
                                "Nom des joueurs",
                                nil,
                                joueurs,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        joueurs = Checked
                                        if joueurs then
                                            OraAdmin.DISPLAY_NAMES = true
                                            OraAdmin.HandlePlayersNames()
                                            TriggerServerEvent(
                                                "Ora:sendToDiscord",
                                                webhookadmin,
                                                Ora.Identity:GetMyName() .. " active le nom des joueurs"
                                            )
                                        else
                                            OraAdmin.DISPLAY_NAMES = false
                                            OraAdmin.HandlePlayersNames()
                                            TriggerServerEvent(
                                                "Ora:sendToDiscord",
                                                webhookadmin,
                                                Ora.Identity:GetMyName() .. " désactive le nom des joueurs"
                                            )
                                        end
                                    end
                                end
                            )
                            RageUI.Checkbox(
                                "Blip des joueurs",
                                nil,
                                pblips,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        pblips = Checked
                                        if pblips then
                                            TriggerServerEvent(
                                                "Ora:sendToDiscord",
                                                webhookadmin,
                                                Ora.Identity:GetMyName() .. " active les blips "
                                            )
                                        else
                                            TriggerServerEvent(
                                                "Ora:sendToDiscord",
                                                webhookadmin,
                                                Ora.Identity:GetMyName() .. " désactive les blips "
                                            )
                                        end
                                    end
                                end
                            )
                            RageUI.Checkbox(
                                "Coordonnées",
                                nil,
                                showcoords,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        showcoords = Checked
                                    end
                                end
                            )
                            
                            RageUI.Checkbox(
                                "Invisible",
                                nil,
                                invisible,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        invisible = Checked
                                        if not invisible then
                                            SetEntityVisible(PlayerPedId(), true, false)
                                        end
                                    end
                                end
                            )
                            
                            RageUI.Checkbox(
                                "Noclip",
                                nil,
                                isNoclip(),
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        if Checked == true then
                                            invisible = true
                                        end
                                        admin_no_clip()
                                        if Checked then
                                            TriggerServerEvent(
                                                "Ora:sendToDiscord",
                                                webhookadmin,
                                                Ora.Identity:GetMyName() .. " active le no clip "
                                            )
                                        else
                                            TriggerServerEvent(
                                                "Ora:sendToDiscord",
                                                webhookadmin,
                                                Ora.Identity:GetMyName() .. " désactive le no clip "
                                            )
                                        end
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "world2")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Vider la zone de véhicules PNJ sur 25m.",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        ClearAreaOfVehicles(GetEntityCoords(PlayerPedId()), 50.0, false, false, false, false, false)
                                    end
                                end
                            )

                            RageUI.Button(
                                "Vider la zone de peds sur 25m.",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        ClearAreaOfPeds(GetEntityCoords(PlayerPedId()), 50.0, 1)
                                    end
                                end
                            )

                            RageUI.Button(
                                "Vider la zone d'objets sur 25m.",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 50.0, 0)
                                    end
                                end
                            )

                            RageUI.Button(
                                "Vider la zone de tout sur 25m.",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        ClearAreaOfEverything(GetEntityCoords(PlayerPedId()), 50.0, false, false, false, false)
                                    end
                                end
                            )
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "vehicle")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Spawn Véhicule",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        exports['Snoupinput']:ShowInput("Véhicule", 100, "text", "", true)
                                        local ModelName = exports['Snoupinput']:GetInput()
                                        if ModelName ~= false and ModelName ~= "" then
                                            Ora.World.Vehicle:Create(ModelName, LocalPlayer().Pos, GetEntityHeading(LocalPlayer().Ped), {customs = {}, warp_into_vehicle = true, maxFuel = true, health = {}})
                                        end
                                    end
                                end
                            )
                            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
                                RageUI.Button(
                                    "Réparer véhicule",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            local veh = GetVehiclePedIsUsing(LocalPlayer().Ped)
                                            if IsPedInVehicle(PlayerPedId(), veh, false) then
                                                SetVehicleFixed(veh)
                                                SetVehicleDirtLevel(veh, 0.0)
                                            else
                                                veh = ClosestVeh()
                                                if veh ~= 0 then
                                                    SetVehicleFixed(veh)
                                                    SetVehicleDirtLevel(veh, 0.0)
                                                end
                                            end
                                        end
                                    end
                                )
                            end     
                            RageUI.Button(
                                "Supprimer véhicule",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        Admin_DeleteVehicle()
                                            TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            webhookadmin,
                                            Ora.Identity:GetMyName() .. " a dv un véhicule"
                                        )
                                    end
                                end
                            )
                              
                            RageUI.Button(
                                "Retourner le véhicule",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local veh = GetVehicleInDirection(5.0)
                                        SetVehicleOnGroundProperly(veh)
                                        ShowNotification(string.format("Véhicule ~h~%s~h~ a été ~g~%s~s~",  GetVehicleNumberPlateText(veh),"retourné"))
                                    end
                                end
                            )

                            RageUI.Button(
                                "Crocheter véhicule",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local veh = GetVehicleInDirection(5.0)
                                        if veh ~= 0 then
                                            SetVehicleDoorsLockedForAllPlayers(veh, false)
                                            SetVehicleDoorsLocked(veh, 1)
                                            SetEntityAsMissionEntity(veh, true, true)
                                            SetVehicleHasBeenOwnedByPlayer(veh, true)
                                            if (Ora.World.Vehicle.JackedVehicles[veh] == nil) then table.insert(Ora.World.Vehicle.JackedVehicles, veh) end
                                            ShowNotification(string.format("Véhicule ~h~%s~h~ a été ~g~%s~s~", GetVehicleNumberPlateText(veh), "dévérouillé"))
                                        else
                                            ShowNotification(string.format("~r~Aucun véhicule trouvé~s~"))
                                        end
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "report")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            for k, v in pairs(treport) do
                                RageUI.Button(
                                    v.etat .. " " .. v.id .. " - " .. v.name,
                                    "~b~Pris en charge par : ~s~" ..
                                        v.who .. "~n~~b~Date : ~s~" .. v.date .. "~n~~b~Motif : ~s~" .. v.msg,
                                    {RightLabel = "→"},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            ReportPly = {
                                                index = k,
                                                id = v.id,
                                                name = v.name,
                                                date = v.date,
                                                msg = v.msg,
                                                who = v.who,
                                                job = v.job,
                                                orga = v.orga
                                            }
                                        end
                                    end,
                                    RMenu:Get("personnal", "admin_reportaction")
                                )
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "activity")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Perquisitions en cours",
                                nil,
                                {RightLabel = "→"},
                                true,
                                function(_, _, _)
                                end,
                                RMenu:Get("Ora:Immo", "Raids")
                            )

                            RageUI.Button(
                                "Feu",
                                nil,
                                {RightLabel = "→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_activity")
                            )

                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("personnal", "admin_activity")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button("Démarrer un feu", nil,{},true,
                                function(_, _, Selected)
                                    if Selected then
                                        ExecuteCommand("startfire 1 2 3")
                                    end
                                end
                            )
                            RageUI.Button("Stopper le feu ",nil,{},true,
                                function(_, _, Selected)
                                    if Selected then
                                        ExecuteCommand("stopallfires")
                                    end
                                end
                            )
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_plylist")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            local players = {}

                            for _, player in ipairs(connectedPlayers) do
                                table.insert(players, player)
                            end

                            RageUI.Button(
                                "🔍 Rechercher",
                                nil,
                                {RightLabel = filterString},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        exports['Snoupinput']:ShowInput("Filtre", 25, "text", "", true)
                                        local text = exports['Snoupinput']:GetInput()
                                        if text ~= false and text ~= "" then
                                            filterString = text
                                        else
                                            filterString = nil
                                        end
                                    end
                                end
                            )

                            for _, v in pairs(players) do
                                if
                                    filterString == nil or string.find(string.lower(v.name), filterString) or
                                        string.find(_, filterString)
                                 then
                                    RageUI.Button(
                                        v.id .. " - " .. string.lower(v.name),
                                        nil,
                                        {RightLabel = "→"},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                CurrentPlayer = {
                                                    player = v.id,
                                                    serverId = v.id,
                                                    name = string.lower(v.name)
                                                }
                                            end
                                        end,
                                        RMenu:Get("personnal", "admin_plyaction")
                                    )
                                end
                            end
                        end,
                        function()
                        end
                    )
                end
            elseif PlyGroup == "animator" then
                if RageUI.Visible(RMenu:Get("personnal", "admin")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Changer son ped",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        exports['Snoupinput']:ShowInput("Nom du ped", 100, "text", "", true)
                                        local Reason = exports['Snoupinput']:GetInput()
                                        if Reason ~= false and Reason ~= "" then
                                            if IsModelValid(GetHashKey(Reason)) then
                                                local hash = GetHashKey(Reason)
                                                RequestModel(hash)
                                                while not HasModelLoaded(hash) do
                                                    Citizen.Wait(500)
                                                end
                                                SetPlayerModel(PlayerId(), hash)
                                                SetPedDefaultComponentVariation(PlayerPedId())
                                                TriggerServerEvent(
                                                    "Ora:sendToDiscord",
                                                    webhookadmin,
                                                    Ora.Identity:GetMyName() .. " a changé son ped en " .. Reason
                                                )
                                            else
                                                ShowNotification("Model de ped Invalide")
                                            end
                                        else
                                            ShowNotification("Model de ped Invalide")
                                        end
                                    end
                                end
                            )

                            RageUI.Button(
                                "Récupérer son apparence",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerServerCallback(
                                            "core:GetSKin2",
                                            function(skin, model)
                                                local hash = GetHashKey(model)
                                                RequestModel(hash)
                                                while not HasModelLoaded(hash) do
                                                    Citizen.Wait(500)
                                                end
                                                SetPlayerModel(PlayerId(), hash)
                                                Citizen.CreateThread(
                                                    function()
                                                        Wait(500)

                                                        UpdateEntityFace(PlayerPedId(), json.decode(skin))
                                                        RefreshClothes()
                                                    end
                                                )
                                            end
                                        )
                                    end
                                end
                            )

                            RageUI.Button(
                                "Véhicule",
                                nil,
                                {
                                    RightLabel = "→"
                                },
                                true,
                                function(_, _, _)
                                end,
                                RMenu:Get("personnal", "vehicle")
                            )
                        end
                    )
                end
            end
        end
    end
)

TriggerServerCallback(
    "onlinePlayers:list",
    function(users)
        connectedPlayers = users
    end
)

RMenu:Get("personnal", "world"):AddInstructionButton(
    {
        [1] = GetControlInstructionalButton(2, 42, 0),
        [2] = "Noclip plus rapide"
    }
)
RMenu:Get("personnal", "world"):AddInstructionButton(
    {
        [1] = GetControlInstructionalButton(2, 41, 0),
        [2] = "Noclip moins rapide"
    }
)


function Admin_DeleteVehicle()
    local veh = GetVehicleInDirection(5.0)
    if IsPedInAnyVehicle(LocalPlayer().Ped) then
        DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
    else
        if ClosestVeh() ~= 0 then
            DeleteEntity(ClosestVeh())
        end
    end
end

-- FONCTION NOCLIP
local noclip = false

function admin_no_clip()
    noclip = not noclip
    local ped = PlayerPedId()
    if noclip then -- activé
        SetEntityInvincible(ped, true)
        Ora.Player:SetEntityInvicible(PlayerId(), PlayerPedId(), true)
        SetEntityVisible(ped, false, false)
        ShowNotification("Noclip ~g~activé")
        exports['Ora_utils']:ToggleDrain(false)
    else -- désactivé
        SetEntityInvincible(ped, false)
        Ora.Player:SetEntityInvicible(PlayerId(), PlayerPedId(), false)
        ShowNotification("Noclip ~r~désactivé")
        exports['Ora_utils']:ToggleDrain(true)
    end
end

RegisterKeyMapping("spectate", "Mode NoClip", "keyboard", "O")
RegisterCommand("spectate", function()
    if Ora.Identity:GetMyGroup() == "superadmin" or Ora.Identity:GetMyGroup() == "staff" then
        admin_no_clip()
    end    
end)

function getPosition()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    return x, y, z
end

function getCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()

    local x = -math.sin(heading * math.pi / 180.0)
    local y = math.cos(heading * math.pi / 180.0)
    local z = math.sin(pitch * math.pi / 180.0)

    local len = math.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end

    return x, y, z
end

function isNoclip()
    return noclip
end



-- noclip/invisible
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if noclip then
                local ped = PlayerPedId()
                local x, y, z = getPosition()
                local dx, dy, dz = getCamDirection()
                local speed = noclip_speed

                -- reset du velocity
                SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

                if noclip_speed ~= 0 then
                    if IsControlJustPressed(0, 41) then
                        noclip_speed = noclip_speed - 0.25
                    end
                end
                if IsControlJustPressed(0, 42) then
                    noclip_speed = noclip_speed + 0.25
                end

                HideHudComponentThisFrame(19)

                -- aller vers le haut
                if IsControlPressed(0, 32) then -- MOVE UP
                    x = x + speed * dx
                    y = y + speed * dy
                    z = z + speed * dz
                end

                -- aller vers le bas
                if IsControlPressed(0, 269) then -- MOVE DOWN
                    x = x - speed * dx
                    y = y - speed * dy
                    z = z - speed * dz
                end

                SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
            end
        end
    end
)
-- FIN NOCLIP

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            if pblips then
                for _, id in ipairs(GetActivePlayers()) do
                    if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
                        ped = GetPlayerPed(id)
                        blip = GetBlipFromEntity(ped)
                        vehicule = IsPedInAnyVehicle(ped, true)

                        if not DoesBlipExist(blip) then
                            blip = AddBlipForEntity(ped)
                            SetBlipSprite(blip, 1)
                            ShowHeadingIndicatorOnBlip(blip, true)
                        else
                            veh = GetVehiclePedIsIn(ped, false)
                            blipSprite = GetBlipSprite(blip)
                            if GetEntityHealth(ped) < 1 then
                                if blipSprite ~= 274 then
                                    SetBlipSprite(blip, 274)
                                    ShowHeadingIndicatorOnBlip(blip, false)
                                end
                            elseif veh then
                                vehClass = GetVehicleClass(veh)
                                vehModel = GetEntityModel(veh)
                                if vehClass == 15 then
                                    if blipSprite ~= 422 then
                                        SetBlipSprite(blip, 422)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif vehClass == 8 then
                                    if blipSprite ~= 226 then
                                        SetBlipSprite(blip, 226)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif vehClass == 14 then
                                    if blipSprite ~= 427 then
                                        SetBlipSprite(blip, 427)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif vehModel == GetHashKey("rhino") then
                                    if blipSprite ~= 421 then
                                        SetBlipSprite(blip, 421)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif vehModel == GetHashKey("trash") or vehModel == GetHashKey("trash2") then
                                    if blipSprite ~= 318 then
                                        SetBlipSprite(blip, 318)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif
                                    vehModel == GetHashKey("seashark") or vehModel == GetHashKey("seashark2") or
                                        vehModel == GetHashKey("seashark3")
                                 then
                                    if blipSprite ~= 471 then
                                        SetBlipSprite(blip, 471)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif
                                    vehModel == GetHashKey("cargobob") or vehModel == GetHashKey("cargobob2") or
                                        vehModel == GetHashKey("cargobob3") or
                                        vehModel == GetHashKey("cargobob4")
                                 then
                                    if blipSprite ~= 481 then
                                        SetBlipSprite(blip, 481)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif vehModel == GetHashKey("taxi") then
                                    if blipSprite ~= 198 then
                                        SetBlipSprite(blip, 198)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif
                                    vehModel == GetHashKey("fbi") or vehModel == GetHashKey("fbi2") or
                                        vehModel == GetHashKey("police2") or
                                        vehModel == GetHashKey("police3") or
                                        vehModel == GetHashKey("police") or
                                        vehModel == GetHashKey("sheriff2") or
                                        vehModel == GetHashKey("sheriff") or
                                        vehModel == GetHashKey("policeold2") or
                                        vehModel == GetHashKey("policeold1")
                                 then
                                    if blipSprite ~= 56 then
                                        SetBlipSprite(blip, 56)
                                        SetBlipColour(blip, 38)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif IsPedInAnyVehicle(ped, true) then
                                    local plate = GetVehicleNumberPlateText(veh)
                                    if plate == "RESELLER" then
                                        SetBlipSprite(blip, 225)
                                        SetBlipColour(blip, 52)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    elseif plate == " GOFAST " then
                                        SetBlipSprite(blip, 225)
                                        SetBlipColour(blip, 49)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    else
                                        if blipSprite ~= 225 then
                                            SetBlipSprite(blip, 225)
                                            ShowHeadingIndicatorOnBlip(blip, false)
                                        end
                                    end
                                elseif blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    ShowHeadingIndicatorOnBlip(blip, true)
                                end
                            else
                                --HideNumberOnBlip(blip)
                                if blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    ShowHeadingIndicatorOnBlip(blip, true)
                                end
                            end

                            SetBlipRotation(blip, math.ceil(GetEntityHeading(veh)))
                            --SetBlipNameToPlayerName(blip, id)
                            SetBlipScale(blip, 0.85)
                            if IsPauseMenuActive() then
                                SetBlipAlpha(blip, 255)
                            else
                                x1, y1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                                x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                                distance =
                                    (math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1)) +
                                    900

                                if distance < 0 then
                                    distance = 0
                                elseif distance > 255 then
                                    distance = 255
                                end
                                SetBlipAlpha(blip, distance)
                            end
                        end
                    end
                end
            else
                for _, id in ipairs(GetActivePlayers()) do
                    ped = GetPlayerPed(id)
                    blip = GetBlipFromEntity(ped)
                    if DoesBlipExist(blip) then
                        RemoveBlip(blip)
                    end
                end
            end
        end
    end
)


RegisterCommand("co", function(source, args, rawCommand)
    print('^2[Utils] - ^5' ..GetEntityCoords(PlayerPedId()).. " ^2- ^1heading :  ^5"..GetEntityHeading(PlayerPedId()).. '^0')
end, false)
