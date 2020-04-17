from flask import render_template, request, session, redirect, jsonify
import json, time, datetime, os, pdb
# import the Blueprint to form url 
# 導入藍圖程序用於創建路由
from . import main
from . import views_tool
# ORM數據庫接口
from .. import db
# import attribute class to use database
from ..models import *


# 網站首頁
@main.route('/')
def main_index():
	# 調用每個頁面都須處理的事情函數every_views
	uname,topics,topics_desc = views_tool.every_views()
	print('topics',topics)
	topics = topics[::-1]
	print('---------')
	print('topics',topics)
	return render_template('index.html',params=locals())

# 登入功能
@main.route('/login',methods=['POST','GET'])
def login_views():
	if request.method == 'GET':
		# 若處於登錄狀態(session or cookie)則直接回到首頁
		if 'uid' in session:
			return redirect('/')
		elif 'uid' in request.cookies:
			session['uid'] = request.cookies['uid']
			session['uname'] = request.cookies['uname']
			return redirect('/')
		return render_template('login.html')

	else:
		# 獲取登錄名與密碼
		loginname= request.form.get('username')
		qpwd = request.form.get('password')
		# 查詢數據庫是否有此用戶
		user = User.query.filter_by(loginname=loginname,upwd=qpwd).first()
		
		# 數據庫中有查詢到此用戶則執行以下代碼
		if user:
			# 生成"響應物件"
			resp = redirect('/')
			# 保存cookie到客戶端
			resp.set_cookie('uid',str(user.id),max_age=60*60*24*365)
			resp.set_cookie('uname',str(user.uname),max_age=60*60*24*365)
			# 將用戶id, uname存入session
			session['uid'] = user.id
			session['uname'] = user.uname
			return resp
		# 數據庫中無查詢到此用戶則執行以下代碼
		else:
			errMsg = "登錄失敗：帳號或密碼有錯"
			return render_template('login.html',errMsg=errMsg)


# 登出功能
@main.route('/sign_out')
def sign_out():
	# 判斷是否有存入session
	if 'uid' in session and 'uname' in session:
		del session['uid'] 
		del session['uname']

	# 判斷是否有瀏覽器是否有登錄資訊
	if 'uid' in request.cookies and 'uname' in request.cookies:
		resp = redirect('/')
		resp.delete_cookie('uid')
		resp.delete_cookie('uname')
		return resp


# 註冊功能
@main.route('/register',methods=['GET','POST'])
def register_views():
	if request.method == 'GET':
		return render_template('register.html')
	else:
		 # 創建user表數據物件
		user = User()
		# 插入數據
		user.loginname = request.form['loginname']
		user.uname = request.form['username']
		user.email = request.form['email']
		user.url = request.form['url']
		user.upwd = request.form['password']

		# 插入頭貼
		rf = request.files.get('picture')

		# 設定預設的圖片
		user.images = 'user_personal_images/Default.JPG'
		if rf:
			print('uploaded file')
			# 取出文件
			filename, f = views_tool.file_views(rf)

			# 處理文件名稱 將文件明賦值給topic.images
			user.images = 'user_personal_images/'+filename
			
			# 將文件保存至服務器
			basedir = os.path.dirname(os.path.dirname(__file__))
			upload_path = os.path.join(basedir,'static/user_personal_images',filename)
			print(upload_path)	
			f.save(upload_path)
			print('firstline>>>>','user_personal_images/' + filename)
	
		db.session.add(user)
		db.session.commit()
		uid = user.id
		print("new user's is %s" % uid)
		session['uid'] = user.id
		session['uname'] = user.uname

		return redirect('/')


# 判斷使用者帳號是否使用過
@main.route('/loginname-check')
def loginname_check_views():

	# 前端發送get請求, 提供querystring回調函數名callback
	cb = request.args.get('callback')
	
	# 前端提供querystring用戶登錄名
	loginname = request.args.get('loginname','not find')

	# 確認是否為有人註冊過這個名子
	user = User.query.filter_by(loginname=loginname).first()
	data = views_tool.check_loginname(user)

	# 組合成js函數名及傳入的參數的字符串
	return cb+"("+data+")"


# 確認兩次密碼是否一致
@main.route('/password-check')
def password_check_views():
	# 前端發送get請求, 提供querystring回調函數名callback
	cb = request.args.get('callback')

	# 前端提供querystring的兩次密碼
	password = request.args.get('password')
	password2 = request.args.get('password2')

	# 確認兩次密碼是否一致
	data = views_tool.password_check(password,password2)
	# 組合成js函數名及傳入的參數的字符串
	return cb+"("+data+")"




# 修改文章
class Update():
	def __init__(self,update):
		self.update = update
		self.user = User.query.filter_by(id=(session.get('uid'))).first()

	def whether_update_or_not(self):
		if self.update:
			return True
		else:
			return False

	def author_right(self):
		# 驗證是否有權限修改文章
		if self.user.is_author != 1 and self.whether_update_or_not():
			# 若非板主點擊修改文章時重定向到該文章頁面
			return True
		else:
			return False

	@staticmethod
	def get_update_topic(topic):
		# -------------------獲取到原本文章的title-------------
		title = views_tool.database_to_text(topic.title)

		# -------------------獲取到原本文章的內文-------------
		content = views_tool.database_to_text(topic.content)

		# -------------------獲取到原本文章的category_id-------------
		category_id = topic.category_id

		# -------------------獲取到原本文章的blogtype_id-------------
		blogtype_id = topic.blogtype_id	

		return title,content,category_id,blogtype_id


	def post_update_topic(self,topic):
		# 文字存入資料庫的轉換處理 以正常渲染到模板上
		# 把修改後的title存入topic表中
		topic.title = views_tool.text_to_database(request.form.get('author'))

		# 獲取修改後的內容存入topic表中 
		topic.blogtype_id = request.form.get('list')
		topic.category_id = request.form.get('category')
		# topic.user_id = request.cookies.get('uid')

		# 文字存入資料庫的轉換處理 以正常渲染到模板上
		# 把修改後的content存入topic表中
		topic.content = views_tool.text_to_database(request.form.get('content'))
		self.upload_file(topic)


	def upload_file(self,topic):
		# 若有夾帶檔案則執行以下代碼
		rf = request.files.get('picture')
		if rf:
			print('uploaded file')
			# 取出文件
			filename, f = views_tool.file_views(rf)

			# 處理文件名稱 將新的文件名賦值給topic.images
			topic.images = 'upload/'+filename
			
			# 獲取當前文件或文件夾的存儲路徑
			basedir = os.path.dirname(os.path.dirname(__file__))

			upload_path = os.path.join(basedir,'static/upload',filename)
			
			# 將文件保存至服務器upload_path的路徑
			f.save(upload_path)

# 發表文章
class Release(Update):
	def __init__(self):
		self.user = User.query.filter_by(id=(session.get('uid'))).first()

	@staticmethod
	def login_status():
		# 獲取server登錄訊息, 驗證是否為用戶
		if 'uid' in session and 'uname' in session:
			uname = session['uname']
		elif 'uid' in request.cookies and 'uname' in request.cookies:
			session['uid'] = request.cookies['uid']
			session['uname'] = request.cookies['uname']	
				
			uname = request.cookies.get('uname')
		# 若非用戶則重定向到登錄頁面
		else:
			redirect('/login')

	@staticmethod
	def top3_topic():
		# 調用每個頁面都須處理的事情函數every_views
		return views_tool.every_views()

	def author_right(self):
		if self.user.is_author != 1:
			# 若非板主則重定向到首頁
			print('i am not author~~~~~~')
			return True
		else:
			return False

	def post_release_topic(self):
		# 創建topic表數據
		topic = Topic()

		# 文字存入資料庫的轉換處理 以正常渲染到模板上
		# 把修改後的title存入topic表中
		topic.title = views_tool.text_to_database(request.form.get('author'))

		# 獲取發表文章資訊相關的內容
		topic.blogtype_id = request.form.get('list')
		topic.category_id = request.form.get('category')
		topic.user_id = session.get('uid')
		topic.pub_date = datetime.datetime.now().strftime("%Y-%m-%d")

		# 文字存入資料庫的轉換處理 以正常渲染到模板上
		# 把修改後的content存入topic表中
		topic.content = views_tool.text_to_database(request.form.get('content'))
		self.upload_file(topic)

		db.session.add(topic)


	# def upload_file(self,topic):
	# 	Update.upload_file(self,topic)
		# topic.save()





# 發表文章或修改文章
@main.route('/release',methods=['POST','GET'])
def release_views():
	if request.method == 'GET':
		R = Release()
		Release.login_status()
		
		# 調用每個頁面都須處理的事情函數every_views
		uname,topics,topics_desc = Release.top3_topic()

		# 驗證是否有權限修改文章
		update_get = request.args.get('update_get')	

		U = Update(update_get)
		R.author_right()

		if U.author_right():
		# 	# 若非板主點擊修改文章時重定向到該文章頁面
			return redirect('/info?topic_id='+str(request.args.get('topic_id')))

		# 驗證是否有權限發表文章
		if R.author_right():
			# 若非板主則重定向到首頁
			return redirect('/')

		# query category and blogtype
		categories = Category.query.all()
		blogTypes = BlogType.query.all()

		########### handle the get for update #############
		# 進入 "發表" or "修改" 文章的處理
		if U.whether_update_or_not():
			# 1. 首先是查詢資料庫該文章的數據, 
			# 2. 渲染到原本的模板後, 在網頁上修改 
			# 3. 按下修改按鈕後, 發起post請求在後端處理新的數據更新到資料庫去, 
			# 最後重定向到觀看頁面info.html
			# 獲取文章的topic_id, 並查詢該文章物件
			topic_id = request.args.get('topic_id')
			
			topic = Topic.query.filter_by(id=topic_id).first()

			title,content,category_id,blogtype_id = Update.get_update_topic(topic)

			#！！！！！！！post端分叉點！！！！！！！ 
			# 用來判斷採取"更新"(有值) 或是 "發布文章 >>> 
			# (有值)採取 >>> "更新" 
			# (空數值)採取 >>> "發布文章(空數值)"
			update_post = 'Y'
			
			return render_template('release.html',params=locals())
		
		########### handle the get for release topic #############
		else:			
			return render_template('release.html',params=locals())
	
	########### handle the post request #############
	else:
		#！！！！！！！重要！！！！！！！ 
		# 用來判斷採取"更新"(有值) 或是 "發布文章
		# (有值)採取 >>> "更新" 
		# (空數值)採取 >>> "發布文章"
		update_post = request.form.get('update_post')
		U = Update(update_post)

		########### handle the post for update topic #############
		if U.whether_update_or_not():

			# 獲取要修改的文章id
			topic_id = request.form.get('topic_id')
			topic = Topic.query.filter_by(id=int(topic_id)).first()

			U.post_update_topic(topic)

			return redirect('/info?topic_id='+str(topic_id))
		########### handle the post for release topic #############
		else:
			R = Release()
			R.post_release_topic()

			return redirect('/')


# 查看文章內容及處理文章留言
@main.route('/info',methods=['GET','POST'])
def info_views():
	if request.method == 'GET':

		# uname >>> 獲取server端的session是否有登錄過的資訊;獲取client端的cookie是否有登錄過的資訊
		# topics >>> 查詢所有文章以用於特別推薦
		# topics_desc >>> 用於點擊排行榜的文章, 並根據閱讀量以降序排列
		uname,topics,topics_desc = views_tool.every_views()

		# 查看要看的部落格訊息
		topic_id = int(request.args.get('topic_id'))
		topic = Topic.query.filter_by(id=topic_id).first()

		# 更新閱讀次數
		topic.read_num = int(topic.read_num) + 1
		db.session.add(topic)

		#上一篇: 查詢topic_id比當前topic_id數值小的最後一條數據
		from sqlalchemy import text
		prevTopic = Topic.query.filter(Topic.id<topic_id).order_by(text('id desc')).first()

		#下一篇: 查詢topic_id比當前topic_id數值大的第一條數據
		nextTopic = Topic.query.filter(Topic.id>topic_id).first()

		# 查看要看的文章回覆
		replies = Reply.query.filter_by(topic_id=topic_id).all()

		return render_template('info.html',params=locals())
	else:
		# 創建立reply表的一條數據
		reply = Reply()

		# 獲取當前時間日期
		reply_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

		# 獲取使用者及文章的ID
		user_id = int(session.get('uid'))

		topic_id = int(request.form.get('article'))

		# 在回覆表中插入數據
		# 文字存入資料庫的轉換處理 以正常渲染到模板上
		# 把修改後的content存入reply表中
		reply.content = views_tool.text_to_database(request.form.get('content'))
		reply.reply_time = reply_time
		reply.user_id = user_id
		reply.topic_id = topic_id
		
		# 提交topic表數據到數據庫
		db.session.add(reply)
		# db.session.commit()

		return redirect('/info?topic_id='+str(topic_id))

# 刪除文章視圖函數
@main.route('/delete_topic')
def delete_user():
	# 獲取該文章的id
	topic_id = request.args['topic_id']

	# 判斷若沒有站長權限 則重定向到本篇文章
	user = User.query.filter_by(id=session.get('uid')).first()	
	if user.is_author != 1:
		return redirect('/info?topic_id='+str(topic_id))
	
	# 查詢該文章的數據
	topic = Topic.query.filter_by(id=topic_id).first()

	# 要刪除文章前要先刪除其回覆 因為回覆表有設置外鍵關聯至文章表
	# 查詢相關回覆
	replies = Reply.query.filter_by(topic_id=topic_id).all()
	for reply in replies:
		# 刪除此文章的所有回覆
		db.session.delete(reply)

	# 刪除此文章
	db.session.delete(topic)

	# 刪除完重定向回首頁
	return redirect('/')


@main.route('/list')
def update_user():
	#查询所有的Category的信息
	categories = Category.query.all()

	# 調用每個頁面都須處理的事情函數every_views
	uname,topics,topics_desc = views_tool.every_views()

	return render_template('list.html',params=locals())

# Ajax局部刷新文章主題列表所需的json數據
@main.route('/list_data')
def list_date_views():

	# 獲取回調函數名
	cb = request.args.get('callback')

	# 獲取文章的分類id
	pid = request.args.get('pid')
	topics = Topic.query.filter_by(category_id=pid).all()

	# 生成該文章的所有相關數據並轉換為Json格式
	topics_list = []
	for topic in topics:

		topic_dic = topic.to_dict()
		topic_dic['user_uname'] = topic.user.uname
		topic_dic['category_cate_name'] = topic.category.cate_name
		# print(topic_dic)
		# print(len(topic_dic))
		topics_list.append(topic_dic)

	# 組合成js函數名及傳入的參數的字符串
	return cb+"("+json.dumps(topics_list[::-1])+")"


# 時間軸處理函數
@main.route('/time')
def timeline_views():

	# 調用每個頁面都須處理的事情函數every_views
	uname,topics,topics_desc = views_tool.every_views()
	
	#查询所有的Category的信息
	categories = Category.query.all()

	return render_template('time.html',params=locals())

	
