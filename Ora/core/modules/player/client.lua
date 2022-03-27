Ora.Player.HasLoaded = false
Ora.Player.SavedPos = nil
Ora.Player.Speaker = {
  IsUsing = false,
  Pos = vector3(0,0,0),
  IsOnShoulder = false
}


--[[ 
   ________      __          __   __  ___     __  __              __    
  / ____/ /___  / /_  ____ _/ /  /  |/  /__  / /_/ /_  ____  ____/ /____
 / / __/ / __ \/ __ \/ __ `/ /  / /|_/ / _ \/ __/ __ \/ __ \/ __  / ___/
/ /_/ / / /_/ / /_/ / /_/ / /  / /  / /  __/ /_/ / / / /_/ / /_/ (__  ) 
\____/_/\____/_.___/\__,_/_/  /_/  /_/\___/\__/_/ /_/\____/\__,_/____/  
]]


function Ora.Player:SetCantRun(cantRun)
  self.State.CANT_RUN = cantRun
end

function Ora.Player:SetCantShoot(cantShoot)
  self.State.CANT_SHOOT = cantShoot
end

function Ora.Player:GetCantRun()
  return self.State.CANT_RUN
end

function Ora.Player:GetCantShoot()
  return self.State.CANT_SHOOT
end

function Ora.Player:IsPlayerWounded()
  return self.State.IS_WOUNDED
end

function Ora.Player:SetStealing(switch)
  self.State.STEALING = switch
end

function Ora.Player:IsStealing()
  return self.State.STEALING
end


function Ora.Player:SetPlayerWounded(mstimeWounded)
  -- local playerPed = PlayerPedId()
  -- local noLimit = false
  -- self:SetCantRun(true)
  -- self:SetCantShoot(true)
  -- self.State.IS_WOUNDED = true
  -- RemoveAllPedWeapons(playerPed)
  -- ResetPedMovementClipset(playerPed, 0)
  -- Ora.Utils:RequestAndWaitSet("move_m@injured")
  -- SetPedMovementClipset(playerPed, "move_m@injured", 0)

  -- local endTime = GetGameTimer()

  -- if (mstimeWounded == nil) then
  --   noLimit = true
  -- else
  --   endTime = GetGameTimer() + mstimeWounded
  -- end

  -- Citizen.CreateThread(
  --     function()
  --       if (noLimit) then
  --         while self.State.IS_WOUNDED do
  --           Citizen.Wait(1000)
  --         end
  --       else
  --         while self.State.IS_WOUNDED and GetGameTimer() < endTime do
  --             Citizen.Wait(1000)
  --         end
  --       end

  --       if self.State.IS_WOUNDED then
  --           self.State.IS_WOUNDED = false
  --       end
  --     end
  -- )
end


function Ora.Player:GenerateNewPhoneNumber()
    local canSend = false
    local phoneNumber = nil

    TriggerServerCallback("Ora::SE::Player:Phone:GetNewPhoneNumber", function(newPhoneNumber)
      phoneNumber = newPhoneNumber
      canSend = true
    end)
    
    while (canSend == false) do
      self:Debug(string.format("Waiting new phone number pulling"))
      Wait(100)      
    end
    
    self:Debug(string.format("Returning new phone number : ^5%s^3", phoneNumber))
  return phoneNumber
end

function Ora.Player:ApplyTattoos(tattoosList)
  if (type(tattoosList) == "table" and #tattoosList > 0) then
    ClearPedDecorations(LocalPlayer().Ped)
    for i = 1, #tattoosList, 1 do
        if tattoosList[i] ~= nil then
          self:ApplyTattoo(tattoosList[i].dict, tattoosList[i].hash)
        end
    end
  end

  self:Debug(string.format("Applied ^5%s^3 tattoos to player ^5%s^3", #tattoosList, GetPlayerServerId(PlayerId())))
end

function Ora.Player:ApplyHairsTattoos()
  local headTattoos = Ora.Config:GetDataCollection("AppliedHarcutTatoos")
  if (headTattoos ~= nil and headTattoos.dict ~= nil and headTattoos.hash ~= nil) then
    self:ApplyTattoo(headTattoos.dict, headTattoos.hash)
  end

  self:Debug(string.format("Applied ^5%s^3 tattoos hairs to player ^5%s^3", #headTattoos, GetPlayerServerId(PlayerId())))
end

function Ora.Player:RemoveAllTattoos()
  ClearPedDecorations(LocalPlayer().Ped)
  self:Debug(string.format("Removed tattoos from player ^5%s^3", GetPlayerServerId(PlayerId())))
end

function Ora.Player:ApplyTattoo(dict, hash)
  AddPedDecorationFromHashes(LocalPlayer().Ped, dict, hash)
  self:Debug(string.format("Applied ^5%s %s^3 tattoo to player ^5%s^3", dict, hash, GetPlayerServerId(PlayerId())))
end

function Ora.Player:ApplyAllSavedTattoos(withoutHairs)
  ClearPedDecorations(LocalPlayer().Ped)
  local currentTattoos = Ora.Config:GetDataCollection("PlayerTattoos")
  Ora.Player:ApplyTattoos(currentTattoos)

  if (withoutHairs ~= true) then
    local headTattoos = Ora.Config:GetDataCollection("AppliedHarcutTatoos")
    if (headTattoos ~= nil and headTattoos.dict ~= nil and headTattoos.hash ~= nil) then
      self:ApplyTattoo(headTattoos.dict, headTattoos.hash)
    end
  end

  self:Debug(string.format("Applied ^5%s^3 tattoos to player ^5%s^3", #currentTattoos, GetPlayerServerId(PlayerId())))
end

function Ora.Player:FreezePlayer(playerPed, switch)
  if (playerPed == LocalPlayer().Ped) then
    self.State.FREEZED = switch
    self:Debug(string.format("Player ^5%s^3 freeze is ^5%s^3", GetPlayerServerId(PlayerId()), switch))
  end

  FreezeEntityPosition(playerPed, switch)
end

function Ora.Player:IsFreezed()
  return self.State.FREEZED
end

function Ora.Player:SetEntityInvicible(player, playerPed, switch)
  if (switch == true) then
    SetEntityInvincible(playerPed, true)
    SetPlayerInvincible(player, true)
    SetPedCanRagdoll(playerPed, false)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    SetEntityProofs(playerPed, true, true, true, true, true, true, true, true)
    SetEntityOnlyDamagedByPlayer(playerPed, false)
    SetEntityCanBeDamaged(playerPed, false)
    self:Debug(string.format("Player ^5%s^3 is invincible", GetPlayerServerId(PlayerId())))
  else
    SetEntityInvincible(playerPed, false)
    SetPlayerInvincible(player, false)
    SetPedCanRagdoll(playerPed, true)
    ClearPedLastWeaponDamage(playerPed)
    SetEntityProofs(playerPed, false, false, false, false, false, false, false, false)
    SetEntityOnlyDamagedByPlayer(playerPed, false)
    SetEntityCanBeDamaged(playerPed, true)
    self:Debug(string.format("Player ^5%s^3 is no more invincible", GetPlayerServerId(PlayerId())))
  end
end

function Ora.Player:SetIsCreated(switch)
  self.State.CREATED = switch
end

function Ora.Player:IsCreated()
  return self.State.CREATED
end

function Ora.Player:UpdateTattoos(tattoosListFixed)
  self:Debug(string.format("Players tatoos need to be fixed ^5%s^3", GetPlayerServerId(PlayerId())))
  TriggerServerEvent("Ora::SE::Player:UpdateTattoos", tattoosListFixed)
end

function Ora.Player:SavePosition()
  if (self.SavedPos == nil or (type(self.SavedPos) == 'table' and Ora.Utils:TableLength(self.SavedPos) == 0)) then
    TriggerServerEvent('handler:savePosition', EntityGetCoords(LocalPlayer().Ped))
  else
    TriggerServerEvent('handler:savePosition', self.SavedPos)
  end
end


--[[ 
    ______                 __      
   / ____/   _____  ____  / /______
  / __/ | | / / _ \/ __ \/ __/ ___/
 / /___ | |/ /  __/ / / / /_(__  ) 
/_____/ |___/\___/_/ /_/\__/____/  
]]


RegisterNetEvent("Ora::CE::PlayerLoaded")
AddEventHandler(
    "Ora::CE::PlayerLoaded",
    function()
      Ora.Player:SetIsCreated(true)
    end
)

RegisterNetEvent("Ora::CE::Player:RemoveTattoos")
AddEventHandler(
    "Ora::CE::Player:RemoveTattoos",
    function(player)
        Ora.Player:Debug(string.format("Received a request from player ^5%s^3 to remove all my tattoos", player)) 
        Ora.Player:RemoveAllTattoos()  
    end
)

RegisterNetEvent("Ora::CE::Player:ApplyTattoo")
AddEventHandler(
    "Ora::CE::Player:ApplyTattoo",
    function(player, dict, hash)
        Ora.Player:Debug(string.format("Received a request from player ^5%s^3 to add tattoo : ^5%s^3 ^5%s^3 ", player, dict, hash)) 
        Ora.Player:ApplyTatto(dict, hash)  
    end
)

RegisterNetEvent("Ora::CE::Player:ApplySavedTattoos")
AddEventHandler(
    "Ora::CE::Player:ApplySavedTattoos",
    function(player)
        Ora.Player:Debug(string.format("Received a request from player ^5%s^3 to reset all my tattoos ", player)) 
        local currentTattoos = Ora.Config:GetDataCollection("PlayerTattoos")
        Ora.Player:ApplyTattoos(currentTattoos)
    end
)


--[[ 
    ______                      __      
   / ____/  ______  ____  _____/ /______
  / __/ | |/_/ __ \/ __ \/ ___/ __/ ___/
 / /____>  </ /_/ / /_/ / /  / /_(__  ) 
/_____/_/|_/ .___/\____/_/   \__/____/  
          /_/                           
]]


exports(
  'OraPlayerHasLoaded',
  function()
    return Ora.Player.HasLoaded
  end
)


Citizen.CreateThread(
    function()
        while true do
            Wait(1000 * 300)
            if (Ora.Player.HasLoaded == true) then
                Ora.Inventory:Save(true)
                if (GetEntityHealth(LocalPlayer().Ped) ~= Ora.Health:GetCurrentRegisteredHealth()) then
                  Ora.Health:SetMyHealth(GetEntityHealth(LocalPlayer().Ped))
                end
                Ora.Player:SavePosition()
                RageUI.Popup({
                    message = "✅ Personnage synchronisé.",
                    colors = 20
                })
            end
        end
    end
)
