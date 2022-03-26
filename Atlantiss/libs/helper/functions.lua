function returnTime(time, bl)
    return bl and MilliSecondsToClock(time) or SecondsToClock(time)
end

-- basic DrawText2D method shared by numeros functions
function generateUuid()
    local uuid = ""
    TriggerEvent(
        "atlantiss:generateUuid",
        function(localUuid)
            uuid = localUuid
        end
    )

    return uuid
end


function DrawTopNotification(txt, beep)
	BeginTextCommandDisplayHelp("jamyfafi")
	AddLongString(txt)
	EndTextCommandDisplayHelp(0, 0, beep, -1)
end

function toboolean(v)
    return v and ( (type(v)=="number") and (v==1) or ( (type(v)=="string") and (v=="true") ) )
end

math.randomseed(GetGameTimer())
local itemVariableIncrementForId = math.random(10000, 90000)
local timerConnectedAt = GetGameTimer()

function generateUUIDV2()
    local randomTest = uuid.seeder()
    local uuidForItem = uuid.new(randomTest)
    randomTest = uuid.seeder()
    itemVariableIncrementForId = itemVariableIncrementForId + 1
    uuidForItem = timerConnectedAt .. "-" .. uuidForItem .. "-" .. itemVariableIncrementForId
    print("^5[DBG] Generated new UUID " .. uuidForItem .. "^0")
    return uuidForItem
end

-- basic DrawText3D method shared by numeros functions
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end

-- basic DrawText2D method shared by numeros functions
function DrawText2D(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

-- Returns the vehicle identifier (model hashkey + plate number) + pcall to avoid errors
function getVehicleIdentifier(vehicle)
    local status, vehicleIdentifier = pcall(getVehicleIdentifierInternal, vehicle)
    if (status == true) then
        return vehicleIdentifier
    end
end

-- Internal vehicle identifier, always called by a pcall to avoid errors
function getVehicleIdentifierInternal(vehicle)
    return GetEntityModel(vehicle) .. "|" .. GetVehicleNumberPlateText(vehicle)
end

function getInventoryMaxWeight()
    return 40
end

local safeZone = (1.0) * 0.5
local timerBar = {
    baseX = 0.918,
    baseY = 0.984,
    baseWidth = 0.165,
    baseHeight = 0.035,
    baseGap = 0.038,
    titleX = 0.012,
    titleY = -0.009,
    textX = 0.0785,
    textY = -0.0165,
    progressX = 0.047,
    progressY = 0.0015,
    progressWidth = 0.0616,
    progressHeight = 0.0105,
    txtDict = "timerbars",
    txtName = "all_black_bg",
}

function DrawTimerProgressBar(idx, title, progress, titleColor, fgColor, bgColor, usePlayerStyle)
    local title = title or ""
    local titleColor = titleColor or { 255, 255, 255, 255 }
    local progress = progress or false
    local fgColor = fgColor or { 255, 255, 255, 255 }
    local bgColor = bgColor or { 255, 255, 255, 255 }
    local titleScale = usePlayerStyle and 0.465 or 0.3
    local titleFont = usePlayerStyle and 4 or 0
    local titleFontOffset = usePlayerStyle and 0.00625 or 0.0

    local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

    if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
        RequestStreamedTextureDict(timerBar.txtDict, true)

        local t = GetGameTimer() + 5000
        
        repeat
            Citizen.Wait(0)
        until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
    end

    DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(titleFont)
    SetTextScale(titleScale, titleScale)
    SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
    AddTextComponentSubstringPlayerName(title)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

    local progress = (progress < 0.0) and 0.0 or ((progress > 1.0) and 1.0 or progress)
    local progressX = (timerBar.baseX - safeZone) + timerBar.progressX
    local progressY = yOffset + timerBar.progressY
    local progressWidth = timerBar.progressWidth * progress

    DrawRect(progressX, progressY, timerBar.progressWidth, timerBar.progressHeight, bgColor[1], bgColor[2], bgColor[3], bgColor[4])
    DrawRect((progressX - timerBar.progressWidth / 2) + progressWidth / 2, progressY, progressWidth, timerBar.progressHeight, fgColor[1], fgColor[2], fgColor[3], fgColor[4])

    if idx ~= nil then
        if idx[1] then
            idx[1] = idx[1] + 1
        end
    end
end

function DrawCenterText(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

function DrawTimerBar(idx, title, text, titleColor, textColor, usePlayerStyle)
    local title = title or ""
    local text = text or ""
    local titleColor = titleColor or { 255, 255, 255, 255 }
    local textColor = textColor or { 255, 255, 255, 255 }
    local titleScale = usePlayerStyle and 0.465 or 0.3
    local titleFont = usePlayerStyle and 4 or 0
    local titleFontOffset = usePlayerStyle and 0.00625 or 0.0

    local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

    if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
        RequestStreamedTextureDict(timerBar.txtDict, true)

        local t = GetGameTimer() + 5000
        
        repeat
            Citizen.Wait(0)
        until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
    end

    DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(titleFont)
    SetTextScale(titleScale, titleScale)
    SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
    AddTextComponentSubstringPlayerName(title)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(0)
    SetTextScale(0.425, 0.425)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.textX)
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.textX, yOffset + timerBar.textY)

    if idx ~= nil then
        if idx[1] then
            idx[1] = idx[1] + 1
        end
    end
end

function s2m(s)
    if s <= 0 then
        return "00:00"
    else
        local m = string.format("%02.f", math.floor(s/60))
        return m..":"..string.format("%02.f", math.floor(s - m * 60))
    end
end

function DrawNiceText(qX, h_8, xL7OTb, w8T3f, K, qL, vfIyB)
    SetTextFont(K)
    SetTextScale(xL7OTb, xL7OTb)
    SetTextColour(255, 255, 255, 255)
    SetTextJustification(qL or 1)
    BeginTextCommandDisplayText("STRING")
    if vfIyB then
        SetTextWrap(qX, qX + .1)
    end
    AddTextComponentSubstringPlayerName(w8T3f)
    EndTextCommandDisplayText(qX, h_8)
end

function ShowLoadingPrompt(showText, showTime, showType)
	Citizen.CreateThread(function()
		Citizen.Wait(0)
		BeginTextCommandBusyspinnerOn("STRING")
		AddTextComponentSubstringPlayerName(showText)
		EndTextCommandBusyspinnerOn(showType)
		Citizen.Wait(showTime)
		BusyspinnerOff()
	end)
end

function SecondsToClock(seconds)
	seconds = tonumber(seconds)

	if seconds <= 0 then
		return "00:00"
	else
		local mins = string.format("%02.f", math.floor(seconds / 60))
		local secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end

function tableHasValue(tbl, value, k)
    if not tbl or not value or type(tbl) ~= "table" then
        return
    end
    for _, v in pairs(tbl) do
        if k and v[k] == value or v == value then
            return true, _
        end
    end
end


function GetByteCount(str)
    local bytes = 0

    for c in str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        local a,b,c,d = c:byte(1, -1)
        if a ~= nil then
            bytes = bytes + 1
        end
        if b ~= nil then
            bytes = bytes + 1
        end
        if c ~= nil then
            bytes = bytes + 1
        end
        if d ~= nil then
            bytes = bytes + 1
        end
    end
    return bytes
end


function AddLongStringForAscii(str)
    local maxbytelength = 99
    for i = 0, GetCharacterCount(str), 99 do
        AddTextComponentSubstringPlayerName(string.sub(str, i, math.min(maxbytelength, GetCharacterCount(str) - i))) --needs changed
    end
end

function AddLongStringForUtf8(str)
    local maxbytelength = 99
    local bytecount = GetByteCount(str)

    if bytecount < maxbytelength then
        AddTextComponentSubstringPlayerName(str)
        return
    end

    local startIndex = 0

    for i = 0, GetCharacterCount(str), 1 do
        local length = i - startIndex
        if GetByteCount(string.sub(str, startIndex, length)) > maxbytelength then
            AddTextComponentSubstringPlayerName(string.sub(str, startIndex, length - 1))
            i = i - 1
            startIndex = startIndex + (length - 1)
        end
    end
    AddTextComponentSubstringPlayerName(string.sub(str, startIndex, GetCharacterCount(str) - startIndex))
end 

function AddLongString(txt)
    local maxLen = 100
	for i = 0, string.len(txt), maxLen do
		local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
		AddTextComponentSubstringPlayerName(sub)
	end
end

function ShowAboveRadarMessage(message, back)
	if back then ThefeedNextPostBackgroundColor(back) end
	BeginTextCommandThefeedPost("jamyfafi")
	AddLongString(message)
	return EndTextCommandThefeedPostTicker(0, 1)
end

function ifModuleLoaded(moduleName)
    if (Atlantiss ~= nil and Atlantiss[moduleName] ~= nil) then
        return true
    end

    return false
end

function PlaySimpleForceAnim(animName, flag, args)
	flag, args = flag and tonumber(flag) or false, args or {}
	local ped, time, clearTasks, animPos, animRot, animTime = args.ped or GetPlayerPed(-1), args.time, args.clearTasks, args.pos, args.ang

	if IsPedInAnyVehicle(ped) and (not flag or flag < 40) then return end

	if not clearTasks then ClearPedTasks(ped) end

	if not animName[2] and femaleFix[animName[1]] and GetEntityModel(ped) == -1667301416 then
		animName = femaleFix[animName[1]]
	end

	if animName[2] then
		RequestAndWaitDict(animName[1])
	end

	if not animName[2] then
		ClearAreaOfObjects(GetEntityCoords(ped), 1.0)
		TaskStartScenarioInPlace(ped, animName[1], -1, not tableHasValue(animBug, animName[1]))
	else
		if not animPos then
			TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, flag or 44, 0, 0, 0, 0, 0)
		else
			TaskPlayAnimAdvanced(ped, animName[1], animName[2], animPos.x, animPos.y, animPos.z, animRot.x, animRot.y, animRot.z, 8.0, -8.0, -1, flag or 44, animTime or -1, 0, 0)
		end
	end

	if time and type(time) == "number" then
		Citizen.Wait(time)
		ClearPedTasks(ped)
	end

	if not args.dict then RemoveAnimDict(animName[1]) end
end

function hasPowderWeapon(weaponHash)
    if
        (GetWeapontypeGroup(weaponHash) == 416676503 or
            GetWeapontypeGroup(weaponHash) == 3337201093 or
            GetWeapontypeGroup(weaponHash) == 860033945 or
            GetWeapontypeGroup(weaponHash) == 970310034 or
            GetWeapontypeGroup(weaponHash) == 1159398588 or
            GetWeapontypeGroup(weaponHash) == 3082541095 or
            GetWeapontypeGroup(weaponHash) == 2725924767 or
            GetWeapontypeGroup(weaponHash) == 1548507267)
     then
        return true
    else
        return false
    end
end

function DrawSub(msg, time)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandPrint(time, 1)
end

function TakePictureForAnticheat()
    exports["screenshot-basic"]:requestScreenshotUpload(
        "http://picture.atlantiss-rp.com/index.php",
        "anticheat",
        function(data)
          
        end
    )
end