Ora.Jobs.RefreshTimeout = {}
Ora.Jobs.DrinksStored = {}


function Ora.Jobs.RefreshDrinksStored(storage, job, src, force)
  local advertize = true

  if (Ora.Jobs.RefreshTimeout[job] == nil) then
    Ora.Jobs.RefreshTimeout[job] = 0
  end

  if (Ora.Jobs.DrinksStored[job] == nil) then
    Ora.Jobs.DrinksStored[job] = {}
  end

  if (Ora.Jobs.RefreshTimeout[job] - GetGameTimer() <= 0) then
    MySQL.Async.fetchAll(
      "SELECT * FROM storages_inventory_items2 WHERE storage_name = @name",
      {["@name"] = storage.."_storage"},
      function(result)
        if (result[1]) then
          for i = 1, #result do
            local howmuch = 0

            if (result[i].metadata ~= '{}') then advertize = false end

            for _,_ in pairs(json.decode(result[i].metadata)) do
              howmuch = howmuch + 1
            end

            if (Items[result[i].item_name].category == "bspecial" and howmuch > 0) then
              Ora.Jobs.DrinksStored[job][result[i].item_name] = howmuch
            end
          end

          if (advertize == true) then
            TriggerClientEvent("RageUI:Popup", src, {message = "~r~Je n'ai plus rien en stock, repassez plus tard."})
          end
        else
          if (#(Ora.Jobs.DrinksStored[job]) == 0) then
            TriggerClientEvent("RageUI:Popup", src, {message = "~r~Je n'ai plus rien en stock, repassez plus tard."})
          end
        end
      end
    )
    
    Ora.Jobs.RefreshTimeout[job] = GetGameTimer() + 60000 -- 1 min
  else
    if (force) then
      TriggerClientEvent("RageUI:Popup", src, {message = "~r~J'ai d'autres clients, merci de repasser dans quelques minutes."})
    end
  end
end