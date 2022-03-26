IllegalLabsAndWarehouse = IllegalLabsAndWarehouse or {}

if (IllegalLabsAndWarehouse.MENUS == nil) then
  IllegalLabsAndWarehouse.MENUS = {}
end

IllegalLabsAndWarehouse.MENUS.GUNLEAD = {}
IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES = {}
IllegalLabsAndWarehouse.MENUS.GUNLEAD.TOTAL_PRICE = 0
IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY = {}
IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.LIST = {}
IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.LOADED = false
IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER = {}

RMenu.Add("illeg_property_gunlead_main", "main", RageUI.CreateMenu("Gestion", "Actions disponibles", 10, 50))
RMenu.Add("illeg_property_gunlead_main", "illeg_property_gunlead_new_order", RageUI.CreateSubMenu(RMenu:Get("illeg_property_gunlead_main", "main"), "Nouvelle commande", "Listes"))
RMenu.Add("illeg_property_gunlead_main", "illeg_property_gunlead_order_history", RageUI.CreateSubMenu(RMenu:Get("illeg_property_gunlead_main", "main"), "Réceptionner mes commandes", "Listes"))
RMenu.Add("illeg_property_gunlead_main", "illeg_property_gunlead_show_order", RageUI.CreateSubMenu(RMenu:Get("illeg_property_gunlead_main", "main"), "Visualisation commande", "Listes"))
RMenu.Add("illeg_property_gunlead_main", "illeg_property_gunlead_security", RageUI.CreateSubMenu(RMenu:Get("illeg_property_gunlead_main", "main"), "Niveau de sécurité", "Listes"))
RMenu.Add("illeg_property_gunlead_main", "illeg_property_gunlead_production", RageUI.CreateSubMenu(RMenu:Get("illeg_property_gunlead_main", "main"), "Niveau de production", "Listes"))


function IllegalLabsAndWarehouse.MENUS.GUNLEAD.CreateZones()
  local computerCoords = IllegalLabsAndWarehouse.GetComputerPositionByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)  

  Marker:Add(
      computerCoords,
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
      computerCoords,
      function(self)
          Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le logiciel de gestion")
          KeySettings:Add(
              "keyboard",
              "E",
              function()
                IllegalLabsAndWarehouse.RefreshCurrentPropertyByName(IllegalLabsAndWarehouse.CURRENT_PROPERTY.name)
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.LIST = {}
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.LOADED = false
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER = {}
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
                RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","main"), true)
              end,
              "illegal_property_manage"
          )
          KeySettings:Add(
              "controller",
              46,
              function()
                IllegalLabsAndWarehouse.RefreshCurrentPropertyByName(IllegalLabsAndWarehouse.CURRENT_PROPERTY.name)
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.LIST = {}
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.LOADED = false
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER = {}
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
                RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","main"), true)
              end,
              "illegal_property_manage"
          )
      end,
      function()
          KeySettings:Clear("keyboard", "E", "illegal_property_manage")
          KeySettings:Clear("controller", 46, "illegal_property_manage")
          Hint:RemoveAll()

          if (RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","main"))) then
                RageUI.GoBack()
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
          end

          if (RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","illeg_property_gunlead_new_order"))) then
                RageUI.GoBack()
                Wait(10)
                RageUI.GoBack()
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
          end

          if (RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","illeg_property_gunlead_production"))) then
                RageUI.GoBack()
                Wait(10)
                RageUI.GoBack()
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
          end

          if (RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","illeg_property_gunlead_show_order"))) then
                RageUI.GoBack()
                Wait(10)
                RageUI.GoBack()
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
          end

          if (RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","illeg_property_gunlead_order_history"))) then
                RageUI.GoBack()
                Wait(10)
                RageUI.GoBack()
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
          end
          if (RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","illeg_property_gunlead_security"))) then
                RageUI.GoBack()
                Wait(10)
                RageUI.GoBack()
                IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
          end
      end,
      self,
      1.5
  )

end

function IllegalLabsAndWarehouse.MENUS.GUNLEAD.DeleteZones()
    local computerCoords = IllegalLabsAndWarehouse.GetComputerPositionByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)  
    Marker:Remove(computerCoords)
    Zone:Remove(computerCoords)
    IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
end

function IllegalLabsAndWarehouse.MENUS.GUNLEAD.GenerateValues(values)

    local maxValue = math.tointeger(values)
    local availableValues = {0}

    for i = 1, values, 1 do
        table.insert(availableValues, i)
    end

    return availableValues
end

function IllegalLabsAndWarehouse.MENUS.GUNLEAD.LoadOrderHistory(propertyId)
    if (IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.LOADED == false) then
        local canSend = false
        TriggerServerCallback("Atlantiss:Illegal:GetOrderHistoryByPropertyId", function(orderHistoryAsJson)
            IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.LOADED = true
            IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.LIST = json.decode(orderHistoryAsJson)
          canSend = true
        end, propertyId)
        
        while (canSend == false) do
          Wait(100)      
        end
    end

    return IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.LIST
end

-- Handle Menu Options
Citizen.CreateThread(function()
    while (true) do
        Wait(0)

        if RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","illeg_property_gunlead_show_order")) then
            RageUI.DrawContent({ header = true, glare = false }, function()
                if (IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS == true) then
                    RageUI.GoBack()
                    Wait(10)
                end

                if (IllegalLabsAndWarehouse.CURRENT_PROPERTY.name ~= nil) then
                    RageUI.CenterButton(
                        "~b~↓↓↓ ~s~"..  IllegalLabsAndWarehouse.CURRENT_PROPERTY.name .." ~b~↓↓↓",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end
                    )
                end

                for index, value in pairs(IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER.order_detail) do
                    if (Items[index] ~= nil and value.qty > 0) then
                        RageUI.Button("~h~~r~" .. value.qty .. "x ~b~" .. Items[index].label .. "~s~~h~", nil, {RightLabel = "~h~~g~" .. value.price .. "$~s~~h~"}, true, 
                            function(Hovered, Active, Selected)
                            end
                        )
                    end
                end

                if (IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER.status == "waiting_delivery") then
                    
                    RageUI.CenterButton(
                        "~h~~b~----------------~h~~s~",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end
                    )

                    RageUI.CenterButton(
                        "~h~~g~Récéptionner la commande #"..IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER.id.."~h~~s~",
                        nil,
                        {},
                        true,
                        function(_, _, Selected)
                            if (Selected) then
                                
                                TriggerServerCallback(
                                    "Atlantiss::SE::Service:GetTotalServiceCountForJobs",
                                    function(numberOfPolice)
                                        if (numberOfPolice >= Atlantiss.Illegal:GetCopsRequired("gundelivery")) then
                                            local deliveryPosition = IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER.delivery_position
                                            TriggerServerEvent("AM::Illegal:addPhone", IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER.phone, "Atlantiss::Illegal:Gunleader:GetOrder")
                                            TriggerServerEvent("Atlantiss::Illegal:sendMessageToOrga", IllegalLabsAndWarehouse.CURRENT_PROPERTY.organisation_id, "Réception d'armes : Une fois sur place, appelez le ~h~" .. IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER.phone)
                                            TriggerServerEvent("Atlantiss::Illegal:sendMessageToOrga", IllegalLabsAndWarehouse.CURRENT_PROPERTY.organisation_id, "Réception d'armes : Rendez vous au lieu d'échange. Une fois sur place")
                                            TriggerServerEvent("Atlantiss::Illegal:setCoordsToOrga", IllegalLabsAndWarehouse.CURRENT_PROPERTY.organisation_id, deliveryPosition.finish)
                                            TriggerServerEvent(
                                                "atlantiss:sendToDiscord",
                                                22,
                                                "[COMMANDE #" .. IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER.id .. "]\nCréé le rendez vous pour receptionner les armes. (Num a appeler : " .. IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER.phone ..")", 
                                                "info"
                                            )
                                        else
                                            TriggerServerEvent("Atlantiss::Illegal:sendMessageToOrga", IllegalLabsAndWarehouse.CURRENT_PROPERTY.organisation_id, "Réception d'armes : J'ai pas encore assez d'hommes. Rappel plus tard")
                                        end
                                    end,
                                    {"police", "lssd"}
                                )

                                RageUI.GoBack()
                                Wait(10)
                            end
                        end
                    )
                end
            end)
        end

        if RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","illeg_property_gunlead_order_history")) then
            RageUI.DrawContent({ header = true, glare = false }, function()

                if (IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS == true) then
                    RageUI.GoBack()
                    Wait(10)
                end
                local orderHistory = IllegalLabsAndWarehouse.MENUS.GUNLEAD.LoadOrderHistory(IllegalLabsAndWarehouse.CURRENT_PROPERTY.id)

                
                if (IllegalLabsAndWarehouse.CURRENT_PROPERTY.name ~= nil) then
                    RageUI.CenterButton(
                        "~b~↓↓↓ ~s~"..  IllegalLabsAndWarehouse.CURRENT_PROPERTY.name .." ~b~↓↓↓",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end
                    )
                end

                for index, value in pairs(orderHistory) do
                    local statusColor = "~o~"

                    if (value.status == "waiting_delivery") then
                        statusColor = "~b~"
                    elseif (value.status == "delivered") then
                        statusColor = "~g~"
                    end

                    RageUI.Button("[".. statusColor .. IllegalLabsAndWarehouse.GetOrderLabel(value.status) .."~s~]" .. " - Montant : " .. value.price .. "$", "Commande d'un montant de " .. value.price .. "$", {}, true, function(Hovered, Active, Selected)
                        if (Active) then
                            IllegalLabsAndWarehouse.MENUS.GUNLEAD.HISTORY.CURRENT_ORDER = value
                        end
                        end, 
                        RMenu:Get("illeg_property_gunlead_main", "illeg_property_gunlead_show_order")
                    )
                end
            end)
        end

        if RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","illeg_property_gunlead_new_order")) then
                RageUI.DrawContent({ header = true, glare = false }, function()

                    if (IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS == true) then
                        RageUI.GoBack()
                        Wait(10)
                    end

                    if (IllegalLabsAndWarehouse.CURRENT_PROPERTY.name ~= nil) then
                        RageUI.CenterButton(
                            "~b~↓↓↓ ~s~"..  IllegalLabsAndWarehouse.CURRENT_PROPERTY.name .." ~b~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                    end

                    for index, value in pairs(IllegalLabsAndWarehouse.CURRENT_PROPERTY.limitation) do
                        if (Items[value.name] ~= nil) then
                            
                            if (IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name] == nil) then
                                IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name] = {}
                                IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].CURRENT_INDEX = 1
                                IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].PRICE = 0
                            end

                            IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].VALUES = IllegalLabsAndWarehouse.MENUS.GUNLEAD.GenerateValues(value.byWeek) 

                            if (value.byWeek > 0) then
                                RageUI.List(
                                    "~h~~b~ " .. Items[value.name].label.. " - ~r~("..value.price .."$/u)~s~~h~~s~",
                                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].VALUES,
                                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].CURRENT_INDEX,
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected, Index)
                                        IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].CURRENT_INDEX = Index
                                        IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].PRICE = (Index - 1) * value.price  

                                        if Selected then
                                            amount = KeyboardInput("Quantité ?", nil, 5)
                                            if tonumber(amount) ~= nil then
                                                if (IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].VALUES[tonumber(amount) + 1] ~= nil) then
                                                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].CURRENT_INDEX = tonumber(amount) + 1
                                                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].PRICE = (tonumber(amount)) * value.price  
                                                else
                                                    ShowNotification(string.format("La valeur ~r~%s~s~ est incorrecte. Max : ~g~%s~s~", tonumber(amount), #IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].VALUES - 1))
                                                end
                                            end
                                        end
                                    end
                                )        
                            end
                        end
                    end
                    
                    RageUI.CenterButton(
                        "~h~~b~----------------~h~~s~",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end
                    )

                    local totalPrice = 0
                    for index, value in pairs(IllegalLabsAndWarehouse.CURRENT_PROPERTY.limitation) do
                        if (Items[value.name] ~= nil) then
                            totalPrice = totalPrice + IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES[value.name].PRICE
                        end
                    end


                    RageUI.CenterButton(
                        "~h~~g~Valider la commande : ~b~".. totalPrice .."$~h~~s~",
                        nil,
                        {},
                        true,
                        function(_, _, Selected)
                            if (Selected) then
                                if (totalPrice > 150000) then
                                    ShowNotification("~r~Veuillez passer plusieurs commandes inférieures ou égales à 150 000$.~s~")
                                else
                                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = true
                                    local deliveryPositions = IllegalLabsAndWarehouse.GetDeliveryPositionsForBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)
                                    local deliveryPosition = deliveryPositions[math.random(1, #deliveryPositions)]
    
                                    local quote = {
                                        ITEMS = IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES,
                                        PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY,
                                        TOTAL_PRICE = totalPrice,
                                        DELIVERY_POSITION = deliveryPosition,
                                        NO_LIMIT = false
                                    }

                                    ShowNotification("~b~Commande en cours de ~h~vérification~h~. Veuillez patienter.~s~")
                                    dataonWait = {
                                        title = "Achat inconnu",
                                        price = totalPrice,
                                        isLimited = false,
                                        fct = function()
                                            IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
                                            local result = nil
                                            TriggerServerCallback(
                                                "Atlantiss:Illegal:verifyOrder",
                                                function(isValid)
                                                    if isValid == true then
                                                        ShowNotification("~g~Votre commande est ~h~acceptée~h~ par le mandataire.~s~")
                                                        result = true
                                                    else
                                                        ShowNotification("~r~Votre commande est ~h~refusée~h~ par le mandataire. Quota dépassé.~s~")
                                                        result = false
                                                    end
                                                end,
                                                quote
                                            )
    
                                            while (result == nil) do
                                                Wait(10)
                                            end

                                            if (result == true) then
                                                TriggerServerEvent("Atlantiss:Illegal:registerOrder", quote)
                                                TriggerServerEvent("Atlantiss::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", totalPrice, true)
                                            else
                                                ShowNotification("~r~Commande est ~h~refusée~h~ remboursement effectué.~s~")
                                                TriggerServerEvent("money:Add", quote.TOTAL_PRICE)
                                            end
                                        end
                                    }
                                    TriggerEvent("payWith?")
                                end
                            end
                        end
                    )
                end)
        end

        if RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","illeg_property_gunlead_security")) then
            RageUI.DrawContent({ header = true, glare = false }, function()
                if (IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS == true) then
                    RageUI.GoBack()
                    Wait(10)
                else
                    if (IllegalLabsAndWarehouse.CURRENT_PROPERTY.name ~= nil) then
                        RageUI.CenterButton(
                            "~b~↓↓↓ ~s~"..  IllegalLabsAndWarehouse.CURRENT_PROPERTY.name .." ~b~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                    end

                    RageUI.CenterButton(
                        "~h~~b~----------------~h~~s~",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end
                    )

                    securityLevels = IllegalLabsAndWarehouse.GetSecurityEvolutionsByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)

                    for index, value in pairs(securityLevels) do
                        if index == IllegalLabsAndWarehouse.CURRENT_PROPERTY.security_level then
                            RageUI.Button("~g~" .. value.label .. "~s~", value.description, {RightLabel = "~g~Acquis~s~"}, true, 
                                function(Hovered, Active, Selected)
                                    if Selected then
                                        ShowNotification("~b~Il s'agit de votre niveau actuel.~s~")
                                    end
                                end
                            )
                        elseif index == IllegalLabsAndWarehouse.CURRENT_PROPERTY.security_level + 1 then
                            RageUI.Button("~b~" .. value.label .. "~s~", value.description,  {RightLabel = "~g~" .. value.price .. "$"}, true, 
                                function(Hovered, Active, Selected)
                                    if Selected then
                                        IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = true
                                        exports['Snoupinput']:ShowInput("Type de paiement (supprimez le mauvais et le /) | " .. math.floor(Atlantiss.Illegal.FakeMoneyTax * 100) .. "% du prix initial en argent sale", 30, "text", "propre/sale", true)
                                        local type = exports['Snoupinput']:GetInput()

                                        if (type and type == "propre") then
                                            RageUI.CloseAll()

                                            dataonWait = {
                                                title = "Achat matériels",
                                                price = value.price,
                                                isLimited = false,
                                                fct = function()
                                                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
                                                    TriggerServerEvent("Atlantiss::Illegal:updateSecurityLevel", { PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY, LEVEL = index })
                                                    TriggerServerEvent("Atlantiss::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", value.price, true)
                                                end
                                            }
        
                                            TriggerEvent("payWith?")
                                        elseif (type and type == "sale") then
                                            RageUI.CloseAll()

                                            dataonWait = {
                                                title = "Achat matériels",
                                                price = math.ceil(value.price * Atlantiss.Illegal.FakeMoneyTax),
                                                isLimited = false,
                                                fct = function()
                                                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
                                                    TriggerServerEvent("Atlantiss::Illegal:updateSecurityLevel", { PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY, LEVEL = index })
                                                    TriggerServerEvent("Atlantiss::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", math.ceil(value.price * Atlantiss.Illegal.FakeMoneyTax), true)
                                                end
                                            }
        
                                            TriggerEvent("payByFakeCash")
                                        elseif (type ~= false) then
                                            RageUI.Popup({message = '~r~Vous devez simplement mettre "sale" ou "propre" sans les guillemets'})
                                        end
                                    end
                                end
                            )
                        elseif index > IllegalLabsAndWarehouse.CURRENT_PROPERTY.security_level + 1 then
                            RageUI.Button("~w~" .. value.label .. "~s~", "~h~Vous devez débloquer d'abord le niveau : ".. IllegalLabsAndWarehouse.CURRENT_PROPERTY.security_level + 1 .."~h~\n\n" .. value.description, {RightLabel = "~g~" .. value.price .. "$"}, true, 
                                function(Hovered, Active, Selected)
                                    if Selected then
                                        ShowNotification("~r~Vous devez débloquer le niveau ".. IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level + 1 .. " avant.~s~")
                                    end
                                end
                            )
                        elseif index < IllegalLabsAndWarehouse.CURRENT_PROPERTY.security_level then
                            RageUI.Button("~w~" .. value.label .. "~s~", value.description, {RightLabel = "~g~Acquis~s~"}, true, 
                                function(Hovered, Active, Selected)
                                    if Selected then
                                        ShowNotification("~b~Vous avez déjà acheté ce niveau.~s~")
                                    end
                                end
                            )
                        end
                    end

                end
            end)
        end

        if RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","illeg_property_gunlead_production")) then
            RageUI.DrawContent({ header = true, glare = false }, function()
                if (IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS == true) then
                    RageUI.GoBack()
                    Wait(10)
                else
                    if (IllegalLabsAndWarehouse.CURRENT_PROPERTY.name ~= nil) then
                        RageUI.CenterButton(
                            "~b~↓↓↓ ~s~"..  IllegalLabsAndWarehouse.CURRENT_PROPERTY.name .." ~b~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                    end

                    RageUI.CenterButton(
                        "~h~~b~----------------~h~~s~",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end
                    )

                    productionLevels = IllegalLabsAndWarehouse.GetProductionEvolutionsByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)

                    for index, value in pairs(productionLevels) do
                        if index == IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level then
                            RageUI.Button("~g~" .. value.label .. "~s~", value.description, {RightLabel = "~g~Acquis~s~"}, true, 
                                function(Hovered, Active, Selected)
                                    if Selected then
                                        ShowNotification("~b~Il s'agit de votre niveau actuel.~s~")
                                    end
                                end
                            )
                        elseif index == IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level + 1 then
                            RageUI.Button("~b~" .. value.label .. "~s~", value.description,  {RightLabel = "~g~" .. value.price .. "$"}, true, 
                                function(Hovered, Active, Selected)
                                    if Selected then
                                        IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = true
                                        exports['Snoupinput']:ShowInput("Type de paiement (supprimez le mauvais et le /) | " .. math.floor(Atlantiss.Illegal.FakeMoneyTax * 100) .. "% du prix initial en argent sale", 30, "text", "propre/sale", true)
                                        local type = exports['Snoupinput']:GetInput()

                                        if (type and type == "propre") then
                                            RageUI.CloseAll()

                                            dataonWait = {
                                                title = "Achat matériels",
                                                price = value.price,
                                                isLimited = false,
                                                fct = function()
                                                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
                                                    TriggerServerEvent("Atlantiss::Illegal:updateProductionLevel", { PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY, LEVEL = index })
                                                    TriggerServerEvent("Atlantiss::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", value.price, true)
                                                end
                                            }
        
                                            TriggerEvent("payWith?")
                                        elseif (type and type == "sale") then
                                            RageUI.CloseAll()

                                            dataonWait = {
                                                title = "Achat matériels",
                                                price = math.ceil(value.price * Atlantiss.Illegal.FakeMoneyTax),
                                                isLimited = false,
                                                fct = function()
                                                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS = false
                                                    TriggerServerEvent("Atlantiss::Illegal:updateProductionLevel", { PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY, LEVEL = index })
                                                    TriggerServerEvent("Atlantiss::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", math.ceil(value.price * Atlantiss.Illegal.FakeMoneyTax), true)
                                                end
                                            }
        
                                            TriggerEvent("payByFakeCash")
                                        elseif (type ~= false) then
                                            RageUI.Popup({message = '~r~Vous devez simplement mettre "sale" ou "propre" sans les guillemets'})
                                        end
                                    end
                                end
                            )
                        elseif index > IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level + 1 then
                            RageUI.Button("~w~" .. value.label .. "~s~", "~h~Vous devez débloquer d'abord le niveau : ".. IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level + 1 .."~h~\n\n" .. value.description, {RightLabel = "~g~" .. value.price .. "$"}, true, 
                                function(Hovered, Active, Selected)
                                    if Selected then
                                        ShowNotification("~r~Vous devez débloquer le niveau ".. IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level + 1 .. " avant.~s~")
                                    end
                                end
                            )
                        elseif index < IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level then
                            RageUI.Button("~w~" .. value.label .. "~s~", value.description, {RightLabel = "~g~Acquis~s~"}, true, 
                                function(Hovered, Active, Selected)
                                    if Selected then
                                        ShowNotification("~b~Vous avez déjà acheté ce niveau.~s~")
                                    end
                                end
                            )
                        end
                    end
                end
            end)
        end

        

        -- Main menu
        if RageUI.Visible(RMenu:Get("illeg_property_gunlead_main","main")) then
            RageUI.DrawContent({ header = true, glare = false }, function()

                if (IllegalLabsAndWarehouse.MENUS.GUNLEAD.PAYMENT_PROCESS == true) then
                    RageUI.GoBack()
                    Wait(10)
                else
                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.INDEXES = {}
                    IllegalLabsAndWarehouse.MENUS.GUNLEAD.TOTAL_PRICE = 0
    
                    if (IllegalLabsAndWarehouse.CURRENT_PROPERTY.name ~= nil) then
                        RageUI.CenterButton(
                            "~b~↓↓↓ ~s~"..  IllegalLabsAndWarehouse.CURRENT_PROPERTY.name .." ~b~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                    end
    
    
                    RageUI.CenterButton(
                        "~h~~b~----------------~h~~s~",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end
                    )
    
                    RageUI.Button("Passer une commande d'arme", "Vous permet d'acceder à la commande d'arme", {}, true, function(Hovered, Active, Selected)
                            if Selected then
                            end
                        end, 
                        RMenu:Get("illeg_property_gunlead_main", "illeg_property_gunlead_new_order")
                    )
    
                    RageUI.Button("Receptionner mes commandes", "Visualiser mon historique de commandes", {}, true, function(Hovered, Active, Selected)
                            if Selected then
                            end
                        end, 
                        RMenu:Get("illeg_property_gunlead_main", "illeg_property_gunlead_order_history")
                    )
    
                    RageUI.CenterButton(
                        "~h~~b~----------------~h~~s~",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end
                    )
    
                    RageUI.Button("Gestion propriété : Sécurité", "Gérer la sécurité de votre dépot d'arme", {}, true, function(Hovered, Active, Selected)
                        end, 
                        RMenu:Get("illeg_property_gunlead_main", "illeg_property_gunlead_security")
                    )
    
                    RageUI.Button("Gestion propriété : Production", "Gérer la production de votre dépot d'arme", {}, true, function(Hovered, Active, Selected)
                        end, 
                        RMenu:Get("illeg_property_gunlead_main", "illeg_property_gunlead_production")
                    )
                end
          end)
        end
    end
end)