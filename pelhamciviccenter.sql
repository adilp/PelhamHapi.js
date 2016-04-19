-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `Address1` VARCHAR(100) NOT NULL,
  `Address2` VARCHAR(45) NULL,
  `State` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Zip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `JoinDate` DATETIME NOT NULL,
  `isActive` TINYINT(1) NOT NULL,
  `AddressID` INT NOT NULL,
  `PhoneNumber` INT NULL,
  PRIMARY KEY (`idUser`),
  INDEX `AddressID_idx` (`AddressID` ASC),
  CONSTRAINT `AddressID`
    FOREIGN KEY (`AddressID`)
    REFERENCES `mydb`.`Address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`master_scheduleType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`master_scheduleType` (
  `idmaster_scheduleType` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmaster_scheduleType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`master_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`master_location` (
  `idmaster_location` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmaster_location`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`master_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`master_schedule` (
  `idmaster_schedule` INT NOT NULL AUTO_INCREMENT,
  `start` DATETIME NOT NULL,
  `end` DATETIME NOT NULL,
  `idmaster_location` INT NOT NULL,
  `idmaster_scheduleType` INT NOT NULL,
  `isResReq` TINYINT(1) NOT NULL,
  `numOfSpots` INT NOT NULL,
  `isActive` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idmaster_schedule`),
  INDEX `idmaster_location_idx` (`idmaster_location` ASC),
  INDEX `idmaster_scheduleType_idx` (`idmaster_scheduleType` ASC),
  CONSTRAINT `idmaster_location`
    FOREIGN KEY (`idmaster_location`)
    REFERENCES `mydb`.`master_location` (`idmaster_location`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idmaster_scheduleType`
    FOREIGN KEY (`idmaster_scheduleType`)
    REFERENCES `mydb`.`master_scheduleType` (`idmaster_scheduleType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reservation` (
  `idreservation` INT NOT NULL,
  `idUser` INT NOT NULL,
  `idmaster_schedule` INT NOT NULL,
  PRIMARY KEY (`idreservation`),
  INDEX `idUser_idx` (`idUser` ASC),
  INDEX `idmaster_schedule_idx` (`idmaster_schedule` ASC),
  CONSTRAINT `idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idmaster_schedule`
    FOREIGN KEY (`idmaster_schedule`)
    REFERENCES `mydb`.`master_schedule` (`idmaster_schedule`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
