-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 02, 2017 at 04:04 PM
-- Server version: 5.7.19-0ubuntu0.16.04.1
-- PHP Version: 7.1.6-2~ubuntu14.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eso_helper`
--

--
-- Dumping data for table `gems`
--

INSERT INTO `gems` (`id`, `name`, `category_id`, `trait`) VALUES
(1, 'Chysolite', 1, 'Powered'),
(2, 'Amethyst', 1, 'Charged'),
(3, 'Ruby', 1, 'Precise'),
(4, 'Jade', 1, 'Infused'),
(5, 'Turquoise', 1, 'Defending'),
(6, 'Carnelian', 1, 'Training'),
(7, 'Fire Opal', 1, 'Sharpened'),
(8, 'Citrine', 1, 'Decisive'),
(9, 'Potent Nirncrux', 1, 'Nirnhoned'),
(10, 'Quartz', 2, 'Sturdy'),
(11, 'Diamond', 2, 'Impenetrable'),
(12, 'Sardonyx', 2, 'Reinforced'),
(13, 'Almandine', 2, 'Well-fitted'),
(14, 'Emerald', 2, 'Training'),
(15, 'Bloodstone', 2, 'Infused'),
(16, 'Garnet', 2, 'Prosperous'),
(17, 'Sapphire', 2, 'Divines'),
(18, 'Fortified Nirncrux', 2, 'Nirnhoned');

--
-- Dumping data for table `item_page_categories`
--

INSERT INTO `item_page_categories` (`id`, `description`) VALUES
(1, 'Weapon'),
(2, 'Armor');

--
-- Dumping data for table `item_skill_categories`
--

INSERT INTO `item_skill_categories` (`id`, `page_category_id`, `description`) VALUES
(1, 1, 'Two-handed'),
(3, 1, 'One-handed'),
(4, 1, 'Bow'),
(5, 1, 'Destruction staff'),
(6, 1, 'Restoration staff'),
(7, 2, 'Shield'),
(8, 2, 'Light armor'),
(9, 2, 'Medium armor'),
(10, 2, 'Heavy armor');

--
-- Dumping data for table `priorities`
--

INSERT INTO `priorities` (`id`, `description`, `weight`) VALUES
(1, 'primary', 3),
(2, 'secondary', 2),
(3, 'extra', 1),
(4, 'temporary', 0);

--
-- Dumping data for table `professions`
--

INSERT INTO `professions` (`id`, `name`) VALUES
(1, 'Blacksmithing'),
(2, 'Tailoring'),
(3, 'Woodworking');

--
-- Dumping data for table `recipe_statuses`
--

INSERT INTO `recipe_statuses` (`id`, `description`, `research_slot`) VALUES
(1, 'Not researched', 0),
(2, 'Reserved', 1),
(3, 'In progress', 1),
(4, 'Learned', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
