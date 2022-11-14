local defaultFaceData <const> = {
    freckles = {
        style = 0,
        opacity = 0
    },
    face = {
        mom = 1,
        face = 0,
        skin = 0,
        dad = 1
    },
    model = "mp_m_freemode_01",
    complexion = {
        style = 0,
        opacity = 0
    },
    facial = {
        features = {
            chimp = {
                bone = {
                    length = 0,
                    lowering = 0,
                    width = 0
                },
                hole = 0
            },
            lips = {
                thickness = 0
            },
            nose = {
                bone = {
                    height = 0,
                    twist = 0
                },
                width = 0,
                peak = {
                    height = 0,
                    lowering = 0,
                    length = 0
                }
            },
            cheeks = {
                bone = {
                    height = 0,
                    width = 0
                },
                width = 0
            },
            eyebrow = {
                forward = 0,
                height = 0
            },
            jaw = {
                bone = {
                    backLength = 0,
                    width = 0
                }
            },
            neck = {
                thickness = 0
            },
            eye = {
                opening = 0
            }
        },
        hair = {
            beard = {
                opacity = 0,
                color = { 0, 0 },
                style = 1
            },
            eyebrow = {
                opacity = 0,
                color = { 0, 0 },
                style = 1
            }
        }
    },
    blush = {
        opacity = 0,
        color = { 0, 0 },
        style = 0
    },
    skinAspect = {
        style = 0,
        opacity = 1
    },
    chestHair = {
        opacity = 0,
        color = { 0, 0 },
        style = 0
    },
    ageing = {
        style = 1,
        opacity = 0
    },
    hair = {
        color = { 0, 0 },
        style = 0
    },
    makeup = {
        opacity = 0,
        color = { 0, 0 },
        style = 0
    },
    skinMix = 0.8,
    lipstick = {
        opacity = 0,
        color = { 0, 0 },
        style = 0
    },
    blemishes = {
        style = 0,
        opacity = 0
    },
    resemblance = 0.8,
    eye = {
        style = 1
    },
    razorCut = {
        index = 0,
        style = 0,
        opacity = 0
    },
}

pedIndex = 1
isPed = false

function ProcessMenuCharacter(indexCharacter, createPlayer)
	creating = true
	local Cped = false
	RageUI.DrawContent({header = true, instructionalButton = true}, function()
		---Items
		if sexIndex == 1 then
			--UpdatePlayerPedFreemodeCharacter(PlayerPedId(), "mp_f_freemode_01", createPlayer[createPlayer.Model].Face, createPlayer[createPlayer.Model].Outfit, createPlayer[createPlayer.Model].Tattoo)
		elseif sexIndex == 2 then
			-- UpdatePlayerPedFreemodeCharacter(PlayerPedId(), "mp_m_freemode_01", createPlayer[createPlayer.Model].Face, createPlayer[createPlayer.Model].Outfit, createPlayer[createPlayer.Model].Tattoo)
		else
			Cped = true
		end
		
		RageUI.List("Type de création",{"Héritage", "Normal", "Ped"}, indexC, nil, {}, true, function(Hovered, Active, Selected, Index)
			indexC = Index
		end)
		
		if (indexC == 2 or indexC == 1) then
			isPed = false
			RageUI.CenterButton("~b~-----------------~b~",nil,{},true,function(_, _, _) end)
			
			RageUI.List("Votre sexe",sexList,sexIndex,GetLabelText("FACE_MM_H2"),{},true,function(Hovered, Active, Selected, Index)
				if Active and sexIndex ~= Index then
					sexIndex = Index
					
					if Index == 1 then
						createPlayer.Model = "mp_f_freemode_01"
					elseif Index == 2 then
						createPlayer.Model = "mp_m_freemode_01"
					else
						createPlayer.Model = pedList[sexIndex]
					end
					
					if createPlayer[createPlayer.Model] ~= nil then
						-- Reset the ped face to the 0, with no face features
						createPlayer[createPlayer.Model].Face = defaultFaceData
						UpdatePlayerPedFreemodeCharacter(
							PlayerPedId(),
							createPlayer.Model,
							createPlayer[createPlayer.Model].Face,
							createPlayer[createPlayer.Model].Outfit,
							createPlayer[createPlayer.Model].Tattoo
						)
					else
						RequestModel(createPlayer.Model)
						while not HasModelLoaded(createPlayer.Model) do
							Citizen.Wait(10)
						end
						SetPlayerModel(PlayerId(), GetHashKey(createPlayer.Model))
					end
					RestartAnimProcess()
					--CreatorUpdateModelAnim()
				end
			end)
		else
			isPed = true
			RageUI.CenterButton("~b~-----------------~b~",nil,{},true,function(_, _, _) end)

			RageUI.List("Modele de votre PED", pedList, pedIndex, GetLabelText("FACE_MM_H2"), {}, true, function(Hovered, Active, Selected, Index)
				if Active and pedIndex ~= Index then
					if (hasBeenLoaded == false) then
						hasBeenLoaded = true
						RequestModel(createPlayer.Model)
						while not HasModelLoaded(createPlayer.Model) do
							Citizen.Wait(10)
						end
						SetPlayerModel(PlayerId(), GetHashKey(createPlayer.Model))
					end
					pedIndex = Index
					createPlayer.Model = pedList[pedIndex]
					
					if createPlayer[createPlayer.Model] ~= nil then
						UpdatePlayerPedFreemodeCharacter(PlayerPedId(),createPlayer.Model,
							createPlayer[createPlayer.Model].Face,
							createPlayer[createPlayer.Model].Outfit,
							createPlayer[createPlayer.Model].Tattoo
						)
					else
						RequestModel(createPlayer.Model)
						while not HasModelLoaded(createPlayer.Model) do
							Citizen.Wait(10)
						end
						SetPlayerModel(PlayerId(), GetHashKey(createPlayer.Model))
						SetPedDefaultComponentVariation(PlayerPedId())
						SetModelAsNoLongerNeeded(createPlayer.Model)
					end
					RestartAnimProcess()
					--CreatorUpdateModelAnim()
				end
			end)
		end


		if createPlayer[createPlayer.Model] ~= nil and not Cped then
			if indexC == 1 then
				RageUI.Button(GetLabelText("FACE_HERI"), GetLabelText("FACE_MM_H3"), {},true,function(Hovered, Active, Selected)
					if Selected then
						--CreatorZoomIn(GetCreatorCam())
						--UpdateCreatorTick("FaceTurnEnabled", true)
					end
				end,RMenu:Get("mugshot", "heritage"))
			elseif (indexC == 2) then 
				if createPlayer[createPlayer.Model].Face.face.face == nil then
					createPlayer[createPlayer.Model].Face.face.face = 1
				end
				local am = {}
				local amd = {}
				for i = 1, 46, 1 do
					am[i] = i
					amd[i] = i - 1
				end
				RageUI.List("Visage", amd,indexCharacter[createPlayer.Model].Face.face.face + 1, nil, {}, true, function(Hovered, Active, Selected, Index)
					createPlayer[createPlayer.Model].Face.face.face = amd[Index]
					indexCharacter[createPlayer.Model].Face.face.face = amd[Index]
					createPlayer[createPlayer.Model].Face.resemblance = sexIndex == 1 and 0.0 or 0.8
					createPlayer[createPlayer.Model].Face.skinMix = sexIndex == 1 and 0.0 or 0.8
					if Active then
						UpdateEntityFace(PlayerPedId(), createPlayer[createPlayer.Model].Face)
					end
					-- if Active and not ZoomV and (not ZoomV2) then
					-- 	--print("zooom")
					--CreatorZoomIn(GetCreatorCam())
					-- 	--UpdateCreatorTick("FaceTurnEnabled", true)
					-- 	ZoomV = true
					-- elseif not Active and ZoomV then
					-- 	--print("zooom 2 ")
					-- 	ZoomV = false
					-- 	CreatorZoomOut(GetCreatorCam())
					-- 	--UpdateCreatorTick("FaceTurnEnabled", false)
					-- end
				end)
				local amX = {}
				local amdX = {}
				for i = 1, 45, 1 do
					amX[i] = i
					amdX[i] = i - 1
				end
				if createPlayer[createPlayer.Model].Face.face.skin == nil then
					createPlayer[createPlayer.Model].Face.face.skin = 1
				end
				RageUI.List("Teint",amdX,createPlayer[createPlayer.Model].Face.face.skin + 1,nil,{},true,function(Hovered, Active, Selected, Index)
					createPlayer[createPlayer.Model].Face.face.skin = amdX[Index]
					createPlayer[createPlayer.Model].Face.resemblance = sexIndex == 1 and 0.0 or 0.8
					createPlayer[createPlayer.Model].Face.skinMix = sexIndex == 1 and 0.0 or 0.8
					if Active then
						UpdateEntityFace(PlayerPedId(), createPlayer[createPlayer.Model].Face)
					end
					if Active and not ZoomV2 then
						--CreatorZoomIn(GetCreatorCam())
						--UpdateCreatorTick("FaceTurnEnabled", true)
						ZoomV2 = true
						ZoomV = false
					elseif not Active and ZoomV2 then
						ZoomV2 = false
						--CreatorZoomOut(GetCreatorCam())
						--UpdateCreatorTick("FaceTurnEnabled", false)
					end
				end)
			end
			RageUI.Button(GetLabelText("FACE_FEAT"),GetLabelText("FACE_MM_H4"),{},true,function(Hovered, Active, Selected)
				if Selected then
					--CreatorZoomIn(GetCreatorCam())
					--UpdateCreatorTick("FaceTurnEnabled", true)
				end
			end,RMenu:Get("mugshot", "faceFeature"))
			RageUI.Button(GetLabelText("FACE_APP"),GetLabelText("FACE_MM_H6"),{},true,function(Hovered, Active, Selected)
				if Selected then
					--CreatorZoomIn(GetCreatorCam())
					--UpdateCreatorTick("FaceTurnEnabled", true)
				end
			end,RMenu:Get("mugshot", "apparence"))

			RageUI.Button(GetLabelText("FACE_APPA"),GetLabelText("FACE_MM_H6"),{},true,function(Hovered, Active, Selected)
				if Selected then
					OnClothesOpen()
					--UpdateCreatorTick("FaceTurnEnabled", true)
				end
			end,RMenu:Get("mugshot", "clothes"))
		else
			for i = 0, 11, 1 do
				local m = {}
				
				for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), i) do
					m[i + 1] = i + 1
				end
				if #m ~= 0 then
					if (GetPedDrawableVariation(PlayerPedId(), i) + 1 >= 1) then
						RageUI.List("Variation " .. i, m, GetPedDrawableVariation(PlayerPedId(), i) + 1, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
							if Active then
								if Index - 1 ~= GetPedDrawableVariation(PlayerPedId(), i) then
									SetPedComponentVariation(PlayerPedId(), i, Index - 1, 0, 0)
								end
							end
						end)
					end
					
					local x = {}
					for t = 0, GetNumberOfPedTextureVariations(PlayerPedId(), i,GetPedDrawableVariation(PlayerPedId(), i)) - 1, 1 do
						table.insert(x, t)
					end
					if tablelength(x) > 1 then
						RageUI.List("Texture " .. i, x, GetPedTextureVariation(PlayerPedId(), i) + 1, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
							if Active then
								if Index - 1 ~= GetPedTextureVariation(PlayerPedId(), i) then
									SetPedComponentVariation(PlayerPedId(),i,GetPedDrawableVariation(PlayerPedId(), i),Index - 1,0)
								end
							end
						end)
					end
				end
			end
		end
	end,function()
		---Panels
	end)
end