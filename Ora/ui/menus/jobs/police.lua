Police = {}

local currCarte = nil
local Started = false

local function ClosestVeh()
    if GetEntityType(vehicleFct.GetVehicleInDirection()) == 2 then
        return vehicleFct.GetVehicleInDirection()
    else
        return 0
    end
end
function CloseAllMenus()
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
        end
    )
end
function Police.code99() exports["Ora_utils"]:sendME("* L'individu appuie sur un bouton de sa radio *") end
function Police.PlateCheck()
    local veh = ClosestVeh()
    if veh ~= 0 then
        local plate = GetVehicleNumberPlateText(veh)
        RageUI.Popup({message = "La plaque de ce véhicule est : ~r~" .. plate})
    end
end
function Police.Stup()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        local player = GetPlayerFromServerId(playerId)
        local pedT = GetPlayerPed(player)

        TriggerServerCallback(
            "Ora_status:isOnStatus",
            function(bool)
                if bool then
                    ShowNotification("Test Canabinoide : ~g~Positif~s~")
                else
                    ShowNotification("Test Canabinoide : ~r~Negatif~s~")
                end
            end,
            "weed",
            playerId
        )

        TriggerServerCallback(
            "Ora_status:isOnStatus",
            function(bool)
                if bool then
                    ShowNotification("Test Meth : ~g~Positif~s~")
                else
                    ShowNotification("Test Meth : ~r~Negatif~s~")
                end
            end,
            "meth",
            playerId
        )

        TriggerServerCallback(
            "Ora_status:isOnStatus",
            function(bool)
                if bool then
                    ShowNotification("Test Cocaine : ~g~Positif~s~")
                else
                    ShowNotification("Test Cocaine : ~r~Negatif~s~")
                end
            end,
            "coke",
            playerId
        )
    else
        ShowNotification("~r~Aucun joueur proche")
    end
end
function Police.Powder()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        local player = GetPlayerFromServerId(playerId)
        local pedT = GetPlayerPed(player)

        TriggerServerCallback(
            "Ora_status:isOnStatus",
            function(bool)
                if bool then
                    ShowNotification("Test Poudre : ~g~Positif~s~")
                else
                    ShowNotification("Test Poudre : ~r~Negatif~s~")
                end
            end,
            "powder",
            playerId
        )
    else
        ShowNotification("~r~Aucun joueur proche")
    end
end
function Police.Crocheter()
    local veh = ClosestVeh()
    if veh ~= 0 then
        TaskStartScenarioInPlace(LocalPlayer().Ped, "WORLD_HUMAN_WELDING", 0, true)
        Citizen.Wait(20000)
        ClearPedTasksImmediately(LocalPlayer().Ped)
        SetEntityAsMissionEntity(veh, true, true)
        SetVehicleDoorsLocked(veh, 1)
        SetVehicleDoorsLockedForPlayer(veh, false)
        SetVehicleDoorsLockedForAllPlayers(veh, false)
        if (Ora.World.Vehicle.JackedVehicles[veh] == nil) then table.insert(Ora.World.Vehicle.JackedVehicles, veh) end
        TriggerPlayerEvent("Ora::CE::Carjacking:LockState", -1, veh, 1)
        RageUI.Popup({message = "~g~Véhicule déverouillé"})
    end
end

function Police.Immobiliser()
    local veh = ClosestVeh()
    if veh ~= 0 then
        SetVehicleUndriveable(veh, true)
        SetVehicleDoorsLockedForAllPlayers(veh, true)
        TriggerPlayerEvent("Ora::CE::Carjacking:LockState", -1, veh, 2)
        RageUI.Popup({message = "~r~Vous avez immobilisé~s~ le véhicule"})
    end
end

function Police.Desimmobiliser()
    local veh = ClosestVeh()
    if veh ~= 0 then
        SetVehicleUndriveable(veh, false)
        SetVehicleDoorsLockedForAllPlayers(veh, false)

        RageUI.Popup({message = "~r~Vous avez désimmobilisé~s~ le véhicule"})
    end
end
local function F(l)
    local i = {}
    for k, v in pairs(l) do
        i[v.uuid] = v
    end
    return i
end
local listIdentity = {}
local braceletList = {}
local plyTracked = {}
local blipsList = {}
RMenu.Add("police", "bracelet", RageUI.CreateMenu("", "Actions disponibles", 10, 200))
function Police.Bracelet()
    listIdentity = {}
    Citizen.CreateThread(
        function()
            CloseAllMenus()
            TriggerServerCallback(
                "core:GetBraceletList",
                function(identity, _braceletList)
                    listIdentity = F(identity)
                    braceletList = _braceletList
                    RageUI.Visible(RMenu:Get("police", "bracelet"), true)
                end
            )
        end
    )
end
InTracking = false
function Police.ActivateTrack()
    if Ora.Service:isInService('police') then
        local c = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId()))
        if c == 17 or c == 18 then
            if InTracking then
                ShowNotification("Vous avez ~r~désactiver~s~ le tracking")
            else
                ShowNotification("Vous avez ~g~activer~s~ le tracking")
            end
            InTracking = not InTracking
            TriggerServerEvent("trackingToggle", InTracking)
        else
            ShowNotification("~r~Ce n'est pas un véhicule adapté")
        end
    else
        ShowNotification("~r~Tu dois être en service")
    end
end
local carBlips = {}
RegisterNetEvent("trackingRefresh")
AddEventHandler(
    "trackingRefresh",
    function(t)
        if Ora.Service:isInService('police') then
            if Ora.Identity.Job:GetName() == "police" or Ora.Identity.Job:GetName() == "lssd" then
                for i = 1, #carBlips, 1 do
                    RemoveBlip(carBlips[i])
                end
                for k, v in pairs(t) do
                    if v then
                        local ped = GetPlayerPed(GetPlayerFromServerId(k))
                        blipPed = AddBlipForEntity(GetVehiclePedIsIn(ped))
                        SetBlipAsFriendly(blipPed, true)
                        SetBlipColour(blipPed, 2)
                        SetBlipCategory(blipPed, 3)
                        SetBlipSprite(blipPed, 523)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString("Voiture #" .. k)
                        EndTextCommandSetBlipName(blipPed)
                        table.insert(carBlips, blipPed)
                    end
                end
            end
        end
    end
)
RegisterNetEvent("deleteBracelet")
AddEventHandler(
    "deleteBracelet",
    function(t)
        for k, v in pairs(plyTracked) do
            if k == t then
                plyTracked[k] = nil
                RemoveBlip(blipsList[k])
                blipsList[k] = nil
                TriggerServerCallback(
                    "core:GetBraceletList",
                    function(identity, _braceletList)
                        listIdentity = F(identity)
                        braceletList = _braceletList
                    end
                )
                break
            end
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("police", "bracelet")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        local ply = GetPlayerServerIdInDirection(5.0)
                        HoverPlayer()
                        if ply ~= false then
                            local fo = false
                            for p, t in pairs(braceletList) do
                                if t == ply then
                                    fo = true
                                end
                            end
                            RageUI.Button(
                                fo == false and "Attacher un bracelet éléctronique" or
                                    "Détacher le bracelet éléctronique",
                                nil,
                                {},
                                true,
                                function(_, A, S)
                                    if S and not fo then
                                        if ply == false then
                                            ShowNotification("~r~Aucun joueur proche")
                                        end
                                        TriggerServerEvent("core:RegisterBracelet", ply)

                                        TriggerServerCallback(
                                            "core:GetBraceletList",
                                            function(identity, _braceletList)
                                                listIdentity = F(identity)
                                                braceletList = _braceletList
                                                RageUI.Refresh()
                                            end
                                        )
                                        TriggerPlayerEvent(
                                            "RageUI:Popup",
                                            ply,
                                            {message = "On vous à attaché un bracelet électronique !"}
                                        )
                                    elseif S and fo then
                                        TriggerServerEvent("core:DeleteBracelet", ply)

                                        TriggerPlayerEvent(
                                            "RageUI:Popup",
                                            ply,
                                            {message = "On vous à enlever un bracelet électronique !"}
                                        )
                                    end

                                    if A then
                                        HoverPlayer()
                                    end
                                end
                            )
                        end
                        for p, t in pairs(braceletList) do
                            local found = false
                            for k, v in pairs(plyTracked) do
                                if v == t then
                                    found = true
                                end
                            end
                            RageUI.Checkbox(
                                listIdentity[p].first_name .. " " .. listIdentity[p].last_name,
                                nil,
                                found,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        if found then
                                            plyTracked[t] = nil
                                            RemoveBlip(blipsList[t])
                                        else
                                            plyTracked[t] = t
                                            local ped = GetPlayerPed(GetPlayerFromServerId(t))
                                            blipPed = AddBlipForEntity(ped)
                                            SetBlipAsFriendly(blipPed, true)
                                            SetBlipColour(blipPed, 2)
                                            SetBlipCategory(blipPed, 3)
                                            SetBlipSprite(blipPed, 480)
                                            BeginTextCommandSetBlipName("STRING")
                                            AddTextComponentString(
                                                "Bracelet" ..
                                                    listIdentity[p].first_name .. " " .. listIdentity[p].last_name
                                            )
                                            EndTextCommandSetBlipName(blipPed)
                                            blipsList[t] = blipPed
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)
DecorRegister("HandsUp", 3)
local handsup = false
local waiting = false
local val = nil
RegisterNetEvent("imhandsup")
AddEventHandler(
    "imhandsup",
    function(handsup_)
        val = handsup_
        waiting = false
    end
)
RegisterNetEvent("areuhandsup")
AddEventHandler(
    "areuhandsup",
    function(id)
        TriggerPlayerEvent("imhandsup", id, handsup)
    end
)
function IsPlyHandsup(id)
    TriggerPlayerEvent("areuhandsup", id, GetPlayerServerId(PlayerId()))
    waiting = true
    while waiting == true do
        Wait(1)
    end

    return val
end
function HandsUP()
    local ped = PlayerPedId()
    --print("yh")
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        RequestAnimDict("random@mugging3")

        while (not HasAnimDictLoaded("random@mugging3")) do
            Citizen.Wait(1)
        end

        if handsup then
            ClearPedSecondaryTask(ped)
            handsup = false
            TriggerServerEvent("core:updateHands", handsup)
            Citizen.Wait(500)
        else
            TaskPlayAnim(ped, "random@mugging3", "handsup_standing_enter", 2.0, 2.5, -1, 49, 0, 0, 0, 0)
            Wait(100)
            TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0)
            handsup = true
            TriggerServerEvent("core:updateHands", handsup)
            Citizen.Wait(500)
        end
    end
end

RegisterCommand(
    "+handsup",
    function()
        HandsUP()
    end,
    false
)
RegisterCommand(
    "-handsup",
    function()
        HandsUP()
    end,
    false
)
RegisterCommand(
    "handsup",
    function()
        HandsUP()
    end,
    false
)
RegisterKeyMapping("handsup", "Lever les mains", "keyboard", "X")
function IsPlyHandcuff(id)
    local player = GetPlayerFromServerId(id)
    player = GetPlayerPed(player)
    return DecorGetBool(player, "Handcuffed")
end
DecorRegister("Handcuffed", 3)

exports.qtarget:Player({
    options = {
        {
            event = "HancuffPlayer",
            icon = "fas fa-link",
            label = "Menotter",
            required_items = {
                ["menottes"] = 1
            },
            canInteract = function(entity)
                local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                if not IsPlyHandcuff(id) then
                    return true
                else
                    return false
                end
            end
        },
        {
            event = "CutHandcuffs",
            icon = "fas fa-cut",
            label = "Couper les menottes",
            required_items = {
                ["pinces"] = 1
            },
            canInteract = function(entity)
                local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                if IsPlyHandcuff(id) then
                    return true
                else
                    return false
                end
            end
        },
        {
            event = "RemoveHandcuffs",
            icon = "fas fa-key",
            label = "Démenotter",
            job = {"police", "lssd"},
            canInteract = function(entity)
                local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                if IsPlyHandcuff(id) then
                    return true
                else
                    return false
                end
            end
        }

    },
    distance = 1.0
})

RegisterNetEvent("CutHandcuffs")
AddEventHandler("CutHandcuffs", function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    TriggerServerEvent("player:Handcuff", playerId, false)
end)

RegisterNetEvent("RemoveHandcuffs")
AddEventHandler("RemoveHandcuffs", function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    local item = {name = "menottes", data = {}}
    TriggerServerEvent("player:Handcuff", playerId, false)
    Ora.Inventory:AddItem(item)
end)

RegisterNetEvent("HancuffPlayer")
AddEventHandler("HancuffPlayer", function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    Ora.Inventory:RemoveFirstItem('menottes')
    TriggerServerEvent("player:Handcuff", playerId, true)
end)

function Police.HandcuffPly()
    local count = Ora.Inventory:GetItemCount("menottes")
    if count > 0 then
        local playerId = GetPlayerServerIdInDirection(5.0)
        if (playerId ~= false) then
            local isHandcuff = IsPlyHandcuff(playerId)
            if not isHandcuff then
                Ora.Inventory:RemoveFirstItem('menottes')
                TriggerServerEvent("player:Handcuff", playerId, true)
            else
                RageUI.Popup({message = "~b~Ce joueur est déjà menotté"})
            end
        else
            RageUI.Popup({message = "~r~Aucun joueur proche"})
        end
    else
        RageUI.Popup({message = "Vous n'avez pas de ~r~menottes"})
    end
end
function Police.PhotoIdent()
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()

            RageUI.Visible(RMenu:Get("police", "identity"), true)
        end
    )
end
function Police.RetraitPermis()
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()

            RageUI.Visible(RMenu:Get("police", "permis"), true)
        end
    )
end
function Police.AuthorizeLicence()
    local target = GetPlayerServerIdInDirection(5.0)

    if (target) then
        RageUI.Popup({message = string.format("~b~Vous avez autorisé un repassage de permis à %s", Ora.Identity:GetFullname(target))})
    end
end

-- Sirens

local carSpawned = false
local newVeh = nil
local inLightbarMenu = false
local lightBool = false
local sirenBool = false
local oldSirenBool = false
local controlsDisabled = false
local xCoord = 0
local yCoord = 0
local zCoord = 0
local xrot = 0.0
local yrot = 0.0
local zrot = 0.0
local snd_pwrcall = {}
local airHornSirenID = nil
local sirenTone = "VEHICLES_HORNS_SIREN_1"
local vehPlateBoolSavedData = nil
local isPlateCar = false
local isAirhornKeyPressed = false
local deleteVehicleLightbars = {}
local savedSiren = nil

function Police.Sirens()
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()

            RageUI.Visible(RMenu:Get("police", "sirens"), true)
        end
    )
end

function Police.ON()
    if (Started == true) then return end
    Started = true

    Citizen.CreateThread(function()
        while (Ora.Player.HasLoaded == false) do
            Wait(50)
        end
        
        if (Ora.Identity:GetMyGroup() ~= "superadmin") then
            return
        end

        while true do
            Citizen.Wait(0)
            if inLightbarMenu then
                printControlsText()
            end
    
            local player = GetPlayerPed(-1)
            if (IsControlJustReleased(1, 44)) then -- Q to turn on lights
                toggleLights()
            end
    
            if (IsControlJustReleased(1, 47)) then -- G to turn on siren
                sirenTone = "VEHICLES_HORNS_SIREN_1" -- sets siren to default siren
                toggleSiren()
            end
    
            if (IsControlJustReleased(1, 210)) then -- Left control to change siren tone
                changeSirenTone()
            end
    
            if IsControlJustPressed(1, 184) and not isAirhornKeyPressed then
                playAirHorn(true)
                isAirhornKeyPressed = true
                if sirenBool then
                    oldSirenBool = sirenBool
                    toggleSiren()
                end
            end
    
            if IsControlJustReleased(1, 184) then
                playAirHorn(false)
                isAirhornKeyPressed = false
                if oldSirenBool then
                    toggleSiren()
                    oldSirenBool = false
                end
            end
    
            if isPlateCar then DisableControlAction(0,86,true) end -- Disables Veh horn
        end
    end)

    Citizen.CreateThread(
        function()
            local last_name, first_name = "", ""
            local dIndex = 1
            local driversLicenseOptions = {"Retrait", "Ajout"}
            Wait(500)

            --TriggerEvent("ShowPicture","https://lh5.ggpht.com/-jHhk2ghmH2Q/T4grf3MRH_I/AAAAAAAACgo/zwHULGGjU5I/jquery-change-image%25255B13%25255D.png?imgmax=800")
            while true do
                Wait(1)
                if takingPic then
                    DisplayRadar(false)
                    Player.Hud = false
                    TriggerEvent("displayNourriture", false)
                    if IsControlJustPressed(0, Keys["E"]) then
                        ShowNotification("~b~Photo prise !")

                        exports["screenshot-basic"]:requestScreenshotUpload(
                            "https://pictures.orarp.com/upload.php",
                            "identity",
                            function(data)
                                local resp = json.decode(data)
                                for i = 1, #Ora.Inventory.Data["identity"], 1 do
                                    if Ora.Inventory.Data["identity"][i].id == currCarte then
                                        Ora.Inventory.Data["identity"][i].data.identity.face_picutre = resp.url
                                        --TriggerServerEvent("inventory:editData",Ora.Inventory.Data["identity"][i].id,Ora.Inventory.Data["identity"][i].data)
                                        TriggerServerEvent(
                                            "identity:editPic",
                                            Ora.Inventory.Data["identity"][i].data.identity.uuid,
                                            resp.url
                                        )
                                    end
                                end
                                takingPic = false
                                SetFollowPedCamViewMode(0)
                                DisplayRadar(true)
                                Player.Hud = true
                                TriggerEvent("displayNourriture", true)
                            end
                        )
                    end
                end
                if RageUI.Visible(RMenu:Get("police", "identity")) then
                    RageUI.DrawContent(
                        {header = false, glare = false},
                        function()
                            if Ora.Inventory.Data["identity"] == nil or #Ora.Inventory.Data["identity"] == 0 then
                                RageUI.Button(
                                    "Vide",
                                    nil,
                                    {RightLabel = nil},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                        end
                                    end
                                )
                            end
                            if Ora.Inventory.Data["identity"] ~= nil then
                                for i = 1, #Ora.Inventory.Data["identity"], 1 do
                                    local v = Ora.Inventory.Data["identity"][i]
                                    local data = v.data.identity
                                    if data == nil then
                                        data = {}
                                    end
                                    if data.first_name == nil then
                                        data.first_name = "Inconnu"
                                        data.last_name = "Inconnu"
                                    end
                                    RageUI.Button(
                                        "Carte d'identité",
                                        nil,
                                        {RightLabel = data.first_name .. " " .. data.last_name},
                                        true,
                                        function(_, A, Selected)
                                            if A then
                                                if data.face_picutre ~= "N/A" then
                                                    TriggerEvent("ShowPicture", data.face_picutre)
                                                else
                                                    TriggerEvent("ShowPicture", false)
                                                end
                                            end
                                            if Selected then
                                                RageUI.GoBack()
                                                Citizen.CreateThread(
                                                    function()
                                                        currCarte = v.id
                                                        TriggerEvent("ShowPicture", false)
                                                        ShowNotification("Préparez vous à prendre la photo d'identité")
                                                        SetFollowPedCamViewMode(4)
                                                        Wait(250)
                                                        ShowNotification("~b~Appuyez sur E pour prendre la photo")
                                                        takingPic = true
                                                        Wait(50000)
                                                        if takingPic then
                                                            takingPic = false
                                                            SetFollowPedCamViewMode(0)
                                                            ShowNotification("~b~Vous avez pris trop de temps ! ")
                                                        end
                                                    end
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

                if (RageUI.Visible(RMenu:Get("police", "sirens"))) then
                    RageUI.DrawContent(
                        {header = false, glare = false},
                        function()
                            if (savedSiren ~= nil) then
                                RageUI.Button(
                                    "Toggle Siren",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            if (GetEntityAlpha(newVeh) == 0) then
                                                SetEntityAlpha(newVeh, 255, false)
                                                ShowNotification("~b~Sirène replacée !")
                                            else
                                                SetEntityAlpha(newVeh, 0, false)
                                                ShowNotification("~b~Sirène retirée !")
                                            end
                                        end
                                    end
                                )
                            else
                                RageUI.Button(
                                    "Blue Dome Light",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            if (GetVehiclePedIsIn(GetPlayerPed(-1), false) == 0) then return ShowNotification("~r~Vous devez être dans un véhicule") end
                                            TriggerEvent("openLightbarMenu", "fbiold")
                                            RageUI.Visible(RMenu:Get("police", "sirens"), false)
                                        end
                                    end
                                )
                                RageUI.Button(
                                    "Small Stick Light",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            if (GetVehiclePedIsIn(GetPlayerPed(-1), false) == 0) then return ShowNotification("~r~Vous devez être dans un véhicule") end
                                            TriggerEvent("openLightbarMenu", "lightbarTwoSticks")
                                            RageUI.Visible(RMenu:Get("police", "sirens"), false)
                                        end
                                    end
                                )
                                RageUI.Button(
                                    "Blue Stick Light",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            if (GetVehiclePedIsIn(GetPlayerPed(-1), false) == 0) then return ShowNotification("~r~Vous devez être dans un véhicule") end
                                            TriggerEvent("openLightbarMenu", "longLightbar")
                                            RageUI.Visible(RMenu:Get("police", "sirens"), false)
                                        end
                                    end
                                )
                                RageUI.Button(
                                    "Red Stick Light",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            if (GetVehiclePedIsIn(GetPlayerPed(-1), false) == 0) then return ShowNotification("~r~Vous devez être dans un véhicule") end
                                            TriggerEvent("openLightbarMenu", "longLightbarRed")
                                            RageUI.Visible(RMenu:Get("police", "sirens"), false)
                                        end
                                    end
                                )
                            end
                            RageUI.Button(
                                "Remove All Lights",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        savedSiren = nil
                                        TriggerEvent("deleteLightbarVehicle", GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("police", "permis")) then
                    RageUI.DrawContent(
                        {header = false, glare = false},
                        function()
                            if (
								(Ora.Inventory.Data["permis-conduire"] == nil or #Ora.Inventory.Data["permis-conduire"] == 0) and
								(Ora.Inventory.Data["permis-conduire-moto"] == nil or #Ora.Inventory.Data["permis-conduire-moto"] == 0) and
								(Ora.Inventory.Data["permis-conduire-pl"] == nil or #Ora.Inventory.Data["permis-conduire-pl"] == 0)
							) then
                                RageUI.Button(
                                    "Vide",
                                    nil,
                                    {RightLabel = nil},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                        end
                                    end
                                )
                            end

                            if Ora.Inventory.Data["permis-conduire"] ~= nil then
                                for i = 1, #Ora.Inventory.Data["permis-conduire"], 1 do
                                    local v = Ora.Inventory.Data["permis-conduire"][i]
                                    local data = v.data
                                    local label = data.identity.first_name.." "..data.identity.last_name

                                    RageUI.Button(
                                        string.format("%s - %s", label, data.uid),
                                        nil,
                                        {RightLabel = data.points .. " points"},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                exports['Snoupinput']:ShowInput("Nombre de points à enlever", 2, "number", "1", true)
												local am = exports['Snoupinput']:GetInput()

                                                if (am ~= nil and am ~= false) then
                                                    data.points = data.points - am
                                                end
                                                RageUI.CloseAll()
                                            end
                                        end
                                    )
                                    --[[ RageUI.List(label .. " - " .. data.uid, driversLicenseOptions, dIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
                                        dIndex = Index
                                        if Selected then
                                            if dIndex == 1 then
                                                local am = KeyboardInput("Nombre de points à enlever", nil, 2)
                                                if am ~= nil and am ~= "" then
                                                    data.points = data.points - am
                                                end
                                                RageUI.CloseAll()
                                            else
                                                local am = KeyboardInput("Nombre de points à ajouter", nil, 2)
                                                if am ~= nil and am ~= "" then
                                                    data.points = data.points + am
                                                end
                                                RageUI.CloseAll()
                                            end
                                        end
                                    end) ]]
                                end
                            end

                            if Ora.Inventory.Data["permis-conduire-moto"] ~= nil then
                                for i = 1, #Ora.Inventory.Data["permis-conduire-moto"], 1 do
                                    local v = Ora.Inventory.Data["permis-conduire-moto"][i]
                                    local data = v.data
                                    local label = data.identity.first_name.." "..data.identity.last_name
                                    
                                    RageUI.Button(
                                        string.format("%s - %s", label, data.uid),
                                        nil,
                                        {RightLabel = data.points .. " points"},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                exports['Snoupinput']:ShowInput("Nombre de points à enlever", 2, "number", "1", true)
												local am = exports['Snoupinput']:GetInput()

                                                if (am ~= nil and am ~= false) then
                                                    data.points = data.points - am
                                                end
                                                RageUI.CloseAll()
                                            end
                                        end
                                    )
                                end
                            end

                            if Ora.Inventory.Data["permis-conduire-pl"] ~= nil then
                                for i = 1, #Ora.Inventory.Data["permis-conduire-pl"], 1 do
                                    local v = Ora.Inventory.Data["permis-conduire-pl"][i]
                                    local data = v.data
                                    local label = data.identity.first_name.." "..data.identity.last_name

                                    RageUI.Button(
                                        string.format("%s - %s", label, data.uid),
                                        nil,
                                        {RightLabel = data.points .. " points"},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                exports['Snoupinput']:ShowInput("Nombre de points à enlever", 2, "number", "1", true)
												local am = exports['Snoupinput']:GetInput()

                                                if (am ~= nil and am ~= false) then
                                                    data.points = data.points - am
                                                end
                                                RageUI.CloseAll()
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
                if RageUI.Visible(RMenu:Get("police", "hunting_license")) then
                    RageUI.DrawContent({header = true, glare = true}, function()
                        RageUI.Button("Nom", nil, {RightLabel = last_name}, true, function(_, _, Selected)
                            if Selected then
                                last_name = KeyboardInput("Nom", nil, 15)
                            end
                        end)
                        RageUI.Button("Prénom", nil, {RightLabel = first_name}, true, function(_, _, Selected)
                            if Selected then
                                first_name = KeyboardInput("Prénom", nil, 15)
                            end
                        end)
                        RageUI.Button("Créer le permis de chasse", nil, {}, true, function(_, _, Selected)
                            if Selected then
                                if first_name ~= "" and last_name ~= "" then
                                    RageUI.CloseAll()
                                    local items = {name = "hunting_license", label = first_name.." "..last_name, data = {uid = "LS-" .. Random(99999999), identity = {last_name = last_name, first_name = first_name, face_picture = "N/A"}}}
                                    Ora.Inventory:AddItem(items)
                                else
                                    ShowNotification("~r~Veuillez remplir tous les champs")
                                end
                            end
                        end)
                    end)
                end
            end
        end
    )

    Citizen.CreateThread(
        function()
            while true do
                Wait(10000)
                local vehh = GetVehiclePedIsIn(GetPlayerPed(-1), false)

                if (savedSiren ~= nil and vehh ~= 0) then
                    SetVehicleRadioEnabled(vehh, false)
                    SetUserRadioControlEnabled(false)
                elseif (savedSiren == nil and vehh ~= 0) then
                    SetVehicleRadioEnabled(vehh, true)
                    SetUserRadioControlEnabled(true)
                end
            end
        end
    )
end

function printControlsText()
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextColour(128, 128, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString("Use your ↑ ↓ → ← Arrow Keys for Lateral Movements, Pg Up and Pg Down for Altitude Change")
	DrawText(0.25, 0.9)
	-- 
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextColour(128, 128, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString("Insert and Delete for rotation. SPACE to save, BACKSPACE to cancel")
	DrawText(0.25, 0.93)
end

function lightMenu(lightbarModel)
    if not inLightbarMenu then
        inLightbarMenu = true
        local player = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(player, false)
        spawnLightbar(lightbarModel)
        controlsDisabled = true
        disableControls()
        AttachEntityToEntity(newVeh, veh, 0, 0, 0, 0, 0.0, 0.0, 0.0, true, true, true, true, 0, true)
        while true do
            Citizen.Wait(10)
            --resetOffSets()
            moveObj(newVeh)
            if (IsControlJustReleased(1, 22)) then -- attatch obj and close
                TriggerServerEvent("addLightbar", GetVehicleNumberPlateText(veh), VehToNet(newVeh), veh)
                inLightbarMenu = false
                savedSiren = {x = xCoord, y = yCoord, z = zCoord, xr = xrot, yr = yrot, zr = zrot}
                --newVeh = nil
                controlsDisabled = false
                if(vehPlateBoolSavedData == GetVehicleNumberPlateText(veh)) then
                    isPlateCar = true
                end
                break
            end
            if (IsControlJustReleased(1, 177)) then -- close menu
                inLightbarMenu = false
                DeleteVehicle(newVeh)
                --newVeh = nil
                controlsDisabled = false
                break
            end
        end
    end
end

function disableControls()
    Citizen.CreateThread(function()
      while controlsDisabled do
        Citizen.Wait(0)
            DisableControlAction(0,21,true) -- disable sprint
            DisableControlAction(0,24,true) -- disable attack
            DisableControlAction(0,25,true) -- disable aim
            DisableControlAction(0,47,true) -- disable weapon
            DisableControlAction(0,58,true) -- disable weapon
            DisableControlAction(0,263,true) -- disable melee
            DisableControlAction(0,264,true) -- disable melee
            DisableControlAction(0,257,true) -- disable melee
            DisableControlAction(0,140,true) -- disable melee
            DisableControlAction(0,141,true) -- disable melee
            DisableControlAction(0,142,true) -- disable melee
            DisableControlAction(0,143,true) -- disable melee
            DisableControlAction(0,75,true) -- disable exit vehicle
            DisableControlAction(27,75,true) -- disable exit vehicle
            DisableControlAction(0,32,true) -- move (w)
            DisableControlAction(0,34,true) -- move (a)
            DisableControlAction(0,33,true) -- move (s)
            DisableControlAction(0,35,true) -- move (d)
            DisableControlAction(0,71,true) -- move (d)
            DisableControlAction(0,72,true) -- move (d)
        end
    end)
end

function changeSirenTone()
    local currPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    if not(vehPlateBoolSavedData == currPlate) then
        TriggerServerEvent("returnLightBarVehiclePlates")
        while true do
            if(vehPlateBoolSavedData == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))) then
                break
            end
            if not(currPlate == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))) then
                return
            end
            Citizen.Wait(10)
        end
    end
    if isPlateCar then
        if sirenTone == "VEHICLES_HORNS_SIREN_1" then
            sirenTone = "VEHICLES_HORNS_SIREN_2"
            toggleSiren()
            toggleSiren()
        elseif sirenTone == "VEHICLES_HORNS_SIREN_2" then
            sirenTone = "VEHICLES_HORNS_POLICE_WARNING"
            toggleSiren()
            toggleSiren()
        else
            sirenTone = "VEHICLES_HORNS_SIREN_1"
            toggleSiren()
            toggleSiren()
        end
    end
end

function toggleSiren()
    if lightBool == false then
        TriggerServerEvent("ToggleSound1Server", GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
    end
end

function spawnLightbar(lightbarModel)
    local player = GetPlayerPed(-1)
    local vehiclehash1 = GetHashKey(lightbarModel)
    RequestModel(vehiclehash1)
    Citizen.CreateThread(function() 
        while not HasModelLoaded(vehiclehash1) do
            Citizen.Wait(100)
        end
        local coords = GetEntityCoords(player)
        newVeh = Ora.World.Vehicle:Create(vehiclehash1, {x = coords.x, y = coords.y, z = coords.z}, GetEntityHeading(PlayerPedId()))
        --newVeh = CreateVehicle(vehiclehash1, coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()), true, 0)
        SetEntityCollision(newVeh, false, false)
        SetVehicleDoorsLocked(newVeh, 2)
        SetEntityAsMissionEntity(newVeh, true, true)
    end)
end

function moveObj(veh)
    local player = GetPlayerPed(-1)
    local MOVEMENT_CONSTANT = 0.01
    local vehOffset = GetOffsetFromEntityInWorldCoords(newVeh, 0.0, 1.3, 0.0)

    if (IsControlJustReleased(1, 121)) then -- rotate 180 upside down
        yrot = yrot + 180.0
        DetachEntity(newVeh, 0, 0)
        AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
    end

    if (IsControlJustReleased(1, 178)) then -- rotate 180 
        zrot = zrot + 180
        DetachEntity(newVeh, 0, 0)
        AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
    end

    if (IsControlPressed(1, 190)) then -- move forward
        xCoord = xCoord + MOVEMENT_CONSTANT
        DetachEntity(newVeh, 0, 0)
        AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
    end

    if (IsControlPressed(1, 189)) then -- move backwards
        xCoord = xCoord - MOVEMENT_CONSTANT
        DetachEntity(newVeh, 0, 0)
        AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
    end

    if (IsControlPressed(1, 27)) then -- move right
        yCoord = yCoord + MOVEMENT_CONSTANT
        DetachEntity(newVeh, 0, 0)
        AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
    end

    if (IsControlPressed(1, 187)) then -- move left
        yCoord = yCoord - MOVEMENT_CONSTANT
        DetachEntity(newVeh, 0, 0)
        AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
    end

    if (IsControlPressed(1, 208)) then -- move up
        zCoord = zCoord + MOVEMENT_CONSTANT
        DetachEntity(newVeh, 0, 0)
        AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
    end

    if (IsControlPressed(1, 207)) then -- move down
        zCoord = zCoord - MOVEMENT_CONSTANT
        DetachEntity(newVeh, 0, 0)
        AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
    end
end
  
function resetOffSets()
    xCoord = 0
    yCoord = 0
    zCoord = 0
    xrot = 0
    yrot = 0
    zrot = 0
end

function TogPowercallStateForVeh(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if toggle == true then
            if snd_pwrcall[veh] == nil then
                snd_pwrcall[veh] = GetSoundId()
				PlaySoundFromEntity(snd_pwrcall[veh], sirenTone, veh, 0, 0, 0)
				sirenBool = true
			end
        else
            if snd_pwrcall[veh] ~= nil then
                --sirenToneNumber = 1
				StopSound(snd_pwrcall[veh])
				ReleaseSoundId(snd_pwrcall[veh])
                snd_pwrcall[veh] = nil
                sirenBool = false
			end
		end
	end
end

function playAirHorn(bool)
    local tempVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local currPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    if not(vehPlateBoolSavedData == currPlate) then
        TriggerServerEvent("returnLightBarVehiclePlates")
        while true do
            if(vehPlateBoolSavedData == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))) then
                break
            end
            if not(currPlate == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))) then
                return
            end
            Citizen.Wait(10)
        end
    end
  
    if not(tempVeh == nil) and isPlateCar and vehPlateBoolSavedData == currPlate then
        if bool then
            airHornSirenID = GetSoundId()
            PlaySoundFromEntity(airHornSirenID, "SIRENS_AIRHORN", tempVeh, 0, 0, 0)
        end
        if not bool then
            StopSound(airHornSirenID)
            ReleaseSoundId(airHornSirenID)
            airHornSirenID = nil
        end
    end
end

function deleteArray()
    for k,v in pairs(deleteVehicleLightbars) do 
        DeleteVehicle(NetToVeh(v))
    end
end

function toggleLights()
    local player = GetPlayerPed(-1)
    TriggerServerEvent("toggleLights2", GetVehicleNumberPlateText(GetVehiclePedIsIn(player, false)))
    if sirenBool == true then
        TriggerServerEvent("ToggleSound1Server", GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
    end
  end

RegisterNetEvent("sendLightBarVehiclePlates")
AddEventHandler("sendLightBarVehiclePlates", function(platesArr)
  local player = GetPlayerPed(-1)
  local currPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(player, false))
  for k,v in pairs(platesArr) do 
        if currPlate == v then
            vehPlateBoolSavedData = currPlate
            isPlateCar = true
            return
        end
  end
  vehPlateBoolSavedData = currPlate
  isPlateCar = false
end)

RegisterNetEvent('clientToggleLights')
AddEventHandler('clientToggleLights', function(lightsArray, lightsStatus, hostVehiclePointer)
  Citizen.CreateThread(function()
    for k,v in pairs(lightsArray) do 
      NetworkRequestControlOfNetworkId(v) 
      while not NetworkHasControlOfNetworkId(v) do
        Citizen.Wait(0)
      end

      lightBool = lightsStatus
      SetVehicleSiren(NetToVeh(v), not lightsStatus)
	  end
  end)
end)

RegisterNetEvent('openLightbarMenu')
AddEventHandler('openLightbarMenu', function(lightbarModel)
  lightMenu(lightbarModel)
end)

RegisterNetEvent("deleteLightbarVehicle")
AddEventHandler("deleteLightbarVehicle", function(mainVehPlate)
  TriggerServerEvent("returnLightbarsForMainVeh", mainVehPlate)
end)

RegisterNetEvent("updateLightbarArray")
AddEventHandler("updateLightbarArray", function(plates)
  deleteVehicleLightbars = plates
  if sirenBool then
    toggleLights()
  end
  deleteArray()
  isPlateCar = false
  lightBool = false
  sirenBool = false
end)

RegisterNetEvent("sound1Client")
AddEventHandler("sound1Client", function(sender, toggle)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if IsPedInAnyVehicle(ped_s, false) then
			local veh = GetVehiclePedIsUsing(ped_s)
			TogPowercallStateForVeh(veh, toggle)
		end
	end
    Citizen.CreateThread(
        function()
            local i = 0

            while true do
                Wait(500)
                i = i + 1
                if (#(GetEntityCoords(ped_s) - GetEntityCoords(GetPlayerPed(-1))) < 10 or i >= 240) then
                    local veh = GetVehiclePedIsUsing(ped_s) or GetVehiclePedIsUsing(GetPlayerPed(-1))
			        TogPowercallStateForVeh(veh, false)
                    break
                end
            end
        end
    )
end)

RMenu.Add("police", "permis", RageUI.CreateMenu("", "Permis disponibles", 10, 200))

RMenu.Add("police", "identity", RageUI.CreateMenu("", "Cartes d'identitées disponibles", 10, 200))
RMenu.Add("police", "hunting_license", RageUI.CreateMenu("Permis de chasse", "Actions disponibles", 10, 200))
RMenu.Add("police", "sirens", RageUI.CreateMenu("Sirènes", "Sirènes disponibles", 10, 200))

RMenu.Add("concess", "listes", RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "", "Ventes effectuées"))
RMenu.Add("concess", "listes_veh", RageUI.CreateSubMenu(RMenu:Get("concess", "listes"), "", "Informations"))
RMenu.Add("concess", "jobs", RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "", "Entreprise à attribuer"))

RMenu.Add("autoshop", "listes", RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "", "Ventes effectuées"))
RMenu.Add("autoshop", "listes_veh", RageUI.CreateSubMenu(RMenu:Get("concess", "listes"), "", "Informations"))

RMenu.Add("bikershop", "listes", RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "", "Ventes effectuées"))
RMenu.Add("bikershop", "listes_veh", RageUI.CreateSubMenu(RMenu:Get("concess", "listes"), "", "Informations"))

local VehiclesList = {}

function Clef()
    local veh = ClosestVeh()
    local closestvehicle = GetClosestVehicle(LocalPlayer().Pos.x, LocalPlayer().Pos.y, LocalPlayer().Pos.z, 1.5, 0, 127)
    if veh == 0 and closestvehicle == 0 then
        return ShowNotification("~r~Aucun véhicule proche")
    end
    if veh == 0 then
        vehc = closestvehicle
    else
        vehc = veh
    end
    local k = GetVehicleNumberPlateText(vehc)
    if k ~= nil then
        TriggerServerCallback(
            "core:GetVehicleOwnedX",
            function(b)
                if b then
                    items = {
                        name = "key",
                        data = {
                            plate = k,
                            vehicleIdentifier = getVehicleIdentifier(vehc)
                        },
                        label = k
                    }
                    Ora.Inventory:AddItem(items)
                else
                    ShowNotification("~r~Véhicule inexistant")
                end
            end,
            k
        )
    end
end

function CarteGrise()
    local k = KeyboardInput("Plaque ", nil, 10)
    k = tostring(k)

    if k ~= nil then
        TriggerServerCallback(
            "core:GetVehicleOwned+Infos",
            function(b, v, x)
                if b then
                    _t = json.decode(v.settings)
                    if x == nil then
                        x = v.uuid
                    end
                    items = {name = "carte_grise", data = {plate = k, model = _t.label, identity = x}, label = k}
                    Ora.Inventory:AddItem(items)
                end
            end,
            k
        )
    end
end
function CGNvxProprioJob()
    Citizen.CreateThread(function()
        Wait(20)
        RageUI.GoBack()
        RageUI.Visible(RMenu:Get("concess", "jobs"), true)
    end)
end

function CGNvxProprioPlyr()
    local fn = tostring(KeyboardInput("Prénom ", nil, 25))
    local ln = tostring(KeyboardInput("Nom ", nil, 25))
    local plate = tostring(KeyboardInput("Plaque ", nil, 8))
    if fn ~= nil and ln ~= nil and plate ~= nil then
        TriggerServerCallback(
            "core:SetNewOwner+Infos",
            function(foundPly, ply, foundPlt, vhl, isUpdated)
                if foundPly then
                    if foundPlt then
                        if isUpdated then
                            Ora.Inventory:AddItem({name = "carte_grise", data = {plate = vhl.plate, model = vhl.label, identity = {first_name = ply.first_name, last_name = ply.last_name}}, label = vhl.plate})
                            TriggerServerEvent(
                                "Ora:sendToDiscord",
                                36,
                                string.format("A changé le véhicule %s avec la plaque %s de propriétaire pour %s %s", vhl.label, vhl.plate, ply.first_name, ply.last_name)
                            )
                        else
                            error("ERREUR: Impossible d'update l'uuid de cette plaque: "..plate..". Contactez un Administrateur.")
                            SendNotification("~r~~h~ERREUR~h~:\nPlaque ou Prénom/nom non-trouvées.~s~")
                        end
                    else
                        SendNotification("~r~~h~ERREUR~h~:\nPlaque non-trouvée.~s~")
                    end
                else
                    SendNotification("~r~~h~ERREUR~h~:\nPrénom/Nom non-trouvés.~s~")
                end
            end,
            fn,
            ln,
            plate
        )
    end
end

function CGNvxProprioPlyrID(id)
    local plate = tostring(KeyboardInput("Plaque ", nil, 8))
    if (plate ~= nil) then
        TriggerServerCallback(
            "Ora::SE::Identity:GetIdentity",
            function(player)
                if (player.first_name and player.last_name) then
                    TriggerServerCallback(
                        "core:SetNewOwner+Infos",
                        function(foundPly, ply, foundPlt, vhl, isUpdated)
                            if (foundPly) then
                                if (foundPlt) then
                                    if (isUpdated) then
                                        Ora.Inventory:AddItem({name = "carte_grise", data = {plate = vhl.plate, model = vhl.label, identity = {first_name = ply.first_name, last_name = ply.last_name}}, label = vhl.plate})
                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            36,
                                            string.format("A changé le véhicule %s avec la plaque %s de propriétaire pour %s %s", vhl.label, vhl.plate, ply.first_name, ply.last_name)
                                        )
                                    else
                                        error("ERREUR: Impossible d'update l'uuid de cette plaque: "..plate..". Contactez un Administrateur.")
                                        SendNotification("~r~~h~ERREUR~h~:\nPlaque ou Prénom/nom non-trouvées.~s~")
                                    end
                                else
                                    SendNotification("~r~~h~ERREUR~h~:\nPlaque non-trouvée.~s~")
                                end
                            else
                                SendNotification("~r~~h~ERREUR~h~:\nPrénom/Nom non-trouvés.~s~")
                            end
                        end,
                        player.first_name,
                        player.last_name,
                        plate
                    )
                else
                    SendNotification("~r~~h~ERREUR~h~:\nPrénom/Nom non-trouvés, essayez avec l'option de sélection du prénom et nom.~s~")
                end
            end,
            id
        )
    end
end

function ListesVentes() -- (concess)
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            TriggerServerCallback(
                "vehicleshop:GetAll",
                function(d, identity)
                    for t = 1, #d, 1 do
                        d[t].identityBuyer = d[t].buyer
                        if d[t].buyer == nil then
                            d[t].identityBuyer = "Contactez un admin (pas de vendeur)"
                        end
                        d[t].identityVendor = "Inconnu"
                        local buyerFound = false
                        for i = 1, #identity, 1 do
                            if identity[i].uuid == d[t].buyer then
                                d[t].identityBuyer = identity[i]
                                buyerFound = true
                            end

                            if identity[i].uuid == d[t].vendor then
                                d[t].identityVendor = identity[i]
                            end
                        end

                        if (buyerFound == false) then
                            d[t].identityBuyer = {}
                            d[t].identityBuyer.first_name = "Société"
                            d[t].identityBuyer.last_name = d[t].buyer
                        end
                    end
                    VehiclesList = d
                end
            )
            RageUI.Visible(RMenu:Get("concess", "listes"), true)
        end
    )
end
local currVEH = {}
function RentrerVeh()
    print(GetInteriorFromEntity(PlayerPedId()))
    if GetInteriorFromEntity(PlayerPedId()) == 7170 then
        DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
    end
end
function RentrerVeh2()
    DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
end
function RentrerVeh3()
    DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
end
local filter = nil
Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            if RageUI.Visible(RMenu:Get("concess", "listes")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        local label2 = search == nil and "Rechercher" or "Recherche actuel : ~b~" .. search
                        RageUI.Button(
                            label2,
                            nil,
                            {RightLabel = "🔍"},
                            true,
                            function(_, _, S)
                                if S then
                                    local filter = KeyboardInput("Rechercher", nil, 250)
                                    filter = tostring(filter)
                                    if filter ~= "nil" then
                                        if tostring(filter) ~= nil and filter ~= "" then
                                            search = filter
                                        elseif tostring(filter) == nil and filter == "" then
                                            search = nil
                                        else
                                            search = nil
                                            ShowAboveRadarMessage("Recherche ~r~invalide")
                                        end
                                    else
                                        search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                end
                            end
                        )
                        local found = false
                        for i = 1, #VehiclesList, 1 do
                            if filter ~= nil then
                                for k, v in pairs(vehicleList) do
                                    if string.match(v, filterSearch.search:lower()) then
                                        found = true
                                    end
                                end
                            else
                                found = true
                            end
                            if found then
                                RageUI.Button(
                                    VehiclesList[i].model .. " - " .. VehiclesList[i].plate,
                                    nil,
                                    {RightLabel = VehiclesList[i].date},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            currVEH = VehiclesList[i]
                                        end
                                    end,
                                    RMenu:Get("concess", "listes_veh")
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("concess", "listes_veh")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        RageUI.Button(
                            "Modèle du véhicule ",
                            nil,
                            {RightLabel = currVEH.model},
                            true,
                            function(_, _, Selected)
                            end
                        )
                        RageUI.Button(
                            "Plaques ",
                            nil,
                            {RightLabel = currVEH.plate},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Prix de vente ",
                            nil,
                            {RightLabel = currVEH.prices .. "$"},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Date de la vente ",
                            nil,
                            {RightLabel = currVEH.date},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        local bfirstname = currVEH.identityBuyer.first_name or ""
                        local blastname = currVEH.identityBuyer.last_name or currVEH.identityBuyer

                        RageUI.Button(
                            "Acheteur ",
                            nil,
                            {RightLabel = bfirstname .. " " .. blastname},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        local vfirstname = currVEH.identityVendor.first_name or ""
                        local vlastname = currVEH.identityVendor.last_name or currVEH.identityVendor

                        RageUI.Button(
                            "Vendeur ",
                            nil,
                            {RightLabel = vfirstname .. " " .. vlastname},
                            true,
                            function(_, _, Selected)
                            end
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("concess", "jobs")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        for k, v in pairs(Jobs) do
                            RageUI.Button(
                                v.label,
                                nil,
                                {},
                                true,
                                function(_, Active, Selected)
                                    if Selected then
                                        local plate = tostring(KeyboardInput("Plaque ", nil, 8))
                                        if plate ~= nil and #plate == 8 then
                                            TriggerServerCallback(
                                                "core:SetNewOwner+Infos",
                                                function(foundPlt, vhl, isUpdated)
                                                    if foundPlt then
                                                        if isUpdated then
                                                            Ora.Inventory:AddItem({name = "carte_grise", data = {plate = vhl.plate, model = vhl.label, identity = k}, label = vhl.plate})
                                                            TriggerServerEvent(
                                                                "Ora:sendToDiscord",
                                                                36,
                                                                string.format("A changé le véhicule %s avec la plaque %s de propriétaire pour l'entreprise %s", vhl.label, vhl.plate, k)
                                                            )
                                                            CloseAllMenus()
                                                        else
                                                            error("ERREUR: Impossible d'update l'uuid de cette plaque: "..plate..". Contactez un Administrateur.")
                                                            SendNotification("~r~~h~ERREUR~h~:\nImpossible de changer cette plaque, contactez l'assurance.~s~")
                                                        end
                                                    else
                                                        SendNotification("~r~~h~ERREUR~h~:\nPlaque non-trouvée.~s~")
                                                    end
                                                end,
                                                k,
                                                0,
                                                plate
                                            )
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)
local zoneRadius = 50.0
local createdSpeedZones = {}
function Police.ChangeZone()
    if createdSpeedZones.id ~= nil then
        RemoveSpeedZone(createdSpeedZones.id)
    end
    local pos = LocalPlayer().Pos
    local val = tonumber(KeyboardInput("KM/H"))
    if val == nil then
        return
    end
    local zone = AddSpeedZoneForCoord(pos, zoneRadius, math.ceil((val or 0) / 3.6) + 0.0)
    createdSpeedZones = {id = zone, pos = pos}

    ShowAboveRadarMessage(
        string.format("La vitesse est limité à ~g~%skm/h~w~ dans la zone.", math.ceil(tonumber(val or 0)))
    )
end

function Police.EditZone()
    if createdSpeedZones.id ~= nil then
        RemoveSpeedZone(createdSpeedZones.id)
    end
    local pos = LocalPlayer().Pos
    local val = tonumber(KeyboardInput("Mètres de rayons", nil, 3))

    if val == nil then
        return
    end
    zoneRadius = val * 1.0001
    local zone = AddSpeedZoneForCoord(pos, zoneRadius, math.ceil((val or 0) / 3.6) + 0.0)
    createdSpeedZones.id = zone

    ShowAboveRadarMessage("La zone est maintenant de ~g~" .. val .. "m de rayons")
end

function Police.RemoveZone()
    if createdSpeedZones.id ~= nil then
        RemoveSpeedZone(createdSpeedZones.id)
        createdSpeedZones = {}

        ShowAboveRadarMessage("~b~La vitesse n'est plus limitée")
    end
end
function Police.PutInVeh()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        TriggerPlayerEvent("police:PutVeh", playerId)
    end
end

function Police.SortirVeh()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        TriggerPlayerEvent("police:PutVeh", playerId)
    end
end

RegisterNetEvent("police:PutVeh")
AddEventHandler(
    "police:PutVeh",
    function()
        local ped = LocalPlayer().Ped
        local vehicle = GetVehiclePedIsIn(LocalPlayer().Ped)
        if vehicle == 0 then
            vehicle = vehicleFct.GetClosestVehicle()
            TaskEnterVehicle(LocalPlayer().Ped, vehicle, 10000, 1)
        else
            TaskLeaveAnyVehicle(LocalPlayer().Ped)
        end
    end
)

function Police.ShowZone()
    if createdSpeedZones.id ~= nil then
        DrawMarker(
            28,
            createdSpeedZones.pos,
            0.0,
            0.0,
            0.0,
            0.0,
            0.0,
            0.0,
            zoneRadius,
            zoneRadius,
            zoneRadius,
            192,
            255,
            0,
            70,
            0,
            0,
            0,
            0,
            0,
            0,
            0
        )
    end
end

function Police.CutMenottes()
    local playerId = GetPlayerServerIdInDirection(5.0)
    local item = {name = "menottes", data = {}}
    if (playerId ~= false) then
        local isHandcuff = IsPlyHandcuff(playerId)
        if isHandcuff then
            if Ora.Identity.Job:GetName() == "police" or Ora.Identity.Job:GetName() == "lssd" then
                TriggerServerEvent("player:Handcuff", playerId, false)
                Ora.Inventory:AddItem(item)
            else
                TriggerServerEvent("player:Handcuff", playerId, false)
            end
        else
            RageUI.Popup({message = "Ce joueur n'est pas menotté"})
        end
    else
        RageUI.Popup({message = "~r~Aucun joueur proche"})
    end
end
function Police.PutPortWeapon()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        local txtt = KeyboardInput("Numéro de série", nil, 2)

        items = {name = "weapon_licences", data = {serial = txtt}}
        Ora.Inventory:AddItem(items)
        ShowNotification("~r~Vous avez créer un permis port d'arme avec le numéro de série ~y~" .. txtt)
    else
        RageUI.Popup({message = "~r~Aucun joueur proche"})
    end
end

function Police.GetHose(source)
    TriggerEvent("Client:HoseCommand", source, true)
end

function Police.AutorizePpa()
    local target = GetPlayerServerIdInDirection(5.0)
    if (target) then
        TriggerPlayerEvent("Ora::CE::NpcJobs:DrivingSchool::SetDB", target, 1)
        RageUI.Popup({message = string.format("~b~Vous avez donné le PPA à %s", Ora.Identity:GetFullname(target))})
    end
end

function Police.RetirePpa()
    local target = GetPlayerServerIdInDirection(5.0)
    if (target) then
        TriggerPlayerEvent("Ora::CE::NpcJobs:DrivingSchool::SetDB", target, 0)
        RageUI.Popup({message = string.format("~b~Vous avez retiré le PPA à %s", Ora.Identity:GetFullname(target))})
    end
end
-- function ListesVentesnord() -- (autoshop nord)
--     Citizen.CreateThread(function()
--         RageUI.GoBack()
--         Wait(20)
--         RageUI.GoBack()
--         Wait(20)
--         RageUI.GoBack()
--         Wait(20)
--         RageUI.GoBack()
--         Wait(20)
--         RageUI.GoBack()
--         TriggerServerCallback('autoshop:GetAll',function(d,identity)
--             for t = 1 , #d , 1 do
--                 for i = 1 , #identity, 1 do
--                     if identity[i].uuid == d[t].buyer then
--                         d[t].identityBuyer = identity[i]
--                     end

--                     if identity[i].uuid == d[t].vendor then
--                         d[t].identityVendor = identity[i]
--                     end
--                 end
--             end
--             VehiclesList =  d
--         end)
--         RageUI.Visible(RMenu:Get('autoshop',"listes"),true)
--     end)
-- end

function ListesVentesnord() -- (concess NORD)
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            TriggerServerCallback(
                "autoshop:GetAll",
                function(d, identity)
                    for t = 1, #d, 1 do
                        local buyerFound = false
                        for i = 1, #identity, 1 do
                            if identity[i].uuid == d[t].buyer then
                                d[t].identityBuyer = identity[i]
                                buyerFound = true
                            end

                            if identity[i].uuid == d[t].vendor then
                                d[t].identityVendor = identity[i]
                            end
                        end

                        if (buyerFound == false) then
                            d[t].identityBuyer = {}
                            d[t].identityBuyer.first_name = "Société"
                            d[t].identityBuyer.last_name = d[t].buyer
                        end
                    end
                    VehiclesList = d
                end
            )
            RageUI.Visible(RMenu:Get("autoshop", "listes"), true)
        end
    )
end
Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            if RageUI.Visible(RMenu:Get("autoshop", "listes")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        local label2 = search == nil and "Rechercher" or "Recherche actuel : ~b~" .. search
                        RageUI.Button(
                            label2,
                            nil,
                            {RightLabel = "🔍"},
                            true,
                            function(_, _, S)
                                if S then
                                    local filter = KeyboardInput("Rechercher", nil, 250)
                                    filter = tostring(filter)
                                    if filter ~= "nil" then
                                        if tostring(filter) ~= nil and filter ~= "" then
                                            search = filter
                                        elseif tostring(filter) == nil and filter == "" then
                                            search = nil
                                        else
                                            search = nil
                                            ShowAboveRadarMessage("Recherche ~r~invalide")
                                        end
                                    else
                                        search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                end
                            end
                        )
                        local found = false
                        for i = 1, #VehiclesList, 1 do
                            if filter ~= nil then
                                for k, v in pairs(vehicleList) do
                                    if string.match(v, filterSearch.search:lower()) then
                                        found = true
                                    end
                                end
                            else
                                found = true
                            end
                            if found then
                                RageUI.Button(
                                    VehiclesList[i].model .. " - " .. VehiclesList[i].plate,
                                    nil,
                                    {RightLabel = VehiclesList[i].date},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            currVEH = VehiclesList[i]
                                        end
                                    end,
                                    RMenu:Get("autoshop", "listes_veh")
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("autoshop", "listes_veh")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        RageUI.Button(
                            "Modèle du véhicule ",
                            nil,
                            {RightLabel = currVEH.model},
                            true,
                            function(_, _, Selected)
                            end
                        )
                        RageUI.Button(
                            "Plaques ",
                            nil,
                            {RightLabel = currVEH.plate},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Prix de vente ",
                            nil,
                            {RightLabel = currVEH.prices .. "$"},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Date de la vente ",
                            nil,
                            {RightLabel = currVEH.date},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Acheteur ",
                            nil,
                            {RightLabel = currVEH.identityBuyer.first_name .. " " .. currVEH.identityBuyer.last_name},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Vendeur ",
                            nil,
                            {RightLabel = currVEH.identityVendor.first_name .. " " .. currVEH.identityVendor.last_name},
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

function ListesVentesautojap() -- (concess jap)
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            TriggerServerCallback(
                "autojap:GetAll",
                function(d, identity)
                    for t = 1, #d, 1 do
                        local buyerFound = false
                        for i = 1, #identity, 1 do
                            if identity[i].uuid == d[t].buyer then
                                d[t].identityBuyer = identity[i]
                                buyerFound = true
                            end

                            if identity[i].uuid == d[t].vendor then
                                d[t].identityVendor = identity[i]
                            end
                        end

                        if (buyerFound == false) then
                            d[t].identityBuyer = {}
                            d[t].identityBuyer.first_name = "Société"
                            d[t].identityBuyer.last_name = d[t].buyer
                        end
                    end
                    VehiclesList = d
                end
            )
            RageUI.Visible(RMenu:Get("autojap", "listes"), true)
        end
    )
end
Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            if RageUI.Visible(RMenu:Get("autojap", "listes")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        local label2 = search == nil and "Rechercher" or "Recherche actuel : ~b~" .. search
                        RageUI.Button(
                            label2,
                            nil,
                            {RightLabel = "🔍"},
                            true,
                            function(_, _, S)
                                if S then
                                    local filter = KeyboardInput("Rechercher", nil, 250)
                                    filter = tostring(filter)
                                    if filter ~= "nil" then
                                        if tostring(filter) ~= nil and filter ~= "" then
                                            search = filter
                                        elseif tostring(filter) == nil and filter == "" then
                                            search = nil
                                        else
                                            search = nil
                                            ShowAboveRadarMessage("Recherche ~r~invalide")
                                        end
                                    else
                                        search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                end
                            end
                        )
                        local found = false
                        for i = 1, #VehiclesList, 1 do
                            if filter ~= nil then
                                for k, v in pairs(vehicleList) do
                                    if string.match(v, filterSearch.search:lower()) then
                                        found = true
                                    end
                                end
                            else
                                found = true
                            end
                            if found then
                                RageUI.Button(
                                    VehiclesList[i].model .. " - " .. VehiclesList[i].plate,
                                    nil,
                                    {RightLabel = VehiclesList[i].date},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            currVEH = VehiclesList[i]
                                        end
                                    end,
                                    RMenu:Get("autojap", "listes_veh")
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("autojap", "listes_veh")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        RageUI.Button(
                            "Modèle du véhicule ",
                            nil,
                            {RightLabel = currVEH.model},
                            true,
                            function(_, _, Selected)
                            end
                        )
                        RageUI.Button(
                            "Plaques ",
                            nil,
                            {RightLabel = currVEH.plate},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Prix de vente ",
                            nil,
                            {RightLabel = currVEH.prices .. "$"},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Date de la vente ",
                            nil,
                            {RightLabel = currVEH.date},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Acheteur ",
                            nil,
                            {RightLabel = currVEH.identityBuyer.first_name .. " " .. currVEH.identityBuyer.last_name},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Vendeur ",
                            nil,
                            {RightLabel = currVEH.identityVendor.first_name .. " " .. currVEH.identityVendor.last_name},
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


function ListesVentesmoto() -- (Bikershop)
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            TriggerServerCallback(
                "bikershop:GetAll",
                function(d, identity)
                    for t = 1, #d, 1 do
                        local buyerFound = false

                        for i = 1, #identity, 1 do
                            if identity[i].uuid == d[t].buyer then
                                d[t].identityBuyer = identity[i]
                                buyerFound = true
                            end

                            if identity[i].uuid == d[t].vendor then
                                d[t].identityVendor = identity[i]
                            end
                        end

                        if (buyerFound == false) then
                            d[t].identityBuyer = {}
                            d[t].identityBuyer.first_name = "Société"
                            d[t].identityBuyer.last_name = d[t].buyer
                        end
                    end
                    VehiclesList = d
                end
            )
            RageUI.Visible(RMenu:Get("bikershop", "listes"), true)
        end
    )
end
Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            if RageUI.Visible(RMenu:Get("bikershop", "listes")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        local label2 = search == nil and "Rechercher" or "Recherche actuel : ~b~" .. search
                        RageUI.Button(
                            label2,
                            nil,
                            {RightLabel = "🔍"},
                            true,
                            function(_, _, S)
                                if S then
                                    local filter = KeyboardInput("Rechercher", nil, 250)
                                    filter = tostring(filter)
                                    if filter ~= "nil" then
                                        if tostring(filter) ~= nil and filter ~= "" then
                                            search = filter
                                        elseif tostring(filter) == nil and filter == "" then
                                            search = nil
                                        else
                                            search = nil
                                            ShowAboveRadarMessage("Recherche ~r~invalide")
                                        end
                                    else
                                        search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                end
                            end
                        )
                        local found = false
                        for i = 1, #VehiclesList, 1 do
                            if filter ~= nil then
                                for k, v in pairs(vehicleList) do
                                    if string.match(v, filterSearch.search:lower()) then
                                        found = true
                                    end
                                end
                            else
                                found = true
                            end
                            if found then
                                RageUI.Button(
                                    VehiclesList[i].model .. " - " .. VehiclesList[i].plate,
                                    nil,
                                    {RightLabel = VehiclesList[i].date},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            currVEH = VehiclesList[i]
                                        end
                                    end,
                                    RMenu:Get("bikershop", "listes_veh")
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("bikershop", "listes_veh")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        RageUI.Button(
                            "Modèle du véhicule ",
                            nil,
                            {RightLabel = currVEH.model},
                            true,
                            function(_, _, Selected)
                            end
                        )
                        RageUI.Button(
                            "Plaques ",
                            nil,
                            {RightLabel = currVEH.plate},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Prix de vente ",
                            nil,
                            {RightLabel = currVEH.prices .. "$"},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Date de la vente ",
                            nil,
                            {RightLabel = currVEH.date},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Acheteur ",
                            nil,
                            {RightLabel = currVEH.identityBuyer.first_name .. " " .. currVEH.identityBuyer.last_name},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Vendeur ",
                            nil,
                            {RightLabel = currVEH.identityVendor.first_name .. " " .. currVEH.identityVendor.last_name},
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
