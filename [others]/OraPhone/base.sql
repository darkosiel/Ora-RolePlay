-- Suppression des tables
DROP TABLE IF EXISTS ora_phone;
DROP TABLE IF EXISTS ora_phone_contacts;
DROP TABLE IF EXISTS ora_phone_conversations;
DROP TABLE IF EXISTS ora_phone_messages;
DROP TABLE IF EXISTS ora_phone_call_history;
DROP TABLE IF EXISTS ora_phone_image;
DROP TABLE IF EXISTS ora_phone_richtermotorsport;
DROP TABLE IF EXISTS ora_phone_richtermotorsport_favorite;
DROP TABLE IF EXISTS ora_phone_maps_favorite;
DROP TABLE IF EXISTS ora_phone_notes_folder;
DROP TABLE IF EXISTS ora_phone_notes_note;

-- Création des tables
CREATE TABLE IF NOT EXISTS ora_phone (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `player_uuid` VARCHAR(255) NOT NULL,
    `serial_number` VARCHAR(20) NOT NULL,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `number` VARCHAR(20) NOT NULL,
    `is_active` TINYINT(1) NOT NULL,
    `sound_notification` varchar(255) NOT NULL,
    `sound_ringing` varchar(255) NOT NULL,
    `sound_alarm` varchar(255) NOT NULL,
    `sound_notification_volume` decimal(11,0) NOT NULL,
    `sound_ringing_volume` decimal(11,0) NOT NULL,
    `sound_alarm_volume` decimal(11,0) NOT NULL,
    `dark_mode` TINYINT(1) NOT NULL,
    `zoom` varchar(20) NOT NULL,
    `wallpaper` varchar(1500) NOT NULL,
    `wallpaper_lock` varchar(1500) NOT NULL,
    `luminosity` int(11) NOT NULL,
    `notification` TEXT NOT NULL,
    `app_home_order` varchar(5000) NOT NULL,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_contacts (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `phone_id` INT(11) NOT NULL,
    `name` varchar(255) NOT NULL,
    `number` varchar(255) NOT NULL,
    `note` text,
    `avatar` varchar(255)
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_conversations (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `target_number` TEXT NOT NULL,
    `name` VARCHAR(255) NULL,
    `last_msg_time` DATETIME DEFAULT CURRENT_TIMESTAMP
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_messages (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `id_conversation` INT NOT NULL,
    `source_number` VARCHAR(255) NOT NULL,
    `msg_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `message` VARCHAR(1000) DEFAULT NULL,
    `img_id` INT DEFAULT NULL,
    `gps_json` VARCHAR(255) DEFAULT NULL,
    `is_read` TINYINT(1) NOT NULL DEFAULT 0
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_call_history (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `source_number` VARCHAR(255) NOT NULL,
    `target_number` VARCHAR(255) NOT NULL,
    `call_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `accepted` BOOLEAN DEFAULT 0,
    `call_duration` INTEGER DEFAULT 0,
    `video` BOOLEAN DEFAULT 0
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_image (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `phone_id` INT NOT NULL,
    `image_link` VARCHAR(255) NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_richtermotorsport (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `phone_id` INT NOT NULL,
    `img_url` VARCHAR(255) NULL,
    `model` VARCHAR(255) NOT NULL,
    `category` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `registration` VARCHAR(255) NOT NULL,
    `price` INT NOT NULL,
    `advertisement_type` VARCHAR(255) NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_richtermotorsport_favorite (
    `advertisement_id` INT NOT NULL,
    `phone_id` INT NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_maps_favorite (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `phone_id` INT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `icon` VARCHAR(255) NOT NULL,
    `x` INT NOT NULL,
    `y` INT NOT NULL,
    `z` INT NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_notes_folder (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `phone_id` INT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_notes_note (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `folder_id` INT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `content` VARCHAR(2000) NOT NULL,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (folder_id) REFERENCES ora_phone_notes_folder(id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_lifeinvader_user (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `phone_id` INT(11) NOT NULL,
    `pseudo` varchar(255) NOT NULL,
    `username` varchar(255) NOT NULL,
    `bio` text,
    `avatar` text
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_lifeinvader_post (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `content` VARCHAR(400) NOT NULL,
    `image` TEXT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES ora_phone_lifeinvader_user(id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_lifeinvader_comment (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `post_id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `content` VARCHAR(400) NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES ora_phone_lifeinvader_post(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES ora_phone_lifeinvader_user(id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_lifeinvader_like (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `post_id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES ora_phone_lifeinvader_post(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES ora_phone_lifeinvader_user(id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;

-- CREATE TABLE IF NOT EXISTS ora_phone_players_apps (
--     app_id INT NOT NULL,
--     player_id INT NOT NULL,
--     download_time DATETIME DEFAULT CURRENT_TIMESTAMP,
--     PRIMARY KEY(app_id, player_id)
-- );

-- CREATE TABLE IF NOT EXISTS ora_phone_images_shares (
--     image_id INT NOT NULL,
--     player_id INT NOT NULL,
--     share_time DATETIME DEFAULT CURRENT_TIMESTAMP,
--     PRIMARY KEY (image_id, player_id)
-- );