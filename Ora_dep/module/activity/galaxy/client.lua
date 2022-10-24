Citizen.CreateThread(function()
    Smoke()
    CreatePeds()
  end)

local clubsmoke = {
	{vec(372.126, 273.249, 90.00),vec(0.0, 0.0, 0.0)},
	{vec(373.115, 277.976, 90.00),vec(0.0, 0.0, 0.0)},
	{vec(370.88, 279.56, 90.00),vec(0.0, 0.0, 0.0)},
	{vec(367.021, 282.936, 90.00),vec(0.0, -10.0, 270.0)},
	{vec(361.695, 275.508, 90.00),vec(0.0, -10.0, 20.0)},
	{vec(368.398, 273.073, 90.00),vec(0.0, -10.0, 80.0)},
	{vec(377.196, 282.073, 90.00),vec(0.0, -10.0, -150.00)},
}
local spawnedclubsmoke = {}
local smokemachines = {
	{vec(367.021, 282.936, 90.00),vec(0.0, -10.0, 270.0)},
	{vec(361.695, 275.508, 90.00),vec(0.0, -10.0, 20.0)},
	{vec(368.398, 273.073, 90.00),vec(0.0, -10.0, 80.0)},
	{vec(377.196, 282.073, 90.00),vec(0.0, -10.0, -150.00)},
}
local spawnedsmokemachines = {}

local InsidePeds = {
	["Dancer1"] 		= {false, 25, "u_f_y_dancerave_01", vec3(371.813, 280.121, 91.00), 129.00},
	["Dancer2"] 		= {false, 25, "u_f_y_dancerave_01", vec3(367.598, 273.270, 91.00), 352.0}
}

local PedAnims = {
	["Dancer1"] 		= {false, "anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_female^2"},
	["Dancer2"] 		= {false, "anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5"},
}

function Smoke()
  
  RequestNamedPtfxAsset("scr_ba_club")
	while not HasNamedPtfxAssetLoaded("scr_ba_club") do Citizen.Wait(0) end
    for i,v in ipairs(clubsmoke) do
      if not DoesParticleFxLoopedExist(spawnedclubsmoke[i]) then
        UseParticleFxAssetNextCall("scr_ba_club")
        spawnedclubsmoke[i] = StartParticleFxLoopedAtCoord("scr_ba_club_smoke", v[1], v[2], 1.0, 0, 0, 0, 1)
        SetParticleFxLoopedColour(spawnedclubsmoke[i], 255.0, 255.0, 255.0, 1)
      end
	end
	for i,v in ipairs(smokemachines) do
    if not DoesParticleFxLoopedExist(spawnedsmokemachines[i]) then
      UseParticleFxAssetNextCall("scr_ba_club")
      spawnedsmokemachines[i] = StartParticleFxLoopedAtCoord("scr_ba_club_smoke_machine", v[1], v[2], 5.0, 0, 0, 0, 1)
      SetParticleFxLoopedColour(spawnedsmokemachines[i], 255.0, 255.0, 255.0, 1)
    end
  end
  RemovePtfxAsset("scr_ba_club")
end

function RequestEntModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do Citizen.Wait(0) end
	SetModelAsNoLongerNeeded(model)
end

function playAnim(ped, animDict, animName)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, -1, 1, 1, false, false, false)
	RemoveAnimDict(animDict)
end

function CreatePeds()
	for k,v in pairs(InsidePeds) do
		if not v[1] then
			RequestEntModel(v[3])
			v[1] = CreatePed(v[2], v[3], v[4], v[5], false, true)
			if v[6] ~= nil then
				TaskStartScenarioAtPosition(v[1], v[6], v[7], v[8], -1, false, true)
			end
			DecorSetInt(v[1], "propHack", 74)
			SetModelAsNoLongerNeeded(v[2])
		end
		--[[for q,t in pairs(PedComponents) do
			if q == k then
				t[1] = v[1]
			end
		end]]
		for i,o in pairs(PedAnims) do
			if i == k then
				o[1] = v[1]
			end
		end
		if k == "Dancer1" or k == "Dancer2" then
			FreezeEntityPosition(v[1], true)
		end
		SetPedAsEnemy(v[1], false)
		SetBlockingOfNonTemporaryEvents(v[1], true)
		SetPedResetFlag(v[1], 249, true)
		SetPedConfigFlag(v[1], 185, true)
		SetPedConfigFlag(v[1], 108, true)
		SetPedConfigFlag(v[1], 106, true)
		SetPedCanEvasiveDive(v[1], false)
		N_0x2f3c3d9f50681de4(v[1], 1)
		SetPedCanRagdollFromPlayerImpact(v[1], false)
		SetPedCanRagdoll(v[1], false)
		SetPedConfigFlag(v[1], 208, true)
	end
	--[[for k,v in pairs(PedComponents) do
		SetPedComponentVariation(v[1], v[2], v[3], v[4], v[5])
	end]]
	for k,v in pairs(PedAnims) do
		playAnim(v[1], v[2], v[3])
	end
end

function StopSmoke()
	--[[for k,v in pairs(InsidePeds) do
		if DoesEntityExist(v[1]) then
			DeleteEntity(v[1])
			v[1] = false
		end
	end]]
	for k,v in pairs(spawnedclubsmoke) do
		if DoesParticleFxLoopedExist(v) then
			StopParticleFxLooped(v, false)
		end
	end
	for k,v in pairs(spawnedsmokemachines) do
		if DoesParticleFxLoopedExist(v) then
			StopParticleFxLooped(v, false)
		end
	end
end



local int_id = GetInteriorAtCoords(345.4899597168,294.95315551758,98.191421508789)



--============================ DO NOT TOUCH ==================================
-- upgrade
EnableInteriorProp(int_id , "Int01_ba_security_upgrade")
EnableInteriorProp(int_id , "Int01_ba_equipment_setup")

DisableInteriorProp(int_id , "Int01_ba_Style01") 
EnableInteriorProp(int_id , "Int01_ba_Style02") 
DisableInteriorProp(int_id , "Int01_ba_Style03") 

DisableInteriorProp(int_id , "Int01_ba_style01_podium") 
DisableInteriorProp(int_id , "Int01_ba_style02_podium") 
EnableInteriorProp(int_id , "Int01_ba_style03_podium") 

EnableInteriorProp(int_id , "int01_ba_lights_screen")
EnableInteriorProp(int_id , "Int01_ba_Screen")
EnableInteriorProp(int_id , "Int01_ba_bar_content")
DisableInteriorProp(int_id , "Int01_ba_booze_01") 
DisableInteriorProp(int_id , "Int01_ba_booze_02") 
DisableInteriorProp(int_id , "Int01_ba_booze_03") 
DisableInteriorProp(int_id , "Int01_ba_dj01")
DisableInteriorProp(int_id , "Int01_ba_dj02")
DisableInteriorProp(int_id , "Int01_ba_dj03")
EnableInteriorProp(int_id , "Int01_ba_dj04")

DisableInteriorProp(int_id , "DJ_01_Lights_01")
EnableInteriorProp(int_id , "DJ_01_Lights_02")
DisableInteriorProp(int_id , "DJ_01_Lights_03")
DisableInteriorProp(int_id , "DJ_01_Lights_04")

DisableInteriorProp(int_id , "DJ_02_Lights_01")
DisableInteriorProp(int_id , "DJ_02_Lights_02")
DisableInteriorProp(int_id , "DJ_02_Lights_03")
DisableInteriorProp(int_id , "DJ_02_Lights_04") -- Lumières moches

DisableInteriorProp(int_id , "DJ_03_Lights_01") -- Murs plafond
DisableInteriorProp(int_id , "DJ_03_Lights_02")
DisableInteriorProp(int_id , "DJ_03_Lights_03")
DisableInteriorProp(int_id , "DJ_03_Lights_04")

DisableInteriorProp(int_id , "DJ_04_Lights_01")
DisableInteriorProp(int_id , "DJ_04_Lights_02")
DisableInteriorProp(int_id , "DJ_04_Lights_03")
DisableInteriorProp(int_id , "DJ_04_Lights_04")

DisableInteriorProp(int_id , "light_rigs_off")
EnableInteriorProp(int_id , "Int01_ba_lightgrid_01")
DisableInteriorProp(int_id , "Int01_ba_Clutter")
EnableInteriorProp(int_id , "Int01_ba_equipment_upgrade")
EnableInteriorProp(int_id , "Int01_ba_clubname_01") -- galaxy
DisableInteriorProp(int_id , "Int01_ba_clubname_02") --studio
DisableInteriorProp(int_id , "Int01_ba_clubname_03") --omega
DisableInteriorProp(int_id , "Int01_ba_clubname_04") --tehnology
DisableInteriorProp(int_id , "Int01_ba_clubname_05") --gefangnis
DisableInteriorProp(int_id , "Int01_ba_clubname_06") --maisonnette
DisableInteriorProp(int_id , "Int01_ba_clubname_07") -- tony 
DisableInteriorProp(int_id , "Int01_ba_clubname_08") -- the palace
DisableInteriorProp(int_id , "Int01_ba_clubname_09") -- paradise

EnableInteriorProp(int_id , "Int01_ba_dry_ice")
DisableInteriorProp(int_id , "Int01_ba_deliverytruck")
EnableInteriorProp(int_id , "Int01_ba_trophy04")
EnableInteriorProp(int_id , "Int01_ba_trophy05")
DisableInteriorProp(int_id , "Int01_ba_trophy07")
DisableInteriorProp(int_id , "Int01_ba_trophy09")
DisableInteriorProp(int_id , "Int01_ba_trophy08")
DisableInteriorProp(int_id , "Int01_ba_trophy11")
DisableInteriorProp(int_id , "Int01_ba_trophy10")
DisableInteriorProp(int_id , "Int01_ba_trophy03")
DisableInteriorProp(int_id , "Int01_ba_trophy01")
DisableInteriorProp(int_id , "Int01_ba_trophy02")
EnableInteriorProp(int_id , "Int01_ba_trad_lights")
DisableInteriorProp(int_id , "Int01_ba_Worklamps")
RefreshInterior(int_id )


--Render--
function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end

	return handle
end


local Playlists = {
  "PL_DIX_NL_GALAXY", -- DIXON
  "PL_DIX_LED_GALAXY",
  "PL_DIX_GEO_GALAXY", -- GALAXY
  "PL_DIX_RIB_GALAXY",
  "PL_DIX_LSER_GALAXY", --DIXON
  "PL_SOL_NL_GALAXY",
  "PL_SOL_LED_GALAXY",
  "PL_SOL_GEO_GALAXY",
  "PL_SOL_RIB_GALAXY",
  "PL_SOL_LSER_GALAXY",
  "PL_TBM_NL_GALAXY", -- RED
  "PL_TBM_LED_GALAXY",
  "PL_TBM_GEO_GALAXY",
  "PL_TBM_RIB_GALAXY",
  "PL_TBM_LSER_GALAXY",
  "PL_TOU_NL_GALAXY",
  "PL_TOU_LED_GALAXY",
  "PL_TOU_GEO_GALAXY",
  "PL_TOU_RIB_GALAXY",
  "PL_TOU_LSER_GALAXY"

}

--Nightclub Screens--
Citizen.CreateThread(function ()
	local model = GetHashKey("ba_prop_club_screens_01"); -- 1194029334
	local pos = { x = 345.4899597168, y = 294.95315551758, z = 98.191421508789 };
	local entity = GetClosestObjectOfType(pos.x, pos.y, pos.z, 20.0, model, 0, 0, 0)
	local handle = CreateNamedRenderTargetForModel("club_projector", model)

	RegisterScriptWithAudio(0)
	SetTvChannel(-1)

	Citizen.InvokeNative(0x9DD5A62390C3B735, 2, "PL_TOU_LSER_GALAXY", 0)
	SetTvChannel(2)
	EnableMovieSubtitles(1)

	while true do
		SetTvAudioFrontend(0)
		AttachTvAudioToEntity(entity)
		SetTextRenderId(handle)
			Set_2dLayer(4)
			Citizen.InvokeNative(0x9DD5A62390C3B735, 1)
			DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
		SetTextRenderId(GetDefaultScriptRendertargetRenderId())
		Citizen.Wait(0)
	end
end)

-------------------------------------------------------------------------- LIGHT