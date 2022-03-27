--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================

local myPedId = nil

local phoneProp = 0
local phoneModel = "prop_amb_phone"
-- OR "prop_npc_phone"
-- OR "prop_npc_phone_02"
-- OR "prop_cs_phone_01"

local currentStatus = "out"
local lastDict = nil
local lastAnim = nil
local lastIsFreeze = false

local ANIMS = {
    ["cellphone@"] = {
        ["out"] = {
            ["text"] = "cellphone_text_in",
            ["call"] = "cellphone_call_listen_base"
        },
        ["text"] = {
            ["out"] = "cellphone_text_out",
            ["text"] = "cellphone_text_in",
            ["call"] = "cellphone_text_to_call"
        },
        ["call"] = {
            ["out"] = "cellphone_call_out",
            ["text"] = "cellphone_call_to_text",
            ["call"] = "cellphone_text_to_call"
        }
    },
    ["anim@cellphone@in_car@ps"] = {
        ["out"] = {
            ["text"] = "cellphone_text_in",
            ["call"] = "cellphone_call_in"
        },
        ["text"] = {
            ["out"] = "cellphone_text_out",
            ["text"] = "cellphone_text_in",
            ["call"] = "cellphone_text_to_call"
        },
        ["call"] = {
            ["out"] = "cellphone_horizontal_exit",
            ["text"] = "cellphone_call_to_text",
            ["call"] = "cellphone_text_to_call"
        }
    }
}

function newPhoneProp()
    deletePhone()
    local modelHash = GetHashKey(phoneModel)
    if modelHash and IsModelInCdimage(modelHash) and not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do Citizen.Wait(100) end
    end

    exports["Ora"]:TriggerServerCallback("Ora::SE::Anticheat:RegisterObject", 
        function()
            local ped = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(ped))
            phoneProp = CreateObject(modelHash, x, y, z + 0.2, true, true, true)
            local bone = GetPedBoneIndex(ped, 28422)
            AttachEntityToEntity(phoneProp, ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
        end,
        modelHash
    )
end

function deletePhone()
    if phoneProp ~= 0 then
        Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(phoneProp))
        phoneProp = 0
    end
end

--[[
	out || text || Call ||
--]]
function PhonePlayAnim(status, freeze, force)
    if currentStatus == status and force ~= true then
        return
    end

    myPedId = PlayerPedId()
    local freeze = freeze or false

    local dict = "cellphone@"
    if IsPedInAnyVehicle(myPedId, false) then
        dict = "anim@cellphone@in_car@ps"
    end
    loadAnimDict(dict)

    local anim = ANIMS[dict][currentStatus][status]
    if currentStatus ~= "out" then
        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
    end
    local flag = 50
    if freeze == true then
        flag = 14
    end
    TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)

    if status ~= "out" and currentStatus == "out" then
        Citizen.Wait(380)
        newPhoneProp()
    end

    lastDict = dict
    lastAnim = anim
    lastIsFreeze = freeze
    currentStatus = status

    if status == "out" then
        Citizen.Wait(180)
        deletePhone()
        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
    end
end

function PhonePlayOut()
    PhonePlayAnim("out")
end

function PhonePlayText()
    PhonePlayAnim("text")
end

function PhonePlayCall(freeze)
    PhonePlayAnim("call", freeze)
end

function PhonePlayIn()
    if currentStatus == "out" then
        PhonePlayText()
    end
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
end

-- Citizen.CreateThread(function ()
-- 	Citizen.Wait(200)
-- 	PhonePlayCall()
-- 	Citizen.Wait(2000)
-- 	PhonePlayOut()
-- 	Citizen.Wait(2000)

-- 	PhonePlayText()
-- 	Citizen.Wait(2000)
-- 	PhonePlayCall()
-- 	Citizen.Wait(2000)
-- 	PhonePlayOut()
-- end)
