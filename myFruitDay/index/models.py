from django.db import models

# Create your models here.


class User(models.Model):
  uphone = models.CharField(max_length=30,verbose_name='手機號碼')
  upwd = models.CharField(max_length=30,verbose_name='密碼')
  uname = models.CharField(max_length=30,verbose_name='用戶名')
  uemail = models.EmailField(null=True,verbose_name='電子郵件')
  isActive = models.BooleanField(default=False,verbose_name='是否激活')

  def __repr__(self):
    return '<user:%r>' % (self.name,)

  class Meta:
    db_table = 'user'



class GoodsType(models.Model):
  title = models.CharField(
    max_length=20,
    verbose_name='類型標題')
  picture = models.ImageField(
    upload_to='static/upload/goodstype',
    null=True,
    verbose_name="類型圖片")
  desc = models.TextField(
    verbose_name='類型描述')

  def __str__(self):
    return '<GoodsType:%s>' % self.title

  def to_dict(self):
    dic = {
      'title':self.title,
      'picture':self.picture.__str__(),
      'desc':self.desc,
    }
    return dic

  class Meta:
    db_table = "goods_type"
    verbose_name = "商品類型"
    verbose_name_plural = verbose_name


class Goods(models.Model):
  title = models.CharField(
    max_length=40,
    verbose_name='商品名稱'
  )
  price = models.DecimalField(
    max_digits=7,
    decimal_places=2,
    verbose_name='商品價格'
  )
  spec = models.CharField(
    max_length=20,
    verbose_name='商品規格'
  )
  picture = models.ImageField(
    upload_to='static/upload/goods',
    null=True,
    verbose_name='商品圖片'
  )
  goodsType = models.ForeignKey(
    GoodsType,
    verbose_name='商品類型'
  )
  isActive = models.BooleanField(
    default = True,
    verbose_name='是否上架'
  )

  def to_dict(self):
    dic = {
      'title':self.title,
      'price':self.price.__str__(),
      'spec':self.spec,
      'picture':self.picture.__str__(),
      'goodsType_id':self.goodsType_id,
      'isActive':self.isActive,
    }
    return dic

  def __str__(self):
    return '<good:%s>'% self.title

  class Meta:
    db_table = "goods"
    verbose_name = "商品"
    verbose_name_plural = verbose_name



class CartInfo(models.Model):
  user = models.ForeignKey(
    User,
    verbose_name='客戶'
  )
  good = models.ForeignKey(
    Goods,
    verbose_name='商品'
  )
  ccount = models.IntegerField(
  	db_column = 'ccount',
  	null = False

  	)
  def __str__(self):
    return '<user:%s, good:%s>' % (self.user.uname, self.good.title)

  def to_dict(self):
    dic = {
      'cart_id':self.id,
      'ccount':self.ccount,
    }
    return dic



  class Meta:
    db_table = "cart_info"
    verbose_name = "購物車"
    verbose_name_plural = verbose_name