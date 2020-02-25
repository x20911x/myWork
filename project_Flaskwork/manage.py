from app import create_app

app = create_app()

# import pymysql
# pymysql.install_as_MySQLdb(
# 	)
# db = SQLAlchemy(app)

if __name__ == "__main__":
	app.run(host='0.0.0.0')