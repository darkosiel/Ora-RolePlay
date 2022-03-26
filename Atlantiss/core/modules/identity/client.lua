Atlantiss.Identity.List = {}
Atlantiss.Identity.InitFunctions = nil -- Define table in the thread down below

Citizen.CreateThread(
  function()
    while (Atlantiss.Player.HasLoaded == false) do Wait(50) end

    Wait(1000)

    Atlantiss.Identity.InitFunctions = {
      ['raffinerie'] = createFuelerJob,
      ['hacker'] = createHackerMenu,
      ['admin_drug'] = initAdminDrugMenu,
      ['police'] = Police.ON,
      ['lssd'] = Police.ON,
      ['casino'] = Atlantiss.Jobs.Casino.INIT,
      ['jetsam'] = Atlantiss.Jobs.Jetsam.INIT,
      ['immo'] = Atlantiss.Jobs.Immo.INIT,
      ['bleacher'] = Atlantiss.Jobs.Bleacher.INIT,
      ['lsfd'] = Atlantiss.Jobs.Firefighter.INIT,
      ['drivingschool'] = Atlantiss.Jobs.DrivingSchool.INIT,
    }
  end
)

function Atlantiss.Identity:GetIdentity(playerId)
    if playerId == 0 then
      return {uuid = nil, first_name = nil, last_name = nil, group = "user"}
    end
    
    if (self.List[playerId] ~= nil) then
        return self.List[playerId]
    end

    local canSend = false
    local identity = {}
    self:Debug(string.format("Fetching identity for player ^5%s^3", playerId))

    TriggerServerCallback("Atlantiss::SE::Identity:GetIdentity", function(data)
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

function Atlantiss.Identity:GetMyIdentity()
    return self:GetIdentity(GetPlayerServerId(PlayerId()))
end

function Atlantiss.Identity:GetFullname(playerId)
  local identity = Atlantiss.Identity:GetIdentity(playerId)
  if (identity == nil or identity.first_name == nil or identity.last_name == nil) then
    return "Non déterminé"
  end
  return identity.first_name .. " " .. identity.last_name
end

function Atlantiss.Identity:GetGroup(playerId)
  local identity = Atlantiss.Identity:GetIdentity(playerId)
  return identity.group
end

function Atlantiss.Identity:GetUuid(playerId)
  local identity = Atlantiss.Identity:GetIdentity(playerId)
  return identity.uuid
end

function Atlantiss.Identity:GetMyName()
  local identity = Atlantiss.Identity:GetMyIdentity()
  return identity.first_name .. " " .. identity.last_name
end

function Atlantiss.Identity:GetMyUuid()
  local identity = Atlantiss.Identity:GetMyIdentity()
  return identity.uuid
end

function Atlantiss.Identity:GetMyHealth()
  local identity = Atlantiss.Identity:GetMyIdentity()
  return identity.health
end


function Atlantiss.Identity:GetMyGroup()
  local identity = Atlantiss.Identity:GetMyIdentity()
  self:Debug(string.format("Retuning group for player ^5%s^3 ^5%s^3", GetPlayerServerId(PlayerId()), identity.group))
  return identity.group
end


function Atlantiss.Identity:HasAnyJob(job)
	if (job == self.Job:GetName() or job == self.Orga:GetName()) then
		return true
	end

  return false
end

RegisterNetEvent("Atlantiss::CE::Identity:SetUuid")
AddEventHandler(
  "Atlantiss::CE::Identity:SetUuid",
  function(uuid)
    print("Received my UUID", uuid)
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
