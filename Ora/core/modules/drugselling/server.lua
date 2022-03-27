Ora.DrugDealing.AreaFiles = {
    [1] = "core/modules/drugselling/data/vespucci_beach.json",
    [2] = "core/modules/drugselling/data/place_des_cubes.json",
    [3] = "core/modules/drugselling/data/maze_bank_arena.json",
    [4] = "core/modules/drugselling/data/little_seoul.json",
    [5] = "core/modules/drugselling/data/mirror_park.json",
    [6] = "core/modules/drugselling/data/sandy_shore.json",
    [7] = "core/modules/drugselling/data/paletto.json",
}

Ora.DrugDealing.AreaPositions = {}
Ora.DrugDealing.CurrentDealers = {}
Ora.DrugDealing.CurrentDealersZones = {}
Ora.DrugDealing.BoostedZone = math.random(6, #Ora.DrugDealing.AreaFiles)

AddEventHandler(
    "playerDropped",
    function(reason)
        local _source = source
        if (Ora.DrugDealing:IsDealing(_source)) then
            Ora.DrugDealing:Debug(string.format("Player : ^5%s^3 dropped. Removed as dealer",  _source))
            Ora.DrugDealing:RemoveDealerFromAnyZones(_source)
        end
    end
)

function Ora.DrugDealing:GetBoostedZone()
    return self.BoostedZone
end

function Ora.DrugDealing:IsZoneBoosted(id)
    return self.BoostedZone == id
end

function Ora.DrugDealing:GetZones()
    local zones = {}
    for key, value in ipairs(self.Area) do
        local isFull = self:isZoneIdFull(key)
        local currentDealersCount = self:GetCurrentDealersCountForZone(key)
        local maxDealers = self:GetSimultaneousLimitForZone(key)
        local hasEnoughCops = self:HasZoneIdEnoughCops(key)
        table.insert(zones, {name = value, isFull = isFull, currentDealerCount = currentDealerCount, maxDealers = maxDealers, hasEnoughCops = hasEnoughCops, isBoosted = self:IsZoneBoosted(key)})
    end

    Ora.DrugDealing:Debug(string.format("Returning ^5%s^3 zones", #zones))    
    return zones
end

function Ora.DrugDealing:isZoneIdFull(zoneId)
    if (self.CurrentDealersZones[zoneId] == nil) then
        self.CurrentDealersZones[zoneId] = {}   
    end

    local isFull = #self.CurrentDealersZones[zoneId] >= self:GetSimultaneousLimitForZone(zoneId) and true or false
    Ora.DrugDealing:Debug(string.format("Verifying if zone ^5%s^3 is full (%s)", zoneId, isFull))
    return isFull
end

function Ora.DrugDealing:GetCurrentDealersCountForZone(zoneId)
    local currentDealerCount = #self:GetCurrentDealersForZone(zoneId)
    Ora.DrugDealing:Debug(string.format("Returning current dealer count for zone ^5%s^3 (%s dealers)", zoneId, currentDealerCount))
    return currentDealerCount
end

function Ora.DrugDealing:GetCurrentDealersForZone(zoneId)
    if (self.CurrentDealersZones[zoneId] == nil) then
        self.CurrentDealersZones[zoneId] = {}   
    end

    Ora.DrugDealing:Debug(string.format("Returning current dealers for zone ^5%s^3", zoneId))
    return self.CurrentDealersZones[zoneId]
end

function Ora.DrugDealing:HasZoneIdEnoughCops(zoneId)
    local copsJuridiction = self:GetCopsJuridictionForZoneId(zoneId) 
    Ora.DrugDealing:Debug(string.format("Returning if zone ^5%s^3 and juridiction ^5%s^3 has enough cops ", zoneId, copsJuridiction))
    return Ora.Service:GetTotalServiceCountForJob(copsJuridiction) >= Ora.Illegal:GetCopsRequired("drugselling")
end

function Ora.DrugDealing:AddDealerIntoZoneId(zoneId, playerId)
    self:Debug(string.format("Adding ^5%s^3 as a dealer of zone id ^5%s^3", playerId, zoneId))
    self.CurrentDealers[playerId] = true
    if (self.CurrentDealersZones[zoneId] == nil) then
        self.CurrentDealersZones[zoneId] = {}
    end

    table.insert(self.CurrentDealersZones[zoneId], playerId)
end

function Ora.DrugDealing:RemoveDealerFromZoneId(zoneId, playerId)
    if (self.CurrentDealersZones[zoneId] == nil) then
        self.CurrentDealersZones[zoneId] = {}
    end
    
    self.CurrentDealers[playerId] = nil
    local hasBeenRemoved = false
    for arrIndex, value in pairs(self.CurrentDealersZones[zoneId]) do
        if (value == playerId) then
            table.remove(self.CurrentDealersZones[zoneId], arrIndex)
            hasBeenRemoved = true
            self:Debug(string.format("Removing ^5%s^3 as a dealer of zone id ^5%s^3", playerId, zoneId))
        end
    end
    
    if (hasBeenRemoved == false) then
        self:Debug(string.format("Cannot remove ^5%s^3 as a dealer of zone id ^5%s^3 because he is not marked as dealer", playerId, zoneId))
    end
end

function Ora.DrugDealing:IsDealing(playerId)
    if (self.CurrentDealers[playerId] ~= nil and self.CurrentDealers[playerId] == true) then
        Ora.DrugDealing:Debug(string.format("Player ^5%s^3 is currently dealing", playerId))
        return true
    end

    Ora.DrugDealing:Debug(string.format("Player ^5%s^3 is not dealing", playerId))
    return false
end

function Ora.DrugDealing:RemoveDealerFromAnyZones(playerId)
    for key, value in pairs(self.CurrentDealersZones) do
        self:RemoveDealerFromZoneId(key, playerId)
    end
end

function Ora.DrugDealing:ResetAreaPositionsForZoneId(zoneId)
    self:Debug(string.format("Reseting positions for zone id ^5%s^3", zoneId))
    self.AreaPositions[zoneId] = nil
end

function Ora.DrugDealing:ResetAreaPositions()
    self:Debug(string.format("Reseting all positions for drug dealing areas"))
    self.AreaPositions = {}
end

function Ora.DrugDealing:GetPositionsFileForZoneId(zoneId)
    if (Ora.DrugDealing.AreaFiles[zoneId] ~= nil) then
        self:Debug(string.format("Resolving position file ^5%s^3 for zone id ^5%s^3", Ora.DrugDealing.AreaFiles[zoneId], zoneId))
        return self.AreaFiles[zoneId]
    end

    self:Debug(string.format("Cannot resolve position file for zone id ^5%s^3", zoneId))
    return "false"
end

function Ora.DrugDealing:GetPositionsForZoneId(zoneId)
    if (self.AreaPositions[zoneId] == nil) then
        self:Debug(string.format("Fetching positions from file for zone id ^5%s^3", zoneId))
        local contentAsJson = LoadResourceFile(GetCurrentResourceName(), "./" .. Ora.DrugDealing:GetPositionsFileForZoneId(zoneId))
        self.AreaPositions[zoneId] = json.decode(contentAsJson)
    end

    self:Debug(string.format("Returning ^5%s^3 loaded positions for zone id ^5%s^3", #self.AreaPositions[zoneId], zoneId))
    return self.AreaPositions[zoneId]
end

RegisterServerCallback(
    "Ora::SE::DrugDealing:GetZones",
    function(source, callback)
        Ora.DrugDealing:Debug(string.format("^5%s^3 triggered ServerEventCallback : Ora::SE::DrugDealing:GetZones to retrieve availables zones and status", source))
      callback(Ora.DrugDealing:GetZones())
    end
)

RegisterServerCallback(
    "Ora::SE::DrugDealing:GetPositionsForZoneId",
    function(source, callback, zoneId)
        Ora.DrugDealing:Debug(string.format("^5%s^3 triggered ServerEventCallback : Ora::SE::DrugDealing:GetPositionsForZoneId to retrieve positions for zone id ^5%s^3", source, zoneId))
      callback(Ora.DrugDealing:GetPositionsForZoneId(zoneId))
    end
)

RegisterServerCallback(
    "Ora::SE::DrugDealing:CanRegisterForDealingIntoZoneId",
    function(source, callback, zoneId)
        Ora.DrugDealing:Debug(string.format("^5%s^3 triggered ServerEventCallback : Ora::SE::DrugDealing:CanRegisterForDealingIntoZoneId to verify if it cans deal into zone id ^5%s^3", source, zoneId))
        local zoneIsFull = Ora.DrugDealing:isZoneIdFull(zoneId)
        local hasEnoughCops = Ora.DrugDealing:HasZoneIdEnoughCops(zoneId)

        if (zoneIsFull == true) then
            TriggerClientEvent("Ora::CE::Core:ShowNotification", source, string.format("La zone ~g~~h~%s~h~~s~ a déjà trop de dealers", Ora.DrugDealing:GetDealingAreaNameById(zoneId)))
            callback(false)
        elseif (hasEnoughCops == false) then 
            TriggerClientEvent("Ora::CE::Core:ShowNotification", source, string.format("La zone ~g~~h~%s~h~~s~ n'a aucun client", Ora.DrugDealing:GetDealingAreaNameById(zoneId)))
            callback(false)
        else
            callback(true)
        end
    end
)

RegisterServerCallback(
    "Ora::SE::DrugDealing:GetBoostedZone",
    function(source, callback)
        callback(Ora.DrugDealing:GetBoostedZone())
    end
)

RegisterServerEvent("Ora::SE::DrugDealing:AddDealerForZone")
AddEventHandler(
    "Ora::SE::DrugDealing:AddDealerForZone",
    function(zoneId)
        local _source = source
        Ora.DrugDealing:AddDealerIntoZoneId(zoneId, _source)
        Ora.DrugDealing:Debug(string.format("Player : ^5%s^3 is now added to zone id ^5%s^3 as a dealer",  _source, zoneId))
        TriggerClientEvent("Ora::CE::Core:ShowNotification", _source, string.format("Vous dealez désormais sur la zone ~g~~h~%s~h~~s~", Ora.DrugDealing:GetDealingAreaNameById(zoneId)))
    end
)

RegisterServerEvent("Ora::SE::DrugDealing:RemoveDealerForZone")
AddEventHandler(
    "Ora::SE::DrugDealing:RemoveDealerForZone",
    function(zoneId)
        local _source = source
        Ora.DrugDealing:Debug(string.format("Player : ^5%s^3 is now removed from zone id ^5%s^3. No more dealing",  _source, zoneId))
        Ora.DrugDealing:RemoveDealerFromZoneId(zoneId, _source)
        TriggerClientEvent("Ora::CE::Core:ShowNotification", _source, string.format("Vous ne dealez plus dans la zone ~g~~h~%s~h~~s~", Ora.DrugDealing:GetDealingAreaNameById(zoneId)))
    end
)

RegisterServerEvent("Ora::Illegal:PlayerIsDead")
AddEventHandler("Ora::Illegal:PlayerIsDead",function()
    local _source = source
    if (Ora.DrugDealing:IsDealing(_source)) then
        Ora.DrugDealing:Debug(string.format("Player : ^5%s^3 died. Removed as dealer",  _source))
        Ora.DrugDealing:RemoveDealerFromAnyZones(_source)
        TriggerClientEvent("Ora::CE::DrugDealing:StopDealing", _source)
        TriggerClientEvent("Ora::CE::Core:ShowNotification", _source, string.format("~r~Vous ne dealez plus car vous êtes mort~s~"))
    end
end)
