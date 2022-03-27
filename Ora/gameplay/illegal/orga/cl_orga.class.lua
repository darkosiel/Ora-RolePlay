
IllegalOrga = IllegalOrga or {}

--[[
********************************************************
********************************************************
**************       CLASS METHODS       ***************
********************************************************
********************************************************

* Methods related to the IllegalOrga class
]]

-- Returns the current organisation (nil|table)
-- @returns nil|table
function IllegalOrga.GetOrga()
  return IllegalOrga.CURRENT_ORGA
end

-- Returns the uuid of the owner (nil|string)
-- @returns nil|string
function IllegalOrga.GetOwner()
  return IllegalOrga.CURRENT_ORGA.OWNER
end

-- Returns the id of the organisation
-- @returns nil|integer
function IllegalOrga.GetId()
  return IllegalOrga.CURRENT_ORGA.ID
end

  -- Returns a "default" rank with limited rights.
  -- it is used as a fallback when a rank is unknown
  -- @returns table
function IllegalOrga.GetUnkownRank()
    return { id = nil, name = "Inconnu", position = 1, can_add_members = 0, can_remove_members = 0, can_see_lab = 0, can_manage_member = 0, can_manage_rank = 0, can_delete_orga = 0, can_receive_notif = 0, can_enter_lab = 0}
end

-- Returns the name of the current organisation (string).
-- @returns nil|string
function IllegalOrga.GetName()
  return IllegalOrga.CURRENT_ORGA.NAME
end

-- Returns the uuid of the current player (methods can be long to returns the result)
-- @returns string
function IllegalOrga.GetMyUuid()
  if (IllegalOrga.CURRENT_ORGA.MY_UUID == nil) then
    local canSend = false
    TriggerServerCallback("Ora:getMyUuid", function(myUuid)
      IllegalOrga.CURRENT_ORGA.MY_UUID = myUuid
      canSend = true
    end)
    
    while (canSend == false) do
      Wait(100)      
    end

    return IllegalOrga.CURRENT_ORGA.MY_UUID
  else
    return IllegalOrga.CURRENT_ORGA.MY_UUID
  end
end

-- Returns the the list of factions. Using lazy loading method
-- @returns table
function IllegalOrga.GetAllFactions()
  if (IllegalOrga.FACTIONS.LOADED == false) then
    TriggerServerCallback("Ora:Illegal:getAllOrga", 
        function(orgasAsJson)
            IllegalOrga.FACTIONS.LIST = json.decode(orgasAsJson)
            IllegalOrga.FACTIONS.LOADED = true
        end, 
        propertyName
    )
    
    while (IllegalOrga.FACTIONS.LOADED == false) do
      Wait(100)      
    end

    return IllegalOrga.FACTIONS.LIST
  else
    return IllegalOrga.FACTIONS.LIST
  end
end


-- Returns my rank in the organisation
-- @returns table
function IllegalOrga.GetMyRank()
  if (IllegalOrga.MY_RANK == nil) then
      local rankId = nil 
      for index, value in pairs(IllegalOrga.CURRENT_ORGA.MEMBERS) do
          if value.uuid == IllegalOrga.GetMyUuid() then
              rankId = value.rank_id
          end
      end

      if (rankId ~= nil) then
        for index, value in pairs(IllegalOrga.CURRENT_ORGA.RANKS) do
            if value.id == rankId then
              IllegalOrga.MY_RANK = value
            end
        end
      else
        IllegalOrga.MY_RANK = IllegalOrga.GetUnkownRank()
      end
  end

  return IllegalOrga.MY_RANK
end

-- Returns ranks existing in the organisation
-- @returns table
function IllegalOrga.GetRanks()
  return IllegalOrga.CURRENT_ORGA.RANKS
end

-- Returns ranks label existing the organisation
-- @returns table
function IllegalOrga.GetOrgaRanksAsList()
  if IllegalOrga.MENU.RANKS_AS_LIST == nil then
      local ranksAsList = {}
      local ranks = IllegalOrga.CURRENT_ORGA.RANKS
      for index, value in pairs(ranks) do
          table.insert(ranksAsList, value.name)
      end
      IllegalOrga.MENU.RANKS_AS_LIST = ranksAsList
  end

  return IllegalOrga.MENU.RANKS_AS_LIST
end

-- Returns rank id of the rank by providing rank name
-- @returns integer
function IllegalOrga.GetRankIdByName(rankName)
    local ranks = IllegalOrga.CURRENT_ORGA.RANKS
    for index, value in pairs(ranks) do
        if (value.name == rankName) then
            return value.id
        end
    end
end

-- Returns members of the organisation
-- @returns table
function IllegalOrga.GetMembers()
  return IllegalOrga.CURRENT_ORGA.MEMBERS
end

-- Returns properties of the organisation
-- @returns table
function IllegalOrga.GetProperties()
  return IllegalOrga.CURRENT_ORGA.PROPERTIES
end

 -- Event handler used to "update" the current organisation ()
RegisterNetEvent("Ora::Illegal:updateCurrentOrga")
AddEventHandler("Ora::Illegal:updateCurrentOrga", function(organisation)
    IllegalOrga.CURRENT_ORGA = organisation
    IllegalOrga.MY_ORGA = IllegalOrga.CURRENT_ORGA.NAME
    IllegalOrga.MENU.RANKS_AS_LIST = nil
    IllegalOrga.MY_RANK = nil
end)

-- Handler for Coords 
RegisterNetEvent("Ora:Illegal:OrganisationSetCoords")
AddEventHandler(
    "Ora:Illegal:OrganisationSetCoords",
    function(coords)
        SetNewWaypoint(coords.x, coords.y)
    end
)

 -- Event handler used to "update" the current organisation and add blips issued from organisation properties
RegisterNetEvent("Ora::Illegal:setOrgaObject")
AddEventHandler("Ora::Illegal:setOrgaObject", function(organisation)
    IllegalOrga.CURRENT_ORGA = organisation
    IllegalOrga.MY_ORGA = IllegalOrga.CURRENT_ORGA.NAME
    IllegalOrga.MY_RANK = nil
    IllegalOrga.MENU.RANKS_AS_LIST = nil

    for index, value in pairs(IllegalOrga.PROPERTIES_BLIPS) do
          RemoveBlip(value)
    end

    for index, value in pairs(IllegalOrga.PROPERTIES_ZONES) do
        Zone:Remove(value)
    end

    IllegalOrga.PROPERTIES_BLIPS = {}
    IllegalOrga.PROPERTIES_ZONES = {}

    local myRank = IllegalOrga.GetMyRank()


      for index, value in pairs(IllegalOrga.CURRENT_ORGA.PROPERTIES) do
        if (myRank.can_see_lab == 1) then
          local blip = AddBlipForCoord(value.outside_door.x, value.outside_door.y, value.outside_door.z)
          SetBlipSprite(blip, 543)
          SetBlipDisplay(blip, 4)
          SetBlipScale(blip, 0.8)
          SetBlipColour(blip, 66)
          SetBlipAsShortRange(blip, true)
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(value.name .. " (" .. IllegalOrga.CURRENT_ORGA.LABEL .. ")")
          EndTextCommandSetBlipName(blip)
          table.insert(IllegalOrga.PROPERTIES_BLIPS, blip)
        end
        
        if (myRank.can_enter_lab == 1) then
          local labPos = vector3(value.outside_door.x, value.outside_door.y, value.outside_door.z)
          table.insert(IllegalOrga.PROPERTIES_ZONES, labPos)
          Zone:Add(labPos, IllegalLabsAndWarehouse.PropertyMenuEnter, IllegalLabsAndWarehouse.PropertyMenuExit, value.name, 2.5)
        end
    end
end)
