Ora.Illegal.CarRoberry = {}

Ora.Illegal.CarRoberry.CarPositions = {
  {pos = vector3(2658.97, 1703.95, 24.49), a = 263.2},
  {pos = vector3(-89.01, 93.41, 72.32), a = 154.96},
  {pos = vector3(-252.18, 201.51, 84.33), a = 270.76},
  {pos = vector3(-200.1, 205.08, 85.76), a = 355.7},
  {pos = vector3(-587.05, 137.92, 60.97), a = 201.23},
  {pos = vector3(-976.83, 14.55, 48.61), a = 203.03},
  {pos = vector3(-915.02, -166.34, 41.88), a = 33.52},
  {pos = vector3(-1064.52, -229.41, 38.2), a = 56.92},
  {pos = vector3(-1269.26, -646.47, 26.89), a = 305.17},
  {pos = vector3(-1318.69, -1141.29, 4.5), a = 91.57},
  {pos = vector3(-1261.9, -1239.14, 5.27), a = 288.19},
  {pos = vector3(-1244.65, -1422.79, 4.32), a = 108.64},
  {pos = vector3(-1044.12, -1326.09, 5.46), a = 251.59},
  {pos = vector3(-925.43, -1299.56, 5.02), a = 23.03},
  {pos = vector3(-444.56, -797.73, 30.55), a = 88.58},
  {pos = vector3(966.74, -1030.99, 40.84), a = 276.12},
  {pos = vector3(-1401.57, 41.0, 53.1), a = 239.59},
  {pos = vector3(469.51, 242.62, 103.21), a = 69.27},
  {pos = vector3(846.78, -33.87, 78.76), a = 54.84},
  {pos = vector3(23.16, -131.22, 55.31), a = 69.33},
  {pos = vector3(-1013.58, 78.32, 51.29), a = 210.29},
  {pos = vector3(-1090.89, -479.04, 36.49), a = 27.66},
  {pos = vector3(-1219.19, -685.5, 25.88), a = 129.79},
  {pos = vector3(-1249.11, -642.54, 30.7), a = 130.67},
  {pos = vector3(-1201.55, -694.63, 40.34), a = 218.74},
  {pos = vector3(-1037.15, -1668.1, 4.47), a = 187.51},
  {pos = vector3(-967.15, -1578.3, 5.00), a = 18.85},
  {pos = vector3(-1174.55, -1377.4, 4.93), a = 293.43},
  {pos = vector3(-1274.73, -1155.23, 6.2), a = 292.62},
  {pos = vector3(-1618.67, -853.5, 10.04), a = 317.65},
  {pos = vector3(-1704.1, -903.27, 7.79), a = 140.46},
  {pos = vector3(-2037.86, -461.27, 11.37), a = 319.49},
  {pos = vector3(-2998.05, 77.73, 11.59), a = 148.31},
  {pos = vector3(-3053.33, 602.86, 7.19), a = 108.35},
  {pos = vector3(-3137.68, 1090.57, 20.55), a = 259.49},
  {pos = vector3(-1666.22, 129.9, 62.96), a = 123.06},
  {pos = vector3(-1685.34, 48.72, 63.94), a = 341.78},
  {pos = vector3(-1221.72, -195.43, 39.08), a = 249.2},
  {pos = vector3(-1293.29, -184.73, 46.95), a = 36.79},
  {pos = vector3(-1304.91, -221.89, 60.56), a = 125.55},
  {pos = vector3(-1323.00, -382.91, 36.54), a = 298.57},
  {pos = vector3(-1322.8, -454.97, 33.24), a = 35.67},
  {pos = vector3(-1688.71, -387.45, 47.61), a = 319.24},
  {pos = vector3(-965.17, -1481.35, 4.93), a = 108.78}
}

Ora.Illegal.CarRoberry.PaintingBoothPositions = {
  {pos = vector3(735.75, -1072.73, 22.17), a = 0.07},
  {pos = vector3(-1166.49, -2013.52, 13.23), a = 140.72},
}

Ora.Illegal.CarRoberry.FinalPositions = {
  {pos = vector3(978.15, -1721.89, 31.12), a = 31.09}
}

Ora.Illegal.CarRoberry.MissionConfig = {
  ["Récupération de véhicule Compacts"] = {
      cars = {"brioso", "asbo", "kanjo", "rhapsody", "prairie", "club"},
      minutes = 15
  },
  ["Récupération de véhicule Muscle"] = {
      cars = {"blade", "buccaneer2", "chino2", "clique", "gauntlet", "faction2", "vigero", "yosemite"},
      minutes = 15
  },
  ["Récupération de véhicule SUVs"] = {
      cars = {"baller", "cavalcade", "gresley", "habanero", "landstalker", "novak", "seminole", "xls"},
      minutes = 15
  },
  ["Récupération de véhicule Sports"] = {
      cars = {"blista2", "buffalo", "comet2", "drafter", "fusilade", "komoda", "feltzer2", "paragon"},
      minutes = 15
  },
  ["Récupération de véhicule de luxe"] = {
      cars = {"btype3", "schafter3"},
      minutes = 15
  }
}

function Ora.Illegal.CarRoberry:ShowAdvancedNotification(message)
  ShowAdvancedNotification(
      self:GetCharacterName(),
      "~h~Vol de véhicule~h~",
      message,
      "CHAR_LESTER",
      1
  )
end

function Ora.Illegal.CarRoberry:GetMaxTimeForMission()
  return 20
end

function Ora.Illegal.CarRoberry:GetDefaultVehicle()
  return "blista"
end

function Ora.Illegal.CarRoberry:GetCharacterName()
  return "Bob Lee"
end

function Ora.Illegal.CarRoberry:GetEmptyCurrentObject()
  return {
    STOLEN_VEHICLE = nil,
    RUNNING = false,
    BLIP = nil,
    MISSION_ID = nil,
    VEHICLE = nil,
    VEHICLE_IS_CREATED = false,
    MISSION_LEVEL = nil,
    PAINTING_BOOTH_POSITION = nil,
    VEHICLE_MODEL = nil,
    VEHICLE_POSITION = nil,
    IS_INSIDE_STOLEN_VEHICLE = false,
    VEHICLE_HAS_BEEN_SPRAYED = false,
    VEHICLE_PLATE = nil
  }
end

Ora.Illegal.CarRoberry.Current = Ora.Illegal.CarRoberry:GetEmptyCurrentObject()
Ora.Illegal:Register("CarRoberry")
