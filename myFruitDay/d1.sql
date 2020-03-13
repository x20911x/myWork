-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: d1
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
-- Table structure for table `blogtype`
--

DROP TABLE IF EXISTS `blogtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blogtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='博客类型 - 个人博客,公开博客,其他博客';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogtype`
--

LOCK TABLES `blogtype` WRITE;
/*!40000 ALTER TABLE `blogtype` DISABLE KEYS */;
INSERT INTO `blogtype` VALUES (1,'個人部落格'),(2,'公開部落格'),(3,'其他部落格');
/*!40000 ALTER TABLE `blogtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='文章分類';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Python'),(2,'MySQL'),(3,'Javascript'),(4,'Flask');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `reply_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reply_User` (`user_id`),
  KEY `FK_Reply_Topic` (`topic_id`),
  CONSTRAINT `FK_Reply_Topic` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `FK_Reply_User` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部落格回覆';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
INSERT INTO `reply` VALUES (1,1,1,'有任何意見歡迎留言','2020-02-11 20:37:21'),(2,3,1,'讚讚讚','2020-02-13 09:12:40'),(3,3,1,'好文給推','2020-02-12 11:40:23'),(4,1,2,'有任何意見歡迎留言','2020-02-12 20:37:21'),(5,2,2,'讚讚讚','2020-02-14 09:12:40'),(6,3,2,'好文給推','2020-02-13 11:40:23');
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `pub_date` datetime NOT NULL,
  `read_num` int(11) DEFAULT NULL,
  `content` text NOT NULL,
  `images` text,
  `blogtype_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Topic_User` (`user_id`),
  KEY `FK_Topic_Blogtype` (`blogtype_id`),
  KEY `FK_Topic_Category` (`category_id`),
  CONSTRAINT `FK_Topic_Blogtype` FOREIGN KEY (`blogtype_id`) REFERENCES `blogtype` (`id`),
  CONSTRAINT `FK_Topic_Category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_Topic_User` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COMMENT='部落格文章';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (1,'List 補充---append + += * *= copy和deepcopy 對數據儲存地址的影響','2019-11-02 20:37:20',123,'From：https://www.oschina.net/question/5189_4306\r\n\r\nFrom：https://www.oschina.net/question/5189_4306\r\n\r\n\r\n\r\nWeb.py Cookbook 简体中文版：http://webpy.org/cookbook/index.zh-cn\r\n\r\nweb.py 0.3 新手指南：http://webpy.org/docs/0.3/tutorial.zh-cn\r\n\r\n\r\n\r\nwebpy 官网文档：http://webpy.org/ web.py 十分钟创建简易博客：http://blog.csdn.net/freeking101/article/details/53020728\r\n\r\nweb.py 是一个Python 的web 框架，它简单而且功能强大。web.py 是公开的，无论用于什么用途都是没有限制的。而且相当的小巧，应当归属于轻量级的web 框架。但这并不影响web.py 的强大，而且使用起来很简单、很直接。在实际应用上，web.py 更多的是学术上的价值，因为你可以看到更多web 应用的底层，这在当今“抽象得很好”的web 框架上是学不到的 ：） 如果想了解更多web.py，可以访问web.py 的官方文档。 先感受一下web.py 的简单而强大：\r\n\r\n上面就是一个基于web.py 的完整的Web 应用。将上面的代码保存为文件code.py，在命令行下执行python code.py。然后打开你的浏览器，打开地址：http://localhost:8080 或者 http://localhost:8080/test 没有意外的话(当然要先安装web.py，下面会有介绍)，浏览器会显示“Hello, world”或者 “Hello, test”。 \r\n\r\n\r\n\r\n1. 安装 下载 web.py 的安装文件，将下载得到的文件 web.py 解压，进入解压后的文件夹，在命令行下执行：python setup.py install，在Linux 等系统下，需要root 的权限，可以执行：sudo python setup.py install。 2. URL 处理 对于一个站点来说，URL 的组织是最重要的一个部分，因为这是用户看得到的部分，而且直接影响到站点是如何工作的，例如：www.baidu.com ，其URLs 甚至是网页界面的一部分。而web.py 以简单的方式就能够构造出一个强大的URLs。 在每个web.py 应用，必须先import web 模块：','images/banner01.jpg',1,2,1),(2,'Python高階函數的運用','2019-11-05 12:20:23',14,'webpy 官网文档：http://webpy.org/ web.py 十分钟创建简易博客：http://blog.csdn.net/freeking101/article/details/53020728\r\n\r\nweb.py 是一个Python 的web 框架，它简单而且功能强大。web.py 是公开的，无论用于什么用途都是没有限制的。而且相当的小巧，应当归属于轻量级的web 框架。但这并不影响web.py 的强大，而且使用起来很简单、很直接。在实际应用上，web.py 更多的是学术上的价值，因为你可以看到更多web 应用的底层，这在当今“抽象得很好”的web 框架上是学不到的 ：） 如果想了解更多web.py，可以访问web.py 的官方文档。 先感受一下web.py 的简单而强大：\r\n\r\n上面就是一个基于web.py 的完整的Web 应用。将上面的代码保存为文件code.py，在命令行下执行python code.py。然后打开你的浏览器，打开地址：http://localhost:8080 或者 http://localhost:8080/test 没有意外的话(当然要先安装web.py，下面会有介绍)，浏览器会显示“Hello, world”或者 “Hello, test”。 \r\n\r\n\r\n\r\n1. 安装 下载 web.py 的安装文件，将下载得到的文件 web.py 解压，进入解压后的文件夹，在命令行下执行：python setup.py install，在Linux 等系统下，需要root 的权限，可以执行：sudo python setup.py install。 2. URL 处理 对于一个站点来说，URL 的组织是最重要的一个部分，因为这是用户看得到的部分，而且直接影响到站点是如何工作的，例如：www.baidu.com ，其URLs 甚至是网页界面的一部分。而web.py 以简单的方式就能够构造出一个强大的URLs。 在每个web.py 应用，必须先import web 模块：\r\nwebpy 官网文档：http://webpy.org/ web.py 十分钟创建简易博客：http://blog.csdn.net/freeking101/article/details/53020728\r\n\r\nweb.py 是一个Python 的web 框架，它简单而且功能强大。web.py 是公开的，无论用于什么用途都是没有限制的。而且相当的小巧，应当归属于轻量级的web 框架。但这并不影响web.py 的强大，而且使用起来很简单、很直接。在实际应用上，web.py 更多的是学术上的价值，因为你可以看到更多web 应用的底层，这在当今“抽象得很好”的web 框架上是学不到的 ：） 如果想了解更多web.py，可以访问web.py 的官方文档。 先感受一下web.py 的简单而强大：\r\n\r\n上面就是一个基于web.py 的完整的Web 应用。将上面的代码保存为文件code.py，在命令行下执行python code.py。然后打开你的浏览器，打开地址：http://localhost:8080 或者 http://localhost:8080/test 没有意外的话(当然要先安装web.py，下面会有介绍)，浏览器会显示“Hello, world”或者 “Hello, test”。 \r\n\r\n\r\n\r\n1. 安装 下载 web.py 的安装文件，将下载得到的文件 web.py 解压，进入解压后的文件夹，在命令行下执行：python setup.py install，在Linux 等系统下，需要root 的权限，可以执行：sudo python setup.py install。 2. URL 处理 对于一个站点来说，URL 的组织是最重要的一个部分，因为这是用户看得到的部分，而且直接影响到站点是如何工作的，例如：www.baidu.com ，其URLs 甚至是网页界面的一部分。而web.py 以简单的方式就能够构造出一个强大的URLs。 在每个web.py 应用，必须先import web 模块：\r\nwebpy 官网文档：http://webpy.org/ web.py 十分钟创建简易博客：http://blog.csdn.net/freeking101/article/details/53020728\r\n\r\nweb.py 是一个Python 的web 框架，它简单而且功能强大。web.py 是公开的，无论用于什么用途都是没有限制的。而且相当的小巧，应当归属于轻量级的web 框架。但这并不影响web.py 的强大，而且使用起来很简单、很直接。在实际应用上，web.py 更多的是学术上的价值，因为你可以看到更多web 应用的底层，这在当今“抽象得很好”的web 框架上是学不到的 ：） 如果想了解更多web.py，可以访问web.py 的官方文档。 先感受一下web.py 的简单而强大：\r\n\r\n上面就是一个基于web.py 的完整的Web 应用。将上面的代码保存为文件code.py，在命令行下执行python code.py。然后打开你的浏览器，打开地址：http://localhost:8080 或者 http://localhost:8080/test 没有意外的话(当然要先安装web.py，下面会有介绍)，浏览器会显示“Hello, world”或者 “Hello, test”。 \r\n\r\n\r\n\r\n1. 安装 下载 web.py 的安装文件，将下载得到的文件 web.py 解压，进入解压后的文件夹，在命令行下执行：python setup.py install，在Linux 等系统下，需要root 的权限，可以执行：sudo python setup.py install。 2. URL 处理 对于一个站点来说，URL 的组织是最重要的一个部分，因为这是用户看得到的部分，而且直接影响到站点是如何工作的，例如：www.baidu.com ，其URLs 甚至是网页界面的一部分。而web.py 以简单的方式就能够构造出一个强大的URLs。 在每个web.py 应用，必须先import web 模块：\r\nFrom：https://www.oschina.net/question/5189_4306\r\n\r\nFrom：https://www.oschina.net/question/5189_4306\r\n\r\n\r\n\r\nWeb.py Cookbook 简体中文版：http://webpy.org/cookbook/index.zh-cn\r\n\r\nweb.py 0.3 新手指南：http://webpy.org/docs/0.3/tutorial.zh-cn\r\n\r\n\r\n\r\nwebpy 官网文档：http://webpy.org/ web.py 十分钟创建简易博客：http://blog.csdn.net/freeking101/article/details/53020728\r\n\r\nweb.py 是一个Python 的web 框架，它简单而且功能强大。web.py 是公开的，无论用于什么用途都是没有限制的。而且相当的小巧，应当归属于轻量级的web 框架。但这并不影响web.py 的强大，而且使用起来很简单、很直接。在实际应用上，web.py 更多的是学术上的价值，因为你可以看到更多web 应用的底层，这在当今“抽象得很好”的web 框架上是学不到的 ：） 如果想了解更多web.py，可以访问web.py 的官方文档。 先感受一下web.py 的简单而强大：\r\n\r\n上面就是一个基于web.py 的完整的Web 应用。将上面的代码保存为文件code.py，在命令行下执行python code.py。然后打开你的浏览器，打开地址：http://localhost:8080 或者 http://localhost:8080/test 没有意外的话(当然要先安装web.py，下面会有介绍)，浏览器会显示“Hello, world”或者 “Hello, test”。 \r\n\r\n\r\n\r\n1. 安装 下载 web.py 的安装文件，将下载得到的文件 web.py 解压，进入解压后的文件夹，在命令行下执行：python setup.py install，在Linux 等系统下，需要root 的权限，可以执行：sudo python setup.py install。 2. URL 处理 对于一个站点来说，URL 的组织是最重要的一个部分，因为这是用户看得到的部分，而且直接影响到站点是如何工作的，例如：www.baidu.com ，其URLs 甚至是网页界面的一部分。而web.py 以简单的方式就能够构造出一个强大的URLs。 在每个web.py 应用，必须先import web 模块：','images/banner02.jpg',1,2,1),(3,'Python裝飾器的運用','2019-11-07 11:52:03',8,'Python 安装配置及基本语法篇 Python 语言速成 Python 基本知识 Python 常用表达式 Python 基础语法 Python 语法篇：菜鸟的Python笔记 Python精要参考：快速入门 《Python标... ','images/banner03.jpg',1,2,1),(4,'Moduel import','2019-11-10 10:03:02',23,'python中打开TXT文件报错2017年03月09日 14:30:57 阅读数:676 在IDLE命令行引用一文件夹下的函数,来了条错误提示:FileNotFoundError: [Errno 2] No such ...','images/toppic01.jpg',1,2,1),(5,'Python異常處理','2017-11-11 20:01:22',10,'随便写点内容吧','images/zd01.jpg',1,2,1),(100,'df','2020-03-04 12:03:31',2,'aaaaaaaaaaaaaaaaaa','img',1,1,1),(101,'你','2020-03-04 12:04:17',2,'aaaaaaaaaaaaaaaaaa','img',1,1,1);
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(50) NOT NULL,
  `uname` varchar(30) NOT NULL,
  `email` varchar(200) NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `upwd` varchar(30) NOT NULL,
  `images` varchar(200) DEFAULT 'user_personal_images/Default.JPG',
  `is_author` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用戶訊息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'x20911x','Sam','x20911x@gmail.com',NULL,'a123456','user_personal_images/Default.JPG',1),(2,'weiye','老嘉','weimz@163.com',NULL,'a123456','user_personal_images/Default.JPG',0),(3,'lvye','法銓','lvye@163.com',NULL,'a123456','user_personal_images/Default.JPG',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voke`
--

DROP TABLE IF EXISTS `voke`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voke` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Voke_User` (`user_id`),
  KEY `FK_Voke_Topic` (`topic_id`),
  CONSTRAINT `FK_Voke_Topic` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `FK_Voke_User` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='點讚';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voke`
--

LOCK TABLES `voke` WRITE;
/*!40000 ALTER TABLE `voke` DISABLE KEYS */;
/*!40000 ALTER TABLE `voke` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-12 20:43:52
