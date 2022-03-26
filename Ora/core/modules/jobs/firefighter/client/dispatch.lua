--================================--
--       FIRE SCRIPT v1.6.3       --
--  by GIMI (+ foregz, Albo1125)  --
--      License: GNU GPL 3.0      --
--================================--

Atlantiss.Jobs.Firefighter.Dispatch = {
	lastCall = nil,
	blips = {},
	__index = self,
	init = function(o)
		o = o or {active = {}, removed = {}}
		setmetatable(o, self)
		self.__index = self
		return o
	end
}

function Atlantiss.Jobs.Firefighter.Dispatch:renderRoute(coords)
	ClearGpsMultiRoute()

    StartGpsMultiRoute(6, true, true)
    AddPointToGpsMultiRoute(table.unpack(coords))
    SetGpsMultiRouteRender(true)
end

function Atlantiss.Jobs.Firefighter.Dispatch:create(dispatchNumber, coords)
	if not (dispatchNumber and coords) then
		return
	end

	-- Create a fire blip
	local blip = AddBlipForCoord(table.unpack(coords))
	SetBlipSprite(blip, 436)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.5)
	SetBlipColour(blip, 1)
	SetBlipAsShortRange(blip, false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Fire #" .. dispatchNumber)
	EndTextCommandSetBlipName(blip)

	self.blips[dispatchNumber] = {
		coords = coords,
		blip = blip
	}

    self:renderRoute(coords)
    
    if Atlantiss.Jobs.Firefighter.Config.Dispatch.playSound then
        Citizen.CreateThread(
            function()
                for i = 1, 3 do
                    PlaySoundFromEntity(-1, "IDLE_BEEP", GetPlayerPed(-1), "EPSILONISM_04_SOUNDSET", 0)
                    Citizen.Wait(300)
                end
            end
        )
    end

	FlashMinimapDisplay()

	Citizen.SetTimeout(
		Atlantiss.Jobs.Firefighter.Config.Dispatch.removeBlipTimeout,
		function()
			if self.blips[dispatchNumber] and self.blips[dispatchNumber].blip then
				RemoveBlip(blip)
				self.blips[dispatchNumber].blip = false
			end
			if self.lastCall == dispatchNumber then
				ClearGpsMultiRoute()
			end
		end
	)

	-- Only store the last 'Atlantiss.Jobs.Firefighter.Config.Dispatch.storeLast' dispatches' data.
	if countElements(self.blips) > Atlantiss.Jobs.Firefighter.Config.Dispatch.storeLast then
		local order = {}

		for k, v in pairs(self.blips) do
			table.insert(order, k)
		end

		table.sort(order)
		self.blips[order[1]] = nil
	end

	self.lastCall = dispatchNumber
end

function Atlantiss.Jobs.Firefighter.Dispatch:clear(dispatchNumber)
	ClearGpsMultiRoute()

	if dispatchNumber and self.blips[dispatchNumber] and self.blips[dispatchNumber].blip then
		RemoveBlip(self.blips[dispatchNumber].blip)
		self.blips[dispatchNumber].blip = false
	elseif dispatchNumber == 0 then
		for k, v in pairs(self.blips) do
			if self.blips[k].blip then
				RemoveBlip(self.blips[k].blip)
				self.blips[k].blip = false
			end
		end
	end
end

function Atlantiss.Jobs.Firefighter.Dispatch:remind(dispatchNumber)
	if self.blips[dispatchNumber] then
		SetNewWaypoint(table.unpack(self.blips[dispatchNumber].coords.xy))
		return true
	else
		return false
	end
end

--================================--
--     DISPATCH ROUTE REMOVAL     --
--================================--

if Atlantiss.Jobs.Firefighter.Config.Dispatch.clearGpsRadius and tonumber(Atlantiss.Jobs.Firefighter.Config.Dispatch.clearGpsRadius) then
	Citizen.CreateThread(
		function()
			while true do
				Citizen.Wait(5000)
				if Atlantiss.Jobs.Firefighter.Dispatch.lastCall and Atlantiss.Jobs.Firefighter.Dispatch.blips[Atlantiss.Jobs.Firefighter.Dispatch.lastCall] and Atlantiss.Jobs.Firefighter.Dispatch.blips[Atlantiss.Jobs.Firefighter.Dispatch.lastCall].blip and #(Atlantiss.Jobs.Firefighter.Dispatch.blips[Atlantiss.Jobs.Firefighter.Dispatch.lastCall].coords - GetEntityCoords(GetPlayerPed(-1))) < Atlantiss.Jobs.Firefighter.Config.Dispatch.clearGpsRadius then
					ClearGpsMultiRoute()
				end
			end
		end
	)
end