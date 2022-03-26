function DrawSub(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, 1)
end
local lookinggg = true
local DrugSellPosProps = {
    weed_pooch = "bkr_prop_weed_bag_01a",
    meth = "p_meth_bag_01_s",
    coke1 = "bkr_prop_coke_cutblock_01",
    lsd_pooch = "bkr_prop_coke_cutblock_01"
}
local Price = {
    weed_pooch = {27, 35},
    coke1 = {68, 75},
    meth = {55, 65},
    lsd_pooch = {75, 80}
}
local DrugSellPos = {
    weed_pooch = {
        ["Little Seoul"] = {
            Location = {
                "Bridge Street",
                "Nikola Avenue",
                "Mirror Park Boulevard",
                "Mirror Drive East",
                "Mirror Drive West",
                "Nikola Place",
                "Nikola Park Boulevard",
                "Mirror Place",
                "Bridge Street"
            },
            used = 100
        },
        ["Richman"] = {},
        ["Del Perro"] = {},
        ["Mirror Park"] = {},
        ["Vespucci Beach"] = {},
        ["Del Perro Beach"] = {},
        ["Duluoz Avenue"] = {},
        ["La Mesa"] = {},
        ["Legion Square"] = {},
        ["La Puerta"] = {},
        ["Vespucci Canals"] = {}
    },
    coke1 = {
        ["Richman"] = {},
        ["Rockford Hills"] = {},
        ["Richards Majestic"] = {},
        ["Vinewood Hills"] = {},
        ["Vinewood West"] = {},
        ["Hawick"] = {},
        ["Burton"] = {},
        ["Legion Square"] = {},
        ["Vespucci Canals"] = {}
    },
    meth = {
        ["Vespucci Beach"] = {},
        ["Burton"] = {},
        ["Alta"] = {},
        ["Downtown Vinewood"] = {},
        ["Del Perro Beach"] = {},
        ["Hawick"] = {},
        ["Legion Square"] = {},
        ["Vespucci Canals"] = {},
        ["La Puerta"] = {}
    },
    lsd_pooch = {
        ["Richman"] = {},
        ["Rockford Hills"] = {},
        ["Richards Majestic"] = {},
        ["Vinewood Hills"] = {},
        ["Vinewood West"] = {},
        ["Hawick"] = {},
        ["Burton"] = {},
        ["Legion Square"] = {},
        ["Vespucci Canals"] = {}
    }
}

local DrugNPC = {
    selling = false,
    CurrentDrug = nil,
    Count = 0
}

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if not DrugNPC.selling and lookinggg then
                local ped = LocalPlayer().Ped
                if not IsPedInAnyVehicle(ped) and not IsPedDeadOrDying(ped) then
                    for item, v in pairs(DrugSellPos) do
                        if Atlantiss == nil or Atlantiss.Inventory == nil or Atlantiss.Inventory["GetInventory"] == nil then
                            print("WAIT")
                            goto continue
                        end

                        local count = Atlantiss.Inventory:GetItemCount(item)
                        if count ~= nil and count > 0 and inCorrectStreet(item) then

                            TriggerServerCallback("Atlantiss::SE::Service:GetTotalServiceCountForJobs", 
                                function(allcount)
                                    if allcount >= Atlantiss.Illegal:GetCopsRequired("drugselling") then
                                        DrugNPC.selling = true
                                        DrugNPC.CurrentDrug = item
                                        DrugNPC.Count = count
                                    else
                                        DrawSub("Les clients n'ont pas d'argent", 10000)
                                        Wait(5000)
                                    end
                                end,
                                {"police", "lssd"}
                            )

                            Wait(5000)
                            goto continue
                        else
                            Wait(5000)
                        end
                    end
                end
            end
            ::continue::
        end
    end
)
local pedList = {}
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if DrugNPC.selling then
                DrawSub(DrugNPC.Sub, 1)
            end
        end
    end
)

function isCompatiblePed(target)
    local found = false
    for i = 1, #pedList, 1 do
        if pedList[i] == target then
            found = true
        end
    end
    if found then
        return false
    else
        return target and DoesEntityExist(target) and NetworkGetEntityIsNetworked(target) and not IsPedAPlayer(target) and
            not tableHasValue(pedFed, target) and
            not IsPedInAnyVehicle(target) and
            not IsPedDeadOrDying(target) and
            not IsPedShooting(target) and
            IsPedHuman(target)
    end
end
function inCorrectStreet(item)
    if item == nil then
        item = DrugNPC.CurrentDrug
    end
    local pos = DrugSellPos[item]
    local isCorrect = false
    local x, y, z = LocalPlayer().Pos
    local current_zone = GetLabelText(GetNameOfZone(x, y, z))
    for k, v in pairs(pos) do
        if k == current_zone then
            isCorrect = true
        end
    end
    return isCorrect
end
Citizen.CreateThread(
    function()
        while true do
            Wait(1000)
            if DrugNPC.selling then
                local check = inCorrectStreet()
                if not check then
                    DrugNPC = {
                        selling = false,
                        CurrentDrug = nil,
                        Count = 0
                    }
                end
            end

            if DrugNPC.selling then
                DrugNPC.Count = Atlantiss.Inventory:GetItemCount(DrugNPC.CurrentDrug)

                if DrugNPC.Count == 0 then
                    DrugNPC.Sub = "~r~Vous n'avez plus assez de marchandise !"
                    DrugNPC.selling = false
                    ResetNPCDRUG()
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(5000)
            if DrugNPC.selling then

                TriggerServerCallback("Atlantiss::SE::Service:GetTotalServiceCountForJobs", 
                    function(allcount)
                        if allcount < Atlantiss.Illegal:GetCopsRequired("drugselling") then
                            DrugNPC = {
                                selling = false,
                                CurrentDrug = nil,
                                Count = 0
                            }
                            DrawSub("Les clients n'ont pas d'argent ", 5000)
                        end
                    end,
                    {"police", "lssd"}
                )
            end
        end
    end
)

Citizen.CreateThread(
    function()
        RequestAnimDict("mp_common")
        while not HasAnimDictLoaded("mp_common") do
            Citizen.Wait(0)
        end
        RequestAnimDict("random@shop_gunstore")
        while not HasAnimDictLoaded("random@shop_gunstore") do
            Citizen.Wait(0)
        end
        Wait(2500)
        while true do
            Wait(1)
            if DrugNPC.selling then
                local ped = LocalPlayer().Ped

                if IsPedInAnyVehicle(ped) or IsPedDeadOrDying(ped) then
                    DrugNPC.selling = false
                    ResetNPCDRUG()
                end
                if DrugNPC.CurrentNPC ~= nil then
                    coords = GetEntityCoords(DrugNPC.CurrentNPC)
                    coordst = LocalPlayer().Pos

                    DrawMarker(
                        29,
                        coords.x,
                        coords.y,
                        coords.z + 1.2,
                        0.0,
                        0.0,
                        0.0,
                        0,
                        0.0,
                        0.0,
                        0.2,
                        0.2,
                        0.2,
                        255,
                        0,
                        0,
                        100,
                        true,
                        true,
                        2,
                        true,
                        false,
                        false,
                        false
                    )
                    pkq =
                        GetDistanceBetween3DCoords(coords.x, coords.y, coords.z, coordst.x, coordst.y, coordst.z, true)
                    if pkq > 5.0 then
                        ClearPedTasksImmediately(DrugNPC.CurrentNPC)
                        DrugNPC.CurrentNPC = nil
                    end
                    if pkq < 2.0 then
                        ClearPedTasks(DrugNPC.CurrentNPC)
                    end

                    if pkq < 1.5 then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("~r~Appuyez sur ~INPUT_CONTEXT~ pour vendre votre marchandise")
                        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                        if IsControlJustPressed(0, Keys["E"]) then
                            table.insert(pedList, DrugNPC.CurrentNPC)
                            FreezeEntityPosition(LocalPlayer().Ped, true)
                            TaskPlayAnim(LocalPlayer().Ped, "mp_common", "givetake1_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                            Wait(1500)
                            FreezeEntityPosition(LocalPlayer().Ped, false)
                            prop_name = DrugSellPosProps[DrugNPC.CurrentDrug]
                            local _prop = nil
                            local x, y, z = table.unpack(LocalPlayer().Pos)
                            SpawnObject(
                                prop_name,
                                {x = x, y = y, z = z},
                                function(prop)
                                    _prop = prop
                                    AttachEntityToEntity(
                                        prop,
                                        playerPed,
                                        GetPedBoneIndex(playerPed, 6286),
                                        0.12,
                                        -0.020,
                                        0.010,
                                        -85.0,
                                        175.0,
                                        0.0,
                                        true,
                                        true,
                                        false,
                                        true,
                                        1,
                                        true
                                    )
                                end
                            )
                            math.randomseed(GetGameTimer())
                            local xp = math.random(10, 25)
                            math.randomseed(GetGameTimer())

                            local dataDrug = Atlantiss.Inventory.Data[DrugNPC.CurrentDrug][1].data
                            local quality = 10
                            local typeQuality = "~r~Merdique~w~"

                            if (dataDrug ~= nil and type(dataDrug) == "table") then
                                if dataDrug.quality ~= nil then
                                    quality = dataDrug.quality
                                end
                            end

                            local price = math.random(Price[DrugNPC.CurrentDrug][1], Price[DrugNPC.CurrentDrug][2])

                            if (quality > 10 and quality <= 35) then
                                typeQuality = "~r~Basse~w~"
                                price = price + (price * ((quality / 100) / 2))
                            end

                            if (quality > 35 and quality < 50) then
                                typeQuality = "~o~Moyenne~w~"
                                price = price + ((price*1.1) * ((quality / 100) / 2))
                            end

                            if (quality >= 50 and quality < 75) then
                                typeQuality = "~y~Bonne~w~"
                                price = price + ((price*2.1) * ((quality / 100) / 2))
                            end

                            if (quality >= 75 and quality <= 99) then
                                typeQuality = "~g~Exceptionnelle~w~"
                                price = price + ((price*2.1) * ((quality / 100) / 2))
                            end

                            if (quality == 100) then
                                typeQuality = "~g~Inégalable~w~"
                                price = price + ((price*3.1) * ((quality / 100) / 2))
                            end

                            DrugNPC.Sub =
                                "Merci mon pote !\n~g~+" ..
                                price .. "$\n~y~+" .. xp .. " points d'expérience~s~\nQualité : " .. typeQuality

                            XNL_AddPlayerXP(math.floor(xp))
                            Wait(300)
                            PlayAmbientSpeech2(DrugNPC.CurrentNPC, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
                            show = false

                            Wait(800)

                            ClearPedSecondaryTask(LocalPlayer().Ped)
                            ClearPedSecondaryTask(DrugNPC.CurrentNPC)
                            ClearPedTasks(DrugNPC.CurrentNPC)
                            Wait(800)
                            Atlantiss.Inventory:RemoveItem(Atlantiss.Inventory.Data[DrugNPC.CurrentDrug][1])

                            TriggerServerCallback(
                                "Atlantiss::SE::Money:Fake:AuthorizePayment", 
                                function(token)
                                    TriggerServerEvent(Atlantiss.Payment.Fake:GetServerEventName(), {TOKEN = token, AMOUNT = price, SOURCE = "Vente drogue", LEGIT = false})
                                    TriggerServerEvent("Atlantiss::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", price, false)
                                end,
                                {}
                            )

                            math.randomseed(GetGameTimer())
                            local random = math.random(1, 10)
                            TaskWanderStandard(DrugNPC.CurrentNPC, 10.0, 10)
                            if random > 7 then
                                local pedDenounce = DrugNPC.CurrentNPC

                                Citizen.SetTimeout(
                                    math.random(5000, 30000),
                                    function()
                                        if DoesEntityExist(pedDenounce) and not IsPedDeadOrDying(pedDenounce, 1) then
                                            TaskSmartFleePed(pedDenounce, LocalPlayer().Ped, 100.0, 15000, 0, 0)
                                            Citizen.Wait(7500)
                                            if DoesEntityExist(pedDenounce) and not IsPedDeadOrDying(pedDenounce, 1) then
                                                forceAnim(
                                                    {"missfbi3_steve_phone", "steve_phone_idle_b"},
                                                    49,
                                                    {time = 4000, ped = pedDenounce}
                                                )
                                                Citizen.Wait(4000)
                                                if DoesEntityExist(pedDenounce) and not IsPedDeadOrDying(pedDenounce, 1) then
                                                    TaskWanderStandard(pedDenounce, 10.0, 10)
                                                    msg = "Quelqu'un a voulu me vendre de la drogue !!"
                                                    x, y, z = table.unpack(GetEntityCoords(pedDenounce))
                                                    TriggerServerEvent(
                                                        "call:makeCall2",
                                                        "police",
                                                        {x = x, y = y, z = z},
                                                        msg
                                                    )
                                                    TriggerServerEvent(
                                                        "call:makeCall2",
                                                        "lssd",
                                                        {x = x, y = y, z = z},
                                                        msg
                                                    )
                                                    SetEntityAsNoLongerNeeded(pedDenounce)
                                                end
                                            end
                                        end
                                    end
                                )
                            end
                            DrugNPC.CurrentNPC = nil
                            Citizen.Wait(1200)
                            DeleteObject(_prop)

                            Wait(800)
                            ResetNPCDRUG()
                            Wait(500)
                            DrugNPC.Sub = "~b~Vous recherchez des clients..."
                        end
                    end
                --
                end

                if DrugNPC.CurrentDrug ~= nil and DrugNPC.CurrentNPC == nil then
                    DrugNPC.Sub = "~b~Vous recherchez des clients..."

                    local player = LocalPlayer().Ped
                    local playerloc = GetEntityCoords(player, 0)
                    local handle, ped = FindFirstPed()
                    repeat
                        success, ped = FindNextPed(handle)
                        local pos = GetEntityCoords(ped)
                        local distance =
                            GetDistanceBetweenCoords(
                            pos.x,
                            pos.y,
                            pos.z,
                            playerloc["x"],
                            playerloc["y"],
                            playerloc["z"],
                            true
                        )
                        if isCompatiblePed(ped) then
                            if IsPedInAnyVehicle(LocalPlayer().Ped) == false then
                                if DoesEntityExist(ped) then
                                    if IsPedDeadOrDying(ped) == false then
                                        if IsPedInAnyVehicle(ped) == false then
                                            local pedType = GetPedType(ped)
                                            if pedType ~= 28 and IsPedAPlayer(ped) == false then
                                                currentped = pos
                                                if distance <= 2 and ped ~= LocalPlayer().Ped and ped ~= oldped then
                                                    oldped = ped
                                                    SetEntityAsMissionEntity(ped)
                                                    TaskStandStill(ped, 9.0)
                                                    pos1 = GetEntityCoords(ped)
                                                    TaskGoToEntity(ped, LocalPlayer().Ped, -1, 1.0, 0.5, 1073741824, 0)
                                                    PlayAmbientSpeech2(ped, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
                                                    DrugNPC.Sub = "~b~Client : ~g~Salut mec"
                                                    TaskLookAtEntity(ped, LocalPlayer().Ped, -1, 2048, 3)
                                                    DrugNPC.CurrentNPC = ped

                                                    Citizen.CreateThread(
                                                        function()
                                                            Wait(250)
                                                            DrugNPC.Sub = "~b~Client : ~g~ C'est quoi le deal ?"
                                                        end
                                                    )
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    until not success
                    EndFindPed(handle)

                --     local dist = target and GetDistanceBetweenCoords(GetEntityCoords(target), plyPos, true)

                --     if isCompatiblePed(target) and dist < 6 then

                --             ClearPedTasksImmediately(target)
                --             SetBlockingOfNonTemporaryEvents(target, true)
                --             TaskStandStill(target, 30000)

                --             if blipPed and DoesBlipExist(blipPed) then
                --                 RemoveBlip(blipPed)
                --                 blipPed = nil
                --             end

                --             blipPed = AddBlipForEntity(target)
                --             SetBlipAsFriendly(blipPed, true)
                --             SetBlipColour(blipPed, 2)
                --             SetBlipCategory(blipPed, 3)

                --             SetPedRelationshipGroupHash(target, GetHashKey("PLAYER"))
                --             TaskGoToEntity(target, ped, -1, 1.0, 0.5, 1073741824, 0)
                --             PlayAmbientSpeech2(target, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
                --             DrugNPC.CurrentNPC = target
                --             stageDrug = 2
                --             DrugNPC.Sub = "~b~Client: ~w~Hey mec"
                --             TaskLookAtEntity(drugPed, ped, -1, 2048, 3)
                --             break

                --     else
                --         DrugNPC.Sub ="~r~Vous êtes à la recherche de clients.."
                --     end

                -- if DoesEntityExist(ped) and not found then
                --     if IsPedDeadOrDying(ped) == false then
                --         if IsPedInAnyVehicle(ped) == false then
                --             local pedType = GetPedType(ped)

                --             -- if pedType ~= 28 and IsPedAPlayer(ped) == false then
                --             --     print("found")
                --             --     coords = LocalPlayer().Pos
                --             --     ClearPedTasksImmediately(ped)
                --             --     iencliPos = coords

                --             --     --TaskGoToEntity(ped,LocalPlayer().Ped,-1,1,0.5)
                --             --     TaskGoStraightToCoord(ped,coords,0.5,999999)

                --             --     DrugNPC.Sub  = "~b~Client : ~s~Salut man ! T'as quelque chose pour moi ?"
                --             --     SetEntityDynamic(ped, false)
                --             --     SetBlockingOfNonTemporaryEvents(ped, true)
                --             --     SetPedAlertness(ped,0)

                --             --     DrugNPC.CurrentNPC = ped
                --             -- end
                --         end
                --     end
                -- end
                end
            end
        end
    end
)

function ResetNPCDRUG()
    DrugNPC = {
        selling = false,
        CurrentDrug = nil,
        Count = 0
    }
end
