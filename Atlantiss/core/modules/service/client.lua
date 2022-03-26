function Atlantiss.Service:isInService(jobname)
	if (jobname == Atlantiss.Identity.Job:GetName()) then
		if (Atlantiss.Identity.Job.isOnDuty == true) then
			return true
		else
			return false
		end
	elseif (jobname == Atlantiss.Identity.Orga:GetName()) then
		if (Atlantiss.Identity.Orga.isOnDuty == true) then
			return true
		else
			return false
		end
	end

	self:Debug(string.format("Trying to get the duty of a job that the player doesn't have: server id %s, jobname %s", GetPlayerServerId(PlayerId()), jobname))
	return false
end

function Atlantiss.Service:UpdateService(jobType)
	if jobType == 'job' then
		if Atlantiss.Identity.Job.isOnDuty == true and Atlantiss.Identity.Orga.isOnDuty == true then
			Atlantiss.Identity.Orga.isOnDuty = false
			TriggerServerEvent("Atlantiss::SE::Service:RemovePlayerFromService", Atlantiss.Identity.Orga:GetName())
		end

		if Atlantiss.Identity.Job.isOnDuty == true then
			TriggerServerEvent("Atlantiss::SE::Service:SetPlayerInService", Atlantiss.Identity.Job:GetName())
		else
			TriggerServerEvent("Atlantiss::SE::Service:RemovePlayerFromService", Atlantiss.Identity.Job:GetName())
		end
	elseif jobType == 'orga' then
		if Atlantiss.Identity.Orga.isOnDuty == true and Atlantiss.Identity.Job.isOnDuty == true then
			Atlantiss.Identity.Job.isOnDuty = false
			TriggerServerEvent("Atlantiss::SE::Service:RemovePlayerFromService", Atlantiss.Identity.Job:GetName())
		end

		if Atlantiss.Identity.Orga.isOnDuty == true then
			TriggerServerEvent("Atlantiss::SE::Service:SetPlayerInService", Atlantiss.Identity.Orga:GetName())
		else
			TriggerServerEvent("Atlantiss::SE::Service:RemovePlayerFromService", Atlantiss.Identity.Orga:GetName())
		end
	end
end
