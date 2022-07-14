-- Framework functions
FOB = false -- Do not rename this variable! And if your framework doesn't have shared objects, keep and set this variable to true!
TriggerEvent(Config.SharedObject, function(obj) FOB = obj end)

if(not IsDuplicityVersion()) then
    RegisterNetEvent('Ora::CE::PlayerLoaded', function()
        TriggerServerEvent("high_phone:playerLoaded", GetPlayerServerId(PlayerId()))
    end)
end

if(IsDuplicityVersion()) then
    AddEventHandler("playerDropped", function()
        local src = source
        TriggerEvent("high_phone:playerDropped", src)
    end)
end


Config.Events = {
    playerLoaded = "high_phone:playerLoaded", -- player loaded server-side event, requires a player source as the 1st argument.
    playerDropped = "high_phone:playerDropped", -- player disconnected server-side event, requires a player source as the 1st argument.
    updateJob = "Ora::high_phone:onSetJob" -- player job updated server-side event, requires a player source as the 1st argument.
}

Config.PlayersTable = "users" -- Database players table.
Config.IdentifierColumn = "uuid" -- In players table, the main player identifier column.
Config.Invoices = {
    enabled = false,
    table = "phone_invoices", -- Table's name that contains all the bills [invoices]
    columns = {
        id = "id", -- ID column
        owner = "dest", -- Player's identifier that received the invoice column
        label = "sender", -- Invoice label [title or reason] column
        amount = "amount" -- Price/amount of the invoice column
    }
}

Config.FrameworkFunctions = {
    -- Client-side trigger callback
    triggerCallback = function(name, cb, ...)
        FOB.TriggerServerCallback(name, cb, ...)
    end,
    
    -- Server-side register callback
    registerCallback = function(name, cb)
        FOB.RegisterServerCallback(name, cb)
    end,

    -- Server-side get players function
    getPlayers = function()
        return FOB["high_phone:getPlayers"]()
    end,

    -- Client-side get closest player
    getClosestPlayer = function()
        local players = GetPlayers()
        local closestDistance = -1
        local closestPlayer = -1
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply, 0)
    
        for index, value in ipairs(players) do
            local target = GetPlayerPed(value)
            if (target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance =
                    GetDistanceBetweenCoords(
                    targetCoords["x"],
                    targetCoords["y"],
                    targetCoords["z"],
                    plyCoords["x"],
                    plyCoords["y"],
                    plyCoords["z"],
                    true
                )
                if (closestDistance == -1 or closestDistance > distance) then
                    closestPlayer = value
                    closestDistance = distance
                end
            end
        end
        return closestPlayer
    end,

    -- Server-side get player data
    getPlayer = function(source) 
        local self = {}
        --get player uuid, group, money, bankMoney from the source object
        local player = MySQL.Sync.fetchAll("SELECT u.identifier as identifier, u.uuid as uuid, u.phone_number as phone_number, u.group as `group`, u.money as money, sum(b.amount) as bankMoney from users u left join banking_account b on b.uuid = u.uuid where identifier = @id GROUP BY u.uuid",{["@id"]=GetPlayerIdentifier(source)})[1]

        if(player ~= nil) then
            self.source = source
            self.identifier = player.identifier
            self.group = player.group

            self.job = nil
            self.job = MySQL.Sync.fetchAll("SELECT name, rank as grade FROM players_jobs WHERE uuid = @id", {["@id"] = player.uuid})[1]
            self.jobName = self.job.name
            self.jobGrade = self.job.grade
            -- REMOVE THE -- IN FRONT OF self.onDuty IF YOU WANT TO CHECK IF THE PLAYER IS ON DUTY/IN SERVICE BEFORE SENDING HIM JOB MESSAGES/CALLS.
            --self.onDuty = player.job.service == 1 or false
            self.money = {cash = player.money, bank = player.bankMoney}
            self.number = player.phone_number

            self.getIdentity = function()                
                local data = MySQL.Sync.fetchAll("SELECT first_name, last_name FROM players_identity WHERE " .. Config.IdentifierColumn .. " = @identifier", {["@identifier"] = self.identifier})
                if(data[1] ~= nil) then
                    return {firstname = data[1].first_name ~= nil and data[1].first_name or "", lastname = data[1].last_name ~= nil and data[1].last_name or ""}
                end
                return {firstname = "", lastname = ""}
            end

            self.addBankMoney = function(amount) 
                MySQL.Sync.execute(
                    "UPDATE banking_account SET amount = amount + @amount WHERE uuid = @uuid",
                    {
                        ["@amount"] = amount,
                        ["@uuid"] = player.uuid
                    }
                )
                
            end
            self.addCash = function(amount) 
                MySQL.Sync.execute(
                    "UPDATE users SET money = money + @amount WHERE uuid = @uuid",
                    {
                        ["@amount"] = amount,
                        ["@uuid"] = player.uuid
                    }
                )
            end
            self.removeBankMoney = function(amount) 
                MySQL.Sync.execute(
                    "UPDATE banking_account SET amount = amount - @amount WHERE uuid = @uuid",
                    {
                        ["@amount"] = amount,
                        ["@uuid"] = player.uuid
                    }
                )
            end
            self.removeCash = function(amount) 
                MySQL.Sync.execute(
                    "UPDATE users SET money = money - @amount WHERE uuid = @uuid",
                    {
                        ["@amount"] = amount,
                        ["@uuid"] = player.uuid
                    }
                )
            end

            self.getItemCount = function(item)
                return FOB.getItemCount(item)
            end

            return self
        end

        return nil
    end,

    -- Server-side get player data by identifier
    getPlayerByIdentifier = function(identifier)
        local player = FOB.GetPlayerByIdentifier(identifier) -- Only replace this function
        if(player ~= nil) then
            return Config.FrameworkFunctions.getPlayer(player.PlayerData.source) -- And replace this player.source with player's source, function requires a player ID.
        end

        return nil
    end
}

Config.CustomCallbacks = {
    -- Advertisments app
    ["postAd"] = function(data)
        TriggerServerEvent("high_phone:postAd", data.title, data.content, data.image, data.data)
    end,
    ["deleteAd"] = function(data)
        TriggerServerEvent("high_phone:deleteAd", data.id)
    end,
    -- Twitter app
    ["postTweet"] = function(data)
        TriggerServerEvent("high_phone:postTweet", data.title, data.content, data.image)
    end,
    ["deleteTweet"] = function(data)
        TriggerServerEvent("high_phone:deleteTweet", data.id)
    end,
    ["postReply"] = function(data)
        TriggerServerEvent("high_phone:postReply", data.id, data.content)
    end,
    -- Messages app
    ["sendMessage"] = function(data)
        TriggerServerEvent("high_phone:sendMessage", data.number, data.content, data.attachments, data.time) -- data.time is for accurate saving of time of the messages.
    end,
    -- Mail app
    ["sendMail"] = function(data)
        if(not data.reply) then
            TriggerServerEvent("high_phone:sendMail", data.recipients, data.subject, data.content, data.attachments)
        else
            TriggerServerEvent("high_phone:sendMailReply", data.reply, data.recipients, data.subject, data.content, data.attachments)
        end
    end,
    -- Darkchat app
    ["sendDarkMessage"] = function(data)
        TriggerServerEvent("high_phone:sendDarkMessage", data.id, data.content, data.attachments, data.time) -- data.time is for accurate saving of time of the messages.
    end,
    -- Phone app
    ["callNumber"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback("high_phone:callNumber", function(response)
            cb(response) -- If response is "SUCCESS", the call screen will slide out. IMPORTANT TO CALLBACK SOMETHING!
            if(response == "SUCCESS") then
                DoPhoneAnimation('cellphone_text_to_call') -- Global function, play any animation from library cellphone@
                onCall = true -- Global variable, set it to true if in a call.
            end
        end, data.number, data.anonymous)
    end,
    -- Contacts app
    ["createContact"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback("high_phone:createContact", function(id)
            cb(id)
        end, data.number, data.name, data.photo, data.tag)
    end,
    -- Bank app
    ["transferMoney"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback("high_phone:transferMoney", function(response)
            cb(response) -- If response is "SUCCESS", a message saying that the transfer was successful will be shown. IMPORTANT TO CALLBACK SOMETHING!
        end, Config.TransferType == 1 and tonumber(data.id) or data.id, tonumber(data.amount), data.purpose)
    end,
    ["requestMoney"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback("high_phone:requestMoney", function(response)
            cb(response) -- If response is "SUCCESS", a message saying that the transfer was successful will be shown. IMPORTANT TO CALLBACK SOMETHING!
        end, tonumber(data.id), tonumber(data.amount), data.purpose)
    end,
    ["payBill"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback('esx_billing:payBill', function()
            cb() -- esx_billing is so lame..
        end, data.id)
    end,
    ["cancelBill"] = function(data, cb)
        Config.FrameworkFunctions.triggerCallback("high_phone:cancelBill", function(response)
            cb(response) -- If response is "SUCCESS", a message saying that the cancelation was successful will be shown. IMPORTANT TO CALLBACK SOMETHING!
        end, data.id)
    end,
}

Config.Commands = {
    -- Do not rename the index, only change the name field if you want to change the command name.
    ["twitter_rank"] = {
        enabled = true,
        name = "settwitterrank",
        suggestion_label = "Set rank for a twitter account",
        args = {{
            name = "Email address",
            help = "Twitter user email address"
        }, {
            name = "Rank",
            help = "Twitter rank name"
        }},
        notifications = {
            ["error_prefix"] = "^1SYSTEM",
            ["success_prefix"] = "^2SYSTEM",
            ["email_not_specified"] = "You have to specify a twitter email address!",
            ["group_not_specified"] = "You have to specify a twitter group!",
            ["no_permission"] = "No permission for this command!",
            ["account_doesnt_exist"] = "A twitter account with this email doesn't exist!",
            ["group_successfully_set"] = "You've set the group on {email} to {rank}",
            ["rank_non_existant"] = "Rank {rank} doesn't exist!"
        }
    }
}