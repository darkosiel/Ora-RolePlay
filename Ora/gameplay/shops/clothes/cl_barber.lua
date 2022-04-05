local Shops_Barber = {
     Pos = {
        {x = -814.308,  y = -183.823,  z = 36.568},
        {x = 136.826,   y = -1708.373, z = 28.291},
        {x = -1282.604, y = -1116.757, z = 5.990},
        {x = 1931.513,  y = 3729.671,  z = 31.844},
        {x = 1212.840,  y = -473.921,  z = 65.450},
        {x = -32.885,   y = -152.319,  z = 56.076},
        {x = -278.077,  y = 6228.463,  z = 30.695},
     }
}
Colors = {
    {22, 19, 19}, -- 0
    {30, 28, 25}, -- 1
    {76, 56, 45}, -- 2
    {69, 34, 24}, -- 3
    {123, 59, 31}, -- 4
    {149, 68, 35}, -- 5
    {165, 87, 50}, -- 6
    {175, 111, 72}, -- 7
    {159, 105, 68}, -- 8
    {198, 152, 108}, -- 9
    {213, 170, 115}, -- 10
    {223, 187, 132}, -- 11
    {202, 164, 110}, -- 12
    {238, 204, 130}, -- 13
    {229, 190, 126}, -- 14
    {250, 225, 167}, -- 15
    {187, 140, 96}, -- 16
    {163, 92, 60}, -- 17
    {144, 52, 37}, -- 18
    {134, 21, 17}, -- 19
    {164, 24, 18}, -- 20
    {195, 33, 24}, -- 21
    {221, 69, 34}, -- 22
    {229, 71, 30}, -- 23
    {208, 97, 56}, -- 24
    {113, 79, 38}, -- 25
    {132, 107, 95}, -- 26
    {185, 164, 150}, -- 27
    {218, 196, 180}, -- 28
    {247, 230, 217}, -- 29
    {102, 72, 93}, -- 30
    {162, 105, 138}, -- 31
    {171, 174, 11}, -- 32
    {239, 61, 200}, -- 33
    {255, 69, 152}, -- 34
    {255, 178, 191}, -- 35
    {12, 168, 146}, -- 36
    {8, 146, 165}, -- 37
    {11, 82, 134}, -- 38
    {118, 190, 117}, -- 39
    {52, 156, 104}, -- 40
    {22, 86, 85}, -- 41
    {152, 177, 40}, -- 42
    {127, 162, 23}, -- 43
    {241, 200, 98}, -- 44
    {238, 178, 16}, -- 45
    {224, 134, 14}, -- 46
    {247, 157, 15}, -- 47
    {243, 143, 16}, -- 48
    {231, 70, 15}, -- 49
    {255, 101, 21}, -- 50
    {254, 91, 34}, -- 51
    {252, 67, 21}, -- 52
    {196, 12, 15}, -- 53
    {143, 10, 14}, -- 54
    {44, 27, 22}, -- 55
    {80, 51, 37}, -- 56
    {98, 54, 37}, -- 57
    {60, 31, 24}, -- 58
    {69, 43, 32}, -- 59
    {8, 10, 14}, -- 60
    {212, 185, 158}, -- 61
    {212, 185, 158}, -- 62
    {213, 170, 115}, -- 63
}
beardAmount = {}
for i=0,28 do
    table.insert(beardAmount, {Name = i, Value = i})
end
ap = {
    GetLabelText("CC_LIPSTICK_0"),
    GetLabelText("CC_LIPSTICK_1"),
    GetLabelText("CC_LIPSTICK_2"),
    GetLabelText("CC_LIPSTICK_3"),
    GetLabelText("CC_LIPSTICK_4"),
    GetLabelText("CC_LIPSTICK_5"),
    GetLabelText("CC_LIPSTICK_6"),
    GetLabelText("CC_LIPSTICK_7"),
    GetLabelText("CC_LIPSTICK_8"),
    GetLabelText("CC_LIPSTICK_9")
    }
    ppp = {
        GetLabelText("CC_MKUP_0"),
        GetLabelText("CC_MKUP_1"),
        GetLabelText("CC_MKUP_2"),
        GetLabelText("CC_MKUP_3"),
        GetLabelText("CC_MKUP_4"),
        GetLabelText("CC_MKUP_5"),
        GetLabelText("CC_MKUP_6"),
        GetLabelText("CC_MKUP_7"),
        GetLabelText("CC_MKUP_8"),
        GetLabelText("CC_MKUP_9"),
        GetLabelText("CC_MKUP_10"),
        GetLabelText("CC_MKUP_11"),
        GetLabelText("CC_MKUP_12"),
        GetLabelText("CC_MKUP_13"),
        GetLabelText("CC_MKUP_14"),
        GetLabelText("CC_MKUP_15"),
        GetLabelText("CC_MKUP_16"),
        GetLabelText("CC_MKUP_17"),
        GetLabelText("CC_MKUP_18"),
        GetLabelText("CC_MKUP_19"),
        GetLabelText("CC_MKUP_20"),
        GetLabelText("CC_MKUP_21"),
        GetLabelText("CC_MKUP_26"),
        GetLabelText("CC_MKUP_27"),
        GetLabelText("CC_MKUP_28"),
        GetLabelText("CC_MKUP_29"),
        GetLabelText("CC_MKUP_30"),
        GetLabelText("CC_MKUP_31"),
        GetLabelText("CC_MKUP_32"),
        GetLabelText("CC_MKUP_33"),
        GetLabelText("CC_MKUP_34"),
        GetLabelText("CC_MKUP_35"),
        GetLabelText("CC_MKUP_36"),
        GetLabelText("CC_MKUP_37"),
        GetLabelText("CC_MKUP_38"),
        GetLabelText("CC_MKUP_39"),
        GetLabelText("CC_MKUP_40"),
        GetLabelText("CC_MKUP_41"),
        GetLabelText("CC_MKUP_42"),
        GetLabelText("CC_MKUP_43"),
        GetLabelText("CC_MKUP_44"),
        GetLabelText("CC_MKUP_45"),
        GetLabelText("CC_MKUP_46"),
        GetLabelText("CC_MKUP_47"),
        GetLabelText("CC_MKUP_48"),
        GetLabelText("CC_MKUP_49"),
        GetLabelText("CC_MKUP_50"),
        GetLabelText("CC_MKUP_51"),
        GetLabelText("CC_MKUP_52"),
        GetLabelText("CC_MKUP_53"),
        GetLabelText("CC_MKUP_54"),
        GetLabelText("CC_MKUP_55"),
        GetLabelText("CC_MKUP_56"),
        GetLabelText("CC_MKUP_57"),
        GetLabelText("CC_MKUP_58"),
        GetLabelText("CC_MKUP_59"),
        GetLabelText("CC_MKUP_60"),
        GetLabelText("CC_MKUP_61"),
        GetLabelText("CC_MKUP_62"),
        GetLabelText("CC_MKUP_63"),
        GetLabelText("CC_MKUP_64"),
        GetLabelText("CC_MKUP_65"),
        GetLabelText("CC_MKUP_66"),
        GetLabelText("CC_MKUP_67"),
        GetLabelText("CC_MKUP_68"),
        GetLabelText("CC_MKUP_69"),
        GetLabelText("CC_MKUP_70"),
        GetLabelText("CC_MKUP_71")
    
    
    }

local CurrentZone = nil
skins = {sex = 0, model = "mp_m_freemode_01", face = {mom = 0, dad = 0}, resemblance = 0.0, skinmix = 0.0, ageing = {style = 0, opacity = 0.0}, lipstick = {style = 0, opacity = 0.0, color = { [1] = 0, [2] = 0}}, eye = {style = 0}, blemishes = {style = 0, opacity = 0.0}, complexion = {style = 0, opacity = 0.0}, makeup = {style = 1, opacity = 0.0, color={[1] = 0, [2] = 0}}, blush = {style = 1, opacity = 0.0, color={[1] = 0, [2] = 0}}, hair = {style = 0, color = {[1] = 0, [2] = 0}}, facialHair = { beard = {style = 0, color = {[1] = 0, [2] = 0}, opacity = 0.0}, eyebrow = {style = 0, color = {[1] = 0, [2] = 0}, opacity = 0.0}}}
local colour_table2 = { 1, 1 }
local colour_table = { 1, 1 }
local colour_table6 = { 1, 1 }
local colour_table3 = { 1, 1 }
local colour_table4 = { 1, 1 }
local hairstyless = 1
local colour_table5 = { 1, 1 }
local colour_table7 = { 1, 1 }
local colour_table8 = { 1, 1 }
local colour_table9 = { 1, 1 }
local colour_table10 = { 1, 1 }
local percentage_float = 0.5
local price = 0
local cheveux = false
local hrtfgdhdfhgc = nil
local locked_hair = true
local locked_barber = true
local barbe = false
local rouge = false
local Maquillage = false
local Blush = false
local cheveux = false
local locked_Maquillage = true
local locked_Blush = true
local locked_rouge = true
PlySkin = TriggerPlayerEvent("getSkin", GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
local function Open()
    skins.hair = PlySkin.hair
    skins.facialHair = PlySkin.facial.hair
    skins.makeup = PlySkin.makeup
    skins.blush = PlySkin.blush
    skins.lipstick = PlySkin.lipstick
    (PlySkin.hair.style)
    (skins.hair.style)
    RageUI.Visible(RMenu:Get('barberDhop', "main"),true)
end

local function EnterZone(zone)
    hrtfgdhdfhgc = PlySkin
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard","E",Open,"Barber")
    KeySettings:Add("controller",46,Open,"Barber")
    CurrentZone = zone
end

local function ExitZone()
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        if RageUI.Visible(RMenu:Get('barberDhop', "main")) then
            RageUI.Visible(RMenu:Get('barberDhop', "main"),not RageUI.Visible(RMenu:Get('barberDhop', "main")))
        end
        KeySettings:Clear("keyboard","E","Barber")
        CurrentZone  = nil

        GetOldChev()
    end

end

function GetOldChev()
    Wait(500)

    TriggerServerCallback("core:GetSKin",function(skin)
        UpdateEntityFace(LocalPlayer().Ped, json.decode(skin))

    end)
end

local function Build()
    for i = 1 , #Shops_Barber.Pos , 1 do
        local v = Shops_Barber.Pos[i]
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite (blip, 71)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, 59)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Coiffeur")
        EndTextCommandSetBlipName(blip)

        Zone:Add(v,EnterZone,ExitZone,i,2.5)

    end
    RMenu.Add('barberDhop', "main", RageUI.CreateMenu("", "Coiffeur", 15, 250,"shopui_title_barber3","shopui_title_barber3"))
    RMenu:Get('barberDhop', "main").EnableMouse = true
    RMenu:Get('barberDhop', "main").Closed = function()
        GetOldChev()
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        
        if RageUI.Visible(RMenu:Get('barberDhop', "main")) then
           (json.encode(skins.hair.style .. " $"))
           (json.encode((PlySkin.hair.style)))
            RageUI.DrawContent({ header = true, glare = false}, function()    
                hairstyles = {} 
                if Ora.World.Ped:IsPedMale(GetPlayerPed(GetPlayerFromServerId(GetPlayerServerIdInDirection(5.0)))) then
                    for i = 1, 23,1 do
                        hairstyles[i] = GetLabelText("CC_M_HS_"..i-1) 
                    end
            
                else
                    for i = 1, 23,1 do
                        hairstyles[i] = GetLabelText("CC_F_HS_"..i-1) 
                    end
            
                end
                RageUI.List("Cheveux", hairstyles,  hairstyless,nil,{}, locked_hair, function(Hovered, Active, Selected, Index)
                    if Active and locked_hair then
                        if Index ~= nil then
                        skins.hair.style = Index - 1 
                        hairstyless = Index
                       
    
                        RageUI.ColourPanel("Couleur principale", Colors, colour_table[1], colour_table[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                            colour_table[1] = MinimumIndex
    
                            colour_table[2] = CurrentIndex
                            skins.hair.color[1] = CurrentIndex - 1
                        end)
                        RageUI.ColourPanel("Couleur secondaire", Colors, colour_table2[1], colour_table2[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                            colour_table2[1] = MinimumIndex
    
                            colour_table2[2] = CurrentIndex
                            skins.hair.color[2] = CurrentIndex - 1
                        end)
                        updateCheveux(skin)
                        end
                    
                    end
                    
                    if Selected and not cheveux then
                        locked_hair = false
                        cheveux = true
                        price = price + 50
                        ShowNotification("~g~Cheveux présélectionné")
                    end
                end)
                BarbeName = {}
                for i = 1 , #beardAmount, 1 do
                    BarbeName[i] = GetLabelText("CC_BEARD_"..i-1)
                end
    
                RageUI.List("Barbe", BarbeName,  skins.facialHair.beard.style+1, nil,{}, locked_barber, function(Hovered, Active, Selected, Index)
                    if Active and locked_barber then
                        skins.facialHair.beard.style = Index - 1 
    
    
                        RageUI.ColourPanel("Couleur principale", Colors, colour_table3[1], colour_table3[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                            colour_table3[1] = MinimumIndex
    
                            colour_table3[2] = CurrentIndex
                            skins.facialHair.beard.color[1] = CurrentIndex - 1
                        end)
                        RageUI.ColourPanel("Couleur secondaire", Colors, colour_table4[1], colour_table4[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                            colour_table4[1] = MinimumIndex
    
                            colour_table4[2] = CurrentIndex
                            skins.facialHair.beard.color[2] = CurrentIndex - 1
                        end)
    
                        RageUI.PercentagePanel(percentage_float, "Opacité", nil, nil, function(Hovered, Active, Percent)
                            percentage_float = Percent
                            skins.facialHair.beard.opacity = Percent
                        end)
    
                        updateCheveux(skin)
                    end
                    
                    if Selected and not barbe then
                        locked_barber = false
                        barbe = true
                        price = price + 40
                        ShowNotification("~g~Barbe présélectionné")
                    end
                end)
                
    
                RageUI.List("Rouge à lèvres", ap,  skins.lipstick.style + 1, nil,{}, locked_rouge, function(Hovered, Active, Selected, Index)
                    if Active and locked_rouge then
                        skins.lipstick.style  = Index - 1 
    
                        RageUI.PercentagePanel(skins.lipstick.opacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                            skins.lipstick.opacity  = Percent
                        end)
    
                        RageUI.ColourPanel("Couleur principale", Colors, colour_table6[1], colour_table6[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                            colour_table6[1] = MinimumIndex
    
                            colour_table6[2] = CurrentIndex
                            skins.lipstick.color[1] = CurrentIndex - 1
                        end)
    
updateCheveux(skin)
                    end
                    
                    if Selected and not rouge then
                        locked_rouge = false
                        rouge = true
                        price = price + 80
                        ShowNotification("~g~Rouge à lèvres présélectionné")
                    end
                end)
    
                RageUI.List("Maquillage", ppp,  skins.makeup.style + 1, nil,{}, locked_Maquillage, function(Hovered, Active, Selected, Index)
                    if Active and locked_Maquillage then
                        skins.makeup.style  = Index - 1 
    
                        RageUI.PercentagePanel(skins.makeup.opacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                            skins.makeup.opacity  = Percent
                        end)
    
                        RageUI.ColourPanel("Couleur principale", Colors, colour_table7[1], colour_table7[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                            colour_table7[1] = MinimumIndex
    
                            colour_table7[2] = CurrentIndex
                            skins.makeup.color[1]= CurrentIndex - 1
                        end)
                        RageUI.ColourPanel("Couleur secondaire", Colors, colour_table8[1], colour_table8[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                            colour_table8[1] = MinimumIndex
    
                            colour_table8[2] = CurrentIndex
                            skins.makeup.color[2] = CurrentIndex - 1
                        end)
                       updateCheveux(skin)
                    end
                    if Selected and not Maquillage then
                        locked_Maquillage = false
                        Maquillage = true
                        price = price + 100
                        ShowNotification("~g~Maquillage présélectionné")
                    end
                end)

                RageUI.List("Blush", ppp,  skins.blush.style + 1, nil,{}, locked_Blush, function(Hovered, Active, Selected, Index)
                    if Active and locked_Blush then
                        skins.blush.style  = Index - 1 
    
                        RageUI.PercentagePanel(skins.blush.opacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                            skins.blush.opacity  = Percent
                        end)
    
                        RageUI.ColourPanel("Couleur principale", Colors, colour_table9[1], colour_table9[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                            colour_table9[1] = MinimumIndex
    
                            colour_table9[2] = CurrentIndex
                            skins.blush.color[1] = CurrentIndex - 1
                        end)
                        RageUI.ColourPanel("Couleur secondaire", Colors, colour_table10[1], colour_table10[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                            colour_table10[1] = MinimumIndex
    
                            colour_table10[2] = CurrentIndex
                            skins.blush.color[2] = CurrentIndex - 1
                        end)
                       updateCheveux(skin)
                    end
                    if Selected and not Blush then
                        locked_Blush = false
                        Blush = true
                        price = price + 100
                        ShowNotification("~g~Blush présélectionné")
                    end
                end)
    
                RageUI.Button("~g~Acheter", nil, { RightLabel = "~g~"..price.."$" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        if Money:CanBuy(price) then
                                if cheveux then
                                    TriggerServerCallback('isAlreadyCoiffed', function(bool)
                                        if bool then
                                            PlySkin.hair.style = skins.hair.style
                                            PlySkin.hair.color[1] = skins.hair.color[1]
                                            PlySkin.hair.color[2] = skins.hair.color[2] 
                                            ("achat")
                                            UpdateEntityFace(LocalPlayer().Ped,PlySkin)
                                        else
                                            ShowNotification("~r~Votre coiffure ne sera pas prise en compte. Vous vous êtes déjà coiffé aujourd'hui")
                                        end
                                    end)
                                end
                                if barbe then
                                    PlySkin.facial.hair.beard.style  = skins.facialHair.beard.style 
                                    PlySkin.facial.hair.beard.opacity = skins.facialHair.beard.opacity
                                    PlySkin.facial.hair.beard.color[1] = skins.facialHair.beard.color[1]
                                    PlySkin.facial.hair.beard.color[2]  = skins.facialHair.beard.color[2]
                                    UpdateEntityFace(LocalPlayer().Ped,PlySkin)
                                end
                                if Maquillage then
                                    PlySkin.makeup.style = skins.makeup.style
                                    PlySkin.makeup.opacity = skins.makeup.opacity
                                    PlySkin.makeup.color[1] = skins.makeup.color[1]
                                    PlySkin.makeup.color[2] = skins.makeup.color[2]
                                    UpdateEntityFace(LocalPlayer().Ped,PlySkin)
                                end
                                if Blush then
                                    PlySkin.blush.style = skins.blush.style
                                    PlySkin.blush.opacity = skins.blush.opacity
                                    PlySkin.blush.color[1] = skins.blush.color[1]
                                    PlySkin.blush.color[2] = skins.blush.color[2]
                                    UpdateEntityFace(LocalPlayer().Ped,PlySkin)
                                end
                                if rouge then
                                    PlySkin.lipstick.style = skins.lipstick.style
                                    PlySkin.lipstick.opacity = skins.lipstick.opacity
                                    PlySkin.lipstick.color[1] = skins.lipstick.color[1]
                                    UpdateEntityFace(LocalPlayer().Ped,PlySkin)
                                end
                                
                                UpdateEntityFace(LocalPlayer().Ped,PlySkin)
                                TriggerServerEvent("money:Pay", price )

                                TriggerServerEvent('face:Save', PlySkin)
                        end
                    end
                end)
            end, function()
            end)
        end
    end
end)

Build()