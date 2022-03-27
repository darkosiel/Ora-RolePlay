Ora.Jobs.Immo.TimeLaunchedRaid = {}


function Ora.Jobs.Immo:Create(propertyDetails)
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


RegisterServerEvent("Ora::SE::Job::Immo:Create")
AddEventHandler(
    "Ora::SE::Job::Immo:Create",
    function(houseDetails)
        local _source = source
        Ora.Jobs.Immo:Debug(string.format("Ora::SE::Job::Immo:Create from ^5%s^3", _source))
        local propertyDetails = json.decode(houseDetails)
        Ora.Jobs.Immo:Create(propertyDetails)
        TriggerClientEvent("Ora::CE::Core:ShowNotification", _source, string.format("La propriété ~h~~g~%s~s~~h~ a bien été créée.", propertyDetails.HOUSE_NUMBER))
    end
)

RegisterServerEvent("Ora::SE::Job::Immo:Update")
AddEventHandler(
    "Ora::SE::Job::Immo:Update",
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
        Ora.Jobs.Immo:Debug(string.format("Ora::SE::Job::Immo:Update from ^5%s^3 Query: ^5%s^3", _source, query))
        MySQL.Async.execute(query, parameters)
    end
)

RegisterServerEvent("Ora::SE::Job::Immo:RemoveRaid")
AddEventHandler(
    "Ora::SE::Job::Immo:RemoveRaid",
    function(id)
        if (Ora.Jobs.Immo.Raids[id]) then
            TriggerEvent(
                "Ora:sendToDiscordFromServer",
                source,
                37,
                string.format("a supprimé une perquisition dans la propriété `%s`", Ora.Jobs.Immo.Raids[id].PropertyName),
                "info"
            )

            table.remove(Ora.Jobs.Immo.Raids, id)

            TriggerClientEvent("Ora::CE::Job::Immo:GetRaids", -1, Ora.Jobs.Immo.Raids)
        end
    end
)

RegisterServerEvent("Ora::SE::Job::Immo:LaunchRaid")
AddEventHandler(
    "Ora::SE::Job::Immo:LaunchRaid",
    function(property)
        local src = source
        local author = Ora.Identity:GetFullname(src)

        if (Ora.Jobs.Immo.TimeLaunchedRaid[src] == nil) then
            Ora.Jobs.Immo.TimeLaunchedRaid[src] = 0
        end

        if (Ora.Jobs.Immo.TimeLaunchedRaid[src] - GetGameTimer() <= 0) then
            table.insert(Ora.Jobs.Immo.Raids, {AuthorID = src, AuthorName = author, PropertyName = property.name, PropertyPos = property.pos})

            TriggerEvent(
                "Ora:sendToDiscordFromServer",
                src,
                37,
                string.format("a lancé une perquisition dans la propriété `%s`, position `/tp %s %s %s`", property.name, property.pos.x, property.pos.y, property.pos.z),
                "warning"
            )

            TriggerClientEvent("Ora::CE::Job::Immo:GetRaids", -1, Ora.Jobs.Immo.Raids)

            TriggerClientEvent("RageUI:Popup", src, {message = "~g~La perquisition est lancée"})

            Citizen.CreateThread(
                function()
                    local key = Ora.Utils:IndexOf(Ora.Jobs.Immo.Raids, {AuthorID = src, AuthorName = author, PropertyName = property.name, PropertyPos = property.pos})

                    Wait(Ora.Jobs.Immo.RaidFinishTime)

                    if (Ora.Jobs.Immo.Raids[key]) then
                        table.remove(Ora.Jobs.Immo.Raids, key)
                        TriggerClientEvent("Ora::CE::Job::Immo:GetRaids", -1, Ora.Jobs.Immo.Raids)
                    end
                end
            )

            Ora.Jobs.Immo.TimeLaunchedRaid[src] = GetGameTimer() + Ora.Jobs.Immo.TimeToRelaunchRaid
        else
            TriggerEvent(
                "Ora:sendToDiscordFromServer",
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
                        (Ora.Jobs.Immo.TimeToRelaunchRaid / 1000) / 60
                    )
                }
            )
        end
    end
)


RegisterServerCallback(
    "Ora::SVCB::Job::Immo:GetRaids",
    function(_, cb)
        cb(Ora.Jobs.Immo.Raids)
    end
)
