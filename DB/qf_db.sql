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
-- Table structure for table `answer_values`
--

DROP TABLE IF EXISTS `answer_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer_values` (
  `answer_id` bigint NOT NULL,
  `answer_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `question_id` bigint NOT NULL,
  PRIMARY KEY (`answer_id`,`question_id`),
  CONSTRAINT `FK4gsk2rrswy3placdpb5t313rk` FOREIGN KEY (`answer_id`) REFERENCES `answers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_values`
--

LOCK TABLES `answer_values` WRITE;
/*!40000 ALTER TABLE `answer_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `answer_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `completed` bit(1) DEFAULT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `questionnaire_id` bigint DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_answers`
--

DROP TABLE IF EXISTS `question_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_answers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `response_id` bigint DEFAULT NULL,
  `question_id` bigint DEFAULT NULL,
  `answer_value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_answers`
--

LOCK TABLES `question_answers` WRITE;
/*!40000 ALTER TABLE `question_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_options`
--

DROP TABLE IF EXISTS `question_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_options` (
  `question_id` bigint NOT NULL,
  `option_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  KEY `FKsb9v00wdrgc9qojtjkv7e1gkp` (`question_id`),
  CONSTRAINT `FKsb9v00wdrgc9qojtjkv7e1gkp` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_options`
--

LOCK TABLES `question_options` WRITE;
/*!40000 ALTER TABLE `question_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_options`
--

DROP TABLE IF EXISTS `questionnaire_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint unsigned NOT NULL,
  `choices` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max` int DEFAULT NULL,
  `choice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `questionnaire_options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questionnaire_questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_options`
--

LOCK TABLES `questionnaire_options` WRITE;
/*!40000 ALTER TABLE `questionnaire_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionnaire_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_question_options`
--

DROP TABLE IF EXISTS `questionnaire_question_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_question_options` (
  `questionnaire_question_id` bigint NOT NULL,
  `options` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `options_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`questionnaire_question_id`,`options_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_question_options`
--

LOCK TABLES `questionnaire_question_options` WRITE;
/*!40000 ALTER TABLE `questionnaire_question_options` DISABLE KEYS */;
INSERT INTO `questionnaire_question_options` VALUES (1690,'{\"0\":\"Very Satisfied\",\"1\":\"Satisfied\",\"2\":\"00\",\"3\":\"Dissatisfied\"}','choices'),(1803,'{\"0\":\"選項1\",\"1\":\"選項2\"}','choices'),(1804,'{\"0\":\"選項1\",\"1\":\"選項2\"}','choices'),(1805,'{\"0\":\"選項1\",\"1\":\"選項2\"}','choices'),(1817,'{\"0\":\"選項1\",\"1\":\"選項3\"}','choices'),(1820,'{}','choices'),(1821,'{\"0\":\"選項1\",\"1\":\"選項2\"}','choices'),(1822,'{\"0\":\"選項1\",\"1\":\"選項2\"}','choices'),(1823,'{}','choices'),(1824,'{}','choices'),(1825,'{}','choices'),(1826,'{\"0\":\"選項1\",\"1\":\"選項2\",\"2\":\"選項3\"}','choices'),(1827,'{\"0\":\"選項1\",\"1\":\"選項2\",\"2\":\"選項3\"}','choices'),(1828,'{\"0\":\"選項1\",\"1\":\"選項2\",\"2\":\"選項3\"}','choices'),(1829,'{}','choices'),(1830,'{}','choices'),(1831,'{}','choices'),(1861,'{}','choices'),(1862,'{}','choices'),(1863,'{\"0\":\"選項1\",\"1\":\"選項2\"}','choices'),(1894,'{}','choices'),(1895,'{\"0\":\"選項1\",\"1\":\"選項2\"}','choices');
/*!40000 ALTER TABLE `questionnaire_question_options` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_questions`
--

LOCK TABLES `questionnaire_questions` WRITE;
/*!40000 ALTER TABLE `questionnaire_questions` DISABLE KEYS */;
INSERT INTO `questionnaire_questions` VALUES (1958,2135,'姓名','short-text',1,'{\"placeholder\":\"\"}'),(1959,2135,'電子郵件','email',1,'{\"placeholder\":\"\"}'),(1960,2135,'聯繫電話','phone',1,'{\"placeholder\":\"\"}'),(1961,2135,'參加場次','radio',1,'{\"choices\":{\"0\":\"選項1\",\"1\":\"選項2\"}}'),(1962,2135,'飲食偏好','checkbox',0,'{\"choices\":{\"0\":\"選項1\",\"1\":\"選項2\"}}'),(1963,2135,'TEST','rating',0,'{\"choices\":{\"1\":\"非常不滿意\",\"2\":\"不滿意\",\"3\":\"一般\",\"4\":\"滿意\",\"5\":\"非常滿意\"}}'),(1964,2135,'下拉','select',0,'{\"choices\":{\"0\":\"選項1\",\"1\":\"選項2\"}}'),(2154,2215,'姓名','short-text',1,NULL),(2155,2215,'年齡','number',0,NULL),(2156,2215,'性別','radio',0,'{\"choices\":{\"M\":\"男\",\"F\":\"女\",\"O\":\"其他\"}}'),(2157,2216,'商品品質','rating',1,'{\"max\":5}'),(2158,2216,'價格合理性','rating',1,'{\"max\":5}'),(2159,2216,'店員服務態度','rating',1,'{\"max\":5}'),(2160,2217,'請提供您的建議','long-text',0,'{\"placeholder\":\"寫下您的想法...\"}'),(2168,2221,'姓名','short-text',1,NULL),(2169,2221,'電子郵件','email',1,NULL),(2170,2221,'職業','short-text',0,NULL),(2171,2222,'請選擇您要報名的課程','checkbox',1,'{\"choices\":{\"1\":\"Python 基礎班\",\"2\":\"Web 開發入門\",\"3\":\"AI 與機器學習\",\"4\":\"數據分析\"}}'),(2172,2223,'選擇題分數','number',1,'{\"min\":0,\"max\":100}'),(2173,2223,'程式設計題分數','number',1,'{\"min\":0,\"max\":100}'),(2174,2224,'老師對學生的評語','long-text',0,'{\"placeholder\":\"請輸入評語...\"}'),(2175,2225,'客戶姓名','short-text',1,NULL),(2176,2225,'聯繫電話','phone',1,NULL),(2177,2225,'送貨地址','short-text',1,NULL),(2178,2226,'選擇商品','checkbox',1,'{\"choices\":{\"1\":\"筆記本電腦\",\"2\":\"無線耳機\",\"3\":\"手機支架\"}}'),(2179,2227,'請選擇支付方式','radio',1,'{\"choices\":{\"credit_card\":\"信用卡\",\"paypal\":\"PayPal\",\"bank_transfer\":\"銀行轉帳\"}}'),(2194,2232,'姓名','short-text',1,'{\"placeholder\":\"\"}'),(2195,2232,'電子郵件','email',1,'{\"placeholder\":\"\"}'),(2196,2232,'聯繫電話','phone',1,'{\"placeholder\":\"\"}'),(2197,2232,'參加場次','radio',1,'{\"choices\":{\"1\":\"上午場 (9:00-12:00)\",\"2\":\"下午場 (14:00-17:00)\"}}'),(2198,2232,'飲食偏好','checkbox',0,'{\"choices\":{\"1\":\"素食\",\"2\":\"不含海鮮\",\"3\":\"不含花生\"}}');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_responses`
--

LOCK TABLES `questionnaire_responses` WRITE;
/*!40000 ALTER TABLE `questionnaire_responses` DISABLE KEYS */;
INSERT INTO `questionnaire_responses` VALUES (1,72,'[{\"answerValue\":\"4444\"},{\"answerValue\":\"4444@11\"},{\"answerValue\":\"1111\"},{\"answerValue\":\"0\"},{\"answerValue\":\"0\"},{\"answerValue\":\"5\"},{\"answerValue\":\"1\"}]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36','2025-02-13 12:55:38'),(2,72,'[{\"answerValue\":\"1111\"},{\"answerValue\":\"11111@111\"},{\"answerValue\":\"1111\"},{\"answerValue\":\"0\"},{\"answerValue\":\"0\"},{\"answerValue\":\"3\"},{\"answerValue\":\"1\"}]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36','2025-02-13 13:17:55'),(3,72,'[{\"answerValue\":\"6666\"},{\"answerValue\":\"6666@6666\"},{\"answerValue\":\"6666\"},{\"answerValue\":\"0\"},{\"answerValue\":\"0\"},{\"answerValue\":\"5\"},{\"answerValue\":\"1\"}]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36','2025-02-13 14:49:43'),(4,72,'[{\"answerValue\":\"4444\"},{\"answerValue\":\"4444@55\"},{\"answerValue\":\"4444\"},{\"answerValue\":\"0\"},{\"answerValue\":\"0\"},{\"answerValue\":\"2\"},{\"answerValue\":\"1\"}]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36','2025-02-13 14:50:20'),(5,72,'[{\"answerValue\":\"6666\"},{\"answerValue\":\"6666@6\"},{\"answerValue\":\"6666\"},{\"answerValue\":\"0\"},{\"answerValue\":\"0\"},{\"answerValue\":\"5\"},{\"answerValue\":\"1\"}]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36','2025-02-13 15:18:25'),(6,72,'[{\"answerValue\":\"444\"},{\"answerValue\":\"444@11\"},{\"answerValue\":\"1111\"},{\"answerValue\":\"0\"},{\"answerValue\":\"0\"},{\"answerValue\":\"1\"},{\"answerValue\":\"1\"}]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36','2025-02-13 15:18:59'),(8,72,'[{\"answerValue\":\"黃國昌\"},{\"answerValue\":\"1629@AAAA.com\"},{\"answerValue\":\"0985555555\"},{\"answerValue\":\"1\"},{\"answerValue\":\"0\"},{\"answerValue\":\"1\"},{\"answerValue\":\"1\"}]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36','2025-03-29 16:22:57'),(9,80,'[{\"answerValue\":\"222\"},{\"answerValue\":\"222@22\"},{\"answerValue\":\"222\"},{\"answerValue\":\"1\"},{\"answerValue\":\"1\"}]','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36','2025-03-29 16:34:18');
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
) ENGINE=InnoDB AUTO_INCREMENT=2233 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_sections`
--

LOCK TABLES `questionnaire_sections` WRITE;
/*!40000 ALTER TABLE `questionnaire_sections` DISABLE KEYS */;
INSERT INTO `questionnaire_sections` VALUES (2135,72,'參與者信息','text'),(2215,93,'個人信息','text'),(2216,93,'購物體驗','rating'),(2217,93,'額外意見','text'),(2221,95,'學員信息','text'),(2222,95,'選擇課程','checkbox'),(2223,96,'考試成績','rating'),(2224,96,'教師評語','text'),(2225,97,'客戶資訊','text'),(2226,97,'訂單詳情','checkbox'),(2227,97,'支付方式','radio'),(2232,80,'參與者信息','text');
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
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaires`
--

LOCK TABLES `questionnaires` WRITE;
/*!40000 ALTER TABLE `questionnaires` DISABLE KEYS */;
INSERT INTO `questionnaires` VALUES (72,'活動報名表','','PUBLISHED',7,'2025-02-12 22:55:52',NULL,_binary '\0',NULL,NULL),(80,'活動報名表','','CLOSED',1,'2025-03-29 16:29:54',NULL,_binary '\0',NULL,NULL),(93,'顧客意見調查','收集顧客對我們商店的評價','DRAFT',0,'2025-03-30 08:58:06',NULL,_binary '\0',NULL,NULL),(95,'線上課程報名','報名參加我們的免費線上課程','DRAFT',0,'2025-03-30 09:01:06',NULL,_binary '\0',NULL,NULL),(96,'線上考試評分表','測驗學生的表現並評分','DRAFT',0,'2025-03-30 09:01:38',NULL,_binary '\0',NULL,NULL),(97,'訂單管理','管理客戶的訂單資訊','DRAFT',0,'2025-03-30 09:01:44',NULL,_binary '\0',NULL,NULL);
/*!40000 ALTER TABLE `questionnaires` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_length` int DEFAULT NULL,
  `max_rating` int DEFAULT NULL,
  `min_length` int DEFAULT NULL,
  `min_rating` int DEFAULT NULL,
  `order_index` int DEFAULT NULL,
  `placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `questionnaire_id` bigint DEFAULT NULL,
  `rating_step` int DEFAULT NULL,
  `required` bit(1) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
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

-- Dump completed on 2025-03-30  9:07:31
