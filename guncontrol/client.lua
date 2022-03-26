-- Start Gun Control

local bag = nil
local WeaponfromTrunk = nil
local color = {r = 37, g = 175, b = 57, alpha = 255} -- Color of the text
local font = 0 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local nbrDisplaying = 0
local tookWeapon = false
local LoadedIn = false
local timeout = false
local HasBag = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            bag = exports["Atlantiss"]:GetBags()
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(18000)
            if not LoadedIn then
                LoadedIn = true
            end
        end
    end
)

local function timeOut()
    SetTimeout(
        4100,
        function()
            timeout = false
        end
    )
end

-- No gun without trunk
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)
            local playerPed = PlayerPedId()
            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
            local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)

            if GetSelectedPedWeapon(playerPed) ~= nil then
                if bag ~= nil or closecar ~= 0 and VehicleInFront() > 0 then
                    if bag ~= nil then
                        where = "bag"
                        HasBag = true
                    else
                        where = "trunk"
                    end
                    for i = 1, #Config.StashWeapons, 1 do
                        local weaponHash = GetHashKey(Config.StashWeapons[i].name)
                        local weaponName = Config.StashWeapons[i].label
                        if
                            weaponHash == GetSelectedPedWeapon(playerPed) and not tookWeapon and
                                GetSelectedPedWeapon(playerPed) ~= WeaponfromTrunk
                        then
                            tookWeapon = true
                            --text = "*Prend " .. weaponName .. " du " .. where .. "*"
                            if not timeout then
                                timeout = true
                                timeOut()
                            end
                            WeaponfromTrunk = GetSelectedPedWeapon(playerPed)
                        end
                    end
                else
                    for i = 1, #Config.StashWeapons, 1 do
                        local weaponHash = GetHashKey(Config.StashWeapons[i].name)
                        if weaponHash == GetSelectedPedWeapon(playerPed) and WeaponfromTrunk ~= weaponHash then
                            SetCurrentPedWeapon(PlayerPedId(), -1569615261, true)
                            tookWeapon = false
                            TriggerEvent("RageUI:Popup", {message = "~r~Vous ne pouvez pas sortir une arme de vos fesses"})
                        end
                    end
                end
            end

            if GetSelectedPedWeapon(playerPed) ~= WeaponfromTrunk then
                WeaponfromTrunk = nil
                tookWeapon = false
            end
            currentWeapon = GetSelectedPedWeapon(playerPed)
            if
                currentWeapon ~= -1569615261 and currentWeapon ~= 883325847 and currentWeapon ~= 966099553 and
                    not IsPedInAnyVehicle(playerPed, 1) and
                    LoadedIn
            then
                if not tookWeapon or WeaponfromTrunk ~= GetSelectedPedWeapon(playerPed) then
                    --text = "*Prendre arme* "
                    if not timeout then
                        timeout = true
                        timeOut()
                    end
                    tookWeapon = true
                    WeaponfromTrunk = GetSelectedPedWeapon(playerPed)
                end
            end
        end
    end
)

function VehicleInFront()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0, 0.0)
    local rayHandle =
        CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end
