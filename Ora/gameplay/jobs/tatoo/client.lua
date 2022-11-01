local TattoJob = {
    posChair = {x = 325.3215, y = 179.4357, z = 104.1064}, --posChair = {x=-1154.43, y=-1427.52, z=4.951},
    posTatoo = {x = 325.7946, y = 180.3293, z = 103.75},
    Seated = false,
    Tatoueur = false
}
local TattoJob2 = {
     posChair = {x=1863.5434, y=3745.5908, z=33.06},
     posTatoo = {x=1864.1995, y=3745.8034, z=32.939},
     Seated = false,
     Tatoueur = false
}
local TattoJob3 = { 
    posChair = {x=1320.3298, y= -1653.3701, z=52.27},
    posTatoo = {x=1320.6446, y= -1654.8449, z=52.27},
    Seated = false,
    Tatoueur = false
}

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
beardAmount = {}
for i = 0, 28 do
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
local skins = {
    sex = 0,
    model = "mp_m_freemode_01",
    face = {mom = 0, dad = 0},
    resemblance = 0.0,
    skinmix = 0.0,
    ageing = {style = 0, opacity = 0.0},
    lipstick = {style = 0, opacity = 0.0, color = {[1] = 0, [2] = 0}},
    eye = {style = 0},
    blemishes = {style = 0, opacity = 0.0},
    complexion = {style = 0, opacity = 0.0},
    makeup = {style = 0, opacity = 0.0, color = {[1] = 0, [2] = 0}},
    blush = {style = 0, opacity = 0.0, color = {[1] = 0, [2] = 0}},
    hair = {style = 0, color = {[1] = 0, [2] = 0}},
    facialHair = {
        beard = {style = 0, color = {[1] = 0, [2] = 0}, opacity = 0.0},
        eyebrow = {style = 0, color = {[1] = 0, [2] = 0}, opacity = 0.0}
    }
}
local colour_table2 = {1, 1}
local colour_table = {1, 1}
local colour_table6 = {1, 1}
local colour_table3 = {1, 1}
local colour_table4 = {1, 1}
local hairstyless = 1
local mpp = 1
local colour_table5 = {1, 1}
local colour_table7 = {1, 1}
local colour_table8 = {1, 1}
local percentage_float = 0.5
Citizen.CreateThread(function()
    Wait(500)
    while true do
        Wait(1000)
        if TattoJob.Seated then
            Wait(1)
            SetEntityCompletelyDisableCollision(LocalPlayer().Ped)
            doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_customer"}, nil, 1)
        end
        if TattoJob2.Seated then
            Wait(1)
            SetEntityCompletelyDisableCollision(LocalPlayer().Ped)
            doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_customer"}, nil, 1)
        end
        if TattoJob3.Seated then
            Wait(1)
            SetEntityCompletelyDisableCollision(LocalPlayer().Ped)
            doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_customer"}, nil, 1)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(5000)
        if TattoJob.Tatoueur then
            Wait(1)
            doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_tattooist"}, nil, 1)
        end
        if TattoJob2.Tatoueur then
            Wait(1)
            doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_tattooist"}, nil, 1)
        end
        if TattoJob3.Tatoueur then
            Wait(1)
            doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_tattooist"}, nil, 1)
        end
    end
end)
RMenu.Add("tatoo", "main", RageUI.CreateMenu("Tatoueur", "Actions disponibles", 10, 100))
RMenu.Add("tatoo","category2",RageUI.CreateSubMenu(RMenu:Get("tatoo", "main"), "Tatoueur", "Actions disponibles", 10, 100))
RMenu.Add("tatoo","category3",RageUI.CreateSubMenu(RMenu:Get("tatoo", "main"), "Tatoueur", "Actions disponibles", 10, 100))
RMenu.Add("tatoo","category4",RageUI.CreateSubMenu(RMenu:Get("tatoo", "category3"), "Tatoueur", "Actions disponibles", 10, 100))
RMenu.Add("tatoo","cut_main",RageUI.CreateSubMenu(RMenu:Get("tatoo", "main"), "Tatoueur", "Actions disponibles", 10, 100))
local function SeatChair()
    Hint:RemoveAll()
    local ped = LocalPlayer().Ped
    local plyPos = LocalPlayer().Pos
    if TattoJob.Seated == true then
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        TattoJob.Seated = not TattoJob.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour s'asseoir")
        SetEntityCollision(LocalPlayer().Ped, true)
    else
        SetEntityCoords(LocalPlayer().Ped, 325.3215, 179.4357, 103.1064)
        SetEntityHeading(LocalPlayer().Ped, 28.95)
        Wait(1)

        SetEntityCollision(LocalPlayer().Ped, false)
        FreezeEntityPosition(ped, true)
        TattoJob.Seated = not TattoJob.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour se relever")
        doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_customer"}, nil, 1)
    end
end
local function SeatChair2()
    Hint:RemoveAll()
    local ped = LocalPlayer().Ped
    local plyPos = LocalPlayer().Pos
    if TattoJob2.Seated == true then
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        TattoJob2.Seated = not TattoJob2.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour s'asseoir")
        SetEntityCollision(LocalPlayer().Ped, true)
    else
        SetEntityCoords(LocalPlayer().Ped, 1863.5434, 3745.1433, 32.00)
        SetEntityHeading(LocalPlayer().Ped, 359.587)
        Wait(1)

        SetEntityCollision(LocalPlayer().Ped, false)
        FreezeEntityPosition(ped, true)
        TattoJob2.Seated = not TattoJob2.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour se relever")
        doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_customer"}, nil, 1)
    end
end
local function SeatChair3()
    Hint:RemoveAll()
    local ped = LocalPlayer().Ped
    local plyPos = LocalPlayer().Pos
    if TattoJob3.Seated == true then
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        TattoJob3.Seated = not TattoJob3.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour s'asseoir")
        SetEntityCollision(LocalPlayer().Ped, true)
    else                                    
        SetEntityCoords(LocalPlayer().Ped, 1320.4609, -1654.2133, 51.27)
        SetEntityHeading(LocalPlayer().Ped, 268.9627)
        Wait(1)

        SetEntityCollision(LocalPlayer().Ped, false)
        FreezeEntityPosition(ped, true)
        TattoJob3.Seated = not TattoJob3.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour se relever")
        doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_customer"}, nil, 1)
    end
end
local currentSitObj
local fakeEnt
local fpxm
local function SeatTatoueur()
    Hint:RemoveAll()
    local ped = LocalPlayer().Ped
    local plyPos = LocalPlayer().Pos
    if TattoJob.Tatoueur == true then
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        TattoJob.Tatoueur = not TattoJob.Tatoueur
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour s'asseoir")
        SetEntityCollision(LocalPlayer().Ped, true)
    else
        SetEntityCoords(LocalPlayer().Ped, 325.7946, 180.3293, 102.75)
        SetEntityHeading(LocalPlayer().Ped, 156.8171)
        Wait(1)

        SetEntityCollision(LocalPlayer().Ped, false)
        FreezeEntityPosition(ped, true)
        TattoJob.Tatoueur = not TattoJob.Tatoueur 
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour se relever")
        doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_tattooist"}, nil, 1)
    end
end

local function SeatTatoueur2()
    Hint:RemoveAll()
    local ped = LocalPlayer().Ped
    local plyPos = LocalPlayer().Pos
    if TattoJob2.Tatoueur == true then
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        TattoJob2.Tatoueur = not TattoJob2.Tatoueur
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour s'asseoir")
        SetEntityCollision(LocalPlayer().Ped, true)
    else
        SetEntityCoords(LocalPlayer().Ped, 1864.1995, 3745.8034, 32.50)
        SetEntityHeading(LocalPlayer().Ped, 113.2934)
        Wait(1)

        SetEntityCollision(LocalPlayer().Ped, false)
        FreezeEntityPosition(ped, true)
        TattoJob2.Tatoueur = not TattoJob2.Tatoueur
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour se relever")
        doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_tattooist"}, nil, 1)

    end
end

local function SeatTatoueur3()
    Hint:RemoveAll()
    local ped = LocalPlayer().Ped
    local plyPos = LocalPlayer().Pos
    if TattoJob3.Tatoueur == true then
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        TattoJob3.Tatoueur = not TattoJob3.Tatoueur
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour s'asseoir")
        SetEntityCollision(LocalPlayer().Ped, true)
    else
        SetEntityCoords(LocalPlayer().Ped, 1320.6446, -1654.8449, 51.00)
        SetEntityHeading(LocalPlayer().Ped, 9.6111)
        Wait(1)

        SetEntityCollision(LocalPlayer().Ped, false)
        FreezeEntityPosition(ped, true)
        TattoJob3.Tatoueur = not TattoJob3.Tatoueur
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour se relever")
        doAnim2({"misstattoo_parlour@shop_ig_4", "shop_ig_4_tattooist"}, nil, 1)

    end
end

local obj = GetClosestObjectOfType(plyPos, 3.0, GetHashKey(k), false, true, true)
local function Create()
    --print("create job tatoo")
    Zone:Add(
        TattoJob.posChair,
        function()
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ s'asseoir")
            KeySettings:Add("keyboard", "E", SeatChair, "PosChairX")
            KeySettings:Add("controller", 46, SeatChair, "PosChairX")
            --print("asseoir")
        end,
        function()
            Hint:RemoveAll()
            KeySettings:Clear("keyboard", "E", "PosChairX")
            KeySettings:Clear("controller", 46, "PosChairX")
            --print("exit")
        end,
        "ssxxxx",
        0.8
    )

    Zone:Add(
        TattoJob.posTatoo,
        function()
            --print("tattt")
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ s'asseoir")
            KeySettings:Add("keyboard", "E", SeatTatoueur, "PosTatoueur")
            KeySettings:Add("controller", 46, SeatTatoueur, "PosTatoueur")
        end,
        function()
            Hint:RemoveAll()
            --print("exit")
            KeySettings:Clear("keyboard", "E", "PosTatoueur")
            KeySettings:Clear("controller", 46, "PosTatoueur")
        end,
        "3612",
        0.8
    )
end

local function Create2()
    --print("create job tatoo")
    Zone:Add(
        TattoJob2.posChair,
        function()
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ s'asseoir")
            KeySettings:Add("keyboard", "E", SeatChair2, "PosChairX")
            KeySettings:Add("controller", 46, SeatChair2, "PosChairX")
            --print("asseoir")
        end,
        function()
            Hint:RemoveAll()
            KeySettings:Clear("keyboard", "E", "PosChairX")
            KeySettings:Clear("controller", 46, "PosChairX")
            --print("exit")
        end,
        "ssxxxx",
        0.8
    )

    Zone:Add(
        TattoJob2.posTatoo,
        function()
            --print("tattt")
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ s'asseoir")
            KeySettings:Add("keyboard", "E", SeatTatoueur2, "PosTatoueur")
            KeySettings:Add("controller", 46, SeatTatoueur2, "PosTatoueur")
        end,
        function()
            Hint:RemoveAll()
            --print("exit")
            KeySettings:Clear("keyboard", "E", "PosTatoueur")
            KeySettings:Clear("controller", 46, "PosTatoueur")
        end,
        "3612",
        0.8
    )
    local x, y, z
    table.unpack(GetEntityCoords(LocalPlayer().Ped))
    Marker:Add(
        {x = 138.26, y = -1708.48, z = 28.30},
        {
            type = 1,
            scale = {x = 0.5, y = 0.5, z = 0.6},
            color = {r = 255, g = 255, b = 255, a = 120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = GetDistanceBetweenCoords(138.26, -1708.48, 28.30, x, y, z, true)
        }
    )
end

local function Create3()
    --print("create job tatoo")
    Zone:Add(
        TattoJob3.posChair,
        function()
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ s'asseoir")
            KeySettings:Add("keyboard", "E", SeatChair3, "PosChairX")
            KeySettings:Add("controller", 46, SeatChair3, "PosChairX")
            --print("asseoir")
        end,
        function()
            Hint:RemoveAll()
            KeySettings:Clear("keyboard", "E", "PosChairX")
            KeySettings:Clear("controller", 46, "PosChairX")
            --print("exit")
        end,
        "ssxxxx",
        0.8
    )

    Zone:Add(
        TattoJob3.posTatoo,
        function()
            --print("tattt")
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ s'asseoir")
            KeySettings:Add("keyboard", "E", SeatTatoueur3, "PosTatoueur")
            KeySettings:Add("controller", 46, SeatTatoueur3, "PosTatoueur")
        end,
        function()
            Hint:RemoveAll()
            --print("exit")
            KeySettings:Clear("keyboard", "E", "PosTatoueur")
            KeySettings:Clear("controller", 46, "PosTatoueur")
        end,
        "3612",
        0.8
    )
end

local myPLY = 0
RMenu:Get("tatoo", "cut_main").EnableMouse = true

RMenu:Get("tatoo", "cut_main").Closed = function()
    TriggerPlayerEvent("skin:GiveBack", myPLY)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("tatoo", "cut_main")) then
                TriggerPlayerEvent("change:skin", myPLY, skins)
            end
        end
    end
)
local pedPrev
local skinLIST = {"mp_m_freemode_01", "mp_f_freemode_01"}
local skinSexe = {"Homme", "Femme"}
local skinIndex = 1
local function makeAnim()
    TaskPlayAnim(pedPrev, "random@mugging3", "handsup_standing_enter", 2.0, 2.5, -1, 49, 0, 0, 0, 0)
    Wait(100)
    TaskPlayAnim(pedPrev, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0)
end
local function spawnManequin()
    RequestAnimDict("random@mugging3")

    while (not HasAnimDictLoaded("random@mugging3")) do
        Citizen.Wait(1)
    end
    pedPrev = Ora.World.Ped:Create(5, skinLIST[skinIndex], LocalPlayer().Pos, GetEntityHeading(LocalPlayer().Ped))
    SetPedFleeAttributes(pedPrev, 0, 0)
    SetPedKeepTask(pedPrev, true)
    SetBlockingOfNonTemporaryEvents(pedPrev, true)
    if skinSexe[skinIndex] == "Homme" then
        SetPedComponentVariation(pedPrev, 6, 34, 0, 2)
        SetPedComponentVariation(pedPrev, 4, 21, 0, 2)
        SetPedComponentVariation(pedPrev, 11, 15, 0, 2)
        SetPedComponentVariation(pedPrev, 3, 15, 0)
        SetPedComponentVariation(pedPrev, 8, 15, 0, 2)
    else
        SetPedComponentVariation(pedPrev, 8, 15, 0, 2)
        SetPedComponentVariation(pedPrev, 11, 15, 0, 2)
        SetPedComponentVariation(pedPrev, 3, 15, 0, 2)
        SetPedComponentVariation(pedPrev, 4, 14, 0, 2)
        SetPedComponentVariation(pedPrev, 6, 35, 0, 2)
    end
    Citizen.CreateThread(
        function()
            Wait(2000)
            FreezeEntityPosition(pedPrev, true)
            makeAnim()
        end
    )
end
local function respawnSkin()
    local p = pedPrev
    pedPrev = Ora.World.Ped:Create(5, skinLIST[skinIndex], GetEntityCoords(p), GetEntityHeading(p))
    DeleteEntity(p)
    SetPedFleeAttributes(pedPrev, 0, 0)
    SetPedKeepTask(pedPrev, true)
    SetBlockingOfNonTemporaryEvents(pedPrev, true)
    if skinSexe[skinIndex] == "Homme" then
        SetPedComponentVariation(pedPrev, 6, 34, 0, 2)
        SetPedComponentVariation(pedPrev, 4, 21, 0, 2)
        SetPedComponentVariation(pedPrev, 11, 15, 0, 2)
        SetPedComponentVariation(pedPrev, 3, 15, 0)
        SetPedComponentVariation(pedPrev, 8, 15, 0, 2)
    else
        SetPedComponentVariation(pedPrev, 8, 15, 0, 2)
        SetPedComponentVariation(pedPrev, 11, 15, 0, 2)
        SetPedComponentVariation(pedPrev, 3, 15, 0, 2)
        SetPedComponentVariation(pedPrev, 4, 14, 0, 2)
        SetPedComponentVariation(pedPrev, 6, 35, 0, 2)
    end
    Citizen.CreateThread(
        function()
            Wait(2000)
            FreezeEntityPosition(pedPrev, true)
            makeAnim()
        end
    )

    RageUI.Refresh()
end
TatooCat = {
    {name = "Catégorie courses", value = "mpairraces_overlays"},
    {name = "Catégorie buisness", value = "mpbusiness_overlays"},
    {name = "Catégorie hipster", value = "mphipster_overlays"},
    {name = "Catégorie multijoueur", value = "multiplayer_overlays"},
    {name = "Catégorie noël", value = "mpchristmas2_overlays"},
    {name = "Catégorie Noel 2", value = "mpchristmas2017_overlays"},
    {name = "Catégorie Noel 3", value = "mpchristmas2018_overlays"},
    {name = "Catégorie Heist", value = "mpheist3_overlays"},
    {name = "Catégorie Vinewood", value = "mpvinewood_overlays"},
    {name = "Catégorie luxe", value = "mpluxe_overlays"},
    {name = "Catégorie luxe 2", value = "mpluxe2_overlays"},
    {name = "Catégorie lowrider ", value = "mplowrider_overlays"},
    {name = "Catégorie lowrider 2", value = "mplowrider2_overlays"},
    {name = "Catégorie stunt", value = "mpstunt_overlays"},
    {name = "Catégorie biker", value = "mpbiker_overlays"},
    {name = "Catégorie plage", value = "mpbeach_overlays"},
    {name = "Catégorie contrebandier", value = "mpsmuggler_overlays"},
    {name = "Catégorie import-export", value = "mpimportexport_overlays"},
    {name = "Catégorie CayoPerico", value = "mpheist4_overlays"},
    {name = "Catégorie spéciaux", value = "mpgunrunning_overlays"}
}
local index
local indexName
function drawTattoo2(ped, currentHash, collection)
    ClearPedDecorations(ped)
    ApplyPedOverlay(ped, GetHashKey(collection), GetHashKey(currentHash))

    TriggerPlayerEvent(
        "sendTatoo:Data",
        GetPlayerServerIdInDirection(5.0),
        {GetHashKey(collection), GetHashKey(currentHash)}
    )
end

function drawTattoo3(currentHash, collection)
    local sID = GetPlayerServerIdInDirection(5.0)
    TriggerPlayerEvent("sendTatoo:Data2", sID, {GetHashKey(collection), GetHashKey(currentHash)})
end

RegisterNetEvent("sendTatoo:Data2")
AddEventHandler(
    "sendTatoo:Data2",
    function(tatoo)
        -- drawTattoo(tatoo[1],tatoo[2])
        ClearPedDecorations(LocalPlayer().Ped)
        Ora.Player:ApplyAllSavedTattoos(false)
        AddPedDecorationFromHashes(LocalPlayer().Ped, tatoo[1], tatoo[2])
    end
)

RegisterNetEvent("sendTatoo:Data3")
AddEventHandler(
    "sendTatoo:Data3",
    function(tatoo)
        ClearPedDecorations(LocalPlayer().Ped)
        Ora.Player:ApplyAllSavedTattoos(false)
    end
)
RegisterNetEvent("sendTatoo:Data4")
AddEventHandler(
    "sendTatoo:Data4",
    function(tatoo)
        table.insert(currentTattoos, {hash = tatoo[1], dict = tatoo[2]})
        ClearPedDecorations(LocalPlayer().Ped)
        TriggerServerEvent("tatoo:add", currentTattoos)
        Ora.Config:SetDataCollection("PlayerTattoos", currentTattoos)
        Ora.Player:ApplyAllSavedTattoos(false)
    end
)

RegisterNetEvent("sendTatoo:Data")
AddEventHandler(
    "sendTatoo:Data",
    function(tatoo)
        local player = LocalPlayer().Ped
        local playerloc = GetEntityCoords(player)
        local handle, ped = FindFirstPed()
        repeat
            success, ped = FindNextPed(handle)
            local pos = GetEntityCoords(ped)
            local distance =
                GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc["x"], playerloc["y"], playerloc["z"], true)
            if distance < 8.0 then
                if IsPedAPlayer(ped) == false then
                    ClearPedDecorations(ped)
                    AddPedDecorationFromHashes(ped, tatoo[1], tatoo[2])
                end
            end
        until not success
    end
)
local translate = {
    ["ZONE_HEAD"] = "Tête ",
    ["ZONE_LEFT_ARM"] = "Bras gauche ",
    ["ZONE_RIGHT_ARM"] = "Bras droite ",
    ["ZONE_RIGHT_LEG"] = "Jambe droite ",
    ["ZONE_LEFT_LEG"] = "Jambe gauche ",
    ["ZONE_TORSO"] = "Torse "
}
RMenu:Get("tatoo", "category4").Closed = function()
    TriggerPlayerEvent("sendTatoo:Data3", GetPlayerServerIdInDirection(5.0))
    --print("cat4")
end

RMenu:Get("tatoo", "category2").Closed = function()
    --print("cat2")
end
RMenu:Get("tatoo", "category3").Closed = function()
    --print("cat3")
end

Citizen.CreateThread(function()
    Wait(500)
    Create()
    Create2()
    Create3()
    hairstyles = {}
    local newT = nil
    local tattooGun = nil
    while true do
        Wait(1)

        if RageUI.Visible(RMenu:Get("tatoo", "main")) then
            RageUI.DrawContent({header = true, glare = false},function()
                RageUI.Button(not tattooGun and "S'équiper de la machine à tattoo" or "Déposer la machine", nil, {}, true, function(_, _, Selected)
                    if Selected then
                        if not tattooGun then
                            local tattooGunProp = "v_ilev_ta_tatgun"
                            local ped = LocalPlayer().Ped
                            local coords = GetEntityCoords(ped)
                            tattooGun = Ora.World.Object:Create(tattooGunProp, coords, true, true, true)
                            AttachEntityToEntity(tattooGun, ped, GetPedBoneIndex(ped, 18905), 0.15, 0.04, 0.0, 215.0, 0.0, 0.0, true, true, false, true, 1, true)
                        else
                            if DoesEntityExist(tattooGun) then
                                DeleteEntity(tattooGun)
                                tattooGun = nil
                            end
                        end
                    end
                end)

                RageUI.Button("Menu joueur",nil,{},true,function(_, _, Selected)end,RMenu:Get("tatoo", "category3"))

                RageUI.Button(pedPrev == nil and "Faire apparaitre un mannequin" or "Supprimer le mannequin",nil,{},true,function(_, _, Selected)
                    if Selected and pedPrev == nil then
                        spawnManequin()
                    elseif Selected and pedPrev ~= nil then
                        DeleteEntity(pedPrev)
                        pedPrev = nil
                    end
                end)

                RageUI.List("Sexe",skinSexe,skinIndex,nil,{},true,function(Hovered, Active, Selected, Index)
                    if skinIndex ~= Index then
                        skinIndex = Index
                        if pedPrev ~= nil then
                            respawnSkin()
                        end
                    end
                end)

                if pedPrev ~= nil then
                    for i = 1, #TatooCat, 1 do
                        RageUI.Button(TatooCat[i].name,nil,{},true,function(_, _, Selected)
                            if Selected then
                                index = j(TatooCat[i].value)
                                indexName = TatooCat[i].value
                            end
                        end,
                        RMenu:Get("tatoo", "category2")
                        )
                    end
                end
            end,function()
            end)
        end
        if RageUI.Visible(RMenu:Get("tatoo", "category2")) then
            RageUI.DrawContent({header = true, glare = false},function()
                for i = 1, #index, 1 do
                    local label = nil
                    label = GetLabelText(index[i].Name)
                    if label == "NULL" then
                        label = "Tatouage " .. i
                    end
                    RageUI.Button(label,nil,{RightLabel = translate[index[i].Zone] .. "100$"},true,function(_, Active, Selected)
                        if Active and newT ~= index[i].HashNameMale then
                            newT = index[i].HashNameMale
                            drawTattoo2(pedPrev, index[i].HashNameMale, indexName)
                        end
                        -- if Selected then
                        --     local canBuy = Money:CanBuy(5000)
                        --     if canBuy then
                        --         table.insert(currentTattoos,{hash=index[i].HashNameMale,dict=indexName})
                        --         TriggerServerEvent("tatoo:add",currentTattoos)
                        --         TriggerServerEvent("money:Pay", 5000 )
                        --     end
                        -- end
                    end)
                end
            end,function()
            end)
        end
        if RageUI.Visible(RMenu:Get("tatoo", "category3")) then
            RageUI.DrawContent({header = true, glare = false},function()
                for i = 1, #TatooCat, 1 do
                    RageUI.Button(TatooCat[i].name,nil,{},true,function(_, _, Selected)
                        if Selected then
                            index = j(TatooCat[i].value)
                            indexName = TatooCat[i].value
                        end
                    end,RMenu:Get("tatoo", "category4"))
                end
            end,function()
            end)
        end
        if RageUI.Visible(RMenu:Get("tatoo", "category4")) then
            RageUI.DrawContent({header = true, glare = false},function()
                for i = 1, #index, 1 do
                    local label = nil
                    label = GetLabelText(index[i].Name)
                    if label == "NULL" then
                        label = index[i].LocalizedName
                    end

                    RageUI.Button(label,nil,{RightLabel = translate[index[i].Zone] .. "100$"},true,function(_, Active, Selected)
                        if Active and newT ~= index[i].HashNameMale then
                            newT = index[i].HashNameMale
                            drawTattoo3(index[i].HashNameMale, indexName)
                        end
                        if Selected then
                            TriggerPlayerEvent(
                                "sendTatoo:Data4",
                                GetPlayerServerIdInDirection(5.0),
                                {index[i].HashNameMale, indexName}
                            )
                            ShowNotification("~g~Tatouage appliqué")
                        end
                    end)
                end
            end,function()
            end)
        end
    end
end)

-- Citizen.CreateThread(function()
--     while true do
--         Wait(1)
--         if IsControlJustPressed(0, Keys["X"]) then
--             local vehicle = GetVehiclePedIsIn(LocalPlayer().Ped)

--             local _, bool = GetVehicleLightsState(vehicle)
--             --print(bool)
--             if bool then
--                 SetVehicleLights(vehicle,1)
--                 SetVehicleLightsMode(vehicle,0)
--             else
--                 SetVehicleLights(vehicle,2)
--                 SetVehicleLightsMode(vehicle,2)
--             end
--         end
--         if IsControlJustReleased(0, Keys["X"]) then

--             local vehicle = GetVehiclePedIsIn(LocalPlayer().Ped)

--             local _, bool = GetVehicleLightsState(vehicle)
--             if bool then
--                 SetVehicleLights(vehicle,2)
--                 SetVehicleLightsMode(vehicle,2)
--             else
--                 SetVehicleLights(vehicle,1)
--                 SetVehicleLightsMode(vehicle,0)
--             end

--         end
--     end
-- end)
RegisterNetEvent("change:skin")
AddEventHandler("change:skin",function(p)
    updateCheveux(p)
end)

RegisterNetEvent("skin:GiveBack")
AddEventHandler("skin:GiveBack",function()
    TriggerServerCallback("core:GetSKin",function(skin)
        --(dump(skin))
        UpdateEntityFace(LocalPlayer().Ped, json.decode(skin))
    end)
end)
