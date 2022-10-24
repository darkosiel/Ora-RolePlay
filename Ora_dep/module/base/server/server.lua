local playerCount = 0
local list = {}

RegisterServerEvent('hardcap:playerActivated')

AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    playerCount = playerCount - 1
    list[source] = nil
  end
end)



AddEventHandler('onResourceStart', function(resource)
	if true then
		print('^5---------------------##^7 ^1SCANNING RESOURCE^7 ^5##---------------------^7')
		print('[^1Ora RolePlay^7] [^2INFO^7] Resource authorized : "^1'.. resource.. '^7"')
	end
end)

AddEventHandler('onResourceStop', function(resource)
end)
