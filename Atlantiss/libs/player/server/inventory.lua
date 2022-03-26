function GetIdentifiers(source)
    local identifiers = {}
    if source == nil then return print("^1Source = nil^0") end
    local playerIdentifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(playerIdentifiers) do
        local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
        identifiers[before] = playerIdentifiers[_]
    end
    return identifiers
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end
