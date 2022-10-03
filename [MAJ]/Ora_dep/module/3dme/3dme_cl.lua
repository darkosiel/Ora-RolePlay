-- --------------------------------------------
-- Settings
-- --------------------------------------------

local defaultScale = 0.5 -- Text scale
local color = {r = 128, g = 255, b = 128, a = 150} -- Text color
local font = 0 -- Text font
local displayTime = 7000 -- Duration to display the text (in ms)
local distToDraw = 250 -- Min. distance to draw

-- --------------------------------------------
-- Variable
-- --------------------------------------------

local pedDisplaying = {}

-- --------------------------------------------
-- Functions
-- --------------------------------------------

local function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)

    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    --if onScreen then

    -- Format the text
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextScale(0.0, defaultScale * scale)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()

    --end
end

local function Display(playerServerId, ped, playerCoords, text)
    local playerPed = PlayerPedId()
    local otherPlayerCoords = GetEntityCoords(playerPed)
    local dist = #(playerCoords - otherPlayerCoords)
    if dist <= distToDraw then
        ped = GetPlayerPed(GetPlayerFromServerId(playerServerId))
        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1
        print(ped)
        -- Timer
        local display = true

        Citizen.CreateThread(
            function()
                Wait(displayTime)
                display = false
            end
        )

        -- Display
        local offset = 0.8 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17) and IsEntityVisible(ped) and IsEntityVisible(playerPed) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3D(vector3(x, y, z), text)
            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1
    end
end

RegisterNetEvent("Ora::3dme:shareDisplay")
AddEventHandler(
    "Ora::3dme:shareDisplay",
    function(text, serverId, playerPed, playerCoords)
        Display(serverId, playerPed, playerCoords, text)
    end
)

local function TableToString(tab)
    local str = ""
    for i = 1, #tab do
        str = str .. " " .. tab[i]
    end
    return str
end

RegisterCommand(
    "me",
    function(_, args)
        local text = "* L'individu" .. TableToString(args) .. " *"
        TriggerServerEvent("sendMe", text)
        TriggerServerEvent("Ora:sendToDiscord", 35, text)
    end,
    false
)

exports(
    "sendME",
    function(text)
        if text then
            TriggerServerEvent('sendMe', text)
            TriggerServerEvent("Ora:sendToDiscord", 35, text)
        end
    end
)
