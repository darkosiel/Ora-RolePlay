RegisterCommand("sit", function(source, args, rawCommand)
    SitChair()
end, false)


local chairs = {
    [GetHashKey("cs1_02_chair_tarped001")] = true,
    [GetHashKey("hei_heist_din_chair_01")] = true,
    [GetHashKey("hei_heist_din_chair_02")] = true,
    [GetHashKey("hei_heist_din_chair_03")] = true,
    [GetHashKey("hei_heist_din_chair_04")] = true,
    [GetHashKey("hei_heist_din_chair_05")] = true,
    [GetHashKey("hei_heist_din_chair_06")] = true,
    [GetHashKey("hei_heist_din_chair_08")] = true,
    [GetHashKey("hei_heist_din_chair_09")] = true,
    [GetHashKey("hei_heist_stn_chairarm_01")] = true,
    [GetHashKey("hei_heist_stn_chairarm_03")] = true,
    [GetHashKey("hei_heist_stn_chairarm_04")] = true,
    [GetHashKey("hei_heist_stn_chairarm_06")] = true,
    [GetHashKey("hei_heist_stn_chairstrip_01")] = true,
    [GetHashKey("hei_prop_hei_skid_chair")] = true,
    [GetHashKey("hei_prop_heist_off_chair")] = true,
    [GetHashKey("p_armchair_01_s")] = true,
    [GetHashKey("p_clb_officechair_s")] = true,
    [GetHashKey("p_dinechair_01_s")] = true,
    [GetHashKey("p_folding_chair_01_s")] = true,
    [GetHashKey("p_ilev_p_easychair_s")] = true,
    [GetHashKey("p_soloffchair_s")] = true,
    [GetHashKey("p_yacht_chair_01_s")] = true,
    [GetHashKey("prop_armchair_01")] = true,
    [GetHashKey("prop_chair_01a")] = true,
    [GetHashKey("prop_chair_01b")] = true,
    [GetHashKey("prop_chair_02")] = true,
    [GetHashKey("prop_chair_03")] = true,
    [GetHashKey("prop_chair_04a")] = true,
    [GetHashKey("prop_chair_04b")] = true,
    [GetHashKey("prop_chair_05")] = true,
    [GetHashKey("prop_chair_06")] = true,
    [GetHashKey("prop_chair_07")] = true,
    [GetHashKey("prop_chair_08")] = true,
    [GetHashKey("prop_chair_09")] = true,
    [GetHashKey("prop_chair_10")] = true,
    [GetHashKey("prop_chair_pile_01")] = true,
    [GetHashKey("prop_chateau_chair_01")] = true,
    [GetHashKey("prop_clown_chair")] = true,
    [GetHashKey("prop_cs_folding_chair_01")] = true,
    [GetHashKey("prop_cs_office_chair")] = true,
    [GetHashKey("prop_direct_chair_01")] = true,
    [GetHashKey("prop_direct_chair_02")] = true,
    [GetHashKey("prop_flipchair_01")] = true,
    [GetHashKey("prop_gc_chair02")] = true,
    [GetHashKey("prop_ld_farm_chair01")] = true,
    [GetHashKey("prop_off_chair_01")] = true,
    [GetHashKey("prop_off_chair_03")] = true,
    [GetHashKey("prop_off_chair_04_s")] = true,
    [GetHashKey("prop_off_chair_04")] = true,
    [GetHashKey("prop_off_chair_04b")] = true,
    [GetHashKey("prop_off_chair_05")] = true,
    [GetHashKey("prop_old_deck_chair_02")] = true,
    [GetHashKey("prop_old_deck_chair")] = true,
    [GetHashKey("prop_old_wood_chair_lod")] = true,
    [GetHashKey("prop_old_wood_chair")] = true,
    [GetHashKey("prop_rock_chair_01")] = true,
    [GetHashKey("prop_skid_chair_01")] = true,
    [GetHashKey("prop_skid_chair_02")] = true,
    [GetHashKey("prop_skid_chair_03")] = true,
    [GetHashKey("prop_sol_chair")] = true,
    [GetHashKey("prop_wheelchair_01_s")] = true,
    [GetHashKey("prop_wheelchair_01")] = true,
    [GetHashKey("prop_yaught_chair_01")] = true,
    [GetHashKey("v_16_high_lng_armchairs")] = true,
    [GetHashKey("v_16_low_lng_mesh_armchair")] = true,
    [GetHashKey("v_3_main_mesh_chair")] = true,
    [GetHashKey("v_49_tat2chair")] = true,
    [GetHashKey("v_50_chairend")] = true,
    [GetHashKey("v_50_chairend001")] = true,
    [GetHashKey("v_50_chairend002")] = true,
    [GetHashKey("v_50_chairend003")] = true,
    [GetHashKey("v_50_chairend004")] = true,
    [GetHashKey("v_50_chairend005")] = true,
    [GetHashKey("v_50_chairend006")] = true,
    [GetHashKey("v_50_chairend007")] = true,
    [GetHashKey("v_50_chairend008")] = true,
    [GetHashKey("v_50_chairend011")] = true,
    [GetHashKey("v_50_chairend034")] = true,
    [GetHashKey("v_50_chairend133")] = true,
    [GetHashKey("v_50_chairend134")] = true,
    [GetHashKey("v_50_chairs")] = true,
    [GetHashKey("v_50_chairs1")] = true,
    [GetHashKey("v_50_chairs3")] = true,
    [GetHashKey("v_50_chairs4")] = true,
    [GetHashKey("v_50_chairs6")] = true,
    [GetHashKey("v_50_chairsingle")] = true,
    [GetHashKey("v_50_chairsingle002")] = true,
    [GetHashKey("v_50_chairsingle003")] = true,
    [GetHashKey("v_50_chairsingle020")] = true,
    [GetHashKey("v_50_chairsingle021")] = true,
    [GetHashKey("v_50_chairsingle022")] = true,
    [GetHashKey("v_50_chairsingle023")] = true,
    [GetHashKey("v_50_chairsingle12")] = true,
    [GetHashKey("v_50_chairsingle18")] = true,
    [GetHashKey("v_50_chairsingle19")] = true,
    [GetHashKey("v_50_chairsingle2")] = true,
    [GetHashKey("v_58_soloff_gchair")] = true,
    [GetHashKey("v_58_soloff_gchair2")] = true,
    [GetHashKey("v_58_soloff_offchair")] = true,
    [GetHashKey("v_club_barchair")] = true,
    [GetHashKey("v_club_ch_armchair")] = true,
    [GetHashKey("v_club_ch_briefchair")] = true,
    [GetHashKey("v_club_officechair")] = true,
    [GetHashKey("v_club_stagechair")] = true,
    [GetHashKey("v_club_vuarmchair")] = true,
    [GetHashKey("v_corp_bk_chair1")] = true,
    [GetHashKey("v_corp_bk_chair2")] = true,
    [GetHashKey("v_corp_bk_chair3")] = true,
    [GetHashKey("v_corp_cd_chair")] = true,
    [GetHashKey("v_corp_lazychair")] = true,
    [GetHashKey("v_corp_lazychairfd")] = true,
    [GetHashKey("v_corp_offchair")] = true,
    [GetHashKey("v_corp_offchairfd")] = true,
    [GetHashKey("v_corp_sidechair")] = true,
    [GetHashKey("v_corp_sidechairfd")] = true,
    [GetHashKey("v_ilev_chair02_ped")] = true,
    [GetHashKey("v_ilev_hd_chair")] = true,
    [GetHashKey("v_ilev_m_dinechair")] = true,
    [GetHashKey("v_ilev_p_easychair")] = true,
    [GetHashKey("v_ind_ss_chair01")] = true,
    [GetHashKey("v_ind_ss_chair2")] = true,
    [GetHashKey("v_ind_ss_chair3_cso")] = true,
    [GetHashKey("v_med_fabricchair1")] = true,
    [GetHashKey("v_med_p_deskchair")] = true,
    [GetHashKey("v_med_p_easychair")] = true,
    [GetHashKey("v_med_whickchair2")] = true,
    [GetHashKey("v_med_whickchair2bit")] = true,
    [GetHashKey("v_med_whickerchair1")] = true,
    [GetHashKey("v_res_d_armchair")] = true,
    [GetHashKey("v_res_d_highchair")] = true,
    [GetHashKey("v_res_fa_chair01")] = true,
    [GetHashKey("v_res_fa_chair02")] = true,
    [GetHashKey("v_res_fh_barcchair")] = true,
    [GetHashKey("v_res_fh_easychair")] = true,
    [GetHashKey("v_res_j_dinechair")] = true,
    [GetHashKey("v_res_jarmchair")] = true,
    [GetHashKey("v_res_m_armchair")] = true,
    [GetHashKey("v_res_m_dinechair")] = true,
    [GetHashKey("v_res_mbchair")] = true,
    [GetHashKey("v_res_mp_stripchair")] = true,
    [GetHashKey("v_res_study_chair")] = true,
    [GetHashKey("v_res_tre_chair")] = true,
    [GetHashKey("v_res_tre_officechair")] = true,
    [GetHashKey("v_res_trev_framechair")] = true,
    [GetHashKey("v_ret_chair_white")] = true,
    [GetHashKey("v_ret_chair")] = true,
    [GetHashKey("v_ret_fh_chair01")] = true,
    [GetHashKey("v_ret_gc_chair01")] = true,
    [GetHashKey("v_ret_gc_chair02")] = true,
    [GetHashKey("v_ret_gc_chair03")] = true,
    [GetHashKey("v_ret_ps_chair")] = true,
    [GetHashKey("v_serv_bs_barbchair")] = true,
    [GetHashKey("v_serv_bs_barbchair2")] = true,
    [GetHashKey("v_serv_bs_barbchair3")] = true,
    [GetHashKey("v_serv_bs_barbchair5")] = true,
    [GetHashKey("v_serv_ct_chair01")] = true,
    [GetHashKey("v_serv_ct_chair02")] = true,

    [GetHashKey("v_ilev_leath_chr")] = true,
    [GetHashKey("prop_bench_01a")] = true,
    [GetHashKey("prop_bench_01b")] = true,
    [GetHashKey("prop_bench_01c")] = true,
    [GetHashKey("prop_bench_02")] = true,
    [GetHashKey("prop_bench_03")] = true,
    [GetHashKey("prop_bench_04")] = true,
    [GetHashKey("prop_bench_05")] = true,
    [GetHashKey("prop_bench_06")] = true,
    [GetHashKey("prop_bench_08")] = true,
    [GetHashKey("prop_bench_09")] = true,
    [GetHashKey("prop_bench_10")] = true,
    [GetHashKey("prop_bench_11")] = true,
    [GetHashKey("prop_fib_3b_bench")] = true,
    [GetHashKey("prop_ld_bench01")] = true,
    [GetHashKey("prop_wait_bench_01")] = true,
    [GetHashKey("prop_table_04_chr")] = true,
    [GetHashKey("prop_table_05_chr")] = true,
    [GetHashKey("prop_table_06_chr")] = true,
    [GetHashKey("v_ilev_leath_chr")] = true,
    [GetHashKey("prop_table_01_chr_a")] = true,
    [GetHashKey("prop_table_01_chr_b")] = true,
    [GetHashKey("prop_table_02_chr")] = true,
    [GetHashKey("prop_table_03b_chr")] = true,
    [GetHashKey("prop_table_03_chr")] = true,
    [GetHashKey("prop_torture_ch_01")] = true,
    [GetHashKey("v_ilev_fh_dineeamesa")] = true,
    [GetHashKey("v_ilev_fh_kitchenstool")] = true,
    [GetHashKey("v_ilev_tort_stool")] = true,
    [GetHashKey("hei_prop_yah_seat_01")] = true,
    [GetHashKey("hei_prop_yah_seat_02")] = true,
    [GetHashKey("hei_prop_yah_seat_03")] = true,
    [GetHashKey("prop_waiting_seat_01")] = true,
    [GetHashKey("prop_yacht_seat_01")] = true,
    [GetHashKey("prop_yacht_seat_02")] = true,
    [GetHashKey("prop_yacht_seat_03")] = true,
    [GetHashKey("prop_hobo_seat_01")] = true,
    [GetHashKey("prop_rub_couch01")] = true,
    [GetHashKey("miss_rub_couch_01")] = true,
    [GetHashKey("prop_ld_farm_couch01")] = true,
    [GetHashKey("prop_ld_farm_couch02")] = true,
    [GetHashKey("prop_rub_couch03")] = true,
    [GetHashKey("prop_rub_couch04")] = true,
    [GetHashKey("p_lev_sofa_s")] = true,
    [GetHashKey("p_res_sofa_l_s")] = true,
    [GetHashKey("p_v_med_p_sofa_s")] = true,
    [GetHashKey("p_yacht_sofa_01_s")] = true,
    [GetHashKey("v_ilev_m_sofa")] = true,
    [GetHashKey("v_res_tre_sofa_s")] = true,
    [GetHashKey("v_tre_sofa_mess_a_s")] = true,
    [GetHashKey("v_tre_sofa_mess_b_s")] = true,
    [GetHashKey("v_tre_sofa_mess_c_s")] = true,
    [GetHashKey("prop_roller_car_01")] = true,
    [GetHashKey("prop_roller_car_02")] = true,
    [GetHashKey("v_ilev_ph_bench")] = true,
    [GetHashKey("ex_prop_offchair_exec_04")] = true,
    [GetHashKey("ex_prop_offchair_exec_01")] = true,
    [GetHashKey("vw_prop_vw_offchair_02")] = true,
    [-997157373] = true,
    

	-- SEAT
	{prop = 'hei_prop_yah_seat_01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'hei_prop_yah_seat_02', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'hei_prop_yah_seat_03', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_waiting_seat_01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_yacht_seat_01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_yacht_seat_02', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_yacht_seat_03', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_hobo_seat_01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.65, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'gr_dlc_gr_yacht_props_seat_01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.65, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'gr_dlc_gr_yacht_props_seat_02', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.65, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'gr_dlc_gr_yacht_props_seat_03', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.65, forwardOffset = 0.0, leftOffset = 0.0},

	-- COUCH
	{prop = 'prop_rub_couch01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'miss_rub_couch_01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_ld_farm_couch01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_ld_farm_couch02', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_rub_couch02', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_rub_couch03', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_rub_couch04', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},

	-- SOFA
	{prop = 'p_lev_sofa_s', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'p_res_sofa_l_s', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'p_v_med_p_sofa_s', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'p_yacht_sofa_01_s', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_ilev_m_sofa', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_res_tre_sofa_s', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_tre_sofa_mess_a_s', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_tre_sofa_mess_b_s', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_tre_sofa_mess_c_s', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},

	-- MISC
	{prop = 'prop_roller_car_01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'prop_roller_car_02', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'p_v_med_p_sofa_s', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},

	{prop = 'v_med_p_sofa', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_ilev_ph_bench', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'hei_heist_bench03', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_club_stagechair', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_club_barchair', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_club_officesofa', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_corp_lazychair', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'v_corp_cd_recseat', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = 'hei_heist_toilet03', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},

	-- Burger Shot

	{prop = "ba_prop_battle_club_chair_01", scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},
	{prop = "v_res_fh_easychair", scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0},

}

local isSit = false
local oldCoords = vector3(0.0,0.0,0.0)
local verticalOffsetX = 0.0
local verticalOffsetY = 0.0
local verticalOffsetZ = -0.45
local direction = 180.0 



function SitChair()
    if isSit then
        isSit = false
        local pPed = PlayerPedId()
        ClearPedTasks(pPed)
        SetEntityCoords(pPed, oldCoords.x, oldCoords.y, oldCoords.z - 1.0, 0.0, 0.0, 0.0, 0)
        FreezeEntityPosition(pPed, false)
    else
        local closetObj = nil
        local closetDst = 100
        local objCoords = vector3(0.0, 0.0, 0.0)
        local dim = {}
        local dimZ = 0
        local pPed = PlayerPedId()
        local pCoords = GetEntityCoords(pPed)
        oldCoords = pCoords

        for k,v in pairs(chairs) do
            local closestObject = GetClosestObjectOfType(pCoords.x, pCoords.y, pCoords.z, 10.0, k, 0, 0, 0)
            local coordsObject = GetEntityCoords(closestObject)
            if coordsObject ~= vector3(0.0, 0.0, 0.0) then
                local distanceDiff = #(coordsObject - pCoords)
                local vDim, _ = GetModelDimensions(GetEntityModel(closestObject))

                if distanceDiff < closetDst then
                    closetObj = closestObject
                    closetDst = distanceDiff
                    objCoords = coordsObject
                    dim = vDim
                end
            end
        end

        if closetDst < 2.0 then
            FreezeEntityPosition(closetObj, true)
            FreezeEntityPosition(pPed, true)

            dimZ = objCoords.z - verticalOffsetZ

            if dim.z <= -0.3 then
                dimZ = objCoords.z + verticalOffsetZ / 5
            end

            isSit = true
            TaskStartScenarioAtPosition(pPed, "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", objCoords.x + verticalOffsetX, objCoords.y + verticalOffsetY, dimZ, GetEntityHeading(closetObj) + direction, 0, true, true)
             
            
            Citizen.CreateThread(function()
                
                while isSit do
                    ShowNotification("Faire /sit pour se lever de nouveau")
                    Wait(1)

                end
            end)
        else
            ShowNotification("Pas de chaise proche")
        end
    end
end