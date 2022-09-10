
RegisterServerEvent("OraPhone:server:GetPhoneSettings")
AddEventHandler('OraPhone:server:GetPhoneSettings', function()
    local src = source local srcid = GetPlayerIdentifier(source)
    GetUUID(
        src,
		function(result)
			uuid = result
			MySQL.Async.fetchAll('SELECT * FROM ora_phone op INNER JOIN ora_phone_settings ops ON op.id = ops.phone_id WHERE `player_uuid`=@player_uuid;', {player_uuid = uuid}, function(result)
                print_table(result)
                TriggerClientEvent("OraPhone:client:ClientGetFavoriteEmoteList", src, "receiveFavorite", json.encode(result))
            end)
		end
	)
end)

function GetUUID(src, cb)
    MySQL.Async.fetchAll(
		"SELECT uuid FROM users WHERE identifier = @hex",
		{["@hex"] = GetPlayerIdentifier(src)},
		function(result)
			if result[1] ~= nil then
                -- print(result[1].uuid)
				-- return result[1].uuid
                cb(result[1].uuid)
			else
				error(string.format("Cannot retreive uuid from source (%s). HEX: %s", src, GetPlayerIdentifier(src)))
			end
		end
	)
end





-- RegisterServerEvent("OraEmoteMenu:ServerAddFavoriteEmote")
-- AddEventHandler("OraEmoteMenu:ServerAddFavoriteEmote", function(emote)
--     local src = source local srcid = GetPlayerIdentifier(source)
--     MySQL.Async.execute('INSERT INTO ora_emote_menu_favorite (`player_id`, `emote`) VALUES (@id, @emote);',
--         {id = srcid, emote = emote}, function(created)
--         TriggerClientEvent("OraEmoteMenu:ClientGetFavoriteEmoteList", src, 'getFavorite')
--     end)
-- end)


function print_table(node)
    local cache, stack, output = {},{},{}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k,v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k,v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then

                if (string.find(output_str,"}",output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str,"\n",output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output,output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "["..tostring(k).."]"
                else
                    key = "['"..tostring(k).."']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = "..tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = {\n"
                    table.insert(stack,node)
                    table.insert(stack,v)
                    cache[node] = cur_index+1
                    break
                else
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = '"..tostring(v).."'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output,output_str)
    output_str = table.concat(output)

    print(output_str)
end