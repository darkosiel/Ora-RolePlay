local LS = {}
local ngc,ndt,nav,nar,stickers = false,false,false,false,false
local prc = 0

function LS.CanBuy(cost)
    local can = nil
    TriggerServerCallback(
        "getBankingAccountsPly3",
        function(result)
            amount = result[1].amount
            if amount - cost >= 0 then
                can = true
            else
                ShowNotification("~r~Pas assez d'argent dans le compte mécano !")
                can = false
            end
        end,
        "mecano"
    )
    while can == nil do
        Wait(1)
    end
    return can
end

LS.BUY = function(cost)
    TriggerServerEvent("banking:removeAmountFromAccount", "mecano", cost)
end

local customs = {
    {
        title = "Aileron",
        mod = 0,
        startingcost = 3,
        data = {}
    },
    {
        title = "Pare-chocs avant",
        mod = 1,
        startingcost = 1.5,
        data = {}
    },
    {
        title = "Pare-chocs arrière",
        mod = 2,
        startingcost = 1.5,
        data = {}
    },
    {
        title = "Bas de caisse",
        mod = 3,
        startingcost = 1.5,
        data = {}
    },
    {
        title = "Échappement",
        mod = 4,
        startingcost = 1,
        data = {}
    },
    {
        title = "Cage",
        mod = 5,
        startingcost = 3,
        data = {}
    },
    {
        title = "Grille",
        mod = 6,
        startingcost = 1.0,
        data = {}
    },
    {
        title = "Capot",
        mod = 7,
        startingcost = 2.5,
        data = {}
    },
    {
        title = "Aile gauche",
        mod = 8,
        startingcost = 1,
        data = {}
    },
    {
        title = "Aile droite",
        mod = 9,
        startingcost = 1,
        data = {}
    },
    {
        title = "Toit",
        mod = 10,
        startingcost = 2,
        data = {}
    },
    {
        title = "Stickers",
        mod = 48,
        startingcost = 2,
        data = {}
    },
    {
        title = "Bloc moteur",
        mod = 39,
        startingcost = 5,
        data = {}
    },
    {
        title = "Filtre à air",
        mod = 40,
        startingcost = 1,
        data = {}
    },
    {
        title = "Siège",
        mod = 32,
        startingcost = 3,
        data = {}
    },
    {
        title = "Compteur",
        mod = 30,
        startingcost = 2,
        data = {}
    },
    {
        title = "Volant",
        mod = 33,
        startingcost = 1,
        data = {}
    },
    {
        title = "Tableau de bord",
        mod = 29,
        startingcost = 2,
        data = {}
    },
    {
        title = "Phares",
        mod = 42,
        startingcost = 2,
        data = {}
    },
    {
        title = "Calandre",
        mod = 43,
        startingcost = 5,
        data = {}
    },
    {
        title = "Réservoir",
        mod = 45,
        startingcost = 1,
        data = {}
    },
    {
        title = "Prise d'air",
        mod = 44,
        startingcost = 5,
        data = {}
    },
    {
        title = "Coffre",
        mod = 37,
        startingcost = 2,
        data = {}
    },
    {
        title = "Levier de vitesse",
        mod = 34,
        startingcost = 1,
        data = {}
    },
    {
        title = "Ornement",
        mod = 28,
        startingcost = 5,
        data = {}
    },
    {
        title = "Contour de plaque",
        mod = 25,
        startingcost = 2,
        data = {}
    },
    {
        title = "Plaque vitre arrière",
        mod = 26,
        startingcost = 2,
        data = {}
    },
    {
        title = "Portière",
        mod = 31,
        startingcost = 2,
        data = {}
    },
    {
        title = "Haut parleurs",
        mod = 36,
        startingcost = 2,
        data = {}
    },
    {
        title = "Plaques",
        mod = 35,
        startingcost = 2,
        data = {}
    },
    {
        title = "Pompe hydrolique",
        mod = 38,
        startingcost = 15,
        data = {}
    },
    {
        title = "Moteur",
        data = {
            {name = "Amélioration moteur niveau 1", mt = 11, mod = -1, cost = 10},
            {name = "Amélioration moteur niveau 2", mt = 11, mod = 0, cost = 15},
            {name = "Amélioration moteur niveau 3", mt = 11, mod = 1, cost = 20},
            {name = "Amélioration moteur niveau 4", mt = 11, mod = 2, cost = 25}
        }
    },
    {
        title = "Freins",
        data = {
            {name = "Freins de série", mt = 12, mod = -1, cost = 2.5},
            {name = "Freins milieu de gamme", mt = 12, mod = 0, cost = 5},
            {name = "Freins sportifs", mt = 12, mod = 1, cost = 7.5},
            {name = "Freins de course", mt = 12, mod = 2, cost = 10}
        }
    },
    {
        title = "Transmission",
        data = {
            {name = "Transmission de série", mod = -1, mt = 13, cost = 5},
            {name = "Transmission milieu de gamme", mod = 0, mt = 13, cost = 7.5},
            {name = "Transmission sportive", mod = 1, mt = 13, cost = 10},
            {name = "Transmission de course", mod = 2, mt = 13, cost = 12.5}
        }
    },
    {
        title = "Klaxon",
        data = {
            {name = "Klaxon par défaut", mt = 14, mod = -1, cost = 0},
            {name = "Klaxon de camion", mt = 14, mod = 0, cost = 0.5},
            {name = "Klaxon camion de glace", mt = 14, mod = 1, cost = 0.5},
            {name = "Klaxon clown", mt = 14, mod = 0.5, cost = 0.5},
            {name = "Klaxon musical 1", mt = 14, mod = 3, cost = 0.5},
            {name = "Klaxon musical 0.5", mt = 14, mod = 4, cost = 0.5},
            {name = "Klaxon musical 3", mt = 14, mod = 5, cost = 0.5},
            {name = "Klaxon musical 4", mt = 14, mod = 6, cost = 0.5},
            {name = "Klaxon musical 5", mt = 14, mod = 7, cost = 0.5},
            {name = "Klaxon trombone triste", mt = 14, mod = 8, cost = 0.5},
            {name = "Klaxon classique 1", mt = 14, mod = 9, cost = 0.5},
            {name = "Klaxon classique 0.5", mt = 14, mod = 10, cost = 0.5},
            {name = "Klaxon classique 3", mt = 14, mod = 11, cost = 0.5},
            {name = "Klaxon classique 4", mt = 14, mod = 12, cost = 0.5},
            {name = "Klaxon classique 5", mt = 14, mod = 13, cost = 0.5},
            {name = "Klaxon classique 6", mt = 14, mod = 14, cost = 0.5},
            {name = "Klaxon classique 7", mt = 14, mod = 15, cost = 0.5},
            {name = "Klaxon note Do", mt = 14, mod = 16, cost = 0.5},
            {name = "Klaxon note Ré", mt = 14, mod = 17, cost = 0.5},
            {name = "Klaxon note Mi", mt = 14, mod = 18, cost = 0.5},
            {name = "Klaxon note Fa", mt = 14, mod = 19, cost = 0.5},
            {name = "Klaxon note Sol", mt = 14, mod = 20, cost = 0.5},
            {name = "Klaxon note La", mt = 14, mod = 21, cost = 0.5},
            {name = "Klaxon note Si", mt = 14, mod = 22, cost = 0.5},
            {name = "Klaxon note Do Diez", mt = 14, mod = 23, cost = 0.5},
            {name = "Klaxon Jazz 1", mt = 14, mod = 25, cost = 0.5},
            {name = "Klaxon Jazz 0.5", mt = 14, mod = 26, cost = 0.5},
            {name = "Klaxon Jazz 3", mt = 14, mod = 27, cost = 0.5},
            {name = "Klaxon Jazz en boucle", mt = 14, mod = 32, cost = 0.5},
            {name = "Klaxon musical aigüe 1", mt = 14, mod = 28, cost = 0.5},
            {name = "Klaxon musical aigüe 0.5", mt = 14, mod = 29, cost = 0.5},
            {name = "Klaxon musical aigüe 3", mt = 14, mod = 30, cost = 0.5},
            {name = "Klaxon musical aigüe 4", mt = 14, mod = 31, cost = 0.5},
            {name = "Klaxon classique boucle 1", mt = 14, mod = 33, cost = 0.5},
            {name = "Klaxon classique 8", mt = 14, mod = 34, cost = 0.5},
            {name = "Klaxon classique boucle 2", mt = 14, mod = 35, cost = 0.5}
        }
    },
    {
        title = "Suspension",
        data = {
            {name = "Suspension de série", mod = -1, mt = 15, cost = 5},
            {name = "Suspension améliorée", mod = 0, mt = 15, cost = 7.5},
            {name = "Suspension de rue", mod = 1, mt = 15, cost = 10},
            {name = "Suspension sportive", mod = 2, mt = 15, cost = 12.5},
            {name = "Suspension de compétition", mod = 3, mt = 15, cost = 15}
        }
    },
    {
        title = "Xénon",
        data = {
            {name = "Phares d'usine", bool = false, mt = 22, color = nil, cost = 0},
            {name = "Phares Xénon", bool = true, mt = 22, color = nil, cost = 0.75},   
            {name = "Phares Xénon Bleu", bool = true, mt = 22, color = 1, cost = 1.25},
            {name = "Phares Xénon Bleu électrique", bool = true, mt = 22, color = 2, cost = 1.25},
            {name = "Phares Xénon Vert menthe", bool = true, mt = 22, color = 3, cost = 1.25},
            {name = "Phares Xénon Vert lime", bool = true, mt = 22, color = 4, cost = 1.25},
            {name = "Phares Xénon Jaune", bool = true, mt = 22, color = 5, cost = 1.25},
            {name = "Phares Xénon Or", bool = true, mt = 22, color = 6, cost = 1.25},
            {name = "Phares Xénon Orange", bool = true, mt = 22, color = 7, cost = 1.25},
            {name = "Phares Xénon Rouge", bool = true, mt = 22, color = 8, cost = 1.25},
            {name = "Phares Xénon Rose", bool = true, mt = 22, color = 9, cost = 1.25},
            {name = "Phares Xénon Rose chaud", bool = true, mt = 22, color = 10, cost = 1.25},
            {name = "Phares Xénon Violet", bool = true, mt = 22, color = 11, cost = 1.25},
            {name = "Phares Xénon Lumière noire", bool = true, mt = 22, color = 12, cost = 1.25}
        }
    },
    {
        title = "Néons",
        data = {
            {name = "Blanc", colour = {255,255,255}, cost = 1.5},
            {name = "Bleu", colour = {2,21,255}, cost = 1.5},
            {name = "Bleu électrique", colour = {3,83,255}, cost = 1.5},
            {name = "Vert menthe", colour = {0,255,140}, cost = 1.5},
            {name = "Vert lime", colour = {94,255,1}, cost = 1.5},
            {name = "Jaune", colour = {255,255,0}, cost = 1.5},
            {name = "Or", colour = {255,150,0}, cost = 1.5},
            {name = "Orange", colour = {255,62,0}, cost = 1.5},
            {name = "Rouge", colour = {255,1,1}, cost = 1.5},
            {name = "Rose", colour = {255,50,100}, cost = 1.5},
            {name = "Rose chaud", colour = {255,5,190}, cost = 1.5},
            {name = "Violet", colour = {35,1,155}, cost = 1.5},
            {name = "Lumière noire", colour = {15,3,255}, cost = 1.5}
        }
    },
    {
        title = "Intérieur",
        data = {
            {name = "Metallic Graphite Black", cost = 1},
            {name = "Metallic Black Steal", cost = 1},
            {name = "Metallic Dark Silver", cost = 1},
            {name = "Metallic Black", cost = 1},
            {name = "Metallic Silver", cost = 1},
            {name = "Metallic Blue Silver", cost = 1},
            {name = "Metallic Steel Gray", cost = 1},
            {name = "Metallic Shadow Silver", cost = 1},
            {name = "Metallic Stone Silver", cost = 1},
            {name = "Metallic Midnight Silver", cost = 1},
            {name = "Metallic Gun Metal", cost = 1},
            {name = "Metallic Anthracite Grey", cost = 1},
            {name = "Matte Black", cost = 1},
            {name = "Matte Gray", cost = 1},
            {name = "Matte Light Grey", cost = 1},
            {name = "Util Black", cost = 1},
            {name = "Util Black Poly", cost = 1},
            {name = "Util Dark silver", cost = 1},
            {name = "Util Silver", cost = 1},
            {name = "Util Gun Metal", cost = 1},
            {name = "Util Shadow Silver", cost = 1},
            {name = "Worn Black", cost = 1},
            {name = "Worn Graphite", cost = 1},
            {name = "Worn Silver Grey", cost = 1},
            {name = "Worn Silver", cost = 1},
            {name = "Worn Blue Silver", cost = 1},
            {name = "Worn Shadow Silver", cost = 1},
            {name = "Metallic Red", cost = 1},
            {name = "Metallic Torino Red", cost = 1},
            {name = "Metallic Formula Red", cost = 1},
            {name = "Metallic Blaze Red", cost = 1},
            {name = "Metallic Graceful Red", cost = 1},
            {name = "Metallic Garnet Red", cost = 1},
            {name = "Metallic Desert Red", cost = 1},
            {name = "Metallic Cabernet Red", cost = 1},
            {name = "Metallic Candy Red", cost = 1},
            {name = "Metallic Sunrise Orange", cost = 1},
            {name = "Metallic Classic Gold", cost = 1},
            {name = "Metallic Orange", cost = 1},
            {name = "Matte Red", cost = 1},
            {name = "Matte Dark Red", cost = 1},
            {name = "Matte Orange", cost = 1},
            {name = "Matte Yellow", cost = 1},
            {name = "Util Red", cost = 1},
            {name = "Util Bright Red", cost = 1},
            {name = "Util Garnet Red", cost = 1},
            {name = "Worn Red", cost = 1},
            {name = "Worn Golden Red", cost = 1},
            {name = "Worn Dark Red", cost = 1},
            {name = "Metallic Dark Green", cost = 1},
            {name = "Metallic Racing Green", cost = 1},
            {name = "Metallic Sea Green", cost = 1},
            {name = "Metallic Olive Green", cost = 1},
            {name = "Metallic Green", cost = 1},
            {name = "Metallic Gasoline Blue Green", cost = 1},
            {name = "Matte Lime Green", cost = 1},
            {name = "Util Dark Green", cost = 1},
            {name = "Util Green", cost = 1},
            {name = "Worn Dark Green", cost = 1},
            {name = "Worn Green", cost = 1},
            {name = "Worn Sea Wash", cost = 1},
            {name = "Metallic Midnight Blue", cost = 1},
            {name = "Metallic Dark Blue", cost = 1},
            {name = "Metallic Saxony Blue", cost = 1},
            {name = "Metallic Blue", cost = 1},
            {name = "Metallic Mariner Blue", cost = 1},
            {name = "Metallic Harbor Blue", cost = 1},
            {name = "Metallic Diamond Blue", cost = 1},
            {name = "Metallic Surf Blue", cost = 1},
            {name = "Metallic Nautical Blue", cost = 1},
            {name = "Metallic Bright Blue", cost = 1},
            {name = "Metallic Purple Blue", cost = 1},
            {name = "Metallic Spinnaker Blue", cost = 1},
            {name = "Metallic Ultra Blue", cost = 1},
            {name = "Metallic Bright Blue", cost = 1},
            {name = "Util Dark Blue", cost = 1},
            {name = "Util Midnight Blue", cost = 1},
            {name = "Util Blue", cost = 1},
            {name = "Util Sea Foam Blue", cost = 1},
            {name = "Util Lightning blue", cost = 1},
            {name = "Util Maui Blue Poly", cost = 1},
            {name = "Util Bright Blue", cost = 1},
            {name = "Matte Dark Blue", cost = 1},
            {name = "Matte Blue", cost = 1},
            {name = "Matte Midnight Blue", cost = 1},
            {name = "Worn Dark blue", cost = 1},
            {name = "Worn Blue", cost = 1},
            {name = "Worn Light blue", cost = 1},
            {name = "Metallic Taxi Yellow", cost = 1},
            {name = "Metallic Race Yellow", cost = 1},
            {name = "Metallic Bronze", cost = 1},
            {name = "Metallic Yellow Bird", cost = 1},
            {name = "Metallic Lime", cost = 1},
            {name = "Metallic Champagne", cost = 1},
            {name = "Metallic Pueblo Beige", cost = 1},
            {name = "Metallic Dark Ivory", cost = 1},
            {name = "Metallic Choco Brown", cost = 1},
            {name = "Metallic Golden Brown", cost = 1},
            {name = "Metallic Light Brown", cost = 1},
            {name = "Metallic Straw Beige", cost = 1},
            {name = "Metallic Moss Brown", cost = 1},
            {name = "Metallic Biston Brown", cost = 1},
            {name = "Metallic Beechwood", cost = 1},
            {name = "Metallic Dark Beechwood", cost = 1},
            {name = "Metallic Choco Orange", cost = 1},
            {name = "Metallic Beach Sand", cost = 1},
            {name = "Metallic Sun Bleeched Sand", cost = 1},
            {name = "Metallic Cream", cost = 1},
            {name = "Util Brown", cost = 1},
            {name = "Util Medium Brown", cost = 1},
            {name = "Util Light Brown", cost = 1},
            {name = "Metallic White", cost = 1},
            {name = "Metallic Frost White", cost = 1},
            {name = "Worn Honey Beige", cost = 1},
            {name = "Worn Brown", cost = 1},
            {name = "Worn Dark Brown", cost = 1},
            {name = "Worn straw beige", cost = 1},
            {name = "Brushed Steel", cost = 1},
            {name = "Brushed Black steel", cost = 1},
            {name = "Brushed Aluminium", cost = 1},
            {name = "Chrome", cost = 1},
            {name = "Worn Off White", cost = 1},
            {name = "Util Off White", cost = 1},
            {name = "Worn Orange", cost = 1},
            {name = "Worn Light Orange", cost = 1},
            {name = "Metallic Securicor Green", cost = 1},
            {name = "Worn Taxi Yellow", cost = 1},
            {name = "police car blue", cost = 1},
            {name = "Matte Green", cost = 1},
            {name = "Matte Brown", cost = 1},
            {name = "Worn Orange", cost = 1},
            {name = "Matte White", cost = 1},
            {name = "Worn White", cost = 1},
            {name = "Worn Olive Army Green", cost = 1},
            {name = "Pure White", cost = 1},
            {name = "Hot Pink", cost = 1},
            {name = "Salmon pink", cost = 1},
            {name = "Metallic Vermillion Pink", cost = 1},
            {name = "Orange", cost = 1},
            {name = "Green", cost = 1},
            {name = "Blue", cost = 1},
            {name = "Mettalic Black Blue", cost = 1},
            {name = "Metallic Black Purple", cost = 1},
            {name = "Metallic Black Red", cost = 1},
            {name = "hunter green", cost = 1},
            {name = "Metallic Purple", cost = 1},
            {name = "Metaillic V Dark Blue", cost = 1},
            {name = "MODSHOP BLACK1", cost = 1},
            {name = "Matte Purple", cost = 1},
            {name = "Matte Dark Purple", cost = 1},
            {name = "Metallic Lava Red", cost = 1},
            {name = "Matte Forest Green", cost = 1},
            {name = "Matte Olive Drab", cost = 1},
            {name = "Matte Desert Brown", cost = 1},
            {name = "Matte Desert Tan", cost = 1},
            {name = "Matte Foilage Green", cost = 1},
            {name = "DEFAULT ALLOY COLOR", cost = 1},
            {name = "Epsilon Blue", cost = 1},
            {name = "Pure Gold", cost = 1},
            {name = "Brushed Gold", cost = 1},
            {name = "Secret Gold", cost = 1}
        }
    },
    {
        title = "Plaques",
        data = {
            {name = "Bleu sur blanc 1", plateindex = 0, cost = 0.5},
            {name = "Bleu sur blanc 2", plateindex = 3, cost = 0.5},
            {name = "Bleu sur blanc 3", plateindex = 4, cost = 0.5},
            {name = "Jaune sur bleu", plateindex = 2, cost = 0.5},
            {name = "Jaune sur noir", plateindex = 1, cost = 0.5}
        }
    },
    {
        title = "Peintures",
        data = {
            ["Couleurs primaires"] = {
                ["Classique"] = {
                    {name = "Noir", cost = 1, colour = 0},
                    {name = "Carbon noir", cost = 1, colour = 147},
                    {name = "Graphite", cost = 1, colour = 1},
                    {name = "Anhracite noir", cost = 1, colour = 11},
                    {name = "Noir acier", cost = 1, colour = 2},
                    {name = "Acier foncé", cost = 1, colour = 3},
                    {name = "Argent", cost = 1, colour = 4},
                    {name = "Argent bleué", cost = 1, colour = 5},
                    {name = "Acié laminé", cost = 1, colour = 6},
                    {name = "Argent ombré", cost = 1, colour = 7},
                    {name = "Argent pierre", cost = 1, colour = 8},
                    {name = "Argent sombre", cost = 1, colour = 9},
                    {name = "Argent solide", cost = 1, colour = 10},
                    {name = "Rouge", cost = 1, colour = 27},
                    {name = "Rouge torino", cost = 1, colour = 28},
                    {name = "Rouge formula", cost = 1, colour = 29},
                    {name = "Rouge lave", cost = 1, colour = 150},
                    {name = "Rouge blaze", cost = 1, colour = 30},
                    {name = "Rouge grâcieux", cost = 1, colour = 31},
                    {name = "Rouge grenat", cost = 1, colour = 32},
                    {name = "Rouge coucher de soleil", cost = 1, colour = 33},
                    {name = "Rouge cabernet", cost = 1, colour = 34},
                    {name = "Rouge vin", cost = 1, colour = 143},
                    {name = "Rouge bonbon", cost = 1, colour = 35},
                    {name = "Rose chaud", cost = 1, colour = 135},
                    {name = "Rose clair", cost = 1, colour = 137},
                    {name = "Rose saumon", cost = 1, colour = 136},
                    {name = "Orange lever de soleil", cost = 1, colour = 36},
                    {name = "Orange", cost = 1, colour = 38},
                    {name = "Orange clair", cost = 1, colour = 138},
                    {name = "Or", cost = 1, colour = 99},
                    {name = "Bronze", cost = 1, colour = 90},
                    {name = "Jaune", cost = 1, colour = 88},
                    {name = "Jaune de course", cost = 1, colour = 89},
                    {name = "Jaune rosé", cost = 1, colour = 91},
                    {name = "Vert foncé", cost = 1, colour = 49},
                    {name = "Vert de course", cost = 1, colour = 50},
                    {name = "Vert océan", cost = 1, colour = 51},
                    {name = "Vert olive", cost = 1, colour = 52},
                    {name = "Vert clair", cost = 1, colour = 53},
                    {name = "Vert petrol", cost = 1, colour = 54},
                    {name = "Vert lime", cost = 1, colour = 92},
                    {name = "Bleu de minuit", cost = 1, colour = 141},
                    {name = "Bleu galaxy", cost = 1, colour = 61},
                    {name = "Bleu foncé", cost = 1, colour = 62},
                    {name = "Bleu saxon", cost = 1, colour = 63},
                    {name = "Bleu", cost = 1, colour = 64},
                    {name = "Bleu marine", cost = 1, colour = 65},
                    {name = "Bleu harbor", cost = 1, colour = 66},
                    {name = "Bleu diamand", cost = 1, colour = 67},
                    {name = "Bleu surf", cost = 1, colour = 68},
                    {name = "Bleu nautique", cost = 1, colour = 69},
                    {name = "Bleu de course", cost = 1, colour = 73},
                    {name = "Bleu ultra", cost = 1, colour = 70},
                    {name = "Bleu clair", cost = 1, colour = 74},
                    {name = "Marron chocolat", cost = 1, colour = 96},
                    {name = "Marron buffle", cost = 1, colour = 101},
                    {name = "Marron classique", cost = 1, colour = 95},
                    {name = "Marron feltzer", cost = 1, colour = 94},
                    {name = "Marron érable", cost = 1, colour = 97},
                    {name = "Marron être", cost = 1, colour = 103},
                    {name = "Marron terre", cost = 1, colour = 104},
                    {name = "Marron selle", cost = 1, colour = 98},
                    {name = "Marron élan", cost = 1, colour = 100},
                    {name = "Marron hêtre", cost = 1, colour = 102},
                    {name = "Marron paille", cost = 1, colour = 99},
                    {name = "Marron sablé", cost = 1, colour = 105},
                    {name = "Marron blanchi", cost = 1, colour = 106},
                    {name = "Violet schafter", cost = 1, colour = 71},
                    {name = "Violet spinnaker", cost = 1, colour = 72},
                    {name = "Violet de minuit", cost = 1, colour = 142},
                    {name = "Violet clair", cost = 1, colour = 145},
                    {name = "Crème", cost = 1, colour = 107},
                    {name = "Blanc glacial", cost = 1, colour = 111},
                    {name = "Blanc gelé", cost = 1, colour = 112}
                },
                ["Métalique"] = {
                    {name = "noir", cost = 1.25, colour = 0},
                    {name = "Carbon noir", cost = 1.25, colour = 147},
                    {name = "Hraphite", cost = 1.25, colour = 1},
                    {name = "Anhracite noir", cost = 1.25, colour = 11},
                    {name = "noir acier", cost = 1.25, colour = 2},
                    {name = "foncé acier", cost = 1.25, colour = 750},
                    {name = "argent", cost = 1.25, colour = 4},
                    {name = "Bleuâtre argent", cost = 1.25, colour = 5},
                    {name = "Roulé acier", cost = 1.25, colour = 6},
                    {name = "Ombré argent", cost = 1.25, colour = 7},
                    {name = "Pierre argent", cost = 1.25, colour = 8},
                    {name = "Nuit argent", cost = 1.25, colour = 9},
                    {name = "Fonte argent", cost = 1.25, colour = 10},
                    {name = "rouge", cost = 1.25, colour = 27},
                    {name = "Torino rouge", cost = 1.25, colour = 28},
                    {name = "Formula rouge", cost = 1.25, colour = 29},
                    {name = "Lave rouge", cost = 1.25, colour = 150},
                    {name = "Flamber rouge", cost = 1.25, colour = 30},
                    {name = "Grace rouge", cost = 1.25, colour = 31},
                    {name = "Garnet rouge", cost = 1.25, colour = 32},
                    {name = "levé du jour rouge", cost = 1.25, colour = 33},
                    {name = "Cabernet rouge", cost = 1.25, colour = 34},
                    {name = "Vin rouge", cost = 1.25, colour = 143},
                    {name = "bonbon rouge", cost = 1.25, colour = 35},
                    {name = "Chaud rose", cost = 1.25, colour = 135},
                    {name = "Pfsiter rose", cost = 1.25, colour = 137},
                    {name = "Saumon rose", cost = 1.25, colour = 136},
                    {name = "levé du jour Orange", cost = 1.25, colour = 36},
                    {name = "Orange", cost = 1.25, colour = 38},
                    {name = "Clair Orange", cost = 1.25, colour = 138},
                    {name = "or", cost = 1.25, colour = 99},
                    {name = "Bronze", cost = 1.25, colour = 90},
                    {name = "jaune", cost = 1.25, colour = 88},
                    {name = "Course jaune", cost = 1.25, colour = 89},
                    {name = "Rosée jaune", cost = 1.25, colour = 91},
                    {name = "foncé vert", cost = 1.25, colour = 49},
                    {name = "Course vert", cost = 1.25, colour = 50},
                    {name = "Mer vert", cost = 1.25, colour = 51},
                    {name = "Olive vert", cost = 1.25, colour = 52},
                    {name = "Clair vert", cost = 1.25, colour = 53},
                    {name = "Gasoline vert", cost = 1.25, colour = 54},
                    {name = "Citron vert", cost = 1.25, colour = 92},
                    {name = "Nuit bleu", cost = 1.25, colour = 141},
                    {name = "Galaxy bleu", cost = 1.25, colour = 61},
                    {name = "foncé bleu", cost = 1.25, colour = 62},
                    {name = "Saxon bleu", cost = 1.25, colour = 63},
                    {name = "bleu", cost = 1.25, colour = 64},
                    {name = "Marine bleu", cost = 1.25, colour = 65},
                    {name = "Port bleu", cost = 1.25, colour = 66},
                    {name = "Diamand bleu", cost = 1.25, colour = 67},
                    {name = "Surf bleu", cost = 1.25, colour = 68},
                    {name = "Nautical bleu", cost = 1.25, colour = 69},
                    {name = "Course bleu", cost = 1.25, colour = 73},
                    {name = "Ultra bleu", cost = 1.25, colour = 70},
                    {name = "clair bleu", cost = 1.25, colour = 74},
                    {name = "Chocolat marron", cost = 1.25, colour = 96},
                    {name = "Bison marron", cost = 1.25, colour = 101},
                    {name = "Creeen marron", cost = 1.25, colour = 95},
                    {name = "Feltzer marron", cost = 1.25, colour = 94},
                    {name = "Maple marron", cost = 1.25, colour = 97},
                    {name = "Bois marron", cost = 1.25, colour = 103},
                    {name = "Sienna marron", cost = 1.25, colour = 104},
                    {name = "Selle marron", cost = 1.25, colour = 98},
                    {name = "Mousse marron", cost = 1.25, colour = 100},
                    {name = "hêtre marron", cost = 1.25, colour = 102},
                    {name = "paille marron", cost = 1.25, colour = 99},
                    {name = "sablé marron", cost = 1.25, colour = 105},
                    {name = "Blanchie marron", cost = 1.25, colour = 106},
                    {name = "Schafter violet", cost = 1.25, colour = 71},
                    {name = "Spinnaker violet", cost = 1.25, colour = 72},
                    {name = "Nuit violet", cost = 1.25, colour = 142},
                    {name = "Clair violet", cost = 1.25, colour = 145},
                    {name = "crème", cost = 1.25, colour = 107},
                    {name = "glace blanc", cost = 1.25, colour = 111},
                    {name = "gel blanc", cost = 1.25, colour = 112}
                },
                ["Mat"] = {
                    {name = "noir", colour = 12, cost = 1.5},
                    {name = "Gris", colour = 13, cost = 1.5},
                    {name = "clair Gris", colour = 14, cost = 1.5},
                    {name = "glace blanc", colour = 131, cost = 1.5},
                    {name = "bleu", colour = 83, cost = 1.5},
                    {name = "foncé bleu", colour = 82, cost = 1.5},
                    {name = "Nuit bleu", colour = 84, cost = 1.5},
                    {name = "Nuit violet", colour = 149, cost = 1.5},
                    {name = "Schafter violet", colour = 148, cost = 1.5},
                    {name = "rouge", colour = 39, cost = 1.5},
                    {name = "foncé rouge", colour = 40, cost = 1.5},
                    {name = "Orange", colour = 41, cost = 1.5},
                    {name = "jaune", colour = 42, cost = 1.5},
                    {name = "Citron vert", colour = 55, cost = 1.5},
                    {name = "vert", colour = 128, cost = 1.5},
                    {name = "gel vert", colour = 151, cost = 1.5},
                    {name = "feuillage vert", colour = 155, cost = 1.5},
                    {name = "Olive Darb", colour = 152, cost = 1.5},
                    {name = "foncé terre", colour = 153, cost = 1.5},
                    {name = "Desert Bronze", colour = 154, cost = 1.5}
                },
                ["Métal"] = {
                    {name = "Brossé acier", colour = 117, cost = 1.75},
                    {name = "Brossé noir acier", colour = 118, cost = 1.75},
                    {name = "Brossé Aluminum", colour = 119, cost = 1.75},
                    {name = "Pure or", colour = 158, cost = 1.75},
                    {name = "Brossé or", colour = 159, cost = 1.75},
                    {name = "Chrome", colour = 120, cost = 1.75}
                }
            },
            ["Couleur secondaires"] = {
                ["Classique"] = {
                    {name = "noir", cost = 0.5, colour = 0},
                    {name = "Carbon noir", cost = 0.5, colour = 147},
                    {name = "Hraphite", cost = 0.5, colour = 1},
                    {name = "Anhracite noir", cost = 0.5, colour = 11},
                    {name = "noir acier", cost = 0.5, colour = 2},
                    {name = "foncé acier", cost = 0.5, colour = 3},
                    {name = "argent", cost = 0.5, colour = 4},
                    {name = "Bleuâtre argent", cost = 0.5, colour = 5},
                    {name = "Roulée acier", cost = 0.5, colour = 6},
                    {name = "Ombré argent", cost = 0.5, colour = 7},
                    {name = "Pierre argent", cost = 0.5, colour = 8},
                    {name = "Nuit argent", cost = 0.5, colour = 9},
                    {name = "Fonte argent", cost = 0.5, colour = 10},
                    {name = "rouge", cost = 0.5, colour = 27},
                    {name = "Torino rouge", cost = 0.5, colour = 28},
                    {name = "Formula rouge", cost = 0.5, colour = 29},
                    {name = "Lave rouge", cost = 0.5, colour = 150},
                    {name = "Flamber rouge", cost = 0.5, colour = 30},
                    {name = "Grace rouge", cost = 0.5, colour = 31},
                    {name = "Garnet rouge", cost = 0.5, colour = 32},
                    {name = "levé du jour rouge", cost = 0.5, colour = 33},
                    {name = "Cabernet rouge", cost = 0.5, colour = 34},
                    {name = "Vin rouge", cost = 0.5, colour = 143},
                    {name = "bonbon rouge", cost = 0.5, colour = 35},
                    {name = "chaud rose", cost = 0.5, colour = 135},
                    {name = "Pfsiter rose", cost = 0.5, colour = 137},
                    {name = "saumon rose", cost = 0.5, colour = 136},
                    {name = "levé du jour Orange", cost = 0.5, colour = 36},
                    {name = "Orange", cost = 0.5, colour = 38},
                    {name = "Clair Orange", cost = 0.5, colour = 138},
                    {name = "or", cost = 0.5, colour = 99},
                    {name = "Bronze", cost = 0.5, colour = 90},
                    {name = "jaune", cost = 0.5, colour = 88},
                    {name = "Course jaune", cost = 0.5, colour = 89},
                    {name = "Rosée jaune", cost = 0.5, colour = 91},
                    {name = "foncé vert", cost = 0.5, colour = 49},
                    {name = "Course vert", cost = 0.5, colour = 50},
                    {name = "Mer vert", cost = 0.5, colour = 51},
                    {name = "Olive vert", cost = 0.5, colour = 52},
                    {name = "Clair vert", cost = 0.5, colour = 53},
                    {name = "Gasoline vert", cost = 0.5, colour = 54},
                    {name = "Citron vert", cost = 0.5, colour = 92},
                    {name = "Nuit bleu", cost = 0.5, colour = 141},
                    {name = "Galaxy bleu", cost = 0.5, colour = 61},
                    {name = "foncé bleu", cost = 0.5, colour = 62},
                    {name = "Saxon bleu", cost = 0.5, colour = 63},
                    {name = "bleu", cost = 0.5, colour = 64},
                    {name = "Marine bleu", cost = 0.5, colour = 65},
                    {name = "Port bleu", cost = 0.5, colour = 66},
                    {name = "Diamand bleu", cost = 0.5, colour = 67},
                    {name = "Surf bleu", cost = 0.5, colour = 68},
                    {name = "Nautical bleu", cost = 0.5, colour = 69},
                    {name = "Course bleu", cost = 0.5, colour = 73},
                    {name = "Ultra bleu", cost = 0.5, colour = 70},
                    {name = "clair bleu", cost = 0.5, colour = 74},
                    {name = "Chocolat marron", cost = 0.5, colour = 96},
                    {name = "Bison marron", cost = 0.5, colour = 101},
                    {name = "Creeen marron", cost = 0.5, colour = 95},
                    {name = "Feltzer marron", cost = 0.5, colour = 94},
                    {name = "Maple marron", cost = 0.5, colour = 97},
                    {name = "Bois marron", cost = 0.5, colour = 103},
                    {name = "Sienna marron", cost = 0.5, colour = 104},
                    {name = "Selle marron", cost = 0.5, colour = 98},
                    {name = "Mousse marron", cost = 0.5, colour = 100},
                    {name = "hêtre marron", cost = 0.5, colour = 102},
                    {name = "Paille marron", cost = 0.5, colour = 99},
                    {name = "sablé marron", cost = 0.5, colour = 105},
                    {name = "Blanchie marron", cost = 0.5, colour = 106},
                    {name = "Schafter violet", cost = 0.5, colour = 71},
                    {name = "Spinnaker violet", cost = 0.5, colour = 72},
                    {name = "Nuit violet", cost = 0.5, colour = 142},
                    {name = "Clair violet", cost = 0.5, colour = 145},
                    {name = "crème", cost = 0.5, colour = 107},
                    {name = "glace blanc", cost = 0.5, colour = 111},
                    {name = "gel blanc", cost = 0.5, colour = 112}
                },
                ["Metallique"] = {
                    {name = "noir", cost = 0.625, colour = 0},
                    {name = "Carbon noir", cost = 0.625, colour = 147},
                    {name = "Hraphite", cost = 0.625, colour = 1},
                    {name = "Anhracite noir", cost = 0.625, colour = 11},
                    {name = "noir acier", cost = 0.625, colour = 2},
                    {name = "foncé acier", cost = 0.625, colour = 325},
                    {name = "argent", cost = 0.625, colour = 4},
                    {name = "Bleuâtre argent", cost = 0.625, colour = 5},
                    {name = "Laminé acier", cost = 0.625, colour = 6},
                    {name = "Ombré argent", cost = 0.625, colour = 7},
                    {name = "Pierre argent", cost = 0.625, colour = 8},
                    {name = "nuit argent", cost = 0.625, colour = 9},
                    {name = "Fonte argent", cost = 0.625, colour = 10},
                    {name = "rouge", cost = 0.625, colour = 27},
                    {name = "Torino rouge", cost = 0.625, colour = 28},
                    {name = "Formula rouge", cost = 0.625, colour = 29},
                    {name = "Lave rouge", cost = 0.625, colour = 150},
                    {name = "Flamber rouge", cost = 0.625, colour = 30},
                    {name = "Grenat rouge", cost = 0.625, colour = 31},
                    {name = "Grenat rouge", cost = 0.625, colour = 32},
                    {name = "Levé du jour rouge", cost = 0.625, colour = 33},
                    {name = "Cabernet rouge", cost = 0.625, colour = 34},
                    {name = "Vin rouge", cost = 0.625, colour = 143},
                    {name = "bonbon rouge", cost = 0.625, colour = 35},
                    {name = "chaud rose", cost = 0.625, colour = 135},
                    {name = "Pfsiter rose", cost = 0.625, colour = 137},
                    {name = "Saumon rose", cost = 0.625, colour = 136},
                    {name = "Levé du jour Orange", cost = 0.625, colour = 36},
                    {name = "Orange", cost = 0.625, colour = 38},
                    {name = "clair Orange", cost = 0.625, colour = 138},
                    {name = "or", cost = 0.625, colour = 99},
                    {name = "Bronze", cost = 0.625, colour = 90},
                    {name = "jaune", cost = 0.625, colour = 88},
                    {name = "Course jaune", cost = 0.625, colour = 89},
                    {name = "Rosée jaune", cost = 0.625, colour = 91},
                    {name = "foncé vert", cost = 0.625, colour = 49},
                    {name = "Course vert", cost = 0.625, colour = 50},
                    {name = "Mer vert", cost = 0.625, colour = 51},
                    {name = "Olive vert", cost = 0.625, colour = 52},
                    {name = "Clair vert", cost = 0.625, colour = 53},
                    {name = "Gasoline vert", cost = 0.625, colour = 54},
                    {name = "Citron vert", cost = 0.625, colour = 92},
                    {name = "Nuit bleu", cost = 0.625, colour = 141},
                    {name = "Galaxy bleu", cost = 0.625, colour = 61},
                    {name = "foncé bleu", cost = 0.625, colour = 62},
                    {name = "Saxon bleu", cost = 0.625, colour = 63},
                    {name = "bleu", cost = 0.625, colour = 64},
                    {name = "Marine bleu", cost = 0.625, colour = 65},
                    {name = "port bleu", cost = 0.625, colour = 66},
                    {name = "Diamand bleu", cost = 0.625, colour = 67},
                    {name = "Surf bleu", cost = 0.625, colour = 68},
                    {name = "Nautical bleu", cost = 0.625, colour = 69},
                    {name = "Course bleu", cost = 0.625, colour = 73},
                    {name = "Ultra bleu", cost = 0.625, colour = 70},
                    {name = "clair bleu", cost = 0.625, colour = 74},
                    {name = "Chocolat marron", cost = 0.625, colour = 96},
                    {name = "Bison marron", cost = 0.625, colour = 101},
                    {name = "Creeen marron", cost = 0.625, colour = 95},
                    {name = "Feltzer marron", cost = 0.625, colour = 94},
                    {name = "Maple marron", cost = 0.625, colour = 97},
                    {name = "Bois marron", cost = 0.625, colour = 103},
                    {name = "Selle marron", cost = 0.625, colour = 104},
                    {name = "Selle marron", cost = 0.625, colour = 98},
                    {name = "mousse marron", cost = 0.625, colour = 100},
                    {name = "Hêtre marron", cost = 0.625, colour = 102},
                    {name = "paille marron", cost = 0.625, colour = 99},
                    {name = "sablé marron", cost = 0.625, colour = 105},
                    {name = "Blanchie marron", cost = 0.625, colour = 106},
                    {name = "Schafter violet", cost = 0.625, colour = 71},
                    {name = "Spinnaker violet", cost = 0.625, colour = 72},
                    {name = "Nuit violet", cost = 0.625, colour = 142},
                    {name = "Clair violet", cost = 0.625, colour = 145},
                    {name = "Crème", cost = 0.625, colour = 107},
                    {name = "Glace blanc", cost = 0.625, colour = 111},
                    {name = "Gel blanc", cost = 0.625, colour = 112}
                },
                ["Mat"] = {
                    {name = "Noir", colour = 12, cost = 0.75},
                    {name = "Gris", colour = 13, cost = 0.75},
                    {name = "clair gris", colour = 14, cost = 0.75},
                    {name = "glace blanc", colour = 131, cost = 0.75},
                    {name = "bleu", colour = 83, cost = 0.75},
                    {name = "foncé bleu", colour = 82, cost = 0.75},
                    {name = "nuit bleu", colour = 84, cost = 0.75},
                    {name = "nuit violet", colour = 149, cost = 0.75},
                    {name = "Schafter violet", colour = 148, cost = 0.75},
                    {name = "rouge", colour = 39, cost = 0.75},
                    {name = "foncé rouge", colour = 40, cost = 0.75},
                    {name = "Orange", colour = 41, cost = 0.75},
                    {name = "jaune", colour = 42, cost = 0.75},
                    {name = "citron vert", colour = 55, cost = 0.75},
                    {name = "vert", colour = 128, cost = 0.75},
                    {name = "gel vert", colour = 151, cost = 0.75},
                    {name = "feuillage vert", colour = 155, cost = 0.75},
                    {name = "Olive Darb", colour = 152, cost = 0.75},
                    {name = "foncé terre", colour = 153, cost = 0.75},
                    {name = "Desert Bronze", colour = 154, cost = 0.75}
                },
                ["Métal"] = {
                    {name = "Brossé acier", colour = 117, cost = 0.875},
                    {name = "Brossé noir acier", colour = 118, cost = 0.875},
                    {name = "Brossé Aluminum", colour = 119, cost = 0.875},
                    {name = "Pure or", colour = 158, cost = 0.875},
                    {name = "Brossé or", colour = 159, cost = 0.875},
                    {name = "Chrome", colour = 120, cost = 0.875}
                }
            },
            ["Nacrage"] = {
                ["Classique"] = {
                    {name = "noir", cost = 0.5, colour = 0},
                    {name = "Carbon noir", cost = 0.5, colour = 147},
                    {name = "Hraphite", cost = 0.5, colour = 1},
                    {name = "Anhracite noir", cost = 0.5, colour = 11},
                    {name = "noir acier", cost = 0.5, colour = 2},
                    {name = "foncé acier", cost = 0.5, colour = 3},
                    {name = "argent", cost = 0.5, colour = 4},
                    {name = "Bleuâtre argent", cost = 0.5, colour = 5},
                    {name = "Roulée acier", cost = 0.5, colour = 6},
                    {name = "Ombré argent", cost = 0.5, colour = 7},
                    {name = "Pierre argent", cost = 0.5, colour = 8},
                    {name = "Nuit argent", cost = 0.5, colour = 9},
                    {name = "Fonte argent", cost = 0.5, colour = 10},
                    {name = "rouge", cost = 0.5, colour = 27},
                    {name = "Torino rouge", cost = 0.5, colour = 28},
                    {name = "Formula rouge", cost = 0.5, colour = 29},
                    {name = "Lave rouge", cost = 0.5, colour = 150},
                    {name = "Flamber rouge", cost = 0.5, colour = 30},
                    {name = "Grace rouge", cost = 0.5, colour = 31},
                    {name = "Garnet rouge", cost = 0.5, colour = 32},
                    {name = "levé du jour rouge", cost = 0.5, colour = 33},
                    {name = "Cabernet rouge", cost = 0.5, colour = 34},
                    {name = "Vin rouge", cost = 0.5, colour = 143},
                    {name = "bonbon rouge", cost = 0.5, colour = 35},
                    {name = "chaud rose", cost = 0.5, colour = 135},
                    {name = "Pfsiter rose", cost = 0.5, colour = 137},
                    {name = "saumon rose", cost = 0.5, colour = 136},
                    {name = "levé du jour Orange", cost = 0.5, colour = 36},
                    {name = "Orange", cost = 0.5, colour = 38},
                    {name = "Clair Orange", cost = 0.5, colour = 138},
                    {name = "or", cost = 0.5, colour = 99},
                    {name = "Bronze", cost = 0.5, colour = 90},
                    {name = "jaune", cost = 0.5, colour = 88},
                    {name = "Course jaune", cost = 0.5, colour = 89},
                    {name = "Rosée jaune", cost = 0.5, colour = 91},
                    {name = "foncé vert", cost = 0.5, colour = 49},
                    {name = "Course vert", cost = 0.5, colour = 50},
                    {name = "Mer vert", cost = 0.5, colour = 51},
                    {name = "Olive vert", cost = 0.5, colour = 52},
                    {name = "Clair vert", cost = 0.5, colour = 53},
                    {name = "Gasoline vert", cost = 0.5, colour = 54},
                    {name = "Citron vert", cost = 0.5, colour = 92},
                    {name = "Nuit bleu", cost = 0.5, colour = 141},
                    {name = "Galaxy bleu", cost = 0.5, colour = 61},
                    {name = "foncé bleu", cost = 0.5, colour = 62},
                    {name = "Saxon bleu", cost = 0.5, colour = 63},
                    {name = "bleu", cost = 0.5, colour = 64},
                    {name = "Marine bleu", cost = 0.5, colour = 65},
                    {name = "Port bleu", cost = 0.5, colour = 66},
                    {name = "Diamand bleu", cost = 0.5, colour = 67},
                    {name = "Surf bleu", cost = 0.5, colour = 68},
                    {name = "Nautical bleu", cost = 0.5, colour = 69},
                    {name = "Course bleu", cost = 0.5, colour = 73},
                    {name = "Ultra bleu", cost = 0.5, colour = 70},
                    {name = "clair bleu", cost = 0.5, colour = 74},
                    {name = "Chocolat marron", cost = 0.5, colour = 96},
                    {name = "Bison marron", cost = 0.5, colour = 101},
                    {name = "Creeen marron", cost = 0.5, colour = 95},
                    {name = "Feltzer marron", cost = 0.5, colour = 94},
                    {name = "Maple marron", cost = 0.5, colour = 97},
                    {name = "Bois marron", cost = 0.5, colour = 103},
                    {name = "Sienna marron", cost = 0.5, colour = 104},
                    {name = "Selle marron", cost = 0.5, colour = 98},
                    {name = "Mousse marron", cost = 0.5, colour = 100},
                    {name = "hêtre marron", cost = 0.5, colour = 102},
                    {name = "Paille marron", cost = 0.5, colour = 99},
                    {name = "sablé marron", cost = 0.5, colour = 105},
                    {name = "Blanchie marron", cost = 0.5, colour = 106},
                    {name = "Schafter violet", cost = 0.5, colour = 71},
                    {name = "Spinnaker violet", cost = 0.5, colour = 72},
                    {name = "Nuit violet", cost = 0.5, colour = 142},
                    {name = "Clair violet", cost = 0.5, colour = 145},
                    {name = "crème", cost = 0.5, colour = 107},
                    {name = "glace blanc", cost = 0.5, colour = 111},
                    {name = "gel blanc", cost = 0.5, colour = 112}
                },
                ["Metallique"] = {
                    {name = "noir", cost = 0.625, colour = 0},
                    {name = "Carbon noir", cost = 0.625, colour = 147},
                    {name = "Hraphite", cost = 0.625, colour = 1},
                    {name = "Anhracite noir", cost = 0.625, colour = 11},
                    {name = "noir acier", cost = 0.625, colour = 2},
                    {name = "foncé acier", cost = 0.625, colour = 325},
                    {name = "argent", cost = 0.625, colour = 4},
                    {name = "Bleuâtre argent", cost = 0.625, colour = 5},
                    {name = "Laminé acier", cost = 0.625, colour = 6},
                    {name = "Ombré argent", cost = 0.625, colour = 7},
                    {name = "Pierre argent", cost = 0.625, colour = 8},
                    {name = "nuit argent", cost = 0.625, colour = 9},
                    {name = "Fonte argent", cost = 0.625, colour = 10},
                    {name = "rouge", cost = 0.625, colour = 27},
                    {name = "Torino rouge", cost = 0.625, colour = 28},
                    {name = "Formula rouge", cost = 0.625, colour = 29},
                    {name = "Lave rouge", cost = 0.625, colour = 150},
                    {name = "Flamber rouge", cost = 0.625, colour = 30},
                    {name = "Grenat rouge", cost = 0.625, colour = 31},
                    {name = "Grenat rouge", cost = 0.625, colour = 32},
                    {name = "Levé du jour rouge", cost = 0.625, colour = 33},
                    {name = "Cabernet rouge", cost = 0.625, colour = 34},
                    {name = "Vin rouge", cost = 0.625, colour = 143},
                    {name = "bonbon rouge", cost = 0.625, colour = 35},
                    {name = "chaud rose", cost = 0.625, colour = 135},
                    {name = "Pfsiter rose", cost = 0.625, colour = 137},
                    {name = "Saumon rose", cost = 0.625, colour = 136},
                    {name = "Levé du jour Orange", cost = 0.625, colour = 36},
                    {name = "Orange", cost = 0.625, colour = 38},
                    {name = "clair Orange", cost = 0.625, colour = 138},
                    {name = "or", cost = 0.625, colour = 99},
                    {name = "Bronze", cost = 0.625, colour = 90},
                    {name = "jaune", cost = 0.625, colour = 88},
                    {name = "Course jaune", cost = 0.625, colour = 89},
                    {name = "Rosée jaune", cost = 0.625, colour = 91},
                    {name = "foncé vert", cost = 0.625, colour = 49},
                    {name = "Course vert", cost = 0.625, colour = 50},
                    {name = "Mer vert", cost = 0.625, colour = 51},
                    {name = "Olive vert", cost = 0.625, colour = 52},
                    {name = "Clair vert", cost = 0.625, colour = 53},
                    {name = "Gasoline vert", cost = 0.625, colour = 54},
                    {name = "Citron vert", cost = 0.625, colour = 92},
                    {name = "Nuit bleu", cost = 0.625, colour = 141},
                    {name = "Galaxy bleu", cost = 0.625, colour = 61},
                    {name = "foncé bleu", cost = 0.625, colour = 62},
                    {name = "Saxon bleu", cost = 0.625, colour = 63},
                    {name = "bleu", cost = 0.625, colour = 64},
                    {name = "Marine bleu", cost = 0.625, colour = 65},
                    {name = "port bleu", cost = 0.625, colour = 66},
                    {name = "Diamand bleu", cost = 0.625, colour = 67},
                    {name = "Surf bleu", cost = 0.625, colour = 68},
                    {name = "Nautical bleu", cost = 0.625, colour = 69},
                    {name = "Course bleu", cost = 0.625, colour = 73},
                    {name = "Ultra bleu", cost = 0.625, colour = 70},
                    {name = "clair bleu", cost = 0.625, colour = 74},
                    {name = "Chocolat marron", cost = 0.625, colour = 96},
                    {name = "Bison marron", cost = 0.625, colour = 101},
                    {name = "Creeen marron", cost = 0.625, colour = 95},
                    {name = "Feltzer marron", cost = 0.625, colour = 94},
                    {name = "Maple marron", cost = 0.625, colour = 97},
                    {name = "Bois marron", cost = 0.625, colour = 103},
                    {name = "Selle marron", cost = 0.625, colour = 104},
                    {name = "Selle marron", cost = 0.625, colour = 98},
                    {name = "mousse marron", cost = 0.625, colour = 100},
                    {name = "Hêtre marron", cost = 0.625, colour = 102},
                    {name = "paille marron", cost = 0.625, colour = 99},
                    {name = "sablé marron", cost = 0.625, colour = 105},
                    {name = "Blanchie marron", cost = 0.625, colour = 106},
                    {name = "Schafter violet", cost = 0.625, colour = 71},
                    {name = "Spinnaker violet", cost = 0.625, colour = 72},
                    {name = "Nuit violet", cost = 0.625, colour = 142},
                    {name = "Clair violet", cost = 0.625, colour = 145},
                    {name = "Crème", cost = 0.625, colour = 107},
                    {name = "Glace blanc", cost = 0.625, colour = 111},
                    {name = "Gel blanc", cost = 0.625, colour = 112}
                },
                ["Mat"] = {
                    {name = "Noir", colour = 12, cost = 0.75},
                    {name = "Gris", colour = 13, cost = 0.75},
                    {name = "clair gris", colour = 14, cost = 0.75},
                    {name = "glace blanc", colour = 131, cost = 0.75},
                    {name = "bleu", colour = 83, cost = 0.75},
                    {name = "foncé bleu", colour = 82, cost = 0.75},
                    {name = "nuit bleu", colour = 84, cost = 0.75},
                    {name = "nuit violet", colour = 149, cost = 0.75},
                    {name = "Schafter violet", colour = 148, cost = 0.75},
                    {name = "rouge", colour = 39, cost = 0.75},
                    {name = "foncé rouge", colour = 40, cost = 0.75},
                    {name = "Orange", colour = 41, cost = 0.75},
                    {name = "jaune", colour = 42, cost = 0.75},
                    {name = "citron vert", colour = 55, cost = 0.75},
                    {name = "vert", colour = 128, cost = 0.75},
                    {name = "gel vert", colour = 151, cost = 0.75},
                    {name = "feuillage vert", colour = 155, cost = 0.75},
                    {name = "Olive Darb", colour = 152, cost = 0.75},
                    {name = "foncé terre", colour = 153, cost = 0.75},
                    {name = "Desert Bronze", colour = 154, cost = 0.75}
                },
                ["Métal"] = {
                    {name = "Brossé acier", colour = 117, cost = 0.875},
                    {name = "Brossé noir acier", colour = 118, cost = 0.875},
                    {name = "Brossé Aluminum", colour = 119, cost = 0.875},
                    {name = "Pure or", colour = 158, cost = 0.875},
                    {name = "Brossé or", colour = 159, cost = 0.875},
                    {name = "Chrome", colour = 120, cost = 0.875}
                }
            }
        }
    },
    {
        title = "Turbo",
        data = {
            {name = "None", bool = "false", mt = 18, cost = 0},
            {name = "Turbo Tuning", bool = "true", mt = 18, cost = 9}
        }
    },
    {
        title = "Jantes",
        data = {
            ["Type de jantes"] = {
                ["Sport"] = {
                    {name = "Stock", wtype = false, mt = 23, mod = -1, cost = 5.25},
                    {name = "Inferno", wtype = false, mt = 23, mod = 0, cost = 5.25},
                    {name = "Deepfive", wtype = false, mt = 23, mod = 1, cost = 5.60},
                    {name = "Lozspeed", wtype = false, mt = 23, mod = 2, cost = 5.60},
                    {name = "Diamondcut", wtype = false, mt = 23, mod = 3, cost = 6},
                    {name = "Chrono", wtype = false, mt = 23, mod = 4, cost = 6},
                    {name = "Feroccirr", wtype = false, mt = 23, mod = 5, cost = 5.0},
                    {name = "Fiftynine", wtype = false, mt = 23, mod = 6, cost = 5.0},
                    {name = "Mercie", wtype = false, mt = 23, mod = 7, cost = 3.75},
                    {name = "Syntheticz", wtype = false, mt = 23, mod = 8, cost = 4.0},
                    {name = "Organictyped", wtype = false, mt = 23, mod = 9, cost = 6.5},
                    {name = "Endov1", wtype = false, mt = 23, mod = 10, cost = 4.5},
                    {name = "Duper7", wtype = false, mt = 23, mod = 11, cost = 4.0},
                    {name = "Uzer", wtype = false, mt = 23, mod = 12, cost = 6},
                    {name = "Groundride", wtype = false, mt = 23, mod = 13, cost = 4.5},
                    {name = "Spacer", wtype = false, mt = 23, mod = 14, cost = 6.25},
                    {name = "Venum", wtype = false, mt = 23, mod = 15, cost = 3.80},
                    {name = "Cosmo", wtype = false, mt = 23, mod = 16, cost = 3},
                    {name = "Dashvip", wtype = false, mt = 23, mod = 17, cost = 5.0},
                    {name = "Icekid", wtype = false, mt = 23, mod = 18, cost = 5.0},
                    {name = "Ruffeld", wtype = false, mt = 23, mod = 19, cost = 5.0},
                    {name = "Wangenmaster", wtype = false, mt = 23, mod = 20, cost = 5.0},
                    {name = "Superfive", wtype = false, mt = 23, mod = 21, cost = 5.0},
                    {name = "Endov2", wtype = false, mt = 23, mod = 22, cost = 5.0},
                    {name = "Slitsix", wtype = false, mt = 23, mod = 23, cost = 5.0}
                },
                ["Street"] = {
                    {name = "1", wtype = 11, mt = 23, mod = 1, cost = 5.25},
                    {name = "2", wtype = 11, mt = 23, mod = 2, cost = 5.25},
                    {name = "3", wtype = 11, mt = 23, mod = 3, cost = 5.25},
                    {name = "4", wtype = 11, mt = 23, mod = 4, cost = 5.25},
                    {name = "5", wtype = 11, mt = 23, mod = 5, cost = 5.25},
                    {name = "6", wtype = 11, mt = 23, mod = 6, cost = 5.25},
                    {name = "7", wtype = 11, mt = 23, mod = 7, cost = 5.25},
                    {name = "8", wtype = 11, mt = 23, mod = 8, cost = 5.25},
                    {name = "9", wtype = 11, mt = 23, mod = 9, cost = 5.25},
                    {name = "10", wtype = 11, mt = 23, mod = 10, cost = 5.25},
                    {name = "11", wtype = 11, mt = 23, mod = 11, cost = 5.25},
                    {name = "12", wtype = 11, mt = 23, mod = 12, cost = 5.25},
                    {name = "13", wtype = 11, mt = 23, mod = 13, cost = 5.25},
                    {name = "14", wtype = 11, mt = 23, mod = 14, cost = 5.25},
                    {name = "15", wtype = 11, mt = 23, mod = 15, cost = 5.25},
                    {name = "16", wtype = 11, mt = 23, mod = 16, cost = 5.25},
                    {name = "17", wtype = 11, mt = 23, mod = 17, cost = 5.25},
                    {name = "18", wtype = 11, mt = 23, mod = 18, cost = 5.25},
                    {name = "19", wtype = 11, mt = 23, mod = 19, cost = 5.25},
                    {name = "20", wtype = 11, mt = 23, mod = 20, cost = 5.25},
                    {name = "21", wtype = 11, mt = 23, mod = 21, cost = 5.25},
                    {name = "22", wtype = 11, mt = 23, mod = 22, cost = 5.25},
                    {name = "23", wtype = 11, mt = 23, mod = 23, cost = 5.25},
                    {name = "24", wtype = 11, mt = 23, mod = 24, cost = 5.25},
                    {name = "25", wtype = 11, mt = 23, mod = 25, cost = 5.25},
                    {name = "26", wtype = 11, mt = 23, mod = 26, cost = 5.25},
                    {name = "27", wtype = 11, mt = 23, mod = 27, cost = 5.25},
                    {name = "28", wtype = 11, mt = 23, mod = 28, cost = 5.25},
                    {name = "29", wtype = 11, mt = 23, mod = 29, cost = 5.25},
                    {name = "30", wtype = 11, mt = 23, mod = 30, cost = 5.25},
                    {name = "31", wtype = 11, mt = 23, mod = 31, cost = 5.25},
                    {name = "32", wtype = 11, mt = 23, mod = 32, cost = 5.25},
                    {name = "33", wtype = 11, mt = 23, mod = 33, cost = 5.25},
                    {name = "34", wtype = 11, mt = 23, mod = 34, cost = 5.25},
                    {name = "35", wtype = 11, mt = 23, mod = 35, cost = 5.25},
                    {name = "36", wtype = 11, mt = 23, mod = 36, cost = 5.25},
                    {name = "37", wtype = 11, mt = 23, mod = 37, cost = 5.25},
                    {name = "38", wtype = 11, mt = 23, mod = 38, cost = 5.25},
                    {name = "39", wtype = 11, mt = 23, mod = 39, cost = 5.25},
                    {name = "40", wtype = 11, mt = 23, mod = 40, cost = 5.25},
                    {name = "41", wtype = 11, mt = 23, mod = 41, cost = 5.25},
                    {name = "42", wtype = 11, mt = 23, mod = 42, cost = 5.25},
                    {name = "43", wtype = 11, mt = 23, mod = 43, cost = 5.25},
                    {name = "44", wtype = 11, mt = 23, mod = 44, cost = 5.25},
                    {name = "45", wtype = 11, mt = 23, mod = 45, cost = 5.25},
                    {name = "46", wtype = 11, mt = 23, mod = 46, cost = 5.25},
                    {name = "47", wtype = 11, mt = 23, mod = 47, cost = 5.25},
                    {name = "48", wtype = 11, mt = 23, mod = 48, cost = 5.25},
                    {name = "49", wtype = 11, mt = 23, mod = 49, cost = 5.25},
                    {name = "50", wtype = 11, mt = 23, mod = 50, cost = 5.25},
                    {name = "51", wtype = 11, mt = 23, mod = 51, cost = 5.25},
                    {name = "52", wtype = 11, mt = 23, mod = 52, cost = 5.25},
                    {name = "53", wtype = 11, mt = 23, mod = 53, cost = 5.25},
                    {name = "54", wtype = 11, mt = 23, mod = 54, cost = 5.25},
                    {name = "55", wtype = 11, mt = 23, mod = 55, cost = 5.25},
                    {name = "56", wtype = 11, mt = 23, mod = 56, cost = 5.25},
                    {name = "57", wtype = 11, mt = 23, mod = 57, cost = 5.25},
                    {name = "58", wtype = 11, mt = 23, mod = 58, cost = 5.25},
                    {name = "59", wtype = 11, mt = 23, mod = 59, cost = 5.25},
                    {name = "60", wtype = 11, mt = 23, mod = 60, cost = 5.25},
                    {name = "61", wtype = 11, mt = 23, mod = 61, cost = 5.25},
                    {name = "62", wtype = 11, mt = 23, mod = 62, cost = 5.25},
                    {name = "63", wtype = 11, mt = 23, mod = 63, cost = 5.25},
                    {name = "64", wtype = 11, mt = 23, mod = 64, cost = 5.25},
                    {name = "65", wtype = 11, mt = 23, mod = 65, cost = 5.25},
                    {name = "66", wtype = 11, mt = 23, mod = 66, cost = 5.25},
                    {name = "67", wtype = 11, mt = 23, mod = 67, cost = 5.25},
                    {name = "68", wtype = 11, mt = 23, mod = 68, cost = 5.25},
                    {name = "69", wtype = 11, mt = 23, mod = 69, cost = 5.25},
                    {name = "70", wtype = 11, mt = 23, mod = 70, cost = 5.25},
                    {name = "71", wtype = 11, mt = 23, mod = 71, cost = 5.25},
                    {name = "72", wtype = 11, mt = 23, mod = 72, cost = 5.25},
                    {name = "73", wtype = 11, mt = 23, mod = 73, cost = 5.25},
                    {name = "74", wtype = 11, mt = 23, mod = 74, cost = 5.25},
                    {name = "75", wtype = 11, mt = 23, mod = 75, cost = 5.25},
                    {name = "76", wtype = 11, mt = 23, mod = 76, cost = 5.25},
                    {name = "77", wtype = 11, mt = 23, mod = 77, cost = 5.25},
                    {name = "78", wtype = 11, mt = 23, mod = 78, cost = 5.25},
                    {name = "79", wtype = 11, mt = 23, mod = 79, cost = 5.25},
                    {name = "80", wtype = 11, mt = 23, mod = 80, cost = 5.25},
                    {name = "81", wtype = 11, mt = 23, mod = 81, cost = 5.25},
                    {name = "82", wtype = 11, mt = 23, mod = 82, cost = 5.25},
                    {name = "83", wtype = 11, mt = 23, mod = 83, cost = 5.25},
                    {name = "84", wtype = 11, mt = 23, mod = 84, cost = 5.25},
                    {name = "85", wtype = 11, mt = 23, mod = 85, cost = 5.25},
                    {name = "86", wtype = 11, mt = 23, mod = 86, cost = 5.25},
                    {name = "87", wtype = 11, mt = 23, mod = 87, cost = 5.25},
                    {name = "88", wtype = 11, mt = 23, mod = 88, cost = 5.25},
                    {name = "89", wtype = 11, mt = 23, mod = 89, cost = 5.25},
                    {name = "90", wtype = 11, mt = 23, mod = 90, cost = 5.25},
                    {name = "91", wtype = 11, mt = 23, mod = 91, cost = 5.25},
                    {name = "92", wtype = 11, mt = 23, mod = 92, cost = 5.25},
                    {name = "93", wtype = 11, mt = 23, mod = 93, cost = 5.25},
                    {name = "94", wtype = 11, mt = 23, mod = 94, cost = 5.25},
                    {name = "95", wtype = 11, mt = 23, mod = 95, cost = 5.25},
                    {name = "96", wtype = 11, mt = 23, mod = 96, cost = 5.25},
                    {name = "97", wtype = 11, mt = 23, mod = 97, cost = 5.25},
                    {name = "98", wtype = 11, mt = 23, mod = 98, cost = 5.25},
                    {name = "99", wtype = 11, mt = 23, mod = 99, cost = 5.25},
                    {name = "100", wtype = 11, mt = 23, mod = 100, cost = 5.25},
                    {name = "101", wtype = 11, mt = 23, mod = 101, cost = 5.25},
                    {name = "102", wtype = 11, mt = 23, mod = 101, cost = 5.25},
                    {name = "103", wtype = 11, mt = 23, mod = 103, cost = 5.25},
                    {name = "104", wtype = 11, mt = 23, mod = 104, cost = 5.25},
                    {name = "105", wtype = 11, mt = 23, mod = 105, cost = 5.25},
                    {name = "106", wtype = 11, mt = 23, mod = 106, cost = 5.25},
                    {name = "107", wtype = 11, mt = 23, mod = 107, cost = 5.25},
                    {name = "108", wtype = 11, mt = 23, mod = 108, cost = 5.25},
                    {name = "109", wtype = 11, mt = 23, mod = 109, cost = 5.25},
                    {name = "110", wtype = 11, mt = 23, mod = 110, cost = 5.25},
                    {name = "111", wtype = 11, mt = 23, mod = 111, cost = 5.25},
                    {name = "112", wtype = 11, mt = 23, mod = 112, cost = 5.25},
                    {name = "113", wtype = 11, mt = 23, mod = 113, cost = 5.25},
                    {name = "114", wtype = 11, mt = 23, mod = 114, cost = 5.25},
                    {name = "115", wtype = 11, mt = 23, mod = 115, cost = 5.25},
                    {name = "116", wtype = 11, mt = 23, mod = 116, cost = 5.25},
                    {name = "117", wtype = 11, mt = 23, mod = 117, cost = 5.25},
                    {name = "118", wtype = 11, mt = 23, mod = 118, cost = 5.25},
                    {name = "119", wtype = 11, mt = 23, mod = 119, cost = 5.25},
                    {name = "120", wtype = 11, mt = 23, mod = 120, cost = 5.25},
                    {name = "121", wtype = 11, mt = 23, mod = 121, cost = 5.25},
                    {name = "122", wtype = 11, mt = 23, mod = 122, cost = 5.25},
                    {name = "123", wtype = 11, mt = 23, mod = 123, cost = 5.25},
                    {name = "124", wtype = 11, mt = 23, mod = 124, cost = 5.25},
                    {name = "125", wtype = 11, mt = 23, mod = 125, cost = 5.25},
                    {name = "126", wtype = 11, mt = 23, mod = 126, cost = 5.25},
                    {name = "127", wtype = 11, mt = 23, mod = 127, cost = 5.25},
                    {name = "128", wtype = 11, mt = 23, mod = 128, cost = 5.25},
                    {name = "129", wtype = 11, mt = 23, mod = 129, cost = 5.25},
                    {name = "130", wtype = 11, mt = 23, mod = 130, cost = 5.25},
                    {name = "131", wtype = 11, mt = 23, mod = 131, cost = 5.25},
                    {name = "132", wtype = 11, mt = 23, mod = 132, cost = 5.25},
                    {name = "133", wtype = 11, mt = 23, mod = 133, cost = 5.25},
                    {name = "134", wtype = 11, mt = 23, mod = 134, cost = 5.25},
                    {name = "135", wtype = 11, mt = 23, mod = 135, cost = 5.25},
                    {name = "136", wtype = 11, mt = 23, mod = 136, cost = 5.25},
                    {name = "137", wtype = 11, mt = 23, mod = 137, cost = 5.25},
                    {name = "138", wtype = 11, mt = 23, mod = 138, cost = 5.25},
                    {name = "139", wtype = 11, mt = 23, mod = 139, cost = 5.25},
                    {name = "140", wtype = 11, mt = 23, mod = 140, cost = 5.25},
                    {name = "141", wtype = 11, mt = 23, mod = 141, cost = 5.25},
                    {name = "142", wtype = 11, mt = 23, mod = 142, cost = 5.25},
                    {name = "143", wtype = 11, mt = 23, mod = 143, cost = 5.25},
                    {name = "144", wtype = 11, mt = 23, mod = 144, cost = 5.25},
                    {name = "145", wtype = 11, mt = 23, mod = 145, cost = 5.25},
                    {name = "146", wtype = 11, mt = 23, mod = 146, cost = 5.25},
                    {name = "147", wtype = 11, mt = 23, mod = 147, cost = 5.25},
                    {name = "148", wtype = 11, mt = 23, mod = 148, cost = 5.25},
                    {name = "149", wtype = 11, mt = 23, mod = 149, cost = 5.25},
                    {name = "150", wtype = 11, mt = 23, mod = 150, cost = 5.25},
                    {name = "151", wtype = 11, mt = 23, mod = 151, cost = 5.25},
                    {name = "152", wtype = 11, mt = 23, mod = 152, cost = 5.25},
                    {name = "153", wtype = 11, mt = 23, mod = 153, cost = 5.25},
                    {name = "154", wtype = 11, mt = 23, mod = 154, cost = 5.25},
                    {name = "155", wtype = 11, mt = 23, mod = 155, cost = 5.25},
                    {name = "156", wtype = 11, mt = 23, mod = 156, cost = 5.25},
                    {name = "157", wtype = 11, mt = 23, mod = 157, cost = 5.25},
                    {name = "158", wtype = 11, mt = 23, mod = 158, cost = 5.25},
                    {name = "159", wtype = 11, mt = 23, mod = 159, cost = 5.25},
                    {name = "160", wtype = 11, mt = 23, mod = 160, cost = 5.25},
                    {name = "161", wtype = 11, mt = 23, mod = 161, cost = 5.25},
                    {name = "162", wtype = 11, mt = 23, mod = 162, cost = 5.25},
                    {name = "163", wtype = 11, mt = 23, mod = 163, cost = 5.25},
                    {name = "164", wtype = 11, mt = 23, mod = 164, cost = 5.25},
                    {name = "165", wtype = 11, mt = 23, mod = 165, cost = 5.25},
                    {name = "166", wtype = 11, mt = 23, mod = 166, cost = 5.25},
                    {name = "167", wtype = 11, mt = 23, mod = 167, cost = 5.25},
                    {name = "168", wtype = 11, mt = 23, mod = 168, cost = 5.25},
                    {name = "169", wtype = 11, mt = 23, mod = 169, cost = 5.25},
                    {name = "170", wtype = 11, mt = 23, mod = 170, cost = 5.25},
                    {name = "171", wtype = 11, mt = 23, mod = 171, cost = 5.25},
                    {name = "172", wtype = 11, mt = 23, mod = 172, cost = 5.25},
                    {name = "173", wtype = 11, mt = 23, mod = 173, cost = 5.25},
                    {name = "174", wtype = 11, mt = 23, mod = 174, cost = 5.25},
                    {name = "175", wtype = 11, mt = 23, mod = 175, cost = 5.25},
                    {name = "176", wtype = 11, mt = 23, mod = 176, cost = 5.25},
                    {name = "177", wtype = 11, mt = 23, mod = 177, cost = 5.25},
                    {name = "178", wtype = 11, mt = 23, mod = 178, cost = 5.25},
                    {name = "179", wtype = 11, mt = 23, mod = 179, cost = 5.25},
                    {name = "180", wtype = 11, mt = 23, mod = 180, cost = 5.25},
                    {name = "181", wtype = 11, mt = 23, mod = 181, cost = 5.25},
                    {name = "182", wtype = 11, mt = 23, mod = 182, cost = 5.25},
                    {name = "183", wtype = 11, mt = 23, mod = 183, cost = 5.25},
                    {name = "184", wtype = 11, mt = 23, mod = 184, cost = 5.25},
                    {name = "185", wtype = 11, mt = 23, mod = 185, cost = 5.25},
                    {name = "186", wtype = 11, mt = 23, mod = 186, cost = 5.25},
                    {name = "187", wtype = 11, mt = 23, mod = 187, cost = 5.25},
                    {name = "188", wtype = 11, mt = 23, mod = 188, cost = 5.25},
                    {name = "189", wtype = 11, mt = 23, mod = 189, cost = 5.25},
                    {name = "190", wtype = 11, mt = 23, mod = 190, cost = 5.25},
                    {name = "191", wtype = 11, mt = 23, mod = 191, cost = 5.25},
                    {name = "192", wtype = 11, mt = 23, mod = 192, cost = 5.25},
                    {name = "193", wtype = 11, mt = 23, mod = 193, cost = 5.25},
                    {name = "194", wtype = 11, mt = 23, mod = 194, cost = 5.25},
                    {name = "195", wtype = 11, mt = 23, mod = 195, cost = 5.25},
                    {name = "196", wtype = 11, mt = 23, mod = 196, cost = 5.25},
                    {name = "197", wtype = 11, mt = 23, mod = 197, cost = 5.25},
                    {name = "198", wtype = 11, mt = 23, mod = 198, cost = 5.25},
                    {name = "199", wtype = 11, mt = 23, mod = 199, cost = 5.25},
                    {name = "200", wtype = 11, mt = 23, mod = 200, cost = 5.25},
                    {name = "201", wtype = 11, mt = 23, mod = 201, cost = 5.25},
                    {name = "202", wtype = 11, mt = 23, mod = 202, cost = 5.25},
                    {name = "203", wtype = 11, mt = 23, mod = 203, cost = 5.25},
                    {name = "204", wtype = 11, mt = 23, mod = 204, cost = 5.25},
                    {name = "205", wtype = 11, mt = 23, mod = 205, cost = 5.25},
                    {name = "206", wtype = 11, mt = 23, mod = 206, cost = 5.25},
                    {name = "207", wtype = 11, mt = 23, mod = 207, cost = 5.25},
                    {name = "208", wtype = 11, mt = 23, mod = 208, cost = 5.25},
                    {name = "209", wtype = 11, mt = 23, mod = 209, cost = 5.25},
                    {name = "210", wtype = 11, mt = 23, mod = 0, cost = 5.25}
                },
                ["Benny's 1"] = {
                    {name = "1", wtype = 8, mt = 23, mod = 1, cost = 5.25},
                    {name = "2", wtype = 8, mt = 23, mod = 2, cost = 5.25},
                    {name = "3", wtype = 8, mt = 23, mod = 3, cost = 5.25},
                    {name = "4", wtype = 8, mt = 23, mod = 4, cost = 5.25},
                    {name = "5", wtype = 8, mt = 23, mod = 5, cost = 5.25},
                    {name = "6", wtype = 8, mt = 23, mod = 6, cost = 5.25},
                    {name = "7", wtype = 8, mt = 23, mod = 7, cost = 5.25},
                    {name = "8", wtype = 8, mt = 23, mod = 8, cost = 5.25},
                    {name = "9", wtype = 8, mt = 23, mod = 9, cost = 5.25},
                    {name = "10", wtype = 8, mt = 23, mod = 10, cost = 5.25},
                    {name = "11", wtype = 8, mt = 23, mod = 11, cost = 5.25},
                    {name = "12", wtype = 8, mt = 23, mod = 12, cost = 5.25},
                    {name = "13", wtype = 8, mt = 23, mod = 13, cost = 5.25},
                    {name = "14", wtype = 8, mt = 23, mod = 14, cost = 5.25},
                    {name = "15", wtype = 8, mt = 23, mod = 15, cost = 5.25},
                    {name = "16", wtype = 8, mt = 23, mod = 16, cost = 5.25},
                    {name = "17", wtype = 8, mt = 23, mod = 17, cost = 5.25},
                    {name = "18", wtype = 8, mt = 23, mod = 18, cost = 5.25},
                    {name = "19", wtype = 8, mt = 23, mod = 19, cost = 5.25},
                    {name = "20", wtype = 8, mt = 23, mod = 20, cost = 5.25},
                    {name = "21", wtype = 8, mt = 23, mod = 21, cost = 5.25},
                    {name = "22", wtype = 8, mt = 23, mod = 22, cost = 5.25},
                    {name = "23", wtype = 8, mt = 23, mod = 23, cost = 5.25},
                    {name = "24", wtype = 8, mt = 23, mod = 24, cost = 5.25},
                    {name = "25", wtype = 8, mt = 23, mod = 25, cost = 5.25},
                    {name = "26", wtype = 8, mt = 23, mod = 26, cost = 5.25},
                    {name = "27", wtype = 8, mt = 23, mod = 27, cost = 5.25},
                    {name = "28", wtype = 8, mt = 23, mod = 28, cost = 5.25},
                    {name = "29", wtype = 8, mt = 23, mod = 29, cost = 5.25},
                    {name = "30", wtype = 8, mt = 23, mod = 30, cost = 5.25},
                    {name = "31", wtype = 8, mt = 23, mod = 31, cost = 5.25},
                    {name = "32", wtype = 8, mt = 23, mod = 32, cost = 5.25},
                    {name = "33", wtype = 8, mt = 23, mod = 33, cost = 5.25},
                    {name = "34", wtype = 8, mt = 23, mod = 34, cost = 5.25},
                    {name = "35", wtype = 8, mt = 23, mod = 35, cost = 5.25},
                    {name = "36", wtype = 8, mt = 23, mod = 36, cost = 5.25},
                    {name = "37", wtype = 8, mt = 23, mod = 37, cost = 5.25},
                    {name = "38", wtype = 8, mt = 23, mod = 38, cost = 5.25},
                    {name = "39", wtype = 8, mt = 23, mod = 39, cost = 5.25},
                    {name = "40", wtype = 8, mt = 23, mod = 40, cost = 5.25},
                    {name = "41", wtype = 8, mt = 23, mod = 41, cost = 5.25},
                    {name = "42", wtype = 8, mt = 23, mod = 42, cost = 5.25},
                    {name = "43", wtype = 8, mt = 23, mod = 43, cost = 5.25},
                    {name = "44", wtype = 8, mt = 23, mod = 44, cost = 5.25},
                    {name = "45", wtype = 8, mt = 23, mod = 45, cost = 5.25},
                    {name = "46", wtype = 8, mt = 23, mod = 46, cost = 5.25},
                    {name = "47", wtype = 8, mt = 23, mod = 47, cost = 5.25},
                    {name = "48", wtype = 8, mt = 23, mod = 48, cost = 5.25},
                    {name = "49", wtype = 8, mt = 23, mod = 49, cost = 5.25},
                    {name = "50", wtype = 8, mt = 23, mod = 50, cost = 5.25},
                    {name = "51", wtype = 8, mt = 23, mod = 51, cost = 5.25},
                    {name = "52", wtype = 8, mt = 23, mod = 52, cost = 5.25},
                    {name = "53", wtype = 8, mt = 23, mod = 53, cost = 5.25},
                    {name = "54", wtype = 8, mt = 23, mod = 54, cost = 5.25},
                    {name = "55", wtype = 8, mt = 23, mod = 55, cost = 5.25},
                    {name = "56", wtype = 8, mt = 23, mod = 56, cost = 5.25},
                    {name = "57", wtype = 8, mt = 23, mod = 57, cost = 5.25},
                    {name = "58", wtype = 8, mt = 23, mod = 58, cost = 5.25},
                    {name = "59", wtype = 8, mt = 23, mod = 59, cost = 5.25},
                    {name = "60", wtype = 8, mt = 23, mod = 60, cost = 5.25},
                    {name = "61", wtype = 8, mt = 23, mod = 61, cost = 5.25},
                    {name = "62", wtype = 8, mt = 23, mod = 62, cost = 5.25},
                    {name = "63", wtype = 8, mt = 23, mod = 63, cost = 5.25},
                    {name = "64", wtype = 8, mt = 23, mod = 64, cost = 5.25},
                    {name = "65", wtype = 8, mt = 23, mod = 65, cost = 5.25},
                    {name = "66", wtype = 8, mt = 23, mod = 66, cost = 5.25},
                    {name = "67", wtype = 8, mt = 23, mod = 67, cost = 5.25},
                    {name = "68", wtype = 8, mt = 23, mod = 68, cost = 5.25},
                    {name = "69", wtype = 8, mt = 23, mod = 69, cost = 5.25},
                    {name = "70", wtype = 8, mt = 23, mod = 70, cost = 5.25},
                    {name = "71", wtype = 8, mt = 23, mod = 71, cost = 5.25},
                    {name = "72", wtype = 8, mt = 23, mod = 72, cost = 5.25},
                    {name = "73", wtype = 8, mt = 23, mod = 73, cost = 5.25},
                    {name = "74", wtype = 8, mt = 23, mod = 74, cost = 5.25},
                    {name = "75", wtype = 8, mt = 23, mod = 75, cost = 5.25},
                    {name = "76", wtype = 8, mt = 23, mod = 76, cost = 5.25},
                    {name = "77", wtype = 8, mt = 23, mod = 77, cost = 5.25},
                    {name = "78", wtype = 8, mt = 23, mod = 78, cost = 5.25},
                    {name = "79", wtype = 8, mt = 23, mod = 79, cost = 5.25},
                    {name = "80", wtype = 8, mt = 23, mod = 80, cost = 5.25},
                    {name = "81", wtype = 8, mt = 23, mod = 81, cost = 5.25},
                    {name = "82", wtype = 8, mt = 23, mod = 82, cost = 5.25},
                    {name = "83", wtype = 8, mt = 23, mod = 83, cost = 5.25},
                    {name = "84", wtype = 8, mt = 23, mod = 84, cost = 5.25},
                    {name = "85", wtype = 8, mt = 23, mod = 85, cost = 5.25},
                    {name = "86", wtype = 8, mt = 23, mod = 86, cost = 5.25},
                    {name = "87", wtype = 8, mt = 23, mod = 87, cost = 5.25},
                    {name = "88", wtype = 8, mt = 23, mod = 88, cost = 5.25},
                    {name = "89", wtype = 8, mt = 23, mod = 89, cost = 5.25},
                    {name = "90", wtype = 8, mt = 23, mod = 90, cost = 5.25},
                    {name = "91", wtype = 8, mt = 23, mod = 91, cost = 5.25},
                    {name = "92", wtype = 8, mt = 23, mod = 92, cost = 5.25},
                    {name = "93", wtype = 8, mt = 23, mod = 93, cost = 5.25},
                    {name = "94", wtype = 8, mt = 23, mod = 94, cost = 5.25},
                    {name = "95", wtype = 8, mt = 23, mod = 95, cost = 5.25},
                    {name = "96", wtype = 8, mt = 23, mod = 96, cost = 5.25},
                    {name = "97", wtype = 8, mt = 23, mod = 97, cost = 5.25},
                    {name = "98", wtype = 8, mt = 23, mod = 98, cost = 5.25},
                    {name = "99", wtype = 8, mt = 23, mod = 99, cost = 5.25},
                    {name = "100", wtype = 8, mt = 23, mod = 100, cost = 5.25},
                    {name = "101", wtype = 8, mt = 23, mod = 101, cost = 5.25},
                    {name = "102", wtype = 8, mt = 23, mod = 101, cost = 5.25},
                    {name = "103", wtype = 8, mt = 23, mod = 103, cost = 5.25},
                    {name = "104", wtype = 8, mt = 23, mod = 104, cost = 5.25},
                    {name = "105", wtype = 8, mt = 23, mod = 105, cost = 5.25},
                    {name = "106", wtype = 8, mt = 23, mod = 106, cost = 5.25},
                    {name = "107", wtype = 8, mt = 23, mod = 107, cost = 5.25},
                    {name = "108", wtype = 8, mt = 23, mod = 108, cost = 5.25},
                    {name = "109", wtype = 8, mt = 23, mod = 109, cost = 5.25},
                    {name = "110", wtype = 8, mt = 23, mod = 110, cost = 5.25},
                    {name = "111", wtype = 8, mt = 23, mod = 111, cost = 5.25},
                    {name = "112", wtype = 8, mt = 23, mod = 112, cost = 5.25},
                    {name = "113", wtype = 8, mt = 23, mod = 113, cost = 5.25},
                    {name = "114", wtype = 8, mt = 23, mod = 114, cost = 5.25},
                    {name = "115", wtype = 8, mt = 23, mod = 115, cost = 5.25},
                    {name = "116", wtype = 8, mt = 23, mod = 116, cost = 5.25},
                    {name = "117", wtype = 8, mt = 23, mod = 117, cost = 5.25},
                    {name = "118", wtype = 8, mt = 23, mod = 118, cost = 5.25},
                    {name = "119", wtype = 8, mt = 23, mod = 119, cost = 5.25},
                    {name = "120", wtype = 8, mt = 23, mod = 120, cost = 5.25},
                    {name = "121", wtype = 8, mt = 23, mod = 121, cost = 5.25},
                    {name = "122", wtype = 8, mt = 23, mod = 122, cost = 5.25},
                    {name = "123", wtype = 8, mt = 23, mod = 123, cost = 5.25},
                    {name = "124", wtype = 8, mt = 23, mod = 124, cost = 5.25},
                    {name = "125", wtype = 8, mt = 23, mod = 125, cost = 5.25},
                    {name = "126", wtype = 8, mt = 23, mod = 126, cost = 5.25},
                    {name = "127", wtype = 8, mt = 23, mod = 127, cost = 5.25},
                    {name = "128", wtype = 8, mt = 23, mod = 128, cost = 5.25},
                    {name = "129", wtype = 8, mt = 23, mod = 129, cost = 5.25},
                    {name = "130", wtype = 8, mt = 23, mod = 130, cost = 5.25},
                    {name = "131", wtype = 8, mt = 23, mod = 131, cost = 5.25},
                    {name = "132", wtype = 8, mt = 23, mod = 132, cost = 5.25},
                    {name = "133", wtype = 8, mt = 23, mod = 133, cost = 5.25},
                    {name = "134", wtype = 8, mt = 23, mod = 134, cost = 5.25},
                    {name = "135", wtype = 8, mt = 23, mod = 135, cost = 5.25},
                    {name = "136", wtype = 8, mt = 23, mod = 136, cost = 5.25},
                    {name = "137", wtype = 8, mt = 23, mod = 137, cost = 5.25},
                    {name = "138", wtype = 8, mt = 23, mod = 138, cost = 5.25},
                    {name = "139", wtype = 8, mt = 23, mod = 139, cost = 5.25},
                    {name = "140", wtype = 8, mt = 23, mod = 140, cost = 5.25},
                    {name = "141", wtype = 8, mt = 23, mod = 141, cost = 5.25},
                    {name = "142", wtype = 8, mt = 23, mod = 142, cost = 5.25},
                    {name = "143", wtype = 8, mt = 23, mod = 143, cost = 5.25},
                    {name = "144", wtype = 8, mt = 23, mod = 144, cost = 5.25},
                    {name = "145", wtype = 8, mt = 23, mod = 145, cost = 5.25},
                    {name = "146", wtype = 8, mt = 23, mod = 146, cost = 5.25},
                    {name = "147", wtype = 8, mt = 23, mod = 147, cost = 5.25},
                    {name = "148", wtype = 8, mt = 23, mod = 148, cost = 5.25},
                    {name = "149", wtype = 8, mt = 23, mod = 149, cost = 5.25},
                    {name = "150", wtype = 8, mt = 23, mod = 150, cost = 5.25},
                    {name = "151", wtype = 8, mt = 23, mod = 151, cost = 5.25},
                    {name = "152", wtype = 8, mt = 23, mod = 152, cost = 5.25},
                    {name = "153", wtype = 8, mt = 23, mod = 153, cost = 5.25},
                    {name = "154", wtype = 8, mt = 23, mod = 154, cost = 5.25},
                    {name = "155", wtype = 8, mt = 23, mod = 155, cost = 5.25},
                    {name = "156", wtype = 8, mt = 23, mod = 156, cost = 5.25},
                    {name = "157", wtype = 8, mt = 23, mod = 157, cost = 5.25},
                    {name = "158", wtype = 8, mt = 23, mod = 158, cost = 5.25},
                    {name = "159", wtype = 8, mt = 23, mod = 159, cost = 5.25},
                    {name = "160", wtype = 8, mt = 23, mod = 160, cost = 5.25},
                    {name = "161", wtype = 8, mt = 23, mod = 161, cost = 5.25},
                    {name = "162", wtype = 8, mt = 23, mod = 162, cost = 5.25},
                    {name = "163", wtype = 8, mt = 23, mod = 163, cost = 5.25},
                    {name = "164", wtype = 8, mt = 23, mod = 164, cost = 5.25},
                    {name = "165", wtype = 8, mt = 23, mod = 165, cost = 5.25},
                    {name = "166", wtype = 8, mt = 23, mod = 166, cost = 5.25},
                    {name = "167", wtype = 8, mt = 23, mod = 167, cost = 5.25},
                    {name = "168", wtype = 8, mt = 23, mod = 168, cost = 5.25},
                    {name = "169", wtype = 8, mt = 23, mod = 169, cost = 5.25},
                    {name = "170", wtype = 8, mt = 23, mod = 170, cost = 5.25},
                    {name = "171", wtype = 8, mt = 23, mod = 171, cost = 5.25},
                    {name = "172", wtype = 8, mt = 23, mod = 172, cost = 5.25},
                    {name = "173", wtype = 8, mt = 23, mod = 173, cost = 5.25},
                    {name = "174", wtype = 8, mt = 23, mod = 174, cost = 5.25},
                    {name = "175", wtype = 8, mt = 23, mod = 175, cost = 5.25},
                    {name = "176", wtype = 8, mt = 23, mod = 176, cost = 5.25},
                    {name = "177", wtype = 8, mt = 23, mod = 177, cost = 5.25},
                    {name = "178", wtype = 8, mt = 23, mod = 178, cost = 5.25},
                    {name = "179", wtype = 8, mt = 23, mod = 179, cost = 5.25},
                    {name = "180", wtype = 8, mt = 23, mod = 180, cost = 5.25},
                    {name = "181", wtype = 8, mt = 23, mod = 181, cost = 5.25},
                    {name = "182", wtype = 8, mt = 23, mod = 182, cost = 5.25},
                    {name = "183", wtype = 8, mt = 23, mod = 183, cost = 5.25},
                    {name = "184", wtype = 8, mt = 23, mod = 184, cost = 5.25},
                    {name = "185", wtype = 8, mt = 23, mod = 185, cost = 5.25},
                    {name = "186", wtype = 8, mt = 23, mod = 186, cost = 5.25},
                    {name = "187", wtype = 8, mt = 23, mod = 187, cost = 5.25},
                    {name = "188", wtype = 8, mt = 23, mod = 188, cost = 5.25},
                    {name = "189", wtype = 8, mt = 23, mod = 189, cost = 5.25},
                    {name = "190", wtype = 8, mt = 23, mod = 190, cost = 5.25},
                    {name = "191", wtype = 8, mt = 23, mod = 191, cost = 5.25},
                    {name = "192", wtype = 8, mt = 23, mod = 192, cost = 5.25},
                    {name = "193", wtype = 8, mt = 23, mod = 193, cost = 5.25},
                    {name = "194", wtype = 8, mt = 23, mod = 194, cost = 5.25},
                    {name = "195", wtype = 8, mt = 23, mod = 195, cost = 5.25},
                    {name = "196", wtype = 8, mt = 23, mod = 196, cost = 5.25},
                    {name = "197", wtype = 8, mt = 23, mod = 197, cost = 5.25},
                    {name = "198", wtype = 8, mt = 23, mod = 198, cost = 5.25},
                    {name = "199", wtype = 8, mt = 23, mod = 199, cost = 5.25},
                    {name = "200", wtype = 8, mt = 23, mod = 200, cost = 5.25},
                    {name = "201", wtype = 8, mt = 23, mod = 201, cost = 5.25},
                    {name = "202", wtype = 8, mt = 23, mod = 202, cost = 5.25},
                    {name = "203", wtype = 8, mt = 23, mod = 203, cost = 5.25},
                    {name = "204", wtype = 8, mt = 23, mod = 204, cost = 5.25},
                    {name = "205", wtype = 8, mt = 23, mod = 205, cost = 5.25},
                    {name = "206", wtype = 8, mt = 23, mod = 206, cost = 5.25},
                    {name = "207", wtype = 8, mt = 23, mod = 207, cost = 5.25},
                    {name = "208", wtype = 8, mt = 23, mod = 208, cost = 5.25},
                    {name = "209", wtype = 8, mt = 23, mod = 209, cost = 5.25},
                    {name = "210", wtype = 8, mt = 23, mod = 210, cost = 5.25},
                    {name = "211", wtype = 8, mt = 23, mod = 211, cost = 5.25},
                    {name = "212", wtype = 8, mt = 23, mod = 212, cost = 5.25},
                    {name = "213", wtype = 8, mt = 23, mod = 213, cost = 5.25},
                    {name = "214", wtype = 8, mt = 23, mod = 214, cost = 5.25},
                    {name = "215", wtype = 8, mt = 23, mod = 215, cost = 5.25},
                    {name = "216", wtype = 8, mt = 23, mod = 216, cost = 5.25},
                    {name = "219", wtype = 8, mt = 23, mod = 0, cost = 5.25}
                },
                ["Benny's 2"] = {
                    {name = "1", wtype = 9, mt = 23, mod = 1, cost = 5.25},
                    {name = "2", wtype = 9, mt = 23, mod = 2, cost = 5.25},
                    {name = "3", wtype = 9, mt = 23, mod = 3, cost = 5.25},
                    {name = "4", wtype = 9, mt = 23, mod = 4, cost = 5.25},
                    {name = "5", wtype = 9, mt = 23, mod = 5, cost = 5.25},
                    {name = "6", wtype = 9, mt = 23, mod = 6, cost = 5.25},
                    {name = "7", wtype = 9, mt = 23, mod = 7, cost = 5.25},
                    {name = "8", wtype = 9, mt = 23, mod = 8, cost = 5.25},
                    {name = "9", wtype = 9, mt = 23, mod = 9, cost = 5.25},
                    {name = "10", wtype = 9, mt = 23, mod = 10, cost = 5.25},
                    {name = "11", wtype = 9, mt = 23, mod = 11, cost = 5.25},
                    {name = "12", wtype = 9, mt = 23, mod = 12, cost = 5.25},
                    {name = "13", wtype = 9, mt = 23, mod = 13, cost = 5.25},
                    {name = "14", wtype = 9, mt = 23, mod = 14, cost = 5.25},
                    {name = "15", wtype = 9, mt = 23, mod = 15, cost = 5.25},
                    {name = "16", wtype = 9, mt = 23, mod = 16, cost = 5.25},
                    {name = "17", wtype = 9, mt = 23, mod = 17, cost = 5.25},
                    {name = "18", wtype = 9, mt = 23, mod = 18, cost = 5.25},
                    {name = "19", wtype = 9, mt = 23, mod = 19, cost = 5.25},
                    {name = "20", wtype = 9, mt = 23, mod = 20, cost = 5.25},
                    {name = "21", wtype = 9, mt = 23, mod = 21, cost = 5.25},
                    {name = "22", wtype = 9, mt = 23, mod = 22, cost = 5.25},
                    {name = "23", wtype = 9, mt = 23, mod = 23, cost = 5.25},
                    {name = "24", wtype = 9, mt = 23, mod = 24, cost = 5.25},
                    {name = "25", wtype = 9, mt = 23, mod = 25, cost = 5.25},
                    {name = "26", wtype = 9, mt = 23, mod = 26, cost = 5.25},
                    {name = "27", wtype = 9, mt = 23, mod = 27, cost = 5.25},
                    {name = "28", wtype = 9, mt = 23, mod = 28, cost = 5.25},
                    {name = "29", wtype = 9, mt = 23, mod = 29, cost = 5.25},
                    {name = "30", wtype = 9, mt = 23, mod = 30, cost = 5.25},
                    {name = "31", wtype = 9, mt = 23, mod = 31, cost = 5.25},
                    {name = "32", wtype = 9, mt = 23, mod = 32, cost = 5.25},
                    {name = "33", wtype = 9, mt = 23, mod = 33, cost = 5.25},
                    {name = "34", wtype = 9, mt = 23, mod = 34, cost = 5.25},
                    {name = "35", wtype = 9, mt = 23, mod = 35, cost = 5.25},
                    {name = "36", wtype = 9, mt = 23, mod = 36, cost = 5.25},
                    {name = "37", wtype = 9, mt = 23, mod = 37, cost = 5.25},
                    {name = "38", wtype = 9, mt = 23, mod = 38, cost = 5.25},
                    {name = "39", wtype = 9, mt = 23, mod = 39, cost = 5.25},
                    {name = "40", wtype = 9, mt = 23, mod = 40, cost = 5.25},
                    {name = "41", wtype = 9, mt = 23, mod = 41, cost = 5.25},
                    {name = "42", wtype = 9, mt = 23, mod = 42, cost = 5.25},
                    {name = "43", wtype = 9, mt = 23, mod = 43, cost = 5.25},
                    {name = "44", wtype = 9, mt = 23, mod = 44, cost = 5.25},
                    {name = "45", wtype = 9, mt = 23, mod = 45, cost = 5.25},
                    {name = "46", wtype = 9, mt = 23, mod = 46, cost = 5.25},
                    {name = "47", wtype = 9, mt = 23, mod = 47, cost = 5.25},
                    {name = "48", wtype = 9, mt = 23, mod = 48, cost = 5.25},
                    {name = "49", wtype = 9, mt = 23, mod = 49, cost = 5.25},
                    {name = "50", wtype = 9, mt = 23, mod = 50, cost = 5.25},
                    {name = "51", wtype = 9, mt = 23, mod = 51, cost = 5.25},
                    {name = "52", wtype = 9, mt = 23, mod = 52, cost = 5.25},
                    {name = "53", wtype = 9, mt = 23, mod = 53, cost = 5.25},
                    {name = "54", wtype = 9, mt = 23, mod = 54, cost = 5.25},
                    {name = "55", wtype = 9, mt = 23, mod = 55, cost = 5.25},
                    {name = "56", wtype = 9, mt = 23, mod = 56, cost = 5.25},
                    {name = "57", wtype = 9, mt = 23, mod = 57, cost = 5.25},
                    {name = "58", wtype = 9, mt = 23, mod = 58, cost = 5.25},
                    {name = "59", wtype = 9, mt = 23, mod = 59, cost = 5.25},
                    {name = "60", wtype = 9, mt = 23, mod = 60, cost = 5.25},
                    {name = "61", wtype = 9, mt = 23, mod = 61, cost = 5.25},
                    {name = "62", wtype = 9, mt = 23, mod = 62, cost = 5.25},
                    {name = "63", wtype = 9, mt = 23, mod = 63, cost = 5.25},
                    {name = "64", wtype = 9, mt = 23, mod = 64, cost = 5.25},
                    {name = "65", wtype = 9, mt = 23, mod = 65, cost = 5.25},
                    {name = "66", wtype = 9, mt = 23, mod = 66, cost = 5.25},
                    {name = "67", wtype = 9, mt = 23, mod = 67, cost = 5.25},
                    {name = "68", wtype = 9, mt = 23, mod = 68, cost = 5.25},
                    {name = "69", wtype = 9, mt = 23, mod = 69, cost = 5.25},
                    {name = "70", wtype = 9, mt = 23, mod = 70, cost = 5.25},
                    {name = "71", wtype = 9, mt = 23, mod = 71, cost = 5.25},
                    {name = "72", wtype = 9, mt = 23, mod = 72, cost = 5.25},
                    {name = "73", wtype = 9, mt = 23, mod = 73, cost = 5.25},
                    {name = "74", wtype = 9, mt = 23, mod = 74, cost = 5.25},
                    {name = "75", wtype = 9, mt = 23, mod = 75, cost = 5.25},
                    {name = "76", wtype = 9, mt = 23, mod = 76, cost = 5.25},
                    {name = "77", wtype = 9, mt = 23, mod = 77, cost = 5.25},
                    {name = "78", wtype = 9, mt = 23, mod = 78, cost = 5.25},
                    {name = "79", wtype = 9, mt = 23, mod = 79, cost = 5.25},
                    {name = "80", wtype = 9, mt = 23, mod = 80, cost = 5.25},
                    {name = "81", wtype = 9, mt = 23, mod = 81, cost = 5.25},
                    {name = "82", wtype = 9, mt = 23, mod = 82, cost = 5.25},
                    {name = "83", wtype = 9, mt = 23, mod = 83, cost = 5.25},
                    {name = "84", wtype = 9, mt = 23, mod = 84, cost = 5.25},
                    {name = "85", wtype = 9, mt = 23, mod = 85, cost = 5.25},
                    {name = "86", wtype = 9, mt = 23, mod = 86, cost = 5.25},
                    {name = "87", wtype = 9, mt = 23, mod = 87, cost = 5.25},
                    {name = "88", wtype = 9, mt = 23, mod = 88, cost = 5.25},
                    {name = "89", wtype = 9, mt = 23, mod = 89, cost = 5.25},
                    {name = "90", wtype = 9, mt = 23, mod = 90, cost = 5.25},
                    {name = "91", wtype = 9, mt = 23, mod = 91, cost = 5.25},
                    {name = "92", wtype = 9, mt = 23, mod = 92, cost = 5.25},
                    {name = "93", wtype = 9, mt = 23, mod = 93, cost = 5.25},
                    {name = "94", wtype = 9, mt = 23, mod = 94, cost = 5.25},
                    {name = "95", wtype = 9, mt = 23, mod = 95, cost = 5.25},
                    {name = "96", wtype = 9, mt = 23, mod = 96, cost = 5.25},
                    {name = "97", wtype = 9, mt = 23, mod = 97, cost = 5.25},
                    {name = "98", wtype = 9, mt = 23, mod = 98, cost = 5.25},
                    {name = "99", wtype = 9, mt = 23, mod = 99, cost = 5.25},
                    {name = "100", wtype = 9, mt = 23, mod = 100, cost = 5.25},
                    {name = "101", wtype = 9, mt = 23, mod = 101, cost = 5.25},
                    {name = "102", wtype = 9, mt = 23, mod = 101, cost = 5.25},
                    {name = "103", wtype = 9, mt = 23, mod = 103, cost = 5.25},
                    {name = "104", wtype = 9, mt = 23, mod = 104, cost = 5.25},
                    {name = "105", wtype = 9, mt = 23, mod = 105, cost = 5.25},
                    {name = "106", wtype = 9, mt = 23, mod = 106, cost = 5.25},
                    {name = "107", wtype = 9, mt = 23, mod = 107, cost = 5.25},
                    {name = "108", wtype = 9, mt = 23, mod = 108, cost = 5.25},
                    {name = "109", wtype = 9, mt = 23, mod = 109, cost = 5.25},
                    {name = "110", wtype = 9, mt = 23, mod = 110, cost = 5.25},
                    {name = "111", wtype = 9, mt = 23, mod = 111, cost = 5.25},
                    {name = "112", wtype = 9, mt = 23, mod = 112, cost = 5.25},
                    {name = "113", wtype = 9, mt = 23, mod = 113, cost = 5.25},
                    {name = "114", wtype = 9, mt = 23, mod = 114, cost = 5.25},
                    {name = "115", wtype = 9, mt = 23, mod = 115, cost = 5.25},
                    {name = "116", wtype = 9, mt = 23, mod = 116, cost = 5.25},
                    {name = "117", wtype = 9, mt = 23, mod = 117, cost = 5.25},
                    {name = "118", wtype = 9, mt = 23, mod = 118, cost = 5.25},
                    {name = "119", wtype = 9, mt = 23, mod = 119, cost = 5.25},
                    {name = "120", wtype = 9, mt = 23, mod = 120, cost = 5.25},
                    {name = "121", wtype = 9, mt = 23, mod = 121, cost = 5.25},
                    {name = "122", wtype = 9, mt = 23, mod = 122, cost = 5.25},
                    {name = "123", wtype = 9, mt = 23, mod = 123, cost = 5.25},
                    {name = "124", wtype = 9, mt = 23, mod = 124, cost = 5.25},
                    {name = "125", wtype = 9, mt = 23, mod = 125, cost = 5.25},
                    {name = "126", wtype = 9, mt = 23, mod = 126, cost = 5.25},
                    {name = "127", wtype = 9, mt = 23, mod = 127, cost = 5.25},
                    {name = "128", wtype = 9, mt = 23, mod = 128, cost = 5.25},
                    {name = "129", wtype = 9, mt = 23, mod = 129, cost = 5.25},
                    {name = "130", wtype = 9, mt = 23, mod = 130, cost = 5.25},
                    {name = "131", wtype = 9, mt = 23, mod = 131, cost = 5.25},
                    {name = "132", wtype = 9, mt = 23, mod = 132, cost = 5.25},
                    {name = "133", wtype = 9, mt = 23, mod = 133, cost = 5.25},
                    {name = "134", wtype = 9, mt = 23, mod = 134, cost = 5.25},
                    {name = "135", wtype = 9, mt = 23, mod = 135, cost = 5.25},
                    {name = "136", wtype = 9, mt = 23, mod = 136, cost = 5.25},
                    {name = "137", wtype = 9, mt = 23, mod = 137, cost = 5.25},
                    {name = "138", wtype = 9, mt = 23, mod = 138, cost = 5.25},
                    {name = "139", wtype = 9, mt = 23, mod = 139, cost = 5.25},
                    {name = "140", wtype = 9, mt = 23, mod = 140, cost = 5.25},
                    {name = "141", wtype = 9, mt = 23, mod = 141, cost = 5.25},
                    {name = "142", wtype = 9, mt = 23, mod = 142, cost = 5.25},
                    {name = "143", wtype = 9, mt = 23, mod = 143, cost = 5.25},
                    {name = "144", wtype = 9, mt = 23, mod = 144, cost = 5.25},
                    {name = "145", wtype = 9, mt = 23, mod = 145, cost = 5.25},
                    {name = "146", wtype = 9, mt = 23, mod = 146, cost = 5.25},
                    {name = "147", wtype = 9, mt = 23, mod = 147, cost = 5.25},
                    {name = "148", wtype = 9, mt = 23, mod = 148, cost = 5.25},
                    {name = "149", wtype = 9, mt = 23, mod = 149, cost = 5.25},
                    {name = "150", wtype = 9, mt = 23, mod = 150, cost = 5.25},
                    {name = "151", wtype = 9, mt = 23, mod = 151, cost = 5.25},
                    {name = "152", wtype = 9, mt = 23, mod = 152, cost = 5.25},
                    {name = "153", wtype = 9, mt = 23, mod = 153, cost = 5.25},
                    {name = "154", wtype = 9, mt = 23, mod = 154, cost = 5.25},
                    {name = "155", wtype = 9, mt = 23, mod = 155, cost = 5.25},
                    {name = "156", wtype = 9, mt = 23, mod = 156, cost = 5.25},
                    {name = "157", wtype = 9, mt = 23, mod = 157, cost = 5.25},
                    {name = "158", wtype = 9, mt = 23, mod = 158, cost = 5.25},
                    {name = "159", wtype = 9, mt = 23, mod = 159, cost = 5.25},
                    {name = "160", wtype = 9, mt = 23, mod = 160, cost = 5.25},
                    {name = "161", wtype = 9, mt = 23, mod = 161, cost = 5.25},
                    {name = "162", wtype = 9, mt = 23, mod = 162, cost = 5.25},
                    {name = "163", wtype = 9, mt = 23, mod = 163, cost = 5.25},
                    {name = "164", wtype = 9, mt = 23, mod = 164, cost = 5.25},
                    {name = "165", wtype = 9, mt = 23, mod = 165, cost = 5.25},
                    {name = "166", wtype = 9, mt = 23, mod = 166, cost = 5.25},
                    {name = "167", wtype = 9, mt = 23, mod = 167, cost = 5.25},
                    {name = "168", wtype = 9, mt = 23, mod = 168, cost = 5.25},
                    {name = "169", wtype = 9, mt = 23, mod = 169, cost = 5.25},
                    {name = "170", wtype = 9, mt = 23, mod = 170, cost = 5.25},
                    {name = "171", wtype = 9, mt = 23, mod = 171, cost = 5.25},
                    {name = "172", wtype = 9, mt = 23, mod = 172, cost = 5.25},
                    {name = "173", wtype = 9, mt = 23, mod = 173, cost = 5.25},
                    {name = "174", wtype = 9, mt = 23, mod = 174, cost = 5.25},
                    {name = "175", wtype = 9, mt = 23, mod = 175, cost = 5.25},
                    {name = "176", wtype = 9, mt = 23, mod = 176, cost = 5.25},
                    {name = "177", wtype = 9, mt = 23, mod = 177, cost = 5.25},
                    {name = "178", wtype = 9, mt = 23, mod = 178, cost = 5.25},
                    {name = "179", wtype = 9, mt = 23, mod = 179, cost = 5.25},
                    {name = "180", wtype = 9, mt = 23, mod = 180, cost = 5.25},
                    {name = "181", wtype = 9, mt = 23, mod = 181, cost = 5.25},
                    {name = "182", wtype = 9, mt = 23, mod = 182, cost = 5.25},
                    {name = "183", wtype = 9, mt = 23, mod = 183, cost = 5.25},
                    {name = "184", wtype = 9, mt = 23, mod = 184, cost = 5.25},
                    {name = "185", wtype = 9, mt = 23, mod = 185, cost = 5.25},
                    {name = "186", wtype = 9, mt = 23, mod = 186, cost = 5.25},
                    {name = "187", wtype = 9, mt = 23, mod = 187, cost = 5.25},
                    {name = "188", wtype = 9, mt = 23, mod = 188, cost = 5.25},
                    {name = "189", wtype = 9, mt = 23, mod = 189, cost = 5.25},
                    {name = "190", wtype = 9, mt = 23, mod = 190, cost = 5.25},
                    {name = "191", wtype = 9, mt = 23, mod = 191, cost = 5.25},
                    {name = "192", wtype = 9, mt = 23, mod = 192, cost = 5.25},
                    {name = "193", wtype = 9, mt = 23, mod = 193, cost = 5.25},
                    {name = "194", wtype = 9, mt = 23, mod = 194, cost = 5.25},
                    {name = "195", wtype = 9, mt = 23, mod = 195, cost = 5.25},
                    {name = "196", wtype = 9, mt = 23, mod = 196, cost = 5.25},
                    {name = "197", wtype = 9, mt = 23, mod = 197, cost = 5.25},
                    {name = "198", wtype = 9, mt = 23, mod = 198, cost = 5.25},
                    {name = "199", wtype = 9, mt = 23, mod = 199, cost = 5.25},
                    {name = "200", wtype = 9, mt = 23, mod = 200, cost = 5.25},
                    {name = "201", wtype = 9, mt = 23, mod = 201, cost = 5.25},
                    {name = "202", wtype = 9, mt = 23, mod = 202, cost = 5.25},
                    {name = "203", wtype = 9, mt = 23, mod = 203, cost = 5.25},
                    {name = "204", wtype = 9, mt = 23, mod = 204, cost = 5.25},
                    {name = "205", wtype = 9, mt = 23, mod = 205, cost = 5.25},
                    {name = "206", wtype = 9, mt = 23, mod = 206, cost = 5.25},
                    {name = "207", wtype = 9, mt = 23, mod = 207, cost = 5.25},
                    {name = "208", wtype = 9, mt = 23, mod = 208, cost = 5.25},
                    {name = "209", wtype = 9, mt = 23, mod = 209, cost = 5.25},
                    {name = "210", wtype = 9, mt = 23, mod = 210, cost = 5.25},
                    {name = "211", wtype = 9, mt = 23, mod = 211, cost = 5.25},
                    {name = "212", wtype = 9, mt = 23, mod = 212, cost = 5.25},
                    {name = "213", wtype = 9, mt = 23, mod = 213, cost = 5.25},
                    {name = "214", wtype = 9, mt = 23, mod = 214, cost = 5.25},
                    {name = "215", wtype = 9, mt = 23, mod = 215, cost = 5.25},
                    {name = "216", wtype = 9, mt = 23, mod = 216, cost = 5.25},
                    {name = "219", wtype = 9, mt = 23, mod = 0, cost = 5.25}
                },
                ["SUV"] = {
                    {name = "Stock", wtype = 3, mt = 23, mod = -1, cost = 5.0},
                    {name = "Vip", wtype = 3, mt = 23, mod = 0, cost = 5.0},
                    {name = "Benefactor", wtype = 3, mt = 23, mod = 1, cost = 5.0},
                    {name = "Cosmo", wtype = 3, mt = 23, mod = 2, cost = 5.0},
                    {name = "Bippu", wtype = 3, mt = 23, mod = 3, cost = 5.0},
                    {name = "Royalsix", wtype = 3, mt = 23, mod = 4, cost = 5.0},
                    {name = "Fagorme", wtype = 3, mt = 23, mod = 5, cost = 5.0},
                    {name = "Deluxe", wtype = 3, mt = 23, mod = 6, cost = 5.0},
                    {name = "Icedout", wtype = 3, mt = 23, mod = 7, cost = 5.0},
                    {name = "Cognscenti", wtype = 3, mt = 23, mod = 8, cost = 5.0},
                    {name = "Lozspeedten", wtype = 3, mt = 23, mod = 9, cost = 5.0},
                    {name = "Supernova", wtype = 3, mt = 23, mod = 10, cost = 5.0},
                    {name = "Obeyrs", wtype = 3, mt = 23, mod = 11, cost = 5.0},
                    {name = "Lozspeedballer", wtype = 3, mt = 23, mod = 12, cost = 5.0},
                    {name = "Extra vaganzo", wtype = 3, mt = 23, mod = 13, cost = 5.0},
                    {name = "Splitsix", wtype = 3, mt = 23, mod = 14, cost = 5.0},
                    {name = "Empowered", wtype = 3, mt = 23, mod = 15, cost = 5.0},
                    {name = "Sunrise", wtype = 3, mt = 23, mod = 16, cost = 5.0},
                    {name = "Dashvip", wtype = 3, mt = 23, mod = 17, cost = 5.0},
                    {name = "Cutter", wtype = 3, mt = 23, mod = 18, cost = 5.0}
                },
                ["Offroad"] = {
                    {name = "Stock", wtype = 4, mt = 23, mod = -1, cost = 6.25},
                    {name = "Raider", wtype = 4, mt = 23, mod = 0, cost = 6.25},
                    --{name = "Mudslinger", mt = 23, mod = 1, cost = 6.25}, -- cause crash
                    {name = "Nevis", wtype = 4, mt = 23, mod = 2, cost = 6.25},
                    {name = "Cairngorm", wtype = 4, mt = 23, mod = 3, cost = 6.25},
                    {name = "Amazon", wtype = 4, mt = 23, mod = 4, cost = 6.25},
                    {name = "Challenger", wtype = 4, mt = 23, mod = 5, cost = 6.25},
                    {name = "Dunebasher", wtype = 4, mt = 23, mod = 6, cost = 6.25},
                    {name = "Fivestar", wtype = 4, mt = 23, mod = 7, cost = 6.25},
                    {name = "Rockcrawler", wtype = 4, mt = 23, mod = 8, cost = 6.25},
                    {name = "Milspecsteelie", wtype = 4, mt = 23, mod = 9, cost = 6.25}
                },
                ["Tuner"] = {
                    {name = "Stock", wtype = 5, mt = 23, mod = -1, cost = 5.0},
                    {name = "Cosmo", wtype = 5, mt = 23, mod = 0, cost = 5.0},
                    {name = "Supermesh", wtype = 5, mt = 23, mod = 1, cost = 5.0},
                    {name = "Outsider", wtype = 5, mt = 23, mod = 2, cost = 5.0},
                    {name = "Rollas", wtype = 5, mt = 23, mod = 3, cost = 5.0},
                    {name = "Driffmeister", wtype = 5, mt = 23, mod = 4, cost = 5.0},
                    {name = "Slicer", wtype = 5, mt = 23, mod = 5, cost = 5.0},
                    {name = "Elquatro", wtype = 5, mt = 23, mod = 6, cost = 5.0},
                    {name = "Dubbed", wtype = 5, mt = 23, mod = 7, cost = 5.0},
                    {name = "Fivestar", wtype = 5, mt = 23, mod = 8, cost = 5.0},
                    {name = "Slideways", wtype = 5, mt = 23, mod = 9, cost = 5.0},
                    {name = "Apex", wtype = 5, mt = 23, mod = 10, cost = 5.0},
                    {name = "Stancedeg", wtype = 5, mt = 23, mod = 11, cost = 5.0},
                    {name = "Countersteer", wtype = 5, mt = 23, mod = 12, cost = 5.0},
                    {name = "Endov1", wtype = 5, mt = 23, mod = 13, cost = 5.0},
                    {name = "Endov2dish", wtype = 5, mt = 23, mod = 14, cost = 5.0},
                    {name = "Guppez", wtype = 5, mt = 23, mod = 15, cost = 5.0},
                    {name = "Chokadori", wtype = 5, mt = 23, mod = 16, cost = 5.0},
                    {name = "Chicane", wtype = 5, mt = 23, mod = 17, cost = 5.0},
                    {name = "Saisoku", wtype = 5, mt = 23, mod = 18, cost = 5.0},
                    {name = "Dishedeight", wtype = 5, mt = 23, mod = 19, cost = 5.0},
                    {name = "Fujiwara", wtype = 5, mt = 23, mod = 20, cost = 5.0},
                    {name = "Zokusha", wtype = 5, mt = 23, mod = 21, cost = 5.0},
                    {name = "Battlevill", wtype = 5, mt = 23, mod = 22, cost = 5.0},
                    {name = "Rallymaster", wtype = 5, mt = 23, mod = 23, cost = 5.0}
                },
                ["Haut de gamme"] = {
                    {name = "Stock", wtype = 7, mt = 23, mod = -1, cost = 7},
                    {name = "Shadow", wtype = 7, mt = 23, mod = 0, cost = 7},
                    {name = "Hyper", wtype = 7, mt = 23, mod = 1, cost = 7.5},
                    {name = "Blade", wtype = 7, mt = 23, mod = 2, cost = 4},
                    {name = "Diamond", wtype = 7, mt = 23, mod = 3, cost = 2.5},
                    {name = "Supagee", wtype = 7, mt = 23, mod = 4, cost = 5.25},
                    {name = "Chromaticz", wtype = 7, mt = 23, mod = 5, cost = 6},
                    {name = "Merciechlip", wtype = 7, mt = 23, mod = 6, cost = 6.75},
                    {name = "Obeyrs", wtype = 7, mt = 23, mod = 7, cost = 7.5},
                    {name = "Gtchrome", wtype = 7, mt = 23, mod = 8, cost = 7.5},
                    {name = "Cheetahr", wtype = 7, mt = 23, mod = 9, cost = 4},
                    {name = "Solar", wtype = 7, mt = 23, mod = 10, cost = 5.25},
                    {name = "Splitten", wtype = 7, mt = 23, mod = 11, cost = 6},
                    {name = "Dashvip", wtype = 7, mt = 23, mod = 12, cost = 6.75},
                    {name = "Lozspeedten", wtype = 7, mt = 23, mod = 13, cost = 4},
                    {name = "Carboninferno", wtype = 7, mt = 23, mod = 14, cost = 7.5},
                    {name = "Carbonshadow", wtype = 7, mt = 23, mod = 15, cost = 11.5},
                    {name = "Carbonz", wtype = 7, mt = 23, mod = 16, cost = 11.5},
                    {name = "Carbonsolar", wtype = 7, mt = 23, mod = 17, cost = 11.5},
                    {name = "Carboncheetahr", wtype = 7, mt = 23, mod = 18, cost = 11.5},
                    {name = "Carbonsracer", wtype = 7, mt = 23, mod = 19, cost = 11.5}
                },
                ["Lowrider"] = {
                    {name = "Stock", wtype = 2, mt = 23, mod = -1, cost = 5.0},
                    {name = "Flare", wtype = 2, mt = 23, mod = 0, cost = 5.0},
                    {name = "Wired", wtype = 2, mt = 23, mod = 1, cost = 5.0},
                    {name = "Triplegolds", wtype = 2, mt = 23, mod = 2, cost = 5.0},
                    {name = "Bigworm", wtype = 2, mt = 23, mod = 3, cost = 5.0},
                    {name = "Sevenfives", wtype = 2, mt = 23, mod = 4, cost = 5.0},
                    {name = "Splitsix", wtype = 2, mt = 23, mod = 5, cost = 5.0},
                    {name = "Freshmesh", wtype = 2, mt = 23, mod = 6, cost = 5.0},
                    {name = "Leadsled", wtype = 2, mt = 23, mod = 7, cost = 5.0},
                    {name = "Turbine", wtype = 2, mt = 23, mod = 8, cost = 5.0},
                    {name = "Superfin", wtype = 2, mt = 23, mod = 9, cost = 5.0},
                    {name = "Classicrod", wtype = 2, mt = 23, mod = 10, cost = 5.0},
                    {name = "Dollar", wtype = 2, mt = 23, mod = 11, cost = 5.0},
                    {name = "Dukes", wtype = 2, mt = 23, mod = 12, cost = 5.0},
                    {name = "Lowfive", wtype = 2, mt = 23, mod = 13, cost = 5.0},
                    {name = "Gooch", wtype = 2, mt = 23, mod = 14, cost = 5.0}
                },
                ["Muscle"] = {
                    {name = "Stock", wtype = 1, mt = 23, mod = -1, cost = 5.0},
                    {name = "Classicfive", wtype = 1, mt = 23, mod = 0, cost = 5.0},
                    {name = "Dukes", wtype = 1, mt = 23, mod = 1, cost = 5.0},
                    {name = "Musclefreak", wtype = 1, mt = 23, mod = 2, cost = 5.0},
                    {name = "Kracka", wtype = 1, mt = 23, mod = 3, cost = 5.0},
                    {name = "Azrea", wtype = 1, mt = 23, mod = 4, cost = 5.0},
                    {name = "Mecha", wtype = 1, mt = 23, mod = 5, cost = 5.0},
                    {name = "Blacktop", wtype = 1, mt = 23, mod = 6, cost = 5.0},
                    {name = "Dragspl", wtype = 1, mt = 23, mod = 7, cost = 5.0},
                    {name = "Revolver", wtype = 1, mt = 23, mod = 8, cost = 5.0},
                    {name = "Classicrod", wtype = 1, mt = 23, mod = 9, cost = 5.0},
                    {name = "Spooner", wtype = 1, mt = 23, mod = 10, cost = 5.0},
                    {name = "Fivestar", wtype = 1, mt = 23, mod = 11, cost = 5.0},
                    {name = "Oldschool", wtype = 1, mt = 23, mod = 12, cost = 5.0},
                    {name = "Eljefe", wtype = 1, mt = 23, mod = 13, cost = 5.0},
                    {name = "Dodman", wtype = 1, mt = 23, mod = 14, cost = 5.0},
                    {name = "Sixgun", wtype = 1, mt = 23, mod = 15, cost = 5.0},
                    {name = "Mercenary", wtype = 1, mt = 23, mod = 16, cost = 5.0}
                }
            },
            ["Motos"] = {
                ["Roue avant"] = {
                    {name = "Stock", wtype = 6, mt = 23, mod = -1, cost = 3},
                    {name = "Speedway", wtype = 6, mt = 23, mod = 0, cost = 3},
                    {name = "Streetspecial", wtype = 6, mt = 23, mod = 1, cost = 3},
                    {name = "Racer", wtype = 6, mt = 23, mod = 2, cost = 3},
                    {name = "Trackstar", wtype = 6, mt = 23, mod = 3, cost = 3},
                    {name = "Overlord", wtype = 6, mt = 23, mod = 4, cost = 3},
                    {name = "Trident", wtype = 6, mt = 23, mod = 5, cost = 3},
                    {name = "Triplethreat", wtype = 6, mt = 23, mod = 6, cost = 3},
                    {name = "Stilleto", wtype = 6, mt = 23, mod = 7, cost = 3},
                    {name = "Wires", wtype = 6, mt = 23, mod = 8, cost = 3},
                    {name = "Bobber", wtype = 6, mt = 23, mod = 9, cost = 3},
                    {name = "Solidus", wtype = 6, mt = 23, mod = 10, cost = 3},
                    {name = "Iceshield", wtype = 6, mt = 23, mod = 11, cost = 3},
                    {name = "Loops", wtype = 6, mt = 23, mod = 12, cost = 3}
                },
                ["Roue arrière"] = {
                    {name = "Stock", wtype = 6, mt = 24, mod = -1, cost = 3},
                    {name = "Speedway", wtype = 6, mt = 24, mod = 0, cost = 3},
                    {name = "Streetspecial", wtype = 6, mt = 24, mod = 1, cost = 3},
                    {name = "Racer", wtype = 6, mt = 24, mod = 2, cost = 3},
                    {name = "Trackstar", wtype = 6, mt = 24, mod = 3, cost = 3},
                    {name = "Overlord", wtype = 6, mt = 24, mod = 4, cost = 3},
                    {name = "Trident", wtype = 6, mt = 24, mod = 5, cost = 3},
                    {name = "Triplethreat", wtype = 6, mt = 24, mod = 6, cost = 3},
                    {name = "Stilleto", wtype = 6, mt = 24, mod = 7, cost = 3},
                    {name = "Wires", wtype = 6, mt = 24, mod = 8, cost = 3},
                    {name = "Bobber", wtype = 6, mt = 24, mod = 9, cost = 3},
                    {name = "Solidus", wtype = 6, mt = 24, mod = 10, cost = 3},
                    {name = "Iceshield", wtype = 6, mt = 24, mod = 11, cost = 3},
                    {name = "Loops", wtype = 6, mt = 24, mod = 12, cost = 3}
                }
            },
            ["Couleur des jantes"] = {
                {name = "Noir", cost = 0.75, colour = 0},
                {name = "Carbon Noir", cost = 0.75, colour = 147},
                {name = "Graphite", cost = 0.75, colour = 1},
                {name = "Anhracite Noir", cost = 0.75, colour = 11},
                {name = "Noir Acier", cost = 0.75, colour = 2},
                {name = "Sombre Acier", cost = 0.75, colour = 3},
                {name = "Argent", cost = 0.75, colour = 4},
                {name = "Bleuâtre Silver", cost = 0.75, colour = 5},
                {name = "Roulé Acier", cost = 0.75, colour = 6},
                {name = "Ombré Silver", cost = 0.75, colour = 7},
                {name = "Pierre Silver", cost = 0.75, colour = 8},
                {name = "Nuit Silver", cost = 0.75, colour = 9},
                {name = "Fonte Silver", cost = 0.75, colour = 10},
                {name = "Rouge", cost = 0.75, colour = 27},
                {name = "Torino Rouge", cost = 0.75, colour = 28},
                {name = "Formula Rouge", cost = 0.75, colour = 29},
                {name = "Lave Rouge", cost = 0.75, colour = 150},
                {name = "Flamber Rouge", cost = 0.75, colour = 30},
                {name = "Grace Rouge", cost = 0.75, colour = 31},
                {name = "Garnet Rouge", cost = 0.75, colour = 32},
                {name = "Levé du jour Rouge", cost = 0.75, colour = 33},
                {name = "Cabernet Rouge", cost = 0.75, colour = 34},
                {name = "Vin Rouge", cost = 0.75, colour = 143},
                {name = "bonbon Rouge", cost = 0.75, colour = 35},
                {name = "Chaud Rose", cost = 0.75, colour = 135},
                {name = "Pfsiter Rose", cost = 0.75, colour = 137},
                {name = "Saumon Rose", cost = 0.75, colour = 136},
                {name = "levé du jour Orange", cost = 0.75, colour = 36},
                {name = "Orange", cost = 0.75, colour = 38},
                {name = "Clair Orange", cost = 0.75, colour = 138},
                {name = "Or", cost = 0.75, colour = 99},
                {name = "Bronze", cost = 0.75, colour = 90},
                {name = "Jaune", cost = 0.75, colour = 88},
                {name = "Course Jaune", cost = 0.75, colour = 89},
                {name = "Rosée Jaune", cost = 0.75, colour = 91},
                {name = "Sombre Vert", cost = 0.75, colour = 49},
                {name = "Course Vert", cost = 0.75, colour = 50},
                {name = "Mer Vert", cost = 0.75, colour = 51},
                {name = "Olive Vert", cost = 0.75, colour = 52},
                {name = "Clair Vert", cost = 0.75, colour = 53},
                {name = "Gasoline Vert", cost = 0.75, colour = 54},
                {name = "Citron Vert", cost = 0.75, colour = 92},
                {name = "Nuit Bleu", cost = 0.75, colour = 141},
                {name = "Galaxy Bleu", cost = 0.75, colour = 61},
                {name = "Sombre Bleu", cost = 0.75, colour = 62},
                {name = "Saxon Bleu", cost = 0.75, colour = 63},
                {name = "Bleu", cost = 0.75, colour = 64},
                {name = "Marine Bleu", cost = 0.75, colour = 65},
                {name = "Port Bleu", cost = 0.75, colour = 66},
                {name = "Diamand Bleu", cost = 0.75, colour = 67},
                {name = "Surf Bleu", cost = 0.75, colour = 68},
                {name = "Nautical Bleu", cost = 0.75, colour = 69},
                {name = "Course Bleu", cost = 0.75, colour = 73},
                {name = "Ultra Bleu", cost = 0.75, colour = 70},
                {name = "Léger Bleu", cost = 0.75, colour = 74},
                {name = "Chocolat Brun", cost = 0.75, colour = 96},
                {name = "Bison Brun", cost = 0.75, colour = 101},
                {name = "Creeen Brun", cost = 0.75, colour = 95},
                {name = "Feltzer Brun", cost = 0.75, colour = 94},
                {name = "Maple Brun", cost = 0.75, colour = 97},
                {name = "Bois Brun", cost = 0.75, colour = 103},
                {name = "Sienna Brun", cost = 0.75, colour = 104},
                {name = "Selle Brun", cost = 0.75, colour = 98},
                {name = "mousse Brun", cost = 0.75, colour = 100},
                {name = "hêtre Brun", cost = 0.75, colour = 102},
                {name = "paille Brun", cost = 0.75, colour = 99},
                {name = "sablé Brun", cost = 0.75, colour = 105},
                {name = "Blanchie Brun", cost = 0.75, colour = 106},
                {name = "Schafter Violet", cost = 0.75, colour = 71},
                {name = "Spinnaker Violet", cost = 0.75, colour = 72},
                {name = "Nuit Violet", cost = 0.75, colour = 142},
                {name = "Clair Violet", cost = 0.75, colour = 145},
                {name = "Crème", cost = 0.75, colour = 107},
                {name = "Glace White", cost = 0.75, colour = 111},
                {name = "Gel White", cost = 0.75, colour = 112}
            },
            ["Accessoires Pneus"] = {
                {name = "Stock Pneu", bool = false, cost = 1.5},
                {name = "Custom Pneu", bool = true, cost = 1.5},
                {name = "Blanc Pneu Fumée", colour = {255, 255, 255}, cost = 1.5},
                {name = "Noir Pneu Fumée", colour = {1, 1, 1}, cost = 1.5},
                {name = "Bleu Pneu Fumée", colour = {0, 150, 255}, cost = 1.5},
                {name = "Jaune Pneu Fumée", colour = {255, 255, 50}, cost = 1.5},
                {name = "Orange Pneu Fumée", colour = {255, 153, 51}, cost = 1.5},
                {name = "Rouge Pneu Fumée", colour = {255, 10, 10}, cost = 1.5},
                {name = "Vert Pneu Fumée", colour = {10, 255, 10}, cost = 1.5},
                {name = "Violet Pneu Fumée", colour = {153, 10, 153}, cost = 1.5},
                {name = "Rose Pneu Fumée", colour = {255, 102, 178}, cost = 1.5},
                {name = "Gris Pneu Fumée", colour = {128, 128, 128}, cost = 1.5}
            }
        }
    },
    {
        title = "Fenêtres",
        data = {
            {name = "Aucun", tint = 0, cost = 0.5},
            {name = "Noir foncé", tint = 1, cost = 2.5},
            {name = "Fumé", tint = 2, cost = 2},
            {name = "Fumé leger", tint = 3, cost = 1.5},
            {name = "Limousine", tint = 4, cost = 1.5},
            {name = "Vert", tint = 5, cost = 1}
        }
    }
}

RMenu.Add(
    "jobs",
    "LSC",
    RageUI.CreateMenu(nil, "Catégories disponibles", 10, 100, "shopui_title_carmod", "shopui_title_carmod")
)
RMenu.Add("jobs", "LSC_CAT", RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC"), nil, "Modifications disponibles", 10, 100))
RMenu.Add("jobs", "extras", RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC"), nil, "Modifications disponibles", 10, 100))
RMenu.Add(
    "jobs",
    "LSC_CAT_COLOR",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_CAT"), nil, "Modifications disponibles", 10, 100)
)
RMenu.Add(
    "jobs",
    "LSC_CAT_WHEELS_2",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_CAT"), nil, "Modifications disponibles", 10, 100)
)
RMenu.Add(
    "jobs",
    "LSC_CAT_WHEELS_1",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_CAT"), nil, "Modifications disponibles", 10, 100)
)
RMenu.Add(
    "jobs",
    "LSC_CAT_WHEELS_3",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_CAT"), nil, "Modifications disponibles", 10, 100)
)
RMenu.Add(
    "jobs",
    "LSC_CAT_COLOR_1",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_CAT_COLOR"), nil, "Modifications disponibles", 10, 100)
)
RMenu:Get("jobs", "LSC_CAT").Closed = function()
    UpdateCar1()
end

RMenu:Get("jobs", "LSC_CAT_COLOR").Closed = function()
    UpdateCar1()
end
RMenu:Get("jobs", "LSC_CAT_COLOR_1").Closed = function()
    UpdateCar1()
end
RMenu:Get("jobs", "LSC").Closed = function()
    currentvehicle = GetVehiclePedIsIn(LocalPlayer().Ped)
    SetVehicleOnGroundProperly(currentvehicle)
    FreezeEntityPosition(currentvehicle, false)
    SetPlayerInvincible(GetPlayerIndex(), false)
    SetEntityInvincible(currentvehicle, false)
end
function EnterZoneLSC()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le Los Santos Customs")
    KeySettings:Add("keyboard", "E", OpenLSC, "LSC")
    KeySettings:Add("controller", 46, OpenLSC, "LSC")
end

function ExitZoneLSC()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard", "E", "LSC")
    KeySettings:Clear("controller", 46, "LSC")
    RageUI.Visible(RMenu:Get("jobs", "LSC"), false)
end
local currentData = {}
local currMod = nil
local currentvehicle
local Vehicledata = {}
local modName = nil
local colorTab = {}
local indexColor = nil
local colorrrssTab = {}
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("jobs", "LSC")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in ipairs(customs) do
                            RageUI.Button(
                                v.title,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        currentData = v
                                        currMod = k
                                        modName = v.title
                                    end
                                end,
                                RMenu:Get("jobs", "LSC_CAT")
                            )
                        end

                        RageUI.Button(
                            "Extras",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                end
                            end,
                            RMenu:Get("jobs", "extras")
                        )
                        
                        RageUI.Button(
                            "Installation suspension hydraulique",
                            "$1500",
                            {},
                            true,
                            function(_, _, Selected)
                                if (Selected) then
                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

                                    if (LS.CanBuy(1500) and vehicle ~= 0) then
                                        LS.BUY(1500)
                                        DecorSetBool(vehicle, "hydraulicSystem", true)
                                        RageUI.Popup({message = "~g~Suspension installée"})
                                    end
                                end
                            end
                        )
                        
                        RageUI.Button(
                            "Retrait de la suspension hydraulique",
                            "$1500",
                            {},
                            true,
                            function(_, _, Selected)
                                if (Selected) then
                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

                                    if (LSBENNYS.CanBuy(1500) and vehicle ~= 0) then
                                        LSBENNYS.BUY(1500)
                                        DecorSetBool(vehicle, "hydraulicSystem", false)
                                        RageUI.Popup({message = "~g~Suspension retirée"})
                                    end
                                end
                            end
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("jobs", "extras")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for i = 1, 30, 1 do
                            if DoesExtraExist(currentvehicle, i - 1) then
                                RageUI.Checkbox(
                                    "Extras n°" .. i - 1,
                                    nil,
                                    IsVehicleExtraTurnedOn(currentvehicle, i - 1),
                                    {},
                                    function(Hovered, Ative, Selected, Checked)
                                        if Selected then
                                            SetVehicleExtra(
                                                currentvehicle,
                                                i - 1,
                                                IsVehicleExtraTurnedOn(currentvehicle, i - 1)
                                            )
                                        end
                                    end
                                )
                            end
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("jobs", "LSC_CAT")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        -- print(currentData.title)
                        if currentData.title == "Peintures" then
                            for k, v in pairs(currentData["data"]) do
                                RageUI.Button(
                                    k,
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        v.Index = Index

                                        if Selected then
                                            colorTab = v
                                            indexColor = k
                                        end
                                    end,
                                    RMenu:Get("jobs", "LSC_CAT_COLOR")
                                )
                            end
                        elseif currentData.title == "Jantes" then
                            if IsThisModelABike(currentvehicle) then
                                for k, v in pairs(currentData.data["Motos"]) do
                                    RageUI.Button(
                                        k,
                                        nil,
                                        {},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                colorTab = v
                                                indexColor = k
                                            end
                                        end,
                                        RMenu:Get("jobs", "LSC_CAT_WHEELS_2")
                                    )
                                end
                            else
                                for k, v in pairs(currentData.data["Type de jantes"]) do
                                    RageUI.Button(
                                        k,
                                        nil,
                                        {},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                colorTab = v
                                                indexColor = k
                                            end
                                        end,
                                        RMenu:Get("jobs", "LSC_CAT_WHEELS_1")
                                    )
                                end
                            end

                            RageUI.Button(
                                "Couleur des jantes",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        colorTab = currentData.data["Couleur des jantes"]
                                        indexColor = k
                                    end
                                end,
                                RMenu:Get("jobs", "LSC_CAT_WHEELS_3")
                            )
                        elseif currentData.title == "Xénon" then
                            for k, v in ipairs(currentData.data) do
                                if v.bool or v.bool == "true" then
                                else
                                end
                                if Vehicledata["Xenon"] == tostring(v.bool) then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end

                                RageUI.Button(
                                    v.name,
                                    nil,
                                    t,
                                    true,
                                    function(_, A, Selected)
                                        if A then
                                            ToggleVehicleMod(currentvehicle, 22, v.bool)
                                            if v.color ~= nil then
                                                SetVehicleXenonLightsColour(currentvehicle, v.color)
                                            else
                                                SetVehicleXenonLightsColour(currentvehicle, -1)
                                            end
                                        end
                                        if Selected then
                                            if LS.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                                Vehicledata["Xenon"] = tostring(v.bool)
                                                LS.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                            else
                                            end
                                        end
                                    end
                                )
                            end
                        elseif currentData.title == "Plaques" then
                            for k, v in ipairs(currentData.data) do
                                if Vehicledata["Plate"] == v.plateindex then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                                RageUI.Button(
                                    v.name,
                                    nil,
                                    t,
                                    true,
                                    function(_, A, Selected)
                                        if A then
                                            SetVehicleNumberPlateTextIndex(currentvehicle, v.plateindex)
                                        end

                                        if Selected then
                                            print(LS.CanBuy(math.floor((v.cost / 100) * vehiclePrice)))
                                            if LS.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                                Vehicledata["Plate"] = v.plateindex
                                                LS.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                            else
                                            end
                                        end
                                    end
                                )
                            end
                        elseif currentData.title == "Fenêtres" then
                            for k, v in ipairs(currentData.data) do
                                if Vehicledata[modName] == v.tint then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                                RageUI.Button(
                                    v.name,
                                    nil,
                                    t,
                                    true,
                                    function(_, A, Selected)
                                        if A then
                                            SetVehicleWindowTint(currentvehicle, v.tint)
                                        end
                                        if Selected then
                                            if LS.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                                Vehicledata[modName] = v.tint
                                                LS.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                            else
                                            end
                                        end
                                    end
                                )
                            end
                        elseif currentData.title == "Néons" then
                            RageUI.Checkbox("Neon Gauche", nil, ngc, {}, function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    ngc = Checked
                                    SetVehicleNeonLightEnabled(currentvehicle, 0, Checked)
                                    if Checked then
                                        prc = prc + 0.25
                                    else
                                        prc = prc - 0.25
                                    end
                                end
                                if Checked then
                                    SetVehicleNeonLightEnabled(currentvehicle, 0, Checked)
                                end
                            end)
                            RageUI.Checkbox("Neon Droit", nil, ndt, {}, function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    ndt = Checked
                                    SetVehicleNeonLightEnabled(currentvehicle, 1, Checked)
                                    if Checked then
                                        prc = prc + 0.25
                                    else
                                        prc = prc - 0.25
                                    end
                                end
                                if Checked then
                                    SetVehicleNeonLightEnabled(currentvehicle, 1, Checked)
                                end
                            end)
                            RageUI.Checkbox("Neon Avant", nil, nav, {}, function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    nav = Checked
                                    SetVehicleNeonLightEnabled(currentvehicle, 2, Checked)
                                    if Checked then
                                        prc = prc + 0.25
                                    else
                                        prc = prc - 0.25
                                    end
                                end
                                if Checked then
                                    SetVehicleNeonLightEnabled(currentvehicle, 2, Checked)
                                end
                            end)
                            RageUI.Checkbox("Neon Arrière", nil, nar, {}, function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    nar = Checked
                                    SetVehicleNeonLightEnabled(currentvehicle, 3, Checked)
                                    if Checked then
                                        prc = prc + 0.25
                                    else
                                        prc = prc - 0.25
                                    end
                                end
                                if Checked then
                                    SetVehicleNeonLightEnabled(currentvehicle, 3, Checked)
                                end
                            end)
                            RageUI.Button("Aucun", nil, {}, true, function(_, A, Selected)
                                if Selected then
                                    ngc, ndt, nar, nav = false, false, false, false
                                    Vehicledata.n0 = "false"
                                    Vehicledata.n1 = "false"
                                    Vehicledata.n2 = "false"
                                    Vehicledata.n3 = "false"
                                    for i = 0, 3, 1 do
                                        SetVehicleNeonLightEnabled(currentvehicle, i, false)
                                    end
                                end
                            end)
                            RageUI.Button("Couleur personnalisé", nil, {RightLabel = math.floor(((3.0*prc) / 100) * vehiclePrice) .. "$"}, true, function(_, A, Selected)
                                if Selected then
                                    local R = KeyboardInput("R", "", 3)
                                    local G = KeyboardInput("G", "", 3)
                                    local B = KeyboardInput("B", "", 3)
                                    SetVehicleNeonLightsColour(currentvehicle, R, G, B)
                                    if LS.CanBuy(math.floor(((4.0*prc) / 100) * vehiclePrice)) then
                                        Vehicledata["NeonColours"] = {R, G, B}
                                        LS.BUY(math.floor(((4.0*prc) / 100) * vehiclePrice))
                                        if ngc then
                                            Vehicledata.n0 = "true"
                                        end
                                        if ndt then
                                            Vehicledata.n1 = "true"
                                        end
                                        if nav then
                                            Vehicledata.n2 = "true"
                                        end
                                        if nar then
                                            Vehicledata.n3 = "true"
                                        end
                                    end
                                end
                            end)
                            for k,v in ipairs(currentData.data) do
                                t = {RightLabel = math.floor(((v.cost*prc) / 100) * vehiclePrice) .. "$"}
                                                        
                                RageUI.Button(v.name, nil, t, true, function(_, A, Selected)
                                    if A then
                                        SetVehicleNeonLightsColour(currentvehicle, table.unpack(v.colour))
                                    end
                                    if Selected then
                                        if LS.CanBuy(math.floor(((v.cost*prc) / 100) * vehiclePrice)) then
                                            Vehicledata["NeonColours"] = v.colour
                                            LS.BUY(math.floor(((v.cost*prc) / 100) * vehiclePrice))
                                            if ngc then
                                                Vehicledata.n0 = "true"
                                            end
                                            if ndt then
                                                Vehicledata.n1 = "true"
                                            end
                                            if nav then
                                                Vehicledata.n2 = "true"
                                            end
                                            if nar then
                                                Vehicledata.n3 = "true"
                                            end
                                        else
                                        end
                                    end
                                end)
                            end
                        elseif currentData.title == "Intérieur" then
                            intInd = currentData.data
                            
                            for k,v in pairs(currentData.data) do
                                if Vehicledata["Interior"] == GetVehicleInteriorColour(currentvehicle) then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                                                        
                                RageUI.Button(v.name, nil, t, true, function(_, A, Selected)
                                    if A then
                                        SetVehicleInteriorColour(currentvehicle, k-1)
                                    end
                                    if Selected then
                                        if LS.CanBuy(math.floor(((v.cost) / 100) * vehiclePrice)) then
                                            SetVehicleInteriorColour(currentvehicle, k-1)
                                            Vehicledata["Interior"] = k-1
                                        end
                                    end
                                end)
                            end
                        else
                            for k, v in ipairs(currentData.data) do
                                if Vehicledata[modName] == v.mod or (v.mt == 18 and Vehicledata[modName] == v.bool) then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    if (math.floor((v.cost / 100) * vehiclePrice) > vehiclePrice) then
                                        v.price = v.cost
                                    else
                                        v.price = math.floor((v.cost / 100) * vehiclePrice)
                                    end
                                    t = {RightLabel = v.price .. "$"}
                                end
                                RageUI.Button(
                                    v.name,
                                    nil,
                                    t,
                                    true,
                                    function(_, A, Selected)
                                        if A then
                                            SetVehicleMod(_v, v.mt, v.mod)
                                        end
                                        if Selected then
                                            if LS.CanBuy(v.price) then
                                                if v.mt == 48 then
                                                    stickers = true
                                                end
                                                if (v.mt == 18) then
                                                    Vehicledata[modName] = v.bool
                                                    if (v.bool == true) then
                                                        ToggleVehicleMod(_v, 18, true)
                                                    else
                                                        ToggleVehicleMod(_v, 18, false)
                                                    end
                                                else
                                                    Vehicledata[modName] = v.mod
                                                end
                                                LS.BUY(math.floor(v.price))
                                            else
                                            end
                                        end
                                    end
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("jobs", "LSC_CAT_WHEELS_1")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(colorTab) do
                            RageUI.Button(
                                v.name,
                                nil,
                                {RightLabel = math.floor((v.cost / 100) * vehiclePrice).."$"},
                                true,
                                function(_, A, Selected)
                                    if Selected then
                                        if LS.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                            Vehicledata["Wheel Type"] = v.wtype
                                            Vehicledata["Wheels"] = v.mod
                                            LS.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                        else
                                        end
                                    end
                                    if A then
                                        SetVehicleMod(currentvehicle, v.mt, v.mod)
                                        SetVehicleWheelType(currentvehicle, v.wtype)
                                    end
                                end
                            )
                        end
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("jobs", "LSC_CAT_WHEELS_2")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(colorTab) do
                            RageUI.Button(
                                v.name,
                                nil,
                                {RightLabel = math.floor((v.cost / 100) * vehiclePrice).."$"},
                                true,
                                function(_, A, Selected)
                                    if Selected then
                                        if LS.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                            Vehicledata["Wheel Type"] = v.wtype
                                            if v.mt == 23 then
                                                Vehicledata["Wheels"] = v.mod
                                            else
                                                Vehicledata["Wheels2"] = v.mod
                                            end
                                            LS.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                        else
                                        end
                                    end
                                    if A then
                                        SetVehicleMod(currentvehicle, v.mt, v.mod)
                                        SetVehicleWheelType(currentvehicle, v.wtype)
                                    end
                                end
                            )
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("jobs", "LSC_CAT_WHEELS_3")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(colorTab) do
                            RageUI.Button(
                                v.name,
                                nil,
                                {RightLabel = math.floor((v.cost / 100) * vehiclePrice).."$"},
                                true,
                                function(_, A, Selected)
                                    if A then
                                        SetVehicleExtraColours(
                                            currentvehicle,
                                            tonumber(Vehicledata["ExtraColours"][1]),
                                            v.colour
                                        )
                                    end
                                    if Selected then
                                        if LS.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                            Vehicledata["ExtraColours"][2] = v.colour
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("jobs", "LSC_CAT_COLOR")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        --(dump(currentData))
                        for k, v in pairs(colorTab) do
                            RageUI.Button(
                                k,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        colorrrssTab = v
                                    end
                                end,
                                RMenu:Get("jobs", "LSC_CAT_COLOR_1")
                            )
                        end
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("jobs", "LSC_CAT_COLOR_1")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        --(dump(currentData))
                        for k, v in pairs(colorrrssTab) do
                            local t = {}
                            if indexColor == "Couleurs primaires" then
                                if Vehicledata["Colours"][1] == v.colour then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                            elseif indexColor ~= "Nacrage" then
                                if Vehicledata["Colours"][2] == v.colour then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                            else
                                if Vehicledata["ExtraColours"][1] == v.colour then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                            end
                            RageUI.Button(
                                v.name,
                                nil,
                                t,
                                true,
                                function(_, A, Selected)
                                    if A then
                                        local mod = nil
                                        if indexColor == "Couleurs primaires" then
                                            mod = v.colour
                                            SetVehicleColours(currentvehicle, mod, Vehicledata["Colours"][2])
                                        elseif indexColor ~= "Nacrage" then
                                            mod = v.colour
                                            SetVehicleColours(currentvehicle, Vehicledata["Colours"][1], mod)
                                        else
                                            mod = v.colour
                                            SetVehicleExtraColours(currentvehicle, mod, Vehicledata["ExtraColours"][2])
                                        end
                                    end

                                    if Selected and LS.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                        LS.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                        if indexColor == "Couleurs primaires" then
                                            Vehicledata["Colours"][1] = v.colour
                                        elseif indexColor ~= "Nacrage" then
                                            Vehicledata["Colours"][2] = v.colour
                                        else
                                            Vehicledata["ExtraColours"][1] = v.colour
                                        end
                                        RageUI.GoBack()
                                    end
                                end,
                                RMenu:Get("jobs", "LSC_CAT_COLOR_1")
                            )
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)

function GetVehiclePrice(vehicleModel)
    for k, v in pairs(VehiclePrices) do
        if GetHashKey(v.name) == vehicleModel then
            return v.price
        end
    end

    return 10000
end

function GetVehiclePriceByCategory(vehicle)
    local vehClass = GetVehicleClass(vehicle)
    if (VehiclePricesByCategory["class" .. vehClass] ~= nil) then
        return VehiclePricesByCategory["class" .. vehClass]
    end

    return 10000
end

function OpenLSC()
    if (
        RageUI.Visible(RMenu:Get('jobs', 'LSC')) == true or
        RageUI.Visible(RMenu:Get('jobs', 'LSC_CAT')) == true or
        RageUI.Visible(RMenu:Get('jobs', 'extras')) == true or
        RageUI.Visible(RMenu:Get('jobs', 'LSC_CAT_COLOR')) == true or
        RageUI.Visible(RMenu:Get('jobs', 'LSC_CAT_WHEELS_2')) == true or
        RageUI.Visible(RMenu:Get('jobs', 'LSC_CAT_WHEELS_1')) == true or
        RageUI.Visible(RMenu:Get('jobs', 'LSC_CAT_WHEELS_3')) == true or
        RageUI.Visible(RMenu:Get('jobs', 'LSC_CAT_COLOR_1')) == true
    ) then
        return --[[ Atlantiss.Anticheat:ReportCheat(
            "error",
            "**[USEBUG]** Un employé du LS Custom utilise le glitch du 'klaxon' pour faire des custom gratuites.",
            false
        ) ]]
    end
    if GetVehiclePedIsIn(LocalPlayer().Ped) ~= 0 then
        RageUI.Visible(RMenu:Get("jobs", "LSC"), true)
        currentvehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
        vehicleModel = GetEntityModel(currentvehicle)
        vehiclePrice = GetVehiclePrice(vehicleModel)

        SetVehicleOnGroundProperly(currentvehicle)
        FreezeEntityPosition(currentvehicle, true)
        SetPlayerInvincible(GetPlayerIndex(), true)
        SetEntityInvincible(currentvehicle, true)
        enStickers = GetVehicleMod(currentvehicle, 48)

        for i = 1, 31 do
            customs[i].data = {}
        end
        for i = 1, 31 do
            SetVehicleModKit(currentvehicle, 0)
            if
                GetNumVehicleMods(currentvehicle, customs[i].mod) ~= nil and
                    GetNumVehicleMods(currentvehicle, customs[i].mod) ~= false
            then
                local mt = customs[i].mod
                local startingcost = math.floor((customs[i].startingcost / 100) * vehiclePrice)
                if mt ~= nil then
                    table.insert(customs[i].data, {name = "Aucun", cost = 0, mt = mt, mod = -1})
                    for a = 0, GetNumVehicleMods(currentvehicle, mt) - 1 do
                        local prevmodname = nil
                        local label = GetModTextLabel(currentvehicle, mt, a)
                        if label ~= nil then
                            local modname = tostring(GetLabelText(label))
                            if prevmodname == nil and prevmodname ~= modname then
                                --if modname ~= "NULL" then
                                    local finalCost = (startingcost / vehiclePrice) * 100
                                    table.insert(customs[i].data, {name = modname, cost = finalCost, mt = mt, mod = a})
                                    prevmodname = modname
                                --end
                            end
                        end
                    end
                end
            end
        end

        local turbo
        local tiresmoke
        local xenon
        local neon0
        local neon1
        local neon2
        local neon3
        local neon4
        local bulletproof
        local variation
        local plate = GetVehicleNumberPlateText(currentvehicle)
        if IsToggleModOn(currentvehicle, 18) then
            turbo = "true"
        else
            turbo = "false"
        end
        if IsToggleModOn(currentvehicle, 20) then
            tiresmoke = "true"
        else
            tiresmoke = "false"
        end
        if IsToggleModOn(currentvehicle, 22) then
            xenon = "true"
        else
            xenon = "false"
        end
        if IsVehicleNeonLightEnabled(currentvehicle, 0) then
            neon0 = "true"
        else
            neon0 = "false"
        end
        if IsVehicleNeonLightEnabled(currentvehicle, 1) then
            neon1 = "true"
        else
            neon1 = "false"
        end
        if IsVehicleNeonLightEnabled(currentvehicle, 2) then
            neon2 = "true"
        else
            neon2 = "false"
        end
        if IsVehicleNeonLightEnabled(currentvehicle, 3) then
            neon3 = "true"
        else
            neon3 = "false"
        end
        if GetVehicleTyresCanBurst(currentvehicle) then
            bulletproof = "Non"
        else
            bulletproof = "Oui"
        end
        if GetVehicleModVariation(currentvehicle, 23) then
            variation = "true"
        else
            variation = "false"
        end
        if neon0 == "true" and neon1 == "true" and neon2 == "true" and neon3 == "true" then
            neon4 = 1
        else
            neon4 = 0
        end
        Vehicledata = {
            ["Colours"] = table.pack(GetVehicleColours(currentvehicle)),
            ["ExtraColours"] = table.pack(GetVehicleExtraColours(currentvehicle)),
            ["NeonColours"] = table.pack(GetVehicleNeonLightsColour(currentvehicle)),
            ["SmokeColours"] = table.pack(GetVehicleTyreSmokeColor(currentvehicle)),
            ["Aileron"] = GetVehicleMod(currentvehicle, 0), -- Vehicle Mod 0
            ["Interior"] = GetVehicleInteriorColour(currentvehicle),
            ["Pare-chocs avant"] = GetVehicleMod(currentvehicle, 1), -- Vehicle Mod 1
            ["Pare-chocs arrière"] = GetVehicleMod(currentvehicle, 2), -- Vehicle Mod 2
            ["Bas de caisse"] = GetVehicleMod(currentvehicle, 3), -- Vehicle Mod 3
            ["Échappement"] = GetVehicleMod(currentvehicle, 4), -- Vehicle Mod 4
            ["Cage"] = GetVehicleMod(currentvehicle, 5), -- Vehicle Mod 5
            ["Grille"] = GetVehicleMod(currentvehicle, 6), -- Vehicle Mod 6
            ["Capot"] = GetVehicleMod(currentvehicle, 7), -- Vehicle Mod 7
            ["Aile gauche"] = GetVehicleMod(currentvehicle, 8), -- Vehicle Mod 8
            ["Aile droite"] = GetVehicleMod(currentvehicle, 9), -- Vehicle Mod 9
            ["Toit"] = GetVehicleMod(currentvehicle, 10), -- Vehicle Mod 10
            ["Moteur"] = GetVehicleMod(currentvehicle, 11), -- Vehicle Mod 11
            ["Freins"] = GetVehicleMod(currentvehicle, 12), -- Vehicle Mod 12
            ["Transmission"] = GetVehicleMod(currentvehicle, 13), -- Vehicle Mod 13
            ["Klaxon"] = GetVehicleMod(currentvehicle, 14), -- Vehicle Mod 14
            ["Suspension"] = GetVehicleMod(currentvehicle, 15), -- Vehicle Mod 15
            ["Armour"] = GetVehicleMod(currentvehicle, 16), -- Vehicle Mod 16
            ["Plate"] = GetVehicleNumberPlateTextIndex(currentvehicle), -- Colour of license plate
            ["Fenêtres"] = GetVehicleWindowTint(currentvehicle), -- Window Tint
            ["Wheel Type"] = GetVehicleWheelType(currentvehicle), -- Wheel type
            ["Turbo"] = turbo, -- Turbo
            ["Xenon"] = xenon, -- Xenon Lights
            ["Tyre Smoke"] = tiresmoke, -- Tyre Smoke
            ["Wheels"] = GetVehicleMod(currentvehicle, 23), -- Vehicle Mod 23
            ["Wheels2"] = GetVehicleMod(currentvehicle, 24), -- Vehicle Mod 24
            n0 = neon0, -- Neon 0
            n1 = neon1, -- Neon 1
            n2 = neon2, -- Neon 2
            n3 = neon3, -- Neon 3
            ["Layout"] = neon4,
            ["Variation"] = variation -- Custom Wheels
        }
    else
        RageUI.Popup({message = "~r~Vous devez être dans un véhicule"})
    end
end

function UpdateCar1()
    local currentvehicle = GetVehiclePedIsIn(LocalPlayer().Ped)
    SetVehicleColours(currentvehicle, tonumber(Vehicledata["Colours"][1]), tonumber(Vehicledata["Colours"][2]))
    SetVehicleExtraColours(
        currentvehicle,
        tonumber(Vehicledata["ExtraColours"][1]),
        tonumber(Vehicledata["ExtraColours"][2])
    )
    SetVehicleNumberPlateTextIndex(currentvehicle, tonumber(Vehicledata["Plate"]))
    SetVehicleNeonLightsColour(
        currentvehicle,
        tonumber(Vehicledata["NeonColours"][1]),
        tonumber(Vehicledata["NeonColours"][2]),
        tonumber(Vehicledata["NeonColours"][3])
    )
    SetVehicleTyreSmokeColor(
        currentvehicle,
        tonumber(Vehicledata["SmokeColours"][1]),
        tonumber(Vehicledata["SmokeColours"][2]),
        tonumber(Vehicledata["SmokeColours"][3])
    )
    SetVehicleModKit(currentvehicle, 0)
    SetVehicleMod(currentvehicle, 0, tonumber(Vehicledata["Aileron"]))
    SetVehicleMod(currentvehicle, 1, tonumber(Vehicledata["Pare-chocs avant"]))
    SetVehicleMod(currentvehicle, 2, tonumber(Vehicledata["Pare-chocs arrière"]))
    SetVehicleMod(currentvehicle, 3, tonumber(Vehicledata["Bas de caisse"]))
    SetVehicleMod(currentvehicle, 4, tonumber(Vehicledata["Échappement"]))
    SetVehicleMod(currentvehicle, 5, tonumber(Vehicledata["Cage"]))
    SetVehicleMod(currentvehicle, 6, tonumber(Vehicledata["Grille"]))
    SetVehicleMod(currentvehicle, 7, tonumber(Vehicledata["Capot"]))
    SetVehicleMod(currentvehicle, 8, tonumber(Vehicledata["Aile gauche"]))
    SetVehicleMod(currentvehicle, 9, tonumber(Vehicledata["Aile droite"]))
    SetVehicleMod(currentvehicle, 10, tonumber(Vehicledata["Toit"]))
    SetVehicleMod(currentvehicle, 11, tonumber(Vehicledata["Moteur"]))
    SetVehicleMod(currentvehicle, 12, tonumber(Vehicledata["Freins"]))
    SetVehicleMod(currentvehicle, 13, tonumber(Vehicledata["Transmission"]))
    SetVehicleMod(currentvehicle, 14, tonumber(Vehicledata["Klaxon"]))
    SetVehicleMod(currentvehicle, 15, tonumber(Vehicledata["Suspension"]))
    SetVehicleMod(currentvehicle, 16, tonumber(Vehicledata["Armour"]))
    SetVehicleInteriorColour(currentvehicle, Vehicledata["Interior"])
    if stickers == false then
        if enStickers == -1 then
            SetVehicleMod(currentvehicle, 48, -1)
        else
            SetVehicleMod(currentvehicle, 48, enStickers)
        end
    else
        enStickers = GetVehicleMod(currentvehicle, 48)
        stickers = false
    end
    if Vehicledata["Turbo"] == "true" then
        ToggleVehicleMod(currentvehicle, 18, true)
    else
        ToggleVehicleMod(currentvehicle, 18, false)
    end
    if Vehicledata["Tyre Smoke"] == "true" then
        ToggleVehicleMod(currentvehicle, 20, true)
    else
        ToggleVehicleMod(currentvehicle, 20, false)
    end
    if Vehicledata["Xenon"] == "true" then
        ToggleVehicleMod(currentvehicle, 22, true)
    else
        ToggleVehicleMod(currentvehicle, 22, false)
    end
    SetVehicleWheelType(currentvehicle, tonumber(Vehicledata["Wheel Type"]))
    SetVehicleMod(currentvehicle, 23, tonumber(Vehicledata["Wheels"]))
    SetVehicleMod(currentvehicle, 24, tonumber(Vehicledata["Wheels2"]))
    if Vehicledata["Variation"] == "true" then
        SetVehicleMod(currentvehicle, 23, GetVehicleMod(currentvehicle, 23), true)
        -- Vehicle Mod 23
        SetVehicleMod(currentvehicle, 24, GetVehicleMod(currentvehicle, 24), true)
    -- Vehicle Mod 24
    end
    if Vehicledata.n0 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle, 0, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle, 0, false)
    end
    if Vehicledata.n1 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle, 1, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle, 1, false)
    end
    if Vehicledata.n2 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle, 2, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle, 2, false)
    end
    if Vehicledata.n3 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle, 3, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle, 3, false)
    end
    if Vehicledata.bp == "true" then
        SetVehicleTyresCanBurst(currentvehicle, false)
    else
        SetVehicleTyresCanBurst(currentvehicle, true)
    end
    SetVehicleWindowTint(currentvehicle, tonumber(Vehicledata["Fenêtres"]))

    TriggerServerCallback(
        "core:GetVehicleOwnedX",
        function(b)
            if b then
                TriggerServerEvent(
                    "vehicle:SetProperties",
                    GetVehicleNumberPlateText(currentvehicle),
                    vehicleFct.GetVehicleProperties(currentvehicle)
                )
            else
                --    ShowNotification("~r~Véhicule inexistant")
            end
        end,
        GetVehicleNumberPlateText(currentvehicle)
    )
end