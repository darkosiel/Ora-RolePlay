function SetupServingScaleformFully()
    local serveScaleform = setupServeScaleform("TENNIS")
    
    BeginScaleformMovieMethod(serveScaleform, "SWING_METER_TRANSITION_IN");
	EndScaleformMovieMethod();

    
	SWING_METER_SET_FILL(serveScaleform, 0.5, 1.0)
	SWING_METER_SET_TARGET(serveScaleform, 0.7, 0.1)
	SWING_METER_POSITION(serveScaleform, 0.7, 0.5)

	return {
		scaleform = serveScaleform,
		isServing = false,
		progress = 1.0,
		progressSpeed = 0.3,
		progressAcceleration = 1.0,
	}
end

function HandleServingScaleformTick(scaleformData)
	if scaleformData.isServing then
		scaleformData.progress = scaleformData.progress - scaleformData.progressSpeed * GetFrameTime()
		scaleformData.progressSpeed = scaleformData.progressSpeed + scaleformData.progressAcceleration * GetFrameTime()

		if scaleformData.progress <= 0.0 then
			scaleformData.progressSpeed = scaleformData.progressSpeed * -1
			scaleformData.progressAcceleration = scaleformData.progressAcceleration * -1
			scaleformData.reachedPeak = true
		end

		if scaleformData.progress >= 0.75 and scaleformData.reachedPeak then
			scaleformData.isServing = false
			scaleformData.finalStrength = 0.25
		end

		if isLeftClicked then
			scaleformData.isServing = false
		end
	end

	SET_MARKER(scaleformData.scaleform, scaleformData.progress)
	DrawScaleformMovieFullscreen(scaleformData.scaleform, 255, 255, 255, 255, 0)
end

-- Citizen.CreateThread(function()
--     local serveScaleform = setupServeScaleform("instructional_buttons")

--     while true do Wait(0)
--     DrawScaleformMovieFullscreen(serveScaleform, 255, 255, 255, 255, 0)
--     end
-- end)

function setupServeScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    return scaleform
end

function SET_MARKER(serveScaleform, y)
	BeginScaleformMovieMethod(serveScaleform, "SWING_METER_SET_MARKER");
	ScaleformMovieMethodAddParamBool(true)
	ScaleformMovieMethodAddParamFloat(y)
	ScaleformMovieMethodAddParamBool(false)
	ScaleformMovieMethodAddParamFloat(-0.25)
	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(serveScaleform, "SWING_METER_SET_APEX_MARKER");
	ScaleformMovieMethodAddParamBool(true)
	ScaleformMovieMethodAddParamFloat(y + 0.002)
	ScaleformMovieMethodAddParamBool(false)
	ScaleformMovieMethodAddParamFloat(-0.25)
	EndScaleformMovieMethod()
end

function SWING_METER_SET_FILL(iParam0, fParam1, fParam2)
	BeginScaleformMovieMethod(iParam0, "SWING_METER_SET_FILL");
	ScaleformMovieMethodAddParamFloat(fParam1);
	ScaleformMovieMethodAddParamFloat(fParam2);
	EndScaleformMovieMethod();
end

function SWING_METER_POSITION(iParam0, fParam1, fParam2)
	BeginScaleformMovieMethod(iParam0, "SWING_METER_POSITION");
	ScaleformMovieMethodAddParamFloat(fParam1);
	ScaleformMovieMethodAddParamFloat(fParam2);
	ScaleformMovieMethodAddParamBool(true);
	EndScaleformMovieMethod();
end

function SWING_METER_SET_TARGET(iParam0, fParam1, fParam2)
	BeginScaleformMovieMethod(iParam0, "SWING_METER_SET_TARGET");
	ScaleformMovieMethodAddParamFloat(fParam1);
	ScaleformMovieMethodAddParamFloat(fParam2);
	EndScaleformMovieMethod();
end

function SWING_METER_SET_TARGET_COLOR(iParam0, r, g, b, a)
	BeginScaleformMovieMethod(iParam0, "SWING_METER_SET_TARGET_COLOR");
	ScaleformMovieMethodAddParamFloat(iParam0, r/255)
	ScaleformMovieMethodAddParamFloat(iParam0, g/255)
	ScaleformMovieMethodAddParamFloat(iParam0, b/255)
	ScaleformMovieMethodAddParamFloat(iParam0, a/255)
	EndScaleformMovieMethod()
end