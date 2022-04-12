CONST_SIDE_A = 'a'
CONST_SIDE_B = 'b'

PlayerSettings = nil

Citizen.CreateThread(function()
    while true do
        if not PlayerSettings then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

            for courtIdx, courtData in pairs(TennisCourts) do
                local courtCenter = courtData.courtCenter
                local courtHeading = courtData.courtHeading
                local serverPointLength = courtData.courtLength + 0.7
                local serverPointWide = courtData.courtWidth/3

                local aSideServePoint = vector3(
                    courtCenter.x + math.cos(math.rad(courtHeading + 90.0)) * serverPointLength + math.cos(math.rad(courtHeading + 180.0)) * serverPointWide, 
                    courtCenter.y + math.sin(math.rad(courtHeading + 90.0)) * serverPointLength + math.sin(math.rad(courtHeading + 180.0)) * serverPointWide,
                    courtCenter.z - 0.1
                )
                
                local bSideServePoint = vector3(
                    courtCenter.x + math.cos(math.rad(courtHeading - 90.0)) * serverPointLength + math.cos(math.rad(courtHeading + 0.0)) * serverPointWide, 
                    courtCenter.y + math.sin(math.rad(courtHeading - 90.0)) * serverPointLength + math.sin(math.rad(courtHeading + 0.0)) * serverPointWide,
                    courtCenter.z - 0.1
                )

                HandleServePoint(ped, coords, courtIdx, CONST_SIDE_A, aSideServePoint)
                HandleServePoint(ped, coords, courtIdx, CONST_SIDE_B, bSideServePoint)
            end

            Wait(0)
        else
            Wait(1000)
        end
    end
end)

----- server steps
-- 1) E
-- 2) server "request position"
-- 3) grant "server/waiter"
-- 4) if server, idle serve, wait
-- 5) if waiter, wait
-- 6) if server and both players ready, left click to initiate
-- 7) fire baby
function HandleServePoint(ped, coords, courtIdx, positionName, serverPointCoords)
    if #(coords - serverPointCoords) < 2.3 then
	DrawText3DTest(serverPointCoords.x, serverPointCoords.y, serverPointCoords.z+1,"~w~ Play Tennis ~r~[E] ")
	DrawMarker(
        25, 
        serverPointCoords.x, serverPointCoords.y, serverPointCoords.z+0.1, 
        0.0, 0.0, 0.0, 
        0.0, 0.0, 0.0, 
        1.5, 1.5, 1.0, 
        0, 0, 255, 150, 
        false, false, false, false, nil, nil, false
    )
end
    if #(coords - serverPointCoords) < 1.3 then
        if IsControlJustPressed(0, 38) then
            TriggerServerEvent('lsrp_tennis:requestPosition', courtIdx, positionName)
            Wait(500)
        end
    end

end
function DrawText3DTest(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('lsrp_tennis:grantPosition')
AddEventHandler('lsrp_tennis:grantPosition', function(courtName, positionName, isServing)
    PlayerSettings = {}
    PlayerSettings.courtName = courtName
    PlayerSettings.side = positionName
    PlayerSettings.isServing = isServing

    StartTennisWorker(PlayerPedId(), TennisCourts[courtName], positionName)
end)