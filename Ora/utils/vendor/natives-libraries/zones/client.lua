local HasAlreadyEnteredMarker = false
local LastZone = nil
local ZoneSaved = nil
local ActionMsg = nil
Zone = setmetatable({}, Blips)
Zone.Data = {}
Zone.DataByZone = {}

function Zone:Add(Pos, Enter, Exit, i, range)
    local gridZoneId = Atlantiss.Core:GetGridZoneId(Pos.x, Pos.y)
    local idForPosition = Atlantiss.Core:GetIdentifierForCoords(Pos)

    local tempData = {Pos = Pos, Enter = Enter, Exit = Exit, i = i, range = range, id = idForPosition}
    if self.DataByZone[gridZoneId] == nil then 
        self.DataByZone[gridZoneId] = {}
    end
    Atlantiss.Core:Debug(string.format("Added new zone at pos: ^5%s %s %s^3 for zone ^5%s^3 with id : ^5%s^3",  Pos.x, Pos.y, Pos.z, gridZoneId, idForPosition))

    table.insert(self.DataByZone[gridZoneId], tempData)

    self.Data[idForPosition] = tempData
end

function Zone:Remove(Pos)
    if (Pos == nil) then 
        return
    end
    local idForPosition = Atlantiss.Core:GetIdentifierForCoords(Pos)

    if self.Data[idForPosition] ~= nil then
        self.Data[idForPosition].Exit()
        self.Data[idForPosition] = nil
    end
end

function Zone:RemoveFromName(Name)
    for i = 1, #self.Data, 1 do
        if self.Data[i].Name == Name then
            self.Data[i].Exit()
            table.remove(self.Data, i)
            break
        end
    end
end

local currentZoneId = nil

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if (currentZoneId ~= nil) then
			if (Zone.DataByZone ~= nil and type(Zone.DataByZone[currentZoneId]) == "table") then
                local coords = LocalPlayer().Pos
                local isInMarker = false
                local currentZone = nil
                local self = Zone
                local totalNo = 0

                for key, value in pairs(Zone.DataByZone[currentZoneId]) do
                    v = value
                    if v ~= nil and v.Pos ~= nil then
                        if
                            (GetDistanceBetween3DCoords(coords.x, coords.y, coords.z, v.Pos.x, v.Pos.y, v.Pos.z, false) <
                                v.range)
                        then
                            local idForPosition = Atlantiss.Core:GetIdentifierForCoords(v.Pos)
                            isInMarker = true

                            if (ZoneSaved ~= nil and ZoneSaved ~= idForPosition and self.Data[ZoneSaved] ~= nil) then
                                self.Data[ZoneSaved].Exit()
                                ZoneSaved = nil
                            end

                            currentZone = idForPosition
                            ZoneSaved = idForPosition
                            LastZone = idForPosition

                        else
                            totalNo = totalNo + 1
                        end
                    end
                end

                local i = currentZone
                if isInMarker and not HasAlreadyEnteredMarker then
                    HasAlreadyEnteredMarker = true
                    Atlantiss.Core:Debug(string.format("Player has entered in pos: ^5%s %s %s^3 for zone ^5%s^3",  v.Pos.x, v.Pos.y, v.Pos.z, currentZone))
                    if (self.Data[currentZone] ~= nil) then
                        self.Data[currentZone].Enter(self.Data[currentZone].i)
                    end
                end
                if not isInMarker and HasAlreadyEnteredMarker then
                    HasAlreadyEnteredMarker = false

                    if (LastZone ~= nil and ZoneSaved ~= LastZone and self.Data[ZoneSaved] ~= nil) then
                        Atlantiss.Core:Debug(string.format("Player has exited in pos: ^5%s %s %s^3 for zone ^5%s^3",  v.Pos.x, v.Pos.y, v.Pos.z, ZoneSaved))
                        if (self.Data[ZoneSaved] ~= nil) then
                            self.Data[ZoneSaved].Exit()
                        end
                        ZoneSaved = nil
                    end

                    if (LastZone ~= nil and self.Data[LastZone] ~= nil) then
                        Atlantiss.Core:Debug(string.format("Player has exited in pos: ^5%s %s %s^3 for zone ^5%s^3",  v.Pos.x, v.Pos.y, v.Pos.z, LastZone))
                        if (self.Data[LastZone] ~= nil) then
                            self.Data[LastZone].Exit()
                        end
                    end
                end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(500)
		local previousZoneId = currentZoneId
		local t = LocalPlayer().Pos
		currentZoneId = Atlantiss.Core:GetGridZoneId(t.x, t.y)
		if (previousZoneId ~= currentZoneId) then
			Atlantiss.Core:Debug(string.format("^5ZONE^3 : Current zone id is now ^5%s^3", currentZoneId))
		end
	end
end)

Hint = setmetatable({}, Hint)

function Hint:RemoveAll()
    ActionMsg = nil
end

function Hint:Set(txt)
    ActionMsg = txt
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if ActionMsg ~= nil then
                SetTextComponentFormat("STRING")
                AddTextComponentString(ActionMsg)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            end
        end
    end
)
