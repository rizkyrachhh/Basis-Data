-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 15, 2026 at 01:46 PM
-- Server version: 10.11.16-MariaDB-log
-- PHP Version: 8.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tugas2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `transaksi1` ()   BEGIN
START TRANSACTION;
INSERT INTO pasien
(id_pasien, nama_pasien, alamat_pasien, jenis_kelamin)
VALUES (24, 'Agus', 'Pontianak', 'L');
SELECT * FROM pasien;
COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transaksi2` ()   BEGIN
START TRANSACTION;
UPDATE pasien
SET nama_pasien = 'Septi'
WHERE id_pasien = '20';
ROLLBACK;
COMMIT;
SELECT * FROM pasien;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transaksi3` ()   BEGIN
START TRANSACTION;
INSERT INTO pasien (id_pasien, nama_pasien,
alamat_pasien, jenis_kelamin)
VALUES (22, 'Putri', 'Pontianak', 'P');
SAVEPOINT POINT1;

INSERT INTO pasien (id_pasien, nama_pasien,
alamat_pasien, jenis_kelamin)
VALUES (21, 'Bagas', 'Pontianak', 'L');
ROLLBACK TO POINT1;

INSERT INTO pasien (id_pasien, nama_pasien,
alamat_pasien, jenis_kelamin)
VALUES (30, 'Jecky', 'Pontianak', 'L');
COMMIT;
SELECT * FROM pasien;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `id_admin` int(3) NOT NULL,
  `waktu_jaga` varchar(50) DEFAULT NULL,
  `nama_admin` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `daftar`
--

CREATE TABLE `daftar` (
  `id_daftar` int(3) NOT NULL,
  `id_admin` int(3) DEFAULT NULL,
  `id_pasien` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dokter`
--

CREATE TABLE `dokter` (
  `id_dokter` int(3) NOT NULL,
  `nama_dokter` varchar(30) DEFAULT NULL,
  `tanggal_lahir` varchar(15) DEFAULT NULL,
  `spesialis` varchar(15) DEFAULT NULL,
  `waktu_kerja` varchar(50) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `alamat_dokter` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dokter_admin`
--

CREATE TABLE `dokter_admin` (
  `id_data` int(3) NOT NULL,
  `id_dokter` int(5) DEFAULT NULL,
  `id_admin` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `id_obat` int(3) NOT NULL,
  `kode_obat` varchar(5) NOT NULL,
  `nama_obat` varchar(30) NOT NULL,
  `harga` int(10) NOT NULL,
  `stock` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`id_obat`, `kode_obat`, `nama_obat`, `harga`, `stock`) VALUES
(1, 'A001', 'Paracetamol', 15000, 18),
(2, 'A002', 'Betadine', 8000, 10),
(3, 'A003', 'Amoxilin', 15000, 15);

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id_pasien` int(3) NOT NULL,
  `nama_pasien` varchar(30) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `alamat_pasien` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`id_pasien`, `nama_pasien`, `jenis_kelamin`, `alamat_pasien`) VALUES
(20, 'Rini', 'P', 'Pontianak'),
(22, 'Putri', 'P', 'Pontianak'),
(24, 'Agus', 'L', 'Pontianak'),
(26, 'Dimas', 'L', 'Pontianak'),
(27, 'Dina', 'P', 'Pontianak'),
(30, 'Jecky', 'L', 'Pontianak'),
(35, 'Angga', 'L', 'Pontianak');

-- --------------------------------------------------------

--
-- Table structure for table `pasien_dokter`
--

CREATE TABLE `pasien_dokter` (
  `id` int(3) NOT NULL,
  `id_dokter` int(3) DEFAULT NULL,
  `id_pasien` int(3) DEFAULT NULL,
  `resep` varchar(100) DEFAULT NULL,
  `waktu_periksa` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_obat`
--

CREATE TABLE `transaksi_obat` (
  `id_transaksi` int(3) NOT NULL,
  `id_pasien` int(5) NOT NULL,
  `id_obat` int(3) NOT NULL,
  `jumlah` int(10) NOT NULL,
  `total_harga` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi_obat`
--

INSERT INTO `transaksi_obat` (`id_transaksi`, `id_pasien`, `id_obat`, `jumlah`, `total_harga`) VALUES
(1, 24, 1, 2, 30000);

--
-- Triggers `transaksi_obat`
--
DELIMITER $$
CREATE TRIGGER `tg_jual` BEFORE INSERT ON `transaksi_obat` FOR EACH ROW UPDATE obat SET stock = stock - new.jumlah WHERE id_obat =
new.id_obat
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`id_admin`),
  ADD KEY `id_admin` (`id_admin`);

--
-- Indexes for table `daftar`
--
ALTER TABLE `daftar`
  ADD PRIMARY KEY (`id_daftar`),
  ADD KEY `id_daftar` (`id_daftar`),
  ADD KEY `id_admin` (`id_admin`),
  ADD KEY `id_pasien` (`id_pasien`);

--
-- Indexes for table `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id_dokter`),
  ADD KEY `id_dokter` (`id_dokter`);

--
-- Indexes for table `dokter_admin`
--
ALTER TABLE `dokter_admin`
  ADD PRIMARY KEY (`id_data`),
  ADD KEY `id_data` (`id_data`),
  ADD KEY `id_dokter` (`id_dokter`),
  ADD KEY `id_admin` (`id_admin`);

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id_obat`),
  ADD KEY `id_obat` (`id_obat`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id_pasien`),
  ADD KEY `id_pasien` (`id_pasien`);

--
-- Indexes for table `pasien_dokter`
--
ALTER TABLE `pasien_dokter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_dokter` (`id_dokter`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `transaksi_obat`
--
ALTER TABLE `transaksi_obat`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_transaksi` (`id_transaksi`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_obat` (`id_obat`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrator`
--
ALTER TABLE `administrator`
  MODIFY `id_admin` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `daftar`
--
ALTER TABLE `daftar`
  MODIFY `id_daftar` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id_dokter` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dokter_admin`
--
ALTER TABLE `dokter_admin`
  MODIFY `id_data` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id_obat` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id_pasien` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `pasien_dokter`
--
ALTER TABLE `pasien_dokter`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaksi_obat`
--
ALTER TABLE `transaksi_obat`
  MODIFY `id_transaksi` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `administrator`
--
ALTER TABLE `administrator`
  ADD CONSTRAINT `administrator_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `daftar` (`id_admin`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `daftar`
--
ALTER TABLE `daftar`
  ADD CONSTRAINT `daftar_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dokter_admin`
--
ALTER TABLE `dokter_admin`
  ADD CONSTRAINT `dokter_admin_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `administrator` (`id_admin`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dokter_admin_ibfk_2` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pasien_dokter`
--
ALTER TABLE `pasien_dokter`
  ADD CONSTRAINT `pasien_dokter_ibfk_1` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pasien_dokter_ibfk_2` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaksi_obat`
--
ALTER TABLE `transaksi_obat`
  ADD CONSTRAINT `transaksi_obat_ibfk_1` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaksi_obat_ibfk_2` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
