function Ora.Utils:RequestAndWAitForModel(modelHash)
    if modelHash and IsModelInCdimage(modelHash) and not HasModelLoaded(modelHash) then
      RequestModel(modelHash)
      while not HasModelLoaded(modelHash) do Citizen.Wait(100) end
    end
end


function Ora.Utils:RequestAndWaitSet(setName)
	if setName and not HasAnimSetLoaded(setName) then
		RequestAnimSet(setName)

		local startTime = GetGameTimer()
		while not HasAnimSetLoaded(setName) and startTime + 3000 > GetGameTimer() do Citizen.Wait(100) end
	end
end