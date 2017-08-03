-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 02, 2017 at 06:00 PM
-- Server version: 5.7.19-0ubuntu0.16.04.1
-- PHP Version: 7.1.6-2~ubuntu14.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

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
-- Triggers `characters`
--
DELIMITER $$
CREATE TRIGGER `add_professions_to_new_character` AFTER INSERT ON `characters` FOR EACH ROW INSERT
INTO
  `character_professions`(`character_id`,
  `profession_id`)
SELECT
  NEW.id,
  professions.id
FROM
  professions
$$
DELIMITER ;

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
-- Triggers `character_professions`
--
DELIMITER $$
CREATE TRIGGER `add_recipes_to_new_character_professions` AFTER INSERT ON `character_professions` FOR EACH ROW INSERT
INTO
  `character_recipes`(`character_profession_id`,
  `recipe_id`)
SELECT
  NEW.id,
  profession_recipes.id
FROM
  profession_recipes
  JOIN profession_items ON profession_recipes.item_id=profession_items.id
  WHERE NEW.profession_id=profession_items.profession_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `character_recipes`
--

CREATE TABLE `character_recipes` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `character_profession_id` smallint(3) UNSIGNED NOT NULL,
  `recipe_id` smallint(5) UNSIGNED NOT NULL,
  `status_id` tinyint(3) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gems`
--

CREATE TABLE `gems` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(18) NOT NULL,
  `category_id` tinyint(3) UNSIGNED NOT NULL,
  `trait` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `gems`
--
DELIMITER $$
CREATE TRIGGER `add_recipes_to_new_gems` AFTER INSERT ON `gems` FOR EACH ROW INSERT
INTO
  `profession_recipes`(`gem_id`,
  `item_id`)
SELECT
  NEW.id,
  profession_items.id
FROM
  profession_items
JOIN
  item_skill_categories
  ON
  profession_items.skill_category_id=item_skill_categories.id
  WHERE
  NEW.category_id=item_skill_categories.page_category_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item_page_categories`
--

CREATE TABLE `item_page_categories` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `description` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `item_skill_categories`
--

CREATE TABLE `item_skill_categories` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `page_category_id` tinyint(3) UNSIGNED NOT NULL,
  `description` varchar(17) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `priorities`
--

CREATE TABLE `priorities` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `description` varchar(15) NOT NULL,
  `weight` tinyint(3) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `professions`
--

CREATE TABLE `professions` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Professions';

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
-- Triggers `profession_items`
--
DELIMITER $$
CREATE TRIGGER `add_recipes_to_new_items` AFTER INSERT ON `profession_items` FOR EACH ROW INSERT
INTO
  `profession_recipes`(`item_id`,
  `gem_id`)
SELECT
  NEW.id,
  gems.id
FROM
  gems
  JOIN
  `item_skill_categories`
  ON
  `gems`.`category_id`=`item_skill_categories`.`page_category_id`
  WHERE
  NEW.skill_category_id=`item_skill_categories`.id
$$
DELIMITER ;

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
-- Triggers `profession_recipes`
--
DELIMITER $$
CREATE TRIGGER `add_character_on_new_profession_recipe` AFTER INSERT ON `profession_recipes` FOR EACH ROW INSERT
INTO
  `character_recipes`(`recipe_id`,
  `character_profession_id`)
SELECT
  NEW.id,
  character_professions.id
FROM
  character_professions
  JOIN profession_items ON character_professions.profession_id=profession_items.profession_id
  WHERE NEW.item_id=profession_items.id
$$
DELIMITER ;

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
  ADD UNIQUE KEY `character_id` (`character_profession_id`,`recipe_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `character_recipes_ibfk_2` (`recipe_id`);

--
-- Indexes for table `gems`
--
ALTER TABLE `gems`
  ADD PRIMARY KEY (`id`),
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
  ADD KEY `profession_recipes_ibfk_2` (`gem_id`);

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
-- AUTO_INCREMENT for table `item_page_categories`
--
ALTER TABLE `item_page_categories`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `item_skill_categories`
--
ALTER TABLE `item_skill_categories`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `priorities`
--
ALTER TABLE `priorities`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `professions`
--
ALTER TABLE `professions`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;
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
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `character_professions`
--
ALTER TABLE `character_professions`
  ADD CONSTRAINT `character_professions_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `character_professions_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `professions` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `character_professions_ibfk_3` FOREIGN KEY (`priority_id`) REFERENCES `priorities` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `character_recipes`
--
ALTER TABLE `character_recipes`
  ADD CONSTRAINT `character_recipes_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `profession_recipes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `character_recipes_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `recipe_statuses` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `character_recipes_ibfk_4` FOREIGN KEY (`character_profession_id`) REFERENCES `character_professions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `gems`
--
ALTER TABLE `gems`
  ADD CONSTRAINT `gems_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `item_page_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `item_skill_categories`
--
ALTER TABLE `item_skill_categories`
  ADD CONSTRAINT `item_skill_categories_ibfk_1` FOREIGN KEY (`page_category_id`) REFERENCES `item_page_categories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `profession_items`
--
ALTER TABLE `profession_items`
  ADD CONSTRAINT `profession_items_ibfk_1` FOREIGN KEY (`skill_category_id`) REFERENCES `item_skill_categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `profession_items_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `professions` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `profession_recipes`
--
ALTER TABLE `profession_recipes`
  ADD CONSTRAINT `profession_recipes_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `profession_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `profession_recipes_ibfk_2` FOREIGN KEY (`gem_id`) REFERENCES `gems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
