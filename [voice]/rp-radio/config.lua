radioConfig = {
    Controls = {
        Activator = {
            -- Open/Close Radio
            Name = "INPUT_DROP_AMMO", -- Control name
            Key = 57 -- F2
        },
        Secondary = {
            Name = "INPUT_SPRINT",
            Key = 21, -- Left Shift
            Enabled = true -- Require secondary to be pressed to open radio with Activator
        },
        Toggle = {
            -- Toggle radio on/off
            Name = "INPUT_CONTEXT", -- Control name
            Key = 51 -- E
        },
        Increase = {
            -- Increase Frequency
            Name = "INPUT_CELLPHONE_RIGHT", -- Control name
            Key = 175, -- Right Arrow
            Pressed = false
        },
        Decrease = {
            -- Decrease Frequency
            Name = "INPUT_CELLPHONE_LEFT", -- Control name
            Key = 174, -- Left Arrow
            Pressed = false
        },
        Input = {
            -- Choose Frequency
            Name = "INPUT_FRONTEND_ACCEPT", -- Control name
            Key = 201, -- Enter
            Pressed = false
        },
        vIncrease = {
            -- Choose Volume
            Name = "INPUT_SCRIPTED_FLY_ZUP", -- Control name
            Key = 10, -- Page Up
            Pressed = false
        },
        vDecrease = {
            -- Decrease Volume
            Name = "INPUT_SCRIPTED_FLY_ZDOWN", -- Control name
            Key = 11, -- Page Down
            Pressed = false
        },
        Broadcast = {
            Name = "INPUT_VEH_PUSHBIKE_SPRINT", -- Control name
            Key = 137 -- Caps Lock
        },
        ToggleClicks = {
            -- Toggle radio click sounds
            Name = "INPUT_SELECT_WEAPON", -- Control name
            Key = 37 -- Tab
        }
    },
    Frequency = {
        Private = {}, -- List of private frequencies
        Current = 137, -- Don't touch
        CurrentIndex = 1, -- Don't touch
        Min = 137, -- Minimum frequency
        Max = 850, -- Max number of frequencies
        List = {}, -- Frequency list, Don't touch
        Access = {} -- List of freqencies a player has access to
    },
    Volume = {
        Current = 1.00,
        Min = 0.0,
        Max = 1.6
    },
    AllowRadioWhenClosed = true -- Allows the radio to be used when not open (uses police radio animation)
}
