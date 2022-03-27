Ora.World.Appart = {}
Ora.World.Appart.CURRENT = {}
Ora.World.Appart.LIST = {}
Ora.World.Appart.LIST_LOADED = false

function Ora.World.Appart:GetList()
  if self.LIST_LOADED == false then
    Ora.World:Debug(string.format("Appartement list not loaded. Loading it"))
    local responseReceived = false

    TriggerServerCallback("Ora::SE::World:Appart:GetAll", 
        function(appartsAsJson)
            local apparts = json.decode(appartsAsJson)

            for key, value in pairs(apparts) do
              self.LIST[math.tointeger(key)] = value
            end
            Ora.World:Debug(string.format("Appartement list is now loaded. Fetched ^5%s^3 appartements", #apparts))
            responseReceived = true
        end
    )

    local maxTimeProcessing = GetGameTimer() + 5000

    while responseReceived == false or maxTimeProcessing < GetGameTimer() do
      Ora.World:Debug(string.format("Waiting appartement list to be pulled from server"))
      Wait(100)
    end

    self.LIST_LOADED = true
  end

  return self.LIST
end

function Ora.World.Appart:GetById(appartId)
  if (self:GetList()[appartId] ~= nil) then
    Ora.World:Debug(string.format("Appartement ^5%s^3 already in list. Returning", appartId))
    return self:GetList()[appartId]
  end

  local responseReceived = false
  local appart = {}

  Ora.World:Debug(string.format("Appartement ^5%s^3 not in list, loading it", appartId))
  TriggerServerCallback("Ora::SE::World:Appart:GetById", 
      function(appartAsJson)
          appart = json.decode(appartAsJson)
          Ora.World:Debug(string.format("Received data for appartement ^5%s^3", appartId))
          if (appart.id ~= nil) then
            Ora.World:Debug(string.format("Added appartement ^5%s^3 in list", appartId))
            self:AddToList(appart)
          end
          responseReceived = true
      end,
      appartId
  )

  local maxTimeProcessing = GetGameTimer() + 5000

  while responseReceived == false or maxTimeProcessing < GetGameTimer() do
    Ora.World:Debug(string.format("Waiting pulling data for appartement ^5%s^3", appartId))
    Wait(100)
  end

  if (appart.id ~= nil) then
    Ora.World:Debug(string.format("Returning loaded appartement : ^5%s^3", appartId))
    return appart
  end

  Ora.World:Debug(string.format("Appartement : ^5%s^3 not found", appartId))
  return nil
end

function Ora.World.Appart:RemoveFromList(id)
  if (self:GetList()[id] ~= nil) then
    Ora.World:Debug(string.format("Appartement : ^5%s^3 has been removed", id))
    self:GetList()[id] = nil
    return true
  end
  Ora.World:Debug(string.format("Appartement : ^5%s^3 not found in list. Already removed ?", id))
  return false
end

function Ora.World.Appart:AddToList(object)
  if (type(object) == "string") then
    object = json.decode(object)
  end

  if (type(object) == "table" and object.id ~= nil) then
    Ora.World:Debug(string.format("Appartement : ^5%s^3 is now added to list", object.id))
    self:GetList()[object.id] = object
    return true
  end

  return false
end

function Ora.World.Appart:ExitFromAppartCreateHint(position)
  Ora.World.Appart.CURRENT.Position = position
  Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour sortir")
  KeySettings:Add("keyboard", "E", Ora.World.Appart["ExitAppart"], "Appart_")
  KeySettings:Add("controller", 46, Ora.World.Appart["ExitAppart"], "Appart_")
end

function Ora.World.Appart:ExitAppart()
  Ora.Player.SavedPos = {}

  if (Ora.World.Appart.CURRENT.Property == nil or Ora.World.Appart.CURRENT.Property.name == nil) then
    TriggerServerCallback("Ora::SE::Instance:LeaveAllInstance", 
        function(canLeave)
            Ora.World.Appart:TeleportOutside()
            KeySettings:Clear("keyboard", "E", "Appart_")
            KeySettings:Clear("controller", 46, "Appart_")
            Hint:RemoveAll()
        end
    )
  else
      TriggerServerCallback("Ora::SE::Instance:LeaveInstance", 
          function(canLeave)
              Ora.World.Appart:TeleportOutside()
              KeySettings:Clear("keyboard", "E", "Appart_")
              KeySettings:Clear("controller", 46, "Appart_")
              Hint:RemoveAll()
          end,
          Ora.World.Appart.CURRENT.Property.name
      )
  end
end

function Ora.World.Appart:TeleportOutside()
  outside = Ora.World.Appart.CURRENT.Outside
  local playerPed = LocalPlayer().Ped
  if Ora.World.Appart.CURRENT.Property ~= nil then
      local propertyData = Ora.Jobs.Immo:GetInteriorById(Ora.World.Appart.CURRENT.Property.indexx)
      if (propertyData ~= nil) then
          Zone:Remove(propertyData.coffre)
      end
  end
  Zone:RemoveFromName("coffre_appart")

  Citizen.CreateThread(
      function()
          DoScreenFadeOut(100)
          Ora.Player:FreezePlayer(LocalPlayer().Ped, true)
          Ora.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, true)

          if outside == nil or outside.x == nil or outside.y == nil or outside.z == nil then
              outside = {x = 254.29, y = -780.99, z = 30.57}
              ShowNotification("~b~Votre localisation de départ n'a pas été trouvé. Vous serez TP au PC")
          end
          
          Ora.Core:TeleportEntityTo(playerPed, vector3(outside.x, outside.y, outside.z), true)
          Wait(100)
          Ora.Player:FreezePlayer(LocalPlayer().Ped, false)
          Ora.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, false)
          DoScreenFadeIn(100)
      end
  )

  Ora.World.Appart.CURRENT.Property = nil
  Ora.World.Appart.CURRENT.Outside = nil
end

function Ora.World.Appart:ExitFromAppartRemoveHint()
  KeySettings:Clear("keyboard", "E", "Appart_")
  KeySettings:Clear("controller", 46, "Appart_")
  Hint:RemoveAll()
end


RegisterNetEvent("Ora::CE::World:Appart:SyncWithID")
AddEventHandler(
	"Ora::CE::World:Appart:SyncWithID",
	function(id, new)
		local property = Ora.World.Appart:GetList()[id]
		local owner = false
		
		if (property ~= nil) then
      if (property.owner and property.owner == Ora.Identity:GetMyUuid()) then
				owner = true
			end

			if (not owner and property.coowner ~= nil) then
				for _, uuid in pairs(property.coowner) do
					if (Ora.Identity:GetMyUuid() == uuid) then
						owner = true
						break
					end
				end
			end

			if (owner == true and new.garagePos ~= property.garagePos) then
				Marker:Remove(property.garagePos)

				Ora.World.Appart:GetList()[id] = new
				property = Ora.World.Appart:GetById(id)
  
				if (property.garagePos ~= nil) then
					if (type(property.garagePos) == "string") then
						property.garagePos = json.decode(property.garagePos)
					end

					local _x, _y, _z = table.unpack(property.garagePos)
					property.garagePos = {x = _x, y = _y, z = _z}
  
					Garage.New(
						property.name,
						property.garagePos,
						{
							type = 3,
							spawnpos = property.garagePos,
							Limit = property.garageMax
						},
						{
							Pos = property.garagePos,
							Blipcolor = 2,
							Blipname = "Garage " .. property.name,
							size = 0.6
						}
					):Setup()

					property.garagePos.z = property.garagePos.z + 1.0
					Marker:Add(
						property.garagePos,
						{
							type = 25,
							scale = {x = 1.5, y = 1.5, z = 0.2},
							color = {r = 125, g = 0, b = 0, a = 120},
							Up = false,
							Cam = false,
							Rotate = false,
							visible = true
						}
					)

					local blip = AddBlipForCoord(property.pos.x, property.pos.y, property.pos.z)
					SetBlipSprite(blip, 411)
					SetBlipDisplay(blip, 4)
					SetBlipScale(blip, 0.6)
					SetBlipColour(blip, 2)
					SetBlipAsShortRange(blip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(property.name)
					EndTextCommandSetBlipName(blip)
				end
			else
				Ora.World.Appart:GetList()[id] = new
			end
    else
      Ora.World.Appart:GetById(id)
    end
	end
)
