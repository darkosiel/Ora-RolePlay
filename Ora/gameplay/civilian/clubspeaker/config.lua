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
    }
  }
end