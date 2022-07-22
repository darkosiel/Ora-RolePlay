Ora.Consumable:Register("Alcohol")

Ora.Consumable.Alcohol = {
  Object = {},
  Settings = {
    [1] = { -- Bottles
      options = {
        {
          event = "Ora::CE::Consumable::Alcohol::Drink",
          icon = "fas fa-beer",
          label = "Boire"
        },
        {
          event = "Ora::CE::Consumable::Alcohol::StoreIntoInventory",
          icon = "fas fa-hand-lizard",
          label = "Ranger"
        }
      },
      distance = 1.5
    },
    [2] = { -- Beer
      options = {
        {
          event = "Ora::CE::Consumable::Alcohol::Drink",
          icon = "fas fa-beer",
          label = "Prendre"
        }
      },
      distance = 1.5
    },
    [3] = { -- Bong
      options = {
        {
          event = "Ora::CE::Consumable::Alcohol::Drink",
          icon = "fas fa-bong",
          label = "Fumer"
        },
        {
          event = "test2",
          icon = "fas fa-hand-lizard",
          label = "Ranger"
        }
      },
      distance = 1.5
    }
  },
  Bottles ={
    ["whisky"] = {
      bottle = "p_whiskey_notop",
      glass = 'ex_p_ex_tumbler_01_s',
      anim = {
        dict = "anim@safehouse@whisky",
        ped = "drink_whisky_stage2",
        bottle = "drink_whisky_stage2_bottle",
        glass = "drink_whisky_stage2_tumbler",
        rotation = 180.0,
        duration = 9000
      },
      settings = 1,
      count = 2
    },
    ["vodka"] = {
      bottle = "prop_vodka_bottle",
      glass = "ex_p_ex_tumbler_02_s",
      anim = {
        dict = "anim@safehouse@whisky",
        ped = "drink_whisky_stage2",
        bottle = vector3(0.10, -0.15, -0.15),
        glass = "drink_whisky_stage2_tumbler",
        rotation = 180.0,
        duration = 9000
      },
      settings = 1,
      count = 10
    },
    ["champagne"] = {
      bottle = "prop_vodka_bottle",
      glass = "ex_p_ex_tumbler_02_s",
      anim = {
        dict = "anim@safehouse@whisky",
        ped = "drink_whisky_stage2",
        bottle = vector3(0.10, -0.15, -0.15),
        glass = "drink_whisky_stage2_tumbler",
        rotation = 180.0,
        duration = 9000
      },
      settings = 1,
      count = 10
    },
    ["cognac"] = {
      bottle = "prop_bottle_cognac",
      glass = 'ex_p_ex_tumbler_01_s',
      anim = {
        dict = "anim@safehouse@whisky",
        ped = "drink_whisky_stage2",
        bottle = vector3(0.10, -0.15, -0.15),
        glass = "drink_whisky_stage2_tumbler",
        rotation = 180.0,
        duration = 9000
      },
      settings = 1,
      count = 8
    },
    ["rhum"] = {
      bottle = "prop_rum_bottle",
      glass = 'ex_p_ex_tumbler_01_s',
      anim = {
        dict = "anim@safehouse@whisky",
        ped = "drink_whisky_stage2",
        bottle = vector3(0.10, -0.10, -0.15),
        glass = "drink_whisky_stage2_tumbler",
        rotation = 180.0,
        duration = 9000
      },
      settings = 1,
      count = 6
    },
    ["tequila"] = {
      bottle = "prop_tequila_bottle",
      glass = "ex_p_ex_tumbler_02_s",
      anim = {
        dict = "anim@safehouse@whisky",
        ped = "drink_whisky_stage2",
        bottle = vector3(0.10, -0.15, -0.15),
        glass = "drink_whisky_stage2_tumbler",
        rotation = 180.0,
        duration = 9000
      },
      settings = 1,
      count = 8
    },
    ["red_wine"] = {
      bottle = "prop_wine_bot_01",
      glass = "p_wine_glass_s",
      anim = {
        dict = "mp_safehousewine@",
        ped = "drinking_wine",
        bottle = "drinking_wine_bottle",
        glass = "drinking_wine_glass",
        rotation = 0.0,
        duration = 15000
      },
      settings = 1,
      count = 6
    },
    ["white_wine"] = {
      bottle = "prop_wine_white",
      glass = "prop_drink_whtwine",
      anim = {
        dict = "mp_safehousewine@",
        ped = "drinking_wine",
        bottle = "drinking_wine_bottle",
        glass = "drinking_wine_glass",
        rotation = 0.0,
        duration = 15000
      },
      settings = 1,
      count = 6
    },
    ["high_quality_wine"] = {
      bottle = "prop_wine_red",
      glass = "p_wine_glass_s",
      anim = {
        dict = "mp_safehousewine@",
        ped = "drinking_wine",
        bottle = "drinking_wine_bottle",
        glass = "drinking_wine_glass",
        rotation = 0.0,
        duration = 15000
      },
      settings = 1,
      count = 6
    },
    ["beer"] = {
      bottle = "prop_beer_logopen",
      anim = {
        dict = "mp_common",
        name = "givetake1_b"
      },
      anim2 = {
        dict = "mp_safehousebeer@",
        name = "enter",
      },
      settings = 2,
      count = 3
    },
    ["beer2"] = {
      bottle = "prop_amb_beer_bottle",
      anim = {
        dict = "mp_common",
        name = "givetake1_b"
      },
      anim2 = {
        dict = "mp_safehousebeer@",
        name = "enter",
      },
      settings = 2,
      count = 3
    },
    ["bong"] = {
      bottle = "prop_bong_01",
      glass = "p_cs_lighter_01",
      anim = {
        dict = "anim@safehouse@bong",
        ped = "bong_stage1",
        bottle = "bong_stage1_bong",
        glass = "bong_stage1_lighter",
        rotation = 180.0,
        duration = 9000
      },
      settings = 3,
      count = 6
    }
  }
}