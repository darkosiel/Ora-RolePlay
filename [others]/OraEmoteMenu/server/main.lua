
-----------------------------------------------------------------------------------------------------
-- Shared Emotes Syncing  ---------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

RegisterServerEvent("OraEmoteMenu:ServerEmoteRequest")
AddEventHandler("OraEmoteMenu:ServerEmoteRequest", function(target, emotename, etype)
	TriggerClientEvent("OraEmoteMenu:ClientEmoteRequestReceive", target, emotename, etype)
end)

RegisterServerEvent("OraEmoteMenu:ServerValidEmote") 
AddEventHandler("OraEmoteMenu:ServerValidEmote", function(target, requestedemote, otheremote)
	TriggerClientEvent("OraEmoteMenu:SyncPlayEmote", source, otheremote, source)
	TriggerClientEvent("OraEmoteMenu:SyncPlayEmoteSource", target, requestedemote)
end)

-----------------------------------------------------------------------------------------------------
-- Favorite Emote  ----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

RegisterServerEvent("OraEmoteMenu:ServerGetFavoriteEmoteList")
AddEventHandler('OraEmoteMenu:ServerGetFavoriteEmoteList', function()
    local src = source local srcid = GetPlayerIdentifier(source)
    MySQL.Async.fetchAll('SELECT * FROM ora_emote_menu_favorite WHERE `player_id`=@id;', {id = srcid}, function(result)
        TriggerClientEvent("OraEmoteMenu:ClientGetFavoriteEmoteList", src, "receiveFavorite", json.encode(result))
    end)
end)

RegisterServerEvent("OraEmoteMenu:ServerAddFavoriteEmote")
AddEventHandler("OraEmoteMenu:ServerAddFavoriteEmote", function(emote)
    local src = source local srcid = GetPlayerIdentifier(source)
    MySQL.Async.execute('INSERT INTO ora_emote_menu_favorite (`player_id`, `emote`) VALUES (@id, @emote);',
        {id = srcid, emote = emote}, function(created)
        TriggerClientEvent("OraEmoteMenu:ClientGetFavoriteEmoteList", src, 'getFavorite')
    end)
end)

RegisterServerEvent("OraEmoteMenu:ServerRemoveFavoriteEmote")
AddEventHandler("OraEmoteMenu:ServerRemoveFavoriteEmote", function(emote)
    local src = source local srcid = GetPlayerIdentifier(source)
    MySQL.Async.execute('DELETE FROM ora_emote_menu_favorite WHERE `player_id`=@id AND `emote`=@emote;',
        {id = srcid, emote = emote}, function(created)
        TriggerClientEvent("OraEmoteMenu:ClientGetFavoriteEmoteList", src, 'getFavorite')
    end)
end)

-----------------------------------------------------------------------------------------------------
-- Preferences (Walks and Expression) --------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

RegisterServerEvent("OraEmoteMenu:ServerGetPreferences", function()
    local src = source local srcid = GetPlayerIdentifier(source)
    print("ServerGetPreferences: " .. srcid)
    MySQL.Async.fetchScalar('SELECT preferences FROM ora_emote_menu_preferences WHERE `player_id`=@id;', {id = srcid}, function(result)
        if result == nil then 
            result = "{}" 
            -- Insert default preferences
            MySQL.Async.execute('INSERT INTO ora_emote_menu_preferences (`player_id`, `preferences`) VALUES (@id, @preferences);',
                {id = srcid, preferences = result}, function(created)
            end)
        end
        TriggerClientEvent("OraEmoteMenu:ClientGetPreferences", src, result)
    end)
end)

RegisterServerEvent("OraEmoteMenu:ServerSavePreferences", function(preferences)
    local src = source local srcid = GetPlayerIdentifier(source)
    MySQL.Async.execute('INSERT INTO ora_emote_menu_preferences (`player_id`, `preferences`) VALUES (@id, @preferences) ON DUPLICATE KEY UPDATE `preferences`=@preferences;',
        {id = srcid, preferences = preferences}, function(created)
        TriggerClientEvent("OraEmoteMenu:ClientGetPreferences", src, preferences)
    end)
end)