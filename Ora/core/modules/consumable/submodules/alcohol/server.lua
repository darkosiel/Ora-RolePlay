RegisterServerEvent("Ora::SE::Consumable::Alcohol::AddNewBottle")
AddEventHandler("Ora::SE::Consumable::Alcohol::AddNewBottle", function(bottleId, alcohol, count)
  local newBottle = {id = bottleId, alcohol = alcohol, count = count}
  table.insert(Ora.Consumable.Alcohol.Object, newBottle)
  TriggerClientEvent("Ora::CE::Consumable::Alcohol::AddNewBottle", -1, newBottle)
end)

RegisterServerEvent("Ora::SE::Consumable::Alcohol::Drink")
AddEventHandler("Ora::SE::Consumable::Alcohol::Drink", function(bottleId)
  for k, v in ipairs(Ora.Consumable.Alcohol.Object) do
    if v.id == bottleId then
      v.count = v.count - 1
      if v.count == 0 then
        table.remove(Ora.Consumable.Alcohol.Object, k)
        TriggerClientEvent("Qtarget:NetworkRemoveTargetEntity", -1, bottleId)
        DeleteEntity(NetworkGetEntityFromNetworkId(bottleId))
      end
      break
    end
  end
end)

RegisterServerCallback("Ora::SE::Consumable::Alcohol::GetCount", function(source, callback, bottleId)
  for k, v in ipairs(Ora.Consumable.Alcohol.Object) do
    if v.id == bottleId then
      table.remove(Ora.Consumable.Alcohol.Object, k)
      return callback(v.count)
    end
  end
end)

RegisterServerCallback("Ora::SE::Consumable::Alcohol::Initialize", function(source, callback)
  callback(Ora.Consumable.Alcohol.Object)
end)