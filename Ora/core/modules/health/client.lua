RegisterNetEvent("Ora::CE::PlayerLoaded")
AddEventHandler(
    "Ora::CE::PlayerLoaded",
    function()
        local myHealth = Ora.Identity:GetMyHealth()
        if (myHealth ~= nil) then
          --Ora.Health:SetMyHealthWithoutRegister(myHealth)
        end
    end
)

function Ora.Health:SetCantRun(cantRun)
  self:Debug(string.format("^5%s^3 can now run ^5%s^3", GetPlayerServerId(PlayerId()), cantRun))
  self.State.CANT_RUN = cantRun
end

function Ora.Health:SetCantShoot(cantShoot)
  self:Debug(string.format("^5%s^3 can now shoot ^5%s^3", GetPlayerServerId(PlayerId()), cantShoot))
  self.State.CANT_SHOOT = cantShoot
end

function Ora.Health:SetKO(isKo)
  self:Debug(string.format("^5%s^3 is now ko ^5%s^3", GetPlayerServerId(PlayerId()), isKo))
  self.State.IS_KO = isKo
end

function Ora.Health:SetIsDead(isDead, registerServerSide)
  registerServerSide = registerServerSide or true
  self:Debug(string.format("^5%s^3 is now dead ^5%s^3", GetPlayerServerId(PlayerId()), isDead))
  self.State.IS_DEAD = isDead

  if (registerServerSide) then
    self:Debug(string.format("^5%s^3 is now dead serverside : ^5%s^3", GetPlayerServerId(PlayerId()), isDead))
    TriggerServerEvent("Ora::SE::Health:SetPlayerIsDead", isDead)
  end

end

function Ora.Health:isKO()
  return self.State.IS_KO
end

function Ora.Health:IsDead()
  return self.State.IS_DEAD
end

function Ora.Health:GetCantRun()
  return self.State.CANT_RUN
end

function Ora.Health:GetCantShoot()
  return self.State.CANT_SHOOT
end

function Ora.Health:IsPlayerWounded()
  return self.State.IS_WOUNDED
end

function Ora.Health:Slay()
  self:Debug(string.format("^5%s^3 is now slayed", GetPlayerServerId(PlayerId())))
  self:SetMyHealthWithoutRegister(0)
  LocalPlayer().isDead = true
  Ora.Health:SetIsDead(true)
end

function Ora.Health:Revive(registerServerSide)
  registerServerSide = registerServerSide or true
  local ped = LocalPlayer().Ped
  
  LocalPlayer().isDead = false
  LocalPlayer().isKO = false
  Ora.Health:SetIsDead(false)
  Ora.Health:SetKO(false)

  if IsEntityDead(ped) or IsPedDeadOrDying(ped, 1) then
      NetworkResurrectLocalPlayer(GetEntityCoords(ped), 0, true, true, false)
  end

  if (registerServerSide == true) then
    TriggerServerEvent("Ora::SE::Health:SetPlayerIsDead", false)
  end
  self:Debug(string.format("^5%s^3 is now revived (server side : ^5%s^3)", GetPlayerServerId(PlayerId()), registerServerSide))
  self:SetMyHealthPercent(15)
end

function Ora.Health:RemoveInjuredEffects()

  Citizen.CreateThread(
      function()
          local ped = LocalPlayer().Ped
          DoScreenFadeOut(1000)
          Citizen.Wait(1000)
          DoScreenFadeIn(1000)
          ClearTimecycleModifier()
          ResetScenarioTypesEnabled()
          ResetPedMovementClipset(ped, 0)
          SetPedIsDrunk(ped, false)
          SetCamEffect(0)
      end
  )

end

function Ora.Health:GetCurrentRegisteredHealth()
  if (self.State.CURRENT_HEALTH == nil) then
    self.State.CURRENT_HEALTH = GetEntityHealth(LocalPlayer().Ped)
  end
  return self.State.CURRENT_HEALTH
end

function Ora.Health:SetCurrentRegisteredHealth(health)
  self.State.CURRENT_HEALTH = health
end

function Ora.Health:SetMyHealthPercentWithoutRegister(healthPercent)
  self:Debug(string.format("^5%s^3 has now ^5%s^3 %% life", GetPlayerServerId(PlayerId()), healthPercent))
  local life = self:GetHealthPointByPercent(healthPercent)
  SetEntityHealth(PlayerPedId(), life)
  self:SetCurrentRegisteredHealth(life)
end

function Ora.Health:SetMyHealthWithoutRegister(healthPoint)
  self:Debug(string.format("^5%s^3 has now ^5%s^3 health point life", GetPlayerServerId(PlayerId()), healthPoint))
  local playerPed = PlayerPedId()
  SetEntityHealth(playerPed, math.tointeger(healthPoint))
  self:SetCurrentRegisteredHealth(math.tointeger(healthPoint))
end

function Ora.Health:SetMyHealth(healthPoint)
  local playerPed = PlayerPedId()
  self:SetMyHealthWithoutRegister(math.tointeger(healthPoint))
  TriggerServerEvent("Ora::SE::Player:RegisterHealth", GetEntityHealth(playerPed))
end

function Ora.Health:SetMyHealthPercent(healthPercent)
  local playerPed = PlayerPedId()
  self:SetMyHealthPercentWithoutRegister(healthPercent)
  TriggerServerEvent("Ora::SE::Player:RegisterHealth", GetEntityHealth(playerPed))
end


function Ora.Health:SetPlayerWounded(mstimeWounded)
  -- local playerPed = LocalPlayer().Ped
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

function Ora.Health:GetHealthPointByPercent(percent)
  if percent == 0 or percent == nil then
    percent = 50
  end
  
  local entityHealth = 200
  if (GetEntityMaxHealth(LocalPlayer().Ped) > 100) then
    entityHealth = 100 + math.ceil((GetEntityMaxHealth(LocalPlayer().Ped) - 100) *  (percent / 100))
  else
    entityHealth = math.ceil(GetEntityMaxHealth(LocalPlayer().Ped) *  (percent / 100))
  end

  return entityHealth
end

function Ora.Health:Initialize()
  -- local lastHealth = nil
  -- Citizen.CreateThread(function()
  --   while true do
  --     Wait(1000)
  --     local hurt = Ora.Health:GetHealthPointByPercent(25)
  --     local ped = GetLocalPlayer().Ped
  --     health = GetEntityHealth(ped)
      
  --     if (lastHealth ~= health) then
  --       TriggerServerEvent("Ora::SE::Player:RegisterHealth", health)
  --       lastHealth = health
  --     end

  --     if health <= hurt then
  --       self:SetCantRun(true)
  --       self:SetCantShoot(true)
  --       self:SetPlayerWounded()
  --     else
  --       self:SetCantRun(false)
  --       self:SetCantShoot(false)
  --       self.State.IS_WOUNDED = false
  --     end
  --   end
  -- end)

  -- Citizen.CreateThread(function()
  --   while true do
  --     Wait(0)
  --     if (self:GetCantRun()) then
  --       DisableControlAction(0, 21, 1)
  --     end

  --     if (self:GetCantShoot()) then
  --       DisableControlAction(0,24,1) -- disable attack
  --       DisableControlAction(0,25,1) -- disable aim
  --       DisableControlAction(0,47,1) -- disable weapon
  --       DisableControlAction(0,58,1) -- disable weapon
  --       DisableControlAction(0,263,1) -- disable melee
  --       DisableControlAction(0,264,1) -- disable melee
  --       DisableControlAction(0,257,1) -- disable melee
  --       DisableControlAction(0,140,1) -- disable melee
  --       DisableControlAction(0,141,1) -- disable melee
  --       DisableControlAction(0,142,1) -- disable melee
  --       DisableControlAction(0,143,1) -- disable melee
  --     end
  --   end
  -- end)

end
