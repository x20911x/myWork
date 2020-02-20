# name: Zhi-Yan Chen
# email: x20911x@gmail.com
from socket import *
import os,sys,pymysql,time,signal


def main():

	# 建立數據庫連接
	db = pymysql.connect('localhost','root',\
		'a123456', 'project_dict')

	# 設定欲連接的ip及端口號
	HOST = sys.argv[1]
	POST = int(sys.argv[2])
	ADDR = (HOST,POST)

	# 創建立socket使用網路套接字類型AF_INET, 流式套接字SOCK_STREAM(Tcp協議)
	s = socket()

	#設置端口立即釋放
	s.setsockopt(SOL_SOCKET,SO_REUSEADDR,1)

	# socket榜定欲連接的ip及端口號
	s.bind(ADDR)

	# 設置監聽socket, 開始監聽tcp傳入"連接動作"
	s.listen()
	print('監聽中等待客戶端連接')

	# 在父進程中忽略子進程狀態改變,子進程退出自動由系統處理
	signal.signal(signal.SIGCHLD,signal.SIG_IGN)

	while True:
		# 阻塞程序, 接著等待接收客戶端連線, 
		# 連線後 返回客戶端套接字socket和客戶端地址
		# 使用異常處理確保持續監聽客戶端套接字		
		try:
			c, addr = s.accept()
			print('connecting from', addr)
		except KeyboardInterrupt:
			s.close()
			sys.exit('服務器退出')
		except Exception as e:
			print(e)
			continue

		# 創建立父子進程 子進程處理客戶端訊息客戶的登錄 註冊 字典查詢等功能
		pid = os.fork()
		# 子進程：
		if pid == 0:
			# 關閉父進程socket套接字
			s.close()
			# 調用子進程處理函數
			do_child(c,db)
			sys.exit('子進程退出')
		
		# 父進程：關閉父進程socket套接字
		else:
			# 關閉客戶端
			c.close()
			# 持續阻塞, 等待客戶端的連線
			continue


def do_child(c,db):
	# try:
	while True:
		try:
			print('等待client端指示')
			time.sleep(1)

			# 接收客戶端請求
			data = c.recv(1024).decode()	
			data = data.split(' ')
			if data[0] == 'E' or data[0] == '': # ['']為空值
				c.close()
				sys.exit('客戶端退出')
			elif data[0] == 'R':
				do_register(c,db,data)
			elif data[0] == 'L':
				do_login(c,db,data)
			elif data[0] == 'Q':
				do_query(c,db,data)
			elif data[0] == 'H':
				do_hist(c,db,data)
			else:
				continue
		except KeyboardInterrupt:
			c.close()
			sys.exit('server端退出')
		except Exception as e:
			print(e)
			continue




def do_register(c,db,data):
	# 獲取用戶端輸入的註冊姓名及密碼
	name = data[1]
	passwd = data[2]

	# 創建用於數據庫交互的光標物件
	cursor = db.cursor()

	# 執行查詢語句
	sql = "select * from user where name = '{}';".format(name)
	cursor.execute(sql)
	r = cursor.fetchone()

	# 若此用戶名已經註冊在數據庫中, 則返回exists
	if r != None:
		c.send(b'exists') 
		return
	# 將用戶填入資料庫
	sql = "insert into user(name, passwd) values('%s','%s');" % (name,passwd)
	try:
		# 執行SQL語句
		cursor.execute(sql)
		db.commit()

		# 順利將使用者資訊插入數據庫, 回傳OK
		c.send(b'OK')
	except:
		# 若出現異常則回滾
		db.send(b'fail')
		db.rollback()


def do_login(c,db,data):
	# 獲取用戶端輸入的用戶登入姓名及密碼
	name = data[1]
	passwd = data[2]
	print('name:',name,'passwd',passwd)

	# 創建用於數據庫交互的光標物件
	# 判斷用戶是否在資料庫內
	cursor = db.cursor()
	sql = 'select * from user where\
	 name = "%s" and passwd = "%s";' %(name,passwd)
	
	# 執行SQL語句
	cursor.execute(sql)
	r = cursor.fetchone()

	# 若查不到該用戶的數據
	if r == None:
		print('%s登錄失敗'% name)
		c.send(b'##')

	# 在user表查到用戶資訊, 回傳OK
	else:
		print('%s登錄成功'% name)
		c.send(b'OK')

		
def do_query(c,db,data):
	# 獲取用戶端輸入的用戶姓名及查詢單詞
	name = data[1]
	word = data[2]
	
	# 創建用於數據庫交互的光標物件
	cursor = db.cursor()

	# 搜尋單詞解釋並回傳客戶端
	sql = "select interpret from words where \
	word = '{}'".format(word)

	# 執行SQL語句
	cursor.execute(sql)

	# 獲得查詢結果元祖
	r = cursor.fetchone()

	# 若查詢到該單詞則返回該單詞解釋的元祖
	if r != None:
		interpret = r[0]
		c.send(interpret.encode())
	else:
		c.send('查無此字'.encode())
		return

	# 存儲查詢紀錄
	sql2 = "insert into inquiry_record(name, word\
	) values('{}', '{}')".format(name,word)
	try:
		# 執行SQL語句
		cursor.execute(sql2)
		db.commit()

		# 順利將使用者資訊插入數據庫
		print('查詢紀錄已存')
	except:
		# 若出現異常則回滾
		db.rollback()



def do_hist(c,db,data):
	# 獲取用戶端輸入的用戶姓名及查詢歷史紀錄
	name = data[1]
	uwt = data[2]

	# 創建用於數據庫交互的光標物件
	cursor = db.cursor()

	if name == 'all' or uwt == 'all':
		sql = "select * from inquiry_record;"
	else:
		sql = "select * from inquiry_record \
		where name = '{}' or word = '{}'\
		or time = '{}';".format(uwt, uwt, uwt)

	# 執行SQL語句
	cursor.execute(sql)

	r = cursor.fetchall()
	print(r,type(r))
	# 判斷有無查詢到紀錄
	if r == tuple():
		c.send('未查詢到相關紀錄'.encode())
	else:
		for i in r:
			# 發送查訊歷史紀錄
			c.send('''user:"{}"\nword:"{}"\ntime:"{}"
				'''.format(i[1],i[2],i[3]).encode())
			time.sleep(0.1)
		else:
			c.send(b'OK')

if __name__ == '__main__':
	main()











