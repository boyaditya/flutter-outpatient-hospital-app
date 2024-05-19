-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2024 at 10:15 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `athena_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `coverage_type` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `queue_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `img_name` varchar(50) DEFAULT NULL,
  `interest` text DEFAULT NULL,
  `education` text DEFAULT NULL,
  `id_specialization` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `name`, `img_name`, `interest`, `education`, `id_specialization`) VALUES
(1, 'dr. Anita Susila, SpAk', 'anita.jpg', 'Akupuntur Kepala untuk Kasus Stroke Akupuntur untuk Nyeri Akupuntur untuk Insomnia Akupuntur untuk Infertilitas Pria dan Wanita termasuk Program IVF', 'Kedokteran Umum - Universitas Trisakti, Pendidikan Spesialis Akupunktur Medik - Universitas Indonesia', 1),
(2, 'dr. Budi Setiawan, MARS, SpAk', 'budi.jpg', 'Penyakit Stroke,  Nyeri Leher dan Tulang Punggung Low Back Pain Bell\'s Palsy Ansietas, Nyeri Lutut, Penyakit Asam Lambung, Sindroma Metabolik Estetika, Asma Autoimun Carpal Tunnel Syndrom, Frozen Shoulder Syndrom, Fertilitas', 'Universitas Atmajaya - Dokter Umum, Universitas Indonesia - Master Administrasi Rumah Sakit - MARS, Universitas - Spesialis Akupuntur - SpAK', 1),
(3, 'Dr. dr. Fajar Sutisna, M.Med., SpDV (Subsp.DKE)', 'fajar.png', 'Electrocauterization, Konsultasi Kulit dan Kelamin, Pengangkatan Kutil, Pengobatan Melasma, Perawatan Luka Bakar, Skrining, Sifilis', 'Universitas Sam Ratulangi, Manado', 2),
(5, 'dr. Hasan Basri, SpDV', 'hasan.png', 'General Dermatology, Aesthetic, Hair Transplantation, Skin Surgery.', 'Master Of Dermatology and Venereology, Chongqing Medical University, Chongqing, China, \r\nProgram adaptasi dokter spesialis kulit dan kelamin, Dept Dermatology & Venereology UGM, Yogyakarta, Indonesia.', 2),
(7, 'dr. Bayu Kusuma, M.Biomed, SpPD', 'bayu.png', 'Endokrin dan penyakit metabolik, Ginjal hipertensi, Hematologi onkologi medik, Gastroenterohepatologi, Rematologi, Pulmonologi, Kardiologi, Geriatri', 'Pendidikan Kedokteran Umum - Universitas Kristen Indonesia, Jakarta, Pendidikan Kedokteran Spesialis Penyakit Dalam - Universitas Udayana, Bal', 4),
(8, 'dr. Siti Rahayu, SpPD', 'siti.png', 'Infeksi Tropik, Reumatologi, Hematologi, Onkologi, Endokrin, Metabolik', 'Kedokteran Umum Universitas Kristen Indonesia, Spesialis Penyakit Dalam Universitas Indonesia.', 4),
(9, 'drg. Dewi Lestari', 'dewi.jpg', 'Dokter Gigi', 'Dokter Gigi, Universitas Lambung Mangkurat', 5),
(10, 'drg. Maya Sari, SpKG', 'maya.png', 'Aesthetic dentistry (smile design, veneering, and bleaching tooth), Operative restoration (filling with Amalgams, Composite), Cleaning and dental spa, Root canals treatments (basic and comprehensive endodontic treatments), Endodontic surgery, Crown & Bridge preparation, post, and core procedures, Prosthetic replacement of teeth, Implant Space maintenance, Basic non-surgical pulp capping, Pulpotomy, Pulpectomy Basic periodontal therapy including curettage, splinting, occlusal adjustment scaling & root planning, Single & uncomplicated extractions, Avulsed/luxated teeth, repositioning and stabilization, Local anesthesia, diagnostic blocks, Fixed & removable retainers, Complicated non-surgical root canal therapy for all permanent teeth, Gingival Flap Procedure, Gingivoplasty / Gingivectomy Alveoplasty, alveolectomy, Suture laceration (Intraoral)', 'Universitas Trisakti - Dokter Gigi, Universitas Trisakti - Spesialis Konservasi Gigi - SpKG, New York University (NYU) College Dentistry, Linhart Continuing Dental Education Program-The Aesthetic Advantage, USA, \r\nMicrovision Aesthetic Veneers,Taiwan with Dr Maxim Belograd, Implant of Osteem AIC Jakarta', 5);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_schedules`
--

CREATE TABLE `doctor_schedules` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `day` varchar(10) DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_schedules`
--

INSERT INTO `doctor_schedules` (`id`, `doctor_id`, `day`, `time`) VALUES
(1, 1, 'Selasa', '14.00 - 16.30'),
(2, 1, 'Rabu', '14.00 - 16.30'),
(3, 1, 'Kamis', '14.00 - 16.30'),
(4, 2, 'Senin', '08.00 - 12.00'),
(5, 2, 'Rabu', '13.00 - 17.00'),
(6, 2, 'Jumat', '08.00 - 12.00'),
(7, 3, 'Selasa', '10.00 - 14.00'),
(8, 3, 'Kamis', '08.30 - 12.30'),
(9, 3, 'Sabtu', '09.00 - 13.00'),
(10, 5, 'Senin', '09.00 - 13.00'),
(11, 5, 'Rabu', '14.00 - 18.00'),
(12, 5, 'Jumat', '14.00 - 18.00'),
(13, 7, 'Selasa', '08:00 - 12:00'),
(14, 7, 'Kamis', '13.00 - 17.00'),
(15, 7, 'Sabtu', '09.30 - 12.30'),
(16, 8, 'Senin', '11.00 - 15.00'),
(17, 8, 'Rabu', '08.00 - 12.00'),
(18, 8, 'Jumat', '13.00 - 16.00'),
(19, 9, 'Selasa', '09.00 - 13.00'),
(20, 9, 'Kamis', '10.00 - 14.00'),
(21, 9, 'Sabtu', '08.30 - 12.30'),
(22, 10, 'Senin', '08.30 - 12.30'),
(23, 10, 'Rabu', '09.00 - 13.00'),
(24, 10, 'Jumat', '14.00 - 18.00');

-- --------------------------------------------------------

--
-- Table structure for table `medical_records`
--

CREATE TABLE `medical_records` (
  `id` int(11) NOT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `complaint` varchar(255) DEFAULT NULL,
  `diagnosis` varchar(255) DEFAULT NULL,
  `treatment` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `nik` varchar(16) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `specializations`
--

CREATE TABLE `specializations` (
  `id` int(11) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `img_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `specializations`
--

INSERT INTO `specializations` (`id`, `title`, `description`, `img_name`) VALUES
(1, 'Akupuntur', 'Spesialis akupunktur adalah dokter spesialis yang membantu proses pemulihan menggunakan metode terapi dengan menusukkan jarum akupunktur kepermukan tubuh untuk tujuan preventif, promotive, rehabilitative dan paliatif berdasarkan diagnosis kedokteran dan menggunakan titik akupunktur yang telah terbukti secara ilmiah.', 'akupuntur.jpg'),
(2, 'Dermatologi', 'Spesialisasi dermatologi adalah bidang kedokteran yang berfokus pada diagnosis, pengobatan, dan manajemen berbagai kondisi yang mempengaruhi kulit, rambut, kuku, dan selaput lendir. Dermatologis merupakan dokter yang ahli dalam menangani masalah seperti gangguan kulit, infeksi kulit, alergi kulit, kanker kulit, gangguan pigmen, masalah rambut dan kulit kepala, serta penyakit menular seksual. ', 'dermatologi.jpg'),
(4, 'Penyakit Dalam', 'Spesialisasi penyakit dalam, atau dalam istilah medis dikenal sebagai spesialis internis, adalah cabang kedokteran yang berfokus pada diagnosis, pengobatan, dan manajemen berbagai penyakit pada organ dalam tubuh manusia. Dokter spesialis penyakit dalam atau internis, dikenal sebagai internis, mampu menangani berbagai kondisi medis kompleks, termasuk namun tidak terbatas pada penyakit kardiovaskular, gangguan pernapasan, gangguan pencernaan, gangguan hormonal, penyakit autoimun, dan gangguan imunologi.', 'penyakit_dalam.png'),
(5, 'Kedokteran Gigi', 'Spesialisasi kedokteran gigi adalah cabang kedokteran yang berfokus pada diagnosis, pencegahan, dan pengobatan berbagai kondisi yang memengaruhi mulut, gigi, dan struktur terkait. Dokter gigi yang menjalani spesialisasi ini dikenal sebagai spesialis gigi atau dokter gigi spesialis. ', 'gigi.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `hashed_password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `hashed_password`) VALUES
(7, '123', '$2b$12$/bGt5NNwhngAxpF2Txdf5uSUZfL6B7HT8Ks5zQwMQdwadRImthNYW'),
(8, '1', '$2b$12$/bGt5NNwhngAxpF2Txdf5u73TthYFbjs3XXsRIoewFytSIEcl6U82'),
(9, 'a', '$2b$12$/bGt5NNwhngAxpF2Txdf5uR4nSFTfEebG28zzNupK8Pitox0e/Mxi');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_specialization` (`id_specialization`);

--
-- Indexes for table `doctor_schedules`
--
ALTER TABLE `doctor_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `medical_records`
--
ALTER TABLE `medical_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_id` (`appointment_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `specializations`
--
ALTER TABLE `specializations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `doctor_schedules`
--
ALTER TABLE `doctor_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `medical_records`
--
ALTER TABLE `medical_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `specializations`
--
ALTER TABLE `specializations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);

--
-- Constraints for table `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`id_specialization`) REFERENCES `specializations` (`id`);

--
-- Constraints for table `doctor_schedules`
--
ALTER TABLE `doctor_schedules`
  ADD CONSTRAINT `doctor_schedules_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);

--
-- Constraints for table `medical_records`
--
ALTER TABLE `medical_records`
  ADD CONSTRAINT `medical_records_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`);

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
