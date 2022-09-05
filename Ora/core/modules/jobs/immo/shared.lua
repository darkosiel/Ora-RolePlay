Ora.Jobs.Immo = {}
Ora.Jobs.Immo.Raids = {}
Ora.Jobs.Immo.RaidFinishTime = 2700000 -- 45 min
Ora.Jobs.Immo.TimeToRelaunchRaid = 600000 -- 10 min
Ora.Jobs.Immo.Tax = 1.35 -- Marge

Ora.Jobs.Immo.SafeWeight = {
    [1] = 200,
    [2] = 350,
    [3] = 500,
    [4] = 750,
    [5] = 1000,
    [6] = 1250,
    [7] = 1500,
    [8] = 2000,
    [9] = 2500,
    [10] = 3000,
    [11] = 5000,
    [12] = 10000,
}

Ora.Jobs.Immo.Garage = {
    [1] = 2,
    [2] = 6,
    [3] = 10,
    [4] = 20,
    [5] = 30,
    [6] = 64,
}

Ora.Jobs.Immo.Interiors = { 
    {
        coords = {x = 1087.69, y = -3095.56, z = -36.5},
        r = {x = -200.0, y = -180.0, z = -57.39},
        entry = {x = 1087.63, y = -3099.42, z = -39.0},
        coffre = {x = 1091.37, y = -3096.9, z = -39.0},
        activated = true,
        label = "Hangar Petit",
        id = "phangar"
    },
    {
        coords = {x = 1048.45, y = -3111.36, z = -36.8},
        r = {x = -10.0, y = 0.0, z = -74.39},
        entry = {x = 1048.31, y = -3097.34, z = -39.0},
        coffre = {x = 1052.97, y = -3095.2, z = -39.0},
        activated = true,
        label = "Hangar Moyen",
        id = "mhangar"
    },
    {
        coords = {x = 993.13, y = -3092.36, z = -33.5},
        r = {x = -200.0, y = -180.0, z = -57.39},
        entry = {x = 992.76, y = -3097.81, z = -39.0},
        coffre = {x = 1003.48, y = -3102.71, z = -39.0},
        activated = true,
        label = "Hangar XXL",
        id = "xhangar"
    },
    {
        coords = {x = 257.73, y = -995.36, z = -98.0},
        r = {x = -190.0, y = -180.0, z = -49.43},
        entry = {x = 266.06, y = -1007.38, z = -101.01},
        coffre = {x = 259.81, y = -1003.95, z = -99.01},
        activated = true,
        label = "Appartement Bas de Gamme",
        id = "appart1"
    },
    {
        coords = {x = 337.98, y = -993.43, z = -98.0},
        r = {x = -190.0, y = -180.0, z = -49.43},
        entry = {x = 346.38, y = -1012.72, z = -99.2},
        coffre = {x = 351.9, y = -998.6, z = -99.2},
        activated = true,
        label = "Appartement Moyen de Gamme",
        id = "appart2"
    },
    {
        coords = {x = -769.52, y = 342.82, z = 213.04},
        r = {x = -190.0, y = -180.0, z = 49.01},
        entry = {x = -781.56, y = 322.36, z = 212.0},
        coffre = {x = -765.52, y = 327.23, z = 211.4},
        activated = true,
        label = "Appartement Haut de Gamme",
        id = "appart3"
    },
    {
        coords = {x = 1004.4, y = -2992.36, z = -39.65},
        r = {x = 0.0, y = -0.0, z = 77.08},
        entry = {x = 1004.4, y = -2992.36, z = -39.65},
        coffre = {x = 959.76, y = -3004.94, z = -39.64},
        activated = true,
        label = "Garage",
        id = "appart4"
    },
    {
        coords = {x = -9.49, y = -1441.55, z = 32.10},
        r = {x = -190.0, y = -180.0, z = 160.44},
        entry = {x = -14.4482, y = -1438.788, z = 31.1},
        coffre = {x = -18.29, y = -1438.79, z = 31.1},
        activated = true,
        label = "Maison de Franklin",
        id = "appart5"
    },
    {
        coords = {x = -1161.62, y = -1520.68, z = 11.60},
        r = {x = -190.0, y = -180.0, z = -84.69},
        entry = {x = -1150.70, y = -1520.713, z = 10.633},
        coffre = {x = -1145.27, y = -1514.57, z = 10.63},
        activated = true,
        label = "Appartement Balcon",
        id = "appart6"
    },
    {
        coords = {x = -42.2, y = -570.73, z = 90.65},
        r = {x = -190.0, y = -180.0, z = -25.63},
        entry = {x = -17.45, y = -588.46, z = 90.11},
        coffre = {x = -27.15, y = -588.22, z = 90.12},
        activated = true,
        label = "Appartement Luxe Arcadia",
        id = "appart7"
    },
    {
        coords = {x = -1480.84, y = -533.65, z = 70.55}, -- Luxe Del Perro a changer
        r = {x = -190.0, y = -180.0, z = -80.08},
        entry = {x = -1451.3, y = -524.04, z = 69.56},
        coffre = {x = -1456.8, y = -530.99, z = 69.56},
        activated = true,
        label = "Appartement Luxe Del Perro",
        id = "appart8"
    },
    {
        coords = {x = -170.52, y = 478.84, z = 138.40}, -- Maison Luxe 1
        r = {x = -190.0, y = -180.0, z = -140.48},
        entry = {x = -174.14, y = 497.41, z = 137.67},
        coffre = {x = -175.19, y = 492.79, z = 130.04},
        activated = true,
        label = "Maison de Luxe",
        id = "appart9"
    },
    {
        coords = {x = 368.65, y = 404.74, z = 146.68}, -- Maison Luxe rouge
        r = {x = -190.0, y = -180.0, z = -120.34},
        entry = {x = 373.69, y = 423.62, z = 145.91},
        coffre = {x = 378.33, y = 429.58, z = 138.3},
        activated = true,
        label = "Maison Luxe Rouge",
        id = "appart10"
    },
    {
        coords = {x = -772.65, y = 337.47, z = 198.10},
        r = {x = -190.0, y = -180.0, z = 15.22},
        entry = {x = -779.33, y = 339.31, z = 196.69},
        coffre = {x = -765.05, y = 330.44, z = 196.09},
        activated = true,
        label = "Penthouse Rouge",
        id = "appart11"
    },
    {
        coords = {x = -781.77, y = 342.36, z = 188.75},
        r = {x = -190.0, y = -180.0, z = 45.1},
        entry = {x = -781.6, y = 318.36, z = 187.91},
        coffre = {x = -796.04, y = 326.98, z = 186.41},
        activated = true,
        label = "Penthouse Marron",
        id = "appart12"
    },
    {
        coords = {x = 895.06, y = -3246.8, z = -95.25}, --bunker
        r = {x = -190.0, y = -180.0, z = 105.31},
        entry = {x = 895.85, y = -3245.87, z = -98.25},
        coffre = {x = 907.93, y = -3203.63, z = -97.19},
        activated = true,
        label = "Bunker",
        id = "appart13"
    },
    {
        coords = {x = -142.22, y = -646.72, z = 169.95}, --Business Moderne
        r = {x = -190.0, y = -180.0, z = -140.43},
        entry = {x = -140.3246, y = -623.086, z = 168.820},
        coffre = {x = -127.63, y = -634.04, z = 167.84},
        activated = true,
        label = "Business Moderne",
        id = "appart14"
    },
    {
        coords = {x = -63.9, y = -804.87, z = 244.50}, --Business - Bois
        r = {x = -190.0, y = -180.0, z = 58.89},
        entry = {x = -76.75, y = -830.32, z = 243.39},
        coffre = {x = -82.26, y = -809.25, z = 243.39},
        activated = true,
        label = "Business Bois",
        id = "appart15"
    },
    {
        coords = {x = -899.82, y = -463.47, z = 162.7}, --Studio de musique
        r = {x = -190.0, y = -180.0, z = 190.89},
        entry = {x = -906.27, y = -453.9, z = 161.32},
        coffre = {x = -888.65, y = -439.18, z = 160.22},
        activated = true,
        label = "Studio de Musique",
        id = "appart16"
    },
    {
        coords = {x = 150.73, y = -1007.99, z = -98.20}, --Chambre motel
        r = {x = -190.0, y = -180.0, z = 220.46},
        entry = {x = 151.52, y = -1007.91, z = -99.00},
        coffre = {x = 151.90, y = -1001.19, z = -98.99},
        activated = true,
        label = "Chambre motel",
        id = "appart17"
    },
    {
        coords = {x = 726.37, y = 2521.85, z = 75.01}, --Studio maison de disque
        r = {x = -190.0, y = -180.0, z = 150.62},
        entry = {x = 731.3458, y = 2523.2314, z = 73.50},
        coffre = {x = 716.52, y = 2524.05, z = 72.50},
        activated = true,
        label = "Studio de Musique de luxe",
        id = "appart18"
    },
    {
      coords = {x = 1015.89, y = -3154.37, z = -36.93}, --Biker 1
      entry = {x = 996.95, y = -3158.12, z = -38.91},
      r = {x = -180.0, y = 180.0, z = 61.96},
      coffre = {x = 1008.35, y = -3171.26, z = -39.89},
      clothes = vector3(1009.96, -3167.79, -39.91),
      activated = true,
      label = "Club House 1",
      id = "appart19"
    },
    {
        coords = {x = 1125.32, y = -3152.21, z = -36.43}, --Biker 1
        entry = { x = 1121.09, y = -3152.58,z = -37.06},
        r = {x = 0.0, y = -0.0, z = 46.26},
        coffre = {x = 1122.84, y = -3161.73, z = -37.87},
        clothes = vector3(1116.92, -3163.04, -37.87),
        activated = true,
        label = "Club House 2",
        id = "appart20"
    },
    {
        entry = {x = 242.313, y = 361.306, z = 105.40}, 
        coffre = {x = 247.05, y = 370.99, z = 104.74},
        r = {x = -180.0, y = -180.0, z = 353.6},
        coords = {x = 245.37, y = 373.01, z = 106.35},
        activated = true,
        label = "Petit rangement",
        id = "appart21"
    },
    {
        entry = {x = -1583.0168, y = -558.6378, z = 108.5228}, 
        coffre = {x = -1564.73, y = -572.32, z = 107.52},
        r = {x = -180.0, y = -180.0, z = 353.6},
        coords = {x = -1569.59, y = -568.47, z = 108.91},
        activated = true,
        label = "Business Moderne 2",
        id = "appart22"
    },
}

Ora.Jobs.Immo.ErrorMessages = {}
Ora.Jobs.Immo.Menu = {}
Ora.Jobs.Immo.Menu.Property = {}

function Ora.Jobs.Immo:GetJobName()
  return "Immo"
end

function Ora.Jobs.Immo:GetInteriorById(id)
  if (Ora.Jobs.Immo:GetInteriors()[id] ~= nil) then
      return Ora.Jobs.Immo:GetInteriors()[id]
  end

  return {}
end

function Ora.Jobs.Immo:GetAvailableWeight()
    local labels = {}
    for key, value in pairs(Ora.Jobs.Immo.SafeWeight) do
        table.insert(labels, value .. " KG")
    end

    return labels
end

function Ora.Jobs.Immo:GetAvailableGaragePlaces()
    local labels = {}
    for key, value in pairs(Ora.Jobs.Immo.Garage) do
        table.insert(labels, value .. " Places")
    end

    return labels
end

function Ora.Jobs.Immo:GetInteriorLabels()
    local labels = {}
    for key, value in pairs(Ora.Jobs.Immo:GetInteriors()) do
        table.insert(labels, value.label)
    end

    return labels
end

function Ora.Jobs.Immo:GetInteriors()
  local interiors = {}
  for key, value in pairs(Ora.Jobs.Immo.Interiors) do
    table.insert(interiors, value)
  end

  return interiors
end

function Ora.Jobs.Immo:GetSafeCapacityForIndex(safeIndex)
    if (self.SafeWeight[safeIndex] ~= nil) then
        return self.SafeWeight[safeIndex] .. "KG"
    end

    return "200KG"
end

function Ora.Jobs.Immo:GetParkingPlaceCountForIndex(parkingPlaceIndex)
    if (self.Garage[parkingPlaceIndex] ~= nil) then
        return self.Garage[parkingPlaceIndex]
    end

    return 2
end

function Ora.Jobs.Immo:GetLastValidationMessages()
    return self.ErrorMessages
end

function Ora.Jobs.Immo:SetLastValidationMessages(messages)
    self.ErrorMessages = messages
end

function Ora.Jobs.Immo:IsNewAppartValid(data)
    local errorMessages = {}
    self:SetLastValidationMessages(errorMessages)
    local isValid = true

    if (data.SAFE_INDEX == nil) then
        isValid = false
        table.insert(errorMessages, "Pas de contenance de coffre choisie")
    end

    if (data.ENTRY_POS == nil or type(data.ENTRY_POS) ~= "vector3") then
        isValid = false
        table.insert(errorMessages, "Entrée de la propriété non définie")
    end

    if (data.HOUSE_NUMBER == nil) then
        isValid = false
        table.insert(errorMessages, "Nom de la propriété non défini")
    end

    --if (data.GARAGE_POS == nil or type(data.GARAGE_POS) ~= "vector3") then
    --    isValid = false
    --    table.insert(errorMessages, "Garage de la propriété non défini")
    --end

    if (data.GARAGE_POS ~= nil and data.GARAGE_INDEX == nil) then
        isValid = false
        table.insert(errorMessages, "Type de garage non défini")
    end

    if (data.INTERIOR_INDEX == nil or data.INTERIOR_DATA == {}) then
        isValid = false
        table.insert(errorMessages, "Pas d'interieur défini")
    end

    if (data.PRICE == nil) then
        isValid = false
        table.insert(errorMessages, "Prix non défini")
    end

    self:SetLastValidationMessages(errorMessages)
    return isValid
end

function Ora.Jobs.Immo:GetCurrent()
    return self.Current
  end
  
  function Ora.Jobs.Immo:ResetCurrent()
    self.Current = {
        ENTRY_POS = nil,
        GARAGE_POS = nil,
        SAFE_INDEX = 1,
        GARAGE_INDEX = 1,
        HOUSE_NUMBER = nil,
        PRICE = 0,
        INTERIOR_DATA = {},
        INTERIOR_CAMERA = nil,
        CAMERA = nil,
        INTERIOR_CAMERA_ROTATION = nil,
        INTERIOR_INDEX = 1,
        PARKING_PLACE_COUNT = 2,
        SAFE_CAPACITY = 200,
    }
  end
  
  Ora.Jobs.Immo.Current = Ora.Jobs.Immo:ResetCurrent()

function Ora.Jobs.Immo:Debug(message)
  if (Ora:IsDebug()) then
    Citizen.Trace(string.format("^2[Job %s / %s] ^3%s^7.\n",  Ora.Jobs:GetModuleName(), Ora.Jobs.Immo:GetJobName(), message))
  end
end

Ora.Jobs:Register(Ora.Jobs.Immo:GetJobName())
