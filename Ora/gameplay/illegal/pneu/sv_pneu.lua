RegisterServerEvent("SlashTires:TargetClient")
AddEventHandler("SlashTires:TargetClient", function(client, vehicleNetId, tireIndex)
	TriggerClientEvent("SlashTires:SlashClientTire", client, vehicleNetId, tireIndex)
end)