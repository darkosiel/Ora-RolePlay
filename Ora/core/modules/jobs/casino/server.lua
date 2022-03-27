RegisterServerCallback(
  "Ora::SE::Job::Casino::GetDrinksStored",
  function(src, cb, force)
    Ora.Jobs.RefreshDrinksStored("coffre_casino", "casino", src, force)
    Wait(2500)

    cb(Ora.Jobs.DrinksStored['casino'])
  end
)

RegisterServerCallback(
  "Ora::SE::Job::Casino::CanBuy",
  function(src, cb)
    if (Ora.Service:GetTotalServiceCountForJob('casino') == 0) then
      cb(true)
    else
      cb(false)
    end
  end
)


RegisterNetEvent("Ora::SE::Job::Casino::RemoveFromStorage")
AddEventHandler(
  "Ora::SE::Job::Casino::RemoveFromStorage",
  function(item, count)
    if (Ora.Jobs.DrinksStored['casino'][item] - count <= 0) then
      Ora.Jobs.DrinksStored['casino'][item] = nil
    else
      Ora.Jobs.DrinksStored['casino'][item] = Ora.Jobs.DrinksStored['casino'][item] - count
    end

    MySQL.Async.fetchAll(
      "SELECT * FROM storages_inventory_items2 WHERE storage_name = 'coffre_casino_storage' AND item_name = @item",
      {["@item"] = item},
      function(res)
        local data = json.decode(res[1].metadata)

        for i = 0, count do
          for k, _ in pairs(data) do
            data[k] = nil
            break
          end
        end

        data = json.encode(data)

        MySQL.Async.execute(
          "UPDATE storages_inventory_items2 SET metadata = @data WHERE item_name = @item",
          {
            ["@data"] = data,
            ["@item"] = item
          },
          function() end
        )
      end
    )
  end
)
