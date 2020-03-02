from flask import render_template, request, session, redirect, jsonify
import json, time, datetime, os, pdb
# import the Blueprint to form url
from . import main

from . import views_tool

# import db to use databases
from .. import db
# from .manage import db

# import attribute class to use database
from ..models import *

from . import views


def every_views():
	# 獲取server端的session是否有登錄過的資訊
	uname = '' # 確保沒有cookie and sesseion的時候, 可以在return的位置傳參
	if 'uid' in session and 'uname' in session:
		uname = session.get('uname')
		# use user to identify
		# user = User.query.filter_by(id=session['uid']).first()
	
	# 獲取client端的cookie是否有登錄過的資訊
	elif 'uid' in request.cookies and 'uname' in request.cookies:
		# 將cookies的uid, uname 重新存入session
		session['uid'] = request.cookies['uid']
		session['uname'] = request.cookies['uname']
		uname = request.cookies.get('uname')
		# use user to identify
		# user = User.query.filter_by(id=request.cookies['uid']).first()

	# 查詢所有文章以用於特別推薦
	topics = Topic.query.all()
	# print(topics)
	# 查看用於點擊排行榜的文章, 並根據閱讀量以降序排列
	from sqlalchemy import text
	topics_desc = Topic.query.order_by(text('read_num desc')).all()

	return (uname,topics,topics_desc)


def file_views(rf):
	# 獲取上傳圖片的名稱
	filename = rf.filename

	# 獲取圖片格式
	ext = filename.split('.')[-1]

	# 獲取日期時間作為檔案名稱
	date_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
	time_list = date_time.split(' ')
	time_list = time_list[0].split('-')+time_list[1].split(':')
	filename1 = ''.join(time_list)

	# 組合檔案名
	filename = filename1 + '.' + ext

	return (filename,rf)


# 確認是否為有人註冊過這個名子
def check_loginname(user):
	if user:
		data = json.dumps({
	  'msg' : '此帳戶已經有人註冊'
	})
	else:
		data = json.dumps({
	  'msg' : '此帳號可以使用'
	})
	return data


# 確認兩次密碼是否一致
def password_check(password,password2):
	if password == password2:
		data = json.dumps({
	  'msg' : None
	})
	else:
		data = json.dumps({
	  'msg' : '密碼不一致'
	})
	return data

# 文字存入資料庫的轉換處理 以正常渲染到模板上
def text_to_database(content):
	# < 以&lt; 替代 > 以&gt; 替代
	content = '&lt;'.join(content.split('<'))
	# content = '&gt;'.join(content.split('>'))
	# 將獲取到的 "換行" 替換成 "br標簽"
	content = '<br>'.join(content.split('\n'))
	# 將獲取到的 "空格" 替換成 "&nbsp標簽"
	content = '&nbsp;'.join(content.split(' '))
	return content


# 文字從資料庫取出的預處理
def database_to_text(content):
	# 將獲取到的 "br標簽" 替換成 "換行" 
	content = '\n'.join(content.split('<br>'))	
	# 將獲取到的 "&lt;標簽" 替換成 "<"
	content = '<'.join(content.split('&lt;'))	
	# 將獲取到的 "&nbsp標簽" 替換成 "空格"
	content = ' '.join(content.split('&nbsp;'))
	return content

