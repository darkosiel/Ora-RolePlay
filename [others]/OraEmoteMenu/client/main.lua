local display = false

local AnimationDuration = -1
local ChosenAnimation = ""
local ChosenDict = ""
local IsInAnimation = false
local MostRecentChosenAnimation = ""
local MostRecentChosenDict = ""
local MovementType = 0
local PlayerGender = "male"
local PlayerHasProp = false
local PlayerProps = {}
local PlayerParticles = {}
local SecondPropEmote = false
local PtfxNotif = false
local PtfxPrompt = false
local PtfxWait = 500
local PtfxNoProp = false

RegisterKeyMapping('emote', 'Menu emote', 'keyboard', 'f4')
RegisterCommand('emote', function()
    SetDisplay(not display)
    display = not display
    print("Menu :" .. tostring(display))
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
        DisableControlAction(0, 3, true) -- disable mouse look
        DisableControlAction(0, 4, true) -- disable mouse look
        DisableControlAction(0, 5, true) -- disable mouse look
        DisableControlAction(0, 6, true) -- disable mouse look
        DisableControlAction(0, 263, true) -- disable melee
        DisableControlAction(0, 264, true) -- disable melee
        DisableControlAction(0, 257, true) -- disable melee
        DisableControlAction(0, 140, true) -- disable melee
        DisableControlAction(0, 141, true) -- disable melee
        DisableControlAction(0, 143, true) -- disable melee
        DisableControlAction(0, 177, true) -- disable escape
        DisableControlAction(0, 200, true) -- disable escape
        DisableControlAction(0, 202, true) -- disable escape
        DisableControlAction(0, 244, true) -- disable phone
        DisableControlAction(0, 245, true) -- disable chat
    end
end, false)

function SetDisplay(status)
    SetNuiFocus(status, status)
    SetNuiFocusKeepInput(status)
    SendNUIMessage({
        type = "ui",
        display = status
    })
end

Citizen.CreateThread(function()
    Citizen.Wait(500)
    TriggerServerEvent("OraEmoteMenu:ServerGetFavoriteEmoteList")
end)

Citizen.CreateThread(function()
    while true do
        if IsPedShooting(PlayerPedId()) and IsInAnimation then
            EmoteCancel()
        end
        if PtfxPrompt then
            if not PtfxNotif then
                SimpleNotify(PtfxInfo)
                PtfxNotif = true
            end
            if IsControlPressed(0, 47) then
                PtfxStart()
                Wait(PtfxWait)
                PtfxStop()
            end
        end
        if Config.EnableXtoCancel then if IsControlPressed(0, 73) then EmoteCancel() end end
        Citizen.Wait(1)
    end
end)

RegisterNUICallback("exit", function(data)
    display = false
    SetDisplay(false)
end)

RegisterNUICallback("playEmote", function(data)
    EmoteStart(data.name)
end)

RegisterNUICallback("cancelEmote", function(data)
    EmoteCancel()
end)

function EmoteCancel()
    if ChosenDict == "MaleScenario" and IsInAnimation then
        ClearPedTasksImmediately(PlayerPedId())
        IsInAnimation = false
        DebugPrint("Forced scenario exit")
    elseif ChosenDict == "Scenario" and IsInAnimation then
        ClearPedTasksImmediately(PlayerPedId())
        IsInAnimation = false
        DebugPrint("Forced scenario exit")
    end

    PtfxNotif = false
    PtfxPrompt = false

    if IsInAnimation then
        PtfxStop()
        ClearPedTasks(GetPlayerPed(-1))
        DestroyAllProps()
        IsInAnimation = false
    end
end

function DebugPrint(args)
    if Config.DebugDisplay then
        print(args)
    end
end

function EmoteStart(args)
    if #args > 0 then
        local name = tostring(args)
        if name == "c" then
            if IsInAnimation then
                EmoteCancel()
            end
            return
        end
        if DP.Emotes[name] ~= nil then
            if OnEmotePlay(DP.Emotes[name]) then end return
        elseif DP.Dances[name] ~= nil then
            if OnEmotePlay(DP.Dances[name]) then end return
        elseif DP.PropEmotes[name] ~= nil then
            if OnEmotePlay(DP.PropEmotes[name]) then end return
        elseif DP.Expressions[name] ~= nil then
            if OnEmotePlay(DP.Expressions[name]) then end return
        elseif DP.Walks[name] ~= nil then
            if WalkMenuStart(DP.Walks[name]) then end return
        end
    end
end

function OnEmotePlay(EmoteName)

    InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
    if not Config.AllowedInCars and InVehicle == 1 then
        return
    end

    if not DoesEntityExist(GetPlayerPed(-1)) then
        return false
    end

    if Config.DisarmPlayer then
        if IsPedArmed(GetPlayerPed(-1), 7) then
            SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
        end
    end

    ChosenDict,ChosenAnimation,ename = table.unpack(EmoteName)
    AnimationDuration = -1

    if PlayerHasProp then
        DestroyAllProps()
    end

    if ChosenDict == "Expression" then
        SetFacialIdleAnimOverride(PlayerPedId(), ChosenAnimation, 0)
        return
    end

    if ChosenDict == "MaleScenario" or "Scenario" then 
        CheckGender()
        if ChosenDict == "MaleScenario" then if InVehicle then return end
            if PlayerGender == "male" then
            ClearPedTasks(GetPlayerPed(-1))
            TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
            DebugPrint("Playing scenario = ("..ChosenAnimation..")")
            IsInAnimation = true
            else
            EmoteChatMessage(Config.Languages[lang]['maleonly'])
            end return
        elseif ChosenDict == "ScenarioObject" then if InVehicle then return end
            BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
            ClearPedTasks(GetPlayerPed(-1))
            TaskStartScenarioAtPosition(GetPlayerPed(-1), ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
            DebugPrint("Playing scenario = ("..ChosenAnimation..")")
            IsInAnimation = true
            return
        elseif ChosenDict == "Scenario" then if InVehicle then return end
            ClearPedTasks(GetPlayerPed(-1))
            TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
            DebugPrint("Playing scenario = ("..ChosenAnimation..")")
            IsInAnimation = true
        return end 
    end

    LoadAnim(ChosenDict)

    if EmoteName.AnimationOptions then
        if EmoteName.AnimationOptions.EmoteLoop then
            MovementType = 1
        if EmoteName.AnimationOptions.EmoteMoving then
            MovementType = 51
    end

    elseif EmoteName.AnimationOptions.EmoteMoving then
        MovementType = 51
    elseif EmoteName.AnimationOptions.EmoteMoving == false then
        MovementType = 0
    elseif EmoteName.AnimationOptions.EmoteStuck then
        MovementType = 50
    end

    else
        MovementType = 0
    end

    --[[ if InVehicle == 1 then
        MovementType = 51
    end ]]

    if EmoteName.AnimationOptions then
        if EmoteName.AnimationOptions.EmoteDuration == nil then 
            EmoteName.AnimationOptions.EmoteDuration = -1
            AttachWait = 0
        else
            AnimationDuration = EmoteName.AnimationOptions.EmoteDuration
            AttachWait = EmoteName.AnimationOptions.EmoteDuration
        end
    
        if EmoteName.AnimationOptions.PtfxAsset then
            PtfxAsset = EmoteName.AnimationOptions.PtfxAsset
            PtfxName = EmoteName.AnimationOptions.PtfxName
            if EmoteName.AnimationOptions.PtfxNoProp then
            PtfxNoProp = EmoteName.AnimationOptions.PtfxNoProp
            else
            PtfxNoProp = false
            end
            Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(EmoteName.AnimationOptions.PtfxPlacement)
            PtfxInfo = EmoteName.AnimationOptions.PtfxInfo
            PtfxWait = EmoteName.AnimationOptions.PtfxWait
            PtfxNotif = false
            PtfxPrompt = true
            PtfxThis(PtfxAsset)
        else
            DebugPrint("Ptfx = none")
            PtfxPrompt = false
        end
    end

    TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
    RemoveAnimDict(ChosenDict)
    IsInAnimation = true
    MostRecentDict = ChosenDict
    MostRecentAnimation = ChosenAnimation

    if EmoteName.AnimationOptions then
        if EmoteName.AnimationOptions.Prop then
            PropName = EmoteName.AnimationOptions.Prop
            PropBone = EmoteName.AnimationOptions.PropBone
            PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(EmoteName.AnimationOptions.PropPlacement)
            if EmoteName.AnimationOptions.SecondProp then
                SecondPropName = EmoteName.AnimationOptions.SecondProp
                SecondPropBone = EmoteName.AnimationOptions.SecondPropBone
                SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(EmoteName.AnimationOptions.SecondPropPlacement)
                SecondPropEmote = true
            else
                SecondPropEmote = false
            end
            Wait(AttachWait)
            AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
            if SecondPropEmote then
                AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
            end
        end
    end
    return true
end

function CheckGender()
    local hashSkinMale = GetHashKey("mp_m_freemode_01")
    local hashSkinFemale = GetHashKey("mp_f_freemode_01")

    if GetEntityModel(PlayerPedId()) == hashSkinMale then
        PlayerGender = "male"
    elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
        PlayerGender = "female"
    end
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

function PtfxThis(asset)
    while not HasNamedPtfxAssetLoaded(asset) do
        RequestNamedPtfxAsset(asset)
        Wait(10)
    end
    UseParticleFxAssetNextCall(asset)
end

function DestroyAllProps()
    for _,v in pairs(PlayerProps) do
        DeleteEntity(v)
    end
    PlayerHasProp = false
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))

    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end

    exports["Ora"]:TriggerServerCallback("Ora::SE::Anticheat:RegisterObject", 
        function()
            print("ACtor")
            prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
            AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
            table.insert(PlayerProps, prop)
            PlayerHasProp = true
            SetModelAsNoLongerNeeded(prop1)
        end,
        GetHashKey(prop1)
    )

    -- prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    -- AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    -- table.insert(PlayerProps, prop)
    -- PlayerHasProp = true
    -- SetModelAsNoLongerNeeded(prop1)
    -- GetHashKey(prop1)
end

function PtfxStop()
    for a,b in pairs(PlayerParticles) do
        DebugPrint("Stopped PTFX: "..b)
        StopParticleFxLooped(b, false)
        table.remove(PlayerParticles, a)
    end
end

function WalkMenuStart(EmoteName)
    name = table.unpack(EmoteName)
    RequestWalking(name)
    SetPedMovementClipset(PlayerPedId(), name, 0.2)
    RemoveAnimSet(name)
end

function RequestWalking(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Citizen.Wait(1)
    end 
end

RegisterNetEvent("OraEmoteMenu:ClientGetFavoriteEmoteList")
AddEventHandler("OraEmoteMenu:ClientGetFavoriteEmoteList", function(status, data)
    if status == 'getFavorite' then
        TriggerServerEvent("OraEmoteMenu:ServerGetFavoriteEmoteList")
    elseif status == 'receiveFavorite' then
        SendNUIMessage({
            type = "receiveFavorite",
            data = data
        })
    end
end)

RegisterNUICallback("addFavoriteEmote", function(data)
    TriggerServerEvent('OraEmoteMenu:ServerAddFavoriteEmote', data.emote)
end)

RegisterNUICallback("removeFavoriteEmote", function(data)
    TriggerServerEvent('OraEmoteMenu:ServerRemoveFavoriteEmote', data.emote)
end)

RegisterNUICallback('EnableInput', function()
    Citizen.Trace("EnableInput")
    SetNuiFocusKeepInput(true)
end)

RegisterNUICallback('DisableInput', function()
    SetNuiFocusKeepInput(false)
end)

RegisterNUICallback('DisableWalkExpression', function()
    ResetPedMovementClipset(PlayerPedId())
    ClearFacialIdleAnimOverride(PlayerPedId())
    EmoteCancel()
end)