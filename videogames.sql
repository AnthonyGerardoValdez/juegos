-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-08-2021 a las 03:02:59
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `videogames`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create` (IN `n_nameCategory` VARCHAR(120), IN `n_nameGames` VARCHAR(120), IN `n_img_game` LONGBLOB, IN `n_date_premiere` DATE)  BEGIN
DECLARE v_idCategory INT;
INSERT INTO category (name) VALUES (n_nameCategory);
SELECT LAST_INSERT_ID() INTO v_idCategory;
INSERT INTO games (name, img_game, date_premiere, Category_idCategory) VALUES (n_nameGames, n_img_game, n_date_premiere, v_idCategory);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete1` (IN `n_idGames` INT)  BEGIN
DECLARE n_idCategory INT;

SELECT idCategory FROM category WHERE idCategory = n_idGames INTO n_idCategory;

DELETE FROM games WHERE Category_idCategory = n_idCategory;
DELETE FROM category WHERE idCategory = n_idCategory;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete2` (IN `n_idGames` INT)  BEGIN
UPDATE games SET status = 0 WHERE idGames = n_idGames;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_findAll` ()  BEGIN
SELECT * FROM games AS g INNER JOIN category AS c ON g.Category_idCategory = c.idCategory;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_findGames` (IN `n_idGames` INT)  BEGIN
SELECT * FROM games WHERE idGames = n_idGames;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update` (IN `n_idCategory` INT(11), IN `n_nameCategory` VARCHAR(120), IN `n_idGames` INT(11), IN `n_nameGames` VARCHAR(120), IN `n_img_game` LONGBLOB, IN `n_date_premiere` DATE)  BEGIN
	UPDATE category SET name = n_nameCategory WHERE idCategory = n_idCategory;
    
    UPDATE games SET name = n_nameGames, img_game = n_img_game, date_premiere = n_date_premiere WHERE idGames = n_idGames;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `category`
--

CREATE TABLE `category` (
  `idCategory` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `games`
--

CREATE TABLE `games` (
  `idGames` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `img_game` longblob NOT NULL,
  `date_premiere` date NOT NULL,
  `Category_idCategory` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`idCategory`);

--
-- Indices de la tabla `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`idGames`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `category`
--
ALTER TABLE `category`
  MODIFY `idCategory` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `games`
--
ALTER TABLE `games`
  MODIFY `idGames` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
