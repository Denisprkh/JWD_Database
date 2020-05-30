-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rent_service
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rent_service
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rent_service` DEFAULT CHARACTER SET utf8 ;
USE `rent_service` ;

-- -----------------------------------------------------
-- Table `rent_service`.`users_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_service`.`users_role` (
  `users_role_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`users_role_id`),
  UNIQUE INDEX `role_UNIQUE` (`role` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_service`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_service`.`users` (
  `users_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `users_role_id` INT NOT NULL,
  PRIMARY KEY (`users_id`),
  INDEX `fk_users_users_role_idx` (`users_role_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_users_users_role`
    FOREIGN KEY (`users_role_id`)
    REFERENCES `rent_service`.`users_role` (`users_role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_service`.`flats_decription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_service`.`flats_decription` (
  `flats_description_id` INT NOT NULL AUTO_INCREMENT,
  `rooms` INT NOT NULL,
  `living_area` FLOAT NOT NULL,
  `has_furniture` TINYINT NOT NULL,
  `has_home_appliciances` TINYINT NOT NULL,
  `has_the_internet` TINYINT NOT NULL,
  `possible_with_childs` TINYINT NOT NULL,
  `possible_with_pets` TINYINT NOT NULL,
  `repair` VARCHAR(45) NOT NULL,
  `users_description` TEXT NOT NULL,
  PRIMARY KEY (`flats_description_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_service`.`flats_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_service`.`flats_address` (
  `flats_address_id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `house` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`flats_address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_service`.`flats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_service`.`flats` (
  `flats_id` INT NOT NULL AUTO_INCREMENT,
  `is_free` TINYINT NOT NULL DEFAULT 1,
  `flats_description_id` INT NOT NULL,
  `flats_address_id` INT NOT NULL,
  `owner_id` INT NOT NULL,
  PRIMARY KEY (`flats_id`),
  INDEX `fk_flats_flats_decription1_idx` (`flats_description_id` ASC) VISIBLE,
  INDEX `fk_flats_users1_idx` (`owner_id` ASC) VISIBLE,
  INDEX `fk_flats_flats_address1_idx` (`flats_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_flats_flats_decription1`
    FOREIGN KEY (`flats_description_id`)
    REFERENCES `rent_service`.`flats_decription` (`flats_description_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flats_users1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `rent_service`.`users` (`users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flats_flats_address1`
    FOREIGN KEY (`flats_address_id`)
    REFERENCES `rent_service`.`flats_address` (`flats_address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_service`.`advertisement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_service`.`advertisement` (
  `advertisement_id` INT NOT NULL AUTO_INCREMENT,
  `author_id` INT NOT NULL,
  `flats_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  `comm_services_by_owner` TINYINT NOT NULL DEFAULT 0,
  `date_of_creation` DATE NOT NULL,
  PRIMARY KEY (`advertisement_id`),
  INDEX `fk_advertisement_flats1_idx` (`flats_id` ASC) VISIBLE,
  INDEX `fk_advertisement_users1_idx` (`author_id` ASC) VISIBLE,
  CONSTRAINT `fk_advertisement_flats1`
    FOREIGN KEY (`flats_id`)
    REFERENCES `rent_service`.`flats` (`flats_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_advertisement_users1`
    FOREIGN KEY (`author_id`)
    REFERENCES `rent_service`.`users` (`users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_service`.`request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_service`.`request` (
  `request_id` INT NOT NULL AUTO_INCREMENT,
  `advertisement_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `stard_date` DATE NOT NULL,
  `end_date` DATE NULL,
  PRIMARY KEY (`request_id`),
  INDEX `fk_request_advertisement1_idx` (`advertisement_id` ASC) VISIBLE,
  INDEX `fk_request_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_request_advertisement1`
    FOREIGN KEY (`advertisement_id`)
    REFERENCES `rent_service`.`advertisement` (`advertisement_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_request_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `rent_service`.`users` (`users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rent_service`.`flats_photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rent_service`.`flats_photo` (
  `flats_photo_id` INT NOT NULL,
  `photo` BLOB NOT NULL,
  `flats_id` INT NOT NULL,
  PRIMARY KEY (`flats_photo_id`),
  INDEX `fk_flats_photo_flats1_idx` (`flats_id` ASC) VISIBLE,
  CONSTRAINT `fk_flats_photo_flats1`
    FOREIGN KEY (`flats_id`)
    REFERENCES `rent_service`.`flats` (`flats_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
