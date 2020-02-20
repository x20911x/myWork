# 多程序 Multi-Process 英英電子辭典

### 使用技術
  * Server端
	* Websocket
	* mulit-Process
	* MySQL
	* pymysql模組
  * Client端
    * Websocket

### 功能說明

服務端:
1. Parent process程序處理客戶端連接及創立一級子進程
  * 註冊
  * 登陸
  * 字典查詢
  * 歷史紀錄查詢

客戶端
2. 子進程處理一級介面功能,
  * 註冊
  * 登陸
  * 字典查詢
  * 歷史紀錄查詢



