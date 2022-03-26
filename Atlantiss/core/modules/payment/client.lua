Atlantiss.Payment.EVENT_NAME = nil
Atlantiss.Payment.FILTERS = {"dollar1", "dollar5", "dollar10", "dollar50", "dollar100", "dollar500"}
Atlantiss.Payment.AMOUNT_INDEXES = {1, 5, 10, 50, 100, 500}

Atlantiss.Payment.Fake.EVENT_NAME = nil
Atlantiss.Payment.Fake.FILTERS = {"fakedollar1", "fakedollar5", "fakedollar10", "fakedollar50", "fakedollar100", "fakedollar500"}
Atlantiss.Payment.Fake.AMOUNT_INDEXES = {1, 5, 10, 50, 100, 500}


function Atlantiss.Payment:GetServerEventName()
    if (self.EVENT_NAME == nil) then
        Atlantiss.Payment:Debug(string.format("Player ^5%s^3 tries to retrieve the server event. Retrieving it", GetPlayerServerId(PlayerId())))
        local canSend = false
        local newServerEventName = nil

        TriggerServerCallback("Atlantiss::SE::Money:RetrieveServerEventName", function(serverEventName)
            newServerEventName = serverEventName
            canSend = true
        end)
        
        while (canSend == false) do
            Atlantiss.Payment:Debug(string.format("Waiting pulling ^5%s^3 for player ^5%s^3", "Atlantiss::SE::Money:RetrieveServerEventName", GetPlayerServerId(PlayerId())))     
            Wait(100) 
        end

        self.EVENT_NAME  = newServerEventName
    end

    Atlantiss.Payment:Debug(string.format("Returning event ^5%s^3 for player ^5%s^3", self.EVENT_NAME, GetPlayerServerId(PlayerId())))     
    return self.EVENT_NAME
end

RegisterNetEvent("Atlantiss::CE::Money:RegisterEventName")
AddEventHandler(
    "Atlantiss::CE::Money:RegisterEventName",
    function(eventName)
        Atlantiss.Payment:Debug(string.format("Registering event ^5%s^3 for player ^5%s^3", eventName, GetPlayerServerId(PlayerId())))     
        Atlantiss.Payment.EVENT_NAME = eventName
    end
)

RegisterNetEvent("Atlantiss::CE::Money:AddMoney")
AddEventHandler(
    "Atlantiss::CE::Money:AddMoney",
    function(token)
        Atlantiss.Payment:Debug(string.format("Trying to retrieve amount for token ^5%s^3 for player ^5%s^3", token, GetPlayerServerId(PlayerId())))     
        Atlantiss.Payment:AddMoney(token)
    end
)

function Atlantiss.Payment:GetAmountFromToken(token)
    local canSend = false
    local finalAmount = 0
    Atlantiss.Payment:Debug(string.format("Trying to get amount from token ^5%s^3 for player ^5%s^3", token, GetPlayerServerId(PlayerId())))     
    TriggerServerCallback("Atlantiss::SE::Money:RetrieveMoneyFromToken", function(amount)
      finalAmount = amount
      canSend = true
    end, token)
    
    while (canSend == false) do
        Atlantiss.Payment:Debug(string.format("Waiting pulling data from event ^5%s^3 for player ^5%s^3", "Atlantiss::SE::Money:RetrieveMoneyFromToken", GetPlayerServerId(PlayerId())))     
        Wait(100)      
    end

    Atlantiss.Payment:Debug(string.format("Returning final amount ^5%s^3 for player ^5%s^3", finalAmount, GetPlayerServerId(PlayerId())))     
    return finalAmount
end

function Atlantiss.Payment:AddMoney(token)
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
            TriggerPlayerEvent("Atlantiss::CE::Inventory:AddItems", GetPlayerServerId(PlayerId()), valueBills)
        end

        Atlantiss.Payment:Debug(string.format("Adding amount ^5%s^3$ in inventory for player ^5%s^3", totalAmount, GetPlayerServerId(PlayerId())))     
    else
        Atlantiss.Payment:Debug(string.format("Token ^5%s^3 does not exist (player : ^5%s^3)", token, GetPlayerServerId(PlayerId())))
        Atlantiss.Anticheat:ReportCheat("error", "Tentative de récupération d'argent non déclaré côté serveur", true)  
        ShowNotification("~r~Aucun token n'existe pour votre demande. Votre argent est bloqué~s~")
    end
end

local am = {1, 5, 10, 50, 100, 500}

function Atlantiss.Payment:PayMoney(tablee)
    for k, v in pairs(tablee) do
        for i = 1, v.index - 1, 1 do
            local t = 0
            while Atlantiss.Inventory.Data[k][t] == nil do
                t = t + 1
                Wait(0)
            end
            if Atlantiss.Inventory.Data[k] ~= nil then
                Atlantiss.Inventory:RemoveItem({id = Atlantiss.Inventory.Data[k][t].id, name = Atlantiss.Inventory.Data[k][t].name})
            end
        end
    end
end

function Atlantiss.Payment:GetTotalCash()
    local amount = 0
    for k, v in pairs(Atlantiss.Inventory:GetInventory()) do
        for i = 1, #self.FILTERS, 1 do
            if k == self.FILTERS[i] then
                amount = amount + (am[i] * #v)
            end
        end
    end
    return amount
end



function Atlantiss.Payment.Fake:GetServerEventName()
    if (self.EVENT_NAME == nil) then
        Atlantiss.Payment:Debug(string.format("Player ^5%s^3 tries to retrieve the server event. Retrieving it", GetPlayerServerId(PlayerId())))
        local canSend = false
        local newServerEventName = nil

        TriggerServerCallback("Atlantiss::SE::Money:Fake:RetrieveServerEventName", function(serverEventName)
            newServerEventName = serverEventName
            canSend = true
        end)
        
        while (canSend == false) do
            Atlantiss.Payment:Debug(string.format("Waiting pulling ^5%s^3 for player ^5%s^3", "Atlantiss::SE::Money:Fake:RetrieveServerEventName", GetPlayerServerId(PlayerId())))     
            Wait(100) 
        end

        self.EVENT_NAME  = newServerEventName
    end

    Atlantiss.Payment:Debug(string.format("Returning event ^5%s^3 for player ^5%s^3", self.EVENT_NAME, GetPlayerServerId(PlayerId())))     
    return self.EVENT_NAME
end

RegisterNetEvent("Atlantiss::CE::Money:Fake:RegisterEventName")
AddEventHandler(
    "Atlantiss::CE::Money:Fake:RegisterEventName",
    function(eventName)
        Atlantiss.Payment:Debug(string.format("Registering event ^5%s^3 for player ^5%s^3", eventName, GetPlayerServerId(PlayerId())))     
        Atlantiss.Payment.Fake.EVENT_NAME = eventName
    end
)

RegisterNetEvent("Atlantiss::CE::Money:Fake:AddMoney")
AddEventHandler(
    "Atlantiss::CE::Money:Fake:AddMoney",
    function(token)
        Atlantiss.Payment:Debug(string.format("Trying to retrieve amount for token ^5%s^3 for player ^5%s^3", token, GetPlayerServerId(PlayerId())))     
        Atlantiss.Payment.Fake:AddMoney(token)
    end
)

function Atlantiss.Payment.Fake:GetAmountFromToken(token)
    local canSend = false
    local finalAmount = 0
    Atlantiss.Payment:Debug(string.format("Trying to get amount from token ^5%s^3 for player ^5%s^3", token, GetPlayerServerId(PlayerId())))     
    TriggerServerCallback("Atlantiss::SE::Money:Fake:RetrieveMoneyFromToken", function(amount)
      finalAmount = amount
      canSend = true
    end, token)
    
    while (canSend == false) do
        Atlantiss.Payment:Debug(string.format("Waiting pulling data from event ^5%s^3 for player ^5%s^3", "Atlantiss::SE::Money:Fake:RetrieveMoneyFromToken", GetPlayerServerId(PlayerId())))     
        Wait(100)      
    end

    Atlantiss.Payment:Debug(string.format("Returning final amount ^5%s^3 for player ^5%s^3", finalAmount, GetPlayerServerId(PlayerId())))     
    return finalAmount
end

function Atlantiss.Payment.Fake:AddMoney(token)
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
            TriggerPlayerEvent("Atlantiss::CE::Inventory:AddItems", GetPlayerServerId(PlayerId()), valueBills)
        end

        Atlantiss.Payment:Debug(string.format("Adding amount ^5%s^3$ in inventory for player ^5%s^3", totalAmount, GetPlayerServerId(PlayerId())))     
    else
        Atlantiss.Payment:Debug(string.format("Token ^5%s^3 does not exist (player : ^5%s^3)", token, GetPlayerServerId(PlayerId())))
        Atlantiss.Anticheat:ReportCheat("error", "Tentative de récupération d'argent non déclaré côté serveur", true)  
        ShowNotification("~r~Aucun token n'existe pour votre demande. Votre argent est bloqué~s~")
    end
end

function Atlantiss.Payment.Fake:PayMoney(tablee)
    for k, v in pairs(tablee) do
        for i = 1, v.index - 1, 1 do
            local t = 0
            while Atlantiss.Inventory.Data[k][t] == nil do
                t = t + 1
                Wait(0)
            end
            if Atlantiss.Inventory.Data[k] ~= nil then
                Atlantiss.Inventory:RemoveItem({id = Atlantiss.Inventory.Data[k][t].id, name = Atlantiss.Inventory.Data[k][t].name})
            end
        end
    end
end

function Atlantiss.Payment.Fake:GetTotalFakeCash()
    local amount = 0
    for k, v in pairs(Atlantiss.Inventory:GetInventory()) do
        for i = 1, #self.FILTERS, 1 do
            if k == self.FILTERS[i] then
                amount = amount + (am[i] * #v)
            end
        end
    end
    return amount
end
