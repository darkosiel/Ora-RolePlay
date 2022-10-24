RMenu.Add("storage", "fouiller_joueur", RageUI.CreateMenu("Joueur", "~g~Objets disponibles"))

local function CanBeFouilled(ped, id)
    if GetVehiclePedIsIn(LocalPlayer().Ped) == 0 then
        if IsPlyHandsup(id) or IsPedRagdoll(ped) or IsPlyHandcuff(id) then
            return true
        else
            return false
        end
    else
        return false
    end
end

local currPlayerInv = {}
local accounts = {}
local targetInv = nil

RegisterNetEvent("SearchPlayer")
AddEventHandler("SearchPlayer", function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    if CanBeFouilled(data.entity, playerId) then
        TriggerPlayerEvent("RageUI:Popup", playerId, {message = "~b~Vous êtes en train de vous faire fouiller"})
        exports['Ora_utils']:sendME("* L'individu fouille quelqu'un *")
        TriggerServerCallback("getInventoryOtherPPL", function(Inv, Money, black_money)
            currPlayerInv = json.decode(Inv)
            TriggerEvent('Ora:inventoryFouille', currPlayerInv)
            TriggerServerEvent("Ora:sendToDiscord", 4, "Fouille " .. Ora.Identity:GetFullname(playerId))
        end, playerId)
    end
end)

exports("CanSearchPlayer", CanBeFouilled)

exports.qtarget:Player({
    options = {
        {
            event = "SearchPlayer",
            icon = "fas fa-search",
            label = "Fouiller",
            canInteract = function(entity)
                local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                if exports.Ora:CanSearchPlayer(entity, playerId) then
                    return true
                else
                    return false
                end
            end
        }
    },
    distance = 1.0
})

local function Fouiller()
    local closestPly = GetPlayerServerIdInDirection(8.0)

    if closestPly ~= false then
        local player = GetPlayerFromServerId(closestPly)
        local pedT = GetPlayerPed(player)
        if CanBeFouilled(pedT, closestPly) then
            TriggerPlayerEvent("RageUI:Popup", closestPly, {message = "~b~Vous êtes en train de vous faire fouiller"})
            exports['Ora_utils']:sendME("* L'individu fouille quelqu'un *")
            TriggerServerCallback(
                "getInventoryOtherPPL",
                function(Inv, Money, black_money)
                    currPlayerInv = json.decode(Inv)
                    TriggerEvent('Ora:inventoryFouille', currPlayerInv)
                    TriggerServerEvent(
                        "Ora:sendToDiscord",
                        4,
                        "Fouille " .. Ora.Identity:GetFullname(closestPly)
                    )
                end,
                closestPly
            )
        end
    end
end

function FouilleAdmin(id)
    local closestPly = id
    if closestPly ~= false then
        local player = GetPlayerFromServerId(closestPly)
        local pedT = GetPlayerPed(player)
        targetInv = closestPly
        TriggerServerCallback(
            "getInventoryOtherPPL",
            function(Inv, Money, black_money)
                currPlayerInv = json.decode(Inv)
                TriggerServerEvent(
                    "Ora:sendToDiscord",
                    4,
                    "Fouille " .. Ora.Identity:GetFullname(closestPly)
                )
                RageUI.Visible(RMenu:Get("storage", "fouiller_joueur"), true)
            end,
            closestPly
        )
    end
end

RegisterCommand(
    "+fouille",
    function()
        Fouiller()
    end,
    false
)
RegisterCommand(
    "-fouille",
    function()
        Fouiller()
    end,
    false
)
RegisterCommand(
    "fouille",
    function()
        Fouiller()
    end,
    false
)
RegisterKeyMapping("fouille", "Fouiller", "keyboard", "K")

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            --    HoverPlayer()
            if RageUI.Visible(RMenu:Get("storage", "fouiller_joueur")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(currPlayerInv) do
                            if #v > 0 then
                                RageUI.Button(
                                    Items[k].label,
                                    nil,
                                    {RightLabel = #v},
                                    true,
                                    function(_, _, S)
                                        if S then
                                            local count = KeyboardInput("Combien?")
                                            if
                                                tonumber(count) ~= nil and tonumber(count) <= #v and
                                                Ora.Inventory:CanReceive(k, tonumber(count))
                                             then
                                                TriggerServerEvent(
                                                    "Ora:sendToDiscord",
                                                    4,
                                                    "Vole " ..
                                                        count ..
                                                            "x " ..
                                                                Items[v[1].name].label ..
                                                                    " à " ..
                                                                    Ora.Identity:GetFullname(targetInv)
                                                )
                                                for i = 1, count, 1 do
                                                    items = v[i]
                                                    Ora.Inventory:AddItem(items)
                                                    TriggerPlayerEvent("Ora::CE::Inventory:RemoveItem", targetInv, {id = v[i].id, name = k})
                                                    RageUI.Visible(RMenu:Get("storage", "fouiller_joueur"), false)
                                                end
                                            end
                                        end
                                    end
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)
