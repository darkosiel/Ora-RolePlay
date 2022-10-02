RegisterCommand("tpbug", function()
    local playerCoords = GetEntityCoords(PlayerPedId(), false)
    local spawnbug = Vdist(playerCoords.x, playerCoords.y, playerCoords.z,vector3(0.0, 0.0, 0.0))
    if spawnbug <= 15.0 then
		SetEntityCoords(GetPlayerPed(-1), 217.8954, -808.9475, 30.71239)
    else
        ShowNotification(string.format("Vous n'êtes pas buger sous la map, impossible d'utiliser cette commande !"))
    end
end)