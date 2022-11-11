
function SetDisplay(status, param)
    SetNuiFocus(status, status)
    SendNUIMessage({
        type = "ui",
        display = status,
        param = param
    })
end

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback('CodeSubmit', function(data)
    TriggerEvent("Ora:CodeSubmit", data.code)
end)

RegisterNUICallback('Refresh', function()
    TriggerEvent("Ora:Refresh")
end)

RegisterNUICallback('Deposit', function(data)
    TriggerEvent("Ora:Deposit", data.amount, data.billList)
end)

RegisterNUICallback('GetData', function()
    TriggerEvent("Ora:GetData")
end)

RegisterNUICallback('Withdraw', function(data)
    TriggerEvent("Ora:Withdraw", data.amount)
end)

RegisterNUICallback('Send', function(data)
    TriggerEvent("Ora:Send", data.amount, data.rib1, data.rib2)
end)

RegisterNUICallback('NewCode', function(data)
    TriggerEvent("Ora:NewCode")
end)

RegisterNetEvent("OraBankMenu:OpenATM")
AddEventHandler("OraBankMenu:OpenATM", function(param)
    SetDisplay(true, param)
end)

RegisterNetEvent("OraBankMenu:SetData")
AddEventHandler("OraBankMenu:SetData", function(param)
    SendNUIMessage({
        type = "setData",
        param = param
    })
end)

RegisterNetEvent("OraBankMenu:EventReturn")
AddEventHandler("OraBankMenu:EventReturn", function(status)
    SendNUIMessage({
        type = "eventReturn",
        status = status
    })
end)

RegisterNetEvent("OraBankMenu:SetDollar")
AddEventHandler("OraBankMenu:SetDollar", function(m)
    SendNUIMessage({
        type = "setMoney",
        param = m
    })
end)

RegisterNetEvent("OraBankMenu:CheckCode")
AddEventHandler("OraBankMenu:CheckCode", function(param)
    display = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "checkCode",
        param = param
    })
end)