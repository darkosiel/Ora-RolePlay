---@diagnostic disable-next-line: unused-function
local function print(...)
	_G.print("[FIREFIGHTER]", ...)
end


local FIRE_POSITIONS <const> = {
	vector3(-1231.23, -672.39, 25.90),
	vector3(-1228.15, -1406.28, 4.18),
	vector3(2.79, -1231.40, 29.45),
	vector3(694.61, 248.60, 93.40),
	vector3(-70.74, -2208.77, 7.81),
	vector3(1045.61, -2455.21, 28.90),
	vector3(411.73, 315.01, 103.13),
	vector3(-521.29, 160.92, 71.08),
	vector3(-608.46, -1040.01, 22.27),
	vector3(-590.92, -290.17, 35.45),
	vector3(-369.88, 275.04, 86.42),
	vector3(-232.63, 293.72, 92.18),
	vector3(1147.39, -784.44, 57.59),
	vector3(711.49, -305.91, 59.87),
	vector3(-1063.44, -1667.75, 4.33),
	vector3(-1123.15, -970.76, 2.14),
	vector3(6.70, -710.40, 32.48),
	vector3(-121.91, -1094.20, 21.68),
	vector3(455.90, -853.58, 27.57),
	vector3(280.72,  -1003.75, 29.35),
	vector3(33.71, -448.39, 55.28),
	vector3(-1659.81, -396.46, 44.96),
	vector3(-1321.18, -253.54, 45.12),
	vector3(798.04, -721.72, 28.08),
	vector3(827.12, -776.38, 26.20),
	vector3(851.28, -959.99, 26.28),
	vector3(727.20, -928.24, 24.62),
	vector3(946.00, -1697.80, 30.08),
	vector3(748.41, -1695, 29.28),
}

local MINIMUM_FIREFIGHTER <const> = 1
local JOB_FIREFIGHTER <const> = "lsfd"

local PROBA_FOR_TWO_SIMULT_FIRES <const> = 0.8

local FIRE_START_AROUND_TIMES <const> = {
	--"13:30",
	"17:15",
	"21:30",
	"23:00",
}

local FIRE_START_AROUND_MARGIN <const> = 15

local FIRE_SPREAD <const> = 100.0
local FIRE_SPREAD_SPEED <const> = 75.0

local FIRE_SPREAD_MARGIN <const> = 15.0
local FIRE_SPREAD_SPEED_MARGIN <const> = 10.0

-- Generate fires based on the supposed times it should start
local fireTimes = {}

for _, v in pairs(FIRE_START_AROUND_TIMES) do
	local hour, minute = v:match("^(%d+):(%d+)$")
	hour = tonumber(hour)
	minute = tonumber(minute)

	local margin = math.random(-1*FIRE_START_AROUND_MARGIN, FIRE_START_AROUND_MARGIN)

	minute = minute + margin
	if minute < 0 then
		hour = hour - 1
		minute = minute + 60
	elseif minute >= 60 then
		hour = hour + 1
		minute = minute - 60
	end

	local currentTime = os.date("*t")

	if hour > currentTime.hour and minute - currentTime.min <= 5  then
		local time = os.date("*t", os.time())
		time.hour = hour
		time.min = minute
		time.sec = 0
	
		table.insert(fireTimes, os.time(time))
	
	end
end

local function getMyTime()
	return os.time() + 2 * 60 * 60
end

local function generateFires()
	local currentTime = getMyTime()
	repeat
		Citizen.Wait(60 * 1000)
		currentTime = getMyTime()
	until currentTime > fireTimes[1]

	if Ora.Service:GetTotalServiceCountForJob(JOB_FIREFIGHTER) >= MINIMUM_FIREFIGHTER then
		local firePosition = FIRE_POSITIONS[math.random(1, #FIRE_POSITIONS)]
		TriggerEvent("fireManager:command:startfire", firePosition, FIRE_SPREAD, FIRE_SPREAD_SPEED, true, "Un incendie s'est déclenché dans la ville !")
	end

	-- Supprimer les incendies qui ont déjà été générés ou qui sont passés
	for i = #fireTimes, 1, -1 do
		if fireTimes[i] < currentTime then
			table.remove(fireTimes, i)
		end
	end

	-- print("Next fire in", fireTimes[1] - timer)

	SetTimeout(fireTimes[1] - currentTime, generateFires)
end

-- Démarrer la génération des incendies
if fireTimes[1] then
	SetTimeout(fireTimes[1] - os.time(), generateFires)
end