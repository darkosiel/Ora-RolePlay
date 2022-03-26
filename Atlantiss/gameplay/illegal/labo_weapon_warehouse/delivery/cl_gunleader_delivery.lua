IllegalGunleadDelivery = {}
IllegalGunleadDelivery.DELIVERY = {}
IllegalGunleadDelivery.ORDER = {}

function IllegalGunleadDelivery.hasSerialAndBallistic(itemName)
    if (IllegalLabsAndWarehouse.GUNLABELS[itemName] ~= nil) then
        return true
    end
    return false
end

function IllegalGunleadDelivery.addItemIntoTrunk(order, vehicle)

    local items = order.order_detail
    local vehicleStorageName = GetEntityModel(vehicle) .. "|" .. GetVehicleNumberPlateText(vehicle)

    for index, value in pairs(items) do
        local itemsType = {}
        for i = 1, value.qty, 1 do
            local metadata = {}
            
            if (IllegalGunleadDelivery.hasSerialAndBallistic(index)) then
                metadata = { serial = "~r~NUMERO DE SERIE ILLISIBLE~s~", ballistic =  index .. "-" .. order.id .. "-" .. order.organisation_id .. "-" .. order.property_id .. "-" .. i }
            end
            table.insert(
                itemsType, 
                {
                    id = generateUUIDV2(), 
                    name = index, 
                    metadata = metadata, 
                    label = IllegalLabsAndWarehouse.GetGunLabel(index)
                }
            )
        end
        TriggerServerEvent("rage-reborn:TransfertToStorage", itemsType, index, vehicleStorageName)
    end
end

function IllegalGunleadDelivery.startDelivery(positionStart, positionStartHeading, positionEnd, order)
    IllegalGunleadDelivery.DELIVERY = {}

    local discordChannel = 22
    if (order.property_type == "drug") then
        discordChannel = 21
    end

    vehicleFct.SpawnVehicle(
        "speedo4",
        positionStart,
        positionStartHeading,
        function(vehicle)
           IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE = vehicle
           SetVehicleOnGroundProperly(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE)
           SetEntityAsMissionEntity(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, true, true)
           SetVehicleOnGroundProperly(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE)
           SetVehicleMod(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 11, 2, false)
           SetVehicleMod(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 12, 3, false)
           SetVehicleMod(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 13, 2, false)
           SetVehicleMod(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 15, 2, false)
           ToggleVehicleMod(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 18, 1)
           ToggleVehicleMod(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 22, 1)
           Citizen.InvokeNative(0x06FAACD625D80CAA, IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE)
           IllegalGunleadDelivery.addItemIntoTrunk(order, IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE)
           AddRelationshipGroup("GunleaderDelivery")
           SetRelationshipBetweenGroups(0, GetHashKey("GunleaderDelivery"), 0xA49E591C)
           SetRelationshipBetweenGroups(0, 0xA49E591C, GetHashKey("GunleaderDelivery"))
           IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVER = Atlantiss.World.Ped:Create(5, "s_m_y_blackops_01", vector3(positionStart.x + 1.0, positionStart.y + 1.0, positionStart.z), 0.0)
           IllegalGunleadDelivery.DELIVERY.TRUCK_PASSENGER = Atlantiss.World.Ped:Create(5, "s_m_y_blackops_02", vector3(positionStart.x + 1.0, positionStart.y + 1.0, positionStart.z), 0.0)
           SetPedIntoVehicle(IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVER, IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, -1)
           SetPedIntoVehicle(IllegalGunleadDelivery.DELIVERY.TRUCK_PASSENGER, IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 0)

           local otherCarPosition = GetOffsetFromEntityInWorldCoords(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE,2.5,0.0,0.0)

           vehicleFct.SpawnVehicle(
            "mesa3",
            otherCarPosition,
            positionStartHeading,
            function(vehicle)
                TriggerServerEvent(
                    "atlantiss:sendToDiscord",
                    discordChannel,
                    "[COMMANDE #" .. order.id .. "]\nLe véhicule a été créé.", 
                    "info"
                )
               IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE = vehicle
               SetVehicleOnGroundProperly(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE)
               SetEntityAsMissionEntity(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, true, true)
               SetVehicleOnGroundProperly(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE)
               SetVehicleMod(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 11, 2, false)
               SetVehicleMod(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 12, 3, false)
               SetVehicleMod(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 13, 2, false)
               SetVehicleMod(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 15, 2, false)
               ToggleVehicleMod(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 18, 1)
               ToggleVehicleMod(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 22, 1)
               Citizen.InvokeNative(0x06FAACD625D80CAA, IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE)
               IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_DRIVER = Atlantiss.World.Ped:Create(5, "s_m_y_blackops_01", vector3(otherCarPosition.x + 1.0, otherCarPosition.y + 1.0, otherCarPosition.z), 0.0)
               IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_PASSENGER = Atlantiss.World.Ped:Create(5, "s_m_y_blackops_02", vector3(otherCarPosition.x + 1.0, otherCarPosition.y + 1.0, otherCarPosition.z), 0.0)
               SetPedIntoVehicle(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_DRIVER, IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, -1)
               SetPedIntoVehicle(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_PASSENGER, IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 0)
            end)    


           TaskVehicleDriveToCoord(
               IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVER, 
               IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 
               positionEnd.x, 
               positionEnd.y, 
               positionEnd.z, 
               18.0, 
               0, 
               "mule2", 
               959, 
               1, 
               true
            )

            Wait(1500)

            TaskVehicleDriveToCoord(
               IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_DRIVER, 
               IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 
               positionEnd.x, 
               positionEnd.y, 
               positionEnd.z, 
               18.0, 
               0, 
               "mule2", 
               959, 
               1, 
               true
            )

            SetPedRelationshipGroupHash(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_DRIVER, GetHashKey("GunleaderDelivery"))
            SetPedRelationshipGroupHash(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_PASSENGER, GetHashKey("GunleaderDelivery"))
            SetPedRelationshipGroupHash(IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVER, GetHashKey("GunleaderDelivery"))
            SetPedRelationshipGroupHash(IllegalGunleadDelivery.DELIVERY.TRUCK_PASSENGER, GetHashKey("GunleaderDelivery"))

            IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVING = true
            
            Citizen.CreateThread(
                function()
                    while (IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVING == true) do
                        Wait(500)
                        local buyerPosition = GetEntityCoords(PlayerPedId())
                        distanceToTarget = GetDistanceBetweenCoords(buyerPosition.x, buyerPosition.y, buyerPosition.z, GetEntityCoords(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE).x, GetEntityCoords(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE).y, GetEntityCoords(IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE).z, true)
                        distanceToTarget2 = GetDistanceBetweenCoords(buyerPosition.x - 5.0, buyerPosition.y - 5.0, buyerPosition.z, GetEntityCoords(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE).x, GetEntityCoords(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE).y, GetEntityCoords(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE).z, true)

                        if distanceToTarget2 < 20.0 then
                            TaskVehicleTempAction(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_DRIVER, IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 27, 6000)
                        end
                        
                        if distanceToTarget < 20.0 then
                            TriggerServerEvent(
                                "atlantiss:sendToDiscord",
                                discordChannel,
                                "[COMMANDE #" .. order.id .. "]\nLe véhicule est arrivé à bon port.", 
                                "success"
                            )
                            IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVING = false
                            TaskVehicleTempAction(IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVER, IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 27, 6000)
                            Wait(1000)
                            TaskVehicleTempAction(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_DRIVER, IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 27, 6000)
                            TaskLeaveVehicle(IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVER, IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 256)
                            TaskLeaveVehicle(IllegalGunleadDelivery.DELIVERY.TRUCK_PASSENGER, IllegalGunleadDelivery.DELIVERY.TRUCK_VEHICLE, 256)
                            Wait(1500)
                            ClearPedTasks(IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVER)
                            ClearPedTasks(IllegalGunleadDelivery.DELIVERY.TRUCK_PASSENGER)
                            TaskEnterVehicle(IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVER, IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 5000, 1, 2.0, 1, 0)
                            TaskEnterVehicle(IllegalGunleadDelivery.DELIVERY.TRUCK_PASSENGER, IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 5000, 2, 2.0, 1, 0)
                            Wait(5000)
                            TaskVehicleDriveWander(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_DRIVER, IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, 17.0, 786603)
                            
                            TriggerServerEvent("Atlantiss::SE::World:Entity:Delete", {handle = IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_DRIVER, network_id = NetworkGetNetworkIdFromEntity(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_DRIVER), seconds = 30})
                            TriggerServerEvent("Atlantiss::SE::World:Entity:Delete", {handle = IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_PASSENGER, network_id = NetworkGetNetworkIdFromEntity(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE_PASSENGER), seconds = 30})
                            TriggerServerEvent("Atlantiss::SE::World:Entity:Delete", {handle = IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVER, network_id = NetworkGetNetworkIdFromEntity(IllegalGunleadDelivery.DELIVERY.TRUCK_DRIVER), seconds = 30})
                            TriggerServerEvent("Atlantiss::SE::World:Entity:Delete", {handle = IllegalGunleadDelivery.DELIVERY.TRUCK_PASSENGER, network_id = NetworkGetNetworkIdFromEntity(IllegalGunleadDelivery.DELIVERY.TRUCK_PASSENGER), seconds = 30})
                            TriggerServerEvent("Atlantiss::SE::World:Entity:Delete", {handle = IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE, network_id = NetworkGetNetworkIdFromEntity(IllegalGunleadDelivery.DELIVERY.FLEE_VEHICLE), seconds = 30})
                        end
                    end
                end
            )
        end
    )

    IllegalGunleadDelivery.DELIVERY = {}
    IllegalGunleadDelivery.ORDER = {}
end

-- Handler for instance creation. 
RegisterNetEvent("Atlantiss::Illegal:Gunleader:GetOrder")
AddEventHandler(
    "Atlantiss::Illegal:Gunleader:GetOrder",
    function(phoneNumber)
        IllegalGunleadDelivery.LOADED = false

        TriggerServerCallback("Atlantiss:Illegal:GetWaitingOrderByPhoneNumber", function(order)
            local localOrder =  json.decode(order)
            IllegalGunleadDelivery.CAN_SHIP = true 
            if (localOrder.id == nil) then 
                -- Show Error Message
                ShowAdvancedNotification(
                    "Vitaly",
                    "~b~Dialogue",
                    "~r~~h~Je ne sais pas qui t'a filé ce num, mais j'ai rien pour toi~h~",
                    "CHAR_LESTER_DEATHWISH",
                    1
                )  
                IllegalGunleadDelivery.CAN_SHIP = false
                TriggerServerEvent(
                    "atlantiss:sendToDiscord",
                    22,
                    "A tenté d'appeler un numéro où la commande est déjà en livraison ou livré.", 
                    "error"
                )
            else 
                if (localOrder.delivery_position == nil) then 
                    -- Show Error Message
                    ShowNotification("~r~Erreur #2 : Point de livraison manquant. Veuillez faire un ticket~s~")
                    IllegalGunleadDelivery.CAN_SHIP = false
                    TriggerServerEvent(
                        "atlantiss:sendToDiscord",
                        22,
                        "[ERROR] aucun point de livraison défini pour cette commande. Il faut rembourser.", 
                        "error"
                    )
                end
        
                if (localOrder.order_detail == nil) then 
                    -- Show Error Message
                    ShowNotification("~r~Erreur #3 : Détails de la commande manquant. Veuillez faire un ticket~s~")
                    IllegalGunleadDelivery.CAN_SHIP = false
                    TriggerServerEvent(
                        "atlantiss:sendToDiscord",
                        22,
                        "[ERROR] Le détail de la commande n'existe pas. Il faut rembourser.", 
                        "error"
                    )
                end
            end

            if (IllegalGunleadDelivery.CAN_SHIP) then
                IllegalGunleadDelivery.DELIVERY = {}
                IllegalGunleadDelivery.ORDER = localOrder
            end

            IllegalGunleadDelivery.LOADED = true
        end, phoneNumber)

        while (IllegalGunleadDelivery.LOADED == false) do
            Wait(10)
        end

        if (IllegalGunleadDelivery.CAN_SHIP == true) then
            local ped = LocalPlayer().Ped
            local pedPosition = GetEntityCoords(ped)
            local deliveryPositionDistanceFromPed = GetDistanceBetweenCoords(pedPosition, IllegalGunleadDelivery.ORDER.delivery_position.finish.x, IllegalGunleadDelivery.ORDER.delivery_position.finish.y, IllegalGunleadDelivery.ORDER.delivery_position.finish.z, true)  
            
            if (deliveryPositionDistanceFromPed <= 25.0) then
                ShowAdvancedNotification(
                    "Vitaly",
                    "~b~Dialogue",
                    "~b~~h~Super, t'es en place, mes guetteurs te voient. On arrive dans 1 minute.~h~",
                    "CHAR_LESTER_DEATHWISH",
                    1
                )
                ShowAdvancedNotification(
                    "Vitaly",
                    "~b~Dialogue",
                    "~b~~h~On te laisse le véhicule, tout est dans le coffre. Ne te fais pas péter~h~",
                    "CHAR_LESTER_DEATHWISH",
                    1
                )
                local startPosition = vector3(IllegalGunleadDelivery.ORDER.delivery_position.start.x, IllegalGunleadDelivery.ORDER.delivery_position.start.y, IllegalGunleadDelivery.ORDER.delivery_position.start.z)
                local endPosition = vector3(IllegalGunleadDelivery.ORDER.delivery_position.finish.x, IllegalGunleadDelivery.ORDER.delivery_position.finish.y, IllegalGunleadDelivery.ORDER.delivery_position.finish.z)
    
                IllegalGunleadDelivery.CAN_START = nil
                TriggerServerCallback("Atlantiss:Illegal:OrderCanBeDelivered", function(canDeliver)
                    IllegalGunleadDelivery.CAN_START = canDeliver
                end, IllegalGunleadDelivery.ORDER.id)
        
                while (IllegalGunleadDelivery.CAN_START == nil) do
                    Wait(10)
                end
    
                local discordChannel = 22
                if (IllegalGunleadDelivery.ORDER.property_type == "drug") then
                    discordChannel = 21
                end

                if (IllegalGunleadDelivery.CAN_START == true) then
                    TriggerServerEvent(
                        "atlantiss:sendToDiscord",
                        discordChannel,
                        "[COMMANDE #".. IllegalGunleadDelivery.ORDER.id .."]\nLancement de la livraison.", 
                        "info"
                    )
                    IllegalGunleadDelivery.startDelivery(startPosition, IllegalGunleadDelivery.ORDER.delivery_position.startHeading, endPosition, IllegalGunleadDelivery.ORDER)
                else
                    TriggerServerEvent(
                        "atlantiss:sendToDiscord",
                        discordChannel,
                        "[WARNING][COMMANDE #".. IllegalGunleadDelivery.ORDER.id .."]\nSuspicion de tentative de multiple appel en même temps.", 
                        "error"
                    )
                    ShowNotification("~r~Tentative de multiple appel détecté.\nSignalement réalisé.~s~")
                end
    
            else
                ShowAdvancedNotification(
                    "Vitaly",
                    "~b~Dialogue",
                    "~r~~h~Mes guetteurs te voient pas au point de RDV. Rappelle moi quand tu y seras!~h~",
                    "CHAR_LESTER_DEATHWISH",
                    1
                )
            end
        end
    end
)
