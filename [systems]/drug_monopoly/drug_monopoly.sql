
-- migrate up
CREATE TABLE IF NOT EXISTS drug_transaction (
    id INT NOT NULL AUTO_INCREMENT,
    day_stamp INT NOT NULL,
    first_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    last_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    organisation_id INT NOT NULL,
    zone_id INT NOT NULL,
    quantity INT NOT NULL,
    price INT NOT NULL,

    PRIMARY KEY (id)    
);

CREATE TABLE IF NOT EXISTS drug_monopoly (
    id INT NOT NULL AUTO_INCREMENT,
    zone_id INT NOT NULL,
    organisation_id INT NOT NULL,
    time_begin TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    time_last_activation TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(),
    slow_raise_stack INT DEFAULT 0,
    fast_raise_stack INT DEFAULT 0,
    influence_lock TINYINT DEFAULT 0,
    loss_stack INT DEFAULT 0,
    loss_stack_enemies INT DEFAULT 0,
    quantity_double TINYINT DEFAULT 0,
    invest_stack INT DEFAULT 0,
    invest_losing TINYINT DEFAULT 0,
    invest_amount INT DEFAULT 0,
    dollar_lock TINYINT DEFAULT 0,
    PRIMARY KEY (id)
);

ALTER TABLE `organisation_rank`
    ADD `can_read_influence` TINYINT NOT NULL DEFAULT '1',
    ADD `can_activate_option` TINYINT NOT NULL DEFAULT '1';

-- migrate down
DROP TABLE IF EXISTS drug_monopoly;
DROP TABLE IF EXISTS drug_transaction;
ALTER TABLE `organisation_rank`
    DROP COLUMN IF EXISTS `can_read_influence`,
    DROP COLUMN IF EXISTS `can_activate_option`;