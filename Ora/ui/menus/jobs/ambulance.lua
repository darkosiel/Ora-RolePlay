Ambulance = {}
Pompier = {}
local fileLoaded = nil
local targetPly = false
local Tattoos = {}
local TattooConf = {
    ["mpairraces_overlays"] = "Catégorie courses",
    ["mpbusiness_overlays"] = "Catégorie buisness",
    ["mphipster_overlays"] = "Catégorie hipster",
    ["multiplayer_overlays"] = "Catégorie multijoueur",
    ["mpchristmas2_overlays"] = "Catégorie noël",
    ["mpchristmas2017_overlays"] = "Catégorie Noel 2",
    ["mpchristmas2018_overlays"] = "Catégorie Noel 3",
    ["mpheist3_overlays"] = "Catégorie Heist",
    ["mpvinewood_overlays"] = "Catégorie Vinewood",
    ["mpluxe_overlays"] = "Catégorie luxe",
    ["mpluxe2_overlays"] = "Catégorie luxe 2",
    ["mplowrider_overlays"] = "Catégorie lowrider ",
    ["mplowrider2_overlays"] = "Catégorie lowrider 2",
    ["mpstunt_overlays"] = "Catégorie stunt",
    ["mpbiker_overlays"] = "Catégorie biker",
    ["mpbeach_overlays"] = "Catégorie plage",
    ["mpsmuggler_overlays"] = "Catégorie contrebandier",
    ["mpimportexport_overlays"] = "Catégorie import-export",
    ["mpheist4_overlays"] = "Catégorie CayoPerico",
    ["mpgunrunning_overlays"] = "Catégorie spéciaux"
}

RMenu.Add("tattoo", "main", RageUI.CreateMenu("Tatouages", "Edition des tatouages", 10, 50))

local function GetArrayKey(arr, val)
    for k, v in pairs(arr) do
        if type(v) == "table" then
            for l, x in pairs(v) do
                if x == val then
                    return k
                end
            end
        else
            if v == val then
                return k
            end
        end
    end
end

function Ambulance.Revive()
    local count = Ora.Inventory:GetItemCount("medikit")
    if count > 0 then
        local playerId = GetPlayerServerIdInDirection(5.0)
        if (playerId ~= false) then
            local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
            RequestAnimDict(lib)
            while (not HasAnimDictLoaded(lib)) do Citizen.Wait(0) end
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, 0, 0, 0.0, false, false, false)
            local playerPed = PlayerPedId()
            Wait(5000)
            TriggerPlayerEvent("player:Revive",playerId)
            Ora.Inventory:RemoveFirstItem('medikit')
        else
            ShowNotification("~r~Aucun joueur proche")
        end
    else
        ShowNotification("~r~Vous n'avez pas de trousse de soin")
    end
end

function Ambulance.Heal(m)
    local count = Ora.Inventory:GetItemCount("medikit")
    if count > 0 then
        TaskStartScenarioInPlace(LocalPlayer().Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        local playerId = GetPlayerServerIdInDirection(5.0)
        if (playerId ~= false) then
            Wait(5000)
            TriggerPlayerEvent("player:Heal",playerId,m)
            ClearPedTasksImmediately(LocalPlayer().Ped)
            Ora.Inventory:RemoveFirstItem('medikit')
        else
            ShowNotification("~r~Aucun joueur proche")
        end
    else
        ShowNotification("~r~Vous n'avez pas de trousse de soin")
    end
end

function Ambulance.AllowNpcAmbulance(isAllowed)
    TriggerServerEvent("Ora::SE::Job::Ambulance:AllowNPCAmbulance", {IS_ALLOWED = isAllowed})
    ShowNotification(string.format("Les PNJ medecins sont désormais : %s", isAllowed == true and "~g~Activé~s~" or "~r~Désactivé~s~"))
end

function Ambulance.DrawMarkerVehicle()
    local vehicle = GetVehicleInDirection()
    if vehicle ~= 0 and (GetEntityModel(vehicle) == GetHashKey("emsnspeedo")) then
        local vehCoords = GetEntityCoords(vehicle)
        DrawMarker(2, vehCoords.x, vehCoords.y, vehCoords.z + 2.5, 0, 0, 0, 180.0, nil, nil, 0.5, 0.5, 0.5, 100, 165, 225, 255, false, true, 2, true)
    end
end


function Pompier.DrawMarkerVehicle()
    local vehicle = GetVehicleInDirection()
    if vehicle ~= 0 and (GetEntityModel(vehicle) == GetHashKey("lsfd4")) or GetEntityModel(veh) == GetHashKey("lsfd3") then
        local vehCoords = GetEntityCoords(vehicle)
        DrawMarker(2, vehCoords.x, vehCoords.y, vehCoords.z + 2.5, 0, 0, 0, 180.0, nil, nil, 0.5, 0.5, 0.5, 100, 165, 225, 255, false, true, 2, true)
    end
end

function Ambulance.DrawMarkerStretcher(restriction)
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local coords = GetEntityCoords(LocalPlayer().Ped)
    local stretcher = GetClosestObjectOfType(coords, 3.0, stretcherHash)
    if (restriction and stretcher ~= 0 and GetEntityAttachedTo(stretcher) == 0) or not restriction then
        local stretcherCoords = GetEntityCoords(stretcher)
        DrawMarker(2, stretcherCoords.x, stretcherCoords.y, stretcherCoords.z + 1.0, 0, 0, 0, 180.0, nil, nil, 0.5, 0.5, 0.5, 100, 165, 225, 255, false, true, 2, true)
    end
end

function Pompier.DrawMarkerStretcher(restriction)
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local coords = GetEntityCoords(LocalPlayer().Ped)
    local stretcher = GetClosestObjectOfType(coords, 3.0, stretcherHash)
    if (restriction and stretcher ~= 0 and GetEntityAttachedTo(stretcher) == 0) or not restriction then
        local stretcherCoords = GetEntityCoords(stretcher)
        DrawMarker(2, stretcherCoords.x, stretcherCoords.y, stretcherCoords.z + 1.0, 0, 0, 0, 180.0, nil, nil, 0.5, 0.5, 0.5, 100, 165, 225, 255, false, true, 2, true)
    end
end

function Ambulance.DrawMarkerOnPed()
    local targetId = GetPlayerServerIdInDirection(4.0)
    if targetId ~= false then
        local targetPlayer = GetPlayerFromServerId(targetId)
        local targetPed = GetPlayerPed(targetPlayer)
        local targetCoords = GetEntityCoords(targetPed)
        DrawMarker(2, targetCoords.x, targetCoords.y, targetCoords.z + 1.5, 0, 0, 0, 180.0, nil, nil, 0.5, 0.5, 0.5, 52, 177, 74, 255, false, true, 2, true)
    end
end

function Pompier.DrawMarkerOnPed()
    local targetId = GetPlayerServerIdInDirection(4.0)
    if targetId ~= false then
        local targetPlayer = GetPlayerFromServerId(targetId)
        local targetPed = GetPlayerPed(targetPlayer)
        local targetCoords = GetEntityCoords(targetPed)
        DrawMarker(2, targetCoords.x, targetCoords.y, targetCoords.z + 1.5, 0, 0, 0, 180.0, nil, nil, 0.5, 0.5, 0.5, 52, 177, 74, 255, false, true, 2, true)
    end
end

function Ambulance.GetOffStretcher()
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local veh = GetVehicleInDirection()
    if veh ~= 0 and GetEntityModel(veh) == GetHashKey("samsbisonamb") or GetEntityModel(veh) == GetHashKey("samsspeedoamb") or GetEntityModel(veh) == GetHashKey("samsspeedoamb2") or GetEntityModel(veh) == GetHashKey("Romero") or GetEntityModel(veh) == GetHashKey("medevac") then
        local vehCoords = GetEntityCoords(veh)
        local forward = GetEntityForwardVector(veh)
        local behind = vehCoords - (forward * 6.0)
        for object in EnumerateObjects() do
            if GetEntityModel(object) == stretcherHash and GetEntityAttachedTo(object) == veh then
                DetachEntity(object)
                SetEntityCoords(object, behind)
                PlaceObjectOnGroundProperly(object)
                SetEntityCollision(object, true, true)
                return
            end
        end
        
        local stretcher = Ora.World.Object:Create(stretcherHash, behind, true, true, true)
        SetEntityHeading(stretcher, GetEntityHeading(veh))
        PlaceObjectOnGroundProperly(stretcher)
        FreezeEntityPosition(stretcher, true)
    end
end

function Pompier.GetOffStretcher()
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local veh = GetVehicleInDirection()
    if veh ~= 0 and GetEntityModel(veh) == GetHashKey("lsfd4") or GetEntityModel(veh) == GetHashKey("lsfd3") then
        local vehCoords = GetEntityCoords(veh)
        local forward = GetEntityForwardVector(veh)
        local behind = vehCoords - (forward * 6.0)
        for object in EnumerateObjects() do
            if GetEntityModel(object) == stretcherHash and GetEntityAttachedTo(object) == veh then
                DetachEntity(object)
                SetEntityCoords(object, behind)
                PlaceObjectOnGroundProperly(object)
                SetEntityCollision(object, true, true)
                return
            end
        end
        
        local stretcher = Ora.World.Object:Create(stretcherHash, behind, true, true, true)
        SetEntityHeading(stretcher, GetEntityHeading(veh))
        PlaceObjectOnGroundProperly(stretcher)
        FreezeEntityPosition(stretcher, true)
    end
end

function Ambulance.PutStretcherOnVehicle()
    local ped = LocalPlayer().Ped
    local coords = GetEntityCoords(ped)
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local stretcher = GetClosestObjectOfType(coords, 3.0, stretcherHash)
    if stretcher and GetEntityAttachedTo(stretcher) == ped then
        local veh = GetVehicleInDirection()
        if veh ~= 0 and GetEntityModel(veh) == GetHashKey("emsnspeedo") then
            DetachEntity(stretcher)
            AttachEntityToEntity(stretcher, veh, 0.0, 0.0, -2.0, 0.8, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            FreezeEntityPosition(stretcher, true)
            ClearPedTasks(ped)
            pickStretcher = false
        end
    end
end

function Pompier.PutStretcherOnVehicle()
    local ped = LocalPlayer().Ped
    local coords = GetEntityCoords(ped)
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local stretcher = GetClosestObjectOfType(coords, 3.0, stretcherHash)
    if stretcher and GetEntityAttachedTo(stretcher) == ped then
        local veh = GetVehicleInDirection()
        if veh ~= 0 and GetEntityModel(veh) == GetHashKey("lsfd4") or GetEntityModel(veh) == GetHashKey("lsfd3") then
            DetachEntity(stretcher)
            AttachEntityToEntity(stretcher, veh, 0.0, 0.0, -2.0, 0.8, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            FreezeEntityPosition(stretcher, true)
            ClearPedTasks(ped)
            pickStretcher = false
        end
    end
end

function Ambulance.PickPutStretcher()
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local ped = LocalPlayer().Ped
    local coords = GetEntityCoords(ped)
    local stretcher = GetClosestObjectOfType(coords, 3.0, stretcherHash)
    if not pickStretcher then
        if stretcher ~= 0 and GetEntityAttachedTo(stretcher) == 0 then
            local dict = "anim@heists@box_carry@"
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Wait(100)
            end
            
            TaskPlayAnim(ped, dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
            NetworkRequestControlOfEntity(stretcher)
            while not NetworkHasControlOfEntity(stretcher) do
                Wait(0)
            end
            SetEntityAsMissionEntity(stretcher, true, true)
            while not IsEntityAMissionEntity(stretcher) do
                Wait(0)
            end
            SetEntityCollision(stretcher, false, false)
            FreezeEntityPosition(stretcher, false)
            AttachEntityToEntity(stretcher, ped,  GetPedBoneIndex(ped, 10706), 0.0, 1.5, -0.62, 0.0, 15.0, 185.0, 0.0, true, true, false, false, 1, false)
            while not IsEntityAttachedToEntity(stretcher, ped) do
                AttachEntityToEntity(stretcher, ped,  GetPedBoneIndex(ped, 10706), 0.0, 1.5, -0.62, 0.0, 15.0, 185.0, 0.0, true, true, false, false, 1, false)
                Wait(100)
            end
            pickStretcher = true
            Citizen.CreateThread(function()
                while pickStretcher do
                    if not IsEntityPlayingAnim(ped, dict, "idle", 3) then
                        TaskPlayAnim(ped, dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
                    end
                    Wait(500)
                end
            end)
        end
    else
        if stretcher ~= 0 and GetEntityAttachedTo(stretcher) == ped then
            pickStretcher = false
            DetachEntity(stretcher, true, true)
            SetEntityCollision(stretcher, true, true)
            PlaceObjectOnGroundProperly(stretcher)
            FreezeEntityPosition(stretcher, true)
            ClearPedTasks(ped)
        end
    end
end

function Pompier.PickPutStretcher()
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local ped = LocalPlayer().Ped
    local coords = GetEntityCoords(ped)
    local stretcher = GetClosestObjectOfType(coords, 3.0, stretcherHash)
    if not pickStretcher then
        if stretcher ~= 0 and GetEntityAttachedTo(stretcher) == 0 then
            local dict = "anim@heists@box_carry@"
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Wait(100)
            end
            
            TaskPlayAnim(ped, dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
            NetworkRequestControlOfEntity(stretcher)
            while not NetworkHasControlOfEntity(stretcher) do
                Wait(0)
            end
            SetEntityAsMissionEntity(stretcher, true, true)
            while not IsEntityAMissionEntity(stretcher) do
                Wait(0)
            end
            SetEntityCollision(stretcher, false, false)
            FreezeEntityPosition(stretcher, false)
            AttachEntityToEntity(stretcher, ped,  GetPedBoneIndex(ped, 10706), 0.0, 1.5, -0.62, 0.0, 15.0, 185.0, 0.0, true, true, false, false, 1, false)
            while not IsEntityAttachedToEntity(stretcher, ped) do
                AttachEntityToEntity(stretcher, ped,  GetPedBoneIndex(ped, 10706), 0.0, 1.5, -0.62, 0.0, 15.0, 185.0, 0.0, true, true, false, false, 1, false)
                Wait(100)
            end
            pickStretcher = true
            Citizen.CreateThread(function()
                while pickStretcher do
                    if not IsEntityPlayingAnim(ped, dict, "idle", 3) then
                        TaskPlayAnim(ped, dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
                    end
                    Wait(500)
                end
            end)
        end
    else
        if stretcher ~= 0 and GetEntityAttachedTo(stretcher) == ped then
            pickStretcher = false
            DetachEntity(stretcher, true, true)
            SetEntityCollision(stretcher, true, true)
            PlaceObjectOnGroundProperly(stretcher)
            FreezeEntityPosition(stretcher, true)
            ClearPedTasks(ped)
        end
    end
end

function Ambulance.PutOnStretcher()
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local ped = LocalPlayer().Ped
    local coords = GetEntityCoords(ped)
    local targetId = GetPlayerServerIdInDirection(4.0)
    local stretcher = GetClosestObjectOfType(coords, 3.0, stretcherHash)
    if stretcher ~= 0 and targetId ~= false then
        local stretcherId = NetworkGetNetworkIdFromEntity(stretcher)
        TriggerPlayerEvent("Ambulance:PutOnStretcher", targetId, stretcherId)
    end
end


function Pompier.PutOnStretcher()
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local ped = LocalPlayer().Ped
    local coords = GetEntityCoords(ped)
    local targetId = GetPlayerServerIdInDirection(4.0)
    local stretcher = GetClosestObjectOfType(coords, 3.0, stretcherHash)
    if stretcher ~= 0 and targetId ~= false then
        local stretcherId = NetworkGetNetworkIdFromEntity(stretcher)
        TriggerPlayerEvent("Ambulance:PutOnStretcher", targetId, stretcherId)
    end
end

function Ambulance.RemoveStretcher()
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local ped = LocalPlayer().Ped
    local coords = GetEntityCoords(ped)
    local stretcher = GetClosestObjectOfType(coords, 3.0, stretcherHash)
    if stretcher ~= 0 then
        DeleteEntity(stretcher)
    end
end


function Pompier.RemoveStretcher()
    local stretcherHash = GetHashKey("prop_ld_binbag_01")
    local ped = LocalPlayer().Ped
    local coords = GetEntityCoords(ped)
    local stretcher = GetClosestObjectOfType(coords, 3.0, stretcherHash)
    if stretcher ~= 0 then
        DeleteEntity(stretcher)
    end
end

function Ambulance.Tattoo()
    targetPly = GetPlayerServerIdInDirection(5.0)
    if (targetPly ~= false) then
        RageUI.CloseAll()

        TriggerServerCallback(
            'Ora::SCB::Player:GetTattoos',
            function(res)
                if (res ~= false) then
                    Tattoos = res
                    RageUI.Visible(RMenu:Get("tattoo", "main"), true)
                else
                    ShowNotification("~r~Impossible de récupérer les tatouages de cette personne")
                end
            end,
            targetPly
        )
    else
        ShowNotification("~r~Aucun joueur proche")
    end
end

Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            if RageUI.Visible(RMenu:Get("tattoo", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for i, v in ipairs(Tattoos) do
                            fileLoaded = json.decode(LoadResourceFile("Ora", "statics/data/" .. v.dict .. ".json"))
                            local labelTattoo = GetLabelText(fileLoaded[GetArrayKey(fileLoaded, v.hash)].Name)
                            if labelTattoo == "NULL" then
                                labelTattoo = fileLoaded[GetArrayKey(fileLoaded, v.hash)].LocalizedName
                            end
                            RageUI.Button(
                                labelTattoo,
                                nil,
                                {RightLabel = TattooConf[v.dict]},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        exports["mythic_progbar"]:Progress(
                                            {
                                                name = "offtattoo",
                                                duration = 30000,
                                                label = "Retrait du tatouage...",
                                                useWhileDead = false,
                                                canCancel = false,
                                                controlDisables = {
                                                    disableMovement = false,
                                                    disableCarMovement = false,
                                                    disableMouse = false,
                                                    disableCombat = true
                                                }
                                            },
                                            function(cancelled)
                                                if not cancelled then
                                                    table.remove(Tattoos, i)
                                                    TriggerServerEvent('Ora::SE::Player:SetTattoo', targetPly, Tattoos)
                                                    ClearPedDecorations(GetPlayerPed(GetPlayerFromServerId(targetPly)))
                                                    for j = 1, #Tattoos, 1 do
                                                        if Tattoos[j] ~= nil then
                                                            AddPedDecorationFromHashes(GetPlayerPed(GetPlayerFromServerId(targetPly)), Tattoos[j].dict, Tattoos[j].hash)
                                                        end
                                                    end
                                                    ShowNotification("~g~Tatouage retiré")
                                                    RageUI.Visible(RMenu:Get("tattoo", "main"), false)
                                                    Tattoos = {}
                                                    targetPly = false
                                                else
                                                    ShowNotification("~r~Action annulée")
                                                    RageUI.Visible(RMenu:Get("tattoo", "main"), false)
                                                    Tattoos = {}
                                                    targetPly = false
                                                end
                                            end
                                        )
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

RegisterNetEvent('player:Heal')
AddEventHandler('player:Heal',function(m)
    local PlayerPed = LocalPlayer().Ped
    if m ~= nil then
        SetEntityHealth(PlayerPed,GetEntityHealth(PlayerPed)+m)
        Ora.Health:RemoveInjuredEffects()
    else
        Ora.Health:SetMyHealthPercent(100)
        Ora.Health:RemoveInjuredEffects()
    end

    Ora.Player.State.IS_WOUNDED = false
end)

RegisterNetEvent("Ambulance:PutOnStretcher")
AddEventHandler("Ambulance:PutOnStretcher", function(stretcherId)
    local ped = LocalPlayer().Ped
    local stretcher = NetworkGetEntityFromNetworkId(stretcherId)
    if not onStretcher then
        onStretcher = true
        local animDict = "anim@gangops@morgue@table@"
        local animName = "body_search"
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(100)
        end
        AttachEntityToEntity(ped, stretcher, 0, 0.0, 0.2, 1.04, 0.0, 0.0, 177.0, false, false, false, true, 2, true)
        TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, 1, 0.0, false, false, false)
        Citizen.CreateThread(function()
            while onStretcher do
                if not IsEntityPlayingAnim(ped, animDict, animName, 3) then
                    TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, 1, 0.0)
                end
                Wait(500)
            end
        end)
    else
        onStretcher = false
        local animDict = "get_up@directional@transition@prone_to_seated@injured"
        local animName = "back"
        local duration = GetAnimDuration(animDict, animName)
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(100)
        end
        TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, 1, 0.0)
        Wait(duration*1000)
        local pedCoords = GetEntityCoords(ped)
        local forwardVector, rightVector, upVector, position = GetEntityMatrix(ped)
        local coords = pedCoords + rightVector
        DetachEntity(ped)
        ClearPedTasks(ped)
        SetEntityCoords(ped, coords.x, coords.y, coords.z - 1.7)
    end
end)