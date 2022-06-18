Boss = setmetatable({}, Boss)
local orgas = false
local employes = {}
local BleachingJobs = {"casino", "taxi", "ponsonbys", "mecano", "mecano2", "bennys"}

function OpenBossMenu()
    if (
        Ora.Identity.Job:GetName() ~= "bleacher" and
        (Ora.Identity.Job:IsBoss() or Ora.Identity.Job:IsCoBoss())
    ) then
        orgas = false
        RageUI.Visible(RMenu:Get("personnal", "boss"), not RageUI.Visible(RMenu:Get("personnal", "boss")))
    end
end

function OpenBossOrgaMenu()
    if (
        Ora.Identity.Orga:GetName() ~= "bleacher" and
        (Ora.Identity.Orga:IsBoss() or Ora.Identity.Orga:IsCoBoss())
    ) then
        orgas = true
        RageUI.Visible(RMenu:Get("personnal", "boss"), not RageUI.Visible(RMenu:Get("personnal", "boss")))
    end
end

RMenu.Add(
    "personnal",
    "boss",
    RageUI.CreateMenu("Gestion entreprise", "Actions disponibles", 10, 100, nil, nil, 52, 177, 74, 1.0)
)

RegisterCommand(
    "+booss",
    function()
        OpenBossMenu()
    end,
    false
)
RegisterCommand(
    "-booss",
    function()
        OpenBossMenu()
    end,
    false
)
RegisterCommand(
    "booss",
    function()
        OpenBossMenu()
    end,
    false
)
RegisterKeyMapping("booss", "Menu patron", "keyboard", "F1")

RegisterCommand(
    "+booxss",
    function()
        OpenBossOrgaMenu()
    end,
    false
)
RegisterCommand(
    "-booxss",
    function()
        OpenBossOrgaMenu()
    end,
    false
)
RegisterCommand(
    "booxss",
    function()
        OpenBossOrgaMenu()
    end,
    false
)

RegisterKeyMapping("booxss", "Menu patron organisation", "keyboard", "F9")

Citizen.CreateThread(
    function()
        for i = 1, 255 do
            Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("personnal", "boss")) then
                RageUI.DrawContent(
                    {header = true, glare = true},
                    function()                        
                        RageUI.Button(
                            "Recruter",
                            nil,
                            {},
                            true,
                            function(_, A, Selected)
                                if A then
                                    HoverPlayer()
                                end
                                if Selected then
                                    local player = GetPlayerServerIdInDirection(5.0)
                                    if player then
                                        if orgas then
                                            TriggerPlayerEvent("Ora::CE::Identity:Orga:Set", player, Ora.Identity.Orga:GetName(), 1)
                                        else
                                            TriggerPlayerEvent("Ora::CE::Identity:Job:Set", player, Ora.Identity.Job:GetName(), 1)
                                        end
                                    end
                                end
                            end
                        )

                        RageUI.Button(
                            "Gestion patron",
                            nil,
                            {},
                            true,
                            function(_, Active, Selected)
                                if Selected then
                                    if orgas then
                                        TriggerServerCallback(
                                            "Ora::SVCB::Identity:Orga:GetEmployees",
                                            function(res) TriggerEvent('business:activateMenu', res, false, true, Jobs[Ora.Identity.Orga:GetName()].isSelf) end,
                                            Ora.Identity.Orga:GetName()
                                        )
                                    else
                                        TriggerServerCallback(
                                            "Ora::SVCB::Identity:Job:GetEmployees",
                                            function(res) TriggerEvent('business:activateMenu', res, false, false, Jobs[Ora.Identity.Job:GetName()].isSelf) end,
                                            Ora.Identity.Job:GetName()
                                        )
                                    end
                                end
                            end
                        )

                        --[[if (Ora.Utils:HasValue(BleachingJobs, Ora.Identity.Job:GetName()) or Ora.Utils:HasValue(BleachingJobs, Ora.Identity.Orga:GetName())) then
                            RageUI.Button(
                                "Fausse facture",
                                nil,
                                {},
                                true,
                                function(_, Active, Selected)
                                    if (Selected) then
                                        if orgas then
                                            CreateFakeFacture(orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName())
                                        else
                                            CreateFakeFacture(orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName())
                                        end
                                    end

                                    if (Active) then
                                        HoverPlayer()
                                    end
                                end
                            )
                        end]]
                    end,
                    function()
                    end
                )
            end
        end
    end
)
function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end
