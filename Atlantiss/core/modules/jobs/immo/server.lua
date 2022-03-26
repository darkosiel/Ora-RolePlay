Atlantiss.Jobs.Immo.TimeLaunchedRaid = {}


function Atlantiss.Jobs.Immo:Create(propertyDetails)
  local newId = MySQL.Sync.insert(
        "INSERT INTO players_appartement (capacity,name,pos,price,indexx,garagePos,garageMax) VALUES(@capacity,@name,@pos,@price,@index,@garagePos,@maxGrg)",
        {
            ["@capacity"] = propertyDetails.SAFE_CAPACITY,
            ["@name"] = propertyDetails.HOUSE_NUMBER,
            ["@pos"] = json.encode(propertyDetails.ENTRY_POS),
            ["@price"] = propertyDetails.PRICE,
            ["@index"] = propertyDetails.INTERIOR_INDEX,
            ["@garagePos"] = json.encode(propertyDetails.GARAGE_POS),
            ["@maxGrg"] = propertyDetails.PARKING_PLACE_COUNT
        }
    )

    local result = MySQL.Sync.fetchAll("SELECT * FROM players_appartement WHERE id = @id", {["@id"] = newId})

    for i = 1, #result, 1 do
        result[i].time = os.date("%d/%m/%Y %X", result[i].time)
        TriggerClientEvent("add:Appart", -1, result[i])
    end

    return true
end


RegisterServerEvent("Atlantiss::SE::Job::Immo:Create")
AddEventHandler(
    "Atlantiss::SE::Job::Immo:Create",
    function(houseDetails)
        local _source = source
        Atlantiss.Jobs.Immo:Debug(string.format("Atlantiss::SE::Job::Immo:Create from ^5%s^3", _source))
        local propertyDetails = json.decode(houseDetails)
        Atlantiss.Jobs.Immo:Create(propertyDetails)
        TriggerClientEvent("Atlantiss::CE::Core:ShowNotification", _source, string.format("La propriété ~h~~g~%s~s~~h~ a bien été créée.", propertyDetails.HOUSE_NUMBER))
    end
)

RegisterServerEvent("Atlantiss::SE::Job::Immo:Update")
AddEventHandler(
    "Atlantiss::SE::Job::Immo:Update",
    function(Property, ChangedProperties)
        local _source = source
        local query = {}
        local parameters = {["@name"] = Property.name}
        
        for key, value in pairs(ChangedProperties) do
            table.insert(query, string.format("%s = @%s", key, key))
            if (type(Property[key]) == "table") then
                parameters["@"..key] = json.encode(Property[key])
            else
                parameters["@"..key] = Property[key]
            end
        end

        query = "UPDATE players_appartement SET " .. table.concat(query, ", ") .. " WHERE name = @name"
        Atlantiss.Jobs.Immo:Debug(string.format("Atlantiss::SE::Job::Immo:Update from ^5%s^3 Query: ^5%s^3", _source, query))
        MySQL.Async.execute(query, parameters)
    end
)

RegisterServerEvent("Atlantiss::SE::Job::Immo:RemoveRaid")
AddEventHandler(
    "Atlantiss::SE::Job::Immo:RemoveRaid",
    function(id)
        if (Atlantiss.Jobs.Immo.Raids[id]) then
            TriggerEvent(
                "atlantiss:sendToDiscordFromServer",
                source,
                37,
                string.format("a supprimé une perquisition dans la propriété `%s`", Atlantiss.Jobs.Immo.Raids[id].PropertyName),
                "info"
            )

            table.remove(Atlantiss.Jobs.Immo.Raids, id)

            TriggerClientEvent("Atlantiss::CE::Job::Immo:GetRaids", -1, Atlantiss.Jobs.Immo.Raids)
        end
    end
)

RegisterServerEvent("Atlantiss::SE::Job::Immo:LaunchRaid")
AddEventHandler(
    "Atlantiss::SE::Job::Immo:LaunchRaid",
    function(property)
        local src = source
        local author = Atlantiss.Identity:GetFullname(src)

        if (Atlantiss.Jobs.Immo.TimeLaunchedRaid[src] == nil) then
            Atlantiss.Jobs.Immo.TimeLaunchedRaid[src] = 0
        end

        if (Atlantiss.Jobs.Immo.TimeLaunchedRaid[src] - GetGameTimer() <= 0) then
            table.insert(Atlantiss.Jobs.Immo.Raids, {AuthorID = src, AuthorName = author, PropertyName = property.name, PropertyPos = property.pos})

            TriggerEvent(
                "atlantiss:sendToDiscordFromServer",
                src,
                37,
                string.format("a lancé une perquisition dans la propriété `%s`, position `/tp %s %s %s`", property.name, property.pos.x, property.pos.y, property.pos.z),
                "warning"
            )

            TriggerClientEvent("Atlantiss::CE::Job::Immo:GetRaids", -1, Atlantiss.Jobs.Immo.Raids)

            TriggerClientEvent("RageUI:Popup", src, {message = "~g~La perquisition est lancée"})

            Citizen.CreateThread(
                function()
                    local key = Atlantiss.Utils:IndexOf(Atlantiss.Jobs.Immo.Raids, {AuthorID = src, AuthorName = author, PropertyName = property.name, PropertyPos = property.pos})

                    Wait(Atlantiss.Jobs.Immo.RaidFinishTime)

                    if (Atlantiss.Jobs.Immo.Raids[key]) then
                        table.remove(Atlantiss.Jobs.Immo.Raids, key)
                        TriggerClientEvent("Atlantiss::CE::Job::Immo:GetRaids", -1, Atlantiss.Jobs.Immo.Raids)
                    end
                end
            )

            Atlantiss.Jobs.Immo.TimeLaunchedRaid[src] = GetGameTimer() + Atlantiss.Jobs.Immo.TimeToRelaunchRaid
        else
            TriggerEvent(
                "atlantiss:sendToDiscordFromServer",
                src,
                37,
                string.format("a essayé de forcer pour lancer une perquisition dans la propriété `%s`", property.name),
                "error"
            )

            TriggerClientEvent(
                "RageUI:Popup",
                src,
                {
                    message = string.format(
                        "~r~Vous ne pouvez plus lancer de perquisition ici pendant %s minutes depuis le premier essai.",
                        (Atlantiss.Jobs.Immo.TimeToRelaunchRaid / 1000) / 60
                    )
                }
            )
        end
    end
)


RegisterServerCallback(
    "Atlantiss::SVCB::Job::Immo:GetRaids",
    function(_, cb)
        cb(Atlantiss.Jobs.Immo.Raids)
    end
)
