-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


DROP SCHEMA IF EXISTS `basketball` ;
CREATE SCHEMA IF NOT EXISTS `basketball` ;
USE `basketball` ;

DROP TABLE IF EXISTS `basketball`.`PlayerPosition` ;

CREATE TABLE IF NOT EXISTS `basketball`.`PlayerPosition` (
  `playerposition` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`playerposition`))
ENGINE = InnoDB;


DROP TABLE IF EXISTS `basketball`.`Player` ;

CREATE TABLE IF NOT EXISTS `basketball`.`Player` (
  `player` INT(11) NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(20) NOT NULL,
  `lastname` VARCHAR(30) NOT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  `playernum` INT(11) NULL DEFAULT NULL,
  `height` INT(11) NULL DEFAULT NULL,
  `weight` INT(11) NULL DEFAULT NULL,
  `playerposition` INT(11) NOT NULL,
  PRIMARY KEY (`player`),
  INDEX `player_playerposition_fk` (`playerposition` ASC),
  CONSTRAINT `player_playerposition_fk`
    FOREIGN KEY (`position`)
    REFERENCES `basketball`.`PlayerPosition` (`playerposition`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


DROP TABLE IF EXISTS `basketball`.`Sponsor` ;

CREATE TABLE IF NOT EXISTS `basketball`.`Sponsor` (
  `sponsor` INT(11) NOT NULL AUTO_INCREMENT,
  `sponsorname` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`sponsor`))
ENGINE = InnoDB;


DROP TABLE IF EXISTS `basketball`.`PlayerSponsor` ;

CREATE TABLE IF NOT EXISTS `basketball`.`PlayerSponsor` (
  `playersponsor` INT(11) NOT NULL AUTO_INCREMENT,
  `player` INT(11) NOT NULL,
  `sponsor` INT(11) NOT NULL,
  `euros` DECIMAL(10,2) NULL DEFAULT NULL,
  `rating` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`playersponsor`),
  INDEX `playersponsor_player_fk` (`player` ASC),
  INDEX `playersponsor_sponsor_fk` (`sponsor` ASC),
  CONSTRAINT `playersponsor_player_fk`
    FOREIGN KEY (`player`)
    REFERENCES `basketball`.`Player` (`player`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `playersponsor_sponsor_fk`
    FOREIGN KEY (`sponsor`)
    REFERENCES `basketball`.`Sponsor` (`sponsor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;