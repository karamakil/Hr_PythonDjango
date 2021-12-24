-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: hr
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Employee');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add employee',1,'add_employee'),(2,'Can change employee',1,'change_employee'),(3,'Can delete employee',1,'delete_employee'),(4,'Can view employee',1,'view_employee'),(5,'Can add attendance',2,'add_attendance'),(6,'Can change attendance',2,'change_attendance'),(7,'Can delete attendance',2,'delete_attendance'),(8,'Can view attendance',2,'view_attendance'),(9,'Can add log entry',3,'add_logentry'),(10,'Can change log entry',3,'change_logentry'),(11,'Can delete log entry',3,'delete_logentry'),(12,'Can view log entry',3,'view_logentry'),(13,'Can add permission',4,'add_permission'),(14,'Can change permission',4,'change_permission'),(15,'Can delete permission',4,'delete_permission'),(16,'Can view permission',4,'view_permission'),(17,'Can add group',5,'add_group'),(18,'Can change group',5,'change_group'),(19,'Can delete group',5,'delete_group'),(20,'Can view group',5,'view_group'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add content type',7,'add_contenttype'),(26,'Can change content type',7,'change_contenttype'),(27,'Can delete content type',7,'delete_contenttype'),(28,'Can view content type',7,'view_contenttype'),(29,'Can add session',8,'add_session'),(30,'Can change session',8,'change_session'),(31,'Can delete session',8,'delete_session'),(32,'Can view session',8,'view_session'),(33,'Can add vacation',9,'add_vacation'),(34,'Can change vacation',9,'change_vacation'),(35,'Can delete vacation',9,'delete_vacation'),(36,'Can view vacation',9,'view_vacation');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$320000$awFSdETPeHzutz2izER87c$P4SlwHOVZ9d2sPIZ2GW1+avNM1MOMOIywkqepG0sZiw=','2021-12-24 21:36:56.664319',1,'root','','','root@email.com',1,1,'2021-12-20 23:56:59.510224'),(2,'pbkdf2_sha256$320000$FyJNRwOs5jmb9ttPyOtmmE$Ex2daSdOumUuM9Dd8vfu+YV2b/MISnniGvjTtY8CCxY=','2021-12-24 22:19:33.802832',0,'karam','karam','akil','karamakil150@gmail.com',0,1,'2021-12-21 18:44:43.000000'),(6,'pbkdf2_sha256$320000$lUlBQqKe5t0bdvjmeVWh4x$Sv1MXe5Qnu4bqFGHZsAR9WRRew+a59m37jYAenh9VrY=','2021-12-24 21:57:44.316687',0,'ali','ali','last name','ali@email.com',0,1,'2021-12-24 09:06:21.000845');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2021-12-21 05:21:25.944201','1','Employee',1,'[{\"added\": {}}]',5,1),(2,'2021-12-21 18:44:43.915295','2','karam',1,'[{\"added\": {}}]',6,1),(3,'2021-12-24 08:19:22.024503','3','ali',1,'[{\"added\": {}}]',6,1),(4,'2021-12-24 08:40:58.569356','3','ali',2,'[{\"added\": {\"name\": \"employee\", \"object\": \"Employee object (2)\"}}]',6,1),(5,'2021-12-24 08:41:37.222979','3','ali',2,'[]',6,1),(6,'2021-12-24 08:49:24.802564','4','hussien',1,'[{\"added\": {}}]',6,1),(7,'2021-12-24 09:02:53.358164','5','mahdi',1,'[{\"added\": {}}, {\"added\": {\"name\": \"employee\", \"object\": \"Employee object (3)\"}}]',6,1),(8,'2021-12-24 09:03:29.052702','3','ali',2,'[]',6,1),(9,'2021-12-24 09:03:54.043866','3','ali',3,'',6,1),(10,'2021-12-24 09:04:04.628558','4','hussien',3,'',6,1),(11,'2021-12-24 09:04:16.922678','5','mahdi',3,'',6,1),(12,'2021-12-24 09:06:21.350910','6','ali',1,'[{\"added\": {}}, {\"added\": {\"name\": \"employee\", \"object\": \"Employee object (4)\"}}]',6,1),(13,'2021-12-24 21:37:41.104318','2','karam',2,'[{\"changed\": {\"name\": \"employee\", \"object\": \"Employee object (1)\", \"fields\": [\"Department\"]}}]',6,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (3,'admin','logentry'),(5,'auth','group'),(4,'auth','permission'),(6,'auth','user'),(7,'contenttypes','contenttype'),(2,'hrApplication','attendance'),(1,'hrApplication','employee'),(9,'hrApplication','vacation'),(8,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'hrApplication','0001_initial','2021-12-20 23:54:10.112211'),(2,'contenttypes','0001_initial','2021-12-20 23:56:30.651877'),(3,'auth','0001_initial','2021-12-20 23:56:32.676909'),(4,'admin','0001_initial','2021-12-20 23:56:33.367288'),(5,'admin','0002_logentry_remove_auto_add','2021-12-20 23:56:33.399128'),(6,'admin','0003_logentry_add_action_flag_choices','2021-12-20 23:56:33.428318'),(7,'contenttypes','0002_remove_content_type_name','2021-12-20 23:56:34.104490'),(8,'auth','0002_alter_permission_name_max_length','2021-12-20 23:56:34.264496'),(9,'auth','0003_alter_user_email_max_length','2021-12-20 23:56:34.316320'),(10,'auth','0004_alter_user_username_opts','2021-12-20 23:56:34.334732'),(11,'auth','0005_alter_user_last_login_null','2021-12-20 23:56:34.484901'),(12,'auth','0006_require_contenttypes_0002','2021-12-20 23:56:34.495322'),(13,'auth','0007_alter_validators_add_error_messages','2021-12-20 23:56:34.513852'),(14,'auth','0008_alter_user_username_max_length','2021-12-20 23:56:34.762285'),(15,'auth','0009_alter_user_last_name_max_length','2021-12-20 23:56:35.009007'),(16,'auth','0010_alter_group_name_max_length','2021-12-20 23:56:35.083927'),(17,'auth','0011_update_proxy_permissions','2021-12-20 23:56:35.111561'),(18,'auth','0012_alter_user_first_name_max_length','2021-12-20 23:56:35.280563'),(19,'sessions','0001_initial','2021-12-20 23:56:35.373750'),(20,'hrApplication','0002_remove_employee_email_remove_employee_first_name_and_more','2021-12-21 07:44:44.708082'),(21,'hrApplication','0003_employee_department','2021-12-21 21:42:04.266624'),(22,'hrApplication','0004_alter_attendance_checkout','2021-12-22 18:50:29.441117'),(23,'hrApplication','0005_vacation','2021-12-23 20:17:01.830397');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0gu8fizjfufh8sgnu213zt4jxechn6de','e30:1mzlXl:cY5AG9Fqb-wHFqW3KYpD9NRbPsHLHrIxNteRkKWrX4U','2022-01-04 20:15:29.940316'),('1ne15y20kxath2yaytrm8eo7tsw1yk08','.eJxVjMEOwiAQRP-FsyFAAReP3v0GsuxSqRpISnsy_rtt0oMeZ96beYuI61Li2vMcJxYXYcTpt0tIz1x3wA-s9yap1WWektwVedAub43z63q4fwcFe9nWyqNlhU5rcwbrR8PKOsMQVBpsCJY9AY0DaY0BtmQcZgakIXkEDyQ-X79AN3M:1mzlsd:zWArcXc0HRputWeH1Va6H-jBko-oVSByvCrh5HHzitI','2022-01-04 20:37:03.738821'),('6ua69c44p7m5m1pa28vzrqdyzzf3p4vc','.eJxVjMEOwiAQRP-FsyFAAReP3v0GsuxSqRpISnsy_rtt0oMeZ96beYuI61Li2vMcJxYXYcTpt0tIz1x3wA-s9yap1WWektwVedAub43z63q4fwcFe9nWyqNlhU5rcwbrR8PKOsMQVBpsCJY9AY0DaY0BtmQcZgakIXkEDyQ-X79AN3M:1n0suT:JtFuP-38mvTKYv5-RQz0zvq-CxKf0ksUWdJeJlMQa0k','2022-01-07 22:19:33.821781'),('7eo19b9t8x8jmv2kljwj32cf0bflqxza','e30:1mzlfq:vEcSophle28paoavfZXXkTL44qsMeGogLr3mhlQu4aE','2022-01-04 20:23:50.395610'),('agw5fbfss12ylr9vhp2y48lnl37hdgsv','.eJxVjMEOwiAQRP-FsyFAAReP3v0GsuxSqRpISnsy_rtt0oMeZ96beYuI61Li2vMcJxYXYcTpt0tIz1x3wA-s9yap1WWektwVedAub43z63q4fwcFe9nWyqNlhU5rcwbrR8PKOsMQVBpsCJY9AY0DaY0BtmQcZgakIXkEDyQ-X79AN3M:1mzmHu:ULbSNG3mZn59HMNFH981iOtn7wgvGZYv1wQzqL6fYXY','2022-01-04 21:03:10.521741'),('cmyaugpw68w8kzbxskkn63dh3awansp3','e30:1mzl7c:sKFodJLrd_z72WfetQJuhRT31oq_r0Fzsf1hPvuxjYw','2022-01-04 19:48:28.772378'),('d3oyvb9jgp447krigvh538ceu2rvhcmg','e30:1mzlYK:vc6OHwGzizz-0ntFbU0g0_WeDNGCZDNIHZtA080qysw','2022-01-04 20:16:04.019841'),('frby0euyxn4wfzc9oo98mpe6672jamcw','e30:1mzlds:VFpO6g6vnb2Gf6B5HRGAfcxLftgbGMQxdLm59PyxTfQ','2022-01-04 20:21:48.461218'),('h49qbsmgpmt9q4g89yd27vvxjc9fg463','e30:1mzlpM:2R4XCnxdVm_AJlxv1rt4bESj5iJ1vFJBVxd43bwFjRA','2022-01-04 20:33:40.751315'),('iqme8iru8earl1dhdit7el6ef8a9p1i2','.eJxVjMEOwiAQRP-FsyFAAReP3v0GsuxSqRpISnsy_rtt0oMeZ96beYuI61Li2vMcJxYXYcTpt0tIz1x3wA-s9yap1WWektwVedAub43z63q4fwcFe9nWyqNlhU5rcwbrR8PKOsMQVBpsCJY9AY0DaY0BtmQcZgakIXkEDyQ-X79AN3M:1mzmWg:so5V-OZ_8ibc72uQ_0aeBFTU-MAGueBQONvk_CT3-bo','2022-01-04 21:18:26.392020'),('j2f2o813ntq5ryixnj2sard3bswsqgxe','.eJxVjMEOwiAQRP-FsyFAAReP3v0GsuxSqRpISnsy_rtt0oMeZ96beYuI61Li2vMcJxYXYcTpt0tIz1x3wA-s9yap1WWektwVedAub43z63q4fwcFe9nWyqNlhU5rcwbrR8PKOsMQVBpsCJY9AY0DaY0BtmQcZgakIXkEDyQ-X79AN3M:1mzlTK:EwHBKFvZC4orLkF9qaRHZD9cMYCTc35W2Fyy3qq4BUo','2022-01-04 20:10:54.445689'),('kcd1uie1w16iexyycip9rlkjsh6cv0wy','e30:1mzlWf:9T7JMdqBVpG3LjxSXWJKIz3905renkxK1gIRBwtH63g','2022-01-04 20:14:21.834016'),('li6rs7mllwjh41cempdj9p1j6k07igck','.eJxVjMEOwiAQRP-FsyFAAReP3v0GsuxSqRpISnsy_rtt0oMeZ96beYuI61Li2vMcJxYXYcTpt0tIz1x3wA-s9yap1WWektwVedAub43z63q4fwcFe9nWyqNlhU5rcwbrR8PKOsMQVBpsCJY9AY0DaY0BtmQcZgakIXkEDyQ-X79AN3M:1mzmV6:F8jlNl1s3DuZT1ckjsllvk5Hm1Fo_1M3OrZ6t6LzBBs','2022-01-04 21:16:48.241812'),('pneuj6lqov607hj76huubzxl1731639v','e30:1mzlbY:FDnEYp32dFl_jDsgvu-RpXxFW7b0_Ay1VojG0IDSMwM','2022-01-04 20:19:24.123102'),('xwlo6mtodf7z0bel6cctonr2mv570r6n','e30:1mzli3:jlGiIqfeZDQR-4UPdQBdHF5vwrHTREzWa4rPJjI_1xs','2022-01-04 20:26:07.078737'),('ylt5zlzzg93tma77n2yxxpi1yeqz3hhg','.eJxVjMEOwiAQRP-FsyFAAReP3v0GsuxSqRpISnsy_rtt0oMeZ96beYuI61Li2vMcJxYXYcTpt0tIz1x3wA-s9yap1WWektwVedAub43z63q4fwcFe9nWyqNlhU5rcwbrR8PKOsMQVBpsCJY9AY0DaY0BtmQcZgakIXkEDyQ-X79AN3M:1mzmXO:StEZWN7qv2C9vejm5CEvR-IqtU9t_W4yXzjgrrzKJ2Y','2022-01-04 21:19:10.297272');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hrapplication_attendance`
--

DROP TABLE IF EXISTS `hrapplication_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hrapplication_attendance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `checkIn` datetime(6) NOT NULL,
  `checkOut` datetime(6) DEFAULT NULL,
  `employee_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hrApplication_attend_employee_id_6b9d361b_fk_hrApplica` (`employee_id`),
  CONSTRAINT `hrApplication_attend_employee_id_6b9d361b_fk_hrApplica` FOREIGN KEY (`employee_id`) REFERENCES `hrapplication_employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hrapplication_attendance`
--

LOCK TABLES `hrapplication_attendance` WRITE;
/*!40000 ALTER TABLE `hrapplication_attendance` DISABLE KEYS */;
INSERT INTO `hrapplication_attendance` VALUES (1,'2021-12-22 11:24:29.000000','2021-12-22 16:29:43.886580',1),(3,'2021-12-12 11:24:29.000000','2021-12-12 16:15:07.228187',1),(4,'2021-12-20 11:24:29.000000','2021-12-20 16:15:07.228187',1),(5,'2021-12-19 11:24:29.000000','2021-12-19 16:15:07.228187',1),(6,'2021-12-18 09:24:29.000000','2021-12-18 16:15:07.228187',1),(7,'2021-12-17 10:24:29.000000','2021-12-17 13:15:07.228187',1),(8,'2021-12-16 08:05:29.000000','2021-12-16 18:15:07.228187',1),(9,'2021-12-15 08:05:29.000000','2021-12-15 18:15:07.228187',1),(10,'2021-12-14 08:05:29.000000','2021-12-14 18:15:07.228187',1),(11,'2021-12-13 08:05:29.000000','2021-12-13 18:15:07.228187',1),(13,'2021-12-11 08:05:29.000000','2021-12-11 18:15:07.228187',1),(14,'2021-10-16 08:05:29.000000','2021-12-10 18:15:07.228187',1),(16,'2021-12-23 10:42:04.450309','2021-12-23 10:42:26.856240',1),(17,'2021-12-24 10:48:26.536555',NULL,1);
/*!40000 ALTER TABLE `hrapplication_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hrapplication_employee`
--

DROP TABLE IF EXISTS `hrapplication_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hrapplication_employee` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` int DEFAULT NULL,
  `title` varchar(128) NOT NULL,
  `user_id` int NOT NULL,
  `department` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `hrApplication_employee_user_id_64892377_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hrapplication_employee`
--

LOCK TABLES `hrapplication_employee` WRITE;
/*!40000 ALTER TABLE `hrapplication_employee` DISABLE KEYS */;
INSERT INTO `hrapplication_employee` VALUES (1,11111111,'software developer',2,'Software Development department'),(4,1234568,'accounting',6,'human resources');
/*!40000 ALTER TABLE `hrapplication_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hrapplication_vacation`
--

DROP TABLE IF EXISTS `hrapplication_vacation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hrapplication_vacation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vacationDate` datetime(6) NOT NULL,
  `reason` varchar(350) NOT NULL,
  `employee_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hrApplication_vacati_employee_id_4a846ca3_fk_hrApplica` (`employee_id`),
  CONSTRAINT `hrApplication_vacati_employee_id_4a846ca3_fk_hrApplica` FOREIGN KEY (`employee_id`) REFERENCES `hrapplication_employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hrapplication_vacation`
--

LOCK TABLES `hrapplication_vacation` WRITE;
/*!40000 ALTER TABLE `hrapplication_vacation` DISABLE KEYS */;
INSERT INTO `hrapplication_vacation` VALUES (11,'2021-12-02 00:00:00.000000','ahdfhgh',1),(12,'2022-01-01 00:00:00.000000','dfasfsadf',1),(13,'2021-12-28 00:00:00.000000','sadfasdfsadf',1),(14,'2021-12-04 00:00:00.000000','sdfasqwet',1),(15,'2022-01-08 00:00:00.000000','eeeeeeee',1),(16,'2021-11-28 00:00:00.000000','wqetwqtwqet',1),(18,'2022-01-05 00:00:00.000000','dsdfsgdg',1),(20,'2021-12-01 00:00:00.000000','wert',1),(22,'2022-01-02 00:00:00.000000','weyewrywery',1),(23,'2021-12-07 00:00:00.000000','gggg',1),(24,'2021-12-15 00:00:00.000000','',1),(25,'2021-12-08 00:00:00.000000','ffffffffffff',1),(26,'2022-02-04 00:00:00.000000','vsvsvsvs',1),(27,'2021-12-03 00:00:00.000000','',1),(28,'2021-11-16 00:00:00.000000','',1);
/*!40000 ALTER TABLE `hrapplication_vacation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-24 15:25:45
