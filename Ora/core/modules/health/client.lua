RegisterNetEvent("Atlantiss::CE::PlayerLoaded")
AddEventHandler(
    "Atlantiss::CE::PlayerLoaded",
    function()
        local myHealth = Atlantiss.Identity:GetMyHealth()
        if (myHealth ~= nil) then
          --Atlantiss.Health:SetMyHealthWithoutRegister(myHealth)
        end
    end
)

function Atlantiss.Health:SetCantRun(cantRun)
  self:Debug(string.format("^5%s^3 can now run ^5%s^3", GetPlayerServerId(PlayerId()), cantRun))
  self.State.CANT_RUN = cantRun
end

function Atlantiss.Health:SetCantShoot(cantShoot)
  self:Debug(string.format("^5%s^3 can now shoot ^5%s^3", GetPlayerServerId(PlayerId()), cantShoot))
  self.State.CANT_SHOOT = cantShoot
end

function Atlantiss.Health:SetKO(isKo)
  self:Debug(string.format("^5%s^3 is now ko ^5%s^3", GetPlayerServerId(PlayerId()), isKo))
  self.State.IS_KO = isKo
end

function Atlantiss.Health:SetIsDead(isDead, registerServerSide)
  registerServerSide = registerServerSide or true
  self:Debug(string.format("^5%s^3 is now dead ^5%s^3", GetPlayerServerId(PlayerId()), isDead))
  self.State.IS_DEAD = isDead

  if (registerServerSide) then
    self:Debug(string.format("^5%s^3 is now dead serverside : ^5%s^3", GetPlayerServerId(PlayerId()), isDead))
    TriggerServerEvent("Atlantiss::SE::Health:SetPlayerIsDead", isDead)
  end

end

function Atlantiss.Health:isKO()
  return self.State.IS_KO
end

function Atlantiss.Health:IsDead()
  return self.State.IS_DEAD
end

function Atlantiss.Health:GetCantRun()
  return self.State.CANT_RUN
end

function Atlantiss.Health:GetCantShoot()
  return self.State.CANT_SHOOT
end

function Atlantiss.Health:IsPlayerWounded()
  return self.State.IS_WOUNDED
end

function Atlantiss.Health:Slay()
  self:Debug(string.format("^5%s^3 is now slayed", GetPlayerServerId(PlayerId())))
  self:SetMyHealthWithoutRegister(0)
  LocalPlayer().isDead = true
  Atlantiss.Health:SetIsDead(true)
end

function Atlantiss.Health:Revive(registerServerSide)
  registerServerSide = registerServerSide or true
  local ped = LocalPlayer().Ped
  
  LocalPlayer().isDead = false
  LocalPlayer().isKO = false
  Atlantiss.Health:SetIsDead(false)
  Atlantiss.Health:SetKO(false)

  if IsEntityDead(ped) or IsPedDeadOrDying(ped, 1) then
      NetworkResurrectLocalPlayer(GetEntityCoords(ped), 0, true, true, false)
  end

  if (registerServerSide == true) then
    TriggerServerEvent("Atlantiss::SE::Health:SetPlayerIsDead", false)
  end
  self:Debug(string.format("^5%s^3 is now revived (server side : ^5%s^3)", GetPlayerServerId(PlayerId()), registerServerSide))
  self:SetMyHealthPercent(15)
end

function Atlantiss.Health:RemoveInjuredEffects()

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

function Atlantiss.Health:GetCurrentRegisteredHealth()
  if (self.State.CURRENT_HEALTH == nil) then
    self.State.CURRENT_HEALTH = GetEntityHealth(LocalPlayer().Ped)
  end
  return self.State.CURRENT_HEALTH
end

function Atlantiss.Health:SetCurrentRegisteredHealth(health)
  self.State.CURRENT_HEALTH = health
end

function Atlantiss.Health:SetMyHealthPercentWithoutRegister(healthPercent)
  self:Debug(string.format("^5%s^3 has now ^5%s^3 %% life", GetPlayerServerId(PlayerId()), healthPercent))
  local life = self:GetHealthPointByPercent(healthPercent)
  SetEntityHealth(LocalPlayer().Ped, life)
  self:SetCurrentRegisteredHealth(life)
end

function Atlantiss.Health:SetMyHealthWithoutRegister(healthPoint)
  self:Debug(string.format("^5%s^3 has now ^5%s^3 health point life", GetPlayerServerId(PlayerId()), healthPoint))
  local playerPed = LocalPlayer().Ped
  SetEntityHealth(playerPed, math.tointeger(healthPoint))
  self:SetCurrentRegisteredHealth(math.tointeger(healthPoint))
end

function Atlantiss.Health:SetMyHealth(healthPoint)
  local playerPed = LocalPlayer().Ped
  self:SetMyHealthWithoutRegister(math.tointeger(healthPoint))
  TriggerServerEvent("Atlantiss::SE::Player:RegisterHealth", GetEntityHealth(playerPed))
end

function Atlantiss.Health:SetMyHealthPercent(healthPercent)
  local playerPed = LocalPlayer().Ped
  self:SetMyHealthPercentWithoutRegister(healthPercent)
  TriggerServerEvent("Atlantiss::SE::Player:RegisterHealth", GetEntityHealth(playerPed))
end


function Atlantiss.Health:SetPlayerWounded(mstimeWounded)
  -- local playerPed = LocalPlayer().Ped
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

function Atlantiss.Health:GetHealthPointByPercent(percent)
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

function Atlantiss.Health:Initialize()
  -- local lastHealth = nil
  -- Citizen.CreateThread(function()
  --   while true do
  --     Wait(1000)
  --     local hurt = Atlantiss.Health:GetHealthPointByPercent(25)
  --     local ped = GetLocalPlayer().Ped
  --     health = GetEntityHealth(ped)
      
  --     if (lastHealth ~= health) then
  --       TriggerServerEvent("Atlantiss::SE::Player:RegisterHealth", health)
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
