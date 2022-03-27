ATMRobberyConfig = {
    ["money"] = {
        type = "clear",
        amount = {200, 500}
    },
    ["xp"] = {1300, 2600},
    itemRequired = "stickybomb",
    policeRequired = Ora.Illegal:GetCopsRequired("atm"),
    policeType = {"police", "lssd"}
}
    