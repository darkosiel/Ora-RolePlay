IllegalOrga = IllegalOrga or {}

local function getPlayerUuid(source)
  return Ora.Identity:GetUuid(source)
end

Citizen.CreateThread(function()
  print("^1REMOVING INVALID MEMBERS FOR FACTION^0")

  local invalidMembers = MySQL.Sync.fetchAll(
      "SELECT om.id, om.uuid FROM organisation_member AS om LEFT JOIN players_identity AS pi ON om.uuid = pi.uuid WHERE pi.uuid IS NULL",
      {}
  )

  if (invalidMembers[1] ~= nil) then
    for index, value in pairs(invalidMembers) do
        MySQL.Async.execute(
            "DELETE FROM organisation_member WHERE id = @id",
            {
              ['@id'] = value.id
            },
            function(affectedRows)
                print("^2REMOVED UUID ".. value.uuid .."^0")
            end
        )
    end  
  end
end)

function IllegalOrga.GetPlayerUuid(playerId) 
    return Ora.Identity:GetUuid(playerId)
end

-- Get CURRENT_ORGA object for organisation id
local function getOrgaObjectForOrganisationId(orgaId)
  local tmpOrga = IllegalOrga.GetEmptyOrga()
  local organisation = MySQL.Sync.fetchAll(
      "SELECT * FROM organisation WHERE id = @organisationId",
      {
          ["@organisationId"] = orgaId
      }
  )

  if (organisation[1] == nil) then
    return tmpOrga
  end

  tmpOrga.ID = organisation[1].id
  tmpOrga.OWNER = organisation[1].owner
  tmpOrga.MY_UUID = nil
  tmpOrga.NAME = organisation[1].name
  tmpOrga.LABEL = organisation[1].label

  local ranks = MySQL.Sync.fetchAll(
      "SELECT * FROM organisation_rank WHERE organisation_id = @organisationId",
      {
          ["@organisationId"] = orgaId
      }
  )

  if (ranks[1] ~= nil) then
    for index, value in pairs(ranks) do
      table.insert(
        tmpOrga.RANKS,
        { 
          id = value.id, 
          name = value.name, 
          position = value.name, 
          can_add_members = value.can_add_members, 
          can_remove_members = value.can_remove_members, 
          can_see_lab = value.can_see_lab,
          can_manage_member = value.can_manage_member,
          can_manage_rank = value.can_manage_rank,
          can_delete_orga = value.can_delete_orga,
          can_enter_lab = value.can_enter_lab,
          can_receive_notif = value.can_receive_notif
        }  
      )
    end
  end

  local members = MySQL.Sync.fetchAll(
      "SELECT om.*, or2.name as rank_name, CONCAT(pi.first_name, ' ', pi.last_name) as fullname FROM organisation_member as om LEFT JOIN organisation_rank as or2 ON or2.id = om.rank_id INNER JOIN players_identity as pi ON pi.uuid = om.uuid WHERE om.organisation_id = @organisationId",
      {
          ["@organisationId"] = orgaId
      }
  )

  if (members[1] ~= nil) then
    for index, value in pairs(members) do
      table.insert(
        tmpOrga.MEMBERS,
        { 
          id = value.id, 
          rank_id = value.rank_id, 
          uuid = value.uuid, 
          fullname = value.fullname, 
          rank_name = value.rank_name
        } 
      )
    end
  end
  

  local properties = MySQL.Sync.fetchAll(
      "SELECT * FROM organisation_property WHERE organisation_id = @organisationId",
      {
          ["@organisationId"] = orgaId
      }
  )

  if (properties[1] ~= nil) then
    for index, value in pairs(properties) do
      tmpOrga.PROPERTIES[value.name] = 
        { 
          id = value.id, 
          organisation_id = value.organisation_id, 
          name = value.name, 
          type = value.type, 
          business_id = value.business_id,
          outside_door = json.decode(value.outside_door),
          production_level = value.production_level,
          security_level = value.security_level,
          capacity = value.capacity,
          limitation = json.decode(value.limitation)
        }
    end
  end


  return tmpOrga
end

local function updateOrganisationToAllClient(organisationId)
    local tmpOrga = getOrgaObjectForOrganisationId(organisationId)
    local usersUuid = {}
    for index, value in ipairs(tmpOrga.MEMBERS) do
        usersUuid[value.uuid] = true
    end

    for _, playerId in ipairs(GetPlayers()) do
        local playerUuid = getPlayerUuid(playerId)
        if (usersUuid[playerUuid] ~= nil and usersUuid[playerUuid] == true) then
            TriggerClientEvent("Ora::Illegal:setOrgaObject", playerId, tmpOrga)
        end
    end
end


local function setupOrganisationToAllClient(organisationId)
  local tmpOrga = getOrgaObjectForOrganisationId(organisationId)
  local usersUuid = {}
  for index, value in ipairs(tmpOrga.MEMBERS) do
      usersUuid[value.uuid] = true
  end

  for _, playerId in ipairs(GetPlayers()) do
      local playerUuid = getPlayerUuid(playerId)
      if (usersUuid[playerUuid] ~= nil and usersUuid[playerUuid] == true) then
          TriggerClientEvent("Ora::Illegal:setOrgaObject", playerId, tmpOrga)
      end
  end
end

local function getOrganisationOnlineMembers(organisationId)
  local tmpOrga = getOrgaObjectForOrganisationId(organisationId)
  local usersUuid = {}
  for index, value in ipairs(tmpOrga.MEMBERS) do
      usersUuid[value.uuid] = value
  end

  local organisationOnlinePlayers = {}

  for _, playerId in ipairs(GetPlayers()) do
      local playerUuid = getPlayerUuid(playerId)
      if (usersUuid[playerUuid] ~= nil) then
          table.insert(organisationOnlinePlayers, usersUuid[playerUuid])
      end
  end

  return organisationOnlinePlayers
end

-- Returns the current organisation (nil|table)
-- @returns nil|table
function IllegalOrga.GetOrganisationOnlineMembers(organisationId)
  return getOrganisationOnlineMembers(organisationId)
end

local function getOnlinePlayerByUuid(uuid)
  for _, playerId in ipairs(GetPlayers()) do
      local playerUuid = getPlayerUuid(playerId)
      if (uuid == playerUuid) then
          return playerId
      end
  end

  return nil
end


function IllegalOrga.TriggerClientEvent(eventName, organisationId, arg)
  local tmpOrga = getOrgaObjectForOrganisationId(organisationId)
  local usersUuid = {}

  for index, value in ipairs(tmpOrga.MEMBERS) do
      usersUuid[value.uuid] = value
  end

  for _, playerId in ipairs(GetPlayers()) do
      local playerUuid = getPlayerUuid(playerId)
      if (usersUuid[playerUuid] ~= nil) then
          TriggerClientEvent(eventName, playerId, arg)
      end
  end
end


local function sendMessageToOnlineMembers(organisationId, message)
  local tmpOrga = getOrgaObjectForOrganisationId(organisationId)
  local usersUuid = {}
  local allowedRanks = {}

  for index, value in ipairs(tmpOrga.RANKS) do
      allowedRanks[value.name] = value.can_receive_notif 
  end

  for index, value in ipairs(tmpOrga.MEMBERS) do
      if (allowedRanks[value.rank_name] ~= nil and allowedRanks[value.rank_name] == 1) then
          usersUuid[value.uuid] = value
      end
  end

  for _, playerId in ipairs(GetPlayers()) do
      local playerUuid = getPlayerUuid(playerId)
      if (usersUuid[playerUuid] ~= nil) then
        TriggerClientEvent("RageUI:Popup", playerId, {message = "~h~".. tmpOrga.LABEL .."~h~: " .. message})
      end
  end
end

local function setCoordsToOnlineMembers(organisationId, coords)
  local tmpOrga = getOrgaObjectForOrganisationId(organisationId)
  local usersUuid = {}
  local allowedRanks = {}

  for index, value in ipairs(tmpOrga.RANKS) do
      allowedRanks[value.name] = value.can_receive_notif 
  end

  for index, value in ipairs(tmpOrga.MEMBERS) do
      if (allowedRanks[value.rank_name] ~= nil and allowedRanks[value.rank_name] == 1) then
          usersUuid[value.uuid] = value
      end
  end

  for _, playerId in ipairs(GetPlayers()) do
      local playerUuid = getPlayerUuid(playerId)
      if (usersUuid[playerUuid] ~= nil) then
        TriggerClientEvent("Ora:Illegal:OrganisationSetCoords", playerId, coords)
      end
  end
end

local function deleteOrganisationFromAllClient(organisation)
  local tmpOrga = organisation
  local usersUuid = {}

  for index, value in ipairs(tmpOrga.MEMBERS) do
      usersUuid[value.uuid] = true
  end

  for _, playerId in ipairs(GetPlayers()) do
      local playerUuid = getPlayerUuid(playerId)
      if (usersUuid[playerUuid] ~= nil and usersUuid[playerUuid] == true) then
        TriggerClientEvent("Ora::Illegal:updateCurrentOrga", playerId, IllegalOrga.GetEmptyOrga())
        TriggerClientEvent("RageUI:Popup", playerId, {message = "~h~".. tmpOrga.LABEL .."~h~: La faction vient d'être supprimée"})
      end
  end
end

-- Get the CURRENT_ORGA object for given player uuid
local function getOrgaForUuid(uuid)
  local tmpOrga = IllegalOrga.GetEmptyOrga()
  
  local results = MySQL.Sync.fetchAll(
      "SELECT * FROM organisation_member WHERE uuid = @uuid",
      {
          ["@uuid"] = uuid
      }
  )

  if (results[1] ~= nil) then
    local orgaId = results[1].organisation_id
    tmpOrga = getOrgaObjectForOrganisationId(orgaId)
    tmpOrga.MY_UUID = uuid
  end

  return tmpOrga
end


-- Get the player fullname
local function getPlayerFullname(uuid)
  local results = MySQL.Sync.fetchAll(
      "SELECT CONCAT(first_name, ' ', last_name) as fullname FROM `players_identity` WHERE uuid = @uuid",
      {
        ["@uuid"] = uuid,
      }
  )

  if (results[1] ~= nil) then
    return results[1].fullname
  else
    return "Membre inconnu"
  end
end

--[[
CREATE TABLE `organisation` ( `id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(255) NOT NULL , `owner` VARCHAR(255) NOT NULL , `created_at` VARCHAR(255) NOT NULL , PRIMARY KEY (`id`), INDEX (`name`), INDEX (`owner`)) ENGINE = InnoDB CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;
CREATE TABLE `organisation_rank` ( `id` INT NOT NULL AUTO_INCREMENT , `organisation_id` INT NOT NULL , `name` VARCHAR(255) NOT NULL , `position` INT NOT NULL , `can_add_members` TINYINT NOT NULL DEFAULT '0' , `can_remove_members` TINYINT NOT NULL DEFAULT '0' , `can_see_lab` TINYINT NOT NULL DEFAULT '0' , PRIMARY KEY (`id`)) ENGINE = InnoDB CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE `organisation_rank` ADD CONSTRAINT `fk_orga_orga_ranks` FOREIGN KEY (`organisation_id`) REFERENCES `organisation`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
CREATE TABLE `organisation_member` ( `id` INT NOT NULL AUTO_INCREMENT , `organisation_id` INT NOT NULL , `rank_id` INT NOT NULL , `uuid` VARCHAR(255) NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE `organisation_member` ADD CONSTRAINT `fk_orga_orga_members` FOREIGN KEY (`organisation_id`) REFERENCES `organisation`(`id`) ON DELETE CASCADE ON UPDATE CASCADE; 
ALTER TABLE `organisation_member` ADD CONSTRAINT `fk_orga_member_ranks` FOREIGN KEY (`rank_id`) REFERENCES `organisation_rank`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `organisation_rank` ADD `can_manage_rank` TINYINT NOT NULL DEFAULT '0' AFTER `can_see_lab`, ADD `can_manage_member` TINYINT NOT NULL DEFAULT '0' AFTER `can_manage_rank`, ADD `can_delete_orga` TINYINT NOT NULL DEFAULT '0' AFTER `can_manage_member`;
ALTER TABLE `organisation` ADD `label` VARCHAR(4) NOT NULL AFTER `name`;
ALTER TABLE `organisation_rank` ADD `can_receive_notif` TINYINT NOT NULL DEFAULT '1' AFTER `can_delete_orga`, ADD `can_enter_lab` TINYINT NOT NULL DEFAULT '1' AFTER `can_receive_notif`;
]]--

RegisterServerEvent("Ora::Illegal:createOrg")
AddEventHandler(
    "Ora::Illegal:createOrg",
    function(organisation)
        local _source = source
        local now = os.time()
        local uuid = Ora.Identity:GetUuid(_source)

        local newlyCreatedOrg = {
          NAME = organisation.NAME,
          LABEL = organisation.LABEL
        }

        local organisationId = MySQL.Sync.insert(
            "INSERT INTO organisation (name, label, owner, created_at) VALUES (@name, @label, @ownerUuid, @createdAt)",
            {
                ["@name"] = organisation.NAME,
                ["@label"] = organisation.LABEL,
                ["@createdAt"] = now,
                ["@ownerUuid"] = uuid
            }
        )

        newlyCreatedOrg.ID = organisationId
        newlyCreatedOrg.OWNER = uuid
        newlyCreatedOrg.MY_UUID = uuid

        local organisationRankId = MySQL.Sync.insert(
            "INSERT INTO organisation_rank (organisation_id, name, position, can_add_members, can_remove_members, can_see_lab, can_manage_rank, can_manage_member, can_delete_orga, can_receive_notif, can_enter_lab) VALUES (@organisation_id, @name, @position, @can_add_members, @can_remove_members, @can_see_lab, @can_manage_rank, @can_manage_member, @can_delete_orga, @can_receive_notif, @can_enter_lab)",
            {
                ["@organisation_id"] = organisationId,
                ["@name"] = "Admin",
                ["@position"] = 1,
                ["@can_add_members"] = 1,
                ["@can_remove_members"] = 1,
                ["@can_see_lab"] = 1,
                ["@can_manage_rank"] = 1,
                ["@can_manage_member"] = 1,
                ["@can_delete_orga"] = 1,
                ["@can_receive_notif"] = 1,
                ["@can_enter_lab"] = 1,
            }
        )

        newlyCreatedOrg.RANKS = {
          { id = organisationRankId, name = "Admin", position = 1, can_add_members = 1, can_remove_members = 1, can_see_lab = 1, can_manage_member = 1, can_manage_rank = 1, can_delete_orga = 1, can_enter_lab = 1, can_receive_notif = 1}
        }

        local organisationMemberId = MySQL.Sync.insert(
            "INSERT INTO organisation_member (organisation_id, rank_id, uuid) VALUES (@organisation_id, @rank_id, @uuid)",
            {
                ["@organisation_id"] = organisationId,
                ["@rank_id"] = organisationRankId,
                ["@uuid"] = uuid,
            }
        )

        newlyCreatedOrg.MEMBERS = {
          { id = organisationMemberId, rank_id = organisationRankId, uuid = uuid, fullname = getPlayerFullname(uuid), rank_name = "Admin"}
        }

        newlyCreatedOrg.PROPERTIES = {}

        TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Votre faction est créée~s~"})
        TriggerClientEvent("Ora::Illegal:updateCurrentOrga", _source, newlyCreatedOrg)
        TriggerEvent("Ora:sendToDiscordFromServer", _source, 20, Ora.Identity:GetFullname(_source) .. " a créé la faction " .. newlyCreatedOrg.NAME .. " (".. newlyCreatedOrg.LABEL ..")", "info")
    end
)

RegisterServerEvent("Ora::Illegal:deleteOrg")
AddEventHandler(
    "Ora::Illegal:deleteOrg",
    function(organisation)
        local _source = source
        local _organisation = organisation
        local now = os.time()
        local uuid = getPlayerUuid(_source)

        MySQL.Async.execute(
          "DELETE FROM organisation WHERE owner = @ownerUuid",
          {
            ["@ownerUuid"] = uuid
          },
          function (affectedRows) 
            if (affectedRows > 0) then
                  deleteOrganisationFromAllClient(_organisation)
                  TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Votre faction est désormais supprimée~s~"})
                  TriggerEvent("Ora:sendToDiscordFromServer", _source, 20, Ora.Identity:GetFullname(_source) .. " a supprimé la faction " .. organisation.NAME .. " (".. organisation.LABEL ..")", "info")

                else
                  TriggerClientEvent("RageUI:Popup", _source, {message = "~r~~h~Une erreur empeche la suppression de votre faction~s~"})
                end
            end
        )
    end
)


RegisterServerEvent("Ora::Illegal:deletePlayerFromOrgByPlayerServerId")
AddEventHandler(
    "Ora::Illegal:deletePlayerFromOrgByPlayerServerId",
    function(organisation, playerId)
      local _source = source
      local uuid = getPlayerUuid(playerId)
      local members = MySQL.Sync.fetchAll(
          "SELECT COUNT(id) as members FROM organisation_member WHERE organisation_id = @organisationId AND uuid = @uuid",
          {
              ["@organisationId"] = organisation.ID,
              ["@uuid"] = uuid,
          }
      )

      if (members[1] ~= nil and members[1].members == 0) then
            TriggerClientEvent("RageUI:Popup", _source, {message = "~r~Cette personne n'est ~h~pas~h~ dans votre groupe.~s~"})
      else
          local organisationMemberId = MySQL.Sync.insert(
              "DELETE FROM organisation_member WHERE organisation_id = @organisation_id AND uuid = @uuid",
              {
                  ["@organisation_id"] = organisation.ID,
                  ["@uuid"] = uuid,
              }
          )
          TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Vous avez exclu un membre~s~"})
          TriggerClientEvent("RageUI:Popup", playerId, {message = "~g~Vous avez été exclu de la faction ~h~" .. organisation.NAME .."~h~~s~"})
          updateOrganisationToAllClient(organisation.ID)
          TriggerClientEvent("Ora::Illegal:updateCurrentOrga", playerId, IllegalOrga.GetEmptyOrga())
          TriggerEvent("Ora:sendToDiscordFromServer", _source, 20, Ora.Identity:GetFullname(_source) .. " a exclu ".. Ora.Identity:GetFullname(playerId) .." de la faction " .. organisation.NAME .. " (".. organisation.LABEL ..")", "info")
      end

    end
)

RegisterServerEvent("Ora::Illegal:addPlayerToOrg")
AddEventHandler(
    "Ora::Illegal:addPlayerToOrg",
    function(organisation, playerId, roleId)
        local _source = source
        local uuid = getPlayerUuid(playerId)
        local members = MySQL.Sync.fetchAll(
            "SELECT COUNT(id) as members FROM organisation_member WHERE uuid = @uuid",
            {
                ["@uuid"] = uuid
            }
        )

        if (members[1] ~= nil and members[1].members > 0) then
            TriggerClientEvent("RageUI:Popup", _source, {message = "~r~Cette personne est ~h~déjà~h~ recrutée ou dans un autre groupe.~s~"})
        else
          local organisationMemberId = MySQL.Sync.insert(
              "INSERT INTO organisation_member (organisation_id, rank_id, uuid) VALUES (@organisation_id, @rank_id, @uuid)",
              {
                  ["@organisation_id"] = organisation.ID,
                  ["@rank_id"] = roleId,
                  ["@uuid"] = uuid,
              }
          )
          TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Vous avez recruté un nouveau membre~s~"})
          TriggerClientEvent("RageUI:Popup", playerId, {message = "~g~Vous avez été recruté dans la faction ~h~" .. organisation.NAME .."~h~~s~"})
          updateOrganisationToAllClient(organisation.ID)
          TriggerEvent("Ora:sendToDiscordFromServer", _source, 20, Ora.Identity:GetFullname(_source) .. " a recruté ".. Ora.Identity:GetFullname(playerId) .." dans la faction " .. organisation.NAME .. " (".. organisation.LABEL ..")", "info")

        end
    end
  )

RegisterServerEvent("Ora::Illegal:updateOrgPlayer")
AddEventHandler(
    "Ora::Illegal:updateOrgPlayer",
    function(organisationId, currentPlayer)
        local _source = source
        if (currentPlayer.NEW_VALUES ~= nil) then
            local sqlUpdate = "UPDATE organisation_member SET "
            local updatedFields = {}
            for index, value in pairs(currentPlayer.NEW_VALUES) do
              table.insert(updatedFields, index .. " = " .. value)
            end
            sqlUpdate = sqlUpdate .. " " .. table.concat(updatedFields,",")
            MySQL.Async.execute(
                sqlUpdate .. " WHERE id = @currentPlayerId",
                {
                    ["@currentPlayerId"] = currentPlayer.id
                },
                function (affectedRows)
                    if (affectedRows > 0) then
                        updateOrganisationToAllClient(organisationId)
                        TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Le membre ~h~".. currentPlayer.fullname .."~h~ a été mis à jour~s~"})
                        TriggerEvent("Ora:sendToDiscordFromServer", _source, 20, Ora.Identity:GetFullname(_source) .. " a mis à jour ".. currentPlayer.fullname .." dans la faction id " .. organisationId, "info")
                    else
                      TriggerClientEvent("RageUI:Popup", _source, {message = "~r~Une erreur a empeché la mise à jour~s~"})
                    end
                end
            )
        end
    end
)

RegisterServerEvent("Ora::Illegal:deleteOrgPlayer")
AddEventHandler(
    "Ora::Illegal:deleteOrgPlayer",
    function(organisation, currentPlayer)
        local _source = source

        if (organisation.OWNER == currentPlayer.uuid) then
            TriggerClientEvent("RageUI:Popup", _source, {message = "~r~Le membre ~h~".. currentPlayer.fullname .."~h~ est le propriétaire du groupe~s~"})
        else
            local affectedRows = MySQL.Sync.execute(
                "DELETE FROM organisation_member WHERE organisation_id = @organisationId AND uuid = @uuid",
                {
                    ["@organisationId"] = organisation.ID,
                    ["@uuid"] = currentPlayer.uuid,
                }
            )

            if affectedRows > 0 then 
              TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Le membre ~h~".. currentPlayer.fullname .."~h~ a été supprimé~s~"})
              updateOrganisationToAllClient(organisationId)
  
              local onlinePlayer = getOnlinePlayerByUuid(currentPlayer.uuid)
              if (onlinePlayer ~= nil) then
                  TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Vous avez été ~h~exclu~h~ de la faction " .. organisation.NAME .. "~s~"})
                  TriggerClientEvent("Ora::Illegal:updateCurrentOrga", onlinePlayer, IllegalOrga.GetEmptyOrga())
                  TriggerEvent("Ora:sendToDiscordFromServer", _source, 20, Ora.Identity:GetFullname(_source) .. " a exclu ".. currentPlayer.fullname .." dans la faction  " .. organisation.NAME .. " (".. organisation.LABEL .. ")", "info")
              end
            end
        end
    end
)

RegisterServerEvent("Ora::Illegal:createOrgRank")
AddEventHandler(
    "Ora::Illegal:createOrgRank",
    function(organisationId, currentRank)
        local _source = source

        for index, value in pairs(currentRank.NEW_VALUES) do
            if (value == true) then
              value = 1
            end

            if (value == nil) then
              value = 0
            end

            if (value == false) then
              value = 0
            end
        end

        local organisationRankId = MySQL.Sync.insert(
            "INSERT INTO organisation_rank (organisation_id, name, position, can_add_members, can_remove_members, can_see_lab, can_manage_rank, can_manage_member, can_delete_orga, can_receive_notif, can_enter_lab) VALUES (@organisation_id, @name, @position, @can_add_members, @can_remove_members, @can_see_lab, @can_manage_rank, @can_manage_member, @can_delete_orga, @can_receive_notif, @can_enter_lab)",
            {
                ["@organisation_id"] = organisationId,
                ["@name"] = currentRank.NEW_VALUES.name,
                ["@position"] = 1,
                ["@can_add_members"] = currentRank.NEW_VALUES.can_add_members,
                ["@can_remove_members"] =  currentRank.NEW_VALUES.can_remove_members,
                ["@can_see_lab"] = currentRank.NEW_VALUES.can_see_lab,
                ["@can_manage_rank"] = currentRank.NEW_VALUES.can_manage_rank,
                ["@can_manage_member"] = currentRank.NEW_VALUES.can_manage_member,
                ["@can_delete_orga"] = currentRank.NEW_VALUES.can_delete_orga,
                ["@can_receive_notif"] = currentRank.NEW_VALUES.can_receive_notif,
                ["@can_enter_lab"] = currentRank.NEW_VALUES.can_enter_lab
            }
        )
      
        TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Le grade ~h~".. currentRank.NEW_VALUES.name .. "~h~ a été créé.~s~"})
        updateOrganisationToAllClient(organisationId)
        TriggerEvent("Ora:sendToDiscordFromServer", _source, 20, Ora.Identity:GetFullname(_source) .. " a créé le grade ".. currentRank.NEW_VALUES.name .." dans la faction  " .. organisationId, "info")
      end
)

RegisterServerEvent("Ora::Illegal:deleteOrgRank")
AddEventHandler(
    "Ora::Illegal:deleteOrgRank",
    function(organisationId, currentRank)
        local _source = source
        local members = MySQL.Sync.fetchAll(
            "SELECT COUNT(id) as members FROM organisation_member WHERE organisation_id = @organisationId AND rank_id = @rankId",
            {
                ["@organisationId"] = organisationId,
                ["@rankId"] = currentRank.id,
            }
        )

        if (members[1] ~= nil and members[1].members > 0) then
            TriggerClientEvent("RageUI:Popup", _source, {message = "~r~Il y a encore ~h~".. members[1].members .. "~h~ ayant ce grade. Modifiez leur grade avant~s~"})
        else
            MySQL.Async.execute(
                "DELETE FROM organisation_rank where organisation_id = @organisationId and id = @rankId",
                {
                    ["@organisationId"] = organisationId,
                    ["@rankId"] = currentRank.id,
                },
                function (affectedRows)
                    if (affectedRows > 0) then
                        TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Vous avez supprimé le grade ~h~" .. currentRank.name .."~h~.~s~"})
                        updateOrganisationToAllClient(organisationId)
                        TriggerEvent("Ora:sendToDiscordFromServer", _source, 20, Ora.Identity:GetFullname(_source) .. " a supprimé le grade ".. currentRank.name .." dans la faction  " .. organisationId, "info")
                    else
                      TriggerClientEvent("RageUI:Popup", _source, {message = "~r~Une erreur s'est produite. Impossible de supprimer le grade.~s~"})
                    end
                end
            )
        end
    end
)

RegisterServerEvent("Ora::Illegal:updateOrgRank")
AddEventHandler(
    "Ora::Illegal:updateOrgRank",
    function(organisationId, currentRank)
      local _source = source
      if (currentRank.NEW_VALUES ~= nil) then
          local sqlUpdate = "UPDATE organisation_rank SET "
          local updatedFields = {}
          for index, value in pairs(currentRank.NEW_VALUES) do

            if (value == true) then
              value = 1
            end

            if (value == nil) then
              value = 0
            end

            if (value == false) then
              value = 0
            end

            table.insert(updatedFields, index .. " = " .. value)
          end
          sqlUpdate = sqlUpdate .. " " .. table.concat(updatedFields,",")
          MySQL.Async.execute(
              sqlUpdate .. " WHERE id = @currentRankId",
              {
                  ["@currentRankId"] = currentRank.id
              },
              function (affectedRows)
                  if (affectedRows > 0) then
                      updateOrganisationToAllClient(organisationId)
                      TriggerEvent("Ora:sendToDiscordFromServer", _source, 20, Ora.Identity:GetFullname(_source) .. " a mis à jour le grade ".. currentRank.name .." dans la faction  " .. organisationId, "info")
                  end
              end
          )
      end
    end
)

RegisterServerEvent("Ora::Illegal:updateOrgForPlayer")
AddEventHandler(
    "Ora::Illegal:updateOrgForPlayer",
    function()
        local _source = source
        TriggerClientEvent("Ora::Illegal:updateCurrentOrga", _source, organisation)
    end
)

RegisterServerEvent("Ora::Illegal:leaveOrg")
AddEventHandler(
    "Ora::Illegal:leaveOrg",
    function(organisation)
        local _source = source
        local myUuid = getPlayerUuid(_source)

        if (organisation.OWNER == myUuid) then
          TriggerClientEvent("RageUI:Popup", _source, {message = "~h~~r~Vous êtes le propriétaire de la faction. Supprimez la faction.~s~"})
        else
          MySQL.Async.execute(
              "DELETE FROM organisation_member where uuid = @uuid AND organisation_id = @organisationId",
              {
                  ["@uuid"] = myUuid,
                  ["@organisationId"] = organisation.ID
              },
              function (affectedRows)
                  if (affectedRows > 0) then
                    TriggerClientEvent("RageUI:Popup", _source, {message = "~g~Vous avez quitté l'organisation ~h~" .. organisation.NAME .."~h~.~s~"})
                      TriggerClientEvent("Ora::Illegal:updateCurrentOrga", _source, IllegalOrga.GetEmptyOrga())
                      updateOrganisationToAllClient(organisation.ID)
                      TriggerEvent("Ora:sendToDiscordFromServer", _source, 20, Ora.Identity:GetFullname(_source) .. " a quitté la faction ".. organisation.NAME .." (" .. organisation.LABEL ..")", "info")

                  else
                    TriggerClientEvent("RageUI:Popup", _source, {message = "~r~Une erreur s'est produite lors de votre départ de la faction.~s~"})
                  end
              end
          )
        end
    end
)

RegisterServerEvent("Ora::PlayerLoaded")
AddEventHandler(
    "Ora::PlayerLoaded",
    function(uuid)
        local _source = source
        local orga = getOrgaForUuid(uuid)
        TriggerClientEvent("Ora::Illegal:updateCurrentOrga", _source, orga)
    end
)

RegisterServerEvent("Ora::ServerSidePlayerLoaded")
AddEventHandler(
    "Ora::ServerSidePlayerLoaded",
    function(source, uuid)
        local _source = source
        local orga = getOrgaForUuid(uuid)
        TriggerClientEvent("Ora::Illegal:setOrgaObject", _source, orga)
    end
)

RegisterServerEvent("Ora::Illegal:updateOrgaForAllClient")
AddEventHandler(
    "Ora::Illegal:updateOrgaForAllClient",
    function(organisationId)
        updateOrganisationToAllClient(organisationId)
    end
)


RegisterServerEvent("Ora::Illegal:setupOrgaForAllClient")
AddEventHandler(
    "Ora::Illegal:setupOrgaForAllClient",
    function(organisationId)
        setupOrganisationToAllClient(organisationId)
    end
)

RegisterServerEvent("Ora::Illegal:sendMessageToOrga")
AddEventHandler(
    "Ora::Illegal:sendMessageToOrga",
    function(organisationId, message)
        sendMessageToOnlineMembers(organisationId, message)
    end
)

RegisterServerEvent("Ora::Illegal:setCoordsToOrga")
AddEventHandler(
    "Ora::Illegal:setCoordsToOrga",
    function(organisationId, coords)
        setCoordsToOnlineMembers(organisationId, coords)
    end
)

RegisterServerCallback("Ora:getMyUuid", 
  function(source, cb)
    local playerUuid = getPlayerUuid(source)
    cb(playerUuid)
  end
)

RegisterServerCallback("Ora:Illegal:GetOnlinePlayersCountForFaction", 
  function(source, cb, organisationId)
    local organisationOnlineMember = getOrganisationOnlineMembers(organisationId)
    cb(#organisationOnlineMember)
  end
)

RegisterServerCallback("Ora:Illegal:getAllOrga", 
  function(source, cb)
    local organisations = MySQL.Sync.fetchAll(
        "SELECT * FROM organisation ORDER BY label ASC",
        {}
    )
    cb(json.encode(organisations))
  end
)
