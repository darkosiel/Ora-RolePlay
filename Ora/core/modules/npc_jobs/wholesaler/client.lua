Atlantiss.NpcJobs.Wholesaler.E_Thread = false
Atlantiss.NpcJobs.Wholesaler.Peds = {
    {
        Name = "Hank",
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


function Atlantiss.NpcJobs.Wholesaler.CloseUI()
    if (not Atlantiss.Inventory.State.IsOpen) then
        SendNUIMessage({eventName = "closeWholesalerMenu"})
        SetNuiFocus(false, false)
    end
end

function Atlantiss.NpcJobs.Wholesaler.EnterZone()
    while (Atlantiss.Player.HasLoaded == false) do Wait(50) end
    
    Atlantiss.NpcJobs.Wholesaler.E_Thread = false
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")

    Citizen.CreateThread(
        function()
            while true do
                Wait(0)
                if (IsControlJustPressed(0, Keys["E"])) then
                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        eventName = "openWholesalerMenu", JobItems = Atlantiss.NpcJobs.Wholesaler.ItemsPerJob[Atlantiss.Identity.Job:GetName()],
                        OrgaItems = Atlantiss.NpcJobs.Wholesaler.ItemsPerJob[Atlantiss.Identity.Orga:GetName()],
                        Job = Atlantiss.Identity.Job:Get().label, Orga = Atlantiss.Identity.Orga:Get().label
                    })
                    Atlantiss.NpcJobs.Wholesaler.E_Thread = true
                end

                if (Atlantiss.NpcJobs.Wholesaler.E_Thread == true) then
                    Atlantiss.NpcJobs.Wholesaler.E_Thread = false
                    break
                end
            end
        end
    )
end

function Atlantiss.NpcJobs.Wholesaler.ExitZone()
    Atlantiss.NpcJobs.Wholesaler.E_Thread = true
    Atlantiss.NpcJobs.Wholesaler.CloseUI()
    Hint:RemoveAll()
end


RegisterNUICallback("WholesalerCloseUI", function() Atlantiss.NpcJobs.Wholesaler.CloseUI() end)

RegisterNUICallback(
    "WholeSalerBuy",
    function(data)
        Atlantiss.NpcJobs.Wholesaler.CloseUI()

        if (not Atlantiss.Inventory:CanReceive(data.item, data.count)) then return end
        
        dataonWait = {
            price = data.price * data.count,
            count = data.count,
            title = "Grossiste général",
            fct = function()
                local items = {}
                
                for i=1, data.count do
                    table.insert(items, {name = data.item})
                end

                Atlantiss.Inventory:AddItems(items)
                TriggerServerEvent("Atlantiss::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", data.price * data.count, true)
            end
        }

        TriggerEvent("payWith?")
    end
)


Citizen.CreateThread(
	function()
		while (Atlantiss.Player.HasLoaded == false) do Wait(50) end

        for _, ped in pairs(Atlantiss.NpcJobs.Wholesaler.Peds) do
            Zone:Add(ped.Pos, Atlantiss.NpcJobs.Wholesaler.EnterZone, Atlantiss.NpcJobs.Wholesaler.ExitZone, "", 2.5)
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
