-- Server side array of active races
local races = {}


RegisterServerCallback("getRaces", function(source, callback)
	callback(races)
end)

-- Cleanup thread
Citizen.CreateThread(function()
    -- Loop forever and check status every 100ms
    while true do
        Citizen.Wait(100)

        for index, race in pairs(races) do
            local time = GetGameTimer()
            local players = race.players

            if (time > race.startTime) and (#players == 0) then
                table.remove(races, index)
                TriggerClientEvent("StreetRaces:removeRace_cl", -1, index)
            elseif (race.finishTime ~= 0) and (time > race.finishTime + race.finishTimeout) then
                for _, player in pairs(players) do
                    TriggerClientEvent('Streetraces:Popup', player, "Terminée (timeout)")
                end
                table.remove(races, index)
                TriggerClientEvent("StreetRaces:removeRace_cl", -1, index)
            end
        end
    end
end)

RegisterNetEvent("StreetRaces:createRace_sv")
AddEventHandler("StreetRaces:createRace_sv", function(amount, startDelay, startCoords, checkpoints, finishTimeout)
    local race = {
        owner = source,
        amount = amount,
        startDelay = startDelay,
        startTime = GetGameTimer() + startDelay,
        startCoords = startCoords,
        checkpoints = checkpoints,
        finishTimeout = config_sv.finishTimeout,
        players = {},
        prize = 0,
        finishTime = 0
    }
    table.insert(races, race)

    --local index = #races
    TriggerClientEvent("StreetRaces:createRace_cl", -1, race)--index, amount, startDelay, startCoords, checkpoints)
end)

RegisterNetEvent("StreetRaces:joinRace_sv")
AddEventHandler("StreetRaces:joinRace_sv", function(index)
    local _source = source
    local race = races[index]
    local amount = race.amount
    local players = race.players
    race.prize = race.prize + amount

    table.insert(races[index].players, _source)
    for k, pSource in pairs(players) do
        TriggerClientEvent('StreetRaces:Popup', pSource, "~g~Le montant total parié est de: "..race.prize.."~s~")
    end
    TriggerClientEvent("StreetRaces:joinedRace_cl", _source, index, race.prize)
end)

RegisterNetEvent("StreetRaces:betRace_sv")
AddEventHandler("StreetRaces:betRace_sv", function(index)
    local _source = source
    local race = races[index]
    local amount = race.amount
    local players = race.players

    race.prize = race.prize + amount
    race.status = BET_RACE

    TriggerClientEvent('StreetRaces:Popup', _source, "~g~Le montant total parié est de: "..race.prize.."~s~")
    for k, pSource in pairs(players) do
        if pSource == _source then goto continue end
        TriggerClientEvent('StreetRaces:Popup', pSource, "~g~Le montant total parié est de: "..race.prize.."~s~")
        ::continue::
    end
    TriggerClientEvent("StreetRaces:bettingRace_cl", _source, index, race.prize)
end)

RegisterNetEvent("StreetRaces:leaveRace_sv")
AddEventHandler("StreetRaces:leaveRace_sv", function(index)
    local race = races[index]
    local players = race.players
    race.prize = race.prize - race.amount

    for index, player in pairs(players) do
        if source == player then
            table.remove(players, index)
        else
            TriggerClientEvent('StreetRaces:Popup', player, "~g~Le montant total parié est de: "..race.prize.."~s~")
        end
    end
end)

RegisterServerCallback('StreetRaces:finishedRace_sv', function(source, callback, index, time)
    local race = races[index]
    local players = race.players
    for _, player in pairs(players) do
        if source == player then
            local time = GetGameTimer()
            local timeSeconds = (time - race.startTime)/1000.0
            local timeMinutes = math.floor(timeSeconds/60.0)
            timeSeconds = timeSeconds - 60.0*timeMinutes

            if race.finishTime == 0 then
                race.finishTime = time
                --TriggerClientEvent('StreetRaces:sendWinMoney', source, races[index].prize)
                callback(races[index].prize)

                for _, pSource in pairs(players) do
                    if pSource == source then
                        local msg = ("~o~Tu as gagné ~h~$"..races[index].prize.."~h~\n~b~Ton temps: [%02d:%06.3f]~s~"):format(timeMinutes, timeSeconds)
                        TriggerClientEvent('StreetRaces:Popup', pSource, msg)
                    elseif config_sv.notifyOfWinner then
                        local msg = ("~b~~h~%s a gagné~h~\nSon temps: [%02d:%06.3f]~s~"):format(GetPlayerName(source), timeMinutes, timeSeconds)
                        TriggerClientEvent('StreetRaces:Popup', pSource, msg)
                    end
                end
            else
                local msg = ("~b~~h~Tu as perdu~h~\nTon temps: [%02d:%06.3f]~s~"):format(timeMinutes, timeSeconds)
                TriggerClientEvent('StreetRaces:Popup', source, msg)
            end
            table.remove(players, index)
            break
        end
    end
end)
