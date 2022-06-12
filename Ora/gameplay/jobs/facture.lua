function CreateFacture(account)
    local playerId = GetPlayerServerIdInDirection(8.0)
    if playerId ~= false then
        exports['Snoupinput']:ShowInput("Nom de la facture", 30, "text", nil, true)
        local titre = exports['Snoupinput']:GetInput()
        exports['Snoupinput']:ShowInput("Montant de la facture", 30, "number", nil, true)
        local amount = exports['Snoupinput']:GetInput()

        if (titre == false or amount == false) then return RageUI.Popup({message="~r~Facture invalide"}) end

        local _facture = {
            title = titre,
            montant = amount,
            playerId = playerId,
            account = account
        }
        _facture.montant = tonumber(_facture.montant)

        if (_facture.title ~= nil and _facture.title ~= "" and tonumber(_facture.montant) ~= nil and _facture.montant ~= 0) then
            TriggerServerEvent("facture:send", _facture)
            TriggerServerEvent("Ora:sendToDiscord", 30, "Réalise une facture pour le compte ".. _facture.account .. " de " .. _facture.montant .. "$ avec pour titre " .. _facture.title, "info")
            _facture = {}
        else
            _facture = {}
            RageUI.Popup({message="~r~Facture invalide"})
        end
    else
        RageUI.Popup({message="~r~Aucun joueur proche"})
    end
end
RegisterNetEvent("facture:paied")
AddEventHandler("facture:paied",function()
    RageUI.Popup({message="~g~Facture payée"})
end)

RegisterNetEvent("facture:nopaied")
AddEventHandler("facture:nopaied",function()
    RageUI.Popup({message="~r~Facture non-payée"})
end)


RegisterNetEvent("facture:get")
AddEventHandler("facture:get", function(_facture)
    RageUI.Popup({message="~g~Facture:\n~s~Titre : ~p~".._facture.title.."\n~s~Montant : ~o~".._facture.montant.."$~s~"})
    Wait(400)
    RageUI.Popup({message="~g~E ~s~pour accepter\n~r~Y ~s~pour refuser"})
    if _facture.source == nil then _facture.source = GetPlayerServerIdInDirection(5.0) end

    KeySettings:Add("keyboard", "E", function() 
        if _facture.source == nil then _facture.source = GetPlayerServerIdInDirection(5.0) end

        __facture = _facture
        dataonWait = {
            title = __facture.title, 
            price = __facture.montant,
            account = __facture.account,
            fct = function(type) -- type (optional) = "money" or "bank" in clshop
                if type then
                    if type == "money" then
                        if __facture.account ~= "gouvernement" and Jobs[__facture.account].isSelf then
                            TriggerServerCallback(
                                "Ora::SE::Money:AuthorizePayment", 
                                function(token)
                                    TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = __facture.montant, SOURCE = "Paiement liquide Uber", LEGIT = true, ROUTING = __facture.source})
                                end,
                                {ROUTING = __facture.source}
                            )
                        else
                            TriggerServerEvent('business:AddFromTreasury', __facture.account, __facture.montant)
                        end
                    else
                        if __facture.account ~= "gouvernement" and Jobs[__facture.account].isSelf then
                            TriggerServerCallback(
                                "Ora:addBankIfExists",
                                function(bool)
                                    if not bool then
                                        TriggerServerCallback(
                                            "Ora::SE::Money:AuthorizePayment", 
                                            function(token)
                                                TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = __facture.montant, SOURCE = "Paiement transféré en liquide Uber", LEGIT = true, ROUTING = __facture.source})
                                            end,
                                            {ROUTING = __facture.source}
                                        )
                                    end
                                end,
                                __facture.source,
                                __facture.montant
                            )
                        else
                            TriggerServerEvent("entreprise:Add", __facture.account, __facture.montant)
                        end
                    end
                else
                    error('Aucun moyen de paiement détecté.')
                end
                local method = type and type == "money" and "En liquide" or "Par CB" or "inconnu"
                if __facture.source == nil then __facture.source = GetPlayerServerIdInDirection(5.0) end

                TriggerServerEvent('Ora:logInvoice', __facture.account, __facture.title, __facture.source, __facture.montant, method)
                TriggerServerEvent("business:SetProductivity", __facture.source, __facture.account, __facture.montant, true)
                TriggerPlayerEvent("RageUI:Popup", __facture.source, {message="Le citoyen a bien payé la facture"})
                RageUI.Popup({message="~g~Paiement accepté"})
            end
        }
        KeySettings:Clear("keyboard", "E", "factureX")

        -- if Ora.Inventory.Data["bank_card"] == nil then
        --     dataonWait = {}
        --     return ShowNotification("~r~Vous n'avez pas de cartes bancaires")
        -- else
        --     RageUI.Visible(RMenu:Get('personnal', 'choose_card'),true)
        -- end 
        CloseAllMenus()
        TriggerEvent("payWith?")
    end, "factureX")

    KeySettings:Add("keyboard", "Y", function() 
        RageUI.Popup({message="~g~Paiement refusé"})
        if _facture.source == nil then
            _facture.source = GetPlayerServerIdInDirection(5.0)
        end
        KeySettings:Clear("keyboard", "Y", "facture2")
        TriggerPlayerEvent("facture:nopaied", _facture.source)
    end, "facture2")



    Wait(15000)
    _facture = {}
    KeySettings:Clear("keyboard", "Y", "facture2")
    KeySettings:Clear("keyboard", "E", "factureX")
end)





function CreateFakeFacture(job)
    local playerId = GetPlayerServerIdInDirection(8.0)
    if playerId ~= false then
        exports['Snoupinput']:ShowInput("Nom de la facture", 30, "text", nil, true)
        local titre = exports['Snoupinput']:GetInput()
        exports['Snoupinput']:ShowInput("Montant de la facture", 30, "number", nil, true)
        local amount = exports['Snoupinput']:GetInput()

        if (not titre or not amount) then return RageUI.Popup({message = "~r~Facture invalide"}) end

        local _facture = {
            title = titre,
            montant = amount,
            playerId = playerId,
            account = job
        }
        _facture.montant = tonumber(_facture.montant)

        if (_facture.title ~= nil and _facture.title ~= "" and tonumber(_facture.montant) ~= nil and _facture.montant ~= 0) then
            TriggerServerEvent("fake_facture:send", _facture)
            _facture = {}
        else
            _facture = {}
            RageUI.Popup({message = "~r~Facture invalide"})
        end
    else
        RageUI.Popup({message = "~r~Aucun joueur proche"})
    end
end


RegisterNetEvent("fake_facture:get")
AddEventHandler("fake_facture:get", function(_facture)
    RageUI.Popup({message="~g~Facture:\n~s~Titre : ~p~".._facture.title.."\n~s~Montant : ~o~".._facture.montant.."$~s~"})
    Wait(400)
    RageUI.Popup({message="~g~E ~s~pour accepter\n~r~Y ~s~pour refuser"})
    if _facture.source == nil then _facture.source = GetPlayerServerIdInDirection(5.0) end

    KeySettings:Add("keyboard", "E", function() 
        if _facture.source == nil then _facture.source = GetPlayerServerIdInDirection(5.0) end

        __facture = _facture
        dataonWait = {
            title = __facture.title, 
            price = __facture.montant,
            account = __facture.account,
            fct = function()
                TriggerServerEvent('business:AddFromTreasury', __facture.account, math.floor(Ora.Jobs.Bleacher.Tax * __facture.montant))

                if __facture.source == nil then __facture.source = GetPlayerServerIdInDirection(5.0) end

                TriggerServerEvent('Ora:logInvoice', __facture.account, __facture.title, __facture.source, __facture.montant, "En liquide")
                TriggerServerEvent("business:SetProductivity", __facture.source, __facture.account, __facture.montant, true)
                TriggerPlayerEvent("RageUI:Popup", __facture.source, {message = "Le citoyen a bien payé la facture"})
                RageUI.Popup({message = "~g~Paiement accepté"})
            end
        }
        KeySettings:Clear("keyboard", "E", "factureX")

        -- if Ora.Inventory.Data["bank_card"] == nil then
        --     dataonWait = {}
        --     return ShowNotification("~r~Vous n'avez pas de cartes bancaires")
        -- else
        --     RageUI.Visible(RMenu:Get('personnal', 'choose_card'),true)
        -- end
        -- CloseAllMenus()
        TriggerEvent("payByFakeCash")
    end, "factureX")

    KeySettings:Add("keyboard", "Y", function() 
        RageUI.Popup({message = "~g~Paiement refusé"})
        if _facture.source == nil then
            _facture.source = GetPlayerServerIdInDirection(5.0)
        end
        KeySettings:Clear("keyboard", "Y", "facture2")
        TriggerPlayerEvent("facture:nopaied", _facture.source)
    end, "facture2")


    Wait(15000)
    _facture = {}
    KeySettings:Clear("keyboard", "Y", "facture2")
    KeySettings:Clear("keyboard", "E", "factureX")
end)
