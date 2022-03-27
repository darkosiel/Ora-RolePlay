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

GetPlayers = function()
    local players = {}

    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)

        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end

    return players
end

local max = 1.5
function GetPlayerServerIdInDirection(range)
    local ped, closestPlayer = PlayerPedId()
    local playerPos, playerForward = GetEntityCoords(ped), GetEntityForwardVector(ped)
    playerPos = playerPos + (addVector or playerForward * 0.5)

    for _, v in pairs(GetActivePlayers()) do
        local otherPed = GetPlayerPed(v)
        local otherPedPos = otherPed ~= ped and IsEntityVisible(otherPed) and GetEntityCoords(otherPed)
        if otherPed ~= PlayerPedId() then
            if
                otherPedPos and GetDistanceBetweenCoords(otherPedPos, playerPos) <= (d or max) and
                    (not closestPlayer or GetDistanceBetweenCoords(otherPedPos, playerPos))
             then
                closestPlayer = v
            end
        end
    end
    --  print(GetPlayerPed(closestPlayer),PlayerPedId())
    return closestPlayer ~= nil and GetPlayerServerId(closestPlayer) or false
end

function GetPlayers()
    local players = {}
    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            players[#players + 1] = i
        end
    end
    return players
end

function CastRayPlayerPedToPoint(range, type)
    local playerPed = GetPlayerPed()
    local playerCoords = LocalPlayer().Position
    local entityWorld = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, range, 0.0)
    local rayHandle =
        StartShapeTestRay(
        playerCoords.x,
        playerCoords.y,
        playerCoords.z,
        entityWorld.x,
        entityWorld.y,
        entityWorld.z,
        type,
        playerPed,
        0
    )
    local a, b, c, d, entity = GetRaycastResult(rayHandle)
    if entity ~= nil then
        return entity
    end
    return false
end

function GetEntityInDirection(range)
    if type(range) ~= "number" then
        range = 20.0
    end
    return CastRayPlayerPedToPoint(range, 10)
end

function GetPedInDirection(range)
    if type(range) ~= "number" then
        range = 20.0
    end
    local entity = GetEntityInDirection(range)
    if DoesEntityExist(entity) then
        if GetEntityType(entity) == 1 then
            return entity
        end
    end
    return false
end

local armed = false
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            found = false
            pp = GetSelectedPedWeapon(LocalPlayer().Ped)
            if pp ~= GetHashKey("WEAPON_Unarmed") then
                armed = true
                for k, v in pairs(weapon_name) do
                    Wait(200)
                    if GetHashKey(v) == pp then
                        if Ora.Inventory.Data[k] ~= nil and #Ora.Inventory.Data[k] == 0 and not onShooting then
                            RemoveWeaponFromPed(LocalPlayer().Ped, pp)
                        elseif Ora.Inventory.Data[k] == nil and not onShooting then
                            RemoveWeaponFromPed(LocalPlayer().Ped, pp)
                        end
                    end
                end
                Wait(1000)
            else
                armed = false
            end
            Wait(10)
        end
    end
)

AddEventHandler(
    "Ora:EditTel",
    function()
        RageUI.Visible(RMenu:Get("phone", "choose_card"), true)
    end
)

RMenu.Add("phone", "choose_card", RageUI.CreateMenu("Ora", "Cartes bancaire disponibles", 10, 200))

Citizen.CreateThread(
    function()
        SetMinimapComponent(15, true, -1)
        SetAudioFlag("WantedMusicDisabled", false)
        SetThisScriptCanRemoveBlipsCreatedByAnyScript(true)
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("phone", "choose_card")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        for __i = 1, #Ora.Inventory.Data["bank_card"], 1 do
                            RageUI.Button(
                                Items["bank_card"].label .. " #" .. Ora.Inventory.Data["bank_card"][__i].data.number,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local code = KeyboardInput("Veuillez entrer le code", nil, 4)
                                        code = tonumber(code)
                                        if code ~= nil then
                                            if code == Ora.Inventory.Data["bank_card"][__i].data.code then
                                                for _i = 1, #Ora.Inventory.Data["tel"], 1 do
                                                    local x = Ora.Inventory.Data["tel"][_i]
                                                    if x.id == currPh then
                                                        if x.data.accounts == nil then
                                                            x.data.accounts = {}
                                                        end
                                                        local f = false
                                                        for i = 1, #x.data.accounts, 1 do
                                                            if
                                                                x.data.accounts[i].account ==
                                                                    Ora.Inventory.Data["bank_card"][__i].data.account
                                                             then
                                                                f = true
                                                                TriggerEvent('Ora:InvNotification', "Carte déjà liée", "error")
                                                            end
                                                        end
                                                        if not f then
                                                            table.insert(
                                                                x.data.accounts,
                                                                Ora.Inventory.Data["bank_card"][__i].data
                                                            )
                                                            TriggerEvent('Ora:InvNotification', "Carte liée")
                                                        end

                                                        CloseAllMenus()
                                                        break
                                                    end
                                                end
                                            else
                                                TriggerEvent('Ora:InvNotification', "Code incorrect", "error")
                                            end
                                        end
                                    end
                                end
                            )
                        end
                    end
                )
            end
        end
    end
)

exports(
    "getCurrentTel",
    function()
        for i = 1, #Ora.Inventory.Data["tel"], 1 do
            local x = Ora.Inventory.Data["tel"][i]
            if x.id == currPh then
                if x.data.accounts == nil then
                    x.data.accounts = {}
                end
                return x.data.accounts
            end
        end
    end
)

RegisterNetEvent("DeleteCard")
AddEventHandler(
    "DeleteCard",
    function(id)
        for i = 1, #Ora.Inventory.Data["tel"], 1 do
            local x = Ora.Inventory.Data["tel"][i]
            if x.id == currPh then
                table.remove(x.data.accounts, id + 1)
            end
        end
    end
)

exports(
    "GetItemsData",
    function()
        return Items
    end
)
