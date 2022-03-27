Storage = setmetatable({}, Storage)
Storage.__index = Storage
Storage.__call = function()
    return "Storage"
end
local storage = {}
currentStorage = {}
function Storage.New(name, maxWeight)
    local newStorage = {}
    TriggerServerCallback(
        "rage-reborn:GetStorageItems",
        function(Items)
            newStorage = {
                name = name,
                maxWeight = maxWeight,
                items = FormatStorage(Items),
                Weight = 0
            }
        end,
        name
    )
    while newStorage.name == nil do
        Wait(50)
    end
    return setmetatable(newStorage, Storage)
end

function Storage:LinkToPos(Pos, name)
    Marker:Add(
        Pos,
        {
            type = 23,
            scale = {x = 1.5, y = 1.5, z = 0.2},
            color = {r = 255, g = 255, b = 255, a = 120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        }
    )
    Zone:Add(
        Pos,
        function(storage)
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
            KeySettings:Add(
                "keyboard",
                "E",
                function()
                    currentStorage = storage
                    self:RefreshDB()
                    self:RefreshWeight()
                    self:Visible(true)
                end,
                "STORAGEEE"
            )
            KeySettings:Add(
                "controller",
                46,
                function()
                    currentStorage = storage
                    self:RefreshDB()
                    self:RefreshWeight()
                    self:Visible(true)
                end,
                "STORAGEEE"
            )
        end,
        function()
            KeySettings:Clear("keyboard", "E", "STORAGEEE")
            KeySettings:Clear("controller", 46, "STORAGEEE")
            Hint:RemoveAll()
            currentStorage = nil
        end,
        self,
        1.5
    )
end
function Storage:Visible(bool)
    if bool then
        currentStorage = self
        self:RefreshWeight()
        TriggerEvent('Ora:openInvStorage')
    end
    Citizen.CreateThread(
        function()
            Wait(2500)
            -- Inventory:Load()
        end
    )
end
function FormatStorage(items)
    local _Items = {}
    for i = 1, #items, 1 do
        local p = items[i]
        if _Items[p.item_name] == nil then
            _Items[p.item_name] = {}
        end
        local data = p.metadata ~= nil and json.decode(p.metadata) or nil

        if (data == "{}" or data == nil) then
            -- do nothingg
        else
            for itemId, itemValue in pairs(data) do
                if (type(itemValue) == "string") then
                    itemValue = json.decode(itemValue)
                end

                if itemValue.metadata == nil then
                    itemValue.metadata = {}
                end

                if itemValue.label == nil then
                    itemValue.label = nil
                end

                table.insert(
                    _Items[p.item_name],
                    {name = p.item_name, data = itemValue.metadata, label = itemValue.label, id = itemId}
                )
            end
        end
    end
    return _Items
end
function Storage:AddItem(item)
    self = currentStorage
    if self.items[item.name] == nil then
        self.items[item.name] = {}
    end
    local label = item.label ~= nil and item.label or nil
    table.insert(self.items[item.name], {name = item.name, data = item.metadata, label = label, id = item.id})
end

function Storage:UpdateItemId(item, oldid, newid)
    if self.items[item.name] == nil then
        self.items[item.name] = {}
    end
    local label = item.label ~= nil and item.label or nil
    for k, v in pairs(self.items[item.name]) do
        if (v ~= nil and v.id == oldid) then
            v.id = newid
        end
    end
end

function Storage:RefreshWeight()
    self = currentStorage
    local Weight = 0
    local tmpWeight = nil
    while self.items == nil do Wait(10) end
    for k, v in pairs(self.items) do
        if v[1] ~= nil then
            p = self.items[k]
            if (Items[v[1].name] == nil or Items[v[1].name].weight == nil) then
                tmpWeight = 0.5
                print("^1-[DBG STOCKAGE 123] - " .. v[1].name .. " aucun poids")
            else
                tmpWeight = Items[v[1].name].weight
            end
            Weight = Weight + (tmpWeight * #v)
        end
    end
    self.Weight = Weight
end

function Storage:RefreshDB()
    TriggerServerCallback(
        "rage-reborn:GetStorageItems",
        function(Items)
            self.items = FormatStorage(Items)
        end,
        self.name
    )
end

function Storage:RemoveItem(name, id)

    self:RefreshWeight()
    for k, v in pairs(self.items) do
        if k == name then
            for i = 1, #v, 1 do
                if v[i].id == id then
                    TriggerServerEvent("rage-reborn:RemoveItemFromStorage2", id, name, self.name)
                    table.remove(self.items[name], i)
                    break
                end
            end
        end
    end
end

function Storage:RemoveItems(items, itemName)
    self:RefreshWeight()
    local itemsIds = {}

    for itemKey, itemValue in pairs(items) do
        table.insert(itemsIds, itemValue.id)
        for k, v in pairs(currentStorage.items) do
            if k == itemValue.name then
                for i = 1, #v, 1 do
                    if v[i].id == itemValue.id then
                        table.remove(currentStorage.items[itemValue.name], i)
                        break
                    end
                end
            end
        end
    end

    TriggerServerEvent("rage-reborn:RemoveItemsFromStorage2", itemsIds, itemName, self.name)
end

function Storage:TransferToInventory(count, item)
    self:RefreshWeight()
    local itemName = item.name
    local itemLabel = item.label or nil
    local itemsIds = {}
    self = currentStorage

    for k, v in pairs(self.items) do
        if k == itemName then
            local itemsLocal = {}
            local tempCount = count

            if (#v >= count) then
                for _, it in pairs(v) do
                    if tempCount == 0 then break end
                    if it.label == itemLabel then
                        for c,x in pairs(self.items[itemName]) do
                            if x.id == it.id then
                                table.insert(itemsIds, x.id)
                                self.items[itemName][c] = nil
                            end
                        end
                        tempCount = tempCount - 1
                    end
                end
            else
                TriggerEvent('Ora:InvNotification', "Vous n'avez pas assez d'items", 'error')
            end

            for i = 1, #v do
                if (self.items[itemName][i] ~= nil) then
                    table.insert(itemsLocal, self.items[itemName][i])
                end
            end

            self.items[itemName] = itemsLocal
        end
    end

    if #itemsIds > 0 then
        --TriggerEvent('Ora:InvNotification', 'Récupération du coffre. Veuillez patienter...', 'warning')
        TriggerServerEvent("rage-reborn:TransfertToInventory", itemsIds, item, self.name)

        TriggerServerEvent(
            "Ora:sendToDiscord",
            3,
            "Récupère " .. 
                count .. " x " .. 
                    Items[itemName].label .. 
                        " depuis le coffre " .. 
                            self.name, 
            "info"
        )
    end
end

function Storage:TransferToStorage(count, item)
    self:RefreshWeight()
    self = currentStorage
    local itemName = item.name
    local itemLabel = item.label or nil
    local itemsIds = {}
    local itemsToStorageVerifyDuplicates = {}
    local itemsToStorage = {}
    local itemsToStorage2 = {}

    if self.items[itemName] == nil then
        self.items[itemName] = {}
    end

    for k, v in pairs(Ora.Inventory.Data) do
        if k == itemName then
            local itemsLocal = {}
            local tempCount = count

            if (#v >= count) then
                for _, it in pairs(v) do
                    if tempCount == 0 then break end
                    if it.label == itemLabel then
                        if itemName == "tel" then
                            if it.data.num == MyNumber then
                                MyNumber = nil
                                MyBattery = 0
                                TriggerEvent("gcphone:UpdateBattery", MyBattery)
                                TriggerEvent("gcPhone:myPhoneNumber", MyNumber)
                                TriggerServerEvent("gcPhone:allUpdate")
                            end
                        end

                        if (itemsToStorageVerifyDuplicates[it.id] ~= nil) then
                            TriggerServerEvent(
                                "Ora:sendToDiscord",
                                12,
                                "Un UUID dupliqué a été repéré lors du transfert de l'item : " .. itemName .." dans le coffre " .. self.name .. " (uuid : " .. it.id .. ")", 
                                "error"
                            )
                            TriggerEvent('Ora:InvNotification', 'Duplication détectée', "error")
                        else
                            itemsToStorageVerifyDuplicates[it.id] = true
                        end

                        if itemName == "carte_grise" then
                            table.insert(
                                itemsToStorage,
                                {
                                    id = it.id,
                                    data = it.data,
                                    label = it.label,
                                    name = it.name,
                                    model = it.model,
                                    plate = it.plate
                                }
                            )
                            table.insert(
                                itemsToStorage2,
                                {
                                    id = it.id,
                                    data = it.data,
                                    label = it.label,
                                    name = it.name,
                                    model = it.model,
                                    plate = it.plate
                                }
                            )
                        else
                            table.insert(
                                itemsToStorage,
                                {
                                    id = it.id,
                                    data = it.data,
                                    label = it.label,
                                    name = it.name
                                }
                            )
                            table.insert(
                                itemsToStorage2,
                                {
                                    id = it.id,
                                    data = it.data,
                                    label = it.label,
                                    name = it.name
                                }
                            )
                        end

                        for c,x in pairs(Ora.Inventory.Data[itemName]) do
                            if x.id == it.id then
                                Ora.Inventory.Data[itemName][c] = nil
                            end
                        end
                        tempCount = tempCount - 1
                    end
                end
            else
                TriggerEvent('Ora:InvNotification', "Vous n'avez pas d'items", 'error')
            end

            itemsToStorageVerifyDuplicates = nil

            if (Ora.Inventory.Data[itemName] ~= nil) then
                for kItem, vItem in pairs(Ora.Inventory.Data[itemName]) do
                    if vItem ~= nil then
                        table.insert(itemsLocal, vItem)
                    end
                end
            end

            Ora.Inventory.Data[itemName] = itemsLocal
            break
        end
    end

    for key2, value2 in pairs(itemsToStorage) do
        table.insert(self.items[itemName], value2)
    end


    if #itemsToStorage2 > 0 then
        --TriggerEvent('Ora:InvNotification', 'Dépot dans le coffre. Veuillez patienter...', 'warning')

        local sendItems = {}
        local itemSent = 0

        for key3, value3 in pairs(itemsToStorage2) do
            table.insert(sendItems, value3)
            itemSent = itemSent + 1
            if (itemSent >= 150) then
                TriggerServerEvent("storage:addToQueue", sendItems, itemName, self.name)
                sendItems = {}
                itemSent = 0
                Wait(100)
            end
        end

        if (itemSent > 0) then
            TriggerServerEvent("storage:addToQueue", sendItems, itemName, self.name)
        end
        TriggerServerEvent(
            "Ora:sendToDiscord",
            3,
            "Dépose " .. count .. " x " .. Items[itemName].label .. " dans le coffre " .. self.name, 
            "info"
        )

        TriggerServerEvent("storage:runQueue", itemName, self.name)
    end
end

function Storage:CanAcceptItem(item, count)
    self:RefreshWeight()
    local tempWeight = currentStorage.Weight
    tempWeight = tempWeight + (Items[item].weight * count)
    if not (tempWeight <= tonumber(currentStorage.maxWeight)) then
        TriggerEvent('Ora:InvNotification', 'Il n\'y a plus de place dans le coffre !', 'error')
    end
    return tempWeight <= currentStorage.maxWeight
end
function table.hasValue(tbl, value, k)
    if not tbl or not value or type(tbl) ~= "table" then
        return
    end
    for _, v in pairs(tbl) do
        if k and v[k] == value or v == value then
            return true, _
        end
    end
end

function table.removeByValue(tbl, val, i)
    local ntbl = {}
    for k, v in pairs(tbl) do
        if v ~= val and (not i or v[i] ~= val) then
            table.insert(ntbl, v)
        end
    end
    return ntbl
end

function table.count(table, checkCount)
    if not table or type(table) ~= "table" then
        return not checkCount and 0
    end
    local n = 0
    for k, v in pairs(table) do
        n = n + 1
        if checkCount and n >= checkCount then
            return true
        end
    end
    return not checkCount and n
end

-- Citizen.CreateThread(
--     function()
--         while true do
--             Wait(500)
--             if #json.encode(currentStorage) > 5 then
--                 currentStorage:RefreshWeight()
--                 Wait(8000)
--             end
--         end
--     end
-- )
