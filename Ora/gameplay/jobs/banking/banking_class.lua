Banking = {}
local Banks = {}
local ratios = {
    ["classic"] = {maxDeposit = 5000, maxRemove = 5000, maxPayin = 10000, deposit = 0, remove = 0, payin = 0},
    ["gold"] = {maxDeposit = 15000, maxRemove = 15000, maxPayin = 30000, deposit = 0, remove = 0, payin = 0},
    ["platinium"] = {maxDeposit = 50000, maxRemove = 50000, maxPayin = 100000, deposit = 0, remove = 0, payin = 0},
    ["blackcard"] = {maxDeposit = 250000, maxRemove = 250000, maxPayin = 500000, deposit = 0, remove = 0, payin = 0}
}

Banking.GetAccount = function(name)
    if Banks[name] == nil then
        Banks[name] = Banking.CreateBanks(name)
    end
    return Banks[name]
end

Banking.GetFromUUID = function(uuid)
    --(json.encode(Banks))
    for i = 1, #Banks, 1 do
        if Banks[i].owner == uuid then
            return Banks[i]
        end
    end
end
Banking.GetFromUUID2 = function(uuid)
    for i = 1, #Banks, 1 do
        if Banks[i].coowner == uuid then
            return Banks[i]
        end
    end
end
RegisterServerCallback(
    "getInventoryOtherPPL",
    function(source, callback, target)
        local _source = target
        local identifers = GetIdentifiers(_source).steam
        local player = Player.GetPlayer(_source)
        MySQL.Async.fetchAll(
            "SELECT * FROM users WHERE identifier = @identifiers",
            {
                ["@identifiers"] = identifers
            },
            function(result)
                MySQL.Async.fetchAll(
                    "SELECT * FROM players_inventory WHERE uuid = @uuid",
                    {
                        ["@uuid"] = result[1].uuid
                    },
                    function(result)
                        callback(result[1].inventory)
                    end
                )
            end
        )
    end
)

math.randomseed(GetGameTimer())
local essenprice = math.random(10, 20) / 10
RegisterServerCallback(
    "GetPriceFuel",
    function(source, callback, target)
        callback(essenprice)
    end
)

function Banking.CreateBanks(name)
    local FLT = {}
    local self = FLT
    FLT.label = nil
    FLT.name = name
    FLT.owner = nil
    FLT.coowner = nil
    FLT.money = nil
    FLT.quotas = nil
    FLT.id = nil
    MySQL.Async.fetchAll(
        "SELECT * FROM banking_account WHERE iban = @name",
        {
            ["@name"] = name
        },
        function(result)
            if result[1] ~= nil then
                FLT.label = result[1].label
                FLT.owner = result[1].uuid
                FLT.coowner = result[1].coowner
                FLT.money = result[1].amount
                FLT.id = result[1].id
                FLT.quotas = result[1].todayratio
            else
                return --print("Aucun compte créer à cette adresse")
            end
        end
    )
    while FLT.id == nil do
        Wait(1)
    end
    FLT.removeMoney = function(m)
        --print("REMOVING MONEY")
        --print(m)
        MySQL.Async.execute(
            "UPDATE banking_account SET amount=amount - @m where id=@id",
            {
                ["@id"] = FLT.id,
                ["@m"] = m
            }
        )
    end
    FLT.addMoney = function(m)
        MySQL.Async.execute(
            "UPDATE banking_account SET amount=amount + @m where id=@id",
            {
                ["@id"] = FLT.id,
                ["@m"] = m
            }
        )
    end

    FLT.getMoney = function(m)
        local results = MySQL.Sync.fetchAll(
            "SELECT amount FROM banking_account WHERE id = @id",
            {
                ["@id"] =  FLT.id
            }
        )
        if (results ~= nil and results[1] ~= nil) then
            FLT.money = results[1].amount
        else
            FLT.money = 0
        end

        return FLT.money
    end

    return FLT
end
RegisterServerEvent("bankingRemoveFromAccount2")
AddEventHandler(
    "bankingRemoveFromAccount2",
    function(name, rem)
        local source = source
        MySQL.Async.execute(
            "UPDATE banking_account SET amount=amount - @m where iban=@id",
            {
                ["@id"] = name,
                ["@m"] = rem
            }
        )
    end
)
RegisterServerCallback(
    "getBankingAccountsPly3",
    function(source, callback, bank)
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account where iban=@uuid",
            {
                ["@uuid"] = bank
            },
            function(resu)
                callback(resu)
            end
        )
    end
)
RegisterServerCallback(
    "getBankingAccountsPly2",
    function(source, callback, id)
        local _source = source
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account where id=@id",
            {
                ["@id"] = id
            },
            function(result)
                acc = result
                callback(acc)
            end
        )
    end
)

RegisterServerCallback(
    "getBankingCard",
    function(source, callback, id)
        --print(id)
        local _source = source
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_cards where number=@id",
            {
                ["@id"] = id
            },
            function(result)
                acc = result
                callback(acc)
            end
        )
    end
)
RegisterServerCallback(
    "getBankingAccountsPly",
    function(source, callback)
        local _source = source
        local uuid = Ora.Identity:GetUuid(_source)
        local acc = {own = {}, coOwn = {}}
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account where uuid=@uuid",
            {
                ["@uuid"] = uuid
            },
            function(result)
                acc.own = result
                MySQL.Async.fetchAll(
                    "SELECT * FROM banking_account where coowner=@uuid",
                    {
                        ["@uuid"] = uuid
                    },
                    function(result)
                        acc.coOwn = result

                        callback(acc)
                    end
                )
            end
        )
    end
)
RegisterServerCallback(
    "banksExists",
    function(source, callback, name)
        MySQL.Async.fetchAll(
            "SELECT uuid FROM banking_account WHERE iban = @name",
            {
                ["@name"] = name
            },
            function(result)
                if result[1] ~= nil then
                    callback(true)
                else
                    callback(false)
                end
            end
        )
    end
)
RegisterServerCallback(
    "getAllBanks",
    function(source, callback)
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account",
            {},
            function(result)
                callback(result)
            end
        )
    end
)

RegisterServerCallback(
    "getHisto",
    function(_, callback, label, iban)
        if (iban and iban ~= label) then
            MySQL.Async.fetchAll(
                "SELECT * FROM banking_transactions WHERE src = @iban OR src = @label OR dest = @iban OR dest = @label ORDER BY id DESC",
                {
                    ["@iban"] = iban,
                    ["@label"] = label
                },
                function(histo)
                    callback(histo)
                end
            )
        else
            MySQL.Async.fetchAll(
                "SELECT * FROM banking_transactions WHERE src = @iban OR dest = @iban ORDER BY id DESC",
                {
                    ["@iban"] = label
                },
                function(histo)
                    callback(histo)
                end
            )
        end
    end
)

RegisterServerCallback("getBanksSummaryInfo", function(source, cb)
    local bankInfos = MySQL.Sync.fetchAll("SELECT id, label, amount, iban, uuid FROM banking_account")
    local accountsOwnerDetails = MySQL.Sync.fetchAll("SELECT uuid, first_name, last_name FROM players_identity")
    cb(bankInfos, accountsOwnerDetails)
end)

RegisterServerCallback("getAccountInfo", function(source, cb, accountId)
    local accountInfo = MySQL.Sync.fetchAll("SELECT * FROM banking_account WHERE id = @id", { ["@id"] = accountId })
    local cards = MySQL.Sync.fetchAll("SELECT * FROM banking_cards WHERE account = @id", { ["@id"] = accountId })

    for k, v in pairs(cards) do
        local info = json.decode(v.current_ratio)
        if (info.maxPayin == nil or info.maxPayin == "") then
            info.maxPayin = ratios[v.type].maxPayin
        end

        if (info.payin == nil) then
            info.payin = 0
        end

        v.current_ratio = info
        
    end

    cb(accountInfo, cards)
end)

RegisterServerCallback("getLoansInfo", function(source, cb, type)
    local loans = MySQL.Sync.fetchAll("SELECT * FROM banking_prets WHERE type = @type", { ["@type"] = type })
    cb(loans)
end)

RegisterServerCallback("getBankInfoFromID", function(source, cb, accountId)
    --print(accountId)
    local bank = MySQL.Sync.fetchAll("SELECT * FROM banking_account WHERE id = @id", { ["@id"] = accountId })
    print("Data ", json.encode(bank[1]))
    cb(bank[1])
end)

RegisterServerCallback("bank:getHistory", function(source, cb, accountId)
    local history = MySQL.Sync.fetchAll("SELECT * FROM banking_transactions WHERE src = @id OR dest = @id ORDER BY id DESC", { ["@id"] = accountId })
    cb(history)
end)

RegisterServerCallback(
    "getAllBanks2",
    function(source, callback)
        MySQL.Async.fetchAll(
            "SELECT id, label, amount, uuid FROM banking_account",
            {},
            function(result)
                MySQL.Async.fetchAll(
                    "SELECT uuid, first_name, last_name FROM players_identity",
                    {},
                    function(_result)
                        callback(result, _result)
                    end
                )
            end
        )
    end
)

RegisterServerCallback("getAccountsInfo", function(source, callback, id)
    local accountId = id
    MySQL.Async.fetchAll("SELECT * FROM banking_cards", {}, function(dresult)
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_transactions",
            {},
            function(mresult)
                
            end
        )
    end)
end)

RegisterServerCallback("getLoanInfos", function()
    MySQL.Async.fetchAll(
        "SELECT * FROM banking_prets",
        {},
        function(presult)
            callback(presult)
        end
    )
end)

--print('a')
MySQL.ready(
    function()
        --print("p")
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_prets WHERE type = 0",
            {},
            function(result)
                for i = 1, #result, 1 do
                    local now = os.time()

                    if result[i].date < now then
                        --print(result[i].label)
                        MySQL.Async.fetchAll(
                            "SELECT * FROM banking_account WHERE id = @id",
                            {
                                ["@id"] = result[i].account
                            },
                            function(_result)
                                local am =
                                    (result[i].base_amount + ((result[i].base_amount / 100) * result[i].percent)) /
                                    result[i].total

                                if _result[1] ~= nil then
                                    if _result[1].amount - am >= 0 then
                                        MySQL.Async.execute(
                                            "UPDATE banking_account SET amount = amount - @amount where id=@id",
                                            {
                                                ["@id"] = result[i].account,
                                                ["@amount"] = am
                                            }
                                        )

                                        MySQL.Async.execute(
                                            "UPDATE banking_prets SET amount = amount - @amount, current = current + 1,date=@date  where id=@id",
                                            {
                                                ["@id"] = result[i].id,
                                                ["@amount"] = am,
                                                ["@date"] = now + 604800
                                            }
                                        )
                                        if result[i].current + 1 == result[i].total then
                                            MySQL.Async.execute(
                                                "UPDATE banking_prets SET type = 1 where id=@id",
                                                {
                                                    ["@id"] = result[i].id
                                                }
                                            )
                                        end
                                    else
                                        MySQL.Async.execute(
                                            "UPDATE banking_account SET bloqued = true where id=@id",
                                            {
                                                ["@id"] = result[i].account
                                            }
                                        )
                                        MySQL.Async.execute(
                                            "INSERT INTO mailing (receiver,message,expeditor) VALUES(@mailTo,@Message,@mailFrom)",
                                            {
                                                ["@mailTo"] = "mazegroup",
                                                ["@Message"] = _result[1].iban ..
                                                    " n'a pas pu payé le prêt, nom : " .. result[i].label,
                                                ["@mailFrom"] = "mazegroup"
                                            }
                                        )
                                    end
                                end
                            end
                        )
                    end
                end
            end
        )
    end
)

RegisterServerEvent("core:DeleteThisCard")
AddEventHandler(
    "core:DeleteThisCard",
    function(id)
        MySQL.Async.execute(
            "DELETE from banking_cards where id=@id",
            {
                ["@id"] = id
            }
        )
    end
)
RegisterServerEvent("newCode")
AddEventHandler(
    "newCode",
    function(newCode, id)
        MySQL.Async.execute(
            "UPDATE banking_cards SET code = @code where number=@id",
            {
                ["@id"] = id,
                ["@code"] = newCode
            }
        )
    end
)
RegisterServerEvent("bank:oneprets")
AddEventHandler(
    "bank:oneprets",
    function(prets)
        local am = (prets.base_amount + ((prets.base_amount / 100) * prets.percent)) / prets.total
        MySQL.Async.execute(
            "UPDATE banking_account SET amount = amount - @amount where id=@id",
            {
                ["@id"] = prets.account,
                ["@amount"] = am
            }
        )

        MySQL.Async.execute(
            "UPDATE banking_prets SET amount = amount - @amount, current = current + 1,date=@date  where id=@id",
            {
                ["@id"] = prets.id,
                ["@amount"] = am,
                ["@date"] = now + 604800
            }
        )
        if prets.current + 1 == prets.total then
            MySQL.Async.execute(
                "UPDATE banking_prets SET type = 1 where id=@id",
                {
                    ["@id"] = prets.id
                }
            )
        end
    end
)
MySQL.ready(
    function()
        -- print("^3Starting bank_ratio reset ^0")

        -- local results = MySQL.Sync.fetchAll(
        --     "SELECT *  FROM players_inventory",
        --     {

        --     }
        -- )

        -- for i = 1 , #results, 1 do
        --     local p = json.decode(results[i].inventory)
        --     local ind = p["bank_card"]
        --     local c = {}
        --     local save = false

        --     if ind ~= nil then
        --         for k ,v in pairs(ind) do
        --             table.insert( c, v )
        --         end
        --     end

        --     ind = c
        --     p["bank_card"] = ind

        --     for j = 1 , #ind , 1 do
        --         if ind[j] ~= nil and ind[j].data ~= nil and ind[j].data.current_ratio ~= nil and ind[j].data.current_ratio.remove > 0 then
        --             print("^6Remove before " .. ind[j].data.current_ratio.remove .. "^0")
        --             ind[j].data.current_ratio.remove = 0
        --             save = true
        --         end

        --         if ind[j] ~= nil and ind[j].data ~= nil and ind[j].data.current_ratio ~= nil and ind[j].data.current_ratio.deposit > 0 then
        --             print("^6Deposit before " .. ind[j].data.current_ratio.deposit .. "^0")
        --             ind[j].data.current_ratio.deposit = 0
        --             save = true
        --         end
        --     end

        --     local t = json.encode(p)

        --     local updateResults = MySQL.Sync.execute(
        --         "UPDATE players_inventory SET inventory=@data where id=@id",
        --         {
        --             ["@id"] = results[i].id,
        --             ["@data"] = t,
        --         }
        --     )
        --     print("^6[players_inventory] Ratio reset : ROW(S) UPDATED ^0" .. updateResults)

        -- end

        MySQL.Async.execute(
            'UPDATE banking_cards SET current_ratio = JSON_MERGE_PATCH(current_ratio, \'{"deposit":0, "remove":0}\')',
            {},
            function(affectedRows)
                print("^6[banking_cards] MASS RATIO RESET : ROW(S) UPDATED ^0" .. affectedRows)
            end
        )

        MySQL.Async.execute(
            'UPDATE banking_account SET todayratio = JSON_MERGE_PATCH(todayratio, \'{"deposit":0, "remove":0}\')',
            {},
            function(affectedRows)
                print("^6[banking_account] MASS RATIO RESET : ROW(S) UPDATED ^0" .. affectedRows)
            end
        )
    end
)

RegisterServerEvent("newTransaction")
AddEventHandler(
    "newTransaction",
    function(_s, dest, am, title, details)
        local time = os.date("%d/%m/%y %X")
        MySQL.Async.execute(
            "INSERT INTO banking_transactions (src, dest, montant, title, details) VALUES(@src, @dest, @montant, @title, @details)",
            {
                ["@src"] = _s,
                ["@dest"] = dest,
                ["@montant"] = am,
                ["@title"] = title,
                ["@details"] = time..((details ~= nil and details ~= "") and (" - "..details) or "")
            }
        )
    end
)

RegisterServerEvent("banking:removeAmountFromAccount")
AddEventHandler(
    "banking:removeAmountFromAccount",
    function(accountRib, amount)
        if source ~= nil then
            TriggerEvent("business:SetProductivity", source, accountRib, amount, false)
        end
        MySQL.Async.execute(
            "UPDATE banking_account SET amount = amount - @amount WHERE iban = @iban",
            {
                ["@iban"] = accountRib,
                ["@amount"] = amount
            },
            function(results)
            end
        )
    end
)

function Random5(max)
    local c = 0
    TriggerEvent(
        "getRandom",
        function(m)
            c = m
            return c
        end,
        max
    )
end
local function GenerateNumber(cv)
    local result = {}
    local found = false

    MySQL.Async.fetchAll(
        "SELECT * FROM banking_cards",
        {},
        function(dresult)
            local unique = false
            local table = nil
            while not unique do
                Wait(1)
                --print("yessai2")
                math.randomseed(GetGameTimer())
                p = math.random(1111, 9999)

                Wait(50)
                math.randomseed(GetGameTimer())
                r = math.random(1111, 9999)
                Wait(50)
                math.randomseed(GetGameTimer())
                c = math.random(1111, 9999)
                Wait(50)
                math.randomseed(GetGameTimer())
                pp = math.random(1111, 9999)
                table = p .. r .. c .. pp

                table = tonumber(table)
                result = dresult
                found = false
                for i = 1, #result, 1 do
                    if result[i].number == table then
                        found = true
                        break
                    end
                end
                --print("yessai3")
                if not found then
                    unique = true
                    break
                end
                --print("yessai4")
                --print("checking " .. table)
            end
            cv(table)
        end
    )
end

RegisterServerEvent("newCard")
AddEventHandler(
    "newCard",
    function(tab, id, type)
        local number = nil
        GenerateNumber(
            function(t)
                --print(t)
                number = t
            end
        )
        while number == nil do
            Wait(1)
        end
        MySQL.Async.execute(
            "INSERT INTO banking_cards (type,uuid,account,code,number,current_ratio) VALUES(@type,@uuid,@account,@code,@number,@current_ratio)",
            {
                ["@type"] = type,
                ["@uuid"] = tab.uuid,
                ["@account"] = id,
                ["@code"] = tab.code,
                ["@number"] = number,
                ["@current_ratio"] = json.encode(ratios[type])
            }
        )
    end
)

RegisterServerCallback(
    "Ora_banking:getRatiosForCard",
    function(source, callback, cardNumber)
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_cards WHERE number = @cardNumber",
            {
                ["@cardNumber"] = cardNumber
            },
            function(result)
                if (result[1] == nil) then
                    callback(false, 0, 0, 0, 0, 0, 0)
                else
                    local info = json.decode(result[1].current_ratio)
                    if (info.maxPayin == nil or info.maxPayin == "") then
                        info.maxPayin = ratios[result[1].type].maxPayin
                    end

                    if (info.payin == nil) then
                        info.payin = 0
                    end

                    callback(
                        true,
                        info.maxDeposit,
                        info.maxRemove,
                        info.maxPayin,
                        info.deposit,
                        info.remove,
                        info.payin
                    )
                end
            end
        )
    end
)

RegisterServerEvent("Ora_bank:removeMoneyFromBankAccount")
AddEventHandler(
    "Ora_bank:removeMoneyFromBankAccount",
    function(id, amount)
        local _source = source
        local account = Banking.GetAccount(id)
        local limit = 0

        while account.getMoney() == nil do
            Wait(10)
            limit = limit + 1
            if (limit == 50) then
                TriggerClientEvent(
                    "RageUI:Popup",
                    _source,
                    {
                        message = "💰 BANQUE\n~r~Probleme, nous ne trouvons pas votre compte en banque~s~"
                    }
                )
            end
        end
        
        if (math.tointeger(account.getMoney()) - math.tointeger(amount) >= 0) then
            account.removeMoney(amount)
            local player = Player.GetPlayer(_source)
            player.addMoney(amount)
        else
            TriggerClientEvent(
                "RageUI:Popup",
                _source,
                {
                    message = "💰 BANQUE\n~r~Probleme, vous n'avez pas les fonds nécessaires. Opération annulée~s~"
                }
            )
        end
    end
)

RegisterServerEvent("Ora_bank:addMoneyToBankAccount")
AddEventHandler(
    "Ora_bank:addMoneyToBankAccount",
    function(id, amount)
        local source = source
        local account = Banking.GetAccount(id)
        while account.getMoney() == nil do
            Wait(1)
        end

        account.addMoney(amount)
        local player = Player.GetPlayer(source)
        player.removeMoney(amount)
    end
)

RegisterServerEvent("Ora_bank:addRemoveQuotaToCard")
AddEventHandler(
    "Ora_bank:addRemoveQuotaToCard",
    function(cardNumber, amount)
        local _source = source
        MySQL.Async.fetchAll(
            "SELECT current_ratio FROM banking_cards WHERE number = @cardNumber",
            {
                ["@cardNumber"] = cardNumber
            },
            function(result)
                if (result[1] == nil) then
                    print("^1[BANKING] YES CARD - Trying to get unexistant card : " .. cardNumber)
                else
                    local ratio = json.decode(result[1].current_ratio)
                    ratio.remove = ratio.remove + amount

                    MySQL.Async.execute(
                        "UPDATE banking_cards SET current_ratio = @currentRatio where number = @cardNumber",
                        {
                            ["@currentRatio"] = json.encode(ratio),
                            ["@cardNumber"] = cardNumber
                        }
                    )

                    print(
                        "^3[UPDATE] " ..
                            cardNumber .. " updated remove ratio : " .. ratio.remove .. "(added : " .. amount .. "$)^0"
                    )

                    TriggerClientEvent(
                        "RageUI:Popup",
                        _source,
                        {
                            message = "💰 BANQUE\n~g~Ratio de retrait : " ..
                                ratio.remove .. "$/" .. ratio.maxRemove .. "$~s~"
                        }
                    )
                end
            end
        )
    end
)

RegisterServerEvent("Ora_bank:addDepositQuotaToCard")
AddEventHandler(
    "Ora_bank:addDepositQuotaToCard",
    function(cardNumber, amount)
        local _source = source
        MySQL.Async.fetchAll(
            "SELECT current_ratio FROM banking_cards WHERE number = @cardNumber",
            {
                ["@cardNumber"] = cardNumber
            },
            function(result)
                if (result[1] == nil) then
                    print("^1[BANKING] YES CARD - Trying to get unexistant card : " .. cardNumber .. "^0")
                else
                    local ratio = json.decode(result[1].current_ratio)
                    ratio.deposit = ratio.deposit + amount

                    MySQL.Async.execute(
                        "UPDATE banking_cards SET current_ratio = @currentRatio where number = @cardNumber",
                        {
                            ["@currentRatio"] = json.encode(ratio),
                            ["@cardNumber"] = cardNumber
                        }
                    )

                    TriggerClientEvent(
                        "RageUI:Popup",
                        _source,
                        {
                            message = "💰 BANQUE\n~g~Ratio de dépôt : " ..
                                ratio.deposit .. "$/" .. ratio.maxDeposit .. "$~s~"
                        }
                    )

                    print(
                        "^3[UPDATE] " ..
                            cardNumber .. " updated deposit ratio : " .. ratio.deposit .. "(added : " .. amount .. "$)^0"
                    )
                end
            end
        )
    end
)

RegisterServerEvent("bank:DeleteAccounts")
AddEventHandler(
    "bank:DeleteAccounts",
    function(id)
        MySQL.Async.execute(
            "DELETE FROM banking_account where id=@id",
            {
                ["@id"] = id
            }
        )
        MySQL.Async.execute(
            "DELETE FROM banking_cards where account=@id",
            {
                ["@id"] = id
            }
        )
    end
)

RegisterServerEvent("bankBlockAcc")
AddEventHandler(
    "bankBlockAcc",
    function(check, id)
        MySQL.Async.execute(
            "UPDATE banking_account SET bloqued=@check where id=@id",
            {
                ["@id"] = id,
                ["@check"] = tostring(check)
            }
        )
    end
)

RegisterServerEvent("cardBlock")
AddEventHandler(
    "cardBlock",
    function(check, id)
        MySQL.Async.execute(
            "UPDATE banking_cards SET bloqued=@check where id=@id",
            {
                ["@id"] = id,
                ["@check"] = check
            }
        )
    end
)

RegisterServerEvent("bankUpdateNum")
AddEventHandler(
    "bankUpdateNum",
    function(num, id)
        MySQL.Async.execute(
            "UPDATE banking_account SET phone_number=@num where id=@id",
            {
                ["@num"] = num,
                ["@id"] = id
            }
        )
    end
)

RegisterServerCallback(
    "createAccount",
    function(source, callback, tab)
        local unique = false
        local table = Ora.NpcJobs.Bank:GenerateNewIban()
        -- MySQL.Async.fetchAll(
        --     "SELECT * FROM banking_account",
        --     {},
        --     function(result)
        --         while not unique do
        --             Wait(1)
        --             math.randomseed(GetGameTimer())
        --             table = "LS-" .. math.random(11111111, 99999999)
        --             local found = false
        --             for i = 1, #result, 1 do
        --                 if result[i].iban == table then
        --                     found = true
        --                 end
        --             end
        --             if not found then
        --                 unique = true
        --             end
        --         end
        --     end
        -- )
        while table == nil do
            Wait(1)
        end
        MySQL.Async.execute(
            "INSERT INTO banking_account (label,uuid,iban,phone_number) VALUES(@label,@uuid,@iban,@phone_number)",
            {
                ["@label"] = tab.name,
                ["@uuid"] = tab.uuid,
                ["@iban"] = table,
                ["@phone_number"] = tab.number
            }
        )
        callback(table)
    end
)
RegisterServerCallback(
    "newCard",
    function(source, callback, tab, id, type)
        local number = nil
        GenerateNumber(
            function(t)
                --print(t)
                number = t
            end
        )
        while number == nil do
            Wait(1)
            --  --print("o")
        end
        MySQL.Async.execute(
            "INSERT INTO banking_cards (type,uuid,account,code,number,current_ratio) VALUES(@type,@uuid,@account,@code,@number,@current_ratio)",
            {
                ["@type"] = type,
                ["@uuid"] = tab.uuid,
                ["@account"] = id,
                ["@code"] = tab.code,
                ["@number"] = number,
                ["@current_ratio"] = json.encode(ratios[type])
            }
        )
        callback(number, ratios[type])
    end
)

RegisterServerCallback(
    "newPrets",
    function(source, callback, tab)
        now = os.time()
        MySQL.Async.execute(
            "INSERT INTO banking_prets (account,label,total,current,percent,amount,base_amount,date) VALUES(@account,@label,@total,0,@percent,@amount,@base_amount,@data)",
            {
                ["@type"] = type,
                ["@account"] = tab.account,
                ["@percent"] = tab.Index,
                ["@label"] = tab.label,
                ["@total"] = tab.total,
                ["@amount"] = tab.cAm,
                ["@base_amount"] = tab.montant,
                ["@data"] = now + 604800
            }
        )

        callback(true)
    end
)

RegisterServerEvent("bankingRemoveFromAccount")
AddEventHandler(
    "bankingRemoveFromAccount",
    function(name, rem, dat)
        local source = source
        local account = Banking.GetAccount(name)
        while account.getMoney() == nil do
            Wait(1)
        end
        if 0 <= account.getMoney() - rem then
            account.removeMoney(rem)
            account.quotas = dat
            local player = Player.GetPlayer(source)
            player.addMoney(rem)
        end
    end
)
RegisterServerEvent("bank:GenerateBankAccount")
AddEventHandler(
    "bank:GenerateBankAccount",
    function()
        local _source = source
        local uuid = Ora.Identity:GetUuid(_source)
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account",
            {},
            function(result)
                local unique = false
                local table = nil
                while not unique do
                    Wait(1)
                    table = "LS-" .. math.random(11111111, 99999999)
                    local found = false
                    for i = 1, #result, 1 do
                        if result[i].iban == table then
                            found = true
                        end
                    end
                    if not found then
                        unique = true
                    end
                end
                MySQL.Async.execute(
                    "INSERT INTO banking_account (label,uuid,amount,iban) VALUES(@label,@owner,@amount,@iban)",
                    {
                        ["@label"] = "Compte personnel",
                        ["@owner"] = uuid,
                        ["@amount"] = 500,
                        ["@iban"] = "LS-" .. math.random(11111111, 99999999)
                    }
                )
            end
        )
    end
)

RegisterServerEvent("bankingAddFromAccount")
AddEventHandler(
    "bankingAddFromAccount",
    function(name, rem, dat)
        local source = source
        local account = Banking.GetAccount(name)
        while account.getMoney() == nil do
            Wait(1)
        end

        account.addMoney(rem)
        account.quotas = dat
        local player = Player.GetPlayer(source)
        player.removeMoney(rem)
    end
)
RegisterServerEvent("bankingAddFromAccount3")
AddEventHandler(
    "bankingAddFromAccount3",
    function(name, rem)
        local source = source
        local account = Banking.GetAccount(name)
        while account.getMoney() == nil do
            Wait(1)
        end
        account.addMoney(rem)
    end
)

RegisterServerEvent("bankingSendMoney")
AddEventHandler(
    "bankingSendMoney",
    function(target, money, src)
        local targetAccount = Banking.GetAccount(target)
        local srcAccount = Banking.GetAccount(src)
        while targetAccount.getMoney() == nil do
            Wait(1)
        end
        while srcAccount.getMoney() == nil do
            Wait(1)
        end
        targetAccount.addMoney(money)
        srcAccount.removeMoney(money)

        for k, v in pairs(Users) do
            if v.uuid == srcAccount.uuid then
                TriggerClientEvent(
                    "RageUI:Popup",
                    v.source,
                    {message = "Vous avez reçu un nouveau virement de " .. money .. "$ de la part du compte " .. src}
                )
                break
            end
        end
    end
)

RegisterServerEvent("entreprise:Add")
AddEventHandler(
    "entreprise:Add",
    function(target, money)
        local targetAccount = Banking.GetAccount(target)
        while targetAccount.getMoney() == nil do
            Wait(1)
        end
        targetAccount.addMoney(money)
    end
)

RegisterServerEvent("banking:EditCard")
AddEventHandler(
    "banking:EditCard",
    function(id, banking)
        MySQL.Async.execute(
            "UPDATE banking_cards SET current_ratio=@uuid where number=@id",
            {
                ["@id"] = id,
                ["@uuid"] = banking
            }
        )
    end
)

RegisterServerEvent("bank:Add")
AddEventHandler(
    "bank:Add",
    function(id, uuid)
        MySQL.Async.execute(
            "UPDATE banking_account SET coowner=@uuid where id=@id",
            {
                ["@id"] = id,
                ["@uuid"] = uuid
            }
        )
    end
)

local function GetFirstAccountFound(src, cb)
    local _src = src
    MySQL.Async.fetchAll(
        "SELECT iban FROM banking_account WHERE uuid = @uuid AND iban LIKE '%ATL%'",
        {
            ["@uuid"] = Ora.Identity:GetUuid(_src)
        },
        function(res)
            if res then
                cb(true, res)
            else
                cb(false)
            end
        end
    )
end

RegisterServerCallback('Ora:addBankIfExists', function(s, cb, _source, amount)
    GetFirstAccountFound(
        _source,
        function(bool, res)
            if bool and res[1] then
                local iban = res[1].iban
                MySQL.Async.execute(
                    "UPDATE banking_account SET amount = amount + @amount WHERE iban = @iban",
                    {
                        ["@amount"] = amount,
                        ["@iban"] = iban
                    }
                )
                cb(true)
            else
                cb(false)
            end
        end
    )
end)

RegisterServerEvent("Ora:RemoveFromBankAccount")
AddEventHandler(
    "Ora:RemoveFromBankAccount",
    function(id, amount)
        MySQL.Async.execute(
            "UPDATE banking_account SET amount = amount - @amount WHERE iban = @iban",
            {
                ["@amount"] = amount,
                ["@iban"] = id
            }
        )
    end
)

RegisterServerEvent("Ora:AddFromBankAccount")
AddEventHandler(
    "Ora:AddFromBankAccount",
    function(id, amount)
        MySQL.Async.execute(
            "UPDATE banking_account SET amount = amount + @amount WHERE iban = @iban",
            {
                ["@amount"] = amount,
                ["@iban"] = id
            }
        )
    end
)
