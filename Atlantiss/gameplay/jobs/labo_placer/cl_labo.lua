IllegalAdminMenu = {}

IllegalAdminMenu.CURRENT_BLIPS = {}
IllegalAdminMenu.CURRENT_ZONES = {}
IllegalAdminMenu.PROPERTY_LIST = {}

IllegalAdminMenu.CURRENT_MENU_OPENED = nil
IllegalAdminMenu.CURRENT_PROPERTY_EDIT = {}
IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION ={}
IllegalAdminMenu.CURRENT_DRUG_INDEX = 1
IllegalAdminMenu.CURRENT_WAREHOUSE_INDEX = 1
IllegalAdminMenu.CURRENT_WAREHOUSE_SELECTED = nil
IllegalAdminMenu.CURRENT_DRUG_SELECTED = nil
IllegalAdminMenu.FACTIONS = {}
IllegalAdminMenu.FACTIONS.LOADED = false
IllegalAdminMenu.FACTIONS.LIST = {}

local function resetProperty()
  IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION = {}
  IllegalAdminMenu.CURRENT_DRUG_INDEX = 1
  IllegalAdminMenu.CURRENT_WAREHOUSE_INDEX = 1
end

RMenu.Add("illeg_admin_menuperso", "main", RageUI.CreateMenu("Référent Illégal", "Actions disponibles", 10, 50))
RMenu.Add("illeg_admin_menuproperty", "main", RageUI.CreateMenu("Configuration Propriété", "Actions disponibles", 10, 50))

RMenu.Add("illeg_admin_menuperso", "illeg_drug_lab_create", RageUI.CreateSubMenu(RMenu:Get("illeg_admin_menuperso", "main"), "Laboratoire de drogue", "Listes"))
RMenu.Add("illeg_admin_menuperso", "illeg_weapon_warehouse_create", RageUI.CreateSubMenu(RMenu:Get("illeg_admin_menuperso", "main"), "Dépot d'armes", "Listes"))
RMenu.Add("illeg_admin_menuperso", "illeg_property_manage", RageUI.CreateSubMenu(RMenu:Get("illeg_admin_menuperso", "main"), "Gérer la propriété", "Listes"))
RMenu.Add("illeg_admin_menuproperty", "illeg_admin_menuproperty_info", RageUI.CreateSubMenu(RMenu:Get("illeg_admin_menuproperty", "main"), "Informations", "Listes"))
RMenu.Add("illeg_admin_menuproperty", "illeg_admin_menuproperty_assign", RageUI.CreateSubMenu(RMenu:Get("illeg_admin_menuproperty", "main"), "Assigner une faction", "Listes"))

function initAdminDrugMenu()
  Citizen.CreateThread(function()
    if Atlantiss.Identity.Orga:Get().label == "Référent Illégal" then
      KeySettings:Add("keyboard","F7",function()
        RageUI.Visible(RMenu:Get("illeg_admin_menuperso", "main"), true)
      end,"admin_drug")
    end

    if Atlantiss.Identity.Job:Get().label == "Référent Illégal" then
      KeySettings:Add("keyboard","F6",function()
        RageUI.Visible(RMenu:Get("illeg_admin_menuperso", "main"), true)
      end,"admin_drug")
    end
  end)

  TriggerServerEvent("Atlantiss:Illegal:SyncProperties")
end

function IllegalAdminMenu.PopulateCurrentEditProperty(propertyName)
  if (#IllegalAdminMenu.CURRENT_PROPERTY_EDIT == 0) then
    local canSend = false
    
    TriggerServerCallback("Atlantiss:Illegal:getPropertyByName", 
        function(property)
            IllegalAdminMenu.CURRENT_PROPERTY_EDIT = property
            canSend = true
        end, 
        propertyName
    )
    
    while (canSend == false) do
      Wait(100)      
    end

    return IllegalAdminMenu.CURRENT_PROPERTY_EDIT
  else
    return IllegalAdminMenu.CURRENT_PROPERTY_EDIT
  end
end

function IllegalAdminMenu.OpenPropertyMenu()
    IllegalAdminMenu.CURRENT_PROPERTY_EDIT = IllegalAdminMenu.PopulateCurrentEditProperty(IllegalAdminMenu.CURRENT_MENU_OPENED)
    RageUI.Visible(RMenu:Get("illeg_admin_menuproperty","main"), true)
end

function IllegalAdminMenu.PropertyMenuEnter(zone)
  Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour configurer la propriété")
  IllegalAdminMenu.CURRENT_MENU_OPENED = zone
  IllegalAdminMenu.CURRENT_PROPERTY_EDIT = {}
  IllegalAdminMenu.FACTIONS.LOADED = false
  IllegalAdminMenu.FACTIONS.LIST = {}
  KeySettings:Add("keyboard", "E", IllegalAdminMenu.OpenPropertyMenu, "IllegalProperty")
  KeySettings:Add("controller", 46, IllegalAdminMenu.OpenPropertyMenu, "IllegalProperty")
end

function IllegalAdminMenu.PropertyMenuExit()
    if IllegalAdminMenu.CURRENT_MENU_OPENED ~= nil then
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", "IllegalProperty")

        if RageUI.Visible(RMenu:Get("illeg_admin_menuproperty","main")) then
            RageUI.GoBack()
            RageUI.Visible(RMenu:Get("illeg_admin_menuperso","illeg_property_manage"), false)
        elseif RageUI.Visible(RMenu:Get("illeg_admin_menuproperty","illeg_admin_menuproperty_info")) then
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()
            RageUI.Visible(RMenu:Get("illeg_admin_menuproperty","illeg_admin_menuproperty_info"), false)
        elseif RageUI.Visible(RMenu:Get("illeg_admin_menuproperty","illeg_admin_menuproperty_assign")) then
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()
            RageUI.Visible(RMenu:Get("illeg_admin_menuproperty","illeg_admin_menuproperty_assign"), false)
        end

        IllegalAdminMenu.CURRENT_MENU_OPENED = nil
        IllegalAdminMenu.CURRENT_PROPERTY_EDIT = {}
        IllegalAdminMenu.FACTIONS.LOADED = false
        IllegalAdminMenu.FACTIONS.LIST = {}

    end
end

-- Handle Menu Options
Citizen.CreateThread(function()
    while (true) do
        Wait(0)

        -- Main menu
        if RageUI.Visible(RMenu:Get("illeg_admin_menuperso","main")) then
          resetProperty()
          RageUI.DrawContent({ header = true, glare = false }, function()
            
            RageUI.Button("Créer un labo de drogue", "Créer un labo de drogue", {}, true, function(Hovered, Active, Selected)
                if Selected then
                end
              end, 
              RMenu:Get("illeg_admin_menuperso", "illeg_drug_lab_create")
            )

            RageUI.Button("Créer un dépot d'armes", "Créer un dépot d'armes", {}, true, function(Hovered, Active, Selected)
                if Selected then
                end
              end, 
              RMenu:Get("illeg_admin_menuperso", "illeg_weapon_warehouse_create")
            )
            
            RageUI.Button("Actualiser les propriétés", "Actualiser la liste des propriétés", {}, true, function(Hovered, Active, Selected)
              if Selected then
                TriggerServerEvent("Atlantiss:Illegal:SyncProperties")
                ShowNotification("~g~Liste des propriétés ~h~illégales~h~ mises à jours~s~")
              end
            end
            )

            RageUI.Button("Effectuer un paiement", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                  IllegalLabsAndWarehouse.CreatePayement()
                end
              end
            )
          end)
        end

        -- Drug Lab
        if RageUI.Visible(RMenu:Get("illeg_admin_menuperso","illeg_drug_lab_create")) then
          RageUI.DrawContent({ header = true, glare = false }, function()

            if IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR ~= nil then
              DrawMarker(25, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.x, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.y, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 4, 117, 125, 100)
            end

            local labelInputName = "Nom du labo: "
              if (IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.NAME ~= nil) then
                  labelInputName = labelInputName .. " " .. IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.NAME
              end

              RageUI.Button(labelInputName, "Nom d'identification du labo", {}, true, function(Hovered, Active, Selected)
                  if Selected then
                      name = KeyboardInput("~b~Nom du labo", nil, 255)
                      if name ~= nil then
                        IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.NAME  = name
                      end                 
                  end
            end) 

            RageUI.Button("Placer l'entrée", "Entrée du Laboratoire de drogue", {}, true, function(Hovered, Active, Selected)
                if Active then
                  if IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR == nil then
                    coords = LocalPlayer().Pos
                    DrawMarker(25, coords.x, coords.y, coords.z-0.95, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 4, 117, 125, 100)
                  else
                    DrawMarker(25, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.x, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.y, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 4, 117, 125, 100)
                  end
                end

                if Selected then
                  coords = LocalPlayer().Pos                  
                  IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR = vector3(coords.x, coords.y, coords.z - 0.95)
                end
            end) 

            local availableDrugsLabel, availableDrugsIdentifier = IllegalLabsAndWarehouse.GetAvailableDrugsLabel()

            RageUI.List(
                "Type de drogue",
                availableDrugsLabel,
                IllegalAdminMenu.CURRENT_DRUG_INDEX,
                IllegalLabsAndWarehouse.GetAvailableDrugs()[availableDrugsIdentifier[IllegalAdminMenu.CURRENT_DRUG_INDEX]].description,
                {},
                true,
                function(_, _, Selected, Index)
                    IllegalAdminMenu.CURRENT_DRUG_INDEX = Index
                    IllegalAdminMenu.CURRENT_DRUG_SELECTED = availableDrugsIdentifier[Index]
                    IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.BUSINESS_ID = availableDrugsIdentifier[Index]
                    IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.LIMITATION = IllegalLabsAndWarehouse.GetLimitationsByBusinessId(IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.BUSINESS_ID)
                    if Selected then
                    end
                end
            )

            RageUI.Button("Sauvegarder", "Créer le laboratoire de drogue", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    if IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR == nil then
                      ShowNotification("~h~~r~Erreur!~h~~s~\n~r~Vous n'avez pas placé d'entrée~s~")
                    else
                      ShowNotification("~h~~g~Succès!~h~~s~\n~g~Laboratoire de drogue créé.~s~")
                      ShowNotification("~h~~b~Info :~h~~s~\n~b~Utilisez Gérer les labo pour affecter une faction.~s~")
                      TriggerServerEvent("Atlantiss:Illegal:createProperty", "drug", IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION)
                    end
                end
            end)
          end)
        end

         -- Weapon Warehouse
         if RageUI.Visible(RMenu:Get("illeg_admin_menuperso","illeg_weapon_warehouse_create")) then
            RageUI.DrawContent({ header = true, glare = false }, function()
              
              if IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR ~= nil then
                DrawMarker(25, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.x, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.y, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 4, 117, 125, 100)
              end

              local labelInputName = "Nom du dépot: "
              if (IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.NAME ~= nil) then
                  labelInputName = labelInputName .. " " .. IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.NAME
              end

              RageUI.Button(labelInputName, "Nom d'identification du dépot", {}, true, function(Hovered, Active, Selected)
                  if Selected then
                      name = KeyboardInput("~b~Nom du dépot", nil, 255)
                      if name ~= nil then
                        IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.NAME  = name
                      end                 
                  end
            end) 


              RageUI.Button("Placer l'entrée", "Placer l'entrée de l'entrepot", {}, true, function(Hovered, Active, Selected)
                  if Active then
                    if IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR == nil then
                      coords = LocalPlayer().Pos
                      DrawMarker(25, coords.x, coords.y, coords.z-0.95, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 4, 117, 125, 100)
                    else
                      DrawMarker(25, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.x, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.y, IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 4, 117, 125, 100)
                    end
                  end

                  if Selected then
                    coords = LocalPlayer().Pos                  
                    IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR = vector3(coords.x, coords.y, coords.z - 0.95)
                  end
              end) 

              local availableGunleadsLabel, availableGunleadsIdentifier = IllegalLabsAndWarehouse.GetAvailableGunleadsLabel()
            
              RageUI.List(
                  "Type de gunlead",
                  availableGunleadsLabel,
                  IllegalAdminMenu.CURRENT_WAREHOUSE_INDEX,
                  IllegalLabsAndWarehouse.GetAvailableGunleads()[availableGunleadsIdentifier[IllegalAdminMenu.CURRENT_WAREHOUSE_INDEX]].description,
                  {},
                  true,
                  function(_, _, Selected, Index)
                      IllegalAdminMenu.CURRENT_WAREHOUSE_INDEX = Index
                      IllegalAdminMenu.CURRENT_WAREHOUSE_SELECTED = availableGunleadsIdentifier[Index]
                      IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.BUSINESS_ID = availableGunleadsIdentifier[Index]
                      IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.LIMITATION = IllegalLabsAndWarehouse.GetLimitationsByBusinessId(IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.BUSINESS_ID)
                      if Selected then
                      end
                  end
              )

              RageUI.Button("Sauvegarder", "Sauvegarder le dépot d'arme", {}, true, function(Hovered, Active, Selected)
                  if Selected then
                      if IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION.OUTSIDE_DOOR == nil then
                          ShowNotification("~h~~r~Erreur!~h~\n~r~Vous n'avez pas placé d'entrée~s~")
                      else
                          ShowNotification("~h~~g~Succès!~h~\n~g~Laboratoire dépot d'arme créé.~s~")
                          ShowNotification("~h~~b~Info :~h~\n~b~Utilisez Gérer les dépots pour affecter une faction.~s~")
                          TriggerServerEvent("Atlantiss:Illegal:createProperty", "weapon", IllegalAdminMenu.CURRENT_PROPERTY_CONFIGURATION)
                      end
                  end
              end)
            end)
        end

       
        if RageUI.Visible(RMenu:Get("illeg_admin_menuproperty","illeg_admin_menuproperty_info")) then
            RageUI.DrawContent({ header = true, glare = false }, function()

                if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.name ~= nil) then
                    RageUI.CenterButton(
                        "~b~↓↓↓ ~s~"..  IllegalAdminMenu.CURRENT_PROPERTY_EDIT.name .." ~b~↓↓↓",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end
                    )
                end


                
                RageUI.CenterButton(
                  "~r~↓↓↓ ~b~ Appartenance ~r~↓↓↓",
                  nil,
                  {},
                  true,
                  function(_, _, _)
                  end
              )

              local inputValue = "Aucune" 
              if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.business_name ~= nil) then
                inputValue = IllegalAdminMenu.CURRENT_PROPERTY_EDIT.business_name .. " (" .. IllegalAdminMenu.CURRENT_PROPERTY_EDIT.business_label .. ")"
              end

              RageUI.Button(
                "Faction Propriétaire :",
                nil,
                {RightLabel = inputValue},
                true,
                function(_, _, _)
                end
            )

              RageUI.CenterButton(
                  "~r~↓↓↓ ~b~ Informations ~r~↓↓↓",
                  nil,
                  {},
                  true,
                  function(_, _, _)
                  end
              )

              if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.type ~= nil) then
                  RageUI.Button(
                      "Type de propriété : ",
                      nil,
                      {RightLabel = IllegalLabsAndWarehouse.GetTypeLabel(IllegalAdminMenu.CURRENT_PROPERTY_EDIT.type)},
                      true,
                      function(_, _, _)
                      end
                  )
              end
             
              if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.business_id ~= nil) then
                  RageUI.Button(
                      "Business : ",
                      nil,
                      {RightLabel = IllegalLabsAndWarehouse.GetBusinessLabel(IllegalAdminMenu.CURRENT_PROPERTY_EDIT.business_id)},
                      true,
                      function(_, _, _)
                      end
                  )
              end

              if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.capacity ~= nil) then
                  RageUI.Button(
                      "Capacité coffre : ",
                      nil,
                      {RightLabel = IllegalLabsAndWarehouse.GetCapacityLabel(IllegalAdminMenu.CURRENT_PROPERTY_EDIT.capacity)},
                      true,
                      function(_, _, _)
                      end
                  )
              end

              if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.production_level ~= nil) then
                  RageUI.Button(
                      "Capacité de production : ",
                      nil,
                      {RightLabel = IllegalAdminMenu.CURRENT_PROPERTY_EDIT.production_level},
                      true,
                      function(_, _, _)
                      end
                  )
              end
             

              if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.security_level ~= nil) then
                  RageUI.Button(
                      "Niveau de sécurité : ",
                      nil,
                      {RightLabel = IllegalAdminMenu.CURRENT_PROPERTY_EDIT.security_level},
                      true,
                      function(_, _, _)
                      end
                  )
              end
            end)
        end

        if RageUI.Visible(RMenu:Get("illeg_admin_menuproperty","main")) then
            RageUI.DrawContent({ header = true, glare = false }, function()

              IllegalAdminMenu.FACTIONS.LOADED = false
              IllegalAdminMenu.FACTIONS.LIST = {}

              if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.name ~= nil) then
                  RageUI.CenterButton(
                        "~b~↓↓↓ ~s~"..  IllegalAdminMenu.CURRENT_PROPERTY_EDIT.name .." ~b~↓↓↓",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end
                    )
                end

                local inputValue = "Aucune" 
                if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.business_name ~= nil) then
                  inputValue = IllegalAdminMenu.CURRENT_PROPERTY_EDIT.business_name .. " (" .. IllegalAdminMenu.CURRENT_PROPERTY_EDIT.business_label .. ")"
                end

                RageUI.Button(
                    "Faction Propriétaire :",
                    nil,
                    {RightLabel = inputValue},
                    true,
                    function(_, _, _)
                    end
                )

                RageUI.CenterButton(
                    "~h~~b~----------------~h~~s~",
                    nil,
                    {},
                    true,
                    function(_, _, _)
                    end
                )
                
                RageUI.Button(
                    "~b~Détails sur la propriété",
                    nil,
                    {},
                    true,
                    function(_, _, _)
                    end,
                    RMenu:Get("illeg_admin_menuproperty", "illeg_admin_menuproperty_info")
                )

                if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.organisation_id == nil) then
                    RageUI.Button(
                        "~g~Attribuer la propriété",
                        nil,
                        {},
                        true,
                        function(_, _, _)
                        end,
                        RMenu:Get("illeg_admin_menuproperty", "illeg_admin_menuproperty_assign")
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

                if (IllegalAdminMenu.CURRENT_PROPERTY_EDIT.organisation_id ~= nil) then
                    RageUI.Button(
                        "~r~Expulser la faction : ~s~" .. IllegalAdminMenu.CURRENT_PROPERTY_EDIT.business_name .. " (" .. IllegalAdminMenu.CURRENT_PROPERTY_EDIT.business_label .. ")",
                        nil,
                        {},
                        true,
                        function(_, _, Selected)
                            if Selected then
                                TriggerServerEvent("Atlantiss:Illegal:DeleteFactionFromProperty", IllegalAdminMenu.CURRENT_PROPERTY_EDIT)
                            end
                        end
                    )
                end

                RageUI.Button(
                    "~r~Supprimer la propriété",
                    nil,
                    {},
                    true,
                    function(_, _, Selected)
                        if Selected then
                            TriggerServerEvent("Atlantiss:Illegal:DeleteProperty", IllegalAdminMenu.CURRENT_PROPERTY_EDIT)
                            Wait(10)
                            RageUI.GoBack()
                        end
                    end
                )

            end)
        end

        if RageUI.Visible(RMenu:Get("illeg_admin_menuproperty","illeg_admin_menuproperty_assign")) then
              RageUI.DrawContent({ header = true, glare = false }, function()
                    if (IllegalAdminMenu.FACTIONS.LOADED == false) then
                        IllegalAdminMenu.FACTIONS.LIST = IllegalOrga.GetAllFactions()
                        IllegalAdminMenu.FACTIONS.LOADED = true
                    end

                    for index, value in pairs(IllegalAdminMenu.FACTIONS.LIST) do
                        RageUI.Button(
                            value.label .. " - " .. value.name,
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    TriggerServerEvent("Atlantiss:Illegal:AssignProperty", IllegalAdminMenu.CURRENT_PROPERTY_EDIT, value)
                                    Wait(10)
                                    RageUI.GoBack()
                                end
                            end
                        )
                    end
              end)
        end


    end
end)

RegisterNetEvent("Atlantiss::Illegal:populateIllegalPropertyList")
AddEventHandler("Atlantiss::Illegal:populateIllegalPropertyList", function(propertyListAsJson)
    local canDisplay = false
    while Atlantiss.Player.HasLoaded == false do
      Wait(100)
    end

    if Atlantiss.Identity.Orga:Get().label == "Référent Illégal" then
      canDisplay = true
    end

    if Atlantiss.Identity.Job:Get().label == "Référent Illégal" then
      canDisplay = true
    end

    if (canDisplay == true) then
      local propertyList = json.decode(propertyListAsJson)
      IllegalAdminMenu.PROPERTY_LIST = propertyList
  
      for index, value in pairs(IllegalAdminMenu.CURRENT_BLIPS) do
            RemoveBlip(value)
      end
  
      for index, value in pairs(IllegalAdminMenu.CURRENT_ZONES) do
          Zone:Remove(value)
      end
  
      IllegalAdminMenu.CURRENT_BLIPS = {}
      IllegalAdminMenu.CURRENT_ZONES = {}
      
      for index, value in pairs(propertyList) do
          value.outside_door = json.decode(value.outside_door)
          if (value.business_label == nil) then
              value.business_label = "Libre"
          end
  
          if (value.business_name == nil) then
              value.business_name = "Vide"
          end
  
          local blip = AddBlipForCoord(value.outside_door.x, value.outside_door.y, value.outside_door.z)
          local labPos = vector3(value.outside_door.x, value.outside_door.y, value.outside_door.z)
          SetBlipSprite(blip, 543)
          SetBlipDisplay(blip, 4)
          SetBlipScale(blip, 0.8)
          SetBlipColour(blip, 66)
          SetBlipAsShortRange(blip, true)
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(value.name .. " (" .. value.business_label .. ")")
          EndTextCommandSetBlipName(blip)
          table.insert(IllegalAdminMenu.CURRENT_BLIPS, blip)
          table.insert(IllegalAdminMenu.CURRENT_ZONES, labPos)
          Zone:Add(labPos, IllegalAdminMenu.PropertyMenuEnter, IllegalAdminMenu.PropertyMenuExit, value.name, 2.5)
      end
    end
end)