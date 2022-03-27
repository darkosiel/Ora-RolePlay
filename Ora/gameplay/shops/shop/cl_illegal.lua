IllegalShops = IllegalShops or {}
IllegalShops.CLIENTSIDE = {
  ILLEGAL_SHOP = {},
  ILLEGAL_SHOP_LOADED = false,
  PAYMENT_PROCESS = false,
  INDEXES = {},
  ILLEGAL_SHOP_LIMITATION = {}
}

Citizen.CreateThread(
    function()
        while (GetResourceState("gcphone") ~= "started") do
            Wait(1000)
        end

        for index, value in pairs(IllegalShops.SHARED.GetAvailablePhones()) do
          TriggerServerEvent("AM::Illegal:addPhone", value.phone, value.event)
        end
        IllegalShops.CLIENTSIDE.CreateZones()
    end
)

RegisterNetEvent("Ora::CE::Illegal:GetPosition")
AddEventHandler(
    "Ora::CE::Illegal:GetPosition",
    function(phoneNumber)
        if (IllegalOrga.CURRENT_ORGA.ID == nil) then 
          ShowAdvancedNotification(
              "Mitch",
              "~b~Dialogue",
              "~r~~h~Tu n'es personne, ne m'appelle pas.~h~",
              "CHAR_BEVERLY",
              1
          )        
      else
          local illegalShopLocation = IllegalShops.CLIENTSIDE.GetIllegalShopCoords()
          print(IllegalOrga.GetId())
          TriggerServerEvent("Ora::Illegal:sendMessageToOrga", IllegalOrga.GetId(), "Rendez vous au point indiqué sur votre GPS pour me voir.")
          TriggerServerEvent("Ora::Illegal:setCoordsToOrga", IllegalOrga.GetId(), vector3(illegalShopLocation.pos.x,illegalShopLocation.pos.y,illegalShopLocation.pos.z))
        end
    end
)

RMenu.Add("illeg_shop_main", "main", RageUI.CreateMenu("Dealer du coin", "Actions disponibles", 10, 50))

function IllegalShops.CLIENTSIDE.GetIllegalShopCoords()
    if IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LOADED == false then
      local canSend = false
      TriggerServerCallback("Ora::SE::Illegal:GetIllegalDealerPosition", function(shopPositionAsJson)
          IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LOADED = true
          IllegalShops.CLIENTSIDE.ILLEGAL_SHOP = json.decode(shopPositionAsJson)
        canSend = true
      end)
      
      while (canSend == false) do
        Wait(100)      
      end
    end

    return IllegalShops.CLIENTSIDE.ILLEGAL_SHOP
end

function IllegalShops.CLIENTSIDE.CreateZones()
  local illegalShopCoords = IllegalShops.CLIENTSIDE.GetIllegalShopCoords()  

  Ped:Add(
      "Trent",
      IllegalShops.SHARED.DEALER_PED,
      {
          x = illegalShopCoords.pos.x,
          y = illegalShopCoords.pos.y,
          z = illegalShopCoords.pos.z,
          a = illegalShopCoords.heading
      },
      nil
  )

  Zone:Add(
      illegalShopCoords.pos,
      function(self)
          Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour acceder a la boutique")
          KeySettings:Add(
              "keyboard",
              "E",
              function()
                if (IllegalOrga.CURRENT_ORGA.ID == nil) then 
                  ShowNotification("~r~Vous n'êtes pas qualifié pour ouvrir cette boutique~s~")
                else
                  IllegalShops.ILLEGAL_SHOP_LOADED = false
                  IllegalShops.CLIENTSIDE.INDEXES = {}
                  IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION = {}
                  IllegalShops.CLIENTSIDE.PAYMENT_PROCESS = false
                  IllegalShops.CLIENTSIDE.RefreshCurrentLimit(IllegalOrga.GetId(), true)
                  RageUI.Visible(RMenu:Get("illeg_shop_main","main"), true)
                end
              end,
              "illegal_shop_buy"
          )
          KeySettings:Add(
              "controller",
              46,
              function()
                if (IllegalOrga.CURRENT_ORGA ~= nil) then 
                  ShowNotification("~r~Vous n'êtes pas qualifié pour ouvrir cette boutique~s~")
                else
                  IllegalShops.ILLEGAL_SHOP_LOADED = false
                  IllegalShops.CLIENTSIDE.INDEXES = {}
                  IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION = {}
                  IllegalShops.CLIENTSIDE.PAYMENT_PROCESS = false
                  IllegalShops.CLIENTSIDE.RefreshCurrentLimit(IllegalOrga.GetId(), true)
                  RageUI.Visible(RMenu:Get("illeg_shop_main","main"), true)
                end
              end,
              "illegal_shop_buy"
          )
      end,
      function()
          KeySettings:Clear("keyboard", "E", "illegal_shop_buy")
          KeySettings:Clear("controller", 46, "illegal_shop_buy")
          Hint:RemoveAll()

          if (RageUI.Visible(RMenu:Get("illeg_shop_main","main"))) then
                RageUI.GoBack()
                IllegalShops.CLIENTSIDE.INDEXES = {}
                  IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION = {}
                IllegalShops.CLIENTSIDE.PAYMENT_PROCESS = false
          end
      end,
      self,
      1.5
  )
end

function IllegalShops.CLIENTSIDE.RefreshCurrentLimit(organisationId, force)
  if IllegalShops.CLIENTSIDE.LIMIT_LOADED == false or force == true then
    local canSend = false
    TriggerServerCallback("Ora::SE::Illegal:GetGlobalLimitationForOrganisation", function(shopLimitationAsJson)
        IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LOADED = true
        IllegalShops.CLIENTSIDE.LIMIT_LOADED = true
        IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION = json.decode(shopLimitationAsJson)
      canSend = true
      end,
      {ORGANISATION = IllegalOrga.CURRENT_ORGA}
    )
    
    while (canSend == false) do
      Wait(100)      
    end
  end

  return IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION
end

function IllegalShops.CLIENTSIDE.GenerateValues(values)

  local maxValue = math.tointeger(values)
  local availableValues = {0}

  for i = 1, values, 1 do
      table.insert(availableValues, i)
  end

  return availableValues
end

Citizen.CreateThread(function()
    while (true) do
        Wait(0)
        if RageUI.Visible(RMenu:Get("illeg_shop_main","main")) then
          RageUI.DrawContent({ header = true, glare = false }, function()

              if (IllegalShops.CLIENTSIDE.PAYMENT_PROCESS == true) then
                  RageUI.GoBack()
                  Wait(10)
              end

              if (IllegalOrga.CURRENT_ORGA.ID ~= nil) then
                  RageUI.CenterButton(
                      "~b~↓↓↓ ~s~"..  IllegalOrga.CURRENT_ORGA.NAME .." (".. IllegalOrga.CURRENT_ORGA.LABEL ..") ~b~↓↓↓",
                      nil,
                      {},
                      true,
                      function(_, _, _)
                      end
                  )
              end

              RageUI.CenterButton(
                  "~b~____________________~s~",
                  nil,
                  {},
                  true,
                  function(_, _, _)
                  end
              )

              if (IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION ~= nil and IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION.limitation ~= nil) then
                    for index, value in pairs(IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION.limitation) do
                        if (Items[index] ~= nil) then
                            
                            if (IllegalShops.CLIENTSIDE.INDEXES[index] == nil) then
                                IllegalShops.CLIENTSIDE.INDEXES[index] = {}
                                IllegalShops.CLIENTSIDE.INDEXES[index].CURRENT_INDEX = 1
                                IllegalShops.CLIENTSIDE.INDEXES[index].PRICE = 0
                            end
    
                            IllegalShops.CLIENTSIDE.INDEXES[index].VALUES = IllegalShops.CLIENTSIDE.GenerateValues(value) 
    
                            if (value > 0) then
                                RageUI.List(
                                    "~h~~b~ " .. Items[index].label.. " - ~r~(".. IllegalShops.SHARED.GetPriceForItem(index) .."$/u)~s~~h~~s~",
                                    IllegalShops.CLIENTSIDE.INDEXES[index].VALUES,
                                    IllegalShops.CLIENTSIDE.INDEXES[index].CURRENT_INDEX,
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected, Index)
                                        IllegalShops.CLIENTSIDE.INDEXES[index].CURRENT_INDEX = Index
                                        IllegalShops.CLIENTSIDE.INDEXES[index].PRICE = (Index - 1) * IllegalShops.SHARED.GetPriceForItem(index)  
                                    end
                                )        
                            else
                            RageUI.Button("~r~[EPUISE]~s~ " .. Items[index].label, nil, {}, false, 
                                function(Hovered, Active, Selected)
                                    if (Selected) then
                                        ShowNotification("~r~J'ai plus assez de stock mec!")
                                    end
                                end
                            )
                            end
                        end
                    end
              end

              RageUI.CenterButton(
                    "~b~____________________~s~",
                    nil,
                    {},
                    true,
                    function(_, _, _)
                    end
                )

            if (IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION ~= nil and IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION.limitation ~= nil) then

                local totalPrice = 0
                for index, value in pairs(IllegalShops.CLIENTSIDE.ILLEGAL_SHOP_LIMITATION.limitation) do
                    if (Items[index] ~= nil) then
                        totalPrice = totalPrice + IllegalShops.CLIENTSIDE.INDEXES[index].PRICE
                    end
                end

                RageUI.CenterButton(
                "~g~Valider cette commande : " .. totalPrice .. "$~s~",
                nil,
                {},
                true,
                function(_, _, Selected)
                    if (Selected) then

                        if (totalPrice == 0) then
                            ShowNotification("~r~Si tu veux rien, juste bouge... tu vas me griller.~s~")
                        elseif (totalPrice > 150000) then
                            ShowNotification("~r~Veuillez passer plusieurs commandes inférieures ou égales à 150 000$.~s~")
                        else
                            IllegalShops.CLIENTSIDE.PAYMENT_PROCESS = true

                            local quote = {
                                ORGANISATION = IllegalOrga.CURRENT_ORGA, 
                                ITEMS =  IllegalShops.CLIENTSIDE.INDEXES,
                                TOTAL_PRICE = totalPrice,
                            }

                            ShowNotification("~b~Commande en cours de ~h~vérification~h~. Veuillez patienter.~s~")
                            dataonWait = {
                                title = "Achat inconnu",
                                price = totalPrice,
                                fct = function()
                                    IllegalShops.CLIENTSIDE.PAYMENT_PROCESS = false
                                    local result = nil
                                    
                                    TriggerServerCallback(
                                        "Ora::SE::IllegalShop:verifyOrder",
                                        function(isValid)
                                            if isValid == true then
                                                ShowNotification("~g~Votre commande est ~h~acceptée~h~ par le dealer.~s~")
                                                result = true
                                            else
                                                ShowNotification("~r~Votre commande est ~h~refusée~h~ par le dealer. Quota dépassé.~s~")
                                                result = false
                                            end
                                        end,
                                        quote
                                    )

                                    while (result == nil) do
                                        Wait(10)
                                    end

                                    if (result == true) then
                                        TriggerServerEvent("Ora::SE::IllegalShop:registerOrder", quote)
                                    else
                                        ShowNotification("~r~Commande est ~h~refusée~h~ remboursement effectué.~s~")
                                        TriggerServerEvent("money:Add", quote.TOTAL_PRICE)
                                    end
                                end
                            }
                            TriggerEvent("payWith?")
                        end
                    end
                end)
            end

          end)
      end
    end
end)