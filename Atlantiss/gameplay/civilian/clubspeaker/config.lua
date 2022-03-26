function Config()
  speaker = {
    unicorn = {
      name = "unicorn", -- name job
      label = "Unicorn", -- label Orga/Job2
      interiorId = 197121,
      playlist = playlist.unicorn,
      volume = 5,
      canOpen = false, -- Défaut
      inclub = false, -- Défaut
      play = false, -- Défaut
      pos = vector3(121.965, -1281.300, 29.00), -- Menu
      soundpos = vector3(110.325, -1288.025, 30.25) -- Pos diffusion du son
    },
  
    night = {
      name = "night",
      label = "Night-Club",
      interiorId = 271617,
      playlist = playlist.night,
      canOpen = false,
      inclub = false,
      play = false,
      pos = vector3(-1603.868, -3012.695, -78.50),
      soundpos = vector3(-1603.868, -3012.695, -78.50)
    },

    restaurant = {
      name = "restaurant",
      label = "Restaurant",
      interiorId = 121602,
      playlist = playlist.restaurant,
      canOpen = false,
      inclub = false,
      play = false,
      pos = vector3(-1831.436, -1190.354, 19.88),
      soundpos = vector3(-1823.167, -1186.24, 21.60)
    }
  }
end