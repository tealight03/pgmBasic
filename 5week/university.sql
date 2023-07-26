-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`department` (
  `did` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `president` VARCHAR(45) NOT NULL,
  `callnum` VARCHAR(15) NOT NULL,
  `assistant_aid` INT NOT NULL,
  PRIMARY KEY (`did`),
  UNIQUE INDEX `did_UNIQUE` (`did` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `callnum_UNIQUE` (`callnum` ASC) VISIBLE,
  INDEX `fk_department_assistant1_idx` (`assistant_aid` ASC) VISIBLE,
  CONSTRAINT `fk_department_assistant1`
    FOREIGN KEY (`assistant_aid`)
    REFERENCES `mydb`.`assistant` (`aid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`subject` (
  `sid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `professor` VARCHAR(30) NOT NULL,
  `subnum` VARCHAR(45) NOT NULL,
  `department_did` INT NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE INDEX `sid_UNIQUE` (`sid` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `professor_UNIQUE` (`professor` ASC) VISIBLE,
  UNIQUE INDEX `subnum_UNIQUE` (`subnum` ASC) VISIBLE,
  INDEX `fk_subject_department_idx` (`department_did` ASC) VISIBLE,
  CONSTRAINT `fk_subject_department`
    FOREIGN KEY (`department_did`)
    REFERENCES `mydb`.`department` (`did`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`assistant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`assistant` (
  `aid` INT NOT NULL AUTO_INCREMENT,
  `department` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `tel` VARCHAR(15) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `subject_sid` INT NOT NULL,
  PRIMARY KEY (`aid`),
  UNIQUE INDEX `aid_UNIQUE` (`aid` ASC) VISIBLE,
  UNIQUE INDEX `department_UNIQUE` (`department` ASC) VISIBLE,
  UNIQUE INDEX `tel_UNIQUE` (`tel` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_assistant_subject1_idx` (`subject_sid` ASC) VISIBLE,
  CONSTRAINT `fk_assistant_subject1`
    FOREIGN KEY (`subject_sid`)
    REFERENCES `mydb`.`subject` (`sid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`professor` (
  `pid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `department` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `tel` VARCHAR(15) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `assistant_aid` INT NOT NULL,
  PRIMARY KEY (`pid`),
  UNIQUE INDEX `pid_UNIQUE` (`pid` ASC) VISIBLE,
  UNIQUE INDEX `department_UNIQUE` (`department` ASC) VISIBLE,
  UNIQUE INDEX `tel_UNIQUE` (`tel` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_professor_assistant1_idx` (`assistant_aid` ASC) VISIBLE,
  CONSTRAINT `fk_professor_assistant1`
    FOREIGN KEY (`assistant_aid`)
    REFERENCES `mydb`.`assistant` (`aid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `sid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `age` INT NOT NULL,
  `department_did` INT NOT NULL,
  `professor_pid` INT NOT NULL,
  PRIMARY KEY (`sid`, `professor_pid`),
  UNIQUE INDEX `sid_UNIQUE` (`sid` ASC) VISIBLE,
  INDEX `fk_student_department1_idx` (`department_did` ASC) VISIBLE,
  INDEX `fk_student_professor1_idx` (`professor_pid` ASC) VISIBLE,
  CONSTRAINT `fk_student_department1`
    FOREIGN KEY (`department_did`)
    REFERENCES `mydb`.`department` (`did`),
  CONSTRAINT `fk_student_professor1`
    FOREIGN KEY (`professor_pid`)
    REFERENCES `mydb`.`professor` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`class` (
  `cid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `professor` VARCHAR(30) NOT NULL,
  `time` VARCHAR(50) NOT NULL,
  `student_sid` INT NOT NULL,
  `professor_pid` INT NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE INDEX `cid_UNIQUE` (`cid` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_class_student1_idx` (`student_sid` ASC) VISIBLE,
  INDEX `fk_class_professor1_idx` (`professor_pid` ASC) VISIBLE,
  CONSTRAINT `fk_class_professor1`
    FOREIGN KEY (`professor_pid`)
    REFERENCES `mydb`.`professor` (`pid`),
  CONSTRAINT `fk_class_student1`
    FOREIGN KEY (`student_sid`)
    REFERENCES `mydb`.`student` (`sid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`class_has_student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`class_has_student` (
  `class_cid` INT NOT NULL,
  `student_sid` INT NOT NULL,
  PRIMARY KEY (`class_cid`, `student_sid`),
  INDEX `fk_class_has_student_student1_idx` (`student_sid` ASC) VISIBLE,
  INDEX `fk_class_has_student_class1_idx` (`class_cid` ASC) VISIBLE,
  CONSTRAINT `fk_class_has_student_class1`
    FOREIGN KEY (`class_cid`)
    REFERENCES `mydb`.`class` (`cid`),
  CONSTRAINT `fk_class_has_student_student1`
    FOREIGN KEY (`student_sid`)
    REFERENCES `mydb`.`student` (`sid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
