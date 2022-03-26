function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  local id = GetPlayerServerId(PlayerId())
  AddTextEntry('FE_THDR_GTAO', '~g~Ora RP ~w~| https://discord.gg/orarp | ~b~ID : '..id)
  AddTextEntry('PM_PANE_LEAVE', 'Retourner sur la liste des serveurs.')
  AddTextEntry('PM_PANE_QUIT', 'Quitter')
  AddTextEntry('PM_SCR_MAP', 'Carte')
  AddTextEntry('PM_SCR_GAM', 'Prendre l\'avion')
  AddTextEntry('PM_SCR_INF', 'Logs')
end)
