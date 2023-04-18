-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema myTeamsDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS myTeamsDB;
CREATE SCHEMA IF NOT EXISTS myTeamsDB;
USE myTeamsDB;
-- -----------------------------------------------------
-- Table `Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Region` (
  `region_id` INT NOT NULL AUTO_INCREMENT,
  `region_name` VARCHAR(45) NOT NULL,
  `region_UTC` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`region_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Company` (
  `company_id` INT NOT NULL AUTO_INCREMENT,
  `region_id` INT NOT NULL,
  `address` VARCHAR(64) NULL,
  `city` VARCHAR(32) NULL,
  `state` CHAR(2) NULL,
  `zip` INT NULL,
  PRIMARY KEY (`company_id`),
  INDEX `fk_region_idx` (`region_id` ASC) VISIBLE,
  CONSTRAINT `fk_region`
    FOREIGN KEY (`region_id`)
    REFERENCES `Region` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Budget`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Budget` (
  `budget_id` INT NOT NULL AUTO_INCREMENT,
  `amount_avail` INT NOT NULL,
  PRIMARY KEY (`budget_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `budget_id` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(20) NULL,
  PRIMARY KEY (`department_id`),
  INDEX `fk_company_idx` (`company_id` ASC) VISIBLE,
  INDEX `fk_budget_idx` (`budget_id` ASC) VISIBLE,
  CONSTRAINT `fk_budget`
    FOREIGN KEY (`budget_id`)
    REFERENCES `Budget` (`budget_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_company`
    FOREIGN KEY (`company_id`)
    REFERENCES `Company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `position` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NULL,
  `start_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `termination_date` TIMESTAMP NULL,
  `department_id` INT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `Department` (`department_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EmployeeInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EmployeeInfo` (
  `employeeInfo_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `ssn` VARCHAR(256) NULL,
  `address1` VARCHAR(45) NULL,
  `zip_code` INT NULL,
  `city` VARCHAR(45) NULL,
  `state` CHAR(2) NULL,
  `dob` DATE NULL,
  `salary` INT NULL,
  `num_dependents` TINYINT(0) NULL,
  `phone_number` VARCHAR(45) NULL,
  PRIMARY KEY (`employeeInfo_id`),
  UNIQUE INDEX `ssn_UNIQUE` (`ssn` ASC) VISIBLE,
  INDEX `fk_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employeeinfo_employee`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SkillCerts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SkillCerts` (
  `skillCerts_id` INT NOT NULL AUTO_INCREMENT,
  `skillCerts_name` VARCHAR(45) NOT NULL,
  `date_added` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`skillCerts_id`),
  INDEX `fkEmployee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fkEmployee_certs`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EmployeeLogin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EmployeeLogin` (
  `employeeLogin_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `email` VARCHAR(64) NOT NULL,
  `username` VARCHAR(64) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`employeeLogin_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_employee2_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee2`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Manager` (
  `manager_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NULL,
  `directReport_id` INT NULL,
  PRIMARY KEY (`manager_id`),
  UNIQUE INDEX `manager_id_UNIQUE` (`manager_id` ASC) VISIBLE,
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) VISIBLE,
  INDEX `fk_directreport_idx` (`directReport_id` ASC) VISIBLE,
  CONSTRAINT `fk_directreport`
    FOREIGN KEY (`directReport_id`)
    REFERENCES `Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_managerid`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Employee` (`employee_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Position` (
  `position_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(1000) NULL,
  `min_pay` INT UNSIGNED NOT NULL,
  `level` TINYINT(0) UNSIGNED NOT NULL,
  PRIMARY KEY (`position_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Candidate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Candidate` (
  `candidate_id` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NULL,
  `dob` DATE NULL,
  `email` VARCHAR(64) NOT NULL,
  `phone` VARCHAR(45) NULL,
  `last_application_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`candidate_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JobPosting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JobPosting` (
  `jobPosting_id` INT NOT NULL AUTO_INCREMENT,
  `position_id` INT NOT NULL,
  `candidate_id` INT NOT NULL,
  `post_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`jobPosting_id`),
  INDEX `fk_positionid_idx` (`position_id` ASC) VISIBLE,
  INDEX `fk_candidateid2_idx` (`candidate_id` ASC) VISIBLE,
  CONSTRAINT `fk_positionid`
    FOREIGN KEY (`position_id`)
    REFERENCES `Position` (`position_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_candidateid2`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `Candidate` (`candidate_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Teams` (
  `teams_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `manager_id` INT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`teams_id`),
  INDEX `fkEmployee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fkManager_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `fkManager`
    FOREIGN KEY (`manager_id`)
    REFERENCES `Manager` (`manager_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fkEmployee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Clients` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `address` VARCHAR(64) NOT NULL,
  `zip` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` CHAR(2) NOT NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projects` (
  `projects_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `priority` TINYINT(2) NOT NULL,
  `department_id` INT NULL,
  `team_id` INT NULL,
  `client_id` INT NULL,
  PRIMARY KEY (`projects_id`),
  INDEX `fkClient_idx` (`client_id` ASC) VISIBLE,
  INDEX `fkDepartment_idx` (`department_id` ASC) VISIBLE,
  INDEX `fkTeam_idx` (`team_id` ASC) VISIBLE,
  CONSTRAINT `fkTeam`
    FOREIGN KEY (`team_id`)
    REFERENCES `Teams` (`teams_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fkDepartment`
    FOREIGN KEY (`department_id`)
    REFERENCES `Department` (`department_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fkClient`
    FOREIGN KEY (`client_id`)
    REFERENCES `Clients` (`client_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clientAssignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientAssignments` (
  `clientAssignments_id` INT NOT NULL AUTO_INCREMENT,
  `department_id` INT NULL,
  `client_id` INT NOT NULL,
  `date_started` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_finished` TIMESTAMP NULL,
  PRIMARY KEY (`clientAssignments_id`),
  INDEX `fk_clientId_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_departmentId_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_clientId`
    FOREIGN KEY (`client_id`)
    REFERENCES `Clients` (`client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_departmentId`
    FOREIGN KEY (`department_id`)
    REFERENCES `Department` (`department_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Documents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Documents` (
  `documents_id` INT NOT NULL AUTO_INCREMENT,
  `candidate_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `document` VARCHAR(2048) NOT NULL,
  `date_added` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`documents_id`),
  INDEX `fk_candidate_idx` (`candidate_id` ASC) VISIBLE,
  CONSTRAINT `fk_candidate`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `Candidate` (`candidate_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Invoices` (
  `invoice_id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NULL,
  `description` VARCHAR(128) NULL,
  `amount_due` INT NOT NULL,
  `amount_paid` INT NOT NULL,
  `due_date` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`invoice_id`),
  INDEX `fk_client1_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `fk_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `Clients` (`client_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Payroll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Payroll` (
  `payroll_id` INT NOT NULL AUTO_INCREMENT,
  `pay_period` VARCHAR(45) NOT NULL,
  `employee_id` INT NOT NULL,
  `gross_pay` INT NULL,
  `taxes` INT GENERATED ALWAYS AS (gross_pay * .15),
  `net_pay` INT GENERATED ALWAYS AS (gross_pay - taxes),
  PRIMARY KEY (`payroll_id`),
  INDEX `fk_employeeid3_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employeeid3`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `W2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `W2` (
  `w2_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `year` YEAR NOT NULL,
  `eDocPath` VARCHAR(4096) NOT NULL,
  `total_income` INT NOT NULL,
  `total_tax` INT NOT NULL,
  `total_take_home` INT NOT NULL,
  PRIMARY KEY (`w2_id`),
  INDEX `fk_employee5_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee5`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Notes` (
  `notes_id` INT NOT NULL AUTO_INCREMENT,
  `manager` INT NULL,
  `candidate` INT NOT NULL,
  `note` VARCHAR(1000) NOT NULL,
  `public` TINYINT(0) NULL DEFAULT 1,
  PRIMARY KEY (`notes_id`),
  INDEX `fk_manager_note_idx` (`manager` ASC) VISIBLE,
  INDEX `fk_candidate_note_idx` (`candidate` ASC) VISIBLE,
  CONSTRAINT `fk_manager_note`
    FOREIGN KEY (`manager`)
    REFERENCES `Manager` (`manager_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_candidate_note`
    FOREIGN KEY (`candidate`)
    REFERENCES `Candidate` (`candidate_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `internalJobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `internalJobs` (
  `internalJobs_id` INT NOT NULL AUTO_INCREMENT,
  `position` INT NOT NULL,
  `employee` INT NOT NULL,
  `submittedDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`internalJobs_id`),
  INDEX `fk_internal_employee_idx` (`employee` ASC) VISIBLE,
  INDEX `fk_internal_position_idx` (`position` ASC) VISIBLE,
  CONSTRAINT `fk_internal_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_internal_position`
    FOREIGN KEY (`position`)
    REFERENCES `Position` (`position_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
