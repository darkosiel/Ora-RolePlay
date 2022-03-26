Atlantiss.Player.HasLoaded = false
Atlantiss.Player.SavedPos = nil
Atlantiss.Player.Speaker = {
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


function Atlantiss.Player:SetCantRun(cantRun)
  self.State.CANT_RUN = cantRun
end

function Atlantiss.Player:SetCantShoot(cantShoot)
  self.State.CANT_SHOOT = cantShoot
end

function Atlantiss.Player:GetCantRun()
  return self.State.CANT_RUN
end

function Atlantiss.Player:GetCantShoot()
  return self.State.CANT_SHOOT
end

function Atlantiss.Player:IsPlayerWounded()
  return self.State.IS_WOUNDED
end

function Atlantiss.Player:SetStealing(switch)
  self.State.STEALING = switch
end

function Atlantiss.Player:IsStealing()
  return self.State.STEALING
end


function Atlantiss.Player:SetPlayerWounded(mstimeWounded)
  -- local playerPed = PlayerPedId()
  -- local noLimit = false
  -- self:SetCantRun(true)
  -- self:SetCantShoot(true)
  -- self.State.IS_WOUNDED = true
  -- RemoveAllPedWeapons(playerPed)
  -- ResetPedMovementClipset(playerPed, 0)
  -- Atlantiss.Utils:RequestAndWaitSet("move_m@injured")
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


function Atlantiss.Player:GenerateNewPhoneNumber()
    local canSend = false
    local phoneNumber = nil

    TriggerServerCallback("Atlantiss::SE::Player:Phone:GetNewPhoneNumber", function(newPhoneNumber)
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

function Atlantiss.Player:ApplyTattoos(tattoosList)
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

function Atlantiss.Player:ApplyHairsTattoos()
  local headTattoos = Atlantiss.Config:GetDataCollection("AppliedHarcutTatoos")
  if (headTattoos ~= nil and headTattoos.dict ~= nil and headTattoos.hash ~= nil) then
    self:ApplyTattoo(headTattoos.dict, headTattoos.hash)
  end

  self:Debug(string.format("Applied ^5%s^3 tattoos hairs to player ^5%s^3", #headTattoos, GetPlayerServerId(PlayerId())))
end

function Atlantiss.Player:RemoveAllTattoos()
  ClearPedDecorations(LocalPlayer().Ped)
  self:Debug(string.format("Removed tattoos from player ^5%s^3", GetPlayerServerId(PlayerId())))
end

function Atlantiss.Player:ApplyTattoo(dict, hash)
  AddPedDecorationFromHashes(LocalPlayer().Ped, dict, hash)
  self:Debug(string.format("Applied ^5%s %s^3 tattoo to player ^5%s^3", dict, hash, GetPlayerServerId(PlayerId())))
end

function Atlantiss.Player:ApplyAllSavedTattoos(withoutHairs)
  ClearPedDecorations(LocalPlayer().Ped)
  local currentTattoos = Atlantiss.Config:GetDataCollection("PlayerTattoos")
  Atlantiss.Player:ApplyTattoos(currentTattoos)

  if (withoutHairs ~= true) then
    local headTattoos = Atlantiss.Config:GetDataCollection("AppliedHarcutTatoos")
    if (headTattoos ~= nil and headTattoos.dict ~= nil and headTattoos.hash ~= nil) then
      self:ApplyTattoo(headTattoos.dict, headTattoos.hash)
    end
  end

  self:Debug(string.format("Applied ^5%s^3 tattoos to player ^5%s^3", #currentTattoos, GetPlayerServerId(PlayerId())))
end

function Atlantiss.Player:FreezePlayer(playerPed, switch)
  if (playerPed == LocalPlayer().Ped) then
    self.State.FREEZED = switch
    self:Debug(string.format("Player ^5%s^3 freeze is ^5%s^3", GetPlayerServerId(PlayerId()), switch))
  end

  FreezeEntityPosition(playerPed, switch)
end

function Atlantiss.Player:IsFreezed()
  return self.State.FREEZED
end

function Atlantiss.Player:SetEntityInvicible(player, playerPed, switch)
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

function Atlantiss.Player:SetIsCreated(switch)
  self.State.CREATED = switch
end

function Atlantiss.Player:IsCreated()
  return self.State.CREATED
end

function Atlantiss.Player:UpdateTattoos(tattoosListFixed)
  self:Debug(string.format("Players tatoos need to be fixed ^5%s^3", GetPlayerServerId(PlayerId())))
  TriggerServerEvent("Atlantiss::SE::Player:UpdateTattoos", tattoosListFixed)
end

function Atlantiss.Player:SavePosition()
  if (self.SavedPos == nil or (type(self.SavedPos) == 'table' and Atlantiss.Utils:TableLength(self.SavedPos) == 0)) then
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


RegisterNetEvent("Atlantiss::CE::PlayerLoaded")
AddEventHandler(
    "Atlantiss::CE::PlayerLoaded",
    function()
      Atlantiss.Player:SetIsCreated(true)
    end
)

RegisterNetEvent("Atlantiss::CE::Player:RemoveTattoos")
AddEventHandler(
    "Atlantiss::CE::Player:RemoveTattoos",
    function(player)
        Atlantiss.Player:Debug(string.format("Received a request from player ^5%s^3 to remove all my tattoos", player)) 
        Atlantiss.Player:RemoveAllTattoos()  
    end
)

RegisterNetEvent("Atlantiss::CE::Player:ApplyTattoo")
AddEventHandler(
    "Atlantiss::CE::Player:ApplyTattoo",
    function(player, dict, hash)
        Atlantiss.Player:Debug(string.format("Received a request from player ^5%s^3 to add tattoo : ^5%s^3 ^5%s^3 ", player, dict, hash)) 
        Atlantiss.Player:ApplyTatto(dict, hash)  
    end
)

RegisterNetEvent("Atlantiss::CE::Player:ApplySavedTattoos")
AddEventHandler(
    "Atlantiss::CE::Player:ApplySavedTattoos",
    function(player)
        Atlantiss.Player:Debug(string.format("Received a request from player ^5%s^3 to reset all my tattoos ", player)) 
        local currentTattoos = Atlantiss.Config:GetDataCollection("PlayerTattoos")
        Atlantiss.Player:ApplyTattoos(currentTattoos)
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
  'AtlantissPlayerHasLoaded',
  function()
    return Atlantiss.Player.HasLoaded
  end
)


Citizen.CreateThread(
    function()
        while true do
            Wait(1000 * 300)
            if (Atlantiss.Player.HasLoaded == true) then
                Atlantiss.Inventory:Save(true)
                if (GetEntityHealth(LocalPlayer().Ped) ~= Atlantiss.Health:GetCurrentRegisteredHealth()) then
                  Atlantiss.Health:SetMyHealth(GetEntityHealth(LocalPlayer().Ped))
                end
                Atlantiss.Player:SavePosition()
                RageUI.Popup({
                    message = "✅ Personnage synchronisé.",
                    colors = 20
                })
            end
        end
    end
)
