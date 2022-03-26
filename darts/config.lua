Config = {}
Config.cleanBoardButton = 194 -- 
Config.cleanBoardButtonName = "~INPUT_FRONTEND_RRIGHT~"

Config.addYourNameButton = 191 -- Enter
Config.addYourNameButtonName = "~INPUT_FRONTEND_RDOWN~" -- 

Config.changeRuleDartsButton = 157 -- 1
Config.changeRuleDartsButtonName = "~INPUT_SELECT_WEAPON_UNARMED~"

Config.changeRulePointsButton = 158 -- 
Config.changeRulePointsButtonName = "~INPUT_SELECT_WEAPON_MELEE~"

Config.changeRuleDifficultyButton = 160 -- 
Config.changeRuleDifficultyButtonName = "~INPUT_SELECT_WEAPON_SHOTGUN~"

Config.rotateButton = 25 -- 
Config.rotateButtonName = "~INPUT_AIM~"

Config.exitButton = 194
Config.exitButtonName = "~INPUT_FRONTEND_RRIGHT~"

Config.throwButton = 86 -- 
Config.throwButtonName = "~INPUT_VEH_HORN~"

Config.playercancelRaceButton = 194-- Backspace
Config.playercancelRaceButtonName = "~INPUT_FRONTEND_RRIGHT~"-- Backspace

Config.marker = {
	type = 27,
	rgba = {519, 0, 105, 255},
	height = 0.5,
	size = 1.0

}

-- Helptext
Config.helptext = {}
Config.helptext.x = 0.0 -- Changing this is tricky, may cause problems 
Config.helptext.y = 0.0-- Changing this is tricky, may cause problems (x 0.8 y 0.85 bottom right corner)
Config.helptext.color = 5 -- over 200 colors 1 - 225


lang = {
	["clean_board"] = " Tout effacer",
	["write_your_name"] = " Rejoindre",
	["change_rule_darts"] = " Changer le nombre de fléchettes",
	["change_rule_points"] = " Changer le nombre de points",
	["change_rule_difficulty"] = " Changer la difficulté",
	["points"] = "Points",
	["darts"] = "Fléchettes",
	["difficulty"] = "Difficulté",
	["rules"] = "Règles",
	["throw"] = " Tirer",
	["rotate"] = " Ajuster/Viser",
	["exit"] = " Sortir",
	

}

-- Spawn dartboards where ever you want 
Config.spawnDartboards = {
	--vec4(1345.0, 3151.0, 41.0, 360.0), 
	--vec4(1355.0, 3151.0, 41.0, 360.0),
}


