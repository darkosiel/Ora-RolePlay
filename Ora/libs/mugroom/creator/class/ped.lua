---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 01/09/2019 19:40
---

local ScaleformBoard = {}

onCreatorTick = {
    Tick = true,
    Scaleform = false,
    FaceTurnEnabled = false,
    LightRemote = false
}

local prop_id_board = GetHashKey("prop_police_id_board")
local pedPos, overlayModel = nil, GetHashKey("prop_police_id_text")
local board = nil
local overlay = nil

local function func_1532()
    return vector3(404.834, -997.838, -98.841)
end

local function func_1531()
    return vector3(0, 0, -38)
end

local function GetDictionary()
    if (GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01")) then
        return "mp_character_creation@customise@male_a"
    else
        return "mp_character_creation@customise@female_a"
    end
end

local _Substring, _FooterString, _Rank = nil
function AttachBoardToEntity(Entity, HeaderString, Substring, FooterString, Rank)
    prop_id_board = GetHashKey("prop_police_id_board")
    pedPos, overlayModel = GetEntityCoords(Entity), GetHashKey("prop_police_id_text")
    board = Ora.World.Object:Create(prop_id_board, pedPos, false, true, false)
    overlay = Ora.World.Object:Create(overlayModel, pedPos, false, true, false)
    _Substring = Substring
    _FooterString = FooterString
    _Rank = Rank
    AttachEntityToEntity(overlay, board, -1, 4103, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(prop_id_board)
    SetModelAsNoLongerNeeded(overlayModel)
    AttachEntityToEntity(board, Entity, GetPedBoneIndex(Entity, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
    local handleName = "ID_Text"
    table.insert(
        ScaleformBoard,
        {
            handleName = handleName,
            overlayModel = overlayModel,
            obj = {board, overlay},
            handle = CreateNamedRenderTargetForModel(handleName, overlayModel),
            scaleform = createScaleform(
                "mugshot_board_01",
                {
                    {
                        name = "SET_BOARD",
                        param = {
                            HeaderString,
                            Substring,
                            FooterString,
                            "",
                            0,
                            Rank,
                            116
                        }
                    }
                }
            )
        }
    )
    onCreatorTick.Scaleform = true
end

function BoardToEntity(Entity)
    AttachEntityToEntity(overlay, board, -1, 4103, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(prop_id_board)
    SetModelAsNoLongerNeeded(overlayModel)
    AttachEntityToEntity(board, Entity, GetPedBoneIndex(Entity, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
end

function WalkToRoom()
    AttachBoardToEntity(
        PlayerPedId(),
        "Nouveau personnage",
        math.random(10 * 1000000000, 10 * 1000000000),
        "LOS SANTOS POLICE DEPT",
        math.random(1, 99)
    )
    local _, sequence = OpenSequenceTask(0)
    TaskPlayAnimAdvanced(0, GetDictionary(), "Intro", func_1532(), func_1531(), 8.0, -8.0, -1, 4608, 0, 2, 0)
    TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -4.0, -1, 513, 0, 0, 0, 0)
    CloseSequenceTask(sequence)
    TaskPerformSequence(PlayerPedId(), sequence)
    FreezeEntityPosition(PlayerPedId(), false)
end

local function GetRandomOutro(iVar0)
    local hash = {"outro", "outro_b", "outro_c", "outro_d"}
    return hash[iVar0]
end

local function GetRandomOutroLoop(iVar0)
    local hash = {"outro_loop", "outro_loop_b", "outro_loop_c", "outro_loop_d"}
    return hash[iVar0]
end

function TakePictureAndExit()
    ScaleformBoard[1].scaleform =
        createScaleform(
        "mugshot_board_01",
        {
            {
                name = "SET_BOARD",
                param = {
                    GetRPName(),
                    _Substring,
                    _FooterString,
                    "",
                    0,
                    _Rank,
                    116
                }
            }
        }
    )
    local random = math.random(4)
    local _, sequence = OpenSequenceTask(0)
    TaskPlayAnim(0, GetDictionary(), GetRandomOutro(random), 8.0, -4.0, -1, 512, 0, 0, 0, 0)
    TaskPlayAnim(0, GetDictionary(), GetRandomOutroLoop(random), 8.0, -4.0, -1, 513, 0, 0, 0, 0)
    CloseSequenceTask(sequence)
    TaskPerformSequence(PlayerPedId(), sequence)
    FreezeEntityPosition(PlayerPedId(), false)
    CloseCreatorMenu()
    Citizen.Wait(2000)

    exports["screenshot-basic"]:requestScreenshotUpload(
        "http://pictures.orarp.fr/index.php",
        "creation",
        function(data)
            --print(data)
            local resp = json.decode(data)
            print(json.encode(resp))
            TriggerServerEvent("identity:editPic2", resp.url)
        end
    )
    CreatorTakePictureIn(GetCreatorCam())
end
-- exports['screenshot-basic']:requestScreenshotUpload("https://fiveshopm.com/shop/up/uploads2.php", "files", function(data)
--     print(data)
-- end)
function LoopInRoom()
    ClearPedTasksImmediately(PlayerPedId())
    TaskPlayAnim(PlayerPedId(), GetDictionary(), "Loop", 8.0, -4.0, -1, 513, 0, 0, 0, 0)
    TaskClearLookAt(PlayerPedId())
end

function CreatorUpdateModelAnim()
    --UpdateBoardToEntity(PlayerPedId())
    local _, sequence = OpenSequenceTask(0)
    TaskPlayAnim(0, GetDictionary(), "loop", 4.0, -4.0, -1, 513, 0, 0, 0, 0)
    CloseSequenceTask(sequence)
    TaskPerformSequence(PlayerPedId(), sequence)
    ClearSequenceTask(sequence)
end

--- Update Clothes
function OnSelectedClothes()
    local uParam0 = PlayerPedId()
    local sVar0 = GetDictionary()
    local anim = {
        [1] = "DROP_CLOTHES_A",
        [2] = "DROP_CLOTHES_B",
        [3] = "DROP_CLOTHES_C"
    }
    local random = math.random(0, 4)
    local _, sequence = OpenSequenceTask(1)
    TaskPlayAnim(0, sVar0, anim[random], 8.0, -8.0, -1, 512, 0, 0, 0, 0)
    TaskPlayAnim(0, sVar0, "DROP_LOOP", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
    CloseSequenceTask(sequence)
    TaskPerformSequence(uParam0, sequence)
    ClearSequenceTask(sequence)
end

function isPlayingAnimSelectedClothes(Entity)
    if
        IsEntityPlayingAnim(Entity, GetDictionary(), "DROP_CLOTHES_A", 3) or
            IsEntityPlayingAnim(Entity, GetDictionary(), "DROP_CLOTHES_B", 3) or
            IsEntityPlayingAnim(Entity, GetDictionary(), "DROP_CLOTHES_C", 3) or
            IsEntityPlayingAnim(Entity, GetDictionary(), "drop_intro", 3)
     then
        return true
    else
        return false
    end
end

function OnClothesOpen()
    local uParam0 = PlayerPedId()
    local _, sequence = OpenSequenceTask(1)
    TaskPlayAnim(0, GetDictionary(), "drop_intro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
    TaskPlayAnim(0, GetDictionary(), "drop_loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
    CloseSequenceTask(sequence)
    TaskPerformSequence(uParam0, sequence)
    ClearSequenceTask(sequence)
end

function OnClothesClose()
    local uParam0 = PlayerPedId()
    if (IsEntityPlayingAnim(uParam0, GetDictionary(), "DROP_LOOP", 3)) then
        local _, sequence = OpenSequenceTask(1)
        TaskPlayAnim(0, GetDictionary(), "DROP_OUTRO", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
        TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
        CloseSequenceTask(sequence)
        TaskPerformSequence(uParam0, sequence)
        ClearSequenceTask(sequence)
    end
end

--- Turn face Left
function func_1513(Entity, Stats)
    local sVar1 = GetDictionary()
    local _, sequence
    if (Stats) then
        if
            (IsEntityPlayingAnim(Entity, sVar1, "Profile_L_Intro", 3)) and
                not (IsEntityPlayingAnim(Entity, sVar1, "Profile_L_Loop", 3))
         then
            if (GetEntityAnimCurrentTime(Entity, sVar1, "Profile_L_Intro") >= 0.4) then
                _, sequence = OpenSequenceTask(0)
                TaskPlayAnim(0, GetDictionary(), "Profile_L_Outro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
                TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
                CloseSequenceTask(sequence)
            else
                return 0
            end
        elseif
            (IsEntityPlayingAnim(Entity, sVar1, "Profile_L_Loop", 3)) and
                not (IsEntityPlayingAnim(Entity, sVar1, "Profile_L_Intro", 3))
         then
            _, sequence = OpenSequenceTask(0)
            TaskPlayAnim(0, GetDictionary(), "Profile_L_Outro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
            TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
            CloseSequenceTask(sequence)
        end
    else
        _, sequence = OpenSequenceTask(0)
        TaskPlayAnim(0, GetDictionary(), "Profile_L_Intro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
        TaskPlayAnim(0, GetDictionary(), "Profile_L_Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
        CloseSequenceTask(sequence)
    end
    TaskPerformSequence(PlayerPedId(), sequence)
    ClearSequenceTask(sequence)
    return 1
end

--- Turn face Right
function func_1514(Entity, Stats)
    local sVar1 = GetDictionary()
    local _, sequence
    if (Stats) then
        if
            (IsEntityPlayingAnim(Entity, sVar1, "Profile_R_Intro", 3)) and
                not (IsEntityPlayingAnim(Entity, sVar1, "Profile_R_Loop", 3))
         then
            if (GetEntityAnimCurrentTime(Entity, sVar1, "Profile_R_Intro") >= 0.4) then
                _, sequence = OpenSequenceTask(0)
                TaskPlayAnim(0, GetDictionary(), "Profile_R_Outro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
                TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
                CloseSequenceTask(sequence)
            else
                return 0
            end
        elseif
            (IsEntityPlayingAnim(Entity, sVar1, "Profile_R_Loop", 3)) and
                not (IsEntityPlayingAnim(Entity, sVar1, "Profile_R_Intro", 3))
         then
            _, sequence = OpenSequenceTask(0)
            TaskPlayAnim(0, GetDictionary(), "Profile_R_Outro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
            TaskPlayAnim(0, GetDictionary(), "Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
            CloseSequenceTask(sequence)
        end
    else
        _, sequence = OpenSequenceTask(0)
        TaskPlayAnim(0, GetDictionary(), "Profile_R_Intro", 8.0, -8.0, -1, 512, 0, 0, 0, 0)
        TaskPlayAnim(0, GetDictionary(), "Profile_R_Loop", 8.0, -8.0, -1, 513, 0, 0, 0, 0)
        CloseSequenceTask(sequence)
    end
    TaskPerformSequence(PlayerPedId(), sequence)
    ClearSequenceTask(sequence)
    return 1
end

function OnRenderCreatorScaleform()
    HideHudAndRadarThisFrame()
    for k, v in pairs(ScaleformBoard) do
        SetTextRenderId(ScaleformBoard[k].handle)
        SetScriptGfxDrawOrder(4)
        Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
        DrawScaleformMovie(ScaleformBoard[k].scaleform, 0.405, 0.37, 0.81, 0.74, 255, 255, 255, 255, 0)
        Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
    end
end

function CreatorRequestAssets()
    local animsToLoad = {
        "mp_character_creation@customise@male_a",
        "mp_character_creation@customise@female_a"
    }
    for _, v in pairs(animsToLoad) do
        RequestAnimDict(v)
        while not HasAnimDictLoaded(v) do
            Citizen.Wait(1)
            RequestAnimDict(v)
        end
    end
    RequestScriptAudioBank("DLC_GTAO/MUGSHOT_ROOM", false, -1)
    RequestScriptAudioBank("Mugshot_Character_Creator", false, -1)
end

function CreatorDeleteAssets()
    local animsToUnLoad = {
        "mp_character_creation@customise@male_a",
        "mp_character_creation@customise@female_a"
    }
    for _, v in pairs(animsToUnLoad) do
        RemoveAnimDict(v)
    end
    for k, v in pairs(ScaleformBoard) do
        DeleteObject(v.obj[1])
        DeleteObject(v.obj[2])
    end

    onCreatorTick.Scaleform = false
    onCreatorTick.LightRemote = false
    onCreatorTick.FaceTurnEnabled = false
    onCreatorTick.Tick = false

    local interiorID = GetInteriorAtCoordsWithType(vector3(399.9, -998.7, -100.0), "v_mugshot")

    UnpinInterior(interiorID)

    local ped = LocalPlayer().Ped
    SetEntityVisible(ped, 1, 1)
    SetEntityInvincible(ped, 0)
    FreezeEntityPosition(ped, 0)
    --RMenu:Delete('mugshot', 'creator')

    RequestScriptAudioBank("DLC_GTAO/MUGSHOT_ROOM", false, -1)
    RequestScriptAudioBank("Mugshot_Character_Creator", false, -1)
end
