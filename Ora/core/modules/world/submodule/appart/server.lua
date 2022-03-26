Atlantiss.World.Appart = {}

RegisterServerCallback(
    "Atlantiss::SE::World:Appart:GetAll",
    function(source, callback)
        local results = MySQL.Sync.fetchAll(
            "SELECT * FROM `players_appartement` ORDER BY id ASC",
            {}
        )

        if results[1] then
          local apparts = {}
          for key, value in pairs(results) do
            if (value.time ~= nil) then
              value.time = os.date("%d/%m/%Y %X", value.time)
              value.time = tostring(value.time)
            end
            value.pos = json.decode(value.pos)
            value.garagePos = json.decode(value.garagePos)

            if (value.coowner == nil) then
              value.coowner = {}
            else
              value.coowner = json.decode(value.coowner)
            end

            value.zoneId = Atlantiss.Core:GetGridZoneId(value.pos.x, value.pos.y)
            
            if (value.capacity == nil) then
              value.capacity = "200KG"
            end

            value.capacity = string.gsub(value.capacity, "KG", "")
            value.capacity = tonumber(value.capacity)
            apparts[value.id] = value
          end

          callback(json.encode(apparts))
        else
          callback(json.encode({}))
        end
    end
)

RegisterServerCallback(
    "Atlantiss::SE::World:Appart:GetById",
    function(source, callback, id)
      local results = MySQL.Sync.fetchAll(
        "SELECT * FROM `players_appartement` WHERE id = @id",
        {
          ["@id"] = id
        }
      )

      if results[1] then
        local value = results[1]

        value.time = os.date("%d/%m/%Y %X", value.time)
        value.time = tostring(value.time)
        value.pos = json.decode(value.pos)
        value.garagePos = json.decode(value.garagePos)

        if (value.coowner == nil) then
          value.coowner = {}
        else
          value.coowner = json.decode(value.coowner)
        end

        value.zoneId = Atlantiss.Core:GetGridZoneId(value.pos.x, value.pos.y)
        
        if (value.capacity == nil) then
          value.capacity = "200KG"
        end

        value.capacity = string.gsub(value.capacity, "KG", "")
        value.capacity = tonumber(value.capacity)
        callback(json.encode(value))
      else
        callback(json.encode({}))
      end
    end
)


RegisterServerEvent("Atlantiss::SE::World:Appart:LogUpdates")
AddEventHandler(
  "Atlantiss::SE::World:Appart:LogUpdates",
  function(OldConfig, UpdatedProperty)
    local src = source
    local Args = {string.format("Changements immobiliers sur la propriété `%s`\n", UpdatedProperty["name"])}
    local Translate = {
      ["indexx"] = "Intérieur",
      ["capacity"] = "Capacité",
      ["garagePos"] = "Position garage",
      ["garageMax"] = "Places garage",
      ["price"] = "Prix",
    }

    for key, value in pairs(OldConfig) do
      if (key ~= "coowner" and UpdatedProperty[key] and UpdatedProperty[key] ~= value) then
        if (type(value) == "table") then value = vector3(value.x, value.y, value.z) end
        if (type(UpdatedProperty[key]) == "table") then UpdatedProperty[key] = vector3(UpdatedProperty[key].x, UpdatedProperty[key].y, UpdatedProperty[key].z) end

        table.insert(
          Args,
          string.format(
            "- %s **%s** en **%s**",
            Translate[key] or key,
            key == "indexx" and Atlantiss.Jobs.Immo:GetInteriorById(value).label or value,
            key == "indexx" and Atlantiss.Jobs.Immo:GetInteriorById(UpdatedProperty[key]).label or UpdatedProperty[key]
          )
        )
      end
    end
    
    TriggerEvent("atlantiss:sendToDiscordFromServer", src, 38, table.concat(Args, "\n"), "info")
  end
)

