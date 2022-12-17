Config = {} 

Config.Logs = true -- Active/Désactive les logs

Config.Peds = {
    [1] = {
        coords = vector3(-2272.44, 229.41, 194.61), -- Début Labyrinthe
        heading = 129.36,
        distancespawn = 100,
        model = 's_f_y_shop_mid',
        anim = "friends@frj@ig_1",
        anim2 = "wave_d",
        txt = '"1er Informatrice : "Bien joué ! Illuminée qu`importe l`heure, je tournoie au dessus des flots"',
    },
    [2] = {
        coords = vector3(-1660.69, -1121.75, 13.02), -- Fête foraine
        heading = 294.58,
        distancespawn = 50,
        model = 'a_m_m_bevhills_02',
        anim = "rcmnigel1cnmt_1c",
        anim2 = "base",
        txt = '2e Informateur : "SAVUR UN PAVONTAVON ELLE RAVEGAVARDE AU PLAVUS LAVOIN VAVERS LE NAVORD"',
    },
    [3] = {
        coords = vector3(-271.22, 6644.94, 7.39), -- Poton Paleto
        heading = 28.92,
        distancespawn = 150,
        model = 'a_f_y_beach_01',
        anim = "amb@prop_human_bum_shopping_cart@male@idle_a",
        anim2 = "idle_c",
        txt = '3e Informatrice : "Trop facile ?! Hmm ok ! Elle contemple un totem du haut d`une grande cascade"',
    },
    [4] = {
        coords = vector3(-1641.82, 2072.35, 89.4), -- Cascade
        heading = 288.52,
        distancespawn = 150,
        model = 'a_f_y_tourist_01',
        anim = "misscarsteal4@aliens",
        anim2 = "rehearsal_base_idle_director",
        txt = '4e Informatrice : "Tu te débrouilles bien ! Maintenant remonte à la source"',
    },
    [5] = {
        coords = vector3(-2169.53, 1630.93, 246.35), -- Bonne source
        heading = 321.35,
        distancespawn = 100,
        model = 'a_f_y_runner_01',
        anim = "amb@world_human_cheering@male_a",
        anim2 = "base",
        txt = '5e Informatrice : "On lâche rien ! Carré Polybe : 1/4 - 2/4 - 3/3 - 3/4 - 4/2 - 3/4 - 4/3 - 1/5"',
    },
    [6] = {
        coords = vector3(2566.2, 2568.63, 36.42), -- Dino Rose
        heading = 140.15,
        distancespawn = 80,
        model = 'a_f_y_juggalo_01',
        anim = "anim@amb@business@bgen@bgen_no_work@",
        anim2 = "sit_phone_phoneputdown_idle_nowork",
        txt = '6e Informatrice : "Tu m`as trouvé ! Popular Street : 19 - 11 - 1 - 20 - 5 - 16 - 1 - 18 - 11"',
    },
    [7] = {
        coords = vector3(719.06, -1218.82, 25.32), -- Skate Park
        heading = 255.13,
        distancespawn = 70,
        model = 'a_m_y_skater_01',
        anim = "amb@world_human_hang_out_street@male_b@idle_a",
        anim2 = "idle_b",
        txt = '7e Informateur : "evresbo`J eppurG shceS ertne xued sreimlap"',
    },
    [8] = {
        coords = vector3(-170.61, -768.9, 41.92), -- G6
        heading = 157.79,
        distancespawn = 120,
        model = 'a_m_y_vindouche_01',
        anim = "amb@world_human_hang_out_street@female_arms_crossed@idle_a",
        anim2 = "idle_a",
        txt = '8e Informateur : "Chauffe tes méninges ! Njssps Qbsl Mbd"',
    },
    [9] = {
        coords = vector3(1109.43, -631.59, 56.82), -- Lac Mirror Park
        heading = 148.66,
        distancespawn = 120,
        model = 'a_f_y_eastsa_02',
        anim = "friends@frj@ig_1",
        anim2 = "wave_b",
        txt = '9e Informatrice : "Tout va bien ? Je suis une protéine fibreuse qui forme la lamina nucléaire"',
    },
    [10] = {
        coords = vector3(-482.04, 1894.99, 119.74), -- Mine
        heading = 99.05,
        distancespawn = 80,
        model = 'a_m_y_motox_02',
        anim = "misscarsteal4@aliens",
        anim2 = "rehearsal_base_idle_director",
        txt = '10e Informateur : "T`en es à la moitié ! En haut d`un immeuble donnant sur la Place des Cubes"',
    },
    [11] = {
        coords = vector3(259.26, -1000.6, 61.6), -- Place des Cubes
        heading = 60.2,
        distancespawn = 50,
        model = 'a_f_y_vinewood_04',
        anim = "friends@fra@ig_1",
        anim2 = "base_idle",
        txt = '11e Informatrice : "Tu fatigues ? Haha ! Monument : LIVMGZO GSVZGVI"',
    },
    [12] = {
        coords = vector3(297.24, 204.26, 104.37), -- Oriental
        heading = 158.17,
        distancespawn = 80,
        model = 'cs_movpremf_01',
        anim = "missbigscore2aig_3",
        anim2 = "wait_for_van_c",
        txt = '12e Informatrice : "Délivrez-moi ! Je suis une jolie princesse à deux pâtés d`ici au Sud"',
    },
    [13] = {
        coords = vector3(203.42, -147.77, 57.18), -- Vinewood quartier
        heading = 155.76,
        distancespawn = 50,
        model = 'a_m_m_tranvest_01',
        anim = "amb@world_human_cheering@male_a",
        anim2 = "base",
        txt = '13e Informatrice : "Comment ça je suis pas une princesse ? Monte le Mont Chiliad en motocross"',
    },
    [14] = {
        coords = vector3(501.62, 5599.82, 796.42), -- Moto Mount Chiliad
        heading = 174.83,
        distancespawn = 100,
        model = 'a_m_y_motox_02',
        anim = "anim@heists@heist_corona@single_team",
        anim2 = "single_team_loop_boss",
        txt3 = '14e Informateur : "Descends le Mont Chilial vers le Sud-Ouest (point GPS) en moins de 1m35s"',
    },
    [15] = {
        coords = vector3(-3027.35, 31.3, 10.87), -- PB Country Club
        heading = 64.39,
        distancespawn = 100,
        model = 'a_m_y_beach_03',
        anim = "amb@prop_human_bum_shopping_cart@male@idle_a",
        anim2 = "idle_c",
        txt = '15e Informateur : "Je suis caché dans le grand Motel Office abandonné"',
    },
    [16] = {
        coords = vector3(1540.88, 3593.52, 38.77), -- Motel
        heading = 61.71,
        distancespawn = 30,
        model = 'a_m_y_hippy_01',
        anim = "missbigscore2aig_3",
        anim2 = "wait_for_van_c",
        txt = '16e Informateur : "01000111 01110010 01101111 01110100 01110100 01100101 proche de l`ocèan"',
    },
    [17] = {
        coords = vector3(3068.91, 2208.05, 2.87), -- Grotte
        heading = 250.52,
        distancespawn = 120,
        model = 'a_m_y_jetski_01',
        anim = "anim@amb@business@bgen@bgen_no_work@",
        anim2 = "sit_phone_phoneputdown_idle_nowork",
        txt = '17e Informateur : "Bientôt tu en vois le bout ! Lâche rien ! térMo itLtel ueoSl"',
    },
    [18] = {
        coords = vector3(-480.4, -727.95, 23.9), -- Métro
        heading = 7,
        distancespawn = 30,
        model = 'a_m_o_genstreet_01',
        anim = "anim@mp_player_intupperair_shagging",
        anim2 = "idle_a",
        txt = '18e Informateur : "Géantes .-.. / . / - / - / .-. / . / ... / qui dominent la ville ! Oh Hmmm !"',
    },
    [19] = {
        coords = vector3(671.52, 1204.71, 322.77), -- Vinewood lettre
        heading = 151.95,
        distancespawn = 80,
        model = 'a_f_y_soucent_03',
        anim = "mp_move@prostitute@m@french",
        anim2 = "idle",
        anim5 = "amb@world_human_cheering@male_a",
        anim6 = "base",
        txt = '19e Informatrice : "Trouve un signe dans le ciel sur la scène des émotions ..."',
        event2 = "chasse:client:UseFirework",
    },
    [20] = {
        coords = vector3(202.29, 1166.68, 227.0), -- Sisyphus theater
        heading = 101.85,
        distancespawn = 150,
        model = 's_f_y_hooker_01',
        anim = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
        anim2 = "low_center",
        anim5 = "amb@world_human_cheering@male_a",
        anim6 = "base",
        txt = '"Incroyable ! Vous avez terminé la Chasse au trésor. Envoyez un mail à : railey.pearce@samail.us"',
        event = "chasse:client:UseFirework",
    },    
    [21] = {
        coords = vector3(204.77, 1170.33, 227.0), -- Sisyphus theater
        heading = 101.85,
        distancespawn = 150,
        model = 's_f_y_hooker_01',
        anim = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
        anim2 = "low_center_down",
        anim5 = "amb@world_human_cheering@male_a",
        anim6 = "base",
        txt = '"Bravo ! Je vous applaudit ! Envoyez un mail à Railey Pearce : railey.pearce@samail.us"',
        event = "chasse:client:UseFirework",
    },
    [22] = {
        coords = vector3(206.09, 1164.58, 227.01), -- Sisyphus theater
        heading = 101.85,
        distancespawn = 150,
        model = 's_f_y_hooker_01',
        anim = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@",
        anim2 = "low_center_down",
        anim5 = "amb@world_human_cheering@male_a",
        anim6 = "base",
        txt = '"Bien joué à vous et félicitation ! Envoyez un mail à Railey Pearce : railey.pearce@samail.us"',
        event = "chasse:client:UseFirework",
    },
    [23] = {
        coords = vector3(208.53, 1168.27, 227.0), -- Sisyphus theater
        heading = 101.85,
        distancespawn = 150,
        model = 'ig_tylerdix_02',
        anim = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@",
        anim2 = "low_center",
        anim5 = "amb@world_human_cheering@male_a",
        anim6 = "base",
        txt = '"Parfait ! Bravo à vous ! On baise ? Grrrrrr 555-2303"',
        event = "chasse:client:UseFirework",
    },


    
    ---------- Figurants :



    [24] = {
        coords = vector3(-1929.61, 1983.07, 143.51), -- Mauvaise source
        heading = 335.44,
        distancespawn = 80,
        model = 'a_m_m_paparazzi_01',
        anim = "anim@amb@business@bgen@bgen_no_work@",
        anim2 = "sit_phone_phoneputdown_idle_nowork",
        txt2 = 'Participant : "Mauvaise piste, c`est pas ici ! Laisse moi me reposer maintenant"',
    },
    [25] = {
        coords = vector3(154.56, -129.39, 54.83), -- Mauvaix Quartier
        heading = 47.0,
        distancespawn = 100,
        model = 's_m_y_robber_01',
        anim = "random@car_thief@agitated@idle_a",
        anim2 = "agitated_idle_a",
        anim3 = "misscarsteal4@actor",
        anim4 = "actor_berating_loop",
        coordsnetscene = vector3(154.2, -129.05, 53.83),
        txt2 = 'Participant : "Princesse de merde ! Je perd mon temps ici moi ! File moi ta thune toi !"',
    },
    [26] = {
        coords = vector3(139.69, -92.39, 77.1), -- Mauvaix Quartier
        heading = 165.8,
        distancespawn = 100,
        model = 'csb_denise_friend',
        anim = "re@construction",
        anim2 = "out_of_breath",
        txt2 = 'Participante : "Impossible de mettre la main sur cette princesse ! Je suis creuvée putain !"',
    },
    [27] = {
        coords = vector3(210.8, -130.27, 73.31), -- Mauvaix Quartier
        heading = 188.51,
        distancespawn = 100,
        model = 'g_f_y_vagos_01',
        anim = "amb@world_human_bum_wash@male@low@idle_a",
        anim2 = "idle_a",
        txt2 = 'Participante : "Madre mía ! Je deviens folle, j`entends des applaudissements pas loin !"',
    },
    [28] = {
        coords = vector3(233.99, -106.96, 73.35), -- Mauvaix Quartier
        heading = 293.07,
        distancespawn = 100,
        model = 'u_f_o_moviestar',
        anim = "amb@world_human_leaning@male@wall@back@foot_up@idle_a",
        anim2 = "idle_a",
        txt2 = 'Voisine : "Oui, c`est moi la princesse et si tu rentres, je te réserve des surprises coquines"',
    },
    [29] = {
        coords = vector3(170.56, -98.3, 80.53), -- Mauvaix Quartier
        heading = 237.42,
        distancespawn = 100,
        model = 'csb_ramp_mex',
        anim = "friends@frj@ig_1",
        anim2 = "wave_b",
        txt2 = 'Participant : "Ya ma chica là-bas ! C`est elle la princesse de mes nuits. Youhouuuu !"',
    },
    [30] = {
        coords = vector3(1079.87, -702.7, 57.97), -- Mauvais Lac Mirror Park
        heading = 189.41,
        distancespawn = 150,
        model = 'g_m_y_famfor_01',
        anim = "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a",
        anim2 = "idle_a",
        anim3 = "anim@mp_player_intcelebrationfemale@jazz_hands",
        anim4 = "jazz_hands",
        coordsnetscene = vector3(1079.87, -702.7, 57.97),
        txt2 = 'Participant : "Je suis un informateur. C`est faux. Donne moi ton oseille !"',
    },
    [31] = {
        coords = vector3(-594.1, 2094.02, 131.54), -- Devant Mine
        heading = 169.35,
        distancespawn = 100,
        model = 'a_m_y_polynesian_01',
        anim = "timetable@ron@ig_5_p3",
        anim2 = "ig_5_p3_base",
        txt2 = 'Participant : "Si seulement j`avais la CS Flash pour l`apprendre à mon Pikachu"',
    },
    [32] = {
        coords = vector3(-457.4, 2050.78, 122.51), -- Dans la Mine
        heading = 163.18,
        distancespawn = 80,
        model = 'a_m_y_gay_02',
        anim = "random@domestic",
        anim2 = "f_distressed_loop",
        txt2 = 'Participant : "Je peux plus continuer ! Il fait vraiment trop sombre, j`me fais dessus là !"',
    },
    [33] = {
        coords = vector3(-540.42, 1984.29, 126.98), -- Dans la Mine
        heading = 85.76,
        distancespawn = 80,
        model = 'a_f_m_tourist_01',
        anim = "random@shop_tattoo",
        anim2 = "_idle_a",
        txt2 = 'Participante : "Fait chier ! Ma lampe de torche est tombé en rade"',
    },
    [34] = {
        coords = vector3(-594.15, 2094.99, 132.11), -- Devant la Mine
        heading = 127.48,
        distancespawn = 100,
        model = 'a_c_rat',
        txt2 = 'Un rat qui porte un collier au nom de "Pikachu" ',
    },
    [35] = {
        coords = vector3(-444.05, 2014.84, 122.57), -- Dans la Mine
        heading = 56.55,
        distancespawn = 150,
        model = 'a_m_y_genstreet_02',
        anim = "missheistfbi3b_ig7",
        anim2 = "lift_fibagent_loop",
        txt2 = 'Participant : "Rhaaaaa ! Si faut c`est juste de l`autre côté !"',
    },
    [36] = {
        coords = vector3(113.59, 1111.86, 253.04), -- Mauvaix Firework
        heading = 241.9,
        distancespawn = 100,
        model = 'ig_ortega',
        anim = "anim@mp_player_intupperface_palm",
        anim2 = "idle_a",
        anim3 = "misscarsteal4@actor",
        anim4 = "actor_berating_loop",
        coordsnetscene = vector3(113.98, 1111.65, 252.01),
        txt2 = 'Participant : "Hé coño va ! "SCÉNES DES ÉMOTIONS" ?! T`en vois où des émotions cabrón ?!"',
    },
    [37] = {
        coords = vector3(-2303.61, 202.31, 171.22), -- Début Labyrinthe
        heading = 314.15,
        distancespawn = 150,
        model = 'mp_f_chbar_01',
        anim = "friends@frj@ig_1",
        anim2 = "wave_b",
        txt2 = '"Bienvenue pour la Chasse au trésor ! Mais je suis une complice, la bonne et un peu plus haute"',
    },
    [38] = {
        coords = vector3(51.58, -1004.25, 79.84), -- Mauvaix Immeuble
        heading = 205.11,
        distancespawn = 50,
        model = 'mp_m_weapexp_01',
        anim = "anim@mp_player_intupperface_palm",
        anim2 = "idle_a",
        anim3 = "misscarsteal4@actor",
        anim4 = "actor_berating_loop",
        coordsnetscene = vector3(51.8, -1004.75, 78.84),
        txt2 = 'Participant : "Putain gros ! J`le trouve pas bordel ! Dis moi où il est ! Vite !"',
    },
    [39] = {
        coords = vector3(851.86, -1321.84, 26.23), -- SAHP
        heading = 81.9,
        distancespawn = 100,
        model = 's_m_y_hwaycop_01',
        anim = "anim@amb@casino@hangout@ped_male@stand@02b@idles",
        anim2 = "idle_a",
        anim5 = "amb@world_human_hang_out_street@female_arms_crossed@idle_a",
        anim6 = "idle_a",
        txt2 = 'Traffic Officer : "100 000$ à gagner, c`est du jamais vu ! Pearce à gérer pour le coup"',
    },
    [40] = {
        coords = vector3(851.06, -1320.98, 26.24), -- SAHP
        heading = 200.45,
        distancespawn = 100,
        model = 's_m_y_hwaycop_01',
        anim = "random@shop_tattoo",
        anim2 = "_idle_a",
        anim5 = "amb@world_human_hang_out_street@male_c@idle_a",
        anim6 = "idle_b",
        txt2 = 'Traffic Officer : "Je pense que je vais prendre mon 10-10 pour participer à la chasse au trésor"',
    },
}

Config.Webhooks = {
    ['chasse'] = 'https://discord.com/api/webhooks/1014923964864278579/rs6Hn5yglx38b0aus1WAeXla6sfHhizWMkfzk_S7lxwmMtsp9v434yEvjeK483KA-hLY',

    -- LS EVENT : https://discord.com/api/webhooks/1046091652328067082/9VM_JsXvWyIqsmlitjnb9RDqthfz8ZtKivjXkllkD7lwYDv4q2_Gu-93UMyK-yMgBX0p
    -- ORA : https://discord.com/api/webhooks/1014923964864278579/rs6Hn5yglx38b0aus1WAeXla6sfHhizWMkfzk_S7lxwmMtsp9v434yEvjeK483KA-hLY
}

Config.Colors = {
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
}
