Ora.Service.Jobs = {
  ["ltd"] = {},
  ["police"] = {},
  ["lssd"] = {},
  ["lsms"] = {},
  ["mecano"] = {},
  ["mecano2"] = {},
  ["uber"] = {},
  ["caroccasions"] = {}
}

function Ora.Service:GetServiceArray()
  self:Debug(string.format("Returning service array"))
  return self.Jobs
end

function Ora.Service:GetJobService(job)
  if (self.Jobs[job] == nil) then
    self:Debug(string.format("Returning on empty table for on duty players because job ^5%s^3 does not exists", job))
    return {}
  end
  
    self:Debug(string.format("Returning on duty players for job ^5%s^3", job))
   return self.Jobs[job]
end

function Ora.Service:ShowOnDutyPlayersForJob(receiver, job)
  if (self.Jobs[job] == nil) then
    TriggerClientEvent("Ora::CE::Core:ShowNotification", receiver, string.format("~h~%s~h~ n'est en service.", "Personne"))
  else
    if (#self.Jobs[job] > 0) then
      for _, value in pairs(self.Jobs[job]) do
        local fullname = Ora.Identity:GetFullname(value)
        self:Debug(string.format("Notifying ^5%s^3 that ^5%s^3 is on duty for job ^5%s^3", receiver, fullname, job))
        TriggerClientEvent("Ora::CE::Core:ShowNotification", receiver, string.format("~h~%s~h~ est en service.", fullname))
      end
    else
      TriggerClientEvent("Ora::CE::Core:ShowNotification", receiver, string.format("~h~%s~h~ n'est en service.", "Personne"))
    end
  end
end

function Ora.Service:NotifyPlayerIsOnDuty(player, job)
  if (self.Jobs[job] == nil) then
    self:Debug(string.format("Won't notify on duty because job ^5%s^3 does not exist", job))
  else
    local fullname = Ora.Identity:GetFullname(player)
    self:Debug(string.format("Notifying that ^5%s^3 is now on duty for job ^5%s^3", fullname, job))
    for _, value in pairs(self.Jobs[job]) do
      self:Debug(string.format("Notifying ^5%s^3 that player ^5%s^3 is on duty", value, fullname))
        TriggerClientEvent("Ora::CE::Core:ShowNotification", value, string.format("~h~%s~h~ est en service.", fullname))
    end
  end
end

function Ora.Service:NotifyPlayerIsOffDuty(player, job)
  if (Ora.Service.Jobs[job] == nil) then
    Ora.Service:Debug(string.format("Won't notify off duty because job ^5%s^3 does not exist", job))
  else
    local fullname = Ora.Identity:GetFullname(player)
    Ora.Service:Debug(string.format("Notifying that ^5%s^3 is now off duty for job ^5%s^3", fullname, job))
    for _, value in pairs(self.Jobs[job]) do
      self:Debug(string.format("Notifying ^5%s^3 that player ^5%s^3 is off duty", value, fullname))
      TriggerClientEvent("Ora::CE::Core:ShowNotification", value, string.format("~h~%s~h~ n'est plus en service.", fullname))
    end
  end
end

function Ora.Service:RemoveFromService(player, job)
  for i, val in pairs(self.Jobs[job]) do
      if val == player then
          table.remove(self.Jobs[job], i)
          --Ora.Service:NotifyPlayerIsOffDuty(player, job)
          Ora.Service:Debug(string.format("Removed : ^5%s^3 from job service ^5%s", player, job))
          return
      end
  end
end


function Ora.Service:GetTotalServiceCountForJob(job)
  if (self.Jobs[job] ~= nil) then
    self:Debug(string.format("Added : ^5%s^3 members in GetTotalServiceCountForJob for job ^5%s", #Ora.Service.Jobs[job], job))
    return #self.Jobs[job]
  end

  self:Debug(string.format("Callback sended total members : ^5%s^3 in GetTotalServiceCountForJob because it does not exists", 0))
  return 0
end

function Ora.Service:GetTotalServiceCountForJobs(jobs)
  local numberOfService = 0

  for key, value in pairs(jobs) do
    if (self.Jobs[value] ~= nil) then
      numberOfService = numberOfService + #self.Jobs[value]
      self:Debug(string.format("Added : ^5%s^3 members in GetTotalServiceCountForJobs for job ^5%s", #Ora.Service.Jobs[value], value))
    end
  end
  self:Debug(string.format("Callback sended total members : ^5%s^3 in GetTotalServiceCountForJobs", numberOfService))
  return numberOfService
end

function Ora.Service:IsPlayerInService(player, job)
  if (self.Jobs[job] ~= nil) then
    for _, value in pairs(self.Jobs[job]) do
      if (value == player) then
        self:Debug(string.format("Player ^5%s^3 is in service for job ^5%s^3", player, job))
        return true
      end
    end
  end

  self:Debug(string.format("Player ^5%s^3 is not in service for job ^5%s^3", player, job))
  return false
end

RegisterServerEvent("Ora::SE::Service:ShowOnDutyPlayers")
AddEventHandler(
    "Ora::SE::Service:ShowOnDutyPlayers",
    function(job)
        local _source = source
        Ora.Service:ShowOnDutyPlayersForJob(_source, job)
    end
)

RegisterServerEvent("Ora::SE::Service:AddJob")
AddEventHandler(
    "Ora::SE::Service:AddJob",
    function(job)
        if (Ora.Service.Jobs[job] == nil) then
            Ora.Service.Jobs[job] = {}
            Ora.Service:Debug(string.format("Add new job : ^5%s^3 service", job))
        else
          Ora.Service:Debug(string.format("Already existing job : ^5%s^3 service", job))
        end
    end
)

RegisterServerEvent("Ora::SE::Service:RemoveJob")
AddEventHandler(
    "Ora::SE::Service:RemoveJob",
    function(job)
        if (Ora.Service.Jobs[job] ~= nil) then
            Ora.Service.Jobs[job] = nil
            Ora.Service:Debug(string.format("Removed job : ^5%s^3 service", job))
        else
          Ora.Service:Debug(string.format("No existing job : ^5%s^3 service", job))
        end
    end
)

RegisterServerEvent("Ora::SE::Service:SetPlayerInService")
AddEventHandler(
    "Ora::SE::Service:SetPlayerInService",
    function(job)
        local _source = source
        if (Ora.Service.Jobs[job] == nil) then
            Ora.Service.Jobs[job] = {}
            Ora.Service:Debug(string.format("Add new job : ^5%s^3 service", job))
        end

        Ora.Service:Debug(string.format("Added : ^5%s^3 in job service ^5%s",  _source, job))
        table.insert(Ora.Service.Jobs[job], _source)
        --Ora.Service:NotifyPlayerIsOnDuty(_source, job)
    end
)

RegisterServerEvent("Ora::SE::Service:RemovePlayerFromService")
AddEventHandler(
    "Ora::SE::Service:RemovePlayerFromService",
    function(job)
        local _source = source

        if job == nil then
            for _, v in pairs(Ora.Service.Jobs) do
              Ora.Service:RemoveFromService(_source, _)
            end
        else
            Ora.Service:RemoveFromService(_source, job)
        end
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        for _, v in pairs(Ora.Service:GetServiceArray()) do
          Ora.Service:RemoveFromService(source, _)
        end
        Ora.Service:Debug(string.format("Player : ^5%s^3 dropped. removed service",  source))
    end
)

RegisterServerCallback(
    "Ora::SE::Service:GetInServiceCount",
    function(source, callback, job)
        if Ora.Service.Jobs[job] ~= nil then
          Ora.Service:Debug(string.format("Callback sended : ^5%s^3 players in service for job ^5%s^3", #Ora.Service.Jobs[job], job))
          callback(#Ora.Service.Jobs[job])
        else
          Ora.Service:Debug(string.format("Callback sended : ^5%s^3 players in service for job ^5%s^3 because it does not exist", 0, job))
          callback(0)
        end
    end
)

RegisterServerCallback(
    "Ora::SE::Service:GetTotalServiceCountForJobs",
    function(source, callback, jobs)
        callback(Ora.Service:GetTotalServiceCountForJobs(jobs))
    end
)

Citizen.CreateThread(
  function()
    Wait(5000)
    for k, v in pairs(Jobs) do
      TriggerEvent("Ora::SE::Service:AddJob", k)
    end
  end
)
