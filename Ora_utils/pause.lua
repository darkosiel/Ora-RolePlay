function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  local id = GetPlayerServerId(PlayerId())
  while true do
    TriggerServerCallback("onlinePlayers:list",function(users)
      AddTextEntry('FE_THDR_GTAO', '~g~Ora RP ~w~| https://discord.gg/orarp | ID : ~r~'..id.."~s~| ~b~".. #users .. "~w~/~b~128 ~w~joueurs ~b~en ligne")
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

--[[Citizen.CreateThread(function()
  local id = GetPlayerServerId(PlayerId())
  AddTextEntry('FE_THDR_GTAO', '~g~Ora RP ~w~| https://discord.gg/orarp | ~b~ID : '..id)
  AddTextEntry('PM_PANE_LEAVE', 'Retourner sur la liste des serveurs.')
  AddTextEntry('PM_PANE_QUIT', 'Quitter')
  AddTextEntry('PM_SCR_MAP', 'Carte')
  AddTextEntry('PM_SCR_GAM', 'Prendre l\'avion')
  AddTextEntry('PM_SCR_INF', 'Logs')
end)]]
