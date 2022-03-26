
RegisterNetEvent('advert:AddAdvert')
AddEventHandler('advert:AddAdvert',function(table)
    local table = json.decode(table)
    local table = {author=table[3],message=table[1],url=table[2]}
    SendNUIMessage({showNew=true,data=table})
end)