CREATE DATABASE  IF NOT EXISTS `transit_tracker` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `transit_tracker`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: transit_tracker
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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `street_no` varchar(8) NOT NULL,
  `street_name` varchar(64) NOT NULL,
  `city` varchar(64) NOT NULL,
  `state` char(2) NOT NULL,
  `zipcode` char(5) NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `street_no` (`street_no`,`street_name`,`city`,`state`,`zipcode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (4,'40','PARKER','AHMEDAHAD','MA','02120'),(1,'40','PARKER HILL AVE','BOSTON','MA','02120'),(3,'44','PARKER HILL AVE','BOSTON','MA','02120'),(2,'9','EGREMONT STREET','SAN DIEGO','CA','34512');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charlie_card`
--

DROP TABLE IF EXISTS `charlie_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charlie_card` (
  `card_id` varchar(16) NOT NULL,
  `card_type_id` int NOT NULL,
  `balance` double NOT NULL DEFAULT '0',
  `card_issue_date` date NOT NULL,
  `owner_username` varchar(16) NOT NULL,
  PRIMARY KEY (`card_id`),
  KEY `card_type_id` (`card_type_id`),
  KEY `owner_username` (`owner_username`),
  CONSTRAINT `charlie_card_ibfk_1` FOREIGN KEY (`card_type_id`) REFERENCES `charlie_card_type` (`card_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `charlie_card_ibfk_2` FOREIGN KEY (`owner_username`) REFERENCES `user_login` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charlie_card`
--

LOCK TABLES `charlie_card` WRITE;
/*!40000 ALTER TABLE `charlie_card` DISABLE KEYS */;
INSERT INTO `charlie_card` VALUES ('0000111',1,10,'2023-12-09','nakrani_m'),('1111111',1,20.200000000000003,'2022-06-05','nakrani_m'),('2222222',2,44.809999999999995,'2021-10-30','nakrani_m'),('2223334',1,50,'2023-12-09','nakrani_m'),('7777777',1,7.799999999999999,'2020-11-30','nakrani_m'),('9999999',2,3.9,'2023-12-07','nakrani_m');
/*!40000 ALTER TABLE `charlie_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charlie_card_type`
--

DROP TABLE IF EXISTS `charlie_card_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charlie_card_type` (
  `card_type_id` int NOT NULL AUTO_INCREMENT,
  `card_type` varchar(16) NOT NULL,
  `card_fare` double NOT NULL,
  PRIMARY KEY (`card_type_id`),
  UNIQUE KEY `card_type` (`card_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charlie_card_type`
--

LOCK TABLES `charlie_card_type` WRITE;
/*!40000 ALTER TABLE `charlie_card_type` DISABLE KEYS */;
INSERT INTO `charlie_card_type` VALUES (1,'NORMAL',2.4),(2,'REDUCED_FARE',1.1);
/*!40000 ALTER TABLE `charlie_card_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_card` (
  `card_number` char(16) NOT NULL,
  `card_type` enum('VISA','MASTERCARD','AMEX') NOT NULL,
  `cardholder_name` varchar(128) NOT NULL,
  `exp_date` date NOT NULL,
  PRIMARY KEY (`card_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
INSERT INTO `credit_card` VALUES ('1234123412341234','VISA','Mitul Nakrani','2028-08-08'),('3333333333333333','VISA','Mitul Nakrani','2027-03-01'),('9876987698769876','MASTERCARD','Mitul Nakrani','2028-12-01');
/*!40000 ALTER TABLE `credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journey`
--

DROP TABLE IF EXISTS `journey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journey` (
  `journey_id` int NOT NULL AUTO_INCREMENT,
  `journey_date` date NOT NULL,
  `travel_line` varchar(64) NOT NULL,
  `start_station` varchar(64) NOT NULL,
  `end_station` varchar(64) NOT NULL,
  `card_id` varchar(16) DEFAULT NULL,
  `username` varchar(16) NOT NULL,
  PRIMARY KEY (`journey_id`),
  KEY `travel_line` (`travel_line`,`start_station`),
  KEY `travel_line_2` (`travel_line`,`end_station`),
  KEY `card_id` (`card_id`),
  KEY `journey_ibfk_4` (`username`),
  CONSTRAINT `journey_ibfk_1` FOREIGN KEY (`travel_line`, `start_station`) REFERENCES `line_station` (`line_name`, `station_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `journey_ibfk_2` FOREIGN KEY (`travel_line`, `end_station`) REFERENCES `line_station` (`line_name`, `station_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `journey_ibfk_3` FOREIGN KEY (`card_id`) REFERENCES `charlie_card` (`card_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `journey_ibfk_4` FOREIGN KEY (`username`) REFERENCES `user_login` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journey`
--

LOCK TABLES `journey` WRITE;
/*!40000 ALTER TABLE `journey` DISABLE KEYS */;
INSERT INTO `journey` VALUES (1,'2023-11-23','GREEN','BRIGHAM CIRCLE','NORTHEASTERN',NULL,'nakrani_m'),(2,'2023-01-01','GREEN','NORTHEASTERN','BRIGHAM CIRCLE',NULL,'nakrani_m'),(3,'2023-01-05','GREEN','COPLEY','PARK STREET',NULL,'nakrani_m'),(4,'2022-06-22','ORANGE','ASSEMBLY','HAYMARKET','2222222','nakrani_m'),(5,'2023-12-08','ORANGE','BACK BAY','NORTH STATION','2222222','nakrani_m'),(6,'2023-12-09','ORANGE','DOWNTOWN CROSSING','OAK GRAVE','7777777','nakrani_m'),(7,'2023-12-10','ORANGE','NORTH STATION','RUGGLES','9999999','nakrani_m'),(8,'2023-12-12','ORANGE','STONY BROOK','ASSEMBLY',NULL,'nakrani_m'),(9,'2023-12-13','ORANGE','RUGGLES','ASSEMBLY','1111111','nakrani_m'),(10,'2023-12-14','ORANGE','BACK BAY','NORTH STATION','2222222','nakrani_m'),(11,'2023-12-15','GREEN','COPLEY','MEDFORD/TUFTS',NULL,'nakrani_m'),(12,'2023-12-16','GREEN','BRIGHAM CIRCLE','NORTHEASTERN','2222222','nakrani_m'),(13,'2023-12-16','GREEN','GOVT CENTER','HEATH STREET','2222222','nakrani_m'),(14,'2023-12-17','GREEN','HEATH STREET','NORTH STATION','7777777','nakrani_m'),(15,'2023-12-20','GREEN','GOVT CENTER','HEATH STREET',NULL,'nakrani_m'),(16,'2023-12-10','GREEN','BRIGHAM CIRCLE','MISSION HILL','1111111','nakrani_m'),(17,'2023-12-10','GREEN','BRIGHAM CIRCLE','NORTHEASTERN','7777777','nakrani_m');
/*!40000 ALTER TABLE `journey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line`
--

DROP TABLE IF EXISTS `line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line` (
  `line_name` varchar(64) NOT NULL,
  PRIMARY KEY (`line_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line`
--

LOCK TABLES `line` WRITE;
/*!40000 ALTER TABLE `line` DISABLE KEYS */;
INSERT INTO `line` VALUES ('GREEN'),('ORANGE'),('RED');
/*!40000 ALTER TABLE `line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line_station`
--

DROP TABLE IF EXISTS `line_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line_station` (
  `line_station_id` int NOT NULL AUTO_INCREMENT,
  `line_name` varchar(64) NOT NULL,
  `station_name` varchar(64) NOT NULL,
  PRIMARY KEY (`line_station_id`),
  UNIQUE KEY `line_name` (`line_name`,`station_name`),
  KEY `station_name` (`station_name`),
  CONSTRAINT `line_station_ibfk_1` FOREIGN KEY (`line_name`) REFERENCES `line` (`line_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `line_station_ibfk_2` FOREIGN KEY (`station_name`) REFERENCES `station` (`station_name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line_station`
--

LOCK TABLES `line_station` WRITE;
/*!40000 ALTER TABLE `line_station` DISABLE KEYS */;
INSERT INTO `line_station` VALUES (6,'GREEN','BRIGHAM CIRCLE'),(4,'GREEN','COPLEY'),(7,'GREEN','GOVT CENTER'),(3,'GREEN','HEATH STREET'),(9,'GREEN','MEDFORD/TUFTS'),(1,'GREEN','MISSION HILL'),(8,'GREEN','NORTH STATION'),(2,'GREEN','NORTHEASTERN'),(5,'GREEN','PARK STREET'),(22,'ORANGE','ASSEMBLY'),(18,'ORANGE','BACK BAY'),(19,'ORANGE','DOWNTOWN CROSSING'),(20,'ORANGE','HAYMARKET'),(21,'ORANGE','NORTH STATION'),(23,'ORANGE','OAK GRAVE'),(17,'ORANGE','RUGGLES'),(16,'ORANGE','STONY BROOK'),(10,'RED','ALEWIFE'),(14,'RED','BRAINTREE'),(12,'RED','DOWNTOWN CROSSING'),(15,'RED','HARVARD'),(11,'RED','PARK STREET'),(13,'RED','SOUTH STATION');
/*!40000 ALTER TABLE `line_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `station_name` varchar(64) NOT NULL,
  PRIMARY KEY (`station_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES ('AIRPORT'),('ALEWIFE'),('ASSEMBLY'),('BACK BAY'),('BRAINTREE'),('BRIGHAM CIRCLE'),('COPLEY'),('DOWNTOWN CROSSING'),('GOVT CENTER'),('HARVARD'),('HAYMARKET'),('HEATH STREET'),('MEDFORD/TUFTS'),('MISSION HILL'),('NORTH STATION'),('NORTHEASTERN'),('OAK GRAVE'),('PARK STREET'),('RUGGLES'),('SOUTH STATION'),('STONY BROOK');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_`
--

DROP TABLE IF EXISTS `user_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_` (
  `username` varchar(16) NOT NULL,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) NOT NULL,
  `address_id` int DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `contact_no` char(10) DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  PRIMARY KEY (`username`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `user__ibfk_1` FOREIGN KEY (`username`) REFERENCES `user_login` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user__ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_`
--

LOCK TABLES `user_` WRITE;
/*!40000 ALTER TABLE `user_` DISABLE KEYS */;
INSERT INTO `user_` VALUES ('nakrani','mitul','nakrani',4,'nakrani@gmail.com','1234567890','2002-10-02'),('nakrani_m','Mitul','PATEL',2,'nakrani.mi@northeastern.edu','9090909090','2001-10-30'),('patel_t','Tony','Patel',3,'patel.tony@northeastern.edu','1212121212','2001-12-10'),('shah_a','Aneri','Shah',1,'shah.ane@northeastern.edu','9898989898','2000-07-23');
/*!40000 ALTER TABLE `user_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_credit_card`
--

DROP TABLE IF EXISTS `user_credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_credit_card` (
  `username` varchar(16) NOT NULL,
  `card_number` char(16) NOT NULL,
  PRIMARY KEY (`username`,`card_number`),
  KEY `card_number` (`card_number`),
  CONSTRAINT `user_credit_card_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user_login` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_credit_card_ibfk_2` FOREIGN KEY (`card_number`) REFERENCES `credit_card` (`card_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_credit_card`
--

LOCK TABLES `user_credit_card` WRITE;
/*!40000 ALTER TABLE `user_credit_card` DISABLE KEYS */;
INSERT INTO `user_credit_card` VALUES ('nakrani_m','1234123412341234');
/*!40000 ALTER TABLE `user_credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login`
--

DROP TABLE IF EXISTS `user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login` (
  `username` varchar(16) NOT NULL,
  `pwd` varchar(16) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login`
--

LOCK TABLES `user_login` WRITE;
/*!40000 ALTER TABLE `user_login` DISABLE KEYS */;
INSERT INTO `user_login` VALUES ('nakrani','palak'),('nakrani_m','mitul'),('patel_t','tirth'),('shah_a','aneri');
/*!40000 ALTER TABLE `user_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'transit_tracker'
--

--
-- Dumping routines for database 'transit_tracker'
--
/*!50003 DROP FUNCTION IF EXISTS `if_user_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `if_user_exists`(
 username_ VARCHAR(16),
 pwd_ VARCHAR(16)
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN    
    DECLARE uname VARCHAR(16);
    
    SELECT username INTO uname FROM user_login 
	WHERE username = username_
    AND pwd = pwd_;
    
    IF uname IS NULL
    THEN
		RETURN FALSE;
    ELSE
		RETURN TRUE;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_username_taken` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_username_taken`(
username_ VARCHAR(16)
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE uname VARCHAR(16);
    
	SELECT username INTO uname FROM user_login
    WHERE username = username_;
    
    IF uname IS NULL
    THEN 
		RETURN FALSE;
	ELSE
		RETURN TRUE;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `user_journey_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `user_journey_count`(
username_ VARCHAR(16)
) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE total_journeys INT;
    DECLARE uname VARCHAR(16);
    
    SELECT username INTO uname FROM user_login
	WHERE username = username_;
        
	IF uname IS NOT NULL
	THEN
		SELECT COUNT(*) INTO total_journeys FROM journey
		WHERE card_id in 
		(SELECT card_id FROM charlie_card
		WHERE owner_username like username_
		);
		
		RETURN(total_journeys);
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_balance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_balance`(
IN username_ VARCHAR(16),
IN card_no_ CHAR(16),
IN card_id_ VARCHAR(16),
IN balance_ DOUBLE
)
BEGIN
    DECLARE uname VARCHAR(16);
    DECLARE credit_ CHAR(16);
    DECLARE charlie_ VARCHAR(16);
    DECLARE old_balance DOUBLE;

    SELECT username INTO uname FROM user_login
	WHERE username = username_;
	
	IF uname IS NOT NULL
	THEN
		SELECT card_number INTO credit_ FROM user_credit_card
        WHERE username = username_
        AND card_number = card_no_;
        
        IF credit_ IS NOT NULL
        THEN
			SELECT card_id, balance INTO charlie_, old_balance FROM charlie_card
			WHERE owner_username = username_
			AND card_id = card_id_;
            
            IF charlie_ IS NOT NULL
            THEN
				UPDATE charlie_card 
                SET balance = old_balance + balance_
                WHERE owner_username = username_
				AND card_id = card_id_;
            ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'CHARLIE CARD IS NOT LINKED TO THIS USER.';
            END IF;
        ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'CREDIT CARD IS NOT LINKED TO THIS USER.';
        END IF;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_charlie_card` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_charlie_card`(
IN username_ VARCHAR(16),
IN card_type_ VARCHAR(16),
IN card_id_ VARCHAR(16),
IN issue_date_ VARCHAR(10)
)
BEGIN    
    DECLARE c_id_ VARCHAR(16);
    DECLARE c_type_id INT;
    DECLARE uname VARCHAR(16);
    
    SELECT card_id INTO c_id_ FROM charlie_card 
	WHERE card_id = card_id_;
    
    IF c_id_ IS NULL
    THEN
		SELECT username INTO uname FROM user_login
        WHERE username = username_;
        
        IF uname IS NOT NULL
        THEN
			SELECT card_type_id INTO c_type_id FROM charlie_card_type 
			WHERE card_type = card_type_;
            
            IF c_type_id IS NOT NULL
            THEN
				INSERT INTO charlie_card(card_id, card_type_id, balance, card_issue_date, owner_username) 
				VALUES (card_id_,c_type_id, 0, issue_date_, username_);
			ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'CARD TYPE DOES NOT Exist in system.';
            END IF;
		ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
		END IF;
    ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Card Already Exists in system.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_credit_card` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_credit_card`(
IN username_ VARCHAR(16),
IN card_no_ CHAR(16),
IN card_type_ VARCHAR(24),
IN card_holder_name_ VARCHAR(64),
IN exp_date_ VARCHAR(10)
)
BEGIN
    DECLARE uname VARCHAR(16);
    DECLARE c_no_ CHAR(16);
    
    SELECT card_number INTO c_no_ FROM credit_card 
	WHERE card_number = card_no_;
    
    SELECT username INTO uname FROM user_login
	WHERE username = username_;
	
	IF uname IS NOT NULL
	THEN
		IF c_no_ IS NULL
        THEN
			INSERT INTO credit_card
            VALUES(card_no_, card_type_, card_holder_name_, exp_date_);
        END IF;
        
        INSERT INTO user_credit_card
        VALUES(username_, card_no_);
        
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `book_journey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `book_journey`(
IN username_ VARCHAR(16),
IN card_id_ VARCHAR(16),
IN line_ VARCHAR(64),
IN start_station_ VARCHAR(64),
IN end_station_ VARCHAR(64),
IN journey_date_ VARCHAR(10)
)
BEGIN
    DECLARE uname VARCHAR(16);
    DECLARE charlie_ VARCHAR(16);
    DECLARE old_balance DOUBLE;
    DECLARE l_ VARCHAR(64);
    DECLARE ss_ VARCHAR(64);
    DECLARE es_ VARCHAR(64);
    DECLARE c_type_id INT;
    DECLARE fare DOUBLE;

    SELECT username INTO uname FROM user_login
	WHERE username = username_;
	
	IF uname IS NOT NULL
	THEN
		SELECT card_id, card_type_id, balance INTO charlie_, c_type_id, old_balance FROM charlie_card
		WHERE owner_username = username_
		AND card_id = card_id_;
		
		IF charlie_ IS NOT NULL
		THEN
			SELECT line_name, station_name INTO l_, ss_
            FROM line_station
            WHERE line_name = line_
            AND station_name = start_station_;
            
            IF l_ IS NOT NULL AND ss_ IS NOT NULL
            THEN
				SELECT line_name, station_name INTO l_, es_
				FROM line_station
				WHERE line_name = line_
				AND station_name = end_station_;
                
                IF l_ IS NOT NULL AND es_ IS NOT NULL
                THEN
					SELECT card_fare INTO fare
                    FROM charlie_card_type
                    WHERE card_type_id = c_type_id;
                    
                    IF c_type_id <= old_balance
                    THEN
						UPDATE charlie_card
                        SET balance = old_balance - fare
                        WHERE owner_username = username_
						AND card_id = card_id_;
                        
                        INSERT INTO journey(journey_date, travel_line, start_station, end_station, card_id, username)
                        VALUES (journey_date_ , line_ , start_station_ ,end_station_ , card_id_, username_);
                    ELSE
						SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT = 'NOT ENOUGH BALANCE.';
                    END IF;
                ELSE
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'END STATION IS NOT ON LINE.';
                END IF;
            ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'START STATION IS NOT ON LINE.';
            END IF;
		ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'CHARLIE CARD IS NOT LINKED TO THIS USER.';
		END IF;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_user`(
IN username_ VARCHAR(16),
IN pwd VARCHAR(16),
IN firstname VARCHAR(64),
IN lastname VARCHAR(64),
IN street_no_ VARCHAR(8),
IN street_name_ VARCHAR(64),
IN city_ VARCHAR(64),
IN state_ CHAR(2),
IN zipcode_ CHAR(5),
IN email VARCHAR(64),
IN contact_no CHAR(10),
IN date_of_birth VARCHAR(10)
)
BEGIN    
    DECLARE uname VARCHAR(16);
    DECLARE set_address_id INT;
    
    SELECT username INTO uname FROM user_login 
	WHERE username = username_;
    
    IF uname IS NULL
    THEN
        
        SELECT address_id INTO set_address_id FROM address 
		WHERE street_no = street_no_
        AND street_name = street_name_
        AND city = city_
        AND state = state_
        AND zipcode = zipcode_;
                
        IF set_address_id IS NULL
        THEN
			INSERT INTO address(street_no,street_name,city,state, zipcode) 
			VALUES (street_no_,street_name_,city_,state_,zipcode_);
			SET set_address_id = LAST_INSERT_ID();
		END IF;
        
        INSERT INTO user_login(username,pwd) 
        VALUES (username_,pwd);
        
        INSERT INTO user_(username, firstname, lastname, address_id, email, contact_no, date_of_birth ) 
        VALUES (username_,firstname, lastname, set_address_id, email, contact_no, date_of_birth);
    ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Username already exists OR Your User Field is not valid.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_charlie_card` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_charlie_card`(
IN username_ VARCHAR(16),
IN card_id_ VARCHAR(16)
)
BEGIN  
	DECLARE uname VARCHAR(16);
    
    SELECT owner_username INTO uname FROM charlie_card
    WHERE card_id = card_id_
    AND owner_username = username_;
    
    IF uname IS NOT NULL
    THEN
		DELETE FROM charlie_card
		WHERE card_id = card_id_
		AND owner_username = username_;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'SUCH CARD DOES NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_credit_card` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_credit_card`(
IN username_ VARCHAR(16),
IN card_id_ CHAR(16)
)
BEGIN  
	DECLARE uname VARCHAR(16);
    
    SELECT username INTO uname FROM user_credit_card
    WHERE username = username_
    AND card_number = card_id_;
    
    IF uname IS NOT NULL
    THEN
		DELETE FROM user_credit_card
		WHERE card_number = card_id_
		AND username = username_;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'SUCH CARD DOES NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_charlie_card` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_charlie_card`(
IN username_ VARCHAR(16)
)
BEGIN    
	DECLARE uname VARCHAR(16);
    
    SELECT username INTO uname FROM user_login
	WHERE username = username_;
        
	IF uname IS NOT NULL
	THEN
		SELECT card_id, card_type, balance, card_issue_date 
		FROM charlie_card cc
		JOIN charlie_card_type cct ON cct.card_type_id = cc.card_type_id;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_charlie_card_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_charlie_card_type`()
BEGIN
	SELECT card_type FROM charlie_card_type;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_credit_card` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_credit_card`(
IN username_ VARCHAR(16)
)
BEGIN
    DECLARE uname VARCHAR(16);

    SELECT username INTO uname FROM user_login
	WHERE username = username_;
	
	IF uname IS NOT NULL
	THEN
		SELECT card_number FROM user_credit_card
        WHERE username = username_;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_lines` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lines`()
BEGIN    
    SELECT line_name FROM line
    ORDER BY line_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_stations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_stations`(
IN line_ VARCHAR(64)
)
BEGIN   
	DECLARE l_ VARCHAR(64);
    
    SELECT line_name INTO l_ FROM line
    WHERE line_name = line_;
    
    IF l_ IS NOT NULL
    THEN
		SELECT station_name FROM line_station
		WHERE line_name = line_
        ORDER BY station_name;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'LINE DOES NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_details`(
IN username_ VARCHAR(16)
)
BEGIN
    DECLARE uname VARCHAR(16);
    
    SELECT username INTO uname FROM user_
	WHERE username = username_;
        
	IF uname IS NOT NULL
	THEN
		SELECT firstname, lastname, email, contact_no, date_of_birth
        FROM user_
		WHERE username = username_;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_charlie_card_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_charlie_card_type`(
IN card_type_ VARCHAR(16),
IN card_fare_ DOUBLE
)
BEGIN   
	DECLARE ct_ VARCHAR(16);
    
    SELECT card_type INTO ct_ FROM charlie_card_type 
	WHERE card_type = card_type_;
    
    IF ct_ IS NULL
    THEN
		INSERT INTO charlie_card_type(card_type,card_fare) 
        VALUES (card_type_,card_fare_);
    ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Charlie Card Already Exists.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_line` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_line`(
IN line_ VARCHAR(64)
)
BEGIN   
	DECLARE l_ VARCHAR(64);
    
    SELECT line_name INTO l_ FROM line 
	WHERE line_name = line_;
    
    IF l_ IS NULL
    THEN
		INSERT INTO line(line_name) 
        VALUES (line_);
    ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Line Already Exists.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_station` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_station`(
IN station_ VARCHAR(64)
)
BEGIN   
	DECLARE l_ VARCHAR(64);
    
    SELECT station_name INTO l_ FROM station 
	WHERE station_name = station_;
    
    IF l_ IS NULL
    THEN
		INSERT INTO station(station_name) 
        VALUES (station_);
    ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Station Already Exists.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `journey_by_weekday` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `journey_by_weekday`()
BEGIN
    SELECT all_days.day_of_week, COUNT(journey.journey_date)
	FROM  (SELECT 'Sunday' AS day_of_week
	UNION SELECT 'Monday' UNION SELECT 'Tuesday' UNION SELECT 'Wednesday'
	UNION SELECT 'Thursday' UNION SELECT 'Friday' UNION SELECT 'Saturday') AS all_days
	LEFT JOIN journey ON DAYNAME(journey_date) = all_days.day_of_week
	GROUP BY all_days.day_of_week;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `line_end_station_total_journeys` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `line_end_station_total_journeys`(
IN line_ VARCHAR(64)
)
BEGIN
	DECLARE l_ VARCHAR(64);
    
    SELECT DISTINCT(line_name) INTO l_ FROM line_station
    WHERE line_name = line_;
    
    IF l_ IS NOT NULL
    THEN
		SELECT all_stations.sn_, count(journey_id) 
		FROM (SELECT line_name ln_, station_name sn_
			FROM line_station
			WHERE line_name = line_) all_stations
		LEFT JOIN
		(SELECT j.end_station, journey_id
		FROM journey j
		WHERE j.travel_line = line_) line_jour
		ON line_jour.end_station = all_stations.sn_
		GROUP BY all_stations.sn_;
	ELSE
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'LINE STATIONS NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `line_sstart_station_total_journeys` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `line_sstart_station_total_journeys`(
IN line_ VARCHAR(64)
)
BEGIN
	DECLARE l_ VARCHAR(64);
    
    SELECT DISTINCT(line_name) INTO l_ FROM line_station
    WHERE line_name = line_;
    
    IF l_ IS NOT NULL
    THEN
		SELECT all_stations.sn_, count(journey_id) 
		FROM (SELECT line_name ln_, station_name sn_
			FROM line_station
			WHERE line_name = line_) all_stations
		LEFT JOIN
		(SELECT j.start_station, journey_id
		FROM journey j
		WHERE j.travel_line = line_) line_jour
		ON line_jour.start_station = all_stations.sn_
		GROUP BY all_stations.sn_;

	ELSE
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'LINE STATIONS NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `line_total_journeys` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `line_total_journeys`()
BEGIN
	SELECT line_name, COUNT(journey_id)
    FROM journey j
    RIGHT JOIN line l_ ON l_.line_name = j.travel_line
    GROUP BY l_.line_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_journey_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_journey_details`(
IN username_ VARCHAR(16),
IN journey_id_ INT,
IN start_station_ VARCHAR(64),
IN end_station_ VARCHAR(64)
)
BEGIN
    DECLARE uname VARCHAR(16);
    DECLARE jour_id INT;
    
    SELECT username INTO uname FROM user_
	WHERE username = username_;
        
	IF uname IS NOT NULL
	THEN
		SELECT journey_id INTO jour_id FROM journey
        WHERE journey_id = journey_id_;
        
        IF jour_id IS NOT NULL
        THEN
			UPDATE journey
            SET start_station = start_station_
            , end_station = end_station_
            WHERE journey_id = jour_id;
        ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'JOURNEY NOT EXISTS FOR USER.';
        END IF;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_user_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_details`(
IN username_ VARCHAR(16),
IN firstname_ VARCHAR(64),
IN lastname_ VARCHAR(64),
IN email_ VARCHAR(64),
IN contact_no_ CHAR(10),
IN date_of_birth_ VARCHAR(10)
)
BEGIN
    DECLARE uname VARCHAR(16);
    
    SELECT username INTO uname FROM user_
	WHERE username = username_;
        
	IF uname IS NOT NULL
	THEN
		UPDATE user_
        SET firstname = firstname_
        , lastname = lastname_
        , email = email_
        , contact_no = contact_no_
        , date_of_birth = date_of_birth_
        WHERE username = uname;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `users_for_charlie_card_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `users_for_charlie_card_type`()
BEGIN
	SELECT ct.card_type, COUNT(cc.card_id)
	FROM charlie_card cc
	RIGHT JOIN charlie_card_type ct ON ct.card_type_id = cc.card_type_id
	GROUP BY ct.card_type_id
	ORDER BY ct.card_type;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_journey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_journey`(
IN username_ VARCHAR(16)
)
BEGIN    
	DECLARE uname VARCHAR(16);
    
    SELECT username INTO uname FROM user_login
	WHERE username = username_;
        
	IF uname IS NOT NULL
	THEN
		SELECT journey_id, journey_date, travel_line, start_station, end_station, IFNULL(card_id, 'CARD NOT EXISTS') AS card_id FROM journey
		WHERE username like username_;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'USER DOES NOT Exist in system.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-08 18:41:27
