OraAdmin = OraAdmin or {}
OraAdmin.DISPLAY_NAMES = false
OraAdmin.PLAYERS_TAG = {}
OraAdmin.UUIDS_DISPLAYED = {}
OraAdmin.PLAYERS = {}

OraAdmin.TAGS = {
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
    ["staff"] = 200,
    ["superadmin"] = 18
}

TriggerServerCallback("Ora::SE:Admin:AmIAdmin?", 
    function(bool, baseUsersAsJson) 
        if (bool) then

            local baseUsers = json.decode(baseUsersAsJson)

            for index, value in pairs(baseUsers) do
                OraAdmin.PLAYERS[tostring(value.id)] = value
            end
        end
    end,
    {GET_ALL_USERS = true}
)


function OraAdmin.GetPlayerInfoByServerId(playerId)

    if (OraAdmin.PLAYERS[playerId] ~= nil) then
        return OraAdmin.PLAYERS[tostring(playerId)]
    end

    return false
end

function OraAdmin.DisplayPlayerNames()
    local playerPosition = GetEntityCoords(PlayerPedId())
    OraAdmin.UUIDS_DISPLAYED = {}
    OraAdmin.NO_INFOS = {}
    
    for index, userId in pairs(GetActivePlayers()) do 
        local playerServerId = GetPlayerServerId(userId)
        local playerServerIdToString = tostring(playerServerId)

        if playerServerIdToString ~= tostring(GetPlayerServerId(PlayerId())) then
            local otherPlayerPed = GetPlayerPed(userId)
            local playerInformation = OraAdmin.GetPlayerInfoByServerId(playerServerIdToString)
            if (playerInformation == false or playerInformation == nil or playerInformation.uuid == nil) then
                print("No Player Information, nor UUID")
                table.insert(OraAdmin.NO_INFOS, playerServerId)
            else
                local gamerTag = OraAdmin.PLAYERS_TAG[playerInformation.uuid]
                OraAdmin.UUIDS_DISPLAYED[playerInformation.uuid] = true

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
                        SetMpGamerTagVisibility(gamerTagLocal, OraAdmin.TAGS.GAMER_NAME, true)
                        SetMpGamerTagVisibility(gamerTagLocal, OraAdmin.TAGS.healthArmour, true)
        
                        if playerInformation and playerInformation.group and playerInformation.group ~= "user" then
                            SetMpGamerTagColour(gamerTagLocal, 0, TagColors[playerInformation.group])
                        end
                        SetMpGamerTagAlpha(gamerTagLocal, OraAdmin.TAGS.healthArmour, 255)
                        OraAdmin.PLAYERS_TAG[playerInformation.uuid] = {tag = gamerTagLocal, ped = otherPlayerPed}
                    else
                        local gamerTagLocal = gamerTag.tag
                        if playerInformation and playerInformation.name then
                            SetMpGamerTagName(gamerTagLocal, playerInformation.name)
                        end
                    end
                else
                    if (gamerTag ~= nil and gamerTag.tag ~= nil) then
                        RemoveMpGamerTag(gamerTag.tag)
                        OraAdmin.PLAYERS_TAG[playerInformation.uuid] = nil
                    end
                end
            end
        end
    end

    -- Find batched identities
    OraAdmin.RetrieveMissingTags(OraAdmin.NO_INFOS)

    for uuidIndex, uuidValue in pairs(OraAdmin.PLAYERS_TAG) do
        if (OraAdmin.UUIDS_DISPLAYED[uuidIndex] == nil) then
            RemoveMpGamerTag(uuidValue.tag)
            OraAdmin.PLAYERS_TAG[uuidIndex] = nil
        end
    end
end

function OraAdmin.RetrieveMissingTags(playersIds)
    local canSend = false
    local identities = {}

    TriggerServerCallback("Ora::SE::Admin:GetMpTagsIdentityForPlayers", function(dataAsJson)
      identities = json.decode(dataAsJson)
      canSend = true
    end, playersIds)
    
    while (canSend == false) do
      Wait(100)      
    end

    for key, value in pairs(identities) do
        OraAdmin.PLAYERS[tostring(value.id)] = value
    end
end

function OraAdmin.HandlePlayersNames()
    if OraAdmin.DISPLAY_NAMES then
        CreateThread(
            function()
                while OraAdmin.DISPLAY_NAMES do
                    OraAdmin.DisplayPlayerNames()
                    Wait(5000)
                end
            end
        )
    else
        for index, value in pairs(OraAdmin.PLAYERS_TAG) do
            RemoveMpGamerTag(value.tag)
        end
        OraAdmin.DISPLAY_NAMES = false
        OraAdmin.PLAYERS_TAG = {}
    end
end