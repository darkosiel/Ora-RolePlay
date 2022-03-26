LabsAndWarehouseAttack = LabsAndWarehouseAttack or {}

LabsAndWarehouseAttack.ATTACKS = {}
LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS = {}

Citizen.CreateThread(
  function()
      while (true) do
          -- Every 10 secondes update attack object
          Citizen.Wait(1000 * 5)
          
          for index, value in pairs(LabsAndWarehouseAttack.ATTACKS) do 

              if (value.STATUS == "running") then
                local propertyId = index
                local defenderOrganisationId = value.DEFENDER_ORGA_ID
                local attackerOrganisationId = value.ATTACKER_ORGA_ID
                local property = value.PROPERTY
  
                local defenders = IllegalOrga.GetOrganisationOnlineMembers(defenderOrganisationId)
                local attackers = IllegalOrga.GetOrganisationOnlineMembers(attackerOrganisationId)
  
                for defIndex, defValue in pairs(defenders) do
                    if (LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[defValue.uuid] == nil) then 
                        LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[defValue.uuid] = {alive = true, fullname = defValue.fullname, organisation_id = value.DEFENDER_ORGA_ID, property_id = propertyId}
                        TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[defValue.uuid].organisation_id, "~h~" .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[defValue.uuid].fullname .. "~h~ a rejoint le combat.")
                        TriggerEvent("atlantiss:sendToDiscordFromServer", 999999, 24, "[ATTAQUE #" .. propertyId .. "]\n"..  defValue.fullname .. " a été ajouté dans l'équipe de défense", "info")
                    end
                end
  
                for attIndex, attValue in pairs(attackers) do
                    if (LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[attValue.uuid] == nil) then 
                        LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[attValue.uuid] = {alive = true, fullname = attValue.fullname, organisation_id = value.ATTACKER_ORGA_ID, property_id = propertyId}
                        TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[attValue.uuid].organisation_id, "~h~" .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[attValue.uuid].fullname .. "~h~ a rejoint le combat.")
                        TriggerEvent("atlantiss:sendToDiscordFromServer", 999999, 24, "[ATTAQUE #" .. propertyId .. "]\n"..  attValue.fullname .. " a été ajouté dans l'équipe d'attaque", "info")
                    end
                end
  
                LabsAndWarehouseAttack.ATTACKS[propertyId] = {
                    PROPERTY = property,
                    LAUNCHER = value.LAUNCHER,
                    DEFENDER_ORGA_ID = defenderOrganisationId,
                    ATTACKER_ORGA_ID = attackerOrganisationId,
                    DEFENDERS = defenders,
                    ATTACKERS = attackers,
                    STATUS = value.STATUS,
                    STARTED_AT = value.STARTED_AT,
                    SCHEDULED_END_AT = value.SCHEDULED_END_AT,
                    SECONDS_LEFT = (value.SCHEDULED_END_AT - os.time()),
                    FINAL_ALIVE_DEFENDER_IN_ZONE = 0,
                    FINAL_ALIVE_ATTACKER_IN_ZONE = 0
                }
  

                if (LabsAndWarehouseAttack.ATTACKS[propertyId].SECONDS_LEFT <= 0) then
                  LabsAndWarehouseAttack.ATTACKS[propertyId].STATUS = "finished"
                  print("[ATTACK FINISHED] : ATTACK ON PROPERTY ID " .. propertyId .. " FINISHED")
                  LabsAndWarehouseAttack.EndAttack(propertyId)
                else
                    IllegalOrga.TriggerClientEvent("Atlantiss::Illegal:updateCurrentAttack", defenderOrganisationId, json.encode(LabsAndWarehouseAttack.ATTACKS[propertyId]))
                    IllegalOrga.TriggerClientEvent("Atlantiss::Illegal:updateCurrentAttack", attackerOrganisationId, json.encode(LabsAndWarehouseAttack.ATTACKS[propertyId]))
                end
              end
          end
      end
  end
)

function LabsAndWarehouseAttack.AnalyzeResults(propertyId)
    if (LabsAndWarehouseAttack.ATTACKS[propertyId] ~= nil) then
        local attackObject = LabsAndWarehouseAttack.ATTACKS[propertyId]
        if (attackObject.FINAL_ALIVE_ATTACKER_IN_ZONE == 0) then
          -- Defender wins
          TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackObject.DEFENDER_ORGA_ID, "~g~Félicitations, vous avez sauvez votre propriété.")
          TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackObject.ATTACKER_ORGA_ID, "~r~Dommage, vous n'avez pas réussi a capturer. Vous n'avez plus de membres vivants.")
          TriggerEvent("atlantiss:sendToDiscordFromServer", 999999, 24, "[ATTAQUE #" .. propertyId .. "]\nles défenseurs gagnent (plus aucun attaquant vivant dans la zone de capture)", "info")

        elseif (attackObject.FINAL_ALIVE_ATTACKER_IN_ZONE > attackObject.FINAL_ALIVE_DEFENDER_IN_ZONE) then
          -- Attackers wins
          TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackObject.DEFENDER_ORGA_ID, "~r~Dommage, vous n'avez pas réussi a défendre (" .. attackObject.FINAL_ALIVE_ATTACKER_IN_ZONE .. " adversaires dans la zone vivants).")
          TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackObject.ATTACKER_ORGA_ID, "~g~Félicitations, vous avez capturé la propriété. C'est désormais la votre.")
          TriggerEvent("Atlantiss::Illegal:ChangeOwnerOfProperty", {property_id = propertyId, old_owner = attackObject.DEFENDER_ORGA_ID, new_owner = attackObject.ATTACKER_ORGA_ID})
          TriggerEvent("atlantiss:sendToDiscordFromServer", 999999, 24, "[ATTAQUE #" .. propertyId .. "]\nles attaquants gagnent (Plus d'attaquants que de defenseurs encore vivant sur place)", "info")
        elseif (attackObject.FINAL_ALIVE_ATTACKER_IN_ZONE == attackObject.FINAL_ALIVE_DEFENDER_IN_ZONE) then
          -- Defender wins
          TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackObject.DEFENDER_ORGA_ID, "~g~Félicitations, vous avez sauvez votre propriété.")
          TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackObject.ATTACKER_ORGA_ID, "~r~Dommage, vous n'avez pas réussi a capturer (Autant de vivants de chaque côté).")
          TriggerEvent("atlantiss:sendToDiscordFromServer", 999999, 24, "[ATTAQUE #" .. propertyId .. "]\nles defenseurs gagnent (autant d'attaquants, que de defenseurs vivants sur place)", "info")

        else
          -- Defender wins
          TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackObject.DEFENDER_ORGA_ID, "~g~Félicitations, vous avez sauvez votre propriété.")
          TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackObject.ATTACKER_ORGA_ID, "~r~Dommage, vous n'avez pas réussi a capturer (" .. attackObject.FINAL_ALIVE_DEFENDER_IN_ZONE .. " adversaires dans la zone vivants).")
          TriggerEvent("atlantiss:sendToDiscordFromServer", 999999, 24, "[ATTAQUE #" .. propertyId .. "]\nles defenseurs gagnent (moins d'attaquants que de defenseurs vivants sur place)", "info")
        end

        IllegalOrga.TriggerClientEvent("Atlantiss::Illegal:EndAttack", attackObject.DEFENDER_ORGA_ID)
        IllegalOrga.TriggerClientEvent("Atlantiss::Illegal:EndAttack", attackObject.ATTACKER_ORGA_ID)
        LabsAndWarehouseAttack.ATTACKS[propertyId] = nil
    end
    
end

function LabsAndWarehouseAttack.EndAttack(propertyId)
    if (LabsAndWarehouseAttack.ATTACKS[propertyId] ~= nil) then
      print("[ATTACK DEFINING WINNER] : ATTACK ON PROPERTY ID " .. propertyId .. " IS BEING ANALYZED")

      local defenderOrganisationId = LabsAndWarehouseAttack.ATTACKS[propertyId].DEFENDER_ORGA_ID
      local attackerOrganisationId = LabsAndWarehouseAttack.ATTACKS[propertyId].ATTACKER_ORGA_ID
      
      local verificationObjectForAttacker = {
        warzone = {x = LabsAndWarehouseAttack.ATTACKS[propertyId].PROPERTY.outside_door.x, y = LabsAndWarehouseAttack.ATTACKS[propertyId].PROPERTY.outside_door.y, z = LabsAndWarehouseAttack.ATTACKS[propertyId].PROPERTY.outside_door.z},
        distance = LabsAndWarehouseAttack.MAX_DISTANCE_FIGHT,
        serverEventName = "Atlantiss::Illegal:SEAttackerCount",
      }

      local verificationObjectForDefender = {
        warzone = {x = LabsAndWarehouseAttack.ATTACKS[propertyId].PROPERTY.outside_door.x, y = LabsAndWarehouseAttack.ATTACKS[propertyId].PROPERTY.outside_door.y, z = LabsAndWarehouseAttack.ATTACKS[propertyId].PROPERTY.outside_door.z},
        distance = LabsAndWarehouseAttack.MAX_DISTANCE_FIGHT,
        serverEventName = "Atlantiss::Illegal:SEDefenderCount",
      }


      TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackerOrganisationId, "~b~L'attaque est terminée. Patientez 15 secondes pendant le calcul de la victoire.")
      TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", defenderOrganisationId, "~b~L'attaque est terminée. Patientez 15 secondes pendant le calcul de la victoire.")
      
      IllegalOrga.TriggerClientEvent("Atlantiss::Illegal:IsInWarzone", attackerOrganisationId, json.encode(verificationObjectForAttacker))
      IllegalOrga.TriggerClientEvent("Atlantiss::Illegal:IsInWarzone", defenderOrganisationId, json.encode(verificationObjectForDefender))
      TriggerEvent("atlantiss:sendToDiscordFromServer", 999999, 24, "[ATTAQUE #" .. propertyId .. "]\n" .. "L'attaque est terminée calcul du résultat en cours.", "info")

      Wait(1000 * 15)

      LabsAndWarehouseAttack.AnalyzeResults(propertyId)
    else
        print("[ATTACK ERROR] : ATTACK ON PROPERTY ID " .. propertyId .. " DOES NOT EXIST")
    end
end

RegisterServerEvent("Atlantiss::Illegal:SEDefenderCount")
AddEventHandler("Atlantiss::Illegal:SEDefenderCount",function(resultsAsJson)
    local _source = source
    local uuid = IllegalOrga.GetPlayerUuid(_source)
    local results = json.decode(resultsAsJson)
    if (LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid] ~= nil) then 
      if (LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].alive == true) then
          LabsAndWarehouseAttack.ATTACKS[results.PROPERTY_ID].FINAL_ALIVE_DEFENDER_IN_ZONE = LabsAndWarehouseAttack.ATTACKS[results.PROPERTY_ID].FINAL_ALIVE_DEFENDER_IN_ZONE + 1
          TriggerEvent("atlantiss:sendToDiscordFromServer", 999999, 24, "[ATTAQUE #" .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].property_id .. "]\n" .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].fullname .. "(organisation id = " .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].organisation_id .. ") est comptabilisé dans les défenseurs vivants", "info")
      end
    end
end)

RegisterServerEvent("Atlantiss::Illegal:SEAttackerCount")
AddEventHandler("Atlantiss::Illegal:SEAttackerCount",function(resultsAsJson)
    local _source = source
    local uuid = IllegalOrga.GetPlayerUuid(_source)
    local results = json.decode(resultsAsJson)
    if (LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid] ~= nil) then 
        if (LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].alive == true) then
          LabsAndWarehouseAttack.ATTACKS[results.PROPERTY_ID].FINAL_ALIVE_ATTACKER_IN_ZONE = LabsAndWarehouseAttack.ATTACKS[results.PROPERTY_ID].FINAL_ALIVE_ATTACKER_IN_ZONE + 1
          TriggerEvent("atlantiss:sendToDiscordFromServer", 999999, 24, "[ATTAQUE #" .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].property_id .. "]\n" .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].fullname .. "(organisation id = " .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].organisation_id .. ") est comptabilisé dans les attaquants vivants", "info")
        end
    end
end)

RegisterServerEvent("Atlantiss::Illegal:PlayerIsDead")
AddEventHandler("Atlantiss::Illegal:PlayerIsDead",function()
    local _source = source
    local uuid = IllegalOrga.GetPlayerUuid(_source)
    if (LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid] ~= nil) then 
        if (LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].alive == true) then
          LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].alive = false
          TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].organisation_id, "~h~" .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].fullname .. "~h~ n'est plus dans le combat.")
          TriggerEvent("atlantiss:sendToDiscordFromServer", 999999, 24, "[ATTAQUE #" .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].property_id .. "]\n" .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].fullname .. " (organisation id = " .. LabsAndWarehouseAttack.CURRENT_MONITORED_PLAYERS[uuid].organisation_id .. ") est mort au combat", "info")
        end
    end
end)


RegisterServerEvent("Atlantiss::Illegal:StartAttack")
AddEventHandler("Atlantiss::Illegal:StartAttack",function(attackObject)
    local _source = source
    if (LabsAndWarehouseAttack.ATTACKS[attackObject.PROPERTY.id] ~= nil) then
      TriggerClientEvent("Atlantiss::Illegal:ShowNotification", _source, "~r~Une attaque sur la propriété ".. attackObject.PROPERTY.name .." est déjà en cours~s~")
      TriggerEvent("atlantiss:sendToDiscordFromServer", _source, 24, "[ATTAQUE #" .. attackObject.PROPERTY.id .. "]\n" .. Atlantiss.Identity:GetFullname(_source) .. " tente de lancer une attaque sur " .. attackObject.PROPERTY.name .. " mais une attaque est déjà en cours sur ce batiment", "info")
      return false
    end

    local defenderOrganisationId = attackObject.DEFENDER
    local attackerOrganisationId = attackObject.ATTACKER
    local timeToHoldInSeconds = IllegalLabsAndWarehouse.GetAttackTotalTime(attackObject.PROPERTY.business_id, attackObject.PROPERTY.security_level)


    TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", defenderOrganisationId, "La propriété ~h~" .. attackObject.PROPERTY.name .. "~h~ est attaquée ! Depechez vous de venir sur place.")
    TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", defenderOrganisationId, "Vous avez désormais ".. math.tointeger(timeToHoldInSeconds / 60) .." minutes pour sécuriser la zone.")
    TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackerOrganisationId, "Vous attaquez la propriété ~h~" .. attackObject.PROPERTY.name .. "~h~")
    TriggerEvent("Atlantiss::Illegal:sendMessageToOrga", attackerOrganisationId, "Tenez la position pendant ".. math.tointeger(timeToHoldInSeconds / 60) .." minutes.")
    TriggerEvent("Atlantiss::Illegal:setCoordsToOrga", attackerOrganisationId, vector3(attackObject.PROPERTY.outside_door.x, attackObject.PROPERTY.outside_door.y, attackObject.PROPERTY.outside_door.z))
    TriggerEvent("Atlantiss::Illegal:setCoordsToOrga", defenderOrganisationId, vector3(attackObject.PROPERTY.outside_door.x, attackObject.PROPERTY.outside_door.y, attackObject.PROPERTY.outside_door.z))


    local defenders = IllegalOrga.GetOrganisationOnlineMembers(defenderOrganisationId)
    local attackers = IllegalOrga.GetOrganisationOnlineMembers(attackerOrganisationId)

    local startedAt = os.time()
    local scheduledEndAt = os.time() + (timeToHoldInSeconds)

    local organisationProperty = MySQL.Sync.execute(
        "UPDATE organisation_property SET last_attacked_at = @last_attacked_at WHERE id = @propertyId",
        {
          ['@propertyId'] = attackObject.PROPERTY.id,
          ['@last_attacked_at'] = os.time() + (86400*14)
        }
    )

    LabsAndWarehouseAttack.ATTACKS[attackObject.PROPERTY.id] = {
        PROPERTY = attackObject.PROPERTY,
        LAUNCHER = IllegalOrga.GetPlayerUuid(_source),
        DEFENDER_ORGA_ID = defenderOrganisationId,
        ATTACKER_ORGA_ID = attackerOrganisationId,
        DEFENDERS = defenders,
        ATTACKERS = attackers,
        STATUS = "running",
        STARTED_AT = startedAt,
        SCHEDULED_END_AT = scheduledEndAt,
        SECONDS_LEFT = (scheduledEndAt - startedAt),
        FINAL_ALIVE_DEFENDER_IN_ZONE = 0,
        FINAL_ALIVE_ATTACKER_IN_ZONE = 0
    }

    IllegalOrga.TriggerClientEvent("Atlantiss::Illegal:StartAttack", defenderOrganisationId, json.encode(LabsAndWarehouseAttack.ATTACKS[attackObject.PROPERTY.id]))
    IllegalOrga.TriggerClientEvent("Atlantiss::Illegal:StartAttack", attackerOrganisationId, json.encode(LabsAndWarehouseAttack.ATTACKS[attackObject.PROPERTY.id]))
    TriggerEvent("atlantiss:sendToDiscordFromServer", _source, 24, "[ATTAQUE #" .. attackObject.PROPERTY.id .. "]\n" .. Atlantiss.Identity:GetFullname(_source) .. " vient d'attaquer la propriété " .. attackObject.PROPERTY.name .. ".", "info")
end)