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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`habitacion_clase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`habitacion_clase` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `clase` VARCHAR(20) NOT NULL,
  `costo_usd` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `clase_UNIQUE` (`clase` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleado_estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleado_estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estado_inactivo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `estado_nombre_UNIQUE` (`estado_inactivo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hotel_sector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hotel_sector` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sector_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `sector_nombre_UNIQUE` (`sector_nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_pais_UNIQUE` (`nombre_pais` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apellido` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `dni` CHAR(15) NOT NULL,
  `fecha_de_nacimineto` DATE NOT NULL,
  `domicilio` VARCHAR(70) NOT NULL,
  `telefono_movil` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `empleado_estado_id` INT NOT NULL,
  `hotel_sector_id` INT NOT NULL,
  `pais_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `telefono_movil_UNIQUE` (`telefono_movil` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_empleados_empleado_estado_idx` (`empleado_estado_id` ASC) VISIBLE,
  INDEX `fk_empleados_hotel_sector1_idx` (`hotel_sector_id` ASC) VISIBLE,
  INDEX `fk_empleados_pais1_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_empleado_estado`
    FOREIGN KEY (`empleado_estado_id`)
    REFERENCES `mydb`.`empleado_estado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_hotel_sector1`
    FOREIGN KEY (`hotel_sector_id`)
    REFERENCES `mydb`.`hotel_sector` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_pais1`
    FOREIGN KEY (`pais_id`)
    REFERENCES `mydb`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`huesped`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`huesped` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apellido` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `pasaporte` VARCHAR(45) NOT NULL,
  `domicilio` VARCHAR(70) NOT NULL,
  `telefono_movil` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `pais_id` INT NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `pasaporte_UNIQUE` (`pasaporte` ASC) VISIBLE,
  UNIQUE INDEX `telefono_movil_UNIQUE` (`telefono_movil` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_huesped_pais1_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `fk_huesped_pais1`
    FOREIGN KEY (`pais_id`)
    REFERENCES `mydb`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`habitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`habitacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `capacidad_max` CHAR(2) NOT NULL,
  `habitacion_clase_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_habitacion_habitacion_clase1_idx` (`habitacion_clase_id` ASC) VISIBLE,
  CONSTRAINT `fk_habitacion_habitacion_clase1`
    FOREIGN KEY (`habitacion_clase_id`)
    REFERENCES `mydb`.`habitacion_clase` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`check_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`check_in` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_entrada` DATE NOT NULL,
  `fecha_salida` DATE NOT NULL,
  `importe` FLOAT(6,2) NOT NULL,
  `huesped_id` INT NOT NULL,
  `habitacion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_check_in_huesped1_idx` (`huesped_id` ASC) VISIBLE,
  INDEX `fk_check_in_habitacion1_idx` (`habitacion_id` ASC) VISIBLE,
  CONSTRAINT `fk_check_in_huesped1`
    FOREIGN KEY (`huesped_id`)
    REFERENCES `mydb`.`huesped` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_check_in_habitacion1`
    FOREIGN KEY (`habitacion_id`)
    REFERENCES `mydb`.`habitacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`forma_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`forma_pago` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `forma_pago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `forma_pago_UNIQUE` (`forma_pago` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`decoracion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`decoracion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `decoracion_tipo` VARCHAR(45) NOT NULL,
  `habitacion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `decoracion_tipo_UNIQUE` (`decoracion_tipo` ASC) VISIBLE,
  INDEX `fk_decoracion_habitacion1_idx` (`habitacion_id` ASC) VISIBLE,
  CONSTRAINT `fk_decoracion_habitacion1`
    FOREIGN KEY (`habitacion_id`)
    REFERENCES `mydb`.`habitacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`servicios_basicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`servicios_basicos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servicio_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `servicio_nombre_UNIQUE` (`servicio_nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`servicio_extra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`servicio_extra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servicio_nombre` VARCHAR(45) NOT NULL,
  `costo_por_hora` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `servicio_nombre_UNIQUE` (`servicio_nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reserva_servicio_extra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reserva_servicio_extra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `horas_cantidad` CHAR(1) NOT NULL,
  `importe` FLOAT(6,2) NOT NULL,
  `huesped_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_reserva_servicio_extra_huesped1_idx` (`huesped_id` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_servicio_extra_huesped1`
    FOREIGN KEY (`huesped_id`)
    REFERENCES `mydb`.`huesped` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`forma_pago_has_reserva_servicio_extra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`forma_pago_has_reserva_servicio_extra` (
  `forma_pago_id` INT NOT NULL,
  `reserva_servicio_extra_id` INT NOT NULL,
  PRIMARY KEY (`forma_pago_id`, `reserva_servicio_extra_id`),
  INDEX `fk_forma_pago_has_reserva_servicio_extra_reserva_servicio_e_idx` (`reserva_servicio_extra_id` ASC) VISIBLE,
  INDEX `fk_forma_pago_has_reserva_servicio_extra_forma_pago1_idx` (`forma_pago_id` ASC) VISIBLE,
  CONSTRAINT `fk_forma_pago_has_reserva_servicio_extra_forma_pago1`
    FOREIGN KEY (`forma_pago_id`)
    REFERENCES `mydb`.`forma_pago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_forma_pago_has_reserva_servicio_extra_reserva_servicio_ext1`
    FOREIGN KEY (`reserva_servicio_extra_id`)
    REFERENCES `mydb`.`reserva_servicio_extra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`check_in_has_forma_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`check_in_has_forma_pago` (
  `check_in_id` INT NOT NULL,
  `forma_pago_id` INT NOT NULL,
  PRIMARY KEY (`check_in_id`, `forma_pago_id`),
  INDEX `fk_check_in_has_forma_pago_forma_pago1_idx` (`forma_pago_id` ASC) VISIBLE,
  INDEX `fk_check_in_has_forma_pago_check_in1_idx` (`check_in_id` ASC) VISIBLE,
  CONSTRAINT `fk_check_in_has_forma_pago_check_in1`
    FOREIGN KEY (`check_in_id`)
    REFERENCES `mydb`.`check_in` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_check_in_has_forma_pago_forma_pago1`
    FOREIGN KEY (`forma_pago_id`)
    REFERENCES `mydb`.`forma_pago` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`servicios_basicos_has_habitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`servicios_basicos_has_habitacion` (
  `servicios_basicos_id` INT NOT NULL,
  `habitacion_id` INT NOT NULL,
  PRIMARY KEY (`servicios_basicos_id`, `habitacion_id`),
  INDEX `fk_servicios_basicos_has_habitacion_habitacion1_idx` (`habitacion_id` ASC) VISIBLE,
  INDEX `fk_servicios_basicos_has_habitacion_servicios_basicos1_idx` (`servicios_basicos_id` ASC) VISIBLE,
  CONSTRAINT `fk_servicios_basicos_has_habitacion_servicios_basicos1`
    FOREIGN KEY (`servicios_basicos_id`)
    REFERENCES `mydb`.`servicios_basicos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicios_basicos_has_habitacion_habitacion1`
    FOREIGN KEY (`habitacion_id`)
    REFERENCES `mydb`.`habitacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reserva_servicio_extra_has_servicio_extra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reserva_servicio_extra_has_servicio_extra` (
  `reserva_servicio_extra_id` INT NOT NULL,
  `servicio_extra_id` INT NOT NULL,
  PRIMARY KEY (`reserva_servicio_extra_id`, `servicio_extra_id`),
  INDEX `fk_reserva_servicio_extra_has_servicio_extra_servicio_extra_idx` (`servicio_extra_id` ASC) VISIBLE,
  INDEX `fk_reserva_servicio_extra_has_servicio_extra_reserva_servic_idx` (`reserva_servicio_extra_id` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_servicio_extra_has_servicio_extra_reserva_servicio1`
    FOREIGN KEY (`reserva_servicio_extra_id`)
    REFERENCES `mydb`.`reserva_servicio_extra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_servicio_extra_has_servicio_extra_servicio_extra1`
    FOREIGN KEY (`servicio_extra_id`)
    REFERENCES `mydb`.`servicio_extra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
