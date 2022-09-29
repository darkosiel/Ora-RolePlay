local washudoff = false
local pedInVeh = false

--																			FUNCTIONS

local function HideInventory()
    if currentStorage and currentStorage.name ~= nil then currentStorage = {} end
    SetNuiFocus(false, false)
	Ora.Inventory.State.IsOpen = false
    if not washudoff then exports["Ora_utils"]:SetPlayerHUD(true) end
end

local function OpenInventory()
    Ora.Inventory:RefreshWeight()
    if pedInVeh then
        local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
        if veh ~= 0 then
            currentStorage = Storage.New(
                GetEntityModel(veh) .. "|" .. 
                    GetVehicleNumberPlateText(veh) .. 
                        " b-a-g", 
                2
            )
            while currentStorage == nil do
                Wait(1)
            end
            currentStorage:Visible(true)
            currentStorage:RefreshDB()
            currentStorage:RefreshWeight()
        else
            ShowNotification("Une erreur s'est produite ! Veuillez réessayer. Si le problème persiste, contactez un développeur.")
        end
    else
        if not exports["Ora_utils"]:GetPlayerHUD() then
            washudoff = true
        else
            exports["Ora_utils"]:SetPlayerHUD(false)
            washudoff = false
        end
        SetNuiFocus(true, true)
        SendNUIMessage({
            eventName = "showInventory", eventData = Ora.Inventory.Data, invWeight = Ora.Inventory.Weight, 
            weapons = Ora.Inventory:GetWeapons(), bars = exports['Ora_utils'].GetPlayerBars()
        })
    end
end


local function RefreshSto()
    SetNuiFocus(true, true)
    Storage:RefreshWeight()
    Ora.Inventory:RefreshWeight()
    SendNUIMessage({
        eventName = "showInventory", eventData = Ora.Inventory.Data, invWeight = Ora.Inventory.Weight, 
        weapons = Ora.Inventory:GetWeapons(), target = currentStorage.items, targWeight = {round(currentStorage.Weight), currentStorage.maxWeight},
        bars = exports['Ora_utils'].GetPlayerBars()
    })
end

local function Refresh()
    if currentStorage and currentStorage.name ~= nil then return RefreshSto() end
    Ora.Inventory:RefreshWeight()
    SetNuiFocus(true, true)
    if pedInVeh then
        local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
        currentStorage = Storage.New(
            GetEntityModel(veh) .. "|" .. 
                GetVehicleNumberPlateText(veh) .. 
                    " b-a-g", 
            2
        )
        while currentStorage == nil do
            Wait(1)
        end
        currentStorage:Visible(true)
        currentStorage:RefreshDB()
        currentStorage:RefreshWeight()
        SendNUIMessage({
            eventName = "showInventory", eventData = Ora.Inventory.Data, invWeight = Ora.Inventory.Weight, 
            weapons = Ora.Inventory:GetWeapons(), target = currentStorage.items, targWeight = {round(currentStorage.Weight), currentStorage.maxWeight},
            bars = exports['Ora_utils'].GetPlayerBars()
        })
    else
        SendNUIMessage({
            eventName = "showInventory", eventData = Ora.Inventory.Data, invWeight = Ora.Inventory.Weight, weapons = Ora.Inventory:GetWeapons(),
            bars = exports['Ora_utils'].GetPlayerBars()
        })
    end
end

local function RefreshStealing(closestPly)
    Ora.Inventory:RefreshWeight()
    TriggerServerCallback(
        "getInventoryOtherPPL",
        function(Inv, Money, black_money)
            currPlayerInv = json.decode(Inv)
            TriggerEvent('Ora:inventoryFouille', currPlayerInv)
            SetNuiFocus(true, true)
            SendNUIMessage({
                eventName = "showInventory", eventData = Ora.Inventory.Data, invWeight = Ora.Inventory.Weight, 
                weapons = Ora.Inventory:GetWeapons(), target = currPlayerInv, targWeight = {Ora.Inventory:GetTargetWeight(currPlayerInv), 40}, snoupix = true,
                bars = exports['Ora_utils'].GetPlayerBars()
            })
        end,
        closestPly
    )
end

local function OpenInvStorage()
    if not exports["Ora_utils"]:GetPlayerHUD() then
        washudoff = true
    else
        exports["Ora_utils"]:SetPlayerHUD(false)
        washudoff = false
    end
    Ora.Inventory.State.IsOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        eventName = "showInventory", eventData = Ora.Inventory.Data, invWeight = Ora.Inventory.Weight, 
        weapons = Ora.Inventory:GetWeapons(), target = currentStorage.items, targWeight = {round(currentStorage.Weight), currentStorage.maxWeight},
        bars = exports['Ora_utils'].GetPlayerBars()
    })
end

local function Fouilling(targetInv)
    if not exports["Ora_utils"]:GetPlayerHUD() then
        washudoff = true
    else
        exports["Ora_utils"]:SetPlayerHUD(false)
        washudoff = false
    end
    Ora.Inventory.State.IsOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        eventName = "showInventory", eventData = Ora.Inventory.Data, invWeight = Ora.Inventory.Weight, 
        weapons = Ora.Inventory:GetWeapons(), target = targetInv, targWeight = {Ora.Inventory:GetTargetWeight(targetInv), 40}, snoupix = true,
        bars = exports['Ora_utils'].GetPlayerBars()
    })
end

local function IsAWeapon(name)
    if Items[name] then
        if Items[name].category == "weapon" then
            return true
        else
            return false
        end
    else
        error('Cet item "'..name..'" n\'a pas de catégorie indexée, merci de contacter Snoupix.')
        return false
    end
end

local function DeleteIfWeapon(item)
    if item and item.name then
        if IsAWeapon(item.name) then
            for i=1, #(Ora.Inventory:GetWeapons()) do
                if Ora.Inventory:GetWeapons()[i] and Ora.Inventory:GetWeapons()[i].id == item.id then
                    for k, v in pairs(Ora.Inventory:GetInventory()[item.name]) do
                        if v.id == item.id and v.data then
                            Ora.Inventory.Data[item.name][k].data.equipedSlot = 0
                        end
                    end
                    Ora.Inventory:SetWeapon(nil, i)
                end
            end
            Wait(50)
            Ora.Inventory:Save()
        end
    end
end

---@param message String
---@param theme String optional => 'white' or 'warning' -> yellow or 'error' -> red or nothing -> black
local function ShowNotif(message, theme)
    if message ~= "" and message ~= nil then
        SendNUIMessage({eventName = "showNotification", eventData = {message, theme}})
    end
end

local function HoverPlayer(ply)
	local player = ply
	player = GetPlayerPed(player)
	local coords = GetEntityCoords(player)
	local x, y, z = table.unpack(coords)
	DrawMarker(2, x, y, z + 1.0, 0, 0, 0, 180.0, nil, nil, 0.15, 0.15, 0.15, 52, 177, 74, 255, false, true, 2, true)
end

local notifId

local function showNotificationForWeapon(weaponData, isEquiped)
    if (weaponData ~= nil and weaponData.name ~= nil) then
        
        if notifId ~= nil then
            ThefeedRemoveItem(notifId)
        end
        if (isEquiped == false) then
            notifId = ShowNotification(string.format("Vous avez équipé votre ~h~~g~%s~h~~s~", Items[weaponData.name].label))
        else
            if Ora.Inventory.CurrentWeapon.Label == weapon_name[weaponData.name] then
                notifId = ShowNotification(string.format("Vous rangez votre ~h~~g~%s~h~~s~", Items[weaponData.name].label))
            else
                notifId = ShowNotification(string.format("Vous sortez votre ~h~~g~%s~h~~s~", Items[weaponData.name].label))
            end
        end

        local tempId = notifId
        Citizen.SetTimeout(1500, function()
            if notifId == tempId then
                notifId = nil
                ThefeedRemoveItem(tempId)
            end
        end)
    end
end


--																			  EVENTS

RegisterNetEvent('Ora:openInventory')
RegisterNetEvent('Ora:hideInventory')
RegisterNetEvent('Ora:openInvStorage')
RegisterNetEvent('Ora:InvNotification')
RegisterNetEvent('Ora:inventoryFouille')
RegisterNetEvent('Ora:refreshStorage')
RegisterNetEvent('Ora:inventory:deleteIfWeapon')

AddEventHandler('Ora:openInventory', function() OpenInventory() end)
AddEventHandler('Ora:hideInventory', function() SendNUIMessage({eventName = "hideInventory"}) end)
AddEventHandler('Ora:openInvStorage', function() OpenInvStorage() end)
AddEventHandler('Ora:InvNotification', function(message, theme) ShowNotif(message, theme) end)
AddEventHandler('Ora:inventoryFouille', function(targetInv) Fouilling(targetInv) end)
AddEventHandler('Ora:refreshStorage', function() RefreshSto() end)
AddEventHandler('Ora:inventory:deleteIfWeapon', function(item) DeleteIfWeapon(item) end)

--																			NUICALLBACKS

RegisterNUICallback('ShowInvNotification', function(data)
    local args = data.args
    if #args == 2 then
        ShowNotif(args[1], args[2])
    end
end)

RegisterNUICallback('hideInventory', function() HideInventory() end)

RegisterNUICallback('DeleteWeapon', function(data)
    DeleteIfWeapon(data.itemData)
    Refresh()
end)

RegisterNUICallback('UpdateWeapon', function(data)
    if not data or not data.itemData then return error("L'item utilisé est cassé, veuillez contacter un membre du staff.") end
    if not IsAWeapon(data.itemData.name) then return end

    Ora.Inventory:SetWeapon(data.itemData, data.number)
    Refresh()
end)

RegisterNUICallback('inventoryInteraction', function(data)
    if not data or not data.itemData then return error("L'item utilisé est cassé, veuillez contacter un membre du staff.") end

    if data.eventName == "useInventory" then
        if IsAWeapon(data.itemData.name) then return end
        Ora.Inventory:UseItem(data.itemData)
        if (
            Items[data.itemData.name].category ~= "clothes" and
            Items[data.itemData.name].category ~= "consumable" and
            data.itemData.name ~= "sac" and
            data.itemData.name ~= "mask" and
            data.itemData.name ~= "access" and
            data.itemData.name ~= "bank_card" and
            data.itemData.name ~= "speaker" and
            data.itemData.name ~= "molotovartisanal" and
            data.itemData.name ~= "allumette" and
            data.itemData.name ~= "roadwheels" and
            data.itemData.name ~= "driftwheels" and
            data.itemData.name ~= "crochetage"
        ) then
            Refresh()
        end
    elseif data.eventName == "giveInventory" then
		Citizen.CreateThread(function()
			local index = 1
            while true do
                Citizen.Wait(0)
                DrawTopNotification("~INPUT_CELLPHONE_LEFT~ / ~INPUT_CELLPHONE_RIGHT~ : Pour changer de joueur~n~~INPUT_FRONTEND_RDOWN~ : Pour valider l'échange~n~~INPUT_FRONTEND_RRIGHT~ : Pour annuler l'échange")

                local aroundPlayers = GetActivePlayers()
                local maxAroundPlayers = #aroundPlayers
				local v = aroundPlayers[index]
				if NetworkIsPlayerActive(v) and GetPlayerPed(v) ~= PlayerPedId() then
                    local pedCoords = GetEntityCoords(GetPlayerPed(v))
                    if #(GetEntityCoords(PlayerPedId()) - pedCoords) < 6.5 then
                        HoverPlayer(v)
                    else
                        index = index + 1
                    end
                else
                    index = index + 1
				end

                if (index > maxAroundPlayers) then
                    index = 1
                end


                if IsControlJustPressed(0, 191) then
                    if v ~= nil and v ~= false and v ~= 0 and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(v)), true) < 6.5 then
                        loadAnimDict("mp_common")
                        TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_b", 5.0, 1.0, 0.8, 48, 0.0, 0, 0, 0)
                        if IsAWeapon(data.itemData.name) then exports['Ora_utils']:sendME('* L\'individu donne une arme à un autre individu. *') end
                        DeleteIfWeapon(data.itemData)
                        Ora.Inventory:GiveItemToPlayer(v, data.itemData, data.amount)
                        Refresh()
						break
                    else
                        RageUI.Popup({message = "~r~Aucun joueur détecté"})
                        ShowNotif('Aucun joueur détecté', 'error')
                        Refresh()
						break
					end
				end
				if IsControlJustPressed(0, 194) then
                    ShowNotif('Transaction joueur à joueur annulée', 'warning')
                    Refresh()
					break
				end

				if IsControlJustPressed(0, 174) then
                    if (index + 1 > maxAroundPlayers) then
                        index = 1
                    end

					if aroundPlayers[index + 1] ~= nil then
						index = index + 1
					else
						index = 1
					end
				end

                if IsControlJustPressed(0, 175) then
					if (index - 1 < 1) then
                        index = maxAroundPlayers
                    end

					if aroundPlayers[index - 1] ~= nil then
						index = index - 1
					else
						index = maxAroundPlayers
					end
				end
            end
        end)
    elseif data.eventName == "throwInventory" then
        local toDrop = {}
        for it, itarr in pairs(Ora.Inventory.Data) do
            if it == data.itemData.name then
                for idx, itemtodrop in pairs(itarr) do
                    if itemtodrop.label == data.itemData.label then
                        for i = 0, tonumber(data.amount)-1 do
                            if itarr[idx+i] then
                                table.insert(toDrop, itarr[idx+i])
                                if itarr[idx+i].name == "tel" then
                                    MyNumber = nil
                                    MyBattery = 0
                                    -- OraPhone
                                    -- TriggerEvent("OraPhone:client:phone_active", false)
                                end
                            end
                        end
                        break
                    end
                end
            end
        end
        for i=1, #toDrop do
            DeleteIfWeapon(toDrop[i])
        end
        if IsAWeapon(data.itemData.name) then exports['Ora_utils']:sendME('* L\'individu jette une arme par terre. *') end
        Ora.Inventory:Throw(toDrop)
        Refresh()
        toDrop = {}
    elseif data.eventName == "infoInventory" then
        Ora.Inventory:Infos(data.itemData)
    elseif data.eventName == "renameItem" then
        Ora.Inventory:Rename(data.itemData)
        SetNuiFocus(true, true)
        Refresh()
    elseif data.eventName == "renameAllItems" then
        Ora.Inventory:RenameAll(data.itemData)
        SetNuiFocus(true, true)
        Refresh()
    elseif data.eventName == "weaponOne" then
        if IsAWeapon(data.itemData.name) then
            ShowNotif('Vous avez équipé une arme', 'success')
            showNotificationForWeapon(data.itemData, false)
            Ora.Inventory:SetWeapon(data.itemData, 1)
            Ora.Inventory:Save(true)
            Refresh()
        end
    elseif data.eventName == "weaponTwo" then
        if IsAWeapon(data.itemData.name) then
            ShowNotif('Vous avez équipé une arme', 'success')
            showNotificationForWeapon(data.itemData, false)
            Ora.Inventory:SetWeapon(data.itemData, 2)
            Ora.Inventory:Save(true)
            Refresh()
        end
    elseif data.eventName == "weaponThree" then
        if IsAWeapon(data.itemData.name) then
            ShowNotif('Vous avez équipé une arme', 'success')
            showNotificationForWeapon(data.itemData, false)
            Ora.Inventory:SetWeapon(data.itemData, 3)
            Ora.Inventory:Save(true)
            Refresh()
        end
    end
end)

RegisterNUICallback('InventoryToTarget', function(data)    
    if not data or not data.itemData then return error("L'item utilisé est cassé, veuillez contacter un membre du staff.") end

    if Storage:CanAcceptItem(data.itemData.name, data.amount) then
        for k, v in pairs(Ora.Inventory.Data) do
            if k == data.itemData.name then
                for i = 1, data.amount do
                    DeleteIfWeapon(Ora.Inventory.Data[data.itemData.name][i])
                end
            end
        end
        Storage:TransferToStorage(tonumber(data.amount), data.itemData)
        --Wait(1000) -- Wait time to refresh storage, avoid duplications
        RefreshSto()
    end
end)

RegisterNUICallback('TargetToInventory', function(data)
    if not data or not data.itemData then return error("L'item utilisé est cassé, veuillez contacter un membre du staff.") end

    if data.snoupix then -- fouille
        if Ora.Inventory:CanReceive(data.itemData.name, data.amount) then
            local closestPly = GetPlayerServerIdInDirection(5.0)
            if closestPly then
                local canContinue = true
                if (math.tointeger(data.amount) > 1) then
                    ShowNotif("Il n'est pas possible de voler plus d'un item à la fois.", 'error')
                    RefreshStealing(closestPly)
                else
                    local hasBeenStolen = Ora.Inventory:StealFromPlayer(closestPly, data.itemData, data.amount)

                    if (hasBeenStolen) then
                        Ora.Inventory:AddItem({name = data.itemData.name, id = data.itemData.id, data = data.itemData.data, label = data.itemData.label})
                        TriggerServerEvent(
                            "Ora:sendToDiscord",
                            2,
                            Ora.Identity:GetMyName() ..
                                " a volé " ..
                                    data.amount ..
                                        " x " ..
                                            Items[data.itemData.name].label ..
                                                " a " .. 
                                                    Ora.Identity:GetFullname(closestPly)
                        )
                        ShowNotif("Vous avez volé ".. data.amount .." x "..Items[data.itemData.name].label)
                        RefreshStealing(closestPly)
                    else
                        ShowNotif("Cette personne n'a pas autant d'item sur elle.", 'error')
                        RefreshStealing(closestPly)
                    end
                end
            else
                SendNUIMessage({eventName = "hideInventory"})
                RageUI.Popup({message = "~r~Aucune personne détectée en face de vous"})
            end
        end
    else
        if Ora.Inventory:CanReceive(data.itemData.name, data.amount) then
            Storage:TransferToInventory(tonumber(data.amount), data.itemData)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        HideHudComponentThisFrame(19)
        HudWeaponWheelIgnoreSelection()
    end
end)

Citizen.CreateThread(function()
	Wait(500)
	while true do
        Wait(0)
        HideHudComponentThisFrame(19)
		HudWeaponWheelIgnoreSelection()

        if (Ora.Inventory.State.IsOpen) then
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 25, true)
			for i = 0, 5 do
				DisableControlAction(0, i, true)
			end
            HideHudAndRadarThisFrame()
        else
            if GetVehiclePedIsIn(LocalPlayer().Ped) ~= 0 then
                local class = GetVehicleClass(GetVehiclePedIsIn(LocalPlayer().Ped))
                if class ~= 16 and class ~= 8 and class ~= 21 and class ~= 13 then
                    pedInVeh = true
                else
                    pedInVeh = false
                    if currentStorage ~= nil and currentStorage.name ~= nil and string.match(currentStorage.name, "b-a-g") then
                        currentStorage = {}
                    end
                end
            else
                pedInVeh = false
            end
        end

        if (IsControlJustPressed(0, Keys['1'])) then
            if Ora.Inventory.weaponONE and GetVehiclePedIsIn(LocalPlayer().Ped) == 0 then
                showNotificationForWeapon(Ora.Inventory.weaponONE, true)
                Ora.Inventory:UseItem(Ora.Inventory.weaponONE)
                Ora.World.Weapon:PlayAnimationForWeapon(GetHashKey(weapon_name[Ora.Inventory.weaponONE.name]))
            end
        end

        if (IsControlJustPressed(0, Keys['2'])) then
            if Ora.Inventory.weaponTWO and GetVehiclePedIsIn(LocalPlayer().Ped) == 0 then
                showNotificationForWeapon(Ora.Inventory.weaponTWO, true)
                Ora.Inventory:UseItem(Ora.Inventory.weaponTWO) 
                Ora.World.Weapon:PlayAnimationForWeapon(GetHashKey(weapon_name[Ora.Inventory.weaponTWO.name]))
            end
        end

        if (IsControlJustPressed(0, Keys['3'])) then
            if Ora.Inventory.weaponTHREE and GetVehiclePedIsIn(LocalPlayer().Ped) == 0 then
                showNotificationForWeapon(Ora.Inventory.weaponTHREE, true)
                Ora.Inventory:UseItem(Ora.Inventory.weaponTHREE) 
                Ora.World.Weapon:PlayAnimationForWeapon(GetHashKey(weapon_name[Ora.Inventory.weaponTHREE.name]))
            end
        end
	end
end)

KeySettings:Add(
	'keyboard',
	'TAB',
    function()
        if (
            (LocalPlayer().Handcuff == true) or
            (Ora.Health.State.IS_DEAD == true) or
            (Ora.Health.State.IS_WOUNDED == true) or
            (Ora.Player.HasLoaded == false)
        ) then
            return RageUI.Popup({message = 'Vous ne pouvez pas faire ça !'})
        end

		if (Ora.Inventory.State.IsOpen) then
			HideInventory()
		else
			OpenInventory()
			Ora.Inventory.State.IsOpen = true
		end
	end,
	"Ouvrir/Fermer l'inventaire"
)
