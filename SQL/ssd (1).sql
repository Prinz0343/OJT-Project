-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 05, 2024 at 04:11 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ssd`
--

-- --------------------------------------------------------

--
-- Table structure for table `goal`
--

CREATE TABLE `goal` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `year` int(11) NOT NULL,
  `department` varchar(255) NOT NULL,
  `targets` varchar(255) NOT NULL,
  `total_budget` decimal(10,2) NOT NULL,
  `initiative` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `archived` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `goal`
--

INSERT INTO `goal` (`id`, `title`, `year`, `department`, `targets`, `total_budget`, `initiative`, `user_id`, `archived`) VALUES
(1, 'abcde', 2024, 'BSCS', 'LOCK', 1000.00, 'KPI 1.2', 1, 1),
(2, 'Baptism', 2024, 'Sabbath School', '5 Baptisms', 25000.00, 'KPI 1.2', 1, NULL),
(3, 'Testing User ID', 2024, 'Sabbath School', 'sabbath school congress', 10000.00, 'KPI 1.4', 0, NULL),
(4, 'testing user id 2', 2024, 'Sabbath School', 'sabbath school congress', 10000.00, 'KPI 1.3', 1, NULL),
(5, 'Testing User ID 2.1', 2024, 'Sabbath School', 'Correct user_id entry', 5000.00, 'KPI 1.2', 2, NULL),
(6, 'sdjfajkdfs', 2024, 'Sabbath School', '78', 5000.00, 'KPI 1.4', 1, NULL),
(7, 'JinJin', 2024, 'Sabbath School', 'Thesis', 5000.00, 'KPI 1.3', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(4) UNSIGNED NOT NULL,
  `username` varchar(25) NOT NULL,
  `surname` varchar(25) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `middle_name` varchar(25) DEFAULT NULL,
  `suffix` varchar(5) DEFAULT NULL,
  `department` enum('Sabbath School','IT','','') NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `surname`, `first_name`, `middle_name`, `suffix`, `department`, `password`) VALUES
(1, 'lyshasilva', 'Silva', 'Lysha', 'Tolentino', NULL, 'Sabbath School', 'pass1234'),
(2, 'prinzj', 'Magallamento', 'Prinz Juancho', 'L', NULL, 'Sabbath School', 'pass5678');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `goal`
--
ALTER TABLE `goal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `goal`
--
ALTER TABLE `goal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(4) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
