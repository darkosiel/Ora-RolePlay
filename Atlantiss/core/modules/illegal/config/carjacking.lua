Atlantiss.Illegal.Carjacking = Atlantiss.Illegal.Carjacking or {}

local carJackingConfig = {
  START_POSITIONS = {
    {pos = vector3(-1483.03, -293.34, 47.48 - 0.98), heading = 219.2},
    {pos = vector3(-1335.54, -474.54, 33.51 - 0.98), heading = 214.83},
    {pos = vector3(-1276.08, -556.64, 30.22 - 0.98), heading = 217.17},
    {pos = vector3(1079.03, -3070.85, 5.9 - 0.98), heading = 356.54},
    {pos = vector3(489.44, -1551.5, 29.25 - 0.98), heading = 240.61},
    {pos = vector3(375.69, -1290.79, 32.4 - 0.98), heading = 312.41},
    {pos = vector3(1421.02, -1120.82, 29.16 - 0.98), heading = 149.73},
    {pos = vector3(1421.02, -1120.82, 29.16 - 0.98), heading = 149.73},
    {pos = vector3(217.39, -396.65, 24.14 - 0.98), heading = 142.55},
    {pos = vector3(-324.05, -675.67, 32.56 - 0.98), heading = 357.2},
    {pos = vector3(-522.02, -394.53, 35.04 - 0.98), heading = 352.06},
    {pos = vector3(-375.57, 78.41, 61.44 - 0.98), heading = 90.41},
    {pos = vector3(-1200.96, -1444.86, 4.38 - 0.98), heading = 302.99}
  },
  END_POSITIONS = {
    {pos = vector3(-1132.51, 2698.20, 18.80 - 0.98), heading = 310.18},
  },
  MISSION_LEVELS = {
    ["CarJacking - Voitures Muscle"] = {
        cars = {
            "buccaneer2",
            "chino2",
            "clique",
            "dukes",
            "impaler"
        },
        minutes = 15
    },
    ["CarJacking - Voitures SUV"] = {
        cars = {
            "baller",
            "landstalker",
            "cavalcade",
            "habanero",
            "granger"
        },
        minutes = 15
    },
    ["CarJacking - Voitures SEDAN"] = {
        cars = {
            "asea",
            "fugitive",
            "stanier",
            "warrener"
        },
        minutes = 15
    },
    ["CarJacking - Voitures COUPES"] = {
        cars = {
            "cogcabrio",
            "exemplar",
            "f620",
            "felon"
        },
        minutes = 15
    },
    ["CarJacking - Voitures SPORTS"] = {
        cars = {
            "alpha",
            "blista2",
            "buffalo",
            "drafter"
        },
        minutes = 15
    },
    ["CarJacking - Voitures SPORTS CLASSIC"] = {
        cars = {
            "casco",
            "savestra",
            "retinue",
            "tornado"
        },
        minutes = 15
    }
  },
  PEDS = {
    "a_f_m_downtown_01",
    "a_f_m_eastsa_01",
    "a_f_m_soucentmc_01",
    "a_f_y_femaleagent",
    "a_f_y_smartcaspat_01",
    "a_m_m_eastsa_01",
    "a_m_m_bevhills_01",
    "a_m_m_fatlatin_01",
    "a_m_m_mexlabor_01",
    "a_m_m_og_boss_01",
    "a_m_m_paparazzi_01",
    "a_m_y_epsilon_02",
    "a_m_y_soucent_02",
    "a_m_y_gencaspat_01",
    "g_m_m_armlieut_01",
    "g_f_y_vagos_01",
    "g_m_m_mexboss_01",
    "g_m_y_lost_01",
    "g_m_y_salvagoon_01",
    "g_m_m_armboss_01",
    "g_f_y_ballas_01"
  }
}

function Atlantiss.Illegal.Carjacking:InitializeConfig()
    Atlantiss.Config:SetDataCollection("Atlantiss:Illegal:Config:Carjacking", carJackingConfig)
end

function Atlantiss.Illegal.Carjacking:GetConfig()
  return Atlantiss.Config:GetDataCollection("Atlantiss:Illegal:Config:Carjacking")
end