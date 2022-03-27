Ora.Payment.EVENT_NAME = nil
Ora.Payment.FILTERS = {"dollar1", "dollar5", "dollar10", "dollar50", "dollar100", "dollar500"}
Ora.Payment.AMOUNT_INDEXES = {1, 5, 10, 50, 100, 500}

Ora.Payment.Fake.EVENT_NAME = nil
Ora.Payment.Fake.FILTERS = {"fakedollar1", "fakedollar5", "fakedollar10", "fakedollar50", "fakedollar100", "fakedollar500"}
Ora.Payment.Fake.AMOUNT_INDEXES = {1, 5, 10, 50, 100, 500}


function Ora.Payment:GetServerEventName()
    if (self.EVENT_NAME == nil) then
        Ora.Payment:Debug(string.format("Player ^5%s^3 tries to retrieve the server event. Retrieving it", GetPlayerServerId(PlayerId())))
        local canSend = false
        local newServerEventName = nil

        TriggerServerCallback("Ora::SE::Money:RetrieveServerEventName", function(serverEventName)
            newServerEventName = serverEventName
            canSend = true
        end)
        
        while (canSend == false) do
            Ora.Payment:Debug(string.format("Waiting pulling ^5%s^3 for player ^5%s^3", "Ora::SE::Money:RetrieveServerEventName", GetPlayerServerId(PlayerId())))     
            Wait(100) 
        end

        self.EVENT_NAME  = newServerEventName
    end

    Ora.Payment:Debug(string.format("Returning event ^5%s^3 for player ^5%s^3", self.EVENT_NAME, GetPlayerServerId(PlayerId())))     
    return self.EVENT_NAME
end

RegisterNetEvent("Ora::CE::Money:RegisterEventName")
AddEventHandler(
    "Ora::CE::Money:RegisterEventName",
    function(eventName)
        Ora.Payment:Debug(string.format("Registering event ^5%s^3 for player ^5%s^3", eventName, GetPlayerServerId(PlayerId())))     
        Ora.Payment.EVENT_NAME = eventName
    end
)

RegisterNetEvent("Ora::CE::Money:AddMoney")
AddEventHandler(
    "Ora::CE::Money:AddMoney",
    function(token)
        Ora.Payment:Debug(string.format("Trying to retrieve amount for token ^5%s^3 for player ^5%s^3", token, GetPlayerServerId(PlayerId())))     
        Ora.Payment:AddMoney(token)
    end
)

function Ora.Payment:GetAmountFromToken(token)
    local canSend = false
    local finalAmount = 0
    Ora.Payment:Debug(string.format("Trying to get amount from token ^5%s^3 for player ^5%s^3", token, GetPlayerServerId(PlayerId())))     
    TriggerServerCallback("Ora::SE::Money:RetrieveMoneyFromToken", function(amount)
      finalAmount = amount
      canSend = true
    end, token)
    
    while (canSend == false) do
        Ora.Payment:Debug(string.format("Waiting pulling data from event ^5%s^3 for player ^5%s^3", "Ora::SE::Money:RetrieveMoneyFromToken", GetPlayerServerId(PlayerId())))     
        Wait(100)      
    end

    Ora.Payment:Debug(string.format("Returning final amount ^5%s^3 for player ^5%s^3", finalAmount, GetPlayerServerId(PlayerId())))     
    return finalAmount
end

function Ora.Payment:AddMoney(token)
    local sendAmount = self:GetAmountFromToken(token)
    local totalAmount = sendAmount
    if sendAmount ~= nil and sendAmount ~= false then
        local giveTable = {}
        local i = #self.AMOUNT_INDEXES
        repeat
            if sendAmount - self.AMOUNT_INDEXES[i] >= 0 then
                sendAmount = sendAmount - self.AMOUNT_INDEXES[i]
                table.insert(giveTable, i)
            else
                i = i - 1
            end
        until i == 0

        local sendItems = {}
        local itemSent = 0
        local sendItemsByType = {}

        for i = 1, #giveTable, 1 do
            if (sendItemsByType[self.FILTERS[giveTable[i]]] == nil) then
                sendItemsByType[self.FILTERS[giveTable[i]]] = {}
            end

            table.insert(
                sendItemsByType[self.FILTERS[giveTable[i]]],
                {name = self.FILTERS[giveTable[i]], data = {serial = "LS-" .. math.random(10000000000, 90000000000), real = true}}
            )
        end

        for keyBills, valueBills in pairs(sendItemsByType) do
            TriggerPlayerEvent("Ora::CE::Inventory:AddItems", GetPlayerServerId(PlayerId()), valueBills)
        end

        Ora.Payment:Debug(string.format("Adding amount ^5%s^3$ in inventory for player ^5%s^3", totalAmount, GetPlayerServerId(PlayerId())))     
    else
        Ora.Payment:Debug(string.format("Token ^5%s^3 does not exist (player : ^5%s^3)", token, GetPlayerServerId(PlayerId())))
        Ora.Anticheat:ReportCheat("error", "Tentative de récupération d'argent non déclaré côté serveur", true)  
        ShowNotification("~r~Aucun token n'existe pour votre demande. Votre argent est bloqué~s~")
    end
end

local am = {1, 5, 10, 50, 100, 500}

function Ora.Payment:PayMoney(tablee)
    for k, v in pairs(tablee) do
        for i = 1, v.index - 1, 1 do
            local t = 0
            while Ora.Inventory.Data[k][t] == nil do
                t = t + 1
                Wait(0)
            end
            if Ora.Inventory.Data[k] ~= nil then
                Ora.Inventory:RemoveItem({id = Ora.Inventory.Data[k][t].id, name = Ora.Inventory.Data[k][t].name})
            end
        end
    end
end

function Ora.Payment:GetTotalCash()
    local amount = 0
    for k, v in pairs(Ora.Inventory:GetInventory()) do
        for i = 1, #self.FILTERS, 1 do
            if k == self.FILTERS[i] then
                amount = amount + (am[i] * #v)
            end
        end
    end
    return amount
end



function Ora.Payment.Fake:GetServerEventName()
    if (self.EVENT_NAME == nil) then
        Ora.Payment:Debug(string.format("Player ^5%s^3 tries to retrieve the server event. Retrieving it", GetPlayerServerId(PlayerId())))
        local canSend = false
        local newServerEventName = nil

        TriggerServerCallback("Ora::SE::Money:Fake:RetrieveServerEventName", function(serverEventName)
            newServerEventName = serverEventName
            canSend = true
        end)
        
        while (canSend == false) do
            Ora.Payment:Debug(string.format("Waiting pulling ^5%s^3 for player ^5%s^3", "Ora::SE::Money:Fake:RetrieveServerEventName", GetPlayerServerId(PlayerId())))     
            Wait(100) 
        end

        self.EVENT_NAME  = newServerEventName
    end

    Ora.Payment:Debug(string.format("Returning event ^5%s^3 for player ^5%s^3", self.EVENT_NAME, GetPlayerServerId(PlayerId())))     
    return self.EVENT_NAME
end

RegisterNetEvent("Ora::CE::Money:Fake:RegisterEventName")
AddEventHandler(
    "Ora::CE::Money:Fake:RegisterEventName",
    function(eventName)
        Ora.Payment:Debug(string.format("Registering event ^5%s^3 for player ^5%s^3", eventName, GetPlayerServerId(PlayerId())))     
        Ora.Payment.Fake.EVENT_NAME = eventName
    end
)

RegisterNetEvent("Ora::CE::Money:Fake:AddMoney")
AddEventHandler(
    "Ora::CE::Money:Fake:AddMoney",
    function(token)
        Ora.Payment:Debug(string.format("Trying to retrieve amount for token ^5%s^3 for player ^5%s^3", token, GetPlayerServerId(PlayerId())))     
        Ora.Payment.Fake:AddMoney(token)
    end
)

function Ora.Payment.Fake:GetAmountFromToken(token)
    local canSend = false
    local finalAmount = 0
    Ora.Payment:Debug(string.format("Trying to get amount from token ^5%s^3 for player ^5%s^3", token, GetPlayerServerId(PlayerId())))     
    TriggerServerCallback("Ora::SE::Money:Fake:RetrieveMoneyFromToken", function(amount)
      finalAmount = amount
      canSend = true
    end, token)
    
    while (canSend == false) do
        Ora.Payment:Debug(string.format("Waiting pulling data from event ^5%s^3 for player ^5%s^3", "Ora::SE::Money:Fake:RetrieveMoneyFromToken", GetPlayerServerId(PlayerId())))     
        Wait(100)      
    end

    Ora.Payment:Debug(string.format("Returning final amount ^5%s^3 for player ^5%s^3", finalAmount, GetPlayerServerId(PlayerId())))     
    return finalAmount
end

function Ora.Payment.Fake:AddMoney(token)
    local sendAmount = self:GetAmountFromToken(token)
    local totalAmount = sendAmount
    if sendAmount ~= nil and sendAmount ~= false then
        local giveTable = {}
        local i = #self.AMOUNT_INDEXES
        repeat
            if sendAmount - self.AMOUNT_INDEXES[i] >= 0 then
                sendAmount = sendAmount - self.AMOUNT_INDEXES[i]
                table.insert(giveTable, i)
            else
                i = i - 1
            end
        until i == 0

        local sendItems = {}
        local itemSent = 0
        local sendItemsByType = {}

        for i = 1, #giveTable, 1 do
            if (sendItemsByType[self.FILTERS[giveTable[i]]] == nil) then
                sendItemsByType[self.FILTERS[giveTable[i]]] = {}
            end

            table.insert(
                sendItemsByType[self.FILTERS[giveTable[i]]],
                {name = self.FILTERS[giveTable[i]], data = {serial = "LS-" .. math.random(10000000000, 90000000000), real = true}}
            )
        end

        for keyBills, valueBills in pairs(sendItemsByType) do
            TriggerPlayerEvent("Ora::CE::Inventory:AddItems", GetPlayerServerId(PlayerId()), valueBills)
        end

        Ora.Payment:Debug(string.format("Adding amount ^5%s^3$ in inventory for player ^5%s^3", totalAmount, GetPlayerServerId(PlayerId())))     
    else
        Ora.Payment:Debug(string.format("Token ^5%s^3 does not exist (player : ^5%s^3)", token, GetPlayerServerId(PlayerId())))
        Ora.Anticheat:ReportCheat("error", "Tentative de récupération d'argent non déclaré côté serveur", true)  
        ShowNotification("~r~Aucun token n'existe pour votre demande. Votre argent est bloqué~s~")
    end
end

function Ora.Payment.Fake:PayMoney(tablee)
    for k, v in pairs(tablee) do
        for i = 1, v.index - 1, 1 do
            local t = 0
            while Ora.Inventory.Data[k][t] == nil do
                t = t + 1
                Wait(0)
            end
            if Ora.Inventory.Data[k] ~= nil then
                Ora.Inventory:RemoveItem({id = Ora.Inventory.Data[k][t].id, name = Ora.Inventory.Data[k][t].name})
            end
        end
    end
end

function Ora.Payment.Fake:GetTotalFakeCash()
    local amount = 0
    for k, v in pairs(Ora.Inventory:GetInventory()) do
        for i = 1, #self.FILTERS, 1 do
            if k == self.FILTERS[i] then
                amount = amount + (am[i] * #v)
            end
        end
    end
    return amount
end
