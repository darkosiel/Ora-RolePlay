RegisterServerEvent("Atlantiss::SE::Consumable::Alcohol::AddNewBottle")
AddEventHandler("Atlantiss::SE::Consumable::Alcohol::AddNewBottle", function(bottleId, alcohol, count)
  local newBottle = {id = bottleId, alcohol = alcohol, count = count}
  table.insert(Atlantiss.Consumable.Alcohol.Object, newBottle)
  TriggerClientEvent("Atlantiss::CE::Consumable::Alcohol::AddNewBottle", -1, newBottle)
end)

RegisterServerEvent("Atlantiss::SE::Consumable::Alcohol::Drink")
AddEventHandler("Atlantiss::SE::Consumable::Alcohol::Drink", function(bottleId)
  for k, v in ipairs(Atlantiss.Consumable.Alcohol.Object) do
    if v.id == bottleId then
      v.count = v.count - 1
      if v.count == 0 then
        table.remove(Atlantiss.Consumable.Alcohol.Object, k)
        TriggerClientEvent("Qtarget:NetworkRemoveTargetEntity", -1, bottleId)
        DeleteEntity(NetworkGetEntityFromNetworkId(bottleId))
      end
      break
    end
  end
end)

RegisterServerCallback("Atlantiss::SE::Consumable::Alcohol::GetCount", function(source, callback, bottleId)
  for k, v in ipairs(Atlantiss.Consumable.Alcohol.Object) do
    if v.id == bottleId then
      table.remove(Atlantiss.Consumable.Alcohol.Object, k)
      return callback(v.count)
    end
  end
end)

RegisterServerCallback("Atlantiss::SE::Consumable::Alcohol::Initialize", function(source, callback)
  callback(Atlantiss.Consumable.Alcohol.Object)
end)