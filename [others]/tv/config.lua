Config = {}

Config['URL'] = 'https://www.youtube.com/embed/%s?autoplay=1&controls=1&disablekb=1&fs=0&rel=0&showinfo=0&iv_load_policy=3&start=%s'
-- Config['URL'] = 'https://www.youtube.com/watch?v=%s&t=%s' -- use this if you want to be able to play copyrighted stuff. please note that ads will pop up every now and again, and full screen doesn't work
Config['API'] = {
    ['URL'] = 'https://www.googleapis.com/youtube/v3/videos?id=%s&part=contentDetails&key=%s',
    ['Key'] = ''
}
Config['DurationCheck'] = false -- this will automatically delete the browser (good for ram i guess?) once the video has finished (REQUIRES YOU TO ADD AN API KEY!!!!!)

Config['Objects'] = {
    {
        ['Object'] = 'prop_tv_flat_01',
        ['Scale'] = 0.05,
        ['Offset'] = vec3(-0.925, -0.055, 1.0),
        ['Distance'] = 20.0,
    },
    {
        ['Object'] = 'prop_tv_flat_michael',
        ['Scale'] = 0.035,
        ['Offset'] = vec3(-0.675, -0.055, 0.4),
        ['Distance'] = 20.0,
    },
    {
        ['Object'] = 'ex_prop_ex_tv_flat_01',
        ['Scale'] = 0.055,
        ['Offset'] = vec3(-0.990, -0.055, 1.05),
        ['Distance'] = 20.0,
    },
    {
        ['Object'] = 'prop_trev_tv_01',
        ['Scale'] = 0.012,
        ['Offset'] = vec3(-0.225, -0.01, 0.26),
        ['Distance'] = 20.0,
    },
    {
        ['Object'] = 'prop_tv_flat_03b',
        ['Scale'] = 0.016,
        ['Offset'] = vec3(-0.3, -0.062, 0.18),
        ['Distance'] = 20.0,
    },
    {
        ['Object'] = 'prop_tv_flat_03',
        ['Scale'] = 0.016,
        ['Offset'] = vec3(-0.3, -0.01, 0.4),
        ['Distance'] = 20.0,
    },
    {
        ['Object'] = 'prop_tv_flat_02b',
        ['Scale'] = 0.026,
        ['Offset'] = vec3(-0.5, -0.012, 0.525),
        ['Distance'] = 20.0,
    },
    {
        ['Object'] = 'prop_tv_flat_02',
        ['Scale'] = 0.026,
        ['Offset'] = vec3(-0.5, -0.012, 0.525),
        ['Distance'] = 20.0,
    },
    {
        ['Object'] = 'prop_tv_flat_02',
        ['Scale'] = 0.026,
        ['Offset'] = vec3(-0.5, -0.012, 0.525),
        ['Distance'] = 20.0,
    },
}

Strings = {
    ['VideoHelp'] = 'Tapez ~b~/tv ~y~youtube id~s~ pour lire une vidéo.\nExemple : ~b~/tv ~y~3hqjseATp4g~s~',
    ['VolumeHelp'] = 'Tapez ~b~/volume ~y~(0-10)~s~ pour modifier le volume.\nExemple : ~b~/volume ~y~5~s~\n\nTapez ~b~/tv ~y~youtube id~s~ pour modifier la vidéo.\nExemple : ~b~/tv ~y~3hqjseATp4g~s~\n\nTapez ~b~/stop~s~ pour arrêter la vidéo\n\n~INPUT_CONTEXT~ Synchroniser la vidéo',
}