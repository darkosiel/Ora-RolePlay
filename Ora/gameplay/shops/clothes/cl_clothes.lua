local function j(t)
    return json.decode(t)
end
local male_torso = {
    [0] = 0,
    [1] = 0,
    [2] = 2,
    [3] = 14,
    [4] = 6,
    [5] = 5,
    [6] = 0,
    [7] = 1,
    [8] = 8,
    [9] = 0,
    [10] = 4,
    [11] = 1,
    [12] = 1,
    [13] = 11,
    [14] = 1,
    [15] = 15,
    [16] = 0,
    [17] = 5,
    [18] = 0,
    [19] = 4,
    [20] = 4,
    [21] = 4,
    [22] = 1,
    [23] = 2,
    [24] = 1,
    [25] = 4,
    [26] = 11,
    [27] = 4,
    [28] = 4,
    [29] = 4,
    [30] = 4,
    [31] = 4,
    [32] = 4,
    [33] = 0,
    [34] = 0,
    [35] = 4,
    [36] = 5,
    [37] = 4,
    [38] = 8,
    [39] = 0,
    [40] = 4,
    [41] = 1,
    [42] = 11,
    [43] = 11,
    [44] = 0,
    [45] = 4,
    [46] = 4,
    [47] = 0,
    [48] = 1,
    [49] = 12,
    [50] = 12,
    [51] = 12,
    [52] = 12,
    [53] = 1,
    [54] = 0,
    [55] = 0,
    [56] = 1,
    [57] = 1,
    [58] = 4,
    [59] = 4,
    [60] = 8,
    [61] = 1,
    [62] = 1,
    [63] = 0,
    [64] = 4,
    [65] = 4,
    [66] = 4,
    [67] = 4,
    [68] = 4,
    [69] = 4,
    [70] = 4,
    [71] = 0,
    [72] = 4,
    [73] = 0,
    [74] = 4,
    [75] = 0,
    [76] = 4,
    [77] = 4,
    [78] = 4,
    [79] = 4,
    [80] = 0,
    [81] = 0,
    [82] = 0,
    [83] = 0,
    [84] = 1,
    [85] = 1,
    [86] = 1,
    [87] = 1,
    [88] = 4,
    [89] = 4,
    [90] = 4,
    [91] = 15,
    [92] = 6,
    [93] = 0,
    [94] = 0,
    [95] = 11,
    [96] = 4,
    [97] = 0,
    [98] = 4,
    [99] = 4,
    [100] = 4,
    [101] = 4,
    [102] = 4,
    [103] = 4,
    [104] = 4,
    [105] = 0,
    [106] = 4,
    [107] = 4,
    [108] = 4,
    [109] = 4,
    [110] = 4,
    [111] = 4,
    [112] = 4,
    [113] = 6,
    [114] = 14,
    [115] = 4,
    [116] = 4,
    [117] = 6,
    [118] = 4,
    [119] = 4,
    [120] = 4,
    [121] = 4,
    [122] = 4,
    [123] = 0,
    [124] = 4,
    [125] = 4,
    [126] = 4,
    [127] = 4,
    [128] = 0,
    [129] = 4,
    [130] = 4,
    [131] = 0,
    [132] = 0,
    [133] = 11,
    [134] = 4,
    [135] = 0,
    [136] = 4,
    [137] = 4,
    [138] = 4,
    [139] = 4,
    [140] = 4,
    [141] = 12,
    [142] = 4,
    [143] = 4,
    [144] = 14,
    [145] = 4,
    [146] = 0,
    [147] = 4,
    [148] = 4,
    [149] = 4,
    [150] = 4,
    [151] = 4,
    [152] = 4,
    [153] = 4,
    [154] = 6,
    [155] = 4,
    [156] = 4,
    [157] = 2,
    [158] = 2,
    [159] = 2,
    [160] = 2,
    [161] = 6,
    [162] = 5,
    [163] = 1,
    [164] = 0,
    [165] = 1,
    [166] = 4,
    [167] = 4,
    [168] = 6,
    [169] = 4,
    [170] = 2,
    [171] = 4,
    [172] = 4,
    [173] = 2,
    [174] = 6,
    [175] = 5,
    [176] = 2,
    [177] = 2,
    [178] = 4,
    [179] = 2,
    [180] = 15,
    [181] = 4,
    [182] = 4,
    [183] = 4,
    [184] = 4,
    [185] = 4,
    [186] = 4,
    [187] = 6,
    [188] = 6,
    [189] = 4,
    [190] = 4,
    [191] = 4,
    [192] = 4,
    [193] = 0,
    [194] = 4,
    [195] = 4,
    [196] = 4,
    [197] = 4,
    [198] = 6,
    [199] = 6,
    [200] = 4,
    [201] = 7,
    [202] = 15,
    [203] = 4,
    [204] = 6,
    [205] = 15,
    [206] = 15,
    [207] = 4,
    [208] = 0,
    [209] = 4,
    [210] = 4,
    [211] = 4,
    [212] = 4,
    [213] = 15,
    [214] = 4,
    [215] = 4,
    [216] = 15,
    [217] = 4,
    [218] = 4,
    [219] = 2,
    [220] = 4,
    [221] = 4,
    [222] = 0,
    [223] = 2,
    [224] = 6,
    [225] = 8,
    [226] = 0,
    [227] = 4,
    [228] = 4,
    [229] = 4,
    [230] = 4,
    [231] = 4,
    [232] = 4,
    [233] = 4,
    [234] = 11,
    [235] = 0,
    [236] = 0,
    [237] = 5,
    [238] = 5,
    [239] = 5,
    [240] = 4,
    [241] = 0,
    [242] = 0,
    [243] = 4,
    [244] = 6,
    [245] = 4,
    [246] = 7,
    [247] = 0,
    [248] = 4,
    [249] = 6,
    [250] = 0,
    [251] = 4,
    [252] = 15,
    [253] = 4,
    [254] = 8,
    [255] = 8,
    [256] = 4,
    [257] = 6,
    [258] = 6,
    [259] = 4,
    [260] = 11,
    [261] = 4,
    [262] = 4,
    [263] = 4,
    [264] = 6,
    [265] = 4,
    [266] = 4,
    [267] = 4,
    [268] = 4,
    [269] = 4,
    [270] = 4,
    [271] = 0,
    [272] = 4,
    [273] = 0,
    [274] = 7,
    [275] = 8,
    [276] = 4,
    [277] = 164,
    [278] = 4,
    [279] = 4,
    [280] = 4,
    [281] = 4,
    [282] = 0,
    [283] = 4,
    [284] = 4,
    [285] = 4,
    [286] = 4,
    [287] = 7,
    [288] = 4,
    [289] = 5
}
local tempData = {}
local topToRemoveMale = {
    [4] = true,
    [10] = true,
    [11] = true,
    [19] = true,
    [20] = true,
    [21] = true,
    [23] = true,
    [24] = true,
    [25] = true,
    [27] = true,
    [28] = true,
    [29] = true,
    [30] = true,
    [31] = true,
    [32] = true,
    [40] = true,
    [45] = true,
    [46] = true,
    [49] = true,
    [53] = true,
    [55] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [72] = true,
    [74] = true,
    [75] = true,
    [76] = true,
    [77] = true,
    [78] = true,
    [80] = true,
    [93] = true,
    [94] = true,
    [99] = true,
    [100] = true,
    [101] = true,
    [102] = true,
    [103] = true,
    [104] = true,
    [108] = true,
    [112] = true,
    [115] = true,
    [116] = true,
    [118] = true,
    [119] = true,
    [120] = true,
    [140] = true,
    [142] = true,
    [149] = true,
    [155] = true,
    [183] = true,
    [186] = true,
    [187] = true,
    [190] = true,
    [192] = true,
    [193] = true,
    [200] = true,
    [208] = true,
    [209] = true,
    [212] = true,
    [219] = true,
    [257] = true,
    [259] = true,
    [271] = true,
    [290] = true,
    [292] = true,
    [293] = true,
    [294] = true,
    [295] = true,
    [302] = true,
    [303] = true,
    [304] = true,
    [305] = true,
    [306] = true,
    [307] = true,
    [310] = true,
    [311] = true,
    [312] = true,
    [314] = true,
    [315] = true,
    [316] = true,
    [317] = true,
    [318] = true,
    [319] = true,
    [320] = true,
    [321] = true,
    [322] = true,
    [348] = true,
    [349] = true
}
local botToRemoveMale = {
    [10] = true,
    [13] = true,
    [19] = true,
    [20] = true,
    [22] = true,
    [23] = true,
    [24] = true,
    [25] = true,
    [28] = true,
    [31] = true,
    [32] = true,
    [35] = true,
    [37] = true,
    [45] = true,
    [48] = true,
    [50] = true,
    [51] = true,
    [53] = true,
    [60] = true,
    [84] = true,
    [96] = true,
    [116] = true,
    [118] = true,
    [119] = true,
    [120] = true,
    [121] = true,
    [125] = true
}
local chaussureToRemoveMale = {
    [10] = true,
    [18] = true,
    [19] = true,
    [20] = true,
    [21] = true,
    [23] = true,
    [30] = true,
    [40] = true
}
local accessToRemoveMale = {
    [5] = true,
    [6] = true,
    [39] = true,
    [41] = true,
    [119] = true,
    [120] = true,
    [125] = true,
    [126] = true,
    [127] = true,
    [128] = true
}
local chapeauToRemoveMale = {
    [1] = true,
    [3] = true,
    [6] = true,
    [37] = true,
    [66] = true,
    [69] = true,
    [70] = true,
    [129] = true,
    [130] = true,
    [141] = true
}

topToRemoveFemale = {
    [6] = true,
    [7] = true,
    [12] = true,
    [13] = true,
    [18] = true,
    [20] = true,
    [21] = true,
    [22] = true,
    [24] = true,
    [25] = true,
    [26] = true,
    [27] = true,
    [28] = true,
    [29] = true,
    [30] = true,
    [34] = true,
    [35] = true,
    [36] = true,
    [37] = true,
    [39] = true,
    [42] = true,
    [44] = true,
    [48] = true,
    [51] = true,
    [52] = true,
    [53] = true,
    [57] = true,
    [58] = true,
    [64] = true,
    [66] = true,
    [68] = true,
    [70] = true,
    [71] = true,
    [84] = true,
    [85] = true,
    [90] = true,
    [91] = true,
    [92] = true,
    [93] = true,
    [94] = true,
    [95] = true,
    [99] = true,
    [104] = true,
    [107] = true,
    [111] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [115] = true,
    [116] = true,
    [124] = true,
    [137] = true,
    [139] = true,
    [151] = true,
    [172] = true,
    [188] = true,
    [192] = true,
    [194] = true,
    [195] = true,
    [200] = true,
    [202] = true,
    [221] = true,
    [225] = true,
    [226] = true,
    [254] = true,
    [266] = true,
    [268] = true,
    [280] = true,
    [281] = true,
    [284] = true,
    [303] = true,
    [304] = true,
    [305] = true,
    [306] = true,
    [307] = true,
    [315] = true,
    [318] = true,
    [321] = true,
    [323] = true,
    [324] = true,
    [325] = true,
    [326] = true,
    [327] = true,
    [328] = true,
    [329] = true,
    [330] = true,
    [331] = true,
    [332] = true,
    [333] = true,
    [334] = true,
    [335] = true,
    [336] = true,
    [337] = true,
    [339] = true,
    [340] = true,
    [341] = true,
    [366] = true,
    [367] = true,
    [377] = true
}
local botToRemoveFemale = {
    [3] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [12] = true,
    [18] = true,
    [23] = true,
    [24] = true,
    [26] = true,
    [28] = true,
    [30] = true,
    [31] = true,
    [34] = true,
    [36] = true,
    [37] = true,
    [41] = true,
    [50] = true,
    [52] = true,
    [53] = true,
    [64] = true,
    [65] = true,
    [86] = true,
    [108] = true,
    [111] = true,
    [124] = true,
    [125] = true,
    [126] = true,
    [127] = true,
    [132] = true,
    [134] = true
}
local chaussureToRemoveFemale = {
    [6] = true,
    [7] = true,
    [8] = true,
    [14] = true,
    [18] = true,
    [19] = true,
    [20] = true,
    [22] = true,
    [23] = true,
    [30] = true,
    [41] = true,
    [42] = true,
    [43] = true,
    [44] = true,
    [77] = true,
    [102] = true
}
local accessToRemoveFemale = {
    [5] = true,
    [14] = true,
    [16] = true,
    [25] = true,
    [88] = true,
    [89] = true,
    [95] = true,
    [96] = true,
    [97] = true,
    [98] = true
}

local chapeauToRemoveMale = {
    [1] = true,
    [8] = true,
    [45] = true,
    [47] = true,
    [48] = true,
    [77] = true,
    [78] = true,
    [137] = true,
    [138] = true
}
local braseditInd = 1
local tshirt1 = 1
local tshirt2 = 1
local Clothes = {
    pricePerClothes = 50,
    config_clothes = {
        {x = 72.254, y = -1399.102, z = 28.376},
        {x = -167.52, y = -299.31, z = 38.73},
        {x = 428.694, y = -800.106, z = 28.491},
        -- {x = -829.413, y = -1073.710, z = 10.328}, --Bincojob
        {x = -1447.797, y = -242.461, z = 48.820},
        {x = 11.632, y = 6514.224, z = 30.877},
        {x = 123.646, y = -219.440, z = 53.557},
        {x = 1696.291, y = 4829.312, z = 41.063},
        -- {x = 618.093, y = 2759.629, z = 41.088}, -- Binco Nord
        {x = 1190.550, y = 2713.441, z = 37.222},
        {x = -1193.429, y = -772.262, z = 16.324},
        {x = -3172.496, y = 1048.133, z = 19.863},
        {x = -1108.441, y = 2708.923, z = 18.107}
    },
    category = {
        {
            label = "Haut",
            component = 11,
            type = 0,
            staticM = j(Config.Haut),
            staticF = j(Config.HautF),
            remM = topToRemoveMale,
            remF = topToRemoveFemale
        },
        {
            label = "Pantalon",
            component = 4,
            type = 0,
            staticM = j(Config.Pant),
            staticF = j(Config.PantF),
            remM = botToRemoveMale,
            remF = botToRemoveFemale
        },
        {
            label = "Chaussures",
            component = 6,
            type = 0,
            staticM = j(Config.Shoes),
            staticF = j(Config.ShoesF),
            remM = chaussureToRemoveMale,
            remF = chaussureToRemoveFemale
        },
        {
            label = "Accessoires",
            component = 7,
            type = 0,
            staticM = j(Config.Accessories),
            staticF = j(Config.AccessoriesF),
            remM = accessToRemoveMale,
            remF = accessToRemoveFemale
        },
        {
            label = "Chapeau",
            component = 0,
            type = 1,
            staticM = j(Config.Hats),
            staticF = j(Config.HatsF),
            remM = chapeauToRemoveMale,
            remF = chapeauToRemoveFemale
        },
        {label = "Lunettes", component = 1, type = 1, staticM = j(Config.Glasses), staticF = j(Config.GlassesF)},
        {
            label = "Oreilles",
            component = 2,
            type = 1,
            staticM = json.decode(Config.Ears),
            staticF = json.decode(Config.EarsF)
        },
        {
            label = "Montres",
            component = 6,
            type = 1,
            staticM = json.decode(Config.Watches),
            staticF = json.decode(Config.WatchesF)
        },
        {label = "Sac", component = 5, type = 0, staticM = {}, staticF = {}}
    }
}

local currentPositionPedProps = {}
local currentPositionPedPropsTexture = {}

function Clothes.CreateShops()
    for i = 1, #Clothes.config_clothes, 1 do
        local v = Clothes.config_clothes[i]
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 73)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 17)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Magasin de vêtement")
        EndTextCommandSetBlipName(blip)
        Blips:AddBlip(blip, "Magasin", v.Blips)
        v.Pos = {x = v.x, y = v.y, z = v.z}
        Zone:Add(v.Pos, Clothes.EnterZone, Clothes.ExitZone, i, 2.5)
        RMenu.Add(
            "clothesSHOP",
            i,
            RageUI.CreateMenu(nil, "Objets disponibles", 10, 100, "shopui_title_midfashion", "shopui_title_midfashion")
        )
        RMenu.Add(
            "clothesSHOP",
            "my_clothes_" .. i,
            RageUI.CreateSubMenu(RMenu:Get("clothesSHOP", i), nil, "Inventaire")
        )
        RMenu.Add(
            "clothesSHOP",
            "custom_clothes_" .. i,
            RageUI.CreateSubMenu(RMenu:Get("clothesSHOP", "my_clothes_" .. i), nil, "Modifier un vêtement")
        )
        RMenu.Add(
            "clothesSHOP",
            "clothes_chooser_" .. i,
            RageUI.CreateSubMenu(RMenu:Get("clothesSHOP", i), nil, "Vêtements disponibles")
        )
        RMenu.Add(
            "clothesSHOP",
            "ped_clothes_" .. i,
            RageUI.CreateSubMenu(RMenu:Get("clothesSHOP", i), nil, "Changer mes vetements")
        )
        RMenu.Add(
            "clothesSHOP",
            "ped_accessories_" .. i,
            RageUI.CreateSubMenu(RMenu:Get("clothesSHOP", i), nil, "Changer mes accessoires")
        )
        RMenu:Get("clothesSHOP", i).Closed = function()
            Clothes.static = {}
            RefreshClothes()
        end
    end

    RMenu.Add(
        "clothesSHOP",
        "topChooser",
        RageUI.CreateMenu(nil, "Variation disponibles", 10, 100, "shopui_title_midfashion", "shopui_title_midfashion")
    )
end
local ixixi = 0
local CurrentZone = nil
function Clothes.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard", "E", Clothes.Open, "Shop")
    KeySettings:Add("controller", 46, Clothes.Open, "Shop")
    CurrentZone = zone
end

function Clothes.ExitZone()
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        if RageUI.Visible(RMenu:Get("clothesSHOP", CurrentZone)) then
            RageUI.Visible(
                RMenu:Get("clothesSHOP", CurrentZone),
                not RageUI.Visible(RMenu:Get("clothesSHOP", CurrentZone))
            )
        end
        KeySettings:Clear("keyboard", "E", "Shop")
        CurrentZone = nil

        RefreshClothes()
    end
end

function Clothes.Open()
    RageUI.Visible(RMenu:Get("clothesSHOP", CurrentZone), not RageUI.Visible(RMenu:Get("clothesSHOP", CurrentZone)))
end
function AmIPed()
    if
        GetEntityModel(LocalPlayer().Ped) == GetHashKey("mp_m_freemode_01") or
            GetEntityModel(LocalPlayer().Ped) == GetHashKey("mp_f_freemode_01")
     then
        return false
    else
        return true
    end
end

Clothes.CreateShops()
local oldClothes = nil
local oldVar = nil
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            --print(LocalPlayer().FarmLimit )
            if RageUI.Visible(RMenu:Get("clothesSHOP", "topChooser")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local am = {}
                        for i = 1, GetNumberOfPedDrawableVariations(LocalPlayer().Ped, 3), 1 do
                            am[i] = i
                        end
                        RageUI.List(
                            "Bras",
                            am,
                            braseditInd,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                braseditInd = Index

                                if Active then
                                    SetPedComponentVariation(LocalPlayer().Ped, 3, Index - 1, 0, 2)
                                end
                            end
                        )
                        local am = {}
                        for i = 1, GetNumberOfPedDrawableVariations(LocalPlayer().Ped, 8), 1 do
                            am[i] = i
                        end
                        RageUI.List(
                            "T-shirt",
                            am,
                            tshirt1,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                if tshirt1 ~= Index then
                                    tshirt1 = Index
                                    tshirt2 = 1
                                    if Active then
                                        SetPedComponentVariation(LocalPlayer().Ped, 8, tshirt1 - 1, tshirt2 - 1, 2)
                                    end
                                end
                            end
                        )
                        local am = {}
                        for i = 1, GetNumberOfPedTextureVariations(LocalPlayer().Ped, 8, tshirt1), 1 do
                            am[i] = i
                        end
                        RageUI.List(
                            "T-shirt 2",
                            am,
                            tshirt2,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                tshirt2 = Index

                                if Active then
                                    SetPedComponentVariation(LocalPlayer().Ped, 8, tshirt1 - 1, tshirt2 - 1, 2)
                                end
                            end
                        )
                        RageUI.Button(
                            "Acheter",
                            nil,
                            {},
                            true,
                            function(_, _, S)
                                if S then
                                    dataonWait = {
                                        title = "Achat vêtement",
                                        price = Clothes.pricePerClothes,
                                        fct = function()
                                            tempData.data.bras = braseditInd - 1
                                            tempData.data.h = tshirt1 - 1
                                            tempData.data.hV = tshirt2 - 1
                                            Ora.Inventory:AddItem(tempData)
                                        end
                                    }
                                    CloseAllMenus()
                                    TriggerEvent("payWith?")
                                end
                            end
                        )
                    end
                )
            end
            if CurrentZone ~= nil then
                if RageUI.Visible(RMenu:Get("clothesSHOP", "clothes_chooser_" .. CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            local label = nil
                            local amount = {}
                            local blackListedClothes = {}

                            if Ora.World.Ped:IsPedMale(LocalPlayer().Ped) then
                                blackListedClothes = Clothes.remM
                            else
                                blackListedClothes = Clothes.remF
                            end

                            if (Clothes.CACHE == nil) then
                                Clothes.CACHE = {}
                            end

                            if (Clothes.CACHE[Clothes.component] == nil) then
                                Clothes.CACHE[Clothes.component] = {LOADED = false, LIST = {}}
                            end

                            if (Clothes.CACHE[Clothes.component].LOADED == false) then
                                Clothes.CACHE[Clothes.component].LOADED = true

                                if (Clothes.component == 5) then
                                    for bagIndex = 0,  GetNumberOfPedDrawableVariations(LocalPlayer().Ped, 5), 1 do 
                                        if (Clothes.static[tostring(bagIndex)] == nil) then
                                            Clothes.static[tostring(bagIndex)] = {}
                                        end

                                        local numberOfVariations = GetNumberOfPedTextureVariations(LocalPlayer().Ped, 5, bagIndex)
                                    
                                        if (numberOfVariations > 1) then
                                            for y = 0, GetNumberOfPedTextureVariations(LocalPlayer().Ped, 5, bagIndex) - 1, 1 do 
                                                Clothes.static[tostring(bagIndex)][tostring(y)] = {Label = "Sac #" .. bagIndex}
                                            end
                                        else
                                            Clothes.static[tostring(bagIndex)][tostring(0)] = {Label = "Sac #" .. bagIndex}
                                        end

                                       
                                    end
                                end
                                
                                for clotheKey, clotheValue in pairs(Clothes.static) do
                                    local clotheKeyInteger = math.tointeger(clotheKey)
                                    if (blackListedClothes == nil or blackListedClothes[clotheKeyInteger] == nil) then
                                        if Clothes.CACHE[Clothes.component].LIST[clotheKeyInteger] == nil then
                                            Clothes.CACHE[Clothes.component].LIST[clotheKeyInteger] = {
                                                CURRENT = 1,
                                                LIST_RAW = {}
                                            }
                                        end

                                        for singleClotheKey, singleValue in pairs(clotheValue) do
                                            label = "Vêtements #" .. clotheKey .. " - " .. singleClotheKey
                                            if singleValue["GXT"] ~= nil then
                                                label = GetLabelText(singleValue["GXT"])
                                                if (label == "NULL") then
                                                    label = "Vêtements #" .. clotheKey .. " - " .. singleClotheKey
                                                else
                                                    label = label .. " #" .. singleClotheKey
                                                end
                                            elseif (singleValue["Label"] ~= nil) then
                                                label = singleValue["Label"]
                                            end

                                            if (Clothes.CACHE[Clothes.component].LIST[clotheKeyInteger].LIST_RAW[clotheKeyInteger] == nil) then
                                                Clothes.CACHE[Clothes.component].LIST[clotheKeyInteger].LIST_RAW[clotheKeyInteger] = {}
                                            end

                                            table.insert(Clothes.CACHE[Clothes.component].LIST[clotheKeyInteger].LIST_RAW[clotheKeyInteger], {Label = label, Name = singleClotheKey, Value = singleValue, ComponentVariation = math.tointeger(singleClotheKey)})
                                        end
                                    end
                                end

                            end

                            for clotheKey, clotheValue in pairs(Clothes.CACHE[Clothes.component].LIST) do
                                local clotheKeyInteger = math.tointeger(clotheKey)

                                RageUI.List(
                                    clotheValue.LIST_RAW[clotheKeyInteger][clotheValue.CURRENT].Label,
                                    clotheValue.LIST_RAW[clotheKeyInteger],
                                    clotheValue.CURRENT,
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected, Index)
                                        Clothes.CACHE[Clothes.component].LIST[clotheKeyInteger].CURRENT = Index
                                        if Active then
                                            if oldClothes ~= clotheKeyInteger or oldVar ~= Index - 1 then
                                                -- print("CURRENT KEY " .. clotheKey)
                                                if Clothes.type == 0 then
                                                    SetPedComponentVariation(
                                                        LocalPlayer().Ped,
                                                        Clothes.component,
                                                        clotheKeyInteger,
                                                        clotheValue.LIST_RAW[clotheKeyInteger][clotheValue.CURRENT].ComponentVariation
                                                    )

                                                    oldClothes = clotheKey
                                                    oldVar = Index - 1
                                                    if Clothes.component == 11 then
                                                        SetPedComponentVariation(
                                                            LocalPlayer().Ped,
                                                            3,
                                                            male_torso[clotheKeyInteger],
                                                            0
                                                        )
                                                    end
                                                else
                                                    SetPedPropIndex(
                                                        LocalPlayer().Ped,
                                                        Clothes.component,
                                                        clotheKeyInteger,
                                                        clotheValue.LIST_RAW[clotheKeyInteger][clotheValue.CURRENT].ComponentVariation
                                                    )
                                                    oldClothes = clotheKeyInteger
                                                    oldVar = Index - 1
                                                end
                                            end
                                        end
                                        if Selected then
                                            local uuu = label
                                            if Clothes.type == 0 then
                                                if Ora.Inventory:CanReceive("clothe", 1) then
                                                    if Clothes.component == 11 then
                                                        tempData = {
                                                            name = "clothe",
                                                            data = {
                                                                component = Clothes.component,
                                                                type = Clothes.type,
                                                                sex = m,
                                                                equiped = false,
                                                                var = clotheKeyInteger,
                                                                ind = clotheValue.LIST_RAW[clotheKeyInteger][clotheValue.CURRENT].ComponentVariation,
                                                                data = male_torso[clotheKeyInteger],
                                                                h = 15,
                                                                hv = 0
                                                            },
                                                            label = clotheValue.LIST_RAW[clotheKeyInteger][clotheValue.CURRENT].Label
                                                        }
                                                    else
                                                        dataonWait = {
                                                            title = "Achat vêtement",
                                                            price = Clothes.pricePerClothes,
                                                            fct = function()
                                                                local m = "female"
                                                                if Ora.World.Ped:IsPedMale(LocalPlayer().Ped) then
                                                                    m = "male"
                                                                end
                                                                items = {
                                                                    name = "clothe",
                                                                    data = {
                                                                        component = Clothes.component,
                                                                        type = Clothes.type,
                                                                        sex = m,
                                                                        equiped = false,
                                                                        var = clotheKeyInteger,
                                                                        ind = clotheValue.LIST_RAW[clotheKeyInteger][clotheValue.CURRENT].ComponentVariation,
                                                                        data = male_torso[clotheKeyInteger],
                                                                        h = 15,
                                                                        hv = 0
                                                                    },
                                                                    label = clotheValue.LIST_RAW[clotheKeyInteger][clotheValue.CURRENT].Label
                                                                }
                                                                Ora.Inventory:AddItem(items)
                                                            end
                                                        }
                                                        CloseAllMenus()
                                                        TriggerEvent("payWith?")
                                                    end
                                                end
                                            else
                                                if Ora.Inventory:CanReceive("access", 1) then
                                                    dataonWait = {
                                                        title = "Achat accessoires",
                                                        price = Clothes.pricePerClothes,
                                                        fct = function()
                                                            local m = "female"
                                                            if Ora.World.Ped:IsPedMale(LocalPlayer().Ped) then
                                                                m = "male"
                                                            end
                                                            items = {
                                                                name = "access",
                                                                data = {
                                                                    component = Clothes.component,
                                                                    type = Clothes.type,
                                                                    sex = m,
                                                                    equiped = false,
                                                                    var = clotheKeyInteger,
                                                                    ind = clotheValue.LIST_RAW[clotheKeyInteger][clotheValue.CURRENT].ComponentVariation,
                                                                },
                                                                label = clotheValue.LIST_RAW[clotheKeyInteger][clotheValue.CURRENT].Label
                                                            }
                                                            Ora.Inventory:AddItem(items)
                                                        end
                                                    }
                                                    CloseAllMenus()
                                                    TriggerEvent("payWith?")
                                                end
                                            end
                                        end
                                    end,
                                    Clothes.component == 11 and RMenu:Get("clothesSHOP", "topChooser") or nil
                                )

                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("clothesSHOP", "ped_clothes_" .. CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            for i = 0, 11, 1 do
                                local m = {}

                                for i = 0, GetNumberOfPedDrawableVariations(LocalPlayer().Ped, i) do
                                    m[i + 1] = i + 1
                                end
                                if #m ~= 0 then
                                    if (GetPedDrawableVariation(LocalPlayer().Ped, i) + 1 >= 1) then
                                        RageUI.List(
                                            "Variation " .. i,
                                            m,
                                            GetPedDrawableVariation(LocalPlayer().Ped, i) + 1,
                                            GetLabelText("FACE_APP_H"),
                                            {},
                                            true,
                                            function(Hovered, Active, Selected, Index)
                                                if Active then
                                                    if Index - 1 ~= GetPedDrawableVariation(LocalPlayer().Ped, i) then
                                                        SetPedComponentVariation(LocalPlayer().Ped, i, Index - 1, 0, 0)
                                                    end
                                                end
                                            end
                                        )
                                    end

                                    local x = {}
                                    for t = 0, GetNumberOfPedTextureVariations(
                                        LocalPlayer().Ped,
                                        i,
                                        GetPedDrawableVariation(LocalPlayer().Ped, i)
                                    ) - 1, 1 do
                                        table.insert(x, t)
                                    end
                                    if tablelength(x) > 1 then
                                        RageUI.List(
                                            "Texture " .. i,
                                            x,
                                            GetPedTextureVariation(LocalPlayer().Ped, i) + 1,
                                            GetLabelText("FACE_APP_H"),
                                            {},
                                            true,
                                            function(Hovered, Active, Selected, Index)
                                                if Active then
                                                    if Index - 1 ~= GetPedTextureVariation(LocalPlayer().Ped, i) then
                                                        SetPedComponentVariation(
                                                            LocalPlayer().Ped,
                                                            i,
                                                            GetPedDrawableVariation(LocalPlayer().Ped, i),
                                                            Index - 1,
                                                            0
                                                        )
                                                    end
                                                end
                                            end
                                        )
                                    end
                                end
                            end

                            RageUI.Button(
                                "Sauvegarder",
                                nil,
                                {},
                                true,
                                function(_, _, S)
                                    if S then
                                        local Skin = {}
                                        for i = 0, 12, 1 do
                                            Skin[i] = {
                                                v = GetPedDrawableVariation(LocalPlayer().Ped, i),
                                                c = GetPedTextureVariation(LocalPlayer().Ped, i)
                                            }
                                        end
                                        TriggerServerEvent("face:Save", Skin)
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("clothesSHOP", "ped_accessories_" .. CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            local precomponentTable = {
                                "Casques / Chapeaux",
                                "Lunettes",
                                "Accessoires d'oreilles",
                                "-- VIDE --",
                                "-- VIDE --",
                                "-- VIDE --",
                                "Poignet gauche",
                                "Poignet droits"
                            }

                            local componentTable = {}
                            for i = 0, 7 do
                                if
                                    GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), i) ~= 0 and
                                        GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), i) ~= false
                                 then
                                    componentTable[i + 1] = precomponentTable[i + 1]
                                end
                            end

                            for keyComponent, valueComponent in pairs(componentTable) do
                                if (currentPositionPedProps[keyComponent] == nil) then
                                    currentPositionPedProps[keyComponent] = 1
                                end

                                if (currentPositionPedPropsTexture[keyComponent] == nil) then
                                    currentPositionPedPropsTexture[keyComponent] = 0
                                end

                                local subComponentScroller =
                                    GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1), keyComponent - 1)
                                local componentElements = {"Sans rien"}

                                for loopCount = 1, subComponentScroller, 1 do
                                    table.insert(componentElements, "Item " .. loopCount)
                                end

                                RageUI.List(
                                    valueComponent,
                                    componentElements,
                                    currentPositionPedProps[keyComponent],
                                    nil,
                                    {},
                                    true,
                                    function(Hovered, Active, Selected, Index)
                                        if Active then
                                            currentPositionPedProps[keyComponent] = Index

                                            if Index == 1 then
                                                ClearPedProp(LocalPlayer().Ped, tonumber(keyComponent - 1))
                                            else
                                                SetPedPropIndex(GetPlayerPed(-1), keyComponent - 1, Index - 2, 240, 0)
                                                SetPedPropIndex(
                                                    GetPlayerPed(-1),
                                                    keyComponent - 1,
                                                    Index - 2,
                                                    currentPositionPedPropsTexture[keyComponent],
                                                    false
                                                )
                                            end
                                        end

                                        if Selected then
                                            if
                                                (GetNumberOfPedPropTextureVariations(
                                                    LocalPlayer().Ped,
                                                    tonumber(keyComponent - 1),
                                                    Index - 2
                                                ))
                                             then
                                                local maxVariation =
                                                    GetNumberOfPedPropTextureVariations(
                                                    LocalPlayer().Ped,
                                                    tonumber(keyComponent - 1),
                                                    Index - 2
                                                )

                                                if (currentPositionPedPropsTexture[keyComponent] < maxVariation) then
                                                    currentPositionPedPropsTexture[keyComponent] =
                                                        currentPositionPedPropsTexture[keyComponent] + 1
                                                else
                                                    currentPositionPedPropsTexture[keyComponent] = 0
                                                end
                                            end
                                        end
                                    end
                                )
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("clothesSHOP", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            if not AmIPed() then
                                -- RageUI.Button("Modifier un vêtement", nil, {}, true, function(_, _, S)

                                -- end,RMenu:Get('clothesSHOP', "my_clothes_"..CurrentZone))
                                for i = 1, #Clothes.category, 1 do
                                    RageUI.Button(
                                        Clothes.category[i].label,
                                        nil,
                                        {},
                                        true,
                                        function(_, _, S)
                                            if S then
                                                RMenu:Get("clothesSHOP", "clothes_chooser_" .. CurrentZone).Index = 1
                                                Clothes.component = Clothes.category[i].component
                                                Clothes.type = Clothes.category[i].type
                                                Clothes.remM = Clothes.category[i].remM
                                                Clothes.remF = Clothes.category[i].remF

                                                Clothes.listLabel = {}
                                                if Clothes.type == 0 then
                                                    Clothes.amount =
                                                        GetNumberOfPedDrawableVariations(
                                                        LocalPlayer().Ped,
                                                        Clothes.component
                                                    )
                                                else
                                                    Clothes.amount =
                                                        GetNumberOfPedPropDrawableVariations(
                                                        LocalPlayer().Ped,
                                                        Clothes.component
                                                    )
                                                end
                                                if Ora.World.Ped:IsPedMale(LocalPlayer().Ped) then
                                                    Clothes.static = Clothes.category[i].staticM
                                                else
                                                    Clothes.static = Clothes.category[i].staticF
                                                end
                                                Clothes.Indexes = {}
                                                for i = 1, #Clothes.static, 1 do
                                                    Clothes.Indexes[i] = 1
                                                end
                                            end
                                        end,
                                        RMenu:Get("clothesSHOP", "clothes_chooser_" .. CurrentZone)
                                    )
                                end
                            else
                                RageUI.Button(
                                    "Modifier mes vetements",
                                    nil,
                                    {RightLabel = ""},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                        end
                                    end,
                                    RMenu:Get("clothesSHOP", "ped_clothes_" .. CurrentZone)
                                )
                                RageUI.Button(
                                    "Modifier mes composants",
                                    nil,
                                    {RightLabel = ""},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                        end
                                    end,
                                    RMenu:Get("clothesSHOP", "ped_accessories_" .. CurrentZone)
                                )
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("clothesSHOP", "custom_clothes_" .. CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            local am = {}
                            for i = 1, GetNumberOfPedDrawableVariations(LocalPlayer().Ped, 3), 1 do
                                am[i] = i
                            end
                            RageUI.List(
                                "Bras",
                                am,
                                braseditInd,
                                nil,
                                {},
                                true,
                                function(Hovered, Active, Selected, Index)
                                    braseditInd = Index

                                    if Active then
                                        SetPedComponentVariation(LocalPlayer().Ped, 3, Index, 0, 2)
                                    end
                                end
                            )
                            local am = {}
                            for i = 0, GetNumberOfPedDrawableVariations(LocalPlayer().Ped, 8), 1 do
                                am[i] = i
                            end
                            RageUI.List(
                                "T-shirt",
                                am,
                                tshirt1,
                                nil,
                                {},
                                true,
                                function(Hovered, Active, Selected, Index)
                                    if tshirt1 ~= Index then
                                        tshirt1 = Index
                                        tshirt2 = 0
                                        if Active then
                                            SetPedComponentVariation(LocalPlayer().Ped, 8, tshirt1, tshirt2, 2)
                                        end
                                    end
                                end
                            )
                            local am = {}
                            for i = 0, GetNumberOfPedTextureVariations(LocalPlayer().Ped, 8, tshirt1), 1 do
                                am[i] = i
                            end
                            RageUI.List(
                                "T-shirt 2",
                                am,
                                tshirt2,
                                nil,
                                {},
                                true,
                                function(Hovered, Active, Selected, Index)
                                    tshirt2 = Index

                                    if Active then
                                        SetPedComponentVariation(LocalPlayer().Ped, 8, tshirt1, tshirt2, 2)
                                    end
                                end
                            )
                            RageUI.Button(
                                "Sauvegarder",
                                nil,
                                {},
                                true,
                                function(_, _, S)
                                    if S then
                                        Ora.Inventory.Data["clothe"][ixixi].data.bras = braseditInd - 1
                                        Ora.Inventory.Data["clothe"][ixixi].data.h = tshirt1 - 1
                                        Ora.Inventory.Data["clothe"][ixixi].data.hV = tshirt2 - 1
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("clothesSHOP", "my_clothes_" .. CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            local count = 0
                            if tableCount(Ora.Inventory:GetInventory()) == 0 then
                                RageUI.Button(
                                    "Vide",
                                    nil,
                                    {},
                                    true,
                                    function()
                                    end
                                )
                            else
                                for k, v in pairs(Ora.Inventory:GetInventory()) do
                                    if k == "clothe" then
                                        for i = 1, #v, 1 do
                                            if v[i].label == nil then
                                                v[i].label = ""
                                            end
                                            if v[i].data.component == 11 then
                                                RageUI.Button(
                                                    Items[k].label .. " : " .. v[i].label,
                                                    nil,
                                                    {RightLabel},
                                                    true,
                                                    function(_, _, Selected)
                                                        if Selected then
                                                            ixixi = i
                                                            braseditInd = v[i].data.bras or 1
                                                            tshirt1 = v[i].data.h or 1
                                                            tshirt2 = v[i].data.hV or 1
                                                            SetPedComponentVariation(
                                                                LocalPlayer().Ped,
                                                                11,
                                                                v[i].data.var,
                                                                v[i].data.ind
                                                            )
                                                        end
                                                    end,
                                                    RMenu:Get("clothesSHOP", "custom_clothes_" .. CurrentZone)
                                                )
                                                count = count + 1
                                            end
                                        end
                                    end
                                end
                                if count == 0 then
                                    RageUI.Button(
                                        "Vide",
                                        nil,
                                        {},
                                        true,
                                        function()
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
    end
)

local masks = {
    Pos = {x = -1336.49, y = -1277.66, z = 4.87, h = 102.23},
    PedModel = "a_m_m_afriamer_01",
    array = json.decode(Config.MaskName),
    Indexes = {},
    price = 100
}
function masks.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique de vêtement")
    KeySettings:Add("keyboard", "E", masks.Open, "Shop")
    KeySettings:Add("controller", 46, masks.Open, "Shop")
end

function masks.ExitZone()
    Hint:RemoveAll()
    if RageUI.Visible(RMenu:Get("masks", "main")) then
        RageUI.Visible(RMenu:Get("masks", "main"), not RageUI.Visible(RMenu:Get("masks", "main")))
    end
    RefreshClothes()
    KeySettings:Clear("keyboard", "E", "Shop")
    CurrentZone = nil
end

function masks.Open()
    RageUI.Visible(RMenu:Get("masks", "main"), not RageUI.Visible(RMenu:Get("masks", "main")))
    playerPed = LocalPlayer().Ped
    for i = 0, GetNumberOfPedDrawableVariations(playerPed, 1) - 1, 1 do
        masks.Indexes[i] = 1
    end
end
function masks.Create()
    local blip = AddBlipForCoord(masks.Pos.x, masks.Pos.y, masks.Pos.z)
    SetBlipSprite(blip, 362)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 83)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Magasin de masques")
    EndTextCommandSetBlipName(blip)

    Zone:Add(masks.Pos, masks.EnterZone, masks.ExitZone, i, 2.5)
    RMenu.Add(
        "masks",
        "main",
        RageUI.CreateMenu(nil, "Masques disponibles", 10, 100, "shopui_title_movie_masks", "shopui_title_movie_masks")
    )
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("masks", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        playerPed = LocalPlayer().Ped
                        for i = 0, GetNumberOfPedDrawableVariations(playerPed, 1) - 1, 1 do
                            amount = {}
                            for c = 1, GetNumberOfPedTextureVariations(playerPed, 1, i), 1 do
                                amount[c] = c
                            end
                            label = "Non définie"

                            if
                                (masks.array[tostring(i)] ~= nil and
                                    masks.array[tostring(i)][tostring(masks.Indexes[i] - 1)] ~= nil and
                                    masks.array[tostring(i)][tostring(masks.Indexes[i] - 1)]["GXT"] ~= nil)
                             then
                                label = GetLabelText(masks.array[tostring(i)][tostring(masks.Indexes[i] - 1)]["GXT"])
                            end

                            if label ~= "NULL" then
                                RageUI.List(
                                    label,
                                    amount,
                                    masks.Indexes[i],
                                    "",
                                    {},
                                    true,
                                    function(Hovered, Active, Selected, Index)
                                        masks.Indexes[i] = Index

                                        if Active then
                                            SetPedComponentVariation(playerPed, 1, i, Index - 1, 2)
                                        end
                                        if Selected then
                                            local ppp = label
                                            if Ora.Inventory:CanReceive("mask", 1) then
                                                dataonWait = {
                                                    title = "Achat masque",
                                                    price = masks.price,
                                                    fct = function()
                                                        items = {
                                                            name = "mask",
                                                            data = {
                                                                component = 1,
                                                                equiped = false,
                                                                var = i,
                                                                ind = Index - 1
                                                            },
                                                            label = ppp
                                                        }
                                                        Ora.Inventory:AddItem(items)
                                                    end
                                                }

                                                CloseAllMenus()
                                                TriggerEvent("payWith?")
                                            end
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

masks.Create()
