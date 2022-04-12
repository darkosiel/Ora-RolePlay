local CourtCenter = vector3(-773.0, 153.465, 66.52)
local CourtHeading = 0
local Width = 7.98
local Length = 11.89

Citizen.CreateThread(function()
    while true do
         Wait(0)

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for _, courtData in pairs(TennisCourts) do
            GetPointData(courtData.courtCenter, courtData.courtHeading, courtData.courtWidth, courtData.courtLength, coords)
        end

        PlayerSettings.courtName

        local modifier = 0.2

        if IsDisabledControlPressed(0, 172) then  up
            TennisCourts[PlayerSettings.courtName].courtCenter = vector3(
                TennisCourts[PlayerSettings.courtName].courtCenter.x,
                TennisCourts[PlayerSettings.courtName].courtCenter.y + GetFrameTime() * modifier,
                TennisCourts[PlayerSettings.courtName].courtCenter.z
            )
        elseif IsDisabledControlPressed(0, 173) then  down
            TennisCourts[PlayerSettings.courtName].courtCenter = vector3(
                TennisCourts[PlayerSettings.courtName].courtCenter.x,
                TennisCourts[PlayerSettings.courtName].courtCenter.y - GetFrameTime() * modifier,
                TennisCourts[PlayerSettings.courtName].courtCenter.z
            )
        elseif IsDisabledControlPressed(0, 174) then  left
            TennisCourts[PlayerSettings.courtName].courtCenter = vector3(
                TennisCourts[PlayerSettings.courtName].courtCenter.x - GetFrameTime() * modifier,
                TennisCourts[PlayerSettings.courtName].courtCenter.y,
                TennisCourts[PlayerSettings.courtName].courtCenter.z
            )
        elseif IsDisabledControlPressed(0, 175) then  right
            TennisCourts[PlayerSettings.courtName].courtCenter = vector3(
                TennisCourts[PlayerSettings.courtName].courtCenter.x + GetFrameTime() * modifier,
                TennisCourts[PlayerSettings.courtName].courtCenter.y,
                TennisCourts[PlayerSettings.courtName].courtCenter.z
            )
        elseif IsDisabledControlPressed(0, 96) then  minut
            TennisCourts[PlayerSettings.courtName].courtHeading = TennisCourts[PlayerSettings.courtName].courtHeading - GetFrameTime() * modifier
        elseif IsDisabledControlPressed(0, 97) then  plus
            TennisCourts[PlayerSettings.courtName].courtHeading = TennisCourts[PlayerSettings.courtName].courtHeading + GetFrameTime() * modifier
        end

        print(TennisCourts[PlayerSettings.courtName].courtCenter, TennisCourts[PlayerSettings.courtName].courtHeading)

        print(">>", isInArea and 'ON COURT' or 'OFF COURT', isLeftSide and 'LEFT' or 'RIGHT', isASide and 'A Side' or 'B Side')
     end
 end)

function GetPointData(courtCenter, courtHeading, courtWidth, courtLength, point)
    local nOrigin = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading + 90.0)) * courtLength, 
        courtCenter.y + math.sin(math.rad(courtHeading + 90.0)) * courtLength,
        courtCenter.z
    )

    local nExtent = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading - 90.0)) * courtLength, 
        courtCenter.y + math.sin(math.rad(courtHeading - 90.0)) * courtLength,
        courtCenter.z
    )

    local aLeftSide = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading)) * courtWidth/2, 
        courtCenter.y + math.sin(math.rad(courtHeading)) * courtWidth/2,
        courtCenter.z
    )

    local aRightSide = vector3(
        courtCenter.x + math.cos(math.rad(courtHeading + 180.0)) * courtWidth/2, 
        courtCenter.y + math.sin(math.rad(courtHeading + 180.0)) * courtWidth/2,
        courtCenter.z
    )

    local isInArea = IsPointInAngledArea(
        point, 
        nOrigin, 
        nExtent, 
        courtWidth,
        true,
        false
    )

    DrawCourtDebug(nOrigin, nExtent, courtWidth, aLeftSide, aRightSide)

    local isLeftSide = ((nOrigin.x - nExtent.x)*(point.y - nExtent.y) - (nOrigin.y - nExtent.y)*(point.x - nExtent.x)) > 0
    local isASide = ((aLeftSide.x - aRightSide.x)*(point.y - aRightSide.y) - (aLeftSide.y - aRightSide.y)*(point.x - aRightSide.x)) > 0

    return {
        isInArea = isInArea,
        isLeftSide = isLeftSide,
        isRightSide = not isLeftSide,
        isASide = isASide,
        isBSide = not isASide,
    }
end

function DrawCourtDebug(origin, extent, width, leftSide, rightSide)
    local fieldVector = origin-extent
    local heading = GetHeadingFromVector_2d(fieldVector.x, fieldVector.y)

    local point1 = vector3(
        extent.x + math.cos(math.rad(heading + 180.0)) * width/2, 
        extent.y + math.sin(math.rad(heading + 180.0)) * width/2,
        extent.z
    )
    
    local point2 = vector3(
        origin.x + math.cos(math.rad(heading + 180.0)) * width/2, 
        origin.y + math.sin(math.rad(heading + 180.0)) * width/2,
        origin.z
    )
    
    local point3 = vector3(
        origin.x + math.cos(math.rad(heading + 0.0)) * width/2, 
        origin.y + math.sin(math.rad(heading + 0.0)) * width/2,
        origin.z
    )
    
    local point4 = vector3(
        extent.x + math.cos(math.rad(heading + 0.0)) * width/2, 
        extent.y + math.sin(math.rad(heading + 0.0)) * width/2,
        extent.z
    )

    DrawPoly(point2, point1, point4, 255, 0, 0, 100)
    DrawPoly(point4, point3, point2, 255, 0, 0, 100)

    local asd = vector3(0.1, 0.1, 1.1)
    DrawBox(point1-asd, point1+asd, 255, 0, 0, 200)
    DrawBox(point2-asd, point2+asd, 255, 0, 0, 200)
    DrawBox(point3-asd, point3+asd, 255, 0, 0, 200)
    DrawBox(point4-asd, point4+asd, 255, 0, 0, 200)

    DrawBox(leftSide - asd, leftSide + asd, 0, 255, 0, 150)
    DrawBox(rightSide - asd, rightSide + asd, 0, 255, 0, 150)
end