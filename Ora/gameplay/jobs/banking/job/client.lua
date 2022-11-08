Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("mazegroup", "main", RageUI.CreateMenu("Maze Group", "Maze Group", 10, 100))

        RMenu.Add("bank", "main", RageUI.CreateSubMenu(RMenu:Get("mazegroup", "main"), "Maze Bank", "Menu Maze Bank", 10, 100))

        RMenu.Add("banks", "main", RageUI.CreateMenu("Maze Bank", "Catégories disponibles", 10, 100, nil, nil, 52, 177, 74, 1.0))
        -- creata acc
        InitImmosMenus()
        RMenu.Add(
            "banks",
            "create_acc",
            RageUI.CreateSubMenu(RMenu:Get("banks", "main"), "Banque", "Catégories disponibles", 10, 100)
        )
        RMenu.Add(
            "banks",
            "identity_list3",
            RageUI.CreateSubMenu(RMenu:Get("banks", "create_acc"), "Banque", "Listes des joueurs", 10, 100)
        )
        -- acc lists
        RMenu.Add(
            "banks",
            "list_main",
            RageUI.CreateSubMenu(RMenu:Get("banks", "main"), "Banque", "Listes des comptes", 10, 100)
        )
        RMenu.Add(
            "banks",
            "list_pret",
            RageUI.CreateSubMenu(RMenu:Get("banks", "main"), "Banque", "Action disponibles", 10, 100)
        )
        RMenu.Add(
            "banks",
            "list_pret_1",
            RageUI.CreateSubMenu(RMenu:Get("banks", "list_pret"), "Banque", "Prêts en cours", 10, 100)
        )
        RMenu.Add(
            "banks",
            "list_pret_2",
            RageUI.CreateSubMenu(RMenu:Get("banks", "list_pret"), "Banque", "Prêts terminés", 10, 100)
        )
        RMenu.Add(
            "banks",
            "list_pret_3",
            RageUI.CreateSubMenu(RMenu:Get("banks", "list_pret_1"), "Banque", "Prêts en cours", 10, 100)
        )

        RMenu.Add(
            "banks",
            "gestion_comptes",
            RageUI.CreateSubMenu(RMenu:Get("banks", "list_main"), "Banque", "Gestion du compte", 10, 100)
        )
        RMenu.Add(
            "banks",
            "deposit_money_by_bank",
            RageUI.CreateSubMenu(RMenu:Get("banks", "gestion_comptes"), "Banque", "Déposer de l'argent", 10, 100)
        )
        RMenu.Add(
            "banks",
            "identity_list",
            RageUI.CreateSubMenu(RMenu:Get("banks", "gestion_comptes"), "Banque", "Listes des joueurs", 10, 100)
        )
        RMenu.Add(
            "banks",
            "historiques",
            RageUI.CreateSubMenu(RMenu:Get("banks", "gestion_comptes"), "Banque", "Historique du compte", 10, 100)
        )
        RMenu.Add(
            "banks",
            "create_card",
            RageUI.CreateSubMenu(RMenu:Get("banks", "gestion_comptes"), "Banque", "Créer une carte", 10, 100)
        )
        RMenu.Add(
            "banks",
            "create_prêt",
            RageUI.CreateSubMenu(RMenu:Get("banks", "gestion_comptes"), "Banque", "Créer un prêt", 10, 100)
        )
        RMenu.Add(
            "banks",
            "identity_list2",
            RageUI.CreateSubMenu(RMenu:Get("banks", "create_card"), "Banque", "Listes des joueurs", 10, 100)
        )

        -- atm
        RMenu.Add("banking", "main_atm", RageUI.CreateMenu(nil, "Actions disponibles", 600, 200))
        RMenu.Add("banking", "manage_account", RageUI.CreateSubMenu(RMenu:Get("banking", "main_atm")))
        RMenu.Add("banking", "deposit_money", RageUI.CreateSubMenu(RMenu:Get("banking", "manage_account")))
    end
)

local lastDeposit = 0
local MIN_TIME_BETWEEN_DEPOSITS = 30000

function EnterBankZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour gérer les comptes en banques")
    KeySettings:Add("keyboard", "E", OpenBankMenu, "BANK")
    KeySettings:Add("controller", 46, OpenBankMenu, "BANK")
end

function ExitBankZone()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard", "E", "BANK")
    KeySettings:Clear("controller", "E", "BANK")
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
end

local function Format(identity)
    local _table = {}
    for i = 1, #identity, 1 do
        _table[identity[i].uuid] = identity[i]
    end
    for k, v in pairs(Jobs) do
        if v.iban then
            _table[v.iban] = {
                first_name = v.label,
                last_name = "",
                uuid = v.iban
            }
        end
    end
    return _table
end

local function FormatBankAccounts(bankAccounts)
    for k, v in pairs(bankAccounts) do
        if v.uuid == "0" then
            v.uuid = v.iban
        end
    end
    return bankAccounts
end

local function Format2(cards)
    local _table = {}
    for i = 1, #cards, 1 do
        if _table[cards[i].account] == nil then
            _table[cards[i].account] = {}
        end
        table.insert(_table[cards[i].account], cards[i])
    end
    return _table
end
local function Format3(rs)
    local _table = {}
    local table_ = {}
    for i = 1, #rs, 1 do
        if rs[i].type == 0 then
            table.insert(table_, rs[i])
        else
            table.insert(_table, rs[i])
        end
    end
    return _table, table_
end

local GUI = {}
GUI.Time = 0
local Banks = {}
local Identity = {}
local Cards = {}
local History = {}
local Prets = {}
function OpenBankMenu()
    RageUI.Visible(RMenu:Get("banks", "main"), false)
    Banks = nil

    TriggerServerCallback(
        "getAllBanks2",
        function(result, _result, dresult, mresult, presult)
            Identity = Format(_result)
            Cards = Format2(dresult)
            History = mresult
            Banks = FormatBankAccounts(result)
            PretsTermine, PretsCours = Format3(presult)
        end
    )
    while Banks == nil do
        Wait(1)
    end
    RageUI.Visible(RMenu:Get("banks", "main"), true)
end
local filterSearch = {
    search = nil,
    filter = nil,
    minAmount = nil,
    display = {
        name = true,
        label = true,
        amount = false
    },
    Label = {"Montant", "Alphabétique", "Date de création", "Aucun"},
    Index = 4,
    filterASC = true
}
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do
        keys[#keys + 1] = k
    end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(
            keys,
            function(a, b)
                return order(t, a, b)
            end
        )
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
local currentBank = nil
local typeCarte = {
    Label = {"Classic", "Gold", "Platinium", "Blackcard"},
    Index = 1,
    total = 1
}
local createCard = {
    uuid = nil
}
local creatingAcc = {
    name = nil
}
function GetBankInfoFromID(id)
    for i = 1, #Banks, 1 do
        if Banks[i].id == id then
            return Banks[i]
        end
    end

    return nil
end
local typePret = {
    amount = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20},
    Index = 1
}
for i = 1, #typePret.amount, 1 do
    typePret.amount[i] = typePret.amount[i] .. "%"
end


local filter = {"dollar1", "dollar5", "dollar10", "dollar50", "dollar100", "dollar500"}
local am = {1, 5, 10, 50, 100, 500}
local m = {
    dollar1 = {
        index = 1,
        label = {0}
    },
    dollar5 = {
        index = 1,
        label = {0}
    },
    dollar10 = {
        index = 1,
        label = {0}
    },
    dollar50 = {
        index = 1,
        label = {0}
    },
    dollar100 = {
        index = 1,
        label = {0}
    },
    dollar500 = {
        index = 1,
        label = {0}
    }
}

local currentPrets = {}
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("banks", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Comptes",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "list_main")
                        )

                        RageUI.Button(
                            "Prêts",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "list_pret")
                        )

                        RageUI.Button(
                            "Créer un nouveau compte",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "create_acc")
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "list_pret")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "En cours",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "list_pret_1")
                        )

                        RageUI.Button(
                            "Terminé",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "list_pret_2")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("banks", "list_pret_1")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for i = 1, #PretsCours, 1 do
                            local firstname = "Citoyen"
                            local lastname = "Expulsé"
                            print(json.encode(PretsCours[i]))

                            local bankInfo = GetBankInfoFromID(PretsCours[i].account)

                            if (bankInfo ~= nil and bankInfo.uuid ~= nil and Identity[bankInfo.uuid] ~= nil) then
                                firstname = Identity[bankInfo.uuid].first_name
                                lastname = Identity[bankInfo.uuid].last_name
                            end

                            RageUI.Button(
                                PretsCours[i].label ..
                                    " - " ..
                                        PretsCours[i].amount ..
                                            "/" .. PretsCours[i].base_amount .. "$ | " .. firstname .. " " .. lastname,
                                nil,
                                {RightLabel = PretsCours[i].current .. "/" .. PretsCours[i].total},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        currentPrets = PretsCours[i]
                                    end
                                end,
                                RMenu:Get("banks", "list_pret_3")
                            )
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "list_pret_2")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for i = 1, #PretsTermine, 1 do
                            RageUI.Button(
                                PretsTermine[i].label ..
                                    " - " ..
                                        PretsTermine[i].amount ..
                                            "/" ..
                                                PretsTermine[i].base_amount ..
                                                    "$ | " ..
                                                        Identity[GetBankInfoFromID(PretsTermine[i].account).uuid].first_name ..
                                                            " " ..
                                                                Identity[GetBankInfoFromID(PretsTermine[i].account).uuid].last_name,
                                "Nom du compte ~b~" .. GetBankInfoFromID(PretsTermine[i].account).label,
                                {RightLabel = PretsTermine[i].current .. "/" .. PretsTermine[i].total},
                                true,
                                function(_, _, Selected)
                                end
                            )
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "list_pret_3")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Payer un prélèvement",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    TriggerServerEvent("bank:oneprets", currentPrets)
                                    currentPrets.amount =
                                        math.floor(
                                        currentPrets.amount -
                                            (currentPrets.base_amount +
                                                ((currentPrets.base_amount / 100) * currentPrets.percent)) /
                                                currentPrets.total,
                                        0
                                    )
                                    currentPrets.current = currentPrets.current + 1
                                    local am = GetBankInfoFromID(currentPrets.account)
                                    am.amount =
                                        math.floor(
                                        am.amount -
                                            (currentPrets.base_amount +
                                                ((currentPrets.base_amount / 100) * currentPrets.percent)) /
                                                currentPrets.total,
                                        0
                                    )
                                    ShowNotification(
                                        "~y~Paiement effectué\n~s~Il reste ~b~" ..
                                            currentPrets.amount .. "$ ~s~à payé\nNouveau solde ~b~" .. am.amount .. "$"
                                    )
                                end
                            end
                        )
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "create_acc")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Nom du compte",
                            nil,
                            {RightLabel = creatingAcc.name},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local name = KeyboardInput("Entrez le nom du compte", nil, 20)
                                    name = tostring(name)
                                    if name ~= nil then
                                        creatingAcc.name = name
                                    end
                                end
                            end
                        )
                        local rightL =
                            creatingAcc.uuid ~= nil and
                            Identity[creatingAcc.uuid].first_name .. " " .. Identity[creatingAcc.uuid].last_name or
                            "N/A"
                        RageUI.Button(
                            "Titulaire",
                            nil,
                            {RightLabel = rightL},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "identity_list3")
                        )

                        RageUI.Button(
                            "Numéro de téléphone du propriétaire",
                            nil,
                            {RightLabel = creatingAcc.number ~= nil and creatingAcc.number or "N/A"},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local name = KeyboardInput("Entrez le numéro de téléphone", nil, 9)
                                    name = tonumber(name)
                                    if name ~= nil then
                                        creatingAcc.number = name
                                    end
                                end
                            end
                        )

                        RageUI.Button(
                            "Créer le compte",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    if creatingAcc.uuid ~= nil and creatingAcc.name ~= nil then
                                        TriggerServerCallback(
                                            "createAccount",
                                            function(result)
                                                ShowNotification("~b~Compte créer")
                                                ShowNotification("~s~Adresse : ~b~" .. result)
                                                ShowNotification("~s~Nom du compte : ~b~" .. creatingAcc.name)
                                                ShowNotification("~s~Titulaire : ~b~" .. rightL)
                                                RageUI.GoBack()
                                                creatingAcc = {}
                                            end,
                                            creatingAcc
                                        )
                                    else
                                        ShowNotification("~r~Vous n'avez pas correctement écris tout les champs.")
                                    end
                                end
                            end
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "create_card")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.List(
                            "Type de la carte",
                            typeCarte.Label,
                            typeCarte.Index,
                            nil,
                            {},
                            true,
                            function(_, Active, Selected, Index)
                                if typeCarte.Index ~= Index then
                                    typeCarte.Index = Index
                                end
                            end
                        )
                        local rightL = "Aucun"
                        if createCard.uuid ~= nil then
                            rightL = Identity[createCard.uuid].first_name .. " " .. Identity[createCard.uuid].last_name
                        end
                        --print(rightL)
                        RageUI.Button(
                            "Demandeur",
                            nil,
                            {RightLabel = rightL},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "identity_list2")
                        )
                        local rightL2 = "N/A"
                        if createCard.code ~= nil then
                            rightL2 = "****"
                        end
                        RageUI.Button(
                            "Code",
                            nil,
                            {RightLabel = rightL2},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local code = KeyboardInput("Code", nil, 4)
                                    code = tonumber(code)
                                    if code ~= nil then
                                        if code > 999 then
                                            createCard.code = code
                                        else
                                            ShowNotification("~r~Veuillez introduire un code à 4 chiffres")
                                        end
                                    end
                                end
                            end
                        )
                        RageUI.Button(
                            "Créer",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    if createCard.code ~= nil and createCard.uuid ~= nil then
                                        TriggerServerCallback(
                                            "newCard",
                                            function(number, cur)
                                                ShowNotification("La carte a bien été créée")
                                                if Cards[currentBank.id] == nil then
                                                    Cards[currentBank.id] = {}
                                                end
                                                table.insert(
                                                    Cards[currentBank.id],
                                                    {
                                                        type = typeCarte.Label[typeCarte.Index]:lower(),
                                                        uuid = createCard.uuid,
                                                        account = currentBank.id,
                                                        number = number,
                                                        current_ratio = cur
                                                    }
                                                )
                                                local items = {
                                                    name = "bank_card",
                                                    label = "Carte bancaire #" .. mysplit(number, "-")[4],
                                                    data = {
                                                        name = Identity[currentBank.uuid].first_name ..
                                                            " " .. Identity[currentBank.uuid].last_name,
                                                        type = typeCarte.Label[typeCarte.Index]:lower(),
                                                        uuid = createCard.uuid,
                                                        account = currentBank.id,
                                                        number = number,
                                                        current_ratio = cur,
                                                        code = createCard.code
                                                    }
                                                }
                                                Ora.Inventory:AddItem(items)
                                                --AddItemtoInv(items)
                                                createCard = {}
                                            end,
                                            createCard,
                                            currentBank.id,
                                            typeCarte.Label[typeCarte.Index]:lower()
                                        )
                                    else
                                        ShowNotification("~r~Vous n'avez pas bien rempli tous les champs")
                                    end
                                end
                            end
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "identity_list")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local label2 = filterSearch.search == nil and "Rechercher" or "Recherche actuel : ~b~" .. filterSearch.search
                        RageUI.Button(label2, nil, {RightLabel = "🔍"}, true, function(_, _, S)
                            if S then
                                local filter = KeyboardInput("Rechercher", nil, 250)
                                filter = tostring(filter)
                                if filter ~= "nil" then
                                    if tostring(filter) ~= nil and filter ~= "" then
                                        filterSearch.search = filter
                                    elseif tostring(filter) == nil and filter == "" then
                                        filterSearch.search = nil
                                    else
                                        filterSearch.search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                else
                                    filterSearch.search = nil
                                    ShowAboveRadarMessage("Recherche ~r~invalide")
                                end
                            end
                        end)
                        for k, v in spairs(
                            Identity,
                            function(t, a, b)
                                return t[a].first_name < t[b].first_name
                            end
                        ) do
                            if filterSearch.search == nil or string.find(string.lower(v.first_name .. " " .. v.last_name), filterSearch.search) or string.find(k, filterSearch.search) then
                                RageUI.Button(
                                    string.lower(v.first_name .. " " .. v.last_name),
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            TriggerServerEvent("bank:Add", currentBank.id, v.uuid)
                                            RageUI.GoBack()
                                            RageUI.GoBack()
                                            RageUI.GoBack()
                                            RageUI.GoBack()
                                            currentBank.coowner = v.uuid
                                            ShowNotification(
                                                v.first_name ..
                                                    " " .. v.last_name .. " est ajouté en tant que co-propriétaire"
                                            )
                                        end
                                    end
                                )
                            end
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "identity_list3")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local label2 = filterSearch.search == nil and "Rechercher" or "Recherche actuel : ~b~" .. filterSearch.search
                        RageUI.Button(label2, nil, {RightLabel = "🔍"}, true, function(_, _, S)
                            if S then
                                local filter = KeyboardInput("Rechercher", nil, 250)
                                filter = tostring(filter)
                                if filter ~= "nil" then
                                    if tostring(filter) ~= nil and filter ~= "" then
                                        filterSearch.search = filter
                                    elseif tostring(filter) == nil and filter == "" then
                                        filterSearch.search = nil
                                    else
                                        filterSearch.search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                else
                                    filterSearch.search = nil
                                    ShowAboveRadarMessage("Recherche ~r~invalide")
                                end
                            end
                        end)
                        for k, v in spairs(
                            Identity,
                            function(t, a, b)
                                return t[a].first_name < t[b].first_name
                            end
                        ) do
                            if filterSearch.search == nil or string.find(string.lower(v.first_name .. " " .. v.last_name), filterSearch.search) or string.find(k, filterSearch.search) then
                                RageUI.Button(
                                    string.lower(v.first_name .. " " .. v.last_name),
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            RageUI.GoBack()
                                            RageUI.GoBack()
                                            RageUI.GoBack()
                                            RageUI.GoBack()
                                            creatingAcc.uuid = v.uuid
                                        end
                                    end
                                )
                            end
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "identity_list2")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local label2 = filterSearch.search == nil and "Rechercher" or "Recherche actuel : ~b~" .. filterSearch.search
                        RageUI.Button(label2, nil, {RightLabel = "🔍"}, true, function(_, _, S)
                            if S then
                                local filter = KeyboardInput("Rechercher", nil, 250)
                                filter = tostring(filter)
                                if filter ~= "nil" then
                                    if tostring(filter) ~= nil and filter ~= "" then
                                        filterSearch.search = filter
                                    elseif tostring(filter) == nil and filter == "" then
                                        filterSearch.search = nil
                                    else
                                        filterSearch.search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                else
                                    filterSearch.search = nil
                                    ShowAboveRadarMessage("Recherche ~r~invalide")
                                end
                            end
                        end)
                        for k, v in spairs(
                            Identity,
                            function(t, a, b)
                                return t[a].first_name < t[b].first_name
                            end
                        ) do
                            if filterSearch.search == nil or string.find(string.lower(v.first_name .. " " .. v.last_name), filterSearch.search) or string.find(k, filterSearch.search) then
                                RageUI.Button(
                                    string.lower(v.first_name .. " " .. v.last_name),
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            RageUI.GoBack()
                                            RageUI.GoBack()
                                            RageUI.GoBack()
                                            RageUI.GoBack()
                                            createCard.uuid = v.uuid
                                        end
                                    end
                                )
                            end
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "historiques")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local v = currentBank
                        for i = 1, #History, 1 do
                            if History[i].src == v.iban or History[i].dest == v.iban then
                                RageUI.CenterButton(
                                    "_________________",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )

                                RageUI.Button(
                                    History[i].src .. " (~r~-" .. History[i].montant .. "$~s~)",
                                    nil,
                                    {RightLabel = History[i].dest .. " (~g~+" .. History[i].montant .. "$~s~)"},
                                    true,
                                    function()
                                    end
                                )

                                RageUI.CenterButton(
                                    History[i].details,
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                            end
                        end
                        RageUI.CenterButton(
                            "_________________",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("banks", "create_prêt")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Libellé du prêt",
                            nil,
                            {RightLabel = typePret.label == nil and "N/A" or typePret.label},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    typePret.label = tostring(KeyboardInput("Libellé du prêt ", nil, 25))
                                end
                            end
                        )

                        RageUI.Button(
                            "Nombre de prélèvement",
                            nil,
                            {RightLabel = typePret.total == nil and "N/A" or typePret.total},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    typePret.total = tonumber(KeyboardInput("Nombre de prélèvement", nil, 25))
                                end
                            end
                        )

                        RageUI.Button(
                            "Montant total du prêt",
                            nil,
                            {RightLabel = typePret.montant == nil and "0$" or typePret.montant .. "$"},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    typePret.montant = tonumber(KeyboardInput("Montant total du prêt ", nil, 25))
                                end
                            end
                        )

                        RageUI.List(
                            "Intérêt",
                            typePret.amount,
                            typePret.Index,
                            nil,
                            {},
                            true,
                            function(_, Active, Selected, Index)
                                if typePret.Index ~= Index then
                                    typePret.Index = Index
                                end
                            end
                        )

                        RageUI.Button(
                            "Valider",
                            typePret.montant ~= nil and
                                math.floor(((typePret.montant / 100) * typePret.Index) + typePret.montant, 2) ..
                                    "$ en " .. typePret.total .. " semaines" or
                                "N/A",
                            {
                                RightLabel = typePret.montant ~= nil and
                                    math.floor(
                                        (((typePret.montant / 100) * typePret.Index) + typePret.montant) /
                                            typePret.total,
                                        2
                                    ) .. "$ par semaines " or
                                    "N/A"
                            },
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    typePret.account = currentBank.id
                                    typePret.cAm =
                                        math.floor(((typePret.montant / 100) * typePret.Index) + typePret.montant, 2)
                                    TriggerServerCallback(
                                        "newPrets",
                                        function(bool)
                                            if bool then
                                                TriggerServerEvent(
                                                    "bankingRemoveFromAccount2",
                                                    "banker",
                                                    typePret.montant
                                                )
                                                TriggerServerEvent(
                                                    "entreprise:Add",
                                                    GetBankInfoFromID(currentBank.id).iban,
                                                    typePret.montant
                                                )
                                                TriggerServerEvent(
                                                    "newTransaction",
                                                    "banker",
                                                    GetBankInfoFromID(currentBank.id).iban,
                                                    typePret.montant,
                                                    "Retrait manuel du banquier"
                                                )
                                                --    TriggerServerEvent("bankingSendMoney",GetBankInfoFromID(currentBank.id).iban,typePret.montant,"banker")
                                                ShowNotification("Prêt créer ")
                                                local am = GetBankInfoFromID(currentBank.id)
                                                am.amount = math.floor(am.amount + typePret.montant, 0)
                                                ShowNotification("Nouveau solde ~b~" .. am.amount .. "$")
                                            end
                                        end,
                                        typePret
                                    )
                                end
                            end
                        )
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("banks", "gestion_comptes")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local v = currentBank

                        RageUI.CenterButton(
                            "~y~↓↓↓ ~s~Actions ~y~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                        if v.bloqued == "false" or v.bloqued == 0 or v.bloqued == false then
                            v.bloqued = false
                        elseif v.bloqued == "true" or v.bloqued == 1 or v.bloqued == true then
                            v.bloqued = true
                        end
                        RageUI.Checkbox(
                            not v.bloqued and "Bloquer le compte" or "Débloquer le compte",
                            nil,
                            v.bloqued,
                            {},
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    v.bloqued = Checked
                                    TriggerServerEvent("bankBlockAcc", Checked, v.id)
                                end
                            end
                        )
                        RageUI.Button(
                            "Cloturer le compte",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local sure = KeyboardInput("Êtes-vous sûr ? (Tapez 'OUI')", nil, 3)
                                    local sure = tostring(sure)
                                    if sure == "OUI" then
                                        TriggerServerEvent("bank:DeleteAccounts", v.id)
                                        TriggerServerCallback(
                                            "getAllBanks2",
                                            function(result, _result, dresult, mresult)
                                                Banks = result
                                                Identity = Format(_result)
                                                Cards = Format2(dresult)
                                                History = mresult
                                            end
                                        )
                                        ShowNotification("Compte ~r~cloturer")
                                        RageUI.GoBack()
                                    end
                                end
                            end
                        )
                        RageUI.Button(
                            "Historique",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "historiques")
                        )
                        local label1 =
                            v.coowner ~= nil and "Modifier le co-propriétaire" or "Ajouter un co-propriétaire"
                        RageUI.Button(
                            label1,
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "identity_list")
                        )

                        RageUI.Button(
                            "Créer une carte",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "create_card")
                        )

                        RageUI.Button(
                            "Prélever",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local amount = KeyboardInput("Montant", nil, 10)
                                    amount = tonumber(amount)
                                    if amount ~= nil then
                                        TriggerServerEvent("bankingRemoveFromAccount2", v.iban, amount)
                                        TriggerServerEvent("entreprise:Add", "banker", amount)
                                        TriggerServerEvent(
                                            "newTransaction",
                                            v.iban,
                                            "banker",
                                            amount,
                                            "Retrait manuel du banquier"
                                        )

                                        table.insert(
                                            History,
                                            {
                                                src = v.iban,
                                                dest = "banker",
                                                montant = amount,
                                                details = "Retrait manuel du banquier"
                                            }
                                        )
                                        v.amount = v.amount - amount
                                        ShowNotification("Vous venez de prélever " .. amount .. "$")
                                    end
                                end
                            end
                        )

                        RageUI.Button(
                            "Envoyer argent",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local amount = KeyboardInput("Montant", nil, 10)
                                    amount = tonumber(amount)
                                    if amount ~= nil then
                                        TriggerServerEvent("bankingRemoveFromAccount2", "banker", amount)
                                        TriggerServerEvent("entreprise:Add", v.iban, amount)
                                        TriggerServerEvent(
                                            "newTransaction",
                                            "banker",
                                            v.iban,
                                            amount,
                                            "Dépot du banquier"
                                        )

                                        table.insert(
                                            History,
                                            {
                                                src = "banker",
                                                dest = v.iban,
                                                montant = amount,
                                                details = "Dépot du banquier"
                                            }
                                        )
                                        v.amount = v.amount + amount
                                        ShowNotification("Vous venez de déposer " .. amount .. "$")
                                    end
                                end
                            end
                        )

                        RageUI.Button("Déposer de l'argent liquide", nil, {}, true, function(_, _, Selected)
                            if Selected then
                                Refresh()
                            end
                        end, RMenu:Get("banks", "deposit_money_by_bank"))

                        RageUI.Button(
                            "Créer un prêt",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "create_prêt")
                        )

                        RageUI.CenterButton(
                            "~y~↓↓↓ ~s~Informations ~y~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                        RageUI.Button(
                            "Nom du compte",
                            nil,
                            {RightLabel = v.label},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Numéro de téléphone",
                            "Changez le numéro de téléphone",
                            {RightLabel = v.phone_number ~= nil and v.phone_number or "N/A"},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local num = KeyboardInput("Entrez le nouveau numéro de téléphone", nil, 9)
                                    num = tonumber(num)
                                    if num ~= nil then
                                        TriggerServerEvent("bankUpdateNum", num, v.id)
                                    end
                                end
                            end
                        )
                        RageUI.Button(
                            "Propriétaire",
                            nil,
                            {RightLabel = Identity[v.uuid].first_name .. " " .. Identity[v.uuid].last_name},
                            true,
                            function(_, _, Selected)
                            end
                        )
                        if v.coowner ~= nil then
                            RageUI.Button(
                                "Co-propriétaire",
                                nil,
                                {RightLabel = Identity[v.coowner].first_name .. " " .. Identity[v.coowner].last_name},
                                true,
                                function(_, _, Selected)
                                end
                            )
                        end

                        RageUI.Button(
                            "Montant",
                            nil,
                            {RightLabel = v.amount .. "$"},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "IBAN",
                            nil,
                            {RightLabel = v.iban},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.CenterButton(
                            "~y~↓↓↓ ~s~Cartes liées ~y~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )

                        local cards = Cards[v.id]
                        local mid = v.id
                        if cards == nil then
                            RageUI.Button(
                                "Vide",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                end
                            )
                        else
                            for k, v in pairs(cards) do
                                RageUI.CenterButton(
                                    "Carte ~y~" .. v.number .. "",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                                if type(v.current_ratio) == "string" then
                                    v.current_ratio = json.decode(v.current_ratio)
                                end
                                RageUI.Button(
                                    "Type de carte",
                                    nil,
                                    {RightLabel = firstToUpper(v.type)},
                                    true,
                                    function(_, _, Selected)
                                    end
                                )
                                RageUI.Button(
                                    "Retraits actuel",
                                    nil,
                                    {
                                        RightLabel = firstToUpper(
                                            v.current_ratio.remove .. "/" .. v.current_ratio.maxRemove .. "$"
                                        )
                                    },
                                    true,
                                    function(_, _, Selected)
                                    end
                                )
                                RageUI.Button(
                                    "Dépot actuel",
                                    nil,
                                    {
                                        RightLabel = firstToUpper(
                                            v.current_ratio.deposit .. "/" .. v.current_ratio.maxDeposit .. "$"
                                        )
                                    },
                                    true,
                                    function(_, _, Selected)
                                    end
                                )

                                local accountFirstname = "Citoyen"
                                local accountLastname = "Expulsé"

                                if (v ~= nil and v.uuid ~= nil and Identity[v.uuid] ~= nil) then
                                    accountFirstname = Identity[v.uuid].first_name
                                    accountLastname = Identity[v.uuid].last_name
                                end

                                RageUI.Button(
                                    "Propriétaire",
                                    nil,
                                    {RightLabel = accountFirstname .. " " .. accountLastname},
                                    true,
                                    function(_, _, Selected)
                                    end
                                )

                                RageUI.Checkbox(
                                    not v.bloqued and "Bloquer la carte" or "Débloquer la carte",
                                    nil,
                                    v.bloqued,
                                    {},
                                    function(Hovered, Ative, Selected, Checked)
                                        if Selected then
                                            v.bloqued = Checked
                                            TriggerServerEvent("cardBlock", Checked, v.id)
                                        end
                                    end
                                )

                                RageUI.Button(
                                    "Supprimer cette carte",
                                    nil,
                                    {RightLabel = "❌"},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            TriggerServerEvent("core:DeleteThisCard", mid)
                                            Cards[mid] = nil
                                            RageUI.Refresh()
                                        end
                                    end
                                )
                                RageUI.CenterButton(
                                    "------------------------",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("banks", "deposit_money_by_bank")) then
                RageUI.DrawContent(
                        {header = false, glare = false},
                        function()
                            for k, v in pairs(m) do
                                RageUI.List(
                                    Items[k].label .. " (" .. v.total .. "x)",
                                    v.label,
                                    v.index,
                                    nil,
                                    {},
                                    v.visible,
                                    function(_, Active, Selected, Index)
                                        v.index = Index
                                        if Selected then
                                            local ask = KeyboardInput("Combien ? ~r~(MAX " .. v.total .. ")", nil)

                                            ask = tonumber(ask)
                                            if ask ~= nil then
                                                if ask <= v.total then
                                                    v.index = ask + 1
                                                end
                                            end
                                        end
                                    end
                                )
                            end

                            local v = currentBank

                            RageUI.Button(
                                "Déposer ",
                                nil,
                                {RightLabel = "~g~" .. GetCurrentMoneySelected() .. "$"},
                                true,
                                function(_, H, S)
                                    if S then
                                        if ((GetGameTimer() - GUI.Time) > 2000 ) then
                                            GUI.Time = GetGameTimer()
                                            local amount = GetCurrentMoneySelected()
                                            ShowNotification(
                                                "~g~Transaction bancaire en cours~w~\nContact du serveur bancaire"
                                            )

                                            RageUI.CloseAll()
                                            RageUI.Popup({message = "~g~💰 Dépot bancaire\n~s~" .. amount .. "$"})

                                            TriggerServerEvent(
                                                "Ora_bank:addMoneyToBankAccount",
                                                v.iban,
                                                amount
                                            )

                                            TriggerServerEvent(
                                                "newTransaction",
                                                "Espèces",
                                                v.iban,
                                                amount,
                                                "Dépôt d'argent par le banquier",
                                                ""
                                            )

                                            TriggerServerEvent(
                                                "gcPhone:_internalAddMessage",
                                                "Banque",
                                                v.phone_number,
                                                "Dépot de " .. amount .. "$ sur le compte" .. v.iban .. " par le banquier.",
                                                false
                                            )

                                            local infoType = "info"
                                            if (amount < 5000) then
                                                infoType = "info"
                                            elseif (amount < 15000) then
                                                infoType = "success"
                                            elseif (amount < 30000) then
                                                infoType = "warning"
                                            else
                                                infoType = "error"
                                            end

                                            TriggerServerEvent(
                                                'Ora:sendToDiscord',
                                                25,
                                                "Dépôt par le banquier de $" .. amount .. " sur le compte " .. v.iban,
                                                infoType
                                            )
                                            TriggerServerEvent("gcPhone:allUpdate")

                                            local t = {}

                                            for k, v in pairs(m) do
                                                if #v.label > 1 then
                                                    t[k] = v
                                                end
                                            end
                                            lastDeposit = GetGameTimer()
                                            Ora.Payment:PayMoney(t)

                                            for k, v in pairs(m) do
                                                v.index = 1
                                            end
                                            GUI.Time = GetGameTimer()
                                        else
                                            ShowNotification("~r~Tentative de spam~s~")
                                        end
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
            end

            if RageUI.Visible(RMenu:Get("banks", "list_main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local label2 =
                            filterSearch.search == nil and "Rechercher" or
                            "Recherche actuel : ~b~" .. filterSearch.search
                        RageUI.Button(
                            label2,
                            nil,
                            {RightLabel = "🔍"},
                            true,
                            function(_, _, S)
                                if S then
                                    local filter = KeyboardInput("Rechercher", nil, 250)
                                    filter = tostring(filter)
                                    if filter ~= "nil" then
                                        if tostring(filter) ~= nil and filter ~= "" then
                                            filterSearch.search = filter
                                        elseif tostring(filter) == nil and filter == "" then
                                            filterSearch.search = nil
                                        else
                                            filterSearch.search = nil
                                            ShowAboveRadarMessage("Recherche ~r~invalide")
                                        end
                                    else
                                        filterSearch.search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                end
                            end
                        )

                        RageUI.Checkbox(
                            "Titulaire du compte",
                            nil,
                            filterSearch.display.name,
                            {},
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    filterSearch.display.name = Checked
                                end
                            end
                        )
                        RageUI.Checkbox(
                            "Nom du compte",
                            nil,
                            filterSearch.display.label,
                            {},
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    filterSearch.display.label = Checked
                                end
                            end
                        )
                        RageUI.Checkbox(
                            "Montant du compte",
                            nil,
                            filterSearch.display.amount,
                            {},
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    filterSearch.display.amount = Checked
                                end
                            end
                        )
                        RageUI.List(
                            "Trier par",
                            filterSearch.Label,
                            filterSearch.Index,
                            nil,
                            {},
                            true,
                            function(_, Active, Selected, Index)
                                if filterSearch.Index ~= Index then
                                    filterSearch.Index = Index

                                    if Index == 1 then
                                        filterSearch.filter = function(t, a, b)
                                            return t[a].amount < t[b].amount
                                        end

                                        filterSearch.filterASC = true
                                    elseif Index == 2 then
                                        filterSearch.filter = function(t, a, b)
                                            return t[a].label < t[b].label
                                        end
                                        filterSearch.filterASC = true
                                    elseif Index == 3 then
                                        filterSearch.filter = function(t, a, b)
                                            return t[a].id < t[b].id
                                        end
                                        filterSearch.filterASC = true
                                    elseif Index == 4 then
                                        filterSearch.filter = nil
                                        filterSearch.filterASC = true
                                    end
                                end
                            end
                        )
                        if filterSearch.filter then
                            RageUI.Checkbox(
                                "Ordre croissant",
                                nil,
                                filterSearch.filterASC,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Ative then
                                        if Selected then
                                            filterSearch.filterASC = Checked

                                            if filterSearch.Index == 1 then
                                                if Checked then
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[a].amount < t[b].amount
                                                    end
                                                else
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[b].amount < t[a].amount
                                                    end
                                                end
                                            end
                                            if filterSearch.Index == 2 then
                                                if Checked then
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[a].label < t[b].label
                                                    end
                                                else
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[b].label < t[a].label
                                                    end
                                                end
                                            end
                                            if filterSearch.Index == 3 then
                                                if Checked then
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[a].id < t[b].id
                                                    end
                                                else
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[b].id < t[a].id
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            )
                        end

                        --
                        RageUI.CenterButton(
                            "~y~↓↓↓ ~s~Comptes ~y~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                        for k, v in spairs(Banks, filterSearch.filter) do
                            local label = ""
                            --v.label .. " - " .. Identity[v.uuid].first_name .. " " .. Identity[v.uuid].last_name
                            local RLabel = v.iban
                            if Identity[v.uuid] ~= nil then
                                if filterSearch.display.amount then
                                    local amount = false
                                    if v.amount < 0 then
                                        amount = "~r~" .. v.amount .. "$"
                                    else
                                        amount = "~g~" .. v.amount .. "$"
                                    end
                                    RLabel = RLabel .. " " .. amount 
                                end

                                if filterSearch.display.label then
                                    label = label .. "" .. v.label .. " - "
                                end

                                if filterSearch.display.name then
                                    label = label .. (Identity[v.uuid].first_name .. " " .. Identity[v.uuid].last_name)
                                end

                                if filterSearch.search == nil or string.match(label:lower(), filterSearch.search:lower()) then
                                    RageUI.Button(label, nil, {RightLabel = RLabel}, true, function(_, _, Selected)
                                        if Selected then
                                            currentBank = v
                                        end
                                    end,
                                    RMenu:Get("banks", "gestion_comptes"))
                                end
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

local ATM = {
    Accounts = {
        own = {},
        coOwn = {}
    }
}
function UseBankCard()
    local bool, coords, heading = IsNearATM()
    if bool then
        TriggerEvent('Ora:hideInventory')
        fpxm = Ora.World.Object:Create(GetHashKey("prop_cs_credit_card"), LocalPlayer().Pos, true, 0, 0)
        AttachEntityToEntity(
            fpxm,
            LocalPlayer().Ped,
            GetPedBoneIndex(LocalPlayer().Ped, 57005),
            vector3(0.15, 0.02, 0.02),
            vector3(-200.0, 0.0, -0.0),
            0,
            0,
            0,
            0,
            0,
            1
        )
        doAnim({"amb@prop_human_atm@male@enter", "enter"})
        Citizen.CreateThread(
            function()
                Wait(1000)
                DeleteEntity(fpxm)
            end
        )

        if GetGameTimer() - lastDeposit < MIN_TIME_BETWEEN_DEPOSITS then
            ShowNotification("~r~Vous avez déjà effectué un retrait ou un dépôt récemment. Veuillez patienter.")
            return
        end

        local currCARD = Ora.Inventory.SelectedItem.data
        ATM.Open(currCARD)
    else
        TriggerEvent('Ora:InvNotification', "Vous n'êtes pas près d'un ATM", 'error')
    end
end

local Atm = {
    {prop = "prop_atm_02"},
    {prop = "prop_atm_03"},
    {prop = "prop_fleeca_atm"},
    {prop = "prop_atm_01"}
}

function IsNearATM()
   return Ora.World.Object:GetNearestAtm(1.8)
end

function getCompanyLabel(account)
    if account ~= nil then
        for k, v in pairs(Jobs) do
            if v.iban == account then
                return v.label2
            end
        end
    end
    return nil
end

local stillNear = true
function ATM.Open(param)
    if IsNearATM() then
        local code = KeyboardInput("Veuillez entrer le code", nil, 4)
        code = tonumber(code)
        if code ~= nil then
            if code == param.code then
                TriggerServerCallback(
                    "getBankingAccountsPly2",
                    function(result)
                        TriggerServerCallback(
                            "getBankingCard",
                            function(_result)
                                if result[1] == nil or _result[1] == nil then
                                    ShowNotification("~r~Compte non reconnu")
                                end
                                local accountIBAN = getCompanyLabel(result[1].iban) or result[1].iban
                                TriggerServerCallback(
                                    "getHisto",
                                    function(tresult)
                                        stillNear = true
                                        ATM.Accounts = result[1]
                                        ATM.Cards = param
                                        ATM.History = tresult
                                        if _result[1].bloqued == 1 then
                                            return ShowNotification("~r~La carte est bloquée")
                                        end
                                        if
                                            result[1].bloqued == "true" or result[1].bloqued == 1 or
                                                result[1].bloqued == true
                                         then
                                            return ShowNotification("~r~Le compte est bloqué")
                                        end

                                        ATM.Accounts.todayratio = Ora.Inventory.SelectedItem.data.current_ratio

                                        for i = 1, 10, 1 do
                                            Wait(1)
                                            RageUI.GoBack()
                                        end

                                        RageUI.Visible(
                                            RMenu:Get("banking", "main_atm"),
                                            not RageUI.Visible(RMenu:Get("banking", "main_atm"))
                                        )
                                    end,
                                    accountIBAN,
                                    result[1].iban
                                )
                            end,
                            param.number
                        )
                    end,
                    param.account
                )
            else
                if param.essai == nil then
                    param.essai = 3
                else
                    param.essai = param.essai - 1
                end
                if param.essai == 0 then
                    ShowNotification("~r~Code incorrect \n~o~La carte à été avalée")
                    TriggerServerEvent("mail:AddMail", "banker", "Carte N°" .. param.number .. " avalés", "ATM")
                    Ora.Inventory:RemoveItem(Ora.Inventory.SelectedItem)

                    RageUI.GoBack()
                    RageUI.Refresh()
                else
                    ShowNotification("~r~Code incorrect \n~o~" .. param.essai .. " essai(s) restant(s)")
                end
            end
        end
    end
end

function GetCurrentMoneySelected()
    local mo = 0
    for k, v in pairs(m) do
        if v.visible then
            p = string.gsub(tostring(k), "dollar", "")
            p = tonumber(p)
            mo = mo + (p * (v.index - 1))
        end
    end

    return mo
end

function Refresh()
    for k, v in pairs(m) do
        if Ora.Inventory.Data[k] ~= nil then
            v.visible = true
            v.total = #Ora.Inventory.Data[k]
            v.label = {0}
            for i = 0, #Ora.Inventory.Data[k], 1 do
                v.label[i + 1] = i
            end
        else
            v.total = 0
            v.visible = false
        end
    end
end
Citizen.CreateThread(
    function()
        local transactionTime = nil
        Wait(1500)

        RMenu:Get("banking", "main_atm").Closed = function()
        end

        while true do
            Wait(1)

            if stillNear then
                if RageUI.Visible(RMenu:Get("banking", "main_atm")) then
                    RageUI.DrawContent(
                        {header = false, glare = false},
                        function()
                            RageUI.CenterButton(
                                "~b~↓↓↓ Votre compte ↓↓↓",
                                nil,
                                {},
                                true,
                                function()
                                end
                            )
                            RageUI.Button(
                                ATM.Accounts.label,
                                "RIB : " .. ATM.Accounts.iban,
                                {RightLabel = ATM.Accounts.amount .. "$"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        ATM.Selected = ATM.Accounts
                                        RMenu:Get("banking", "manage_account").Subtitle =
                                            ATM.Accounts.label .. " " .. ATM.Accounts.amount .. "$"
                                    end
                                end,
                                RMenu:Get("banking", "manage_account")
                            )
                            RageUI.Separator("~b~↓↓↓ Votre historique ↓↓↓")
                            for i = 1, #ATM.History, 1 do
                                local History = ATM.History
                                if transactionTime == nil or transactionTime ~= string.sub(History[i].details, 1, 8) then
                                    RageUI.Separator("~b~"..string.sub(History[i].details, 1, 8))
                                    transactionTime = string.sub(History[i].details, 1, 8)
                                end
                                RageUI.Button(
                                    History[i].src .. " (~r~-" .. History[i].montant .. "$~s~)",
                                    "~b~Titre : ~s~"..History[i].title.."~n~~b~Détail : ~s~"..History[i].details,
                                    {RightLabel = History[i].dest .. " (~g~+" .. History[i].montant .. "$~s~)"},
                                    true,
                                    function()
                                    end
                                )
                            end
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("banking", "deposit_money")) then
                    RageUI.DrawContent(
                        {header = false, glare = false},
                        function()
                            for k, v in pairs(m) do
                                RageUI.List(
                                    Items[k].label .. " (" .. v.total .. "x)",
                                    v.label,
                                    v.index,
                                    nil,
                                    {},
                                    v.visible,
                                    function(_, Active, Selected, Index)
                                        v.index = Index
                                        if Selected then
                                            local ask = KeyboardInput("Combien ? ~r~(MAX " .. v.total .. ")", nil)

                                            ask = tonumber(ask)
                                            if ask ~= nil then
                                                if ask <= v.total then
                                                    v.index = ask + 1
                                                end
                                            end
                                        end
                                    end
                                )
                            end

                            RageUI.Button(
                                "Déposer ",
                                nil,
                                {RightLabel = "~g~" .. GetCurrentMoneySelected() .. "$"},
                                true,
                                function(_, H, S)
                                    if S then
                                        if ((GetGameTimer() - GUI.Time) > 2000 ) then
                                            GUI.Time = GetGameTimer()
                                            local amount = GetCurrentMoneySelected()
                                            ShowNotification(
                                                "~g~Transaction bancaire en cours~w~\nContact du serveur bancaire"
                                            )
    
                                            TriggerServerCallback("Ora_banking:getRatiosForCard", function(cardExist,maxDeposit,maxRemove,maxPayin,currentDeposit,currentRemove,currentPayin)
                                                if (cardExist == false) then
                                                    RageUI.Popup(
                                                        {
                                                            message = "~g~💰 Dépot bancaire\n~s~Cette carte ne semble pas exister"
                                                        }
                                                    )
                                                else
                                                    if (amount <= (maxDeposit - currentDeposit)) then
                                                        processDeposit = true
                                                    end
                                                    if (processDeposit == true) then

                                                        RageUI.CloseAll()
                                                        RageUI.Popup(
                                                            {
                                                                message = "~g~💰 Dépot bancaire\n~s~" .. amount .. "$"
                                                            }
                                                        )

                                                        ATM.Selected.amount = ATM.Selected.amount + amount
                                                        RMenu:Get("banking", "manage_account").Subtitle =
                                                            ATM.Selected.label .. " " .. ATM.Selected.amount .. "$"

                                                        TriggerServerEvent(
                                                            "Ora_bank:addMoneyToBankAccount",
                                                            ATM.Selected.iban,
                                                            amount
                                                        )

                                                        TriggerServerEvent(
                                                            "newTransaction",
                                                            "Espèces",
                                                            ATM.Selected.iban,
                                                            amount,
                                                            "Dépôt d'argent à partir CB "..ATM.Cards.number,
                                                            ""
                                                        )

                                                        TriggerServerEvent(
                                                            "gcPhone:_internalAddMessage",
                                                            "Banque",
                                                            ATM.Selected.phone_number,
                                                            "Dépot de " ..
                                                                amount .. "$ à partir du compte " .. ATM.Selected.iban,
                                                            false
                                                        )

                                                        local infoType = "info"
                                                        if (amount < 5000) then
                                                            infoType = "info"
                                                        elseif (amount < 15000) then
                                                            infoType = "success"
                                                        elseif (amount < 30000) then
                                                            infoType = "warning"
                                                        else
                                                            infoType = "error"
                                                        end

                                                        TriggerServerEvent(
                                                            'Ora:sendToDiscord',
                                                            25,
                                                            "Dépôt ATM de $"
                                                                ..amount
                                                                    .. " sur le compte "
                                                                        ..ATM.Selected.iban,
                                                            infoType
                                                        )
                                                        TriggerServerEvent("gcPhone:allUpdate")

                                                        local t = {}

                                                        for k, v in pairs(m) do
                                                            if #v.label > 1 then
                                                                t[k] = v
                                                            end
                                                        end
                                                        lastDeposit = GetGameTimer()
                                                        Ora.Payment:PayMoney(t)
                                                        TriggerServerEvent("Ora_bank:addDepositQuotaToCard", ATM.Cards.number, amount)
                                                        for k, v in pairs(m) do
                                                            v.index = 1
                                                        end
                                                        GUI.Time = GetGameTimer()
                                                    else
                                                        RageUI.Popup(
                                                            {
                                                                message = "~r~💰 Dépot bancaire\n~s~Vous avez atteint le plafond de dépot pour cette carte"
                                                            }
                                                        )
                                                    end
                                                e
                                            end,ATM.Cards.number)
                                        else
                                            ShowNotification("~r~Tentative de spam~s~")
                                        end
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("banking", "manage_account")) then
                    RageUI.DrawContent(
                        {header = false, glare = false},
                        function()
                            RageUI.Button(
                                "Envoyer de l'argent",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local finish = false
                                        local rib1 = KeyboardInput("RIB du bénéficiaire ?", nil, 255)
                                        local rib2 = KeyboardInput("Confirmez svp", nil, 255)
                                        if rib1 == rib2 then
                                            local amount = KeyboardInput("Montant ? ", nil, 100)
                                            local amount = tonumber(amount)
                                            if amount ~= nil then
                                                if amount <= ATM.Selected.amount then
                                                    TriggerServerCallback(
                                                        "banksExists",
                                                        function(bool)
                                                            if bool then
                                                                TriggerServerEvent(
                                                                    "bankingSendMoney",
                                                                    rib1,
                                                                    amount,
                                                                    ATM.Selected.iban
                                                                )
                                                                RageUI.Popup(
                                                                    {
                                                                        message = "Virement effectué vers " ..
                                                                            rib1 .. " " .. amount .. "$"
                                                                    }
                                                                )
                                                                TriggerServerEvent(
                                                                    "newTransaction",
                                                                    ATM.Selected.iban,
                                                                    rib1,
                                                                    amount,
                                                                    "Virement",
                                                                    "CB N° "..ATM.Cards.number
                                                                )
                                                                TriggerServerEvent(
                                                                    "gcPhone:_internalAddMessage",
                                                                    "Banque",
                                                                    ATM.Selected.phone_number,
                                                                    "Nouveau virement de " ..
                                                                        amount ..
                                                                            "$ vers " ..
                                                                                rib1 ..
                                                                                    " à partir du compte " ..
                                                                                        ATM.Selected.iban,
                                                                    false
                                                                )
                                                                TriggerServerEvent("gcPhone:allUpdate")
                                                            else
                                                                RageUI.Popup({message = "Le compte n'existe pas"})
                                                            end
                                                        end,
                                                        rib1
                                                    )
                                                end
                                            end
                                        else
                                            RageUI.Popup({message = "Les deux rib sont différents"})
                                        end
                                    end
                                end
                            )
                            RageUI.Button(
                                "Déposer de l'argent",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        Refresh()
                                    end
                                end,
                                RMenu:Get("banking", "deposit_money")
                            )
                            RageUI.Button(
                                "Retirer de l'argent",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local data = ATM.Selected.todayratio
                                        local amount = KeyboardInput("Combien ?", nil, 255)
                                        local amount = tonumber(amount)

                                        if amount ~= nil then
                                            if amount <= ATM.Selected.amount then
                                                ShowNotification(
                                                    "~g~Transaction bancaire en cours~w~\nContact du serveur bancaire"
                                                )

                                                TriggerServerCallback(
                                                    "Ora_banking:getRatiosForCard",
                                                    function(
                                                        cardExist,
                                                        maxDeposit,
                                                        maxRemove,
                                                        maxPayin,
                                                        currentDeposit,
                                                        currentRemove,
                                                        currentPayin)
                                                        if (cardExist == false) then
                                                            RageUI.Popup(
                                                                {
                                                                    message = "~g~Retrait bancaire\n~s~Cette carte ne semble pas exister"
                                                                }
                                                            )
                                                        else
                                                            if (amount <= (maxRemove - currentRemove)) then
                                                                processRemoving = true
                                                            end

                                                            if (processRemoving == true) then
                                                                RMenu:Get("banking", "manage_account").Subtitle =
                                                                    ATM.Selected.label ..
                                                                    " " .. ATM.Selected.amount .. "$"

                                                                RageUI.Popup(
                                                                    {
                                                                        message = "~g~Retrait bancaire\n~s~" ..
                                                                            amount .. "$"
                                                                    }
                                                                )

                                                                TriggerServerEvent(
                                                                    "Ora_bank:removeMoneyFromBankAccount",
                                                                    ATM.Selected.iban,
                                                                    amount
                                                                )

                                                                TriggerServerEvent(
                                                                    "newTransaction",
                                                                    ATM.Selected.iban,
                                                                    "Espèces",
                                                                    amount,
                                                                    "Retrait d'argent à partir de "..ATM.Cards.number,
                                                                    ""
                                                                )

                                                                TriggerServerEvent(
                                                                    "gcPhone:_internalAddMessage",
                                                                    "Banque",
                                                                    ATM.Selected.phone_number,
                                                                    "Retrait de " ..
                                                                        amount ..
                                                                            "$ à partir du compte " .. ATM.Selected.iban,
                                                                    false
                                                                )

                                                                local infoType = "info"
                                                                if (amount < 5000) then
                                                                    infoType = "info"
                                                                elseif (amount < 15000) then
                                                                    infoType = "success"
                                                                elseif (amount < 30000) then
                                                                    infoType = "warning"
                                                                else
                                                                    infoType = "error"
                                                                end

                                                                TriggerServerEvent(
                                                                    'Ora:sendToDiscord',
                                                                    25,
                                                                    "Retrait ATM de $"
                                                                        ..amount
                                                                            .. " sur le compte "
                                                                                ..ATM.Selected.iban,
                                                                    infoType
                                                                )
                                                                TriggerServerEvent("Ora_bank:addRemoveQuotaToCard", ATM.Cards.number, amount)
                                                                RageUI.CloseAll()
                                                            else
                                                                RageUI.Popup(
                                                                    {
                                                                        message = "~r~Retrait bancaire\n~s~Vous avez atteint votre limite de retrait pour cette carte"
                                                                    }
                                                                )
                                                            end
                                                        end
                                                    end,
                                                    ATM.Cards.number
                                                )
                                            else
                                                RageUI.Popup({message = "Montant du compte ~r~insuffisant"})
                                            end
                                        end
                                        ATM.Selected.todayratio = data
                                    end
                                end
                            )
                            RageUI.Button(
                                "Informations",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local data = ATM.Selected.todayratio
                                        RageUI.Popup(
                                            {
                                                message = "~b~Informations du compte:~s~\nRIB ~b~" ..
                                                    ATM.Selected.iban .. ""
                                            }
                                        )
                                    end
                                end
                            )

                            RageUI.Button(
                                "Demander un nouveau code",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        math.randomseed(GetGameTimer())
                                        local newCode = math.random(1111, 9999)
                                        TriggerServerEvent(
                                            "gcPhone:_internalAddMessage",
                                            "Banque",
                                            ATM.Selected.phone_number,
                                            "Votre nouveau code est " .. newCode,
                                            false
                                        )
                                        TriggerServerEvent("gcPhone:allUpdate")
                                        RageUI.Popup({message = "Réception du ~g~nouveau code~s~ sur votre télephone"})
                                        TriggerServerEvent("newCode", newCode, Ora.Inventory.SelectedItem.data.number)
                                        Ora.Inventory.SelectedItem.data.code = newCode
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end
            end
        end
    end
)

local ThreadId = nil

function InitBankerJob()
    InitImmoJob()
    
    local currentJob = Ora.Identity.Job:Get()
    local currentOrga = Ora.Identity.Orga:Get()

    function openMenu()
        currentJob = Ora.Identity.Job:Get()
        currentOrga = Ora.Identity.Orga:Get()
        RageUI.Visible(RMenu:Get("mazegroup", "main"), true)
    end

    if (Ora.Identity.Job:GetName() == "mazegroup") then
    	KeySettings:Add(
    		"keyboard",
    		"F6",
    		function()
                openMenu()
    		end,
    		"mazegroup"
    	)
    else
    	KeySettings:Add(
    		"keyboard",
    		"F7",
    		function()
                openMenu()
            end,
    		"mazegroup"
    	)
    end

    Citizen.CreateThread(function() 
        while true do
            if RageUI.Visible(RMenu:Get("mazegroup", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = true, instructionalButton = true},
                    function()
                        RageUI.Button("Facturation", nil, {}, true, function(_, _, Selected)
                            if Selected then
                                CreateFacture("mazegroup")
                            end
                            if Active then
                                HoverPlayer()
                            end
                        end)

                        RageUI.Separator("----- Menu de filiales -----", nil, {}, false, function() end)

                        if (currentJob.name == "mazegroup" and Jobs.mazegroup.grade[currentJob.gradenum].accessBank) or (currentOrga.name == "mazegroup" and Jobs.mazegroup.gradenum[currentOrga.rank].accessBank) then
                            RageUI.Button("Maze Bank", nil, {}, true, function(_, _, Selected)
                            end, RMenu:Get("bank", "main"))
                        end
                        if (currentJob.name == "mazegroup" and Jobs.mazegroup.grade[currentJob.gradenum].accessImmo) or (currentOrga.name == "mazegroup" and Jobs.mazegroup.gradenum[currentOrga.rank].accessImmo) then
                            RageUI.Button("Maze Immo", nil, {}, true, function(_, _, Selected)
                            end, RMenu:Get("immo", "main"))
                        end
                        
                    end,
                    function() end
                )
            elseif RageUI.Visible(RMenu:Get("bank", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = true, instructionalButton = true},
                    function()
                        RageUI.Button("Faire une annonce", nil, {}, true, function(_, _, Selected)
                            if Selected then
                                exports['Snoupinput']:ShowInput("Texte de l'annonce", 90, "text")
                                local text = exports['Snoupinput']:GetInput()
                                if (text ~= false and text ~= "") then
                                    TriggerServerEvent("Job:Annonce", "Maze Bank", "Annonce", text, "CHAR_BANK_MAZE", 8)
                                end
                            end
                        end)
                    end, function() end
                )
            end
            
            if (Ora.Identity.Job:GetName() == "mazegroup" and Ora.Identity.Job.ChangingJob) then
                print("breaking")
                KeySettings:Clear("keyboard", "F6", "mazegroup")
                break
            elseif (Ora.Identity.Orga:GetName() == "mazegroup" and Ora.Identity.Orga.ChangingJob) then
                KeySettings:Clear("keyboard", "F7", "mazegroup")
                break
            end

            Citizen.Wait(1.0)
        end
    end)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1000)
            if RageUI.Visible(RMenu:Get("banking", "main_atm")) then
                stillNear = IsNearATM()

                if not stillNear then
                    RageUI.Visible(RMenu:Get("banking", "main_atm"), false)
                end
            end
        end
    end
)


function mysplit (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end