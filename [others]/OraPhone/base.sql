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
    `player_uuid` VARCHAR(255) NOT NULL UNIQUE,
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
    `app_home_order` varchar(5000) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ora_phone_contacts (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `phone_id` INT(11) NOT NULL,
    `name` varchar(255) NOT NULL,
    `number` varchar(255) NOT NULL,
    `note` text,
    `avatar` varchar(255)
);

CREATE TABLE IF NOT EXISTS ora_phone_conversations (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `target_number` VARCHAR(255) NOT NULL,
    `last_msg_time` DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ora_phone_messages (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `id_conversation` INT NOT NULL,
    `source_number` VARCHAR(255) NOT NULL,
    `msg_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `message` VARCHAR(255) DEFAULT NULL,
    `img_id` INT DEFAULT NULL,
    `gps_json` VARCHAR(255) DEFAULT NULL,
    `is_read` TINYINT(1) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS ora_phone_call_history (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `source_number` VARCHAR(255) NOT NULL,
    `target_number` VARCHAR(255) NOT NULL,
    `call_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `accepted` BOOLEAN DEFAULT 0,
    `call_duration` INTEGER DEFAULT 0,
    `video` BOOLEAN DEFAULT 0
);

CREATE TABLE IF NOT EXISTS ora_phone_app_store (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    owner_uuid VARCHAR(255) DEFAULT NULL,
    owner_name VARCHAR(255) DEFAULT "iOS",
    owner_tax_percent INT DEFAULT 0,
    app_id VARCHAR(255) NOT NULL,
    app_name VARCHAR(255) NOT NULL,
    price INT DEFAULT 0,
);

CREATE TABLE IF NOT EXISTS ora_phone_players_apps (
    app_id INT NOT NULL,
    player_id INT NOT NULL,
    download_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(app_id, player_id)
);

CREATE TABLE IF NOT EXISTS ora_phone_image (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    author_uuid VARCHAR(255) NOT NULL,
    image_name VARCHAR(255),
    image_link VARCHAR(255) NOT NULL,
    image_description VARCHAR(255),
);

CREATE TABLE IF NOT EXISTS ora_phone_images_shares (
    image_id INT NOT NULL,
    player_id INT NOT NULL,
    share_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (image_id, player_id)
);