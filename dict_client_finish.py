# name: Zhi-Yan Chen
# email: x20911x@gmail.com
from socket import *
import os,sys

def main():
	# 創建立socket
	s = socket()
	HOST = sys.argv[1]
	POST = int(sys.argv[2])
	ADDR = (HOST,POST)
	# 建立連接
	s.connect(ADDR)


	while True:
		print('''\t\t\t===========Welcome===========\n\
			--1.register 2.login 3.quit--\n\
			=============================''')
		try:
			cmd = input('請輸入 1).注册 2).登录 3).退出')
		except KeyboardInterrupt:
			s.close()
			sys.exit('客戶退出')
		except Exception as e:
			print(e)
	# 使用者註冊
		if cmd == '1':
			win, name = do_register(s)
			if win:
				# 註冊成功, 則進入二級選單界面
				print('%s註冊成功'% name)
				do_login_v2(s,name)
			else:
				print('%s註冊失敗'% name)
				continue
	# 使用者登錄
		elif cmd == '2':
			win, name = do_login(s)
			if win:
				# 若登錄成功, 則進入二級選單界面 
				print('%s登錄成功'% name)
				do_login_v2(s,name)
			else:
				# 若登錄失敗, 則回到選單 
				print('%s登錄失敗'% name)
				continue

		elif cmd == '3':
			s.send(b'E')
			sys.exit("退出")
		else:
			print("請再次輸入")
			continue


def do_register(s):

	name = input("Register user name: ")
	while True:
		passwd = input("input the passwd")
		if ' ' in passwd:
			print('請勿輸入空格')
			continue
		passwd2 = input("input the passwd again")
		if passwd != passwd2:
			print('密碼不一致')
		else:
			break
	# 帳號密碼完成則發生給服務端
	msg = 'R {} {}'.format(name,passwd)
	s.send(msg.encode())

	# 接收服務端確認訊息
	data = s.recv(1024).decode()
	if data == 'OK':
		# print('註冊成功')
		return True,name
	elif data == 'exists':
		print('用戶已經存在')
		return False,name
	else:
		return False,name



def do_login(s):
	name = input('input user\'s name')

	while True:
		passwd = input("input the passwd")
		if ' ' in passwd:
			print('請勿輸入空格')
			continue
		break
	msg = 'L {} {}'.format(name,passwd)
	s.send(msg.encode())

	# 接收服務端確認訊息
	data = s.recv(1024).decode()
	if data == 'OK':
		
		return (True,name)
	else:
		
		return (False,name)

# 二級選單界面
def do_login_v2(s,name):
	while True:
		print('''
	==========查询界面==========
	1.查词    2.历史记录   3.退出
	===========================''')
		try:
			cmd = input('''請輸入1).查词2).历史记录3).退出''')
		except KeyboardInterrupt:
			s.close()
			sys.exit('客戶退出')
		except Exception as e:
			print(e)
		if cmd == '1':
			do_query(s,name)
		elif cmd == '2':
			do_hist(s,name)
		elif cmd == '3':
			return



def do_query(s,name):
	while  True:
		word = input('請輸入您要查詢的單詞>>')
		# 發送要查詢的單詞 並付上姓名 目的
		msg = 'Q {} {}'.format(name, word)
		s.send(msg.encode())

		# 接收單詞的解釋
		data = s.recv(1024).decode()
		print('%s >>> %s' % (word, data))


def do_hist(s,name):
	print('歡迎來到歷史查訊功能, 請輸入您要查訊的依據')
	while True:
	# 選擇查詢的依據
		cmd = input('1).user 2).word 3).time: 4). all')
		if cmd == '1':
			user = input('user >>>')
			# s.send(user.encode())
			uwt = user
			break
		elif cmd == '2':
			word = input('word >>>')
			# s.send(word.encode())
			uwt = word
			break
		elif cmd == '3':
			time = input('time and data \
				(ex. 202001032109) >>>')
			# s.send(time.encode())
			uwt = time
			break
		elif cmd == '4':
			s.send(b'H all all')
			# 不執行下面的程序
			break
		else:
			continue
	# 發送查詢請求 並付上使用者姓名 依據
	if cmd != '4':
		msg = 'H {} {}'.format(name, uwt)
		s.send(msg.encode())
	# 接收服務端確認訊息
	while True:
		data = s.recv(1024).decode()
		if data == 'OK':
			break
		else:
			print(data)
			if data == '未查詢到相關紀錄':
				return

if __name__ =='__main__':
	main()













