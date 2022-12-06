Ora.Identity.List = {}
Ora.Identity.InitFunctions = nil -- Define table in the thread down below

Citizen.CreateThread(
  function()
    while (Ora.Player.HasLoaded == false) do Wait(50) end

    Wait(1000)

    Ora.Identity.InitFunctions = {
      ['raffinerie'] = createFuelerJob,
      ['hacker'] = createHackerMenu,
      ['admin_drug'] = initAdminDrugMenu,
      ['police'] = Police.ON,
      ['lssd'] = Police.ON,
      -- ['casino'] = Ora.Jobs.Casino.INIT,
      ['jetsam'] = Ora.Jobs.Jetsam.INIT,
      --['immo'] = Ora.Jobs.Immo.INIT,
      -- ['bleacher'] = Ora.Jobs.Bleacher.INIT,
      ['lsfd'] = Ora.Jobs.Firefighter.INIT,
      ['drivingschool'] = Ora.Jobs.DrivingSchool.INIT,
      ["mazegroup"] = InitBankerJob,
    }
  end
)

function Ora.Identity:GetIdentity(playerId)
    if playerId == 0 then
      return {uuid = nil, first_name = nil, last_name = nil, group = "user"}
    end
    
    if (self.List[playerId] ~= nil) then
        return self.List[playerId]
    end

    local canSend = false
    local identity = {}
    self:Debug(string.format("Fetching identity for player ^5%s^3", playerId))

    TriggerServerCallback("Ora::SE::Identity:GetIdentity", function(data)
      identity = data
      canSend = true
    end, playerId)
    
    local maxTime = GetGameTimer() + 5000
    while (canSend == false or GetGameTimer() > maxTime) do
      self:Debug(string.format("Waiting data pulling for player ^5%s^3", playerId))
      Wait(100)      
    end
    
    self:Debug(string.format("Returning identity data for player ^5%s^3", playerId))
    self.List[playerId] = identity
    return self.List[playerId]
end

function Ora.Identity:GetMyIdentity()
    return self:GetIdentity(GetPlayerServerId(PlayerId()))
end

function Ora.Identity:GetFullname(playerId)
  local identity = Ora.Identity:GetIdentity(playerId)
  if (identity == nil or identity.first_name == nil or identity.last_name == nil) then
    return "Non déterminé"
  end
  return identity.first_name .. " " .. identity.last_name
end

exports('GetFullname', Ora.Identity.GetFullname)

function Ora.Identity:GetGroup(playerId)
  local identity = Ora.Identity:GetIdentity(playerId)
  return identity.group
end

function Ora.Identity:GetUuid(playerId)
  local identity = Ora.Identity:GetIdentity(playerId)
  return identity.uuid
end

function Ora.Identity:GetMyName()
  local identity = Ora.Identity:GetMyIdentity()
  return identity.first_name .. " " .. identity.last_name
end

function Ora.Identity:GetMyUuid()
  local identity = Ora.Identity:GetMyIdentity()
  return identity.uuid
end

function Ora.Identity:GetMyHealth()
  local identity = Ora.Identity:GetMyIdentity()
  return identity.health
end


function Ora.Identity:GetMyGroup()
  local identity = Ora.Identity:GetMyIdentity()
  self:Debug(string.format("Retuning group for player ^5%s^3 ^5%s^3", GetPlayerServerId(PlayerId()), identity.group))
  return identity.group
end

function GetMyGroup()
  local identity = Ora.Identity:GetMyIdentity()
  return identity.group
end

function Ora.Identity:HasAnyJob(job)
	if (job == self.Job:GetName() or job == self.Orga:GetName()) then
		return true
	end

  return false
end

RegisterNetEvent("Ora::CE::Identity:SetUuid")
AddEventHandler(
  "Ora::CE::Identity:SetUuid",
  function(uuid)
    --print("Received my UUID", uuid)
    PlyUuid = uuid
  end
)

RegisterNetEvent("Job:Annonce")
AddEventHandler("Job:Annonce", function(title, subject, message, icon, iconType)
  -- SetNotificationBackgroundColor(130)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(message)
  SetNotificationMessage(icon, icon, false, iconType, title, subject)
  DrawNotification(false, false)
end)
