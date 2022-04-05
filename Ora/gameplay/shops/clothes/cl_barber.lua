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
local HairCutJob = {
    posChair = {x = -816.22, y = -182.72, z = 37.57}, --posChair = {x=-34.06, y=-150.38, z=57.077},
    -- posChair = {x = 138.25, y = -1709.13, z = 29.42}, --posChair = {x=-34.06, y=-150.38, z=57.077},
    posCutters = {x = -815.93, y = -183.48, z = 37.56}, --posCutters = {x=-33.28, y=-151.57, z=57.08},
    -- posCutters = {x = 137.76, y = -1708.74, z = 29.3}, --posCutters = {x=-33.28, y=-151.57, z=57.08},
    Seated = false
}

local HairCutJob2 = {
    posChair = {x = -280.62, y = 6227.97, z = 31.80}, --posChair = {x=-34.06, y=-150.38, z=57.077},
    -- posChair = {x = 138.25, y = -1709.13, z = 29.42}, --posChair = {x=-34.06, y=-150.38, z=57.077},
    posCutters = {x = -279.74, y = 6228.70, z = 31.69}, --posCutters = {x=-33.28, y=-151.57, z=57.08},
    -- posCutters = {x = 137.76, y = -1708.74, z = 29.3}, --posCutters = {x=-33.28, y=-151.57, z=57.08},
    Seated = false
}

local sourcilsss = 1
local Colors = {
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
    {213, 170, 115} -- 63
}
local SA = {
    GetLabelText("CC_EYEBRW_0"),
    GetLabelText("CC_EYEBRW_1"),
    GetLabelText("CC_EYEBRW_2"),
    GetLabelText("CC_EYEBRW_3"),
    GetLabelText("CC_EYEBRW_4"),
    GetLabelText("CC_EYEBRW_5"),
    GetLabelText("CC_EYEBRW_6"),
    GetLabelText("CC_EYEBRW_7"),
    GetLabelText("CC_EYEBRW_8"),
    GetLabelText("CC_EYEBRW_9"),
    GetLabelText("CC_EYEBRW_10"),
    GetLabelText("CC_EYEBRW_11"),
    GetLabelText("CC_EYEBRW_12"),
    GetLabelText("CC_EYEBRW_13"),
    GetLabelText("CC_EYEBRW_14"),
    GetLabelText("CC_EYEBRW_15"),
    GetLabelText("CC_EYEBRW_16"),
    GetLabelText("CC_EYEBRW_17"),
    GetLabelText("CC_EYEBRW_18"),
    GetLabelText("CC_EYEBRW_19"),
    GetLabelText("CC_EYEBRW_20"),
    GetLabelText("CC_EYEBRW_21"),
    GetLabelText("CC_EYEBRW_22"),
    GetLabelText("CC_EYEBRW_23"),
    GetLabelText("CC_EYEBRW_24"),
    GetLabelText("CC_EYEBRW_25"),
    GetLabelText("CC_EYEBRW_26"),
    GetLabelText("CC_EYEBRW_27"),
    GetLabelText("CC_EYEBRW_28"),
    GetLabelText("CC_EYEBRW_29"),
    GetLabelText("CC_EYEBRW_30"),
    GetLabelText("CC_EYEBRW_31"),
    GetLabelText("CC_EYEBRW_32"),
    GetLabelText("CC_EYEBRW_33")
}
beardAmount = {}
for i = 0, 28 do
    table.insert(beardAmount, {Name = i, Value = i})
end

local makeupList = {}
local blushList = {}
local lipstickList = {}

for i = 0, 80, 1 do
    table.insert(makeupList, GetLabelText("CC_MKUP_" .. i))
end

for i = 0, 32, 1 do
    table.insert(blushList, GetLabelText("CC_BLUSH_" .. i))
end

for i = 0, 9, 1 do
    table.insert(lipstickList, GetLabelText("CC_LIPSTICK_" .. i))
end

local CurrentZone = nil
local skins = nil
local colour_table0 = {1, 1}
local colour_table1 = {1, 1}
local colour_table = {1, 1}
local colour_table2 = {1, 1}
local colour_table6 = {1, 1}
local colour_table3 = {1, 1}
local colour_table4 = {1, 1}
local hairstyless = nil
local mpp = nil
local colour_table5 = {1, 1}
local colour_table7 = {1, 1}
local colour_table8 = {1, 1}
local colour_makeup = {1, 1}
local colour_makeup2 = {1, 1}
local colour_blush = {1, 1}
local colour_blush2 = {1, 1}
local colour_lipstick = {1, 1}
local colour_lipstick2 = {1, 1}
local percentage_float = 0.5
local percentage_makeup = 0.5
local percentage_blush = 0.5
local percentage_lipstick = 0.5
local makeupStyle = 1
local blushStyle = 1
local lipstickStyle = 1
local razorCutIndex = 118

RMenu.Add("haircuts", "main", RageUI.CreateMenu("Coiffeur", "Actions disponibles", 10, 100))
RMenu.Add(
    "haircuts",
    "cut_main",
    RageUI.CreateSubMenu(RMenu:Get("haircuts", "main"), "Coiffeur", "Actions disponibles", 10, 100)
)

RMenu:Get("haircuts", "main").Closed = function()
    skins = nil
end

RMenu:Get("haircuts", "cut_main").Closed = function()
    skins = nil
end
local function SeatChair()
    Hint:RemoveAll()
    local ped = LocalPlayer().Ped
    if HairCutJob.Seated == true then
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        SetEntityCollision(ped, true)
        HairCutJob.Seated = not HairCutJob.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour s'asseoir")
    else
        SetEntityCoordsNoOffset(ped, -816.23, -182.96, 37.61)
        SetEntityHeading(ped, 30.0)
        FreezeEntityPosition(ped, true)
        SetEntityCollision(ped, false)
        doAnim({"misshair_shop@hair_dressers", "player_base"}, nil, 1)
        HairCutJob.Seated = not HairCutJob.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour se relever")
    end
end

local function SeatChair2()
    Hint:RemoveAll()
    local ped = LocalPlayer().Ped
    if HairCutJob2.Seated == true then
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        SetEntityCollision(ped, true)
        HairCutJob2.Seated = not HairCutJob2.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour s'asseoir")
    else
        SetEntityCoordsNoOffset(ped, HairCutJob2.posChair.x, HairCutJob2.posChair.y, HairCutJob2.posChair.z)
        SetEntityHeading(ped, 135.17)
        FreezeEntityPosition(ped, true)
        SetEntityCollision(ped, false)
        doAnim({"misshair_shop@hair_dressers", "player_base"}, nil, 1)
        HairCutJob2.Seated = not HairCutJob2.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour se relever")
    end
end

local myPLY = 0
RMenu:Get("haircuts", "cut_main").EnableMouse = true

RMenu:Get("haircuts", "cut_main").Closed = function()
    TriggerPlayerEvent("skin:GiveBack", myPLY)
end

Citizen.CreateThread(
    function()
        Zone:Add(
            HairCutJob.posChair,
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ s'asseoir")
                KeySettings:Add("keyboard", "E", SeatChair, "PosChair")
                KeySettings:Add("controller", 46, SeatChair, "PosChair")
                RageUI.Visible(RMenu:Get("haircuts", "main"), true)
            end,
            function()
                Hint:RemoveAll()
                KeySettings:Clear("keyboard", "E", "PosChair")
                KeySettings:Clear("controller", 46, "PosChair")
            end,
            posChair,
            1.0
        )
        Zone:Add(
            HairCutJob2.posChair,
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ s'asseoir")
                KeySettings:Add("keyboard", "E", SeatChair2, "PosChair")
                KeySettings:Add("controller", 46, SeatChair2, "PosChair")
                RageUI.Visible(RMenu:Get("haircuts", "main"), true)
            end,
            function()
                Hint:RemoveAll()
                KeySettings:Clear("keyboard", "E", "PosChair")
                KeySettings:Clear("controller", 46, "PosChair")
            end,
            posChair,
            1.0
        )
        while true do
            Wait(1000)
            if myPLY ~= nil and skins ~= nil then
                if RageUI.Visible(RMenu:Get("haircuts", "cut_main")) then
                    TriggerPlayerEvent("change:skin", myPLY, skins)
                end

                if RageUI.Visible(RMenu:Get("makeup", "main")) then
                    TriggerPlayerEvent("change:skin", myPLY, skins)
                end
            end
        end
    end
)
-- local tx = false
-- Citizen.CreateThread(function()
--     Wait(500)
--     while true do
--         Wait(1000)
--         if tx then
--             plyPos = LocalPlayer().Pos
--             Wait(1)
--             doAnim2({"misstattoo_parlour@shop_ig_4","shop_ig_4_customer"},nil,1)
--         end
--     end
-- end)
-- Citizen.CreateThread(function()
--     Wait(500)
--    -- RageUI.Visible(RMenu:Get("haircuts","main"),true)
--     hairstyles = {}
--     while true do
--         Wait(0)
--         if IsControlJustPressed(0, Keys["E"]) then
--             plyPos = LocalPlayer().Pos
--             SetEntityCoords(LocalPlayer().Ped, -1154.440,-1427.6,3.881159)
--             SetEntityHeading(LocalPlayer().Ped, 347.84)
--             Wait(1)
--             doAnim2({"misstattoo_parlour@shop_ig_4","shop_ig_4_customer"},nil,1)
--             tx = true
--         end

--         if tx then
--             local ped = LocalPlayer().Ped
--             FreezeEntityPosition(ped, true)
--         end
--     end
-- end)
local PreviousIndex = nil
local cam = nil
local prop
RMenu.Add("makeup", "main", RageUI.CreateMenu("Makeup", "Actions disponibles", 10, 100))
RMenu:Get("makeup", "main").EnableMouse = true
RMenu:Get("makeup", "main").Closed = function()
    skins = nil
    TriggerPlayerEvent("skin:GiveBack", myPLY)
    FreezeEntityPosition(LocalPlayer().Ped, false)
    DeleteObject(prop)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    cam = nil
end

Citizen.CreateThread(
    function()
        Wait(500)

        hairstyles = {}
        razorCutsStyles = Ora.Config:GetDataCollection("HaircutTatoos")
        
        razorCutsStyles[#razorCutsStyles + 1] = { Name = "Aucun", library = nil, name = nil}
        for razorKey, razorValue in pairs(razorCutsStyles) do
            if (razorValue.Name == nil) then 
                razorCutsStyles[razorKey].Name = "Dégradé #" .. razorKey 
            end
        end

        while true do
            Wait(1)
            
            if RageUI.Visible(RMenu:Get("makeup", "main")) then
                if cam == nil then
                    cam = true
                    local brush = `prop_makeup_brush`
                    local ped = LocalPlayer().Ped
                    local coords = GetEntityCoords(ped)
                    local forwardx = GetEntityForwardX(ped)
                    local forwardy = GetEntityForwardY(ped)
                    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x + forwardx, coords.y + forwardy, coords.z + 0.7, 0.00, 0.00, 0.00, 50.00, false, 0)
                    PointCamAtCoord(cam, coords.x, coords.y, coords.z + 0.7)
                    SetCamActive(cam, true)
                    RenderScriptCams(true, true, 500, true, true)
                    FreezeEntityPosition(ped, true)
                    RequestModel(brush)
                    while not HasModelLoaded(brush) do
                        Wait(100)
                    end
                    prop = Ora.World.Object:Create(brush, coords, true, true, true)
                    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 57005), 0.15, 0.04, 0.0, 90.0, 90.0, 210.0, true, true, false, true, 1, true)
                end
                DisableControlAction(0, 21, true) -- disable sprint
                DisableControlAction(0, 24, true) -- disable attack
                DisableControlAction(0, 25, true) -- disable aim
                DisableControlAction(0, 47, true) -- disable weapon
                DisableControlAction(0, 58, true) -- disable weapon
                DisableControlAction(0, 263, true) -- disable melee
                DisableControlAction(0, 264, true) -- disable melee
                DisableControlAction(0, 257, true) -- disable melee
                DisableControlAction(0, 140, true) -- disable melee
                DisableControlAction(0, 141, true) -- disable melee
                DisableControlAction(0, 142, true) -- disable melee
                DisableControlAction(0, 143, true) -- disable melee
                RageUI.DrawContent({header = true, glare = false}, function()
                    local ply = PlayerPedId()
                    if skins == nil then
                        TriggerPlayerEvent("getSkin", ply, GetPlayerServerId(PlayerId()))
                        Wait(1000)
                    else
                        myPLY = ply
                        RageUI.List("Maquillage", makeupList, makeupStyle, nil, {}, true, function(Hovered, Active, Selected, Index)
                            if Active then
                                if Index ~= nil then
                                    skins.makeup.style = Index - 1
                                    makeupStyle = Index
                                end
                                RageUI.PercentagePanel(percentage_makeup, "Opacité", nil, nil, function(Hovered, Active, Percent)
                                    if skins.makeup.opacity ~= Percent then
                                        percentage_makeup = Percent
                                        skins.makeup.opacity = Percent
                                    end
                                end)
                                RageUI.ColourPanel("Couleur principale", Colors, colour_makeup[1], colour_makeup[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                                    colour_makeup[1] = MinimumIndex
                                    colour_makeup[2] = CurrentIndex
                                    skins.makeup.color[1] = CurrentIndex - 1
                                end)
                                RageUI.ColourPanel("Couleur principale", Colors, colour_makeup2[1], colour_makeup2[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                                    colour_makeup2[1] = MinimumIndex
                                    colour_makeup2[2] = CurrentIndex
                                    skins.makeup.color[2] = CurrentIndex - 1
                                end)
                            end
                        end)

                        RageUI.List("Blush", blushList, blushStyle, nil, {}, true, function(Hovered, Active, Selected, Index)
                            if Active then
                                if Index ~= nil then
                                    skins.blush.style = Index - 1
                                    blushStyle = Index
                                end
                                RageUI.PercentagePanel(percentage_blush, "Opacité", nil, nil, function(Hovered, Active, Percent)
                                    if skins.blush.opacity ~= Percent then
                                        percentage_blush = Percent
                                        skins.blush.opacity = Percent
                                    end
                                end)
                                RageUI.ColourPanel("Couleur principale", Colors, colour_blush[1], colour_blush[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                                    colour_blush[1] = MinimumIndex
                                    colour_blush[2] = CurrentIndex
                                    skins.blush.color[1] = CurrentIndex - 1
                                end)
                                RageUI.ColourPanel("Couleur principale", Colors, colour_blush2[1], colour_blush2[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                                    colour_blush2[1] = MinimumIndex
                                    colour_blush2[2] = CurrentIndex
                                    skins.blush.color[2] = CurrentIndex - 1
                                end)
                            end
                        end)

                        RageUI.List("Rouge à lèvres", lipstickList, lipstickStyle, nil, {}, true, function(Hovered, Active, Selected, Index)
                            if Active then
                                if Index ~= nil then
                                    skins.lipstick.style = Index - 1
                                    lipstickStyle = Index
                                end
                                RageUI.PercentagePanel(percentage_lipstick, "Opacité", nil, nil, function(Hovered, Active, Percent)
                                    if skins.lipstick.opacity ~= Percent then
                                        percentage_lipstick = Percent
                                        skins.lipstick.opacity = Percent
                                    end
                                end)
                                RageUI.ColourPanel("Couleur principale", Colors, colour_lipstick[1], colour_lipstick[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                                    colour_lipstick[1] = MinimumIndex
                                    colour_lipstick[2] = CurrentIndex
                                    skins.lipstick.color[1] = CurrentIndex - 1
                                end)
                                RageUI.ColourPanel("Couleur principale", Colors, colour_lipstick2[1], colour_lipstick2[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                                    colour_lipstick2[1] = MinimumIndex
                                    colour_lipstick2[2] = CurrentIndex
                                    skins.lipstick.color[2] = CurrentIndex - 1
                                end)
                            end
                        end)

                        RageUI.Button("Appliquer le maquillage", nil, {Color = { HightLightColor = { 0, 155, 0, 150 }}}, true, function(_, _, Selected)
                            if Selected then
                                RageUI.GoBack()
                                FreezeEntityPosition(LocalPlayer().Ped, false)
                                RenderScriptCams(false, true, 500, true, true)
                                SetCamActive(cam, false)
                                DestroyCam(cam, true)
                                cam = nil
                                Wait(600)
                                TriggerPlayerEvent("save:Skin", ply, skins)
                                ShowNotification("~g~Modification appliquée")
                                DeleteObject(prop)
                            end
                        end)
                    end
                end)
            end

            if RageUI.Visible(RMenu:Get("haircuts", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Couper",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    hairstyles = {}
                                    local playerPed = PlayerPedId()
                                    if Ora.World.Ped:IsPedMale(playerPed) then
                                        for i = 0, GetNumberOfPedDrawableVariations(playerPed, 2) - 1, 1 do
                                            local hairLabel = GetLabelText("CC_M_HS_" .. i) == "NULL" and "Coupe #" .. i or GetLabelText("CC_M_HS_" .. i)
                                            table.insert(hairstyles, hairLabel)
                                        end
                                    else
                                        for i = 0, GetNumberOfPedDrawableVariations(playerPed, 2) - 1, 1 do
                                            local hairLabel = GetLabelText("CC_F_HS_" .. i) == "NULL" and "Coupe #" .. i or GetLabelText("CC_F_HS_" .. i)
                                            table.insert(hairstyles, hairLabel)
                                        end
                                    end
                                end
                            end,
                            RMenu:Get("haircuts", "cut_main")
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("haircuts", "cut_main")) then
                DisableControlAction(0, 21, true) -- disable sprint
                DisableControlAction(0, 24, true) -- disable attack
                DisableControlAction(0, 25, true) -- disable aim
                DisableControlAction(0, 47, true) -- disable weapon
                DisableControlAction(0, 58, true) -- disable weapon
                DisableControlAction(0, 263, true) -- disable melee
                DisableControlAction(0, 264, true) -- disable melee
                DisableControlAction(0, 257, true) -- disable melee
                DisableControlAction(0, 140, true) -- disable melee
                DisableControlAction(0, 141, true) -- disable melee
                DisableControlAction(0, 142, true) -- disable melee
                DisableControlAction(0, 143, true) -- disable melee
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Attendre 1",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    doAnim({"misshair_shop@barbers", "keeper_base"}, nil, 1)
                                end
                            end
                        )

                        RageUI.Button(
                            "Attendre 2",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    doAnim({"misshair_shop@hair_dressers", "keeper_base"}, nil, 1)
                                end
                            end
                        )

                        local ply = PlayerPedId()
                        HoverPlayer()

                        if skins == nil and ply ~= false then
                            TriggerPlayerEvent("getSkin", ply, GetPlayerServerId(PlayerId()))
                            Wait(100)
                        else
                            if ply ~= false then
                                myPLY = ply

                                RageUI.List("Maquillage", makeupList, makeupStyle, nil, {}, true, function(Hovered, Active, Selected, Index)
                                    if Active then
                                        if Index ~= nil then
                                            skins.makeup.style = Index - 1
                                            makeupStyle = Index
                                        end
                                        RageUI.PercentagePanel(percentage_makeup, "Opacité", nil, nil, function(Hovered, Active, Percent)
                                            if skins.makeup.opacity ~= Percent then
                                                percentage_makeup = Percent
                                                skins.makeup.opacity = Percent
                                            end
                                        end)
                                        RageUI.ColourPanel("Couleur principale", Colors, colour_makeup[1], colour_makeup[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                                            colour_makeup[1] = MinimumIndex
                                            colour_makeup[2] = CurrentIndex
                                            skins.makeup.color[1] = CurrentIndex - 1
                                        end)
                                        RageUI.ColourPanel("Couleur principale", Colors, colour_makeup2[1], colour_makeup2[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                                            colour_makeup2[1] = MinimumIndex
                                            colour_makeup2[2] = CurrentIndex
                                            skins.makeup.color[2] = CurrentIndex - 1
                                        end)
                                    end

                                    if Selected then
                                        RageUI.GoBack()
                                        Wait(600)
                                        TriggerPlayerEvent("save:Skin", ply, skins)
                                        ShowNotification("~g~Modification appliquée")
                                    end
                                end)

                                RageUI.List("Rouge à lèvres", lipstickList, lipstickStyle, nil, {}, true, function(Hovered, Active, Selected, Index)
                                    if Active then
                                        if Index ~= nil then
                                            skins.lipstick.style = Index - 1
                                            lipstickStyle = Index
                                        end
                                        RageUI.PercentagePanel(percentage_lipstick, "Opacité", nil, nil, function(Hovered, Active, Percent)
                                            if skins.lipstick.opacity ~= Percent then
                                                percentage_lipstick = Percent
                                                skins.lipstick.opacity = Percent
                                            end
                                        end)
                                        RageUI.ColourPanel("Couleur principale", Colors, colour_lipstick[1], colour_lipstick[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                                            colour_lipstick[1] = MinimumIndex
                                            colour_lipstick[2] = CurrentIndex
                                            skins.lipstick.color[1] = CurrentIndex - 1
                                        end)
                                        RageUI.ColourPanel("Couleur principale", Colors, colour_lipstick2[1], colour_lipstick2[2], function(Hovered, Active, MinimumIndex, CurrentIndex)
                                            colour_lipstick2[1] = MinimumIndex
                                            colour_lipstick2[2] = CurrentIndex
                                            skins.lipstick.color[2] = CurrentIndex - 1
                                        end)
                                    end
            
                                    if Selected then
                                        RageUI.GoBack()
                                        Wait(600)
                                        TriggerPlayerEvent("save:Skin", ply, skins)
                                        ShowNotification("~g~Modification appliquée")
                                    end
                                end)

                                RageUI.List(
                                    "Sourcils",
                                    SA,
                                    sourcilsss,
                                    nil,
                                    {},
                                    true,
                                    function(Hovered, Active, Selected, Index)
                                        if Active then
                                            if Index ~= nil then
                                                skins.facialHair.eyebrow.style = Index - 1
                                                sourcilsss = Index
                                            end

                                            RageUI.ColourPanel(
                                                "Couleur principale",
                                                Colors,
                                                colour_table0[1],
                                                colour_table0[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table0[1] = MinimumIndex

                                                    colour_table0[2] = CurrentIndex
                                                    skins.facialHair.eyebrow.color[1] = CurrentIndex - 1
                                                end
                                            )
                                            RageUI.ColourPanel(
                                                "Couleur secondaire",
                                                Colors,
                                                colour_table1[1],
                                                colour_table1[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table1[1] = MinimumIndex

                                                    colour_table1[2] = CurrentIndex
                                                    skins.facialHair.eyebrow.color[2] = CurrentIndex - 1
                                                end
                                            )
                                        end

                                        if Selected then
                                            RageUI.GoBack()
                                            Wait(600)
                                            TriggerPlayerEvent("save:Skin", ply, skins)
                                            ShowNotification("~g~Modification appliquée")
                                        end
                                    end
                                )

                                RageUI.List(
                                    "Cheveux",
                                    hairstyles,
                                    hairstyless,
                                    nil,
                                    {},
                                    true,
                                    function(Hovered, Active, Selected, Index)
                                        if Active then
                                            if Index ~= nil then
                                                skins.hair.style = Index - 1
                                                hairstyless = Index
                                            end

                                            RageUI.ColourPanel(
                                                "Couleur principale",
                                                Colors,
                                                colour_table[1],
                                                colour_table[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table[1] = MinimumIndex

                                                    colour_table[2] = CurrentIndex
                                                    skins.hair.color[1] = CurrentIndex - 1
                                                end
                                            )
                                            RageUI.ColourPanel(
                                                "Couleur secondaire",
                                                Colors,
                                                colour_table2[1],
                                                colour_table2[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table2[1] = MinimumIndex

                                                    colour_table2[2] = CurrentIndex
                                                    skins.hair.color[2] = CurrentIndex - 1
                                                end
                                            )
                                        end

                                        if Selected then
                                            RageUI.GoBack()
                                            Wait(600)
                                            TriggerPlayerEvent("save:Skin", ply, skins)
                                            ShowNotification("~g~Modification appliquée")
                                        end
                                    end
                                )

                                RageUI.List(
                                    "Dégradés",
                                    razorCutsStyles,
                                    razorCutIndex,
                                    nil,
                                    {},
                                    true,
                                    function(Hovered, Active, Selected, Index)
                                        if Active then
                                            if Index ~= nil and PreviousIndex ~= Index then
                                                razorCutIndex = Index
                                                PreviousIndex = Index
                                                skins.razorCut.index = Index
                                                if (razorCutsStyles[Index] ~= nil) then
                                                    skins.razorCut.dict = razorCutsStyles[Index].library
                                                    skins.razorCut.hash = razorCutsStyles[Index].name
    
                                                    Ora.Config:SetDataCollection(
                                                        "AppliedHarcutTatoos",
                                                        {dict = skins.razorCut.dict, hash = skins.razorCut.hash}
                                                    )
                                                end
                                            end
                                        end

                                        if Selected then
                                            RageUI.GoBack()
                                            Wait(600)
                                            TriggerPlayerEvent("save:Skin", ply, skins)
                                            ShowNotification("~g~Modification appliquée")
                                        end
                                    end
                                )

                                BarbeName = {}
                                for i = 1, #beardAmount, 1 do
                                    BarbeName[i] = GetLabelText("CC_BEARD_" .. i - 1)
                                end

                                RageUI.List(
                                    "Barbe",
                                    BarbeName,
                                    mpp,
                                    nil,
                                    {},
                                    true,
                                    function(Hovered, Active, Selected, Index)
                                        if Active then
                                            skins.facialHair.beard.style = Index - 1
                                            mpp = Index

                                            RageUI.ColourPanel(
                                                "Couleur principale",
                                                Colors,
                                                colour_table3[1],
                                                colour_table3[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table3[1] = MinimumIndex

                                                    colour_table3[2] = CurrentIndex
                                                    skins.facialHair.beard.color[1] = CurrentIndex - 1
                                                end
                                            )
                                            RageUI.ColourPanel(
                                                "Couleur secondaire",
                                                Colors,
                                                colour_table4[1],
                                                colour_table4[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table4[1] = MinimumIndex

                                                    colour_table4[2] = CurrentIndex
                                                    skins.facialHair.beard.color[2] = CurrentIndex - 1
                                                end
                                            )

                                            RageUI.PercentagePanel(
                                                percentage_float,
                                                "Opacité",
                                                nil,
                                                nil,
                                                function(Hovered, Active, Percent)
                                                    percentage_float = Percent
                                                    skins.facialHair.beard.opacity = Percent
                                                end
                                            )
                                        end

                                        if Selected then
                                            RageUI.GoBack()
                                            Wait(600)
                                            TriggerPlayerEvent("save:Skin", ply, skins)
                                            ShowNotification("~g~Modification appliquée")
                                        end
                                    end
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)

RegisterNetEvent("change:skin")
AddEventHandler("change:skin", function(p)
    updateCheveux(p)
end)

RegisterNetEvent("getSkin")
AddEventHandler("getSkin", function(p)
    skins = {}
    skins.hair = PlySkin.hair
    skins.facialHair = PlySkin.facial.hair
    skins.razorCut = PlySkin.razorCut or {index = 118}
    skins.makeup = PlySkin.makeup
    skins.blush = PlySkin.blush
    skins.lipstick = PlySkin.lipstick
    TriggerPlayerEvent("sendSkin", p, skins)
end)

RegisterNetEvent("sendSkin")
AddEventHandler("sendSkin", function(_skin)
    skins = _skin
    hairstyless = skins.hair.style + 1
    colour_table[2] = skins.hair.color[1] + 1
    colour_table2[2] = skins.hair.color[2] + 1

    if (skins.razorCut == nil) then
        skins.razorCut = {}
    end
    
    if (skins.razorCut ~= nil and skins.razorCut.index ~= nil and skins.razorCut.index ~= 0) then
        razorCutIndex = skins.razorCut.index
    end

    if skins.blush ~= nil then
        blushStyle = skins.blush.style + 1
        percentage_blush = skins.blush.opacity
    else
        skins.blush = {style = 1, opacity = 0.0, color = {[1] = 0, [2] = 0}}
    end

    makeupStyle = skins.makeup.style + 1
    percentage_makeup = skins.makeup.opacity
    lipstickStyle = skins.lipstick.style + 1
    percentage_lipstick = skins.lipstick.opacity

    sourcilsss = skins.facialHair.eyebrow.style + 1
    colour_table0[2] = skins.facialHair.eyebrow.color[1] + 1
    colour_table1[2] = skins.facialHair.eyebrow.color[2] + 1

    mpp = skins.facialHair.beard.style + 1
    colour_table3[2] = skins.facialHair.beard.color[1] + 1
    colour_table4[2] = skins.facialHair.beard.color[2] + 1
    percentage_float = skins.facialHair.beard.opacity
end)

RegisterNetEvent("skin:GiveBack")
AddEventHandler("skin:GiveBack", function()
    TriggerServerCallback("core:GetSKin", function(skin)
        UpdateEntityFace(LocalPlayer().Ped, json.decode(skin))
        if (skin.razorCut ~= nil and skin.razorCut.index ~= nil) then
            if (skin.razorCut.dict ~= nil and skin.razorCut.hash ~= nil) then
                Ora.Player:RemoveAllTattoos()
                Ora.Player:ApplyAllSavedTattoos(true)
                Ora.Player:ApplyTattoo(skin.razorCut.dict, skin.razorCut.hash)

                Ora.Config:SetDataCollection("AppliedHarcutTatoos", {dict = skin.razorCut.dict, hash = skin.razorCut.hash})

                return true
            end
        end
        Ora.Player:RemoveAllTattoos()
        Ora.Player:ApplyAllSavedTattoos(false)
        return true
    end)
end)

RegisterNetEvent("save:Skin")
AddEventHandler("save:Skin", function(_PlySkin)
    skins = _PlySkin

    PlySkin.hair.style = skins.hair.style
    PlySkin.hair.color[1] = skins.hair.color[1]
    PlySkin.hair.color[2] = skins.hair.color[2]

    if (skins.razorCut ~= nil and skins.razorCut.index ~= nil) then
        if (PlySkin.razorCut == nil) then
            PlySkin.razorCut = {}
        end
        if (skins.razorCut.dict ~= nil and skins.razorCut.hash ~= nil) then
            Ora.Config:SetDataCollection(
                "AppliedHarcutTatoos",
                {dict = skins.razorCut.dict, hash = skins.razorCut.hash}
            )
            PlySkin.razorCut.index = skins.razorCut.index
            PlySkin.razorCut.dict = skins.razorCut.dict
            PlySkin.razorCut.hash = skins.razorCut.hash
        else
            Ora.Config:SetDataCollection(
                "AppliedHarcutTatoos",
                {dict = nil, hash = nil}
            )
            PlySkin.razorCut.index = skins.razorCut.index
            PlySkin.razorCut.dict = nil
            PlySkin.razorCut.hash = nil
        end
    end

    PlySkin.facial.hair.beard.style = skins.facialHair.beard.style
    PlySkin.facial.hair.beard.opacity = skins.facialHair.beard.opacity
    PlySkin.facial.hair.beard.color[1] = skins.facialHair.beard.color[1]
    PlySkin.facial.hair.beard.color[2] = skins.facialHair.beard.color[2]

    PlySkin.facial.hair.eyebrow.style = skins.facialHair.eyebrow.style
    PlySkin.facial.hair.eyebrow.color[1] = skins.facialHair.eyebrow.color[1]
    PlySkin.facial.hair.eyebrow.color[2] = skins.facialHair.eyebrow.color[2]

    PlySkin.makeup.style = skins.makeup.style
    PlySkin.makeup.opacity = skins.makeup.opacity
    PlySkin.makeup.color[1] = skins.makeup.color[1]
    PlySkin.makeup.color[2] = skins.makeup.color[2]

    if PlySkin.blush == nil then 
        PlySkin.blush = {}
        PlySkin.blush.color = {}
    end
    PlySkin.blush.style = skins.blush.style
    PlySkin.blush.opacity = skins.blush.opacity
    PlySkin.blush.color[1] = skins.blush.color[1]
    PlySkin.blush.color[2] = skins.blush.color[2]

    PlySkin.lipstick.style = skins.lipstick.style
    PlySkin.lipstick.opacity = skins.lipstick.opacity
    PlySkin.lipstick.color[1] = skins.lipstick.color[1]
    UpdateEntityFace(LocalPlayer().Ped, PlySkin)
    TriggerServerEvent("face:Save", PlySkin)

    Ora.Player:RemoveAllTattoos()
    Ora.Player:ApplyAllSavedTattoos(false)
end)

updateCheveux = function(skin)
    Citizen.CreateThread(function()
        Citizen.Wait(1)
        skins = skin
        local playerPed = LocalPlayer().Ped
        cleanPlayer()

        if (skins.razorCut ~= nil and skins.razorCut.index ~= nil) then
            if (skins.razorCut.dict ~= nil and skins.razorCut.hash ~= nil) then
                Ora.Player:RemoveAllTattoos()
                Ora.Player:ApplyAllSavedTattoos(true)
                Ora.Player:ApplyTattoo(skins.razorCut.dict, skins.razorCut.hash)
            end
        end

        SetPedComponentVariation(playerPed, 2, skins.hair.style, 1.0, 1.0)
        SetPedHairColor(playerPed, skins.hair.color[1], skins.hair.color[2])
        SetPedHeadOverlay(playerPed, 1, skins.facialHair.beard.style, skins.facialHair.beard.opacity)
        SetPedHeadOverlayColor(playerPed, 1, 1, skins.facialHair.beard.color[1], skins.facialHair.beard.color[2])
        SetPedHeadOverlay(playerPed, 2, skins.facialHair.eyebrow.style, skins.facialHair.eyebrow.opacity)
        SetPedHeadOverlayColor(playerPed, 2, 1, skins.facialHair.eyebrow.color[1], skins.facialHair.eyebrow.color[2])
        SetPedHeadOverlay(playerPed, 8, skins.lipstick.style, skins.lipstick.opacity)
        SetPedHeadOverlayColor(playerPed, 8, 1, skins.lipstick.color[1], skins.lipstick.color[2])
        SetPedHeadOverlay(playerPed, 4, skins.makeup.style, skins.makeup.opacity)
        SetPedHeadOverlayColor(playerPed, 4, 1, skins.makeup.color[1], skins.makeup.color[2])

        if skins.blush ~= nil then
            SetPedHeadOverlay(playerPed, 5, skins.blush.style, skins.blush.opacity)
            SetPedHeadOverlayColor(playerPed, 5, 1, skins.blush.color[1], skins.blush.color[2])
        end
        return
    end)
end