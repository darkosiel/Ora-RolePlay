function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  local id = GetPlayerServerId(PlayerId())
  while true do
    TriggerServerCallback("onlinePlayers:getNumberOfPlayer",function(users)
      AddTextEntry('FE_THDR_GTAO', '~y~Ora RP ~w~| ID : ~r~'..id.."~s~ | ~g~".. users .. "~w~/~g~256 ~w~joueurs ~g~en ligne")
      AddTextEntry('PM_PANE_LEAVE', 'RETOURNER SUR LA LISTE DES SERVEURS')
      AddTextEntry('PM_PANE_QUIT', 'QUITTER')
      AddTextEntry('PM_SCR_RPL', 'SOCIAL CLUB')
      AddTextEntry('PM_SCR_MAP', 'CARTE')
      AddTextEntry('PM_SCR_STA', 'STATISTIQUES')
      AddTextEntry('PM_SCR_SET', 'PARAMETRES')
      AddTextEntry('PM_SCR_GAL', 'GALERIE')
      AddTextEntry('PM_SCR_GAM', 'PRENDRE L\'AVION')
      AddTextEntry('PM_SCR_INF', 'HISTORIQUE')
    end)
    Wait(60000)
end
end)

