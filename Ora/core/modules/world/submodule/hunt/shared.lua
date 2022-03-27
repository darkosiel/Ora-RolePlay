Ora.World.Animals = {
  spawn = {
    timeInterval = 5.0, -- minutes
    stop = false, -- don't touch
    random = {}, -- don't touch
    model = { -- hash(https://docs.fivem.net/docs/game-references/ped-models/#animals) /// chance = percentage chance of animal spawn
      {hash = "a_c_deer", chance = 35},
      {hash = "a_c_boar", chance = 20},
      {hash = "a_c_rabbit_01", chance = 10},
      {hash = "a_c_mtlion", chance = 5},
      {hash = "a_c_coyote", chance = 20},
      {hash = "a_c_chickenhawk", chance = 10}
    },
  },
  huntingZone = PolyZone:Create({ -- don't touch, create with PolyZone script
    vector2(-586.91088867188, 3954.0913085938),
    vector2(-1002.1473388672, 4114.0908203125),
    vector2(-1069.8991699219, 4252.0517578125),
    vector2(-1256.51953125, 4266.9409179688),
    vector2(-1343.2833251953, 4126.0561523438),
    vector2(-1474.0047607422, 4156.1870117188),
    vector2(-1687.6403808594, 4199.8305664062),
    vector2(-1996.7602539062, 4384.2666015625),
    vector2(-1972.2764892578, 4535.10546875),
    vector2(-1654.9104003906, 4787.6796875),
    vector2(-1352.3585205078, 5059.806640625),
    vector2(-847.10437011719, 4648.3369140625),
    vector2(-94.164131164551, 4476.2431640625)
  }, {
    name = "hunting",
    minZ = 1.00,
    maxZ = 240.00
  })
}