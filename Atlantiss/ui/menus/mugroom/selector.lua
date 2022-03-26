
RMenu.Add('mugshot', 'selector', RageUI.CreateMenu("", "N/A", 1650 / 1 - (431 / 2) - 100, 1050 / 1 - (431 / 2) - 100))
RMenu:Get('mugshot', 'selector').EnableMouse = false;
RMenu:Get('mugshot', 'selector').Closable = false;
RMenu:Get('mugshot', 'selector').Selectable = false;

RMenu:Get('mugshot', 'selector'):AddInstructionButton({
    [1] = GetControlInstructionalButton(1, 175, 0),
    [2] = "Droite",
})

RMenu:Get('mugshot', 'selector'):AddInstructionButton({
    [1] = GetControlInstructionalButton(1, 174, 0),
    [2] = "Gauche",
})

function OpenMenuSelector()
  --  RageUI.Visible(RMenu:Get('mugshot', 'selector'), true)

    TriggerServerEvent('mugroom:SelectedPlayer', MenuValue.UUID)
end

function DrawMenuSelector(MenuValue)
    if RageUI.Visible(RMenu:Get('mugshot', 'selector')) then
        RageUI.DrawContent({ header = false, glare = false }, function()
            --- Items

            RMenu:Get('mugshot', 'selector'):SetSubtitle(MenuValue.Roleplay.FirstName .. " " .. MenuValue.Roleplay.LastName)

            RageUI.Button("Identité", nil, { RightLabel = MenuValue.Roleplay.FirstName .. " " .. MenuValue.Roleplay.LastName }, true, function(Hovered, Active, Selected)

            end)
            RageUI.Button("Sexe", nil, { RightLabel = MenuValue.Roleplay.Sex }, true, function(Hovered, Active, Selected)

            end)
            RageUI.Button("Métier", nil, { RightLabel = Jobs[MenuValue.Roleplay.Jobs].label }, true, function(Hovered, Active, Selected)

            end)
            RageUI.Button("Banque", nil, { RightLabel = MenuValue.Roleplay.BankAmount .. " $" }, true, function(Hovered, Active, Selected)

            end)

            if not MenuValue.Locked then
                RageUI.Button("Sélectionner ce personnage", nil, { Color = {
                    BackgroundColor = { 0, 120, 0, 25 }
                } }, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExitPedFormRoom()
                        onSelectorTick.Controls = false
                        onSelectorTick.RageUI = false
                        RageUI.Visible(RMenu:Get('mugshot', 'selector'), false)
                        Citizen.Wait(6000)
                        
                        DoScreenFadeIn(1000)
                        TriggerServerEvent('mugroom:SelectedPlayer', MenuValue.UUID)
                    end
                end)
            end
        end, function()
            --- Panel
        end)
    end
end
