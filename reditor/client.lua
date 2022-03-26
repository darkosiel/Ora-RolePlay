Citizen.CreateThread(
	function()
		while true do
			Wait(10)

			if(IsRecording()) then
				if(IsControlJustPressed(1, config.binding.stop_save_record)) then
					exports['Atlantiss']:ShowNotification('~g~Enregistrement sauvegardé')
					StopRecordingAndSaveClip()
				end

				if(IsControlJustPressed(1, config.binding.stop_discard_record)) then
					exports['Atlantiss']:ShowNotification('~r~Enregistrement annulé')
					StopRecordingAndDiscardClip()
				end
			else
				-- Doesn't seems to work properly
				--[[ if(IsControlJustPressed(1, config.binding.start_record_replay)) then
					print(config.binding.start_record_replay, 'start record replay')
					StartRecording(0)
				end ]]

				if(IsControlJustPressed(1, config.binding.start_record)) then
					exports['Atlantiss']:ShowNotification('~b~Enregistrement en cours')
					StartRecording(1)
				end
			end
		end
	end
)
