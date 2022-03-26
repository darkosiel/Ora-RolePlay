Shooting_range = {
  weapons = {
    ["Pistolet"] = {
      {label = "Pistolet", hash = `WEAPON_PISTOL`, price = 75},
      {label = "Pistolet .50", hash = `WEAPON_PISTOL50`, price = 75},
      {label = "Revolver double action", hash = `WEAPON_DOUBLEACTION`, price = 75},
      {label = "Revolver lourd", hash = `WEAPON_REVOLVER`, price = 75}
    },
    ["SMG"] = {
      {label = "Mitraillette légère", hash = `WEAPON_MINISMG`, price = 110},
      {label = "Uzi", hash = `WEAPON_MICROSMG`, price = 110},
      {label = "Mitraillette", hash = `WEAPON_SMG`, price = 110},
      {label = "Mitraillette d'assaut", hash = `WEAPON_ASSAULTSMG`, price = 110},
      {label = "ADP de combat", hash = `WEAPON_COMBATPDW`, price = 110},
      {label = "Gusenberg", hash = `WEAPON_GUSENBERG`, price = 110}
    },
    ["Fusil d'assaut"] = {
      {label = "Fusil compact", hash = `WEAPON_COMPACTRIFLE`, price = 150},
      {label = "Fusil d'assaut", hash = `WEAPON_ASSAULTRIFLE`, price = 150},
      {label = "Carabine", hash = `WEAPON_CARBINERIFLE`, price = 150},
      {label = "Fusil amélioré", hash = `WEAPON_ADVANCEDRIFLE`, price = 150},
      {label = "Carabine spéciale", hash = `WEAPON_SPECIALCARBINE`, price = 150},
    }
  },
  prop = {
    hash = `gr_prop_gr_target_05a`,
    pos = {
      ["head"] = vector3(0.0, 0.01245117, 1.329),
      ["body"] = vector3(0.0, 0.01245117, 0.80)
    }
  },
  point = {
    ["head"] = {
      {dist = 0.04, score = 15, multiplier = true, sound = "Target_Hit_Head_Red"},
      {dist = 0.50, score = 5, sound = "Target_Hit_Head_Black"}
    },
    ["body"] = {
      {dist = 0.05, score = 10, multiplier = true, sound = "Target_Hit_Body_Red"},
      {dist = 0.116, score = 9, sound = "Target_Hit_Body_Black"},
      {dist = 0.170, score = 8, sound = "Target_Hit_Body_Black"},
      {dist = 0.225, score = 7, sound = "Target_Hit_Body_Black"},
      {dist = 0.50, score = 1, sound = "Target_Hit_Body_Black"}
    }
  },
  localization = {
    ["Sud"] = {
      pos = vector3(821.600, -2163.729, 29.00),
      targetPos = {
        {pos = vector3(817.784, -2171.768, 28.62), rotX = 90.00, rotY = 0.0, rotZ = 0.0},
        {pos = vector3(816.187, -2171.665, 28.62), rotX = 90.00, rotY = 0.0, rotZ = 0.0},
        {pos = vector3(818.271, -2180.777, 28.62), rotX = 90.00, rotY = 0.0, rotZ = 0.0},
        {pos = vector3(819.867, -2180.825, 28.62), rotX = 90.00, rotY = 0.0, rotZ = 0.0},
        {pos = vector3(824.311, -2180.719, 28.62), rotX = 90.00, rotY = 0.0, rotZ = 0.0},
        {pos = vector3(825.908, -2180.736, 28.62), rotX = 90.00, rotY = 0.0, rotZ = 0.0}
      }
    },
    ["Centre"] = {
      pos = vector3(13.445, -1097.180, 29.00),
      targetPos = {
        {pos = vector3(21.231, -1091.634, 28.80), rotX = 90.00, rotY = 0.0, rotZ = 162.0},
        {pos = vector3(19.781, -1091.106, 28.80), rotX = 90.00, rotY = 0.0, rotZ = 162.0},
        {pos = vector3(22.426, -1082.342, 28.80), rotX = 90.00, rotY = 0.0, rotZ = 162.0},
        {pos = vector3(20.928, -1081.836, 28.80), rotX = 90.00, rotY = 0.0, rotZ = 162.0},
        {pos = vector3(16.793, -1080.171, 28.80), rotX = 90.00, rotY = 0.0, rotZ = 162.0},
        {pos = vector3(15.338, -1079.631, 28.80), rotX = 90.00, rotY = 0.0, rotZ = 162.0}
      }
    }
  }
}