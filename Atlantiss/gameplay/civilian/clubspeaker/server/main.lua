local playlist = {["unicorn"] = {}, ["night"] = {}, ["restaurant"] = {}}
local tPly = {
	["unicorn"]			 = {nVol = 5, id = nil, index = 0, title = nil, timer = 0, timeMax = 0, tmF = 0, pause = false, next = false},
	["night"]				 = {nVol = 5, id = nil, index = 0, title = nil, timer = 0, timeMax = 0, tmF = 0, pause = false, next = false},
	["restaurant"]   = {nVol = 5, id = nil, index = 0, title = nil, timer = 0, timeMax = 0, tmF = 0, pause = false, next = false}
}

RegisterServerEvent('music:addToPlaylist')
AddEventHandler('music:addToPlaylist', function(club, data)
	table.insert(playlist[club], data)
	TriggerClientEvent("music:addToPlaylist", -1, club, data)
end)

RegisterServerEvent('music:deleteMusic')
AddEventHandler('music:deleteMusic', function(club, index)
	table.remove(playlist[club], index)
	TriggerClientEvent("music:deleteMusic", -1, club, index)
end)

RegisterServerEvent('music:playAll')
AddEventHandler('music:playAll', function(club, link, timeMax, index, title)
	local timeMx = timeMax * 100
	local seconds = string.sub(timeMx,-4, -3)
	local minutes = (timeMx - seconds)/100
	local totalSeconds = minutes * 60 + seconds
	tPly[club].id = link
	tPly[club].timeMax = totalSeconds
	tPly[club].index = index
	tPly[club].title = title
	tPly[club].timer = 0
	tPly[club].tmF = timeMax
	TriggerClientEvent("music:playAll", -1, club, link, timeMax, index, title)
end)

RegisterServerEvent('music:changeVolume')
AddEventHandler('music:changeVolume', function(club, volume)
	tPly[club].nVol = volume
	TriggerClientEvent("music:setVolume", -1, club, volume)
end)

RegisterServerEvent('music:pause')
AddEventHandler('music:pause', function(club)
	tPly[club].pause = not tPly[club].pause
	TriggerClientEvent("music:pause", -1, club, tPly[club].pause)
end)

RegisterServerEvent('music:getMusic')
AddEventHandler('music:getMusic', function(club)
	TriggerClientEvent("music:getMusic", source, club, tPly[club].id, tPly[club].index, tPly[club].title, tPly[club].timer + 4, tPly[club].tmF, tPly[club].pause)
end)

RegisterServerEvent('music:getVolumeConnect')
AddEventHandler('music:getVolumeConnect', function()
	TriggerClientEvent("music:getVolumeConnect", source, tPly["unicorn"].nVol, tPly["night"].nVol, tPly["restaurant"].nVol)
end)

RegisterServerEvent('music:nextMusic')
AddEventHandler('music:nextMusic', function(club, id, index, timeMax)
	local timeMx = timeMax * 100
	local seconds = string.sub(timeMx,-4, -3)
	local minutes = (timeMx - seconds)/100
	local totalSeconds = minutes * 60 + seconds
	tPly[club].id = id
	tPly[club].index = index
	tPly[club].timeMax = totalSeconds
	tPly[club].timer = 0
	TriggerClientEvent("music:nextMusic", -1, club, id, index)
end)

for k, v in pairs(tPly) do
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if v.id ~= nil and v.pause == false and v.timer < v.timeMax then
				if v.next == true then
					v.next = false
				end
				v.timer = v.timer + 1
				Wait(940)
			elseif v.id ~= nil and v.timer == v.timeMax and v.timeMax ~= 0 and v.next == false then
				club = k
				ind = v.index
				v.next = true
				if playlist[club][ind+1] ~= nil then
					TriggerEvent('music:nextMusic', club, playlist[club][ind+1].id, ind+1, playlist[club][ind+1].duration)
				end
			end
		end
	end)
end

RegisterServerCallback("music:getPlaylist", function(source, callback)
	callback(playlist)
end)