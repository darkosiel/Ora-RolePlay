local displayStreetName = false

Citizen.CreateThread(
    function()
        while Ora.Player.HasLoaded == false do
            Wait(50)
        end

        while true do
            if Ora.Identity.Job:GetName() == "police" or Ora.Identity.Job:GetName() == "lssd" or Ora.Identity.Job:GetName() == "fib" then
                displayStreetName = true
            else
                displayStreetName = false
            end
            Wait(100000)
        end
    end
)

local compass = {cardinal = {}, intercardinal = {}}

-- Configuration. Please be careful when editing. It does not check for errors.
compass.show = true
compass.position = {x = 0.5, y = 0.07, centered = true}
compass.width = 0.25
compass.fov = 180
compass.followGameplayCam = true

compass.ticksBetweenCardinals = 9.0
compass.tickColour = {r = 255, g = 255, b = 255, a = 255}
compass.tickSize = {w = 0.001, h = 0.003}

compass.cardinal.textSize = 0.25
compass.cardinal.textOffset = 0.015
compass.cardinal.textColour = {r = 255, g = 255, b = 255, a = 255}

compass.cardinal.tickShow = true
compass.cardinal.tickSize = {w = 0.001, h = 0.012}
compass.cardinal.tickColour = {r = 255, g = 255, b = 255, a = 255}

compass.intercardinal.show = true
compass.intercardinal.textShow = true
compass.intercardinal.textSize = 0.2
compass.intercardinal.textOffset = 0.015
compass.intercardinal.textColour = {r = 255, g = 255, b = 255, a = 255}

compass.intercardinal.tickShow = true
compass.intercardinal.tickSize = {w = 0.001, h = 0.006}
compass.intercardinal.tickColour = {r = 255, g = 255, b = 255, a = 255}
-- End of configuration

Citizen.CreateThread(
    function()
        if compass.position.centered then
            compass.position.x = compass.position.x - compass.width / 2
        end

        while compass.show do
            if displayStreetName == true and IsPedInAnyVehicle(PlayerPedId()) then
                Wait(0)
                local pxDegree = compass.width / compass.fov
                local playerHeadingDegrees = 0

                if compass.followGameplayCam then
                    -- Converts [-180, 180] to [0, 360] where E = 90 and W = 270
                    local camRot = Citizen.InvokeNative(0x837765A25378F0BB, 0, Citizen.ResultAsVector())
                    playerHeadingDegrees = 360.0 - ((camRot.z + 360.0) % 360.0)
                else
                    -- Converts E = 270 to E = 90
                    playerHeadingDegrees = 360.0 - GetEntityHeading(GetPlayerPed(-1))
                end

                local tickDegree = playerHeadingDegrees - compass.fov / 2
                local tickDegreeRemainder = compass.ticksBetweenCardinals - (tickDegree % compass.ticksBetweenCardinals)
                local tickPosition = compass.position.x + tickDegreeRemainder * pxDegree

                tickDegree = tickDegree + tickDegreeRemainder

                while tickPosition < compass.position.x + compass.width do
                    if (tickDegree % 90.0) == 0 then
                        -- Draw cardinal
                        if compass.cardinal.tickShow then
                            DrawRect(
                                tickPosition,
                                compass.position.y,
                                compass.cardinal.tickSize.w,
                                compass.cardinal.tickSize.h,
                                compass.cardinal.tickColour.r,
                                compass.cardinal.tickColour.g,
                                compass.cardinal.tickColour.b,
                                compass.cardinal.tickColour.a
                            )
                        end

                        drawText(
                            degreesToIntercardinalDirection(tickDegree),
                            tickPosition,
                            compass.position.y + compass.cardinal.textOffset,
                            {
                                size = compass.cardinal.textSize,
                                colour = compass.cardinal.textColour,
                                outline = true,
                                centered = true
                            }
                        )
                    elseif (tickDegree % 45.0) == 0 and compass.intercardinal.show then
                        -- Draw intercardinal
                        if compass.intercardinal.tickShow then
                            DrawRect(
                                tickPosition,
                                compass.position.y,
                                compass.intercardinal.tickSize.w,
                                compass.intercardinal.tickSize.h,
                                compass.intercardinal.tickColour.r,
                                compass.intercardinal.tickColour.g,
                                compass.intercardinal.tickColour.b,
                                compass.intercardinal.tickColour.a
                            )
                        end

                        if compass.intercardinal.textShow then
                            drawText(
                                degreesToIntercardinalDirection(tickDegree),
                                tickPosition,
                                compass.position.y + compass.intercardinal.textOffset,
                                {
                                    size = compass.intercardinal.textSize,
                                    colour = compass.intercardinal.textColour,
                                    outline = true,
                                    centered = true
                                }
                            )
                        end
                    else
                        -- Draw tick
                        DrawRect(
                            tickPosition,
                            compass.position.y,
                            compass.tickSize.w,
                            compass.tickSize.h,
                            compass.tickColour.r,
                            compass.tickColour.g,
                            compass.tickColour.b,
                            compass.tickColour.a
                        )
                    end

                    -- Advance to the next tick
                    tickDegree = tickDegree + compass.ticksBetweenCardinals
                    tickPosition = tickPosition + pxDegree * compass.ticksBetweenCardinals
                end
            else
                Wait(10000)
            end
        end
    end
)

local streetName = {}

-- Configuration. Please be careful when editing. It does not check for errors.
streetName.show = true
streetName.position = {x = 0.5, y = 0.02, centered = true}
streetName.textSize = 0.35
streetName.textColour = {r = 255, g = 255, b = 255, a = 255}
-- End of configuration

local streets = {}

Citizen.CreateThread(
    function()
        local lastStreetA = 0
        local lastStreetB = 0
        local lastStreetName = {}
        local IsPedInAnyVehicle = IsPedInAnyVehicle
        local GetPlayerPed = GetPlayerPed
        local GetEntityCoords = GetEntityCoords
        local GetStreetNameFromHashKey = GetStreetNameFromHashKey
        local drawText = drawText


        while streetName.show do
            if displayStreetName == true and IsPedInAnyVehicle(PlayerPedId()) then
                Wait(0)


                drawText(
                    table.concat(streets, " & "),
                    streetName.position.x,
                    streetName.position.y,
                    {
                        size = streetName.textSize,
                        colour = streetName.textColour,
                        outline = true,
                        centered = streetName.position.centered
                    }
                )
            else
                Wait(10000)
            end
        end
    end
)

Citizen.CreateThread(function()
    while streetName.show do
        if displayStreetName == true and IsPedInAnyVehicle(PlayerPedId()) then
            local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
            local streetA, streetB =
                Citizen.InvokeNative(
                0x2EB41072B4C1E4C0,
                playerPos.x,
                playerPos.y,
                playerPos.z,
                Citizen.PointerValueInt(),
                Citizen.PointerValueInt()
            )

            streets = {}
            if
                not ((streetA == lastStreetA or streetA == lastStreetB) and
                    (streetB == lastStreetA or streetB == lastStreetB))
             then
                -- Ignores the switcharoo while doing circles on intersections
                lastStreetA = streetA
                lastStreetB = streetB
            end

            if lastStreetA ~= 0 then
                table.insert(streets, GetStreetNameFromHashKey(lastStreetA))
            end

            if lastStreetB ~= 0 then
                table.insert(streets, GetStreetNameFromHashKey(lastStreetB))
            end

        end
        Citizen.Wait(1000)
    end
end)
