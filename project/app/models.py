# 此專案的模型實體類

from . import db

class Category(db.Model):
	__tablename__ = "category"
	id = db.Column(db.Integer,primary_key=True)
	cate_name = db.Column(db.String(50),nullable=False)

	topics = db.relationship('Topic',backref='category',lazy='dynamic')


class BlogType(db.Model):
	__tablename__ = "blogtype"
	id = db.Column(db.Integer,primary_key=True)
	type_name = db.Column(db.String(20),nullable=False)

	topics = db.relationship('Topic',backref='blogType',lazy='dynamic')


class User(db.Model):
	__tablename__ = "user"
	id = db.Column(db.Integer,primary_key=True)
	loginname = db.Column(
	db.String(50),nullable=False)
	uname = db.Column(db.String(30),nullable=False)
	email = db.Column(
	db.String(200),nullable=False)
	url = db.Column(db.String(200))
	upwd=db.Column(db.String(30),nullable=False)
	is_author=db.Column(db.SmallInteger,default=0)
	images = db.Column(db.Text)

	topics = db.relationship('Topic',backref='user',lazy='dynamic')
	replies = db.relationship('Reply',backref='user',lazy="dynamic")
  	#增加与Topic之间的关联关系和反向引用(多对多)
	voke_topics=db.relationship(
		'Topic',
		secondary='voke',
		backref=db.backref('voke_users',lazy='dynamic'),
		lazy='dynamic'
	)

class Topic(db.Model):
	__tablename__ = "topic"
	id = db.Column(db.Integer,primary_key=True)
	title = db.Column(
	db.String(200),nullable=False)
	pub_date = db.Column(
	db.DateTime,nullable=False)
	read_num = db.Column(db.Integer,default=0)
	content = db.Column(db.Text,nullable=False)
	images = db.Column(db.Text)

	category_id = db.Column(db.Integer,db.ForeignKey('category.id'))
	blogtype_id = db.Column(db.Integer,db.ForeignKey('blogtype.id'))
	user_id = db.Column(db.Integer,db.ForeignKey('user.id'))
	#定义与Reply之间的关联关系和反向引用
	replies = db.relationship('Reply',backref='topic',lazy="dynamic")

	def to_dict(self):
		dic = {
		"id" : self.id,
		"title" : self.title,
		"images": self.images,
		"blogtype_id" : self.blogtype_id,
		"category_id" : self.category_id,
		"user_id" : self.user_id,
		"content" : self.content,
		"read_num" : self.read_num,
		"pub_date" : str(self.pub_date),
		# "voke_users" : self.voke_users
		}
		return dic


class Reply(db.Model):
	__tablename__ = 'reply'
	id = db.Column(db.Integer,primary_key=True)
	content = db.Column(db.Text,nullable=False)
	reply_time = db.Column(db.DateTime)
	# 关系:一(Topic)对多(Reply)的关系
	topic_id = db.Column(db.Integer,db.ForeignKey('topic.id'))
	# 关系:一(User)对多(Reply)的关系
	user_id = db.Column(db.Integer,db.ForeignKey('user.id'))

Voke = db.Table(
  'voke',
  db.Column('id',db.Integer,primary_key=True),
  db.Column('user_id',db.Integer,db.ForeignKey('user.id')),
  db.Column('topic_id',db.Integer,db.ForeignKey('topic.id'))
)


class Test2(db.Model):
  __tablename__ = 'test2'
  id = db.Column(db.Integer,primary_key=True)
  content = db.Column(db.Text,nullable=False)
  reply_time = db.Column(db.DateTime)

Voke = db.Table(
  'test',
  db.Column('id',db.Integer,primary_key=True),
  db.Column('user_id',db.Integer,db.ForeignKey('user.id')),
  db.Column('topic_id',db.Integer,db.ForeignKey('topic.id'))
)

class Test3(db.Model):
  __tablename__ = 'test3'
  id = db.Column(db.Integer,primary_key=True)
  content = db.Column(db.Text,nullable=False)
  reply_time = db.Column(db.DateTime)

Voke = db.Table(
  'test4',
  db.Column('id',db.Integer,primary_key=True),
  db.Column('user_id',db.Integer,db.ForeignKey('user.id')),
  db.Column('topic_id',db.Integer,db.ForeignKey('topic.id'))
)	
# with app.app_context():
#   db.create_all()