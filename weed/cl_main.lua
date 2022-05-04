local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}
local current = {}
local currentID = {}
local weedsLoaded = false

TriggerServerEvent("getWeeds")

SpawnObject = function(model, coords, cb)
    local model = (type(model) == "number" and model or GetHashKey(model))

    Citizen.CreateThread(
        function()
            RequestModel(model)

            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end

            exports["Ora"]:TriggerServerCallback("Ora::SE::Anticheat:RegisterObject", 
                function()
                    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, true, false)

                    --SetEntityCollision(obj, false, true)
                    FreezeEntityPosition(obj, true)
                    if cb ~= nil then
                        cb(obj)
                    end
                end,
                model
            )
           
        end
    )
end

function DrawText3DTest(coords, text, size)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.25, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 950
    DrawRect(_x, _y + 0.0675, 0.01 + factor, 0.16, 11, 11, 11, 150)
end

function createProps()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local forward = GetEntityForwardVector(ped)
    local x, y, z = table.unpack(coords + forward)
    local coords = {x = x, y = y, z = z - 1.0}
    randPickupAnim()
    Wait(700)
    TriggerServerEvent("createWeed", coords)
end
exports("createProps", createProps)
function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end
function randPickupAnim()
    local randAnim = math.random(7)
    loadAnimDict("random@domestic")
    TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
end

function holdAnim()
    loadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim((PlayerPedId()), "anim@heists@box_carry@", "idle", 4.0, 1.0, -1, 49, 0, 0, 0, 0)
end

local weeds = {}
local states = {
    "bkr_prop_weed_01_small_01c",
    "bkr_prop_weed_01_small_01b",
    "bkr_prop_weed_med_01a",
    "bkr_prop_weed_lrg_01a"
}
local carryingItem = {}
local carrying = false
local carryingProps = nil
local props = {}
RegisterNetEvent("createWeed")
AddEventHandler(
    "createWeed",
    function(c, k)
        props5 = SpawnObject("bkr_prop_weed_01_small_01c",c,function(props)
           --(props)
           FreezeEntityPosition(props, true)
           SetEntityNoCollisionEntity(props, PlayerPedId(), false)

        weeds[k] = {obj = nil, coords = c, states = 1, water = 10, purety = 50, percent = 0, fertz = 0}
        end)
    end
)

RegisterNetEvent("weedsARE")
AddEventHandler(
    "weedsARE",
    function(_weeds)
        weeds = _weeds
        weedsLoaded = true
    end
)
AddEventHandler(
    "playerSpawned",
    function()
        TriggerServerEvent("getWeeds")
    end
)

RegisterNetEvent("createWeed2")
AddEventHandler(
    "createWeed2",
    function(t, k, c)
        weeds[k] = {
            obj = nil,
            coords = t,
            states = c.states,
            water = c.water,
            purety = c.purety,
            percent = c.percent,
            fertz = c.fertz
        }
        SpawnObject(states[c.states],t,function(props)
            --(props)
            FreezeEntityPosition(props, true)
            SetEntityNoCollisionEntity(props, PlayerPedId(), false)
            weeds[k] = {obj=props,coords=GetEntityCoords(props),states=c.states,water=c.water,purety=c.purety,percent=c.percent,fertz=c.fertz}
        end)
    end
)
local inNUI = false
RegisterNUICallback(
    "exit",
    function(data)
        SetNuiFocus(0, 0)
        inNUI = false
        SendNUIMessage({action = "hide", data = v})
    end
)

RegisterNUICallback(
    "waterize",
    function()
        current.water = current.water + math.random(14, 25)
        local v = current
        SendNUIMessage({action = "data", data = {water = v.water, percent = v.percent, fertz = v.fertz}})
        exports["Ora"]:RemoveFirstItem("water")
        TriggerServerEvent("editWeed", currentID, current)
    end
)

RegisterNUICallback(
    "harvest",
    function()
        for i = 1, math.random(10, 28), 1 do
            items = {name = "weed_plant", data = {purety = current.purety, price = 0}}
            exports["Ora"]:AddItem(items)
        end
        SetNuiFocus(0, 0)
        inNUI = false
        SendNUIMessage({action = "hide", data = v})
        current = {
            obj = nil,
            coords = current.coords,
            states = 1,
            water = current.water,
            purety = current.purety,
            percent = 0,
            fertz = current.fertz
        }
        DeleteEntity(current.obj)
        TriggerServerEvent("editWeed", currentID, current)
    end
)

RegisterNUICallback(
    "purifizer",
    function()
        current.fertz = current.fertz + math.random(5, 10)
        local v = current
        SendNUIMessage({action = "data", data = {water = v.water, percent = v.percent, fertz = v.fertz}})
        exports["Ora"]:RemoveFirstItem("fertz")

        TriggerServerEvent("editWeed", currentID, current)
    end
)

RegisterNetEvent("editWeed")
AddEventHandler(
    "editWeed",
    function(k, v)
        weeds[k].states = v.states
        weeds[k].water = v.water
        weeds[k].percent = v.percent
        weeds[k].fertz = v.fertz
        if v.percent >= 88 then
            weeds[k].states = 4
        elseif v.percent >= 66 then
            weeds[k].states = 3
        elseif v.percent >= 33 then
            weeds[k].states = 2
        end
        DeleteEntity(weeds[k].obj)
        SpawnObject(states[weeds[k].states],weeds[k].coords,function(props)
            --(props)
            FreezeEntityPosition(props, true)
            SetEntityNoCollisionEntity(props, PlayerPedId(), false)
            weeds[k].obj = props
        end)
    end
)
RegisterNetEvent("water+percentEdit")
AddEventHandler(
    "water+percentEdit",
    function(k, percent, water)
        if weeds[k] == nil then
            return
        end
        weeds[k].water = water
        weeds[k].percent = percent
        if percent >= 88 then
            weeds[k].states = 4
        elseif percent >= 66 then
            weeds[k].states = 3
        elseif percent >= 33 then
            weeds[k].states = 2
        end

        if weeds[k] == nil then error(k) end
        DeleteEntity(weeds[k].obj)
        if weeds[k] == nil then return end
        SpawnObject(states[weeds[k].states],weeds[k].coords,function(props)
            weeds[k].obj = props
            --(props)
            FreezeEntityPosition(props, true)
            SetEntityNoCollisionEntity(props, PlayerPedId(), false)

        end)
    end
)

local x1, y1, z1
function tableCount(tbl, checkCount)
    if not tbl or type(tbl) ~= "table" then
        return not checkCount and 0
    end
    local n = 0
    for k, v in pairs(tbl) do
        n = n + 1
        if checkCount and n >= checkCount then
            return true
        end
    end
    return not checkCount and n
end
local _props = {}
Citizen.CreateThread(
    function()
        SetNuiFocus(0, 0)
        for k, v in pairs(states) do
            Citizen.CreateThread(
                function()
                    RequestModel(v)

                    while not HasModelLoaded(v) do
                        Citizen.Wait(0)
                    end
                end
            )
        end

        while weedsLoaded == false do
            Wait(10)
            print("^7Waiting for Weed to load^0")
        end

        while true do
            Wait(7)
            for k, v in pairs(states) do
                if not HasModelLoaded(v) then
                    RequestModel(v)
                end
            end
            for k, v in pairs(weeds) do
                if type(v.coords) == "vector3" then
                    x1, y1, z1 = table.unpack(GetEntityCoords(v.obj))
                else
                    x1, y1, z1 = v.coords.x, v.coords.y, v.coords.z
                end
                if v.obj ~= nil then
                    ClearAreaOfObjects(x1,y1,z1,  0.1, 0)
                    for i = 1, 2, 1 do
                        ClearAreaOfObjects(x1, y1, z1 + i, 0.2, 0)
                        ClearAreaOfObjects(x1, y1, z1 - i, 0.2, 0)
                    end
                    SetEntityCoords(v.obj, v.coords.x, v.coords.y, v.coords.z)
                    if GetHashKey(states[v.states]) ~= GetEntityModel(v.obj) then
                        local coords = GetEntityCoords(v.obj)
                        local x, y, z = table.unpack(coords)
                        coords = {x = x, y = y, z = z}

                        DeleteEntity(v.obj)

                        SpawnObject(
                            states[v.states],
                            coords,
                            function(props)
                                v.obj = props
                                --(props)
                                FreezeEntityPosition(props, true)
                                SetEntityNoCollisionEntity(props, PlayerPedId(), false)
                            end
                        )
                    end
                end

                local x2, y2, z2 = table.unpack(GetEntityCoords(PlayerPedId()))

                if
                    GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, false) < 100.0 and v.obj == nil or
                        GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, false) < 20.0 and v.obj == 0
                 then
                    ClearAreaOfObjects(x1, y1, z1, 0.1, 0)

                    SpawnObject(
                        states[v.states],
                        v.coords,
                        function(props)
                            v.obj = props
                            --(props)
                            FreezeEntityPosition(props, true)
                            SetEntityNoCollisionEntity(props, PlayerPedId(), false)
                        end
                    )
                elseif GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, false) > 100.0 then
                    DeleteEntity(v.obj)
                    v.obj = nil
                end
                if GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, false) < 0.85 then
                    DrawText3DTest(
                        v.coords,
                        "~g~Cannabis\n~s~♻️ : ~b~" ..
                            v.percent .. "~s~%\n💧 : ~b~" .. v.water .. "~s~%\n~y~[L] 💡\n[~r~X~s~] ❌",
                        1.0
                    )
                    if IsControlJustPressed(0, Keys["U"]) then
                        randPickupAnim()
                        Wait(750)
                        holdAnim()
                        local player = PlayerPedId()
                        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                        local _props = states[v.states]
                        local model = (type(_props) == 'number' and _props or GetHashKey(_props))
                        obX = CreateObject(model, GetEntityCoords(PlayerPedId()),  true,  true, true)
                        AttachEntityToEntity(obX, player, GetPedBoneIndex(player, 60309), 0.025, 0.08, 0.255, -045.0, 290.0, 0.0, true, true, false, true, 1, true)
                        carryingItem = v
                        carrying = true
                        carryingProps = obX
                        TriggerServerEvent("removeWeed", k)
                    end
                    if IsControlJustPressed(0, Keys["L"]) then
                        SendNUIMessage(
                            {
                                action = "showUI",
                                data = {water = v.water, percent = v.percent, fertz = v.fertz},
                                items = {
                                    water = exports["Ora"]:GetItemCount("water"),
                                    fertz = exports["Ora"]:GetItemCount("fertz")
                                }
                            }
                        )
                        SetNuiFocus(1, 1)
                        current = v
                        currentID = k
                        inNUI = true
                        while inNUI do
                            Wait(1)
                        end
                    end
                    if IsControlJustPressed(0, Keys["X"]) then
                        TriggerServerEvent("removeWeed", k)
                    end
                end
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function()
        for k, v in pairs(weeds) do
            DeleteEntity(v.obj)
        end
    end
)

RegisterNetEvent("removeWeed")
AddEventHandler(
    "removeWeed",
    function(k, props5)
        if currentID == k and inNUI then
            SetNuiFocus(0, 0)
            inNUI = false
            SendNUIMessage({action = "hide", data = v})
        end
        weeds[k].obj = props
        DeleteEntity(props5)
        exports["Ora"]:AddItem("weed_pot")
        weeds[k] = nil
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            if carrying then
                SetTextComponentFormat("STRING")
                AddTextComponentString("Appuyez sur ~INPUT_DETONATE~ pour déposer l'objet")
                DisplayHelpTextFromStringLabel(0, 0, 0, -1)
                DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
                DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
                DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
                DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
                DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
                DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
                DisableControlAction(0, 257, true) -- INPUT_ATTACK2
                DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
                DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
                DisableControlAction(0, 24, true) -- INPUT_ATTACK
                DisableControlAction(0, 25, true) -- INPUT_AIM
                DisableControlAction(0, 21, true) -- SHIFT
                DisableControlAction(0, 22, true) -- SPACE
                DisableControlAction(0, 288, true) -- F1
                DisableControlAction(0, 289, true) -- F2
                DisableControlAction(0, 170, true) -- F3
                DisableControlAction(0, 167, true) -- F6
                DisableControlAction(0, 168, true) -- F7
                DisableControlAction(0, 57, true) -- F10
                DisableControlAction(0, 37, true) -- M
                DisableControlAction(0, 0, true) -- v
                DisableControlAction(0, 26, true) -- c

                DisableControlAction(0, 47, true) -- c
                DisableControlAction(0, 82, true) -- c

                if IsDisabledControlJustPressed(0, Keys["G"]) then
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)
                    local forward = GetEntityForwardVector(ped)
                    local x, y, z = table.unpack(coords + forward)
                    local coords = {
                        x = x,
                        y = y,
                        z = z - 1.0
                    }
                    DeleteEntity(carryingProps)
                    randPickupAnim()
                    Wait(700)
                    carrying = false
                    print("CREATE WEED 2")
                    TriggerServerEvent("createWeed2", coords, carryingItem)
                    carryingItem = {}
                    ClearPedTasks(ped)
                end
            end
        end
    end
)
