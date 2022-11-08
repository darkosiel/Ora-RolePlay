--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 29/08/2019 00:08
---

RegisterNetEvent("mugroom:updatePlayerData")
---@type table New player data
createPlayer = {
    Model = nil,
    Position = nil,
    mp_f_freemode_01 = nil,
    mp_m_freemode_01 = nil
}

indexCharacter = {
    mp_f_freemode_01 = nil,
    mp_m_freemode_01 = nil
}
local currentPlayerSex

sexIndex = nil

local updateModelActive = false

AddEventHandler("mugroom:updatePlayerData",function(Content)
    createPlayer.Model = Content.Model
    createPlayer.Position = Content.Position
    
    createPlayer.mp_f_freemode_01 = Content.mp_f_freemode_01
    indexCharacter.mp_f_freemode_01 = Content.mp_f_freemode_01
    
    createPlayer.mp_m_freemode_01 = Content.mp_m_freemode_01
    indexCharacter.mp_m_freemode_01 = Content.mp_m_freemode_01
    
    currentPlayerSex = Content.Model
    
    if createPlayer.Model == "mp_f_freemode_01" then
        sexIndex = 1
    else
        sexIndex = 2
    end
end)

RMenu.Add("mugshot", "creator", RageUI.CreateMenu("Personnage", "~b~NOUVEAU PERSONNAGE"))
RMenu:Get("mugshot", "creator").Closable = false

RMenu.Add("mugshot", "character", RageUI.CreateSubMenu(RMenu:Get("mugshot", "creator"), "Personnage", "~b~Personnage"))

RMenu.Add("mugshot", "heritage", RageUI.CreateSubMenu(RMenu:Get("mugshot", "character"), "Personnage", "~b~HÉRÉDITÉ"))

RMenu.Add("mugshot","faceFeature",RageUI.CreateSubMenu(RMenu:Get("mugshot", "character"), "Personnage", "~b~TRAITS DU VISAGE"))
RMenu:Get("mugshot", "faceFeature").EnableMouse = true

RMenu.Add("mugshot", "apparence", RageUI.CreateSubMenu(RMenu:Get("mugshot", "character"), "Personnage", "~b~APPARENCE"))
RMenu:Get("mugshot", "apparence").EnableMouse = true

RMenu.Add("mugshot", "clothes", RageUI.CreateSubMenu(RMenu:Get("mugshot", "character"), "Personnage", "~b~VÊTEMENTS"))

RMenu.Add("mugshot","roleplayContent",RageUI.CreateSubMenu(RMenu:Get("mugshot", "creator"), "Personnage", "~b~INFORMATIONS PERSONNELLES"))

RMenu:Settings("mugshot", "creator", "Closable", false)

local function GetDictionary()
    if (GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01")) then
        return "mp_character_creation@customise@male_a"
    else
        return "mp_character_creation@customise@female_a"
    end
end

local MenusCam = {
    [1] = {
        character = {
            [4] = 1, [5] = 1, [6] = 1
        },
    },
    [2] = {
        character = {
            [4] = 1, [5] = 1, [6] = 1, [7] = 1
        },
    },
    [3] = {
        character = {
            [4] = 1, [5] = 1
        }
    }

}
local Zoom = false

-- RMenu:Get("mugshot", "heritage").Closed = function()
--     if not Zoom then
--         --CreatorZoomOut(GetCreatorCam())
--         _Cam:Zoom(_Cam.Fov)
--         Zoom = false
--     end
--     --UpdateCreatorTick("FaceTurnEnabled", false)
-- end

-- RMenu:Get("mugshot", "faceFeature").Closed = function()
--     if not Zoom then
--         --CreatorZoomOut(GetCreatorCam())
--         _Cam:Zoom(_Cam.Fov)
--         Zoom = false
--     end
--     --UpdateCreatorTick("FaceTurnEnabled", false)
-- end

-- RMenu:Get("mugshot", "apparence").Closed = function()
--     if not Zoom then
--         --CreatorZoomOut(GetCreatorCam())
--         _Cam:Zoom(_Cam.Fov)
--         Zoom = false
--     end
--     parameters = {}
--     UpdateEntityOutfit(PlayerPedId(), createPlayer[createPlayer.Model].Outfit)
--     --UpdateCreatorTick("FaceTurnEnabled", false)
-- end

RMenu:Get("mugshot", "character").onIndexChange = function(Index)
    if (MenusCam[indexC].character[Index] == 1 ) then
        if not Zoom then
            Zoom = true
            --CreatorZoomIn(GetCreatorCam())
            _Cam:Zoom(_Cam.ZoomFov)
        end
    else
        if Zoom then
            Zoom = false
            -- CreatorZoomOut(GetCreatorCam())
            _Cam:Zoom(_Cam.Fov)

        end
    end
end

RMenu:Get("mugshot", "character").Closed = function()
    if Zoom then
        --CreatorZoomOut(GetCreatorCam())
        _Cam:Zoom(_Cam.Fov)
        Zoom = false
    end
    --UpdateCreatorTick("FaceTurnEnabled", false)
end

RMenu:Get("mugshot", "clothes").Closed = function()
    OnClothesClose()
end

function OpenCreatorMenu()
    --print("créa")
    TriggerServerEvent("mugroom:enterInstance")
    TriggerEvent("displayNourriture", false)
    TriggerEvent("localInstance", "créaperso")
    local playerPed = PlayerPedId()
    --SetEntityCoordsNoOffset(playerPed, 402.98, -996.39, -99.0, true, true, true)
    --SetEntityCoordsNoOffset(playerPed, )
    RageUI.Visible(RMenu:Get("mugshot", "creator"), true)
    FreezeEntityPosition(playerPed, true)
    StartAnimProcess()
    updateModelActive = true
    onCreatorTick.LightRemote = true
end

RegisterNetEvent("instance:onCreate")
AddEventHandler(
"instance:onCreate",
function(instance)
    if instance.type == "skin" then
        TriggerEvent("instance:enter", instance)
    end
end)

function CloseCreatorMenu()
    TriggerServerEvent("mugroom:leaveInstance")
    TriggerEvent("exitInstance")
    TriggerEvent("instance:leave")
    RageUI.Visible(RMenu:Get("mugshot", "creator"), false)
    RageUI.CloseAll()
    TriggerEvent("displayNourriture", true)
    updateModelActive = false
    FreezeEntityPosition(PlayerPedId(), false)
    onCreatorTick.LightRemote = false
    StopThis = true
end
creating = false
endcreated = false
endcreated = false
indexC = 1
torso1, torso2 = nil, nil
undershit1, undershit2 = nil, nil
tops1, tops2 = nil, nil
legs1, legs2 = nil, nil
feet1, feet2 = nil, nil
function OnSelectedClothes(k)
    skin = k
    torso1, torso2 = skin.torso.id, skin.torso.txt
    undershit1, undershit2 = skin.undershirt.id, skin.undershirt.txt
    tops1, tops2 = skin.tops.id, skin.tops.txt
    legs1, legs2 = skin.legs.id, skin.legs.txt
    feet1, feet2 = skin.feet.id, skin.feet.txt
end

function GiveClothes()
    local startMoney = 5000
    local data = {
        torso = torso1,
        pant = legs1,
        chaus = feet1,
        unders = undershit1,
        access = -1,
        tops = tops1,
        pantcolor = legs2,
        chausscolor = feet2,
        underscolor = undershit2,
        topcolor = tops2,
        accesscolor = -1
    }
    local item = {}
    item.name = "tenue"
    item.data = data
    item.label = "Tenues d'arrivé en ville"
    RageUI.Popup({message = "Vous avez reçu une nouvelle tenue dans votre inventaire !"})
    Ora.Inventory:AddItem(item)
    item = {}
    
    local data = {battery = 99, num = GeneratePhoneNumber()}
    local item = {}
    item.name = "tel"
    item.data = data
    RageUI.Popup({message = "Vous avez reçu un téléphone dans votre inventaire !"})
    Ora.Inventory:AddItem(item)
    item = {}
    TriggerServerCallback("Ora::SE::Money:AuthorizePayment", function(token)
        TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = startMoney, SOURCE = "Argent de départ", LEGIT = false})
        TriggerServerEvent("Ora::SE::NpcJobs:Bank:UpdateMainAccount", "centralbank", startMoney, false)
    end,{})
end

function GetRPName()
    --print(json.encode(createPlayer))
    if (createPlayer.Identity.first_name == nil) then
        createPlayer[createPlayer.Model].Identity.first_name = "Aucun"
    end
    
    if (createPlayer.Identity.last_name == nil) then
        createPlayer.Identity.last_name = "Aucun"
    end
    
    return createPlayer.Identity.first_name ..
    " " .. createPlayer.Identity.last_name
end
createPed = {
    Face = {},
    Outfit = {},
    Identity = {}
}
ZoomV = false
ZoomV2 = false
sexList = {
    "mp_f_freemode_01",
    "mp_m_freemode_01",
}
pedList = {
    "csb_agent",
    "ig_amandatownley",
    "s_m_m_strpreach_01",
    "a_m_m_fatlatin_01",
    "a_f_m_beach_01",
    "a_f_m_bevhills_01",
    "a_f_m_bevhills_02",
    "a_f_m_bodybuild_01",
    "a_f_m_business_02",
    "a_f_m_downtown_01",
    "a_f_m_eastsa_01",
    "a_f_m_eastsa_02",
    "a_f_m_fatbla_01",
    "a_f_m_fatcult_01",
    "a_f_m_fatwhite_01",
    "a_f_m_ktown_01",
    "a_f_m_ktown_02",
    "a_f_m_prolhost_01",
    "a_f_m_salton_01",
    "a_f_m_skidrow_01",
    "a_f_m_soucent_01",
    "a_f_m_soucent_02",
    "a_f_m_soucentmc_01",
    "a_f_m_tourist_01",
    "a_f_m_tramp_01",
    "a_f_m_trampbeac_01",
    "a_f_o_genstreet_01",
    "a_f_o_indian_01",
    "a_f_o_ktown_01",
    "a_f_o_salton_01",
    "a_f_o_soucent_01",
    "a_f_o_soucent_02",
    "a_f_y_beach_01",
    "a_f_y_bevhills_01",
    "a_f_y_bevhills_02",
    "a_f_y_bevhills_03",
    "a_f_y_bevhills_04",
    "a_f_y_business_01",
    "a_f_y_business_02",
    "a_f_y_business_03",
    "a_f_y_business_04",
    "a_f_y_eastsa_01",
    "a_f_y_eastsa_02",
    "a_f_y_eastsa_03",
    "a_f_y_epsilon_01",
    "a_f_y_fitness_01",
    "a_f_y_fitness_02",
    "a_f_y_genhot_01",
    "a_f_y_golfer_01",
    "a_f_y_hiker_01",
    "a_f_y_hippie_01",
    "a_f_y_hipster_01",
    "a_f_y_hipster_02",
    "a_f_y_hipster_03",
    "a_f_y_hipster_04",
    "a_f_y_indian_01",
    "a_f_y_juggalo_01",
    "a_f_y_runner_01",
    "a_f_y_rurmeth_01",
    "a_f_y_scdressy_01",
    "a_f_y_skater_01",
    "a_f_y_soucent_01",
    "a_f_y_soucent_02",
    "a_f_y_soucent_03",
    "a_f_y_tennis_01",
    "a_f_y_topless_01",
    "a_f_y_tourist_01",
    "a_f_y_tourist_02",
    "a_f_y_vinewood_01",
    "a_f_y_vinewood_02",
    "a_f_y_vinewood_03",
    "a_f_y_vinewood_04",
    "a_f_y_yoga_01",
    "a_m_m_acult_01",
    "a_m_m_afriamer_01",
    "a_m_m_beach_01",
    "a_m_m_beach_02",
    "a_m_m_bevhills_01",
    "a_m_m_bevhills_02",
    "a_m_m_business_01",
    "a_m_m_eastsa_01",
    "a_m_m_eastsa_02",
    "a_m_m_farmer_01",
    "a_m_m_fatlatin_01",
    "a_m_m_genfat_01",
    "a_m_m_genfat_02",
    "a_m_m_golfer_01",
    "a_m_m_hasjew_01",
    "a_m_m_hillbilly_01",
    "a_m_m_hillbilly_02",
    "a_m_m_indian_01",
    "a_m_m_ktown_01",
    "a_m_m_malibu_01",
    "a_m_m_mexcntry_01",
    "a_m_m_mexlabor_01",
    "a_m_m_og_boss_01",
    "a_m_m_paparazzi_01",
    "a_m_m_polynesian_01",
    "a_m_m_prolhost_01",
    "a_m_m_rurmeth_01",
    "a_m_m_salton_01",
    "a_m_m_salton_02",
    "a_m_m_salton_03",
    "a_m_m_salton_04",
    "a_m_m_skater_01",
    "a_m_m_skidrow_01",
    "a_m_m_socenlat_01",
    "a_m_m_soucent_01",
    "a_m_m_soucent_02",
    "a_m_m_soucent_03",
    "a_m_m_soucent_04",
    "a_m_m_stlat_02",
    "a_m_m_tennis_01",
    "a_m_m_tourist_01",
    "a_m_m_tramp_01",
    "a_m_m_trampbeac_01",
    "a_m_m_tranvest_01",
    "a_m_m_tranvest_02",
    "a_m_o_acult_01",
    "a_m_o_acult_02",
    "a_m_o_beach_01",
    "a_m_o_genstreet_01",
    "a_m_o_ktown_01",
    "a_m_o_salton_01",
    "a_m_o_soucent_01",
    "a_m_o_soucent_02",
    "a_m_o_soucent_03",
    "a_m_o_tramp_01",
    "a_m_y_acult_01",
    "a_m_y_acult_02",
    "a_m_y_beach_01",
    "a_m_y_beach_02",
    "a_m_y_beach_03",
    "a_m_y_beachvesp_01",
    "a_m_y_beachvesp_02",
    "a_m_y_bevhills_01",
    "a_m_y_bevhills_02",
    "a_m_y_breakdance_01",
    "a_m_y_busicas_01",
    "a_m_y_business_01",
    "a_m_y_business_02",
    "a_m_y_business_03",
    "a_m_y_cyclist_01",
    "a_m_y_dhill_01",
    "a_m_y_downtown_01",
    "a_m_y_eastsa_01",
    "a_m_y_eastsa_02",
    "a_m_y_epsilon_01",
    "a_m_y_epsilon_02",
    "a_m_y_gay_01",
    "a_m_y_gay_02",
    "a_m_y_genstreet_01",
    "a_m_y_genstreet_02",
    "a_m_y_golfer_01",
    "a_m_y_hasjew_01",
    "a_m_y_hiker_01",
    "a_m_y_hippy_01",
    "a_m_y_hipster_01",
    "a_m_y_hipster_02",
    "a_m_y_hipster_03",
    "a_m_y_indian_01",
    "a_m_y_jetski_01",
    "a_m_y_juggalo_01",
    "a_m_y_ktown_01",
    "a_m_y_ktown_02",
    "a_m_y_latino_01",
    "a_m_y_methhead_01",
    "a_m_y_mexthug_01",
    "a_m_y_motox_01",
    "a_m_y_motox_02",
    "a_m_y_musclbeac_01",
    "a_m_y_musclbeac_02",
    "a_m_y_polynesian_01",
    "a_m_y_roadcyc_01",
    "a_m_y_runner_01",
    "a_m_y_runner_02",
    "a_m_y_salton_01",
    "a_m_y_skater_01",
    "a_m_y_skater_02",
    "a_m_y_soucent_01",
    "a_m_y_soucent_02",
    "a_m_y_soucent_03",
    "a_m_y_soucent_04",
    "a_m_y_stbla_01",
    "a_m_y_stbla_02",
    "a_m_y_stlat_01",
    "a_m_y_stwhi_01",
    "a_m_y_stwhi_02",
    "a_m_y_sunbathe_01",
    "a_m_y_surfer_01",
    "a_m_y_vindouche_01",
    "a_m_y_vinewood_01",
    "a_m_y_vinewood_02",
    "a_m_y_vinewood_03",
    "a_m_y_vinewood_04",
    "a_m_y_yoga_01",
    "g_f_importexport_01",
    "g_f_y_ballas_01",
    "g_f_y_families_01",
    "g_f_y_lost_01",
    "g_f_y_vagos_01",
    "g_m_importexport_01",
    "g_m_m_armboss_01",
    "g_m_m_armgoon_01",
    "g_m_m_armlieut_01",
    "g_m_m_chemwork_01",
    "g_m_m_chiboss_01",
    "g_m_m_chicold_01",
    "g_m_m_chigoon_01",
    "g_m_m_chigoon_02",
    "g_m_m_korboss_01",
    "g_m_m_mexboss_01",
    "g_m_m_mexboss_02",
    "g_m_y_armgoon_02",
    "g_m_y_azteca_01",
    "g_m_y_ballaeast_01",
    "g_m_y_ballaorig_01",
    "g_m_y_ballasout_01",
    "g_m_y_famca_01",
    "g_m_y_famdnf_01",
    "g_m_y_famfor_01",
    "g_m_y_korean_01",
    "g_m_y_korean_02",
    "g_m_y_korlieut_01",
    "g_m_y_lost_01",
    "g_m_y_lost_02",
    "g_m_y_lost_03",
    "g_m_y_mexgang_01",
    "g_m_y_mexgoon_01",
    "g_m_y_mexgoon_02",
    "g_m_y_mexgoon_03",
    "g_m_y_pologoon_01",
    "g_m_y_pologoon_02",
    "g_m_y_salvaboss_01",
    "g_m_y_salvagoon_01",
    "g_m_y_salvagoon_02",
    "g_m_y_salvagoon_03",
    "g_m_y_strpunk_01",
    "g_m_y_strpunk_02",
    "ig_abigail",
    "ig_amandatownley",
    "ig_andreas",
    "ig_ashley",
    "ig_ballasog",
    "ig_bankman",
    "ig_barry",
    "ig_benny",
    "ig_bestmen",
    "ig_beverly",
    "ig_brad",
    "ig_bride",
    "ig_car3guy1",
    "ig_car3guy2",
    "ig_chef",
    "ig_chengsr",
    "ig_chrisformage",
    "ig_clay",
    "ig_claypain",
    "ig_cletus",
    "ig_dale",
    "ig_davenorton",
    "ig_denise",
    "ig_devin",
    "ig_dom",
    "ig_dreyfuss",
    "ig_drfriedlander",
    "ig_fabien",
    "ig_fbisuit_01",
    "ig_floyd",
    "ig_g",
    "ig_groom",
    "ig_hao",
    "ig_hunter",
    "ig_janet",
    "ig_jay_norris",
    "ig_jewelass",
    "ig_jimmyboston",
    "ig_jimmydisanto",
    "ig_joeminuteman",
    "ig_josef",
    "ig_josh",
    "ig_kerrymcintosh",
    "ig_lamardavis",
    "ig_lazlow",
    "ig_lestercrest",
    "ig_lifeinvad_01",
    "ig_lifeinvad_02",
    "ig_magenta",
    "ig_malc",
    "ig_manuel",
    "ig_marnie",
    "ig_maryann",
    "ig_maude",
    "ig_michelle",
    "ig_milton",
    "ig_molly",
    "ig_mrk",
    "ig_mrs_thornhill",
    "ig_mrsphillips",
    "ig_natalia",
    "ig_nervousron",
    "ig_nigel",
    "ig_old_man1a",
    "ig_old_man2",
    "ig_omega",
    "ig_oneil",
    "ig_ortega",
    "ig_paper",
    "ig_patricia",
    "ig_priest",
    "ig_ramp_gang",
    "ig_ramp_hic",
    "ig_ramp_hipster",
    "ig_ramp_mex",
    "ig_roccopelosi",
    "ig_russiandrunk",
    "ig_screen_writer",
    "ig_solomon",
    "ig_stevehains",
    "ig_stretch",
    "ig_talina",
    "ig_tanisha",
    "ig_taocheng",
    "ig_taostranslator",
    "ig_tenniscoach",
    "ig_terry",
    "ig_tomepsilon",
    "ig_tonya",
    "ig_tracydisanto",
    "ig_trafficwarden",
    "ig_tylerdix",
    "ig_vagspeak",
    "ig_wade",
    "ig_zimbor",
    "mp_f_boatstaff_01",
    "mp_f_cardesign_01",
    "mp_f_chbar_01",
    "mp_f_counterfeit_01",
    "mp_f_execpa_01",
    "mp_f_forgery_01",
    "mp_f_weed_01",
    "mp_g_m_pros_01",
    "mp_m_counterfeit_01",
    "mp_m_exarmy_01",
    "mp_m_execpa_01",
    "mp_m_famdd_01",
    "mp_m_forgery_01",
    "mp_m_g_vagfun_01",
    "mp_m_shopkeep_01",
    "mp_m_waremech_01",
    "mp_m_weed_01",
    "s_f_m_fembarber",
    "s_f_m_maid_01",
    "s_f_m_shop_high",
    "s_f_m_sweatshop_01",
    "s_f_y_bartender_01",
    "s_f_y_hooker_01",
    "s_f_y_hooker_02",
    "s_f_y_hooker_03",
    "s_f_y_migrant_01",
    "s_f_y_movprem_01",
    "s_f_y_shop_low",
    "s_f_y_shop_mid",
    "s_f_y_sweatshop_01",
    "s_m_m_ammucountry",
    "s_m_m_autoshop_01",
    "s_m_m_autoshop_02",
    "s_m_m_bouncer_01",
    "s_m_m_ciasec_01",
    "s_m_m_cntrybar_01",
    "s_m_m_fiboffice_01",
    "s_m_m_fiboffice_02",
    "s_m_m_gaffer_01",
    "s_m_m_gardener_01",
    "s_m_m_hairdress_01",
    "s_m_m_highsec_01",
    "s_m_m_highsec_02",
    "s_m_m_janitor",
    "s_m_m_lathandy_01",
    "s_m_m_lifeinvad_01",
    "s_m_m_linecook",
    "s_m_m_lsmetro_01",
    "s_m_m_mariachi_01",
    "s_m_m_migrant_01",
    "s_m_m_movprem_01",
    "s_m_m_strpreach_01",
    "s_m_m_strvend_01",
    "s_m_m_trucker_01",
    "s_m_o_busker_01",
    "s_m_y_ammucity_01",
    "s_m_y_barman_01",
    "s_m_y_busboy_01",
    "s_m_y_chef_01",
    "s_m_y_dealer_01",
    "s_m_y_devinsec_01",
    "s_m_y_grip_01",
    "s_m_y_robber_01",
    "s_m_y_shop_mask",
    "s_m_y_strvend_01",
    "s_m_y_valet_01",
    "s_m_y_waiter_01",
    "s_m_y_winclean_01",
    "s_m_y_xmech_01",
    "s_m_y_xmech_02",
    "s_m_y_xmech_02_mp",
    "u_f_m_miranda",
    "u_f_m_promourn_01",
    "u_f_o_moviestar",
    "u_f_o_prolhost_01",
    "u_f_y_bikerchic",
    "u_f_y_comjane",
    "u_f_y_hotposh_01",
    "u_f_y_jewelass_01",
    "u_f_y_mistress",
    "u_f_y_poppymich",
    "u_f_y_princess",
    "u_f_y_spyactress",
    "u_m_m_aldinapoli",
    "u_m_m_bankman",
    "u_m_m_bikehire_01",
    "u_m_m_fibarchitect",
    "u_m_m_filmdirector",
    "u_m_m_glenstank_01",
    "u_m_m_griff_01",
    "u_m_m_jesus_01",
    "u_m_m_jewelsec_01",
    "u_m_m_jewelthief",
    "u_m_m_markfost",
    "u_m_m_partytarget",
    "u_m_m_promourn_01",
    "u_m_m_rivalpap",
    "u_m_m_spyactor",
    "u_m_m_willyfist",
    "u_m_o_finguru_01",
    "u_m_o_taphillbilly",
    "u_m_o_tramp_01",
    "u_m_y_abner",
    "u_m_y_antonb",
    "u_m_y_babyd",
    "u_m_y_baygor",
    "u_m_y_chip",
    "u_m_y_cyclist_01",
    "u_m_y_fibmugger_01",
    "u_m_y_guido_01",
    "u_m_y_gunvend_01",
    "u_m_y_hippie_01",
    "u_m_y_mani",
    "u_m_y_militarybum",
    "u_m_y_paparazzi",
    "u_m_y_party_01",
    "u_m_y_sbike",
    "u_m_y_tattoo_01",
    "s_m_y_cop_01",
    "s_m_y_blackops_01",
    "s_m_y_blackops_02",
    "s_m_y_blackops_03",
    "a_f_y_femaleagent",
    "mp_f_cocaine_01",
    "mp_f_execpa_02",
    "mp_f_helistaff_01",
    "mp_f_meth_01",
    "mp_f_weed_01",
    "mp_m_cocaine_01",
    "mp_m_counterfeit_01",
    "mp_m_meth_01",
    "mp_m_securoguard_01",
    "mp_m_weapexp_01",
    "mp_m_weapwork_01",
    "u_m_m_streetart_01",
    "ig_lestercrest_2",
    "ig_avon",
    "mp_m_avongoon",
    "mp_m_bogdangoon",
    "csb_jackhowitzer",
    "csb_abigail",
    "csb_anita",
    "csb_anton",
    "csb_ballasog",
    "csb_bride",
    "csb_burgerdrug",
    "csb_car3guy1",
    "csb_car3guy2",
    "csb_chef",
    "csb_chin_goon",
    "csb_cletus",
    "csb_cop",
    "csb_customer",
    "csb_denise_friend",
    "csb_fos_rep",
    "csb_g",
    "csb_groom",
    "csb_grove_str_dlr",
    "csb_hao",
    "csb_hugh",
    "csb_imran",
    "csb_janitor",
    "csb_maude",
    "csb_mweather",
    "csb_ortega",
    "csb_oscar",
    "csb_porndudes",
    "csb_prologuedriver",
    "csb_prolsec",
    "csb_ramp_gang",
    "csb_ramp_hic",
    "csb_ramp_hipster",
    "csb_ramp_marine",
    "csb_ramp_mex",
    "csb_reporter",
    "csb_roccopelosi",
    "csb_screen_writer",
    "csb_stripper_01",
    "csb_stripper_02",
    "csb_tonya",
    "csb_trafficwarden",
    "csb_vagspeak",
    "hc_driver",
    "hc_gunman",
    "hc_hacker",
    "ig_casey",
    "ig_johnnyklebitz",
    "ig_orleans",
    "ig_prolsec_02",
    "ig_siemonyetarian",
    "mp_f_deadhooker",
    "mp_f_misty_01",
    "mp_f_stripperlite",
    "mp_f_stripperlite",
    "mp_m_fibsec_01",
    "mp_s_m_armoured_01",
    "s_f_y_airhostess_01",
    "s_f_y_baywatch_01",
    "s_f_y_cop_01",
    "s_f_y_factory_01",
    "s_f_y_ranger_01",
    "s_f_y_scrubs_01",
    "s_f_y_sheriff_01",
    "s_f_y_stripper_01",
    "s_f_y_stripper_02",
    "s_f_y_stripperlite",
    "s_m_m_armoured_01",
    "s_m_m_armoured_02",
    "s_m_m_chemsec_01",
    "s_m_m_dockwork_01",
    "s_m_m_doctor_01",
    "s_m_m_gentransport",
    "s_m_m_marine_01",
    "s_m_m_marine_02",
    "s_m_m_movalien_01",
    "s_m_m_movspace_01",
    "s_m_m_paramedic_01",
    "s_m_m_pilot_01",
    "s_m_m_pilot_02",
    "s_m_m_postal_01",
    "s_m_m_postal_02",
    "s_m_m_prisguard_01",
    "s_m_m_scientist_01",
    "s_m_m_security_01",
    "s_m_m_snowcop_01",
    "s_m_m_strperf_01",
    "s_m_m_ups_01",
    "s_m_m_ups_02",
    "s_m_y_airworker",
    "s_m_y_armymech_01",
    "s_m_y_autopsy_01",
    "s_m_y_baywatch_01",
    "s_m_y_clown_01",
    "s_m_y_construct_01",
    "s_m_y_construct_02",
    "s_m_y_dockwork_01",
    "s_m_y_doorman_01",
    "s_m_y_dwservice_01",
    "s_m_y_dwservice_02",
    "s_m_y_factory_01",
    "s_m_y_fireman_01",
    "s_m_y_garbage",
    "s_m_y_hwaycop_01",
    "s_m_y_marine_01",
    "s_m_y_marine_02",
    "s_m_y_marine_03",
    "s_m_y_mime",
    "s_m_y_pestcont_01",
    "s_m_y_pilot_01",
    "s_m_y_prismuscl_01",
    "s_m_y_prisoner_01",
    "s_m_y_ranger_01",
    "s_m_y_sheriff_01",
    "s_m_y_uscg_01",
    "u_m_m_prolsec_01",
    "u_m_y_burgerdrug_01",
    "u_m_y_imporage",
    "u_m_y_justin",
    "u_m_y_prisoner_01",
    "u_m_y_proldriver_01",
    "u_m_y_rsranger_01",
    "u_m_y_staggrm_01",
    "a_f_y_clubcust_01",
    "a_f_y_clubcust_02",
    "a_f_y_clubcust_03",
    "ig_agent",
    "ig_mp_agent14",
    "ig_chef2",
    "ig_popov",
    "ig_karen_daniels",
    "ig_rashcosvki",
    "ig_money",
    "ig_paige",
    "ig_djblamadon",
    "ig_djblamryans",
    "ig_djblamrupert",
    "ig_djdixmanager",
    "ig_djsolfotios",
    "ig_djsoljakob",
    "ig_djsolmike",
    "ig_djsolrobt",
    "ig_djtalaurelia",
    "ig_djtalignazio",
    "ig_dix",
    "ig_englishdave",
    "ig_djgeneric_01",
    "ig_jimmyboston_02",
    "ig_kerrymcintosh_02",
    "ig_lacey_jones_02",
    "ig_lazlow_2",
    "ig_sol",
    "ig_djsolmanager",
    "ig_talcc",
    "ig_talmm",
    "ig_tylerdix_02",
    "ig_tonyprince",
    "ig_sacha",
    "u_m_y_juggernaut_01",
    "u_m_y_corpse_01",
    "u_m_m_doa_01",
    "u_m_m_edtoh",
    "u_m_y_smugmech_01",
    "u_m_o_filmnoir",
    "u_m_y_pogo_01",
    "u_m_y_zombie_01",
    "u_m_y_danceburl_01",
    "u_m_y_dancelthr_01",
    "u_m_y_dancerave_01",
    "mp_f_meth_01",
    "mp_m_boatstaff_01",
    "mp_m_claude_01",
    "mp_m_marston_01",
    "mp_m_niko_01",
    "mp_f_bennymech_01",
    "csb_mp_agent14",
    "csb_avon",
    "csb_bogdan",
    "csb_chef2",
    "csb_popov",
    "csb_rashcosvki",
    "csb_money",
    "csb_mrs_r",
    "csb_paige",
    "csb_undercover",
    "csb_djblamadon",
    "csb_dix",
    "csb_englishdave",
    "csb_sol",
    "csb_talcc",
    "csb_talmm",
    "csb_tonyprince",
    "csb_alan",
    "csb_bryony",
    "s_m_m_ccrew_01",
    "s_m_m_fibsec_01",
    "s_m_y_swat_01",
    "s_m_y_clubbar_01",
    "s_m_y_waretech_01",
    "s_f_y_clubbar_01",
    "u_f_m_corpse_01",
    "u_f_y_corpse_01",
    "u_f_y_corpse_02",
    "u_f_m_miranda_02",
    "u_f_y_poppymich_02",
    "u_f_y_danceburl_01",
    "u_f_y_dancelthr_01",
    "u_f_y_dancerave_01",
    "a_m_y_clubcust_01",
    "a_m_y_clubcust_02",
    "a_m_y_clubcust_03",
    "a_f_y_beach_02",
    "a_f_y_clubcust_04",
    "a_m_o_beach_02",
    "a_m_y_beach_04",
    "a_m_y_clubcust_04",
    "cs_patricia_02",
    "csb_ary",
    "csb_englishdave_02",
    "csb_gustavo",
    "csb_helmsmanpavel",
    "csb_isldj_00",
    "csb_isldj_01",
    "csb_iSLdj_02",
    "csb_isldj_03",
    "csb_isldj_04",
    "csb_jio",
    "csb_juanstrickler",
    "csb_miguelmadrazo",
    "csb_mjo",
    "csb_sss",
    "g_m_m_cartelguards_01",
    "g_m_m_cartelguards_02",
    "ig_ary",
    "ig_englishdave_02",
    "ig_gustavo",
    "ig_helmsmanpavel",
    "ig_isldj_00",
    "ig_isldj_01",
    "ig_isldj_02",
    "ig_isldj_03",
    "ig_isldj_04",
    "ig_isldj_04_d_01",
    "ig_isldj_04_d_02",
    "ig_isldj_04_e_01",
    "ig_jackie",
    "ig_jio",
    "ig_juanstrickler",
    "ig_kaylee",
    "ig_miguelmadrazo",
    "ig_mjo",
    "ig_oldrichguy",
    "ig_patricia_02",
    "ig_pilot",
    "ig_sss",
    "s_f_y_beachbarstaff_01",
    "s_f_y_clubbar_02",
    "s_m_m_bouncer_02",
    "s_m_m_drugprocess_01",
    "s_m_m_fieldworker_01",
    "s_m_m_highsec_04"
}

local hasBeenLoaded = false

local spawnPoint <const> = {
    data = {
        "Aéroport de Los Santos",
        "Aéroport de Sandy Shore",
        "Vinewood"
    },
    index = 1
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        creating = false
        if RageUI.Visible(RMenu:Get("mugshot", "creator")) and not endcreated then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                RageUI.Button("Informations personnelles","Inscrivez les informations personnelles de votre personnage. ~o~(Nom, Prénom, Âge).",{},true,function(Hovered, Active, Selected)
                end,RMenu:Get("mugshot", "roleplayContent"))

                RageUI.Button("Personnage", "Créez votre personnage.", {}, true, function(Hovered, Active, Selected)
                end, RMenu:Get("mugshot", "character"))

                RageUI.List("Point d'arrivée", spawnPoint.data, spawnPoint.index, "Le lieu sur lequel vous allez faire vos premiers pas sur Ora.",{},true,function(Hovered, Active, Selected, Index)
                    spawnPoint.index = Index
                end)

                RageUI.Button("~g~Finir la création de votre personnage", nil,{ Color = {} }, true, function(Hovered, Active, Selected)
                    if Selected then
                        creating = false
                        if createPlayer[createPlayer.Model] == nil then
                            createPlayer[createPlayer.Model] = createPed
                        end
                        if (
                            (createPlayer[createPlayer.Model].Identity.first_name ~= nil and createPlayer[createPlayer.Model].Identity.first_name ~= "") and
                            (createPlayer[createPlayer.Model].Identity.last_name ~= nil and createPlayer[createPlayer.Model].Identity.last_name ~= "") and
                            (createPlayer[createPlayer.Model].Identity.birth_date ~= nil and createPlayer[createPlayer.Model].Identity.birth_date ~= "") and
                            (createPlayer[createPlayer.Model].Identity.origine ~= nil and createPlayer[createPlayer.Model].Identity.origine ~= "")
                        ) then
                            Ora.Inventory:Load()
                            Wait(500)
                            GiveClothes()
                            Ora.Inventory:Save()
                            CloseCreatorMenu()
                            local ModelSelected = createPlayer[createPlayer.Model]
                            if ModelSelected.Identity == nil then
                                ModelSelected.Identity = createPed.Identity
                            end
                            
                            if (isPed == false) then
                                --print(sexIndex)
                                createPlayer.Model = createPlayer.Model
                                createPlayer.Face = ModelSelected.Face
                            else
                                local Skin = {}
                                createPlayer.Model = pedList[pedIndex]
                                for i = 0, 12, 1 do
                                    Skin[i] = {
                                        v = GetPedDrawableVariation(PlayerPedId(), i),
                                        c = GetPedTextureVariation(PlayerPedId(), i)
                                    }
                                end
                                createPlayer.Face = Skin
                            end
                            createPlayer.Outfit = ModelSelected.Outfit
                            createPlayer.Identity = ModelSelected.Identity
                            
                            --print(json.encode(createPlayer))
                            
                            TriggerServerEvent("mugroom:RegisterNewPlayer", createPlayer, spawnPoint)
                            TakePictureAndExit()
                            RageUI.GoBack()
                            RageUI.GoBack()
                            RageUI.GoBack()
                            RageUI.GoBack()
                            RageUI.GoBack()
                            endcreated = true
                            StopThis = true
                            RageUI.GoBack()
                            DoScreenFadeOut(10)
                            Ora.Inventory:Save()
                            TriggerEvent("mugroom:Finish", spawnPoint)
                        else
                            RageUI.Popup(
                            {
                                message = "Vous n'avez pas correctement rempli le formulaire d'identité",
                                colors = 130,
                                sound = {
                                    audio_name = "ERROR",
                                    audio_ref = "HUD_FRONTEND_DEFAULT_SOUNDSET"
                                }
                            })
                        end
                    end
                end)

                RageUI.CenterButton("~b~-----------------~b~",nil,{},true,function(_, _, _) end)

                RageUI.CenterButton("~o~Tout réinitialiser", nil, {Color = {}}, true, function(Hovered, Active, Selected)
                    if Selected then
                        CloseAllMenus()
                        ShowNotification("~g~Veuillez réessayer maintenant~s~")
                        --Ora.Health:Revive(false)
                        --Ora.Health:SetMyHealthPercent(100)
                        --Creator.LoadContent()
                        TriggerEvent("spawnhandler:CharacterCreator")
                    end
                end)
            end)
        elseif endcreated and RageUI.Visible(RMenu:Get("mugshot", "creator")) then
            RageUI.CloseAll()
        end
        if RageUI.Visible(RMenu:Get("mugshot", "character")) then
            ProcessMenuCharacter(indexCharacter, createPlayer)
        end
        if RageUI.Visible(RMenu:Get("mugshot", "heritage")) then
            CreatorMenuHeritage(indexCharacter, createPlayer)
            creating = true
        end
        if RageUI.Visible(RMenu:Get("mugshot", "faceFeature")) then
            CreatorMenuFaceFeatures(indexCharacter, createPlayer)
            creating = true
        end
        if RageUI.Visible(RMenu:Get("mugshot", "apparence")) then
            creating = true
            CreatorMenuAppearance(indexCharacter, createPlayer)
        end
        if RageUI.Visible(RMenu:Get("mugshot", "clothes")) then
            creating = true
            CreatorMenuClothes(indexCharacter, createPlayer)
        end
        if RageUI.Visible(RMenu:Get("mugshot", "roleplayContent")) then
            CreatorMenuRoleplay(indexCharacter, createPlayer)
            creating = true
        end

        if creating then
            DisableControlAction(0, 69, true)
            DisableControlAction(0, 92, true)
            DisableControlAction(0, 114, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 288, true)
            DisableControlAction(0, 289, true)
            DisableControlAction(0, 170, true)
            DisableControlAction(0, 166, true)
            DisableControlAction(0, 167, true)
            DisableControlAction(0, 168, true)
            DisableControlAction(0, 57, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 0, true)
            DisableControlAction(0, 26, true)
        end
    end
end)

function func_1532()
    return vector3(404.834, -997.838, -98.841)
end

function func_1531()
    return vector3(0, 0, -38)
end

-- Let player stuck in an anim and freeze it just in case

local lookOnTheSide = false
StopThis = false

function RestartAnimProcess()
    StopThis = true
    Wait(100)
    StartAnimProcess()
end

function StartAnimProcess()
    --local Position = func_1532()
    --local Rotation = func_1531()
    StopThis = false
    local PlayerPed = PlayerPedId()
    local dict = "amb@world_human_stand_impatient@male@no_sign@idle_a"
    local anim = "idle_a"
    -- local dict = "amb@world_human_aa_smoke@male"
    -- local anim = "base"
    loadAnimDict(dict)
    TaskPlayAnim(PlayerPed, dict, anim, 8.0, 8.0, -1, 1, 0, false, false, false)

    local Controls = {
        Left = 35, Right = 34, Front = 32
    }


    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if StopThis then
                --print("Stop this")
                break
            end
            HideHudAndRadarThisFrame()
            ThefeedHideThisFrame()
            if IsControlJustPressed(0, Controls.Left) then
                if lookOnTheSide then
                    _Cam:Switch("front")
                    lookOnTheSide = false
                else
                    _Cam:Switch("left")
                    lookOnTheSide = true
                end
                _Cam:Render()
            elseif IsControlJustPressed(0, Controls.Right) then
                if lookOnTheSide then
                    _Cam:Switch("front")
                    lookOnTheSide = false
                else
                    _Cam:Switch("right")
                    lookOnTheSide = true
                end
                _Cam:Render()
            elseif IsControlJustPressed(0, Controls.Front) and lookOnTheSide then
                _Cam:Switch("front")
                lookOnTheSide = false
                _Cam:Render()
            end
            -- if IsControlJustPressed(0, 38) then
            --     if lookOnTheSide then
            --         lookOnTheSide = false
            --         ClearPedTasks(PlayerPed)
            --         TaskPlayAnim(PlayerPed, dict, anim, 8.0, 8.0, -1, 1, 0, false, false, false)
            --     else
            --         lookOnTheSide = true
            --         ClearPedTasks(PlayerPed)
            --         TaskPlayAnim(PlayerPed, dict, "exit", 8.0, 8.0, -1, 1, 0, false, false, false)
            --     end
            -- end
        end
    end)
    
    -------------------------
    -- FreezeEntityPosition(PlayerPed, false)
    --SetEntityCoords(PlayerPed, Position)
    --SetEntityHeading(PlayerPed, Rotation.z)
    -- SetEntityInvincible(PlayerPed, true)
    -- FreezeEntityPosition(PlayerPed, true)
    -- SetEntityCoordsNoOffset(playerPed, 402.98, -996.39, -99.0, true, true, true)


    -- Citizen.CreateThread(function()
    --     local a = {
    --         normal = "",
    --         left = "profile_l_",
    --         right = 'profile_r_',
    --     }
    --     local dict = "mp_character_creation@customise@male_a"
    --     local anim
    --     local TaskPlayAnim = TaskPlayAnim
    --     LoadAnim(dict)
    --     TaskPlayAnim(PlayerPedId(), dict, "loop", -1, 1.0, -1, 1, 1, 0, 0, 0)
    --     while true do
    --         PlayerPed = PlayerPedId()
    --         local IsControlJustPressed = IsControlEnabled(0, 35) and IsControlJustPressed or IsDisabledControlJustPressed
    --         local IsControlPressed = IsControlEnabled(0, 35) and IsControlPressed or IsDisabledControlPressed
    --         local IsControlJustReleased = IsControlEnabled(0, 35) and IsControlJustReleased or IsDisabledControlJustReleased
    --         local Controls = {
    --             Left = 35, Right = 34, Front = 32
    --         }
            
    --         if parameters.chestHair and IsEntityPlayingAnim(PlayerPedId(), dict, "loop", 3) then
    --             ClearPedTasks(PlayerPedId())
    --             --TaskPlayAnim(PlayerPedId(), dict, "loop", -1, 1.0, -1, 1, 1, 0, 0, 0)
    --         end 
    --         if creating then
    --             if IsControlJustPressed(0, Controls.Left) then
    --                 anim = a.right
    --                 TaskPlayAnim(PlayerPedId(), dict, anim.."intro", 1.0, 1.0, -1, 0, 0, 0, 0, 0)
    --                 --StartAnimLoop(Controls.Left, dict, anim)
    --                 Citizen.SetTimeout(GetEntityAnimTotalTime(PlayerPedId(), dict, anim.."outro"), function()
    --                     TaskPlayAnim(PlayerPedId(), dict, anim.."loop", 8, -8, -1, 1, 1, 0, 0, 0)
    --                 end)
    --                 lookOnTheSide = true
    --             elseif IsControlJustPressed(0, Controls.Right) then -- Control 'D' by default -> INPUT_MOVE_RIGHT_ONLY
    --                 anim = a.left
    --                 TaskPlayAnim(PlayerPedId(), dict, anim.."intro", 1.0, 1.0, -1, 0, 0, 0, 0, 0)
    --                 Citizen.SetTimeout(GetEntityAnimTotalTime(PlayerPedId(), dict, anim.."outro"), function()
    --                     TaskPlayAnim(PlayerPedId(), dict, anim.."loop", 8, -8, -1, 1, 1, 0, 0, 0)
    --                 end)
    --                 lookOnTheSide = true
    --             elseif (IsControlJustPressed(0, Controls.Left) and lookOnTheSide and anim == a.left) or (IsControlJustPressed(0, Controls.Right) and lookOnTheSide and anim == a.right) or (IsControlJustPressed(0, Controls.Front) and lookOnTheSide) then
    --                 lookOnTheSide = false
    --                 TaskPlayAnim(0, dict, anim.."outro", 8, -8, -1, 512, 0, 0, 0, 0);
    --                 Citizen.SetTimeout(GetEntityAnimTotalTime(PlayerPedId(), dict, anim.."outro"), function()
    --                     TaskPlayAnim(PlayerPedId(), dict, "loop", 1.0, 1.0, -1, 1, 1, 0, 0, 0)
    --                 end)
    --             elseif not lookOnTheSide and not not IsEntityPlayingAnim(PlayerPedId(), dict, "loop", 3) then
    --                 TaskPlayAnim(PlayerPedId(), dict, "loop", -1, 1.0, -1, 1, 1, 0, 0, 0)
    --             end
    --         end
            
    --         if StopThis then
    --             ClearPedTasksImmediately(PlayerPedId())
    --             break
    --         end
            
    --         Citizen.Wait(1.0)
    --     end
    -- end)
end

function StartAnimLoop(control, dict, anim)
    local IsControlJustPressed = IsControlEnabled(0, 35) and IsControlJustPressed or IsDisabledControlJustPressed
    local IsControlPressed = IsControlEnabled(0, 35) and IsControlPressed or IsDisabledControlPressed
    local IsControlJustReleased = IsControlEnabled(0, 35) and IsControlJustReleased or IsDisabledControlJustReleased
    Citizen.CreateThread(function()
        while lookOnTheSide do
            if lookOnTheSide then
                if not IsEntityPlayingAnim(PlayerPedId(), dict, anim.."intro", 3) then
                    TaskPlayAnim(PlayerPedId(), dict, anim.."loop", 8, -8, -1, 513, 0, 0, 0, 0)
                end
            else
                if not IsEntityPlayingAnim(PlayerPedId(), dict, anim.."intro", 3) or (IsEntityPlayingAnim(PlayerPedId(), dict, anim.."intro", 3) and GetEntityAnimCurrentTime(PlayerPedId(), dict, anim.."intro") >= 0.4 ) then
                    TaskPlayAnim(0, dict, anim.."outro", 8, -8, -1, 512, 0, 0, 0, 0);
                    Citizen.SetTimeout(GetEntityAnimTotalTime(PlayerPedId(), dict, anim.."outro"), function()
                        TaskPlayAnim(PlayerPedId(), dict, "loop", 1.0, 1.0, -1, 1, 1, 0, 0, 0)
                    end)
                end
                TaskPlayAnim(PlayerPedId(), dict, "loop", 1.0, 1.0, -1, 1, 1, 0, 0, 0)
                lookOnTheSide = false
            end
            Wait(1.0)
        end
    end)
end

function SetPlayerInInstance()
    TriggerServerEvent("mugroom:enterInstance")
end