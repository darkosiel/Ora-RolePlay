AtlantissAdmin = AtlantissAdmin or {}
AtlantissAdmin.DISPLAY_NAMES = false
AtlantissAdmin.PLAYERS_TAG = {}
AtlantissAdmin.UUIDS_DISPLAYED = {}
AtlantissAdmin.PLAYERS = {}

AtlantissAdmin.TAGS = {
    GAMER_NAME = 0,
    CREW_TAG = 1,
    healthArmour = 2,
    BIG_TEXT = 3,
    AUDIO_ICON = 4,
    MP_USING_MENU = 5,
    MP_PASSIVE_MODE = 6,
    WANTED_STARS = 7,
    MP_DRIVER = 8,
    MP_CO_DRIVER = 9,
    MP_TAGGED = 10,
    GAMER_NAME_NEARBY = 11,
    ARROW = 12,
    MP_PACKAGES = 13,
    INV_IF_PED_FOLLOWING = 14,
    RANK_TEXT = 15,
    MP_TYPING = 16
}

TagColors = {
    ["animator"] = 200,
    ["superadmin"] = 18
}

TriggerServerCallback("Atlantiss::SE:Admin:AmIAdmin?", 
    function(bool, baseUsersAsJson) 
        if (bool) then

            local baseUsers = json.decode(baseUsersAsJson)

            for index, value in pairs(baseUsers) do
                AtlantissAdmin.PLAYERS[tostring(value.id)] = value
            end
        end
    end,
    {GET_ALL_USERS = true}
)


function AtlantissAdmin.GetPlayerInfoByServerId(playerId)

    if (AtlantissAdmin.PLAYERS[playerId] ~= nil) then
        return AtlantissAdmin.PLAYERS[tostring(playerId)]
    end

    return false
end

function AtlantissAdmin.DisplayPlayerNames()
    local playerPosition = GetEntityCoords(PlayerPedId())
    AtlantissAdmin.UUIDS_DISPLAYED = {}
    AtlantissAdmin.NO_INFOS = {}
    
    for index, userId in pairs(GetActivePlayers()) do 
        local playerServerId = GetPlayerServerId(userId)
        local playerServerIdToString = tostring(playerServerId)

        if playerServerIdToString ~= tostring(GetPlayerServerId(PlayerId())) then
            local otherPlayerPed = GetPlayerPed(userId)
            local playerInformation = AtlantissAdmin.GetPlayerInfoByServerId(playerServerIdToString)
            if (playerInformation == false or playerInformation == nil or playerInformation.uuid == nil) then
                print("No Player Information, nor UUID")
                table.insert(AtlantissAdmin.NO_INFOS, playerServerId)
            else
                local gamerTag = AtlantissAdmin.PLAYERS_TAG[playerInformation.uuid]
                AtlantissAdmin.UUIDS_DISPLAYED[playerInformation.uuid] = true

                if (otherPlayerPed ~= 0) then
                    if not gamerTag or (gamerTag.tag and not IsMpGamerTagActive(gamerTag.tag)) then
                        local displayName = "[" .. playerServerId .. "] NON CONNU PAR LE SERVEUR"
                        if (playerInformation ~= nil and playerInformation.name ~= nil) then
                            displayName = playerInformation.name
                        end
                        local gamerTagLocal =
                            CreateFakeMpGamerTag(
                            otherPlayerPed,
                            displayName,
                            false,
                            false,
                            "",
                            0
                        )
                        SetMpGamerTagVisibility(gamerTagLocal, AtlantissAdmin.TAGS.GAMER_NAME, true)
                        SetMpGamerTagVisibility(gamerTagLocal, AtlantissAdmin.TAGS.healthArmour, true)
        
                        if playerInformation and playerInformation.group and playerInformation.group ~= "user" then
                            SetMpGamerTagColour(gamerTagLocal, 0, TagColors[playerInformation.group])
                        end
                        SetMpGamerTagAlpha(gamerTagLocal, AtlantissAdmin.TAGS.healthArmour, 255)
                        AtlantissAdmin.PLAYERS_TAG[playerInformation.uuid] = {tag = gamerTagLocal, ped = otherPlayerPed}
                    else
                        local gamerTagLocal = gamerTag.tag
                        if playerInformation and playerInformation.name then
                            SetMpGamerTagName(gamerTagLocal, playerInformation.name)
                        end
                    end
                else
                    if (gamerTag ~= nil and gamerTag.tag ~= nil) then
                        RemoveMpGamerTag(gamerTag.tag)
                        AtlantissAdmin.PLAYERS_TAG[playerInformation.uuid] = nil
                    end
                end
            end
        end
    end

    -- Find batched identities
    AtlantissAdmin.RetrieveMissingTags(AtlantissAdmin.NO_INFOS)

    for uuidIndex, uuidValue in pairs(AtlantissAdmin.PLAYERS_TAG) do
        if (AtlantissAdmin.UUIDS_DISPLAYED[uuidIndex] == nil) then
            RemoveMpGamerTag(uuidValue.tag)
            AtlantissAdmin.PLAYERS_TAG[uuidIndex] = nil
        end
    end
end

function AtlantissAdmin.RetrieveMissingTags(playersIds)
    local canSend = false
    local identities = {}

    TriggerServerCallback("Atlantiss::SE::Admin:GetMpTagsIdentityForPlayers", function(dataAsJson)
      identities = json.decode(dataAsJson)
      canSend = true
    end, playersIds)
    
    while (canSend == false) do
      Wait(100)      
    end

    for key, value in pairs(identities) do
        AtlantissAdmin.PLAYERS[tostring(value.id)] = value
    end
end

function AtlantissAdmin.HandlePlayersNames()
    if AtlantissAdmin.DISPLAY_NAMES then
        CreateThread(
            function()
                while AtlantissAdmin.DISPLAY_NAMES do
                    AtlantissAdmin.DisplayPlayerNames()
                    Wait(5000)
                end
            end
        )
    else
        for index, value in pairs(AtlantissAdmin.PLAYERS_TAG) do
            RemoveMpGamerTag(value.tag)
        end
        AtlantissAdmin.DISPLAY_NAMES = false
        AtlantissAdmin.PLAYERS_TAG = {}
    end
end