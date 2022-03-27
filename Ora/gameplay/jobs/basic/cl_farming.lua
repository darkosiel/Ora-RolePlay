local CurrentZone
local currentData
local works = 0
local CurrentAction
local isWorking = false
local wannaSTOP = false
local function farmStart()
    --print("1")
    startwork(CurrentZone)
end
local function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()

    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end
local function StopCurrentWork(bool)
    isWorking = false
    works = 0
    CurrentData = nil
    wannaSTOP = not wannaSTOP

    --print("works to false")

    showMessageInformation("~r~Vous avez arrêté votre action", 4000)
    -- Sauvegarde de la limite de farm
    --TriggerServerEvent("core:SaveLimitFarm",Player.FarmLimit)
    local ped = LocalPlayer().Ped
    if ped then
        ClearPedTasks(ped)
    end
    -- Reset de la zone
    Hint:RemoveAll()
    KeySettings:Clear("controller", "E", CurrentAction)
    KeySettings:Clear("keyboard", "E", CurrentAction)

    KeySettings:ClearAll("E")
    -- Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
    -- KeySettings:Add("keyboard","E",startwork,CurrentAction)
    -- KeySettings:Add("controller","E",startwork,CurrentAction)
end
local function StopCurrentWork2(bool)
    --print("works to falseX")
    if isWorking then
        isWorking = false
        works = 0
        CurrentData = nil
        wannaSTOP = not wannaSTOP
        showMessageInformation("~r~Vous avez arrêté votre action", 4000)
        -- Sauvegarde de la limite de farm
        --TriggerServerEvent("core:SaveLimitFarm",Player.FarmLimit)
        local ped = LocalPlayer().Ped
        if ped then
            ClearPedTasks(ped)
        end
        -- Reset de la zone
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", "CurrentAction")
        KeySettings:Clear("controller", "E", "CurrentAction")
    end
end

Citizen.CreateThread(
    function()
        local jobsFctPublique = {"police", "sams", "lssd", "lsfd"}

        while Ora.Player.HasLoaded == false do
            Wait(50)
        end

        while true do
            Wait(20 * 60000)
            if Ora.Service:isInService(Ora.Identity.Job:GetName()) then
                if (Ora.Identity.Job:GetSalary() >= 50) then
                    ShowNotification("Voici votre salaire : ~b~" .. Ora.Identity.Job:GetSalary() .. "$")
                    TriggerServerEvent("Ora:sendToDiscord", 30, Ora.Identity.Job:GetSalary() .. "$ pour le métier " .. Ora.Identity.Job:GetName(), "info")
                    TriggerServerEvent("Ora::SE::Player:AddToSessionData", "SALARY_DETAILS", Ora.Identity.Job:GetSalary() .. "$ pour le métier " .. Ora.Identity.Job:GetName())
                    TriggerServerEvent("Ora::SE::Player:AddToSessionData", "SALARY_TOTAL", math.tointeger(Ora.Identity.Job:GetSalary()))
                end
                TriggerServerCallback(
                    "Ora::SE::Money:AuthorizePayment",
                    function(token)
                        TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = Ora.Identity.Job:GetSalary(), SOURCE = "Salaire JOB", LEGIT = true})
                        for i = 1, #jobsFctPublique do
                            if (Ora.Identity.Job:GetName() == jobsFctPublique[i]) then
                                TriggerServerEvent("Ora:RemoveFromBankAccount", "gouvernement", Ora.Identity.Job:GetSalary())
                                break
                            end
                        end
                    end,
                    {}
                )
            end
            if Ora.Identity.Orga:GetName() ~= "chomeur" and Ora.Service:isInService(Ora.Identity.Orga:GetName()) then
                if (Ora.Identity.Orga:GetSalary() >= 50) then
                    ShowNotification("Voici votre salaire : ~b~" .. Ora.Identity.Orga:GetSalary() .. "$")
                    TriggerServerEvent("Ora:sendToDiscord", 30, Ora.Identity.Orga:GetSalary() .. "$ pour le métier " .. Ora.Identity.Orga:GetName(), "info")
                    TriggerServerEvent("Ora::SE::Player:AddToSessionData", "SALARY_DETAILS", Ora.Identity.Orga:GetSalary() .. "$ pour le métier " .. Ora.Identity.Orga:GetName())
                    TriggerServerEvent("Ora::SE::Player:AddToSessionData", "SALARY_TOTAL", math.tointeger(Ora.Identity.Orga:GetSalary()))
                end
                TriggerServerCallback(
                    "Ora::SE::Money:AuthorizePayment", 
                    function(token)
                        TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = Ora.Identity.Orga:GetSalary(), SOURCE = "Salaire ORGA", LEGIT = true})
                        for i = 1, #jobsFctPublique do
                            if (Ora.Identity.Orga:GetName() == jobsFctPublique[i]) then
                                TriggerServerEvent("Ora:RemoveFromBankAccount", "gouvernement", Ora.Identity.Orga:GetSalary())
                                break
                            end
                        end
                    end,
                    {}
                )
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(60000)
            if collectgarbage("count") > 13000 then
                collectgarbage()
            end
        end
    end
)
local function Setup()
    for _k, v in pairs(PublicFarm) do
        for k, v in pairs(v) do
            if v.blip ~= "none" then
                local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
                SetBlipSprite(blip, 1)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.8)
                SetBlipColour(blip, v.blipcolor)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.blipname)
                EndTextCommandSetBlipName(blip)
            end
            --     --(dump(v))
            Zone:Add(
                v.Pos,
                function()
                    CurrentData = PublicFarm[_k][k]
                    wannaSTOP = false
                    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                    KeySettings:Add("keyboard", "E", farmStart, k)
                    KeySettings:Add("controller", "E", farmStart, k)
                    CurrentZone = Type
                    CurrentAction = k
                end,
                function()
                    Hint:RemoveAll()
                    KeySettings:Clear("keyboard", "E", k)
                    KeySettings:Clear("controller", "E", k)

                    KeySettings:Clear("keyboard", "E", "CurrentAction")
                    CurrentZone = nil
                    CurrentData = nil
                    CurrentAction = nil
                    isWorking = false
                    StopCurrentWork2()
                end,
                k,
                v.workSize or 1.5
            )
        end
    end
end

local worksP = {
    recolte = {
        fct = function()
            showMessageInformation("~b~Récolte en cours...", 5500)
            Wait(5500)
            --print("ok")
        end
    },
    traitement = {
        fct = function()
            found = false
            if _type(data.required) ~= "table" then
                if Ora.Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Ora.Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
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
                --   Player.FarmLimit = Player.FarmLimit + 1
                if (data.noFarm ~= nil) then
                    if (data.noFarm == true) then
                        -- nothing
                    else
                        SetFarmLimit(1)
                    end
                else
                    SetFarmLimit(1)
                end
            end
        end
    },
    vente = {
        fct = function()
            found = false
            if _type(data.required) ~= "table" then
                if Ora.Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Ora.Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
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
                showMessageInformation("~b~Vente en cours...", 2000)
                Wait(2000)
            else
                ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                StopCurrentWork()
                return
            end
        end
    }
}

local function animsAction(animObj)
    Citizen.CreateThread(
        function()
            if not playAnim then
                local playerPed = LocalPlayer().Ped
                if DoesEntityExist(playerPed) then
                    -- Ckeck if ped exist
                    dataAnim = animObj

                    -- Play Animation
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
function _type(d)
    return type(d)
end

function startwork(type)
    local limit = 50

    if (currentData == nil) then
        for i = 1, limit, 1 do
            Wait(50)
            if (CurrentData ~= nil) then
                break
            end
        end
        if (CurrentData == nil) then
            ShowNotification("~h~~r~Veuillez ressortir et re-rentrer sur le point. Merci~h~~s~")
            return false
        end
    end

    if (CurrentData.closedHours ~= nil and _type(CurrentData.closedHours) == "table") then
        TriggerServerCallback(
            "publicFarm:isOpen",
            function(bool)
                if (bool == true) then
                    startworkInternal(type)
                else
                    if (CurrentData.closedHoursMessage ~= nil) then
                        ShowNotification("~h~~r~" .. CurrentData.closedHoursMessage .. "~h~~s~")
                    else
                        ShowNotification("~h~~r~Cette recolte est fermée pour le moment, repassez plus tard~h~~s~")
                    end
                end
            end,
            CurrentData.closedHours
        )
    else
        startworkInternal(type)
    end
end

function startworkInternal(type)
    -- Permet de stopper l'action en appuyant sur E
    if works == 0 then
        Hint:RemoveAll()
        if CurrentData ~= nil then
            KeySettings:Clear("keyboard", "E", CurrentAction)
            KeySettings:Clear("controller", "E", CurrentAction)

            Citizen.CreateThread(
                function()
                    Wait(800)
                    KeySettings:Add("keyboard", "E", StopCurrentWork, "CurrentAction")
                    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ~r~stopper~s~ l'action")
                end
            )
            isWorking = true

            --print("works to true")
            if isWorking and CurrentData ~= nil and not wannaSTOP then
                works = 1
                -- indexation du job (si farm orga ou pas)

                data = CurrentData
                Player = LocalPlayer()
                CurrentAction6 = CurrentAction

                Citizen.CreateThread(
                    function()
                        -- check si on a de la place

                        -- animation
                        if data.anim ~= nil and not wannaSTOP then
                            animsAction(data.anim)
                        end
                        if isWorking and not wannaSTOP then
                            if
                                data.giveitemType ~= 2 and data.giveitem ~= nil and
                                not Ora.Inventory:CanReceive(data.giveitem, 1)
                             then
                                StopCurrentWork2()
                                ClearPedTasks(LocalPlayer().Ped)
                            end
                            if isWorking and not wannaSTOP then
                                if LocalPlayer().FarmLimit >= 400 and tostring(CurrentAction) ~= "vente" then
                                    StopCurrentWork2()
                                    return ShowNotification("~r~Vous avez atteint votre limite journalière")
                                end
                                if data.required ~= nil then
                                    if _type(data.required) ~= "table" then
                                        if Ora.Inventory:GetItemCount(data.required) > 0 then
                                            Ora.Inventory:RemoveFirstItem(data.required)
                                        else
                                            ShowNotification("~r~Pas assez de " .. Items[data.required].label .. "~s~")
                                            return
                                        end
                                    else
                                        local stopProcess = false
                                        for verificationIterate = 1, #data.required, 1 do
                                            if
                                            Ora.Inventory:GetItemCount(data.required[verificationIterate].name) -
                                                    data.required[verificationIterate].count <
                                                    0
                                             then
                                                ShowNotification(
                                                    "~r~Pas assez de " ..
                                                        Items[data.required[verificationIterate].name].label .. "~s~"
                                                )
                                                stopProcess = true
                                            end
                                        end

                                        if (stopProcess == true) then
                                            return
                                        end

                                        for hh = 1, #data.required, 1 do
                                            for cc = 1, data.required[hh].count, 1 do
                                                Ora.Inventory:RemoveFirstItem(data.required[hh].name)
                                            end
                                        end
                                    end
                                end
                                worksP[tostring(CurrentAction)].fct()
                                if data.giveitem ~= nil then
                                    if data.giveitemType == 2 then
                                        math.randomseed(GetGameTimer() * math.random(1000))
                                        local dropChance = math.random(0, 1000)
                                        local itemsCount = #data.giveitem
                                        math.randomseed(GetGameTimer() * math.random(1000))
                                        local itemDrop = data.giveitem[math.random(itemsCount)]
                                        local itemDropValue = 1000 - itemDrop.drop * 10
                                        if (dropChance > itemDropValue) then
                                            Ora.Inventory:AddItem({name = itemDrop.name})
                                            math.randomseed(GetGameTimer() * math.random(1000))
                                            ShowNotification(
                                                "[" ..
                                                    math.random(0, 1000) ..
                                                        "] ~h~Vous avez reçu ~g~1x " ..
                                                            Items[itemDrop.name].label .. "~s~"
                                            )
                                        else
                                            math.randomseed(GetGameTimer() * math.random(1000))
                                            ShowNotification(
                                                "[" .. math.random(0, 1000) .. "] ~h~~r~Vous n'avez rien reçu~s~"
                                            )
                                        end
                                    else
                                        item = {name = data.giveitem}
                                        if (data.copsQuality ~= nil) then
                                            if (data.copsQuality == true) then

                                                TriggerServerCallback(
                                                    "Ora::SE::Service:GetTotalServiceCountForJobs",
                                                    function(allcount)
                                                        if allcount == 2 then
                                                            item["data"] = {quality = 35}
                                                            item["label"] = "Qualité basse"
                                                        elseif (allcount > 2 and allcount <= 4) then
                                                            item["label"] = "Qualité moyenne"
                                                            item["data"] = {quality = 49}
                                                        elseif (allcount > 4 and allcount <= 6) then
                                                            item["data"] = {quality = 74}
                                                            item["label"] = "Qualité bonne"
                                                        elseif (allcount > 6 and allcount <= 8) then
                                                            item["data"] = {quality = 90}
                                                            item["label"] = "Qualité excellente"
                                                        elseif (allcount > 8) then
                                                            item["data"] = {quality = 100}
                                                            item["label"] = "Qualité inégalable"
                                                        else
                                                            item["data"] = {quality = 10}
                                                            item["label"] = "Qualité merdique"
                                                        end
                                                        Ora.Inventory:AddItem(item)
                                                    end,
                                                    {"police", "lssd"}
                                                )
                                            end
                                        else
                                            Ora.Inventory:AddItem(item)
                                            math.randomseed(GetGameTimer() * math.random(1000))
                                            ShowNotification(
                                                "[" ..
                                                    math.random(0, 1000) ..
                                                        "] ~h~Vous avez reçu ~g~1x " .. Items[item.name].label .. "~s~"
                                            )
                                        end
                                    end
                                end
                                if data.price ~= nil then
                                    TriggerServerCallback(
                                        "Ora::SE::Money:AuthorizePayment", 
                                        function(token)
                                            TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = data.price, SOURCE = "Farm", LEGIT = true})
                                            TriggerServerEvent("Ora:RemoveFromBankAccount", "centralbank", data.price, false)
                                        end,
                                        {}
                                    )
                                end
                                showMessageInformation(data.add, 1000)
                                Wait(400)
                                works = 0
                                startwork(type)
                            end
                        end
                        works = 0
                    end
                )
            end
        end
    else
        StopCurrentWork2()
        works = 0
    end
    wannaSTOP = false
end

Citizen.CreateThread(
    function()
        Setup()
    end
)
