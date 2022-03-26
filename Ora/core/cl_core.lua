RegisterNetEvent("Atlantiss::CE::PlayerLoaded")
AddEventHandler(
    "Atlantiss::CE::PlayerLoaded",
    function()
        Atlantiss.State.Initializing = false
    end
)

RegisterNetEvent("Atlantiss::CE::Core:ShowNotification")
AddEventHandler(
    "Atlantiss::CE::Core:ShowNotification",
    function(message)
        ShowNotification(message)
    end
)

RegisterNetEvent("Atlantiss::CE::Core:SendClientInfos")
AddEventHandler(
    "Atlantiss::CE::Core:SendClientInfos",
    function()
        TriggerServerEvent("Atlantiss::SE::Core:SendClientInfos")
    end
)

function Atlantiss.Core:IsInitialized()
    return Atlantiss.State.Initializing == false
end

function Atlantiss.Core:GetItemLabel(itemName)
    if Items ~= nil and Items[itemName] ~= nil and Items[itemName].label ~= nil then
        return Items[itemName].label
    end

    return itemName
end

Citizen.CreateThread(
    function()
        while (Atlantiss.Player.HasLoaded == false) do
            Wait(500)
        end

        TriggerServerEvent("Atlantiss::SE::Core:SendClientInfos")
    end
)

Citizen.CreateThread(function()
    local startTime = GetGameTimer()
    while (Atlantiss.State.Initializing and ((GetGameTimer() - startTime)/1000) < 30) do
        Wait(1000)
        print("Waiting for initializing end")
    end
    Atlantiss.State.Initializing = false
    Atlantiss:InitializeModules()
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
