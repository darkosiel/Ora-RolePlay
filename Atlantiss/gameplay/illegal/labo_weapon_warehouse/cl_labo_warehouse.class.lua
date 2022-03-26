IllegalLabsAndWarehouse = IllegalLabsAndWarehouse or {}

IllegalLabsAndWarehouse.CURRENT_PROPERTY_NAME = nil
IllegalLabsAndWarehouse.CURRENT_PROPERTY = {}
IllegalLabsAndWarehouse.MENUS = {}

function IllegalLabsAndWarehouse.RefreshCurrentWorkplaceByPropertyIdAndWorkplaceId(propertyId, workplaceId)
  local canSend = false
  local localWorkplaceQueue = {}
  TriggerServerCallback("Atlantiss:Illegal:GetWorkplaceQueueByPropertyIdAndWorkplaceId", function(workplaceQueueAsJson)
    localWorkplaceQueue = json.decode(workplaceQueueAsJson)
    canSend = true
  end, {PROPERTY_ID = propertyId, WORKPLACE_ID = workplaceId})
  
  while (canSend == false) do
    Wait(100)      
  end

  return localWorkplaceQueue
end

function IllegalLabsAndWarehouse.RefreshCurrentPropertyByName(propertyName)
    local canSend = false
    TriggerServerCallback("Atlantiss:Illegal:GetPropertyByName", function(property)
      IllegalLabsAndWarehouse.CURRENT_PROPERTY = property
      canSend = true
    end, propertyName)
    
    while (canSend == false) do
      Wait(100)      
    end

    return IllegalLabsAndWarehouse.CURRENT_PROPERTY
end

function IllegalLabsAndWarehouse.GetOrderLabel(orderStatus)
    if (IllegalLabsAndWarehouse.ORDER_STATUS[orderStatus] ~= nil) then
        return IllegalLabsAndWarehouse.ORDER_STATUS[orderStatus]
    end

    return "Inconnu"
end

function IllegalLabsAndWarehouse.RefreshCurrentPropertyById(propertyId)
    local canSend = false
    TriggerServerCallback("Atlantiss:Illegal:GetPropertyById", function(property)
      IllegalLabsAndWarehouse.CURRENT_PROPERTY = property
      canSend = true
    end, propertyId)
    
    while (canSend == false) do
      Wait(100)      
    end

    return IllegalLabsAndWarehouse.CURRENT_PROPERTY
end

--[[
  ********************************************************
  ********************************************************
  **************       INSTANCE PART       ***************
  ********************************************************
  ********************************************************

  * Methods related to teleporting, and markers mangements
  * for the instance

  ]]

  
  function IllegalLabsAndWarehouse.CreateCurrentPropertyStorage()
    local vaultCoords = IllegalLabsAndWarehouse.GetVaultPositionByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)  
    local Storage = Storage.New(IllegalLabsAndWarehouse.CURRENT_PROPERTY.name .. "_storage", IllegalLabsAndWarehouse.CURRENT_PROPERTY.capacity)
    Storage:LinkToPos(vaultCoords)
  end
  
  function IllegalLabsAndWarehouse.CreateCurrentPropertyManagement()
    if (IllegalLabsAndWarehouse.IsDrugType(IllegalLabsAndWarehouse.CURRENT_PROPERTY.type)) then
      IllegalLabsAndWarehouse.MENUS.DRUGLAB.CreateZones()
    else
      IllegalLabsAndWarehouse.MENUS.GUNLEAD.CreateZones()
    end
  end

  function IllegalLabsAndWarehouse.SetInteriorIPL()
    if (IllegalLabsAndWarehouse.IsDrugType(IllegalLabsAndWarehouse.CURRENT_PROPERTY.type)) then
      IllegalLabsAndWarehouse.MENUS.DRUGLAB.UpdateInteriorIPL()
    else
      -- No action for Weapon
    end
  end

    -- Called when pressed E in the outside door. 
    -- Will create the instance
  function IllegalLabsAndWarehouse.GoToInstance()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard", "E", "IllegalPropertyOrga")

      IllegalLabsAndWarehouse.CURRENT_PROPERTY = IllegalOrga.GetProperties()[IllegalLabsAndWarehouse.CURRENT_PROPERTY_NAME]
      local interiorCoords = IllegalLabsAndWarehouse.GetInteriorCoordsByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)

      TriggerServerCallback("Atlantiss::SE::Instance:EnterInstance", 
          function(canEnter)
            IllegalLabsAndWarehouse.TeleportToInsideDoor()
          end,
          IllegalLabsAndWarehouse.CURRENT_PROPERTY_NAME,
          {inside = interiorCoords, type = "illegal_property"}
      )
  end
  
   -- Called when pressed E in the inside door. 
    -- Will trigger the leave event from instance module
    -- Removes storage and management pos.
  function IllegalLabsAndWarehouse.ExitFromInstance()
      if (IllegalLabsAndWarehouse.CURRENT_PROPERTY_NAME == nil) then
        TriggerServerCallback("Atlantiss::SE::Instance:LeaveAllInstance", 
            function(canLeave)
              IllegalLabsAndWarehouse.TeleportToOutsideDoor()
            end
        )
      else
        TriggerServerCallback("Atlantiss::SE::Instance:LeaveInstance", 
            function(canLeave)
              IllegalLabsAndWarehouse.TeleportToOutsideDoor()
            end,
            IllegalLabsAndWarehouse.CURRENT_PROPERTY_NAME
        )
      end
  end
  
  -- Handler for instance creation. 
  RegisterNetEvent("Atlantiss::Illegal:ShowNotification")
  AddEventHandler(
      "Atlantiss::Illegal:ShowNotification",
      function(message)
          if message ~= nil then
              ShowNotification(message)
          end
      end
  )

  
   -- Called by the instance module and will teleport the player inside the instance
  function IllegalLabsAndWarehouse.TeleportToInsideDoor()
      local playerPed = LocalPlayer().Ped
      Citizen.CreateThread(
          function()

              local interiorCoords = IllegalLabsAndWarehouse.GetInteriorCoordsByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)
              DoScreenFadeOut(100)
              Atlantiss.Player:FreezePlayer(LocalPlayer().Ped, true)
              Atlantiss.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, true)

              while not IsScreenFadedOut() and
                  not IsInteriorReady(GetInteriorAtCoords(interiorCoords.x, interiorCoords.y, interiorCoords.z)) do
                  Citizen.Wait(50)
              end
  
              Atlantiss.Core:TeleportEntityTo(playerPed, vector3(interiorCoords.x, interiorCoords.y, interiorCoords.z), true)
              IllegalLabsAndWarehouse.SetInteriorIPL()

              Wait(100)
              Atlantiss.Player:FreezePlayer(LocalPlayer().Ped, false)
              Atlantiss.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, false)

              DoScreenFadeIn(100)
              DrawSub(IllegalLabsAndWarehouse.CURRENT_PROPERTY.name, 5000)
  
              IllegalLabsAndWarehouse.CreateCurrentPropertyStorage()
              IllegalLabsAndWarehouse.CreateCurrentPropertyManagement()
  
              Zone:Add(
                vector3(interiorCoords.x, interiorCoords.y, interiorCoords.z), 
                IllegalLabsAndWarehouse.InsidePropertyMenuEnter, 
                IllegalLabsAndWarehouse.InsidePropertyMenuExit, 
                IllegalLabsAndWarehouse.CURRENT_PROPERTY.name, 
                1.5
              )
  
          end
      )
  end
  
   -- Called by the instance module and will teleport the player outside the instance
  function IllegalLabsAndWarehouse.TeleportToOutsideDoor()
    local playerPed = LocalPlayer().Ped
    Citizen.CreateThread(
        function()
            DoScreenFadeOut(100)
            Atlantiss.Player:FreezePlayer(LocalPlayer().Ped, true)
            Atlantiss.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, true)

              while not IsScreenFadedOut() do
                Citizen.Wait(50)
            end

            if (IllegalLabsAndWarehouse.CURRENT_PROPERTY == nil or IllegalLabsAndWarehouse.CURRENT_PROPERTY.outside_door == nil) then
                outside = {x = 254.29, y = -780.99, z = 30.57}
                Atlantiss.Core:TeleportEntityTo(playerPed, vector3(outside.x, outside.y, outside.z), true)
                ShowNotification("~b~Votre localisation de départ n'a pas été trouvé. Vous serez TP au PC")
            else
              Atlantiss.Core:TeleportEntityTo(playerPed, vector3(IllegalLabsAndWarehouse.CURRENT_PROPERTY.outside_door.x, IllegalLabsAndWarehouse.CURRENT_PROPERTY.outside_door.y, IllegalLabsAndWarehouse.CURRENT_PROPERTY.outside_door.z), true)
              Wait(100)
              Atlantiss.Player:FreezePlayer(LocalPlayer().Ped, false)
              Atlantiss.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, false)
            end
            DoScreenFadeIn(100)
        end
    )
    
      local interiorCoords = IllegalLabsAndWarehouse.GetInteriorCoordsByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)  
      local vaultCoords = IllegalLabsAndWarehouse.GetVaultPositionByBusinessId(IllegalLabsAndWarehouse.CURRENT_PROPERTY.business_id)  

      Hint:RemoveAll()
      KeySettings:Clear("keyboard", "E", "IllegalPropertyOrgaInside")
      IllegalLabsAndWarehouse.CURRENT_PROPERTY = IllegalOrga.GetProperties()[IllegalLabsAndWarehouse.CURRENT_PROPERTY_NAME]
      Zone:Remove(interiorCoords)
      Zone:Remove(vaultCoords)

      if (IllegalLabsAndWarehouse.IsDrugType(IllegalLabsAndWarehouse.CURRENT_PROPERTY.type)) then
        IllegalLabsAndWarehouse.MENUS.DRUGLAB.DeleteZones()
      else
        IllegalLabsAndWarehouse.MENUS.GUNLEAD.DeleteZones()
      end
  end
  
   -- Behavior when player is in front of outside door (When the player is in the zone)
  function IllegalLabsAndWarehouse.PropertyMenuEnter(zone)
      Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour entrer")
      IllegalLabsAndWarehouse.CURRENT_PROPERTY_NAME = zone
      KeySettings:Add("keyboard", "E", IllegalLabsAndWarehouse.GoToInstance, "IllegalPropertyOrga")
      KeySettings:Add("controller", 46, IllegalLabsAndWarehouse.GoToInstance, "IllegalPropertyOrga")
  end
  
   -- Behavior when player is in front of outside door (When the player leaves the zone)
  function IllegalLabsAndWarehouse.PropertyMenuExit()
      Hint:RemoveAll()
      KeySettings:Clear("keyboard", "E", "IllegalPropertyOrga")
      KeySettings:Clear("controller", 46, "IllegalPropertyOrga")
  end
  
   -- Behavior when player is in front of inside door (When the player enters the zone)
  function IllegalLabsAndWarehouse.InsidePropertyMenuEnter(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour sortir")
    IllegalLabsAndWarehouse.CURRENT_PROPERTY_NAME = zone
    KeySettings:Add("keyboard", "E", IllegalLabsAndWarehouse.ExitFromInstance, "IllegalPropertyOrgaInside")
    KeySettings:Add("controller", 46, IllegalLabsAndWarehouse.ExitFromInstance, "IllegalPropertyOrgaInside")
  end
  
   -- Behavior when player is in front of inside door (When the player exit the zone)
  function IllegalLabsAndWarehouse.InsidePropertyMenuExit()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard", "E", "IllegalPropertyOrgaInside")
    KeySettings:Clear("controller", 46, "IllegalPropertyOrgaInside")
  end

  