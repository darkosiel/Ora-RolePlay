local frontTrunk = {
    -1045541610, --"comet2",
    -2022483795, --"comet3",
    1561920505, --"comet4",
    661493923, --"comet5",
    1032823388, --"ninef",
    -1461482751, --"ninef2",
    -1728685474, --"coquette4",
    --"italirsx",
    -1297672541, --"jester",
    -1106353882, --"jester2",
    -1620126302, --"neo",
    -982130927, --"turismo2",
    -1216765807, --"adder",
    -1829802492, --"pfister811",
    -313185164, --"autarch",
    -1696146015, --"bullet",
    -1311154784, --"cheetah",
    1323778901, --"emerus",
    -1291952903, --"entityxf",
    -2120700196, --"entity2",
    1426219628, --"fmj",
    1234311532, --"gp1",
    960812448, --"furia",
    -2048333973, --"italigtb",
    -482719877, --"italigtb2",
    418536135, --"infernus",
    -1405937764, --"infernus2",
    1504306544, --"torero",
    -664141241, --"krieger",
    1034187331, --"nero",
    1093792632, --"nero2",
    -1758137366, --"penetrator",
    234062309, --"reaper",
    -1622444098, --"voltic",
    1352136073, --"sc1",
    1663218586, --"t20",
    -1134706562, --"taipan",
    272929391, --"tempesta",
    1044193113, --"thrax",
    -1358197432, --"tigon",
    408192225, --"turismor",
    -376434238, --"tyrant",
    338562499, --"vacca",
    1939284556, --"vagner",
    -998177792, --"visione",
    917809321, --"xa21",
    -682108547, -- "zorrusso",
}

local function HasValue(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end

    return false
end

function IsPedNearTrunk(Player, veh)
	local vec1, vec2 = GetModelDimensions(GetEntityModel(veh))
	local behindVector

    if HasValue(frontTrunk, GetEntityModel(veh)) then
        behindVector = vec3(vec1.x + vec2.x, vec2.y, 0.0)
    else
        behindVector = -vec3(vec1.x + vec2.x, vec2.y, 0.0)
    end
	
	return GetDistanceBetweenCoords(LocalPlayer().Pos, GetOffsetFromEntityInWorldCoords(veh, behindVector), true) < 3.5 or Player.InVehicle
end

function getVehicleHealth(veh)
    return math.floor(math.max(0, math.min(100, GetVehicleEngineHealth(entityVeh) / 10)))
end

GetVehicleInDirection = function()
    local playerPed = LocalPlayer().Ped
    local playerCoords = GetEntityCoords(playerPed, 1)
    local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
    local rayHandle = CastRayPointToPoint(playerCoords.x, playerCoords.y, playerCoords.z, inDirection.x, inDirection.y, inDirection.z, 10, playerPed, 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)

    return vehicle
end
