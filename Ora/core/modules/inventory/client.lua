---@class Ora.Inventory : Ora
Ora.Inventory.Data = Ora.Inventory.Data or {}
Ora.Inventory.State = {
    IsOpen = false
}
Ora.Inventory.Weight = 0
Ora.Inventory.MaxWeight = 40
Ora.Inventory.LastSave = 0
Ora.Inventory.CurrentWeapon = {
    Label = nil,
    Name = nil,
    id = nil
}
Ora.Inventory.SelectedItem = nil
local selectedItem = nil
local oldTableLength = 0
local Infos = {
    ["permis-conduire"] = function()
        TriggerEvent("ShowPermis", selectedItem)
    end,
    ["permis-conduire-moto"] = function()
        TriggerEvent("ShowPermis", selectedItem)
    end,
    ["permis-conduire-pl"] = function()
        TriggerEvent("ShowPermis", selectedItem)
    end,
    ["fake-permis-conduire"] = function()
        TriggerEvent("ShowFakePermis", selectedItem)
    end,
    ["kevlar"] = function()
        Ora.Inventory:ShowMessage('Status du kevlar: '.. selectedItem.data.status.."%")
    end,
    ["identity"] = function()
        TriggerEvent("ShowPicture", selectedItem)
    end,
    ["fake_identity"] = function()
        TriggerEvent("ShowFakePicture", selectedItem)
    end,
    ["carte_grise"] = function()
        TriggerEvent("ShowCarteGrise", selectedItem)
    end,
    ["fake_carte_grise"] = function()
        TriggerEvent("ShowFakeCarteGrise", selectedItem)
    end,
    ["bank_card"] = function()
        TriggerEvent("ShowBankCard", selectedItem)
    end
}


--[[
    __                     __   ______                 __  _                 
   / /   ____  _________ _/ /  / ____/_  ______  _____/ /_(_)___  ____  _____
  / /   / __ \/ ___/ __ `/ /  / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
 / /___/ /_/ / /__/ /_/ / /  / __/ / /_/ / / / / /__/ /_/ / /_/ / / / (__  ) 
/_____/\____/\___/\__,_/_/  /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/  
]]


local function explode(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function DropAnim()
    loadAnimDict("mp_weapon_drop")
    TaskPlayAnim(LocalPlayer().Ped, "mp_weapon_drop", "drop_lh", 5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
end

-- Clothes functions to move and to put as global or let on old inventory file

function GetNuMale()
    return {
        torso = {id = 15, txt = 0},
        undershirt = {id = 15, txt = 0},
        tops = {id = 15, txt = 0},
        body_armor = {id = 0, txt = 0},
        backpacks = {id = 0, txt = 0},
        texture = {id = 0, txt = 0},
        feet = {id = 34, txt = 0},
        legs = {id = 14, txt = 0},
        accessories = {id = 0, txt = 0},
        mask = {toggle = false, id = 0, txt = 0},
        hat = {toggle = false, id = -1, txt = 0},
        glasses = {toggle = false, id = -1, txt = 0},
        ears = {toggle = false, id = -1, txt = 0},
        watches = {toggle = false, id = -1, txt = 0},
        bracelets = {toggle = false, id = -1, txt = 0}
    }
end

function GetNuFemale()
    return {
        torso = {id = 15, txt = 0},
        undershirt = {id = 15, txt = 0},
        tops = {id = 15, txt = 0},
        body_armor = {id = 0, txt = 0},
        backpacks = {id = 0, txt = 0},
        texture = {id = 0, txt = 0},
        feet = {id = 35, txt = 0},
        legs = {id = 21, txt = 0},
        accessories = {id = 0, txt = 0},
        mask = {toggle = false, id = 0, txt = 0},
        hat = {toggle = true, id = -1, txt = 0},
        glasses = {toggle = true, id = -1, txt = 0},
        ears = {toggle = true, id = -1, txt = 0},
        watches = {toggle = true, id = -1, txt = 0},
        bracelets = {toggle = true, id = -1, txt = 0}
    }
end

function RefreshClothes()
    visor = false
    local clothesIn = Ora.Inventory.Data ~= nil and Ora.Inventory.Data["clothe"] or nil
    local accessIn = Ora.Inventory.Data ~= nil and Ora.Inventory.Data["access"] or nil
    local Clothes = {}
    if Ora.World.Ped:IsPedMale(LocalPlayer().Ped) then
        Clothes = GetNuMale()
    else
        Clothes = GetNuFemale()
    end

    UpdateEntityOutfit(LocalPlayer().Ped, Clothes)
    if clothesIn ~= nil then
        for i = 1, #clothesIn, 1 do
            if clothesIn[i].data.equiped then
                if clothesIn[i].data.type == 0 then
                    SetPedComponentVariation(
                        LocalPlayer().Ped,
                        clothesIn[i].data.component,
                        clothesIn[i].data.var,
                        clothesIn[i].data.ind
                    )
                    if clothesIn[i].data.component == 11 then
                        SetPedComponentVariation(LocalPlayer().Ped, 8, clothesIn[i].data.h, clothesIn[i].data.hV, 2)
                        SetPedComponentVariation(LocalPlayer().Ped, 3, clothesIn[i].data.bras)
                    end
                end
            end
        end
    end
    if accessIn ~= nil then
        for i = 1, #accessIn, 1 do
            if accessIn[i].data.equiped then
                SetPedPropIndex(
                    LocalPlayer().Ped,
                    accessIn[i].data.component,
                    accessIn[i].data.var,
                    accessIn[i].data.ind,
                    2
                )
            end
        end
    end
end


--[[ 
   ________      __          __   __  ___     __  __              __    
  / ____/ /___  / /_  ____ _/ /  /  |/  /__  / /_/ /_  ____  ____/ /____
 / / __/ / __ \/ __ \/ __ `/ /  / /|_/ / _ \/ __/ __ \/ __ \/ __  / ___/
/ /_/ / / /_/ / /_/ / /_/ / /  / /  / /  __/ /_/ / / / /_/ / /_/ (__  ) 
\____/_/\____/_.___/\__,_/_/  /_/  /_/\___/\__/_/ /_/\____/\__,_/____/  
]]


function Ora.Inventory:Load()
    self:Debug(string.format('Loading inventory with uuid %s', Ora.Identity:GetMyUuid()))
    TriggerServerCallback(
        "Ora::SCB::Inventory:GetInventory",
        function(Data)
            if type(Data) ~= "table" then
                self.Data = Data == nil and {} or json.decode(Data)
            else
                self.Data = {}
            end
            oldTableLength = #Data
            RefreshClothes()
            self:RefreshWeight()
            for _, item in pairs(self.Data) do
                for k, v in pairs(item) do
                    if v.data and v.data.equipedSlot then
                        if v.data.equipedSlot == 1 then
                            self:SetWeapon(v, 1)
                        elseif v.data.equipedSlot == 2 then
                            self:SetWeapon(v, 2)
                        elseif v.data.equipedSlot == 3 then
                            self:SetWeapon(v, 3)
                        end
                    end
                end
            end
        end
    )
end

---@param force Boolean optionnal
function Ora.Inventory:Save(force)
    local uuid = Ora.Identity:GetMyUuid()
    if self.Data == nil or self.Data == {} or self.Data == '{}' then
        self:Load()
    end
    local jsonInv = json.encode(self.Data)
    if (
        (force == true) or
        (
            --(Ora.Inventory.LastSave - GetGameTimer() <= 0) and
            #jsonInv ~= oldTableLength and #jsonInv ~= #json.encode({})
        )
    ) then
        Ora.Inventory.LastSave = GetGameTimer() + 10000 -- 10s
        self:Debug(string.format('Saving inventory with uuid %s. Inventory weight: %s', uuid, self.Weight))
        oldTableLength = #jsonInv
        TriggerServerEvent("Ora::SE::Inventory:SaveInventory", jsonInv, uuid)
    end
end

function Ora.Inventory:RefreshWeight()
    self.Weight = 0
    if self.Data ~= nil then
        for itemName, item in pairs(self.Data) do
            if item[1] ~= nil then
                p = self.Data[itemName]
                if Items[item[1].name] == nil then
                    Ora.Inventory:RemoveAnyItemsFromName(itemName, 100)
                    self:Debug(string.format('Removed item with name ^5%s^3 cause it does not exist in Items.', itemName))
                else
                    self.Weight = self.Weight + (Items[item[1].name].weight * #item)
                end
            end
        end
    end
end

---@param weapon itemObject weapon item
---@param number Integer
function Ora.Inventory:SetWeapon(weapon, number)
    if number ~= nil and type(number) == "number" and number <= 3 and number > 0 then
        if number == 1 then
            self.weaponONE = weapon
        elseif number == 2 then
            self.weaponTWO = weapon
        elseif number == 3 then
            self.weaponTHREE = weapon
        end

        if weapon ~= nil then
            for k, v in pairs(self.Data[weapon.name]) do
                if v.id == weapon.id then
                    if self.Data[weapon.name][k].data then
                        self.Data[weapon.name][k].data.equipedSlot = number
                    else
                        self.Data[weapon.name][k].data = {
                            equipedSlot = number
                        }
                    end
                end
            end
        end
    end
end

---@return Table of player weapons
function Ora.Inventory:GetWeapons()
    return {
        self.weaponONE or nil,
        self.weaponTWO or nil,
        self.weaponTHREE or nil
    }
end

---@return Ora.Inventory.Data
function Ora.Inventory:GetInventory()
    return self.Data
end

---@param itemName String
---@return Integer
function Ora.Inventory:GetItemCount(itemName)
    found = 0
    if self.Data ~= nil then
        for k, v in pairs(self.Data) do
            if k == itemName then
                if #v <= 0 then
                    found = 0
                else
                    found = #v
                end
            end
        end
    end
    return found
end

---@param item itemObject at least name & id
---@param notrefreshing Boolean optionnal
function Ora.Inventory:RemoveItem(item, notrefreshing) -- if you don't want to refresh, put true as a last arg. If you wanna refresh, just keep 1 arg
    local isntRefreshing = notrefreshing or false
    local itemName = item.name
    for k, px in pairs(self.Data) do
        local t = px
        if k == itemName then
            for i = 1, #px, 1 do
                if px[i].id == item.id then
                    if itemName == "tel" then
                        if px[i].data.num == MyNumber then
                            MyNumber = nil
                            TriggerEvent("gcPhone:myPhoneNumber", MyNumber)
                            TriggerServerEvent("gcPhone:allUpdate")
                        end
                    end
                    table.remove(self.Data[itemName], i)
                    if itemName == "clothe" then
                        RefreshClothes()
                    end
                    break
                end
            end
        end
    end
    if not isntRefreshing then
        self:RefreshWeight()
    end
end

---@param items Array of itemObject
---@param qty Number quantity
---@param notrefreshing Boolean optionnal
function Ora.Inventory:RemoveAnyItemsFromName(itemName, qty, notrefreshing)
    local isntRefreshing = notrefreshing or false
    local itemsToDelete = {}
    
    for i=1, qty, 1 do
        if (self.Data[itemName] ~= nil and self.Data[itemName][i] ~= nil) then
            table.insert(itemsToDelete, self.Data[itemName][i])
        end
    end

    self:RemoveItems(itemsToDelete, isntRefreshing, false)
end

---@param items Array of itemObject
---@param notrefreshing Boolean optionnal
---@param takesTheLabel Boolean optional
function Ora.Inventory:RemoveItems(items, notrefreshing, takesTheLabel)
    local itemName = items[1].name
    local itemLabel = items[1].label
    local isntRefreshing = notrefreshing or false
    local isTakingLabel = true
    if (takesTheLabel ~= nil) then isTakingLabel = takesTheLabel end

    for i=1, #items, 1 do
        if self.Data[itemName] == nil or #self.Data[itemName] == 0 then
            ShowNotification("~r~Pas assez d'item~s~")
            self:ShowMessage("Pas assez d'item", "error")
            return
        end

        for k, ite in pairs(self.Data[itemName]) do
            if (isTakingLabel) then
                if (ite.label == itemLabel) then
                    self:Debug(string.format("Removing one %s id: %s", itemName, ite.id))
                    self:RemoveItem(ite, isntRefreshing)
                    break
                end
            else
                self:Debug(string.format("Removing one %s id: %s", itemName, ite.id))
                self:RemoveItem(ite, isntRefreshing)
                break
            end
        end
    end
end

---@param itemName String
function Ora.Inventory:RemoveFirstItem(itemName)
    local inv = self.Data[itemName]
    local _i = nil
    for i = 1, #inv, 1 do
        _i = inv[i]
        if _i ~= nil then break end
    end
    self:RemoveItem(_i)
end

--@param 
function Ora.Inventory:getAnyThrowable()
    for itemName, items in pairs(self.Data) do
        if itemName and #items > 0 and Items[itemName] ~= nil and Items[itemName].throwableItem == true then
            return {
                id = items[1].id,
                name = itemName,
                prop = Items[itemName].props,
                label = Items[itemName].label,
                weight = Items[itemName].weight
            }
        end
    end
end

---@param item itemObject at least name
---@param notrefreshing Boolean optionnal
function Ora.Inventory:AddItem(item, notrefreshing) -- if you don't want to refresh, put true as a last arg. If you wanna refresh, just keep 1 arg
    local isntRefreshing = notrefreshing or false
    self:Debug(string.format("Adding one %s id: %s", item.name, item.id))
    if item.id == nil then
        item.id = generateUUIDV2()
    end
    if self.Data == nil then
        self:Load()
        Wait(500)
    end
    if self.Data[item.name] == nil then
        self.Data[item.name] = {}
    end
    local T = self.Data[item.name]
    local cp = nil
    for k, v in pairs(weapon_name) do
        if v == self.CurrentWeapon.Label then
            cp = k
        end
    end
    if item.name == weapon_munition[cp] then
        AddAmmoToPed(GetPlayerPed(-1), self.CurrentWeapon.Name, 1)
    end
    table.insert(T, {name = item.name, id = item.id, data = item.data, label = item.label})
    RageUI.Popup({message = "Vous avez reçu un(e) ~b~" .. string.lower(Items[item.name].label) .. "(s)"})
    if not isntRefreshing then
        self:RefreshWeight()
    end
end

---@param items Array of itemObject
function Ora.Inventory:AddItems(items)
    for itemKey, itemValue in pairs(items) do
        if itemValue.id == nil then
            itemValue.id = generateUUIDV2()
        end
        self:AddItem(itemValue, true)
    end
    self:RefreshWeight()
end

---@param message String
---@param type String optional => 'white' or 'warning' -> yellow or 'error' -> red or nothing -> black
function Ora.Inventory:ShowMessage(message, type)
    if message ~= "" and message ~= nil then
        SendNUIMessage({eventName = "showNotification", eventData = {message, type}})
    end
end

function Ora.Inventory:StealFromPlayer(playerId, item, amount)
    if (Ora.Player:IsStealing()) then
        ShowNotification("Vous êtes ~r~déjà~s~ en train de récupérer un item")
        Ora.Inventory:ShowMessage("Vous êtes déjà en train de récupérer un item. Patientez", "error")
        return
    end

    Ora.Player:SetStealing(true)
    local canSend = false
    local hasBeenStolen = false

    self:Debug(string.format("^5%s^3 Trying to steal ^5%d^3 x ^5%s^3 from ^5%s^3", GetPlayerServerId(PlayerId()), amount, item.name, playerId))     
    TriggerServerCallback(
        "Ora::SE::Inventory:StealIfAvailable",
        function(hasBeenStolenResponse)
            self:Debug(string.format("Received response from event ^5%s^3 for player ^5%s^3 and response is ^5%s^3", "Ora::SE::Inventory:StealIfAvailable", GetPlayerServerId(PlayerId()), playerId, hasBeenStolenResponse))     
            hasBeenStolen = hasBeenStolenResponse
            canSend = true
        end,
        item,
        amount,
        playerId
    )
    
    while (canSend == false) do
        self:Debug(string.format("Waiting pulling data from event ^5%s^3 for player ^5%s^3", "Ora::SE::Inventory:StealIfAvailable", GetPlayerServerId(PlayerId())))     
        Wait(200)      
    end

    self:Debug(string.format("Player ^5%s^3 received response : steal ^5%s^3 of ^5%d^3 x ^5%s^3 is ^5%s^3", GetPlayerServerId(PlayerId()), playerId, amount, item.name, hasBeenStolen))     
    Ora.Player:SetStealing(false)
    return hasBeenStolen
end

---@param playerId PlayerServerId
---@param item itemObject
---@param amount Integer
---@return Boolean
function Ora.Inventory:CanStealFromPlayer(playerId, item, amount)
    local canSend = false
    local canSteal = false

    self:Debug(string.format("Fetching if player ^5%s^3 can steal ^5%d^3 x ^5%s^3 from ^5%s^3", GetPlayerServerId(PlayerId()), amount, item, playerId))     
    TriggerServerCallback(
        "Ora::SE::Inventory:CanSteal",
        function(canStealItems)
            self:Debug(string.format("Received response from event ^5%s^3 for player ^5%s^3 and response is ^5%s^3", "Ora::SE::Inventory:CanSteal", GetPlayerServerId(PlayerId()), playerId, canStealItems))     
            canSteal = canStealItems
            canSend = true
        end,
        item,
        amount,
        playerId
    )
    
    while (canSend == false) do
        self:Debug(string.format("Waiting pulling data from event ^5%s^3 for player ^5%s^3", "Ora::SE::Inventory:CanSteal", GetPlayerServerId(PlayerId())))     
        Wait(200)      
    end

    self:Debug(string.format("Player ^5%s^3 received response : steal ^5%s^3 of ^5%d^3 x ^5%s^3 is ^5%s^3", GetPlayerServerId(PlayerId()), playerId, amount, item.name, canSteal))     
    return canSteal
end

function Ora.Inventory:CanGiveToPlayer(playerId, item, amount)

end

---@param item itemObject
function Ora.Inventory:Infos(item)
    selectedItem = item
    if item.label then
        self:ShowMessage(string.format("Label de l'item: %s", item.label))
    end
    if Items[item.name].category == "weapon" then
        if item.data == nil then
            item.data = {
                serial = "Illisible"
            }
        end
        return self:ShowMessage(item.data.serial == nil and "Numéro de série : Illisible" or "Numéro de série : " .. item.data.serial)
    elseif Items[item.name].category == "drugs" then
        local quality = nil
        for i, it in ipairs(self.Data[item.name]) do
            if it.id == item.id then
                quality = self.Data[item.name][i].data.quality
            end
        end
        Wait(50)
        local qualityLabel = "Qualité Merdique"

        if quality == nil then return self:ShowMessage('Qualité inconnue') end

        if (quality > 10 and quality <= 35) then
            qualityLabel = "Qualité Basse"
        elseif (quality > 35 and quality < 50) then
            qualityLabel = "Qualité Moyenne"
        elseif (quality >= 50 and quality < 75) then
            qualityLabel = "Qualité Bonne"
        elseif (quality >= 75 and quality <= 99) then
            qualityLabel = "Qualité Exceptionnelle"
        elseif (quality == 100) then
            qualityLabel = "Qualité Inégalable"
        end

        return self:ShowMessage(qualityLabel)
    elseif Items[item.name].category == "carkey" then
        if item.data.plate ~= nil then self:ShowMessage("Plaque liée à la clé: "..item.data.plate) end
        if (item.data.vehicleIdentifier == nil and item.data.plate ~= nil) then
            local vehicleIdentifier = item.data.plate
            TriggerServerCallback(
                "OraCar:getCarPositionWithoutModel",
                function(type, localisation)
                    if (type == "outside") then
                        ShowAdvancedNotification(
                            "SERVICE DES PLAQUES",
                            "~b~Reponse automatique",
                            "~g~Votre voiture semble a l'exterieur.\n Voici sa derniere position?~s~",
                            "CHAR_PROPERTY_TOWING_IMPOUND",
                            1
                        )

                        ClearGpsPlayerWaypoint()
                        SetNewWaypoint(localisation.x, localisation.y)
                        --TriggerServerEvent("OraCar:poundVehicle", vehicleIdentifier)
                    elseif (type == "parked") then
                        ShowAdvancedNotification(
                            "SERVICE DES PLAQUES",
                            "~b~Reponse automatique",
                            "~o~Votre voiture semble être dans un parking sous terrain.\nL'avez vous garé ? Est elle volée ?~s~",
                            "CHAR_PROPERTY_TOWING_IMPOUND",
                            1
                        )
                    else
                        ShowAdvancedNotification(
                            "SERVICE DES PLAQUES",
                            "~b~Reponse automatique",
                            "~r~Votre voiture a été enlevée par la fourriere, veuillez vous rapprocher d'un garagiste~s~",
                            "CHAR_PROPERTY_TOWING_IMPOUND",
                            1
                        )
                    end
                end,
                vehicleIdentifier
            )
        elseif (item.data.vehicleIdentifier ~= nil) then
            local vehicleIdentifier = item.data.vehicleIdentifier
            TriggerServerCallback(
                "OraCar:getCarPosition",
                function(type, localisation)
                    local explodedIdentifier = explode(vehicleIdentifier)
                    if (type == "outside") then
                        ShowAdvancedNotification(
                            "SERVICE DES PLAQUES",
                            "~b~Reponse automatique",
                            "~g~Votre voiture semble être garée ici. (voir GPS)\nSi elle ne s'y trouve pas, c'est qu'elle est en fourriere~s~",
                            "CHAR_PROPERTY_TOWING_IMPOUND",
                            1
                        )

                        ClearGpsPlayerWaypoint()
                        SetNewWaypoint(localisation.x, localisation.y)

                        TriggerServerEvent("OraCar:poundVehicle", vehicleIdentifier)
                    elseif (type == "parked") then
                        ShowAdvancedNotification(
                            "SERVICE DES PLAQUES",
                            "~b~Reponse automatique",
                            "~o~Votre voiture semble être dans un parking sous terrain.\nL'avez vous garé ? Est elle volée ?~s~",
                            "CHAR_PROPERTY_TOWING_IMPOUND",
                            1
                        )
                    else
                        ShowAdvancedNotification(
                            "SERVICE DES PLAQUES",
                            "~b~Reponse automatique",
                            "~r~Votre voiture a été enlevée par la fourriere, veuillez vous rapprocher d'un garagiste~s~",
                            "CHAR_PROPERTY_TOWING_IMPOUND",
                            1
                        )
                    end
                end,
                vehicleIdentifier
            )
        else
            return self:ShowMessage("Cette clé ne contient aucune information")
        end
    else
        if item.data == nil then
            return self:ShowMessage("Item invalide", "error")
        end
        if Infos[item.name] ~= nil then
            Infos[item.name]()
        end
    end
end

---@param item itemObject
function Ora.Inventory:UseItem(item)
    if Items[item.name].category == "weapon" then
        EquipWeapon(item)
    elseif Items[item.name].type == "props" then
        SpecialProps(item)
    elseif Items[item.name].category == "food" then
        TriggerEvent("miam:Drink", item, Items)
        self:RemoveItem(item)
    elseif Items[item.name].category == "consumable" then
        if (Items[item.name].actionCl ~= nil) then
            TriggerEvent(Items[item.name].actionCl, item)
            self:RemoveItem(item)
        end
    else
        if Items[item.name].actionCl ~= nil and ItemsFunction[item.name] == nil then
            TriggerEvent(Items[item.name].actionCl, item)
        elseif Items[item.name].action and ItemsFunction[item.name] == nil then
            TriggerServerEvent(Items[item.name].action, item)
        else
            if ItemsFunction[item.name] ~= nil then
                ItemsFunction[item.name](item)
            else
                self:ShowMessage("Vous ne pouvez pas utiliser cet objet", "error")
            end

            if item.name == "tel" then currPh = item.id end
        end
    end
end

---@param name itemName 
---@param amount Integer
---@return Boolean
function Ora.Inventory:CanReceive(name, amount)
    self:RefreshWeight()
    local tempWeight = self.Weight
    if Items[name] == nil then
        error(string.format("Mauvais item: %s", name))
        return false
    end
    tempWeight = tempWeight + (Items[name].weight * amount)

    if tempWeight >= self.MaxWeight then
        RageUI.Popup({message = "Vous n'avez plus assez de place"})
        self:ShowMessage("Vous n'avez plus assez de place")
        return false
    else
        return true
    end
end

---@param item itemObject
function Ora.Inventory:Rename(item)
    exports['Snoupinput']:ShowInput("Renommer l'item", 25, "text", item.label and item.label or nil)
    local label = exports['Snoupinput']:GetInput()
    self:Debug(string.format('Trying to rename one %s, result: %s', item.name, label))
    if label == false then return end
    if label == "" then label = nil end
    for k, px in pairs(self.Data) do
        if k == item.name then
            for i = 1, #px, 1 do
                if px[i].id == item.id then
                    px[i].label = label
                end
            end
        end
    end
end

---@param item itemObject
function Ora.Inventory:RenameAll(item)
    exports['Snoupinput']:ShowInput("Renommer les items en", 25, "text")
    local newLabel = exports['Snoupinput']:GetInput()
    exports['Snoupinput']:ShowInput("Renommer tous les "..Items[item.name].label.." ? (o/n)", 25, "text")
    local confirm = exports['Snoupinput']:GetInput()
    
    self:Debug(string.format('Trying to rename all %s, results: %s - %s', item.name, newLabel, confirm))
    if newLabel == false then return end
    if confirm ~= "o" and confirm ~= "O" and confirm ~= false then return end
    if newLabel ~= nil then
        if newLabel == "" then newLabel = nil end
        self:Debug(string.format('Renaming every %s in %s. There is %s items to rename.', item.name, newLabel, #self.Data[item.name]))
        for i = 1, #self.Data[item.name], 1 do
            if self.Data[item.name][i] ~= nil then
                self.Data[item.name][i].label = newLabel
            end
        end
    end
end

---@param _player PlayerServerId
---@param item itemObject
---@param amount Integer
function Ora.Inventory:GiveItemToPlayer(_player, item, amount)
    local player = GetPlayerServerId(_player)
    local responseLoaded = false
    local isAbleToSendItems = false
    if (player ~= false) then
        count = amount
        count = tonumber(count)
        if count == 1 then
            giveTable = {item}

            for i = 1, #giveTable, 1 do
                if self:GetItemCount(item.name) >= count then
                    TriggerServerCallback("Ora::SE::Inventory:CanReceive",
                        function(canSend) 
                            responseLoaded = true
                            isAbleToSendItems = canSend
                        end,
                        item.name, 
                        count, 
                        player
                    )

                    local currentTry = 0
                    while (responseLoaded == false and currentTry <= 100) do
                        Wait(100)
                        currentTry = currentTry + 1
                    end

                    if (isAbleToSendItems == true) then
                        self:RemoveItem(giveTable[i])
                        TriggerPlayerEvent("Ora::CE::Inventory:AddItems", player, {giveTable[i]})
                        TriggerServerEvent(
                            "Ora:sendToDiscord",
                            2,
                            "Donne 1x " ..
                                Items[giveTable[i].name].label .. " à " .. Ora.Identity:GetFullname(player)
                        )
                        self:ShowMessage("Vous avez donné " .. count .. " x " .. Items[item.name].label)
                    else
                        self:ShowMessage("Les poches de cette personne sont pleines", "error")
                    end
                else
                    self:ShowMessage("Vous n'avez pas assez de " .. Items[item.name].label, "warning")
                end
            end
        else
            if count ~= nil and self:GetItemCount(item.name) >= count then

                local responseLoaded = false
                local isAbleToSendItems = false
                TriggerServerCallback("Ora::SE::Inventory:CanReceive",
                    function(canSend) 
                        responseLoaded = true
                        isAbleToSendItems = canSend
                    end,
                    item.name, 
                    count, 
                    player
                )

                local currentTry = 0
                while (responseLoaded == false and currentTry <= 100) do
                    Wait(100)
                    currentTry = currentTry + 1
                end

                if (isAbleToSendItems == true) then
                    local giveTable = {}
                    for i = 1, count, 1 do
                        k = self.Data[item.name]
                        if k.id == item.id then
                            if item.data ~= nil and item.data.equiped ~= nil then
                                item.data.equiped = false
                            end
                            table.insert(giveTable, item)
                        else
                            if
                                self.Data[item.name][i].data ~= nil and
                                    self.Data[item.name][i].data.equiped ~= nil
                             then
                                self.Data[item.name][i].data.equiped = false
                            end
                            table.insert(giveTable, self.Data[item.name][i])
                        end
                    end
    
                    local sendItems = {}
                    local itemSent = 0
                    local itemsToRemove = {}
                    local itemNameToGive = nil
    
                    for i = 1, #giveTable, 1 do
                        itemSent = itemSent + 1
    
                        local label = nil
    
                        if (giveTable[i].label ~= nil) then
                            label = giveTable[i].label
                        end
    
                        local id = nil
    
                        if (giveTable[i].id ~= nil) then
                            id = giveTable[i].id
                        end
    
                        local data = nil
    
                        if (giveTable[i].data ~= nil) then
                            data = giveTable[i].data
                        else
                            data = {}
                        end
    
                        table.insert(
                            sendItems,
                            {
                                name = giveTable[i].name,
                                data = data,
                                id = id,
                                label = label
                            }
                        )
    
                        itemNameToGive = giveTable[i].name
    
                        if (itemsToRemove[giveTable[i].name] == nil) then
                            itemsToRemove[giveTable[i].name] = 1
                        else
                            itemsToRemove[giveTable[i].name] = itemsToRemove[giveTable[i].name] + 1
                        end
                    end
    
                    for deleteKey, deleteValue in pairs(itemsToRemove) do
                        self:RemoveAnyItemsFromName(deleteKey, deleteValue)
                    end
    
                    TriggerPlayerEvent("Ora::CE::Inventory:AddItems", player, sendItems)
                    
                    TriggerPlayerEvent(
                        "RageUI:Popup",
                        player,
                        {message = "~b~Vous avez reçu : " .. count .. "x " .. item.name}
                    )

                    TriggerPlayerEvent('Ora:InvNotification', player, "Vous avez reçu : " .. count .. " x " .. item.name)
    
                    TriggerServerEvent(
                        "Ora:sendToDiscord",
                        2,
                        "Donne " ..
                            count ..
                                " x " ..
                                    Items[item.name].label ..
                                        " à " .. Ora.Identity:GetFullname(player)
                    )

                    self:ShowMessage("Vous avez donné " .. count .. " x " .. Items[item.name].label)

                    giveTable = {}
                else
                    self:ShowMessage("Les poches de cette personne sont pleines", "error")
                end
            else
                self:ShowMessage("Vous n'avez pas assez de " .. Items[item.name].label, "warning")
            end
        end
    else
        self:ShowMessage("Aucun joueur proche", "warning")
    end
end

---@param target Array Player Inventory
function Ora.Inventory:GetTargetWeight(target)
    local targetweight = 0
    for k,v in pairs(target) do
        if #v == 0 then goto continue end
        if Items[k].weight then
            targetweight = targetweight + (Items[k].weight * #v)
        end
        ::continue::
    end
    return math.floor(targetweight, 2)
end

---@param items Array of itemObject
function Ora.Inventory:Throw(items)
    local ped = LocalPlayer().Ped
    local coords = GetEntityCoords(ped)
    local forward = GetEntityForwardVector(ped)
    local x, y, z = table.unpack(coords + forward)
    local coords = {
        x = x,
        y = y,
        z = z - 1.0
    }
    TriggerPlayerEvent("newProps", -1, items, coords)
    self:RemoveItems(items, true)
    self:RefreshWeight()
    DropAnim()
end


function Ora.Inventory:AddPlayerLookingIntoStorage(storageName)
    TriggerServerEvent("Ora::SE::Inventory:AddPlayerToStorage", storageName)
end

function Ora.Inventory:RemovePlayerLookingFromStorage(storageName)
    TriggerServerEvent("Ora::SE::Inventory:RemovePlayerFromStorage", storageName)
end


--[[ 
    ______                 __      
   / ____/   _____  ____  / /______
  / __/ | | / / _ \/ __ \/ __/ ___/
 / /___ | |/ /  __/ / / / /_(__  ) 
/_____/ |___/\___/_/ /_/\__/____/  
]]


RegisterNetEvent("Ora::CE::Inventory:CanReceive")
AddEventHandler(
    "Ora::CE::Inventory:CanReceive",
    function(itemName, qty, giver)
        local canReceive = Ora.Inventory:CanReceive(itemName, qty)
        Ora.Inventory:Debug(string.format("Fetching if player ^5%s^3 can receive ^5%d^3 x ^5%s^3 from ^5%s^3 and response is ^5%s^3", GetPlayerServerId(PlayerId()), qty, itemName, giver, canReceive))     
        TriggerServerEvent("Ora::SE::Inventory:PopulateCanReceiveResult", canReceive, giver)
    end
)

RegisterNetEvent("Ora::CE::Inventory:StealIfAvailable")
AddEventHandler(
    "Ora::CE::Inventory:StealIfAvailable",
    function(item, qty, giver)
        local itemCount = Ora.Inventory:GetItemCount(item.name)
        local canSteal = false
        if (math.tointeger(itemCount) >= math.tointeger(qty)) then
          canSteal = true
        end
        Ora.Inventory:Debug(string.format("Player ^5%s^3 is stolen of ^5%d^3 x ^5%s^3 from ^5%s^3 and response is ^5%s^3", GetPlayerServerId(PlayerId()), qty, item.name, giver, canSteal))     
        Ora.Inventory:RemoveItem(item)
        TriggerEvent('Ora:inventory:deleteIfWeapon', item)
        Ora.Inventory:Save()
        ShowNotification(string.format("Une personne vous a volé : ~g~%s~s~ x ~g~%s~s~", qty, Ora.Core:GetItemLabel(item.name)))
        TriggerServerEvent("Ora::SE::Inventory:PopulateCanStealResult", canSteal, giver)
    end
)

RegisterNetEvent("Ora::CE::Inventory:CanBeStealed")
AddEventHandler(
    "Ora::CE::Inventory:CanBeStealed",
    function(itemName, qty, giver)
        local itemCount = Ora.Inventory:GetItemCount(itemName)
        local canSteal = false
        if (math.tointeger(itemCount) >= math.tointeger(qty)) then
          canSteal = true
        end
        Ora.Inventory:Debug(string.format("Fetching if player ^5%s^3 can be stolen of ^5%d^3 x ^5%s^3 from ^5%s^3 and response is ^5%s^3", GetPlayerServerId(PlayerId()), qty, itemName, giver, canSteal))     
        TriggerServerEvent("Ora::SE::Inventory:PopulateCanStealResult", canSteal, giver)
    end
)

RegisterNetEvent("Ora::CE::Inventory:RefreshStorage")
AddEventHandler(
    "Ora::CE::Inventory:RefreshStorage",
    function(data)
        local storageName = data.STORAGE_NAME
        --
    end
)

RegisterNetEvent("Ora::CE::Inventory:AddItems")
AddEventHandler(
    "Ora::CE::Inventory:AddItems",
    function(items)
        Ora.Inventory:AddItems(items)
    end
)

RegisterNetEvent("Ora::CE::Inventory:RemoveItem")
AddEventHandler(
    "Ora::CE::Inventory:RemoveItem",
    function(items)
        Ora.Inventory:RemoveItem(items)
    end
)

RegisterNetEvent("Ora::CE::Inventory:RemoveItems")
AddEventHandler(
    "Ora::CE::Inventory:RemoveItems",
    function(items)
        Ora.Inventory:RemoveItems(items)
    end
)

RegisterNetEvent("Ora::CE::Inventory:RemoveAnyItemsWithName")
AddEventHandler(
    "Ora::CE::Inventory:RemoveAnyItemsWithName",
    function(itemName, qty)
        Ora.Inventory:RemoveAnyItemsFromName(itemName, qty)
    end
)


--[[ 
    ______                      __      
   / ____/  ______  ____  _____/ /______
  / __/ | |/_/ __ \/ __ \/ ___/ __/ ___/
 / /____>  </ /_/ / /_/ / /  / /_(__  ) 
/_____/_/|_/ .___/\____/_/   \__/____/  
          /_/                           
]]


exports(
    "AddItem",
    function(item, refresh)
        Ora.Inventory:AddItem(item, refresh)
    end
)

exports(
    "CanReceive",
    function(itemName, qty)
        return Ora.Inventory:CanReceive(itemName, qty)
    end
)

exports(
    "RemoveFirstItem",
    function(itemName)
        Ora.Inventory:RemoveFirstItem(itemName)
    end
)

exports(
    "GetItemCount",
    function(itemName)
        return Ora.Inventory:GetItemCount(itemName)
    end
)

exports("getAnyThrowable", function () return Ora.Inventory:getAnyThrowable end)

--[[
  ________                        __    
 /_  __/ /_  ________  ____ _____/ /____
  / / / __ \/ ___/ _ \/ __ `/ __  / ___/
 / / / / / / /  /  __/ /_/ / /_/ (__  ) 
/_/ /_/ /_/_/   \___/\__,_/\__,_/____/  
]]


Citizen.CreateThread(
    function()
        while (Ora.Player.HasLoaded == false) do Wait(50) end
        Ora.Inventory:Debug('First loading of player inventory')
        Ora.Inventory:Load()
        while true do
            Wait(5000)
            Ora.Inventory:Save()
        end
    end
)
