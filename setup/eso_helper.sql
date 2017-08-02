-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 02, 2017 at 11:57 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Characters';

--
-- MIME TYPES FOR TABLE `characters`:
--   `id`
--       `Text_Plain`
--

--
-- RELATIONS FOR TABLE `characters`:
--

-- --------------------------------------------------------

--
-- Table structure for table `character_professions`
--

CREATE TABLE `character_professions` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `character_id` tinyint(11) UNSIGNED NOT NULL,
  `profession_id` tinyint(11) UNSIGNED NOT NULL,
  `priority_id` tinyint(11) UNSIGNED NOT NULL DEFAULT '3',
  `total_research_slots` tinyint(3) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `character_professions`:
--   `character_id`
--       `characters` -> `id`
--   `profession_id`
--       `professions` -> `id`
--   `priority_id`
--       `priorities` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `character_recipes`
--

CREATE TABLE `character_recipes` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `character_id` tinyint(3) UNSIGNED NOT NULL,
  `recipe_id` smallint(5) UNSIGNED NOT NULL,
  `status_id` tinyint(3) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `character_recipes`:
--   `character_id`
--       `characters` -> `id`
--   `recipe_id`
--       `profession_recipes` -> `id`
--   `status_id`
--       `recipe_statuses` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `gems`
--

CREATE TABLE `gems` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `gem_name` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `gems`:
--

-- --------------------------------------------------------

--
-- Table structure for table `gem_attributes`
--

CREATE TABLE `gem_attributes` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `gem_id` tinyint(3) UNSIGNED NOT NULL,
  `category_id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `gem_attributes`:
--   `gem_id`
--       `gems` -> `id`
--   `category_id`
--       `item_page_categories` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `item_page_categories`
--

CREATE TABLE `item_page_categories` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `description` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `item_page_categories`:
--

--
-- Dumping data for table `item_page_categories`
--

INSERT INTO `item_page_categories` (`id`, `description`) VALUES
(1, 'Weapon'),
(2, 'Armor');

-- --------------------------------------------------------

--
-- Table structure for table `item_skill_categories`
--

CREATE TABLE `item_skill_categories` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `page_category_id` tinyint(3) UNSIGNED NOT NULL,
  `description` varchar(17) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `item_skill_categories`:
--   `page_category_id`
--       `item_page_categories` -> `id`
--

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

-- --------------------------------------------------------

--
-- Table structure for table `priorities`
--

CREATE TABLE `priorities` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `description` varchar(15) NOT NULL,
  `weight` tinyint(3) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `priorities`:
--

--
-- Dumping data for table `priorities`
--

INSERT INTO `priorities` (`id`, `description`, `weight`) VALUES
(1, 'primary', 3),
(2, 'secondary', 2),
(3, 'extra', 1),
(4, 'temporary', 0);

-- --------------------------------------------------------

--
-- Table structure for table `professions`
--

CREATE TABLE `professions` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Professions';

--
-- RELATIONS FOR TABLE `professions`:
--

--
-- Dumping data for table `professions`
--

INSERT INTO `professions` (`id`, `name`) VALUES
(1, 'Blacksmithing'),
(2, 'Tailoring'),
(3, 'Woodworking');

-- --------------------------------------------------------

--
-- Table structure for table `profession_items`
--

CREATE TABLE `profession_items` (
  `id` tinyint(5) UNSIGNED NOT NULL,
  `description` varchar(20) NOT NULL,
  `profession_id` tinyint(3) UNSIGNED NOT NULL,
  `skill_category_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `profession_items`:
--   `skill_category_id`
--       `item_skill_categories` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `profession_recipes`
--

CREATE TABLE `profession_recipes` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `item_id` tinyint(3) UNSIGNED NOT NULL,
  `gem_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `profession_recipes`:
--   `item_id`
--       `profession_items` -> `id`
--   `gem_id`
--       `gems` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `recipe_statuses`
--

CREATE TABLE `recipe_statuses` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `description` varchar(15) NOT NULL,
  `research_slot` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `recipe_statuses`:
--

--
-- Dumping data for table `recipe_statuses`
--

INSERT INTO `recipe_statuses` (`id`, `description`, `research_slot`) VALUES
(1, 'Not researched', 0),
(2, 'Reserved', 1),
(3, 'In progress', 1),
(4, 'Learned', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `character_professions`
--
ALTER TABLE `character_professions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `character_id` (`character_id`,`profession_id`),
  ADD KEY `priority` (`priority_id`) USING HASH,
  ADD KEY `profession_id` (`profession_id`);

--
-- Indexes for table `character_recipes`
--
ALTER TABLE `character_recipes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `character_id` (`character_id`,`recipe_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `character_recipes_ibfk_2` (`recipe_id`);

--
-- Indexes for table `gems`
--
ALTER TABLE `gems`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gem_attributes`
--
ALTER TABLE `gem_attributes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gem_id` (`gem_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `item_page_categories`
--
ALTER TABLE `item_page_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_skill_categories`
--
ALTER TABLE `item_skill_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`page_category_id`) USING BTREE;

--
-- Indexes for table `priorities`
--
ALTER TABLE `priorities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `professions`
--
ALTER TABLE `professions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `profession_items`
--
ALTER TABLE `profession_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `skill_category_id` (`skill_category_id`),
  ADD KEY `profession_id` (`profession_id`);

--
-- Indexes for table `profession_recipes`
--
ALTER TABLE `profession_recipes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `item_id` (`item_id`,`gem_id`),
  ADD KEY `gem_id` (`gem_id`);

--
-- Indexes for table `recipe_statuses`
--
ALTER TABLE `recipe_statuses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `character_professions`
--
ALTER TABLE `character_professions`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `character_recipes`
--
ALTER TABLE `character_recipes`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `gems`
--
ALTER TABLE `gems`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `gem_attributes`
--
ALTER TABLE `gem_attributes`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `item_page_categories`
--
ALTER TABLE `item_page_categories`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `item_skill_categories`
--
ALTER TABLE `item_skill_categories`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `priorities`
--
ALTER TABLE `priorities`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `professions`
--
ALTER TABLE `professions`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `profession_items`
--
ALTER TABLE `profession_items`
  MODIFY `id` tinyint(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `profession_recipes`
--
ALTER TABLE `profession_recipes`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `recipe_statuses`
--
ALTER TABLE `recipe_statuses`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `character_professions`
--
ALTER TABLE `character_professions`
  ADD CONSTRAINT `character_professions_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `character_professions_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `professions` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `character_professions_ibfk_3` FOREIGN KEY (`priority_id`) REFERENCES `priorities` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `character_recipes`
--
ALTER TABLE `character_recipes`
  ADD CONSTRAINT `character_recipes_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `character_recipes_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `profession_recipes` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `character_recipes_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `recipe_statuses` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `gem_attributes`
--
ALTER TABLE `gem_attributes`
  ADD CONSTRAINT `gem_attributes_ibfk_1` FOREIGN KEY (`gem_id`) REFERENCES `gems` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `gem_attributes_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `item_page_categories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `item_skill_categories`
--
ALTER TABLE `item_skill_categories`
  ADD CONSTRAINT `item_skill_categories_ibfk_1` FOREIGN KEY (`page_category_id`) REFERENCES `item_page_categories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `profession_items`
--
ALTER TABLE `profession_items`
  ADD CONSTRAINT `profession_items_ibfk_1` FOREIGN KEY (`skill_category_id`) REFERENCES `item_skill_categories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `profession_recipes`
--
ALTER TABLE `profession_recipes`
  ADD CONSTRAINT `profession_recipes_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `profession_items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `profession_recipes_ibfk_2` FOREIGN KEY (`gem_id`) REFERENCES `gems` (`id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;