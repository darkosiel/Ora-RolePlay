local Missions = {}
local illegalMissions = {}

local illegalMissionsMax = {
    gofast = 3,
    carjacking = 3,
    volvehicule = 3,
    migrantsmuggler = 3
}

RegisterServerEvent("Ora::illegal:addCount")
AddEventHandler(
    "Ora::illegal:addCount",
    function(missionName)
        local steam64 = GetPlayerIdentifiers(source)[1]

        if (illegalMissions[missionName] == nil) then 
            illegalMissions[missionName] = {}
        end

        if (illegalMissions[missionName][steam64] == nil) then
            illegalMissions[missionName][steam64] = 1
        else
            illegalMissions[missionName][steam64]= illegalMissions[missionName][steam64] + 1
        end
    end
)

RegisterServerCallback(
    "Ora::illegal:canDoIllegalMission",
    function(source, callback, missionName)
        local steam64 = GetPlayerIdentifiers(source)[1]
        local max = 5

        if (illegalMissionsMax[missionName] ~= nil) then
            max = illegalMissionsMax[missionName]
        end

        if (illegalMissions[missionName] == nil) then 
            illegalMissions[missionName] = {}
        end

        if (illegalMissions[missionName][steam64] == nil or illegalMissions[missionName][steam64] <= max) then
            callback(true)
        else
            callback(false)
        end
    end
)

RegisterServerEvent("startIllegalMission")
AddEventHandler(
    "startIllegalMission",
    function(m)
        --print(json.encode(m))
        table.insert(Missions, m)
        --print("started")
        TriggerClientEvent("SyncMissions", -1, Missions)
    end
)

RegisterServerEvent("editIllegalMission")
AddEventHandler(
    "editIllegalMission",
    function(m)
        for i = 1, #Missions, 1 do
            if Missions[i].id == m.id then
                Missions[i] = m
            end
        end
        TriggerClientEvent("SyncMissions", -1, Missions)
    end
)

RegisterServerCallback(
    "Ora::SE::RetrieveMissionById",
    function(source, callback, id)
        --print(plates)
        local f = false
        local c = {}
        --print(Missions)
        for i = 1, #Missions, 1 do
            if Missions[i].id == id then
                c = Missions[i]
                break
            end
        end
        callback(c)
    end
)

RegisterServerCallback(
    "illegalDoesThisPlateExist",
    function(source, callback, plates)
        --print(plates)
        local f = false
        local c = {}
        --print(Missions)
        for i = 1, #Missions, 1 do
            if Missions[i].platesVerif == plates then
                f = true
                c = Missions[i]
                break
            end
        end
        callback(f, c)
    end
)

RegisterServerEvent("MissionFinished")
AddEventHandler(
    "MissionFinished",
    function(m)
        for i = 1, #Missions, 1 do
            if Missions[i].id == m.id then
                table.remove(Missions, i)
                break
            end
        end
        TriggerClientEvent("SyncMissions", -1, Missions)
    end
)
