--[[ Citizen.CreateThread(
  function()
    while true do
      Wait(0)
      for _, bar in pairs(Atlantiss.ZoneSystem.Bars) do
        local x, y, z = table.unpack(bar.Pos)

        DrawMarker(
          1,
          x,
          y,
          z - 30.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          bar.MaxDistance + 15.0,
          bar.MaxDistance + 15.0,
          150.0,
          237,
          36,
          42,
          70
        )
      end
    end
  end
) ]]
