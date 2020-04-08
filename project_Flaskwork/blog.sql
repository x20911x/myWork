-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: blog
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='文章分類';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Python'),(2,'MySQL'),(3,'Javascript'),(4,'Flask'),(5,'網路協議'),(6,'Git'),(7,'Django'),(8,'資安');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `reply_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reply_User` (`user_id`),
  KEY `FK_Reply_Topic` (`topic_id`),
  CONSTRAINT `FK_Reply_Topic` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`),
  CONSTRAINT `FK_Reply_User` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='部落格回覆';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
INSERT INTO `reply` VALUES (1,1,1,'有任何意見歡迎留言','2020-02-11 20:37:21'),(2,3,1,'讚讚讚','2020-02-13 09:12:40'),(3,3,1,'好文給推','2020-02-12 11:40:23'),(9,1,1,'test','2020-02-14 15:05:29'),(14,4,1,'i\'am chen','2020-02-17 15:25:57'),(20,1,1,'留言來自window','2020-02-23 08:22:53'),(21,1,48,'a','2020-02-27 12:14:45'),(22,11,1,'支持一下','2020-03-31 07:35:52');
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `topic_id` (`topic_id`),
  CONSTRAINT `test_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`),
  CONSTRAINT `test_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test2`
--

DROP TABLE IF EXISTS `test2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `reply_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test2`
--

LOCK TABLES `test2` WRITE;
/*!40000 ALTER TABLE `test2` DISABLE KEYS */;
/*!40000 ALTER TABLE `test2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test3`
--

DROP TABLE IF EXISTS `test3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test3` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `reply_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test3`
--

LOCK TABLES `test3` WRITE;
/*!40000 ALTER TABLE `test3` DISABLE KEYS */;
/*!40000 ALTER TABLE `test3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test4`
--

DROP TABLE IF EXISTS `test4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test4` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `topic_id` (`topic_id`),
  CONSTRAINT `test4_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`),
  CONSTRAINT `test4_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test4`
--

LOCK TABLES `test4` WRITE;
/*!40000 ALTER TABLE `test4` DISABLE KEYS */;
/*!40000 ALTER TABLE `test4` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='部落格文章';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (1,'copy和deepcopy 對數據儲存地址的影響','2019-11-02 20:37:20',297,'List&nbsp補充---append&nbsp+&nbsp+=&nbsp*&nbsp*=&nbspcopy和deepcopy&nbsp對數據儲存地址的影響','images/banner01.jpg',1,1,1),(48,'GET and POST 差異','2020-02-25 00:00:00',12,'Get&nbsp;Method:\r<br>-&nbsp;向指定的資源請求資料,&nbsp;類似於查詢操作。\r<br>\r<br>1.&nbsp;資料傳遞方式&nbsp;—&nbsp;將參數以&nbsp;Query&nbsp;String方式(name/value)，由URL帶至Server端，EX:&nbsp;/test/demo_get?name1=value1&name2=value2。\r<br>\r<br>2.&nbsp;參數長度限制&nbsp;—&nbsp;長度限制根據瀏覽器、Server&nbsp;的不同會有所不同。\r<br>\r<br>3.&nbsp;安全性&nbsp;—&nbsp;較POST不安全，因為傳遞的參數會在URL上顯示。\r<br>\r<br>4.&nbsp;資料種類&nbsp;—&nbsp;只允許&nbsp;ASCII。\r<br>\r<br>5.&nbsp;可以重新載入或按上一頁並不會有任何問題。\r<br>\r<br>6.&nbsp;傳遞的參數會被儲存在瀏覽器的歷史紀錄中。\r<br>\r<br>7.&nbsp;可以加入瀏覽器書籤。\r<br>\r<br>\r<br>Post&nbsp;Method:\r<br>-&nbsp;將要處理的資料提交給指定的資源。\r<br>\r<br>1.資料傳遞方式&nbsp;—&nbsp;將參數放至&nbsp;Request&nbsp;的&nbsp;message&nbsp;body&nbsp;中，因此不會在URL看到參數，適合用於隱密性較高的資料，EX:&nbsp;Signup、Signin帳號、密碼等。\r<br>\r<br>2.參數長度限制&nbsp;—&nbsp;長度不受限制。\r<br>\r<br>3.&nbsp;安全性&nbsp;—&nbsp;較POST安全，實際上傳遞的參數皆可以在封包(Request-&nbsp;line&nbsp;和&nbsp;Message-body)上看到。\r<br>\r<br>4.資料種類&nbsp;—&nbsp;無限制。\r<br>\r<br>5.重新載入或按上一頁瀏覽器會出現將重新提交(re-submitted)資料的提示。\r<br>傳遞的參數不會被儲存在瀏覽器的歷史紀錄中。\r<br>\r<br>6.無法加入瀏覽器書籤。\r<br>\r<br>\r<br>原文參考自：https://medium.com/@totoroLiu/http-post-%E5%92%8C-get-%E5%B7%AE%E7%95%B0-928829d29914','upload/20200303092645.JPG',1,5,1),(49,'Cookie and Session','2020-02-25 00:00:00',9,'當瀏覽器向服務器發起請求,&nbsp;會為每個瀏覽器所開闢的一段空間並生成session&nbsp;ID&nbsp;,隨著響應發送給给User-Agent（一般是瀏覽器端），而當瀏覽器接收後&nbsp;存入Cookie後，會將其中的key/value，保存到某個路徑內的文本文件之中，讓下次於造訪同一網站時，就可以將Cookie自動發送给Web&nbsp;Server端。\r<br>\r<br>\r<br>Ex.&nbsp;登入的應用為例，就是使用者登入一個網站時，伺服器端往往會請求用戶輸入使用者帳號及密碼，並且用戶可以勾選「下次自動登入」，這就是觸發使用Cookie的開關了，如果勾選了，在使用者前一次登入時，伺服器就會傳送了包含登入憑據（使用者名稱加密碼的某種加密形式）的Cookie到使用者的硬碟(或記憶體上)，在之後登入時，只要Cookie尚未到期，瀏覽器會傳送該Cookie給伺服器作驗證憑據，來減少重複登入的輸入行為。\r<br>\r<br>cookie&nbsp;and&nbsp;session差異:\r<br>1.保存地方不同\r<br>session&nbsp;是保存在服務器上的\r<br>cookie&nbsp;是保存在瀏覽器上的\r<br>\r<br>2.保存時長不同\r<br>cookie&nbsp;可以永久性保存\r<br>session&nbsp;臨時性保存數據\r<br>\r<br>3.安全性問題\r<br>session&nbsp;安全級別較高\r<br>cookie&nbsp;安全級別較低\r<br>\r<br>原文網址：https://progressbar.tw/posts/91','upload/20200303092708.JPG',1,5,1),(50,'ORM模型','2020-02-28 00:00:00',22,'ORM&nbsp;在網站開發結構中，是在『資料庫』和『&nbsp;Model&nbsp;資料容器』兩者之間，\r<br>簡單來說，它是一個幫助使用者更簡便、安全的去從資料庫讀取資料，\r<br>因為&nbsp;ORM&nbsp;的一個特性為:&nbsp;透過程式語言，去操作資料庫語言(&nbsp;SQL&nbsp;)。\r<br>\r<br>優點\r<br>\r<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、&nbsp;隱藏了數據訪問細節，“封閉”的通用資料庫交互，ORM的核心。他使​​得我們的通用數據交互變得簡單易行，並且完全不用考慮該死的SQL語句。快速開發，由此而來。\r<br>\r<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、ORM使用我們構造固化數據結構變得簡單易行。\r<br>\r<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、ORM可以防止SQL的注入攻擊(SQL-Injection)\r<br>\r<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、面向對象不用編碼，就可以向操作物件一樣操作資料庫\r<br>\r<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5、提高開發效率，ORM可以自動對實體對象與資料庫中表進行字段與屬性的映射，不需要單獨的數據訪問層就可以數據進行增刪改查。\r<br>\r<br>&nbsp;&nbsp;&nbsp;&nbsp;6、方便轉移資料庫，當資料庫發生改變時，不需要對模型進行改動，只需要修改映射關係就可以了。\r<br>\r<br>缺點\r<br>\r<br>&nbsp;&nbsp;&nbsp;&nbsp;1、無可避免的，自動化意味著映射和關聯管理，代價是犧牲性能（早期，這是所有不喜歡ORM人的共同點）。現在的各種ORM框架都在嘗試使用各種方法來減輕這塊，效果還是很顯著的。\r<br>\r<br>&nbsp;&nbsp;&nbsp;&nbsp;2、面向對象的查詢語言作為一種資料庫與對象之間的過渡，雖然隱藏了數據層面的業務抽象，但並不能完全的屏蔽掉資料庫層的設計，並且無疑將半圓學習成本\r<br>\r<br>&nbsp;&nbsp;&nbsp;&nbsp;3、對於複雜查詢，ORM仍然力不從心！雖然可以實現。','upload/20200303135705.JPG',2,4,1),(54,'Ajax 跨域','2020-03-02 00:00:00',9,'Ajax\r<br>\r<br>通過&nbsp;JS&nbsp;異步的向服務器發送請求並接收響應數據\r<br>\r<br>同步訪問：\r<br>當客戶端向服務器發送請求時，服務器在處理的過程中，瀏覽器只能等待，效率較低\r<br>異步訪問：\r<br>當客戶端向服務器發送請求時，服務器在處理的過程中，客戶端可以做其他的操作，不需要一直等待\r<br>\r<br>AJAX優點：\r<br>1.異步&nbsp;訪問\r<br>2.局部&nbsp;刷新\r<br>\r<br>Ajax底層實現\r<br>1.在瀏覽器端創建&nbsp;xhr&nbsp;對象\r<br>2.創建請求&nbsp;-&nbsp;open()\r<br>3.設置回調函數&nbsp;-&nbsp;onreadystatechange\r<br>判斷狀態並接收響應數據\r<br>4.發送請求&nbsp;-&nbsp;send()\r<br>\r<br>\r<br>跨域(Cross&nbsp;Domain)\r<br>\r<br>原起:\r<br>HTTP協議中有一個策略&nbsp;-&nbsp;\"同源策略\"\r<br>同源：多個地址中，若是相同協議，相同域名，且相同端口被視為是\"同源\"網站\r<br>\r<br>同源策略的目的:是為了保證用戶信息的安全,防止惡意的網站竊取數據\r<br>\r<br>同源策略的限制範圍:\r<br>\r<br>隨著互聯網的發展,’同源策略’越來越嚴格,目前,如果非同源,下面的行為將會受到限制:\r<br>\r<br>1.&nbsp;Cookie、LocalStorage&nbsp;和&nbsp;IndexDB&nbsp;無法讀取。\r<br>\r<br>2.&nbsp;DOM&nbsp;無法獲得。\r<br>ps.&nbsp;DOM&nbsp;提供了文件以擁有屬性與函式的節點與物件組成的結構化表示。節點也可以附加事件處理程序，一旦觸發事件就會執行處理程序。&nbsp;\r<br>\r<br>3.&nbsp;AJAX&nbsp;請求在瀏覽器端有跨域限制\r<br>\r<br>在HTTP中，必須是同源地址才能互相發送請求，非同源拒絕請求(&lt;script>和&lt;img>除外)\r<br>\r<br>方法&nbsp;1\r<br>1.&nbsp;通過&nbsp;&lt;script>&nbsp;向服務器資源發送請求,&nbsp;由服務器資源指定前端頁面的哪個方法來執行響應的數據','upload/20200302143053.JPG',1,3,1),(55,'MySQL 索引簡介','2020-03-03 00:00:00',9,'1.&nbsp;索引是什麼?\r<br>&nbsp;&nbsp;&nbsp;索引是對資料庫表中一列或多列的值進行排序的一種結構。在關聯式資料庫中，索引是一種與表有關的資料庫結構，它可以使對應於表的SQL語句執行得更快。\r<br>&nbsp;&nbsp;&nbsp;索引是一個單獨的、物理的資料庫結構，它是某個表中一列或若干列值的集合和相應的指向表中物理標識這些值的資料頁的邏輯指標清單。\r<br>索引提供指向儲存在表的指定列中的資料值的指標，然後根據您指定的排序順序(選擇欄位field)對這些指標排序。ex.&nbsp; create&nbsp;index&nbsp;index_name&nbsp;on&nbsp;t3(field_name);mysql預設的就是二叉樹演算法&nbsp;BTREE,通過BTREE演算法建立索引的欄位。\r<br>\r<br>\r<br>2.&nbsp;為什麼需要索引?\r<br>當表中有大量記錄時，若要對錶進行查詢，第一種搜尋資訊方式是全表搜尋，是將所有記錄一一取出，和查詢條件進行一一對比，然後返回滿足條件的記錄，這樣做會消耗大量資料庫系統時間，並造成大量磁碟I/O操作；\r<br>第二種就是在表中建立索引，然後在索引中找到符合查詢條件的索引值，最後通過儲存在索引中的ROWID（相當於頁碼）快速找到表中對應的記錄。\r<br>\r<br>\r<br>3.&nbsp;Mysql如何使用索引?\r<br>索引用於快速找出在某個列中有一特定值的行。不使用索引，MySQL必須從第1條記錄開始然後讀完整個表直到找出相關的行。表越大，花費的時間越多。如果表中查詢的列有一個索引，MySQL能快速到達一個位置去搜尋到資料檔案的中間，沒有必要看所有資料。\r<br>\r<br>\r<br>-&nbsp;普通索引\r<br>這是最基本的索引，它沒有任何限制。\r<br>ex.&nbsp;CREATE&nbsp;INDEX&nbsp;index_id&nbsp;&nbsp;ON&nbsp;t_student(STU_ID);\r<br>\r<br>\r<br>-&nbsp;唯一索引\r<br>主鍵就是唯一索引的一種，主鍵要求建表時指定，一般用auto_increment列，關鍵字是primary&nbsp;key。它與前面的普通索引類似，不同的就是：索引列的值必須唯一，但允許有空值。如果是組合索引，則列值的組合必須唯一。\r<br>ex.&nbsp;CREATE&nbsp;UNIQUE&nbsp;INDEX&nbsp;indexName&nbsp;ON&nbsp;mytable(username(length))\r<br>\r<br>\r<br>-&nbsp;多列索引\r<br>為了更多的提高mysql效率可建立組合索引\r<br>\r<br>最左前綴規則\r<br>假設聯合索引由列(a,b,c)組成，則一下順序滿足最左前綴規則：a、ab、abc；\r<br>\r<br>現在我們有一個firstname、lastname、age列上的多列索引，我們稱這個索引為fname_lname_age。\r<br>下面這些查詢都能夠使用這個fname_lname_age索引：&nbsp;\r<br>Select&nbsp;peopleid&nbsp;FROM&nbsp;people&nbsp;Where&nbsp;\r<br>firstname=’Mike’&nbsp;AND&nbsp;lastname=’Sullivan’&nbsp;AND&nbsp;age=’17’;&nbsp;\r<br>Select&nbsp;peopleid&nbsp;FROM&nbsp;people&nbsp;Where&nbsp;firstname=’Mike’&nbsp;AND&nbsp;lastname=’Sullivan’;&nbsp;\r<br>Select&nbsp;peopleid&nbsp;FROM&nbsp;people&nbsp;Where&nbsp;firstname=’Mike’;\r<br>ex.&nbsp;CREATE&nbsp;&nbsp;INDEX&nbsp;indexName&nbsp;ON&nbsp;mytable(username1(length),username2(length))\r<br>\r<br>\r<br>-&nbsp;主鍵索引\r<br>主鍵值的定義，是資料庫表中對儲存資料物件是屬於唯一，並且可完整標識的資料列或屬性的值，其不能是重複也不能是空值。\r<br>所謂主鍵就是能夠唯一標識表中某一行的屬性或屬性組，一個表只能有一個主鍵，但可以有多個候選索引。因為主鍵可以唯一標識某一行記錄，所以可以確保執行資料更新、刪除的時候不會出現張冠李戴的錯誤。主鍵除了上述作用外，常常與外來鍵構成參照完整性約束，防止出現數據不一致。\r<br>ex.&nbsp;create&nbsp;table&nbsp;table_name(id&nbsp;int&nbsp;primary&nbsp;key&nbsp;auto_increment)auto_increment=10000;\r<br>\r<br>\r<br>-&nbsp;全文索引\r<br>僅可用於MyISAM表，針對較大的數據，生成全文索引非常的消耗時間和空間\r<br>\r<br>\r<br>參考自:https://www.itread01.com/content/1548732789.html','upload/20200308144816.JPG',1,2,1),(56,'資料庫正規化','2020-03-08 00:00:00',3,'正規化最重要的目的，就是重新整裡關聯式資料庫的表格及欄位，來降低資料重複及減少相依性的過程。\r<br>\r<br>第一正規化：定義主鍵值（primary&nbsp;key或unique&nbsp;key）以及剔除重複資料，主鍵值是資料庫表中對儲存資料物件是屬於唯一，並且可完整標識的資料列或屬性的值，其不能是重複也不能是空值。\r<br>\r<br>第二正規化：符合第一正規化，釐清資料表裡面每一個資料欄位的關係，把部分相依的資料另開表格作儲存，設定外鍵值來確保每一非鍵值欄位必須「完全功能相依」(Functional&nbsp;Dependency)於另外一張表的主鍵,&nbsp;以減少資料重複性。\r<br>\r<br>第三正規化：符合第二正規化，每一個非鍵值欄位都必須不得和其他非鍵值欄位產生相關性。，都只相依於該表的主鍵。','upload/20200308144915.JPG',2,2,1),(57,'MVC&nbsp;與&nbsp;MTV','2020-03-10 00:00:00',6,'MVC&nbsp;是一種『網站開發架構』的技術名詞\r<br>\r<br>-&nbsp;MVC&nbsp;設定一個基礎的架構，未來每個開發者就依循這個架構去開發會比較好維護、擴充、除錯且能讓程式碼的『分工性』更加明確。\r<br>\r<br>\r<br>Model&nbsp;模型&nbsp;-&nbsp;代表商業邏輯與資料庫存取&nbsp;\r<br>\r<br>View&nbsp;視圖&nbsp;-&nbsp;顯示網頁畫面給使用者\r<br>-&nbsp;表單的輸入\r<br>-&nbsp;網頁的輸出\r<br>\r<br>Controller&nbsp;控制&nbsp;-&nbsp;判斷該呼叫哪一個Model存取資料並透過哪一個view介面去顯示\r<br>\r<br>介於Model及View之間,&nbsp;對&nbsp;Request/Response&nbsp;進行處理並透過&nbsp;Controller&nbsp;把&nbsp;Model&nbsp;的資料串接到&nbsp;View（Templates）。\r<br>\r<br>\r<br>\r<br>Flask&nbsp;Django&nbsp;就是參考自MVC架構去設計了MTV\r<br>\r<br>模型&nbsp;-&nbsp;Model：負責業務對象和數據庫的關係映射（ORM），與MVC模式中的Model是等同。\r<br>\r<br>模板&nbsp;-&nbsp;Template：負責如何把頁面展示給用戶（HTML），這部分類似與MVC中的視圖。\r<br>\r<br>視圖&nbsp;-&nbsp;View：負責業務邏輯，並在適當時候調用Model和Template。跟MVC中的Controller等同。\r<br>','upload/20200310002925.JPG',2,4,1),(58,'Git 提交狀態index','2020-03-13 00:00:00',6,'「索引」的目的主要用來紀錄「有哪些檔案即將要被提交到下一個&nbsp;commit&nbsp;版本中」。\r<br>\r<br>換句話說，「如果你想要提交一個版本到&nbsp;Git&nbsp;儲存庫，那麼你一定要先更新索引狀態，變更才會被提交出去。\r<br>\r<br>*&nbsp;untracked&nbsp;(未追蹤的，代表尚未被加入&nbsp;Git&nbsp;儲存庫的檔案狀態)\r<br>*&nbsp;unmodified&nbsp;(未修改的，代表檔案第一次被加入，或是檔案內容與&nbsp;HEAD&nbsp;內容一致的狀態)\r<br>*&nbsp;modified&nbsp;(已修改的，代表檔案已經被編輯過，或是檔案內容與&nbsp;HEAD&nbsp;內容不一致的狀態)\r<br>*&nbsp;staged&nbsp;(等待被&nbsp;commit&nbsp;的，代表下次執行&nbsp;git&nbsp;commit&nbsp;會將這些檔案全部送入版本庫)\r<br>\r<br>全文引用自https://ithelp.ithome.com.tw/articles/10134531','upload/20200315143221.JPG',1,6,1),(59,'Git&nbsp;branch','2020-03-15 00:00:00',2,'git&nbsp;checkout&nbsp;&lt;branch>&nbsp;or&nbsp;&lt;commit&nbsp;id>&nbsp;&nbsp;>>>&nbsp;切換head所在位置\r<br>\r<br>git&nbsp;checkout&nbsp;&lt;commit&nbsp;id>&nbsp;&nbsp;>>>&nbsp;切換到此commit,&nbsp;切換到其他head位置時此commmit&nbsp;id&nbsp;的head所在&nbsp;位置就會消失\r<br>解決方法&nbsp;>>>&nbsp;git&nbsp;checkout&nbsp;-b&nbsp;&lt;branch>&nbsp;>>>&nbsp;將當前head位置指定為此新分支\r<br>\r<br>git&nbsp;branch&nbsp;-D&nbsp;&lt;branch>&nbsp;>>>&nbsp;刪除本地分支\r<br>\r<br>\r<br>狀況題:&nbsp;分支不小心刪掉怎麼處理?\r<br>Ans:&nbsp;$&nbsp;git&nbsp;branch&nbsp;&lt;new_branch>&nbsp;&lt;commit&nbsp;id>\r<br>\r<br>ls&nbsp;.git/refs/heads/&nbsp;>>>&nbsp;查看當前工作目錄下所有分支\r<br>\r<br>cat&nbsp;.git/HEAD&nbsp;>>>&nbsp;查看head位置\r<br>\r<br>cat&nbsp;.git/refs/heads/&lt;branchName>&nbsp;&nbsp;>>>&nbsp;查看此branch&nbsp;當前的&lt;commit&nbsp;id>\r<br>\r<br>','upload/20200315143026.JPG',2,6,1),(60,'Git&nbsp;diff','2020-03-15 00:00:00',0,'Git&nbsp;diff&nbsp;&lt;filename>&nbsp;>>>&nbsp;顯示&nbsp;&lt;檔案>&nbsp;與&nbsp;&lt;HEAD所指向commit>&nbsp;的差異\r<br>\r<br>Git&nbsp;diff&nbsp;--cached&nbsp;&lt;filename>&nbsp;>>>&nbsp;顯示&nbsp;&lt;add到暫存區檔案>&nbsp;跟&nbsp;&lt;HEAD所指向commit>&nbsp;的差異。\r<br>\r<br>git&nbsp;diff&nbsp;e37078e&nbsp;d4d8d9d&nbsp;>>>&nbsp;比對兩個commit&nbsp;的差異\r<br>\r<br>git&nbsp;diff&nbsp;>>>&nbsp;工作目錄與暫存區的差異','upload/20200315143117.JPG',2,6,1),(61,'前後端分離技術','2020-03-16 00:00:00',13,'1.&nbsp;後端請求過程?\r<br>\r<br>Ans:&nbsp;瀏覽器客戶端&nbsp;藉由TCP通訊協議發起http&nbsp;rquest請求,&nbsp;遠端服務器接收到http請求後,&nbsp;向後端服務程序根據url及對應的處理函數發起解析請求,&nbsp;調用靜態文件或ORM與數據庫進行交互,&nbsp;生成資料&nbsp;經過後端服務程序處理後\r<br>重新組織數據&nbsp;發起http&nbsp;response。\r<br>\r<br>2.&nbsp;前後端分離技術\r<br>2.1&nbsp;使用者造訪&nbsp;/posts&nbsp;這個網址，代表他想看全部文章\r<br>2.2&nbsp;前端的路由去處理，負責呼叫對應到的&nbsp;controller\r<br>2.3&nbsp;前端&nbsp;controller&nbsp;去呼叫&nbsp;Model&nbsp;拿資料\r<br>2.4&nbsp;前端&nbsp;Model&nbsp;透過&nbsp;API，去&nbsp;/api/posts&nbsp;這個網址拿資料\r<br>2.5&nbsp;後端路由接到&nbsp;request，丟給對應到的後端&nbsp;controller\r<br>2.6&nbsp;後端&nbsp;controller&nbsp;跟後端&nbsp;Model&nbsp;拿資料\r<br>2.7&nbsp;後端&nbsp;controller&nbsp;把資料傳回去\r<br>2.8&nbsp;前端&nbsp;Modle&nbsp;拿到資料以後回傳給前端&nbsp;controller，並且把資料丟給&nbsp;view，由&nbsp;view&nbsp;回傳完整&nbsp;HTML\r<br>2.9&nbsp;client&nbsp;side&nbsp;render，把畫面渲染出來\r<br>\r<br>3.&nbsp;瀏覽器的&nbsp;Request/Response&nbsp;Lifecycle\r<br>那麼瀏覽器是如何從輸入&nbsp;URL&nbsp;網址到把網頁顯示出來？\r<br>\r<br>3.1&nbsp;在網址列輸入網址，或是點網頁上的超連結,&nbsp;\r<br>3.2&nbsp;瀏覽器解析這個&nbsp;URL&nbsp;找出&nbsp;protocol、host、port&nbsp;和&nbsp;path。\r<br>\r<br>3.3&nbsp;如果是&nbsp;HTTP，則組出&nbsp;HTTP&nbsp;request&nbsp;封包\r<br>3.4&nbsp;查詢&nbsp;DNS&nbsp;用&nbsp;host&nbsp;找出對應的&nbsp;IP&nbsp;位址，組出&nbsp;IP&nbsp;封包\r<br>3.5&nbsp;組出&nbsp;TCP&nbsp;封包並建立一個&nbsp;TCP&nbsp;connection&nbsp;到上述&nbsp;IP&nbsp;位址和&nbsp;Port&nbsp;\r<br>3.6&nbsp;送出&nbsp;HTTP&nbsp;Request&nbsp;封包。\r<br>\r<br>3.7&nbsp;Web&nbsp;伺服器(例如&nbsp;Nginx)接收到&nbsp;HTTP&nbsp;Request&nbsp;封包後，解析其中的內容(特別是其中的&nbsp;path)來決定如何回應：\r<br>\r<br>3.7.1&nbsp;如果是靜態內容，也就是&nbsp;HTTP&nbsp;Response不會根據不同用戶、不同時間等任何因素而改變，例如圖片、影片、CSS、JavaScript&nbsp;等等。那麼&nbsp;Web&nbsp;伺服器會直接將該檔案回傳給瀏覽器。\r<br>\r<br>3.7.2&nbsp;如果是動態內容，也就是會根據不同登入的使用者、時間等參數來回傳不同內容，那個&nbsp;Nginx&nbsp;會將&nbsp;HTTP&nbsp;Request&nbsp;交給應用程式處理，例如&nbsp;PHP、Ruby、Python、Node.js、Java&nbsp;等程式，由該程式動態地根據不同參數和條件，搭配資料庫來撈取資料，然後組合出&nbsp;HTML&nbsp;網頁包成&nbsp;HTTP&nbsp;Response&nbsp;經由&nbsp;Nginx&nbsp;回傳給瀏覽器。\r<br>\r<br>3.8&nbsp;瀏覽器接收到這個&nbsp;HTTP&nbsp;Response，開始解析這份&nbsp;HTML&nbsp;網頁成為&nbsp;Document&nbsp;Object&nbsp;Model&nbsp;(DOM)&nbsp;一種樹狀的資料結構來對應&nbsp;HTML&nbsp;的標籤節點。\r<br>\r<br>3.9&nbsp;瀏覽器會依序檢查&nbsp;HTML&nbsp;原始碼中，需要下載的資源網址&nbsp;URL，例如&nbsp;CSS、圖片、JavaScript&nbsp;等等，就會再發&nbsp;HTTP&nbsp;Request&nbsp;請求下載回來&nbsp;(依照上述步驟二到九)\r<br>\r<br>3.10&nbsp;如果下載到&nbsp;CSS&nbsp;樣式表，就會去裝飾對應的&nbsp;DOM&nbsp;節點\r<br>3.11&nbsp;如果下載到&nbsp;JavaScript&nbsp;程式碼，則會執行它。瀏覽器上的&nbsp;JavaScript&nbsp;程式可以操作&nbsp;DOM&nbsp;節點，通常會用&nbsp;jQuery&nbsp;函式庫來做，來達到一些網頁動態特效。\r<br>3.12&nbsp;直到所有資源都下載完畢，瀏覽器執行完&nbsp;CSS&nbsp;和&nbsp;JavaScript，才算大功告成完成(Page&nbsp;Load)。\r<br>\r<br>\r<br>擷取自&nbsp;https://ihower.tw/cs/networking-http.html#sec0','upload/20200317133429.JPG',2,5,1),(62,'API','2020-03-17 00:00:00',14,'-&nbsp;API（Application&nbsp;Programming&nbsp;Interface）\r<br>\r<br>-&nbsp;『資料交換介面』\r<br>\r<br>-&nbsp;指的是一段程式碼與作業系統、與其他段程式碼彼此之間溝通的管道\r<br>\r<br>時機:&nbsp;Web&nbsp;API&nbsp;是讓團隊其他成員與使用者分享資料的其中一種方式，並不是唯一方式、也不一定是最佳方式。\r<br>如果我們所提供出來的資料較小且不會頻繁隨時間而更動，\r<br>提供靜態的&nbsp;JSON、XML&nbsp;或&nbsp;CSV&nbsp;等常見文字格式資料集可能是更好的選擇。\r<br>\r<br>然而當資料具備下列特性時，使用&nbsp;Web-&nbsp;API分享就顯得比使用文字格式資料集提供下載來得更好。\r<br>\r<br>1.資料更新的速度快、頻率高，生成靜態資料集檔案過於緩慢\r<br>2.使用者可能只需要龐大資料中的一個子集（subset）\r<br>3.資料具備重複運算的特性（例如&nbsp;rolling&nbsp;stats）\r<br>\r<br>RESTful&nbsp;是描述&nbsp;Web&nbsp;API&nbsp;最佳實踐方式的哲學，遵循&nbsp;REST&nbsp;所設計出來的&nbsp;Web&nbsp;API&nbsp;就能夠被稱呼為&nbsp;REST&nbsp;API。\r<br>REST指的是網路中Client端和Server端的一種呼叫服務形式，透過既定的規則，滿足約束條件和原則的應用程式設計，對資源的操作包括獲取、創建、修改和刪除資源，這些操作就是依照我們前面所提到的HTTP&nbsp;Method:&nbsp;GET、POST、PUT、PATCH和DELETE。\r<br>\r<br>使用&nbsp;RESTful&nbsp;風格設計的&nbsp;API，就有了以下幾種優點及限制：\r<br>1.&nbsp;有唯一的URL表示資源位置，統一的&nbsp;API&nbsp;接口。\r<br>2.&nbsp;無狀態\r<br>無狀態的意思，即&nbsp;Client&nbsp;端自行保存狀態，在請求&nbsp;Server&nbsp;的時候，一併附上給&nbsp;Server&nbsp;端，Server&nbsp;端無保存&nbsp;Client&nbsp;端的狀態資訊。\r<br>3.&nbsp;可更高效利用快取來提高回應速度&nbsp;(Cachable)\r<br>4.&nbsp;客戶端服務器分離&nbsp;(Client-Server)\r<br>\r<br>\r<br>參考自https://medium.com/datainpoint/flask-web-api-quickstart-3b13d96cccc2\r<br>https://medium.com/itsems-frontend/api-%E6%98%AF%E4%BB%80%E9%BA%BC-restful-api-%E5%8F%88%E6%98%AF%E4%BB%80%E9%BA%BC-a001a85ab638\r<br>https://progressbar.tw/posts/53','upload/20200317133553.JPG',2,5,1),(63,'HTTP簡介','2020-03-18 00:00:00',5,'HTTP&nbsp;-&nbsp;『超文本傳輸協定』\r<br>-&nbsp;是一個用戶端（瀏覽器）和伺服器端（網站放的位置）請求和應答的標準\r<br>\r<br>HTTPs&nbsp;-&nbsp;『超文本傳輸安全協定』&nbsp;\r<br>-&nbsp;加密所有用戶端與伺服器端傳輸的資料\r<br>\r<br>目前由於許多商業程序都轉移到網路上進行，因此導致網路攻擊的盛行，\r<br>所以資料傳遞過程的安全性，日漸受到大家(老闆)的重視，\r<br>而他的機制就是網站的經營者購買&nbsp;『信任憑證頒發機構』&nbsp;所認可的憑證,&nbsp;並受到這些憑證頒發機構的認可,&nbsp;才能在用戶連結到這些網站告知客戶這是屬於HTTPs\r<br>\r<br>特點:\r<br>是一個無狀態協議，這意味著每個請求都是獨立的，Keep-Alive&nbsp;沒能改變這個結果。\r<br>HTTP&nbsp;是一個屬於應用層的面向對象的協議，HTTP&nbsp;協議一共有五大特點：1、支持客戶/伺服器模式；2、簡單快速；3、靈活；4、無連接；5、無狀態。\r<br>\r<br>ps.\r<br>無連接:\r<br>無連接的含義是限制每次連接只處理一個請求。伺服器處理完客戶的請求，並收到客戶的應答後，即斷開連接。採用這種方式可以節省傳輸時間。\r<br>\r<br>無狀態:\r<br>無狀態是指協議對於事務處理沒有記憶能力，伺服器不知道客戶端是什麼狀態。&nbsp;我們給伺服器發送HTTP&nbsp;請求之後，伺服器根據請求，會給我們響應數據過來，但發送完,&nbsp;不會記錄任何信息。\r<br>\r<br>原文網址：https://kknews.cc/code/9nxbmj8.html','upload/20200318035842.JPG',2,5,1),(64,'響應狀態碼','2020-03-18 00:00:00',1,'HTTP&nbsp;常見頁面狀態\r<br>\r<br>200&nbsp;OK\r<br>-&nbsp;請求成功&nbsp;\r<br>\r<br>400&nbsp;Bad&nbsp;Request\r<br>-&nbsp;客戶端請求的語法錯誤，伺服器無法解析\r<br>\r<br>403&nbsp;Forbidden\r<br>-&nbsp;通常這個狀態指的是，『禁止』，\r<br>常用在後台網站，或相關任何有設定使用者權限的網站，\r<br>如果沒有授權或失敗，就會顯示此一結果\r<br>\r<br>404&nbsp;Not&nbsp;Found\r<br>-&nbsp;網址或圖片位址有問題，根本沒有那個位置時，\r<br>就會回傳這個狀態碼。\r<br>\r<br>500&nbsp;Internal&nbsp;Server&nbsp;Error\r<br>這個狀態碼，通常指的是伺服器內部錯誤，無法完成請求\r<br>\r<br>502&nbsp;Bad&nbsp;Gateway\r<br>這個狀態通常是網路問題，\r<br>造成的與伺服器連結失敗\r<br>\r<br>503&nbsp;Service&nbsp;Unavailable\r<br>如果網站，因為大量&nbsp;loading&nbsp;而滿載','upload/20200318040017.JPG',1,5,1),(65,'CSRF','2020-03-18 00:00:00',3,'CSRF&nbsp;(Cross&nbsp;Site&nbsp;Request&nbsp;Forgery)\r<br>跨站請求偽裝\r<br>step1:　用戶訪問了合法網站A後，服務器返回session&nbsp;ID儲存在用戶瀏覽器的cookie\r<br>step2:&nbsp;再去訪問惡意網站B，然後惡意網站B包含惡意程式碼,&nbsp;冒充該合法用戶（偽造）去向網站A發起請求。\r<br>\r<br>Example:\r<br>攻擊者可以獲取用戶儲存在cookie的session&nbsp;ID,&nbsp;偽裝成員使用者進行需要權限的操作,&nbsp;如刪除&nbsp;轉發資訊&nbsp;轉帳的目的。\r<br>\r<br>防禦方法:\r<br>1.&nbsp;加入驗證碼\r<br>2.&nbsp;驗證來源網址Rerfer\r<br>3.&nbsp;CSRF-token\r<br>4.&nbsp;加入自訂義Header\r<br>\r<br>#&nbsp;form&nbsp;表單&nbsp;CSRF-token&nbsp;方法\r<br>客戶端項服務端發起請求時&nbsp;服務端生成隨機的token碼&nbsp;存在服務端的session&nbsp;當客戶提交數據時&nbsp;也會把相應的token碼提交,&nbsp;&nbsp;服務端驗證session中的token若與提交的不符合,&nbsp;則拒絕該請求,&nbsp;防止CSRF攻擊。\r<br>\r<br>參考自&nbsp;\r<br>https://www.twblogs.net/a/5cff4da3bd9eee14029f7c20\r<br>https://kknews.cc/tech/z633bbl.html','upload/20200318122617.JPG',2,8,1),(66,'XSS','2020-03-18 00:00:00',2,'\r<br>XSS（Cross&nbsp;Site&nbsp;Scripting）\r<br>跨站點腳本攻擊\r<br>將一段JavaScript代碼注入網頁。然後當其他用戶訪問該頁面時，他們將運行駭客編寫的JS代碼來實現一些帳戶控制。\r<br>\r<br>Example:\r<br>step&nbsp;1:&nbsp;惡意攻擊者透過Email或HTTP將構造好的URL提供給用戶\r<br>step&nbsp;2:&nbsp;當用戶點擊或加載頁面時向指定URL發起請求,&nbsp;會同時運行惡意植入的腳本返回數據\r<br>step&nbsp;3:&nbsp;此腳本會將返回數據發送給惡意攻擊者,&nbsp;攻擊者可以獲取用戶資訊\r<br>\r<br>防禦方法:\r<br>步驟1、對所有用戶提交內容進行可靠的輸入驗證，包括對URL、查詢關鍵字、HTTP頭、POST數據等，僅接受指定長度範圍內、採用適當格式、採用所預期的字符的內容提交，對其他的一律過濾。\r<br>步驟2、實現Session標記(session&nbsp;tokens)、CAPTCHA系統或者HTTP引用頭檢查，以防功能被第三方網站所執行。\r<br>步驟3、確認接收的的內容被妥善的規範化，僅包含最小的、安全的Tag(沒有javascript)，去掉任何對遠程內容的引用(尤其是樣式表和javascript)，使用HTTP&nbsp;only的cookie。\r<br>\r<br>參考自&nbsp;\r<br>https://www.twblogs.net/a/5cff4da3bd9eee14029f7c20\r<br>https://kknews.cc/tech/z633bbl.html','upload/20200318122547.JPG',1,8,1),(67,'SQL&nbsp;injection','2020-03-18 00:00:00',0,'SQL&nbsp;注入（SQL&nbsp;injection）利用了網路程式（Web&nbsp;apps）的錯誤輸入。駭客可以透過執行後端資料庫的網路程式，惡意繞過&nbsp;SQL&nbsp;指令。\r<br>\r<br>SQL&nbsp;注入能在未授權的情況下，直接從資料庫訪問資料庫與檢索信息。許多數據洩露肇因於&nbsp;SQL&nbsp;注入。\r<br>\r<br>\r<br>Authorization&nbsp;Bypass（略過權限檢查）\r<br>\r<br>原SQL語句\r<br>\"SELECT&nbsp;Count(*)&nbsp;FROM&nbsp;Users&nbsp;WHERE&nbsp;Username=\'&nbsp;admin&nbsp;\'&nbsp;AND&nbsp;Password=\'&nbsp;passwd123&nbsp;\'&nbsp;\";\r<br>\r<br>惡意注入後\r<br>\"SELECT&nbsp;Count(*)&nbsp;FROM&nbsp;Users&nbsp;WHERE&nbsp;Username=\'&nbsp;admin&nbsp;\'&nbsp;AND&nbsp;Password=\'&nbsp;anything&nbsp;\'or\'1\'=\'1&nbsp;\'&nbsp;\";\r<br>\r<br>因此會繞過權限驗證,&nbsp;FALSE&nbsp;OR&nbsp;TRUE&nbsp;的比較結果是&nbsp;TRUE，認證因而成功通過。\r<br>\r<br>\r<br>Injecting&nbsp;SQL&nbsp;Sub-Statements&nbsp;into&nbsp;SQL&nbsp;Queries（注入&nbsp;SQL&nbsp;子語法）\r<br>\r<br>Example&nbsp;A.&nbsp;http://www.mydomain.com/products/products.asp?productid=123;&nbsp;DROP&nbsp;TABLE&nbsp;Products;\r<br>>>>&nbsp;在上面的&nbsp;URL&nbsp;中在&nbsp;productid=123&nbsp;後面加上一個分號&nbsp;;，並加上&nbsp;DROP&nbsp;TABLE&nbsp;Products&nbsp;這個&nbsp;sub&nbsp;command會命令&nbsp;SQL&nbsp;server&nbsp;將&nbsp;Products&nbsp;這個&nbsp;Table&nbsp;刪除掉\r<br>\r<br>Example&nbsp;B.&nbsp;http://www.mydomain.com/products/products.asp?productid=123&nbsp;UNION&nbsp;SELECT&nbsp;Username,&nbsp;Password&nbsp;FROM&nbsp;USERS;\r<br>>>>其中&nbsp;UNION&nbsp;能將兩個&nbsp;SELECT&nbsp;的結果用一個結果集呈現出來，而第二個&nbsp;SELECT&nbsp;是將&nbsp;USERS&nbsp;這個&nbsp;Table&nbsp;的&nbsp;Username&nbsp;與&nbsp;Password&nbsp;呈現出來\r<br>\r<br>\r<br>Exploiting&nbsp;Stored&nbsp;Procedures（利用預存程序）\r<br>\r<br>Example&nbsp;C.\r<br>SomeAsp.asp?city=pune\';EXEC&nbsp;master.dbo.xp_cmdshell\'&nbsp;cmd.exe&nbsp;dir&nbsp;c:\r<br>>>>&nbsp;Stored&nbsp;Procedures（預存程序）是將又臭又長又常用的&nbsp;SQL&nbsp;語法寫成一組程序並儲存起來，以供後續呼叫相同程序時不必再將完整個&nbsp;SQL&nbsp;語法重打一次，攻擊者亦可透過呼叫這些&nbsp;Stored&nbsp;Procedures&nbsp;進而對&nbsp;DataBase&nbsp;進行攻擊\r<br>\r<br>\r<br>防範方法\r<br>使用&nbsp;Regular&nbsp;expression&nbsp;驗證過濾輸入值與參數中惡意代碼，將輸入值中的單引號置換為雙引號。\r<br>限制輸入字元格式並檢查輸入長度。\r<br>資料庫設定使用者帳號權限，限制某些管道使用者無法作資料庫存取。\r<br>\r<br>參照自\r<br>https://developer.mozilla.org/zh-TW/docs/Glossary/SQL_Injection\r<br>https://ithelp.ithome.com.tw/articles/10189201','upload/20200318122938.JPG',2,8,1),(68,'TCP&UDP','2020-03-19 00:00:00',0,'基於tcp協議的數據傳輸\r<br>\r<br>傳輸特徵：提供可靠的數據傳輸，可靠性指數據傳輸過程中無丟失，無失序，無差錯，無重複。\r<br>\r<br>實現手段：數據傳輸中斷前都需要進行傳輸和交替的確認\r<br>\r<br>三次握手：tcp傳輸在數據傳輸前建立連接的過程\r<br>1.客戶端向服務器發送連接請求\r<br>2.服務器收到請求後，恢復確認消息，表示允許連接\r<br>3.客戶端收到服務器恢復，進行最終標誌發送確認連接\r<br>\r<br>四次揮手：tcp傳輸在連接交替前進行替換確認的過程\r<br>1.主動發封包告知被動方要交替連接\r<br>2.被動方收到請求後立即返回封包認識已經準備就緒\r<br>3.被動方准備就緒後再次發送封包知道可以重置\r<br>4.主動方發送消息，確認最終中斷\r<br>\r<br>應用情況：適用於傳輸傳輸的文件，網絡情況良好，需要保證傳輸可靠性的情況。\r<br>例如：網頁的獲取，文件下載，郵件傳輸，登錄註冊\r<br>\r<br>握手過程中傳送的包裏不包含數據，三次握手完畢後，客戶端與服務器才正式開始傳送數據。理想狀態下，TCP連接一旦建立，在通信雙方中的任何一方主動關閉連接之前，TCP&nbsp;連接都將被一直保持下去。\r<br>\r<br>基於udp協議的傳輸\r<br>\r<br>傳輸特點：不保證傳輸的可靠性，傳輸過程沒有連接和交替的流程，數據收發自由。\r<br>\r<br>使用情況：網絡情況較差，對傳輸可靠性要求不高，需要提高傳輸效率。不便連接，需要靈活收發消息。\r<br>例如：網絡直播，群組聊天，廣播發送','upload/20200319045139.JPG',2,5,1),(69,'Git&nbsp;merge','2020-03-22 00:00:00',1,'git&nbsp;merge&nbsp;&lt;branch>&nbsp;>>>&nbsp;把該分支合併到當前分支\r<br>類似於git&nbsp;pull&nbsp;&lt;origin>&nbsp;&lt;branch>','upload/20200322062656.JPG',1,6,1),(70,'Git&nbsp;tag','2020-03-22 00:00:00',0,'###&nbsp;tag&nbsp;等同於某個分支的commid&nbsp;id\r<br>\r<br>git&nbsp;tag&nbsp;-a&nbsp;&lt;tagName>&nbsp;-m&nbsp;\"comment\"&nbsp;>>>&nbsp;將當前指向的head&nbsp;設置標籤\r<br>\r<br>git&nbsp;tag&nbsp;>>>&nbsp;查看所有標籤\r<br>\r<br>git&nbsp;show&nbsp;>>>&nbsp;觀看tag內容\r<br>\r<br>git&nbsp;tag&nbsp;&lt;tagName>&nbsp;&lt;commit&nbsp;id>&nbsp;&nbsp;>>>&nbsp;設置標籤指向此commit&nbsp;id\r<br>\r<br>git&nbsp;tag&nbsp;-d&nbsp;&lt;tagName>&nbsp;>>>&nbsp;刪除此標籤\r<br>\r<br>若要生成此tag的新分支\r<br>Method&nbsp;1\r<br>步驟一&nbsp;git&nbsp;checkout&nbsp;&lt;tagName>&nbsp;>>>&nbsp;切換到此標籤的位置&nbsp;&nbsp;>>>&nbsp;步驟二&nbsp;git&nbsp;checkout&nbsp;-b&nbsp;&lt;新分支名>&nbsp;>>>&nbsp;將此標籤的coomit&nbsp;生成新的分支v\r<br>\r<br>Method&nbsp;2\r<br>git&nbsp;checkout&nbsp;-b&nbsp;新分支名&nbsp;&lt;tagName>&nbsp;or&nbsp;&lt;commit&nbsp;id>&nbsp;\r<br>Ex.&nbsp;git&nbsp;checkout&nbsp;-b&nbsp;version1.6&nbsp;v1.6\r<br>or&nbsp;\r<br>git&nbsp;checkout&nbsp;-b&nbsp;version1.6&nbsp;d234fsdafd223422232fsd222222de3\r<br>','upload/20200322062741.JPG',2,6,1),(71,'Git&nbsp;remote','2020-03-22 00:00:00',2,'創建遠程倉庫&nbsp;>>>&nbsp;&nbsp;Git&nbsp;init&nbsp;-bare\r<br>\r<br>添加遠程倉庫方法\r<br>1.&nbsp;git&nbsp;remote&nbsp;add&nbsp;&lt;origin遠程倉庫名>&nbsp;&lt;遠程地址>\r<br>\r<br>2.&nbsp;git&nbsp;fetch&nbsp;刷新遠程隱藏分支(以紅色顯示)&nbsp;>>>&nbsp;透過git&nbsp;branch&nbsp;-a&nbsp;可以看到\r<br>\r<br>3.1&nbsp;抓取遠程分支\r<br>a.&nbsp;git&nbsp;pull&nbsp;&lt;origin>&nbsp;&lt;branch>&nbsp;>>>&nbsp;透過遠程倉庫&lt;origin>拉取遠程分支&lt;branch>\r<br>b.&nbsp;git&nbsp;checkout&nbsp;-b&nbsp;&lt;新分支名>&nbsp;&lt;遠程倉庫origin/遠程分支master>&nbsp;>>>&nbsp;在本地抓取遠程生成新分支\r<br>\r<br>3.2&nbsp;\r<br>a.&nbsp;git&nbsp;branch&nbsp;--set-upstream-to=origin/master&nbsp;master&nbsp;>>>&nbsp;設定本地master&nbsp;連結到遠程的origin/master\r<br>b.&nbsp;git&nbsp;push&nbsp;--set-upstream&nbsp;&lt;遠程倉庫origin>&nbsp;&lt;本地branch>&nbsp;&nbsp;>>>&nbsp;&nbsp;推送本地分支到遠程倉庫\r<br>\r<br>4.&nbsp;git&nbsp;branch&nbsp;-D&nbsp;&lt;branch>&nbsp;>>>&nbsp;刪除本地分支\r<br>git&nbsp;push&nbsp;origin&nbsp;--delete&nbsp;&lt;新的分支>\r<br>\r<br>5.&nbsp;本地&nbsp;commit&nbsp;數&nbsp;>&nbsp;遠程&nbsp;commit&nbsp;數&nbsp;>>>&nbsp;使用&nbsp;git&nbsp;push\r<br>遠程&nbsp;commit&nbsp;數&nbsp;>&nbsp;本地&nbsp;commit&nbsp;數&nbsp;>>>&nbsp;使用&nbsp;git&nbsp;pull\r<br>本地&nbsp;commit&nbsp;數&nbsp;==&nbsp;遠程&nbsp;commit&nbsp;數&nbsp;但有差異>>&nbsp;先用pull&nbsp;來merge遠程分支進來&nbsp;再push上去\r<br>\r<br>6.&nbsp;\r<br>a.&nbsp;git&nbsp;pull&nbsp;-f&nbsp;>>>&nbsp;遠程及本地發生衝突則以遠程強制取代本地\r<br>b.&nbsp;git&nbsp;push&nbsp;-f&nbsp;>>>&nbsp;本地及遠程發生衝突則以本地強制取代遠程\r<br>-----------------------------------------------------------\r<br>','upload/20200322062840.JPG',2,6,1),(72,'Git&nbsp;reset','2020-03-23 00:00:00',1,'head:所在位置\r<br>index:變更狀態紀錄\r<br>working&nbsp;tree:工作狀態\r<br>\r<br>Git&nbsp;reset&nbsp;&lt;filename>&nbsp;>>>&nbsp;取消暫存區的狀態\r<br>\r<br>Git&nbsp;reset&nbsp;&lt;commit&nbsp;id>&nbsp;--hard&nbsp;>>>&nbsp;目前的HEAD跟目前的分支&nbsp;移到指定的&nbsp;commit&nbsp;上,&nbsp;工作目錄跟暫存區&nbsp;完全回到此版本。\r<br>\r<br>Git&nbsp;reset&nbsp;--hard&nbsp;HEAD^&nbsp;>>>&nbsp;完全回到上一個版本,&nbsp;\r<br>丟棄當前commmit,&nbsp;add及工作目錄改動\r<br>\r<br>(預設)&nbsp;Git&nbsp;reset&nbsp;--mixed&nbsp;HEAD^&nbsp;>>>&nbsp;丟棄當前commmit,&nbsp;add\r<br>\r<br>Git&nbsp;reset&nbsp;--soft&nbsp;HEAD^&nbsp;>>>&nbsp;丟棄當前commmit\r<br>\r<br>\r<br>\r<br>+-----------+------------+------------+--------------+\r<br>|&nbsp;&nbsp;&nbsp;mode&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;head&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;index&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;working&nbsp;tree&nbsp;|\r<br>+-----------+------------+------------+--------------+\r<br>|&nbsp;&nbsp;&nbsp;soft&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;changed&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;unchanged&nbsp;|&nbsp;&nbsp;unchanged&nbsp;&nbsp;&nbsp;|\r<br>|&nbsp;&nbsp;&nbsp;mixed&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;changed&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;changed&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;unchanged&nbsp;&nbsp;&nbsp;|\r<br>|&nbsp;&nbsp;&nbsp;hard&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;changed&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;changed&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;changed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|\r<br>+-----------+------------+------------+--------------+\r<br>\r<br>\r<br>再做一個新的&nbsp;Commit，來取消你不要的&nbsp;Commit&nbsp;的概念\r<br>git&nbsp;revert&nbsp;HEAD&nbsp;--no-edit&nbsp;>>>&nbsp;生成新的commit&nbsp;內容是反轉回上一個提交的內容\r<br>\r<br>如果對於多人共同協作的專案，也許因為團隊開發的政策，你不一定有機會可以使用&nbsp;Reset&nbsp;指令，這時候就可以&nbsp;Revert&nbsp;指令來做出一個「取消」的&nbsp;Commit，對其它人來說也不算是「修改歷史」，而是新增一個&nbsp;Commit，只是剛好這個&nbsp;Commit&nbsp;是跟某個&nbsp;Commit&nbsp;反向的操作而已。\r<br>\r<br>git&nbsp;rebase&nbsp;-i&nbsp;&lt;需更動順序之前的commit&nbsp;id>&nbsp;&nbsp;>>>&nbsp;進入rebase&nbsp;文件內&nbsp;修改為編輯模式edit&nbsp;>>>&nbsp;git&nbsp;commit&nbsp;--amend&nbsp;>>>&nbsp;進入文件內修改commit&nbsp;註釋\r<br>\r<br>git&nbsp;rebase&nbsp;-i&nbsp;&lt;需更動順序之前的commit&nbsp;id>&nbsp;>>>&nbsp;git&nbsp;reset&nbsp;--soft&nbsp;HEAD&nbsp;>>>git&nbsp;reset&nbsp;>>>&nbsp;重新commit生成新的commit&nbsp;>>>&nbsp;進入rebase&nbsp;文件內&nbsp;調整commit&nbsp;順序','upload/20200323061508.JPG',2,6,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='用戶訊息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'x20911x','Sam','x20911x@gmail.com',NULL,'a123456','user_personal_images/Sam.jpg',1),(2,'weiye','老嘉','weimz@163.com',NULL,'a123456','user_personal_images/Default.JPG',0),(3,'lvye','法銓','lvye@163.com',NULL,'a123456','user_personal_images/Default.JPG',0),(4,'chen','chen','x20911x@gmail.com','http://www.google.com','a123456','user_personal_images/20200217152312.png',0),(5,'tony','tony','x20911x@gmail.com','http://www.yahho.com','a123456',NULL,0),(6,'ken','ken','x20911x@gmail.com','http://www.google.com','a123456','user_personal_images/20200217154548.jpg',0),(7,'john','john','x20911x@outlokk.com','http://www.google.com','a123456','user_personal_images/20200217154744.jpg',0),(8,'a','a','x20911x@outlokk.com','http://www.google.com','a',NULL,0),(9,'b','b','x20911x@outlokk.com','http://www.google.com','a','user_personal_images/Default.JPG',0),(11,'marker1232','阿皓','x20911x@gmail.com','https://www.yahoo.com.tw','a123456','user_personal_images/20200331073434.JPG',0);
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

-- Dump completed on 2020-04-07  1:32:24
