from django.conf.urls import url
from .views import *

# 主要實現應用中的地址與視圖的處理
urlpatterns = [

	url(r'^login/$', login_views, name='login'),
	url(r'^register/$', register_views ,name='reg'),	
 	url(r'^loginname-check/$', loginname_check_views ,name='login_check'),
	url(r'^logout/$', logout_views, name='logout'), 	
    url(r'^$', index_views, name='index'),
    url(r'^check-login/$', check_login_views, name='check_login'),
    # url(r'^test/$',test_views,),
    url(r'^type_goods/$',type_goods_views,name='type_goods'),
    url(r'^check_carts/$',carts_index_views,name='carts_views'),
    url(r'^carts_order/$',carts_json_views,name='carts_order'),
    url(r'^carts_render/$',carts_render_views,name='carts_render'),
	url(r'^delete_cart/$',delete_cart_views,name='delete_cart'),
	url(r'^check_cart/$',check_cart_views,name='check_cart'),
    url(r'^modify_cart/(\d+)/$',modify_cart_views,name='modify_cart'),
    url(r'^other_goods/$',load_other_goods_views,name='load_other'),

]