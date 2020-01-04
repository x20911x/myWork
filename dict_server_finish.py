# name: Zhi-Yan Chen
# email: x20911x@gmail.com
from socket import *
import os,sys,pymysql,time,signal


def main():

	# 建立數據庫連接
	db = pymysql.connect('localhost','root',\
		'a123456', 'project_dict')


	HOST = sys.argv[1]
	POST = int(sys.argv[2])
	ADDR = (HOST,POST)
	# 創建立socket
	s = socket()
	s.setsockopt(SOL_SOCKET,SO_REUSEADDR,1)
	s.bind(ADDR)
	s.listen()
	print('監聽中等待客戶端連接')
	signal.signal(signal.SIGCHLD,signal.SIG_IGN)

	while True:
		try:

			c, addr = s.accept()
			print('connecting from', addr)
		except KeyboardInterrupt:
			s.close()
			sys.exit('服務器退出')
		except Exception as e:
			print(e)
			continue
		pid = os.fork()
		if pid == 0:
			s.close()
			do_child(c,db)

			sys.exit('子進程退出')

		else:
			c.close()
			continue



def do_child(c,db):
	# try:
	while True:
		try:
			print('等待client端指示')
			# print(c)
			time.sleep(1)
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


	name = data[1]
	passwd = data[2]

	cursor = db.cursor()

	sql = "select * from user where name = '{}';".format(name)
	cursor.execute(sql)
	r = cursor.fetchone()

	if r != None:
		c.send(b'exists') 
		return
	# 將用戶填入資料庫
	sql = "insert into user(name, passwd) values('%s','%s');" % (name,passwd)
	try:
		cursor.execute(sql)
		db.commit()
		# 順利將使用者資訊插入數據庫, 回傳OK
		c.send(b'OK')
	except:
		db.rollback()


def do_login(c,db,data):

	name = data[1]
	passwd = data[2]
	print('name:',name,'passwd',passwd)

	# 判斷是否在資料庫內
	cursor = db.cursor()
	sql = 'select * from user where\
	 name = "%s" and passwd = "%s";' %(name,passwd)
	cursor.execute(sql)
	r = cursor.fetchone()

	if r == None:
		print('%s登錄失敗'% name)
		c.send(b'##')
	else:
		# 在user表查到用戶資訊, 回傳OK
		print('%s登錄成功'% name)
		c.send(b'OK')

		
def do_query(c,db,data):
	name = data[1]
	word = data[2]
	
	cursor = db.cursor()
	# 搜尋單詞解釋並回傳客戶端
	sql = "select interpret from words where \
	word = '{}'".format(word)

	cursor.execute(sql)	

	r = cursor.fetchone()
	if r != None:
		print(r,type(r))
		interpret = r[0]
		c.send(interpret.encode())
	else:
		print(r,type(r))
		c.send('查無此字'.encode())
		return
	# 存儲查詢紀錄
	sql2 = "insert into inquiry_record(name, word\
	) values('{}', '{}')".format(name,word)
	try:
		cursor.execute(sql2)
		db.commit()
		print('查詢紀錄已存')
	except:
		db.rollback()



def do_hist(c,db,data):
	name = data[1]
	uwt = data[2]

	cursor = db.cursor()
	if name == 'all' or uwt == 'all':
		sql = "select * from inquiry_record;"
	else:
		sql = "select * from inquiry_record \
		where name = '{}' or word = '{}'\
		or time = '{}';".format(uwt, uwt, uwt)

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











