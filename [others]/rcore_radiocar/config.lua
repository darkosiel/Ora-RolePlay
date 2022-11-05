Config = {}

-- What mysql should be active?

-- What type of mysql you want?
-- 0 No mysql
-- 1 oxmysql (if you have older version where mysql-async bridge does not exists turn this on)
-- 2 Mysql async
-- 3 ghmattimysql
Config.MysqlType = 0

-- 0 standalone
-- 1 ESX
-- 2 QBCore
Config.FrameWork = 0

-- esx object share
Config.ESX_Object = "esx:getSharedObject"

Config.GetQBCoreObject = function()
    -- Choose your objectType or made here your own.
    local objectType = 1

    if objectType == 1 then
        return exports['qb-core']:GetCoreObject()
    end

    if objectType == 2 then
        return exports['qb-core']:GetSharedObject()
    end

    if objectType == 3 then
        local QBCore = nil
        local breakPoint = 0
        while not QBCore do
            Wait(100)
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)

            breakPoint = breakPoint + 1
            if breakPoint == 25 then
                print(string.format("^1[%s]^7 Could not load the sharedobject, are you sure it is called ^1˙QBCore:GetObject˙^7?", GetCurrentResourceName()))
                break
            end
        end

        return QBCore
    end
end

-- Debug
Config.Debug = false

-- how much volume will adjust each +/- button
Config.VolumeAdjust = 0.05

-- Should this be opened only from command ?
Config.EnableCommand = true

-- Name for the command ?
Config.CommandLabel = "radiocar"

-- Key to open radio
Config.KeyForRadio = "."

-- Distance playing from car
Config.DistancePlaying = 4.0

-- Distance playing from car if windows are closed / or if he has open any door
Config.DistancePlayingWindowsOpen  = 10.0

--  if the engine is off the music will be disabled until the engine is on
Config.DisableMusicAfterEngineIsOFF = false

-- Only owner of the car can play a music from the vehicle.
Config.OnlyOwnerOfTheCar = false

-- Radio in car can be used only for people who own the car
-- this can prevent from trolling streamers, i believe many kids
-- will try play some troll music and try to get streamer banned.
Config.OnlyOwnedCars = false

-- this will only let use cars that have installed radio as an item in the car
-- means no car without installed radio before can use it..
-- you have to implement it somewhere by yourself.
-- if you wish to know more about this, please read "readme.md"
Config.OnlyCarWhoHaveRadio = false

-- Default music volume
Config.defaultVolume = 0.3

-- who can touch the radio from what seat?
-- https://docs.fivem.net/natives/?_0xBB40DD2270B65366
Config.AllowedSeats = {
    [-1] = true,
    [0] = true,
}

-- if you have some car that has big speakers or something like that
-- you can increase/decrease distance of playing music
Config.CustomDistanceForVehicles = {
   --[GetHashKey("sultan")] = 100,
}

-- Blacklisted vehicles
Config.blacklistedCars = {
    -- bikes
    GetHashKey("bmx"),
    GetHashKey("cruiser"),
    GetHashKey("fixter"),
    GetHashKey("scorcher"),
    GetHashKey("tribike"),
    GetHashKey("tribike2"),
    GetHashKey("tribike3"),
    GetHashKey("manchez"),
    GetHashKey("sanchez"),
    GetHashKey("sanchez2"),
    -----
    GetHashKey("akuma"),
    GetHashKey("avarus"),
    GetHashKey("sanchez2"),
    GetHashKey("bagger"),
    GetHashKey("bati"),
    GetHashKey("bati2"),
    GetHashKey("bf400"),
    GetHashKey("carbonrs"),
    GetHashKey("chimera"),
    GetHashKey("cliffhanger"),
    GetHashKey("daemon"),
    GetHashKey("daemon2"),
    GetHashKey("defiler"),
    GetHashKey("deathbike"),
    GetHashKey("deathbike2"),
    GetHashKey("deathbike3"),
    GetHashKey("diablous"),
    GetHashKey("diablous2"),
    GetHashKey("double"),
    GetHashKey("enduro"),
    GetHashKey("esskey"),
    GetHashKey("faggio"),
    GetHashKey("faggio2"),
    GetHashKey("faggio3"),
    GetHashKey("fcr"),
    GetHashKey("fcr2"),
    GetHashKey("gargoyle"),
    GetHashKey("hexer"),
    GetHashKey("innovation"),
    GetHashKey("lectro"),
    GetHashKey("nemesis"),
    GetHashKey("nightblade"),
    GetHashKey("oppressor"),
    GetHashKey("oppressor2"),
    GetHashKey("pcj"),
    GetHashKey("ratbike"),
    GetHashKey("ruffian"),
    GetHashKey("herrocketxer"),
    GetHashKey("rrocket"),
    GetHashKey("sanctus"),
    GetHashKey("shotaro"),
    GetHashKey("sovereign"),
    GetHashKey("stryder"),
    GetHashKey("thrust"),
    GetHashKey("vader"),
    GetHashKey("vindicator"),
    GetHashKey("vortex"),
    GetHashKey("wolfsbane"),
    GetHashKey("zombiea"),
    GetHashKey("zombieb"),
    GetHashKey("manchez2"),
    -- other
    GetHashKey("thruster"),
}

-- this whitelist isnt really a whitelist..
-- if you set for an example "anyBoat = false"
-- you can allow one boat from other many to use radio.
Config.whitelistedCars = {-- car
    --GetHashKey("car name here"),
}

-- Blacklisted categories vehicles
Config.blackListedCategories = {
    anyVehicle = true,
    anyBoat = true,
    anyHeli = false,
    anyPlane = true,
    anyCopCar = true,
    anySub = false,
    anyTaxi = true,
    anyTrain = true,
}

-- List default station for radio
-- please dont add more than 6.. if you add more than 6 you need to edit html
Config.defaultList = {
    {
        label = "Music 1",
        url = "",
    },
    {
        label = "Music 2",
        url = "",
    },
    {
        label = "Music 3",
        url = "",
    },
    {
        label = "Music 4",
        url = "",
    },
    {
        label = "Music 5",
        url = "",
    },
    {
        label = "Music 6",
        url = "",
    },
}

-- How much ofter the player position is updated ?
Config.RefreshTime = 200

-- how much close player has to be to the sound before starting updating position ?
Config.distanceBeforeUpdatingPos = 40

-- Message list
Config.Messages = {
    ["streamer_on"]  = "Streamer mode is on. From now you will not hear any music/sound.",
    ["streamer_off"] = "Streamer mode is off. From now you will be able to listen to music that players might play.",
}

-- if you want xsound separated from radiocar then turn this on.
Config.UseExternalxSound = false

-- if you want to use high_3dsounds
Config.UseHighSound = false

-- name of the lib
Config.xSoundName = "xsound"

if Config.UseHighSound then
    Config.UseExternalxSound = true
    Config.xSoundName = "high_3dsounds"

    Config.DistancePlaying = Config.DistancePlaying * 3
    Config.DistancePlayingWindowsOpen  = Config.DistancePlayingWindowsOpen * 3
end