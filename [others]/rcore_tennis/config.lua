CONST_SIDE_A = 'a'
CONST_SIDE_B = 'b'

Config = {
    ExtremeEdition = false, -- whitelist `w_ex_grenadefrag` in your anticheat for this to work
    Gravity = {
        CONST_HIT_NORMAL = vector3(0.0, 0.0, -10.0),
        CONST_HIT_BACKSPIN = vector3(0.0, 0.0, -12.0),
        CONST_HIT_TOPSPIN = vector3(0.0, 0.0, -8.0),
    },
    Drag = 0.25,
    RollingResistance = 0.5,
    GroundBounceEnergyLoss = 0.7,
    BallRadius = 0.05,
    StopHorizontalBounceTreshold = 1.0,
    BallElasticity = 1.2,
    Tutorial = {
        {text = 'Le match ~y~démarre~s~ quand 2 joueurs ~y~sont~s~, chacun dun côté.', time = 5000},
        {text = 'Pour servir, ~y~aller sur le point~s~, appuyer sur ~y~E~s~ pour servir.', time = 5000},
        {text = 'Quand vous faite le service, ~y~bouger à une position~s~ à laquelle vous voulez servir puis ~y~appuyer sur Clic Gauche~s~', time = 5000},
        {text = '~y~Choisissez la puissance~s~ à laquelle vous voulez servir et ~y~ZQSD~s~ pour viser.', time = 5000},
        {text = 'Quand vous faite un service, ~y~viser toujours dans le coin opposer~s~', time = 5000},
        {text = "Avant de ~y~tirer~s~, il est plus simple de voir ~y~la balle rebondir une fois~s~ pour la renvoyer.", time = 5000},
        {text = "~y~Le Bottom Spin~s~ enverra la balle ~y~plus loin~s~, ~y~le top spin~s~ enverra la balle ~y~plus proche~s~.", time = 5000},
    },
    Translation = {
        SECOND_SERVE = 'Second Service',
        OPPONENT_WON_POINT = '~r~Adversaire gagne le point!',
        YOU_WON_POINT = '~g~Vous gagner le point!',
        OPPONENT_WON_GAME = '~r~Adversaire gagne le set !',
        YOU_WON_GAME = '~g~Vous gagner le set !',

        YOU = 'Vous',
        OPPONENT = 'Adversaire',

        GAMES = 'SET',
        POINTS = 'POINTS',

        SERVE_HINT = 'Pour bien servir, viser avec ~y~~d~~s~ pour toucher ~g~le rectangle~s~ lumineux.~n~La balle doit toujours ~y~toucher le sol~s~ avant pour que ladversaire puisse la renvoyer.~n~~y~Clic Gauche~s~ pour effectuer le service.',
        SERVE_HINT_AW = 'Q or QZ',
        SERVE_HINT_DW = 'D or DZ',
    },
    Control = {
        AIM_FAR = {
            key = 32,
            name = 'INPUT_MOVE_UP_ONLY',
            label = 'Viser Loin',
        },
        AIM_NEAR = {
            key = 33,
            name = 'INPUT_MOVE_DOWN_ONLY',
            label = 'Viser Proche',
        },
        AIM_LEFT = {
            key = 34,
            name = 'INPUT_MOVE_LEFT_ONLY',
            label = 'Viser Gauche',
        },
        AIM_RIGHT = {
            key = 35,
            name = 'INPUT_MOVE_RIGHT_ONLY',
            label = 'Viser Droite',
        },
        SHOT_REGULAR = {
            key = 24,
            name = 'INPUT_ATTACK',
            label = 'Base Swing',
        },
        SHOT_SERVE = {
            key = 24,
            name = 'INPUT_ATTACK',
            label = 'Servir',
        },
        SHOT_TOP_SPIN = {
            key = 25,
            name = 'INPUT_AIM',
            label = 'Topspin',
        },
        SHOT_BACK_SPIN = {
            key = 22,
            name = 'INPUT_JUMP',
            label = 'Backspin',
        },
        SERVE_DROP_BALL = {
            key = 23,
            name = 'INPUT_ENTER',
            label = 'Lâcher Balle'
        },
        LEAVE_TENIS = {
            key = 23,
            name = 'INPUT_ENTER',
            label = 'Quitter'
        },
        SERVE = {
            key = 38,
            name = 'INPUT_PICKUP',
            label = 'Servir'
        },
        JOIN_TENIS = {
            key = 38,
            name = 'INPUT_PICKUP',
            label = 'Rejoindre Partie'
        },
        TUTORIAL_MODIFIER = {
            key = 21,
            name = 'INPUT_SPRINT',
            label = 'Tutoriel',
        }
    }
}

TennisCourts = {
    desanta = {
        z = 66.5,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,

        courtCenter = vector3(-773.0, 153.465, 66.52),
        courtHeading = 0.0,
        courtWidth = 7.98,
        courtLength = 11.89,

        centerConstant = 0.097,
    },
    pbluff_1_green = {
        z = 10.64,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,

        courtCenter = vector3(-2916.41, 29.48, 10.62),
        courtHeading = -16.05,
        courtWidth = 7.98,
        courtLength = 11.89,

        centerConstant = -0.097,
    },
    pbluff_2_blue = {
        z = 10.64,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,

        courtCenter = vector3(-2900.401, 24.87408, 10.62),
        courtHeading = -16.05,
        courtWidth = 7.98,
        courtLength = 11.89,

        centerConstant = -0.097,
    },
    pbluff_3_blue = {
        z = 10.64,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,

        courtCenter = vector3(-2884.37, 20.2657, 10.62),
        courtHeading = -16.05,
        courtWidth = 7.98,
        courtLength = 11.89,

        centerConstant = -0.097,
    },
    pbluff_4_red = {
        z = 10.64,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,

        courtCenter = vector3(-2868.337, 15.64847, 10.65),
        courtHeading = -16.05,
        courtWidth = 7.98,
        courtLength = 11.89,

        centerConstant = 0.0,
    },
    rockf_b_1 = {
        z = 49.71,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1371.99, -101.718, 49.71),
        courtHeading = 6.4529713058844,
        courtWidth = 7.98,
        courtLength = 11.89,

        centerConstant = 0.305,
    },
    rockf_b_2 = {
        z = 49.71,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1346.18, -98.78546, 49.71),
        courtHeading = 6.4529713058844,
        courtWidth = 7.98,
        courtLength = 11.89,

        centerConstant = 0.097,
    },
    
    rockf_b_3 = {
        z = 46.87,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1309.6, -98.73545, 46.87),
        courtHeading = 3.0,
        courtWidth = 8.83,
        courtLength = 12.64,

        centerConstant = 0.0,
    },
    rockf_b_4 = {
        z = 44.77,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1294.423, -140.2078, 44.77),
        courtHeading = -38.544858914241,
        courtWidth = 8.83,
        courtLength = 12.64,

        centerConstant = -0.03,
    },
    rockf_b_5 = {
        z = 44.77,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1273.467, -113.849, 44.77),
        courtHeading = -38.544858914241,
        courtWidth = 8.83,
        courtLength = 12.64,

        centerConstant = -0.20,
    },
    richman_1 = {
        z = 58.58,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1611.6435, 269.71167, 58.58),
        courtHeading = 205.0174,
        courtWidth = 8.22,
        courtLength = 11.95,

        centerConstant = 0.0,
    },
    richman_2 = {
        z = 58.58,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1626.1732, 262.9399, 58.58),
        courtHeading = 205.0174,
        courtWidth = 8.22,
        courtLength = 11.95,

        centerConstant = 0.0,
    },
    west_eclipse_2 = {
        z = 53.71,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1508.363525, -73.36015, 53.71),
        courtHeading = 221.0115,
        courtWidth = 7.95,
        courtLength = 11.88,

        centerConstant = 0.0,
    },
    morningwood = {
        z = 48.23,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1615.5266, -343.4387, 48.23),
        courtHeading = 140.80388,
        courtWidth = 7.95,
        courtLength = 11.88,

        centerConstant = -0.095,
    },
    rockf_c_1 = {
        z = 65.759999999999,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-977.11999, 212.49339, 65.76),
        courtHeading = 155.0444,
        courtWidth = 7.95,
        courtLength = 11.88,

        centerConstant = -0.095,
    },
    rockf_c_2 = {
        z = 60.67,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1018.3194, 179.1832, 60.67),
        courtHeading = 110.0444,
        courtWidth = 7.95,
        courtLength = 11.93,

        centerConstant = -0.095,
    },
    rockf_c_3 = {
        z = 79.0,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1223.96997, 338.64999, 79.0),
        courtHeading = 196.3324,
        courtWidth = 8.37,
        courtLength = 11.93,

        centerConstant = 0.0,
    },
    rockf_c_4 = {
        z = 79.0,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1233.36059, 372.7033, 79.0),
        courtHeading = 286.3429,
        courtWidth = 8.37,
        courtLength = 11.93,

        centerConstant = -0.165,
    },
    alta_1 = {
        z = 52.79,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(474.67355, -255.43678, 52.79),
        courtHeading = 340.022,
        courtWidth = 8.05,
        courtLength = 11.93,

        centerConstant = 0.0,
    },
    alta_2 = {
        z = 52.79,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(487.53, -217.94, 52.79),
        courtHeading = 340.022,
        courtWidth = 8.05,
        courtLength = 11.93,

        centerConstant = -0.03,
    },
    lakevw = {
        z = 231.18,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-43.1966, 942.13659, 231.18),
        courtHeading = 84.9115,
        courtWidth = 8.03,
        courtLength = 11.86,

        centerConstant = -0.02,
    },
    vespucci_1 = {
        z = 3.39,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1153.6933, -1639.9835, 3.39),
        courtHeading = 35.0,
        courtWidth = 8.2,
        courtLength = 11.90,

        centerConstant = -0.015,
    },
    vespucci_2 = {
        z = 3.39,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1169.89, -1616.87, 3.39),
        courtHeading = 35.0,
        courtWidth = 8.2,
        courtLength = 11.90,

        centerConstant = -0.0,
    },
    vespucci_3 = {
        z = 3.39,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1183.04, -1626.04, 3.38),
        courtHeading = 35.0,
        courtWidth = 8.2,
        courtLength = 11.90,

        centerConstant = -0.02,
    },
    vespucci_4 = {
        z = 3.39,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1166.84, -1649.19, 3.38),
        courtHeading = 35.0,
        courtWidth = 8.2,
        courtLength = 11.90,

        centerConstant = 0.0,
    },
    vespucci_5 = {
        z = 3.39,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1179.97, -1658.39, 3.39),
        courtHeading = 35.0,
        courtWidth = 8.2,
        courtLength = 11.90,

        centerConstant = 0.0,
    },
    vespucci_6 = {
        z = 3.39,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1196.18, -1635.25, 3.39),
        courtHeading = 35.0,
        courtWidth = 8.2,
        courtLength = 11.90,

        centerConstant = 0.0,
    },
    vespucci_7 = {
        z = 3.39,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1209.31, -1644.45, 3.38),
        courtHeading = 35.0,
        courtWidth = 8.2,
        courtLength = 11.90,

        centerConstant = 0.0,
    },
    vespucci_8 = {
        z = 3.39,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1193.09, -1667.58, 3.38),
        courtHeading = 35.0,
        courtWidth = 8.2,
        courtLength = 11.90,

        centerConstant = 0.0,
    },
    playboy = {
        z = 3.39,
        ballPos = nil,
        ballVelocity = nil,
        spin = CONST_HIT_NORMAL,
        predictedCollisionCoords = nil,
        collisionSuspendedUntil = 0,
        isCollisionActive = false,
        courtCenter = vector3(-1554.669800, 69.742920, 56.5499),
        courtHeading = 47.036,
        courtWidth = 8.0,
        courtLength = 11.89,
        centerConstant = 0.09,
    },
}