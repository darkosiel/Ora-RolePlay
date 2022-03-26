local function InitGames()
    if (ifModuleLoaded("Player")) then
        Atlantiss.Player:SetEntityInvicible(PlayerId(), PlayerPedId(), true)
    end

    TriggerServerCallback("Atlantiss::SE::Anticheat:RegisterPeds", 
        function()
            FreezePlayer(PlayerId(), true)
            DoScreenFadeOut(100)
            LoadingPrompt("Chargement", 4)
            Streaming:Model("mp_f_freemode_01")
            Streaming:Model("mp_m_freemode_01")
            TriggerServerCallback('spawned:requestData', function(ActiveCharacter, ActionID, Table, Identity, Jobs, Users)
                --(("ActionID : %s"):format(ActionID))
                if (ActiveCharacter) then
                    if (ActionID == 0 and Table ~= nil) then
                        TriggerEvent('spawnhandler:LoadCharacter', Table, Identity, Jobs, Users)
                    end
                else
                    if (ActionID == 1 and Table ~= nil) then
                        TriggerEvent('spawnhandler:CharacterSelector', Table, Identity, Jobs, Users)
                    end
                    if (ActionID == 2) then
                        TriggerEvent('spawnhandler:CharacterCreator', Table)
                    end
                end
            end)
        end,
        {GetHashKey("mp_m_freemode_01"), GetHashKey("mp_f_freemode_01")}
    )
end

RegisterNetEvent("Atlantiss::CE::Game:InitGames")
AddEventHandler("Atlantiss::CE::Game:InitGames", function() InitGames() end)


local firstSpawn = true
AddEventHandler('playerSpawned', function(spawnInfo)
    if (firstSpawn) then
        InitGames()
        exports.spawnmanager:setAutoSpawn(false)
        firstSpawn = false
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    InitGames()
    --('The resource ' .. resourceName .. ' has been started.')
end)

RegisterCommand("InitGames", function(source, args, rawCommand)
    if (Atlantiss.Anticheat:IsAnticheatWhitelist()) then
        InitGames()
    else
        ShowNotification("~r~Cette commande n'est pas disponible. Faites un report pour demander une réinitialisation~s~")
    end
end)