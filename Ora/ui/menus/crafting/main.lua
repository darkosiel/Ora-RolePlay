local CraftingRecipe = {
    ["beer"] = {
        ingredient = {
            {name="cereale",amount=1},
            {name="levure",amount=1},

        },
        data = {}
    },
    ["jus_raisin"] = {
        ingredient = {
            {name="raisin",amount=1},

        },
        data = {}
    },
    ["tequila"] = {
        ingredient = {
            {name="agave",amount=1},

        },
        data = {}
    },
    ["rhum"] = {
        ingredient = {
            {name="levure",amount=1},
            {name="c_sucre",amount=1},
            
        },
        data = {}
    },
    ["cognac"] = {
        ingredient = {
            {name="bouteille_vinr",amount=1},
            
        },
        data = {}
    },
    ["vodka"] = {
        ingredient = {
            {name="pommeterre",amount=1},
            {name="cereale",amount=1},
            
        },
        data = {}
    },
    ["whisky"] = {
        ingredient = {
            {name="cereale",amount=1},
            {name="water",amount=1},
            
        },
        data = {}
    },
    ["champagne"] = {
        ingredient = {
            {name="bouteille_vin",amount=1}, --vin
            {name="water",amount=1},
            {name="levure",amount=1},
        },
        data = {}
    },
    ["red_wine"] = {
        ingredient = {
            {name="jus_raisin",amount=1},
            
        },
        data = {}
    },
    ["high_quality_win"] = {
        ingredient = {
            {name="jus_raisin",amount=1},
            {name="raisin",amount=1},
            
        },
        data = {}
    },

}
RMenu.Add('craft', 'main', RageUI.CreateMenu(nil, "Fabriquer un objet",10,200))
RMenu.Add('craft', 'select_anitem', RageUI.CreateSubMenu(RMenu:Get('craft', 'main'),nil, "Objets disponibles",10,200))
local CurrentRecipe = {
    nbrIngredient = 1,
    ingredient = {
        {},

    }
}
local CurrentIndex = nil
RMenu:Get('craft', 'main'):AddInstructionButton({
    [1] = GetControlInstructionalButton(1, 315, 0),
    [2] = "Enlever un ingrédient",
})

RMenu:Get('craft', 'main'):AddInstructionButton({
    [1] = GetControlInstructionalButton(1, 314, 0),
    [2] = "Ajouter un ingrédient",
})
RMenu:Get('craft', 'select_anitem').Closed = function( )
    CurrentIndex = nil
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('craft', 'main')) then
            RageUI.DrawContent({ header = false, glare = false }, function()
                for i = 1 , #CurrentRecipe.ingredient,1 do
                    if CurrentRecipe.ingredient[i].name ~= nil then
                        RageUI.Button(Items[CurrentRecipe.ingredient[i].name].label, nil, { RightLabel = CurrentRecipe.ingredient[i].count }, true, function(_, _, Selected)
                            if Selected then
                                CurrentIndex = i
                            end
                        end, RMenu:Get('craft', 'select_anitem'))
                    else
                        RageUI.Button("Choisir un ingrédient",nil,{},true,function(_,_,Selected)
                            if Selected then
                                
                            end
                        end,RMenu:Get('craft', 'select_anitem'))
                    end

                end
                RageUI.Button("Créer",nil,{},true,function(_,_,Selected)
                    if Selected then
                        
                        for k ,v in pairs(CraftingRecipe) do
                            countCorrect = 0
                            itemToRemove = {}
                            for i=1,#CurrentRecipe.ingredient,1 do
                                local x = CurrentRecipe.ingredient[i]
                                for px=1,#v.ingredient,1 do
                                    local v = v.ingredient[px]
                                    if x.name == v.name and x.count == v.amount then
                                        itemToRemove[v.name] = v.amount
                                        countCorrect = countCorrect + 1
                                    end
                                end
                            end
                            if countCorrect == #v.ingredient then
                                CurrentRecipe.ingredient = {{}}
                                RMenu:Get('craft', 'main').Index = 1
                                items = {name=k,data=v.data}
                                Ora.Inventory:AddItem(items)
                                Citizen.CreateThread(function()
                                    for px=1,#v.ingredient,1 do
                                        for it = 1 , itemToRemove[v.ingredient[px].name] ,1 do
                                            Ora.Inventory:RemoveFirstItem(v.ingredient[px].name)
                                        end
                                    end
                                end)
                                RageUI.Popup({message="Vous avez créé un ~b~" .. Items[k].label})
                                break
                            end
                        end
                    end
                end)
                if IsControlJustPressed(1,314) then
                    
                    table.insert(CurrentRecipe.ingredient,{})
                end
                if IsControlJustPressed(1,315) then
                    if #CurrentRecipe.ingredient > 1 then
                    table.remove( CurrentRecipe.ingredient,CurrentRecipe.nbrIngredient)
                   
                    end
                end
            end, function()
            end)
        end

        if RageUI.Visible(RMenu:Get('craft', 'select_anitem')) then
            RageUI.DrawContent({ header = false, glare = false }, function()
                if tableCount(Ora.Inventory:GetInventory()) == 0 then
                    RageUI.Button("Vide", nil, {}, true, function(_, _, _)
                    end)
                else
                    for k, v in pairs(Ora.Inventory:GetInventory()) do

                            RageUI.Button(Items[k].label, nil, { RightLabel = #v }, true, function(_, _, Selected)
                                if Selected then
                                    if CurrentIndex == nil then
                                        count = KeyboardInput("~b~Combien ?", nil, 25)
                                        count = tonumber(count)
                                        if count ~= nil and count <= #v  then
                                            CurrentRecipe.ingredient[#CurrentRecipe.ingredient] = {name=k,count=count}
                                        end
                                    else
                                        count = KeyboardInput("~b~Combien ?", nil, 25)
                                        count = tonumber(count)
                                        if count ~= nil and count <= #v  then
                                            CurrentRecipe.ingredient[CurrentIndex] = {name=k,count=count}
                                        end
                                    end
                                end
                            end, RMenu:Get('craft', 'main'))
                        
                    end
                end
            end, function()
            end)
        end
    end
end)


function ToggleCraftMenu()
    RageUI.Visible(RMenu:Get('craft', 'main'),not RageUI.Visible(RMenu:Get('craft', 'main')))
end

