-- MySQL dump 10.13  Distrib 8.0.28, for macos11.6 (x86_64)
--
-- Host: localhost    Database: labc
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `labours`
--

DROP TABLE IF EXISTS `labours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labours` (
  `id` int NOT NULL AUTO_INCREMENT,
  `labour_name` varchar(45) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `wage` varchar(45) DEFAULT NULL,
  `age` varchar(45) DEFAULT NULL,
  `location_reference` int DEFAULT NULL,
  `work_reference` int DEFAULT NULL,
  `login_reference` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_reference_idx` (`location_reference`),
  KEY `work_reference_idx` (`work_reference`),
  CONSTRAINT `work_reference` FOREIGN KEY (`work_reference`) REFERENCES `work_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labours`
--

LOCK TABLES `labours` WRITE;
/*!40000 ALTER TABLE `labours` DISABLE KEYS */;
INSERT INTO `labours` VALUES (18,'worker-name','worker-adrs','w-phone','w-wage',NULL,NULL,1,NULL),(19,'ds',NULL,NULL,NULL,NULL,NULL,1,NULL),(20,'k','None','None','500','25',18,1,NULL),(21,'j','j','5','j','j',18,1,NULL),(22,'p','p','p','p','p',18,2,68);
/*!40000 ALTER TABLE `labours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (18,'abcd'),(19,'test');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (1,'admin','admin','admin','2022-02-03 23:59:59'),(55,'1','1','user','2022-11-30 17:52:41'),(56,'1','1','user','2022-11-30 17:53:45'),(57,'1','1','user','2022-11-30 17:54:19'),(61,'s','s','user','2023-02-01 23:54:29'),(66,'p','p','user','2023-02-01 23:57:12'),(67,'pop','opo','user','2023-02-01 23:57:50'),(68,'s','p','labour','2023-02-02 14:35:43');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lid` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `address` text,
  `adhaar_no` varchar(16) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `location_reference` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lid` (`lid`),
  KEY `location_reference_idx` (`location_reference`),
  CONSTRAINT `location_reference` FOREIGN KEY (`location_reference`) REFERENCES `locations` (`id`),
  CONSTRAINT `registration_ibfk_1` FOREIGN KEY (`lid`) REFERENCES `login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (1,1,'admin','admin','2022-02-03','admin','admin','admin','admin','2022-02-03 23:59:59',NULL),(2,57,'1','1','2022-11-22','1','sk@d.co','1',NULL,'2022-11-30 17:54:19',NULL),(3,66,'p','male','2023-03-03','2','p','p','p','2023-02-01 23:57:12',18),(4,67,'swetha','other','2023-02-18','888','po','po','pop','2023-02-01 23:57:50',18);
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_request`
--

DROP TABLE IF EXISTS `work_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_reference` int DEFAULT NULL,
  `worker_reference` int DEFAULT NULL,
  `date_of_request` datetime DEFAULT NULL,
  `work_date` date DEFAULT NULL,
  `status` varchar(45) DEFAULT 'pending',
  `work_description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `worker_reference` (`worker_reference`),
  KEY `user_reference` (`user_reference`),
  CONSTRAINT `work_request_ibfk_1` FOREIGN KEY (`worker_reference`) REFERENCES `labours` (`id`),
  CONSTRAINT `work_request_ibfk_2` FOREIGN KEY (`user_reference`) REFERENCES `registration` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_request`
--

LOCK TABLES `work_request` WRITE;
/*!40000 ALTER TABLE `work_request` DISABLE KEYS */;
INSERT INTO `work_request` VALUES (1,1,20,'2022-02-03 23:59:59','2022-02-03','approved',NULL),(2,4,18,'2023-02-02 13:03:54','2023-03-02','pending',NULL),(3,4,22,'2023-02-02 14:11:41','2023-02-24','pending','test');
/*!40000 ALTER TABLE `work_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_type`
--

DROP TABLE IF EXISTS `work_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `work_name` varchar(45) DEFAULT NULL,
  `location_reference` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_reference` (`location_reference`),
  CONSTRAINT `work_type_ibfk_1` FOREIGN KEY (`location_reference`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_type`
--

LOCK TABLES `work_type` WRITE;
/*!40000 ALTER TABLE `work_type` DISABLE KEYS */;
INSERT INTO `work_type` VALUES (1,'ss',18),(2,'5',19);
/*!40000 ALTER TABLE `work_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-22 16:06:54
