Ora.NpcJobs.Wholesaler.E_Thread = false
Ora.NpcJobs.Wholesaler.Peds = {
    {
        Name = "Nathan",
        PedModel = "s_m_m_dockwork_01",
        Pos = {x = 1221.03, y = -2991.73, z = 5.86 - 0.98, a = 90.04},
        Blip = {name = "Grossiste Général SUD", color = 47, size = 0.8, sprite = 52}
    },
    {
        Name = "Didier",
        PedModel = "s_m_y_dockwork_01",
        Pos = {x = 2746.93, y = 3466.94, z = 55.67 - 0.98, a = 291.01},
        Blip = {name = "Grossiste Général NORD", color = 47, size = 0.8, sprite = 52},
    }
}


function Ora.NpcJobs.Wholesaler.CloseUI()
    if (not Ora.Inventory.State.IsOpen) then
        SendNUIMessage({eventName = "closeWholesalerMenu"})
        SetNuiFocus(false, false)
    end
end

function Ora.NpcJobs.Wholesaler.EnterZone()
    while (Ora.Player.HasLoaded == false) do Wait(50) end
    
    Ora.NpcJobs.Wholesaler.E_Thread = false
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")

    Citizen.CreateThread(
        function()
            while true do
                Wait(0)
                if (IsControlJustPressed(0, Keys["E"])) then
                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        eventName = "openWholesalerMenu", JobItems = Ora.NpcJobs.Wholesaler.ItemsPerJob[Ora.Identity.Job:GetName()],
                        OrgaItems = Ora.NpcJobs.Wholesaler.ItemsPerJob[Ora.Identity.Orga:GetName()],
                        Job = Ora.Identity.Job:Get().label, Orga = Ora.Identity.Orga:Get().label
                    })
                    Ora.NpcJobs.Wholesaler.E_Thread = true
                end

                if (Ora.NpcJobs.Wholesaler.E_Thread == true) then
                    Ora.NpcJobs.Wholesaler.E_Thread = false
                    break
                end
            end
        end
    )
end

function Ora.NpcJobs.Wholesaler.ExitZone()
    Ora.NpcJobs.Wholesaler.E_Thread = true
    Ora.NpcJobs.Wholesaler.CloseUI()
    Hint:RemoveAll()
end


RegisterNUICallback("WholesalerCloseUI", function() Ora.NpcJobs.Wholesaler.CloseUI() end)

RegisterNUICallback(
    "WholeSalerBuy",
    function(data)
        Ora.NpcJobs.Wholesaler.CloseUI()

        if (not Ora.Inventory:CanReceive(data.item, data.count)) then return end
        
        dataonWait = {
            price = data.price * data.count,
            count = data.count,
            title = "Grossiste général",
            fct = function()
                local items = {}
                
                for i=1, data.count do
                    table.insert(items, {name = data.item})
                end

                Ora.Inventory:AddItems(items)
                TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", data.price * data.count, true)
            end
        }

        TriggerEvent("payWith?")
    end
)


Citizen.CreateThread(
	function()
		while (Ora.Player.HasLoaded == false) do Wait(50) end

        for _, ped in pairs(Ora.NpcJobs.Wholesaler.Peds) do
            Zone:Add(ped.Pos, Ora.NpcJobs.Wholesaler.EnterZone, Ora.NpcJobs.Wholesaler.ExitZone, "", 2.5)
            Ped:Add(ped.Name, ped.PedModel, ped.Pos, nil)

            local blip = AddBlipForCoord(ped.Pos.x, ped.Pos.y, ped.Pos.z)
            SetBlipSprite(blip, ped.Blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, ped.Blip.size)
            SetBlipColour(blip, ped.Blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(ped.Blip.name)
            EndTextCommandSetBlipName(blip)
        end
    end
)
