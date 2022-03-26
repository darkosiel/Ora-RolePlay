IllegalShops = IllegalShops or {}
IllegalShops.SHARED = {}


IllegalShops.SHARED.DEALER_PED = "s_m_y_dealer_01" 
IllegalShops.SHARED.DEALER_POSITIONS = {
  { pos = vector3(-1520.01, 1490.15, 111.63 - 0.98), heading = 2.01 },
  { pos = vector3(-1128.77, 2695.56, 18.8 - 0.98), heading = 128.76 },
  { pos = vector3(59.54, 2794.98, 57.88 - 0.98), heading = 310.35 },
  { pos = vector3(239.79, -3312.5, 5.79 - 0.98), heading = 138.67 },
  { pos = vector3(805.45, -2950.12, 6.02 - 0.98), heading = 8.97 },
  { pos = vector3(575.07, -1581.51, 28.08 - 0.98), heading = 211.12 },
  { pos = vector3(-308.1, -2205.72, 9.98 - 0.98), heading = 155.14 },
  { pos = vector3(-512.82, -2866.83, 7.3 - 0.98), heading = 225.56 },
  { pos = vector3(-334.92, -2439.38, 6.0 - 0.98), heading = 53.54 },
  { pos = vector3(-169.84, -2583.25, 6.0 - 0.98), heading = 53.54 },
  { pos = vector3(1023.11, -2893.68, 11.26 - 0.98), heading = 97.95 },
  { pos = vector3(1226.06, -3105.76, 6.03 - 0.98), heading = 348.72 },
  { pos = vector3(-808.07, -2117.53, 8.81 - 0.98), heading = 310.24 },
  { pos = vector3(-867.51, -1274.9, 5.15 - 0.98), heading = 247.89 },
}

IllegalShops.SHARED.DELIVERY_POSITIONS = {
  { final = vector3(-779.19, -1328.54, 5.0), start = vector3(-666.46, -1186.04, 10.61), heading = 201.06 },
  { final = vector3(-2026.2, -359.79, 44.11), start = vector3(-2025.7, -358.62, 48.11), heading = 303.76 },
  { final = vector3(-296.76, -768.49, 43.61), start = vector3(-308.73, -766.12, 53.25), heading = 59.87 },
  { final = vector3(-396.13, 1234.35, 146.6), start = vector3(-510.72, 1189.22, 324.78), heading = 276.54 },
  { final = vector3(395.62, -1663.96, 32.53), start = vector3(364.92, -1698.49, 26.78), heading = 322.21 },
  { final = vector3(1119.14, 241.95, 80.86), start = vector3(1291.35, 299.84, 81.99), heading = 137.41 },
  { final = vector3(1525.97, 1726.1, 109.96), start = vector3(1357.16, 1899.52, 94.1), heading = 216.51 },
}

IllegalShops.SHARED.PHONES = {
  { phone = "5006312", event = "Atlantiss::CE::Illegal:GetPosition" },
  { phone = "5005825", event = "Atlantiss::CE::Illegal:GetPosition" },
  { phone = "5004780", event = "Atlantiss::CE::Illegal:GetPosition" },
  { phone = "5008599", event = "Atlantiss::CE::Illegal:GetPosition" }
}

IllegalShops.SHARED.PRODUCTS_PRICE = {
  weed_pooch = 5,
  meth = 15,
}

IllegalShops.SHARED.DAILY_LIMITS_BY_ORGANISATIONS = {
    weed_pooch = 150,
    meth = 50,
}

function IllegalShops.SHARED.GetPriceForItem(itemName)
    if (IllegalShops.SHARED.PRODUCTS_PRICE[itemName] == nil) then
        return 20
    end

    return IllegalShops.SHARED.PRODUCTS_PRICE[itemName]
end


function IllegalShops.SHARED.GetDefaultLimitation()
    return IllegalShops.SHARED.DAILY_LIMITS_BY_ORGANISATIONS
end

function IllegalShops.SHARED.GetAvailablePhones()
    return IllegalShops.SHARED.PHONES
end

function IllegalShops.SHARED.GetAvailableDealerPositions()
  return IllegalShops.SHARED.DEALER_POSITIONS
end

function IllegalShops.SHARED.GetRandomDealerPosition()
   return IllegalShops.SHARED.DEALER_POSITIONS[math.random(1, #IllegalShops.SHARED.DEALER_POSITIONS)]
end