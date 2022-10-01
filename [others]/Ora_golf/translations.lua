Translations = {}

function _(str, ...) -- Translate string
    if Translations[Config.TranslationSelected] ~= nil then
        if Translations[Config.TranslationSelected][str] ~= nil then
            return string.format(Translations[Config.TranslationSelected][str], ...)
        else
            return 'Translation [' .. Config.TranslationSelected .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. Config.TranslationSelected .. '] does not exist'
    end
end

function _U(str, ...) -- Translate string first char uppercase
    return tostring(_(str, ...):gsub('^%l', string.upper))
end

Translations['en'] = {
    ['help_flag_remove'] = '~INPUT_CONTEXT~ Retirer le trou sélectionné',
    ['help_flag_select'] = '~INPUT_CONTEXT~ Selectionner le trou',
    ['help_select_ball'] = '~INPUT_CONTEXT~ Selectionner la balle\n~INPUT_LOOK_BEHIND~ Ramasser la balle',
    ['help_need_club'] = '~r~Vous devez avoir~w~ un club de golf !',
    ['noti_noflagselected'] = 'Vous devez avoir choisit un drapeau !.',
    ['blip_flag'] = 'Drapeau',
    ['blip_ball'] = 'Balle de golf',
    ['button_drawline'] = 'Tracer une ligne jusquau trou',
    ['button_terraingrid'] = 'Afficher le terrain On / Off',
    ['button_bigmap'] = 'Grosse carte On / Off',
    ['button_topcam'] = 'Camera drone',
    ['button_flagcam'] = 'Camera drapeau',
    ['button_changeclub'] = 'Changer de club',
    ['button_hit'] = 'Tirer (rester appuyer)',
    ['button_left'] = 'Bouger Gauche',
    ['button_right'] = 'Bouger Droite',
    ['button_exit'] = 'Quitter',
    ['2dtext_club'] = 'Club',
    ['2dtext_distanceflag'] = 'Distance Trou',
    ['2dtext_noselected'] = 'Non selectionné',
    ['2dtext_hitted_distance'] = 'Distance',
    ['landed_water'] = 'La balle est perdue.',
    ['club_wood'] = 'Wood',
    ['club_iron'] = 'Iron',
    ['club_wedge'] = 'Wedge',
    ['club_putter'] = 'Putter',
    -- formatteds
    ['2dtext_distancemeter'] = '%s mètres',
    ['midmessage_newrecord'] = 'Nouveau record : %s mètres',
    ['midmessage_putball'] = 'Distance: %s mètres'
}

Translations['hu'] = {
    ['help_flag_remove'] = '~INPUT_CONTEXT~ Zászló jelölés törlése',
    ['help_flag_select'] = '~INPUT_CONTEXT~ Zászló kijelölése',
    ['help_select_ball'] = '~INPUT_CONTEXT~ Labda kiválasztása\n~INPUT_LOOK_BEHIND~ Labda felvétele',
    ['help_need_club'] = '~r~Szükséges ~w~golfütö!',
    ['noti_noflagselected'] = 'Nincs kiválasztva zászló!',
    ['blip_flag'] = 'Golf zászló',
    ['blip_ball'] = 'Golflabda',
    ['button_drawline'] = 'Vonal meghúzása',
    ['button_terraingrid'] = 'Zónák be/ki',
    ['button_bigmap'] = 'Nagytérkép be/ki',
    ['button_topcam'] = 'Top kamera',
    ['button_flagcam'] = 'Zászló kamera',
    ['button_changeclub'] = 'Ütö váltás',
    ['button_hit'] = 'Ütés (nyomvatartva)',
    ['button_left'] = 'Balra fordulás',
    ['button_right'] = 'Jobbra fordulás',
    ['button_exit'] = 'Kilépés',
    ['2dtext_club'] = 'Ütö',
    ['2dtext_distanceflag'] = 'Zászló távolság',
    ['2dtext_noselected'] = 'Nincs kiválasztva',
    ['2dtext_hitted_distance'] = 'Távolság',
    ['landed_water'] = 'Vízbe landolt a golflabda.',
    ['club_wood'] = 'Wood',
    ['club_iron'] = 'Iron',
    ['club_wedge'] = 'Wedge',
    ['club_putter'] = 'Putter',
    -- formatteds
    ['2dtext_distancemeter'] = '%s méter',
    ['midmessage_newrecord'] = 'Új rekord: %s méter',
    ['midmessage_putball'] = 'Távolság: %s méter'
}
