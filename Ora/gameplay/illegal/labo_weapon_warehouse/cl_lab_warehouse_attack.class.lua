LabsAndWarehouseAttack = LabsAndWarehouseAttack or {}

LabsAndWarehouseAttack.CURRENT_ATTACK = {}
LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY = {
  ALERT_MESSAGE_DISPLAYED = false,
  NO_POLICE_CALL = false,
  TIMEBARS_DISPLAYED = false,
  MARKER_DISPLAYED = false,
  MARKER_SHOULD_BE_DISPLAYED = false,
  START_TIME_LOCAL = false
}


-- Handler for current attack update. 
RegisterNetEvent("Ora::Illegal:updateCurrentAttack")
AddEventHandler(
    "Ora::Illegal:updateCurrentAttack",
    function(currentAttackAsJson)
        local currentAttack = json.decode(currentAttackAsJson)
        LabsAndWarehouseAttack.CURRENT_ATTACK = currentAttack
        LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.MARKER_SHOULD_BE_DISPLAYED = true
        LabsAndWarehouseAttack.SetPlayerNoCallPolice(true)
        LabsAndWarehouseAttack.DisplayWarzone(currentAttack)
        LabsAndWarehouseAttack.StartTimeBar(currentAttack)
        LabsAndWarehouseAttack.DisplayAlertMessage(currentAttack)
    end
)

-- Handler for current attack update. 
RegisterNetEvent("Ora::Illegal:IsInWarzone")
AddEventHandler(
    "Ora::Illegal:IsInWarzone",
    function(verificationAsJson)
        local verification = json.decode(verificationAsJson)
        local ped = LocalPlayer().Ped
        local pedCoords = GetEntityCoords(ped)
        local warzone = verification.warzone
        local distance = GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, warzone.x, warzone.y, warzone.z, false)
        if (distance < verification.distance) then
            local args = {ORGANISATION = IllegalOrga.CURRENT_ORGA, PROPERTY_ID = LabsAndWarehouseAttack.CURRENT_ATTACK.PROPERTY.id, ATTACK = LabsAndWarehouseAttack.CURRENT_ATTACK, DISTANCE = distance}
            TriggerServerEvent(verification.serverEventName, json.encode(args))
        end
    end
)

-- Handler for current attack update. 
RegisterNetEvent("Ora::Illegal:StartAttack")
AddEventHandler(
    "Ora::Illegal:StartAttack",
    function(currentAttackAsJson)
        local currentAttack = json.decode(currentAttackAsJson)
        LabsAndWarehouseAttack.CURRENT_ATTACK = currentAttack
        LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.MARKER_SHOULD_BE_DISPLAYED = true
        LabsAndWarehouseAttack.SetPlayerNoCallPolice(true)
        LabsAndWarehouseAttack.DisplayWarzone(currentAttack)
        LabsAndWarehouseAttack.StartTimeBar(currentAttack)
        LabsAndWarehouseAttack.DisplayAlertMessage(currentAttack)

      
    end
)

-- Handler for current attack update. 
RegisterNetEvent("Ora::Illegal:EndAttack")
AddEventHandler(
    "Ora::Illegal:EndAttack",
    function()
        LabsAndWarehouseAttack.CURRENT_ATTACK = {}
        LabsAndWarehouseAttack.SetPlayerNoCallPolice(false)
        LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY = {
            ALERT_MESSAGE_DISPLAYED = false,
            NO_POLICE_CALL = false,
            TIMEBARS_DISPLAYED = false,
            MARKER_DISPLAYED = false,
            MARKER_SHOULD_BE_DISPLAYED = false,
            START_TIME_LOCAL = false
        }
    end
)

local isLoading = false
local currentXL

function LabsAndWarehouseAttack.DisplayAlertMessage()
    if (LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.ALERT_MESSAGE_DISPLAYED == false) then
        ShowNotification("~b~Votre faction a un evenement illégal en cours.~s~")
        LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.ALERT_MESSAGE_DISPLAYED = true
    end
end

function LabsAndWarehouseAttack.SetPlayerNoCallPolice(noCallPolice)
    LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.NO_POLICE_CALL = noCallPolice
end

function LabsAndWarehouseAttack.GetPlayerNoCallPolice()
  return LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.NO_POLICE_CALL
end

function LabsAndWarehouseAttack.StartTimeBar(currentAttack)

  if (LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.START_TIME_LOCAL == false) then
      LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.START_TIME_LOCAL = GetGameTimer()
  end

  if (LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.TIMEBARS_DISPLAYED == false) then
      Citizen.CreateThread(function()
          scaleform = RequestScaleformMovie_2("INSTRUCTIONAL_BUTTONS")
          local hPQ, R1FIoQI, NsoTwDs, HGli = .925, .975, .14, .03
          local iy = {".", "..", "...", ""}
          repeat Wait(0) until HasScaleformMovieLoaded(scaleform)

          while true do Wait(0)
              if renderScaleform == true then
                  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
              end
              
              local futurExpiration = 0
              if (LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.START_TIME_LOCAL ~= false) then
                futurExpiration = (currentAttack.SECONDS_LEFT * 1000) + LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.START_TIME_LOCAL
              end

              local timeleft = (futurExpiration - GetGameTimer()) / 1000
              local barCount = {1}

              if LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.TIMEBARS_DISPLAYED == true and timeleft ~= nil then
                  if timeleft > 0 then
                      DrawCenterText(
                            string.format(
                                "Vous êtes en train de %s la zone...",
                                LabsAndWarehouseAttack.CURRENT_ATTACK.ATTACKER_ORGA_ID == IllegalOrga.CURRENT_ORGA.ID and "capturer" or "défendre"
                            ),
                            0
                      )
                      DrawNiceText(
                        hPQ,
                        R1FIoQI - .05,
                        .5,
                        string.format("TEMPS RESTANT : "..s2m(timeleft)),
                        4,
                        0
                    )
                  end
              end

              if timeleft < 0 or LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.TIMEBARS_DISPLAYED == false then
                  break
              end
          end
      end)
    
      LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.TIMEBARS_DISPLAYED = true
  end
end

function LabsAndWarehouseAttack.DisplayWarzone(currentAttack)
    if (LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.MARKER_DISPLAYED == false) then
        Citizen.CreateThread(function()
            while LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.MARKER_SHOULD_BE_DISPLAYED do
                Wait(0)
                DrawMarker(
                    1,
                    currentAttack.PROPERTY.outside_door.x,
                    currentAttack.PROPERTY.outside_door.y,
                    currentAttack.PROPERTY.outside_door.z - 30.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    115.0,
                    115.0,
                    150.0,
                    237,
                    36,
                    42,
                    70
              ) 
            end
        end)
      
        LabsAndWarehouseAttack.CURRENT_ATTACK_DISPLAY.MARKER_DISPLAYED = true
    end
end

function LabsAndWarehouseAttack.GetNearbyIllegalProperties(position)
    if (LabsAndWarehouseAttack.ILLEGAL_PROPERTIES ~= nil and LabsAndWarehouseAttack.ILLEGAL_PROPERTIES.LOADED == false) then
        local canSend = false
        LabsAndWarehouseAttack.ILLEGAL_PROPERTIES.LIST = {}

        TriggerServerCallback("Ora:Illegal:GetIllegalProperties", function(illegalPropertiesAsJson)
            canSend = true
            LabsAndWarehouseAttack.ILLEGAL_PROPERTIES.LIST = json.decode(illegalPropertiesAsJson)
            LabsAndWarehouseAttack.ILLEGAL_PROPERTIES.LOADED = true
        end)
        
        while (canSend == false) do
            Wait(100)      
        end
    
    end

    for index, value in pairs(LabsAndWarehouseAttack.ILLEGAL_PROPERTIES.LIST) do
        if (GetDistanceBetweenCoords(position, value.outside_door.x, value.outside_door.y, value.outside_door.z, true) < LabsAndWarehouseAttack.MAX_DISTANCE_NEAR_MOLOTOV) then
            return value
        end
    end

    return nil
end

function LabsAndWarehouseAttack.GetOnlinePlayersCountForFaction(organisationId)
    local canSend = false
    local onlineMembersCount = 0
    TriggerServerCallback("Ora:Illegal:GetOnlinePlayersCountForFaction", function(onlineMembersCountFromCallback)
      canSend = true
      onlineMembersCount = onlineMembersCountFromCallback
    end, organisationId)
    
    while (canSend == false) do
      Wait(100)      
    end

    return onlineMembersCount
end

function LabsAndWarehouseAttack.StartAttack(illegalProperty)
    if (IllegalOrga.CURRENT_ORGA ~= nil and IllegalOrga.GetId() ~= nil) then
        if (illegalProperty.organisation_id == IllegalOrga.GetId()) then
            ShowNotification("~r~Vous ne pouvez pas vous attaquer vous même.\nVotre molotov est remboursé~s~")
            Ora.Inventory:AddItem({name = "molotov", data = {}})
        elseif (illegalProperty.last_attacked_at ~= nil and math.tointeger(illegalProperty.last_attacked_at) > illegalProperty.today) then
            ShowNotification("~r~Cette propriété a été attaquée il y a moins de 2 semaines.\nVotre molotov est remboursé~s~")
            Ora.Inventory:AddItem({name = "molotov", data = {}})           
        else
            local onlineMembers = LabsAndWarehouseAttack.GetOnlinePlayersCountForFaction(illegalProperty.organisation_id)

            if (onlineMembers == nil) then
              onlineMembers = 0
            end

            if (onlineMembers < LabsAndWarehouseAttack.MIN_ONLINE_MEMBERS_TO_ATTACK) then
                ShowNotification("~r~Cette action n'est pas réalisable pour le moment.\nVotre molotov est remboursé~s~")
                Ora.Inventory:AddItem({name = "molotov", data = {}})
                return
            else
              TriggerServerEvent("Ora::Illegal:StartAttack", {DEFENDER = illegalProperty.organisation_id, ATTACKER = IllegalOrga.GetId(), PROPERTY = illegalProperty, GAMETIMER = GetGameTimer()})
            end
        end
    else
        ShowNotification("~r~Vous ne faites pas parti d'une faction. Vous ne pouvez pas attaquer seul.~s~")
        ShowNotification("~r~Votre molotov est remboursé~s~")
        Ora.Inventory:AddItem({name = "molotov", data = {}})
    end
end

function LabsAndWarehouseAttack.RaidedByPolice(illegalProperty)
    if (IllegalOrga.CURRENT_ORGA ~= nil and IllegalOrga.GetId() ~= nil) then
        if (illegalProperty.organisation_id == IllegalOrga.GetId()) then
            ShowNotification("~r~Vous ne pouvez pas vous raider vous même.~s~")        
        else
            TriggerServerEvent("Ora::Illegal:ChangeOwnerOfPropertyByPolice", {old_owner = illegalProperty.organisation_id, new_owner = IllegalOrga.GetId(), property_id = illegalProperty.id})
            ShowNotification("~g~Vous avez défoncé la porte de la propriété ".. illegalProperty.name ..".~s~")
        end
    else
        ShowNotification("~r~Vous ne faites pas parti d'une faction. Vous ne pouvez pas attaquer seul.~s~")
    end
end

CreateThread(
    function()
        while true do
            Wait(1000)
            if (IllegalOrga.CURRENT_ORGA ~= nil and IllegalOrga.GetId() ~= nil) then
                local playerPed = LocalPlayer().Ped
                if IsPedArmed(playerPed, 6) then
                    local selectedWeapon = GetSelectedPedWeapon(playerPed)
                    if selectedWeapon == GetHashKey("WEAPON_MOLOTOV") then
                        if not isLoading then
                            isLoading = true
                            CreateThread(
                                function()
                                    while isLoading and not currentXL do
                                        Wait(0)
                                        local projectilePosition = GetEntityCoords(playerPed) + (GetEntityForwardVector(playerPed) * 5)

                                        if (IsPedShooting(playerPed) and GetSelectedPedWeapon(playerPed) == GetHashKey("WEAPON_MOLOTOV")) then
                                            local illegalProperty = LabsAndWarehouseAttack.GetNearbyIllegalProperties(projectilePosition)

                                            if (illegalProperty ~= nil) then
                                                LabsAndWarehouseAttack.StartAttack(illegalProperty)
                                            end

                                            isLoading = false
                                            currentXL = nil
                                            break
                                        end
                                    end
                                end
                            )
                        end
                    elseif selectedWeapon == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
                        if not isLoading then
                            isLoading = true
                            CreateThread(
                                function()
                                while isLoading and not currentXL do
                                    Wait(0)
                                        if (IsPedShooting(playerPed) and GetSelectedPedWeapon(playerPed) == GetHashKey("WEAPON_BULLPUPSHOTGUN")) then
                                            local illegalProperty = LabsAndWarehouseAttack.GetNearbyIllegalProperties(LocalPlayer().Pos)
                                            if (illegalProperty ~= nil) then
                                                LabsAndWarehouseAttack.RaidedByPolice(illegalProperty)
                                                isLoading = false
                                                currentXL = nil
                                                break
                                            end
                                        end

                                    end
                                end
                            )
                        end
                    elseif isLoading then
                        isLoading = false
                        currentXL = nil
                    end
                end
            end
        end
    end
)