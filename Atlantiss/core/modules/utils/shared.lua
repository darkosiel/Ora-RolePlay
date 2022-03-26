Atlantiss.Utils = {}

function Atlantiss.Utils:GetModuleName()
  return "Utils"
end

function Atlantiss.Utils:GetRandomValueFromDropTable(randomItems)
  local items = {}
  local currentItemKey = 0
  for key, value in pairs(randomItems) do
    if (type(value) ~= "table") then
      Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Utils:GetModuleName(), "Not well formated randomItems table"))
      return nil
    end 

    if (value.drop == nil) then
      value.drop = 1
    end 

    for i = 1, value.drop, 1 do
      currentItemKey = currentItemKey + 1
      items[currentItemKey] = value
    end
  end

  return items[math.random(1, #items)]
end

function Atlantiss.Utils:TableClone(t)
  if type(t) ~= 'table' then return t end

	local meta = getmetatable(t)
	local target = {}

	for k, v in pairs(t) do
		if type(v) == 'table' then
			target[k] = Atlantiss.Utils:TableClone(v)
		else
			target[k] = v
		end
	end

	setmetatable(target, meta)

	return target
end

function Atlantiss.Utils:GetRandomString(allowNumber, allowCaps, allowLower, length)

  local charset = {}

  if (allowNumber == true) then
    for i = 97, 122 do table.insert(charset, string.char(i)) end
  end

  if (allowCaps == true) then
    for i = 65,  90 do table.insert(charset, string.char(i)) end
  end
  
  if (allowLower == true) then
    for i = 48,  57 do table.insert(charset, string.char(i)) end
  end

  local randomString = ""

  if length > 0 then
    for i = 1, length do
      randomString = randomString .. charset[math.random(1, #charset)]
    end
    return randomString
  else
    return ""
  end

end

function Atlantiss.Utils:HasValue(table, value)
	for _, v in pairs(table) do
		if (v == value) then
			return true
		end
	end

	return false
end

function Atlantiss.Utils:TableLength(table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end

  return count
end

function Atlantiss.Utils:IndexOf(table, value)
  local res = 0

  for _, v in pairs(table) do
    res = res + 1
    if (v == value) then
      return res
    end
  end

  return res
end

function Atlantiss.Utils:IsTableLengthSuperiorTo(table, int) -- avoid iterate through the whole table
  if (int == 0) then
    error('You cannot use this method "IsTableLengthSuperiorTo" with a 0 as "int" parameter')
    return false
  end

  local count = 0
  for _ in pairs(table) do
    count = count + 1
    if (count > int) then return true end
  end

  return false
end

function Atlantiss.Utils:Debug(message)
  if (Atlantiss:IsDebug()) then
    Citizen.Trace(string.format("^2[%s / %s] ^3%s^7.\n",  Atlantiss:GetServerName(), Atlantiss.Utils:GetModuleName(), message))
  end
end

function Atlantiss.Utils:RandomFloat(lower, upper)
  return lower + (math.random() * (upper - lower))
end

Atlantiss.Modules:Register(Atlantiss.Utils:GetModuleName())