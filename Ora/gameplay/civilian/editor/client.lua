Citizen.CreateThread(
	function()
		while true do
			Wait(10)
			if(IsRecording()) then
				if(IsControlJustPressed(1, config.binding.stop_save_record)) then
					ShowNotification('~g~Enregistrement sauvegardé')
					StopRecordingAndSaveClip()
				end

				if(IsControlJustPressed(1, config.binding.stop_discard_record)) then
					ShowNotification('~r~Enregistrement annulé')
					StopRecordingAndDiscardClip()
				end
			else
				if(IsControlJustPressed(1, config.binding.start_record)) then
					ShowNotification('~b~Enregistrement en cours')
					StartRecording(1)
				end
			end
		end
	end
)
