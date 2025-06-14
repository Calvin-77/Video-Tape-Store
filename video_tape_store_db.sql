-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2024 at 07:08 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `video_tape_store_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Role` enum('admin','user') DEFAULT 'user',
  `Token` varchar(255) NOT NULL,
  `Picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `Password`, `Email`, `Role`, `Token`, `Picture`) VALUES
(1, 'user', 'user', 'user@mail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MzQ0NTY0NzN9.U0aJKSiVBQ0DXC1-KZzA_8I5SZN3f4dvWTO-mjdJfjQ', '/assets/default_avatar.png\r\n'),
(2, 'admin', 'admin', 'admin@mail.com', 'admin', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MzQ0NTM1MTl9.HRXMM088sJKSanIQ9Mlha3j643Tzxf_a9rqZK0H-T5Y', '/assets/default_avatar.png\r\n'),
(7, 'arvin', 'arvin', 'arvin@gmail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MzQxOTUwMzd9.IshtbstjdEogF5WWdBKHOzWgdmM-F7_erD30-g1Mcmw', '/assets/default_avatar.png\r\n'),
(8, 'brandon', 'brandon', 'brandon@gmail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MzQxOTU0MzV9.iZ91BIHCMhaitjdbRtL0qVOdKR9uHWrDKxCpCmEGfYs', '/assets/default_avatar.png\r\n'),
(9, 'calvin', 'calvin', 'calvin@gmail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MzQ0NDk2MjJ9.vFwoqVscR4QXygk3sJE9zEc7Hnn_SMHFsz9dfwMjPGI', '/assets/default_avatar.png\r\n'),
(10, 'kenzi', 'kenzi', 'kenzi@gmail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MzQyNzQxNTd9.k_Ceu5ESfbPgrUXMJCi5c_gtQX9UYzd4PKoBPGPEQ8I', '/assets/default_avatar.png\r\n'),
(11, 'rizki', 'rizki', 'rizki@gmail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MzQyNzk5Nzh9.uTCjBZM3D-VYHAAZtiNE8UNucv3Fuuhfsl9ir6Ujz-8', '/assets/default_avatar.png\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `VideoTapeID` int(11) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Price` int(11) NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `Genre` varchar(255) NOT NULL,
  `Level` varchar(255) NOT NULL,
  `VideoTapeImage` varchar(100) DEFAULT NULL,
  `Image_landscape` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`VideoTapeID`, `Title`, `Price`, `Description`, `Genre`, `Level`, `VideoTapeImage`, `Image_landscape`) VALUES
(3, 'The Exorcist (1973)', 25000, 'One of the most profitable horror movies ever made, this tale of an exorcism is based loosely on actual events. When young Regan (Linda Blair) starts acting odd -- levitating, speaking in tongues -- her worried mother (Ellen Burstyn) seeks medical help, only to hit a dead end. A local priest (Jason Miller), however, thinks the girl may be seized by the devil. The priest makes a request to perform an exorcism, and the church sends in an expert (Max von Sydow) to help with the difficult job.', 'Horror', '18+', '/assets/The Exorcist.jpg', '/assets/The Exorcist (landscape).jpg'),
(4, 'Jurrasic Park (1993)', 25000, 'An industrialist invites some experts to visit his theme park of cloned dinosaurs. After a power failure, the creatures run loose, putting everyone\'s lives, including his grandchildren\'s, in danger.', 'Adventure', '13+', '/assets/Jurassic Park.jpg', '/assets/Jurassic Park (landscape).jpg'),
(6, 'IT (2017)', 25000, 'Seven helpless and bullied children are forced to face their worst nightmares when Pennywise, a shape-shifting clown, reappears. The clown, an ancient evil torments children before feeding on them.', 'Horror', '18+', '/assets/IT.jpg', '/assets/IT (landscape).jpg'),
(15, 'Titanic', 25000, 'Pemburu harta karun bernama Brock Lovett beserta timnya menjelajahi bangkai kapal RMS Titanic untuk mencari sebuah kalung berlian berharga yang diyakini terkubur di dasar laut bersama bangkai kapal tersebut. Sebuah peti berhasil ditemukan dan dibawa ke permukaan untuk dibuka. Sayangnya, peti tersebut tak berisi harta karun berharga, namun terdapat beberapa lembar kerja yang sudah hancur karena air laut. Salah satunya adalah lukisan seorang wanita dan terdapat tulisan 14 April 1912 bertanda tanga', 'Romance', '18+', '/assets/Titanic.jpg', '/assets/Titanic (landscape).jpg'),
(16, 'The Lion King', 25000, 'Di Tanah kebanggaan, Putra Raja Mufasa dan Ratu Sarabi, yang baru lahir, Simba dipersembahkan ke hewan-hewan yang berkumpul oleh Rafiki sang mandrill, dukun dan penasihat kerajaan. Adik laki-laki Mufasa, Scar, mendambakan takhta.\r\n\r\nScar, adik Mufasa, iri dengan posisi Simba sebagai pewaris takhta, dan ia bekerja sama dengan kawanan dubuk berusaha untuk menyingkirkannya. Scar membuat sebuah jebakan yang menggiring Simba dan Mufasa ke jurang dan menyuruh para hyena menggiring kawanan besar wildeb', 'Animation', 'SU', '/assets/The Lion King.jpg', '/assets/lion king (landscape).jpg'),
(17, 'Toy Story', 25000, 'Woody, mainan favorit Andy, khawatir jika setelah Andy menerima hadiah ulang tahunnya, yaitu mainan baru bernama Buzz, dia akan dilupakan. Lantas, ia pun membuat rencana untuk menyingkirkan Buzz.', 'Animation', 'SU', '/assets/Toy Story.jpg', '/assets/Toy Story (landscape).jpg'),
(18, 'Top Gun', 25000, 'Lebih dari 30 tahun mengabdi sebagai salah satu penerbang Angkatan Laut terbaik, Pete “Maverick” Mitchell berada dalam posisi dambaannya, melakukan aksi-aksi mendobrak sebagai pilot uji nan pemberani, dan menampik setiap kesempatan naik pangkat karena akan membuatnya tak bisa menerbangkan pesawatnya.', 'Action', '13+', '/assets/Top Gun.png', '/assets/Top Gun (landscape).png'),
(19, 'Central Intelligence', 25000, 'Hidup Calvin Joyner, seorang akuntan, berubah drastis setelah Bob Stone, teman sekelasnya saat di SMA, menyeret dirinya ke dalam sebuah operasi rahasia yang meragukan.', 'Comedy', 'SU', '/assets/Central Intelligence.jpg', '/assets/Central Intelligence (landscape).jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`VideoTapeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `VideoTapeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
