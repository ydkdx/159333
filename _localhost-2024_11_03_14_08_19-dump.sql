-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: job
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `chat_messages`
--

DROP TABLE IF EXISTS `chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_messages`
--

LOCK TABLES `chat_messages` WRITE;
/*!40000 ALTER TABLE `chat_messages` DISABLE KEYS */;
INSERT INTO `chat_messages` VALUES (18,'CoIr','lijinpeng','2024-10-24 05:38:21',0,0),(19,'2559510115@qq.com','阿斯顿','2024-10-26 03:50:50',0,0),(20,'as','haha','2024-10-27 04:34:39',1,1),(21,'as','hehe','2024-10-27 06:12:35',1,1),(22,'as','1','2024-10-27 06:15:29',1,1),(23,'as','t1','2024-10-27 07:42:42',1,1),(24,'as','hao','2024-10-27 07:45:05',1,1),(25,'as','t2','2024-10-27 08:04:36',1,1),(26,'1','阿斯顿','2024-10-28 04:40:41',1,1),(27,'1','hello','2024-10-31 02:31:47',1,1),(28,'1','阿斯顿','2024-10-31 03:28:19',1,1),(29,'1','11','2024-10-31 03:31:09',1,1),(30,'1','11','2024-10-31 03:31:41',1,1),(31,'1','hello','2024-10-31 03:31:56',1,1),(32,'1','11','2024-10-31 03:32:33',1,1),(33,'1','1','2024-10-31 03:36:58',1,1),(34,'1','1','2024-10-31 03:38:02',1,1),(35,'1','1','2024-10-31 03:40:58',1,1),(36,'1','2','2024-10-31 03:46:25',1,1),(37,'as','3','2024-10-31 04:17:36',1,1),(38,'as','4','2024-10-31 04:31:24',1,1),(39,'as','employer','2024-10-31 04:31:57',1,1),(40,'as','emploee','2024-10-31 04:43:55',1,1),(41,'1','employer','2024-10-31 04:44:43',1,1),(42,'as','hello','2024-11-01 02:45:31',1,1),(43,'as','hello','2024-11-01 02:46:02',1,1),(44,'as','111','2024-11-01 02:48:12',1,1),(45,'1','222','2024-11-01 02:48:34',1,1),(46,'as','11','2024-11-01 02:49:12',1,1),(47,'as','what about the salary','2024-11-01 03:03:56',1,1),(48,'1','$25 per hour','2024-11-01 03:04:32',1,1),(49,'as','hello','2024-11-01 03:27:34',1,1);
/*!40000 ALTER TABLE `chat_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employers`
--

DROP TABLE IF EXISTS `employers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `relation` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employers`
--

LOCK TABLES `employers` WRITE;
/*!40000 ALTER TABLE `employers` DISABLE KEYS */;
INSERT INTO `employers` VALUES (1,'1','123',0),(2,'123','123',0),(3,'qwe','qwe',0),(4,'user2','password2',0),(5,'user13','password13',0);
/*!40000 ALTER TABLE `employers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interested_jobs`
--

DROP TABLE IF EXISTS `interested_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interested_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `job_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  KEY `interested_jobs_ibfk_1` (`user_id`),
  CONSTRAINT `interested_jobs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `jobseekers` (`id`),
  CONSTRAINT `interested_jobs_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interested_jobs`
--

LOCK TABLES `interested_jobs` WRITE;
/*!40000 ALTER TABLE `interested_jobs` DISABLE KEYS */;
INSERT INTO `interested_jobs` VALUES (6,8,76,'2024-10-24 03:32:02',NULL),(22,3,85,'2024-10-27 01:39:28',NULL),(30,1,61,'2024-11-01 03:27:26',NULL),(31,1,61,'2024-11-01 03:28:06',NULL);
/*!40000 ALTER TABLE `interested_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) DEFAULT NULL COMMENT '公司名称',
  `location` varchar(255) DEFAULT NULL COMMENT '工作地点',
  `industry` varchar(255) DEFAULT NULL COMMENT '部门分类',
  `job_type` varchar(255) DEFAULT NULL COMMENT '工作类型',
  `experience_level` varchar(255) DEFAULT NULL COMMENT '学历',
  `posted_date` date DEFAULT NULL COMMENT '发布日期',
  `requirements` text,
  `responsibilities` text,
  `benefits` text,
  `salary` decimal(10,2) DEFAULT NULL,
  `employer_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='雇主';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (54,'Tech Solutions Inc.','New York','IT','Software Development','Bachelor','2024-10-01',NULL,NULL,NULL,NULL,1),(55,'Green Energy Corp.','Los Angeles','Energy','Engineering','Master','2024-10-02',NULL,NULL,NULL,NULL,1),(56,'Global Finance LLC','Chicago','Finance','Accounting','Bachelor','2024-10-03',NULL,NULL,NULL,NULL,1),(57,'HealthCare Associates','Houston','Healthcare','Medical Services','Doctorate','2024-10-04',NULL,NULL,NULL,NULL,1),(58,'Innovative Tech Labs','San Francisco','IT','R&D','PhD','2024-10-05',NULL,NULL,NULL,NULL,1),(59,'EcoWorld Enterprises','Boston','Environment','Project Management','Bachelor','2024-10-06',NULL,NULL,NULL,NULL,1),(60,'FastTrack Logistics','Miami','Logistics','Supply Chain','Master','2024-10-07',NULL,NULL,NULL,NULL,1),(61,'Silverline Pharmaceuticals','Dallas','Pharmaceuticals','Quality Assurance','Doctorate','2024-10-08',NULL,NULL,NULL,NULL,1),(62,'Skyline Construction Ltd.','Seattle','Construction','Engineering','Bachelor','2024-10-09',NULL,NULL,NULL,NULL,1),(63,'Vanguard Media Group','Denver','Media','Marketing','Master','2024-10-10',NULL,NULL,NULL,NULL,1),(64,'Quantum AI Systems','Austin','IT','Data Science','PhD','2024-10-11',NULL,NULL,NULL,NULL,1),(65,'FutureTech Robotics','San Diego','Manufacturing','Engineering','Bachelor','2024-10-12',NULL,NULL,NULL,NULL,1),(66,'Alpha Investment Partners','New York','Finance','Investment Banking','Master','2024-10-13',NULL,NULL,NULL,NULL,1),(67,'Sunshine Hospitality','Orlando','Hospitality','Customer Service','High School','2024-10-14',NULL,NULL,NULL,NULL,1),(68,'Pinnacle Aerospace','Phoenix','Aerospace','Engineering','Doctorate','2024-10-15',NULL,NULL,NULL,NULL,1),(69,'BlueWave Digital','Philadelphia','IT','Digital Marketing','Bachelor','2024-10-16',NULL,NULL,NULL,NULL,1),(70,'Metro Health Services','Las Vegas','Healthcare','Medical Services','Master','2024-10-17',NULL,NULL,NULL,NULL,1),(71,'SkyHigh Airways','Atlanta','Aviation','Pilot','Master','2024-10-18',NULL,NULL,NULL,NULL,1),(72,'Evergreen Agriculture','Kansas City','Agriculture','R&D','PhD','2024-10-19',NULL,NULL,NULL,NULL,1),(73,'RapidTech Solutions','San Jose','IT','Software Development','Bachelor','2024-10-20',NULL,NULL,NULL,NULL,1),(74,'Innovative Energy Inc.','Portland','Energy','Project Management','Master','2024-10-21',NULL,NULL,NULL,NULL,1),(75,'Titan Financial Group','Charlotte','Finance','Financial Analysis','Bachelor','2024-10-22',NULL,NULL,NULL,NULL,1),(76,'Global Media Studios','Nashville','Media','Content Creation','Bachelor','2024-10-23',NULL,NULL,NULL,NULL,1),(77,'Prime Construction Corp.','Detroit','Construction','Project Management','Master','2024-10-24',NULL,NULL,NULL,NULL,1),(78,'Atlas Pharmaceuticals','San Francisco','Pharmaceuticals','Research','PhD','2024-10-25',NULL,NULL,NULL,NULL,1),(79,'Phoenix IT Solutions','Tampa','IT','Technical Support','Bachelor','2024-10-26',NULL,NULL,NULL,NULL,1),(80,'Aurora Health Systems','Washington DC','Healthcare','Medical Services','Doctorate','2024-10-27',NULL,NULL,NULL,NULL,1),(81,'JetStream Airlines','Dallas','Aviation','Pilot','Master','2024-10-28',NULL,NULL,NULL,NULL,1),(82,'CrestWave Logistics','Denver','Logistics','Supply Chain','Bachelor','2024-10-29',NULL,NULL,NULL,NULL,1),(83,'Elite Manufacturing Co.','Chicago','Manufacturing','Engineering','Bachelor','2024-10-30',NULL,NULL,NULL,NULL,1),(84,'Capital Advisors LLC','New York','Finance','Investment Banking','Master','2024-10-31',NULL,NULL,NULL,NULL,1),(85,'Innovative Healthcare Inc.','Miami','Healthcare','Medical Services','Master','2024-11-01',NULL,NULL,NULL,NULL,1),(86,'NorthStar Tech Group','San Diego','IT','Software Engineering','PhD','2024-11-02',NULL,NULL,NULL,NULL,1),(87,'Urban Development Corp.','San Francisco','Construction','Urban Planning','Bachelor','2024-11-03',NULL,NULL,NULL,NULL,1),(88,'Pacific Pharmaceuticals','Los Angeles','Pharmaceuticals','Research','PhD','2024-11-04',NULL,NULL,NULL,NULL,1),(89,'Skyline Financial Services','Seattle','Finance','Financial Analysis','Master','2024-11-05',NULL,NULL,NULL,NULL,1),(90,'Bright Future Media','Austin','Media','Marketing','Bachelor','2024-11-06',NULL,NULL,NULL,NULL,1),(91,'GreenEnergy Tech Solutions','Portland','Energy','Engineering','Bachelor','2024-11-07',NULL,NULL,NULL,NULL,1),(92,'Eagle Eye Consulting','New York','IT','Cybersecurity','Master','2024-11-08',NULL,NULL,NULL,NULL,1),(93,'Horizon Airlines','Phoenix','Aviation','Pilot','Doctorate','2024-11-09',NULL,NULL,NULL,NULL,1),(94,'Delta Pharmaceuticals','Houston','Pharmaceuticals','Quality Control','Bachelor','2024-11-10',NULL,NULL,NULL,NULL,1),(95,'Summit HealthCare Group','Boston','Healthcare','Medical Research','PhD','2024-11-11',NULL,NULL,NULL,NULL,1),(96,'Fusion Tech Systems','Los Angeles','IT','Software Development','Bachelor','2024-11-12',NULL,NULL,NULL,NULL,1),(97,'Grand Construction Ltd.','Las Vegas','Construction','Architecture','Master','2024-11-13',NULL,NULL,NULL,NULL,1),(98,'Silverline Media Group','Dallas','Media','Content Creation','Bachelor','2024-11-14',NULL,NULL,NULL,NULL,1),(99,'Pioneer Agricultural Co.','San Francisco','Agriculture','R&D','PhD','2024-11-15',NULL,NULL,NULL,NULL,1),(100,'Blue Horizon Logistics','Chicago','Logistics','Supply Chain','Bachelor','2024-11-16',NULL,NULL,NULL,NULL,1),(101,'Empire Financial Group','New York','Finance','Financial Consulting','Master','2024-11-17',NULL,NULL,NULL,NULL,1),(102,'asd','Auckland','IT','study','Master','2024-10-12','1','1','1',1.00,1),(103,'fgh','Auckland','IT','study','Master','2024-10-12','asfa','sadfafs','asfad',123.00,8),(104,'123','Auckland','IT','study','Master','2024-10-13','123','123','123',123.00,8),(105,'tre','Auckland','IT','study','123','2024-10-13','235','3245','235',324.00,1),(106,'213','Auckland','IT','study','Master','2024-10-14','456','165','56+',65.00,1),(107,'asd','北京','IT','兼职','Master','2024-10-26','士大夫','123','反光板',33333.00,3),(108,'TechCorp','New York','Information Technology','Full-time','Senior','2023-01-15','5+ years experience in software development','Develop and maintain applications','Health insurance, Retirement plan',95000.00,1),(109,'GreenWorld','San Francisco','Environmental Services','Part-time','Entry','2023-02-20','Bachelor’s degree in environmental science','Assist in research and project planning','Flexible hours',45000.00,2),(110,'HealthPlus','Boston','Healthcare','Full-time','Mid-level','2023-03-01','2+ years experience in healthcare management','Oversee daily operations','Health insurance, Paid time off',70000.00,3),(111,'EduWise','Chicago','Education','Full-time','Senior','2023-01-30','Master’s degree in education','Manage school curriculum','Professional development',85000.00,4),(112,'FinanceHub','New York','Finance','Contract','Mid-level','2023-02-10','3+ years experience in finance','Handle client accounts','Flexible work options',65000.00,5),(113,'EcoBuilders','Seattle','Construction','Full-time','Entry','2023-03-15','Background in environmental studies','Assist with eco-friendly projects','Paid holidays',52000.00,6),(114,'FoodNest','Miami','Food Services','Part-time','Entry','2023-01-22','Customer service experience','Assist customers and process orders','Discounted meals',28000.00,7),(115,'MediaWave','Los Angeles','Media','Contract','Mid-level','2023-02-05','Experience in content creation','Create and edit media content','Remote work available',60000.00,8),(116,'AutoShift','Detroit','Automotive','Full-time','Senior','2023-03-18','5+ years in automotive industry','Lead product design','Stock options, Health insurance',90000.00,9),(117,'SolarTech','Austin','Energy','Full-time','Mid-level','2023-02-25','3+ years in renewable energy','Implement solar energy solutions','Retirement plan',78000.00,1),(118,'FinServe','Houston','Finance','Part-time','Entry','2023-03-05','Bachelor’s in finance','Assist with financial reports','Paid holidays',40000.00,1),(119,'LifeCare','Atlanta','Healthcare','Full-time','Mid-level','2023-01-12','Nursing license','Provide patient care','Health insurance',68000.00,1),(120,'BrightFuture','Dallas','Education','Contract','Entry','2023-02-15','Teaching experience','Conduct tutoring sessions','Flexible schedule',35000.00,1),(121,'TechSolutions','New York','Information Technology','Full-time','Senior','2023-01-20','10+ years in IT management','Oversee tech projects','Health insurance, Paid time off',120000.00,1),(122,'AgriLife','Des Moines','Agriculture','Part-time','Mid-level','2023-03-02','Agricultural background','Assist with crop management','Seasonal bonuses',47000.00,1),(123,'RetailPro','Phoenix','Retail','Full-time','Entry','2023-01-18','Customer service skills','Manage inventory and sales','Employee discount',30000.00,1),(124,'AeroDynamics','Los Angeles','Aerospace','Full-time','Senior','2023-02-28','10+ years in aerospace engineering','Lead R&D projects','Stock options',130000.00,1),(125,'BioCare','San Diego','Biotechnology','Full-time','Mid-level','2023-03-06','Experience in biotech research','Conduct lab experiments','Health insurance',75000.00,1),(126,'CloudSync','New York','Information Technology','Full-time','Senior','2023-01-25','Experience with cloud platforms','Manage cloud infrastructure','Remote work available',95000.00,1),(127,'PetPal','Chicago','Pet Services','Part-time','Entry','2023-03-10','Love for animals','Assist with pet grooming','Flexible schedule',32000.00,1),(128,'QuickMed','Las Vegas','Healthcare','Full-time','Mid-level','2023-02-08','Pharmacy experience','Dispense medications','Health benefits',67000.00,1),(129,'LogiLink','Memphis','Logistics','Full-time','Senior','2023-01-27','Supply chain expertise','Oversee logistics operations','Retirement plan',88000.00,1),(130,'EcoHome','San Francisco','Construction','Contract','Entry','2023-03-14','Interest in sustainable building','Assist with construction projects','Professional development',55000.00,1),(131,'Appify','Seattle','Information Technology','Full-time','Mid-level','2023-02-17','3+ years in app development','Develop mobile apps','Remote work available',85000.00,1),(132,'SunPower','Phoenix','Energy','Full-time','Senior','2023-01-19','Solar energy experience','Manage solar projects','Retirement benefits',98000.00,1),(133,'SafeNet','Austin','Information Technology','Contract','Entry','2023-02-01','Background in cybersecurity','Monitor network security','Flexible schedule',62000.00,1),(134,'MedLine','Miami','Healthcare','Full-time','Mid-level','2023-03-11','Registered nurse license','Provide patient care','Health insurance',71000.00,1),(135,'CleanCo','Portland','Environmental Services','Full-time','Entry','2023-01-21','Interest in sustainability','Perform eco-friendly tasks','Paid holidays',42000.00,1),(136,'GreenTech','San Jose','Renewable Energy','Full-time','Mid-level','2023-02-12','Renewable energy experience','Install solar panels','Health insurance',76000.00,1),(137,'SmartHome','Orlando','Technology','Full-time','Entry','2023-03-09','Interest in smart home tech','Install smart devices','Flexible hours',58000.00,1),(138,'FinConsult','Charlotte','Finance','Part-time','Mid-level','2023-01-28','Financial advising experience','Advise clients on finances','Remote work',55000.00,1),(139,'TeachPlus','Atlanta','Education','Contract','Senior','2023-02-19','Teaching certification','Develop educational programs','Professional development',92000.00,1),(140,'FoodieHub','Houston','Food Services','Full-time','Entry','2023-03-13','Food handling certification','Prepare and serve food','Employee discount',30000.00,1),(141,'NetSecure','Denver','Cybersecurity','Full-time','Senior','2023-01-23','5+ years in cybersecurity','Monitor and manage threats','Stock options',94000.00,1),(142,'GreenHarvest','Columbus','Agriculture','Contract','Entry','2023-02-11','Interest in organic farming','Assist with planting and harvesting','Seasonal bonuses',42000.00,1),(143,'LifeTech','Philadelphia','Biotechnology','Full-time','Mid-level','2023-03-07','Biotech lab experience','Conduct experiments and research','Health insurance',78000.00,1),(144,'SkyHigh','Miami','Aerospace','Full-time','Entry','2023-01-26','Interest in aerodynamics','Assist with aircraft design','Professional development',62000.00,1),(145,'DataCore','San Francisco','Information Technology','Full-time','Mid-level','2023-02-13','Experience with data analysis','Analyze large datasets','Remote work',80000.00,1),(146,'CareMax','New York','Healthcare','Full-time','Senior','2023-01-29','10+ years in healthcare','Oversee patient care services','Health insurance, Paid time off',110000.00,1),(147,'EcoCity','Chicago','Environmental Services','Part-time','Entry','2023-03-04','Passion for eco-friendly projects','Assist in sustainability initiatives','Flexible hours',45000.00,1),(148,'BuildMaster','Los Angeles','Construction','Full-time','Mid-level','2023-02-14','Construction management experience','Oversee project operations','Health insurance',75000.00,1),(149,'HealthFirst','Boston','Healthcare','Full-time','Entry','2023-03-08','CPR certification','Assist nurses and doctors','Health benefits',40000.00,1),(150,'UrbanRenew','Austin','Real Estate','Full-time','Senior','2023-02-21','Real estate experience','Manage property development','Retirement plan',97000.00,1),(151,'RoboTech','Dallas','Robotics','Full-time','Senior','2023-01-31','Experience in robotics engineering','Develop robotics technology','Stock options',105000.00,1),(152,'ShopEasy','New York','Retail','Part-time','Entry','2023-02-24','Customer service skills','Assist customers and manage inventory','Employee discount',28000.00,1),(153,'AquaLife','San Diego','Environmental Services','Full-time','Mid-level','2023-03-03','Marine biology experience','Conduct water quality tests','Health insurance',68000.00,1),(154,'DriveSmart','Detroit','Automotive','Full-time','Entry','2023-01-14','Interest in automotive industry','Assist in car repairs and maintenance','Paid time off',55000.00,1),(155,'FarmFresh','Fresno','Agriculture','Full-time','Mid-level','2023-02-07','Farming experience','Oversee crop production','Seasonal bonuses',67000.00,1),(156,'AirLogix','Seattle','Aerospace','Full-time','Senior','2023-01-17','10+ years in aerospace industry','Lead aerospace projects','Health insurance, Stock options',125000.00,1),(157,'SmartWave','Orlando','Technology','Full-time','Entry','2023-03-12','Interest in smart tech','Assist with smart device installations','Flexible hours',59000.00,1),(158,'123','123','123','123','123','2024-11-01','123','123','123',123.00,1),(159,'ert','Auckland','IT','study','Master','2024-11-01','dfzuyjhgvdfhjx','dfgldkfjgdfllkgj','sdfmhskjdf',10000.00,1);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobseekers`
--

DROP TABLE IF EXISTS `jobseekers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobseekers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `skills` text,
  `job_preferences` text,
  `education_background` text,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `experience` text,
  `relation` int DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobseekers`
--

LOCK TABLES `jobseekers` WRITE;
/*!40000 ALTER TABLE `jobseekers` DISABLE KEYS */;
INSERT INTO `jobseekers` VALUES (1,'as','123','1223','hh','hh','Bill','2559510115@qq.com','hh',1),(2,'hsx','coir',NULL,NULL,NULL,NULL,NULL,NULL,1),(3,'1','123',NULL,NULL,NULL,NULL,NULL,NULL,1),(8,'ljp','123','编程','远程工作','本科','测试用户','testuser@example.com','3年',1),(9,'123','123',NULL,NULL,NULL,NULL,NULL,NULL,1),(10,'test@example.com','defaultPassword123','Node.js','Full-time','Bachelor','Test Name','test@example.com','3 years',1),(11,'haha','123',NULL,NULL,NULL,NULL,NULL,NULL,1),(12,'QWE','QWE',NULL,NULL,NULL,NULL,NULL,NULL,1),(13,'user1','password1',NULL,NULL,NULL,NULL,NULL,NULL,1),(15,'user12','password12',NULL,NULL,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `jobseekers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendations`
--

DROP TABLE IF EXISTS `recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `job_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendations`
--

LOCK TABLES `recommendations` WRITE;
/*!40000 ALTER TABLE `recommendations` DISABLE KEYS */;
/*!40000 ALTER TABLE `recommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('L88FYftqIMZwbmGJHjXG7iIGJCWso7J6',1730518037,'{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2024-11-02T03:23:33.222Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"userId\":1}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submitted_resumes`
--

DROP TABLE IF EXISTS `submitted_resumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submitted_resumes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int DEFAULT NULL,
  `jobseeker_id` int DEFAULT NULL,
  `resume_content` text,
  `employer_id` int DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `job_id` (`job_id`),
  KEY `jobseeker_id` (`jobseeker_id`),
  KEY `employer_id` (`employer_id`),
  CONSTRAINT `submitted_resumes_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`),
  CONSTRAINT `submitted_resumes_ibfk_2` FOREIGN KEY (`jobseeker_id`) REFERENCES `jobseekers` (`id`),
  CONSTRAINT `submitted_resumes_ibfk_3` FOREIGN KEY (`employer_id`) REFERENCES `employers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submitted_resumes`
--

LOCK TABLES `submitted_resumes` WRITE;
/*!40000 ALTER TABLE `submitted_resumes` DISABLE KEYS */;
INSERT INTO `submitted_resumes` VALUES (8,56,1,'This is the user\'s resume content',1,'2024-10-27 02:04:49'),(9,90,1,'This is the user\'s resume content',1,'2024-10-27 05:25:18'),(10,54,1,'This is the user\'s resume content',1,'2024-11-01 02:39:06'),(11,105,1,'This is the user\'s resume content',1,'2024-11-01 02:53:44'),(12,61,1,'This is the user\'s resume content',1,'2024-11-01 03:27:37');
/*!40000 ALTER TABLE `submitted_resumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profiles` (
  `user_id` int NOT NULL,
  `industry` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `jobseekers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profiles`
--

LOCK TABLES `user_profiles` WRITE;
/*!40000 ALTER TABLE `user_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` char(12) NOT NULL,
  `password` varchar(45) NOT NULL,
  `id` int DEFAULT NULL COMMENT 'as',
  PRIMARY KEY (`password`,`username`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-03 14:08:19
