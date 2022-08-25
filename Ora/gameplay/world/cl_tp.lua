local tpPoints = {
	{
		name = "Salle de crise",
		msgText = "la salle de crise",
		entryPos = vector3(-1042.672, -828.539, 10.8801-0.99),
		entryHeading = 0.0,
		interiorPos = vector3(-1042.38, -828.03, 9.88-0.99),
		interiorHeading = 184.98,
		--restrictedJob = {"police", "gouv"}
		Load = function()
			-- interiorID = GetInteriorAtCoordsWithType(345.0041, 4842.001, -59.9997, "xm_x17dlc_int_02")
			
			-- if IsValidInterior(interiorID) then
			-- 	EnableInteriorProp(interiorID, "set_int_02_decal_01")
			-- 	EnableInteriorProp(interiorID, "set_int_02_lounge1")
			-- 	EnableInteriorProp(interiorID, "set_int_02_cannon")
			-- 	EnableInteriorProp(interiorID, "set_int_02_clutter1")
			-- 	EnableInteriorProp(interiorID, "set_int_02_crewemblem")	
			-- 	EnableInteriorProp(interiorID, "set_int_02_shell")
			-- 	EnableInteriorProp(interiorID, "set_int_02_security")
			-- 	EnableInteriorProp(interiorID, "set_int_02_sleep")
			-- 	EnableInteriorProp(interiorID, "set_int_02_trophy1")
			-- 	EnableInteriorProp(interiorID, "set_int_02_paramedic_complete")
			-- 	EnableInteriorProp(interiorID, "set_Int_02_outfit_paramedic")
			-- 	EnableInteriorProp(interiorID, "set_Int_02_outfit_serverfarm")
			-- 	SetInteriorPropColor(interiorID, "set_int_02_decal_01", 1)
			-- 	SetInteriorPropColor(interiorID, "set_int_02_lounge1", 1)
			-- 	SetInteriorPropColor(interiorID, "set_int_02_cannon", 1)
			-- 	SetInteriorPropColor(interiorID, "set_int_02_clutter1", 1)
			-- 	SetInteriorPropColor(interiorID, "set_int_02_shell", 1)
			-- 	SetInteriorPropColor(interiorID, "set_int_02_security", 1)
			-- 	SetInteriorPropColor(interiorID, "set_int_02_sleep", 1)
			-- 	SetInteriorPropColor(interiorID, "set_int_02_trophy1", 1)
			-- 	SetInteriorPropColor(interiorID, "set_int_02_paramedic_complete", 1)
			-- 	SetInteriorPropColor(interiorID, "set_Int_02_outfit_paramedic", 1)
			-- 	SetInteriorPropColor(interiorID, "set_Int_02_outfit_serverfarm", 1)
			-- 	RefreshInterior(interiorID)
			-- end	
			return true
		end
	}
}

Citizen.CreateThread(function()
	while true do
		local plyPos = LocalPlayer().Pos
		for k, v in pairs(tpPoints) do
			if #(plyPos - v.entryPos) < 2.0 then
				DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour accéder à ~b~" .. v.msgText .. "~s~.")
				DrawMarker(25, v.entryPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255, false, false, 2, false, false, false, false)
				if IsControlJustPressed(0, 38) then
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)
					v.Load()
					SetEntityCoords(PlayerPedId(), v.interiorPos)
					SetEntityHeading(PlayerPedId(), v.interiorHeading)
					DoScreenFadeIn(1000)
				end
			end
			if #(plyPos - v.interiorPos) < 2.0 then	
				DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour sortir de ~b~" .. v.msgText .. "~s~.")
				DrawMarker(25, v.interiorPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255, false, false, 2, false, false, false, false)
				if IsControlJustPressed(0, 38) then
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)
					SetEntityCoords(PlayerPedId(), v.entryPos)
					SetEntityHeading(PlayerPedId(), v.entryHeading)
					DoScreenFadeIn(1000)
				end
			end
		end
		Citizen.Wait(1)
	end
end)

function DisplayHelpText(str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(str)
	EndTextCommandDisplayHelp(0, false, true, -1)
end