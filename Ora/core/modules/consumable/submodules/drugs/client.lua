--[[ local alreadyOnCoke = false

RegisterNetEvent("drug:Coke")
AddEventHandler(
    "drug:Coke",
    function(item, Items)
        if (alreadyOnCoke == false) then
            ShowNotification(
                "~g~Vous avez consommé de la cocaine ! Vous êtes moins sensible a la douleur pendant 5 minutes~w~"
            )
            ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.4)
            StartScreenEffect("Rampage", 1000 * 60 * 5, true)

            local playerPed = PlayerPedId()
            TriggerServerEvent("Ora_status:addOn", "coke")

            StatSetInt(GetHashKey("MP0_STAMINA"), 30, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 30, true)
            SetRunSprintMultiplierForPlayer(player, 1.2)
            SetSwimMultiplierForPlayer(player, 1.2)
            SetPedArmour(playerPed, GetPedArmour(playerPed) + 65)

            alreadyOnCoke = true
            Citizen.Wait(1000 * 60 * 5)
            alreadyOnCoke = false

            StopScreenEffect("Rampage")
            StopGameplayCamShaking(false)

            SetPedArmour(playerPed, GetPedArmour(playerPed) - 65)
            StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 0, true)
            SetRunSprintMultiplierForPlayer(player, 1.0)
            SetSwimMultiplierForPlayer(player, 1.0)
        else
            ShowNotification(
                "~r~Vous avez déjà consommé de la cocaine ! Vous voulez faire une overdose. Vous avez perdu un pochon~w~"
            )
        end
    end
)

local alreadyOnMeth = false

RegisterNetEvent("drug:Meth")
AddEventHandler(
    "drug:Meth",
    function(item, Items)
        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.2)
        StartScreenEffect("ChopVision", 1000 * 60 * 3, true)

        if (alreadyOnMeth == false) then
            ShowNotification(
                "~g~Vous avez consommé de la meth ! Vous êtes moins sensible a la douleur pendant 3 minutes~w~"
            )
            local playerPed = PlayerPedId()
            TriggerServerEvent("Ora_status:addOn", "meth")
            StatSetInt(GetHashKey("MP0_STAMINA"), 20, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 20, true)
            SetRunSprintMultiplierForPlayer(playerPed, 1.1)
            SetSwimMultiplierForPlayer(playerPed, 1.1)
            SetPedArmour(playerPed, GetPedArmour(playerPed) + 45)

            alreadyOnMeth = true
            Citizen.Wait(1000 * 60 * 3)
            alreadyOnMeth = false

            StopScreenEffect("ChopVision")
            StopGameplayCamShaking(false)

            SetPedArmour(playerPed, GetPedArmour(playerPed) - 45)
            StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 0, true)
            SetRunSprintMultiplierForPlayer(playerPed, 1.0)
            SetSwimMultiplierForPlayer(playerPed, 1.0)
        else
            ShowNotification(
                "~r~Vous avez déjà consommé de la meth ! Vous voulez faire une overdose. Vous avez perdu un pochon~w~"
            )
        end
    end
)

local alreadyOnWeed = false

RegisterNetEvent("drug:Weed")
AddEventHandler(
    "drug:Weed",
    function(item, Items)
        local playerPed = PlayerPedId()

        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.2)
        StartScreenEffect("DrugsMichaelAliensFight", 1000 * 60 * 5, true)

        if (alreadyOnWeed == false) then
            TriggerServerEvent("Ora_status:addOn", "weed")

            ShowNotification("~g~Vous avez consommé de la weed !~w~")
            ShowNotification(
                "~g~Vous êtes moins sensible a la douleur pendant 5 minutes mais vous êtes moins rapide~w~"
            )

            StatSetInt(GetHashKey("MP0_STAMINA"), 10, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 10, true)
            SetRunSprintMultiplierForPlayer(playerPed, 0.7)
            SetSwimMultiplierForPlayer(playerPed, 0.7)
            SetPedArmour(playerPed, GetPedArmour(playerPed) + 30)

            alreadyOnWeed = true
            Citizen.Wait(1000 * 60 * 5)
            alreadyOnWeed = false

            StopScreenEffect("DrugsMichaelAliensFight")
            StopGameplayCamShaking(false)

            SetPedArmour(playerPed, GetPedArmour(playerPed) - 30)
            StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
            StatSetInt(GetHashKey("MP0_STRENGTH"), 0, true)
            SetRunSprintMultiplierForPlayer(playerPed, 1.0)
            SetSwimMultiplierForPlayer(playerPed, 1.0)
        else
            ShowNotification(
                "~r~Vous avez déjà consommé de la weed ! Vous voulez faire une overdose. Vous avez perdu un pochon~w~"
            )
        end
    end
) ]]