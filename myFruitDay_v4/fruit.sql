-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: fruit
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.16.04.1

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add 商品類型',7,'add_goodstype'),(20,'Can change 商品類型',7,'change_goodstype'),(21,'Can delete 商品類型',7,'delete_goodstype'),(22,'Can add user',8,'add_user'),(23,'Can change user',8,'change_user'),(24,'Can delete user',8,'delete_user'),(25,'Can add 商品',9,'add_goods'),(26,'Can change 商品',9,'change_goods'),(27,'Can delete 商品',9,'delete_goods'),(28,'Can add 購物車',10,'add_cartinfo'),(29,'Can change 購物車',10,'change_cartinfo'),(30,'Can delete 購物車',10,'delete_cartinfo');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$f44bJzxMet9d$eRGB9l8i3Ohv2BsfKGXR9OQjd3hpwy25vLjZxloM2mU=','2020-03-11 09:04:55.213415',1,'x20911x','','','x20911x@gmail.com',1,1,'2020-03-04 04:18:16.957548');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_info`
--

DROP TABLE IF EXISTS `cart_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `good_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ccount` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_info_good_id_fee15156_fk_goods_id` (`good_id`),
  KEY `cart_info_user_id_d68fff78_fk_user_id` (`user_id`),
  CONSTRAINT `cart_info_good_id_fee15156_fk_goods_id` FOREIGN KEY (`good_id`) REFERENCES `goods` (`id`),
  CONSTRAINT `cart_info_user_id_d68fff78_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_info`
--

LOCK TABLES `cart_info` WRITE;
/*!40000 ALTER TABLE `cart_info` DISABLE KEYS */;
INSERT INTO `cart_info` VALUES (41,22,1,5),(50,15,15,20),(51,16,15,19),(52,21,1,4),(55,20,15,18),(57,6,1,7),(60,34,1,3);
/*!40000 ALTER TABLE `cart_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-03-04 04:19:22.777004','1','禮品卡卷',1,'[{\"added\": {}}]',7,1),(2,'2020-03-04 04:25:05.367763','2','家庭量販',1,'[{\"added\": {}}]',7,1),(3,'2020-03-04 04:25:28.250351','3','全球鮮果',1,'[{\"added\": {}}]',7,1),(4,'2020-03-04 04:25:56.324041','4','生鮮美食',1,'[{\"added\": {}}]',7,1),(5,'2020-03-04 04:31:37.439442','1','全球鮮果001',1,'[{\"added\": {}}]',9,1),(6,'2020-03-04 04:32:13.248970','2','全球鮮果002',1,'[{\"added\": {}}]',9,1),(7,'2020-03-04 04:32:22.778855','2','全球鮮果002',2,'[]',9,1),(8,'2020-03-04 04:33:19.298644','3','全球鮮果003',1,'[{\"added\": {}}]',9,1),(9,'2020-03-04 04:33:39.267327','4','全球鮮果004',1,'[{\"added\": {}}]',9,1),(10,'2020-03-04 04:34:01.464711','5','全球鮮果005',1,'[{\"added\": {}}]',9,1),(11,'2020-03-04 04:39:37.205568','6','家庭量販001',1,'[{\"added\": {}}]',9,1),(12,'2020-03-04 04:41:42.780815','7','家庭量販002',1,'[{\"added\": {}}]',9,1),(13,'2020-03-04 04:43:02.179658','8','生鮮美食001',1,'[{\"added\": {}}]',9,1),(14,'2020-03-04 07:06:40.300539','9','韭菜水餃',1,'[{\"added\": {}}]',9,1),(15,'2020-03-04 09:32:27.342835','6','家庭量販001',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(16,'2020-03-04 09:32:46.178824','7','家庭量販002',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(17,'2020-03-04 09:34:18.617438','5','全球鮮果005',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(18,'2020-03-04 09:34:30.684192','4','全球鮮果004',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(19,'2020-03-04 09:34:38.978752','3','全球鮮果003',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(20,'2020-03-04 09:34:43.470981','2','全球鮮果002',2,'[]',9,1),(21,'2020-03-04 09:34:51.196330','1','全球鮮果001',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(22,'2020-03-04 09:35:28.239947','9','韭菜水餃',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(23,'2020-03-04 09:35:48.674622','8','生鮮美食001',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(24,'2020-03-04 09:52:16.696983','7','家庭量販002',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(25,'2020-03-04 09:52:27.853688','6','家庭量販001',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(26,'2020-03-04 09:52:51.030848','7','家庭量販002',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(27,'2020-03-04 09:53:11.226774','6','家庭量販001',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(28,'2020-03-04 09:54:56.451143','10','全球鮮果006',1,'[{\"added\": {}}]',9,1),(29,'2020-03-04 09:55:11.896316','11','全球鮮果007',1,'[{\"added\": {}}]',9,1),(30,'2020-03-04 09:55:38.834105','12','全球鮮果008',1,'[{\"added\": {}}]',9,1),(31,'2020-03-04 09:56:07.088791','13','全球鮮果009',1,'[{\"added\": {}}]',9,1),(32,'2020-03-04 09:56:28.120101','14','全球鮮果010',1,'[{\"added\": {}}]',9,1),(33,'2020-03-04 09:59:08.227712','15','禮品卡卷001',1,'[{\"added\": {}}]',9,1),(34,'2020-03-04 09:59:29.122505','16','禮品卡卷002',1,'[{\"added\": {}}]',9,1),(35,'2020-03-04 09:59:47.640718','17','禮品卡卷003',1,'[{\"added\": {}}]',9,1),(36,'2020-03-04 10:00:11.761117','18','禮品卡卷004',1,'[{\"added\": {}}]',9,1),(37,'2020-03-04 10:00:35.644865','19','禮品卡卷005',1,'[{\"added\": {}}]',9,1),(38,'2020-03-04 10:01:06.467193','20','禮品卡卷006',1,'[{\"added\": {}}]',9,1),(39,'2020-03-04 10:01:29.089500','21','禮品卡卷007',1,'[{\"added\": {}}]',9,1),(40,'2020-03-04 10:01:46.308003','22','禮品卡卷008',1,'[{\"added\": {}}]',9,1),(41,'2020-03-04 10:02:03.046255','23','禮品卡卷009',1,'[{\"added\": {}}]',9,1),(42,'2020-03-04 10:02:19.034981','24','禮品卡卷010',1,'[{\"added\": {}}]',9,1),(43,'2020-03-05 12:18:05.279704','1','<user:陳致硯, good:全球鮮果001>',3,'',10,1),(44,'2020-03-05 12:18:25.352751','11','<user:陳致硯, good:生鮮美食001>',3,'',10,1),(45,'2020-03-05 12:18:30.185752','9','<user:陳致硯, good:禮品卡卷002>',3,'',10,1),(46,'2020-03-05 12:18:34.803642','6','<user:陳致硯, good:禮品卡卷001>',3,'',10,1),(47,'2020-03-05 12:18:38.912292','5','<user:陳致硯, good:禮品卡卷008>',3,'',10,1),(48,'2020-03-05 12:18:43.299248','8','<user:陳致硯, good:全球鮮果004>',3,'',10,1),(49,'2020-03-06 07:15:10.473227','24','<good:禮品卡卷010>',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(50,'2020-03-08 09:22:54.078629','1','<GoodsType:台灣水果>',2,'[{\"changed\": {\"fields\": [\"title\", \"picture\", \"desc\"]}}]',7,1),(51,'2020-03-08 09:23:49.968183','2','<GoodsType:進口水果>',2,'[{\"changed\": {\"fields\": [\"title\", \"desc\"]}}]',7,1),(52,'2020-03-08 09:25:16.508984','3','<GoodsType:蔬菜>',2,'[{\"changed\": {\"fields\": [\"title\", \"desc\"]}}]',7,1),(53,'2020-03-08 09:25:56.211963','4','<GoodsType:有機蔬果>',2,'[{\"changed\": {\"fields\": [\"title\", \"desc\"]}}]',7,1),(54,'2020-03-08 09:36:14.377386','24','<good:聖女小蕃茄>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(55,'2020-03-08 09:38:22.289753','23','<good:屏東牛奶蜜棗>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(56,'2020-03-08 09:39:31.331698','22','<good:金鑽鳳梨>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(57,'2020-03-08 09:41:38.309741','21','<good:鳳梨釋迦>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(58,'2020-03-08 09:43:17.465178','20','<good:大湖草莓>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(59,'2020-03-08 09:47:22.561664','19','<good:紅心芭樂>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(60,'2020-03-08 09:48:11.033424','18','<good:黑金剛蓮霧>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(61,'2020-03-08 09:50:03.502128','17','<good:水果總匯>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(62,'2020-03-08 09:51:01.073277','16','<good:研選柑橘>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(63,'2020-03-11 09:51:08.636250','7','<good:韓國梨>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(64,'2020-03-11 09:53:28.189596','25','<good:美國洋梨>',1,'[{\"added\": {}}]',9,1),(65,'2020-03-11 09:58:19.622898','6','<good:紅地球葡萄>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(66,'2020-03-11 09:59:10.797811','26','<good:智利蜜桃>',1,'[{\"added\": {}}]',9,1),(67,'2020-03-11 10:00:05.694702','27','<good:加州核桃>',1,'[{\"added\": {}}]',9,1),(68,'2020-03-11 10:00:46.665362','28','<good:印度無子葡萄>',1,'[{\"added\": {}}]',9,1),(69,'2020-03-11 10:01:14.781045','29','<good:急凍黑莓>',1,'[{\"added\": {}}]',9,1),(70,'2020-03-11 10:01:39.918087','30','<good:日本富士>',1,'[{\"added\": {}}]',9,1),(71,'2020-03-11 10:02:06.530992','31','<good:智利甜桃>',1,'[{\"added\": {}}]',9,1),(72,'2020-03-11 10:03:48.294941','32','<good:日本山形縣蘋果>',1,'[{\"added\": {}}]',9,1),(73,'2020-03-11 10:43:09.705273','33','<good:味鮮香菇>',1,'[{\"added\": {}}]',9,1),(74,'2020-03-11 10:44:41.865762','34','<good:大甲芋頭>',1,'[{\"added\": {}}]',9,1),(75,'2020-03-11 10:45:17.159243','35','<good:小白菜>',1,'[{\"added\": {}}]',9,1),(76,'2020-03-11 10:45:49.218836','36','<good:小黃瓜>',1,'[{\"added\": {}}]',9,1),(77,'2020-03-11 10:46:16.004520','37','<good:玉米>',1,'[{\"added\": {}}]',9,1),(78,'2020-03-11 10:47:01.358056','5','<good:紅蘿波>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"picture\"]}}]',9,1),(79,'2020-03-11 10:48:45.205956','14','<good:青江菜>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"picture\"]}}]',9,1),(80,'2020-03-11 10:49:19.157069','10','<good:全球鮮果006>',3,'',9,1),(81,'2020-03-11 10:49:46.417787','13','<good:韭菜>',2,'[{\"changed\": {\"fields\": [\"title\", \"picture\"]}}]',9,1),(82,'2020-03-11 10:53:51.203098','6','<good:秘魯紅提>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\"]}}]',9,1),(83,'2020-03-11 11:06:46.713091','32','<good:義大利奇異果>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(84,'2020-03-11 11:19:24.461226','31','<good:海南島芒果>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(85,'2020-03-11 11:22:52.922851','30','<good:日本富士>',2,'[{\"changed\": {\"fields\": [\"price\", \"spec\", \"picture\"]}}]',9,1),(86,'2020-03-11 11:24:01.487127','30','<good:華盛頓蘋果>',2,'[{\"changed\": {\"fields\": [\"title\"]}}]',9,1),(87,'2020-03-11 12:46:39.544116','11','<good:青椒>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"spec\", \"picture\"]}}]',9,1),(88,'2020-03-11 12:47:12.976113','12','<good:白蘿波>',2,'[{\"changed\": {\"fields\": [\"title\", \"picture\"]}}]',9,1),(89,'2020-03-11 12:50:06.697755','9','<good:韭菜水餃>',2,'[{\"changed\": {\"fields\": [\"picture\"]}}]',9,1),(90,'2020-03-11 12:50:23.954513','9','<good:芭樂乾>',2,'[{\"changed\": {\"fields\": [\"title\"]}}]',9,1),(91,'2020-03-11 12:51:04.196252','8','<good:芒果乾>',2,'[{\"changed\": {\"fields\": [\"title\", \"price\", \"picture\"]}}]',9,1),(92,'2020-03-11 12:52:04.605868','4','<GoodsType:水果乾>',2,'[{\"changed\": {\"fields\": [\"title\", \"desc\"]}}]',7,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(10,'index','cartinfo'),(9,'index','goods'),(7,'index','goodstype'),(8,'index','user'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-03-04 04:16:06.490527'),(2,'auth','0001_initial','2020-03-04 04:16:07.136663'),(3,'admin','0001_initial','2020-03-04 04:16:07.401969'),(4,'admin','0002_logentry_remove_auto_add','2020-03-04 04:16:07.430147'),(5,'contenttypes','0002_remove_content_type_name','2020-03-04 04:16:07.554494'),(6,'auth','0002_alter_permission_name_max_length','2020-03-04 04:16:07.610113'),(7,'auth','0003_alter_user_email_max_length','2020-03-04 04:16:07.690069'),(8,'auth','0004_alter_user_username_opts','2020-03-04 04:16:07.720107'),(9,'auth','0005_alter_user_last_login_null','2020-03-04 04:16:07.774879'),(10,'auth','0006_require_contenttypes_0002','2020-03-04 04:16:07.780451'),(11,'auth','0007_alter_validators_add_error_messages','2020-03-04 04:16:07.815899'),(12,'auth','0008_alter_user_username_max_length','2020-03-04 04:16:07.962627'),(13,'index','0001_initial','2020-03-04 04:16:07.992187'),(14,'index','0002_auto_20200229_0624','2020-03-04 04:16:08.019828'),(15,'index','0003_auto_20200304_0158','2020-03-04 04:16:08.174343'),(16,'index','0004_auto_20200304_0203','2020-03-04 04:16:08.246685'),(17,'index','0005_auto_20200304_0205','2020-03-04 04:16:08.265886'),(18,'index','0006_auto_20200304_0209','2020-03-04 04:16:08.291986'),(19,'index','0007_goods','2020-03-04 04:16:08.408548'),(20,'index','0008_auto_20200304_0210','2020-03-04 04:16:08.440973'),(21,'sessions','0001_initial','2020-03-04 04:16:08.487086'),(22,'index','0009_cartinfo','2020-03-05 03:17:16.884760'),(23,'index','0010_cartinfo_ccount','2020-03-05 03:39:22.516477'),(24,'index','0011_auto_20200305_0340','2020-03-05 03:40:29.809525'),(25,'index','0012_auto_20200311_1151','2020-03-11 11:51:16.572019');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('06fej9vm6vzxy6ijkiv9if2b1dosto26','ZDE1NzM1ZDAwYjhmNjNkMDhmYjdiYTMxNTgxMzA2ZDk4ZjUwZDljMzp7InVpZCI6IjEiLCJ1cGhvbmUiOiIwOTg5NTk1MjMyIn0=','2020-03-16 02:30:41.169994'),('0k0hcxcgzn27rv9an044vkkhdz0t9uj6','NmU1ODIzZDIwOTQ1MTc2YjJhZmU1NGMxMDViNTYzODBjYTgwNDZkZDp7InVpZCI6IjE1IiwidXBob25lIjoiMDk4OSJ9','2020-03-16 08:06:46.836949'),('0slr9g5kxn439z7rcu794asrt6xby3xb','NmU1ODIzZDIwOTQ1MTc2YjJhZmU1NGMxMDViNTYzODBjYTgwNDZkZDp7InVpZCI6IjE1IiwidXBob25lIjoiMDk4OSJ9','2020-03-16 07:54:32.741598'),('3htqpm8bz7km0blu1rbo43qrjuise9jx','NThhMGRjN2FiYjIwMDc5MzY5YmJmNjI3ZGQ4ZDVhNzdjMTE3ZjkzMjp7InVwaG9uZSI6IjA5ODk1OTUyMzIiLCJ1aWQiOjF9','2020-03-16 02:32:41.858003'),('4abkazddoa11jdy9jxwajwkui02vf7yn','NmU1ODIzZDIwOTQ1MTc2YjJhZmU1NGMxMDViNTYzODBjYTgwNDZkZDp7InVpZCI6IjE1IiwidXBob25lIjoiMDk4OSJ9','2020-03-16 08:08:22.109409'),('5zskgp89nnm5unrqisxgo0ajk391nuoq','ZjIwZGE4OWMwYzJmZGE0YjM4Zjc2M2E3ZGQyNzZmYTJiZGQ5NGNkOTp7InVwaG9uZSI6IjA5ODk1OTUyMzIiLCJ1aWQiOjEsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYjNjYjlkZjM4ODA0OGQ1Mjc1M2I0YmZlNDRlMjI4ZWJmZTQ1OWFjIn0=','2020-03-12 04:09:37.405560'),('63di5ryoe9517ofrwdjk7k33vjxb0lt7','ZDE1NzM1ZDAwYjhmNjNkMDhmYjdiYTMxNTgxMzA2ZDk4ZjUwZDljMzp7InVpZCI6IjEiLCJ1cGhvbmUiOiIwOTg5NTk1MjMyIn0=','2020-03-16 07:41:35.925237'),('6t4xjhb21v9glm6rdc1yt9cfc9ybx24i','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 07:51:44.646351'),('7opbqhb2tavz5j6cb7pxcssqhv8d2j69','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 02:17:22.424219'),('7qr0mha0ewvjbe0m0dzktzv9mq2jsxku','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 08:08:52.213454'),('88b1n4felpol7t03x1xboag3b3gg2cf0','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 02:30:19.797938'),('8i6hw2qzipimpxqfrdj0jujk9ytlk6ry','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 02:31:42.205500'),('9l7yolb24en37bxbd9m0igz9w77brdyb','NGEzNGUwNWQ3Nzc4NzNkNGM1MTg0YzA1YjVlOWFkMmQ0MTY2N2I5Mjp7fQ==','2020-03-16 02:20:23.029148'),('9mkfwvedkgje4kbzyh4rybtrkvwizdl3','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-17 09:39:34.395102'),('9q6udjij930umhpse93yf3butlftn3i3','ODZmMTIxNjliYjMwMTE3ZjQ4MzIzZmQyM2ZhMzAxZGIzODFmZTk5ZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYjNjYjlkZjM4ODA0OGQ1Mjc1M2I0YmZlNDRlMjI4ZWJmZTQ1OWFjIn0=','2020-03-19 05:55:23.350163'),('9q7t6qy8s8rm84y1ib8vpfskhvg03b6z','NThhMGRjN2FiYjIwMDc5MzY5YmJmNjI3ZGQ4ZDVhNzdjMTE3ZjkzMjp7InVwaG9uZSI6IjA5ODk1OTUyMzIiLCJ1aWQiOjF9','2020-03-16 02:44:28.398315'),('9qmhg9u73rgfw4cyw4uce7en0h28a2dx','ZDE1NzM1ZDAwYjhmNjNkMDhmYjdiYTMxNTgxMzA2ZDk4ZjUwZDljMzp7InVpZCI6IjEiLCJ1cGhvbmUiOiIwOTg5NTk1MjMyIn0=','2020-03-16 08:09:06.743365'),('9zgc0jqnnfk63c4jcx78m7my35bwktzi','NThhMGRjN2FiYjIwMDc5MzY5YmJmNjI3ZGQ4ZDVhNzdjMTE3ZjkzMjp7InVwaG9uZSI6IjA5ODk1OTUyMzIiLCJ1aWQiOjF9','2020-03-16 02:18:26.366978'),('b02h2mrq6le89m70aj6hvuz79h0nkf42','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-19 10:45:40.481855'),('bjf34fh6nvknr2svccvxili9mbr2fata','OWUzMzhhMDRhYTZiMjlmZGZkMzJlMjU0NTI5M2QwY2RlYjM5ZTg5ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwidWlkIjoxLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfaGFzaCI6IjJiM2NiOWRmMzg4MDQ4ZDUyNzUzYjRiZmU0NGUyMjhlYmZlNDU5YWMiLCJ1cGhvbmUiOiIwOTg5NTk1MjMyIn0=','2020-03-16 02:11:27.398996'),('cgh85koipguf6jvoaykoe541nmu7yc11','MGU3ZWNlZWYyMDJkZDc4ODdmZTk1ZjkwZDFlNDc3NzJlZWZmZmYyYTp7InVwaG9uZSI6IjA5ODk1OTUyMzIiLCJ1aWQiOiIxIn0=','2020-03-16 07:41:03.108458'),('claqcai4yu3bg80zzv1lsjss8y4cmfmp','MGU3ZWNlZWYyMDJkZDc4ODdmZTk1ZjkwZDFlNDc3NzJlZWZmZmYyYTp7InVwaG9uZSI6IjA5ODk1OTUyMzIiLCJ1aWQiOiIxIn0=','2020-03-16 07:40:48.555567'),('fi3ojs5gf7cywf2joalorpanczgfkwx6','NThhMGRjN2FiYjIwMDc5MzY5YmJmNjI3ZGQ4ZDVhNzdjMTE3ZjkzMjp7InVwaG9uZSI6IjA5ODk1OTUyMzIiLCJ1aWQiOjF9','2020-03-16 02:43:24.306440'),('kbkphan0h0wqkpz0wdisfua76lsjtanw','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 07:42:42.184440'),('kd4pbpge80m2sbgbwy22fffxzgfyrwgd','ZDE1NzM1ZDAwYjhmNjNkMDhmYjdiYTMxNTgxMzA2ZDk4ZjUwZDljMzp7InVpZCI6IjEiLCJ1cGhvbmUiOiIwOTg5NTk1MjMyIn0=','2020-03-16 07:44:02.598295'),('n1a9t5h8dntdk4nq2jzfb4qabjgnyvv4','NmU1ODIzZDIwOTQ1MTc2YjJhZmU1NGMxMDViNTYzODBjYTgwNDZkZDp7InVpZCI6IjE1IiwidXBob25lIjoiMDk4OSJ9','2020-03-16 08:02:18.121603'),('ogmnhh2pxniu31ns6f98vzzqf79lpu6g','NmU1ODIzZDIwOTQ1MTc2YjJhZmU1NGMxMDViNTYzODBjYTgwNDZkZDp7InVpZCI6IjE1IiwidXBob25lIjoiMDk4OSJ9','2020-03-16 08:02:32.678350'),('okegqfmws7kfqnxus49ebppwj8or3sef','ZDE1NzM1ZDAwYjhmNjNkMDhmYjdiYTMxNTgxMzA2ZDk4ZjUwZDljMzp7InVpZCI6IjEiLCJ1cGhvbmUiOiIwOTg5NTk1MjMyIn0=','2020-03-19 10:40:42.195382'),('oylfy93z5um47w0rsnwmo7ez28m2vchp','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 02:28:49.802702'),('py95pkb9ii1e38cb0faoew9zqb7uvfqx','NDBmMGUzMjY0NDk5ODU2ZDA3OGE3ODUxY2JiMGY0ODVjZDJiNGZkMjp7InVpZCI6MSwiX2F1dGhfdXNlcl9pZCI6IjEiLCJ1cGhvbmUiOiIwOTg5NTk1MjMyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYjNjYjlkZjM4ODA0OGQ1Mjc1M2I0YmZlNDRlMjI4ZWJmZTQ1OWFjIn0=','2020-03-11 09:31:38.380973'),('pzh5uo8yqr7rj30cae4h57wzngg2vgxg','ZDE1NzM1ZDAwYjhmNjNkMDhmYjdiYTMxNTgxMzA2ZDk4ZjUwZDljMzp7InVpZCI6IjEiLCJ1cGhvbmUiOiIwOTg5NTk1MjMyIn0=','2020-03-16 07:51:59.328669'),('r8564wug1eurnagslx68bvypdeybe337','MjM3NmI0N2IxNjdiOTYwNWE0OTFjMzE0ZDk3Y2Q0ODYwZjIwMTM0MTp7InVpZCI6MTUsInVwaG9uZSI6IjA5ODkifQ==','2020-03-16 07:54:16.903139'),('rqywxu9f54ecuwqum7s57kpfblku5039','NThhMGRjN2FiYjIwMDc5MzY5YmJmNjI3ZGQ4ZDVhNzdjMTE3ZjkzMjp7InVwaG9uZSI6IjA5ODk1OTUyMzIiLCJ1aWQiOjF9','2020-03-12 00:50:08.778410'),('sf9fba5lcubsa5motj30hosq6qtqqgsl','NGEzNGUwNWQ3Nzc4NzNkNGM1MTg0YzA1YjVlOWFkMmQ0MTY2N2I5Mjp7fQ==','2020-03-16 06:25:43.267910'),('t02m39riovw60q3c8hbr6rzffq6fkcag','NThhMGRjN2FiYjIwMDc5MzY5YmJmNjI3ZGQ4ZDVhNzdjMTE3ZjkzMjp7InVwaG9uZSI6IjA5ODk1OTUyMzIiLCJ1aWQiOjF9','2020-03-12 00:48:36.805385'),('u8e8nln2do0smrqt40tbcrjruje51n0s','MGU3ZWNlZWYyMDJkZDc4ODdmZTk1ZjkwZDFlNDc3NzJlZWZmZmYyYTp7InVwaG9uZSI6IjA5ODk1OTUyMzIiLCJ1aWQiOiIxIn0=','2020-03-16 02:18:48.516953'),('uvx5r64kh4m68p0agruk7k2o3gd3b8ag','MWFmMzZlMzZiNDI4ZGMxNjQ0YTY2YTlmN2MxYmU1OTMwODhkMmQwZDp7InVpZCI6MTIsInVwaG9uZSI6IjA5ODk1OSJ9','2020-03-16 03:37:20.995991'),('vbsnkimqhabu01wqrhujlh4dv8wqpnpm','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 07:43:21.054072'),('x7ob4f48xi9ers3j8cbrh8yibp5b9ftl','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 04:10:25.961469'),('xn56gk1apckcskxetmtaad11zort2a9l','ZDE1NzM1ZDAwYjhmNjNkMDhmYjdiYTMxNTgxMzA2ZDk4ZjUwZDljMzp7InVpZCI6IjEiLCJ1cGhvbmUiOiIwOTg5NTk1MjMyIn0=','2020-03-16 02:12:01.699754'),('ygfnz19073vbbhua2yschnx6gcz2nje9','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 07:37:47.285459'),('yz9lbngmxva3blmbuguxb867eq8nax80','ZTg0YmQ1MTgwMWM1NDBlNzQzYjJjMDg4Y2VhNWJkYmE3MTc4ZDEyMDp7InVpZCI6MSwidXBob25lIjoiMDk4OTU5NTIzMiJ9','2020-03-16 07:36:23.764599'),('zjyzzzxlxdewn82a3ocx8ku5jlpbn5lt','YmRmZjA5NGZkN2U2NzZmYWU4N2RjN2UwMTZkNmMxODdlMjkwYjE2Yzp7InVwaG9uZSI6IjA5MzMxMzIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwidWlkIjo0LCJfYXV0aF91c2VyX2hhc2giOiIyYjNjYjlkZjM4ODA0OGQ1Mjc1M2I0YmZlNDRlMjI4ZWJmZTQ1OWFjIn0=','2020-03-11 05:13:09.915044');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) NOT NULL,
  `price` decimal(7,1) NOT NULL,
  `spec` varchar(20) NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL,
  `goodsType_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_goods_goodsType_id_51797e1d_fk_goods_type_id` (`goodsType_id`),
  CONSTRAINT `index_goods_goodsType_id_51797e1d_fk_goods_type_id` FOREIGN KEY (`goodsType_id`) REFERENCES `goods_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,'全球鮮果001',15.5,'1斤','static/upload/goods/1-270x270-419-TPSKW6SP_UMJmb6U.jpg',1,3),(2,'全球鮮果002',20.5,'1斤','static/upload/goods/1-270x270-430-9RBRWTU9.jpg',1,3),(3,'全球鮮果003',30.0,'1斤','static/upload/goods/1-270x270-419-TPSKW6SP_uZMG9b5.jpg',1,3),(4,'全球鮮果004',10.0,'1斤','static/upload/goods/1-270x270-419-TPSKW6SP_exe4Lgn.jpg',1,3),(5,'紅蘿波',39.0,'1斤','static/upload/goods/紅蘿波.JPG',1,3),(6,'秘魯紅提',49.9,'1斤','static/upload/goods/紅地球葡萄.JPG',1,2),(7,'韓國梨',55.0,'1顆','static/upload/goods/韓國梨.JPG',1,2),(8,'芒果乾',498.0,'1包','static/upload/goods/芒果乾.JPG',1,4),(9,'芭樂乾',80.0,'1包','static/upload/goods/芭樂乾.JPG',1,4),(11,'青椒',64.0,'1顆','static/upload/goods/青椒.JPG',1,3),(12,'白蘿波',20.0,'1包','static/upload/goods/白蘿波.JPG',1,3),(13,'韭菜',25.0,'1包','static/upload/goods/韭菜.JPG',1,3),(14,'青江菜',36.0,'1包','static/upload/goods/青江菜.JPG',1,3),(15,'禮品卡卷001',12.0,'1包','static/upload/goods/1-270x270-419-TPSKW6SP_fMr0Y1r.jpg',1,1),(16,'研選柑橘',490.0,'5斤','static/upload/goods/嚴選桶柑.JPG',1,1),(17,'水果總匯',400.0,'1盒','static/upload/goods/1-270x270-435-8829CP99.jpg',1,1),(18,'黑金剛蓮霧',688.0,'4斤','static/upload/goods/黑金剛蓮霧.JPG',1,1),(19,'紅心芭樂',888.0,'1箱','static/upload/goods/紅心芭樂.JPG',1,1),(20,'大湖草莓',250.0,'1盒 (400g/盒)','static/upload/goods/大湖草莓.jpg',1,1),(21,'鳳梨釋迦',413.0,'5斤','static/upload/goods/鳳梨釋迦.JPG',1,1),(22,'金鑽鳳梨',60.0,'1斤','static/upload/goods/金鑽鳳梨.JPG',1,1),(23,'屏東牛奶蜜棗',30.0,'1顆','static/upload/goods/屏東牛奶蜜棗.JPG',1,1),(24,'聖女小蕃茄',69.0,'1盒','static/upload/goods/聖女小番茄.JPG',1,1),(25,'美國洋梨',59.0,'1盒','static/upload/goods/美國洋梨.JPG',1,2),(26,'智利蜜桃',35.0,'1顆','static/upload/goods/智利蜜桃.JPG',1,2),(27,'加州核桃',50.0,'1包','static/upload/goods/加州核桃.JPG',1,2),(28,'印度無子葡萄',89.0,'1盒','static/upload/goods/印度無子葡萄.JPG',1,2),(29,'急凍黑莓',100.0,'1盒','static/upload/goods/急凍黑莓.JPG',1,2),(30,'華盛頓蘋果',29.9,'6顆','static/upload/goods/華盛頓蘋果.JPG',1,2),(31,'海南島芒果',29.9,'1斤','static/upload/goods/海南島芒果.JPG',1,2),(32,'義大利奇異果',78.0,'12顆','static/upload/goods/義大利奇異果.JPG',1,2),(33,'味鮮香菇',55.0,'1包','static/upload/goods/味鮮香菇.JPG',1,3),(34,'大甲芋頭',79.0,'1顆','static/upload/goods/大甲芋頭.JPG',1,3),(35,'小白菜',36.0,'1斤','static/upload/goods/小白菜.JPG',1,3),(36,'小黃瓜',42.0,'1包','static/upload/goods/小黃瓜.JPG',1,3),(37,'玉米',55.0,'1斤','static/upload/goods/玉米.JPG',1,3);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods_type`
--

DROP TABLE IF EXISTS `goods_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `desc` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods_type`
--

LOCK TABLES `goods_type` WRITE;
/*!40000 ALTER TABLE `goods_type` DISABLE KEYS */;
INSERT INTO `goods_type` VALUES (1,'台灣水果','static/upload/goodstype/台灣水果.JPG','台灣水果的相關商品訊息'),(2,'進口水果','static/upload/goodstype/t1.png','進口水果的相關訊息'),(3,'蔬菜','static/upload/goodstype/t2.png','蔬菜相關內容'),(4,'水果乾','static/upload/goodstype/t3.png','水果乾相關內容');
/*!40000 ALTER TABLE `goods_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uphone` varchar(30) NOT NULL,
  `upwd` varchar(30) NOT NULL,
  `uname` varchar(30) NOT NULL,
  `uemail` varchar(254) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'0989595232','a123456','陳致硯','x20911x@gmail.com',0),(15,'0989','a','aaaa','a',0),(16,'093','a','b','a',0);
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

-- Dump completed on 2020-03-14 14:58:23
