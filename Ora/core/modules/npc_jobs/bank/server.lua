--[[
  CREATE TABLE `banking_account_company_access` ( `id` INT NOT NULL AUTO_INCREMENT , `banking_account_id` INT NOT NULL , `uuid` VARCHAR(255) NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB CHARSET=utf8mb4 COLLATE utf8mb4_general_ci;
  ALTER TABLE `banking_account_company_access` ADD FOREIGN KEY (`banking_account_id`) REFERENCES `banking_account`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
  ALTER TABLE `banking_account` DROP INDEX `uuid_5`;
  ALTER TABLE `banking_account` DROP INDEX `uuid_4`;
  ALTER TABLE `banking_account` DROP INDEX `uuid_3`;
  ALTER TABLE `banking_account` DROP INDEX `uuid_2`;
  ALTER TABLE `banking_account` ADD `is_pro` INT NOT NULL DEFAULT '0' AFTER `bloqued`, ADD `association_code` INT NULL AFTER `is_pro`;

  INSERT INTO banking_account (label, uuid, amount, iban, is_pro) VALUE ("Réserve légale", '0', 0, "centralbank", 0)
  INSERT INTO banking_account (label, uuid, amount, iban, is_pro) VALUE ("Réserve illégale", '0', 0, "illegalaccount", 0)
]]

Ora.NpcJobs.Bank.MainAccountsIBAN = {"centralbank", "illegalaccount", "casino"}
Ora.NpcJobs.Bank.MainAccountsAmounts = {}
Ora.NpcJobs.Bank.Thread = {
  WaitTime = 600000,
  HaveToUpdate = false
}


function Ora.NpcJobs.Bank:IsBankAccountCreatedForIban(iban)
  local results = MySQL.Sync.fetchAll(
      "SELECT ba.* FROM `banking_account` as ba WHERE ba.`iban` = @iban",
      {
          ["@iban"] = iban
      }
  )

  if (results ~= nil and results[1] ~= nil) then
    self:Debug(string.format("Iban ^5%s^3 already exists", iban))  
    return true
  end

  self:Debug(string.format("Iban ^5%s^3 does not exist", iban))  
  return false
end

function Ora.NpcJobs.Bank:IsPersonnalBankAccountCreatedForUuid(uuid)
  local results = MySQL.Sync.fetchAll(
      "SELECT ba.* FROM `banking_account` as ba WHERE ba.`uuid` = @uuid AND is_pro = @isNotPro",
      {
          ["@uuid"] = uuid,
          ["@isNotPro"] = 0
      }
  )

  if (results ~= nil and results[1] ~= nil) then
    self:Debug(string.format("Bank account for uuid ^5%s^3 already exists", uuid))  
    return true
  end

  self:Debug(string.format("Bank account for uuid ^5%s^3 does not exist", uuid))  
  return false
end

function Ora.NpcJobs.Bank:GetDefaultTodayRatio()
  return {remove = 0, deposit = 0, maxRemove = 5000, maxDeposit = 5000}
end

function Ora.NpcJobs.Bank:GenerateAssociationCodeForCompanyAccount()
  local associationCode = math.random(100000,999999)
  local isValid = false

  while (isValid == false) do
    Wait(10)
    local results = MySQL.Sync.fetchAll(
        "SELECT ba.* FROM `banking_account` as ba WHERE ba.`association_code` = @associationCode",
        {
            ["@associationCode"] = associationCode
        }
    )

    if (results ~= nil and results[1] ~= nil) then
      associationCode = math.random(100000,999999)
    else 
      isValid = true
    end
  end
  
  self:Debug(string.format("Returning association code ^5%s^3", associationCode))  
  return associationCode
end

function Ora.NpcJobs.Bank:GenerateNewCardNumber()
  local newCardNumber = math.random(1111,9999) .. math.random(1111,9999) .. math.random(1111,9999) .. math.random(1111,9999)
  local isValid = false

  while (isValid == false) do
    Wait(10)
    local results = MySQL.Sync.fetchAll(
        "SELECT bc.* FROM `banking_cards` as bc WHERE bc.`number` = @number",
        {
            ["@number"] = newCardNumber
        }
    )

    if (results ~= nil and results[1] ~= nil) then
      newCardNumber = math.random(1111,9999) .. math.random(1111,9999) .. math.random(1111,9999) .. math.random(1111,9999)
    else 
      isValid = true
    end
  end
  
  self:Debug(string.format("Returning card number ^5%s^3", newCardNumber))  
  return newCardNumber
end

function Ora.NpcJobs.Bank:GenerateNewIban()
  local newIban = "LS-" .. math.random(100000,999999)
  local isValid = false

  while (isValid == false) do
    Wait(10)
    local results = MySQL.Sync.fetchAll(
        "SELECT ba.* FROM `banking_account` as ba WHERE ba.`iban` = @iban",
        {
            ["@iban"] = newIban
        }
    )

    if (results ~= nil and results[1] ~= nil) then
      newIban = "LS-" .. math.random(100000,999999)
    else 
      isValid = true
    end
  end
  
  self:Debug(string.format("Returning iban ^5%s^3", newIban))  
  return newIban
end

  
function Ora.NpcJobs.Bank:IsSecurityCodeAvailable(securityCode)
  local results = MySQL.Sync.fetchAll(
      "SELECT ba.* FROM `banking_account` as ba WHERE ba.`association_code` = @association_code AND is_pro = @isPro",
      {
          ["@association_code"] = securityCode,
          ["@isPro"] = 1
      }
  )

  if (results ~= nil and results[1] ~= nil) then
    self:Debug(string.format("Bank account for security code ^5%s^3 is valid", securityCode))  
    return true
  end

  self:Debug(string.format("Bank account for security code ^5%s^3 does not exist", securityCode))  
  return false
end

function Ora.NpcJobs.Bank:AssociatePlayerToCompanyBySecurityCode(playerUuid, securityCode)
  local results = MySQL.Sync.fetchAll(
      "SELECT ba.* FROM `banking_account` as ba WHERE ba.`association_code` = @association_code AND is_pro = @isPro",
      {
          ["@association_code"] = securityCode,
          ["@isPro"] = 1
      }
  )

  if (results ~= nil and results[1] ~= nil) then

    local verificationDuplicated = MySQL.Sync.fetchAll(
        "SELECT baca.* FROM `banking_account_company_access` as baca WHERE baca.`uuid` = @uuid AND banking_account_id = @banking_account_id",
        {
            ["@uuid"] = playerUuid,
            ["@banking_account_id"] = results[1].id
        }
    )

    if (verificationDuplicated ~= nil and verificationDuplicated[1] ~= nil) then
      return false
    else
      MySQL.Sync.insert(
          "INSERT INTO banking_account_company_access (banking_account_id, uuid) VALUES (@bankingAccountId, @uuid)",
          {
              ["@bankingAccountId"] = results[1].id,
              ["@uuid"] = playerUuid,
          }
      )
      MySQL.Sync.execute(
          "UPDATE banking_account SET association_code = @newAssociationCode WHERE id = @bankingAccountId",
          {
              ["@bankingAccountId"] = results[1].id,
              ["@newAssociationCode"] = Ora.NpcJobs.Bank:GenerateAssociationCodeForCompanyAccount(),
          }
      )
      return true
    end
  end

  return false
end

function Ora.NpcJobs.Bank:CreateBankAccount(iban, label, defaultAmount, isPro, ownerUuid, phone)
  local associationCode = nil

  if isPro == 1 then
    associationCode = self:GenerateAssociationCodeForCompanyAccount()
  end

  MySQL.Sync.insert(
      "INSERT INTO banking_account (label, uuid, amount, iban, todayratio, bloqued, is_pro, association_code, phone_number) VALUES (@label, @uuid, @amount, @iban, @todayratio, @bloqued, @isPro, @associationCode, @phone)",
      {
          ["@label"] = label,
          ["@uuid"] = ownerUuid,
          ["@amount"] = defaultAmount,
          ["@iban"] = iban,
          ["@todayratio"] = json.encode(self:GetDefaultTodayRatio()),
          ["@bloqued"] = "false",
          ["@isPro"] = isPro,
          ["@associationCode"] = associationCode,
          ["@phone"] = phone
      }
  )

  self:Debug(string.format("Created new banking account with label ^5%s^3, iban ^5%s^3 and default amount ^5%s^3$", label, iban, defaultAmount))  
end

function Ora.NpcJobs.Bank:Initialize()
  self:Debug(string.format("Initializing ^5%s^3", self:GetJobName()))    
  self:Debug(string.format("Verifying if company banking accounts are created ^5%s^3", self:GetJobName()))    
  
  for key, value in pairs(Jobs) do
    if (value.iban ~= nil) then
      self:Debug(string.format("Verifying if company ^5%s^3 / ^5%s^3 has a banking account for iban ^5%s^3 ", key, value.label2, value.iban))  
      if (self:IsBankAccountCreatedForIban(value.iban) == false) then
        self:CreateBankAccount(value.iban, "Société " .. value.label2, self:GetDefaultAmountForCompanyAccount(), 1, 0, nil)
      end
    end
  end
end

RegisterServerEvent("Ora::SE::NpcJobs::Bank:CreateAccount")
AddEventHandler(
    "Ora::SE::NpcJobs::Bank:CreateAccount",
    function(phoneNumber)
      local _source = source
      Ora.NpcJobs.Bank:Debug(string.format("Received event Ora::SE::NpcJobs::Bank:CreateAccount from ^5%s^3", _source))  
        local playerUuid = Ora.Identity:GetUuid(_source)
        local playerFullname = Ora.Identity:GetFullname(_source)

        if (Ora.NpcJobs.Bank:IsPersonnalBankAccountCreatedForUuid(playerUuid)) then
            TriggerClientEvent("Ora::CE::Core:ShowNotification", _source, "~r~Vous possédez déjà un compte en banque")
        else
          local iban = Ora.NpcJobs.Bank:GenerateNewIban()
          Ora.NpcJobs.Bank:CreateBankAccount(Ora.NpcJobs.Bank:GenerateNewIban(), "CCP. " .. playerFullname, 0, 0, playerUuid, phoneNumber)
          TriggerClientEvent("Ora::CE::Core:ShowNotification", _source, string.format("Le compte bancaire de ~g~~h~%s~h~~s~ a été créé", playerFullname))
        end
    end
)

RegisterServerEvent("Ora::SE::NpcJobs::Bank:CreateCard")
AddEventHandler(
    "Ora::SE::NpcJobs::Bank:CreateCard",
    function(bankAccountId)
      local _source = source
      Ora.NpcJobs.Bank:Debug(string.format("Received event Ora::SE::NpcJobs::Bank:CreateCard from ^5%s^3", _source))  
      local playerUuid = Ora.Identity:GetUuid(_source)
      local playerFullname = Ora.Identity:GetFullname(_source)
      local cardNumber = Ora.NpcJobs.Bank:GenerateNewCardNumber()
      local cardCode = math.random(1000, 9999)

      MySQL.Sync.execute(
          "INSERT INTO banking_cards (type,uuid,account,code,number,current_ratio) VALUES(@type,@uuid,@account,@code,@number,@current_ratio)",
          {
              ["@type"] = Ora.NpcJobs.Bank:GetCardCodeById(2),
              ["@uuid"] = playerUuid,
              ["@account"] = bankAccountId,
              ["@code"] = cardCode,
              ["@number"] = cardNumber,
              ["@current_ratio"] = json.encode(Ora.NpcJobs.Bank:GetCardRatioById(2))
          }
      )
      
      local items = {
          name = "bank_card",
          data = {
              name = playerFullname,
              type = Ora.NpcJobs.Bank:GetCardCodeById(2),
              uuid = playerUuid,
              account = bankAccountId,
              number = cardNumber,
              current_ratio = Ora.NpcJobs.Bank:GetCardRatioById(2),
              code = cardCode
          },
          label = bankAccountId
      }

      TriggerClientEvent("Ora::CE::Inventory:AddItems", _source, {items})
      TriggerClientEvent("Ora::CE::Core:ShowNotification", _source, string.format("Votre carte bancaire possède le code ~g~~h~%s~h~~s~", cardCode))
    end
)


RegisterServerEvent("Ora::SE::NpcJobs::Bank:AssociateProAccount")
AddEventHandler(
    "Ora::SE::NpcJobs::Bank:AssociateProAccount",
    function(securityNumber)
      local _source = source
      Ora.NpcJobs.Bank:Debug(string.format("Received event Ora::SE::NpcJobs::Bank:AssociateProAccount from ^5%s^3", _source))  
        local playerUuid = Ora.Identity:GetUuid(_source)
        local playerFullname = Ora.Identity:GetFullname(_source)

        if (not Ora.NpcJobs.Bank:IsSecurityCodeAvailable(securityNumber)) then
          TriggerClientEvent("Ora::CE::Core:ShowNotification", _source, string.format("Le code de sécurité ~g~~h~%s~h~~s~ n'existe pas. Essai loggé.", securityNumber))
        else 
          if (Ora.NpcJobs.Bank:AssociatePlayerToCompanyBySecurityCode(playerUuid, securityNumber)) then
            TriggerClientEvent("Ora::CE::Core:ShowNotification", _source, string.format("Le compte bancaire entreprise correspondant a ~g~~h~%s~h~~s~ a été associé", securityNumber))
          else
            TriggerClientEvent("Ora::CE::Core:ShowNotification", _source, string.format("Le compte bancaire entreprise correspondant a ~g~~h~%s~h~~s~ est déjà associé", securityNumber))
          end
        end
    end
)

RegisterServerCallback("Ora::SE::NpcJobs:Bank:RetrieveCards", 
  function(source, cb) 
      local _source = source
      local playerUuid = Ora.Identity:GetUuid(_source)

      local results = MySQL.Sync.fetchAll(
          "SELECT bc.*, ba.label AS bank_account_name FROM banking_cards AS bc LEFT JOIN banking_account AS ba ON ba.id = bc.account WHERE (bc.uuid = @uuid)",
          {
              ["@uuid"] = playerUuid
          }
      )

      if (results ~= nil and results[1] ~= nil) then
        cb(json.encode(results))
      end

      cb(json.encode({}))
  end
)

RegisterServerCallback("Ora::SE::NpcJobs:Bank:RetrieveBankAccounts", 
  function(source, cb) 
      local _source = source
      local playerUuid = Ora.Identity:GetUuid(_source)

      local results = MySQL.Sync.fetchAll(
          "SELECT ba.* FROM banking_account AS ba LEFT JOIN banking_account_company_access AS baca ON baca.banking_account_id = ba.id WHERE (ba.uuid = @uuid) OR (baca.uuid = @uuid)",
          {
              ["@uuid"] = playerUuid
          }
      )

      if (results ~= nil and results[1] ~= nil) then
        cb(json.encode(results))
      end

      cb(json.encode({}))
  end
)


RegisterServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount")
AddEventHandler(
  "Ora::SE::NpcJobs:Bank:UpdateMainAccount",
  function(id, amount, adding)
    if (Ora.NpcJobs.Bank.MainAccountsAmounts[id] == nil) then
      return error(string.format("Cannot update %s IBAN because it is not indexed in the table Ora.NpcJobs.Bank.MainAccountsAmounts. (Amount: %s)", id, amount))
    end

    if (adding == true) then
      Ora.NpcJobs.Bank.MainAccountsAmounts[id] = Ora.NpcJobs.Bank.MainAccountsAmounts[id] + amount
    else
      Ora.NpcJobs.Bank.MainAccountsAmounts[id] = Ora.NpcJobs.Bank.MainAccountsAmounts[id] - amount
    end

    Ora.NpcJobs.Bank.Thread.HaveToUpdate = true
  end
)

MySQL.ready(function()
  MySQL.Async.fetchAll(
    string.format('SELECT iban, amount FROM banking_account WHERE iban = "%s"', table.concat(Ora.NpcJobs.Bank.MainAccountsIBAN, '" OR iban = "')),
    {},
    function(results)
      for _, res in pairs(results) do
        Ora.NpcJobs.Bank.MainAccountsAmounts[res.iban] = res.amount
        Ora.NpcJobs.Bank:Debug(string.format("^6Retreived $%s for main account with IBAN %s^0", res.amount, res.iban))
      end
    end
  )
end)

Citizen.CreateThread(
  function()
    while true do
      if (Ora.NpcJobs.Bank.Thread.HaveToUpdate) then
        for iban, amount in pairs(Ora.NpcJobs.Bank.MainAccountsAmounts) do
          MySQL.Async.execute(
            "UPDATE banking_account SET amount = @amount WHERE iban = @iban",
            {
              ["@amount"] = amount,
              ["@iban"] = iban
            }
          )

          Ora.NpcJobs.Bank:Debug(string.format("^6Updated %s account value to %s^0", iban, amount))
        end

        Ora.NpcJobs.Bank.Thread.HaveToUpdate = false
      end

      if (os.date("*t").hour == 18 and os.date("*t").min >= 40) then
        Ora.NpcJobs.Bank.Thread.WaitTime = 60000
      end

      Wait(Ora.NpcJobs.Bank.Thread.WaitTime)
    end
  end
)
