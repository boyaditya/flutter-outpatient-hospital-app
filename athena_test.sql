/*
Navicat MySQL Data Transfer

Source Server         : Kashidota
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : athena_test

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2024-05-13 21:22:13
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `appointments`
-- ----------------------------
DROP TABLE IF EXISTS `appointments`;
CREATE TABLE `appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(20) NOT NULL,
  `coverage_type` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `queue_number` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_appointment_doctor` (`doctor_id`),
  KEY `fk_appointment_patient` (`patient_id`),
  CONSTRAINT `fk_appointment_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  CONSTRAINT `fk_appointment_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of appointments
-- ----------------------------
INSERT INTO `appointments` VALUES ('1', '1', '1', '2024-05-13', 'string', 'string', 'scheduled', '2024-05-13 14:15:52', '0');

-- ----------------------------
-- Table structure for `doctors`
-- ----------------------------
DROP TABLE IF EXISTS `doctors`;
CREATE TABLE `doctors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `img_name` varchar(50) NOT NULL,
  `interest` text NOT NULL,
  `education` text NOT NULL,
  `id_specialization` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_doctor_specialization` (`id_specialization`),
  CONSTRAINT `fk_doctor_specialization` FOREIGN KEY (`id_specialization`) REFERENCES `specializations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of doctors
-- ----------------------------
INSERT INTO `doctors` VALUES ('1', 'dr. Anita Susila, SpAk', 'anita.jpg', 'Akupuntur Kepala untuk Kasus Stroke Akupuntur untuk Nyeri Akupuntur untuk Insomnia Akupuntur untuk Infertilitas Pria dan Wanita termasuk Program IVF', 'Kedokteran Umum - Universitas Trisakti, Pendidikan Spesialis Akupunktur Medik - Universitas Indonesia', '1');
INSERT INTO `doctors` VALUES ('2', 'dr. Budi Setiawan, MARS, SpAk', 'budi.jpg', 'Penyakit Stroke,  Nyeri Leher dan Tulang Punggung Low Back Pain Bell\'s Palsy Ansietas, Nyeri Lutut, Penyakit Asam Lambung, Sindroma Metabolik Estetika, Asma Autoimun Carpal Tunnel Syndrom, Frozen Shoulder Syndrom, Fertilitas', 'Universitas Atmajaya - Dokter Umum, Universitas Indonesia - Master Administrasi Rumah Sakit - MARS, Universitas - Spesialis Akupuntur - SpAK', '1');
INSERT INTO `doctors` VALUES ('3', 'Dr. dr. Fajar Sutisna, M.Med., SpDV (Subsp.DKE)', 'fajar.png', 'Electrocauterization, Konsultasi Kulit dan Kelamin, Pengangkatan Kutil, Pengobatan Melasma, Perawatan Luka Bakar, Skrining, Sifilis', 'Universitas Sam Ratulangi, Manado', '2');
INSERT INTO `doctors` VALUES ('5', 'dr. Hasan Basri, SpDV', 'hasan.png', 'General Dermatology, Aesthetic, Hair Transplantation, Skin Surgery.', 'Master Of Dermatology and Venereology, Chongqing Medical University, Chongqing, China, \r\nProgram adaptasi dokter spesialis kulit dan kelamin, Dept Dermatology & Venereology UGM, Yogyakarta, Indonesia.', '2');
INSERT INTO `doctors` VALUES ('7', 'dr. Bayu Kusuma, M.Biomed, SpPD', 'bayu.png', 'Endokrin dan penyakit metabolik, Ginjal hipertensi, Hematologi onkologi medik, Gastroenterohepatologi, Rematologi, Pulmonologi, Kardiologi, Geriatri', 'Pendidikan Kedokteran Umum - Universitas Kristen Indonesia, Jakarta, Pendidikan Kedokteran Spesialis Penyakit Dalam - Universitas Udayana, Bal', '4');
INSERT INTO `doctors` VALUES ('8', 'dr. Siti Rahayu, SpPD', 'siti.png', 'Infeksi Tropik, Reumatologi, Hematologi, Onkologi, Endokrin, Metabolik', 'Kedokteran Umum Universitas Kristen Indonesia, Spesialis Penyakit Dalam Universitas Indonesia.', '4');
INSERT INTO `doctors` VALUES ('9', 'drg. Dewi Lestari', 'dewi.jpg', 'Dokter Gigi', 'Dokter Gigi, Universitas Lambung Mangkurat', '5');
INSERT INTO `doctors` VALUES ('10', 'drg. Maya Sari, SpKG', 'maya.png', 'Aesthetic dentistry (smile design, veneering, and bleaching tooth), Operative restoration (filling with Amalgams, Composite), Cleaning and dental spa, Root canals treatments (basic and comprehensive endodontic treatments), Endodontic surgery, Crown & Bridge preparation, post, and core procedures, Prosthetic replacement of teeth, Implant Space maintenance, Basic non-surgical pulp capping, Pulpotomy, Pulpectomy Basic periodontal therapy including curettage, splinting, occlusal adjustment scaling & root planning, Single & uncomplicated extractions, Avulsed/luxated teeth, repositioning and stabilization, Local anesthesia, diagnostic blocks, Fixed & removable retainers, Complicated non-surgical root canal therapy for all permanent teeth, Gingival Flap Procedure, Gingivoplasty / Gingivectomy Alveoplasty, alveolectomy, Suture laceration (Intraoral)', 'Universitas Trisakti - Dokter Gigi, Universitas Trisakti - Spesialis Konservasi Gigi - SpKG, New York University (NYU) College Dentistry, Linhart Continuing Dental Education Program-The Aesthetic Advantage, USA, \r\nMicrovision Aesthetic Veneers,Taiwan with Dr Maxim Belograd, Implant of Osteem AIC Jakarta', '5');

-- ----------------------------
-- Table structure for `doctor_schedules`
-- ----------------------------
DROP TABLE IF EXISTS `doctor_schedules`;
CREATE TABLE `doctor_schedules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) NOT NULL,
  `day` varchar(10) NOT NULL,
  `time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_schedule_doctor` (`doctor_id`),
  CONSTRAINT `fk_schedule_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of doctor_schedules
-- ----------------------------

-- ----------------------------
-- Table structure for `medical_records`
-- ----------------------------
DROP TABLE IF EXISTS `medical_records`;
CREATE TABLE `medical_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_id` int(11) NOT NULL,
  `complaint` varchar(255) NOT NULL,
  `diagnosis` varchar(255) NOT NULL,
  `treatment` varchar(255) NOT NULL,
  `notes` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_medrec_appointment` (`appointment_id`),
  CONSTRAINT `fk_medrec_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of medical_records
-- ----------------------------

-- ----------------------------
-- Table structure for `patients`
-- ----------------------------
DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `date_of_birth` date NOT NULL,
  `phone` varchar(15) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_patient_user` (`user_id`),
  CONSTRAINT `fk_patient_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of patients
-- ----------------------------
INSERT INTO `patients` VALUES ('1', 'Arul', '2024-05-13', 'string', 'string', 'string', '2');

-- ----------------------------
-- Table structure for `ratings`
-- ----------------------------
DROP TABLE IF EXISTS `ratings`;
CREATE TABLE `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `rating` float NOT NULL,
  `comment` text NOT NULL,
  `category` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rating_patient` (`patient_id`),
  CONSTRAINT `fk_rating_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of ratings
-- ----------------------------

-- ----------------------------
-- Table structure for `specializations`
-- ----------------------------
DROP TABLE IF EXISTS `specializations`;
CREATE TABLE `specializations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `img_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of specializations
-- ----------------------------
INSERT INTO `specializations` VALUES ('1', 'Akupuntur', 'Spesialis akupunktur adalah dokter spesialis yang membantu proses pemulihan menggunakan metode terapi dengan menusukkan jarum akupunktur kepermukan tubuh untuk tujuan preventif, promotive, rehabilitative dan paliatif berdasarkan diagnosis kedokteran dan menggunakan titik akupunktur yang telah terbukti secara ilmiah.', 'akupuntur.jpg');
INSERT INTO `specializations` VALUES ('2', 'Dermatologi', 'Spesialisasi dermatologi adalah bidang kedokteran yang berfokus pada diagnosis, pengobatan, dan manajemen berbagai kondisi yang mempengaruhi kulit, rambut, kuku, dan selaput lendir. Dermatologis merupakan dokter yang ahli dalam menangani masalah seperti gangguan kulit, infeksi kulit, alergi kulit, kanker kulit, gangguan pigmen, masalah rambut dan kulit kepala, serta penyakit menular seksual. ', 'dermatologi.jpg');
INSERT INTO `specializations` VALUES ('4', 'Penyakit Dalam', 'Spesialisasi penyakit dalam, atau dalam istilah medis dikenal sebagai spesialis internis, adalah cabang kedokteran yang berfokus pada diagnosis, pengobatan, dan manajemen berbagai penyakit pada organ dalam tubuh manusia. Dokter spesialis penyakit dalam atau internis, dikenal sebagai internis, mampu menangani berbagai kondisi medis kompleks, termasuk namun tidak terbatas pada penyakit kardiovaskular, gangguan pernapasan, gangguan pencernaan, gangguan hormonal, penyakit autoimun, dan gangguan imunologi.', 'penyakit_dalam.png');
INSERT INTO `specializations` VALUES ('5', 'Kedokteran Gigi', 'Spesialisasi kedokteran gigi adalah cabang kedokteran yang berfokus pada diagnosis, pencegahan, dan pengobatan berbagai kondisi yang memengaruhi mulut, gigi, dan struktur terkait. Dokter gigi yang menjalani spesialisasi ini dikenal sebagai spesialis gigi atau dokter gigi spesialis. ', 'gigi.jpg');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `hashed_password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('2', 'arul@gmail.com', '$2b$12$ByRaIo7bx9guHhI7tj9hLuAfFBjBTxjmWpsrU9vBHildoqcKcxfyW');
INSERT INTO `users` VALUES ('3', '1', '$2b$12$XjwXfqmFVgnVW5D2pO3KX.x5061bJmvwXOBQXIaazFbV9Ow47gfMC');
INSERT INTO `users` VALUES ('4', '2', '$2b$12$u9nKc2rR1yt3ZT4nUy2hXOy2j1QKoESpOyGXjM9BLSBURRStX4bLG');
INSERT INTO `users` VALUES ('5', '3', '$2b$12$.SHS89XsaooxKoWVNrfAy.7O4dpWZaPfarhvens2II/6E9arj6zIa');
