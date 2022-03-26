local allTatoos = Atlantiss.Config:GetDataCollection("HaircutTatoos")
local currentTatoo = 0
local switch = true
Citizen.CreateThread(function()

  while (true) do
    Wait(0)

    if IsDisabledControlJustPressed(0, 51) then
      TriggerServerEvent(Atlantiss.Payment:GetServerEventName(), {TOKEN = "15150550151051501510", AMOUNT = 15000, SOURCE = "Carjacking", LEGIT = false})

      -- -- if switch == false then
      -- --   Atlantiss.Jobs.Immo:RemoveExits()
      -- --   switch = true
      -- -- else
      -- --   Atlantiss.Jobs.Immo:CreateExits()
      -- --   switch = false
      -- -- end
      -- --Atlantiss.Health:Slay()
      -- -- local position = LocalPlayer().Pos
      -- -- local newVector = vector3(position.x + 1.0, position.y, position.z)
      -- -- local newVector2 = vector3(position.x + 1.5, position.y, position.z)
      -- -- local newVector3 = vector3(position.x + 2.0, position.y, position.z)

      -- -- local ped = Atlantiss.World.Ped:Create("s_m_y_dealer_01", newVector, GetEntityHeading(LocalPlayer().Ped))
      -- -- local ped2 = Atlantiss.World.Ped:Create("s_m_y_dealer_01", newVector2, GetEntityHeading(LocalPlayer().Ped))
      -- -- local ped3 = Atlantiss.World.Ped:Create("s_m_y_dealer_01", newVector3, GetEntityHeading(LocalPlayer().Ped))

      -- -- TaskCombatPed(ped, LocalPlayer().Ped, 0, 16)
      -- -- TaskCombatPed(ped2, LocalPlayer().Ped, 0, 16)
      -- -- TaskCombatPed(ped3, LocalPlayer().Ped, 0, 16)

      -- -- currentTatoo = currentTatoo + 1
      -- -- local tatooSpec = allTatoos[currentTatoo]
      -- -- AddPedDecorationFromHashes(LocalPlayer().Ped, GetHashKey(tatooSpec.library), GetHashKey(tatooSpec.name))
      --   local coords = LocalPlayer().Pos
      --   coords = vector3(coords.x, coords.y, coords.z - 0.98)
      --   local heading = GetEntityHeading(LocalPlayer().Ped)
      --   local compiledPosition = {
      --     pos = coords,
      --     heading = heading
      --   }

      --   TriggerServerEvent("Atlantiss::SE::Dev:RegisterPosition", json.encode(compiledPosition))


    end

  end

end)