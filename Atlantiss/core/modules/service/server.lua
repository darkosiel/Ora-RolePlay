Atlantiss.Service.Jobs = {
  ["ltd"] = {},
  ["police"] = {},
  ["lssd"] = {},
  ["lsms"] = {},
  ["mecano"] = {},
  ["mecano2"] = {},
  ["uber"] = {},
  ["caroccasions"] = {}
}

function Atlantiss.Service:GetServiceArray()
  self:Debug(string.format("Returning service array"))
  return self.Jobs
end

function Atlantiss.Service:GetJobService(job)
  if (self.Jobs[job] == nil) then
    self:Debug(string.format("Returning on empty table for on duty players because job ^5%s^3 does not exists", job))
    return {}
  end
  
    self:Debug(string.format("Returning on duty players for job ^5%s^3", job))
   return self.Jobs[job]
end

function Atlantiss.Service:ShowOnDutyPlayersForJob(receiver, job)
  if (self.Jobs[job] == nil) then
    TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", receiver, string.format("~h~%s~h~ n'est en service.", "Personne"))
  else
    if (#self.Jobs[job] > 0) then
      for _, value in pairs(self.Jobs[job]) do
        local fullname = Atlantiss.Identity:GetFullname(value)
        self:Debug(string.format("Notifying ^5%s^3 that ^5%s^3 is on duty for job ^5%s^3", receiver, fullname, job))
        TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", receiver, string.format("~h~%s~h~ est en service.", fullname))
      end
    else
      TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", receiver, string.format("~h~%s~h~ n'est en service.", "Personne"))
    end
  end
end

function Atlantiss.Service:NotifyPlayerIsOnDuty(player, job)
  if (self.Jobs[job] == nil) then
    self:Debug(string.format("Won't notify on duty because job ^5%s^3 does not exist", job))
  else
    local fullname = Atlantiss.Identity:GetFullname(player)
    self:Debug(string.format("Notifying that ^5%s^3 is now on duty for job ^5%s^3", fullname, job))
    for _, value in pairs(self.Jobs[job]) do
      self:Debug(string.format("Notifying ^5%s^3 that player ^5%s^3 is on duty", value, fullname))
        TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", value, string.format("~h~%s~h~ est en service.", fullname))
    end
  end
end

function Atlantiss.Service:NotifyPlayerIsOffDuty(player, job)
  if (Atlantiss.Service.Jobs[job] == nil) then
    Atlantiss.Service:Debug(string.format("Won't notify off duty because job ^5%s^3 does not exist", job))
  else
    local fullname = Atlantiss.Identity:GetFullname(player)
    Atlantiss.Service:Debug(string.format("Notifying that ^5%s^3 is now off duty for job ^5%s^3", fullname, job))
    for _, value in pairs(self.Jobs[job]) do
      self:Debug(string.format("Notifying ^5%s^3 that player ^5%s^3 is off duty", value, fullname))
      TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", value, string.format("~h~%s~h~ n'est plus en service.", fullname))
    end
  end
end

function Atlantiss.Service:RemoveFromService(player, job)
  for i, val in pairs(self.Jobs[job]) do
      if val == player then
          table.remove(self.Jobs[job], i)
          --Atlantiss.Service:NotifyPlayerIsOffDuty(player, job)
          Atlantiss.Service:Debug(string.format("Removed : ^5%s^3 from job service ^5%s", player, job))
          return
      end
  end
end


function Atlantiss.Service:GetTotalServiceCountForJob(job)
  if (self.Jobs[job] ~= nil) then
    self:Debug(string.format("Added : ^5%s^3 members in GetTotalServiceCountForJob for job ^5%s", #Atlantiss.Service.Jobs[job], job))
    return #self.Jobs[job]
  end

  self:Debug(string.format("Callback sended total members : ^5%s^3 in GetTotalServiceCountForJob because it does not exists", 0))
  return 0
end

function Atlantiss.Service:GetTotalServiceCountForJobs(jobs)
  local numberOfService = 0

  for key, value in pairs(jobs) do
    if (self.Jobs[value] ~= nil) then
      numberOfService = numberOfService + #self.Jobs[value]
      self:Debug(string.format("Added : ^5%s^3 members in GetTotalServiceCountForJobs for job ^5%s", #Atlantiss.Service.Jobs[value], value))
    end
  end
  self:Debug(string.format("Callback sended total members : ^5%s^3 in GetTotalServiceCountForJobs", numberOfService))
  return numberOfService
end

RegisterServerEvent("Atlantiss::SE::Service:ShowOnDutyPlayers")
AddEventHandler(
    "Atlantiss::SE::Service:ShowOnDutyPlayers",
    function(job)
        local _source = source
        Atlantiss.Service:ShowOnDutyPlayersForJob(_source, job)
    end
)

RegisterServerEvent("Atlantiss::SE::Service:AddJob")
AddEventHandler(
    "Atlantiss::SE::Service:AddJob",
    function(job)
        if (Atlantiss.Service.Jobs[job] == nil) then
            Atlantiss.Service.Jobs[job] = {}
            Atlantiss.Service:Debug(string.format("Add new job : ^5%s^3 service", job))
        else
          Atlantiss.Service:Debug(string.format("Already existing job : ^5%s^3 service", job))
        end
    end
)

RegisterServerEvent("Atlantiss::SE::Service:RemoveJob")
AddEventHandler(
    "Atlantiss::SE::Service:RemoveJob",
    function(job)
        if (Atlantiss.Service.Jobs[job] ~= nil) then
            Atlantiss.Service.Jobs[job] = nil
            Atlantiss.Service:Debug(string.format("Removed job : ^5%s^3 service", job))
        else
          Atlantiss.Service:Debug(string.format("No existing job : ^5%s^3 service", job))
        end
    end
)

RegisterServerEvent("Atlantiss::SE::Service:SetPlayerInService")
AddEventHandler(
    "Atlantiss::SE::Service:SetPlayerInService",
    function(job)
        local _source = source
        if (Atlantiss.Service.Jobs[job] == nil) then
            Atlantiss.Service.Jobs[job] = {}
            Atlantiss.Service:Debug(string.format("Add new job : ^5%s^3 service", job))
        end

        Atlantiss.Service:Debug(string.format("Added : ^5%s^3 in job service ^5%s",  _source, job))
        table.insert(Atlantiss.Service.Jobs[job], _source)
        --Atlantiss.Service:NotifyPlayerIsOnDuty(_source, job)
    end
)

RegisterServerEvent("Atlantiss::SE::Service:RemovePlayerFromService")
AddEventHandler(
    "Atlantiss::SE::Service:RemovePlayerFromService",
    function(job)
        local _source = source

        if job == nil then
            for _, v in pairs(Atlantiss.Service.Jobs) do
              Atlantiss.Service:RemoveFromService(_source, _)
            end
        else
            Atlantiss.Service:RemoveFromService(_source, job)
        end
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        for _, v in pairs(Atlantiss.Service:GetServiceArray()) do
          Atlantiss.Service:RemoveFromService(source, _)
        end
        Atlantiss.Service:Debug(string.format("Player : ^5%s^3 dropped. removed service",  source))
    end
)

RegisterServerCallback(
    "Atlantiss::SE::Service:GetInServiceCount",
    function(source, callback, job)
        if Atlantiss.Service.Jobs[job] ~= nil then
          Atlantiss.Service:Debug(string.format("Callback sended : ^5%s^3 players in service for job ^5%s^3", #Atlantiss.Service.Jobs[job], job))
          callback(#Atlantiss.Service.Jobs[job])
        else
          Atlantiss.Service:Debug(string.format("Callback sended : ^5%s^3 players in service for job ^5%s^3 because it does not exist", 0, job))
          callback(0)
        end
    end
)

RegisterServerCallback(
    "Atlantiss::SE::Service:GetTotalServiceCountForJobs",
    function(source, callback, jobs)
        callback(Atlantiss.Service:GetTotalServiceCountForJobs(jobs))
    end
)

Citizen.CreateThread(
  function()
    Wait(5000)
    for k, v in pairs(Jobs) do
      TriggerEvent("Atlantiss::SE::Service:AddJob", k)
    end
  end
)
