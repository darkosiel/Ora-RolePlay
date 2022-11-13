fx_version 'cerulean'

games { 'gta5' }

lua54 'yes'

files {
    "gameplay/illegal/jewelry/audio/audio_bank/jewelry_heist_sound_bank.awc",
}

data_files "AUDIO_WAVEPACK" 'gameplay/illegal/jewelry/audio/audio_bank'

client_scripts {
    "gameplay/illegal/jewelry/config.lua",
    "gameplay/illegal/jewelry/sh_*.lua",
    "gameplay/illegal/jewelry/cl_*.lua"
}

server_scripts {
    "gameplay/illegal/jewelry/config.lua",
    "gameplay/illegal/jewelry/sh_*.lua",
    "gameplay/illegal/jewelry/sv_*.lua"
}