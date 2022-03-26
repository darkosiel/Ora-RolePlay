local TreasureHunt = {}
local hintShown = false

local function setupTreasureHunt()
    if (ConfigTreasureHunt ~= nil and ConfigTreasureHunt.Hints ~= nil) then
        for key, hintValue in pairs(ConfigTreasureHunt.Hints) do
            -- create NPC if registered
            if hintValue.npc ~= nil then
                Ped:Add(
                    "Chasse au tresor",
                    hintValue.npc,
                    {
                        x = hintValue.position.x,
                        y = hintValue.position.y,
                        z = hintValue.position.z,
                        a = hintValue.heading
                    },
                    nil
                )
            end
            -- create Zone & Marker
            if hintValue.position ~= nil then
                Zone:Add(hintValue.position, TreasureHunt.EnterZone, TreasureHunt.ExitZone, hintValue.id, 3.0)
            end
        end
    end
end

local CurrentZone = nil
function TreasureHunt.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour découvrir la prochaine étape")
    KeySettings:Add("keyboard", "E", TreasureHunt.ShowHint, zone)
    KeySettings:Add("controller", 46, TreasureHunt.ShowHint, zone)
    CurrentZone = zone
end

function TreasureHunt.ExitZone()
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", CurrentZone)
        CurrentZone = nil
    end

    if hintShown == true then
        hintShown = false
    end
end

function TreasureHunt.ShowHint()
    if (CurrentZone ~= nil) then
        if (ConfigTreasureHunt ~= nil and ConfigTreasureHunt.Hints ~= nil) then
            for key, hintValue in pairs(ConfigTreasureHunt.Hints) do
                -- create NPC if registered
                if hintValue.id == CurrentZone then
                    TriggerEvent("TreasureHunt:showHint", hintValue.nextHint, hintValue.rewardNumber)
                    break
                end
            end
        end
    else
        ShowNotification("~r~Erreur : Veuillez sortir et revenir sur la zone~s~")
    end
end

if (ConfigTreasureHunt ~= nil and ConfigTreasureHunt.Activated ~= nil and ConfigTreasureHunt.Activated == true) then
    setupTreasureHunt()
end
