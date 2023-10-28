-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pharmacymanagement
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pharmacymanagement
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pharmacymanagement` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pharmacymanagement` ;

-- -----------------------------------------------------
-- Table `pharmacymanagement`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacymanagement`.`customers` (
  `Customer_ID` INT NOT NULL AUTO_INCREMENT,
  `Customer_Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Customer_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pharmacymanagement`.`drugs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacymanagement`.`drugs` (
  `Drug_ID` INT NOT NULL AUTO_INCREMENT,
  `Drug_Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  `Quantity` INT NOT NULL,
  `Expiry_Date` DATE NOT NULL,
  PRIMARY KEY (`Drug_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pharmacymanagement`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacymanagement`.`inventory` (
  `InventoryID` INT NOT NULL AUTO_INCREMENT,
  `MedicationID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `ExpirationDate` DATE NULL DEFAULT NULL,
  `BatchNumber` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`InventoryID`),
  INDEX `MedicationID` (`MedicationID` ASC) VISIBLE,
  CONSTRAINT `inventory_ibfk_1`
    FOREIGN KEY (`MedicationID`)
    REFERENCES `pharmacymanagement`.`drugs` (`Drug_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pharmacymanagement`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacymanagement`.`orders` (
  `Order_ID` INT NOT NULL AUTO_INCREMENT,
  `Customer_ID` INT NOT NULL,
  `Order_Date` DATE NOT NULL,
  `Total_Amount` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `Customer_ID` (`Customer_ID` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `pharmacymanagement`.`customers` (`Customer_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pharmacymanagement`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacymanagement`.`order_details` (
  `OrderDetailID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `MedicationID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `Status` ENUM('Success', 'Canceled') NOT NULL,
  PRIMARY KEY (`OrderDetailID`),
  INDEX `OrderID` (`OrderID` ASC) VISIBLE,
  INDEX `MedicationID` (`MedicationID` ASC) VISIBLE,
  CONSTRAINT `order_details_ibfk_1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `pharmacymanagement`.`orders` (`Order_ID`),
  CONSTRAINT `order_details_ibfk_2`
    FOREIGN KEY (`MedicationID`)
    REFERENCES `pharmacymanagement`.`drugs` (`Drug_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pharmacymanagement`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacymanagement`.`order_items` (
  `OrderItemID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `DrugID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`OrderItemID`),
  INDEX `OrderID` (`OrderID` ASC) VISIBLE,
  INDEX `DrugID` (`DrugID` ASC) VISIBLE,
  CONSTRAINT `order_items_ibfk_1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `pharmacymanagement`.`orders` (`Order_ID`),
  CONSTRAINT `order_items_ibfk_2`
    FOREIGN KEY (`DrugID`)
    REFERENCES `pharmacymanagement`.`drugs` (`Drug_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pharmacymanagement`.`patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacymanagement`.`patients` (
  `PatientID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `DateOfBirth` DATE NULL DEFAULT NULL,
  `Gender` ENUM('Male', 'Female', 'Other') NULL DEFAULT NULL,
  `ContactNumber` VARCHAR(15) NULL DEFAULT NULL,
  `Address` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`PatientID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pharmacymanagement`.`prescriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacymanagement`.`prescriptions` (
  `PrescriptionID` INT NOT NULL AUTO_INCREMENT,
  `PatientID` INT NOT NULL,
  `MedicationID` INT NOT NULL,
  `PrescriptionDate` DATE NULL DEFAULT NULL,
  `DosageInstructions` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`PrescriptionID`),
  INDEX `PatientID` (`PatientID` ASC) VISIBLE,
  INDEX `MedicationID` (`MedicationID` ASC) VISIBLE,
  CONSTRAINT `prescriptions_ibfk_1`
    FOREIGN KEY (`PatientID`)
    REFERENCES `pharmacymanagement`.`patients` (`PatientID`),
  CONSTRAINT `prescriptions_ibfk_2`
    FOREIGN KEY (`MedicationID`)
    REFERENCES `pharmacymanagement`.`drugs` (`Drug_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pharmacymanagement`.`suppliersinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacymanagement`.`suppliersinfo` (
  `Supplier_ID` INT NOT NULL AUTO_INCREMENT,
  `Supplier_Name` VARCHAR(255) NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `Contact_number` VARCHAR(255) NOT NULL,
  `Email_ID` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Supplier_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pharmacymanagement`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacymanagement`.`transactions` (
  `TransactionID` INT NOT NULL AUTO_INCREMENT,
  `MedicationID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `TransactionType` ENUM('In', 'Out') NULL DEFAULT NULL,
  `TransactionDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`TransactionID`),
  INDEX `MedicationID` (`MedicationID` ASC) VISIBLE,
  CONSTRAINT `transactions_ibfk_1`
    FOREIGN KEY (`MedicationID`)
    REFERENCES `pharmacymanagement`.`drugs` (`Drug_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
