-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: gsdb
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `결제`
--

DROP TABLE IF EXISTS `결제`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `결제` (
  `판매번호` int NOT NULL,
  `결제방식` varchar(45) NOT NULL,
  `결제금액` int NOT NULL,
  `카드번호` int DEFAULT NULL,
  `승인번호` int DEFAULT NULL,
  PRIMARY KEY (`판매번호`,`결제방식`),
  CONSTRAINT `결제_판매번호` FOREIGN KEY (`판매번호`) REFERENCES `판매내역` (`판매번호`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `결제`
--

LOCK TABLES `결제` WRITE;
/*!40000 ALTER TABLE `결제` DISABLE KEYS */;
/*!40000 ALTER TABLE `결제` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `결제조건`
--

DROP TABLE IF EXISTS `결제조건`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `결제조건` (
  `이벤트코드` int NOT NULL,
  `결제방식` varchar(45) NOT NULL,
  PRIMARY KEY (`이벤트코드`),
  CONSTRAINT `결제조건_이벤트` FOREIGN KEY (`이벤트코드`) REFERENCES `이벤트` (`이벤트코드`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `결제조건`
--

LOCK TABLES `결제조건` WRITE;
/*!40000 ALTER TABLE `결제조건` DISABLE KEYS */;
/*!40000 ALTER TABLE `결제조건` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `근태기록`
--

DROP TABLE IF EXISTS `근태기록`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `근태기록` (
  `직원ID` int NOT NULL,
  `출근` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `퇴근` datetime DEFAULT NULL,
  PRIMARY KEY (`직원ID`,`출근`),
  KEY `fk_근태기록_직원1_idx` (`직원ID`),
  CONSTRAINT `fk_근태기록_직원1` FOREIGN KEY (`직원ID`) REFERENCES `직원` (`직원ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `근태기록`
--

LOCK TABLES `근태기록` WRITE;
/*!40000 ALTER TABLE `근태기록` DISABLE KEYS */;
INSERT INTO `근태기록` VALUES (2,'2023-05-01 08:59:00','2023-05-01 16:59:00'),(2,'2023-05-02 08:59:00','2023-05-02 16:59:00'),(2,'2023-05-03 08:59:00','2023-05-03 16:59:00'),(2,'2023-05-04 08:59:00','2023-05-04 16:59:00'),(2,'2023-05-05 08:59:00','2023-05-05 16:59:00'),(2,'2023-05-08 08:59:00','2023-05-08 16:59:00'),(2,'2023-05-09 08:59:00','2023-05-09 16:59:00'),(2,'2023-05-10 08:59:00','2023-05-10 16:59:00'),(2,'2023-05-11 08:59:00','2023-05-11 16:59:00'),(2,'2023-05-12 08:59:00','2023-05-12 16:59:00'),(2,'2023-05-15 08:59:00','2023-05-15 16:59:00'),(2,'2023-05-16 08:59:00','2023-05-16 16:59:00'),(2,'2023-05-17 08:59:00','2023-05-17 16:59:00'),(2,'2023-05-18 08:59:00','2023-05-18 16:59:00'),(2,'2023-05-19 08:59:00','2023-05-19 16:59:00'),(2,'2023-05-22 08:59:00','2023-05-22 16:59:00'),(2,'2023-05-23 08:59:00','2023-05-23 16:59:00'),(2,'2023-05-24 08:59:00','2023-05-24 16:59:00'),(2,'2023-05-25 08:59:00','2023-05-25 16:59:00'),(2,'2023-05-26 08:59:00','2023-05-26 16:59:00'),(2,'2023-05-29 08:59:00','2023-05-29 16:59:00'),(2,'2023-05-30 08:59:00','2023-05-30 16:59:00'),(2,'2023-05-31 08:59:00','2023-05-31 16:59:00');
/*!40000 ALTER TABLE `근태기록` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `근태기록뷰`
--

DROP TABLE IF EXISTS `근태기록뷰`;
/*!50001 DROP VIEW IF EXISTS `근태기록뷰`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `근태기록뷰` AS SELECT 
 1 AS `직원ID`,
 1 AS `출근`,
 1 AS `퇴근`,
 1 AS `근무시간`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `미출상품`
--

DROP TABLE IF EXISTS `미출상품`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `미출상품` (
  `출고번호` int NOT NULL,
  `상품코드` bigint NOT NULL,
  `미출사유` varchar(45) DEFAULT NULL,
  `미출량` int NOT NULL,
  PRIMARY KEY (`출고번호`,`상품코드`),
  CONSTRAINT `출고상품변수` FOREIGN KEY (`출고번호`, `상품코드`) REFERENCES `출고상품` (`출고번호`, `상품코드`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `미출상품`
--

LOCK TABLES `미출상품` WRITE;
/*!40000 ALTER TABLE `미출상품` DISABLE KEYS */;
/*!40000 ALTER TABLE `미출상품` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `발주`
--

DROP TABLE IF EXISTS `발주`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `발주` (
  `발주번호` int NOT NULL AUTO_INCREMENT,
  `발주상태` varchar(45) NOT NULL,
  `발주날짜` date NOT NULL,
  PRIMARY KEY (`발주번호`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `발주`
--

LOCK TABLES `발주` WRITE;
/*!40000 ALTER TABLE `발주` DISABLE KEYS */;
INSERT INTO `발주` VALUES (1,'출고','2023-06-06');
/*!40000 ALTER TABLE `발주` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `발주번호별합계`
--

DROP TABLE IF EXISTS `발주번호별합계`;
/*!50001 DROP VIEW IF EXISTS `발주번호별합계`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `발주번호별합계` AS SELECT 
 1 AS `발주번호`,
 1 AS `원가합계`,
 1 AS `매가합계`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `발주상품`
--

DROP TABLE IF EXISTS `발주상품`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `발주상품` (
  `발주번호` int NOT NULL,
  `상품코드` bigint NOT NULL,
  `발주개수` int NOT NULL,
  `원가` int DEFAULT NULL,
  `매가` int DEFAULT NULL,
  PRIMARY KEY (`상품코드`,`발주번호`),
  KEY `발주_상품_idx` (`상품코드`),
  KEY `발주상품_발주_idx` (`발주번호`),
  CONSTRAINT `발주상품_발주` FOREIGN KEY (`발주번호`) REFERENCES `발주` (`발주번호`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `발주상품_상품` FOREIGN KEY (`상품코드`) REFERENCES `상품` (`상품코드`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `발주상품`
--

LOCK TABLES `발주상품` WRITE;
/*!40000 ALTER TABLE `발주상품` DISABLE KEYS */;
/*!40000 ALTER TABLE `발주상품` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `발주상품_AFTER_INSERT` AFTER INSERT ON `발주상품` FOR EACH ROW BEGIN
	UPDATE	발주상품
	SET		발주상품.원가 = (SELECT 상품.원가 FROM 상품 WHERE 상품.상품코드 = NEW.상품코드),
			발주상품.매가 = (SELECT 상품.매가 FROM 상품 WHERE 상품.상품코드 = NEW.상품코드)
	WHERE	발주번호 = NEW.발주번호;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `발주상품뷰`
--

DROP TABLE IF EXISTS `발주상품뷰`;
/*!50001 DROP VIEW IF EXISTS `발주상품뷰`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `발주상품뷰` AS SELECT 
 1 AS `발주번호`,
 1 AS `상품코드`,
 1 AS `상품이름`,
 1 AS `발주개수`,
 1 AS `원가`,
 1 AS `매가`,
 1 AS `BOX입수`,
 1 AS `상품중분류`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `상품`
--

DROP TABLE IF EXISTS `상품`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `상품` (
  `상품코드` bigint NOT NULL,
  `상품이름` varchar(45) NOT NULL,
  `매가` int NOT NULL,
  `원가` int NOT NULL,
  `BOX입수` int NOT NULL,
  `상품중분류` int NOT NULL,
  PRIMARY KEY (`상품코드`),
  KEY `fk_상품_상품 중분류1_idx` (`상품중분류`),
  CONSTRAINT `fk_상품_상품 중분류1` FOREIGN KEY (`상품중분류`) REFERENCES `상품중분류` (`중분류번호`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `상품`
--

LOCK TABLES `상품` WRITE;
/*!40000 ALTER TABLE `상품` DISABLE KEYS */;
INSERT INTO `상품` VALUES (88008028,'빙그래)요구르트65ML5입',900,552,20,40),(88011158,'시즌',4500,3700,500,65),(88019109,'메비우스E스타일3MG',4200,3468,500,65),(2700038841238,'3단참치샐러드샌드위치2편',2600,1489,40,4),(2700038841887,'삼각)매콤참치2편',1100,660,50,3),(2700038841986,'편스)진또더맵싹갈비2편',1700,1020,50,3),(2700038842716,'왕)묵은지참치김밥2편',2700,1595,50,2),(2700038842730,'소고기고추장김밥2편',2500,1454,50,2),(2700038843065,'기본김밥2편',1900,1140,50,2),(2700038845670,'혜자로운집밥)제육볶음2편',4500,3068,10,1),(2700038846554,'샘표)반숙버터간장2편',1300,780,50,3),(2700038846752,'혜자로운)너비아니닭강정1',4900,3341,10,1),(2700038846769,'혜자로운)너비아니닭강정2',4900,3341,10,1),(2700038847261,'1900)치즈버거2편',1900,1036,30,4),(2700038847391,'혜자로운집밥)에그함박2편',5500,3750,10,1),(8801007429298,'CJ)비비고찐만두168G',4400,2200,24,8),(8801007573861,'CJ)숯불향닭강정200G',5600,2927,32,8),(8801045572833,'오뚜기)참깨라면(소컵)',1300,698,15,58),(8801056175955,'롯데)펩시제로라임500ML',2000,970,6,47),(8801068408102,'삼립)달콤달콤허니볼',2000,1090,15,9),(8801068912876,'삼립)생크림보름달',1600,872,21,9),(8801068915174,'삼립)한돈데리마요버거2편',3800,2176,21,4),(8801073106079,'삼양)육개장(소컵)',1000,500,6,58),(8801073211469,'삼양)까르보불닭볶음면(대컵)',1800,900,16,58),(8801104940382,'빙그레)식물성바유190ML',1500,457,24,39),(8801111534220,'서울)초코우유300ML',1800,885,28,39),(8801115114031,'서울)우유200ML',1100,586,50,39),(8801115134213,'서울)딸기우유300ML',1800,885,28,39),(8801152135235,'롯데)처음처럼부드러운369ML',1950,1057,20,51),(8801858133337,'오비)카스큐팩1.6L',6300,3954,6,50),(8803051881282,'심플리쿡)반반족발편육255G',9900,5399,30,7),(8809197840268,'유어스)돌덩이얼음1KG',2000,793,10,44),(8809266251780,'김가루매콤순대범벅282G',5500,2999,25,7);
/*!40000 ALTER TABLE `상품` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `상품중분류`
--

DROP TABLE IF EXISTS `상품중분류`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `상품중분류` (
  `중분류번호` int NOT NULL,
  `중분류이름` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`중분류번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `상품중분류`
--

LOCK TABLES `상품중분류` WRITE;
/*!40000 ALTER TABLE `상품중분류` DISABLE KEYS */;
INSERT INTO `상품중분류` VALUES (1,'도시락'),(2,'김밥'),(3,'주먹밥'),(4,'햄버거/샌드위치'),(5,'카운터FF'),(6,'FF간편식'),(7,'냉장간편식품'),(8,'냉동간편식품'),(9,'빵류'),(10,'점내조리'),(11,'특정판매'),(12,'외주조리'),(13,'육가공'),(14,'어묵/맛살'),(15,'두부/나물'),(16,'근채'),(17,'과채'),(18,'엽채'),(19,'양념'),(20,'샐러드'),(21,'버섯'),(22,'김치'),(23,'나물'),(24,'앵걱'),(25,'채소가공'),(26,'국산과일'),(27,'수입과일'),(28,'건과'),(29,'과일가공'),(30,'국산돈뉵'),(31,'계육/계란'),(32,'국산우육'),(33,'수입육'),(34,'축산가공'),(35,'어류'),(36,'해물'),(37,'건어'),(38,'수산가공'),(39,'우유'),(40,'발효유'),(41,'냉장음료'),(42,'치즈/버터'),(43,'아이스크림'),(44,'얼음'),(45,'커피/차음료'),(46,'기능성음료'),(47,'탄산음료'),(48,'생수/탄산수'),(49,'주스'),(50,'맥주'),(51,'소주/전통주'),(52,'양주/와인'),(53,'스낵'),(54,'쿠키/샌드'),(55,'캔디/껌'),(56,'초콜릿'),(57,'안주'),(58,'면류'),(59,'즉석식품'),(60,'커피/차'),(61,'조미료'),(62,'통조림'),(63,'씨리얼/유아식'),(64,'식용유/참기름'),(65,'담배'),(66,'서비스상품'),(67,'개인위생'),(68,'의양/의료'),(69,'건강'),(70,'헤어용품'),(71,'기초화장품'),(72,'미용소품'),(73,'색조화장품'),(74,'바디용품'),(75,'생리대/화장지'),(76,'생활용품'),(77,'문화/가전'),(78,'가사용품'),(79,'의류용품'),(80,'반려동물'),(81,'한식'),(82,'아시안'),(83,'양식'),(88,'특정판매/수수료'),(89,'연관/세트-비식품'),(90,'온라인주류'),(91,'수수료상품'),(93,'Other Buisiness'),(99,'소모품');
/*!40000 ALTER TABLE `상품중분류` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `시간조건`
--

DROP TABLE IF EXISTS `시간조건`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `시간조건` (
  `이벤트코드` int NOT NULL,
  `시작시간` time NOT NULL,
  `종료시간` time NOT NULL,
  PRIMARY KEY (`이벤트코드`),
  CONSTRAINT `시간조건_이벤트` FOREIGN KEY (`이벤트코드`) REFERENCES `이벤트` (`이벤트코드`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `시간조건`
--

LOCK TABLES `시간조건` WRITE;
/*!40000 ALTER TABLE `시간조건` DISABLE KEYS */;
/*!40000 ALTER TABLE `시간조건` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `이벤트`
--

DROP TABLE IF EXISTS `이벤트`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `이벤트` (
  `이벤트코드` int NOT NULL AUTO_INCREMENT,
  `이벤트방식` varchar(45) NOT NULL,
  `할인가격` int NOT NULL,
  `이벤트시작날짜` date NOT NULL,
  `이벤트종료날짜` date NOT NULL,
  PRIMARY KEY (`이벤트코드`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `이벤트`
--

LOCK TABLES `이벤트` WRITE;
/*!40000 ALTER TABLE `이벤트` DISABLE KEYS */;
INSERT INTO `이벤트` VALUES (1,'1+1',5600,'2023-06-01','2023-06-30'),(2,'2+1',1800,'2023-06-01','2023-06-30');
/*!40000 ALTER TABLE `이벤트` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `이벤트상품`
--

DROP TABLE IF EXISTS `이벤트상품`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `이벤트상품` (
  `이벤트코드` int NOT NULL,
  `상품코드` bigint NOT NULL,
  `할인상품` tinyint NOT NULL,
  PRIMARY KEY (`이벤트코드`,`상품코드`),
  KEY `fk_이벤트 목록_상품1_idx` (`상품코드`),
  KEY `fk_이벤트 목록_이벤트1_idx` (`이벤트코드`),
  CONSTRAINT `fk_상품 목록_상품1` FOREIGN KEY (`상품코드`) REFERENCES `상품` (`상품코드`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_이벤트 목록_이벤트1` FOREIGN KEY (`이벤트코드`) REFERENCES `이벤트` (`이벤트코드`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `이벤트상품`
--

LOCK TABLES `이벤트상품` WRITE;
/*!40000 ALTER TABLE `이벤트상품` DISABLE KEYS */;
INSERT INTO `이벤트상품` VALUES (1,8801007573861,1),(2,8801111534220,1),(2,8801115134213,1);
/*!40000 ALTER TABLE `이벤트상품` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `재고`
--

DROP TABLE IF EXISTS `재고`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `재고` (
  `상품코드` bigint NOT NULL,
  `수량` int NOT NULL,
  PRIMARY KEY (`상품코드`),
  KEY `fk_재고_상품1_idx` (`상품코드`),
  CONSTRAINT `재고_상품` FOREIGN KEY (`상품코드`) REFERENCES `상품` (`상품코드`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `재고`
--

LOCK TABLES `재고` WRITE;
/*!40000 ALTER TABLE `재고` DISABLE KEYS */;
/*!40000 ALTER TABLE `재고` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `적용이벤트`
--

DROP TABLE IF EXISTS `적용이벤트`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `적용이벤트` (
  `판매번호` int NOT NULL,
  `이벤트코드` int NOT NULL,
  `적용횟수` int NOT NULL,
  PRIMARY KEY (`이벤트코드`,`판매번호`),
  KEY `판매번호_idx` (`판매번호`),
  CONSTRAINT `적용이벤트_이벤트코드` FOREIGN KEY (`이벤트코드`) REFERENCES `mydb`.`이벤트` (`이벤트코드`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `적용이벤트_판매번호` FOREIGN KEY (`판매번호`) REFERENCES `mydb`.`판매내역` (`판매번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `적용이벤트`
--

LOCK TABLES `적용이벤트` WRITE;
/*!40000 ALTER TABLE `적용이벤트` DISABLE KEYS */;
INSERT INTO `적용이벤트` VALUES (2,2,4);
/*!40000 ALTER TABLE `적용이벤트` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `직원`
--

DROP TABLE IF EXISTS `직원`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `직원` (
  `직원ID` int NOT NULL,
  `직원이름` varchar(45) NOT NULL,
  `직급` varchar(45) NOT NULL,
  PRIMARY KEY (`직원ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `직원`
--

LOCK TABLES `직원` WRITE;
/*!40000 ALTER TABLE `직원` DISABLE KEYS */;
INSERT INTO `직원` VALUES (1,'조명화','점장'),(2,'조지민','점원'),(3,'서정우','점원'),(4,'박시훈','점원'),(5,'최병주','점원'),(6,'장인석','점원');
/*!40000 ALTER TABLE `직원` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `출고`
--

DROP TABLE IF EXISTS `출고`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `출고` (
  `출고번호` int NOT NULL AUTO_INCREMENT,
  `발주번호` int NOT NULL,
  `출고시각` datetime NOT NULL,
  PRIMARY KEY (`출고번호`),
  KEY `fk_출고_발주1_idx` (`발주번호`),
  CONSTRAINT `fk_출고_발주1` FOREIGN KEY (`발주번호`) REFERENCES `발주` (`발주번호`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `출고`
--

LOCK TABLES `출고` WRITE;
/*!40000 ALTER TABLE `출고` DISABLE KEYS */;
/*!40000 ALTER TABLE `출고` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `출고_AFTER_INSERT` AFTER INSERT ON `출고` FOR EACH ROW BEGIN
    update 발주 set 발주상태 = '출고' where 발주.발주번호 = new.발주번호;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `출고상품`
--

DROP TABLE IF EXISTS `출고상품`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `출고상품` (
  `출고번호` int NOT NULL,
  `상품코드` bigint NOT NULL,
  `출고개수` int NOT NULL,
  PRIMARY KEY (`출고번호`,`상품코드`),
  KEY `출고상품_상품_idx` (`상품코드`),
  CONSTRAINT `출고상품_상품` FOREIGN KEY (`상품코드`) REFERENCES `상품` (`상품코드`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `출고상품_출고` FOREIGN KEY (`출고번호`) REFERENCES `출고` (`출고번호`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `출고상품`
--

LOCK TABLES `출고상품` WRITE;
/*!40000 ALTER TABLE `출고상품` DISABLE KEYS */;
/*!40000 ALTER TABLE `출고상품` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `출고집계표`
--

DROP TABLE IF EXISTS `출고집계표`;
/*!50001 DROP VIEW IF EXISTS `출고집계표`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `출고집계표` AS SELECT 
 1 AS `상품코드`,
 1 AS `상품이름`,
 1 AS `BOX입수`,
 1 AS `발주량`,
 1 AS `출고량`,
 1 AS `출고량BOX`,
 1 AS `미출량`,
 1 AS `매가`,
 1 AS `매가금액`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `판매내역`
--

DROP TABLE IF EXISTS `판매내역`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `판매내역` (
  `판매번호` int NOT NULL AUTO_INCREMENT,
  `판매시각` datetime NOT NULL,
  `환불여부` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`판매번호`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `판매내역`
--

LOCK TABLES `판매내역` WRITE;
/*!40000 ALTER TABLE `판매내역` DISABLE KEYS */;
INSERT INTO `판매내역` VALUES (1,'2023-06-07 02:42:32',0),(2,'2023-06-07 06:20:17',0);
/*!40000 ALTER TABLE `판매내역` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `판매상품`
--

DROP TABLE IF EXISTS `판매상품`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `판매상품` (
  `판매번호` int NOT NULL,
  `상품코드` bigint NOT NULL,
  `취소상품` tinyint NOT NULL DEFAULT '0',
  `판매수` int NOT NULL,
  `판매가` int DEFAULT NULL,
  PRIMARY KEY (`판매번호`,`상품코드`),
  KEY `판매상품_상품_idx` (`상품코드`),
  CONSTRAINT `판매상품_상품` FOREIGN KEY (`상품코드`) REFERENCES `상품` (`상품코드`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `판매상품_판매내역` FOREIGN KEY (`판매번호`) REFERENCES `판매내역` (`판매번호`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `판매상품`
--

LOCK TABLES `판매상품` WRITE;
/*!40000 ALTER TABLE `판매상품` DISABLE KEYS */;
INSERT INTO `판매상품` VALUES (1,8801007573861,1,5,5600),(2,8801111534220,0,9,1800),(2,8801115134213,0,5,1800);
/*!40000 ALTER TABLE `판매상품` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `판매상품_AFTER_INSERT` AFTER INSERT ON `판매상품` FOR EACH ROW BEGIN
    
    SET @eid := (
    SELECT 이벤트코드
    FROM 현재이벤트상품
    WHERE 현재이벤트상품.상품코드 = NEW.상품코드
    );
    SET @et := (
    SELECT 이벤트방식
    FROM 현재이벤트상품
    WHERE 현재이벤트상품.상품코드 = NEW.상품코드
    );
    SET @num := (
    SELECT sum(판매수)
    FROM 현재이벤트상품, 판매상품
    WHERE 현재이벤트상품.상품코드 = 판매상품.상품코드 and 현재이벤트상품.이벤트코드 = @eid and 판매상품.취소상품 = 0
    );
    SET foreign_key_checks = 0;
    IF @et = '1+1' AND @num > 2 THEN
        INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수) VALUES (NEW.판매번호, @eid, (@num DIV 2))
        ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 2);
	ELSEIF @et = '2+1' AND @num > 3 THEN
		INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
		VALUES (NEW.판매번호, @eid, (@num DIV 3))
		ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 3);
    END IF;
	SET foreign_key_checks = 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `판매상품_AFTER_UPDATE` AFTER UPDATE ON `판매상품` FOR EACH ROW BEGIN

    SET @eid := (
    SELECT 이벤트코드
    FROM 현재이벤트상품
    WHERE 현재이벤트상품.상품코드 = NEW.상품코드
    );
    SET @et := (
    SELECT 이벤트방식
    FROM 현재이벤트상품
    WHERE 현재이벤트상품.상품코드 = NEW.상품코드
    );
    SET @num := (
    SELECT sum(판매수)
    FROM 현재이벤트상품, 판매상품
    WHERE 현재이벤트상품.상품코드 = 판매상품.상품코드 and 현재이벤트상품.이벤트코드 = @eid and 판매상품.취소상품 = 0
    );
    SET foreign_key_checks = 0;
	IF @num IS NULL THEN
        DELETE FROM 적용이벤트
        WHERE 판매번호 = OLD.판매번호 AND 이벤트코드 = @eid;
    ELSEIF @et = '1+1' THEN
        INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
        VALUES (NEW.판매번호, @eid, (@num DIV 2))
        ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 2);
	ELSEIF @et = '2+1' THEN
		INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
		VALUES (NEW.판매번호, @eid, (@num DIV 3))
		ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 3);
    END IF;
	SET foreign_key_checks = 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `판매상품_AFTER_DELETE` AFTER DELETE ON `판매상품` FOR EACH ROW BEGIN
    SET @eid := (
    SELECT 이벤트코드
    FROM 현재이벤트상품
    WHERE 현재이벤트상품.상품코드 = OLD.상품코드
    );
    SET @et := (
    SELECT 이벤트방식
    FROM 현재이벤트상품
    WHERE 현재이벤트상품.상품코드 = OLD.상품코드
    );
    SET @num := (
    SELECT sum(판매수)
    FROM 현재이벤트상품, 판매상품
    WHERE 현재이벤트상품.상품코드 = 판매상품.상품코드 and 현재이벤트상품.이벤트코드 = @eid and 판매상품.취소상품 = 0
    );
    SET foreign_key_checks = 0;
	IF @num IS NULL THEN
        DELETE FROM 적용이벤트
        WHERE 판매번호 = OLD.판매번호 AND 이벤트코드 = @eid;
    ELSEIF @et = '1+1' THEN
        INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
        VALUES (OLD.판매번호, @eid, (@num DIV 2))
        ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 2);
	ELSEIF @et = '2+1' THEN
		INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
		VALUES (OLD.판매번호, @eid, (@num DIV 3))
		ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 3);
    END IF;
    SET foreign_key_checks = 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `현금영수증`
--

DROP TABLE IF EXISTS `현금영수증`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `현금영수증` (
  `판매번호` int NOT NULL,
  `승인번호` int NOT NULL,
  PRIMARY KEY (`판매번호`),
  CONSTRAINT `현금영수증_판매번호` FOREIGN KEY (`판매번호`) REFERENCES `판매내역` (`판매번호`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `현금영수증`
--

LOCK TABLES `현금영수증` WRITE;
/*!40000 ALTER TABLE `현금영수증` DISABLE KEYS */;
/*!40000 ALTER TABLE `현금영수증` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `현재이벤트상품`
--

DROP TABLE IF EXISTS `현재이벤트상품`;
/*!50001 DROP VIEW IF EXISTS `현재이벤트상품`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `현재이벤트상품` AS SELECT 
 1 AS `이벤트코드`,
 1 AS `이벤트방식`,
 1 AS `상품코드`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `현재적용이벤트뷰`
--

DROP TABLE IF EXISTS `현재적용이벤트뷰`;
/*!50001 DROP VIEW IF EXISTS `현재적용이벤트뷰`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `현재적용이벤트뷰` AS SELECT 
 1 AS `이벤트코드`,
 1 AS `이벤트방식`,
 1 AS `할인가격`,
 1 AS `이벤트시작날짜`,
 1 AS `이벤트종료날짜`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `근태기록뷰`
--

/*!50001 DROP VIEW IF EXISTS `근태기록뷰`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `근태기록뷰` AS select `근태기록`.`직원ID` AS `직원ID`,`근태기록`.`출근` AS `출근`,`근태기록`.`퇴근` AS `퇴근`,(`근태기록`.`퇴근` - `근태기록`.`출근`) AS `근무시간` from `근태기록` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `발주번호별합계`
--

/*!50001 DROP VIEW IF EXISTS `발주번호별합계`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `발주번호별합계` AS select `발주상품`.`발주번호` AS `발주번호`,sum((`발주상품`.`원가` * `발주상품`.`발주개수`)) AS `원가합계`,sum((`발주상품`.`매가` * `발주상품`.`발주개수`)) AS `매가합계` from `발주상품` group by `발주상품`.`발주번호` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `발주상품뷰`
--

/*!50001 DROP VIEW IF EXISTS `발주상품뷰`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `발주상품뷰` AS select `a`.`발주번호` AS `발주번호`,`a`.`상품코드` AS `상품코드`,`b`.`상품이름` AS `상품이름`,`a`.`발주개수` AS `발주개수`,`a`.`원가` AS `원가`,`a`.`매가` AS `매가`,`b`.`BOX입수` AS `BOX입수`,`b`.`상품중분류` AS `상품중분류` from (`발주상품` `a` join `상품` `b`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `출고집계표`
--

/*!50001 DROP VIEW IF EXISTS `출고집계표`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `출고집계표` AS select `a`.`상품코드` AS `상품코드`,`a`.`상품이름` AS `상품이름`,`a`.`BOX입수` AS `BOX입수`,`a`.`발주개수` AS `발주량`,`b`.`출고개수` AS `출고량`,concat(floor((`b`.`출고개수` / `a`.`BOX입수`)),' BOX ',(`b`.`출고개수` % `a`.`BOX입수`)) AS `출고량BOX`,`c`.`미출량` AS `미출량`,`a`.`매가` AS `매가`,(`a`.`매가` * `b`.`출고개수`) AS `매가금액` from ((`발주상품뷰` `a` join `출고상품` `b`) join `미출상품` `c`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `현재이벤트상품`
--

/*!50001 DROP VIEW IF EXISTS `현재이벤트상품`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `현재이벤트상품` AS select `이벤트상품`.`이벤트코드` AS `이벤트코드`,`현재적용이벤트뷰`.`이벤트방식` AS `이벤트방식`,`이벤트상품`.`상품코드` AS `상품코드` from (`현재적용이벤트뷰` join `이벤트상품`) where (`현재적용이벤트뷰`.`이벤트코드` = `이벤트상품`.`이벤트코드`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `현재적용이벤트뷰`
--

/*!50001 DROP VIEW IF EXISTS `현재적용이벤트뷰`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `현재적용이벤트뷰` AS select `이벤트`.`이벤트코드` AS `이벤트코드`,`이벤트`.`이벤트방식` AS `이벤트방식`,`이벤트`.`할인가격` AS `할인가격`,`이벤트`.`이벤트시작날짜` AS `이벤트시작날짜`,`이벤트`.`이벤트종료날짜` AS `이벤트종료날짜` from `이벤트` where ((`이벤트`.`이벤트시작날짜` <= curdate()) and (`이벤트`.`이벤트종료날짜` >= curdate())) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-07  9:08:47
