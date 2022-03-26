---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 29/08/2019 00:08
---

RMenu.Add(
    "personnal",
    "main",
    RageUI.CreateMenu("ORA", "Actions disponibles", 10, 200, nil, nil, 52, 177, 74, 1.0)
)

--RMenu.Add('personnal', 'inventory', RageUI.CreateMenu("atlantiss", "Actions disponibles"))

--RMenu.Add('personnal', 'inventory', RageUI.CreateMenu("atlantiss", "Actions disponibles"))

Citizen.CreateThread(
    function()
        local myGroup = Atlantiss.Identity:GetMyGroup()
        while true do
            Wait(1)

            if RMenu:Get("personnal", "settings").CinemaMode then
                DrawRect(0.471, 0.06, 1.065, 0.13, 0, 0, 0, 255)
                DrawRect(0.503, 0.935, 1.042, 0.13, 0, 0, 0, 255)
                HideHudComponentThisFrame(7)
                HideHudComponentThisFrame(8)
                HideHudComponentThisFrame(9)
                HideHudComponentThisFrame(6)
            --HideHudComponentThisFrame(19)
            --HideHudAndRadarThisFrame()
            end

            if RageUI.Visible(RMenu:Get("personnal", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = true},
                    function()
                        RageUI.Button(
                            "Animations",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    if LocalPlayer().Handcuff then
                                        CloseAllMenus()
                                        ShowNotification("~r~Vous ne pouvez pas faire ça")
                                    end
                                end
                            end,
                            RMenu:Get("personnal", "animations")
                        )

                        RageUI.Button(
                            "Actions",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    if LocalPlayer().Handcuff then
                                        CloseAllMenus()
                                        ShowNotification("~r~Vous ne pouvez pas faire ça")
                                    end
                                end
                            end,
                            RMenu:Get("personnal", "actions")
                        )

                        RageUI.Button(
                            "Informations",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                end
                            end,
                            RMenu:Get("personnal", "infos")
                        )

                        RageUI.Button(
                            "Paramètres",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("personnal", "settings")
                        )
                        if GetVehiclePedIsIn(PlayerPedId()) ~= 0 then
                            RageUI.Button(
                                "Véhicule",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                end,
                                RMenu:Get("personnal", "vehicule")
                            )
                        end
                        if myGroup == "superadmin" or myGroup == "animator" then
                            RageUI.Button(
                                myGroup == "superadmin" and "Administration" or "Droits d'animation",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                end,
                                RMenu:Get("personnal", "admin")
                            )
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)

function GetGroup()
    return Atlantiss.Identity:GetMyGroup()
end

function OpenPersonnalMenu()
    RageUI.Visible(RMenu:Get("personnal", "main"), not RageUI.Visible(RMenu:Get("personnal", "main")))
end

RegisterCommand(
    "+personnal",
    function()
        OpenPersonnalMenu()
    end,
    false
)
RegisterCommand(
    "-personnal",
    function()
        OpenPersonnalMenu()
    end,
    false
)
RegisterCommand(
    "personnal",
    function()
        OpenPersonnalMenu()
    end,
    false
)
RegisterKeyMapping("personnal", "Menu personnel", "keyboard", "F5")
