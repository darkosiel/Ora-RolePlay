local ObjArray = {
    ["prop_dumpster_01a"] = {},
	["prop_dumpster_02a"] = {},
	["prop_dumpster_02b"] = {},
	["prop_dumpster_4a"] = {},
    ["prop_burgerstand_01"] = {
        {name = "icecream", price = 10},
        {name = "burger", price = 50},
    },
    ["prop_hotdogstand_01"] = {
        {name = "icecream", price = 10},
        {name = "Hhotdog", price = 20},
    },
    ["prop_vend_coffe_01"] = {
        {name = "cafe", price = 3},
        {name = "thevert", price = 3},
    },
    ["p_ld_coffee_vend_01"] = {
        {name = "cafe", price = 3},
        {name = "thevert", price = 3},
    },
	["prop_vend_soda_01"] = {
        {name = "cola", price = 10},
    },
	["prop_vend_soda_02"] = {
        {name = "cola", price = 10},
    },
	["prop_vend_fridge01"] = {
        {name = "cola", price = 10},
    },
	["prop_watercooler"] = {
        {name = "water", price = 50},
    },
    ["prop_vend_water_01"] = {
        {name = "water", price = 50},
    },
    ["prop_watercooler_dark"] = {
        {name = "water", price = 50},
    },
    ["prop_vend_snak_01"] = {
        {name = "chips", price = 20},
        {name = "mentos", price = 2},
    },
    ["prop_vend_snak_01_tu"] = {
        {name = "chips", price = 20},
        {name = "mentos", price = 2},
    },
}
local ItemsToFind = {
    {item = "bread", chance = 25},
    {item = "water", chance = 25},
    {item = "can", chance = 46},
    {item = "hammer", data = {serial=math.random(111111111,999999999)}, chance = 2},
    {item = "bottle", data = {serial=math.random(111111111,999999999)}, chance = 2},
}
local itemsToBuy = {}
local propsFouilled =  {}
local chanceTable = {}
local currentItem = 1

RMenu.Add("lilshop", "main", RageUI.CreateMenu(nil, "Choix du produit", 10, 50))

for itemKey, itemValue in pairs(ItemsToFind) do
    for percentChance = 1, itemValue.chance, 1 do
        chanceTable[currentItem] = itemValue
        currentItem = currentItem + 1
    end
end

local function CheckBin(prop)
    if #propsFouilled == 10 then
        return RageUI.Popup({message="~r~Vous avez fouillé trop de poubelle pour aujourd'hui"})
    end
    for i = 1 , #propsFouilled ,1 do
        if prop == propsFouilled[i] then
            RageUI.Popup({message="Vous avez ~r~déjà fouillé cette poubelle"})
            return
        end
    end
    table.insert(propsFouilled, prop)
    exports['mythic_progbar']:Progress(
        {
            name = "BinCheking",
            duration = 4500,
            label = 'Vous fouillez...',
            useWhileDead = true,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "anim@gangops@morgue@table@",
                anim = "player_search",
                flags = 1,
            },
        }, 
        function(cancelled)
            if not cancelled then
                ClearPedTasksImmediately(LocalPlayer().Ped)
                local random = math.random(1,100)
                local random2 = math.random(1,10)
                if random2 > 2 then
                    if (chanceTable[random] ~= nil) then
                        if Atlantiss.Inventory:CanReceive(chanceTable[random].item, 1) then
                            local itemName = chanceTable[random].item
                            local itemLabel = chanceTable[random].item

                            if (Items[itemName] ~= nil and Items[itemName].label ~= nil) then
                                itemLabel = Items[itemName].label
                            end

                            ShowNotification(string.format("Vous avez trouvé ~b~%s~s~ x ~g~%s~s~", 1, itemLabel))
                            local items = {name = chanceTable[random].item, data = chanceTable[random].data}
                            Atlantiss.Inventory:AddItem(items)
                        else
                            ShowNotification("Vous n'avez rien trouvé")
                        end
                    else
                        ShowNotification("Vous n'avez rien trouvé")
                    end
                else
                    ShowNotification("Vous n'avez rien trouvé")
                end
            else
                ShowNotification("~r~Action annulée")
            end
        end
    )
end

local function isNearAnyObject()
    local plyPos = LocalPlayer().Pos

    if GetVehiclePedIsIn(GetPlayerPed(-1), false) ~= 0 then return end

    for k, v in pairs(ObjArray) do
        local obj = GetClosestObjectOfType(plyPos, 3.0, GetHashKey(k), false, true, true)
        if obj and DoesEntityExist(obj) and GetDistanceBetweenCoords(plyPos, GetEntityCoords(obj), true) < 2.0 then -- 2.8
            if string.match(k, "dump") ~= nil then -- Bin
                return CheckBin(obj)
            elseif string.match(k, "stand") ~= nil then -- Stand
                itemsToBuy = v
                RageUI.Visible(RMenu:Get("lilshop", "main"), true)
                return
            else -- Dispenser
                itemsToBuy = v
                RageUI.Visible(RMenu:Get("lilshop", "main"), true)
                return
            end
        end
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if RageUI.Visible(RMenu:Get("lilshop", "main")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        for i = 1, #itemsToBuy, 1 do
                            RageUI.Button(
                                Items[itemsToBuy[i].name].label,
                                nil,
                                {RightLabel = "$" .. itemsToBuy[i].price},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        if Atlantiss.Inventory:CanReceive(itemsToBuy[i].name, 1) then
                                            dataonWait = {
                                                title = "Achat "..itemsToBuy[i].name,
                                                price = itemsToBuy[i].price,
                                                fct = function()
                                                    loadAnimDict("amb@prop_human_atm@male@enter")
                                                    TaskPlayAnim(LocalPlayer().Ped, "amb@prop_human_atm@male@enter", "enter", 3.0, 1.0, 0.8, 48, 0.0, 0, 0, 0)
                                                    Atlantiss.Inventory:AddItem({name = itemsToBuy[i].name})
                                                    TriggerServerEvent('atlantiss_bank:addMoneyToBankAccount', "gouvernement", itemsToBuy[i].price)
                                                    itemsToBuy = {}
                                                end
                                            }
                                            TriggerEvent("payWith?")
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)

KeySettings:Add("keyboard", "E", isNearAnyObject, "CheckObject")
