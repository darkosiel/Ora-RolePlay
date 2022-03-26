local inputCb = nil
local cancel = false

function ShowInput(_message, _length, _type, _text, _focus, _canColor)
	if _message then
		SetNuiFocus(true, true)
		SendNUIMessage({message = _message, length = _length, type = _type, text = _text, focus = _focus, canColor = _canColor})
	else
		SetNuiFocus(false, false)
		error("Snoupinput: Tu dois entrer au minimum le message dans la fonction pour afficher l'input chacal.")
	end
end

function ShowMultipleBtn(_title, _args)
	if type(_args) == "table" and #_args > 1 then
		SetNuiFocus(true, true)
		SendNUIMessage({title = _title, args = _args})
	else
		SetNuiFocus(false, false)
		error("Snoupinput: Tu dois entrer au minimum un tableau de deux arguments en second paramètre dans la fonction chacal.")
	end
end

RegisterNUICallback('GetText', function(e)
	inputCb = e.input
	SetNuiFocus(false, false)
end)

RegisterNUICallback('CancelText', function()
	cancel = true
	SetNuiFocus(false, false)
end)

exports("ShowInput", function(message, length, type, text, focus, canColor)
	inputCb = nil
	ShowInput(message, length, type, text, focus, canColor)
end)

exports("ShowMultipleBtn", function(title, args)
	inputCb = nil
	ShowMultipleBtn(title, args)
end)

exports("GetInput", function()
	while inputCb == nil do
		if cancel == true then
			cancel = false
			return false
		end
		Wait(10)
	end
	return inputCb
end)
