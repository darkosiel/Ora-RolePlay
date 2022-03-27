RegisterNetEvent("Ora::CE::PlayerLoaded")
AddEventHandler(
    "Ora::CE::PlayerLoaded",
    function()
        Ora.State.Initializing = false
    end
)

RegisterNetEvent("Ora::CE::Core:ShowNotification")
AddEventHandler(
    "Ora::CE::Core:ShowNotification",
    function(message)
        ShowNotification(message)
    end
)

RegisterNetEvent("Ora::CE::Core:SendClientInfos")
AddEventHandler(
    "Ora::CE::Core:SendClientInfos",
    function()
        TriggerServerEvent("Ora::SE::Core:SendClientInfos")
    end
)

function Ora.Core:IsInitialized()
    return Ora.State.Initializing == false
end

function Ora.Core:GetItemLabel(itemName)
    if Items ~= nil and Items[itemName] ~= nil and Items[itemName].label ~= nil then
        return Items[itemName].label
    end

    return itemName
end

Citizen.CreateThread(
    function()
        while (Ora.Player.HasLoaded == false) do
            Wait(500)
        end

        TriggerServerEvent("Ora::SE::Core:SendClientInfos")
    end
)

Citizen.CreateThread(function()
    local startTime = GetGameTimer()
    while (Ora.State.Initializing and ((GetGameTimer() - startTime)/1000) < 30) do
        Wait(1000)
        print("Waiting for initializing end")
    end
    Ora.State.Initializing = false
    Ora:InitializeModules()
end)

Citizen.CreateThread(function()
	N_0x170f541e1cadd1de(false)
	NetworkSetFriendlyFireOption(true)

	while true do
		Citizen.Wait(4000)
		for _,i in pairs(GetActivePlayers()) do
			local ped = GetPlayerPed(i)
			if DoesEntityExist(ped) then
				SetCanAttackFriendly(ped, true, true)
			end
		end
	end
end)

Citizen.CreateThread(
    function()
        while true do
            Wait(60000)
            if collectgarbage("count") > 13000 then
                collectgarbage()
            end
        end
    end
)
