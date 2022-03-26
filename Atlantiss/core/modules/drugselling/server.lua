Atlantiss.DrugDealing.AreaFiles = {
    [1] = "core/modules/drugselling/data/vespucci_beach.json",
    [2] = "core/modules/drugselling/data/place_des_cubes.json",
    [3] = "core/modules/drugselling/data/maze_bank_arena.json",
    [4] = "core/modules/drugselling/data/little_seoul.json",
    [5] = "core/modules/drugselling/data/mirror_park.json",
    [6] = "core/modules/drugselling/data/sandy_shore.json",
    [7] = "core/modules/drugselling/data/paletto.json",
}

Atlantiss.DrugDealing.AreaPositions = {}
Atlantiss.DrugDealing.CurrentDealers = {}
Atlantiss.DrugDealing.CurrentDealersZones = {}
Atlantiss.DrugDealing.BoostedZone = math.random(6, #Atlantiss.DrugDealing.AreaFiles)

AddEventHandler(
    "playerDropped",
    function(reason)
        local _source = source
        if (Atlantiss.DrugDealing:IsDealing(_source)) then
            Atlantiss.DrugDealing:Debug(string.format("Player : ^5%s^3 dropped. Removed as dealer",  _source))
            Atlantiss.DrugDealing:RemoveDealerFromAnyZones(_source)
        end
    end
)

function Atlantiss.DrugDealing:GetBoostedZone()
    return self.BoostedZone
end

function Atlantiss.DrugDealing:IsZoneBoosted(id)
    return self.BoostedZone == id
end

function Atlantiss.DrugDealing:GetZones()
    local zones = {}
    for key, value in ipairs(self.Area) do
        local isFull = self:isZoneIdFull(key)
        local currentDealersCount = self:GetCurrentDealersCountForZone(key)
        local maxDealers = self:GetSimultaneousLimitForZone(key)
        local hasEnoughCops = self:HasZoneIdEnoughCops(key)
        table.insert(zones, {name = value, isFull = isFull, currentDealerCount = currentDealerCount, maxDealers = maxDealers, hasEnoughCops = hasEnoughCops, isBoosted = self:IsZoneBoosted(key)})
    end

    Atlantiss.DrugDealing:Debug(string.format("Returning ^5%s^3 zones", #zones))    
    return zones
end

function Atlantiss.DrugDealing:isZoneIdFull(zoneId)
    if (self.CurrentDealersZones[zoneId] == nil) then
        self.CurrentDealersZones[zoneId] = {}   
    end

    local isFull = #self.CurrentDealersZones[zoneId] >= self:GetSimultaneousLimitForZone(zoneId) and true or false
    Atlantiss.DrugDealing:Debug(string.format("Verifying if zone ^5%s^3 is full (%s)", zoneId, isFull))
    return isFull
end

function Atlantiss.DrugDealing:GetCurrentDealersCountForZone(zoneId)
    local currentDealerCount = #self:GetCurrentDealersForZone(zoneId)
    Atlantiss.DrugDealing:Debug(string.format("Returning current dealer count for zone ^5%s^3 (%s dealers)", zoneId, currentDealerCount))
    return currentDealerCount
end

function Atlantiss.DrugDealing:GetCurrentDealersForZone(zoneId)
    if (self.CurrentDealersZones[zoneId] == nil) then
        self.CurrentDealersZones[zoneId] = {}   
    end

    Atlantiss.DrugDealing:Debug(string.format("Returning current dealers for zone ^5%s^3", zoneId))
    return self.CurrentDealersZones[zoneId]
end

function Atlantiss.DrugDealing:HasZoneIdEnoughCops(zoneId)
    local copsJuridiction = self:GetCopsJuridictionForZoneId(zoneId) 
    Atlantiss.DrugDealing:Debug(string.format("Returning if zone ^5%s^3 and juridiction ^5%s^3 has enough cops ", zoneId, copsJuridiction))
    return Atlantiss.Service:GetTotalServiceCountForJob(copsJuridiction) >= Atlantiss.Illegal:GetCopsRequired("drugselling")
end

function Atlantiss.DrugDealing:AddDealerIntoZoneId(zoneId, playerId)
    self:Debug(string.format("Adding ^5%s^3 as a dealer of zone id ^5%s^3", playerId, zoneId))
    self.CurrentDealers[playerId] = true
    if (self.CurrentDealersZones[zoneId] == nil) then
        self.CurrentDealersZones[zoneId] = {}
    end

    table.insert(self.CurrentDealersZones[zoneId], playerId)
end

function Atlantiss.DrugDealing:RemoveDealerFromZoneId(zoneId, playerId)
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

function Atlantiss.DrugDealing:IsDealing(playerId)
    if (self.CurrentDealers[playerId] ~= nil and self.CurrentDealers[playerId] == true) then
        Atlantiss.DrugDealing:Debug(string.format("Player ^5%s^3 is currently dealing", playerId))
        return true
    end

    Atlantiss.DrugDealing:Debug(string.format("Player ^5%s^3 is not dealing", playerId))
    return false
end

function Atlantiss.DrugDealing:RemoveDealerFromAnyZones(playerId)
    for key, value in pairs(self.CurrentDealersZones) do
        self:RemoveDealerFromZoneId(key, playerId)
    end
end

function Atlantiss.DrugDealing:ResetAreaPositionsForZoneId(zoneId)
    self:Debug(string.format("Reseting positions for zone id ^5%s^3", zoneId))
    self.AreaPositions[zoneId] = nil
end

function Atlantiss.DrugDealing:ResetAreaPositions()
    self:Debug(string.format("Reseting all positions for drug dealing areas"))
    self.AreaPositions = {}
end

function Atlantiss.DrugDealing:GetPositionsFileForZoneId(zoneId)
    if (Atlantiss.DrugDealing.AreaFiles[zoneId] ~= nil) then
        self:Debug(string.format("Resolving position file ^5%s^3 for zone id ^5%s^3", Atlantiss.DrugDealing.AreaFiles[zoneId], zoneId))
        return self.AreaFiles[zoneId]
    end

    self:Debug(string.format("Cannot resolve position file for zone id ^5%s^3", zoneId))
    return "false"
end

function Atlantiss.DrugDealing:GetPositionsForZoneId(zoneId)
    if (self.AreaPositions[zoneId] == nil) then
        self:Debug(string.format("Fetching positions from file for zone id ^5%s^3", zoneId))
        local contentAsJson = LoadResourceFile(GetCurrentResourceName(), "./" .. Atlantiss.DrugDealing:GetPositionsFileForZoneId(zoneId))
        self.AreaPositions[zoneId] = json.decode(contentAsJson)
    end

    self:Debug(string.format("Returning ^5%s^3 loaded positions for zone id ^5%s^3", #self.AreaPositions[zoneId], zoneId))
    return self.AreaPositions[zoneId]
end

RegisterServerCallback(
    "Atlantiss::SE::DrugDealing:GetZones",
    function(source, callback)
        Atlantiss.DrugDealing:Debug(string.format("^5%s^3 triggered ServerEventCallback : Atlantiss::SE::DrugDealing:GetZones to retrieve availables zones and status", source))
      callback(Atlantiss.DrugDealing:GetZones())
    end
)

RegisterServerCallback(
    "Atlantiss::SE::DrugDealing:GetPositionsForZoneId",
    function(source, callback, zoneId)
        Atlantiss.DrugDealing:Debug(string.format("^5%s^3 triggered ServerEventCallback : Atlantiss::SE::DrugDealing:GetPositionsForZoneId to retrieve positions for zone id ^5%s^3", source, zoneId))
      callback(Atlantiss.DrugDealing:GetPositionsForZoneId(zoneId))
    end
)

RegisterServerCallback(
    "Atlantiss::SE::DrugDealing:CanRegisterForDealingIntoZoneId",
    function(source, callback, zoneId)
        Atlantiss.DrugDealing:Debug(string.format("^5%s^3 triggered ServerEventCallback : Atlantiss::SE::DrugDealing:CanRegisterForDealingIntoZoneId to verify if it cans deal into zone id ^5%s^3", source, zoneId))
        local zoneIsFull = Atlantiss.DrugDealing:isZoneIdFull(zoneId)
        local hasEnoughCops = Atlantiss.DrugDealing:HasZoneIdEnoughCops(zoneId)

        if (zoneIsFull == true) then
            TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", source, string.format("La zone ~g~~h~%s~h~~s~ a déjà trop de dealers", Atlantiss.DrugDealing:GetDealingAreaNameById(zoneId)))
            callback(false)
        elseif (hasEnoughCops == false) then 
            TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", source, string.format("La zone ~g~~h~%s~h~~s~ n'a aucun client", Atlantiss.DrugDealing:GetDealingAreaNameById(zoneId)))
            callback(false)
        else
            callback(true)
        end
    end
)

RegisterServerCallback(
    "Atlantiss::SE::DrugDealing:GetBoostedZone",
    function(source, callback)
        callback(Atlantiss.DrugDealing:GetBoostedZone())
    end
)

RegisterServerEvent("Atlantiss::SE::DrugDealing:AddDealerForZone")
AddEventHandler(
    "Atlantiss::SE::DrugDealing:AddDealerForZone",
    function(zoneId)
        local _source = source
        Atlantiss.DrugDealing:AddDealerIntoZoneId(zoneId, _source)
        Atlantiss.DrugDealing:Debug(string.format("Player : ^5%s^3 is now added to zone id ^5%s^3 as a dealer",  _source, zoneId))
        TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", _source, string.format("Vous dealez désormais sur la zone ~g~~h~%s~h~~s~", Atlantiss.DrugDealing:GetDealingAreaNameById(zoneId)))
    end
)

RegisterServerEvent("Atlantiss::SE::DrugDealing:RemoveDealerForZone")
AddEventHandler(
    "Atlantiss::SE::DrugDealing:RemoveDealerForZone",
    function(zoneId)
        local _source = source
        Atlantiss.DrugDealing:Debug(string.format("Player : ^5%s^3 is now removed from zone id ^5%s^3. No more dealing",  _source, zoneId))
        Atlantiss.DrugDealing:RemoveDealerFromZoneId(zoneId, _source)
        TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", _source, string.format("Vous ne dealez plus dans la zone ~g~~h~%s~h~~s~", Atlantiss.DrugDealing:GetDealingAreaNameById(zoneId)))
    end
)

RegisterServerEvent("Atlantiss::Illegal:PlayerIsDead")
AddEventHandler("Atlantiss::Illegal:PlayerIsDead",function()
    local _source = source
    if (Atlantiss.DrugDealing:IsDealing(_source)) then
        Atlantiss.DrugDealing:Debug(string.format("Player : ^5%s^3 died. Removed as dealer",  _source))
        Atlantiss.DrugDealing:RemoveDealerFromAnyZones(_source)
        TriggerClientEvent("Atlantiss::CE::DrugDealing:StopDealing", _source)
        TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", _source, string.format("~r~Vous ne dealez plus car vous êtes mort~s~"))
    end
end)
