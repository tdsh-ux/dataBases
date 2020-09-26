SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_menu
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_menu
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_menu` DEFAULT CHARACTER SET utf8 ;
USE `db_menu` ;

-- -----------------------------------------------------
-- Table `db_menu`.`sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_menu`.`sponsor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_menu`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_menu`.`event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `venue` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_menu`.`currency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_menu`.`currency` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_menu`.`venue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_menu`.`venue` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_menu`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_menu`.`menu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `event_date` VARCHAR(45) NULL,
  `event_id` INT NULL,
  `sponsor_id` INT NULL,
  `currency_id` INT NULL,
  `venue_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menu_sponsor_idx` (`sponsor_id` ASC) VISIBLE,
  INDEX `fk_menu_event1_idx` (`event_id` ASC) VISIBLE,
  INDEX `fk_menu_currency1_idx` (`currency_id` ASC) VISIBLE,
  INDEX `fk_menu_venue1_idx` (`venue_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_sponsor`
    FOREIGN KEY (`sponsor_id`)
    REFERENCES `db_menu`.`sponsor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `db_menu`.`event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_currency1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `db_menu`.`currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_venue1`
    FOREIGN KEY (`venue_id`)
    REFERENCES `db_menu`.`venue` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_menu`.`menu_page`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_menu`.`menu_page` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `page_number` INT NULL,
  `full_height` INT NULL,
  `full_width` INT NULL,
  `menu_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menu_page_menu1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_page_menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `db_menu`.`menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_menu`.`dish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_menu`.`dish` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_menu`.`menu_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_menu`.`menu_item` ( 
  `id` INT NOT NULL AUTO_INCREMENT,
  `menu_page_id` INT NOT NULL,
  `dish_id` INT NOT NULL,
  `price` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menu_page_has_dish_dish1_idx` (`dish_id` ASC) VISIBLE,
  INDEX `fk_menu_page_has_dish_menu_page1_idx` (`menu_page_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_page_has_dish_menu_page1`
    FOREIGN KEY (`menu_page_id`)
    REFERENCES `db_menu`.`menu_page` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_page_has_dish_dish1`
    FOREIGN KEY (`dish_id`)
    REFERENCES `db_menu`.`dish` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

ENGINE = InnoDB;

USE `db_menu` ;

-- -----------------------------------------------------
-- Placeholder table for view `db_menu`.`page_count`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_menu`.`page_count` (`id` INT, `page_count` INT);

-- -----------------------------------------------------
-- Placeholder table for view `db_menu`.`dish_count`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_menu`.`dish_count` (`id` INT, `dish_count` INT);

-- -----------------------------------------------------
-- View `db_menu`.`page_count`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_menu`.`page_count`;
USE `db_menu`;
CREATE  OR REPLACE VIEW `page_count` AS
SELECT m.id, COUNT(mp.id) AS page_count
FROM menu m
JOIN menu_page mp
ON mp.menu_id = m.id
GROUP BY m.id;

-- -----------------------------------------------------
-- View `db_menu`.`dish_count`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_menu`.`dish_count`;
USE `db_menu`;
CREATE  OR REPLACE VIEW `dish_count` AS
SELECT m.id, COUNT(d.id) AS dish_count
FROM menu m
JOIN menu_page mp
    ON mp.menu_id = m.id
    JOIN menu_item mi
    ON mi.menu_page_id = mp.id
    JOIN dish d
    ON d.id = mi.dish_id
GROUP BY m.id;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;