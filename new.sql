-- MySQL dump 10.13  Distrib 5.7.40, for Win64 (x86_64)
--
-- Host: localhost    Database: labc
-- ------------------------------------------------------
-- Server version	5.7.40-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feedback` varchar(200) NOT NULL,
  `user_reference` int(11) NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `userid_idx` (`user_reference`),
  CONSTRAINT `userid` FOREIGN KEY (`user_reference`) REFERENCES `registration` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (5,'had a good experience.',5,'2023-02-24 13:00:31'),(6,'the staff was polite enough and hardworking',5,'2023-02-24 13:01:01'),(7,'response from the laborer was good',5,'2023-02-24 16:14:05'),(8,'I think labour cloud is a best option for finding labours',5,'2023-02-24 16:17:48'),(9,'Staff  was hardworking and payment was not so high',5,'2023-02-27 12:00:17');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labours`
--

DROP TABLE IF EXISTS `labours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `labour_name` varchar(45) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `wage` varchar(45) DEFAULT NULL,
  `age` varchar(45) DEFAULT NULL,
  `location_reference` int(11) DEFAULT NULL,
  `work_reference` int(11) DEFAULT NULL,
  `login_reference` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_reference_idx` (`location_reference`),
  KEY `work_reference_idx` (`work_reference`),
  CONSTRAINT `work_reference` FOREIGN KEY (`work_reference`) REFERENCES `work_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labours`
--

LOCK TABLES `labours` WRITE;
/*!40000 ALTER TABLE `labours` DISABLE KEYS */;
INSERT INTO `labours` VALUES (18,'worker-name','worker-adrs','w-phone','w-wage',NULL,NULL,1,NULL),(19,'ds',NULL,NULL,NULL,NULL,NULL,1,NULL),(20,'k','None','None','500','25',18,1,NULL),(21,'j','j','5','j','j',18,1,NULL),(22,'p','p','p','p','p',18,2,68),(24,'Alex','edevayal','6282097786','500','24',25,15,72),(25,'ram','adukkadukkam(H)','9767665552','700','23',24,17,73),(26,'Saji Konal','pallimuku house','8749745689','500','39',25,10,76),(27,'Salvin','thekedath veedu','8977569823','500','32',25,11,79),(28,'shivan','thazhathuveetil','4587905678','500','45',21,5,81),(29,'sahadevan','keezhel','8796786789','500','42',26,22,82),(30,'676767','ghgfhghjgjk','-6','15','-6',25,19,83);
/*!40000 ALTER TABLE `labours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (18,'kottodi'),(19,'test'),(21,'malakall'),(22,'kallar'),(23,'koliichal'),(24,'chullikara'),(25,'rajapuram'),(26,'panathur');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (1,'admin','admin','admin','2022-02-03 23:59:59'),(55,'1','1','user','2022-11-30 17:52:41'),(56,'1','1','user','2022-11-30 17:53:45'),(57,'1','1','user','2022-11-30 17:54:19'),(61,'s','s','user','2023-02-01 23:54:29'),(66,'p','p','user','2023-02-01 23:57:12'),(67,'pop','opo','user','2023-02-01 23:57:50'),(68,'s','p','labour','2023-02-02 14:35:43'),(70,'majo123','Astra@123','user','2023-02-21 09:11:42'),(71,'alen','9656447732','labour','2023-02-21 09:15:52'),(72,'Alex','6282097786','labour','2023-02-21 09:41:01'),(73,'ram','9767665552','labour','2023-02-22 10:51:59'),(76,'Saji Konal','8749745689','labour','2023-03-01 22:38:59'),(79,'Salvin','8977569823','labour','2023-03-01 23:54:22'),(80,'mahesh123','Mahesh@123','user','2023-03-02 00:33:07'),(81,'shivan','4587905678','labour','2023-03-02 00:34:57'),(82,'sahadevan','8796786789','labour','2023-03-02 00:42:19'),(83,'676767','-6','labour','2023-03-02 14:32:15');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lid` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `address` text,
  `adhaar_no` varchar(16) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `location_reference` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lid` (`lid`),
  KEY `location_reference_idx` (`location_reference`),
  CONSTRAINT `location_reference` FOREIGN KEY (`location_reference`) REFERENCES `locations` (`id`),
  CONSTRAINT `registration_ibfk_1` FOREIGN KEY (`lid`) REFERENCES `login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (1,1,'admin','admin','2022-02-03','admin','admin','admin','admin','2022-02-03 23:59:59',NULL),(2,57,'1','1','2022-11-22','1','sk@d.co','1',NULL,'2022-11-30 17:54:19',NULL),(3,66,'p','male','2023-03-03','2','p','p','p','2023-02-01 23:57:12',18),(4,67,'u-name','other','2023-02-18','u-phone','po','po','pop','2023-02-01 23:57:50',18),(5,70,'Majo Augustine','male','2002-09-05','9544318109','dareitupmahn@gmail.com','manthottathil(h)','895638459455','2023-02-21 09:11:42',25),(6,80,'Mahesh Mohan','male','2000-11-09','7845764590','mahesh@gmail.com','keezhekunnel(h)','985623894589','2023-03-02 00:33:07',26);
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_request`
--

DROP TABLE IF EXISTS `work_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_reference` int(11) DEFAULT NULL,
  `worker_reference` int(11) DEFAULT NULL,
  `date_of_request` datetime DEFAULT NULL,
  `work_date` date DEFAULT NULL,
  `status` varchar(45) DEFAULT 'pending',
  `work_description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `worker_reference` (`worker_reference`),
  KEY `user_reference` (`user_reference`),
  CONSTRAINT `work_request_ibfk_1` FOREIGN KEY (`worker_reference`) REFERENCES `labours` (`id`),
  CONSTRAINT `work_request_ibfk_2` FOREIGN KEY (`user_reference`) REFERENCES `registration` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_request`
--

LOCK TABLES `work_request` WRITE;
/*!40000 ALTER TABLE `work_request` DISABLE KEYS */;
INSERT INTO `work_request` VALUES (1,1,20,'2022-02-03 23:59:59','2022-02-03','rejected',NULL),(2,4,18,'2023-02-02 13:03:54','2023-03-02','pending',NULL),(3,4,22,'2023-02-02 14:11:41','2023-02-24','pending','test'),(4,4,24,'2023-02-21 09:43:00','2023-02-23','approved','need to repair some switches'),(5,4,24,'2023-02-21 19:51:41','2023-02-22','rejected','need to repair some switches'),(6,5,24,'2023-02-22 13:59:13','2023-02-23','approved','jkiugu'),(7,5,24,'2023-02-22 14:05:59','2023-02-23','approved','uuuiii'),(8,5,24,'2023-02-24 11:33:48','2023-02-25','rejected','repair switches'),(9,5,24,'2023-02-24 13:54:57','2023-02-25','rejected','switches'),(10,5,24,'2023-02-24 13:58:24','2023-02-25','rejected','Day'),(11,5,24,'2023-02-24 15:32:29','2023-02-26','rejected','need to repair some switches'),(12,5,24,'2023-02-27 16:30:36','2023-02-28','approved',''),(13,5,24,'2023-03-01 10:52:57','2023-03-02','approved',''),(14,5,27,'2023-03-02 00:00:47','2023-03-03','approved','need to build a dog house'),(15,6,29,'2023-03-02 00:43:18','2023-03-03','rejected','need to tap 80 rubber trees'),(16,5,27,'2023-03-02 14:35:38','2023-05-31','rejected','klknjgi'),(17,5,24,'2023-03-02 14:40:47','2023-03-04','pending','jguf'),(18,5,27,'2023-03-03 20:54:27','2023-03-04','approved','fvvrgevft'),(19,6,29,'2023-03-15 20:10:40','2023-03-16','approved','need to tap 60 rubber');
/*!40000 ALTER TABLE `work_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_type`
--

DROP TABLE IF EXISTS `work_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `work_name` varchar(45) DEFAULT NULL,
  `location_reference` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_reference` (`location_reference`),
  CONSTRAINT `work_type_ibfk_1` FOREIGN KEY (`location_reference`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_type`
--

LOCK TABLES `work_type` WRITE;
/*!40000 ALTER TABLE `work_type` DISABLE KEYS */;
INSERT INTO `work_type` VALUES (1,'ss',18),(2,'5',19),(3,'electric work',21),(4,'construction',21),(5,'tapping',21),(6,'electric work',22),(7,'plumping',22),(8,'construction',22),(9,'construction',23),(10,'electric work',23),(11,'construction',25),(12,'plumping',25),(13,'electric work',24),(14,'plumping',24),(15,'electric work',25),(17,'tapping',24),(18,'welding',24),(19,'plumping',21),(20,'construction',26),(21,'electric work',26),(22,'tapping',26);
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

-- Dump completed on 2023-03-16 13:31:53
