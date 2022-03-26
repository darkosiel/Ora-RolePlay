-- ALTER TABLE `players_vehicles` ADD `plate_identifier` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL AFTER `kms`;
AddEventHandler(
  "entityCreating",
  function(entity)
      if DoesEntityExist(entity) then
        local model = GetEntityModel(entity)
        local entityCoords = GetEntityCoords(entity)

        if (GetEntityType(entity) == 2 and GetEntityPopulationType(entity) ~= 7 and GetEntityPopulationType(entity) ~= 5) then
          for key, value in pairs(Atlantiss.World.VehicleGeneratorRemoved) do
            local gridZoneId = Atlantiss.Core:GetGridZoneIdForRadius(entityCoords.x, entityCoords.y, value.r) 
            local generatorGridZoneId = Atlantiss.Core:GetGridZoneIdForRadius(value.x, value.y, value.r) 
            if (gridZoneId == generatorGridZoneId) then
              CancelEvent()
            end
          end
        end
      end
  end
)

Atlantiss.World.Entity = {
  ListToDelete = {}
}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000 * 10)
    local currentTime = os.time()
    for key, value in pairs(Atlantiss.World.Entity.ListToDelete) do
    if (value ~= nil) then
        local entity = NetworkGetEntityFromNetworkId(value.network_id)
        if value.time_delete < currentTime and DoesEntityExist(entity) then
          Atlantiss.World:Debug(string.format("Entity with handle : ^5%s^3 (network id : ^5%s^3) has been deleted", value.handle, value.network_id))
          DeleteEntity(entity)
          Atlantiss.World.Entity.ListToDelete[key] = nil
        end
      end
    end
  end
end)

RegisterServerEvent("Atlantiss::SE::World:Entity:Delete")
AddEventHandler(
    "Atlantiss::SE::World:Entity:Delete",
    function(data)
      Atlantiss.World:Debug(string.format("Entity with handle : ^5%s^3 (network id : ^5%s^3) will be deleted at ^5%s^3", data.handle, data.network_id,  os.date("%Y-%m-%d %H:%M", os.time() + data.seconds)))
      table.insert(Atlantiss.World.Entity.ListToDelete, {network_id = data.network_id, time_delete = os.time() + data.seconds, handle = data.handle})
    end
)
