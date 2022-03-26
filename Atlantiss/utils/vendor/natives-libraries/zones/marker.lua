Marker = setmetatable({}, Marker)
Marker.Data = {}
Marker.ListByZone = {}

function Marker:Add(Pos,Data)
		local gridZoneId = Atlantiss.Core:GetGridZoneId(Pos.x, Pos.y)
    table.insert( self.Data, {pos=Pos,data=Data, gridZoneId = gridZoneId})
		if (self.ListByZone[gridZoneId] == nil) then
			self.ListByZone[gridZoneId] = {}
		end
		Atlantiss.Core:Debug(string.format("Added marker ^5%s %s %s^3 for zone ^5%s^3", Pos.x, Pos.y, Pos.z, gridZoneId))
		table.insert(self.ListByZone[gridZoneId], {pos=Pos,data=Data,gridZoneId = gridZoneId})
end
function Marker:Visible(Pos,Visible)
	for i = 1 , #self.Data,1 do
		if self.Data[i].pos == Pos then
			self.Data[i].data.visible = Visible
			break
		end
	end
end

function Marker:Remove(Pos)
	for i = 1 , #self.Data , 1 do
		if self.Data[i].pos == Pos then
			local gridZoneForMarker = self.Data[i].gridZoneId
			if (gridZoneForMarker ~= nil and self.ListByZone[gridZoneForMarker] ~= nil and type(self.ListByZone[gridZoneForMarker]) == "table") then
				for key, value in pairs(self.ListByZone[gridZoneForMarker]) do
					if value.pos == Pos then
						Atlantiss.Core:Debug(string.format("Removed marker ^5%s %s %s^3 for zone ^5%s^3", value.pos.x, value.pos.y, value.pos.z, gridZoneForMarker))
						table.remove(self.ListByZone[gridZoneForMarker], key)
						break
					end
				end
			end

			table.remove(self.Data ,i)
			break
		end
	end
end

local currentZoneId = nil

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if (currentZoneId ~= nil) then
			if (Marker.ListByZone ~= nil and type(Marker.ListByZone[currentZoneId]) == "table") then
				for key, value in pairs(Marker.ListByZone[currentZoneId]) do
					local distance = GetDistanceBetweenCoords(value.pos.x, value.pos.y, value.pos.z, LocalPlayer().Pos.x, LocalPlayer().Pos.y, LocalPlayer().Pos.z)
					if value.data ~= nil and value.data.visible and value.pos ~= nil and distance < 35.0 then
						DrawMarker(value.data.type, value.pos.x, value.pos.y, value.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, value.data.scale.x, value.data.scale.y, value.data.scale.z, value.data.color.r, value.data.color.g, value.data.color.b, value.data.color.a, value.data.Up, value.data.Cam, nil, value.data.Rotate, nil, nil, nil)
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
			Atlantiss.Core:Debug(string.format("^5MARKERS^3 : Current zone id is now ^5%s^3", currentZoneId))
		end
	end
end)