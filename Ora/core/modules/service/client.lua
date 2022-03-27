function Ora.Service:isInService(jobname)
	if (jobname == Ora.Identity.Job:GetName()) then
		if (Ora.Identity.Job.isOnDuty == true) then
			return true
		else
			return false
		end
	elseif (jobname == Ora.Identity.Orga:GetName()) then
		if (Ora.Identity.Orga.isOnDuty == true) then
			return true
		else
			return false
		end
	end

	self:Debug(string.format("Trying to get the duty of a job that the player doesn't have: server id %s, jobname %s", GetPlayerServerId(PlayerId()), jobname))
	return false
end

function Ora.Service:UpdateService(jobType)
	if jobType == 'job' then
		if Ora.Identity.Job.isOnDuty == true and Ora.Identity.Orga.isOnDuty == true then
			Ora.Identity.Orga.isOnDuty = false
			TriggerServerEvent("Ora::SE::Service:RemovePlayerFromService", Ora.Identity.Orga:GetName())
		end

		if Ora.Identity.Job.isOnDuty == true then
			TriggerServerEvent("Ora::SE::Service:SetPlayerInService", Ora.Identity.Job:GetName())
		else
			TriggerServerEvent("Ora::SE::Service:RemovePlayerFromService", Ora.Identity.Job:GetName())
		end
	elseif jobType == 'orga' then
		if Ora.Identity.Orga.isOnDuty == true and Ora.Identity.Job.isOnDuty == true then
			Ora.Identity.Job.isOnDuty = false
			TriggerServerEvent("Ora::SE::Service:RemovePlayerFromService", Ora.Identity.Job:GetName())
		end

		if Ora.Identity.Orga.isOnDuty == true then
			TriggerServerEvent("Ora::SE::Service:SetPlayerInService", Ora.Identity.Orga:GetName())
		else
			TriggerServerEvent("Ora::SE::Service:RemovePlayerFromService", Ora.Identity.Orga:GetName())
		end
	end
end
