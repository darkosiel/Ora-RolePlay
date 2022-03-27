RegisterServerEvent("core:NewLabo")
AddEventHandler("core:NewLabo",function(bool)
    MySQL.Async.execute(
        "INSERT INTO players_labo (capacity,name,entry,price,indexx) VALUES(@capacity,@name,@pos,@price,@index)",
           {

                ['@capacity']   = bool.max,
                ['@name']   = bool.name,
                ['@pos']   = bool.entry,
                ['@price']   = bool.price, 
                ['@index'] = bool.index,
                
            }
    )
end)

--[[
    
CREATE TABLE `organisation_property` ( `id` INT NOT NULL AUTO_INCREMENT , `organisation_id` INT NULL , `type` VARCHAR(255) NOT NULL , `outside_door` VARCHAR(255) NOT NULL , `inside_door` VARCHAR(255) NOT NULL , `production_level` INT NOT NULL DEFAULT '1' , `security_level` INT NOT NULL DEFAULT '1' , PRIMARY KEY (`id`)) ENGINE = InnoDB CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE `organisation_property` ADD CONSTRAINT `fk_property_orga` FOREIGN KEY (`organisation_id`) REFERENCES `organisation`(`id`) ON DELETE SET NULL ON UPDATE SET NULL;
ALTER TABLE `organisation_property` ADD `capacity` INT NOT NULL DEFAULT '1000' AFTER `security_level`;
ALTER TABLE `organisation_property` ADD `name` VARCHAR(255) NOT NULL AFTER `organisation_id`;
ALTER TABLE `organisation_property` ADD `business_id` VARCHAR(255) NOT NULL AFTER `type`;
ALTER TABLE `organisation_property` ADD `limitation` LONGTEXT NOT NULL AFTER `capacity`;
ALTER TABLE `organisation_property` ADD INDEX(`organisation_id`);
ALTER TABLE `organisation_property` DROP `inside_door`;
ALTER TABLE `organisation_property` ADD `last_attacked_at` VARCHAR(255) NULL AFTER `limitation`;
]]
local randomDictionnary = {"Furet","Hibou","Lion","Dauphin","Chat","Chien","Ligre","Ouistiti","Gorille","Abyssin","Addax","Aigle","Alpaga","Chameau","Dromadaire","Ane","Appaloosa","Gavial","Fennec","Malamute","Mara","Mandrill","Morse","Mouflon","Narval","Ocelot","Puma","Guepard","Orque","Taureau","Caracal","Jaguar","Loup","Renard","Vison","Wapiti","Kiwi","Yack","Lama","Lapin","Lézard","Cobra","Coyote","Ragondin","Renne","Chinchilla","Cygne","Vautour","Daim","Cerf","Bison","Dingo","Élan","Écureuil","Zèbre","Quokka","Langur","Koala","Lièvre","Kangourou","Pangolin","Pingouin","Ours","Grizzli","Anhinga","Geai","Paresseux","Gnou","Canari","Perroquet","Goujon","Agneau","Albatros","Alligator","Crocodile","Caïman","Boa","Anaconda","Python","Scorpion","Bongare","Boomslang","Crotale","Échide","Grage","Habu","Jararaca","Katuali","Mamba","Mapanare","Araneus","Gecko","Triton","Charançon","Hanneton","Scarabée","Crabe","Chimpanzée","Béluga","Lamantin","Marsouin","Phoque","Opossum","Wallaby","Caribou","Okapi","Pomme","Orange","Banane","Jesus","Carotte","Patate","Kiwi","Melon","Mangue","Peche","Prune","Salade","Fraise","Framboise","Alpha","Beta","Gamma","Delta","Epsilon","Zeta","Eta","Theta","Iota","Kappa","Lambda","Mu","Nu","Xi","Omicron","Pi","Rho","Sigma","Tau","Upsilon","Phi","Chi","Psi","Omega","Abricot","Acajou","Cheval","Argent","Or","Bleu","Vert","Jaune","Avocat","Blond","Brun","Roux","Gris","Noir","Blanc","Vert","Rouge"}

RegisterServerEvent("Ora:Illegal:createProperty")
AddEventHandler("Ora:Illegal:createProperty",function(type, illegalProperty)
    local _source = source
    local newId = MySQL.Sync.insert(
        "INSERT INTO organisation_property (name, type, business_id, outside_door, production_level, security_level, capacity, limitation) VALUES (@name, @type, @business_id, @outside_door, @production_level, @security_level, @capacity, @limitation)",
           {
                ['@name']             = illegalProperty.NAME .. "-" .. GetGameTimer(),
                ['@type']             = type,
                ['@business_id']      = illegalProperty.BUSINESS_ID,
                ['@outside_door']     = json.encode(illegalProperty.OUTSIDE_DOOR),
                ['@production_level'] = 0,
                ['@security_level']   = 0, 
                ['@capacity']         = 1000,
                ['@limitation']       = json.encode(illegalProperty.LIMITATION),
                
            }
    )

    local results = MySQL.Sync.fetchAll("SELECT op.*, o.name AS business_name, o.label AS business_label FROM organisation_property AS op LEFT JOIN organisation AS o ON o.id = op.organisation_id  ORDER BY op.id ASC", {})
    TriggerClientEvent("Ora::Illegal:populateIllegalPropertyList", _source, json.encode(results))
    TriggerEvent("Ora:sendToDiscordFromServer", _source, 23, Ora.Identity:GetFullname(_source) .. " a créé la propriété " .. illegalProperty.NAME .. " (type = " .. type .. ", business_id = " .. illegalProperty.BUSINESS_ID .. ")", "info")
end)

RegisterServerEvent("Ora:Illegal:DeleteProperty")
AddEventHandler("Ora:Illegal:DeleteProperty",function(illegalProperty)
    local _source = source
    local newId = MySQL.Sync.execute(
        "DELETE FROM organisation_property WHERE id = @businessPropertyId",
        {
            ['@businessPropertyId'] = illegalProperty.id
        }
    )

    if (illegalProperty.organisation_id ~= nil) then
        TriggerEvent("Ora::Illegal:sendMessageToOrga", illegalProperty.organisation_id, "Vous n'êtes plus propriétaire de votre propriété ~h~" .. illegalProperty.name .. "~h~")
        TriggerEvent("Ora::Illegal:updateOrgaForAllClient", illegalProperty.organisation_id)
        TriggerClientEvent("RageUI:Popup", _source, {message = "~g~La faction a été expulsée et la propriété a été supprimée avec succès.~s~"})
        TriggerEvent("Ora:sendToDiscordFromServer", _source, 23, Ora.Identity:GetFullname(_source) .. " a expulsé la faction " .. illegalProperty.organisation_id .. " de la propriété " .. illegalProperty.name, "info")
    end
    TriggerClientEvent("RageUI:Popup", _source, {message = "~g~La propriété a été supprimée avec succès.~s~"})
    TriggerEvent("Ora:sendToDiscordFromServer", _source, 23, Ora.Identity:GetFullname(_source) .. " a supprimé la propriété " .. illegalProperty.name, "info")
    TriggerEvent("Ora::ServerSidePlayerLoaded", _source)
end)


RegisterServerEvent("Ora:Illegal:AssignProperty")
AddEventHandler("Ora:Illegal:AssignProperty",function(illegalProperty, organisation)
    local _source = source
    local newId = MySQL.Sync.execute(
        "UPDATE organisation_property set organisation_id = @organisationId WHERE id = @businessPropertyId",
        {
            ["@businessPropertyId"] = illegalProperty.id,
            ["@organisationId"] = organisation.id
        }
    )

    TriggerEvent("Ora::Illegal:updateOrgaForAllClient", organisation.id)
    TriggerEvent("Ora::Illegal:sendMessageToOrga", organisation.id, "Votre faction est désormais propriétaire de ~h~" .. illegalProperty.name .. "~h~")
    TriggerClientEvent("RageUI:Popup", _source, {message = "~g~La faction ~h~".. organisation.name .."~h~ est désormais lié a cette propriété.~s~"})
    TriggerEvent("Ora::ServerSidePlayerLoaded", _source)
    TriggerEvent("Ora:sendToDiscordFromServer", _source, 23, Ora.Identity:GetFullname(_source) .. " a associé la faction " .. organisation.name .. " à la propriété " .. illegalProperty.name, "info")
end)

RegisterServerEvent("Ora:Illegal:DeleteFactionFromProperty")
AddEventHandler("Ora:Illegal:DeleteFactionFromProperty",function(illegalProperty)
    local _source = source
    local newId = MySQL.Sync.execute(
        "UPDATE organisation_property set organisation_id = null WHERE id = @businessPropertyId",
        {
            ['@businessPropertyId'] = illegalProperty.id
        }
    )

    if (illegalProperty.organisation_id ~= nil) then
        TriggerEvent("Ora::Illegal:sendMessageToOrga", illegalProperty.organisation_id, "Vous n'êtes plus propriétaire de votre propriété ~h~" .. illegalProperty.name .. "~h~")
        TriggerEvent("Ora::Illegal:updateOrgaForAllClient", illegalProperty.organisation_id)
        TriggerClientEvent("RageUI:Popup", _source, {message = "~g~La faction a été expulsée.~s~"})
        TriggerEvent("Ora:sendToDiscordFromServer", _source, 23, Ora.Identity:GetFullname(_source) .. " a expulsé la faction " .. illegalProperty.organisation_id .. " de la propriété " .. illegalProperty.name, "info")
    else
        TriggerClientEvent("RageUI:Popup", _source, {message = "~r~Aucune faction n'est liée.~s~"})
    end

    TriggerEvent("Ora::ServerSidePlayerLoaded", _source)
end)

RegisterServerCallback("Ora:Illegal:getPropertyByName", 
  function(source, cb, propertyName)
    local results = MySQL.Sync.fetchAll(
        "SELECT op.*, o.name AS business_name, o.label AS business_label FROM organisation_property AS op LEFT JOIN organisation AS o ON o.id = op.organisation_id  WHERE op.name = @name", 
        {
            ['@name'] = propertyName,
        }
    )

    if (#results > 0) then
        cb(results[1])
    else
        cb(nil)
    end

  end
)

RegisterServerEvent("Ora::ServerSidePlayerLoaded")
AddEventHandler(
    "Ora::ServerSidePlayerLoaded",
    function(source)
        local _source = source
        local results = MySQL.Sync.fetchAll("SELECT op.*, o.name AS business_name, o.label AS business_label FROM organisation_property AS op LEFT JOIN organisation AS o ON o.id = op.organisation_id ORDER BY op.id ASC", {})
        TriggerClientEvent("Ora::Illegal:populateIllegalPropertyList", _source, json.encode(results))
    end
)

RegisterServerEvent("Ora:Illegal:SyncProperties")
AddEventHandler(
    "Ora:Illegal:SyncProperties",
    function()
        local _source = source
        local results = MySQL.Sync.fetchAll("SELECT op.*, o.name AS business_name, o.label AS business_label FROM organisation_property AS op LEFT JOIN organisation AS o ON o.id = op.organisation_id ORDER BY op.id ASC", {})
        TriggerClientEvent("Ora::Illegal:populateIllegalPropertyList", _source, json.encode(results))
    end
)
