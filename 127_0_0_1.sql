-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 02, 2024 at 02:34 AM
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
-- Database: `bscs-dss`
--
CREATE DATABASE IF NOT EXISTS `bscs-dss` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bscs-dss`;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `Attendance_ID` int(10) UNSIGNED NOT NULL,
  `Event_ID` int(10) UNSIGNED NOT NULL,
  `Student_ID` char(7) NOT NULL,
  `Attendance_Status` enum('Present','Absent','') NOT NULL,
  `Attendance_Time` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`Attendance_ID`, `Event_ID`, `Student_ID`, `Attendance_Status`, `Attendance_Time`) VALUES
(368, 70, '19-0001', 'Present', '2023-12-05 07:21:55'),
(369, 70, '19-0099', 'Present', '2023-12-05 07:22:09'),
(370, 70, '19-0002', 'Present', '2023-12-05 07:22:02'),
(371, 70, '19-0003', '', '2023-12-05 07:21:37'),
(372, 70, '19-0088', '', '2023-12-05 07:21:37'),
(373, 71, '19-0001', '', '2023-12-05 09:28:08'),
(374, 71, '19-0099', 'Present', '2023-12-05 09:28:37'),
(375, 71, '19-0002', '', '2023-12-05 09:28:08'),
(376, 71, '19-0003', '', '2023-12-05 09:28:08'),
(377, 71, '19-0088', '', '2023-12-05 09:28:08'),
(378, 72, '19-0001', 'Present', '2023-12-05 10:06:57'),
(379, 72, '19-0099', 'Present', '2023-12-05 10:06:46'),
(380, 72, '19-0002', '', '2023-12-05 10:06:16'),
(381, 72, '19-0003', '', '2023-12-05 10:06:16'),
(382, 72, '19-0088', '', '2023-12-05 10:06:16'),
(383, 73, '19-0001', '', '2023-12-05 11:21:15'),
(384, 73, '19-0099', 'Present', '2023-12-05 11:21:33'),
(385, 73, '19-0002', '', '2023-12-05 11:21:15'),
(386, 73, '19-0003', '', '2023-12-05 11:21:15'),
(387, 73, '19-0088', '', '2023-12-05 11:21:15'),
(388, 74, '19-0001', '', '2023-12-05 11:33:58'),
(389, 74, '19-0099', '', '2023-12-05 11:33:58'),
(390, 74, '19-0002', '', '2023-12-05 11:33:58'),
(391, 74, '19-0003', '', '2023-12-05 11:33:58'),
(392, 74, '19-0088', '', '2023-12-05 11:33:58'),
(393, 75, '19-0001', 'Present', '2023-12-05 11:41:59'),
(394, 75, '19-0099', 'Present', '2023-12-05 11:42:06'),
(395, 75, '19-0002', 'Present', '2023-12-05 11:41:54'),
(396, 75, '19-0003', '', '2023-12-05 11:41:36'),
(397, 75, '19-0088', '', '2023-12-05 11:41:36'),
(398, 76, '19-0001', '', '2023-12-14 14:06:29'),
(399, 76, '19-0099', '', '2023-12-14 14:06:29'),
(400, 76, '19-0002', 'Present', '2023-12-14 14:06:49'),
(401, 76, '19-0003', '', '2023-12-14 14:06:29'),
(402, 76, '19-0088', '', '2023-12-14 14:06:29');

--
-- Triggers `attendance`
--
DELIMITER $$
CREATE TRIGGER `after_attendance_insert` AFTER INSERT ON `attendance` FOR EACH ROW IF NEW.attendance_status = '' THEN
    INSERT INTO fines (Fine_ID, Event_ID, Student_ID, Paid_Amount, Payment_Status)
    VALUES (NEW.Attendance_ID, NEW.Event_ID, NEW.Student_ID, 0, 'Not Cleared');
  END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_attendance_update` AFTER UPDATE ON `attendance` FOR EACH ROW IF NEW.attendance_status = 'Present' AND OLD.attendance_status = '' THEN
    -- If attendance_status changed from empty to 'Present', delete the record from fines
    DELETE FROM fines
    WHERE Student_ID = NEW.Student_ID AND Event_ID = NEW.Event_ID;
  END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `Event_ID` int(10) UNSIGNED NOT NULL,
  `Event_Name` varchar(30) NOT NULL,
  `Event_Date` date NOT NULL,
  `Closing_Time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`Event_ID`, `Event_Name`, `Event_Date`, `Closing_Time`) VALUES
(70, 'Software Engineering Day', '2023-12-05', '2023-12-05 07:23:00'),
(71, 'Software Engineering2', '2023-12-05', '2023-12-05 09:30:00'),
(72, 'Hugyaw', '2023-12-05', '2023-12-05 10:07:00'),
(73, 'Sem Ender', '2023-12-05', '2023-12-05 11:22:00'),
(74, 'Class', '2023-12-05', '2023-12-05 11:34:00'),
(75, 'Chapel Period', '2023-12-05', '2023-12-05 11:44:00'),
(76, 'party', '2023-12-18', '2023-12-18 15:06:00');

-- --------------------------------------------------------

--
-- Table structure for table `fines`
--

CREATE TABLE `fines` (
  `Fine_ID` int(10) UNSIGNED NOT NULL,
  `Student_ID` char(7) NOT NULL,
  `Event_ID` int(10) UNSIGNED NOT NULL,
  `Paid_Amount` int(11) NOT NULL,
  `Payment_Status` enum('Cleared','Not Cleared') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fines`
--

INSERT INTO `fines` (`Fine_ID`, `Student_ID`, `Event_ID`, `Paid_Amount`, `Payment_Status`) VALUES
(371, '19-0003', 70, 35, 'Not Cleared'),
(372, '19-0088', 70, 50, 'Cleared'),
(373, '19-0001', 71, 20, 'Not Cleared'),
(375, '19-0002', 71, 3, 'Not Cleared'),
(376, '19-0003', 71, 1, 'Not Cleared'),
(377, '19-0088', 71, 0, 'Not Cleared'),
(380, '19-0002', 72, 50, 'Cleared'),
(381, '19-0003', 72, 50, 'Not Cleared'),
(382, '19-0088', 72, 0, 'Not Cleared'),
(383, '19-0001', 73, 20, 'Not Cleared'),
(385, '19-0002', 73, 0, 'Not Cleared'),
(386, '19-0003', 73, 0, 'Not Cleared'),
(387, '19-0088', 73, 0, 'Not Cleared'),
(388, '19-0001', 74, 37, 'Not Cleared'),
(389, '19-0099', 74, 1, 'Not Cleared'),
(390, '19-0002', 74, 0, 'Not Cleared'),
(391, '19-0003', 74, 20, 'Not Cleared'),
(392, '19-0088', 74, 0, 'Not Cleared'),
(396, '19-0003', 75, 0, 'Not Cleared'),
(397, '19-0088', 75, 0, 'Not Cleared'),
(398, '19-0001', 76, 0, 'Not Cleared'),
(399, '19-0099', 76, 0, 'Not Cleared'),
(401, '19-0003', 76, 0, 'Not Cleared'),
(402, '19-0088', 76, 0, 'Not Cleared');

-- --------------------------------------------------------

--
-- Table structure for table `monthly_dues`
--

CREATE TABLE `monthly_dues` (
  `Student_ID` char(7) NOT NULL,
  `AUG` int(11) NOT NULL,
  `SEPT` int(11) NOT NULL,
  `OCT` int(11) NOT NULL,
  `NOV` int(11) NOT NULL,
  `DECE` int(11) NOT NULL,
  `JAN` int(11) NOT NULL,
  `FEB` int(11) NOT NULL,
  `MAR` int(11) NOT NULL,
  `APR` int(11) NOT NULL,
  `MAY` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `monthly_dues`
--

INSERT INTO `monthly_dues` (`Student_ID`, `AUG`, `SEPT`, `OCT`, `NOV`, `DECE`, `JAN`, `FEB`, `MAR`, `APR`, `MAY`) VALUES
('19-0001', 50, 0, 50, 0, 30, 0, 0, 0, 0, 0),
('19-0002', 50, 30, 20, 1, 0, 0, 0, 0, 0, 5),
('19-0003', 50, 40, 20, 0, 0, 0, 0, 0, 0, 0),
('19-0088', 10, 0, 0, 40, 0, 0, 0, 0, 0, 0),
('19-0099', 160, 20, 0, 0, 30, 0, 0, 0, 70, 50);

-- --------------------------------------------------------

--
-- Table structure for table `payment_records`
--

CREATE TABLE `payment_records` (
  `Payment_ID` int(10) UNSIGNED NOT NULL,
  `Student_ID` char(7) NOT NULL,
  `Payment_Date` datetime NOT NULL DEFAULT current_timestamp(),
  `Amount` int(11) NOT NULL,
  `Payment_Type` enum('Monthly Due','Fine') NOT NULL,
  `Month` enum('AUG','SEPT','OCT','NOV','DECE','JAN','FEB','MAR','APR','MAY') DEFAULT NULL,
  `Fine_ID` int(10) UNSIGNED DEFAULT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_records`
--

INSERT INTO `payment_records` (`Payment_ID`, `Student_ID`, `Payment_Date`, `Amount`, `Payment_Type`, `Month`, `Fine_ID`, `Description`) VALUES
(26, '19-0001', '2023-12-05 00:10:09', 20, 'Monthly Due', 'AUG', NULL, NULL),
(27, '19-0003', '2023-12-05 02:26:54', 20, 'Monthly Due', 'AUG', NULL, NULL),
(28, '19-0003', '2023-12-05 09:29:33', 30, 'Fine', NULL, 371, NULL),
(29, '19-0003', '2023-12-05 09:30:01', 20, 'Fine', NULL, 371, NULL),
(30, '19-0099', '2023-12-05 02:44:10', 50, 'Monthly Due', 'AUG', NULL, NULL),
(31, '19-0099', '2023-12-05 02:44:29', 50, 'Monthly Due', 'AUG', NULL, NULL),
(32, '19-0099', '2023-12-05 02:44:39', 50, 'Monthly Due', 'AUG', NULL, NULL),
(33, '19-0099', '2023-12-05 02:44:58', 50, 'Monthly Due', 'MAY', NULL, NULL),
(34, '19-0088', '2023-12-05 09:51:11', 20, 'Fine', NULL, 372, NULL),
(35, '19-0001', '2023-12-05 03:04:08', 30, 'Monthly Due', 'AUG', NULL, NULL),
(36, '19-0088', '2023-12-05 10:05:38', 30, 'Fine', NULL, 372, NULL),
(37, '19-0099', '2023-12-05 03:11:46', 50, 'Monthly Due', 'APR', NULL, NULL),
(38, '19-0003', '2023-12-05 03:13:27', 10, 'Monthly Due', 'SEPT', NULL, NULL),
(39, '19-0003', '2023-12-05 03:13:39', 30, 'Monthly Due', 'SEPT', NULL, NULL),
(40, '19-0002', '2023-12-05 04:04:40', 20, 'Monthly Due', 'AUG', NULL, NULL),
(41, '19-0003', '2023-12-05 11:06:47', -20, 'Fine', NULL, 371, NULL),
(42, '19-0003', '2023-12-05 04:18:24', 30, 'Monthly Due', 'AUG', NULL, NULL),
(43, '19-0002', '2023-12-05 11:19:52', 50, 'Fine', NULL, 380, NULL),
(44, '19-0002', '2023-12-05 04:30:45', 30, 'Monthly Due', 'AUG', NULL, NULL),
(45, '19-0002', '2023-12-05 04:31:02', 30, 'Monthly Due', 'SEPT', NULL, NULL),
(46, '19-0002', '2023-12-05 04:31:37', 20, 'Monthly Due', 'OCT', NULL, NULL),
(47, '19-0001', '2023-12-05 11:36:21', 20, 'Fine', NULL, 383, NULL),
(48, '19-0099', '2023-12-14 05:07:25', 10, 'Monthly Due', 'AUG', NULL, NULL),
(49, '19-0001', '2023-12-14 06:50:36', 50, 'Monthly Due', 'AUG', NULL, NULL),
(50, '19-0001', '2023-12-14 06:52:39', 50, 'Monthly Due', 'OCT', NULL, NULL),
(51, '19-0001', '2023-12-14 06:53:05', -50, 'Monthly Due', 'AUG', NULL, NULL),
(52, '19-0001', '2023-12-14 06:54:18', -30, 'Monthly Due', 'DECE', NULL, NULL),
(53, '19-0088', '2023-12-14 06:55:36', 40, 'Monthly Due', 'NOV', NULL, NULL),
(54, '19-0003', '2023-12-14 13:57:11', 50, 'Fine', NULL, 381, NULL),
(55, '19-0001', '2024-05-16 11:33:05', 20, 'Fine', NULL, 388, NULL),
(56, '19-0003', '2024-05-16 11:44:06', 1, 'Fine', NULL, 371, NULL),
(57, '19-0003', '2024-05-16 11:44:15', 1, 'Fine', NULL, 371, NULL),
(58, '19-0001', '2024-05-17 16:06:54', 20, 'Fine', NULL, 373, NULL),
(59, '19-0001', '2024-05-19 03:34:37', 2, 'Fine', NULL, 388, NULL),
(60, '19-0001', '2024-05-19 03:36:38', 2, 'Fine', NULL, 388, NULL),
(61, '19-0001', '2024-05-19 03:36:49', 2, 'Fine', NULL, 388, NULL),
(62, '19-0001', '2024-05-19 03:39:39', 2, 'Fine', NULL, 388, NULL),
(63, '19-0099', '2024-05-19 03:40:14', 1, 'Fine', NULL, 389, NULL),
(64, '19-0001', '2024-05-19 03:44:56', 1, 'Fine', NULL, 388, NULL),
(65, '19-0001', '2024-05-19 03:45:38', 1, 'Fine', NULL, 388, NULL),
(66, '19-0001', '2024-05-19 03:46:26', 1, 'Fine', NULL, 388, NULL),
(67, '19-0001', '2024-05-19 03:47:15', 1, 'Fine', NULL, 388, NULL),
(68, '19-0001', '2024-05-19 03:47:52', 1, 'Fine', NULL, 388, NULL),
(69, '19-0001', '2024-05-19 03:49:03', 1, 'Fine', NULL, 388, NULL),
(70, '19-0001', '2024-05-19 03:50:52', 1, 'Fine', NULL, 388, NULL),
(71, '19-0001', '2024-05-19 03:54:53', 1, 'Fine', NULL, 388, NULL),
(72, '19-0001', '2024-05-19 03:55:13', 1, 'Fine', NULL, 388, NULL),
(73, '19-0002', '2024-05-19 07:49:28', 1, 'Fine', NULL, 375, NULL),
(74, '19-0002', '2024-05-19 07:49:55', 1, 'Fine', NULL, 375, NULL),
(75, '19-0002', '2024-05-19 07:52:33', 1, 'Fine', NULL, 375, NULL),
(76, '19-0003', '2024-05-19 03:39:27', 10, 'Monthly Due', 'OCT', NULL, NULL),
(77, '19-0003', '2024-05-19 03:42:39', 10, 'Monthly Due', 'OCT', NULL, NULL),
(78, '19-0002', '2024-05-19 04:28:30', 1, 'Monthly Due', 'NOV', NULL, NULL),
(79, '19-0099', '2024-05-20 08:52:49', 20, 'Monthly Due', 'SEPT', NULL, NULL),
(80, '19-0002', '2024-05-21 00:31:31', 5, 'Monthly Due', 'MAY', NULL, NULL),
(81, '19-0099', '2024-05-21 00:47:11', 30, 'Monthly Due', 'DECE', NULL, NULL),
(82, '19-0001', '2024-05-21 00:47:29', 30, 'Monthly Due', 'DECE', NULL, NULL),
(83, '19-0001', '2024-05-21 00:48:15', 30, 'Monthly Due', 'DECE', NULL, NULL),
(84, '19-0003', '2024-05-21 07:22:12', 1, 'Fine', NULL, 376, NULL),
(85, '19-0003', '2024-05-21 07:43:21', 3, 'Fine', NULL, 371, NULL),
(86, '19-0099', '2024-05-21 02:08:39', 20, 'Monthly Due', 'APR', NULL, NULL),
(87, '19-0003', '2024-06-25 06:33:18', 20, 'Fine', NULL, 391, NULL),
(88, '19-0088', '2024-06-25 00:33:49', 10, 'Monthly Due', 'AUG', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student_information`
--

CREATE TABLE `student_information` (
  `Student_ID` char(7) NOT NULL,
  `Surname` varchar(20) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Middle_Name` varchar(20) DEFAULT NULL,
  `Suffix` varchar(5) DEFAULT NULL,
  `Year` int(10) UNSIGNED NOT NULL,
  `User_Type` enum('student','treasurer','secretary','admin') NOT NULL,
  `Password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_information`
--

INSERT INTO `student_information` (`Student_ID`, `Surname`, `First_Name`, `Middle_Name`, `Suffix`, `Year`, `User_Type`, `Password`) VALUES
('19-0001', 'Magallamento', 'Prinz Juancho', 'MiddleName', 'Sr.', 1, 'student', 'pass'),
('19-0002', 'Penido', 'Xenon', 'Zander', NULL, 2, 'student', 'pass2'),
('19-0003', 'Antoque', 'Jane', 'Tacan', NULL, 4, 'student', 'pass3'),
('19-0088', 'Landero', 'Glazy Kyle', 'Mirafuentes', NULL, 3, 'secretary', 'pass5678'),
('19-0099', 'Silva', 'Lysha', 'Tolentino', NULL, 3, 'treasurer', 'pass1234');

--
-- Triggers `student_information`
--
DELIMITER $$
CREATE TRIGGER `after_adding_student` AFTER INSERT ON `student_information` FOR EACH ROW INSERT INTO monthly_dues (Student_ID, AUG, SEPT, OCT, NOV, DECE, JAN, FEB, MAR, APR, MAY)
    VALUES (NEW.Student_ID, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`Attendance_ID`),
  ADD KEY `Event_ID` (`Event_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`Event_ID`);

--
-- Indexes for table `fines`
--
ALTER TABLE `fines`
  ADD PRIMARY KEY (`Fine_ID`),
  ADD KEY `Event_ID` (`Event_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `monthly_dues`
--
ALTER TABLE `monthly_dues`
  ADD PRIMARY KEY (`Student_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `payment_records`
--
ALTER TABLE `payment_records`
  ADD PRIMARY KEY (`Payment_ID`),
  ADD KEY `Fine_ID` (`Fine_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `student_information`
--
ALTER TABLE `student_information`
  ADD PRIMARY KEY (`Student_ID`),
  ADD UNIQUE KEY `Password` (`Password`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `Attendance_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `Event_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `fines`
--
ALTER TABLE `fines`
  MODIFY `Fine_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

--
-- AUTO_INCREMENT for table `payment_records`
--
ALTER TABLE `payment_records`
  MODIFY `Payment_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`Event_ID`) REFERENCES `events` (`Event_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `fines`
--
ALTER TABLE `fines`
  ADD CONSTRAINT `fines_ibfk_1` FOREIGN KEY (`Event_ID`) REFERENCES `events` (`Event_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fines_ibfk_2` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `monthly_dues`
--
ALTER TABLE `monthly_dues`
  ADD CONSTRAINT `monthly_dues_ibfk_1` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `payment_records`
--
ALTER TABLE `payment_records`
  ADD CONSTRAINT `payment_records_ibfk_1` FOREIGN KEY (`Fine_ID`) REFERENCES `fines` (`Fine_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_records_ibfk_2` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;
--
-- Database: `bscs-dss2`
--
CREATE DATABASE IF NOT EXISTS `bscs-dss2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bscs-dss2`;
--
-- Database: `data-sharing-system`
--
CREATE DATABASE IF NOT EXISTS `data-sharing-system` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `data-sharing-system`;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `Attendance_ID` int(10) UNSIGNED NOT NULL,
  `Event_ID` int(10) UNSIGNED NOT NULL,
  `Student_ID` char(7) NOT NULL,
  `Attendance_Status` enum('Present','Absent','') NOT NULL,
  `Attendance_Time` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`Attendance_ID`, `Event_ID`, `Student_ID`, `Attendance_Status`, `Attendance_Time`) VALUES
(368, 70, '19-0001', 'Present', '2023-12-05 07:21:55'),
(369, 70, '19-0099', 'Present', '2023-12-05 07:22:09'),
(370, 70, '19-0002', 'Present', '2023-12-05 07:22:02'),
(371, 70, '19-0003', '', '2023-12-05 07:21:37'),
(372, 70, '19-0088', '', '2023-12-05 07:21:37'),
(373, 71, '19-0001', '', '2023-12-05 09:28:08'),
(374, 71, '19-0099', 'Present', '2023-12-05 09:28:37'),
(375, 71, '19-0002', '', '2023-12-05 09:28:08'),
(376, 71, '19-0003', '', '2023-12-05 09:28:08'),
(377, 71, '19-0088', '', '2023-12-05 09:28:08'),
(378, 72, '19-0001', 'Present', '2023-12-05 10:06:57'),
(379, 72, '19-0099', 'Present', '2023-12-05 10:06:46'),
(380, 72, '19-0002', '', '2023-12-05 10:06:16'),
(381, 72, '19-0003', '', '2023-12-05 10:06:16'),
(382, 72, '19-0088', '', '2023-12-05 10:06:16'),
(383, 73, '19-0001', '', '2023-12-05 11:21:15'),
(384, 73, '19-0099', 'Present', '2023-12-05 11:21:33'),
(385, 73, '19-0002', '', '2023-12-05 11:21:15'),
(386, 73, '19-0003', '', '2023-12-05 11:21:15'),
(387, 73, '19-0088', '', '2023-12-05 11:21:15'),
(388, 74, '19-0001', '', '2023-12-05 11:33:58'),
(389, 74, '19-0099', '', '2023-12-05 11:33:58'),
(390, 74, '19-0002', '', '2023-12-05 11:33:58'),
(391, 74, '19-0003', '', '2023-12-05 11:33:58'),
(392, 74, '19-0088', '', '2023-12-05 11:33:58'),
(393, 75, '19-0001', 'Present', '2023-12-05 11:41:59'),
(394, 75, '19-0099', 'Present', '2023-12-05 11:42:06'),
(395, 75, '19-0002', 'Present', '2023-12-05 11:41:54'),
(396, 75, '19-0003', '', '2023-12-05 11:41:36'),
(397, 75, '19-0088', '', '2023-12-05 11:41:36'),
(398, 76, '19-0001', '', '2023-12-14 14:06:29'),
(399, 76, '19-0099', '', '2023-12-14 14:06:29'),
(400, 76, '19-0002', 'Present', '2023-12-14 14:06:49'),
(401, 76, '19-0003', '', '2023-12-14 14:06:29'),
(402, 76, '19-0088', '', '2023-12-14 14:06:29');

--
-- Triggers `attendance`
--
DELIMITER $$
CREATE TRIGGER `after_attendance_insert` AFTER INSERT ON `attendance` FOR EACH ROW IF NEW.attendance_status = '' THEN
    INSERT INTO fines (Fine_ID, Event_ID, Student_ID, Paid_Amount, Payment_Status)
    VALUES (NEW.Attendance_ID, NEW.Event_ID, NEW.Student_ID, 0, 'Not Cleared');
  END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_attendance_update` AFTER UPDATE ON `attendance` FOR EACH ROW IF NEW.attendance_status = 'Present' AND OLD.attendance_status = '' THEN
    -- If attendance_status changed from empty to 'Present', delete the record from fines
    DELETE FROM fines
    WHERE Student_ID = NEW.Student_ID AND Event_ID = NEW.Event_ID;
  END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `Event_ID` int(10) UNSIGNED NOT NULL,
  `Event_Name` varchar(30) NOT NULL,
  `Event_Date` date NOT NULL,
  `Closing_Time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`Event_ID`, `Event_Name`, `Event_Date`, `Closing_Time`) VALUES
(70, 'Software Engineering Day', '2023-12-05', '2023-12-05 07:23:00'),
(71, 'Software Engineering2', '2023-12-05', '2023-12-05 09:30:00'),
(72, 'Hugyaw', '2023-12-05', '2023-12-05 10:07:00'),
(73, 'Sem Ender', '2023-12-05', '2023-12-05 11:22:00'),
(74, 'Class', '2023-12-05', '2023-12-05 11:34:00'),
(75, 'Chapel Period', '2023-12-05', '2023-12-05 11:44:00'),
(76, 'party', '2023-12-18', '2023-12-18 15:06:00');

-- --------------------------------------------------------

--
-- Table structure for table `fines`
--

CREATE TABLE `fines` (
  `Fine_ID` int(10) UNSIGNED NOT NULL,
  `Student_ID` char(7) NOT NULL,
  `Event_ID` int(10) UNSIGNED NOT NULL,
  `Paid_Amount` int(11) NOT NULL,
  `Payment_Status` enum('Cleared','Not Cleared') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fines`
--

INSERT INTO `fines` (`Fine_ID`, `Student_ID`, `Event_ID`, `Paid_Amount`, `Payment_Status`) VALUES
(371, '19-0003', 70, 30, 'Not Cleared'),
(372, '19-0088', 70, 50, 'Cleared'),
(373, '19-0001', 71, 0, 'Not Cleared'),
(375, '19-0002', 71, 0, 'Not Cleared'),
(376, '19-0003', 71, 0, 'Not Cleared'),
(377, '19-0088', 71, 0, 'Not Cleared'),
(380, '19-0002', 72, 50, 'Cleared'),
(381, '19-0003', 72, 50, 'Not Cleared'),
(382, '19-0088', 72, 0, 'Not Cleared'),
(383, '19-0001', 73, 20, 'Not Cleared'),
(385, '19-0002', 73, 0, 'Not Cleared'),
(386, '19-0003', 73, 0, 'Not Cleared'),
(387, '19-0088', 73, 0, 'Not Cleared'),
(388, '19-0001', 74, 0, 'Not Cleared'),
(389, '19-0099', 74, 0, 'Not Cleared'),
(390, '19-0002', 74, 0, 'Not Cleared'),
(391, '19-0003', 74, 0, 'Not Cleared'),
(392, '19-0088', 74, 0, 'Not Cleared'),
(396, '19-0003', 75, 0, 'Not Cleared'),
(397, '19-0088', 75, 0, 'Not Cleared'),
(398, '19-0001', 76, 0, 'Not Cleared'),
(399, '19-0099', 76, 0, 'Not Cleared'),
(401, '19-0003', 76, 0, 'Not Cleared'),
(402, '19-0088', 76, 0, 'Not Cleared');

-- --------------------------------------------------------

--
-- Table structure for table `monthly_dues`
--

CREATE TABLE `monthly_dues` (
  `Student_ID` char(7) NOT NULL,
  `AUG` int(11) NOT NULL,
  `SEPT` int(11) NOT NULL,
  `OCT` int(11) NOT NULL,
  `NOV` int(11) NOT NULL,
  `DECE` int(11) NOT NULL,
  `JAN` int(11) NOT NULL,
  `FEB` int(11) NOT NULL,
  `MAR` int(11) NOT NULL,
  `APR` int(11) NOT NULL,
  `MAY` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `monthly_dues`
--

INSERT INTO `monthly_dues` (`Student_ID`, `AUG`, `SEPT`, `OCT`, `NOV`, `DECE`, `JAN`, `FEB`, `MAR`, `APR`, `MAY`) VALUES
('19-0001', 50, 0, 50, 0, -30, 0, 0, 0, 0, 0),
('19-0002', 50, 30, 20, 0, 0, 0, 0, 0, 0, 0),
('19-0003', 50, 40, 0, 0, 0, 0, 0, 0, 0, 0),
('19-0088', 0, 0, 0, 40, 0, 0, 0, 0, 0, 0),
('19-0099', 160, 0, 0, 0, 0, 0, 0, 0, 50, 50);

-- --------------------------------------------------------

--
-- Table structure for table `payment_records`
--

CREATE TABLE `payment_records` (
  `Payment_ID` int(10) UNSIGNED NOT NULL,
  `Student_ID` char(7) NOT NULL,
  `Payment_Date` datetime NOT NULL DEFAULT current_timestamp(),
  `Amount` int(11) NOT NULL,
  `Payment_Type` enum('Monthly Due','Fine') NOT NULL,
  `Month` enum('AUG','SEPT','OCT','NOV','DECE','JAN','FEB','MAR','APR','MAY') DEFAULT NULL,
  `Fine_ID` int(10) UNSIGNED DEFAULT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_records`
--

INSERT INTO `payment_records` (`Payment_ID`, `Student_ID`, `Payment_Date`, `Amount`, `Payment_Type`, `Month`, `Fine_ID`, `Description`) VALUES
(26, '19-0001', '2023-12-05 00:10:09', 20, 'Monthly Due', 'AUG', NULL, NULL),
(27, '19-0003', '2023-12-05 02:26:54', 20, 'Monthly Due', 'AUG', NULL, NULL),
(28, '19-0003', '2023-12-05 09:29:33', 30, 'Fine', NULL, 371, NULL),
(29, '19-0003', '2023-12-05 09:30:01', 20, 'Fine', NULL, 371, NULL),
(30, '19-0099', '2023-12-05 02:44:10', 50, 'Monthly Due', 'AUG', NULL, NULL),
(31, '19-0099', '2023-12-05 02:44:29', 50, 'Monthly Due', 'AUG', NULL, NULL),
(32, '19-0099', '2023-12-05 02:44:39', 50, 'Monthly Due', 'AUG', NULL, NULL),
(33, '19-0099', '2023-12-05 02:44:58', 50, 'Monthly Due', 'MAY', NULL, NULL),
(34, '19-0088', '2023-12-05 09:51:11', 20, 'Fine', NULL, 372, NULL),
(35, '19-0001', '2023-12-05 03:04:08', 30, 'Monthly Due', 'AUG', NULL, NULL),
(36, '19-0088', '2023-12-05 10:05:38', 30, 'Fine', NULL, 372, NULL),
(37, '19-0099', '2023-12-05 03:11:46', 50, 'Monthly Due', 'APR', NULL, NULL),
(38, '19-0003', '2023-12-05 03:13:27', 10, 'Monthly Due', 'SEPT', NULL, NULL),
(39, '19-0003', '2023-12-05 03:13:39', 30, 'Monthly Due', 'SEPT', NULL, NULL),
(40, '19-0002', '2023-12-05 04:04:40', 20, 'Monthly Due', 'AUG', NULL, NULL),
(41, '19-0003', '2023-12-05 11:06:47', -20, 'Fine', NULL, 371, NULL),
(42, '19-0003', '2023-12-05 04:18:24', 30, 'Monthly Due', 'AUG', NULL, NULL),
(43, '19-0002', '2023-12-05 11:19:52', 50, 'Fine', NULL, 380, NULL),
(44, '19-0002', '2023-12-05 04:30:45', 30, 'Monthly Due', 'AUG', NULL, NULL),
(45, '19-0002', '2023-12-05 04:31:02', 30, 'Monthly Due', 'SEPT', NULL, NULL),
(46, '19-0002', '2023-12-05 04:31:37', 20, 'Monthly Due', 'OCT', NULL, NULL),
(47, '19-0001', '2023-12-05 11:36:21', 20, 'Fine', NULL, 383, NULL),
(48, '19-0099', '2023-12-14 05:07:25', 10, 'Monthly Due', 'AUG', NULL, NULL),
(49, '19-0001', '2023-12-14 06:50:36', 50, 'Monthly Due', 'AUG', NULL, NULL),
(50, '19-0001', '2023-12-14 06:52:39', 50, 'Monthly Due', 'OCT', NULL, NULL),
(51, '19-0001', '2023-12-14 06:53:05', -50, 'Monthly Due', 'AUG', NULL, NULL),
(52, '19-0001', '2023-12-14 06:54:18', -30, 'Monthly Due', 'DECE', NULL, NULL),
(53, '19-0088', '2023-12-14 06:55:36', 40, 'Monthly Due', 'NOV', NULL, NULL),
(54, '19-0003', '2023-12-14 13:57:11', 50, 'Fine', NULL, 381, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student_information`
--

CREATE TABLE `student_information` (
  `Student_ID` char(7) NOT NULL,
  `Surname` varchar(20) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Middle_Name` varchar(20) DEFAULT NULL,
  `Suffix` varchar(5) DEFAULT NULL,
  `Year` int(10) UNSIGNED NOT NULL,
  `User_Type` enum('student','treasurer','secretary','admin') NOT NULL,
  `Password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_information`
--

INSERT INTO `student_information` (`Student_ID`, `Surname`, `First_Name`, `Middle_Name`, `Suffix`, `Year`, `User_Type`, `Password`) VALUES
('19-0001', 'Magallamento', 'Prinz Juancho', 'MiddleName', 'Sr.', 1, 'student', 'pass'),
('19-0002', 'Penido', 'Xenon', 'Zander', NULL, 2, 'student', 'pass2'),
('19-0003', 'Antoque', 'Jane', 'Tacan', NULL, 4, 'student', 'pass3'),
('19-0088', 'Landero', 'Glazy Kyle', 'Mirafuentes', NULL, 3, 'secretary', 'pass5678'),
('19-0099', 'Silva', 'Lysha', 'Tolentino', NULL, 3, 'treasurer', 'pass1234');

--
-- Triggers `student_information`
--
DELIMITER $$
CREATE TRIGGER `after_adding_student` AFTER INSERT ON `student_information` FOR EACH ROW INSERT INTO monthly_dues (Student_ID, AUG, SEPT, OCT, NOV, DECE, JAN, FEB, MAR, APR, MAY)
    VALUES (NEW.Student_ID, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`Attendance_ID`),
  ADD KEY `Event_ID` (`Event_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`Event_ID`);

--
-- Indexes for table `fines`
--
ALTER TABLE `fines`
  ADD PRIMARY KEY (`Fine_ID`),
  ADD KEY `Event_ID` (`Event_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `monthly_dues`
--
ALTER TABLE `monthly_dues`
  ADD PRIMARY KEY (`Student_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `payment_records`
--
ALTER TABLE `payment_records`
  ADD PRIMARY KEY (`Payment_ID`),
  ADD KEY `Fine_ID` (`Fine_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `student_information`
--
ALTER TABLE `student_information`
  ADD PRIMARY KEY (`Student_ID`),
  ADD UNIQUE KEY `Password` (`Password`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `Attendance_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `Event_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `fines`
--
ALTER TABLE `fines`
  MODIFY `Fine_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

--
-- AUTO_INCREMENT for table `payment_records`
--
ALTER TABLE `payment_records`
  MODIFY `Payment_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`Event_ID`) REFERENCES `events` (`Event_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `fines`
--
ALTER TABLE `fines`
  ADD CONSTRAINT `fines_ibfk_1` FOREIGN KEY (`Event_ID`) REFERENCES `events` (`Event_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fines_ibfk_2` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `monthly_dues`
--
ALTER TABLE `monthly_dues`
  ADD CONSTRAINT `monthly_dues_ibfk_1` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `payment_records`
--
ALTER TABLE `payment_records`
  ADD CONSTRAINT `payment_records_ibfk_1` FOREIGN KEY (`Fine_ID`) REFERENCES `fines` (`Fine_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_records_ibfk_2` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;
--
-- Database: `dss`
--
CREATE DATABASE IF NOT EXISTS `dss` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dss`;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `Attendance_ID` int(10) UNSIGNED NOT NULL,
  `Event_ID` int(10) UNSIGNED NOT NULL,
  `Student_ID` char(7) NOT NULL,
  `Attendance_Status` enum('Present','Absent','') NOT NULL,
  `Attendance_Time` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`Attendance_ID`, `Event_ID`, `Student_ID`, `Attendance_Status`, `Attendance_Time`) VALUES
(368, 70, '19-0001', 'Present', '2023-12-05 07:21:55'),
(369, 70, '19-0099', 'Present', '2023-12-05 07:22:09'),
(370, 70, '19-0002', 'Present', '2023-12-05 07:22:02'),
(371, 70, '19-0003', '', '2023-12-05 07:21:37'),
(372, 70, '19-0088', '', '2023-12-05 07:21:37'),
(373, 71, '19-0001', '', '2023-12-05 09:28:08'),
(374, 71, '19-0099', 'Present', '2023-12-05 09:28:37'),
(375, 71, '19-0002', '', '2023-12-05 09:28:08'),
(376, 71, '19-0003', '', '2023-12-05 09:28:08'),
(377, 71, '19-0088', '', '2023-12-05 09:28:08'),
(378, 72, '19-0001', 'Present', '2023-12-05 10:06:57'),
(379, 72, '19-0099', 'Present', '2023-12-05 10:06:46'),
(380, 72, '19-0002', '', '2023-12-05 10:06:16'),
(381, 72, '19-0003', '', '2023-12-05 10:06:16'),
(382, 72, '19-0088', '', '2023-12-05 10:06:16'),
(383, 73, '19-0001', '', '2023-12-05 11:21:15'),
(384, 73, '19-0099', 'Present', '2023-12-05 11:21:33'),
(385, 73, '19-0002', '', '2023-12-05 11:21:15'),
(386, 73, '19-0003', '', '2023-12-05 11:21:15'),
(387, 73, '19-0088', '', '2023-12-05 11:21:15'),
(388, 74, '19-0001', '', '2023-12-05 11:33:58'),
(389, 74, '19-0099', '', '2023-12-05 11:33:58'),
(390, 74, '19-0002', '', '2023-12-05 11:33:58'),
(391, 74, '19-0003', '', '2023-12-05 11:33:58'),
(392, 74, '19-0088', '', '2023-12-05 11:33:58'),
(393, 75, '19-0001', 'Present', '2023-12-05 11:41:59'),
(394, 75, '19-0099', 'Present', '2023-12-05 11:42:06'),
(395, 75, '19-0002', 'Present', '2023-12-05 11:41:54'),
(396, 75, '19-0003', '', '2023-12-05 11:41:36'),
(397, 75, '19-0088', '', '2023-12-05 11:41:36'),
(398, 76, '19-0001', '', '2023-12-14 14:06:29'),
(399, 76, '19-0099', '', '2023-12-14 14:06:29'),
(400, 76, '19-0002', 'Present', '2023-12-14 14:06:49'),
(401, 76, '19-0003', '', '2023-12-14 14:06:29'),
(402, 76, '19-0088', '', '2023-12-14 14:06:29'),
(403, 77, '19-0001', '', '2024-06-24 22:06:54'),
(404, 77, '19-0099', '', '2024-06-24 22:06:54'),
(405, 77, '19-0002', '', '2024-06-24 22:06:54'),
(406, 77, '19-0003', '', '2024-06-24 22:06:54'),
(407, 77, '19-0088', '', '2024-06-24 22:06:54');

--
-- Triggers `attendance`
--
DELIMITER $$
CREATE TRIGGER `after_attendance_insert` AFTER INSERT ON `attendance` FOR EACH ROW IF NEW.attendance_status = '' THEN
    INSERT INTO fines (Fine_ID, Event_ID, Student_ID, Paid_Amount, Payment_Status)
    VALUES (NEW.Attendance_ID, NEW.Event_ID, NEW.Student_ID, 0, 'Not Cleared');
  END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_attendance_update` AFTER UPDATE ON `attendance` FOR EACH ROW IF NEW.attendance_status = 'Present' AND OLD.attendance_status = '' THEN
    -- If attendance_status changed from empty to 'Present', delete the record from fines
    DELETE FROM fines
    WHERE Student_ID = NEW.Student_ID AND Event_ID = NEW.Event_ID;
  END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `Event_ID` int(10) UNSIGNED NOT NULL,
  `Event_Name` varchar(30) NOT NULL,
  `Event_Date` date NOT NULL,
  `Closing_Time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`Event_ID`, `Event_Name`, `Event_Date`, `Closing_Time`) VALUES
(70, 'Software Engineering Day', '2023-12-05', '2023-12-05 07:23:00'),
(71, 'Software Engineering2', '2023-12-05', '2023-12-05 09:30:00'),
(72, 'Hugyaw', '2023-12-05', '2023-12-05 10:07:00'),
(73, 'Sem Ender', '2023-12-05', '2023-12-05 11:22:00'),
(74, 'Class', '2023-12-05', '2023-12-05 11:34:00'),
(75, 'Chapel Period', '2023-12-05', '2023-12-05 11:44:00'),
(76, 'party', '2023-12-18', '2023-12-18 15:06:00'),
(77, 'Event Number 1', '2024-06-24', '2024-06-24 22:07:00');

-- --------------------------------------------------------

--
-- Table structure for table `fines`
--

CREATE TABLE `fines` (
  `Fine_ID` int(10) UNSIGNED NOT NULL,
  `Student_ID` char(7) NOT NULL,
  `Event_ID` int(10) UNSIGNED NOT NULL,
  `Paid_Amount` int(11) NOT NULL,
  `Payment_Status` enum('Cleared','Not Cleared') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fines`
--

INSERT INTO `fines` (`Fine_ID`, `Student_ID`, `Event_ID`, `Paid_Amount`, `Payment_Status`) VALUES
(371, '19-0003', 70, 30, 'Not Cleared'),
(372, '19-0088', 70, 50, 'Cleared'),
(373, '19-0001', 71, 0, 'Not Cleared'),
(375, '19-0002', 71, 0, 'Not Cleared'),
(376, '19-0003', 71, 0, 'Not Cleared'),
(377, '19-0088', 71, 0, 'Not Cleared'),
(380, '19-0002', 72, 50, 'Cleared'),
(381, '19-0003', 72, 50, 'Not Cleared'),
(382, '19-0088', 72, 0, 'Not Cleared'),
(383, '19-0001', 73, 20, 'Not Cleared'),
(385, '19-0002', 73, 0, 'Not Cleared'),
(386, '19-0003', 73, 0, 'Not Cleared'),
(387, '19-0088', 73, 0, 'Not Cleared'),
(388, '19-0001', 74, 0, 'Not Cleared'),
(389, '19-0099', 74, 0, 'Not Cleared'),
(390, '19-0002', 74, 0, 'Not Cleared'),
(391, '19-0003', 74, 0, 'Not Cleared'),
(392, '19-0088', 74, 0, 'Not Cleared'),
(396, '19-0003', 75, 0, 'Not Cleared'),
(397, '19-0088', 75, 0, 'Not Cleared'),
(398, '19-0001', 76, 0, 'Not Cleared'),
(399, '19-0099', 76, 0, 'Not Cleared'),
(401, '19-0003', 76, 0, 'Not Cleared'),
(402, '19-0088', 76, 0, 'Not Cleared'),
(403, '19-0001', 77, 0, 'Not Cleared'),
(404, '19-0099', 77, 0, 'Not Cleared'),
(405, '19-0002', 77, 0, 'Not Cleared'),
(406, '19-0003', 77, 0, 'Not Cleared'),
(407, '19-0088', 77, 0, 'Not Cleared');

-- --------------------------------------------------------

--
-- Table structure for table `monthly_dues`
--

CREATE TABLE `monthly_dues` (
  `Student_ID` char(7) NOT NULL,
  `AUG` int(11) NOT NULL,
  `SEPT` int(11) NOT NULL,
  `OCT` int(11) NOT NULL,
  `NOV` int(11) NOT NULL,
  `DECE` int(11) NOT NULL,
  `JAN` int(11) NOT NULL,
  `FEB` int(11) NOT NULL,
  `MAR` int(11) NOT NULL,
  `APR` int(11) NOT NULL,
  `MAY` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `monthly_dues`
--

INSERT INTO `monthly_dues` (`Student_ID`, `AUG`, `SEPT`, `OCT`, `NOV`, `DECE`, `JAN`, `FEB`, `MAR`, `APR`, `MAY`) VALUES
('19-0001', 50, 0, 50, 0, -30, 0, 0, 0, 0, 0),
('19-0002', 50, 30, 20, 0, 0, 0, 0, 0, 0, 0),
('19-0003', 50, 40, 0, 0, 0, 0, 0, 0, 0, 0),
('19-0088', 0, 0, 0, 40, 0, 0, 0, 0, 0, 0),
('19-0099', 160, 0, 0, 0, 0, 0, 0, 0, 50, 50);

-- --------------------------------------------------------

--
-- Table structure for table `payment_records`
--

CREATE TABLE `payment_records` (
  `Payment_ID` int(10) UNSIGNED NOT NULL,
  `Student_ID` char(7) NOT NULL,
  `Payment_Date` datetime NOT NULL DEFAULT current_timestamp(),
  `Amount` int(11) NOT NULL,
  `Payment_Type` enum('Monthly Due','Fine') NOT NULL,
  `Month` enum('AUG','SEPT','OCT','NOV','DECE','JAN','FEB','MAR','APR','MAY') DEFAULT NULL,
  `Fine_ID` int(10) UNSIGNED DEFAULT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_records`
--

INSERT INTO `payment_records` (`Payment_ID`, `Student_ID`, `Payment_Date`, `Amount`, `Payment_Type`, `Month`, `Fine_ID`, `Description`) VALUES
(26, '19-0001', '2023-12-05 00:10:09', 20, 'Monthly Due', 'AUG', NULL, NULL),
(27, '19-0003', '2023-12-05 02:26:54', 20, 'Monthly Due', 'AUG', NULL, NULL),
(28, '19-0003', '2023-12-05 09:29:33', 30, 'Fine', NULL, 371, NULL),
(29, '19-0003', '2023-12-05 09:30:01', 20, 'Fine', NULL, 371, NULL),
(30, '19-0099', '2023-12-05 02:44:10', 50, 'Monthly Due', 'AUG', NULL, NULL),
(31, '19-0099', '2023-12-05 02:44:29', 50, 'Monthly Due', 'AUG', NULL, NULL),
(32, '19-0099', '2023-12-05 02:44:39', 50, 'Monthly Due', 'AUG', NULL, NULL),
(33, '19-0099', '2023-12-05 02:44:58', 50, 'Monthly Due', 'MAY', NULL, NULL),
(34, '19-0088', '2023-12-05 09:51:11', 20, 'Fine', NULL, 372, NULL),
(35, '19-0001', '2023-12-05 03:04:08', 30, 'Monthly Due', 'AUG', NULL, NULL),
(36, '19-0088', '2023-12-05 10:05:38', 30, 'Fine', NULL, 372, NULL),
(37, '19-0099', '2023-12-05 03:11:46', 50, 'Monthly Due', 'APR', NULL, NULL),
(38, '19-0003', '2023-12-05 03:13:27', 10, 'Monthly Due', 'SEPT', NULL, NULL),
(39, '19-0003', '2023-12-05 03:13:39', 30, 'Monthly Due', 'SEPT', NULL, NULL),
(40, '19-0002', '2023-12-05 04:04:40', 20, 'Monthly Due', 'AUG', NULL, NULL),
(41, '19-0003', '2023-12-05 11:06:47', -20, 'Fine', NULL, 371, NULL),
(42, '19-0003', '2023-12-05 04:18:24', 30, 'Monthly Due', 'AUG', NULL, NULL),
(43, '19-0002', '2023-12-05 11:19:52', 50, 'Fine', NULL, 380, NULL),
(44, '19-0002', '2023-12-05 04:30:45', 30, 'Monthly Due', 'AUG', NULL, NULL),
(45, '19-0002', '2023-12-05 04:31:02', 30, 'Monthly Due', 'SEPT', NULL, NULL),
(46, '19-0002', '2023-12-05 04:31:37', 20, 'Monthly Due', 'OCT', NULL, NULL),
(47, '19-0001', '2023-12-05 11:36:21', 20, 'Fine', NULL, 383, NULL),
(48, '19-0099', '2023-12-14 05:07:25', 10, 'Monthly Due', 'AUG', NULL, NULL),
(49, '19-0001', '2023-12-14 06:50:36', 50, 'Monthly Due', 'AUG', NULL, NULL),
(50, '19-0001', '2023-12-14 06:52:39', 50, 'Monthly Due', 'OCT', NULL, NULL),
(51, '19-0001', '2023-12-14 06:53:05', -50, 'Monthly Due', 'AUG', NULL, NULL),
(52, '19-0001', '2023-12-14 06:54:18', -30, 'Monthly Due', 'DECE', NULL, NULL),
(53, '19-0088', '2023-12-14 06:55:36', 40, 'Monthly Due', 'NOV', NULL, NULL),
(54, '19-0003', '2023-12-14 13:57:11', 50, 'Fine', NULL, 381, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student_information`
--

CREATE TABLE `student_information` (
  `Student_ID` char(7) NOT NULL,
  `Surname` varchar(20) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Middle_Name` varchar(20) DEFAULT NULL,
  `Suffix` varchar(5) DEFAULT NULL,
  `Year` int(10) UNSIGNED NOT NULL,
  `User_Type` enum('student','treasurer','secretary','admin') NOT NULL,
  `Password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_information`
--

INSERT INTO `student_information` (`Student_ID`, `Surname`, `First_Name`, `Middle_Name`, `Suffix`, `Year`, `User_Type`, `Password`) VALUES
('19-0001', 'Magallamento', 'Prinz Juancho', 'MiddleName', 'Sr.', 1, 'student', 'pass'),
('19-0002', 'Penido', 'Xenon', 'Zander', NULL, 2, 'student', 'pass2'),
('19-0003', 'Antoque', 'Jane', 'Tacan', NULL, 4, 'student', 'pass3'),
('19-0088', 'Landero', 'Glazy Kyle', 'Mirafuentes', NULL, 3, 'secretary', 'pass5678'),
('19-0099', 'Silva', 'Lysha', 'Tolentino', NULL, 3, 'treasurer', 'pass1234');

--
-- Triggers `student_information`
--
DELIMITER $$
CREATE TRIGGER `after_adding_student` AFTER INSERT ON `student_information` FOR EACH ROW INSERT INTO monthly_dues (Student_ID, AUG, SEPT, OCT, NOV, DECE, JAN, FEB, MAR, APR, MAY)
    VALUES (NEW.Student_ID, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`Attendance_ID`),
  ADD KEY `Event_ID` (`Event_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`Event_ID`);

--
-- Indexes for table `fines`
--
ALTER TABLE `fines`
  ADD PRIMARY KEY (`Fine_ID`),
  ADD KEY `Event_ID` (`Event_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `monthly_dues`
--
ALTER TABLE `monthly_dues`
  ADD PRIMARY KEY (`Student_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `payment_records`
--
ALTER TABLE `payment_records`
  ADD PRIMARY KEY (`Payment_ID`),
  ADD KEY `Fine_ID` (`Fine_ID`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- Indexes for table `student_information`
--
ALTER TABLE `student_information`
  ADD PRIMARY KEY (`Student_ID`),
  ADD UNIQUE KEY `Password` (`Password`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `Attendance_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=408;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `Event_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `fines`
--
ALTER TABLE `fines`
  MODIFY `Fine_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=408;

--
-- AUTO_INCREMENT for table `payment_records`
--
ALTER TABLE `payment_records`
  MODIFY `Payment_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`Event_ID`) REFERENCES `events` (`Event_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `fines`
--
ALTER TABLE `fines`
  ADD CONSTRAINT `fines_ibfk_1` FOREIGN KEY (`Event_ID`) REFERENCES `events` (`Event_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fines_ibfk_2` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `monthly_dues`
--
ALTER TABLE `monthly_dues`
  ADD CONSTRAINT `monthly_dues_ibfk_1` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `payment_records`
--
ALTER TABLE `payment_records`
  ADD CONSTRAINT `payment_records_ibfk_1` FOREIGN KEY (`Fine_ID`) REFERENCES `fines` (`Fine_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_records_ibfk_2` FOREIGN KEY (`Student_ID`) REFERENCES `student_information` (`Student_ID`) ON UPDATE CASCADE;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2019-10-21 13:37:09', '{\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `ssd`
--
CREATE DATABASE IF NOT EXISTS `ssd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ssd`;

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
(1, 'lyshasilva', 'Silva', 'Lysha', 'Tolentino', NULL, 'Sabbath School', 'pass1234');

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(4) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
