-- CLIENT CONFIGURATION
config_cl = {
    joinProximity = 25,                 -- Proximity to draw 3D text and join race
    joinKeybind = 51,                   -- Keybind to join race ("E" by default)
    betKeybind = 305,                   -- Keybind to bet on a race ("B")
    leaveKeybind = 51,                  -- Keybind to leave the race ("E")
    joinDuration = 30000,               -- Duration in ms to allow players to join the race
    freezeDuration = 5000,              -- Duration in ms to freeze players and countdown start (set to 0 to disable)
    checkpointProximity = 18.0,         -- Proximity to trigger checkpoint in meters                                            - default 25.0
    checkpointRadius = 20.0,            -- Radius of 3D checkpoints in meters (set to 0 to disable cylinder checkpoints)        - default 25.0
    checkpointHeight = 15.0,            -- Height of 3D checkpoints in meters                                                   - default 10.0
    checkpointBlipColor = 25,           -- Color of checkpoint map blips and navigation (see SetBlipColour native reference)    - default 5
    hudEnabled = false,                 -- Enable racing HUD with time and checkpoints                                          - default true
    hudPosition = vec(0.015, 0.725)     -- Screen position to draw racing HUD
}

-- SERVER CONFIGURATION
config_sv = {
    finishTimeout = 180000,             -- Timeout in ms for removing a race after winner finishes
    notifyOfWinner = true               -- Notify all players of the winner (false will only notify the winner)
}
