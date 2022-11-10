--[[
██████   █████  ███    ██ ██   ██ 
██   ██ ██   ██ ████   ██ ██  ██  
██████  ███████ ██ ██  ██ █████   
██   ██ ██   ██ ██  ██ ██ ██  ██  
██████  ██   ██ ██   ████ ██   ██ 
]]

RMenu.Add("Ora_npcjobs_bank", "main", RageUI.CreateMenu("Banque", "Actions disponibles", 10, 50))
RMenu.Add("Ora_npcjobs_bank", "Ora_npcjobs_bank_createaccount", RageUI.CreateSubMenu(RMenu:Get("Ora_npcjobs_bank", "main"), "Créer un compte", "Listes"))
RMenu.Add("Ora_npcjobs_bank", "Ora_npcjobs_bank_manageaccount", RageUI.CreateSubMenu(RMenu:Get("Ora_npcjobs_bank", "main"), "Gérer mes compte", "Listes"))
RMenu.Add("Ora_npcjobs_bank", "Ora_npcjobs_bank_showaccount", RageUI.CreateSubMenu(RMenu:Get("Ora_npcjobs_bank", "main"), "Gérer le compte", "Listes"))
RMenu.Add("Ora_npcjobs_bank", "Ora_npcjobs_bank_createcard", RageUI.CreateSubMenu(RMenu:Get("Ora_npcjobs_bank", "main"), "Créer une carte", "Listes"))
RMenu.Add("Ora_npcjobs_bank", "Ora_npcjobs_bank_managecard", RageUI.CreateSubMenu(RMenu:Get("Ora_npcjobs_bank", "main"), "Gérer mes cartes", "Listes"))
RMenu.Add("Ora_npcjobs_bank", "Ora_npcjobs_bank_showcard", RageUI.CreateSubMenu(RMenu:Get("Ora_npcjobs_bank", "main"), "Gérer une carte", "Listes"))

Ora.NpcJobs.Bank.Menu = {
  INDEXES = {}
}
Ora.NpcJobs.Bank.Cards = {
  LOADED = false,
  LIST = {}
}
Ora.NpcJobs.Bank.Accounts = {
  LOADED = false,
  LIST = {}
}

--[[
   _____ _               
  / ____| |              
 | |    | | __ _ ___ ___ 
 | |    | |/ _` / __/ __|
 | |____| | (_| \__ \__ \
  \_____|_|\__,_|___/___/                                                   
]]

-- function Ora.NpcJobs.Bank:Initialize()
--     self:Debug(string.format("Intializing peds for job ^5%s^3", self:GetJobName()))    
--     for key, value in pairs(self:GetPedPositions()) do
--       Ped:Add(
--           value.name,
--           self:GetRandomPed(),
--           {x = value.pos.x, y = value.pos.y, z = value.pos.z, a = value.heading},
--           nil
--       )
--       self:Debug(string.format("Added ped ^5%s^3 at position ^5%s %s %s^3 for job ^5%s^3", value.name,  value.pos.x,  value.pos.y,  value.pos.z, self:GetJobName()))    
--     end

--     for key, value in pairs(self:GetZones()) do
--       Zone:Add(value.pos, Ora.NpcJobs.Bank.EnterZoneProxy, Ora.NpcJobs.Bank.ExitZoneProxy, value.name, 2.5)
--       self:Debug(string.format("Added zone ^5%s^3 at position ^5%s %s %s^3 for job ^5%s^3", value.name,  value.pos.x,  value.pos.y,  value.pos.z, self:GetJobName()))    
--     end
-- end

function Ora.NpcJobs.Bank:GetBankAccounts()
  if (self.Accounts.LOADED == false) then
    local canSend = false
    local bankAccounts = {}
    self:Debug(string.format("Fetching bank accounts for player ^5%s^3", GetPlayerServerId(PlayerId())))     
    TriggerServerCallback("Ora::SE::NpcJobs:Bank:RetrieveBankAccounts", function(bankAccountsResultsAsJson)
      bankAccounts = json.decode(bankAccountsResultsAsJson)
      canSend = true
    end)
    
    while (canSend == false) do
        self:Debug(string.format("Waiting pulling data from event ^5%s^3 for player ^5%s^3", "Ora::SE::NpcJobs:Bank:RetrieveBankAccounts", GetPlayerServerId(PlayerId())))     
        Wait(200)      
    end

    self:Debug(string.format("Bank account list loaded for player ^5%s^3", GetPlayerServerId(PlayerId())))     
    self.Accounts.LOADED = true
    self.Accounts.LIST = bankAccounts
  end
  
  return self.Accounts.LIST
end

function Ora.NpcJobs.Bank:GetCards()
  if (self.Cards.LOADED == false) then
    local canSend = false
    local cards = {}
    self:Debug(string.format("Fetching bank Cards for player ^5%s^3", GetPlayerServerId(PlayerId())))     
    TriggerServerCallback("Ora::SE::NpcJobs:Bank:RetrieveCards", function(cardsResultsAsJson)
      cards = json.decode(cardsResultsAsJson)
      canSend = true
    end)
    
    while (canSend == false) do
        self:Debug(string.format("Waiting pulling data from event ^5%s^3 for player ^5%s^3", "Ora::SE::NpcJobs:Bank:RetrieveCards", GetPlayerServerId(PlayerId())))     
        Wait(200)      
    end

    self:Debug(string.format("Cards list loaded for player ^5%s^3", GetPlayerServerId(PlayerId())))     
    self.Cards.LOADED = true
    self.Cards.LIST = cards
  end
  
  return self.Cards.LIST
end

function Ora.NpcJobs.Bank:GetBankAccountIdByName(label)
  bankAccounts = self:GetBankAccounts()
  for key, value in pairs(bankAccounts) do
      if (value.label == label) then
          return value.id
      end
  end

  return false
end

function Ora.NpcJobs.Bank:GetBankAccountLabels()
  bankAccounts = self:GetBankAccounts()
  local bankAccountLabels = {}
  for key, value in pairs(bankAccounts) do
      table.insert(bankAccountLabels, value.label)
  end

  return bankAccountLabels
end

function Ora.NpcJobs.Bank:HasPersonnalAccount()
    bankAccounts = self:GetBankAccounts()
    for key, value in pairs(bankAccounts) do
      if (value.is_pro == 0) then
          return true
      end
    end

    return false
end

function Ora.NpcJobs.Bank:HasProfessionalAccount()
  bankAccounts = self:GetBankAccounts()
  for key, value in pairs(bankAccounts) do
      if (value.is_pro == 1) then
          return true
      end
  end

  return false
end

function Ora.NpcJobs.Bank.EnterZoneProxy(zoneName)
  Ora.NpcJobs.Bank:EnterZone(zoneName)
end

function Ora.NpcJobs.Bank.ExitZoneProxy()
  Ora.NpcJobs.Bank:ExitZone()
end

function Ora.NpcJobs.Bank:EnterZone(zoneName)
  Ora.NpcJobs.Bank:Debug(string.format("Player ^5%s^3 entered in zone ^5%s^3 for job ^5%s^3", GetPlayerServerId(PlayerId()),  zoneName, Ora.NpcJobs.Bank:GetJobName()))    
  Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour parler au banquier")
  KeySettings:Add(
      "keyboard",
      "E",
      function()
          Ora.NpcJobs.Bank.Menu.INDEXES = {}
          Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
          Ora.NpcJobs.Bank.Accounts.LOADED = false
          Ora.NpcJobs.Bank.Cards.LOADED = false
          Ora.NpcJobs.Bank:GetBankAccounts()
          RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","main"), true)
      end,
      "Ora_npcjobs_bank_manage"
  )
  KeySettings:Add(
      "controller",
      46,
      function()
          Ora.NpcJobs.Bank.Menu.INDEXES = {}
          Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
          Ora.NpcJobs.Bank.Accounts.LOADED = false
          Ora.NpcJobs.Bank.Cards.LOADED = false
          Ora.NpcJobs.Bank:GetBankAccounts()
          RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","main"), true)
      end,
      "Ora_npcjobs_bank_manage"
  )
end

function Ora.NpcJobs.Bank:ExitZone()
  Ora.NpcJobs.Bank:Debug(string.format("Player ^5%s^3 exited in zone ^5%s^3 for job ^5%s^3", GetPlayerServerId(PlayerId()),  zoneName, Ora.NpcJobs.Bank:GetJobName()))    

  KeySettings:Clear("keyboard", "E", "Ora_npcjobs_bank_manage")
  KeySettings:Clear("controller", 46, "Ora_npcjobs_bank_manage")
  Hint:RemoveAll()

  Ora.NpcJobs.Bank.Menu = {}
  Ora.NpcJobs.Bank.Menu.INDEXES = {}
  Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
  Ora.NpcJobs.Bank.Accounts.LOADED = false
  Ora.NpcJobs.Bank.Cards.LOADED = false
  
  if (RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","main"))) then
    RageUI.CloseAll()

        Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
  end

  if (RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","Ora_npcjobs_bank_createaccount"))) then
    RageUI.CloseAll()

      Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
  end

  if (RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","Ora_npcjobs_bank_manageaccount"))) then
    RageUI.CloseAll()

    Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
  end

  if (RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","Ora_npcjobs_bank_showaccount"))) then
    RageUI.CloseAll()

    Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
  end

  if (RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","Ora_npcjobs_bank_createcard"))) then
    RageUI.CloseAll()

    Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
  end

  if (RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","Ora_npcjobs_bank_managecard"))) then
    RageUI.CloseAll()

    Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
  end

  if (RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","Ora_npcjobs_bank_showcard"))) then
    RageUI.CloseAll()

    Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
  end
end

--[[
  __  __                  
 |  \/  |                 
 | \  / | ___ _ __  _   _ 
 | |\/| |/ _ \ '_ \| | | |
 | |  | |  __/ | | | |_| |
 |_|  |_|\___|_| |_|\__,_|
                                            
]]


-- Handle Menu Options
Citizen.CreateThread(function()
  while (true) do
    Wait(0)

    if RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","Ora_npcjobs_bank_managecard")) then
      RageUI.DrawContent({ header = true, glare = false }, function()
        if (Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS == true) then
          RageUI.CloseAll()
        else

          if (Ora.NpcJobs.Bank.Cards.LOADED == false) then
            Ora.NpcJobs.Bank:GetCards()
          end

          RageUI.CenterButton(
                "~b~↓↓↓ ~s~"..  Ora.Identity:GetMyName() .." ~b~↓↓↓",
                nil,
                {},
                true,
                function(_, _, _)
                end
            )

            if (Ora.NpcJobs.Bank.Cards.LOADED == false) then
              RageUI.CenterButton(
                  "~h~~o~_____ Cartes en chargement _____~h~~s~",
                  nil,
                  {},
                  true,
                  function(_, _, _)
                  end
              )
            else
                for key, value in pairs(Ora.NpcJobs.Bank.Cards.LIST) do
                  local bank_account_name = value.bank_account_name 
                  if (bank_account_name == nil) then
                    bank_account_name = "~r~Compte supprimé~s~"
                  end
                  local description = "CARTE # ~g~" .. value.number .. "~s~\nCOMPTE LIE : ~g~" .. bank_account_name .. "~s~\nCODE : ~g~" .. value.code .. "~s~"
                  RageUI.Button("~b~[".. value.number .."]~s~ " .. bank_account_name, description, {}, true, 
                      function(Hovered, Active, Selected)
                      end
                  )
                end
            end

        end
      end)
    end

    if RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","Ora_npcjobs_bank_createcard")) then
      RageUI.DrawContent({ header = true, glare = false }, function()

        if (Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS == true) then
            RageUI.CloseAll()
        else
          RageUI.CenterButton(
              "~b~↓↓↓ ~s~"..  Ora.Identity:GetMyName() .." ~b~↓↓↓",
              nil,
              {},
              true,
              function(_, _, _)
              end
          )

          RageUI.CenterButton(
              "~h~~b~______________~h~~s~",
              nil,
              {},
              true,
              function(_, _, _)
              end
          )

          if (Ora.NpcJobs.Bank.Menu.INDEXES["bank_account"] == nil) then
              Ora.NpcJobs.Bank.Menu.INDEXES["bank_account"] = {}
              Ora.NpcJobs.Bank.Menu.INDEXES["bank_account"].CURRENT_INDEX = 1
          end

          Ora.NpcJobs.Bank.Menu.INDEXES["bank_account"].VALUES = Ora.NpcJobs.Bank:GetBankAccountLabels() 

          RageUI.List(
              "Carte pour le compte :",
              Ora.NpcJobs.Bank.Menu.INDEXES["bank_account"].VALUES,
              Ora.NpcJobs.Bank.Menu.INDEXES["bank_account"].CURRENT_INDEX,
              nil,
              {},
              true,
              function(_, Active, Selected, Index)
                Ora.NpcJobs.Bank.Menu.INDEXES["bank_account"].CURRENT_INDEX = Index
              end
          )    

          RageUI.CenterButton(
              "~h~~b~______________~h~~s~",
              nil,
              {},
              true,
              function(_, _, _)
              end
          )


          RageUI.CenterButton(
              "~g~+ Créer ma carte bancaire ~h~(1000$)~h~~s~",
              nil,
              {},
              true,
              function(_, _, Selected)
                  if (Selected) then
                      if (Ora.NpcJobs.Bank.Menu.INDEXES["bank_account"].CURRENT_INDEX == nil) then
                        ShowNotification(string.format("Aucun compte en banque saisi pour ~g~~h~%s~h~~s~", Ora.Identity:GetMyName()))
                      else
                        Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = true
                        local selectedIndex = Ora.NpcJobs.Bank.Menu.INDEXES["bank_account"].CURRENT_INDEX
                        local accountName = Ora.NpcJobs.Bank.Menu.INDEXES["bank_account"].VALUES[selectedIndex]
                        local bankAccountId = Ora.NpcJobs.Bank:GetBankAccountIdByName(accountName)
                        Ora.NpcJobs.Bank:Debug(string.format("Player ^5%s^3 create a credit card for bank account ^5%s^3, id ^5%s^3", GetPlayerServerId(PlayerId()), accountName,bankAccountId))    

                        dataonWait = {
                            title = "Banque",
                            price = 1000,
                            isLimited = false,
                            fct = function()
                                Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS = false
                                TriggerServerEvent("Ora::SE::NpcJobs::Bank:CreateCard", bankAccountId)
                            end
                        }
                        TriggerEvent("payWith?")
                      end
                  end
              end
          )
        end
      end)
    end

    if RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","Ora_npcjobs_bank_createaccount")) then
      RageUI.DrawContent({ header = true, glare = false }, function()

        if (Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS == true) then
            RageUI.CloseAll()
        else
          RageUI.CenterButton(
              "~b~↓↓↓ ~s~"..  Ora.Identity:GetMyName() .." ~b~↓↓↓",
              nil,
              {},
              true,
              function(_, _, _)
              end
          )

          RageUI.CenterButton(
              "~h~~b~______________~h~~s~",
              nil,
              {},
              true,
              function(_, _, _)
              end
          )

          local rightLabel = "~r~Non défini~s~"
          if (Ora.NpcJobs.Bank.Menu.Phone ~= nil) then
            rightLabel = "~g~" .. Ora.NpcJobs.Bank.Menu.Phone .. "~s~"
          end
        

        RageUI.Button("Numéro de téléphone", "Appuyez sur entrer pour saisir votre numéro de téléphone pour recevoir votre code", {RightLabel = rightLabel}, true, 
            function(Hovered, Active, Selected)
                if Selected then
                  phone = KeyboardInput("~b~Numéro de téléphone", nil, 255)
                  if phone ~= nil then
                    Ora.NpcJobs.Bank.Menu.Phone = phone
                  end
                end
            end
        )

        RageUI.CenterButton(
            "~h~~b~______________~h~~s~",
            nil,
            {},
            true,
            function(_, _, _)
            end
        )


        RageUI.CenterButton(
            "~h~~g~+ Créer mon compte bancaire~h~~s~",
            nil,
            {},
            true,
            function(_, _, Selected)
                if (Selected) then
                    if (Ora.NpcJobs.Bank.Menu.Phone == nil) then
                      ShowNotification(string.format("Aucun numéro de téléphone saisi pour ~g~~h~%s~h~~s~", Ora.Identity:GetMyName()))
                    else
                      Ora.NpcJobs.Bank:Debug(string.format("Player ^5%s^3 has created bank account", GetPlayerServerId(PlayerId())))    
                      TriggerServerEvent("Ora::SE::NpcJobs::Bank:CreateAccount", Ora.NpcJobs.Bank.Menu.Phone)
                      RageUI.CloseAll()
                    end
                end
            end
        )
        end
      end)
    end

    if RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","main")) then
      RageUI.DrawContent({ header = true, glare = false }, function()
        if (Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS == true) then
            RageUI.CloseAll()
        else

          RageUI.CenterButton(
              "~b~↓↓↓ ~s~"..  Ora.Identity:GetMyName() .." ~b~↓↓↓",
              nil,
              {},
              true,
              function(_, _, _)
              end
          )

          if (Ora.NpcJobs.Bank:HasPersonnalAccount() == false) then
            RageUI.Button("Créer un compte", "Créer votre compte en banque", {}, true, 
                function(Hovered, Active, Selected)
                end,
                RMenu:Get("Ora_npcjobs_bank", "Ora_npcjobs_bank_createaccount")
            )
          end

          if (Ora.NpcJobs.Bank:HasPersonnalAccount() or Ora.NpcJobs.Bank:HasProfessionalAccount()) then
            RageUI.Button("Voir vos comptes", "Voir vos comptes bancaires", {}, true, 
                function(Hovered, Active, Selected)
                end,
                RMenu:Get("Ora_npcjobs_bank", "Ora_npcjobs_bank_manageaccount")
            )
          end

          RageUI.Button("Associer un compte pro", "Associer un compte pro grâce a un code d'activation", {}, true, 
              function(Hovered, Active, Selected)
                  if Selected then
                    if Selected then
                      securityNumber = KeyboardInput("~b~Numéro de sécurité d'association", nil, 255)
                      if securityNumber ~= nil then
                        Ora.NpcJobs.Bank:Debug(string.format("Player ^5%s^3 tries to associate company with security code ^5%s^3", GetPlayerServerId(PlayerId()), securityNumber))    
                        TriggerServerEvent("Ora::SE::NpcJobs::Bank:AssociateProAccount", securityNumber)
                        RageUI.CloseAll()
                      else
                        Ora.NpcJobs.Bank:Debug(string.format("Player ^5%s^3 hasn't entered a security code", GetPlayerServerId(PlayerId())))    
                        ShowNotification(string.format("Aucun numéro sécurité saisi pour ~g~~h~%s~h~~s~", Ora.Identity:GetMyName()))
                      end
                    end
                  end
              end
          )


          RageUI.CenterButton(
              "~h~~b~__________________~h~~s~",
              nil,
              {},
              true,
              function(_, _, _)
              end
          )

          if (Ora.NpcJobs.Bank:HasPersonnalAccount() or Ora.NpcJobs.Bank:HasProfessionalAccount()) then
            RageUI.Button("Créer une carte", "Créer une carte bancaire", {}, true, 
                function(Hovered, Active, Selected)
                end,
                RMenu:Get("Ora_npcjobs_bank", "Ora_npcjobs_bank_createcard")
            )

            RageUI.Button("Gérer vos cartes", "Gérer vos cartes bancaire", {}, true, 
                function(Hovered, Active, Selected)
                end,
                RMenu:Get("Ora_npcjobs_bank", "Ora_npcjobs_bank_managecard")
            )
          else
            RageUI.Button("~r~~h~Pour créer une carte, créez un compte~h~~s~", "Pour créer une carte, créez un compte", {}, true, 
                function(Hovered, Active, Selected)
                end
            )
          end
        end
      end)
    end

    if RageUI.Visible(RMenu:Get("Ora_npcjobs_bank","Ora_npcjobs_bank_manageaccount")) then
      RageUI.DrawContent({ header = true, glare = false }, function()
        if (Ora.NpcJobs.Bank.Menu.PAYMENT_PROCESS == true) then
            RageUI.CloseAll()
        else

            RageUI.CenterButton(
                "~b~↓↓↓ ~s~"..  Ora.Identity:GetMyName() .." ~b~↓↓↓",
                nil,
                {},
                true,
                function(_, _, _)
                end
            )

            if (Ora.NpcJobs.Bank.Accounts.LOADED == false) then
              RageUI.CenterButton(
                  "~h~~o~_____ Comptes en chargement _____~h~~s~",
                  nil,
                  {},
                  true,
                  function(_, _, _)
                  end
              )
            else
                for key, value in pairs(Ora.NpcJobs.Bank.Accounts.LIST) do
                  if (value.bloqued == true) then
                    RageUI.Button("~r~[Bloqué]~s~ " .. value.label, "", {RightLabel = "~g~+".. value.amount .."$~s~"}, true, 
                          function(Hovered, Active, Selected)
                              if Selected then
                              end
                          end
                      )
                  else
                      local description = "IBAN : ~g~" .. value.iban .. "~s~\nNOM : ~g~" .. value.label .. "~s~\nSOLDE : ~g~" .. value.amount .. "$~s~"
                      RageUI.Button("~b~[".. value.iban .."]~s~ " .. value.label, description, {RightLabel = "~g~+".. value.amount .."$~s~"}, true, 
                          function(Hovered, Active, Selected)
                              if Selected then
                              end
                          end
                      )
                  end
                end
            end

        end
      end)
    end
  end
end)