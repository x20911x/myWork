#對整個應用做初始化操作
# 主要工作：
# 1.構建Flask應用以及各種配置
# 2.構建SQLAlchemy的應用
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
# from sqlalchemy import text
import pymysql
pymysql.install_as_MySQLdb(
	)
db = SQLAlchemy()

def create_app():
	app = Flask(__name__)
	#配置啟動模式為調試模式
	app.config['DEBUG'] = True
	#配置數據庫的連庫字符串
	app.config['SQLALCHEMY_DATABASE_URI']\
	="mysql://root:x20911x@localhost:3306/blog"
	#配置數據庫內容在更新時自動提交
	app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN']=True
	#配置session所需要的秘鑰
	app.config['SECRET_KEY']='you guess'

	# db = SQLAlchemy(app)
	# from config import Config
	# app.config.from_object(Config)
	# Config.init_app(app)
	# db = SQLAlchemy(app)
	# from .models import Test2

	#數據庫的初始化
	db.init_app(app)
	app.app_context().push()
	db.create_all(app=app)

	# Blueprint of main ralationship with app
	# 藍圖程序main與app關聯
	from .main import main as main_blueprint
	app.register_blueprint(main_blueprint)

	# from .user import user as user_blueprint
	# app.register_blueprint(user_blueprint)
	return app


