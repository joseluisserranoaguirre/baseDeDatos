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
-- Table `mydb`.`contrasenia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contrasenia` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `contrasenia` VARCHAR(45) NULL,
  `fecha_modificacion` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `fecha_nacimiento` DATE NULL,
  `sexo` VARCHAR(45) NULL,
  `codigo_postal` VARCHAR(45) NULL,
  `es_premium` TINYINT NULL,
  `contrasenia_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_contrasenia1_idx` (`contrasenia_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_contrasenia1`
    FOREIGN KEY (`contrasenia_id`)
    REFERENCES `mydb`.`contrasenia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `num_canciones` SMALLINT NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `usuario_id` INT NOT NULL,
  `esta_activo` TINYINT NULL,
  `fecha_eliminacion` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_usuario_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`artista` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `imagen_artista` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pais` (
  `id` INT NOT NULL,
  `nombre_pais` VARCHAR(45) NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pais_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_pais_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`discografica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`discografica` (
  `id` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `pais_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_discografica_pais1_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `fk_discografica_pais1`
    FOREIGN KEY (`pais_id`)
    REFERENCES `mydb`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`album` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `fecha_de_creacion` DATE NULL,
  `artista_id` INT NOT NULL,
  `discografica_id` INT NOT NULL,
  `imagen_portada` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_album_artista1_idx` (`artista_id` ASC) VISIBLE,
  INDEX `fk_album_discografica1_idx` (`discografica_id` ASC) VISIBLE,
  CONSTRAINT `fk_album_artista1`
    FOREIGN KEY (`artista_id`)
    REFERENCES `mydb`.`artista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_album_discografica1`
    FOREIGN KEY (`discografica_id`)
    REFERENCES `mydb`.`discografica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`genero` (
  `id` INT NOT NULL,
  `nombre_genero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`canciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `duracion` TIME NOT NULL,
  `numero_reproducciones` BIGINT NOT NULL,
  `numero_likes` BIGINT NOT NULL,
  `album_id` INT NOT NULL,
  `genero_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_canciones_album1_idx` (`album_id` ASC) VISIBLE,
  INDEX `fk_canciones_genero1_idx` (`genero_id` ASC) VISIBLE,
  CONSTRAINT `fk_canciones_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `mydb`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canciones_genero1`
    FOREIGN KEY (`genero_id`)
    REFERENCES `mydb`.`genero` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`canciones_has_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`canciones_has_playlist` (
  `canciones_id` INT UNSIGNED NOT NULL,
  `playlist_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`canciones_id`, `playlist_id`),
  INDEX `fk_canciones_has_playlist_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_canciones_has_playlist_canciones1_idx` (`canciones_id` ASC) VISIBLE,
  CONSTRAINT `fk_canciones_has_playlist_canciones1`
    FOREIGN KEY (`canciones_id`)
    REFERENCES `mydb`.`canciones` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canciones_has_playlist_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `mydb`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
