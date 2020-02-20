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
			cmd = input('請輸入 1).註冊 2).登入 3).退出 >>> ')
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

	name = input("請輸入用戶名: ")
	# 判斷兩次密碼是否相同
	while True:
		passwd = input("請輸入密碼:")
		if ' ' in passwd:
			print('請勿輸入空格')
			continue
		passwd2 = input("請在一次輸入密碼:")
		if passwd != passwd2:
			print('密碼不一致')
		else:
			break
	# 帳號密碼完成則發給服務端, 請求服務端進行註冊處理
	msg = 'R {} {}'.format(name,passwd)
	s.send(msg.encode())

	# 接收服務端確認訊息
	data = s.recv(1024).decode()
	# 用戶註冊成功
	if data == 'OK':
		return True,name
	# 用戶已存在
	elif data == 'exists':
		print('用戶已經存在')
		return False,name
	# 註冊異常
	else:
		return False,name



def do_login(s):
	name = input('請輸入用戶名:')

	while True:
		passwd = input("請輸入密碼:")
		if ' ' in passwd:
			print('請勿輸入空格:')
			continue
		break

	# 帳號密碼完成則發給服務端, 請求服務端進行登入處理
	msg = 'L {} {}'.format(name,passwd)
	s.send(msg.encode())

	# 接收服務端確認訊息
	data = s.recv(1024).decode()

	# 在user表查到用戶資訊, 回傳OK
	if data == 'OK':
		return (True,name)

	# 若查不到該用戶的數據
	else:	
		return (False,name)


# 二級選單界面
def do_login_v2(s,name):
	while True:
		print('''
	==========查詢界面==========
	1.查詢    2.歷史紀錄   3.退出
	===========================''')
		try:
			cmd = input('''請輸入 1).查單詞 2).歷史紀錄 3).退出 >>>''')
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
		exit = input('是否繼續查詢 1)是 2)否：')
		if exit == '1':
			continue
		else:
			break


def do_hist(s,name):
	print('歡迎來到歷史查訊功能, 請輸入您要查訊的依據')
	while True:
	# 選擇查詢的依據
		cmd = input('1).user 2).word 3).time: 4). all')
		if cmd == '1':
			uwt = input('user >>>')
			break
		elif cmd == '2':
			uwt = input('word >>>')
			break
		elif cmd == '3':
			uwt = input('time and data (ex. 202001032109) >>>')
			break
		elif cmd == '4':
			s.send(b'H all all')
			break
		else:
			continue

	# 發送查詢請求 並附上使用者姓名 依據
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













