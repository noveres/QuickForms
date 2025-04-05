CREATE DATABASE  IF NOT EXISTS `quickforms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `quickforms`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: quickforms
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `questionnaire_questions`
--

DROP TABLE IF EXISTS `questionnaire_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_questions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `section_id` bigint unsigned NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `options` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `section_id` (`section_id`),
  CONSTRAINT `questionnaire_questions_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `questionnaire_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_questions`
--

LOCK TABLES `questionnaire_questions` WRITE;
/*!40000 ALTER TABLE `questionnaire_questions` DISABLE KEYS */;
INSERT INTO `questionnaire_questions` VALUES (2168,2221,'姓名','short-text',1,NULL),(2169,2221,'電子郵件','email',1,NULL),(2170,2221,'職業','short-text',0,NULL),(2171,2222,'請選擇您要報名的課程','checkbox',1,'{\"choices\":{\"1\":\"Python 基礎班\",\"2\":\"Web 開發入門\",\"3\":\"AI 與機器學習\",\"4\":\"數據分析\"}}'),(2172,2223,'選擇題分數','number',1,'{\"min\":0,\"max\":100}'),(2173,2223,'程式設計題分數','number',1,'{\"min\":0,\"max\":100}'),(2174,2224,'老師對學生的評語','long-text',0,'{\"placeholder\":\"請輸入評語...\"}'),(2175,2225,'客戶姓名','short-text',1,NULL),(2176,2225,'聯繫電話','phone',1,NULL),(2177,2225,'送貨地址','short-text',1,NULL),(2178,2226,'選擇商品','checkbox',1,'{\"choices\":{\"1\":\"筆記本電腦\",\"2\":\"無線耳機\",\"3\":\"手機支架\"}}'),(2179,2227,'請選擇支付方式','radio',1,'{\"choices\":{\"credit_card\":\"信用卡\",\"paypal\":\"PayPal\",\"bank_transfer\":\"銀行轉帳\"}}'),(2206,2236,'姓名','short-text',1,'{}'),(2207,2236,'年齡','number',0,'{}'),(2208,2236,'性別','radio',0,'{\"choices\":{\"M\":\"男\",\"F\":\"女\",\"O\":\"其他\"}}'),(2209,2237,'商品品質','rating',1,'{\"max\":5}'),(2210,2237,'價格合理性','rating',1,'{\"max\":5}'),(2211,2237,'店員服務態度','rating',1,'{\"max\":5}'),(2212,2238,'請提供您的建議','long-text',0,'{\"placeholder\":\"寫下您的想法...\"}'),(2246,2253,'姓名','short-text',1,'{\"placeholder\":\"\"}'),(2247,2253,'電子郵件','email',1,'{\"placeholder\":\"\"}'),(2248,2253,'聯繫電話','phone',0,'{\"placeholder\":\"\"}'),(2249,2254,'產品質量滿意度','rating',1,'{\"choices\":{\"1\":\"非常不滿意\",\"2\":\"不滿意\",\"3\":\"一般\",\"4\":\"滿意\",\"5\":\"非常滿意\"}}'),(2250,2254,'服務態度滿意度','rating',1,'{\"choices\":{\"1\":\"非常不滿意\",\"2\":\"不滿意\",\"3\":\"一般\",\"4\":\"滿意\",\"5\":\"非常滿意\"}}'),(2251,2255,'您對我們的產品或服務有什麼建議？','long-text',0,'{\"placeholder\":\"請輸入您的建議...\"}');
/*!40000 ALTER TABLE `questionnaire_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_responses`
--

DROP TABLE IF EXISTS `questionnaire_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_responses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint unsigned NOT NULL,
  `answers` text COLLATE utf8mb4_unicode_ci,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaire_id` (`questionnaire_id`),
  CONSTRAINT `questionnaire_responses_ibfk_1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_responses`
--

LOCK TABLES `questionnaire_responses` WRITE;
/*!40000 ALTER TABLE `questionnaire_responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionnaire_responses` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = gbk */ ;
/*!50003 SET character_set_results = gbk */ ;
/*!50003 SET collation_connection  = gbk_chinese_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_response_insert` AFTER INSERT ON `questionnaire_responses` FOR EACH ROW BEGIN
    UPDATE questionnaires
    SET response_count = response_count + 1
    WHERE id = NEW.questionnaire_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = gbk */ ;
/*!50003 SET character_set_results = gbk */ ;
/*!50003 SET collation_connection  = gbk_chinese_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_response_update` AFTER UPDATE ON `questionnaire_responses` FOR EACH ROW BEGIN
    
    UPDATE questionnaires
    SET response_count = response_count - 1
    WHERE id = OLD.questionnaire_id;

    
    UPDATE questionnaires
    SET response_count = response_count + 1
    WHERE id = NEW.questionnaire_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = gbk */ ;
/*!50003 SET character_set_results = gbk */ ;
/*!50003 SET collation_connection  = gbk_chinese_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_response_delete` AFTER DELETE ON `questionnaire_responses` FOR EACH ROW BEGIN
    UPDATE questionnaires
    SET response_count = response_count - 1
    WHERE id = OLD.questionnaire_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `questionnaire_sections`
--

DROP TABLE IF EXISTS `questionnaire_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_sections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `questionnaire_id` bigint unsigned NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaire_sections_ibfk_1` (`questionnaire_id`),
  CONSTRAINT `questionnaire_sections_ibfk_1` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2258 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_sections`
--

LOCK TABLES `questionnaire_sections` WRITE;
/*!40000 ALTER TABLE `questionnaire_sections` DISABLE KEYS */;
INSERT INTO `questionnaire_sections` VALUES (2221,95,'學員信息','text'),(2222,95,'選擇課程','checkbox'),(2223,96,'考試成績','rating'),(2224,96,'教師評語','text'),(2225,97,'客戶資訊','text'),(2226,97,'訂單詳情','checkbox'),(2227,97,'支付方式','radio'),(2236,93,'個人信息','text'),(2237,93,'購物體驗','rating'),(2238,93,'額外意見','text'),(2253,101,'基本信息','text'),(2254,101,'評分項目','rating'),(2255,101,'詳細反饋','text');
/*!40000 ALTER TABLE `questionnaire_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaires`
--

DROP TABLE IF EXISTS `questionnaires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaires` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '未命名問卷',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PUBLISHED',
  `response_count` bigint NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime(6) DEFAULT NULL,
  `published` bit(1) NOT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaires`
--

LOCK TABLES `questionnaires` WRITE;
/*!40000 ALTER TABLE `questionnaires` DISABLE KEYS */;
INSERT INTO `questionnaires` VALUES (93,'顧客意見調查','收集顧客對我們商店的評價','DRAFT',0,'2025-03-30 08:58:06',NULL,_binary '\0',NULL,NULL),(95,'線上課程報名','報名參加我們的免費線上課程','DRAFT',0,'2025-03-30 09:01:06',NULL,_binary '\0',NULL,NULL),(96,'線上考試評分表','測驗學生的表現並評分','DRAFT',0,'2025-03-30 09:01:38',NULL,_binary '\0',NULL,NULL),(97,'訂單管理','管理客戶的訂單資訊','DRAFT',0,'2025-03-30 09:01:44',NULL,_binary '\0',NULL,NULL),(101,'客戶滿意度調查 (複製)','','DRAFT',0,'2025-04-05 18:41:26',NULL,_binary '\0',NULL,NULL);
/*!40000 ALTER TABLE `questionnaires` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'quickforms'
--

--
-- Dumping routines for database 'quickforms'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-05 19:29:20
