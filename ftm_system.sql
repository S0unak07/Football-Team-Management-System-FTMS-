-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: ftm_system
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `club_auth_data`
--

DROP TABLE IF EXISTS `club_auth_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club_auth_data` (
  `login_id` varchar(50) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('Player','Coaching Staff','Manager','Developer') DEFAULT NULL,
  PRIMARY KEY (`login_id`),
  UNIQUE KEY `username` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club_auth_data`
--

LOCK TABLES `club_auth_data` WRITE;
/*!40000 ALTER TABLE `club_auth_data` DISABLE KEYS */;
INSERT INTO `club_auth_data` VALUES ('DevRouGuh@07','Rounak Guha','RG007Dev','Developer'),('DevSouGuh@07','Sounak Guha','SG007Dev','Developer'),('SnrCsSebPar@1','Sebas Parrilla','558fe5c3ee1d15c399417e042c8abba8387a063366b73fc6d6891ec1ffc3c27c','Coaching Staff'),('SnrMgXabAlo@100','Xabi Alonso','XA100Man','Manager'),('SnrPlAlvCar@3','Alvaro Carreras','AC03Def','Player'),('SnrPlAndLun@13','Andriy Lunin','AL13Keeper','Player'),('SnrPlAntRud@22','Antonio Rudiger','AR22Def','Player'),('SnrPlArdGul@15','Arda Guler','AG15Mid','Player'),('SnrPlAurTch@14','Aurelien Tchouameni','AT14Mid','Player'),('SnrPlBraDia@10','Brahim Diaz','BD10Forward','Player'),('SnrPlCheMa@26','Chema','CH26Mid','Player'),('SnrPlDanCar@20','Dani Carvajal','DC20Def','Player'),('SnrPlDanCeb@19','Dani Ceballos','DC19Mid','Player'),('SnrPlDavAla@5','David Alaba','DA05Def','Player'),('SnrPlDeaHui@24','Dean Huijsen','DH24Def','Player'),('SnrPlEdeMil@4','Eder Militao','EM04Def','Player'),('SnrPlEduCam@7','Eduardo Camavinga','EC07Mid','Player'),('SnrPlEnd@16','Endrick','EN16Forward','Player'),('SnrPlFedVal@8','Federico Valverde','FV08Mid','Player'),('SnrPlFerMen@23','Ferland Mendy','FM23Def','Player'),('SnrPlFraGar@21','Francisco Garcia','FG21Def','Player'),('SnrPlFraGon@25','Fran Gonzalez','FG25Keeper','Player'),('SnrPlFraMas@17','Franco Mastantuono','FM17Forward','Player'),('SnrPlGonGar@18','Gonzalo Garcia','GG18Mid','Player'),('SnrPlJudBel@6','Jude Bellingham','JB06Mid','Player'),('SnrPlKylMba@9','Kylian Mbappe','KM09Forward','Player'),('SnrPlMarMar@27','Mario Martin','MM27Mid','Player'),('SnrPlRauAse@28','Raul Asensio','RA28Def','Player'),('SnrPlRodRyg@11','Rodrygo','RY11Forward','Player'),('SnrPlThiCou@1','Thibaut Courtois','TC01Gkeeper','Player'),('SnrPlTreAle@2','Trent Alexander-Arnold','TA02Defender','Player'),('SnrPlVinJr@9','Vinicius Jr.','VJ09Forward','Player');
/*!40000 ALTER TABLE `club_auth_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club_expenses`
--

DROP TABLE IF EXISTS `club_expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club_expenses` (
  `expense_id` varchar(20) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `amount` bigint DEFAULT NULL,
  `expense_date` date DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`expense_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club_expenses`
--

LOCK TABLES `club_expenses` WRITE;
/*!40000 ALTER TABLE `club_expenses` DISABLE KEYS */;
INSERT INTO `club_expenses` VALUES ('EXP_2026_01','First Team Wages',516000000,'2026-06-30','Annual salary mass for players and technical staff (~43% of revenue).'),('EXP_2026_02','Stadium Operations',150000000,'2026-06-30','Maintenance, matchday logistics, and event hosting costs for Bernabéu.'),('EXP_2026_03','Amortization (Transfers)',180000000,'2026-06-30','Annual amortization cost of player transfer fees (e.g., Bellingham, Mbappe signing bonus).'),('EXP_2026_04','Non-Sporting Personnel',45000000,'2026-06-30','Salaries for administrative, marketing, and medical staff.'),('EXP_2026_05','Travel & Logistics',25000000,'2026-06-30','Travel costs for La Liga, UCL, and Club World Cup fixtures.'),('EXP20251113_01','Travel',150000,'2025-11-13','Travel expenses for away fixture');
/*!40000 ALTER TABLE `club_expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club_fixtures`
--

DROP TABLE IF EXISTS `club_fixtures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club_fixtures` (
  `match_id` varchar(20) NOT NULL,
  `opponent_name` varchar(100) DEFAULT NULL,
  `match_date` date DEFAULT NULL,
  `match_time` time DEFAULT NULL,
  `venue` varchar(100) DEFAULT NULL,
  `tournament` varchar(100) DEFAULT NULL,
  `status` enum('Upcoming','Completed','Postponed') DEFAULT NULL,
  PRIMARY KEY (`match_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club_fixtures`
--

LOCK TABLES `club_fixtures` WRITE;
/*!40000 ALTER TABLE `club_fixtures` DISABLE KEYS */;
INSERT INTO `club_fixtures` VALUES ('CDR2025_01','CF Talavera de la Reina','2025-12-17','21:00:00','Away','Copa del Rey','Completed'),('LL2025_01','CA Osasuna','2025-08-19','00:30:00','Home','La Liga','Completed'),('LL2025_02','Real Oviedo','2025-08-24','01:00:00','Away','La Liga','Completed'),('LL2025_03','RCD Mallorca','2025-08-30','01:00:00','Home','La Liga','Completed'),('LL2025_04','Real Sociedad','2025-09-13','19:45:00','Away','La Liga','Completed'),('LL2025_05','Espanyol','2025-09-20','19:45:00','Home','La Liga','Completed'),('LL2025_06','Levante','2025-09-23','01:00:00','Away','La Liga','Completed'),('LL2025_07','Atlético Madrid','2025-09-27','19:45:00','Away','La Liga','Completed'),('LL2025_08','Villarreal','2025-10-04','00:30:00','Home','La Liga','Completed'),('LL2025_09','Getafe','2025-10-19','00:30:00','Away','La Liga','Completed'),('LL2025_10','FC Barcelona','2025-10-26','20:45:00','Home','La Liga','Completed'),('LL2025_11','Valencia CF','2025-11-01','01:30:00','Home','La Liga','Completed'),('LL2025_12','Rayo Vallecano','2025-11-09','20:45:00','Away','La Liga','Completed'),('LL2025_13','Elche CF','2025-11-23','01:30:00','Away','La Liga','Completed'),('LL2025_14','Girona FC','2025-11-30','01:30:00','Away','La Liga','Completed'),('LL2025_15','Celta de Vigo','2025-12-07','01:30:00','Home','La Liga','Completed'),('LL2025_16','Deportivo Alavés','2025-12-14','01:30:00','Away','La Liga','Completed'),('LL2025_17','Sevilla FC','2025-12-20','01:30:00','Home','La Liga','Completed'),('LL2025_19','Athletic Club','2025-12-03','23:30:00','Away','La Liga','Completed'),('LL2026_18','Real Betis','2026-01-03',NULL,'Home','La Liga','Upcoming'),('LL2026_20','Levante','2026-01-17',NULL,'Home','La Liga','Upcoming'),('LL2026_21','Villarreal','2026-01-24',NULL,'Away','La Liga','Upcoming'),('LL2026_22','Rayo Vallecano','2026-01-31',NULL,'Home','La Liga','Upcoming'),('LL2026_23','Valencia','2026-02-07',NULL,'Away','La Liga','Upcoming'),('LL2026_24','Real Sociedad','2026-02-14',NULL,'Home','La Liga','Upcoming'),('LL2026_25','CA Osasuna','2026-02-21',NULL,'Away','La Liga','Upcoming'),('LL2026_26','Getafe','2026-02-28',NULL,'Home','La Liga','Upcoming'),('LL2026_27','Celta de Vigo','2026-03-07',NULL,'Away','La Liga','Upcoming'),('LL2026_28','Elche CF','2026-03-14',NULL,'Home','La Liga','Upcoming'),('LL2026_29','Atlético Madrid','2026-03-21',NULL,'Home','La Liga','Upcoming'),('LL2026_30','RCD Mallorca','2026-04-04',NULL,'Away','La Liga','Upcoming'),('LL2026_31','Girona FC','2026-04-11',NULL,'Home','La Liga','Upcoming'),('LL2026_32','Real Betis','2026-04-18',NULL,'Away','La Liga','Upcoming'),('LL2026_33','Deportivo Alavés','2026-04-21',NULL,'Home','La Liga','Upcoming'),('LL2026_34','RCD Espanyol','2026-05-02',NULL,'Away','La Liga','Upcoming'),('LL2026_35','FC Barcelona','2026-05-09',NULL,'Away','La Liga','Upcoming'),('LL2026_36','Real Oviedo','2026-05-12',NULL,'Home','La Liga','Upcoming'),('LL2026_37','Sevilla FC','2026-05-16',NULL,'Away','La Liga','Upcoming'),('LL2026_38','Athletic Club','2026-05-23',NULL,'Home','La Liga','Upcoming'),('SC2026_01','Atlético Madrid','2026-01-08','20:00:00','Neutral','Supercopa','Upcoming'),('UCL2025_01','Olympique Marseille','2025-09-16','00:30:00','Home','Champions League','Completed'),('UCL2025_02','Kairat Almaty','2025-09-30','22:15:00','Away','Champions League','Completed'),('UCL2025_03','Juventus','2025-10-22','00:30:00','Home','Champions League','Completed'),('UCL2025_04','Liverpool','2025-11-04','01:30:00','Away','Champions League','Completed'),('UCL2025_05','Olympiacos','2025-11-26','01:30:00','Away','Champions League','Completed'),('UCL2025_06','Manchester City','2025-12-10','01:30:00','Home','Champions League','Completed'),('UCL2026_01','Monaco','2026-01-20','01:30:00','Home','Champions League','Upcoming'),('UCL2026_02','Benfica','2026-01-28','01:30:00','Away','Champions League','Upcoming');
/*!40000 ALTER TABLE `club_fixtures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club_revenue`
--

DROP TABLE IF EXISTS `club_revenue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club_revenue` (
  `revenue_id` varchar(20) NOT NULL,
  `source` varchar(50) DEFAULT NULL,
  `amount` bigint DEFAULT NULL,
  `revenue_date` date DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`revenue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club_revenue`
--

LOCK TABLES `club_revenue` WRITE;
/*!40000 ALTER TABLE `club_revenue` DISABLE KEYS */;
INSERT INTO `club_revenue` VALUES ('REV_2026_01','Commercial & Sponsorship',405000000,'2026-06-30','Revenue from Adidas, Emirates, HP, and retail operations.'),('REV_2026_02','Stadium & Membership',315000000,'2026-06-30','Matchday income, VIP hospitality, and Bernabéu events (concerts/tours).'),('REV_2026_03','Broadcasting Rights',360000000,'2026-06-30','La Liga TV rights and UEFA Champions League market pool.'),('REV_2026_04','Competition Prize Money',105000000,'2026-06-30','Includes ?74M from FIFA Club World Cup and UCL performance bonuses.'),('REV_2026_05','International Friendlies',25000000,'2025-08-15','Revenue from US Summer Tour 2025.'),('REV20250601','Operating Revenue',1185000000,'2025-06-30','Total club income excluding player transfers.'),('REV20250602','Commercial',NULL,'2025-06-30','Sponsorships, merchandising, and other ventures. Boosted by new deals and full Bernabeu operations.'),('REV20250603','Matchday',280000000,'2025-06-30','Ticket sales and stadium revenue from fully operational Bernabeu.'),('REV20250604','Broadcasting',NULL,'2025-06-30','TV rights and prize money. Impacted by UEFA revenue-sharing and reduced La Liga earnings.'),('REV20250605','Other Revenue',74000000,'2025-06-30','FIFA Club World Cup income, offsetting broadcasting drop. Prize ~?74M.'),('REV20251113_01','Ticket Sales',250000,'2025-11-13','Revenue from recent home match');
/*!40000 ALTER TABLE `club_revenue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club_sponsors`
--

DROP TABLE IF EXISTS `club_sponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club_sponsors` (
  `sponsor_id` varchar(30) NOT NULL,
  `sponsor_name` varchar(100) DEFAULT NULL,
  `contribution` bigint DEFAULT NULL,
  `start_year` date DEFAULT NULL,
  `end_year` date DEFAULT NULL,
  PRIMARY KEY (`sponsor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club_sponsors`
--

LOCK TABLES `club_sponsors` WRITE;
/*!40000 ALTER TABLE `club_sponsors` DISABLE KEYS */;
INSERT INTO `club_sponsors` VALUES ('SP_ADIDAS','Adidas',119800000,'1998-01-01','2028-01-01'),('SP_ADIDAS_01','Adidas',120000000,'2019-07-01','2028-06-30'),('SP_BMW','BMW',12000000,'2022-01-01','2026-06-15'),('SP_BMW_01','BMW',12000000,'2022-07-01','2027-06-30'),('SP_CISCO','Cisco',4500000,'2021-01-01','2026-06-15'),('SP_CISCO_01','Cisco',6000000,'2025-06-15','2028-06-30'),('SP_EA_01','EA Sports FC',10000000,'2020-07-16','2025-06-30'),('SP_EA_SPORTS','EA Sports',8000000,'2011-01-01','2024-01-01'),('SP_EMIRATES','Emirates (Fly Emirates)',70000000,'2011-01-01','2026-06-15'),('SP_EMIRATES_01','Emirates',70000000,'2022-10-01','2026-06-30'),('SP_HP','HP',15000000,'2024-01-01','2027-01-01'),('SP_HP_01','HP (Hewlett-Packard)',70000000,'2024-02-02','2027-06-30'),('SP_KRESS_01','Kress & Worx',4000000,'2025-06-01','2027-06-30'),('SP_LOUIS_VUITTON','Louis Vuitton',10000000,'2025-01-01','2029-01-01'),('SP_LV_01','Louis Vuitton',15000000,'2025-06-01','2029-06-30'),('SP_MAHOU_01','Mahou',5000000,'2020-01-01','2026-06-30'),('SP_MAHOU_SAN_MIGUEL','Mahou San Miguel',4000000,'2015-01-01','2026-06-15'),('SP_NIVEA_MEN','Nivea Men',5000000,'2017-01-01','2026-06-15'),('SP_OURO_01','Ouro',3000000,'2024-04-01','2026-06-30'),('SP_PALLADIUM_HOTEL_GROUP','Palladium Hotel Group',15000000,'2019-01-01','2024-01-01'),('SP_SANITAS','Sanitas',6000000,'2005-01-01','2026-06-15'),('SP_TEST_01','Tech Company XYZ',5000000,'2025-11-13','2027-11-13'),('SP_UNICAJA_BANCO','Unicaja Banco',3000000,'2020-01-01','2026-06-15');
/*!40000 ALTER TABLE `club_sponsors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `injury_log`
--

DROP TABLE IF EXISTS `injury_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `injury_log` (
  `injury_id` varchar(20) NOT NULL,
  `player_id` varchar(20) DEFAULT NULL,
  `injury_type` varchar(100) DEFAULT NULL,
  `injury_date` date DEFAULT NULL,
  `expected_recovery_date` date DEFAULT NULL,
  `severity` enum('Low','Moderate','High') DEFAULT NULL,
  PRIMARY KEY (`injury_id`),
  KEY `injury_log_ibfk_1` (`player_id`),
  CONSTRAINT `injury_log_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_details` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `injury_log`
--

LOCK TABLES `injury_log` WRITE;
/*!40000 ALTER TABLE `injury_log` DISABLE KEYS */;
INSERT INTO `injury_log` VALUES ('IN_271025_01','SnrPl2','Knee injury','2025-10-27','2026-01-27','Moderate'),('INJ_20251015_01','SnrPl4','Muscle Fatigue/Injury','2025-10-15','2025-12-11','Moderate'),('INJ_20251120_01','SnrPl2','Knee Ligament Strain','2025-11-20','2026-01-27','High'),('INJ_20251201_01','SnrPl12','Thigh Muscle Tear','2025-12-01','2026-02-02','Moderate'),('INJ_20251202_01','SnrPl23','Biceps Femoris Injury','2025-12-02','2025-12-20','Moderate'),('INJ_20251207_01','SnrPl3','Hamstring Tear (Grade 3)','2025-12-07','2026-04-01','High'),('INJ_20251210_01','SnrPl11','Muscle Overload','2025-12-10','2025-12-15','Low'),('INJ_20251214_01','SnrPl8','Minor Knock','2025-12-14','2025-12-19','Low'),('Injr_120925_01','SnrPl22','Hamstring','2025-09-12','2025-12-12','Moderate'),('Injr_131125_01','SnrPl4','Ankle Sprain','2025-11-13','2025-12-20','Moderate');
/*!40000 ALTER TABLE `injury_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_history`
--

DROP TABLE IF EXISTS `match_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_history` (
  `match_id` varchar(20) NOT NULL,
  `date_played` date DEFAULT NULL,
  `opponent_name` varchar(100) DEFAULT NULL,
  `tournament` varchar(100) DEFAULT NULL,
  `goals_scored` int DEFAULT NULL,
  `goals_conceded` int DEFAULT NULL,
  `possession_percent` decimal(5,2) DEFAULT NULL,
  `passes_completed` int DEFAULT NULL,
  `fouls_committed` int DEFAULT NULL,
  `yellow_cards` int DEFAULT NULL,
  `red_cards` int DEFAULT NULL,
  `result` enum('Win','Loss','Draw') DEFAULT NULL,
  PRIMARY KEY (`match_id`),
  CONSTRAINT `fk_match_history` FOREIGN KEY (`match_id`) REFERENCES `club_fixtures` (`match_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_history`
--

LOCK TABLES `match_history` WRITE;
/*!40000 ALTER TABLE `match_history` DISABLE KEYS */;
INSERT INTO `match_history` VALUES ('CDR2025_01','2025-12-17','CF Talavera de la Reina','Copa del Rey',3,2,65.00,NULL,7,1,0,'Win'),('LL2025_01','2025-08-19','Osasuna','La Liga',1,0,70.00,691,10,1,0,'Win'),('LL2025_02','2025-08-24','Oviedo','La Liga',3,0,64.00,665,7,1,0,'Win'),('LL2025_03','2025-08-30','Mallorca','La Liga',2,1,59.00,502,12,2,0,'Win'),('LL2025_04','2025-09-13','Real Sociedad','La Liga',2,1,37.00,253,7,1,1,'Win'),('LL2025_05','2025-09-20','Espanyol','La Liga',2,0,72.00,727,10,2,0,'Win'),('LL2025_06','2025-09-23','Levante','La Liga',4,1,62.00,654,9,1,0,'Win'),('LL2025_07','2025-09-27','Atlético Madrid','La Liga',2,5,62.00,493,14,4,0,'Loss'),('LL2025_08','2025-10-04','Villarreal','La Liga',3,1,69.00,683,9,2,0,'Win'),('LL2025_09','2025-10-19','Getafe','La Liga',1,0,76.00,579,11,1,0,'Win'),('LL2025_10','2025-10-26','Barcelona','La Liga',2,1,32.00,251,12,5,1,'Win'),('LL2025_11','2025-11-01','Valencia','La Liga',4,0,65.00,673,14,1,0,'Win'),('LL2025_12','2025-11-09','Rayo Vallecano','La Liga',0,0,54.00,414,7,2,0,'Draw'),('LL2025_13','2025-11-23','Elche','La Liga',2,2,51.00,463,8,1,0,'Draw'),('LL2025_14','2025-11-30','Girona','La Liga',1,1,59.00,571,13,0,0,'Draw'),('LL2025_15','2025-12-07','Celta Vigo','La Liga',0,2,57.00,554,6,6,2,'Loss'),('LL2025_16','2025-12-14','Alavés','La Liga',2,1,47.00,412,13,1,0,'Win'),('LL2025_17','2025-12-20','Sevilla','La Liga',2,0,53.00,467,13,2,0,'Win'),('LL2025_19','2025-12-03','Athletic Club','La Liga',3,0,61.00,586,4,0,0,'Win'),('UCL2025_01','2025-09-16','Marseille','Champions League',2,1,44.00,364,9,3,1,'Win'),('UCL2025_02','2025-09-30','Kairat Almaty','Champions League',5,0,67.00,568,9,0,0,'Win'),('UCL2025_03','2025-10-22','Juventus','Champions League',1,0,65.00,579,10,1,0,'Win'),('UCL2025_04','2025-11-04','Liverpool','Champions League',0,1,60.00,477,11,4,0,'Loss'),('UCL2025_05','2025-11-26','Olympiacos','Champions League',4,3,58.00,523,7,2,0,'Win'),('UCL2025_06','2025-12-10','Man City','Champions League',1,2,52.00,392,14,3,0,'Loss');
/*!40000 ALTER TABLE `match_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_details`
--

DROP TABLE IF EXISTS `player_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_details` (
  `player_id` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `jersey_no` int DEFAULT NULL,
  `availability` enum('Available','Injured','Suspended') DEFAULT NULL,
  `previous_club` varchar(100) DEFAULT NULL,
  `yearly_salary` bigint DEFAULT NULL,
  `date_of_signing` date DEFAULT NULL,
  `contract_expiration` date DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_details`
--

LOCK TABLES `player_details` WRITE;
/*!40000 ALTER TABLE `player_details` DISABLE KEYS */;
INSERT INTO `player_details` VALUES ('SnrPl1','Thibaut Courtois','Goalkeeper','Belgium',1,'Available','Chelsea',16000000,'2018-08-08','2026-06-30',33),('SnrPl10','Brahim Diaz','Forward','Spain',10,'Available','Manchester City',NULL,'2019-01-06','2026-06-30',24),('SnrPl11','Rodrygo','Forward','Brazil',11,'Available','Santos',13300000,'2019-07-01','2028-06-30',24),('SnrPl12','Trent Alexander-Arnold','Defender','England',12,'Available','Liverpool',15000000,'2025-06-01','2031-06-30',26),('SnrPl13','Andriy Lunin','Goalkeeper','Ukraine',13,'Available','Youth Team',4800000,'2020-09-08','2030-06-30',26),('SnrPl14','Aurelien Tchouameni','Midfielder','France',14,'Available','Monaco',13300000,'2022-08-16','2028-06-30',24),('SnrPl15','Arda Guler','Midfielder','Turkey',15,'Available','Fenerbahce',5500000,'2023-07-06','2029-06-30',19),('SnrPl16','Endrick','Forward','Brazil',16,'Available','Palmeiras',4300000,'2024-07-01','2030-06-30',18),('SnrPl17','Franco Mastantuono','Forward','Argentina',17,'Available','River Plate',NULL,'2025-08-14','2031-06-30',16),('SnrPl18','Gonzalo Garcia','Midfielder','Spain',18,'Available','Youth Team',NULL,NULL,'2027-06-30',29),('SnrPl19','Dani Ceballos','Midfielder','Spain',19,'Available','Youth Team',11000000,'2017-08-16','2027-06-30',28),('SnrPl2','Dani Carvajal','Defender','Spain',2,'Injured','Bayer Leverkusen',11200000,'2013-08-12','2026-06-30',32),('SnrPl20','Francisco Garcia','Defender','Spain',20,'Available','Youth Team',5500000,'2025-07-14','2027-06-30',22),('SnrPl21','Alvaro Carreras','Defender','Spain',21,'Available','Manchester United',1500000,'2025-07-13','2026-06-30',23),('SnrPl22','Antonio Rudiger','Defender','Germany',22,'Injured','Chelsea',15600000,'2022-06-01','2026-06-30',31),('SnrPl23','Ferland Mendy','Defender','France',23,'Available','Lyon',11200000,'2020-06-17','2028-06-30',29),('SnrPl24','Dean Huijsen','Defender','Spain',24,'Available','Bournemouth',9000000,'2025-06-01','2030-06-30',20),('SnrPl25','Fran Gonzalez','Goalkeeper','Spain',25,'Available','Youth Team',NULL,NULL,'2026-06-30',19),('SnrPl26','Chema','Midfielder','Spain',26,'Available','Youth Team',NULL,NULL,'2027-06-30',22),('SnrPl27','Mario Martin','Midfielder','Spain',27,'Available','Youth Team',1500000,'2024-01-01','2026-06-30',33),('SnrPl28','Raul Asensio','Defender','Spain',28,'Available','Youth Team',4000000,'2024-01-01','2026-06-30',29),('SnrPl29','Test Player','Midfielder','Portugal',29,'Available','Previous Club',5000000,'2025-11-13','2027-06-30',25),('SnrPl3','Eder Militao','Defender','Brazil',3,'Available','Porto',15600000,'2019-07-01','2028-06-30',27),('SnrPl4','David Alaba','Defender','Austria',4,'Injured','Bayern Munich',24000000,'2021-05-29','2026-06-30',32),('SnrPl5','Jude Bellingham','Midfielder','England',5,'Available','Borussia Dortmund',22200000,'2023-07-05','2029-06-30',22),('SnrPl6','Eduardo Camavinga','Midfielder','France',6,'Available','Rennes',13300000,'2021-08-31','2029-06-30',22),('SnrPl7','Vinicius Jr.','Forward','Brazil',7,'Available','Flamengo',17500000,'2018-07-23','2027-06-30',25),('SnrPl8','Federico Valverde','Midfielder','Uruguay',8,'Available','Penarol',20000000,'2017-01-10','2030-06-30',26),('SnrPl9','Kylian Mbappe','Forward','France',9,'Available','PSG',33400000,'2024-06-03','2029-06-30',26);
/*!40000 ALTER TABLE `player_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_stats_club`
--

DROP TABLE IF EXISTS `player_stats_club`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_stats_club` (
  `player_id` varchar(20) NOT NULL,
  `player_name` varchar(255) DEFAULT NULL,
  `matches_played` int DEFAULT NULL,
  `goals` int DEFAULT NULL,
  `assists` int DEFAULT NULL,
  `saves` int DEFAULT NULL,
  `yellow_cards` int DEFAULT NULL,
  `red_cards` int DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  CONSTRAINT `player_stats_club_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_details` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_stats_club`
--

LOCK TABLES `player_stats_club` WRITE;
/*!40000 ALTER TABLE `player_stats_club` DISABLE KEYS */;
INSERT INTO `player_stats_club` VALUES ('SnrPl1','Thibaut Courtois',161,0,0,399,5,0),('SnrPl10','Brahim Diaz',66,10,7,0,4,0),('SnrPl11','Rodrygo',250,60,45,0,9,0),('SnrPl12','Trent Alexander-Arnold',0,0,0,0,0,0),('SnrPl13','Andriy Lunin',45,0,1,104,3,0),('SnrPl14','Aurelien Tchouameni',98,0,2,0,16,0),('SnrPl15','Arda Guler',28,3,4,0,1,0),('SnrPl16','Endrick',2,1,0,0,1,0),('SnrPl17','Franco Mastantuono',0,0,0,0,0,0),('SnrPl18','Gonzalo Garcia',25,0,1,0,0,0),('SnrPl19','Dani Ceballos',145,6,12,0,21,0),('SnrPl2','Dani Carvajal',475,11,45,0,100,3),('SnrPl20','Francisco Garcia',31,0,2,0,0,0),('SnrPl21','Alvaro Carreras',0,0,0,0,0,0),('SnrPl22','Antonio Rudiger',74,2,2,0,9,0),('SnrPl23','Ferland Mendy',170,6,12,0,26,1),('SnrPl24','Dean Huijsen',0,0,0,0,0,0),('SnrPl25','Fran Gonzalez',19,0,0,0,0,0),('SnrPl28','Raul Asensio',43,0,1,0,7,1),('SnrPl3','Eder Militao',216,10,6,0,24,1),('SnrPl4','David Alaba',134,4,11,0,12,0),('SnrPl5','Jude Bellingham',80,30,20,0,14,1),('SnrPl6','Eduardo Camavinga',141,7,10,0,23,0),('SnrPl7','Vinicius Jr.',274,80,65,0,30,2),('SnrPl8','Federico Valverde',335,26,29,0,44,0),('SnrPl9','Kylian Mbappe',37,7,15,0,3,1);
/*!40000 ALTER TABLE `player_stats_club` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_stats_season`
--

DROP TABLE IF EXISTS `player_stats_season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_stats_season` (
  `player_id` varchar(20) NOT NULL,
  `matches_played` int DEFAULT NULL,
  `minutes_played` int DEFAULT NULL,
  `goals` int DEFAULT NULL,
  `assists` int DEFAULT NULL,
  `yellow_cards` int DEFAULT NULL,
  `red_cards` int DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  CONSTRAINT `player_stats_season_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_details` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_stats_season`
--

LOCK TABLES `player_stats_season` WRITE;
/*!40000 ALTER TABLE `player_stats_season` DISABLE KEYS */;
INSERT INTO `player_stats_season` VALUES ('SnrPl1',18,1620,0,0,0,0),('SnrPl10',12,319,0,2,1,0),('SnrPl11',16,558,1,1,3,0),('SnrPl12',8,392,0,1,0,0),('SnrPl13',0,0,0,0,0,0),('SnrPl14',16,1305,0,0,4,0),('SnrPl15',18,1138,3,5,1,0),('SnrPl16',1,12,0,0,0,0),('SnrPl17',10,548,1,0,3,0),('SnrPl18',13,178,0,0,0,0),('SnrPl19',10,357,0,0,0,0),('SnrPl2',7,376,0,0,0,0),('SnrPl20',6,411,0,0,2,1),('SnrPl21',16,1338,1,1,3,1),('SnrPl22',6,517,1,1,3,0),('SnrPl23',0,0,0,0,0,0),('SnrPl24',13,964,1,1,3,1),('SnrPl25',0,0,0,0,0,0),('SnrPl28',12,764,0,0,2,0),('SnrPl3',13,1000,1,1,2,0),('SnrPl4',3,57,0,0,0,0),('SnrPl5',14,1012,4,3,1,0),('SnrPl6',12,512,1,0,0,0),('SnrPl7',18,1325,5,5,3,0),('SnrPl8',17,1382,0,4,2,0),('SnrPl9',18,1570,18,4,3,0);
/*!40000 ALTER TABLE `player_stats_season` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recent_match_stats`
--

DROP TABLE IF EXISTS `recent_match_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recent_match_stats` (
  `match_id` varchar(20) NOT NULL,
  `player_id` varchar(20) NOT NULL,
  `goals` int DEFAULT '0',
  `assists` int DEFAULT '0',
  `saves` int DEFAULT '0',
  `minutes_played` int DEFAULT NULL,
  `yellow_cards` int DEFAULT '0',
  `red_cards` int DEFAULT '0',
  `rating` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`match_id`,`player_id`),
  KEY `recent_match_stats_ibfk_2` (`player_id`),
  CONSTRAINT `fk_recent_match_stats_fixture` FOREIGN KEY (`match_id`) REFERENCES `club_fixtures` (`match_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recent_match_stats_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `player_details` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recent_match_stats`
--

LOCK TABLES `recent_match_stats` WRITE;
/*!40000 ALTER TABLE `recent_match_stats` DISABLE KEYS */;
INSERT INTO `recent_match_stats` VALUES ('CDR2025_01','SnrPl10',0,0,0,23,0,0,6.50),('CDR2025_01','SnrPl13',0,0,6,90,0,0,8.50),('CDR2025_01','SnrPl16',0,1,0,77,0,0,7.00),('CDR2025_01','SnrPl17',0,0,0,66,1,0,6.50),('CDR2025_01','SnrPl18',0,0,0,90,0,0,6.50),('CDR2025_01','SnrPl19',0,0,0,87,0,0,7.00),('CDR2025_01','SnrPl21',0,0,0,90,0,0,7.00),('LL2025_15','SnrPl3',0,0,0,24,0,0,0.00),('LL2025_17','SnrPl1',0,0,3,90,0,0,7.50),('LL2025_17','SnrPl11',0,1,0,90,0,0,8.00),('LL2025_17','SnrPl14',0,0,0,90,0,0,6.50),('LL2025_17','SnrPl15',0,0,0,90,0,0,6.50),('LL2025_17','SnrPl20',0,0,0,90,0,0,6.00),('LL2025_17','SnrPl22',0,0,0,90,0,0,6.50),('LL2025_17','SnrPl24',0,0,0,90,0,0,6.50),('LL2025_17','SnrPl28',0,0,0,90,0,0,6.00),('LL2025_17','SnrPl5',1,0,0,90,1,0,8.00),('LL2025_17','SnrPl6',0,0,0,5,0,0,6.00),('LL2025_17','SnrPl7',0,0,0,85,0,0,6.50),('LL2025_17','SnrPl8',0,0,0,15,0,0,6.50),('LL2025_17','SnrPl9',1,0,0,90,0,0,6.00);
/*!40000 ALTER TABLE `recent_match_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suspension_log`
--

DROP TABLE IF EXISTS `suspension_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suspension_log` (
  `suspension_id` varchar(20) NOT NULL,
  `player_id` varchar(20) DEFAULT NULL,
  `reason` text,
  `suspension_date` date DEFAULT NULL,
  `matches_suspended` int DEFAULT NULL,
  `tournament_suspended` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`suspension_id`),
  KEY `suspension_log_ibfk_1` (`player_id`),
  CONSTRAINT `suspension_log_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_details` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suspension_log`
--

LOCK TABLES `suspension_log` WRITE;
/*!40000 ALTER TABLE `suspension_log` DISABLE KEYS */;
INSERT INTO `suspension_log` VALUES ('Sus_131125_01','SnrPl6','Misconduct in training','2025-11-13',2,'La Liga'),('SUSP_20250917_01','SnrPl13','Denying a goal scoring opportunity (Red Card)','2025-09-17',1,'Champions League'),('SUSP_20251027_01','SnrPl24','Serious Foul Play (Red Card)','2025-10-27',1,'La Liga'),('SUSP_20251208_01','SnrPl21','Second Yellow Card','2025-12-08',1,'La Liga'),('SUSP_20251208_02','SnrPl20','Professional Foul (Straight Red)','2025-12-08',2,'La Liga');
/*!40000 ALTER TABLE `suspension_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_schedule`
--

DROP TABLE IF EXISTS `training_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_schedule` (
  `training_id` varchar(20) NOT NULL,
  `player_id` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `session_type` varchar(50) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`training_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `training_schedule_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_details` (`player_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_schedule`
--

LOCK TABLES `training_schedule` WRITE;
/*!40000 ALTER TABLE `training_schedule` DISABLE KEYS */;
INSERT INTO `training_schedule` VALUES ('TN_131125_01','SnrPl16','2025-11-14','Whole-Part-Whole','Focus on endurance through interval training'),('Tnr_191025_01','SnrPl5','2025-10-19','Cardio','A 30 minutes session for buidling core strength thorugh cardio.'),('Tnr_201125_02','SnrPl7','2025-11-20','Tactical','Formation practice for upcoming derby'),('TR_AUG10_01','SnrPl1','2025-08-10','Physical','Pre-season cardio: Beep test and endurance work'),('TR_AUG10_02','SnrPl2','2025-08-10','Physical','Pre-season cardio: Beep test and endurance work'),('TR_AUG10_03','SnrPl3','2025-08-10','Physical','Pre-season cardio: Beep test and endurance work'),('TR_AUG10_04','SnrPl4','2025-08-10','Physical','Gym Session: Core strength and stability'),('TR_AUG10_05','SnrPl5','2025-08-10','Physical','Pre-season cardio: High intensity interval training'),('TR_AUG10_06','SnrPl6','2025-08-10','Physical','Pre-season cardio: High intensity interval training'),('TR_AUG10_07','SnrPl7','2025-08-10','Physical','Explosiveness drills: Sprints and resistance bands'),('TR_AUG10_08','SnrPl8','2025-08-10','Physical','Endurance: 10km steady state run'),('TR_AUG10_09','SnrPl9','2025-08-10','Physical','Explosiveness drills: Sprints and plyometrics'),('TR_AUG10_10','SnrPl10','2025-08-10','Physical','Agility work: Cone drills and shuttle runs'),('TR_AUG10_11','SnrPl11','2025-08-10','Physical','Agility work: Cone drills and shuttle runs'),('TR_AUG10_12','SnrPl12','2025-08-10','Physical','Gym Session: Leg strength and power'),('TR_AUG10_13','SnrPl13','2025-08-10','Goalkeeper','Reflex training and shot stopping'),('TR_AUG10_14','SnrPl14','2025-08-10','Physical','Gym Session: Upper body strength'),('TR_AUG10_15','SnrPl15','2025-08-10','Physical','Technical: Ball control under fatigue'),('TR_AUG10_16','SnrPl16','2025-08-10','Physical','Technical: Finishing drills after sprints'),('TR_AUG10_17','SnrPl17','2025-08-10','Physical','Agility work: Ladder drills'),('TR_AUG10_18','SnrPl18','2025-08-10','Physical','Endurance: Interval running'),('TR_AUG10_19','SnrPl19','2025-08-10','Physical','Ball retention drills'),('TR_AUG10_20','SnrPl20','2025-08-10','Physical','Defensive positioning drills'),('TR_AUG10_21','SnrPl21','2025-08-10','Physical','Crossing and overlapping runs'),('TR_AUG10_22','SnrPl22','2025-08-10','Physical','Gym Session: Power cleaning and deadlifts'),('TR_AUG10_23','SnrPl23','2025-08-10','Physical','Recovery: Light jog and stretching (Muscle tightness)'),('TR_AUG10_24','SnrPl24','2025-08-10','Physical','Defensive aerial duels practice'),('TR_AUG10_25','SnrPl25','2025-08-10','Goalkeeper','Distribution and footwork drills'),('TR_DEC08_01','SnrPl3','2025-12-08','Medical','Surgery prep: Consultation with specialist'),('TR_DEC08_02','SnrPl1','2025-12-08','Recovery','Light cycling and stretching'),('TR_DEC08_03','SnrPl5','2025-12-08','Recovery','Ice bath and massage'),('TR_DEC08_04','SnrPl9','2025-12-08','Recovery','Regeneration run'),('TR_DEC08_05','SnrPl7','2025-12-08','Recovery','Pool session'),('TR_DEC08_06','SnrPl8','2025-12-08','Recovery','Yoga and mobility'),('TR_DEC08_07','SnrPl21','2025-12-08','Tactical','Video session: Red card analysis with manager'),('TR_DEC08_08','SnrPl20','2025-12-08','Tactical','Video session: Disciplinary meeting'),('TR_DEC08_09','SnrPl28','2025-12-08','Tactical','First Team Integration: Prep to start vs Man City'),('TR_DEC08_10','SnrPl24','2025-12-08','Tactical','Defensive pairing drills with Rudiger'),('TR_DEC08_11','SnrPl22','2025-12-08','Recovery','Light jog'),('TR_DEC08_12','SnrPl11','2025-12-08','Technical','Shooting practice (Substitutes session)'),('TR_DEC08_13','SnrPl15','2025-12-08','Technical','Small sided game 5v5'),('TR_DEC08_14','SnrPl16','2025-12-08','Technical','Finishing drills'),('TR_DEC08_15','SnrPl17','2025-12-08','Technical','Passing drills'),('TR_DEC08_16','SnrPl18','2025-12-08','Technical','Ball mastery'),('TR_DEC09_01','SnrPl3','2025-12-09','Medical','Surgery successful. Bed rest.'),('TR_DEC15_01','SnrPl3','2025-12-15','Rehab','Post-op assessment: Wound check'),('TR_DEC27_01','SnrPl1','2025-12-27','Physical','Post-holiday weigh-in: Target met. Light cardio.'),('TR_DEC27_02','SnrPl5','2025-12-27','Physical','Post-holiday weigh-in: Target met. Strength activation.'),('TR_DEC27_03','SnrPl7','2025-12-27','Physical','Activation: Rondo and light sprints.'),('TR_DEC27_04','SnrPl9','2025-12-27','Physical','Activation: Shooting drills.'),('TR_DEC27_05','SnrPl8','2025-12-27','Physical','Endurance: 5km run.'),('TR_DEC27_06','SnrPl22','2025-12-27','Physical','Gym: Lower body maintenance.'),('TR_DEC27_07','SnrPl14','2025-12-27','Physical','Activation: Passing circle.'),('TR_DEC27_08','SnrPl6','2025-12-27','Physical','Agility drills.'),('TR_DEC27_09','SnrPl11','2025-12-27','Physical','Speed work.'),('TR_DEC27_10','SnrPl28','2025-12-27','Tactical','Defensive shape reminder (Start vs Betis pending).'),('TR_DEC27_11','SnrPl24','2025-12-27','Tactical','Defensive shape reminder.'),('TR_DEC27_12','SnrPl15','2025-12-27','Technical','Free kicks.'),('TR_DEC27_13','SnrPl13','2025-12-27','Goalkeeper','Handling drills.'),('TR_DEC27_14','SnrPl12','2025-12-27','Rehab','Grass: Running with ball (Injury recovery - 80%).'),('TR_DEC27_15','SnrPl2','2025-12-27','Rehab','Gym: Strengthening knee stabilizers (Recovery - 50%).'),('TR_DEC27_16','SnrPl3','2025-12-27','Rehab','Physio: Scar tissue massage (Recovery - 10%).'),('TR_DEC27_17','SnrPl21','2025-12-27','Physical','Bleep test.'),('TR_DEC27_18','SnrPl20','2025-12-27','Physical','Bleep test.'),('TR_DEC27_19','SnrPl19','2025-12-27','Technical','Ball retention.'),('TR_DEC27_20','SnrPl18','2025-12-27','Physical','Gym work.'),('TR_DEC28_01','SnrPl5','2025-12-28','Tactical','Prep for Betis: Midfield rotation'),('TR_DEC28_02','SnrPl7','2025-12-28','Tactical','Prep for Betis: Attacking transitions'),('TR_DEC28_03','SnrPl9','2025-12-28','Tactical','Prep for Betis: Finishing vs Low block'),('TR_DEC28_04','SnrPl22','2025-12-28','Tactical','Prep for Betis: Defending set pieces'),('TR_NOV15_01','SnrPl4','2025-11-15','Rehab','Grass: Light jogging with physio'),('TR_NOV15_02','SnrPl1','2025-11-15','Physical','Maintenance: Gym strength work'),('TR_NOV15_03','SnrPl19','2025-11-15','Technical','Shooting practice'),('TR_NOV15_04','SnrPl23','2025-11-15','Recovery','Massage and hydrotherapy'),('TR_NOV15_05','SnrPl10','2025-11-15','Technical','Dribbling course'),('TR_NOV15_06','SnrPl24','2025-11-15','Tactical','Video Analysis: Defensive errors vs Rayo'),('TR_NOV20_01','SnrPl4','2025-11-20','Rehab','Grass: Ball work drills (Unipodal)'),('TR_NOV21_01','SnrPl2','2025-11-21','Medical','MRI Scan and initial assessment of knee injury'),('TR_NOV22_01','SnrPl2','2025-11-22','Rehab','Physiotherapy: Ice compression and elevation'),('TR_NOV25_01','SnrPl2','2025-11-25','Rehab','Gym: Upper body ergometer (No leg weight)'),('TR_NOV25_02','SnrPl4','2025-11-25','Rehab','Partial team training (Non-contact)'),('TR_NOV30_01','SnrPl2','2025-11-30','Rehab','Physio: Range of motion exercises'),('TR_OCT24_01','SnrPl1','2025-10-24','Tactical','Goalkeeper distribution vs high press'),('TR_OCT24_02','SnrPl2','2025-10-24','Tactical','Defensive shape: Tracking winger runs'),('TR_OCT24_03','SnrPl3','2025-10-24','Tactical','Defensive shape: Covering spaces behind'),('TR_OCT24_04','SnrPl4','2025-10-24','Rehab','Individual Session: Light running (Recovery from Muscle Injury)'),('TR_OCT24_05','SnrPl5','2025-10-24','Tactical','Midfield transition: Box-to-box runs'),('TR_OCT24_06','SnrPl6','2025-10-24','Tactical','Press resistance: Holding ball under pressure'),('TR_OCT24_07','SnrPl7','2025-10-24','Tactical','Counter-attack: Exploiting high line space'),('TR_OCT24_08','SnrPl8','2025-10-24','Tactical','Pressing triggers: When to engage Barca midfield'),('TR_OCT24_09','SnrPl9','2025-10-24','Tactical','Finishing: 1v1 vs Goalkeeper scenarios'),('TR_OCT24_10','SnrPl10','2025-10-24','Technical','Dribbling in tight spaces'),('TR_OCT24_11','SnrPl11','2025-10-24','Tactical','Link-up play with Bellingham and Vini'),('TR_OCT24_12','SnrPl12','2025-10-24','Tactical','Set-pieces: Corner kick delivery'),('TR_OCT24_13','SnrPl13','2025-10-24','Goalkeeper','Penalty shootout practice'),('TR_OCT24_14','SnrPl14','2025-10-24','Tactical','Defensive screen: Protecting the back four'),('TR_OCT24_15','SnrPl15','2025-10-24','Technical','Free-kick practice'),('TR_OCT24_16','SnrPl22','2025-10-24','Tactical','Physical defending: Marking Lewandowski'),('TR_OCT24_17','SnrPl23','2025-10-24','Tactical','1v1 Defending vs Lamine Yamal'),('TR_OCT24_18','SnrPl24','2025-10-24','Tactical','Shadow play: Defensive shifting'),('TR_OCT24_19','SnrPl28','2025-10-24','Tactical','Shadow play: Defensive shifting (B Team integration)'),('TR_OCT24_20','SnrPl19','2025-10-24','Technical','Possession games: Rondo 5v2'),('TR001','SnrPl1','2025-12-08','Goalkeeper Training','Shot-stopping drills'),('TR002','SnrPl21','2025-12-08','Tactical Session','Positioning and movement off-the-ball'),('TR003','SnrPl22','2025-12-09','Technical Drills','Dribbling and passing exercises'),('TR004','SnrPl15','2025-12-09','Physical Conditioning','Aerobic and strength work'),('TR005','SnrPl14','2025-12-10','Ball Work','Short passing and one-touch football'),('TR006','SnrPl18','2025-12-10','Recovery Session','Light training post-injury monitoring'),('TR007','SnrPl4','2025-12-11','Defensive Drills','One-on-one defending'),('TR008','SnrPl5','2025-12-11','Physical Work','Strength and conditioning'),('TR009','SnrPl21','2025-12-12','Finishing Drills','Clinical shooting practice'),('TR010','SnrPl1','2025-12-15','Match Preparation','Sevilla match pre-game work'),('TR011','SnrPl22','2025-12-15','Match Preparation','Sevilla match pre-game work'),('TR012','SnrPl15','2025-12-15','Match Preparation','Sevilla match pre-game work');
/*!40000 ALTER TABLE `training_schedule` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-28 15:51:14
