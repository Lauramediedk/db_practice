-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Vært: 127.0.0.1
-- Genereringstid: 19. 12 2022 kl. 19:08:48
-- Serverversion: 10.4.27-MariaDB
-- PHP-version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `examdb`
--

DELIMITER $$
--
-- Procedurer
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_item` (IN `name` VARCHAR(20))   SELECT * FROM items
WHERE items.name = name$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user` (IN `name` VARCHAR(20))   SELECT * FROM users
WHERE users.name = name$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in-struktur for visning `active_emails`
-- (Se nedenfor for det aktuelle view)
--
CREATE TABLE `active_emails` (
`user_id_fk` bigint(11) unsigned
,`email` varchar(30)
,`to_login` tinyint(1)
);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `email`
--

CREATE TABLE `email` (
  `user_id_fk` bigint(11) UNSIGNED NOT NULL,
  `email` varchar(30) NOT NULL,
  `to_login` tinyint(1) NOT NULL,
  `time_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `email`
--

INSERT INTO `email` (`user_id_fk`, `email`, `to_login`, `time_created`) VALUES
(1, 'a@gmail.com', 0, '2022-12-13 14:09:22'),
(1, 'a@a.com', 1, '2022-12-13 14:09:22'),
(2, 'b@gmail.com', 1, '2022-12-13 14:09:22'),
(3, 'c@c.com', 0, '2022-12-13 14:09:22'),
(3, 'c@gmail.com', 1, '2022-12-13 14:09:22');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `friends`
--

CREATE TABLE `friends` (
  `user_id_fk` bigint(11) UNSIGNED NOT NULL,
  `friends_fk` bigint(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `friends`
--

INSERT INTO `friends` (`user_id_fk`, `friends_fk`) VALUES
(1, 2),
(2, 1),
(1, 3),
(3, 1);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `hobbies`
--

CREATE TABLE `hobbies` (
  `hobbies_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `hobbies`
--

INSERT INTO `hobbies` (`hobbies_id`, `name`) VALUES
(1, 'climbing'),
(2, 'soccer'),
(3, 'dancing'),
(4, 'music'),
(5, 'running');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `items`
--

CREATE TABLE `items` (
  `items_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `cost` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `items`
--

INSERT INTO `items` (`items_id`, `name`, `cost`, `created_at`) VALUES
(1, 'shoes', 18, '2022-12-12 13:08:47'),
(2, 'dress', 19, '2022-12-12 13:08:47'),
(3, 'basketball', 20, '2022-12-12 13:08:47'),
(4, 'shorts', 19, '2022-12-12 13:08:47'),
(5, 'shirt', 17, '2022-12-12 13:08:47');

--
-- Triggers/udløsere `items`
--
DELIMITER $$
CREATE TRIGGER `items_count` AFTER INSERT ON `items` FOR EACH ROW UPDATE total_items SET number_of_items = number_of_items+1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `liked_items`
--

CREATE TABLE `liked_items` (
  `user_id_fk` bigint(11) UNSIGNED NOT NULL,
  `items_id_fk` bigint(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `liked_items`
--

INSERT INTO `liked_items` (`user_id_fk`, `items_id_fk`) VALUES
(1, 3),
(2, 1),
(3, 4),
(1, 2),
(2, 3);

-- --------------------------------------------------------

--
-- Stand-in-struktur for visning `name_a`
-- (Se nedenfor for det aktuelle view)
--
CREATE TABLE `name_a` (
`id` bigint(20) unsigned
,`name` varchar(20)
);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `phone`
--

CREATE TABLE `phone` (
  `user_id_fk` bigint(11) UNSIGNED NOT NULL,
  `phone_number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `phone`
--

INSERT INTO `phone` (`user_id_fk`, `phone_number`) VALUES
(1, '46735456'),
(2, '78445465'),
(2, '83156754'),
(3, '45657578'),
(3, '56454244');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `total_items`
--

CREATE TABLE `total_items` (
  `number_of_items` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `total_items`
--

INSERT INTO `total_items` (`number_of_items`) VALUES
(5);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `age`) VALUES
(1, 'A', 'passA', 25),
(2, 'B', 'passB', 40),
(3, 'C', 'passC', 19);

--
-- Triggers/udløsere `users`
--
DELIMITER $$
CREATE TRIGGER `new_users_total` AFTER INSERT ON `users` FOR EACH ROW UPDATE users_total SET total_users = total_users + 1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `users_total`
--

CREATE TABLE `users_total` (
  `total_users` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `users_total`
--

INSERT INTO `users_total` (`total_users`) VALUES
(4);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `user_hobbies`
--

CREATE TABLE `user_hobbies` (
  `user_id_fk` bigint(11) UNSIGNED NOT NULL,
  `hobbie_id_fk` bigint(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `user_hobbies`
--

INSERT INTO `user_hobbies` (`user_id_fk`, `hobbie_id_fk`) VALUES
(1, 1),
(1, 5),
(2, 2),
(3, 4),
(3, 5);

-- --------------------------------------------------------

--
-- Struktur for visning `active_emails`
--
DROP TABLE IF EXISTS `active_emails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `active_emails`  AS SELECT `email`.`user_id_fk` AS `user_id_fk`, `email`.`email` AS `email`, `email`.`to_login` AS `to_login` FROM `email` WHERE `email`.`to_login` = 11  ;

-- --------------------------------------------------------

--
-- Struktur for visning `name_a`
--
DROP TABLE IF EXISTS `name_a`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `name_a`  AS SELECT `users`.`id` AS `id`, `users`.`name` AS `name` FROM `users` WHERE `users`.`name` = 'A''A'  ;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `email`
--
ALTER TABLE `email`
  ADD KEY `user_id_fk` (`user_id_fk`);

--
-- Indeks for tabel `friends`
--
ALTER TABLE `friends`
  ADD KEY `user_id_fk` (`user_id_fk`),
  ADD KEY `friends_fk` (`friends_fk`);

--
-- Indeks for tabel `hobbies`
--
ALTER TABLE `hobbies`
  ADD UNIQUE KEY `hobbies_id` (`hobbies_id`);
ALTER TABLE `hobbies` ADD FULLTEXT KEY `name` (`name`);

--
-- Indeks for tabel `items`
--
ALTER TABLE `items`
  ADD UNIQUE KEY `items_id` (`items_id`);
ALTER TABLE `items` ADD FULLTEXT KEY `items` (`name`);

--
-- Indeks for tabel `liked_items`
--
ALTER TABLE `liked_items`
  ADD KEY `user_id_fk` (`user_id_fk`),
  ADD KEY `items_id_fk` (`items_id_fk`);

--
-- Indeks for tabel `phone`
--
ALTER TABLE `phone`
  ADD KEY `user_id_fk` (`user_id_fk`);

--
-- Indeks for tabel `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indeks for tabel `user_hobbies`
--
ALTER TABLE `user_hobbies`
  ADD KEY `user_id_fk` (`user_id_fk`),
  ADD KEY `hobbie_id_fk` (`hobbie_id_fk`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `hobbies`
--
ALTER TABLE `hobbies`
  MODIFY `hobbies_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tilføj AUTO_INCREMENT i tabel `items`
--
ALTER TABLE `items`
  MODIFY `items_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tilføj AUTO_INCREMENT i tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Begrænsninger for tabel `email`
--
ALTER TABLE `email`
  ADD CONSTRAINT `email_ibfk_1` FOREIGN KEY (`user_id_fk`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `friends`
--
ALTER TABLE `friends`
  ADD CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`user_id_fk`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`friends_fk`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `liked_items`
--
ALTER TABLE `liked_items`
  ADD CONSTRAINT `liked_items_ibfk_1` FOREIGN KEY (`user_id_fk`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `liked_items_ibfk_2` FOREIGN KEY (`items_id_fk`) REFERENCES `items` (`items_id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `phone`
--
ALTER TABLE `phone`
  ADD CONSTRAINT `phone_ibfk_1` FOREIGN KEY (`user_id_fk`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Begrænsninger for tabel `user_hobbies`
--
ALTER TABLE `user_hobbies`
  ADD CONSTRAINT `user_hobbies_ibfk_1` FOREIGN KEY (`user_id_fk`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_hobbies_ibfk_2` FOREIGN KEY (`hobbie_id_fk`) REFERENCES `hobbies` (`hobbies_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
