-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: kupi_proday
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `actuality_advertisement`
--

DROP TABLE IF EXISTS `actuality_advertisement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actuality_advertisement` (
  `id_actuality_advertisement` int NOT NULL AUTO_INCREMENT,
  `type` enum('Активно','Удалено','Заблакировано') NOT NULL COMMENT 'атуальность - активно,удалено, блокировано',
  `reason_for_blocking` text COMMENT 'Причина блокировки',
  PRIMARY KEY (`id_actuality_advertisement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='актуальность объявления';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actuality_advertisement`
--

LOCK TABLES `actuality_advertisement` WRITE;
/*!40000 ALTER TABLE `actuality_advertisement` DISABLE KEYS */;
/*!40000 ALTER TABLE `actuality_advertisement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adress`
--

DROP TABLE IF EXISTS `adress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adress` (
  `id_adress` int NOT NULL AUTO_INCREMENT,
  `cantry_id` int NOT NULL COMMENT 'страна',
  `city_id` int NOT NULL COMMENT 'город',
  `index_adress` varchar(20) DEFAULT NULL COMMENT 'индекс',
  `street` varchar(45) DEFAULT NULL COMMENT 'улица',
  `house` varchar(6) DEFAULT NULL COMMENT 'дом',
  `house_2` varchar(3) DEFAULT NULL COMMENT 'строение , корпус',
  `flat` varchar(6) DEFAULT NULL COMMENT 'номер квартиры',
  PRIMARY KEY (`id_adress`),
  KEY `fk_cantry_adress_idx` (`cantry_id`),
  KEY `fk_city_adress_idx` (`city_id`),
  CONSTRAINT `fk_cantry_adress` FOREIGN KEY (`cantry_id`) REFERENCES `cantry` (`id_Cantry`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_city_adress` FOREIGN KEY (`city_id`) REFERENCES `city` (`id City`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Адрес\\n    house_2 - корпус';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adress`
--

LOCK TABLES `adress` WRITE;
/*!40000 ALTER TABLE `adress` DISABLE KEYS */;
/*!40000 ALTER TABLE `adress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertisement`
--

DROP TABLE IF EXISTS `advertisement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertisement` (
  `id_advertisement` int NOT NULL AUTO_INCREMENT,
  `type_advertisement_id` int NOT NULL COMMENT 'тип объявления',
  `body_advertisement` text NOT NULL COMMENT 'тело объявления',
  `create_advertisementcol` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания',
  `update_advertisement` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата обновления',
  `delete_advertisement` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'дата удаления',
  `actuality_advertisement_id` int NOT NULL DEFAULT '1' COMMENT 'актуальность - актуально,удалено,заблокировано',
  `paid_or_not_advertisement_id` int NOT NULL DEFAULT '0' COMMENT 'платное-(1 и выше) или нет-0',
  `new_or_non-new` bit(1) NOT NULL DEFAULT b'1' COMMENT 'новое -1 или бу -0',
  `user_id` int NOT NULL,
  PRIMARY KEY (`id_advertisement`),
  KEY `fk_type_advert_advert_idx` (`type_advertisement_id`),
  KEY `fk_actuality_advert_advert_idx` (`actuality_advertisement_id`),
  KEY `fk_paid_or_not_advert_advert_idx` (`paid_or_not_advertisement_id`),
  KEY `fk_user_advert_idx` (`user_id`),
  CONSTRAINT `fk_actuality_advert_advert` FOREIGN KEY (`actuality_advertisement_id`) REFERENCES `actuality_advertisement` (`id_actuality_advertisement`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_paid_or_not_advert_advert` FOREIGN KEY (`paid_or_not_advertisement_id`) REFERENCES `paid_or_not-paid` (`id_paid_or_not-paid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_type_advert_advert` FOREIGN KEY (`type_advertisement_id`) REFERENCES `type_adverrtisement` (`id_type_adverrtisement`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_advert` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Объявления';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisement`
--

LOCK TABLES `advertisement` WRITE;
/*!40000 ALTER TABLE `advertisement` DISABLE KEYS */;
/*!40000 ALTER TABLE `advertisement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cantry`
--

DROP TABLE IF EXISTS `cantry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cantry` (
  `id_Cantry` int NOT NULL AUTO_INCREMENT,
  `name` enum('Россия','Казахстан','США','Африка') COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id_Cantry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Страна';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cantry`
--

LOCK TABLES `cantry` WRITE;
/*!40000 ALTER TABLE `cantry` DISABLE KEYS */;
/*!40000 ALTER TABLE `cantry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id City` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id City`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Населеный пункт';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_advertisement`
--

DROP TABLE IF EXISTS `media_advertisement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_advertisement` (
  `id_media_advertisement` int NOT NULL AUTO_INCREMENT,
  `media_type_id` int NOT NULL COMMENT 'тип медиа',
  `file_name` varchar(255) NOT NULL COMMENT 'имя файла',
  `metadate` json DEFAULT NULL COMMENT 'метаданные',
  `creatdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'создание',
  `update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'обновление',
  `number_media_advertisementcol` int NOT NULL COMMENT 'номер медиа',
  `user_id` int NOT NULL,
  `adverttisemetn_id` int NOT NULL,
  PRIMARY KEY (`id_media_advertisement`),
  KEY `fk_media_type_media_advert_idx` (`media_type_id`),
  KEY `fk_user_media_advert_idx` (`user_id`),
  KEY `fk_advert_media_advert_idx` (`adverttisemetn_id`),
  CONSTRAINT `fk_advert_media_advert` FOREIGN KEY (`adverttisemetn_id`) REFERENCES `advertisement` (`id_advertisement`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_media_type_media_advert` FOREIGN KEY (`media_type_id`) REFERENCES `media_type` (`id media_type`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_media_advert` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_advertisement`
--

LOCK TABLES `media_advertisement` WRITE;
/*!40000 ALTER TABLE `media_advertisement` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_advertisement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type`
--

DROP TABLE IF EXISTS `media_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_type` (
  `id media_type` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id media_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='тип медиафайла';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type`
--

LOCK TABLES `media_type` WRITE;
/*!40000 ALTER TABLE `media_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paid_or_not-paid`
--

DROP TABLE IF EXISTS `paid_or_not-paid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paid_or_not-paid` (
  `id_paid_or_not-paid` int NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL COMMENT 'что делать в случае платного объявления',
  PRIMARY KEY (`id_paid_or_not-paid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='платное или нет';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paid_or_not-paid`
--

LOCK TABLES `paid_or_not-paid` WRITE;
/*!40000 ALTER TABLE `paid_or_not-paid` DISABLE KEYS */;
/*!40000 ALTER TABLE `paid_or_not-paid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone`
--

DROP TABLE IF EXISTS `phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone` (
  `id Phone` int NOT NULL AUTO_INCREMENT,
  `cod_1` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `cod_2` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `phone_number` varchar(7) COLLATE utf8_bin DEFAULT NULL,
  `full_phone_number` varchar(17) COLLATE utf8_bin DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `serial_phone_number` int DEFAULT NULL,
  PRIMARY KEY (`id Phone`),
  KEY `fk_user_phone_idx` (`user_id`),
  CONSTRAINT `fk_user_phone` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Телефон\ncod_1 - код страны\ncod_2 - код города, мобильного оператора или чего-нибудь еще\nphone_number -номер телефона\nfull_phone_number - Полный номер телефона содержит в себе информацию столбцов БД MySQL Код1, Код2 и Номер телефона. Этот столбец существенно упростит проверку на дублирующиеся номера. Тип и размер данных в нем высчитывается на основании колонок Код1, Код2 и Номер телефона.\nserial_phone_number - порядковый номер телефона(если телефонов много)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone`
--

LOCK TABLES `phone` WRITE;
/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_adverrtisement`
--

DROP TABLE IF EXISTS `type_adverrtisement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_adverrtisement` (
  `id_type_adverrtisement` int NOT NULL AUTO_INCREMENT,
  `product_category` enum('Услуги','Электрика','Пиломатериалы','Сантехника','Разное') DEFAULT NULL COMMENT 'категория товаров',
  `type_adverrt` bit(1) NOT NULL DEFAULT b'1' COMMENT 'тип1-товары 0-услуги',
  `service_category` set('Разное','Электрик','Сантехник','Репетитор','Водитель') DEFAULT NULL,
  PRIMARY KEY (`id_type_adverrtisement`),
  UNIQUE KEY `id_type_adverrtisement_UNIQUE` (`id_type_adverrtisement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='тип объявления(услуги,категории товаров)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_adverrtisement`
--

LOCK TABLES `type_adverrtisement` WRITE;
/*!40000 ALTER TABLE `type_adverrtisement` DISABLE KEYS */;
/*!40000 ALTER TABLE `type_adverrtisement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_of_organization`
--

DROP TABLE IF EXISTS `type_of_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_of_organization` (
  `id_type_of_organization` int NOT NULL AUTO_INCREMENT,
  `type` enum('Частник','ООО','ЗАО','ИП') COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id_type_of_organization`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Тип организвции (ООО,частник,ип)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_of_organization`
--

LOCK TABLES `type_of_organization` WRITE;
/*!40000 ALTER TABLE `type_of_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `type_of_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_user` bit(1) NOT NULL DEFAULT b'0' COMMENT 'тип юзера 0-покупатель 1-продавец',
  `surname` varchar(60) DEFAULT NULL COMMENT 'фамилия',
  `name` varchar(40) NOT NULL COMMENT 'имя',
  `lastname` varchar(45) DEFAULT NULL COMMENT 'отчество',
  `phone_id` int DEFAULT NULL COMMENT 'телефон',
  `email` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `password` varchar(12) NOT NULL COMMENT 'пароль',
  `adress_id` int DEFAULT NULL COMMENT 'адрес',
  `type_of_organizations_id` int DEFAULT NULL COMMENT 'тип организации',
  `creat_data` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'создание',
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'обновление',
  `delete_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'удаленеи',
  `advertisement_id` int NOT NULL COMMENT 'id объявления',
  `number_advertisment` int NOT NULL COMMENT 'номер объявления',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_phone_user_idx` (`phone_id`),
  KEY `fk_adress_user_idx` (`adress_id`),
  KEY `fk_type_of_organizations_user_idx` (`type_of_organizations_id`),
  KEY `fk_advertisement_user_idx` (`advertisement_id`),
  CONSTRAINT `fk_adress_user` FOREIGN KEY (`adress_id`) REFERENCES `adress` (`id_adress`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_advertisement_user` FOREIGN KEY (`advertisement_id`) REFERENCES `advertisement` (`id_advertisement`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_phone_user` FOREIGN KEY (`phone_id`) REFERENCES `phone` (`id Phone`),
  CONSTRAINT `fk_type_of_organizations_user` FOREIGN KEY (`type_of_organizations_id`) REFERENCES `type_of_organization` (`id_type_of_organization`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Пользователь\n 0 - buyer (покупатель)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-27 22:05:11
