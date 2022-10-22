/*Warning this is a kind of destructive operation*/
DROP TABLE IF EXISTS ora_phone;
DROP TABLE IF EXISTS ora_phone_contacts;
DROP TABLE IF EXISTS ora_phone_messages;
DROP TABLE IF EXISTS ora_phone_call_history;
DROP TABLE IF EXISTS ora_phone_app_store;
DROP TABLE IF EXISTS ora_phone_players_apps;
DROP TABLE IF EXISTS ora_phone_images;
DROP TABLE IF EXISTS ora_phone_images_shares;
/**/

-- Tables creation
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
    `app_home_order` varchar(5000) NOT NULL,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
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
    `target_number` VARCHAR(255) NOT NULL,
    `last_msg_time` DATETIME DEFAULT CURRENT_TIMESTAMP
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_messages (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `id_conversation` INT NOT NULL,
    `source_number` VARCHAR(255) NOT NULL,
    `msg_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `message` VARCHAR(255) DEFAULT NULL,
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

-- CREATE TABLE IF NOT EXISTS ora_phone_app_store (
--     id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
--     owner_uuid VARCHAR(255) DEFAULT NULL,
--     owner_name VARCHAR(255) DEFAULT "iOS",
--     owner_tax_percent INT DEFAULT 0,
--     app_id VARCHAR(255) NOT NULL,
--     app_name VARCHAR(255) NOT NULL,
--     price INT DEFAULT 0,
-- );

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

INSERT INTO `ora_phone` (
    `id`, `player_uuid`, `serial_number`, `first_name`, `last_name`, `number`, `is_active`, `sound_notification`, `sound_ringing`, `sound_alarm`, `sound_notification_volume`, `sound_ringing_volume`, `sound_alarm_volume`, `dark_mode`, `zoom`, `wallpaper`, `wallpaper_lock`, `luminosity`, `app_home_order`) 
    VALUES (
        NULL, 
        '1ed21a93-97e6-6dd0-2222-08e78d9135c4', 
        '7676-8441', 
        'Kaleo', 
        'Alahe', 
        '5558857',
        '1', 
        'notification-sms1', 
        'ringing-iosoriginal', 
        'alarm-iosradaroriginal', 
        '5', 
        '5', 
        '5', 
        '0', 
        'zoom100%', 
        'wallpaper-ios15', 
        'wallpaper-ios15', 
        '100', 
        '[\"clock\",\"camera\",\"gallery\",\"calandar\",\"\",\"\",\"\",\"\",\"notes\",\"calculator\",\"templatetabbed\",\"store\",\"\",\"\",\"\",\"\",\"music\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]'
);