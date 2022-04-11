local SelectedItem = nil
local blocNote = true
function ClosestVeh()
    if GetEntityType(vehicleFct.GetVehicleInDirection()) == 2 then
        return vehicleFct.GetVehicleInDirection()
    else
        return getVehInSight()
    end
end

function getVehInSight()
    local ent = getEntInSight()
    if not IsEntityAVehicle(ent) then
        return
    end
    return ent
end

function getEntInSight()
    local ped = LocalPlayer().Ped
    local pos = GetEntityCoords(ped) + vector3(.0, .0, -.4)
    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0) + vector3(.0, .0, -.4)
    local rayHandle = CastRayPointToPoint(pos, entityWorld, 10, ped, 0)
    local _, _, _, _, ent = GetRaycastResult(rayHandle)
    return ent
end
local defaulClothestvalue = {
    male = {
        [8] = 15,
        [3] = 15,
        [11] = 15,
        [6] = 34,
        [4] = 21
    },
    female = {
        [8] = 15,
        [3] = 15,
        [11] = 15,
        [6] = 35,
        [4] = 14
    }
}

local function kevIsUnbreakable(index)
    local kevInd = {
        54,
        53,
        52,
        43,
        42,
        41,
        40,
        39,
        38,
        35,
        28,
        24,
        23,
        22
    }
    for _, v in ipairs(kevInd) do
        if v == index then
            return true
        end
    end
    return false
end

local kevEquiped = nil
local isKevEquiped = false
function EquipKev()
    local ped = LocalPlayer().Ped
    isKevEquiped = not isKevEquiped
    if isKevEquiped then
        if kevEquiped ~= nil then
            SetPedComponentVariation(ped, 9, kevEquiped.data.ind, kevEquiped.data.var, 2)
            SetPedArmour(LocalPlayer().Ped, kevEquiped.data.status)
            TriggerEvent('Ora:InvNotification', 'Kevlar équipé !')
        else
            isKevEquiped = false
            SetPedArmour(LocalPlayer().Ped, 0)
            SetPedComponentVariation(ped, 9, 1, 5)
            TriggerEvent('Ora:InvNotification', 'Kevlar retiré !')
        end
    else
        kevEquiped = nil
        SetPedArmour(LocalPlayer().Ped, 0)
        SetPedComponentVariation(ped, 9, 1, 5)
        TriggerEvent('Ora:InvNotification', 'Kevlar retiré !')
    end
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(750)
        if isKevEquiped and kevEquiped ~= nil and not kevIsUnbreakable(kevEquiped.data.ind) then
            kevEquiped.data.status = GetPedArmour(Player.Ped)
            if kevEquiped.data.status == 0 then
                Ora.Inventory:RemoveItem(kevEquiped)
                EquipKev()
                --SetPedToRagdoll(Player.Ped, 1000, 1000, 0, 0, 0, 0)
                RageUI.Popup({message = '~r~Kevlar cassé !~s~'})
            end
        end
    end
end)
function EquipTenue()
    Citizen.CreateThread(
        function()
            local item = SelectedItem
            local data = item.data
            local ped = LocalPlayer().Ped
            if data.equiped then
                local male = Ora.World.Ped:IsPedMale(LocalPlayer().Ped)
                if not male then
                    SetPedComponentVariation(ped, 8, 15, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 11, 15, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 3, 15, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 4, 14, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 6, 35, 0, 2)

                    Wait(700)
                    SetPedComponentVariation(ped, 8, 15, 0, 2)
                    SetPedComponentVariation(ped, 10, 0, 0)
                    Wait(700)
                    SetPedComponentVariation(ped, 7, 0, 0)
                    Wait(700)
                    SetPedComponentVariation(ped, 5, 0, 0)
                    Wait(700)
                    ClearPedProp(ped, 1)
                    Wait(700)
                    ClearPedProp(ped, 0)
                    SetPedComponentVariation(ped, 1, 0, 0)
                else
                    SetPedComponentVariation(ped, 6, 34, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 4, 21, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 11, 15, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 3, 15, 0)
                    Wait(700)
                    SetPedComponentVariation(ped, 8, 15, 0, 2)
                    SetPedComponentVariation(ped, 10, 0, 0)
                    Wait(700)
                    SetPedComponentVariation(ped, 7, 0, 0)
                    Wait(700)
                    SetPedComponentVariation(ped, 5, 0, 0)
                    Wait(700)
                    ClearPedProp(ped, 1)
                    Wait(700)
                    ClearPedProp(ped, 0)
                    SetPedComponentVariation(ped, 1, 0, 0)
                end
            else
                SetPedComponentVariation(ped, 3, data.torso, data.torsocolor)
                Wait(700)
                SetPedComponentVariation(ped, 4, data.pant, data.pantcolor)
                Wait(700)
                SetPedComponentVariation(ped, 6, data.chaus, data.chausscolor)
                Wait(700)
                SetPedComponentVariation(ped, 11, data.tops, data.topcolor)
                Wait(700)
                SetPedComponentVariation(ped, 3, data.torso, data.torsocolor)
                Wait(700)
                SetPedComponentVariation(ped, 7, data.access, data.accesscolor)
                Wait(700)
                SetPedComponentVariation(ped, 8, data.unders, data.underscolor)
                Wait(700)
                SetPedComponentVariation(ped, 10, data.decals, data.decalscolor)
                Wait(700)
                if data.chain ~= nil then
                    SetPedComponentVariation(ped, 7, data.chain, data.chaincolor)
                end
                Wait(700)
                if data.bags ~= nil then
                    SetPedComponentVariation(ped, 5, data.bags, data.bagscolor)
                end
                Wait(700)
                if data.glasses ~= nil then
                    SetPedPropIndex(ped, 1, data.glasses, data.glassescolor)
                end
                Wait(700)
                if data.hat ~= nil then
                    SetPedPropIndex(ped, 0, data.hat, data.hatcolor)
                end
                if data.mask_1 ~= nil then
                    SetPedComponentVariation(ped, 1, data.mask, data.maskcolor)
                end
            end

            item.data.equiped = not item.data.equiped
        end
    )
    local anim = {}
    if Ora.World.Ped:IsPedMale(LocalPlayer().Ped) then
        anim = {
            animDict = "clothingshirt",
            anim = "try_shirt_positive_d",
            flags = 1
        }
    else
        anim = {
            animDict = "mp_clothing@female@shirt",
            anim = "try_shirt_neutral_a",
            flags = 1
        }
    end
    exports["mythic_progbar"]:Progress(
        {
            name = "unique_tenue",
            duration = 7000,
            label = "Vous vous changez",
            useWhileDead = true,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            },
            animation = anim
        },
        function(cancelled)
            if not cancelled then
                ClearPedTasks(LocalPlayer().Ped)
            end
        end
    )
    Wait(7000)
end
visor = false
local sac = nil
function EquipClothes()
    local item = SelectedItem
    local male = Ora.World.Ped:IsPedMale(LocalPlayer().Ped)

    if male then
        if item.data.component == 5 then
            if sac ~= nil then sac = nil else sac = item end
        end
        if item.data.component == 0 then
            visor = false
        end
        if item.data.type == 0 then
            if item.data.equiped and item.data.sex == "male" then
                if item.data.component == 11 then
                end
            else
            end
            item.data.equiped = not item.data.equiped
        else
            if item.data.equiped and item.data.sex == "male" then
                ClearPedProp(LocalPlayer().Ped, item.data.component)
            else
                SetPedPropIndex(LocalPlayer().Ped, item.data.component, item.data.var, item.data.ind)
            end
            item.data.equiped = not item.data.equiped
        end
    else
        if item.data.type == 0 then
            if item.data.equiped and item.data.sex == "female" then
            else
            end
            item.data.equiped = not item.data.equiped
        else
            if item.data.equiped and item.data.sex == "female" then
                ClearPedProp(LocalPlayer().Ped, item.data.component)
            else
                SetPedPropIndex(LocalPlayer().Ped, item.data.component, item.data.var, item.data.ind, 2)
            end
            item.data.equiped = not item.data.equiped
        end
    end

    for i = 1, #Ora.Inventory.Data[SelectedItem.name] do
        local p = Ora.Inventory.Data[SelectedItem.name][i]
        if p.data.component == SelectedItem.data.commponent then
            if p.id ~= SelectedItem.id then
                p.data.equiped = false
            end
        end
    end

    if item.data.type == 0 then
        RefreshClothes()
    end
end
local decorObject = nil

local removeHair = {
    [1] = true,
    [2] = true,
    [3] = true,
    [5] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [13] = true,
    [17] = true,
    [18] = true,
    [19] = true,
    [20] = true,
    [21] = true,
    [22] = true,
    [23] = true,
    [24] = true,
    [25] = true,
    [26] = true,
    [27] = true,
    [31] = true,
    [32] = true,
    [110] = true,
    [113] = true,
    [114] = true,
    [115] = true,
    [117] = true,
    [118] = true,
    [119] = true,
    [120] = true,
    [121] = true,
    [122] = true,
    [125] = true,
    [126] = true,
    [129] = true,
    [130] = true,
    [131] = true,
    [132] = true,
    [136] = true,
    [137] = true,
    [138] = true,
    [142] = true,
    [143] = true,
    [144] = true,
    [145] = true,
    [146] = true,
    [149] = true,
    [150] = true,
    [151] = true,
    [152] = true,
    [153] = true,
    [154] = true,
    [155] = true,
    [156] = true,
    [157] = true,
    [158] = true,
    [159] = true,
    [162] = true,
    [163] = true,
    [167] = true,
    [170] = true,
    [171] = true,
    [172] = true,
    [173] = true,
    [174] = true,
    [176] = true,
    [177] = true,
    [178] = true,
    [189] = true,

}

local doNotChangeFace = {
    [101] = true,
    [124] = true,
    [127] = true
}

function EquipMasks()
    local item = SelectedItem
    if item.data.equiped then
        -- Adding special treatment to remove holes in mask
        playerPed = LocalPlayer().Ped
        local dict = "missfbi4"
        local myPed = LocalPlayer().Ped

        TriggerServerCallback(
            "core:GetSKin2",
            function(skin, model)
                Citizen.CreateThread(
                    function()
                        local playerPed = LocalPlayer().Ped
                        skin = json.decode(skin)
                        if (skin ~= nil) then
                            if skin.face.face ~= nil then
                                --    SetPedHeadBlendData(Ped, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)
                                --  SetPedHeadBlendData(Ped, Table.face.face, Table.face.face, Table.face.face,Table.face.skin , Table.face.skin , Table.face.skin, 1.0,1.0, 0, false)
                                SetPedHeadBlendData(
                                    LocalPlayer().Ped,
                                    skin.face.face,
                                    skin.face.face,
                                    skin.face.face,
                                    skin.face.skin,
                                    skin.face.skin,
                                    skin.face.skin,
                                    1.0,
                                    1.0,
                                    1.0,
                                    true
                                )
                            else
                                SetPedHeadBlendData(
                                    LocalPlayer().Ped,
                                    skin.face.mom,
                                    skin.face.dad,
                                    0,
                                    skin.face.mom,
                                    skin.face.dad,
                                    0,
                                    skin.resemblance,
                                    skin.skinMix,
                                    0,
                                    false
                                )
                            end

                            SetPedFaceFeature(playerPed, 0, skin.facial.features.nose.width)
                            SetPedFaceFeature(playerPed, 1, skin.facial.features.nose.peak.height)
                            SetPedFaceFeature(playerPed, 2, skin.facial.features.nose.peak.length)
                            SetPedFaceFeature(playerPed, 3, skin.facial.features.nose.bone.height)
                            SetPedFaceFeature(playerPed, 4, skin.facial.features.nose.peak.lowering)
                            SetPedFaceFeature(playerPed, 5, skin.facial.features.nose.bone.twist)
                            SetPedFaceFeature(playerPed, 6, skin.facial.features.eyebrow.height)
                            SetPedFaceFeature(playerPed, 7, skin.facial.features.eyebrow.forward)
                            SetPedFaceFeature(playerPed, 8, skin.facial.features.cheeks.bone.height)
                            SetPedFaceFeature(playerPed, 9, skin.facial.features.cheeks.bone.width)
                            SetPedFaceFeature(playerPed, 10, skin.facial.features.cheeks.width)
                            SetPedFaceFeature(playerPed, 11, skin.facial.features.eye.opening)
                            SetPedFaceFeature(playerPed, 12, skin.facial.features.lips.thickness)
                            SetPedFaceFeature(playerPed, 13, skin.facial.features.jaw.bone.width)
                            SetPedFaceFeature(playerPed, 14, skin.facial.features.jaw.bone.backLength)
                            SetPedFaceFeature(playerPed, 15, skin.facial.features.chimp.bone.lowering)
                            SetPedFaceFeature(playerPed, 16, skin.facial.features.chimp.bone.length)
                            SetPedFaceFeature(playerPed, 17, skin.facial.features.chimp.bone.width)
                            SetPedFaceFeature(playerPed, 18, skin.facial.features.chimp.hole)
                            SetPedFaceFeature(playerPed, 19, skin.facial.features.neck.thickness)
                        end

                        Ora.Core:Debug(string.format("User is putting off mask ^5%s^3", item.data.var))
                        if (removeHair ~= nil and removeHair[item.data.var] ~= nil and removeHair[item.data.var] == true) then
                            local hairId = 0
                            SetPedComponentVariation(playerPed, 2, skin.hair.style, 0, 0)
                            SetPedHairColor(playerPed, skin.hair.color[1], skin.hair.color[2])
                        end

                        RequestAnimDict(dict)

                        while not HasAnimDictLoaded(dict) do
                            Citizen.Wait(0)
                        end

                        local animation = ""
                        local flags = 0
                        animation = "takeoff_mask"
                        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                        Citizen.Wait(1000)
                        SetEntityCollision(LocalPlayer().Ped, true, true)
                        playerPed = LocalPlayer().Ped
                        Citizen.Wait(200)
                        ClearPedTasks(playerPed)
                        SetPedComponentVariation(LocalPlayer().Ped, item.data.component, 0, 0)
                    end
                )
            end
        )
    else
        playerPed = LocalPlayer().Ped
        local dict = "missfbi4"
        local myPed = LocalPlayer().Ped
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end

        local animation = ""
        local flags = 0 -- only play the animation on the upper body
        animation = "takeoff_mask"

        -- Getting Skin back to set back the head

        if (doNotChangeFace ~= nil and doNotChangeFace[item.data.var] ~= nil and doNotChangeFace[item.data.var] == true) then
            Ora.Core:Debug(string.format("Aborting changing face for ^5%s^3", item.data.var))
            TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
            Citizen.Wait(1000)
            SetEntityCollision(LocalPlayer().Ped, true, true)
            playerPed = LocalPlayer().Ped
            Citizen.Wait(200)
            ClearPedTasks(playerPed)
            SetPedComponentVariation(LocalPlayer().Ped, item.data.component, item.data.var, item.data.ind) 
        else
                TriggerServerCallback(
                "core:GetSKin2",
                function(skin, model)
                    Citizen.CreateThread(
                        function()
                            local playerPed = LocalPlayer().Ped
                            skin = json.decode(skin)
                            TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                            Citizen.Wait(1000)
                            SetEntityCollision(LocalPlayer().Ped, true, true)
                            playerPed = LocalPlayer().Ped
                            Citizen.Wait(200)
                            ClearPedTasks(playerPed)
                            SetPedComponentVariation(
                                LocalPlayer().Ped,
                                item.data.component,
                                item.data.var,
                                item.data.ind
                            )
                            if (skin ~= nil) then

                                if skin.face.face ~= nil then
                                    --    SetPedHeadBlendData(Ped, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)
                                    --  SetPedHeadBlendData(Ped, Table.face.face, Table.face.face, Table.face.face,Table.face.skin , Table.face.skin , Table.face.skin, 1.0,1.0, 0, false)
                                    local faceId = 0
                                    if (GetEntityModel(LocalPlayer().Ped) == GetHashKey("mp_f_freemode_01")) then
                                        faceId = 21
                                    end
    
                                    SetPedHeadBlendData(
                                        LocalPlayer().Ped,
                                        faceId,
                                        faceId,
                                        faceId,
                                        skin.face.skin,
                                        skin.face.skin,
                                        skin.face.skin,
                                        1.0,
                                        1.0,
                                        1.0,
                                        true
                                    )
                                else
                                    local faceId = 0
                                    if (GetEntityModel(LocalPlayer().Ped) == GetHashKey("mp_f_freemode_01")) then
                                        faceId = 21
                                    end

                                    SetPedHeadBlendData(
                                        LocalPlayer().Ped,
                                        faceId,
                                        faceId,
                                        faceId,
                                        skin.face.mom,
                                        skin.face.dad,
                                        0,
                                        skin.resemblance,
                                        skin.skinMix,
                                        0,
                                        false
                                    )
                                end

                                SetPedFaceFeature(playerPed, 0, 0)
                                SetPedFaceFeature(playerPed, 1, 0)
                                SetPedFaceFeature(playerPed, 2, 0)
                                SetPedFaceFeature(playerPed, 3, 0)
                                SetPedFaceFeature(playerPed, 4, 0)
                                SetPedFaceFeature(playerPed, 5, 0)
                                SetPedFaceFeature(playerPed, 6, 0)
                                SetPedFaceFeature(playerPed, 7, 0)
                                SetPedFaceFeature(playerPed, 8, 0)
                                SetPedFaceFeature(playerPed, 9, 0)
                                SetPedFaceFeature(playerPed, 10, 0)
                                SetPedFaceFeature(playerPed, 11, 0)
                                SetPedFaceFeature(playerPed, 12, 0)
                                SetPedFaceFeature(playerPed, 13, 0)
                                SetPedFaceFeature(playerPed, 14, 0)
                                SetPedFaceFeature(playerPed, 15, 0)
                                SetPedFaceFeature(playerPed, 16, 0)
                                SetPedFaceFeature(playerPed, 17, 0)
                                SetPedFaceFeature(playerPed, 18, 0)
                                SetPedFaceFeature(playerPed, 19, 0)
                            end
                            Ora.Core:Debug(string.format("User is putting on mask ^5%s^3", item.data.var))

                            if (removeHair ~= nil and removeHair[item.data.var] ~= nil and removeHair[item.data.var] == true) then
                                local hairId = 0
                                SetPedComponentVariation(playerPed, 2, hairId, 0, 0)
                            end
                        end
                    )
                end
            )
            
        end
    end
    item.data.equiped = not item.data.equiped
end
function EquipRadio()
    ShowNotification(string.format("Radio : ~g~Equipée~s~"))
    exports["rp-radio"]:SetRadio(true)
end

MyBattery = 0
MyNumber = 0

ItemsFunction = {
    herse = function()
        useHerse()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    roulant = function(i)
        if i then
            useChaise(i)
        end
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    armoire = function()
        useArmoire()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    fauteuil = function()
        useFauteuil()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    commode = function()
        useCommode()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    tablefbi = function()
        useTablefbi()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    cone = function()
        useCone()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    barrier = function()
        useBarrier()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    tel = function(item)
        if (item.data.num ~= nil) then
            TriggerServerEvent("core:SetNumber", item.data.num)
            MyNumber = item.data.num
            MyBattery = item.data.battery
            TriggerEvent("gcphone:UpdateBattery", MyBattery)
            TriggerEvent("gcPhone:myPhoneNumber", MyNumber)
            Wait(300)
            TriggerServerEvent("gcPhone:allUpdate")
            RageUI.Popup({message = "Téléphone activé : ~g~" .. MyNumber})
        else
            ShowNotification("~r~La carte SIM de ce téléphone est cassé. Veuillez en acheter un autre~s~")
        end
    end,
    battery = function()
        if MyNumber == nil or MyNumber == 0 then
            RageUI.Popup({message = "~r~Vous n'avez pas de téléphone actif"})
        else
            --Ora.Inventory:RemoveItem()
            MyBattery = MyBattery + 50
            if MyBattery > 100 then
                MyBattery = MyBattery - (MyBattery - 100)
            end
            for i = 1, #Ora.Inventory.Data["tel"] do
                if Ora.Inventory.Data["tel"][i].data.num == MyNumber then
                    Ora.Inventory.Data["tel"][i].data.battery = MyBattery
                    break
                end
            end
            TriggerEvent("gcphone:UpdateBattery", MyBattery)
        end
    end,
--[[     blocnote = function()
        local item = Ora.Inventory.SelectedItem
        local data = item.data
        data = json.decode(data)
        if type(data) ~= "table" then
            data = json.decode(data)
        end
        text = KeyboardInput("~b~Combien ?", data.text, 255)
        if tostring(text) ~= nil then
            data.text = text
            TriggerServerEvent("ChangeItemData", item.id, data, item)
        end
    end, ]]
    crochetage = function(i)
        if i then
            LockPickVehicle(i)
        end
    end,
--[[    weed_pot = function(i)
        if i then
            Ora.Inventory:RemoveItem(i)
            exports["weed"]:createProps()
        end
    end,]]
    ciseaux = function()
        CutChev()
    end,
    mask = function(item)
        if item then
            for i = 1, #Ora.Inventory.Data[item.name] do
                if Ora.Inventory.Data[item.name][i].id == item.id then
                    SelectedItem = Ora.Inventory.Data[item.name][i]
                end
            end
            Wait(50)
            EquipMasks()
        end
    end,
    kevlar = function(item)
        if item then
            for i = 1, #Ora.Inventory.Data['kevlar'] do
                if Ora.Inventory.Data['kevlar'][i].id == item.id then
                    kevEquiped = Ora.Inventory.Data['kevlar'][i]
                end
            end
            Wait(50)
            EquipKev()
        end
    end,
    clothe = function(item)
        if item then
            for i = 1, #Ora.Inventory.Data[item.name] do
                if Ora.Inventory.Data[item.name][i].id == item.id then
                    SelectedItem = Ora.Inventory.Data[item.name][i]
                end
            end
            Wait(50)
            EquipClothes()
        end
    end,
    radio = EquipRadio,
    tenue = function(item)
        if item then
            for i = 1, #Ora.Inventory.Data[item.name] do
                if Ora.Inventory.Data[item.name][i].id == item.id then
                    SelectedItem = Ora.Inventory.Data[item.name][i]
                end
            end
            Wait(50)
            EquipTenue()
        end
    end,
    menottes = Police.HandcuffPly,
    pinces = Police.CutMenottes,
    access = function(item)
        if item then
            for i = 1, #Ora.Inventory.Data[item.name] do
                if Ora.Inventory.Data[item.name][i].id == item.id then
                    SelectedItem = Ora.Inventory.Data[item.name][i]
                end
            end
            Wait(50)
            EquipClothes()
        end
    end,
    bank_card = function(item)
        if item then
            for i = 1, #Ora.Inventory.Data[item.name] do
                if Ora.Inventory.Data[item.name][i].id == item.id then
                    SelectedItem = Ora.Inventory.Data[item.name][i]
                    Ora.Inventory.SelectedItem = SelectedItem
                end
            end
            UseBankCard()
        end
    end,
    speaker = function()
        Ora.Inventory:RemoveAnyItemsFromName("speaker", 1)
        TriggerEvent("Ora:hideInventory")
        ExecuteCommand("toggleSpeaker")
        TriggerEvent("xradio:menuOpened", "ground")
        Ora.Player.Speaker.IsUsing = true
        Ora.Player.Speaker.Pos = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId())
    end,
    allumette = function()
        Citizen.CreateThread(
            function()
                local animDict = "move_crouch_proto"
                local dispatchMessage = "Un fou viens de mettre le feu ici, venez vite !"

                Ora.Inventory:RemoveFirstItem("allumette")
                TriggerEvent("Ora:hideInventory")
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do Wait(100) end
        
                TaskPlayAnim(LocalPlayer().Ped, animDict, "idle", 8.0, -8.0, 2000, 0, 0.0, false, false, false)

                Wait(2000)
                TriggerServerEvent('fireManager:command:startfire', GetEntityCoords(LocalPlayer().Ped) + GetEntityForwardVector(LocalPlayer().Ped), 2, 75, true, nil)
                RageUI.Popup({message = "~r~Vous avez allumé un feu espèce de pyromane !"})
            end
        )
    end,
    molotovartisanal = function()
        Citizen.CreateThread(
            function()
                local animDict = "cover@first_person@weapon@grenade"
                local dispatchMessage = "Un fou viens de mettre le feu ici, venez vite !"
                
                Ora.Inventory:RemoveFirstItem("molotovartisanal")
                TriggerEvent("Ora:hideInventory")
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do Wait(100) end
        
                TaskPlayAnim(LocalPlayer().Ped, animDict, "low_r_throw_long", 8.0, -8.0, 2000, 0, 0.0, false, false, false)

                Wait(2000)
                TriggerServerEvent('fireManager:command:startfire', GetEntityCoords(LocalPlayer().Ped) + (GetEntityForwardVector(LocalPlayer().Ped) * 5), 5, 90, true, nil)
                RageUI.Popup({message = "~r~Vous avez allumé un feu espèce de pyromane !"})
            end
        )
    end,
    driftwheels = function()
        Citizen.CreateThread(
            function()
                local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
                local veh = GetVehicleInDirection(5.0)

                if (veh ~= 0 and GetVehiclePedIsIn(LocalPlayer().Ped, false) == 0) then
                    if (not DecorGetBool(veh, "drifttyres")) then
                        exports['Ora_utils']:sendME("* L'individu change les roues du véhicule *")
                        Ora.Inventory:RemoveFirstItem("driftwheels")
                        TriggerEvent("Ora:hideInventory")

                        RequestAnimDict(animDict)
                        while not HasAnimDictLoaded(animDict) do Wait(100) end
                        TaskPlayAnim(LocalPlayer().Ped, animDict, "machinic_loop_mechandplayer", 8.0, -8.0, 20000, 0, 0.0, false, false, false)
                        
                        exports["mythic_progbar"]:Progress(
                            {
                                name = "driftwheels",
                                duration = 20000,
                                label = "Vous changez les roues...",
                                useWhileDead = true,
                                canCancel = false,
                                controlDisables = {
                                    disableMovement = true,
                                    disableCarMovement = false,
                                    disableMouse = false,
                                    disableCombat = false
                                },
                            },
                            function()
                                SetDriftTyresEnabled(veh, true)
                                Ora.Inventory:AddItem({name = "roadwheels"})
                                RageUI.Popup({message = "~g~Vous installé les roues de drift"})
                                DecorSetBool(veh, "drifttyres", true)
                            end
                        )
                    else
                        RageUI.Popup({message = "~r~Ce véhicule a déjà ce type de roues"})
                    end
                else
                    RageUI.Popup({message = "~r~Aucun véhicule en face de vous"})
                end
            end
        )
    end,
    roadwheels = function()
        Citizen.CreateThread(
            function()
                local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
                local veh = GetVehicleInDirection(5.0)

                if (veh ~= 0 and GetVehiclePedIsIn(LocalPlayer().Ped, false) == 0) then
                    if (DecorGetBool(veh, "drifttyres") or GetDriftTyresEnabled(veh, true)) then
                        exports['Ora_utils']:sendME("* L'individu change les roues du véhicule *")

                        Ora.Inventory:RemoveFirstItem("roadwheels")
                        TriggerEvent("Ora:hideInventory")

                        RequestAnimDict(animDict)
                        while not HasAnimDictLoaded(animDict) do Wait(100) end
                        TaskPlayAnim(LocalPlayer().Ped, animDict, "machinic_loop_mechandplayer", 8.0, -8.0, 20000, 0, 0.0, false, false, false)

                        exports["mythic_progbar"]:Progress(
                            {
                                name = "roadwheels",
                                duration = 20000,
                                label = "Vous changez les roues...",
                                useWhileDead = true,
                                canCancel = false,
                                controlDisables = {
                                    disableMovement = true,
                                    disableCarMovement = false,
                                    disableMouse = false,
                                    disableCombat = false
                                },
                            },
                            function()
                                SetDriftTyresEnabled(veh, false)
                                Ora.Inventory:AddItem({name = "driftwheels"})
                                RageUI.Popup({message = "~g~Vous installé les roues de route"})
                                DecorSetBool(veh, "drifttyres", false)
                            end
                        )
                    else
                        RageUI.Popup({message = "~r~Ce véhicule a déjà ce type de roues"})
                    end
                else
                    RageUI.Popup({message = "~r~Aucun véhicule en face de vous"})
                end
            end
        )
    end,
    bouteille_vin = drinkAlcool,
    sac = OpenSac,
    coke1 = eatCoke,
    meth = eatMeth,
    meth1 = eatMeth,
    lsd_pooch = eatLSD,
    hero = eatHero,
    mdma = eatMdma,
    repairbox2 = function(item)
        if item then
            TriggerServerCallback("Ora::SE::Service:GetInServiceCount", 
                function(numberOfMecanosOnline)
                    if numberOfMecanosOnline == 0 then
                        local vehicle = ClosestVeh()
                        Ora.Inventory:RemoveItem(item)
                        if vehicle ~= 0 then
                            TaskStartScenarioInPlace(LocalPlayer().Ped, "PROP_HUMAN_BUM_BIN", 0, true)
                            player = LocalPlayer()
                            player.isBusy = true
                            Citizen.CreateThread(
                                function()
                                    Citizen.Wait(20000)

                                    SetVehicleFixed(vehicle)
                                    SetVehicleDeformationFixed(vehicle)
                                    SetVehicleUndriveable(vehicle, false)
                                    SetVehicleEngineOn(vehicle, true, true)
                                    ClearPedTasksImmediately(LocalPlayer().Ped)

                                    RageUI.Popup({message = "Véhicule ~g~réparé"})
                                    TriggerEvent('Ora:InvNotification', "Véhicule réparé", 'success')
                                    player.isBusy = false
                                end
                            )
                        else
                            TriggerEvent('Ora:InvNotification', "Aucun véhicule", 'warning')
                        end
                    else
                        TriggerEvent('Ora:InvNotification', "Vous n'avez pas assez d'énergie pour faire ceci. (mécano(s) en service)", 'warning')
                    end
                end,
                "mecano"
            )
        end
    end,
    perche = function()
        local objectData = {
            prop = "prop_v_bmike_01",
            anim = {"missfra1", "mcs2_crew_idle_m_boom"},
            flag = 50,
            bone = 28422,
            pos = {-0.08, 0.0, 0.0, 0.0, 0.0, 0.0}
        }
        -- if objectData and objectData.anim and (not IsEntityPlayingAnim(ped, objectData.anim[1], objectData.anim[2], 3) or (not lastAnimationUpdate or lastAnimationUpdate <= GetGameTimer())) then
        --   forceAnim(objectData.anim, objectData.flag, { clearTasks = true })
        --   lastAnimationUpdate = GetGameTimer() + 10000
        -- end
        ppppp(objectData)
    end,
    micro = function()
        objectData = {
            prop = "p_ing_microphonel_01",
            anim = {"missheistdocksprep1hold_cellphone", "hold_cellphone"},
            flag = 50,
            bone = 60309,
            pos = {0.055, 0.05, 0.0, 240.0, 0.0, 0.0}
        }
        ppppp(objectData)
    end,
    bigcam = function()
        objectData = {
            prop = "prop_v_cam_01",
            anim = {"missfinale_c2mcs_1", "fin_c2_mcs_1_camman"},
            flag = 50,
            bone = 28422,
            pos = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}
        }
        ppppp(objectData)
    end,
    parapluie = function()
        objectData = {
            prop = "p_amb_brolly_01",
            anim = {"amb@code_human_wander_drinking@male@base", "base"},
            flag = 49,
            bone = 57005,
            pos = {.125, .05, .0, -90.0, 0.0, 0.0}
        }
        ppppp(objectData)
    end,
    megaphone = function()
        objectData = {
            prop = "prop_megaphone_01",
            anim = {"weapons@first_person@aim_idle@generic@submachine_gun@shared@core", "settle_med"},
            flag = 49,
            bone = 36029,
            pos = {-.125, .0, -.03, -10.0, 30.0, 0.0}
        }
        ppppp(objectData)
        megaphone = not megaphone
        exports["mumble-voip"]:megaPhone()
    end,
    --cannepeche = function()
    --TaskStartScenarioInPlace(LocalPlayer().Ped, "WORLD_HUMAN_STAND_FISHING", 0, true)
    --end,
    shield = function()
        createShield()
    end,
    cana = eatCana,
    darknet = sendDarknetMessage,
    gants = toggleGloves,
    medikit = function(i)
        if i then
            SetEntityHealth(LocalPlayer().Ped, GetEntityMaxHealth(LocalPlayer().Ped))
            Ora.Inventory:RemoveItem(i)
        end
    end,
    mec = function(i)
        if i then
            SetEntityHealth(LocalPlayer().Ped, GetEntityHealth(LocalPlayer().Ped) + 50.0)
            Ora.Inventory:RemoveItem(i)
        end
    end,
    moteur = RepairMotor,
    fikit = RepairCaro,
    roue = RepairRoue,
    lavage = function(item)
        if item then
            Wait(50)
            local vehicle = ClosestVeh()
            if vehicle ~= 0 then
                TaskStartScenarioInPlace(LocalPlayer().Ped, "WORLD_HUMAN_MAID_CLEAN", 0, true)
                player = LocalPlayer()
                player.isBusy = true
                Citizen.CreateThread(
                    function()
                        Citizen.Wait(10000)

                        SetVehicleDirtLevel(vehicle, 0)
                        ClearPedTasksImmediately(LocalPlayer().Ped)
                        removeall()

                        RageUI.Popup({message = "Véhicule ~g~nettoyé"})
                        player.isBusy = false
                    end
                )
                Ora.Inventory:RemoveItem(item)
            else
                TriggerEvent('Ora:InvNotification', "Aucun véhicule", 'warning')
            end
        end
    end,
    adrenaline = function(i)
        if i then
            local clsPly = GetPlayerServerIdInDirection(8.0)
            if clsPly then
                TriggerPlayerEvent("player:Revive", clsPly)
                Ora.Inventory:RemoveItem(i)
            else
                RageUI.Popup({message = "Aucun joueur à proximité"})
            end
        end
    end,
    bandages = function(i)
        if i then
            local clsPly = GetPlayerServerIdInDirection(8.0)
            if clsPly then
                TaskStartScenarioInPlace(LocalPlayer().Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                Wait(5000)
                TriggerPlayerEvent("player:Heal", clsPly, GetEntityMaxHealth(clsPly))
                ClearPedTasksImmediately(LocalPlayer().Ped)
                Ora.Inventory:RemoveItem(i)
            else
                RageUI.Popup({message = "Aucun joueur à proximité"})
            end
        end
    end,
    makeup = function()
        Citizen.SetTimeout(500, function()
            TriggerEvent('Ora:hideInventory')
            RageUI.Visible(RMenu:Get('makeup', "main"), true)
        end)
    end
}
function ppppp(objectData)
    local ped = LocalPlayer().Ped
    if decorObject == nil then
        decorObject = Ora.World.Object:Create(GetHashKey(objectData.prop), plyPos, true, true, true)
        SetPedKeepTask(ped, true)
        doAnim(objectData.anim, nil, objectData.flag)
        local a, b, c, d, e, f = table.unpack(objectData.pos)
        AttachEntityToEntity(
            decorObject,
            ped,
            GetPedBoneIndex(ped, objectData.bone),
            a or 0.0,
            b or 0.0,
            c or 0.0,
            d or 0.0,
            e or 0.0,
            f or 0.0,
            0,
            0,
            0,
            1,
            0,
            1
        )
    else
        DeleteEntity(decorObject)
        decorObject = nil
        ClearPedTasks(ped)
    end
end
function toggleObject(_, n)
    if not n then
        return
    end
    local Player = LocalPlayer()
    GM.itemHandler[n] = nil
    hasObject = not hasObject and n or false
    if decorObject and DoesEntityExist(decorObject) then
        SetEntityAsMissionEntity(decorObject, 1, 1)
        DeleteEntity(decorObject)
    end

    local ped, plyPos, objectInfo = Player.Ped, Player.Pos, treeDecorObjets[n]
    if hasObject and objectInfo then
        ClearAreaOfObjects(plyPos, 3.0)

        decorObject = Ora.World.Object:Create(GetHashKey(objectInfo.prop), plyPos, true, 0, 0)
        SetPedKeepTask(ped, true)
        doAnim(objectInfo.anim, nil, objectInfo.flag)
        local a, b, c, d, e, f = table.unpack(objectInfo.pos)
        AttachEntityToEntity(
            decorObject,
            ped,
            GetPedBoneIndex(ped, objectInfo.bone),
            a or 0.0,
            b or 0.0,
            c or 0.0,
            d or 0.0,
            e or 0.0,
            f or 0.0,
            0,
            0,
            0,
            1,
            0,
            1
        )

        GM.itemHandler[n] = decorObject

        if objectInfo.onStart then
            objectInfo.onStart(objectInfo, Player, ped)
        end
    else
        ClearPedTasks(ped)
        if objectInfo.onExit then
            objectInfo.onExit(objectInfo, Player, ped)
        end
    end
end

local function IsARealWeapon(usedWeapon)
    local fakeWeapons = {
        "WEAPON_CANETTE",
        "WEAPON_PETROLCAN",
        "WEAPON_FIREEXTINGUISHER"
    }
    for _, weapon in ipairs(fakeWeapons) do
        if GetHashKey(weapon) == usedWeapon then
            return false
        end
    end
    return true
end

function EquipWeapon(weapon)
    local name = weapon_name[weapon.name]
    if HasPedGotWeapon(LocalPlayer().Ped, GetHashKey(name), false) then
        RemoveWeaponFromPed(playerPed, GetHashKey(name))
    else
        if (weapon.name == "parachute") then
            GiveWeaponToPed(LocalPlayer().Ped, GetHashKey("GADGET_PARACHUTE"), true)
            SetCurrentPedWeapon(LocalPlayer().Ped, GetHashKey("GADGET_PARACHUTE"), true)
            SetPlayerHasReserveParachute(PlayerId())
            SetPlayerParachutePackTintIndex(PlayerId(), math.random(1, 4))
            SetPlayerParachuteTintIndex(PlayerId(), math.random(0, 13))
            SetPlayerReserveParachuteTintIndex(PlayerId(), math.random(0, 13))
            SetAutoGiveParachuteWhenEnterPlane(PlayerId(), true)
            SetPedGadget(LocalPlayer().Ped, "GADGET_PARACHUTE", true)
        end

        local playerPed = LocalPlayer().Ped
        SetPedAmmo(LocalPlayer().Ped, GetHashKey(name), 0)
        GiveWeaponToPed(playerPed, GetHashKey(name), 0, false, true)
        local data = weapon.data
        if data ~= nil and data.tint ~= nil then
            SetPedWeaponTintIndex(playerPed, GetHashKey(name), data.tint)
        end
        if data ~= nil and data.access ~= nil then
            for i = 1, #data.access, 1 do
                GiveWeaponComponentToPed(LocalPlayer().Ped, GetHashKey(name), GetHashKey(data.access[i]))
            end
        end

        cp = nil

        for k, v in pairs(weapon_name) do
            if v == name then
                cp = k
            end
        end

        if (cp == "gascan") then
            SetPedAmmo(LocalPlayer().Ped, GetHashKey(name), 1600)
            Ora.Inventory.CurrentAmmo = 1600
        elseif (cp == "fire_extinguisher") then
            SetPedAmmo(LocalPlayer().Ped, GetHashKey(name), 9999)
            Ora.Inventory.CurrentAmmo = 9999
        else
            for k, v in pairs(Ora.Inventory.Data) do
                if k == weapon_munition[cp] then
                    SetPedAmmo(LocalPlayer().Ped, GetHashKey(name), #v)
                    Ora.Inventory.CurrentAmmo = #v
                    break
                else
                    Ora.Inventory.CurrentAmmo = 0
                end
            end
        end

        Ora.Inventory.CurrentWeapon.Name = GetHashKey(name)
        Ora.Inventory.CurrentWeapon.Label = name
        Ora.Inventory.CurrentMunition = weapon_munition[cp]
        Ora.Inventory.IsArmed = true
    end
end
DecorRegister("powder", 2)

local Keys = {["E"] = 38, ["K"] = 311}
local isFueling = false

Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            playerPed = LocalPlayer().Ped
            local currentWeapon = GetSelectedPedWeapon(playerPed)

            -- Jerrican
            if (currentWeapon == 883325847) then
                local playerCoords = LocalPlayer().Pos
                local closestVehicle = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 2.0, 0, 127)
                local vehicleCoords = GetEntityCoords(closestVehicle)
                local distance =
                    GetDistanceBetweenCoords(
                    vehicleCoords.x,
                    vehicleCoords.y,
                    vehicleCoords.z,
                    playerCoords.x,
                    playerCoords.y,
                    playerCoords.z,
                    true
                )
                if (distance <= 3.0 and isFueling == false) then
                    DrawText3D(
                        vehicleCoords.x,
                        vehicleCoords.y,
                        vehicleCoords.z + 1.5,
                        "appuyez sur [~h~K~h~] avec votre jerrican en main pour faire le plein"
                    )

                    if IsControlJustPressed(1, Keys["K"]) and IsPedWeaponReadyToShoot(LocalPlayer().Ped) then
                        local tankV = GetVehicleHandlingFloat(closestVehicle, "CHandlingData", "fPetrolTankVolume")
                        if GetFuel(closestVehicle) + 10 < tankV or (tankV <= 10.00 and GetFuel(closestVehicle) < 5.00) then
                            isFueling = true

                            RequestAnimDict("timetable@gardener@filling_can")
                            local j = 0
                            while not HasAnimDictLoaded("timetable@gardener@filling_can") and j <= 50 do
                                Citizen.Wait(100)
                                j = j + 1
                            end

                            if j >= 50 then
                                SendNotification("~r~~h~ERROR ~h~~w~: The animation dictionnary took too long to load.")
                            else
                                TaskPlayAnim(
                                    LocalPlayer().Ped,
                                    "timetable@gardener@filling_can",
                                    "gar_ig_5_filling_can",
                                    8.0,
                                    1.0,
                                    -1,
                                    1
                                )
                                SendNotification(
                                    "~r~~h~ESSENCE~h~~w~: Vous ajoutez 10 Litres d'essence, veuillez patienter."
                                )
                                Wait(1000 * 10)
                                Ora.Inventory:RemoveFirstItem("gascan")
                                Wait(1000 * 5)
                                ClearPedTasksImmediately(LocalPlayer().Ped)
                                RemoveAnimDict("timetable@gardener@filling_can")
                                local newEssenceLevel = GetFuel(closestVehicle)
                                SetFuel(closestVehicle, newEssenceLevel + 10)
                                SendNotification("~r~~h~ESSENCE~h~~w~: Vous avez remis un peu d'essence dans votre voiture")
                                isFueling = false
                            end
                        else
                            SendNotification("~r~~h~ESSENCE~h~~w~: Votre réservoir est loin d'être vide")
                        end
                    end
                end
            end

            if IsPedShooting(playerPed) and not onShooting then
                if IsARealWeapon(currentWeapon) then
                    DecorSetBool(playerPed, "powder", true)
                    TriggerServerEvent("Ora_status:addOn", "powder")
                end

                -- Jerrican
                if (currentWeapon == 883325847) then
                    local gascan = Ora.Inventory.Data["gascan"][1]
                    if (gascan.data == nil or gascan.data.useTime == nil) then
                        gascan.data = {useTime = 0}
                    end
                    gascan.data.useTime = gascan.data.useTime + 1

                    if (gascan.data.useTime > 1500) then
                        Ora.Inventory:RemoveFirstItem("gascan")
                    end
                end

                if (currentWeapon == 101631238) then
                    local extinguisher = Ora.Inventory.Data["fire_extinguisher"][1]
                    if (extinguisher.data == nil or extinguisher.data.useTime == nil) then
                        extinguisher.data = {useTime = 0}
                    end
                    extinguisher.data.useTime = extinguisher.data.useTime + 1

                    if (extinguisher.data.useTime > 6000) then
                        Ora.Inventory:RemoveFirstItem("fire_extinguisher")
                        RageUI.Popup({message = "~r~Votre extincteur est vide"})
                        EquipWeapon({name = "fire_extinguisher"})
                        TriggerEvent("Ora:inventory:deleteIfWeapon", extinguisher)
                    end
                end

                if Ora.Inventory.Data[Ora.Inventory.CurrentMunition] ~= nil then
                    item = Ora.Inventory.Data[Ora.Inventory.CurrentMunition][1].id
                    Ora.Inventory.CurrentAmmo = Ora.Inventory.CurrentAmmo - 1
                    Ora.Inventory:RemoveFirstItem(Ora.Inventory.CurrentMunition)
                end
            end
        end
    end
)

function DeleteChaise()
    local playerPed = LocalPlayer().Ped
    local coords = LocalPlayer().Pos

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_chair_04a"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin de la ~b~chaise")
        end
    end
end

function DeleteArmoire()
    local playerPed = LocalPlayer().Ped
    local coords = LocalPlayer().Pos

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_rub_cabinet01"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin de l'~b~Armoire")
        end
    end
end

function DeleteFauteuil()
    local playerPed = LocalPlayer().Ped
    local coords = LocalPlayer().Pos

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_chair_02"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin du ~b~Fauteuil")
        end
    end
end

function DeleteHerse()
    local playerPed = LocalPlayer().Ped
    local coords = LocalPlayer().Pos

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("p_ld_stinger_s"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin d'une herse")
        end
    end
end

function DeleteCommode()
    local playerPed = LocalPlayer().Ped
    local coords = LocalPlayer().Pos

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_fbibombfile"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin de la commode")
        end
    end
end

function DeleteTablefbi()
    local playerPed = LocalPlayer().Ped
    local coords = LocalPlayer().Pos

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_fbi3_coffee_table"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin de la table")
        end
    end
end

function DeleteCone()
    ExecuteCommand("r")
end

function DeleteBarrier()
    local playerPed = LocalPlayer().Ped
    local coords = LocalPlayer().Pos

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_barrier_work05"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin de la barriere")
        end
    end
end

local gloves = {}
local gloveModel = GetHashKey("prop_boxing_glove_01")
function toggleGloves()
    for k, v in pairs(gloves) do
        DeleteEntity(v)
    end
    if tableCount(gloves) > 0 then
        gloves = {}
        return
    end

    if not HasModelLoaded(gloveModel) then
        RequestModel(gloveModel)
        while not HasModelLoaded(gloveModel) do
            Citizen.Wait(100)
        end
    end

    local Player = LocalPlayer()
    local ped, plyPos = Player.Ped, Player.Pos

    local firstGlove = Ora.World.Object:Create(gloveModel, plyPos, 1, 0, 0)
    local secondGlove = Ora.World.Object:Create(gloveModel, plyPos, 1, 0, 0)
    table.insert(gloves, firstGlove)
    table.insert(gloves, secondGlove)

    for k, v in pairs(gloves) do
        SetEntityAsMissionEntity(v, 1, 1)
        --	SetEntityCollision(v, 1, 0)
    end

    AttachEntityToEntity(
        firstGlove,
        ped,
        GetPedBoneIndex(ped, 6286),
        vector3(-0.1, 0.01, -0.01),
        vector3(90.0, 0.0, 90.0),
        0,
        0,
        0,
        0,
        0,
        1
    )
    AttachEntityToEntity(
        secondGlove,
        ped,
        GetPedBoneIndex(ped, 36029),
        vector3(-0.1, 0.02, 0.02),
        vector3(-90.0, 0.0, -90.0),
        0,
        0,
        0,
        0,
        0,
        1
    )
    ShowNotification("Vous avez équipé ~g~vos gants~w~.")
    TriggerEvent('Ora:InvNotification', 'Vous avez équipé vos gants.')
end
SpawnObject = function(model, coords, cb)
    local model = (type(model) == "number" and model or GetHashKey(model))

    Citizen.CreateThread(
        function()
            RequestModel(model)

            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end

            local obj = Ora.World.Object:Create(model, coords.x, coords.y, coords.z, true, true, true)

            if cb ~= nil then
                cb(obj)
            end
        end
    )
end
function useHerse()
    local playerPed = LocalPlayer().Ped
    local coords, forward = LocalPlayer().Pos, GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "p_ld_stinger_s",
        objectCoords,
        function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end

function useCommode()
    --Ora.Inventory:RemoveItem()
    local playerPed = LocalPlayer().Ped
    local coords, forward = LocalPlayer().Pos, GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "prop_fbibombfile",
        objectCoords,
        function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end

function useTablefbi()
    --Ora.Inventory:RemoveItem()
    local playerPed = LocalPlayer().Ped
    local coords, forward = LocalPlayer().Pos, GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "prop_fbi3_coffee_table",
        objectCoords,
        function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end

function useArmoire()
    --Ora.Inventory:RemoveItem()
    local playerPed = LocalPlayer().Ped
    local coords, forward = LocalPlayer().Pos, GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "prop_rub_cabinet01",
        objectCoords,
        function(obj)
            FreezeEntityPosition(obj, GetEntityHeading(playerPed))
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end

function useFauteuil()
    --Ora.Inventory:RemoveItem()
    local playerPed = LocalPlayer().Ped
    local coords, forward = LocalPlayer().Pos, GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "prop_chair_02",
        objectCoords,
        function(obj)
            FreezeEntityPosition(obj, GetEntityHeading(playerPed))
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end

function useChaise(i)
    Ora.Inventory:RemoveItem(i)
    SpawnObject(
        "prop_wheelchair_01",
        LocalPlayer().Pos,
        function(obj)
            PlaceObjectOnGroundProperly(obj)
        end
    )
end
function useCone()
    TriggerEvent("inrp_propsystem:attachProp", "prop_roadcone02a", 28422, 0.6, -0.15, -0.1, 315.0, 288.0, 0.0)
end
function useBarrier()
    local playerPed = LocalPlayer().Ped
    local coords, forward = LocalPlayer().Pos, GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "prop_barrier_work05",
        objectCoords,
        function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end
-- -- Enter / Exit entity zone events
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- Citizen.CreateThread(
--     function()
--         local trackedEntities = {
--             "p_ld_stinger_s"
--         }

--         while true do
--             Citizen.Wait(0)

--             local playerPed = LocalPlayer().Ped
--             local coords = LocalPlayer().Pos
--             local LastEntity = nil

--             local closestDistance = -1
--             local closestEntity = nil

--             if IsPedInAnyVehicle(LocalPlayer().Ped) then
--                 for i = 1, #trackedEntities, 1 do
--                     local object =
--                         GetClosestObjectOfType(coords, 15.0, GetHashKey(trackedEntities[i]), false, false, false)

--                     if DoesEntityExist(object) then
--                         local objCoords = GetEntityCoords(object)
--                         local distance = GetDistanceBetweenCoords(LocalPlayer().Pos, objCoords, true)

--                         if distance <= 3.0 then
--                             local vehicle = GetVehiclePedIsIn(playerPed)
--                             for i = 0, 7, 1 do
--                                 SetVehicleTyreBurst(vehicle, i, true, 1000)
--                             end
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- )
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- DEACTIVATED BECAUSE IT CAUSES LAGS
-- DEACTIVATED BECAUSE IT CAUSES LAGS

local shieldActive = false
local shieldEntity = nil
local hadPistol = false

-- ANIM
local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"

local prop = "prop_ballistic_shield"
local pistol = GetHashKey("WEAPON_PISTOL")

function createShield()
    if shieldActive then
        DisableShield()
    else
        EnableShield()
    end
end

function EnableShield()
    shieldActive = true
    local ped = LocalPlayer().Ped
    local pedPos = GetEntityCoords(ped, false)

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Citizen.Wait(100)
    end

    local shield = Ora.World.Object:Create(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(
        shieldEntity,
        ped,
        GetEntityBoneIndexByName(ped, "IK_L_Hand"),
        0.0,
        -0.05,
        -0.10,
        -30.0,
        180.0,
        40.0,
        0,
        0,
        1,
        0,
        0,
        1
    )
    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))

    SetEnableHandcuffs(ped, true)
end

function DisableShield()
    local ped = LocalPlayer().Ped
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)
    SetWeaponAnimationOverride(ped, GetHashKey("Default"))

    if not hadPistol then
        RemoveWeaponFromPed(ped, pistol)
    end
    SetEnableHandcuffs(ped, false)
    hadPistol = false
    shieldActive = false
end

Citizen.CreateThread(
    function()
        while true do
            if shieldActive then
                local ped = LocalPlayer().Ped
                if not IsEntityPlayingAnim(ped, animDict, animName, 1) then
                    RequestAnimDict(animDict)
                    while not HasAnimDictLoaded(animDict) do
                        Citizen.Wait(100)
                    end

                    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
                end
            end
            Citizen.Wait(500)
        end
    end
)

attachPropList = {
    {
        ["model"] = "prop_roadcone02a",
        ["name"] = "cone",
        ["bone"] = 28422,
        ["x"] = 0.6,
        ["y"] = -0.15,
        ["z"] = -0.1,
        ["xR"] = 315.0,
        ["yR"] = 288.0,
        ["zR"] = 0.0,
        ["anim"] = "pick"
    }, -- Done
    {
        ["model"] = "prop_cs_trolley_01",
        ["name"] = "chariot",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.6,
        ["z"] = -0.8,
        ["xR"] = -180.0,
        ["yR"] = -165.0,
        ["zR"] = 90.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_table_03",
        ["name"] = "table",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.8,
        ["z"] = -0.7,
        ["xR"] = -180.0,
        ["yR"] = -165.0,
        ["zR"] = 90.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_tool_box_04",
        ["name"] = "repairbox",
        ["bone"] = 28422,
        ["x"] = 0.4,
        ["y"] = -0.1,
        ["z"] = -0.1,
        ["xR"] = 315.0,
        ["yR"] = 288.0,
        ["zR"] = 0.0,
        ["anim"] = "pick"
    }, -- Done
    {
        ["model"] = "xm_prop_smug_crate_s_medical",
        ["name"] = "MedBox",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.1,
        ["z"] = -0.1,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "xm_prop_x17_bag_med_01a",
        ["name"] = "MedBag",
        ["bone"] = 28422,
        ["x"] = 0.4,
        ["y"] = -0.1,
        ["z"] = -0.1,
        ["xR"] = 315.0,
        ["yR"] = 298.0,
        ["zR"] = 0.0,
        ["anim"] = "pick"
    }, -- Done
    {
        ["model"] = "imp_prop_impexp_car_door_04a",
        ["name"] = "porte",
        ["bone"] = 28422,
        ["x"] = -0.5,
        ["y"] = -0.15,
        ["z"] = 0.4,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 90.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "imp_prop_impexp_front_bars_01a",
        ["name"] = "parebuffle",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.25,
        ["z"] = -0.1,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "imp_prop_impexp_bonnet_03a",
        ["name"] = "capot",
        ["bone"] = 28422,
        ["x"] = 0.2,
        ["y"] = 0.2,
        ["z"] = -0.1,
        ["xR"] = -0.0,
        ["yR"] = 0.0,
        ["zR"] = 180.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "imp_prop_impexp_front_bumper_02a",
        ["name"] = "parechoc",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = 0.1,
        ["z"] = 0.05,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_car_battery_01",
        ["name"] = "batterie",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.1,
        ["z"] = -0.05,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_wheel_tyre",
        ["name"] = "pneu",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.1,
        ["z"] = -0.05,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_engine_hoist",
        ["name"] = "levage",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.5,
        ["z"] = -1.3,
        ["xR"] = -195.0,
        ["yR"] = -180.0,
        ["zR"] = 180.0,
        ["anim"] = "hold"
    }, -- Done
         -- Done
     -- Done
    --{["model"] = "prop_c4_final_green",				["name"] = "c4", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.1,	["z"] = -0.05,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0 , 	["anim"] = 'hold' } -- Done
    --{["model"] = "prop_fishing_rod_01",				["name"] = "cannepeche", 		["bone"] = 6286, ["x"] = 0.0,	["y"] = -0.1,	["z"] = -0.1,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0, 	["anim"] = 'hold' } -- Done
}

function SpecialProps(prop)
    local i = attachPropList[Items[prop.name].Index]
    TriggerEvent("inrp_propsystem:attachProp", i.model, i.bone, i.x, i.y, i.z, i.xR, i.yR, i.zR)
end

local holdingPackage = false
local dropkey = 246 -- Key to drop/get the props
local closestEntity = 0

RegisterNetEvent("inrp_propsystem:attachProp")
AddEventHandler(
    "inrp_propsystem:attachProp",
    function(attachModelSent, boneNumberSent, x, y, z, xR, yR, zR)
        notifi("~r~Y~w~ pour prendre/lâcher~n~~r~/r~w~ pour supprimer", true, false, 120)
        closestEntity = 0
        holdingPackage = true
        SetCurrentPedWeapon(LocalPlayer().Ped, 0xA2719263)
        local bone = GetPedBoneIndex(LocalPlayer().Ped, boneNumberSent)
        local coords = GetEntityCoords(LocalPlayer().Ped)
        closestEntity = Ora.World.Object:Create(attachModelSent, coords.x, coords.y, coords.z, true, true, false)
        for i = 1, #attachPropList, 1 do
            if (attachPropList[i].model == attachModelSent) and (attachPropList[i].anim == "hold") then
                holdAnim()
            end
        end
        AttachEntityToEntity(closestEntity, LocalPlayer().Ped, bone, x, y, z, xR, yR, zR, 1, 1, 0, true, 2, 1)
    end
)

function notifi(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, false, 3000)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function randPickupAnim()
    local randAnim = math.random(7)
    loadAnimDict("random@domestic")
    TaskPlayAnim(LocalPlayer().Ped, "random@domestic", "pickup_low", 5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
end

function holdAnim()
    loadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim((LocalPlayer().Ped), "anim@heists@box_carry@", "idle", 4.0, 1.0, -1, 49, 0, 0, 0, 0)
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)
            if IsPedOnFoot(LocalPlayer().Ped) and not IsPedDeadOrDying(LocalPlayer().Ped) then
                if IsControlJustReleased(0, dropkey) then
                    local playerPed = LocalPlayer().Ped
                    local coords = LocalPlayer().Pos
                    local closestDistance = -1
                    closestEntity = 0
                    for i = 1, #attachPropList, 1 do
                        local object =
                            GetClosestObjectOfType(
                            coords,
                            1.5,
                            GetHashKey(attachPropList[i].model),
                            false,
                            false,
                            false
                        )
                        if DoesEntityExist(object) then
                            local objCoords = GetEntityCoords(object)
                            local distance = GetDistanceBetweenCoords(coords, objCoords, true)
                            if closestDistance == -1 or closestDistance > distance then
                                closestDistance = distance
                                closestEntity = object
                                if not holdingPackage then
                                    local dst =
                                        GetDistanceBetweenCoords(
                                        GetEntityCoords(closestEntity),
                                        LocalPlayer().Pos,
                                        true
                                    )
                                    if dst < 2 then
                                        holdingPackage = true
                                        if attachPropList[i].anim == "pick" then
                                            randPickupAnim()
                                        elseif attachPropList[i].anim == "hold" then
                                            holdAnim()
                                        end
                                        Citizen.Wait(550)
                                        NetworkRequestControlOfEntity(closestEntity)
                                        while not NetworkHasControlOfEntity(closestEntity) do
                                            Wait(0)
                                        end
                                        SetEntityAsMissionEntity(closestEntity, true, true)
                                        while not IsEntityAMissionEntity(closestEntity) do
                                            Wait(0)
                                        end
                                        SetEntityHasGravity(closestEntity, true)
                                        AttachEntityToEntity(
                                            closestEntity,
                                            LocalPlayer().Ped,
                                            GetPedBoneIndex(LocalPlayer().Ped, attachPropList[i].bone),
                                            attachPropList[i].x,
                                            attachPropList[i].y,
                                            attachPropList[i].z,
                                            attachPropList[i].xR,
                                            attachPropList[i].yR,
                                            attachPropList[i].zR,
                                            1,
                                            1,
                                            0,
                                            true,
                                            2,
                                            1
                                        )
                                    end
                                else
                                    holdingPackage = false
                                    if attachPropList[i].anim == "pick" then
                                        randPickupAnim()
                                    end
                                    Citizen.Wait(350)
                                    DetachEntity(closestEntity)
                                    ClearPedTasks(LocalPlayer().Ped)
                                    ClearPedSecondaryTask(LocalPlayer().Ped)
                                end
                            end
                            break
                        end
                    end
                end
            else
                Citizen.Wait(1000)
            end
        end
    end
)

function removeAttachedProp()
    if DoesEntityExist(closestEntity) then
        DeleteEntity(closestEntity)
    end
end

function attach(prop)
    TriggerEvent("inrp_propsystem:attachItem", prop)
end

function removeall()
    TriggerEvent("RemoveItems", false)
    ClearPedTasks(LocalPlayer().Ped)
    ClearPedSecondaryTask(LocalPlayer().Ped)
end

RegisterNetEvent("inrp_propsystem:attachItem")
AddEventHandler(
    "inrp_propsystem:attachItem",
    function(item)
        for i = 1, #attachPropList, 1 do
            if (attachPropList[i].model == item) then
                TriggerEvent(
                    "inrp_propsystem:attachProp",
                    attachPropList[i].model,
                    attachPropList[i].bone,
                    attachPropList[i].x,
                    attachPropList[i].y,
                    attachPropList[i].z,
                    attachPropList[i].xR,
                    attachPropList[i].yR,
                    attachPropList[i].zR
                )
            end
        end
    end
)

RegisterNetEvent("RemoveItems")
AddEventHandler(
    "RemoveItems",
    function(sentinfo)
        SetCurrentPedWeapon(LocalPlayer().Ped, GetHashKey("weapon_unarmed"), 1)
        removeAttachedProp()
        holdingPackage = false
    end
)

RegisterCommand(
    "r",
    function()
        local playerPosition = GetEntityCoords(LocalPlayer().Ped)
        for object in EnumerateObjects() do
            if object and DoesEntityExist(object) and IsEntityAttached(object) and GetDistanceBetweenCoords(GetEntityCoords(object), playerPosition) <= 1.5  then
                DeleteEntity(object)   
            end
        end
    end,
    false
)

RegisterCommand(
    "removewheelchair",
    function()
        local wheelchair =
            GetClosestObjectOfType(LocalPlayer().Pos, 10.0, GetHashKey("prop_wheelchair_01"))

        if DoesEntityExist(wheelchair) then
            DeleteEntity(wheelchair)
        end
    end,
    false
)

Sit = function(wheelchairObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()

    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if
            IsEntityPlayingAnim(
                GetPlayerPed(closestPlayer),
                "missfinale_c2leadinoutfin_c_int",
                "_leadin_loop2_lester",
                3
            )
         then
            ShowNotification("Quelqu'un porte déjà cette chaise")
            return
        end
    end

    LoadAnim("missfinale_c2leadinoutfin_c_int")

    AttachEntityToEntity(
        LocalPlayer().Ped,
        wheelchairObject,
        0,
        0,
        0.0,
        0.4,
        0.0,
        0.0,
        180.0,
        0.0,
        false,
        false,
        false,
        false,
        2,
        true
    )

    local heading = GetEntityHeading(wheelchairObject)

    while IsEntityAttachedToEntity(LocalPlayer().Ped, wheelchairObject) do
        Citizen.Wait(5)

        if IsPedDeadOrDying(LocalPlayer().Ped) then
            DetachEntity(LocalPlayer().Ped, true, true)
        end

        if not IsEntityPlayingAnim(LocalPlayer().Ped, "missfinale_c2leadinoutfin_c_int", "_leadin_loop2_lester", 3) then
            TaskPlayAnim(
                LocalPlayer().Ped,
                "missfinale_c2leadinoutfin_c_int",
                "_leadin_loop2_lester",
                8.0,
                8.0,
                -1,
                69,
                1,
                false,
                false,
                false
            )
        end

        if IsControlPressed(0, 32) then
            local x, y, z =
                table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * -0.02)
            SetEntityCoords(wheelchairObject, x, y, z)
            PlaceObjectOnGroundProperly(wheelchairObject)
        end

        if IsControlPressed(1, 34) then
            heading = heading + 0.4

            if heading > 360 then
                heading = 0
            end

            SetEntityHeading(wheelchairObject, heading)
        end

        if IsControlPressed(1, 9) then
            heading = heading - 0.4

            if heading < 0 then
                heading = 360
            end

            SetEntityHeading(wheelchairObject, heading)
        end

        if IsControlJustPressed(0, 73) then
            DetachEntity(LocalPlayer().Ped, true, true)

            local x, y, z =
                table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * -0.7)

            SetEntityCoords(LocalPlayer().Ped, x, y, z)
        end
    end
end

PickUp = function(wheelchairObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()

    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "anim@heists@box_carry@", "idle", 3) then
            ShowNotification("Quelqu'un porte déjà cette chaise")
            return
        end
    end

    NetworkRequestControlOfEntity(wheelchairObject)

    LoadAnim("anim@heists@box_carry@")

    AttachEntityToEntity(
        wheelchairObject,
        LocalPlayer().Ped,
        GetPedBoneIndex(LocalPlayer().Ped, 28422),
        -0.00,
        -0.3,
        -0.73,
        195.0,
        180.0,
        180.0,
        0.0,
        false,
        false,
        true,
        false,
        2,
        true
    )

    while IsEntityAttachedToEntity(wheelchairObject, LocalPlayer().Ped) do
        Citizen.Wait(5)

        if not IsEntityPlayingAnim(LocalPlayer().Ped, "anim@heists@box_carry@", "idle", 3) then
            TaskPlayAnim(LocalPlayer().Ped, "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
        end

        if IsPedDeadOrDying(LocalPlayer().Ped) then
            DetachEntity(wheelchairObject, true, true)
        end

        if IsControlJustPressed(0, 73) then
            DetachEntity(wheelchairObject, true, true)
            ClearPedTasksImmediately(LocalPlayer().Ped)
        end
    end
end

DrawText3Ds = function(coords, text, scale)
    local x, y, z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)

    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 370

    DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.025, 41, 11, 41, 100)
end

GetPlayers = function()
    local players = {}

    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(players, i)
    end

    return players
end

GetClosestPlayer = function()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = LocalPlayer().Ped
    local plyCoords = GetEntityCoords(ply, 0)

    for index, value in ipairs(players) do
        local target = GetPlayerPed(value)
        if (target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance =
                Vdist(
                targetCoords["x"],
                targetCoords["y"],
                targetCoords["z"],
                plyCoords["x"],
                plyCoords["y"],
                plyCoords["z"]
            )
            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

LoadAnim = function(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)

        Citizen.Wait(1)
    end
end

LoadModel = function(model)
    while not HasModelLoaded(model) do
        RequestModel(model)

        Citizen.Wait(1)
    end
end

ShowNotification = function(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringWebsite(msg)
    DrawNotification(false, true)
end
exports(
    "lavage",
    function(item)
        if item then
            local vehicle = ClosestVeh()
            if vehicle ~= 0 then
                TaskStartScenarioInPlace(LocalPlayer().Ped, "WORLD_HUMAN_MAID_CLEAN", 0, true)
                player = LocalPlayer()
                player.isBusy = true
                Citizen.CreateThread(
                    function()
                        Citizen.Wait(10000)

                        SetVehicleDirtLevel(vehicle, 0)
                        ClearPedTasksImmediately(LocalPlayer().Ped)
                        removeall()

                        RageUI.Popup({message = "Véhicule ~g~nettoyé"})
                        player.isBusy = false
                    end
                )
                Ora.Inventory:RemoveItem(item)
            else
                RageUI.Popup({message = "~r~Aucun véhicule"})
                TriggerEvent('Ora:InvNotification', "Aucun véhicule", 'warning')
            end
        else
            if #Ora.Inventory.Data["lavage"] > 0 then
                local lavage = nil
                for i = 1, #Ora.Inventory.Data["lavage"] do
                    if Ora.Inventory.Data["lavage"][i].id == item.id then
                        lavage = Ora.Inventory.Data["lavage"][i]
                    end
                end
                Wait(50)
                local vehicle = ClosestVeh()
                if vehicle ~= 0 then
                    TaskStartScenarioInPlace(LocalPlayer().Ped, "WORLD_HUMAN_MAID_CLEAN", 0, true)
                    player = LocalPlayer()
                    player.isBusy = true
                    Citizen.CreateThread(
                        function()
                            Citizen.Wait(10000)

                            SetVehicleDirtLevel(vehicle, 0)
                            ClearPedTasksImmediately(LocalPlayer().Ped)
                            removeall()

                            RageUI.Popup({message = "Véhicule ~g~nettoyé"})
                            player.isBusy = false
                        end
                    )
                    Ora.Inventory:RemoveItem({id = lavage.id, name = lavage.name})
                else
                    TriggerEvent('Ora:InvNotification', "Aucun véhicule", 'warning')
                end
            else
                TriggerEvent('Ora:InvNotification', "Vous n'avez aucun Kit de lavage sur vous", 'error')
            end
        end
    end
)
exports(
    "CarJack",
    function()
        LockPickVehicle()
    end
)

exports(
    "Repair",
    function()
        if Ora.Inventory:GetItemCount("repairbox2") > 0 then

            TriggerServerCallback("Ora::SE::Service:GetInServiceCount", 
                function(nb)
                    if nb == 0 then
                        local vehicle = ClosestVeh()
                        Ora.Inventory:RemoveFirstItem("repairbox2")
                        if vehicle ~= 0 then
                            TaskStartScenarioInPlace(LocalPlayer().Ped, "PROP_HUMAN_BUM_BIN", 0, true)
                            player = LocalPlayer()
                            player.isBusy = true
                            Citizen.CreateThread(
                                function()
                                    Citizen.Wait(20000)

                                    SetVehicleFixed(vehicle)
                                    SetVehicleDeformationFixed(vehicle)
                                    SetVehicleUndriveable(vehicle, false)
                                    SetVehicleEngineOn(vehicle, true, true)
                                    ClearPedTasksImmediately(LocalPlayer().Ped)

                                    RageUI.Popup({message = "Véhicule ~g~réparé"})
                                    player.isBusy = false
                                end
                            )
                        else
                            RageUI.Popup({message = "~r~Aucun véhicule"})
                        end
                    else
                        ShowNotification("~r~Vous n'avez pas assez d'énergie pour faire ceci\n~y~(mécano(s) en service)")
                        TriggerEvent('Ora:InvNotification', "Vous n'avez pas assez d'énergie pour faire ceci. (mécano(s) en service)", 'error')
                    end
                end,
                "mecano"
            )
        else
            TriggerEvent('Ora:InvNotification', "Vous n'avez pas de " .. Items["repairbox2"].label .. " !", 'error')
        end
    end
)
function LockPickVehicle(item)
    if (Ora.Inventory:GetItemCount("crochetage") == 0) then
        ShowNotification("~r~Vous n'avez pas d'outil de crochetage !")
        TriggerEvent('Ora:InvNotification', "Vous n'avez pas d'outil de crochetage !", 'error')
        return
    end

    if (item == nil) then
        Ora.Inventory:RemoveFirstItem("crochetage")
    else
        Ora.Inventory:RemoveItem(item)
    end
    TriggerEvent("Ora:hideInventory")

    local plyPos = LocalPlayer().Pos
    local veh = GetVehicleInDirection(5.0)
    local mdl = GetEntityModel(veh)

    exports["mythic_progbar"]:Progress(
        {
            name = "lockpick",
            duration = 20500,
            label = "Crochetage en cours...",
            useWhileDead = true,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = true,
                disableCombat = true
            },
            -- animation = {
            --   animDict = "veh@break_in@0h@p_m_zero@",
            --   anim = "std_locked_ds",
            --   flags = 1
            -- },
            -- animation = {
            --   animDict = "veh@break_in@0h@p_m_one@",
            --   anim = "low_force_entry_ds",
            --   flags = 1
            -- },
            animation = {
                animDict = "missheistfbisetup1leadinoutah_1_mcs_1",
                anim = "leadin_janitor_idle_01",
                flags = 1
            }
        },
        function(cancelled)
            if not cancelled then
                ClearPedTasks(LocalPlayer().Ped)
                
                if (math.random(1, 2) ~= 2) then
                    SetVehicleAlarm(veh, true)
                    SetVehicleAlarmTimeLeft(veh, math.random(20000, 40000))
                    ShowNotification("Vous avez ~y~échoué.")
                    PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 0)
                    return
                end
                
                SetVehicleAlarm(veh, true)
                SetVehicleAlarmTimeLeft(veh, math.random(10000, 20000))
                NetworkRequestControlOfEntity(veh)
                local startTime = GetGameTimer()
                while not NetworkHasControlOfEntity(veh) and startTime + 2000 > GetGameTimer() do
                    Citizen.Wait(0)
                end

                if (Ora.World.Vehicle.JackedVehicles[veh] == nil) then table.insert(Ora.World.Vehicle.JackedVehicles, veh) end
                if (Ora.Illegal.CarRoberry:IsMissionRunning()) then Ora.Illegal.CarRoberry.Current.STOLEN_VEHICLE = veh end
                
                ShowNotification("Vous avez ~g~déverrouillé~w~ le véhicule.")
                --SetEntityAsMissionEntity(veh, true, true)
                SetVehicleHasBeenOwnedByPlayer(veh, true)
                local vehCoords = GetEntityCoords(veh)
                Citizen.SetTimeout(600000, function()
                    --callCopsForVehicle(veh, vehCoords)
                    SendDiscordWebHook(veh, vehCoords)
                end)
            end
        end
    )
end
local objectHandle
function attachObjectPedHand(stringProp, intWait, boolRelative, rightBone, boolLocal)
    local ped = LocalPlayer().Ped
    if objectHandle and DoesEntityExist(objectHandle) then
        DeleteEntity(objectHandle)
    end

    objectHandle = Ora.World.Object:Create(GetHashKey(stringProp), LocalPlayer().Pos, not boolLocal)
    AttachEntityToEntity(
        objectHandle,
        ped,
        GetPedBoneIndex(ped, rightBone and 60309 or 28422),
        .0,
        .0,
        .0,
        .0,
        .0,
        .0,
        true,
        true,
        false,
        true,
        1,
        not boolRelative
    )

    if intWait then
        Citizen.Wait(intWait)
        if objectHandle and DoesEntityExist(objectHandle) then
            DeleteEntity(objectHandle)
        end
        ClearPedTasks(LocalPlayer().Ped)
    end

    return objectHandle
end
local cutTime = 20000
local scissors
function CutChev()
    local ped = LocalPlayer().Ped
    FreezeEntityPosition(ped, true)
    local player = GetPlayerServerIdInDirection(5.0)
    TriggerServerEvent("Ora:cutHairs", player)
    local victimePed = GetPlayerPed(GetPlayerFromServerId(player))
    if not victimePed or not DoesEntityExist(victimePed) or victimePed == ped then
        ShowNotification("~r~ERREUR.")
        return
    end
    local right, forward, up, pos = GetEntityMatrix(victimePed)
    SetEntityCoords(ped, pos + forward * .45 - right * .1 - up * .9)
    local heading = GetEntityHeading(victimePed)
    anim = {"missfam6ig_8_ponytail", "ig_7_loop_michael"}
    SetEntityHeading(ped, heading + 15.0)
    scissors = attachObjectPedHand("p_cs_scissors_s")
    forceAnim(anim, 1)
    local threadEnd = GetGameTimer() + cutTime
    while threadEnd > GetGameTimer() do
        Citizen.Wait(0)

        if not IsEntityPlayingAnim(ped, anim[1], anim[2], 3) then
            forceAnim(anim, 1)
        end
    end
    ClearPedTasks(ped)
    if scissors and DoesEntityExist(scissors) then
        DeleteEntity(scissors)
    end

    FreezeEntityPosition(ped, false)
    ShowNotification("Vous avez ~r~coupé les cheveux~w~ de votre cible.")
    TriggerEvent('Ora:InvNotification', 'Vous avez coupé les cheveux de la cible.', 'success')
end
function SetPedHairs(ped, hairID, colorID, secondID)
    SetPedComponentVariation(ped, 2, hairID, 0, 2)
    SetPedHairColor(ped, colorID, secondID)
end
RegisterNetEvent("getCutCheveux")
AddEventHandler(
    "getCutCheveux",
    function()
        TriggerServerCallback(
            "core:GetSKin",
            function(skin)
                --(dump(skin))
                PlySkin = skin
                local skinInfo = json.decode(skin)
                local model = skinInfo.model
                local hash = GetHashKey(model)
                if (model == nil) then
                    ShowNotification("~r~Vous vous faites raser la tete~w~")
                else
                    RequestModel(hash)
                    while not HasModelLoaded(hash) do
                        Citizen.Wait(500)
                        --print("model loading" , hash)
                    end
                    SetPlayerModel(PlayerId(), hash)
                    Citizen.CreateThread(
                        function()
                            Wait(500)

                            UpdateEntityFace(LocalPlayer().Ped, json.decode(skin))
                            RefreshClothes()
                        end
                    )
                end

                local ped = LocalPlayer().Ped
                FreezeEntityPosition(ped, true)
                local anim = {"missfam6ig_8_ponytail", "ig_7_loop_lazlow"}
                forceAnim(anim, 1)
                local threadEnd = GetGameTimer() + cutTime
                while threadEnd > GetGameTimer() do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(ped, anim[1], anim[2], 3) then
                        forceAnim(anim, 1)
                    end
                end

                if (model ~= nil) then
                    SetPedHairs(ped, 0, 0, 0)

                    skinInfo.hair.style = skins.hair.style
                    skinInfo.hair.color[1] = skins.hair.color[1]
                    skinInfo.hair.color[2] = skins.hair.color[2]
                    UpdateEntityFace(LocalPlayer().Ped, skinInfo)
                    TriggerServerEvent("face:Save", skinInfo)
                end

                ClearPedTasks(ped)
                LocalPlayer().Ragdoll = true
                SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)

                FreezeEntityPosition(ped, false)
                ShowNotification("Vos cheveux ont été ~r~coupés~w~.")
                TriggerEvent('Ora:InvNotification', 'Vos cheveux ont été coupés.')
            end
        )
    end
)

function GetBags()
    return sac
end

exports("GetBags", GetBags)


-- Speaker

local radioType = "ground"

RMenu.Add("xRadio", "main", RageUI.CreateSubMenu(RMenu:Get("personnal", "actions"), "Radio", "Options"))


AddEventHandler("xradio:menuOpened", function(type)
  RageUI.Visible(RMenu:Get("xRadio", "main"), true)
  radioType = type or "ground"
end)


Citizen.CreateThread(
	function()
		while true do
			Wait(0)

			if (RageUI.Visible(RMenu:Get("xRadio", "main"))) then
				RageUI.DrawContent({ header = true, glare = false }, function()
                    if (Ora.Player.Speaker.IsUsing == false) then RageUI.GoBack() end
                    Ora.Player.Speaker.IsOnShoulder = radioType ~= "ground"

                    if (radioType == "shoulder") then
                        RageUI.Button(
                            "Gérer la radio sur l'épaule",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if (Selected) then
                                    TriggerEvent("xradio:openShoulderUi") -- will open the radio UI on shoulder
                                end
                            end
                        )

                        RageUI.Button(
                            "Enlever la radio de l'épaule",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if (Selected) then
                                    TriggerEvent("xradio:hideShoulderRadio") -- will remove the radio from user shoulder
                                    Ora.Inventory:AddItem({name = "speaker"})
                                    RageUI.Visible(RMenu:Get("xRadio", "main"), false)
                                    Ora.Player.Speaker.IsUsing = false
                                    Ora.Player.Speaker.Pos = vector3(0,0,0)
                                end
                            end
                        )

                        RageUI.Button(
                            "Mettre la radio au sol",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if (Selected) then
                                    TriggerEvent("xradio:putRadioBackGround") -- will put radio back to the ground
                                    radioType = "ground"
                                    Ora.Player.Speaker.Pos = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId())
                                end
                            end
                        )

                    elseif (radioType == "ground") then
                        RageUI.Button(
                            "Gérer la radio au sol",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if (Selected) then
                                    TriggerEvent("xradio:openRadio") -- will open the radio UI on ground
                                end
                            end
                        )

                        RageUI.Button(
                            "Enlever la radio du sol",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if (Selected) then
                                    TriggerEvent("xradio:deleteRadioOnGround") -- will remove the radio from ground
                                    Ora.Inventory:AddItem({name = "speaker"})
                                    RageUI.Visible(RMenu:Get("xRadio", "main"), false)
                                    Ora.Player.Speaker.IsUsing = false
                                    Ora.Player.Speaker.Pos = vector3(0,0,0)
                                end
                            end
                        )

                        RageUI.Button(
                            "Mettre la radio sur l'épaule",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if (Selected) then
                                    TriggerEvent("xradio:radioOnShoulder") -- will equip the radio to shoulder
                                    radioType = "shoulder"
                                end
                            end
                        )
                        
                    end
                end)
			end
		end
	end
)


