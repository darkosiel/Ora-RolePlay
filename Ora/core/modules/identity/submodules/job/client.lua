Ora.Identity.Job.Data = {}
Ora.Identity.Job.Data.Blips = {}
Ora.Identity.Job.isOnDuty = false
Ora.Identity.Job.CurrentZone = nil
Ora.Identity.Job.CurrentAction = nil
Ora.Identity.Job.ChangingJob = false

function Ora.Identity.Job:Fetch(playerId)
	local hasId = playerId ~= nil and true or false
	local paramId = playerId or GetPlayerServerId(PlayerId())
	local result = nil
	
	self:Debug(string.format("Fetching Job Array with SV CB ^5%s^3, the fetch fct has id ? ^5%s^3 playerID: ^5%s^3", "...:Job:Get", hasId, paramId))
	
	TriggerServerCallback(
	"Ora::SVCB::Identity:Job:Get",
	function(job)
		if (job ~= false and job ~= nil) then
			self:Debug(string.format("Received Job Array from SV CB ^5%s^3 with playerID: ^5%s^3. Fetch function has playerID param ? ^5%s^3. Job name ^5%s^3, job rank ^5%s^3", "...:Job:Get", paramId, hasId, job.name, job.rank))
				
				if (hasId == true) then
					result = {}
					for i, value in pairs(job) do
						result[i] = value
					end
				else
					if (Ora.Utils:TableLength(self.Data) == 0) then 
						self:Set(job.name, job.rank)
					else
						for i, value in pairs(job) do
							self.Data[i] = value
						end
					end
					
					result = self.Data
				end
				
			else
				self:Debug(string.format("Cannot retreive Job Array from SV CB ^5%s^3 with playerID: ^5%s^3", "...:Job:Get", paramId))
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

function Ora.Identity.Job:Init(job)
	self:Debug(string.format("Initializing %s, type: Jobs", job))
	v = job
	local t = v.Menu
	local works = v.work
	local Extrapos = v.Extrapos
	local extraBlips = v.Extrablips
	local Storages = v.Storage
	
	self.ChangingJob = true
	Citizen.SetTimeout(2000, function()
		Ora.Identity.Job.ChangingJob = false
		while (Ora.Identity.InitFunctions == nil) do Wait(50) end
		if (Ora.Identity.InitFunctions[Ora.Identity.Job:GetName()]) then Ora.Identity.InitFunctions[Ora.Identity.Job:GetName()]() end
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
	
	if v.garage5 ~= nil then
		local garage = Garage.New(v.garage5.Name, v.garage5.Pos, v.garage5.Properties, v.garage5.Blipdata)
		garage:Setup()
	end
	
	if v.garage6 ~= nil then
		local garage = Garage.New(v.garage6.Name, v.garage6.Pos, v.garage6.Properties, v.garage6.Blipdata)
		garage:Setup()
	end
	
	if v.garage7 ~= nil then
		local garage = Garage.New(v.garage7.Name, v.garage7.Pos, v.garage7.Properties, v.garage7.Blipdata)
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
		LoadJobMenu(t)
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
				KeySettings:Add("keyboard", "E", Ora.Identity.Job.StartAct, k)
				KeySettings:Add("controller", 46, Ora.Identity.Job.StartAct, k)
				self.CurrentZone = "Jobs"
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


function Ora.Identity.Job:Get()
	if (Ora.Utils:TableLength(self.Data) == 0) then
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

function Ora.Identity.Job:GetName()
	if not self.Data.name then
		return self:Fetch().name
	end
	
	return self.Data.name
end

function Ora.Identity.Job:GetRank()
	if not self.Data.rank then
		return self:Fetch().rank
	end
	
	return self.Data.rank
end

function Ora.Identity.Job:IsBoss()
	if (Ora.Utils:TableLength(self.Data.grades) == self.Data.gradenum and self.Data.name ~= "chomeur") then
		return true
	else
		return false
	end
end

function Ora.Identity.Job:IsCoBoss()
	if (Ora.Utils:TableLength(self.Data.grades) - 1 == self.Data.gradenum) then
		return true
	else
		return false
	end
end

function Ora.Identity.Job:GetSalary()
	return self.Data.grades[self.Data.gradenum].salary
end


-- Setters

local function copy1(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do res[copy1(k)] = copy1(v) end
    return res
end


function Ora.Identity.Job:Set(name, rank)
	self:Debug(string.format("^1Trying to set job to %s rank %s", name, rank))
	if Jobs[name] == nil then
		ShowNotification("~r~ Job incorrect !")
		return error(string.format("Job incorrect ! %s", name))
	end
	if Jobs[name].grade[tonumber(rank)] == nil then
		ShowNotification("~r~ Grade incorrect !")
		return error(string.format("Grade incorrect ! %s", rank))
	end
	
	local data = copy1(self.Data)
	self.ChangingOldName = tostring(data.name)
	--print("Old Job" .. self.ChangingOldName)
	self.Data = Jobs[name]
	self.Data.grades = Jobs[name].grade
	self.Data.gradelabel = Jobs[name].grade[tonumber(rank)].label
	self.Data.gradenum = tonumber(rank) -- check to delete that useless shit
	self.Data.name = name
	self.Data.rank = rank
	--print("Old Job 2" .. self.ChangingOldName)
	
	if self.Data.Blips == nil then self.Data.Blips = {} end
	
	for i = 1, Ora.Utils:TableLength(self.Data.Blips), 1 do
		if self.Data.Blips[i] then
			RemoveBlip(self.Data.Blips[i])
			table.remove(self.Data.Blips, i)
		end
	end
	
	self.Data.Blips = {}
	
	self:Debug(string.format("Job set, going to init Job properties with theses parameters: (%s, %s) then saving SV side with (%s, %s)", Jobs[name], "Jobs", self.Data.name, self.Data.rank))
		self:Init(Jobs[name], "Jobs")
		TriggerServerEvent("Ora::SE::Identity:Job:Save", self.Data.name, self.Data.rank)
	end
	
	
	-- Events
	
	
	RegisterNetEvent("Ora::CE::Identity:Job:Set")
	AddEventHandler(
	"Ora::CE::Identity:Job:Set",
	function(name, rank, force)
		if (
		(Ora.Identity.Orga:GetName() ~= name) or
		force
	) then
		Ora.Identity.Job:Set(name, rank)
	elseif (Ora.Identity.Orga:GetName() == name) then
		Ora.Identity.Orga:Set("chomeur", 1)
		Ora.Identity.Job:Set(name, rank)
	else
		RageUI.Popup({message = "~r~Vous avez déjà un travail primaire."})
	end
end
)


-- Exports


exports(
	'OraGetJob',
	function()
		return Ora.Identity.Job:Get()
	end
)


-- Shitty functions


function Ora.Identity.Job.StartAct(action)
	Ora.Identity.Job.CurrentAction = action
	if action == "vestiaire" then
		OpenClotheRoom(Ora.Identity.Job.CurrentZone)
	else
		StartRecolte(Ora.Identity.Job.CurrentZone)
	end
end
