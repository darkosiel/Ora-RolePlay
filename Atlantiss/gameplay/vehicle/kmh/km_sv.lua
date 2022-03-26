local PlateArray = {
   -- {plate = "22AAA333", kms = 999999999999}
}

RegisterServerCallback('kmveh:getVehicle', function(source, cb, plate)
  for i=1, #PlateArray do
    if PlateArray[i].plate == plate then
      cb(PlateArray[i].kms)
      return
    end
  end
        
	MySQL.Async.fetchAll('SELECT * FROM players_vehicles WHERE @plate = plate', {['@plate'] = plate}, function(result)
    if result[1] ~= nil then
      local kms = result[1].kms
      cb(kms)
    else
      table.insert(PlateArray, {plate = plate, kms = math.random(10000.000, 100000.000)})
      cb(PlateArray[#PlateArray].kms)
    end
	end)
end)

RegisterServerEvent('kmveh:setKms')
AddEventHandler('kmveh:setKms', function(plate, kms)
  if kms ~= 0 then
    for i=1, #PlateArray do
      if PlateArray[i].plate == plate then
        PlateArray[i].kms = kms
        break
      end                
    end
    MySQL.Async.execute('UPDATE `players_vehicles` SET `kms` = @kms WHERE `plate` = @plate',
    {
      ['@kms'] = kms,
      ['@plate'] = plate,
    })
  end
end)