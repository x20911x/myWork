from django.contrib import admin
from .models import *

class GoodsAdmin(admin.ModelAdmin):
	# 指定在列表中顯示的欄位
	list_display = ('title', 'goodsType','price','spec')
	# 指定右側顯示的過濾器
	list_filter = ('goodsType',)
	# 指定在上方的搜尋欄位
	search_fields= ('title',)


# Register your models here.
admin.site.register(GoodsType)
admin.site.register(Goods, GoodsAdmin)
admin.site.register(CartInfo)
