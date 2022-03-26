Atlantiss.Identity.Orga.Data = {}
Atlantiss.Identity.Orga.Data.Blips = {}
Atlantiss.Identity.Orga.isOnDuty = false
Atlantiss.Identity.Orga.CurrentZone = nil
Atlantiss.Identity.Orga.CurrentAction = nil
Atlantiss.Identity.Orga.ChangingJob = false

function Atlantiss.Identity.Orga:Fetch(playerId)
  local hasId = playerId ~= nil and true or false
  local paramId = playerId or GetPlayerServerId(PlayerId())
  local result = nil

  self:Debug(string.format("Fetching Orga Array with SV CB ^5%s^3, the fetch fct has id ? ^5%s^3 playerID: ^5%s^3", "...:Orga:Get", hasId, paramId))

  TriggerServerCallback(
    "Atlantiss::SVCB::Identity:Orga:Get",
    function(orga)
      if (orga ~= false and orga ~= nil) then
        self:Debug(string.format("Received Orga Array from SV CB ^5%s^3 with playerID: ^5%s^3. Fetch function has playerID param ? ^5%s^3. orga name ^5%s^3, orga rank ^5%s^3", "...:Orga:Get", paramId, hasId, orga.name, orga.rank))
        
        if (hasId == true) then
          result = {}
          for i, value in pairs(orga) do
            result[i] = value
          end
        else
          if (Atlantiss.Utils:TableLength(self.Data) == 0) then 
            self:Set(orga.name, orga.rank)
          else
            for i, value in pairs(orga) do
              self.Data[i] = value
            end
          end

          result = self.Data
        end

      else
        self:Debug(string.format("Cannot retreive Orga Array from SV CB ^5%s^3 with playerID: ^5%s^3", "...:Orga:Get", paramId))
        result = {name = nil, rank = nil}
      end
    end,
    paramId
  )

  while (result == nil or #result == 0) do
    Wait(500)
  end

  return result
end

function Atlantiss.Identity.Orga:Init(orga)
  self:Debug(string.format("Initializing %s, type: Orga", orga))
  v = orga
  local t = v.Menu
  local works = v.work
  local Extrapos = v.Extrapos
  local extraBlips = v.Extrablips
  local Storages = v.Storage

  self.ChangingJob = true
  Citizen.SetTimeout(2000, function()
    Atlantiss.Identity.Orga.ChangingJob = false
    while (Atlantiss.Identity.InitFunctions == nil) do Wait(50) end
    if (Atlantiss.Identity.InitFunctions[Atlantiss.Identity.Orga:GetName()]) then Atlantiss.Identity.InitFunctions[Atlantiss.Identity.Orga:GetName()]() end
  end)

  if v.garage ~= nil then
    self.Garage = v.garage
    local garage = Garage.New(v.garage.Name, v.garage.Pos, v.garage.Properties, v.garage.Blipdata)
    garage:Setup()
  end

  if v.garage2 ~= nil then
    local garage = Garage.New(v.garage2.Name, v.garage2.Pos, v.garage2.Properties, v.garage2.Blipdata)
    garage:Setup()
  end

  if v.garage3 ~= nil then
    local garage = Garage.New(v.garage3.Name, v.garage3.Pos, v.garage3.Properties, v.garage3.Blipdata)
    garage:Setup()
  end

  if v.garage4 ~= nil then
    local garage = Garage.New(v.garage4.Name, v.garage4.Pos, v.garage4.Properties, v.garage4.Blipdata)
    garage:Setup()
  end

  if Storages then
    for _, storage in pairs(Storages) do
      self:Debug(string.format("Initializing Storage ^5%s^3, limit: ^5%s^3, pos: ^5%s^3", storage.Name, storage.Limit, vector3(storage.Pos.x, storage.Pos.y, storage.Pos.z)))
      local Storage = Storage.New(storage.Name .. "_storage", storage.Limit)
      Storage:LinkToPos(storage.Pos)
    end
  end

  if t then
    LoadOrgaMenu(t)
  end

  if Extrapos ~= nil then
    for k, v in pairs(Extrapos) do
      local f = false
      if v.restricted ~= nil then
        for i = 1, #v.restricted, 1 do
          if v.restricted[i] == self:Get().gradenum then
            f = true
            break
          end
        end
      else
        f = true
      end
      if f then
        for i = 1, #v.Pos, 1 do
          Zone:Add(v.Pos[i], v.Enter, v.Exit, k, v.zonesize)
          local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
          SetBlipSprite(blip, v.Blips.sprite)
          SetBlipDisplay(blip, 4)
          SetBlipScale(blip, 0.8)
          SetBlipColour(blip, v.Blips.color)
          SetBlipAsShortRange(blip, true)
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString(v.Blips.name)
          EndTextCommandSetBlipName(blip)
          table.insert(self.Data.Blips, blip)
          v.Pos[i].z = v.Pos[i].z - 1.0
          Marker:Add(v.Pos[i], v.Marker)
        end
      end
    end
  end

  if extraBlips ~= nil then
    for k, v in pairs(extraBlips) do
      local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
      SetBlipSprite(blip, v.Blips.sprite)
      SetBlipDisplay(blip, 4)
      SetBlipScale(blip, 0.8)
      SetBlipColour(blip, v.Blips.color)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(v.Blips.name)
      EndTextCommandSetBlipName(blip)
      table.insert(self.Data.Blips, blip)
    end
  end

  if works ~= nil then
    for k, v in pairs(works) do
      local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
      SetBlipSprite(blip, 1)
      SetBlipDisplay(blip, 4)
      SetBlipScale(blip, 0.8)
      SetBlipColour(blip, v.blipcolor)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(v.blipname)
      EndTextCommandSetBlipName(blip)
      table.insert(self.Data.Blips, blip)
      Zone:Add(
        v.Pos,
        function()
          Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
          KeySettings:Add("keyboard", "E", Atlantiss.Identity.Orga.StartAct, k)
          KeySettings:Add("controller", 46, Atlantiss.Identity.Orga.StartAct, k)
          self.CurrentZone = "Orga"
        end,
        function()
          Hint:RemoveAll()
          KeySettings:Clear("keyboard", "E", k)
          KeySettings:Clear("controller", 46, k)
          RageUI.Visible(RMenu:Get("jobs", k), false)
          StopCurrentWork(true)
          self.CurrentZone = nil
        end,
        k,
        v.workSize or 1.5
      )
      RMenu.Add("jobs", k, RageUI.CreateMenu(nil, "Tenues disponibles", 10, 100))
    end
  end
end


-- Getters


function Atlantiss.Identity.Orga:Get()
  if (Atlantiss.Utils:TableLength(self.Data) == 0) then
    return self:Fetch()
  end

  if self.Data.name and self.Data.rank and (not self.Data.gradelabel or not self.Data.gradenum or not self.Data.grades) then
    self.Data.grades = Jobs[self.Data.name].grade
    self.Data.gradelabel = Jobs[self.Data.name].grade[tonumber(self.Data.rank)].label
    self.Data.gradenum = tonumber(self.Data.rank)
  end

  if self.Data.name and self.Data.rank then
    return self.Data
  else
    return self:Fetch()
  end
end

function Atlantiss.Identity.Orga:GetName()
  if not self.Data.name then
    return self:Fetch().name
  end

	return self.Data.name
end

function Atlantiss.Identity.Orga:GetRank()
  if not self.Data.rank then
    return self:Fetch().rank
  end

	return self.Data.rank
end

function Atlantiss.Identity.Orga:IsBoss()
  if (Atlantiss.Utils:TableLength(self.Data.grades) == self.Data.gradenum and self.Data.name ~= "chomeur") then
    return true
  else
    return false
  end
end

function Atlantiss.Identity.Orga:IsCoBoss()
  if (Atlantiss.Utils:TableLength(self.Data.grades) - 1 == self.Data.gradenum) then
    return true
  else
    return false
  end
end

function Atlantiss.Identity.Orga:GetSalary()
  return self.Data.grades[self.Data.gradenum].salary
end


-- Setters


function Atlantiss.Identity.Orga:Set(name, rank)
  self:Debug(string.format("^1Trying to set orga to %s rank %s", name, rank))
  if Jobs[name] == nil then
    return error(string.format("Job2 incorrect ! %s", name))
  end
  if Jobs[name].grade[tonumber(rank)] == nil then
    return error(string.format("Grade incorrect ! %s", rank))
  end

  self.Data = Jobs[name]
  self.Data.grades = Jobs[name].grade
  self.Data.gradelabel = Jobs[name].grade[tonumber(rank)].label
  self.Data.gradenum = tonumber(rank) -- check to delete that useless shit
  self.Data.name = name
  self.Data.rank = rank

  if self.Data.Blips == nil then self.Data.Blips = {} end

  for i = 1, Atlantiss.Utils:TableLength(self.Data.Blips), 1 do
    if self.Data.Blips[i] then
      RemoveBlip(self.Data.Blips[i])
      table.remove(self.Data.Blips, i)
    end
  end

  self.Data.Blips = {}

  self:Debug(string.format("Orga set, going to init orga properties with theses parameters: (%s, %s) then saving SV side with (%s, %s)", Jobs[name], "Orga", self.Data.name, self.Data.rank))
  self:Init(Jobs[name], "Orga")
  TriggerServerEvent("Atlantiss::SE::Identity:Orga:Save", self.Data.name, self.Data.rank)
end


-- Events


RegisterNetEvent("Atlantiss::CE::Identity:Orga:Set")
AddEventHandler(
  "Atlantiss::CE::Identity:Orga:Set",
  function(name, rank, force)
    if (
      (Atlantiss.Identity.Job:GetName() ~= name) or
      force
    ) then
      Atlantiss.Identity.Orga:Set(name, rank)
    elseif (Atlantiss.Identity.Job:GetName() == name) then
      Atlantiss.Identity.Orga:Set("chomeur", 1)
      Atlantiss.Identity.Job:Set(name, rank)
    else
      RageUI.Popup({message = string.format("~r~Vous travaillez déjà au %s.", Jobs[name].label)})
    end
  end
)


-- Exports


exports(
  'AtlantissGetOrga',
  function()
    return Atlantiss.Identity.Orga:Get()
  end
)


-- Shitty functions


function Atlantiss.Identity.Orga.StartAct(action)
  Atlantiss.Identity.Orga.CurrentAction = action
  if action == "vestiaire" then
    OpenClotheRoom(Atlantiss.Identity.Orga.CurrentZone)
  else
    StartRecolte(Atlantiss.Identity.Orga.CurrentZone)
  end
end
