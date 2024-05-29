CREATE DATABASE  IF NOT EXISTS `booking_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `booking_project`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: booking_project
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `AdminID` int NOT NULL,
  `PersonID` int DEFAULT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AdminID`),
  KEY `PersonID` (`PersonID`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`PersonID`) REFERENCES `persons` (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,1,'Mahbub','123','mahbub@gmail.com','mahbub','ahmed'),(28,28,'Tonmoy','123','tonmoy_bisswas@gmail.com','Tonmoy','Bisswas');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `BookingID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `HostID` int DEFAULT NULL,
  `BookingDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `CheckInDate` datetime DEFAULT NULL,
  `CheckOutDate` datetime DEFAULT NULL,
  `TotalPrice` decimal(10,2) DEFAULT NULL,
  `BookingStatus` varchar(50) DEFAULT NULL,
  `AdvertID` int DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  KEY `UserID` (`UserID`),
  KEY `HostID` (`HostID`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`HostID`) REFERENCES `hosts` (`HostID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,5,1,'2024-05-02 16:29:41','2024-05-01 00:00:00','2024-05-05 00:00:00',200.00,'Not Yet Confirmed',2),(2,1,2,'2024-05-02 16:31:11','2024-05-01 00:00:00','2024-05-05 00:00:00',300.00,'Not Yet Confirmed',34),(3,1,2,'2024-05-02 16:31:17','2024-05-01 00:00:00','2024-05-05 00:00:00',150.00,'Not Yet Confirmed',64),(4,13,5,'2024-05-02 16:31:52','2024-05-01 00:00:00','2024-05-05 00:00:00',180.00,'Confirmed',73),(5,13,5,'2024-05-02 16:31:57','2024-05-01 00:00:00','2024-05-05 00:00:00',120.00,'Confirmed',74),(6,17,3,'2024-05-02 16:33:23','2024-05-01 00:00:00','2024-05-05 00:00:00',250.00,'Not Yet Confirmed',67),(7,17,3,'2024-05-02 16:33:37','2024-05-01 00:00:00','2024-05-05 00:00:00',120.00,'Confirmed',68),(8,9,9,'2024-05-02 16:33:57','2024-05-01 00:00:00','2024-05-05 00:00:00',120.00,'Not Yet Confirmed',85),(9,9,9,'2024-05-02 16:34:04','2024-05-01 00:00:00','2024-05-05 00:00:00',180.00,'Confirmed',86),(10,16,2,'2024-05-02 16:34:26','2024-05-01 00:00:00','2024-05-05 00:00:00',200.00,'Confirmed',65),(12,9,8,'2024-05-25 12:19:11','2024-05-01 00:00:00','2024-05-05 00:00:00',1500.00,'Not Yet Confirmed',91);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostadvertisements`
--

DROP TABLE IF EXISTS `hostadvertisements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hostadvertisements` (
  `AdvertID` int NOT NULL AUTO_INCREMENT,
  `HostID` int DEFAULT NULL,
  `AdvertisementContent` text,
  `AdvertisementDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `Title` varchar(255) DEFAULT NULL,
  `Price` int DEFAULT NULL,
  `Place` varchar(255) DEFAULT NULL,
  `Availability` varchar(250) DEFAULT NULL,
  `DiscountPercentage` decimal(5,2) DEFAULT '0.00',
  `DiscountActive` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`AdvertID`),
  KEY `HostID` (`HostID`),
  CONSTRAINT `hostadvertisements_ibfk_1` FOREIGN KEY (`HostID`) REFERENCES `hosts` (`HostID`),
  CONSTRAINT `hostadvertisements_chk_1` CHECK (((`DiscountPercentage` >= 0) and (`DiscountPercentage` <= 100)))
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostadvertisements`
--

LOCK TABLES `hostadvertisements` WRITE;
/*!40000 ALTER TABLE `hostadvertisements` DISABLE KEYS */;
INSERT INTO `hostadvertisements` VALUES (1,1,'Cozy apartment in the heart of the city','2024-05-02 15:37:37','City Apartment',100,'Downtown','Yes',0.00,0),(2,1,'Spacious house with garden and pool','2024-05-02 15:37:37','Family Home',200,'Suburbs','Yes',0.00,0),(3,1,'Luxury villa with panoramic sea view','2024-05-02 15:37:37','Sea View Villa',500,'Coast','Yes',0.00,0),(34,2,'Stylish beachfront villa with breathtaking views','2024-05-02 15:53:39','Beachfront Villa',300,'Beachfront','Yes',0.00,0),(64,2,'Cozy beach house steps away from the ocean','2024-05-02 15:54:13','Beach House Retreat',150,'Beachfront','Yes',0.00,0),(65,2,'Modern condo with ocean view balcony','2024-05-02 15:54:49','Ocean View Condo',200,'Oceanfront','No',0.00,0),(66,3,'Elegant mansion with private pool and beach access','2024-05-02 15:54:49','Luxury Mansion',800,'Beachfront','Yes',0.00,0),(67,3,'Secluded beach house surrounded by lush gardens','2024-05-02 15:54:49','Seaside Escape',250,'Beachfront','Yes',0.00,0),(68,3,'Contemporary apartment with stunning coastal views','2024-05-02 15:54:49','Coastal Apartment',120,'Coast','No',0.00,0),(69,4,'Rustic log cabin nestled in the mountains','2024-05-02 15:54:49','Mountain Cabin',180,'Mountains','Yes',0.00,0),(70,4,'Charming chalet with ski-in/ski-out access','2024-05-02 15:54:49','Ski Chalet Retreat',250,'Mountains','Yes',0.00,0),(71,4,'Tranquil mountain lodge with panoramic views','2024-05-02 15:54:49','Mountain Lodge',300,'Mountains','Yes',0.00,0),(72,5,'Idyllic lakeside cottage with private dock','2024-05-02 15:54:49','Lakeside Cottage',150,'Lakeside','Yes',0.00,0),(73,5,'Serene cabin retreat with stunning lake views','2024-05-02 15:54:49','Lakeview Cabin',180,'Lakeside','No',0.00,0),(74,5,'Cozy log cabin nestled in the woods','2024-05-02 15:54:49','Woodsy Retreat',120,'Forest','No',0.00,0),(75,6,'Charming countryside cottage with garden views','2024-05-02 15:54:49','Country Cottage',100,'Countryside','Yes',0.00,0),(76,6,'Peaceful farmhouse retreat surrounded by nature','2024-05-02 15:54:49','Farmhouse Retreat',200,'Countryside','Yes',0.00,0),(77,6,'Tranquil retreat with scenic views of rolling hills','2024-05-02 15:54:49','Hilltop Hideaway',150,'Hills','Yes',0.00,0),(78,7,'Quaint village house with rustic charm','2024-05-02 15:54:49','Village House',80,'Village','Yes',0.00,0),(79,7,'Historic cottage in the heart of the village','2024-05-02 15:54:49','Historic Cottage',120,'Village','Yes',0.00,0),(80,7,'Traditional farmhouse with modern amenities','2024-05-02 15:54:49','Farmhouse Getaway',150,'Countryside','Yes',0.00,0),(81,8,'Modern loft with urban chic decor','2024-05-02 15:54:49','Urban Loft',200,'City Center','Yes',0.00,0),(82,8,'Luxury penthouse with skyline views','2024-05-02 15:54:49','City Skyline Penthouse',500,'City Center','Yes',0.00,0),(83,8,'Sleek apartment in the heart of downtown','2024-05-02 15:54:49','Downtown Apartment',150,'City Center','Yes',0.00,0),(84,9,'Cozy studio apartment with city views','2024-05-02 15:54:49','City View Studio',100,'City Center','Yes',0.00,0),(85,9,'Chic urban apartment in trendy neighborhood','2024-05-02 15:54:49','Trendy Apartment',120,'Trendy District','Yes',0.00,0),(86,9,'Spacious loft with industrial-chic design','2024-05-02 15:54:49','Industrial Loft',180,'City Center','No',0.00,0),(87,10,'Elegant townhouse in historic district','2024-05-02 15:54:49','Historic Townhouse',250,'Historic District','Yes',0.00,0),(88,10,'Classic brownstone with charming character','2024-05-02 15:54:49','Brownstone Retreat',200,'City Center','Yes',0.00,0),(89,10,'Luxurious mansion with period details','2024-05-02 15:54:49','Period Mansion',800,'Estate','Yes',0.00,0),(90,8,'Stunning waterfront estate with private beach','2024-05-02 15:54:49','Waterfront Estate',1000,'Waterfront','Yes',0.00,0),(91,8,'Exclusive island retreat with panoramic ocean views','2024-05-02 15:54:49','Island Paradise',1500,'Island','Yes',20.00,1),(92,8,'Magnificent castle overlooking the sea','2024-05-02 15:54:49','Seaside Castle',2000,'Coast','Yes',0.00,0),(93,2,'Stylish beachfront villa with breathtaking views','2024-05-25 12:39:42','Beachfront Villa',300,'Beachfront','Yes',0.00,0);
/*!40000 ALTER TABLE `hostadvertisements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostrequests`
--

DROP TABLE IF EXISTS `hostrequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hostrequests` (
  `RequestID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `RequestStatus` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `RequestDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `AdminID` int DEFAULT NULL,
  `ResponseDate` datetime DEFAULT NULL,
  PRIMARY KEY (`RequestID`),
  KEY `UserID` (`UserID`),
  KEY `AdminID` (`AdminID`),
  CONSTRAINT `hostrequests_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `hostrequests_ibfk_2` FOREIGN KEY (`AdminID`) REFERENCES `admins` (`AdminID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostrequests`
--

LOCK TABLES `hostrequests` WRITE;
/*!40000 ALTER TABLE `hostrequests` DISABLE KEYS */;
INSERT INTO `hostrequests` VALUES (11,16,'Pending','2024-05-02 10:20:41',NULL,NULL),(13,25,'Pending','2024-05-02 15:08:09',NULL,NULL),(14,6,'Pending','2024-05-02 15:08:16',NULL,NULL);
/*!40000 ALTER TABLE `hostrequests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosts` (
  `HostID` int NOT NULL AUTO_INCREMENT,
  `PersonID` int DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `HostApprovalStatus` varchar(50) DEFAULT NULL,
  `PropertyAddress` varchar(255) DEFAULT NULL,
  `PropertyType` varchar(100) DEFAULT NULL,
  `Description` text,
  `Amenities` text,
  `PropertyName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`HostID`),
  KEY `PersonID` (`PersonID`),
  CONSTRAINT `hosts_ibfk_1` FOREIGN KEY (`PersonID`) REFERENCES `persons` (`PersonID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (1,2,'ahmed@gmail.com','123','Approved','Basundara, Dhaka','Hotel','It is one of the best hotels in Bangladesh','WiFi, Kitchen, Parking','Radisson Blu'),(2,8,'arif@gmail.com','123','Approved','Coxs Bazar','Hotel','It is one of the best hotels in Bangladesh','WiFi, Kitchen, Parking','Sonargao'),(3,14,'michael@gmail.com','password456','Approved','123 Main Street,New York','Apartment','It is one of the best hotels in Ney York.','WiFi, Kitchen, Parking','City Retreat'),(4,15,'sophie@gmail.com','password789','Approved','1314 Cedar Lane','Cottage','Quaint cottage near the lake','Lake access, Kayaks, BBQ Grill','Lakeside Haven'),(5,4,'rahul@gmail.com','123','Approved','1314 Cedar Lane','Cottage','Quaint cottage near the lake','Lake access, Kayaks, BBQ Grill','Lakeside Haven'),(6,7,'dipu@gmail.com','123','Approved','1314 Cedar Lane','Cottage','Quaint cottage near the lake','Lake access, Kayaks, BBQ Grill','Lakeside Haven'),(7,12,'sophia.carter@example.com','sophia456','Approved','1314 Cedar Lane','Cottage','Quaint cottage near the lake','Lake access, Kayaks, BBQ Grill','Lakeside Haven'),(8,22,'james@gmail.com','password789','Approved','1314 Cedar Lane','Cottage','Quaint cottage near the lake','Lake access, Kayaks, BBQ Grill','Lakeside Haven'),(9,19,'emma@gmail.com','password123','Approved','1314 Cedar Lane','Cottage','Quaint cottage near the lake','Lake access, Kayaks, BBQ Grill','Lakeside Haven'),(10,18,'jacob@gmail.com','password789','Approved','1314 Cedar Lane','Cottage','Quaint cottage near the lake','Lake access, Kayaks, BBQ Grill','Lakeside Haven');
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persons`
--

DROP TABLE IF EXISTS `persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persons` (
  `PersonID` int NOT NULL AUTO_INCREMENT,
  `Role` enum('User','Host','Admin') NOT NULL,
  PRIMARY KEY (`PersonID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persons`
--

LOCK TABLES `persons` WRITE;
/*!40000 ALTER TABLE `persons` DISABLE KEYS */;
INSERT INTO `persons` VALUES (1,'Admin'),(2,'Host'),(3,'User'),(4,'Host'),(5,'User'),(6,'User'),(7,'Host'),(8,'Host'),(9,'User'),(10,'User'),(11,'User'),(12,'Host'),(13,'User'),(14,'Host'),(15,'Host'),(16,'User'),(17,'User'),(18,'Host'),(19,'Host'),(20,'User'),(21,'User'),(22,'Host'),(23,'User'),(24,'User'),(25,'User'),(26,'User'),(27,'User'),(28,'Admin');
/*!40000 ALTER TABLE `persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `BookingID` int DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `Comment` text,
  `ReviewDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `userID` int DEFAULT NULL,
  PRIMARY KEY (`ReviewID`),
  KEY `BookingID` (`BookingID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`BookingID`) REFERENCES `bookings` (`BookingID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,4,5,'Amazing experience! The place was clean and the host was very accommodating.','2024-05-25 12:58:05',NULL),(2,5,4,'Great stay overall, but the WiFi was a bit slow.','2024-05-25 12:58:05',NULL),(3,9,3,'Decent place, but could use some maintenance.','2024-05-25 12:58:05',NULL),(4,10,5,'Fantastic location and beautiful views! Would love to stay here again.','2024-05-25 12:58:05',NULL);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `TransactionID` int NOT NULL AUTO_INCREMENT,
  `BookingID` int DEFAULT NULL,
  `PaymentAmount` decimal(10,2) DEFAULT NULL,
  `PaymentDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `PaymentStatus` varchar(50) DEFAULT NULL,
  `DiscountPercentage` decimal(5,2) DEFAULT '0.00',
  `DiscountAmount` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`TransactionID`),
  KEY `BookingID` (`BookingID`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`BookingID`) REFERENCES `bookings` (`BookingID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,5,120.00,'2024-05-02 16:51:50','Confirmed',0.00,0.00),(2,7,120.00,'2024-05-02 16:52:32','Confirmed',0.00,0.00),(3,4,180.00,'2024-05-02 16:53:18','Confirmed',0.00,0.00),(4,9,180.00,'2024-05-02 16:58:13','Confirmed',0.00,0.00),(5,10,200.00,'2024-05-02 16:58:19','Confirmed',0.00,0.00);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `PersonID` int DEFAULT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `ProfilePicture` varchar(255) DEFAULT NULL,
  `RegistrationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `LastLoginDate` datetime DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  KEY `PersonID` (`PersonID`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`PersonID`) REFERENCES `persons` (`PersonID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Mahbub','123','mahbub@gmail.com','mahbub','ahmed',NULL,'2024-05-02 09:06:17',NULL),(3,3,'tonmay','123','tonmay@example.com','tonmay','bissas',NULL,'2024-05-02 09:11:46',NULL),(5,5,'ruman','123','ruman@gmail.com','ruman','sarkar',NULL,'2024-05-02 09:12:14',NULL),(6,6,'shejan','123','shejan@gmail.com','abu','sayeam',NULL,'2024-05-02 09:12:57',NULL),(9,9,'tahsin','123','tahsin@gmail.com','tahsin','hasan',NULL,'2024-05-02 09:13:22',NULL),(10,10,'jane_smith','pass123','jane.smith@example.com','Jane','Smith',NULL,'2024-05-02 09:13:31',NULL),(11,11,'william_miller','will123','william.miller@example.com','William','Miller',NULL,'2024-05-02 09:13:41',NULL),(13,13,'emily','password123','emily@gmail.com','Emily','Wilson',NULL,'2024-05-02 10:06:08',NULL),(16,16,'alexander','password123','alexander@gmail.com','Alexander','Clark',NULL,'2024-05-02 10:07:23',NULL),(17,17,'olivia','password456','olivia@gmail.com','Olivia','Martinez',NULL,'2024-05-02 10:07:41',NULL),(20,20,'ava','password789','ava@gmail.com','Ava','Lopez',NULL,'2024-05-02 10:08:54',NULL),(21,21,'ethan','password123','ethan@gmail.com','Ethan','Gonzalez',NULL,'2024-05-02 10:09:17',NULL),(23,23,'lucas','password123','lucas@gmail.com','Lucas','Garcia',NULL,'2024-05-02 10:10:57',NULL),(24,24,'natalie','password123','natalie@gmail.com','Natalie','Portman',NULL,'2024-05-02 10:11:19',NULL),(25,25,'isabella','password456','isabella@gmail.com','Isabella','Martinez',NULL,'2024-05-02 10:11:55',NULL),(26,26,'tom','123','tom@gmail.com','Tom','Cruse',NULL,'2024-05-02 15:09:10',NULL),(27,27,'tom','123','tom_hal@gmail.com','Tom','holand',NULL,'2024-05-02 15:09:30',NULL),(28,28,'tonmoy','123','tonmoy_bissas','Tonmoy','Bisswas',NULL,'2024-05-02 15:09:30',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `WishlistID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `HostID` int DEFAULT NULL,
  `WishlistDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `AdvertisementID` int DEFAULT NULL,
  PRIMARY KEY (`WishlistID`),
  KEY `UserID` (`UserID`),
  KEY `HostID` (`HostID`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`HostID`) REFERENCES `hosts` (`HostID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (1,9,1,'2024-05-02 16:05:25',3),(2,9,1,'2024-05-02 16:05:59',2),(3,16,1,'2024-05-02 16:06:12',2),(4,16,2,'2024-05-02 16:06:27',34),(5,16,2,'2024-05-02 16:06:32',64),(6,24,4,'2024-05-02 16:07:10',70),(7,24,4,'2024-05-02 16:07:14',71),(8,17,6,'2024-05-02 16:07:33',75),(9,17,6,'2024-05-02 16:07:38',76),(11,21,7,'2024-05-02 16:09:01',79),(12,21,7,'2024-05-02 16:09:16',80);
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-29 19:50:26
