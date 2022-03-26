To ensure all modit.store scripts load correctly, we can use the following method to assure the http request has responded before firing another.

in the config.lua file provided, add your script names to the `Config.Mods` table.

E.G:
I purchased allhousing/playerhousing V2 and furni v2, I add to the Config.Mods table:
Config.Mods = {'allhousing','furni'}

NOTE:
Mod name correlates with server side event name which precedes the obfuscated string.