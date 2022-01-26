-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 24, 2022 at 08:18 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `members`
--

-- --------------------------------------------------------

--
-- Table structure for table `access_tokens`
--

CREATE TABLE `access_tokens` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `token` char(64) NOT NULL,
  `date_expires` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `category` varchar(45) NOT NULL,
  `slug` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`, `slug`) VALUES
(1, 'Common Attacks', 'common-attacks'),
(2, 'Database Security', 'database-security'),
(3, 'General Web Security', 'general-web-security'),
(4, 'JavaScript Security', 'javascript-security'),
(5, 'PHP Security', 'php-security'),
(6, 'PDF Guides', 'pdf-guides');

-- --------------------------------------------------------

--
-- Table structure for table `favorite_pages`
--

CREATE TABLE `favorite_pages` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `page_id` mediumint(8) UNSIGNED NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `type` enum('page','pdf') DEFAULT NULL,
  `item_id` int(10) UNSIGNED DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL,
  `note` text NOT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `users_id` int(10) UNSIGNED NOT NULL,
  `transaction_id` varchar(45) NOT NULL,
  `payment_status` varchar(45) NOT NULL,
  `payment_amount` int(10) UNSIGNED NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `categories_id` smallint(5) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` tinytext NOT NULL,
  `content` longtext DEFAULT NULL,
  `slug` varchar(100) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `categories_id`, `title`, `description`, `content`, `slug`, `date_created`) VALUES
(3, 1, 'This is a Common Attack Article!', 'This is the description. This is the description. This is the description. This is the description.', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eu scelerisque erat. Praesent vestibulum dui sit amet purus pretium condimentum. Fusce hendrerit, risus vel ultrices varius, est risus vulputate diam, sed blandit arcu leo id justo. Phasellus vel mauris eleifend, pharetra turpis et, dictum enim. Vivamus in orci et metus dictum lobortis sed consequat quam. Nam tempor, nisi vel ultricies mollis, ante risus maximus massa, at gravida arcu sem at turpis. Duis diam turpis, tristique a leo sed, gravida luctus mauris. Mauris congue metus nisl, in cursus elit semper ac. Vestibulum non sapien dui.</p>\r\n<p>Vivamus at vulputate leo. Praesent a feugiat massa, facilisis bibendum libero. Fusce hendrerit ex ut sem mollis imperdiet a nec ex. Pellentesque nibh purus, feugiat facilisis suscipit vitae, fringilla a tellus. Aliquam in consequat eros, a laoreet risus. Duis a turpis eget magna semper varius. Praesent mattis mattis cursus. Etiam vel odio commodo, gravida diam non, rutrum diam. Vestibulum eu nulla erat. Etiam tristique pulvinar lectus, in fermentum neque maximus ut. Nunc iaculis nisi tempor lacinia cursus. Curabitur metus nisl, tincidunt vitae turpis quis, convallis volutpat est. Vivamus vel lacus sit amet ex lobortis consequat.</p>\r\n<p>Nulla augue leo, rhoncus at urna nec, elementum pellentesque sem. Sed dignissim sapien id ligula commodo, eu pellentesque neque semper. Donec ac arcu vitae eros ornare tempus a nec dolor. Curabitur imperdiet sapien arcu, eget varius dui iaculis et. Vestibulum fermentum nisi magna, at posuere massa interdum eu. Nullam vel semper dui. Cras faucibus tristique dictum. Mauris non enim quis ex viverra tempor vitae ut leo. Pellentesque faucibus hendrerit maximus.</p>\r\n<p>Fusce sodales orci arcu, nec ornare diam luctus in. Sed vestibulum tortor risus, sit amet fermentum velit facilisis non. Nunc interdum quis enim ac gravida. Donec et purus aliquet, fringilla lacus quis, convallis justo. Maecenas egestas nunc eu lacus hendrerit ultricies ut ac felis. Nam mauris libero, iaculis quis malesuada vitae, maximus non risus. Nullam eu metus tempus, tincidunt enim vel, lacinia ante. Integer sollicitudin ipsum nec nibh porta, at cursus lectus cursus. Curabitur vulputate sem eu massa ultrices, sed suscipit felis rhoncus.</p>\r\n<p>Fusce urna tellus, semper vitae aliquam ac, viverra sed sapien. In a enim dignissim, commodo justo a, mattis magna. Fusce maximus cursus mi, vel tempus tellus elementum ut. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam gravida enim quam, non interdum massa finibus sed. Donec sodales suscipit felis. Etiam et est ac nibh commodo feugiat non ut purus. Vivamus eget sem at ex tincidunt imperdiet.</p>', 'this-is-a-common-attack-article-', '2022-01-20 17:54:00'),
(4, 1, 'This is Another Common Attack Article!', 'This is the description. This is the description. This is the description. This is the description.', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eu scelerisque erat. Praesent vestibulum dui sit amet purus pretium condimentum. Fusce hendrerit, risus vel ultrices varius, est risus vulputate diam, sed blandit arcu leo id justo. Phasellus vel mauris eleifend, pharetra turpis et, dictum enim. Vivamus in orci et metus dictum lobortis sed consequat quam. Nam tempor, nisi vel ultricies mollis, ante risus maximus massa, at gravida arcu sem at turpis. Duis diam turpis, tristique a leo sed, gravida luctus mauris. Mauris congue metus nisl, in cursus elit semper ac. Vestibulum non sapien dui.</p>\r\n<p>Vivamus at vulputate leo. Praesent a feugiat massa, facilisis bibendum libero. Fusce hendrerit ex ut sem mollis imperdiet a nec ex. Pellentesque nibh purus, feugiat facilisis suscipit vitae, fringilla a tellus. Aliquam in consequat eros, a laoreet risus. Duis a turpis eget magna semper varius. Praesent mattis mattis cursus. Etiam vel odio commodo, gravida diam non, rutrum diam. Vestibulum eu nulla erat. Etiam tristique pulvinar lectus, in fermentum neque maximus ut. Nunc iaculis nisi tempor lacinia cursus. Curabitur metus nisl, tincidunt vitae turpis quis, convallis volutpat est. Vivamus vel lacus sit amet ex lobortis consequat.</p>\r\n<p>Nulla augue leo, rhoncus at urna nec, elementum pellentesque sem. Sed dignissim sapien id ligula commodo, eu pellentesque neque semper. Donec ac arcu vitae eros ornare tempus a nec dolor. Curabitur imperdiet sapien arcu, eget varius dui iaculis et. Vestibulum fermentum nisi magna, at posuere massa interdum eu. Nullam vel semper dui. Cras faucibus tristique dictum. Mauris non enim quis ex viverra tempor vitae ut leo. Pellentesque faucibus hendrerit maximus.</p>\r\n<p>Fusce sodales orci arcu, nec ornare diam luctus in. Sed vestibulum tortor risus, sit amet fermentum velit facilisis non. Nunc interdum quis enim ac gravida. Donec et purus aliquet, fringilla lacus quis, convallis justo. Maecenas egestas nunc eu lacus hendrerit ultricies ut ac felis. Nam mauris libero, iaculis quis malesuada vitae, maximus non risus. Nullam eu metus tempus, tincidunt enim vel, lacinia ante. Integer sollicitudin ipsum nec nibh porta, at cursus lectus cursus. Curabitur vulputate sem eu massa ultrices, sed suscipit felis rhoncus.</p>\r\n<p>Fusce urna tellus, semper vitae aliquam ac, viverra sed sapien. In a enim dignissim, commodo justo a, mattis magna. Fusce maximus cursus mi, vel tempus tellus elementum ut. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam gravida enim quam, non interdum massa finibus sed. Donec sodales suscipit felis. Etiam et est ac nibh commodo feugiat non ut purus. Vivamus eget sem at ex tincidunt imperdiet.</p>', 'this-is-another-common-attack-article-', '2022-01-20 19:54:00'),
(5, 2, 'This is a Databases Security Article!', 'This is the description. This is the description. This is the description. This is the description.', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eu scelerisque erat. Praesent vestibulum dui sit amet purus pretium condimentum. Fusce hendrerit, risus vel ultrices varius, est risus vulputate diam, sed blandit arcu leo id justo. Phasellus vel mauris eleifend, pharetra turpis et, dictum enim. Vivamus in orci et metus dictum lobortis sed consequat quam. Nam tempor, nisi vel ultricies mollis, ante risus maximus massa, at gravida arcu sem at turpis. Duis diam turpis, tristique a leo sed, gravida luctus mauris. Mauris congue metus nisl, in cursus elit semper ac. Vestibulum non sapien dui.</p>\r\n<p>Vivamus at vulputate leo. Praesent a feugiat massa, facilisis bibendum libero. Fusce hendrerit ex ut sem mollis imperdiet a nec ex. Pellentesque nibh purus, feugiat facilisis suscipit vitae, fringilla a tellus. Aliquam in consequat eros, a laoreet risus. Duis a turpis eget magna semper varius. Praesent mattis mattis cursus. Etiam vel odio commodo, gravida diam non, rutrum diam. Vestibulum eu nulla erat. Etiam tristique pulvinar lectus, in fermentum neque maximus ut. Nunc iaculis nisi tempor lacinia cursus. Curabitur metus nisl, tincidunt vitae turpis quis, convallis volutpat est. Vivamus vel lacus sit amet ex lobortis consequat.</p>\r\n<p>Nulla augue leo, rhoncus at urna nec, elementum pellentesque sem. Sed dignissim sapien id ligula commodo, eu pellentesque neque semper. Donec ac arcu vitae eros ornare tempus a nec dolor. Curabitur imperdiet sapien arcu, eget varius dui iaculis et. Vestibulum fermentum nisi magna, at posuere massa interdum eu. Nullam vel semper dui. Cras faucibus tristique dictum. Mauris non enim quis ex viverra tempor vitae ut leo. Pellentesque faucibus hendrerit maximus.</p>\r\n<p>Fusce sodales orci arcu, nec ornare diam luctus in. Sed vestibulum tortor risus, sit amet fermentum velit facilisis non. Nunc interdum quis enim ac gravida. Donec et purus aliquet, fringilla lacus quis, convallis justo. Maecenas egestas nunc eu lacus hendrerit ultricies ut ac felis. Nam mauris libero, iaculis quis malesuada vitae, maximus non risus. Nullam eu metus tempus, tincidunt enim vel, lacinia ante. Integer sollicitudin ipsum nec nibh porta, at cursus lectus cursus. Curabitur vulputate sem eu massa ultrices, sed suscipit felis rhoncus.</p>\r\n<p>Fusce urna tellus, semper vitae aliquam ac, viverra sed sapien. In a enim dignissim, commodo justo a, mattis magna. Fusce maximus cursus mi, vel tempus tellus elementum ut. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam gravida enim quam, non interdum massa finibus sed. Donec sodales suscipit felis. Etiam et est ac nibh commodo feugiat non ut purus. Vivamus eget sem at ex tincidunt imperdiet.</p>', 'this-is-a-databases-security-article-', '2022-01-20 14:54:00'),
(6, 5, 'This is a PHP Security Article!', 'This is the description. This is the description. This is the description. This is the description.', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eu scelerisque erat. Praesent vestibulum dui sit amet purus pretium condimentum. Fusce hendrerit, risus vel ultrices varius, est risus vulputate diam, sed blandit arcu leo id justo. Phasellus vel mauris eleifend, pharetra turpis et, dictum enim. Vivamus in orci et metus dictum lobortis sed consequat quam. Nam tempor, nisi vel ultricies mollis, ante risus maximus massa, at gravida arcu sem at turpis. Duis diam turpis, tristique a leo sed, gravida luctus mauris. Mauris congue metus nisl, in cursus elit semper ac. Vestibulum non sapien dui.</p>\r\n<p>Vivamus at vulputate leo. Praesent a feugiat massa, facilisis bibendum libero. Fusce hendrerit ex ut sem mollis imperdiet a nec ex. Pellentesque nibh purus, feugiat facilisis suscipit vitae, fringilla a tellus. Aliquam in consequat eros, a laoreet risus. Duis a turpis eget magna semper varius. Praesent mattis mattis cursus. Etiam vel odio commodo, gravida diam non, rutrum diam. Vestibulum eu nulla erat. Etiam tristique pulvinar lectus, in fermentum neque maximus ut. Nunc iaculis nisi tempor lacinia cursus. Curabitur metus nisl, tincidunt vitae turpis quis, convallis volutpat est. Vivamus vel lacus sit amet ex lobortis consequat.</p>\r\n<p>Nulla augue leo, rhoncus at urna nec, elementum pellentesque sem. Sed dignissim sapien id ligula commodo, eu pellentesque neque semper. Donec ac arcu vitae eros ornare tempus a nec dolor. Curabitur imperdiet sapien arcu, eget varius dui iaculis et. Vestibulum fermentum nisi magna, at posuere massa interdum eu. Nullam vel semper dui. Cras faucibus tristique dictum. Mauris non enim quis ex viverra tempor vitae ut leo. Pellentesque faucibus hendrerit maximus.</p>\r\n<p>Fusce sodales orci arcu, nec ornare diam luctus in. Sed vestibulum tortor risus, sit amet fermentum velit facilisis non. Nunc interdum quis enim ac gravida. Donec et purus aliquet, fringilla lacus quis, convallis justo. Maecenas egestas nunc eu lacus hendrerit ultricies ut ac felis. Nam mauris libero, iaculis quis malesuada vitae, maximus non risus. Nullam eu metus tempus, tincidunt enim vel, lacinia ante. Integer sollicitudin ipsum nec nibh porta, at cursus lectus cursus. Curabitur vulputate sem eu massa ultrices, sed suscipit felis rhoncus.</p>\r\n<p>Fusce urna tellus, semper vitae aliquam ac, viverra sed sapien. In a enim dignissim, commodo justo a, mattis magna. Fusce maximus cursus mi, vel tempus tellus elementum ut. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam gravida enim quam, non interdum massa finibus sed. Donec sodales suscipit felis. Etiam et est ac nibh commodo feugiat non ut purus. Vivamus eget sem at ex tincidunt imperdiet.</p>', 'this-is-a-php-security-article-', '2022-01-20 22:54:00');

-- --------------------------------------------------------

--
-- Table structure for table `pages_categories`
--

CREATE TABLE `pages_categories` (
  `page_id` int(10) UNSIGNED NOT NULL,
  `category_id` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `page_ratings`
--

CREATE TABLE `page_ratings` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `page_id` mediumint(8) UNSIGNED NOT NULL,
  `rating` tinyint(3) UNSIGNED NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pdfs`
--

CREATE TABLE `pdfs` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` tinytext NOT NULL,
  `tmp_name` char(63) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `size` mediumint(8) UNSIGNED NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `recommendations`
--

CREATE TABLE `recommendations` (
  `page_a` int(10) UNSIGNED NOT NULL,
  `page_b` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `remembered_logins`
--

CREATE TABLE `remembered_logins` (
  `token_hash` varchar(64) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('member','admin') NOT NULL DEFAULT 'member',
  `username` varchar(45) NOT NULL,
  `email` varchar(80) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_expires` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `type`, `username`, `email`, `pass`, `first_name`, `last_name`, `date_created`, `date_expires`, `date_modified`) VALUES
(13, 'member', 'jcayo', 'jefrycayo16@gmail.com', '$2y$10$P709mbxca/JsrZZyXAD19.Hb64d8XIKiM1s259Vj2kMuXPj2xB./G', 'Jefry', 'Cayo', '2022-01-21 17:09:29', '2022-02-21 17:09:29', '2022-01-22 17:43:48'),
(14, 'member', 'roctorber', 'roctorber@gmail.com', '$2y$10$EJOiBU.xmxZlr/VnvFVdQer6z/10/Ctp2tD0JcT6DurReo9s0f/ri', 'Rocío', 'Toribio', '2022-01-21 21:38:18', '2022-02-21 21:38:18', '2022-01-21 21:38:18'),
(15, 'admin', 'noel', 'noel@noel.com', '$2y$10$4UFznsYTYZFRGp2ztObOseGLGX7lHNcFHUeqBPOLa6eeQ35PkGe9m', 'Noel', 'Alcantara', '2022-01-22 08:35:00', '2022-02-22 08:35:00', '2022-01-22 18:53:06');

-- --------------------------------------------------------

--
-- Table structure for table `user_types`
--

CREATE TABLE `user_types` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `access_tokens`
--
ALTER TABLE `access_tokens`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `token` (`token`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_UNIQUE` (`category`);

--
-- Indexes for table `favorite_pages`
--
ALTER TABLE `favorite_pages`
  ADD PRIMARY KEY (`user_id`,`page_id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`,`item_id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`user_id`,`page_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `fk_orders_users1` (`users_id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `fk_pages_categories_idx` (`categories_id`);

--
-- Indexes for table `pages_categories`
--
ALTER TABLE `pages_categories`
  ADD PRIMARY KEY (`page_id`,`category_id`);

--
-- Indexes for table `page_ratings`
--
ALTER TABLE `page_ratings`
  ADD PRIMARY KEY (`user_id`,`page_id`);

--
-- Indexes for table `pdfs`
--
ALTER TABLE `pdfs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tmp_name_UNIQUE` (`tmp_name`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `recommendations`
--
ALTER TABLE `recommendations`
  ADD PRIMARY KEY (`page_a`,`page_b`);

--
-- Indexes for table `remembered_logins`
--
ALTER TABLE `remembered_logins`
  ADD PRIMARY KEY (`token_hash`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `login` (`email`,`pass`);

--
-- Indexes for table `user_types`
--
ALTER TABLE `user_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type` (`type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pdfs`
--
ALTER TABLE `pdfs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `fk_pages_categories` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `remembered_logins`
--
ALTER TABLE `remembered_logins`
  ADD CONSTRAINT `remembered_logins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
