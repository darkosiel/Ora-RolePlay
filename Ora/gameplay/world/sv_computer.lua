-- character table string
local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local NumbersOfBins = {}

-- encoding
function enc(data)
end

-- decoding
function dec(data)
    data = string.gsub(data, "[^" .. b .. "=]", "")
    return (data:gsub(
        ".",
        function(x)
            if (x == "=") then
                return ""
            end
            local r, f = "", (b:find(x) - 1)
            for i = 6, 1, -1 do
                r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
            end
            return r
        end
    ):gsub(
        "%d%d%d?%d?%d?%d?%d?%d?",
        function(x)
            if (#x ~= 8) then
                return ""
            end
            local c = 0
            for i = 1, 8 do
                c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
            end
            return string.char(c)
        end
    ))
end

RegisterServerEvent("Ora:Server:LogNumberOfBins", function(numberOfBins)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    NumbersOfBins[identifier] = numberOfBins
    print(NumbersOfBins[identifier])
end)

RegisterServerCallback("Ora:Server:GetNumberOfBins", function(source, cb)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    print(NumbersOfBins[identifier])
    cb(NumbersOfBins[identifier] ~= nil and NumbersOfBins[identifier] or 0)
end)