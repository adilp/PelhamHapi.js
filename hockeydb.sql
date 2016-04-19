-- MySQL dump 10.13  Distrib 5.7.11, for osx10.10 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.5-10.0.19-MariaDB

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
-- Table structure for table `Address`
--

DROP TABLE IF EXISTS `Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Address` (
  `idAddress` int(11) NOT NULL AUTO_INCREMENT,
  `Address1` varchar(100) NOT NULL,
  `Address2` varchar(45) DEFAULT NULL,
  `State` varchar(45) NOT NULL,
  `City` varchar(45) NOT NULL,
  `Zip` varchar(45) NOT NULL,
  PRIMARY KEY (`idAddress`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
INSERT INTO `Address` VALUES (1,'address1','address2','Alabama','birmingham','35226');
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `JoinDate` datetime NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `AddressID` int(11) NOT NULL,
  `PhoneNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  KEY `AddressID_idx` (`AddressID`),
  CONSTRAINT `AddressID` FOREIGN KEY (`AddressID`) REFERENCES `Address` (`idAddress`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'adilp','adil123','adilp@uab.edu','Adil','Patel','1000-01-01 00:00:00',1,1,2054273072),(2,'maqboolp','adil123','maqbool.patel@gmail.com','Maqbool','Patel','1000-01-01 00:00:00',1,1,2054100356),(3,'ozairp','adil123','a@m','Ozair','Patel','1000-01-01 00:00:00',1,1,2054100356);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_location`
--

DROP TABLE IF EXISTS `master_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_location` (
  `idmaster_location` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(45) NOT NULL,
  PRIMARY KEY (`idmaster_location`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_location`
--

LOCK TABLES `master_location` WRITE;
/*!40000 ALTER TABLE `master_location` DISABLE KEYS */;
INSERT INTO `master_location` VALUES (1,'Main Rink'),(2,'Practice Rink');
/*!40000 ALTER TABLE `master_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_schedule`
--

DROP TABLE IF EXISTS `master_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_schedule` (
  `idmaster_schedule` int(11) NOT NULL AUTO_INCREMENT,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `idmaster_location` int(11) NOT NULL,
  `idmaster_scheduleType` int(11) NOT NULL,
  `isResReq` tinyint(1) NOT NULL,
  `numOfSpots` int(11) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`idmaster_schedule`),
  KEY `idmaster_location_idx` (`idmaster_location`),
  KEY `idmaster_scheduleType_idx` (`idmaster_scheduleType`),
  CONSTRAINT `idmaster_location` FOREIGN KEY (`idmaster_location`) REFERENCES `master_location` (`idmaster_location`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idmaster_scheduleType` FOREIGN KEY (`idmaster_scheduleType`) REFERENCES `master_scheduleType` (`idmaster_scheduleType`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_schedule`
--

LOCK TABLES `master_schedule` WRITE;
/*!40000 ALTER TABLE `master_schedule` DISABLE KEYS */;
INSERT INTO `master_schedule` VALUES (1,'1000-01-01 00:00:00','1000-01-01 00:00:00',1,1,1,30,1),(2,'1000-01-01 00:00:00','1000-01-01 00:00:00',2,2,1,10,1);
/*!40000 ALTER TABLE `master_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_scheduleType`
--

DROP TABLE IF EXISTS `master_scheduleType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master_scheduleType` (
  `idmaster_scheduleType` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`idmaster_scheduleType`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_scheduleType`
--

LOCK TABLES `master_scheduleType` WRITE;
/*!40000 ALTER TABLE `master_scheduleType` DISABLE KEYS */;
INSERT INTO `master_scheduleType` VALUES (1,'PickUp'),(2,'Stick and Puck');
/*!40000 ALTER TABLE `master_scheduleType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `idreservation` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `idmaster_schedule` int(11) NOT NULL,
  PRIMARY KEY (`idreservation`),
  KEY `idUser_idx` (`idUser`),
  KEY `idmaster_schedule_idx` (`idmaster_schedule`),
  CONSTRAINT `idUser` FOREIGN KEY (`idUser`) REFERENCES `User` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `idmaster_schedule` FOREIGN KEY (`idmaster_schedule`) REFERENCES `master_schedule` (`idmaster_schedule`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,1,1),(2,2,1),(3,2,2),(4,1,1),(5,1,2);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-14 19:24:35
