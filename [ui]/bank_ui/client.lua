



RegisterNetEvent('ShowBankCard')
AddEventHandler('ShowBankCard', function(data)
	--print(json.encode(data))
	SendNUIMessage({
		action = 'showCards',
		data = data.data
	})
	Wait(5000)
	SendNUIMessage({
		action = 'hide'
	})
end)


