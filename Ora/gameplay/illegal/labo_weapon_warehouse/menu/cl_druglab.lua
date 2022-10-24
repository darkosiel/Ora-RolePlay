IllegalLabsAndWarehouse = IllegalLabsAndWarehouse or {}

if (IllegalLabsAndWarehouse.MENUS == nil) then
  IllegalLabsAndWarehouse.MENUS = {}
end

IllegalLabsAndWarehouse.MENUS.DRUGLAB = {}
IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES = {}
IllegalLabsAndWarehouse.MENUS.DRUGLAB.TOTAL_PRICE = 0
IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY = {}
IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LIST = {}
IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LOADED = false
IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER = {}
IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE = {
    CURRENT = nil
}

RMenu.Add("illeg_property_druglab_main", "main", RageUI.CreateMenu("Gestion", "Actions disponibles", 10, 50))
RMenu.Add("illeg_property_druglab_main", "illeg_property_druglab_security", RageUI.CreateSubMenu(RMenu:Get("illeg_property_druglab_main", "main"), "Niveau de sécurité", "Listes"))
RMenu.Add("illeg_property_druglab_main", "illeg_property_druglab_production", RageUI.CreateSubMenu(RMenu:Get("illeg_property_druglab_main", "main"), "Niveau de production", "Listes"))
RMenu.Add("illeg_property_druglab_main", "illeg_property_druglab_new_order", RageUI.CreateSubMenu(RMenu:Get("illeg_property_druglab_main", "main"), "Passer une commande", "Listes"))
RMenu.Add("illeg_property_druglab_main", "illeg_property_druglab_order_history", RageUI.CreateSubMenu(RMenu:Get("illeg_property_druglab_main", "main"), "Historique des commandes", "Listes"))
RMenu.Add("illeg_property_druglab_main", "illeg_property_druglab_show_order", RageUI.CreateSubMenu(RMenu:Get("illeg_property_druglab_main", "main"), "Visualisation commande", "Listes"))
RMenu.Add("illeg_property_druglab_work", "main", RageUI.CreateMenu("Production", "Actions disponibles", 10, 50))


function IllegalLabsAndWarehouse.MENUS.DRUGLAB.CreateZones()
  local computerCoords = IllegalLabsAndWarehouse.GetComputerPositionByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)  
  local workplacesCoords = IllegalLabsAndWarehouse.GetWorkplacesPositionByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)  

  for index, value in pairs(workplacesCoords) do
    Marker:Add(
        value.pos,
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
        value.pos,
        function(self)
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour fabriquer")
            KeySettings:Add(
                "keyboard",
                "E",
                function()
                    IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                    IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT_ID = value.id
                    IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT = IllegalLabsAndWarehouse.RefreshCurrentWorkplaceByPropertyIdAndWorkplaceId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.id, IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT_ID)
                    RageUI.Visible(RMenu:Get("illeg_property_druglab_work","main"), true)
                end,
                "illegal_property_drug_create"
            )
            KeySettings:Add(
                "controller",
                46,
                function()
                    IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                    IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT_ID = value.id
                    IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT = IllegalLabsAndWarehouse.RefreshCurrentWorkplaceByPropertyIdAndWorkplaceId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.id, IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT_ID)
                    RageUI.Visible(RMenu:Get("illeg_property_druglab_work","main"), true)
                end,
                "illegal_property_drug_create"
            )
        end,
        function()
            KeySettings:Clear("keyboard", "E", "illegal_property_drug_create")
            KeySettings:Clear("controller", 46, "illegal_property_drug_create")
            Hint:RemoveAll()
            IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT_ID = nil
            IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT = {}

            if (RageUI.Visible(RMenu:Get("illeg_property_druglab_work","main"))) then
                  RageUI.GoBack()
                  IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
            end
        end,
        self,
        2.0
    )
  end

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
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LIST = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LOADED = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.TOTAL_PRICE = 0
                IllegalLabsAndWarehouse.RefreshCurrentPropertyByName(IllegalLabsAndWarehouse.CURRENT_PROPERTY.name)
                RageUI.Visible(RMenu:Get("illeg_property_druglab_main","main"), true)
              end,
              "illegal_property_manage"
          )
          KeySettings:Add(
              "controller",
              46,
              function()
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LIST = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LOADED = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.TOTAL_PRICE = 0
                IllegalLabsAndWarehouse.RefreshCurrentPropertyByName(IllegalLabsAndWarehouse.CURRENT_PROPERTY.name)
                RageUI.Visible(RMenu:Get("illeg_property_druglab_main","main"), true)
              end,
              "illegal_property_manage"
          )
      end,
      function()
            KeySettings:Clear("keyboard", "E", "illegal_property_manage")
            KeySettings:Clear("controller", 46, "illegal_property_manage")
            Hint:RemoveAll()

            if (RageUI.Visible(RMenu:Get("illeg_property_druglab_main","main"))) then
                RageUI.GoBack()
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LIST = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LOADED = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.TOTAL_PRICE = 0
            end

            if (RageUI.Visible(RMenu:Get("illeg_property_druglab_main","illeg_property_druglab_new_order"))) then
                RageUI.GoBack()
                Wait(10)
                RageUI.GoBack()
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LIST = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LOADED = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.TOTAL_PRICE = 0
            end

            if (RageUI.Visible(RMenu:Get("illeg_property_druglab_main","illeg_property_druglab_order_history"))) then
                RageUI.GoBack()
                Wait(10)
                RageUI.GoBack()
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LIST = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LOADED = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.TOTAL_PRICE = 0
            end

            if (RageUI.Visible(RMenu:Get("illeg_property_druglab_main","illeg_property_druglab_show_order"))) then
                RageUI.GoBack()
                Wait(10)
                RageUI.GoBack()
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LIST = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LOADED = false
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES = {}
                IllegalLabsAndWarehouse.MENUS.DRUGLAB.TOTAL_PRICE = 0
            end
      end,
      self,
      1.5
  )
end

function IllegalLabsAndWarehouse.MENUS.DRUGLAB.LoadOrderHistory(propertyId)
    if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LOADED == false) then
        local canSend = false
        TriggerServerCallback("Ora:Illegal:GetOrderHistoryByPropertyId", function(orderHistoryAsJson)
            IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LOADED = true
            IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LIST = json.decode(orderHistoryAsJson)
          canSend = true
        end, propertyId)
        
        while (canSend == false) do
          Wait(100)      
        end
    end

    return IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.LIST
end

function IllegalLabsAndWarehouse.MENUS.DRUGLAB.DeleteZones()
    local workplacesCoords = IllegalLabsAndWarehouse.GetWorkplacesPositionByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)  
    for index, value in pairs(workplacesCoords) do
        Marker:Remove(value.pos)
        Zone:Remove(value.pos)
    end

    local computerCoords = IllegalLabsAndWarehouse.GetComputerPositionByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)  
    Marker:Remove(computerCoords)
    Zone:Remove(computerCoords)
    IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
end

function IllegalLabsAndWarehouse.MENUS.DRUGLAB.GenerateValues(values)

    local maxValue = math.tointeger(values)
    local availableValues = {0}

    for i = 1, values, 1 do
        table.insert(availableValues, i)
    end

    return availableValues
end

function IllegalLabsAndWarehouse.MENUS.DRUGLAB.UpdateInteriorIPL()
    if (IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id == "meth") then
      IllegalLabsAndWarehouse.MENUS.DRUGLAB.UpdateIPLForMeth(IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level, IllegalLabsAndWarehouse.CURRENT_PROPERTY.security_level)
    elseif (IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id == "lsd" or IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id == "cocaine") then 
      IllegalLabsAndWarehouse.MENUS.DRUGLAB.UpdateIPLForCocaineAndLSD(IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level, IllegalLabsAndWarehouse.CURRENT_PROPERTY.security_level)
    elseif (IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id == "weed") then
      IllegalLabsAndWarehouse.MENUS.DRUGLAB.UpdateIPLForCannabis(IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level, IllegalLabsAndWarehouse.CURRENT_PROPERTY.security_level)
    else
        ShowNotification("Cette drogue n'est pas connue.")
    end
end

function IllegalLabsAndWarehouse.MENUS.DRUGLAB.UpdateIPLForMeth(productionLevel, securityLevel)
  Citizen.CreateThread(function()
      -- Getting the object to interact with
      BikerMethLab = exports['Ora_dep']:GetBikerMethLabObject()

      if (productionLevel > 2 ) then
          -- Setting the style
          BikerMethLab.Style.Set(BikerMethLab.Style.upgrade)
      else
          -- Setting the style
          BikerMethLab.Style.Set(BikerMethLab.Style.basic)
      end

      if (securityLevel > 0) then
          -- Setting the security
          BikerMethLab.Security.Set(BikerMethLab.Security.upgrade)
      else
          -- Setting the security
          BikerMethLab.Security.Set(BikerMethLab.Security.none)
      end
      -- Enabling product packages
      BikerMethLab.Details.Enable(BikerMethLab.Details.production, true)
          
      -- Refreshing the interior to the see the result
      RefreshInterior(BikerMethLab.interiorId)
  end)
end

function IllegalLabsAndWarehouse.MENUS.DRUGLAB.UpdateIPLForCannabis(productionLevel, securityLevel)
  Citizen.CreateThread(function()
      -- Getting the object to interact with
     -- Getting the object to interact with
      BikerWeedFarm = exports['Ora_dep']:GetBikerWeedFarmObject()
      if (productionLevel > 2 ) then
          -- Setting the style
            BikerWeedFarm.Style.Set(BikerWeedFarm.Style.upgrade)
            BikerWeedFarm.Details.Enable({BikerWeedFarm.Details.production, BikerWeedFarm.Details.drying}, true)
            BikerWeedFarm.Details.Enable(BikerWeedFarm.Details.chairs, false)        
            BikerWeedFarm.Plant1.Light.Set(BikerWeedFarm.Plant1.Light.upgrade)
            BikerWeedFarm.Plant2.Light.Set(BikerWeedFarm.Plant1.Light.upgrade)
            BikerWeedFarm.Plant3.Light.Set(BikerWeedFarm.Plant1.Light.upgrade)
            BikerWeedFarm.Plant4.Light.Set(BikerWeedFarm.Plant1.Light.upgrade)
            BikerWeedFarm.Plant5.Light.Set(BikerWeedFarm.Plant1.Light.upgrade)
            BikerWeedFarm.Plant6.Light.Set(BikerWeedFarm.Plant1.Light.upgrade)
            BikerWeedFarm.Plant7.Light.Set(BikerWeedFarm.Plant1.Light.upgrade)
            BikerWeedFarm.Plant8.Light.Set(BikerWeedFarm.Plant1.Light.upgrade)
            BikerWeedFarm.Plant9.Light.Set(BikerWeedFarm.Plant1.Light.upgrade)
            BikerWeedFarm.Plant1.Hose.Enable(false)
            BikerWeedFarm.Plant2.Hose.Enable(false)
            BikerWeedFarm.Plant3.Hose.Enable(false)
            BikerWeedFarm.Plant4.Hose.Enable(false)
            BikerWeedFarm.Plant5.Hose.Enable(false)
            BikerWeedFarm.Plant6.Hose.Enable(false)
            BikerWeedFarm.Plant7.Hose.Enable(false)
            BikerWeedFarm.Plant8.Hose.Enable(false)
            BikerWeedFarm.Plant9.Hose.Enable(false)
      else
          -- Setting the style
            BikerWeedFarm.Style.Set(BikerWeedFarm.Style.basic)
            BikerWeedFarm.Details.Enable({BikerWeedFarm.Details.chairs, BikerWeedFarm.Details.drying}, false)
            BikerWeedFarm.Details.Enable({BikerWeedFarm.Details.production, BikerWeedFarm.Details.fans}, true)
            BikerWeedFarm.Plant1.Light.Set(BikerWeedFarm.Plant1.Light.basic)
            BikerWeedFarm.Plant2.Light.Set(BikerWeedFarm.Plant1.Light.basic)
            BikerWeedFarm.Plant3.Light.Set(BikerWeedFarm.Plant1.Light.basic)
            BikerWeedFarm.Plant4.Light.Set(BikerWeedFarm.Plant1.Light.basic)
            BikerWeedFarm.Plant5.Light.Set(BikerWeedFarm.Plant1.Light.basic)
            BikerWeedFarm.Plant6.Light.Set(BikerWeedFarm.Plant1.Light.basic)
            BikerWeedFarm.Plant7.Light.Set(BikerWeedFarm.Plant1.Light.basic)
            BikerWeedFarm.Plant8.Light.Set(BikerWeedFarm.Plant1.Light.basic)
            BikerWeedFarm.Plant9.Light.Set(BikerWeedFarm.Plant1.Light.basic)
            BikerWeedFarm.Plant1.Hose.Enable(false)
            BikerWeedFarm.Plant2.Hose.Enable(false)
            BikerWeedFarm.Plant3.Hose.Enable(false)
            BikerWeedFarm.Plant4.Hose.Enable(false)
            BikerWeedFarm.Plant5.Hose.Enable(false)
            BikerWeedFarm.Plant6.Hose.Enable(false)
            BikerWeedFarm.Plant7.Hose.Enable(false)
            BikerWeedFarm.Plant8.Hose.Enable(false)
            BikerWeedFarm.Plant9.Hose.Enable(false)
      end

      if (securityLevel > 0) then
          -- Setting the security
          BikerWeedFarm.Security.Set(BikerWeedFarm.Security.upgrade)
      else
          -- Setting the security
          BikerWeedFarm.Security.Set(BikerWeedFarm.Security.basic)
      end

      BikerWeedFarm.Plant1.Clear(false)
      BikerWeedFarm.Plant2.Clear(false)
      BikerWeedFarm.Plant3.Clear(false)
      BikerWeedFarm.Plant4.Clear(false)
      BikerWeedFarm.Plant5.Clear(false)
      BikerWeedFarm.Plant6.Clear(false)
      BikerWeedFarm.Plant7.Clear(false)
      BikerWeedFarm.Plant8.Clear(false)
      BikerWeedFarm.Plant9.Clear(false)

      -- Refreshing the interior to the see the result
      RefreshInterior(BikerWeedFarm.interiorId)
  end)
end

function IllegalLabsAndWarehouse.MENUS.DRUGLAB.UpdateIPLForCocaineAndLSD(productionLevel, securityLevel)
  Citizen.CreateThread(function()
      -- Getting the object to interact with
      BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()

      if (productionLevel > 2) then
          -- Setting the style
          BikerCocaine.Style.Set(BikerCocaine.Style.upgrade)
          BikerCocaine.Details.Enable({BikerCocaine.Details.cokeUpgrade1, BikerCocaine.Details.cokeUpgrade2}, true)
          BikerCocaine.Details.Enable({BikerCocaine.Details.cokeBasic1, BikerCocaine.Details.cokeBasic2, BikerCocaine.Details.cokeBasic3}, false)
      else
          -- Setting the style
          BikerCocaine.Style.Set(BikerCocaine.Style.basic)
          BikerCocaine.Details.Enable({BikerCocaine.Details.cokeUpgrade1, BikerCocaine.Details.cokeUpgrade2}, false)
          BikerCocaine.Details.Enable({BikerCocaine.Details.cokeBasic1, BikerCocaine.Details.cokeBasic2, BikerCocaine.Details.cokeBasic3}, true)
      end

      if (securityLevel > 0) then
          -- Setting the security
          BikerCocaine.Security.Set(BikerCocaine.Security.upgrade)
      else
          -- Setting the security
          BikerCocaine.Security.Set(BikerCocaine.Security.none)
      end

      -- Refreshing the interior to the see the result
      RefreshInterior(BikerCocaine.interiorId)
  end)
end

function IllegalLabsAndWarehouse.CreatePayement()
    exports['Snoupinput']:ShowInput("Titre du paiement", 50, "text", "Paiement labo", true)
    local title = exports['Snoupinput']:GetInput()
    exports['Snoupinput']:ShowInput("Type de paiement (supprimez le mauvais et le /)", 30, "text", "propre", true)
    local type = exports['Snoupinput']:GetInput()
    exports['Snoupinput']:ShowInput("Montant du paiement", 30, "number", nil, true)
    local amount = tonumber(exports['Snoupinput']:GetInput())

    if (not title or not type or not amount or (type ~= "propre" and type ~= "sale") or amount <= 0) then
        return RageUI.Popup({message = '~r~Vous devez indiquer un titre, un type "propre" ou "sale" et un montant supérieur à 0'})
    end

    if (type == "propre") then
        dataonWait = {
            title = title,
            price = amount,
            isLimited = false,
            fct = function()
                TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", amount, true)
                RageUI.Popup({message = string.format('~g~Paiement "%s" de $%s effectué en argent %s', title, amount, type)})
                TriggerServerEvent(
                    "Ora:sendToDiscord",
                    23,
                    string.format('%s a effectué un paiement "%s" de $%s en argent %s', Ora.Identity:GetMyName(), title, amount, type),
                    "info"
                )
            end
        }
        TriggerEvent("payByCash")
    elseif (type == "sale") then
        dataonWait = {
            title = title,
            price = amount,
            fct = function()
                TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", amount, true)
                RageUI.Popup({message = string.format('~g~Paiement "%s" de $%s effectué en argent %s', title, amount, type)})
                TriggerServerEvent(
                    "Ora:sendToDiscord",
                    23,
                    string.format('%s a effectué un paiement "%s" de $%s en argent %s', Ora.Identity:GetMyName(), title, amount, type),
                    "info"
                )
            end
        }
        TriggerEvent("payByFakeCash")
    end
end


-- Handle Menu Options
Citizen.CreateThread(function()
  while (true) do
      Wait(0)

      if RageUI.Visible(RMenu:Get("illeg_property_druglab_work","main")) then
        RageUI.DrawContent({ header = true, glare = false }, function()
            if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS == true) then
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

                if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT ~= nil and IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT.id ~= nil) then
                    if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT.status == "waiting_delivery") then
                        RageUI.Button("~g~[TERMINE]~s~ Récupérer votre production", "", {}, true, 
                            function(Hovered, Active, Selected)
                                if Selected then

                                    if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT_ID == nil) then
                                        ShowNotification("~r~Veuillez vous placer dans le point à la table~s~")
                                        RageUI.CloseAll()
                                    else
                                        local packet = {
                                            PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY, 
                                            WORKPLACE_ID = IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT_ID,
                                            CURRENT_PRODUCTION = IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT
                                        }
    
                                        TriggerServerEvent(
                                            "Ora::Illegal:retrieveProductionFromWorkplaceQueue", 
                                            json.encode(packet)
                                        )
                                        RageUI.GoBack()
                                    end
                                end
                            end
                        )
                    else
                        local remainingMinutes = math.ceil((IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT.scheduled_at - IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT.current_time) / 60)

                        RageUI.Button("~b~[EN COURS]~s~ En production", "", {RightLabel = "~y~".. remainingMinutes .." minutes~s~"}, true, 
                            function(Hovered, Active, Selected)
                                if Selected then
                                end
                            end
                        )
                    end
                else
                    RageUI.Button("Lancer une production", "Lancer une production de drogue.\n\n" .. IllegalLabsAndWarehouse.GetNeededMaterialLabelsForDrug(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id, IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level), {RightLabel = "~b~" .. IllegalLabsAndWarehouse.GetNeededTimeForDrug(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id, IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level) .. " minutes~s~"}, true, 
                        function(Hovered, Active, Selected)
                            if Selected then
                                local neededMaterials = IllegalLabsAndWarehouse.GetNeededMaterialForDrug(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id, IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level)
                                local hasOneMissing = false
                                local timeNeeded = IllegalLabsAndWarehouse.GetNeededTimeForDrug(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id, IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level)

                                for neededMaterialIndex, neededMaterialValue in pairs(neededMaterials) do
                                    if (neededMaterialValue.name ~= nil and neededMaterialValue.count ~= nil) then
                                        if Ora.Inventory:GetItemCount(neededMaterialValue.name) >= neededMaterialValue.count then
                                            ShowNotification(
                                                "~b~" ..
                                                    Items[neededMaterialValue.name].label ..
                                                        "~s~ : ~g~" ..
                                                            Ora.Inventory:GetItemCount(neededMaterialValue.name) .. "/" .. neededMaterialValue.count .. "~s~"
                                            )
                                        else
                                            ShowNotification(
                                                "~b~" ..
                                                    Items[neededMaterialValue.name].label ..
                                                        "~s~ : ~r~" ..
                                                            Ora.Inventory:GetItemCount(neededMaterialValue.name) .. "/" .. neededMaterialValue.count .. "~s~"
                                            )
                                            hasOneMissing = true
                                        end
                                    else
                                        print("^1[ERROR] No name and count for material in business_id " ..  IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)
                                    end
                                end

                                if (hasOneMissing == false) then
                                    if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT_ID ~= nil) then
                                        local packet = {
                                            PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY, 
                                            WORKPLACE_ID = IllegalLabsAndWarehouse.MENUS.DRUGLAB.WORKPLACE.CURRENT_ID,
                                            TIME = timeNeeded,
                                            PRODUCTION = {
                                                item_name = IllegalLabsAndWarehouse.GetGiveItemForBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id),
                                                count = IllegalLabsAndWarehouse.GetGiveItemCountBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id),
                                                quality = IllegalLabsAndWarehouse.GetDrugQualityForBusinessIdAndProductionLevel(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id, IllegalLabsAndWarehouse.CURRENT_PROPERTY.production_level)
                                            },
                                            NEEDED_MATERIALS = neededMaterials
                                        }
    
                                        TriggerServerEvent(
                                            "Ora::Illegal:createPropertyWorkplaceQueue", 
                                            json.encode(packet)
                                        )
                                        RageUI.GoBack()
                                    else
                                        ShowNotification("~r~Veuillez vous placer dans le point de production pour lancer cette action.~s~")
                                        RageUI.CloseAll()
                                    end
                                else
                                    ShowNotification("~r~il vous manque des composants pour lancer la production.~s~")
                                end

                            end
                        end
                    )
                end

            end
        end)
    end
      

      if RageUI.Visible(RMenu:Get("illeg_property_druglab_main","illeg_property_druglab_security")) then
        RageUI.DrawContent({ header = true, glare = false }, function()
            if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS == true) then
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
                                    IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = true
                                    exports['Snoupinput']:ShowInput("Type de paiement (supprimez le mauvais et le /) | " .. math.floor(Ora.Illegal.FakeMoneyTax * 100) .. "% du prix initial en argent sale", 30, "text", "propre", true)
                                    local type = exports['Snoupinput']:GetInput()

                                    if (type and type == "propre") then
                                        RageUI.CloseAll()

                                        dataonWait = {
                                            title = "Achat matériels",
                                            price = value.price,
                                            isLimited = false,
                                            fct = function()
                                                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                                                TriggerServerEvent("Ora::Illegal:updateSecurityLevel", { PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY, LEVEL = index })
                                                TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", value.price, true)
                                            end
                                        }
    
                                        TriggerEvent("payWith?")
                                    elseif (type and type == "sale") then
                                        RageUI.CloseAll()

                                        dataonWait = {
                                            title = "Achat matériels",
                                            price = math.ceil(value.price * Ora.Illegal.FakeMoneyTax),
                                            isLimited = false,
                                            fct = function()
                                                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                                                TriggerServerEvent("Ora::Illegal:updateSecurityLevel", { PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY, LEVEL = index })
                                                TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", math.ceil(value.price * Ora.Illegal.FakeMoneyTax), true)
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

    if RageUI.Visible(RMenu:Get("illeg_property_druglab_main","illeg_property_druglab_production")) then
        RageUI.DrawContent({ header = true, glare = false }, function()
            if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS == true) then
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
                                    IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = true
                                    exports['Snoupinput']:ShowInput("Type de paiement (supprimez le mauvais et le /) | " .. math.floor(Ora.Illegal.FakeMoneyTax * 100) .. "% du prix initial en argent sale", 30, "text", "propre", true)
                                    local type = exports['Snoupinput']:GetInput()

                                    if (type and type == "propre") then
                                        RageUI.CloseAll()

                                        dataonWait = {
                                            title = "Achat matériels",
                                            price = value.price,
                                            isLimited = false,
                                            fct = function()
                                                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                                                TriggerServerEvent("Ora::Illegal:updateProductionLevel", { PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY, LEVEL = index })
                                                TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", value.price, true)
                                            end
                                        }
    
                                        TriggerEvent("payWith?")
                                    elseif (type and type == "sale") then
                                        RageUI.CloseAll()

                                        dataonWait = {
                                            title = "Achat matériels",
                                            price = math.ceil(value.price * Ora.Illegal.FakeMoneyTax),
                                            isLimited = false,
                                            fct = function()
                                                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                                                TriggerServerEvent("Ora::Illegal:updateProductionLevel", { PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY, LEVEL = index })
                                                TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "illegalaccount", math.ceil(value.price * Ora.Illegal.FakeMoneyTax), true)
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

    if RageUI.Visible(RMenu:Get("illeg_property_druglab_main","illeg_property_druglab_new_order")) then
        RageUI.DrawContent({ header = true, glare = false }, function()
            if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS == true) then
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

                for index, value in pairs(IllegalLabsAndWarehouse.GetIngredientsForBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)) do
                    if (Items[index] ~= nil) then
                        if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES[index] == nil) then
                            IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES[index] = {}
                            IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES[index].CURRENT_INDEX = 1
                            IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES[index].PRICE = 0
                        end

                        IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES[index].VALUES = IllegalLabsAndWarehouse.MENUS.DRUGLAB.GenerateValues(value.max_qty) 

                        if (value.max_qty > 0) then
                            RageUI.List(
                                "~h~~b~ " .. Items[index].label.. " - ~r~("..value.price .."$/u)~s~~h~~s~",
                                IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES[index].VALUES,
                                IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES[index].CURRENT_INDEX,
                                nil,
                                {},
                                true,
                                function(_, Active, Selected, Index)
                                    IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES[index].CURRENT_INDEX = Index
                                    IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES[index].PRICE = (Index - 1) * value.price  
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
                for eltIndex, eltValue in pairs(IllegalLabsAndWarehouse.GetIngredientsForBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)) do
                    if (Items[eltIndex] ~= nil) then
                        totalPrice = totalPrice + IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES[eltIndex].PRICE
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
                                IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = true
                                local deliveryPositions = IllegalLabsAndWarehouse.GetDeliveryPositionsForBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)
                                local deliveryPosition = deliveryPositions[math.random(1, #deliveryPositions)]

                                local quote = {
                                    ITEMS = IllegalLabsAndWarehouse.MENUS.DRUGLAB.INDEXES,
                                    PROPERTY = IllegalLabsAndWarehouse.CURRENT_PROPERTY,
                                    TOTAL_PRICE = totalPrice,
                                    DELIVERY_POSITION = deliveryPosition,
                                    NO_LIMIT = true,
                                }

                                ShowNotification("~b~Commande en cours de ~h~vérification~h~. Veuillez patienter.~s~")
                                dataonWait = {
                                    title = "Achat inconnu",
                                    price = totalPrice,
                                    isLimited = false,
                                    fct = function()
                                        IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS = false
                                        TriggerServerEvent("Ora:Illegal:registerOrder", quote)
                                    end
                                }
                                TriggerEvent("payWith?")
                            end
                        end
                    end
                )
            end
        end)
    end

    if RageUI.Visible(RMenu:Get("illeg_property_druglab_main","illeg_property_druglab_order_history")) then
        RageUI.DrawContent({ header = true, glare = false }, function()

            if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS == true) then
                RageUI.GoBack()
                Wait(10)
            end

            local orderHistory = IllegalLabsAndWarehouse.MENUS.DRUGLAB.LoadOrderHistory(IllegalLabsAndWarehouse.CURRENT_PROPERTY.id)

            
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
                        IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER = value
                    end
                    end, 
                    RMenu:Get("illeg_property_druglab_main", "illeg_property_druglab_show_order")
                )
            end
        end)
    end

    
    if RageUI.Visible(RMenu:Get("illeg_property_druglab_main","illeg_property_druglab_show_order")) then
        RageUI.DrawContent({ header = true, glare = false }, function()

            if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS == true) then
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

            for index, value in pairs(IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER.order_detail) do
                if (Items[index] ~= nil and value.qty > 0) then
                    RageUI.Button("~h~~r~" .. value.qty .. "x ~b~" .. Items[index].label .. "~s~~h~", nil, {RightLabel = "~h~~g~" .. value.price .. "$~s~~h~"}, true, 
                        function(Hovered, Active, Selected)
                        end
                    )
                end
            end

            if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER.status == "waiting_delivery") then
                
                RageUI.CenterButton(
                    "~h~~b~----------------~h~~s~",
                    nil,
                    {},
                    true,
                    function(_, _, _)
                    end
                )

                RageUI.CenterButton(
                    "~h~~g~Récéptionner la commande #"..IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER.id.."~h~~s~",
                    nil,
                    {},
                    true,
                    function(_, _, Selected)
                        if (Selected) then
                            
                            TriggerServerCallback(
                                "Ora::SE::Service:GetTotalServiceCountForJobs",
                                function(numberOfPolice)
                                    if (numberOfPolice >= Ora.Illegal:GetCopsRequired("drugcomponent")) then
                                        local deliveryPosition = IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER.delivery_position
                                        TriggerServerEvent("AM::Illegal:addPhone", IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER.phone, "Ora::Illegal:Gunleader:GetOrder")
                                        TriggerServerEvent("Ora::Illegal:sendMessageToOrga", IllegalLabsAndWarehouse.CURRENT_PROPERTY.organisation_id, "Réception d'ingrédients : Une fois sur place, appelez le ~h~" .. IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER.phone)
                                        TriggerServerEvent("Ora::Illegal:sendMessageToOrga", IllegalLabsAndWarehouse.CURRENT_PROPERTY.organisation_id, "Réception d'ingrédients : Rendez vous au lieu d'échange. Une fois sur place")
                                        TriggerServerEvent("Ora::Illegal:setCoordsToOrga", IllegalLabsAndWarehouse.CURRENT_PROPERTY.organisation_id, deliveryPosition.finish)
                                        TriggerServerEvent(
                                            "Ora:sendToDiscord",
                                            21,
                                            "[COMMANDE #" .. IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER.id .. "]\nCréé le rendez vous pour receptionner les ingrédients. (Num a appeler : " .. IllegalLabsAndWarehouse.MENUS.DRUGLAB.HISTORY.CURRENT_ORDER.phone ..")", 
                                            "info"
                                        )
                                    else
                                        TriggerServerEvent("Ora::Illegal:sendMessageToOrga", IllegalLabsAndWarehouse.CURRENT_PROPERTY.organisation_id, "Réception d'ingrédients : Je n'ai pas encore assez d'hommes. Rappelle plus tard")
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

    -- Main menu
    if RageUI.Visible(RMenu:Get("illeg_property_druglab_main","main")) then
        RageUI.DrawContent({ header = true, glare = false }, function()

            if (IllegalLabsAndWarehouse.MENUS.DRUGLAB.PAYMENT_PROCESS == true) then
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

                RageUI.Button("Passer une commande de fournitures", "Vous permet d'acceder à la commande de fourniture", {}, true, function(Hovered, Active, Selected)
                    end, 
                    RMenu:Get("illeg_property_druglab_main", "illeg_property_druglab_new_order")
                )

                RageUI.Button("Receptionner mes commandes", "Visualiser mon historique de commandes", {}, true, function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end, 
                    RMenu:Get("illeg_property_druglab_main", "illeg_property_druglab_order_history")
                )

                RageUI.CenterButton(
                    "~h~~b~----------------~h~~s~",
                    nil,
                    {},
                    true,
                    function(_, _, _)
                    end
                )

                RageUI.Button("Gestion propriété : Sécurité", "Gérer la sécurité de votre labo", {}, true, function(Hovered, Active, Selected)
                    end, 
                    RMenu:Get("illeg_property_druglab_main", "illeg_property_druglab_security")
                )

                RageUI.Button("Gestion propriété : Production", "Gérer la production de votre labo", {}, true, function(Hovered, Active, Selected)
                    end, 
                    RMenu:Get("illeg_property_druglab_main", "illeg_property_druglab_production")
                )
            end
      end)
    end

  end
end)