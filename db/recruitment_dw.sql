CREATE DATABASE  IF NOT EXISTS `recruitment_dw` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `recruitment_dw`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: recruitment_dw
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `dim_candidate`
--

DROP TABLE IF EXISTS `dim_candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_candidate` (
  `candidate_key` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(250) NOT NULL,
  PRIMARY KEY (`candidate_key`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_candidate`
--

LOCK TABLES `dim_candidate` WRITE;
/*!40000 ALTER TABLE `dim_candidate` DISABLE KEYS */;
/*!40000 ALTER TABLE `dim_candidate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_country`
--

DROP TABLE IF EXISTS `dim_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_country` (
  `country_key` int NOT NULL AUTO_INCREMENT,
  `country` varchar(150) NOT NULL,
  PRIMARY KEY (`country_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_country`
--

LOCK TABLES `dim_country` WRITE;
/*!40000 ALTER TABLE `dim_country` DISABLE KEYS */;
/*!40000 ALTER TABLE `dim_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_date`
--

DROP TABLE IF EXISTS `dim_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_date` (
  `date_key` int NOT NULL,
  `month` int NOT NULL,
  `day` int NOT NULL,
  `year` int NOT NULL,
  `full_date` date NOT NULL,
  PRIMARY KEY (`date_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_date`
--

LOCK TABLES `dim_date` WRITE;
/*!40000 ALTER TABLE `dim_date` DISABLE KEYS */;
/*!40000 ALTER TABLE `dim_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_seniority`
--

DROP TABLE IF EXISTS `dim_seniority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_seniority` (
  `seniority_key` int NOT NULL AUTO_INCREMENT,
  `seniority` varchar(100) NOT NULL,
  PRIMARY KEY (`seniority_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_seniority`
--

LOCK TABLES `dim_seniority` WRITE;
/*!40000 ALTER TABLE `dim_seniority` DISABLE KEYS */;
/*!40000 ALTER TABLE `dim_seniority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_technology`
--

DROP TABLE IF EXISTS `dim_technology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_technology` (
  `technology_key` int NOT NULL AUTO_INCREMENT,
  `technology` varchar(45) NOT NULL,
  PRIMARY KEY (`technology_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_technology`
--

LOCK TABLES `dim_technology` WRITE;
/*!40000 ALTER TABLE `dim_technology` DISABLE KEYS */;
/*!40000 ALTER TABLE `dim_technology` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fact_application`
--

DROP TABLE IF EXISTS `fact_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_application` (
  `application_key` int NOT NULL AUTO_INCREMENT,
  `code_challenge_score` int NOT NULL,
  `technical_interview_score` int NOT NULL,
  `yoe` int NOT NULL,
  `hired_flag` tinyint(1) NOT NULL DEFAULT '0',
  `country_key` int NOT NULL,
  `candidate_key` int NOT NULL,
  `technology_key` int NOT NULL,
  `seniority_key` int NOT NULL,
  `date_key` int NOT NULL,
  PRIMARY KEY (`application_key`),
  KEY `fk_fact_application_dim_country_idx` (`country_key`),
  KEY `fk_fact_application_dim_candidate1_idx` (`candidate_key`),
  KEY `fk_fact_application_dim_technology1_idx` (`technology_key`),
  KEY `fk_fact_application_dim_seniority1_idx` (`seniority_key`),
  KEY `fk_fact_application_dim_date1_idx` (`date_key`),
  CONSTRAINT `fk_fact_application_dim_candidate1` FOREIGN KEY (`candidate_key`) REFERENCES `dim_candidate` (`candidate_key`),
  CONSTRAINT `fk_fact_application_dim_country` FOREIGN KEY (`country_key`) REFERENCES `dim_country` (`country_key`),
  CONSTRAINT `fk_fact_application_dim_date1` FOREIGN KEY (`date_key`) REFERENCES `dim_date` (`date_key`),
  CONSTRAINT `fk_fact_application_dim_seniority1` FOREIGN KEY (`seniority_key`) REFERENCES `dim_seniority` (`seniority_key`),
  CONSTRAINT `fk_fact_application_dim_technology1` FOREIGN KEY (`technology_key`) REFERENCES `dim_technology` (`technology_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fact_application`
--

LOCK TABLES `fact_application` WRITE;
/*!40000 ALTER TABLE `fact_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `fact_application` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-21 18:27:51
