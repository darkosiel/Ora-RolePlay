local isWorking = false
local data = {}
local works = 0
local Players = {}
local function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

local function ShowNotification(msg)
    RageUI.Popup({message = msg})
end

local worksP = {
    recolte = {
        fct = function()
            if Player.FarmLimit == nil then
                Player.FarmLimit = 0
            end
            --if Player.FarmLimit <= 400 then
                showMessageInformation("~b~Récolte en cours...", 5500)
                Wait(5500)
            --[[ else
                showMessageInformation("~r~Vous avez atteint la limite de farm", 5500)
            end ]]
        end
    },
    traitement = {
        fct = function()
            found = false
            if type(data.required) ~= "table" then
                if Ora.Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Ora.Inventory:GetItemCount(data.required[i].name) - data.required[i].count <= 0 then
                        ShowNotification("~r~Pas assez de " .. Items[data.required[i].name].label)
                        StopCurrentWork()
                        return
                    else
                        found = true
                    end
                end
            end
            if found then
                showMessageInformation("~b~Traitement en cours...", 5500)
                Wait(5500)
                if Player.FarmLimit == nil then
                    Player.FarmLimit = 0
                end

                if (data ~= nil) then
                    if (data.noFarm ~= nil) then
                        if (data.noFarm == true) then
                            -- nothing
                        else
                            SetFarmLimit(1)
                        end
                    else
                        SetFarmLimit(1)
                    end
                else
                    SetFarmLimit(1)
                end
            else
                ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                StopCurrentWork()
                return
            end
        end
    },
    vente = {
        fct = function()
            found = false
            if type(data.required) ~= "table" then
                if Ora.Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Ora.Inventory:GetItemCount(data.required[i].name) - data.required[i].count <= 0 then
                        ShowNotification("~r~Pas assez de " .. Items[data.required[i].name].label)
                        StopCurrentWork()
                        break
                        return
                    else
                        found = true
                    end
                end
            end
            if found then
                showMessageInformation("~g~Vente en cours...", 2000)
                Wait(2000)
            else
                ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                StopCurrentWork()
                return
            end
        end
    }
}

Citizen.CreateThread(
    function()
        while true do
            Wait(2000)
            Player = LocalPlayer()
        end
    end
)
local function animsAction(animObj)
    Citizen.CreateThread(
        function()
            if not playAnim then
                local playerPed = LocalPlayer().Ped
                if DoesEntityExist(playerPed) then
                    -- Ckeck if ped exist
                    dataAnim = animObj

                    -- Play Animation
                    if dataAnim.lib == nil then
                        if dataAnim.scenario ~= nil then
                            TaskStartScenarioInPlace(LocalPlayer().Ped, dataAnim.scenario)
                        end
                    else
                        RequestAnimDict(dataAnim.lib)
                        while not HasAnimDictLoaded(dataAnim.lib) do
                            Citizen.Wait(0)
                        end
                        if HasAnimDictLoaded(dataAnim.lib) then
                            local flag = 0
                            if dataAnim.loop ~= nil and dataAnim.loop then
                                flag = 1
                            elseif dataAnim.move ~= nil and dataAnim.move then
                                flag = 49
                            end

                            TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                            playAnimation = true
                        end
                    end
                    -- Wait end annimation
                    while true do
                        Citizen.Wait(0)
                        if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                            playAnim = false
                            TriggerEvent("ft_animation:ClFinish")
                            break
                        end
                    end
                end -- end ped exist
            end
        end
    )
end
function ResetFarm()
    works = 0
    Hint:RemoveAll()
    isWorking = false
    data = nil
end

function randomChange(percent) -- returns true a given percentage of calls
    assert(percent >= 0 and percent <= 100) -- sanity check
    return percent >= math.random(1, 100) -- 1 succeeds 1%, 50 succeeds 50%,
end

function StartRecolte(_type)
    -- Permet de stopper l'action en appuyant sur E
    if works == 0 then
        Hint:RemoveAll()
        if _type == "Jobs" then
            KeySettings:Clear("keyboard", "E", Ora.Identity.Job.CurrentAction)
            KeySettings:Clear("controller", 46, Ora.Identity.Job.CurrentAction)
            KeySettings:Add("keyboard", "E", StopCurrentWork, Ora.Identity.Job.CurrentAction)
        else
            KeySettings:Clear("keyboard", "E", Ora.Identity.Orga.CurrentAction)
            KeySettings:Clear("controller", 46, Ora.Identity.Orga.CurrentAction)
            KeySettings:Add("keyboard", "E", StopCurrentWork, Ora.Identity.Orga.CurrentAction)
        end
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ~r~stopper~s~ l'action")

        isWorking = true
        if isWorking then
            works = 1
            -- indexation du job (si farm orga ou pas)
            if _type == "Jobs" then
                data = Ora.Identity.Job.Data.work[Ora.Identity.Job.CurrentAction]
            else
                data = Ora.Identity.Orga.Data.work[Ora.Identity.Orga.CurrentAction]
            end
            Player = LocalPlayer()
            CurrentAction6 = Ora.Identity.Job.CurrentAction
            Citizen.CreateThread(
                function()
                    -- check si on a de la place
                    if data ~= nil then
                        if data.giveitem ~= nil then
                            if type(data.giveitem) ~= "table" then
                                if not Ora.Inventory:CanReceive(data.giveitem, 1) then
                                    StopCurrentWork()
                                    return
                                end
                            else
                                for hh = 1, #data.giveitem, 1 do
                                    if type(data.giveitem[hh].count) == "table" then
                                        data.giveitem[hh].count =
                                            math.random(data.giveitem[hh].count[1], data.giveitem[hh].count[2])
                                    end
                                    if not Ora.Inventory:CanReceive(data.giveitem[hh].name, data.giveitem[hh].count) then
                                        StopCurrentWork()
                                        return
                                    end
                                end
                            end
                        end
                        -- animation
                        if data.anim ~= nil then
                            animsAction(data.anim)
                        end
                        if LocalPlayer().FarmLimit >= 600 and tostring(data.type) == "traitement" then
                            return ShowNotification("~r~Vous avez atteint votre limite journalière")
                        end
                        worksP[tostring(data.type)].fct()

                        if isWorking then
                            if data.giveitem ~= nil then
                                if data.giveitemType == nil or data.giveitemType == 0 then
                                    if type(data.giveitem) ~= "table" then
                                        item = {name = data.giveitem}
                                        Ora.Inventory:AddItem(item)
                                    else
                                        for hh = 1, #data.giveitem, 1 do
                                            if type(data.giveitem[hh].count) == "table" then
                                                data.giveitem[hh].count =
                                                    math.random(data.giveitem[hh].count[1], data.giveitem[hh].count[2])
                                            end
                                            for i = 1, data.giveitem[hh].count, 1 do
                                                item = {name = data.giveitem[hh].name}
                                                Ora.Inventory:AddItem(item)
                                            end
                                        end
                                    end
                                elseif data.giveitemType == 1 then
                                    local give = nil
                                    repeat
                                        for hh = 1, #data.giveitem, 1 do
                                            if randomChange(data.giveitem[hh].chanceDrop) then
                                                give = data.giveitem[hh]
                                            end
                                        end
                                    until give ~= nil
                                    if type(give.count) == "table" then
                                        math.randomseed(GetGameTimer())
                                        give.count = math.random(give.count[1], give.count[2])
                                    end
                                    for i = 1, give.count, 1 do
                                        item = {name = give.name}
                                        Ora.Inventory:AddItem(item)
                                    end
                                elseif data.giveitemType == 2 then
                                    local dropElement = nil
                                    math.randomseed(GetGameTimer())
                                    dropElement = math.random(0, 1000)
                                    local itemsCount = #data.giveitem
                                    math.randomseed(GetGameTimer())
                                    local itemDrop = data.giveitem[math.random(itemsCount)]
                                    local itemDropValue = 1000 - itemDrop.drop * 10

                                    if (dropElement > itemDropValue) then
                                        Ora.Inventory:AddItem({name = itemDrop.name})
                                        math.randomseed(GetGameTimer())
                                        ShowNotification(
                                            "[" ..
                                                math.random(0, 1000) ..
                                                    "]~h~Vous avez reçu ~g~1x " .. Items[itemDrop.name].label .. "~s~"
                                        )
                                    else
                                        math.randomseed(GetGameTimer())
                                        ShowNotification(
                                            "[" .. math.random(0, 1000) .. "] ~h~~r~Vous n'avez rien reçu~s~"
                                        )
                                    end
                                end
                            end

                            if data.required ~= nil then
                                if type(data.required) ~= "table" then
                                    -- supprime un objet aléatoire
                                    Ora.Inventory:RemoveAnyItemsFromName(data.required, 1)
                                else
                                    for hh = 1, #data.required, 1 do
                                        for k, v in pairs(Ora.Inventory.Data) do
                                            if k == data.required[hh].name then
                                                for cc = 1, data.required[hh].count, 1 do
                                                    --TriggerServerEvent("inventory:RemoveItem",v[1].id,data.required[hh].name)
                                                    Ora.Inventory:RemoveItem({id = v[1].id, name = data.required[hh].name})
                                                end
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                            -- Give d'argent
                            if data.price ~= nil then
                                if Ora.Identity.Job.Data.FreeAccess then
                                    TriggerServerCallback(
                                        "Ora::SE::Money:AuthorizePayment", 
                                        function(token)
                                            TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = data.price, SOURCE = "Farm Job non WL", LEGIT = true})
                                            TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", data.price, false)
                                        end,
                                        {}
                                    )
                                else
                                    if _type == "Jobs" then
                                        TriggerServerEvent("business:AddFromTreasury", Ora.Identity.Job:GetName(), data.price)
                                        TriggerServerEvent("business:SetProductivity", GetPlayerServerId(PlayerId()), Ora.Identity.Job:GetName(), data.price, true)
                                    else
                                        TriggerServerEvent("business:AddFromTreasury", Ora.Identity.Orga:GetName(), data.price)
                                        TriggerServerEvent("business:SetProductivity", GetPlayerServerId(PlayerId()), Ora.Identity.Orga:GetName(), data.price, true)
                                    end
                                end
                            end
                            showMessageInformation(data.add, 1000)
                            Wait(400)
                            works = 0
                            StartRecolte(_type)
                        end
                        works = 0
                    end
                end
            )
        end
    end
end

function StopCurrentWork(bool)
    isWorking = false
    showMessageInformation("~r~Vous avez arrêté votre action", 4000)
    -- Sauvegarde de la limite de farm
    local Player = LocalPlayer()
    TriggerServerEvent("core:SaveLimitFarm", Player.FarmLimit)
    local ped = LocalPlayer().Ped
    if ped then
        ClearPedTasks(ped)
    end
    -- Reset de la zone
    Hint:RemoveAll()
    ResetFarm()
    if bool == nil then
        Hint:RemoveAll()
        --     Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
        KeySettings:Clear("keyboard", "E", Ora.Identity.Job.CurrentAction)
        KeySettings:Clear("controller", 46, Ora.Identity.Job.CurrentAction)
    end
end

Citizen.CreateThread(
    function()
        while true do
            Players = LocalPlayer()
            Wait(1)
        end
    end
)
