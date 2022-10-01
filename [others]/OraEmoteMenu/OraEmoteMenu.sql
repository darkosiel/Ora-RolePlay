CREATE TABLE IF NOT EXISTS ora_emote_menu_favorite (
    player_id varchar(255) NOT NULL,
    emote varchar(255) NOT NULL,
    PRIMARY KEY (emote, player_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;