from django.shortcuts import render,redirect
from django.http import HttpResponse,HttpResponseRedirect
from django.template import loader
# Create your views here.
from django.urls import reverse
from .models import *
from .forms import *

import datetime, json
from django.core import serializers
from django.db.models import *


# Create your views here.
def index_views(request):
	# user = ""
	# # 判斷是否有session 有session則返回首頁
	# if 'uid' in request.session and 'uphone' in request.session:
	# 	user = User.objects.filter(id=request.session.get('uid'))

	# # # 判斷是否有Cookie 有Cookie則將使用者存入session後返回首頁
	# if 'uid' in request.COOKIES and 'uphone' in request.COOKIES:
	# 	# request.session
	# 	user = User.objects.get(id=request.COOKIES.get('uid'))
	
	return render(request, 'index_HW.html', locals())


# # 檢查 session 中是否有登錄訊息 
def check_login_views(request):
  if 'uid' in request.session and 'uphone' in request.session:
    loginStatus = 1
    #通过uid的值获取对应的uname
    id = request.session['uid']
    uname=User.objects.get(id=id).uname
    dic = {
      'loginStatus':loginStatus,
      'uname':uname
    }
    return HttpResponse(json.dumps(dic))
  else:
    dic = {
      'loginStatus':0
    }
    return HttpResponse(json.dumps(dic))


# 註冊功能
def register_views(request):
	# 判斷是get or post 請求
	if request.method == 'GET':
		# 獲取(前面一頁面或首頁)url
		url = request.META.get('HTTP_REFERER','/')
		resp = render(request, 'Register.html')
		# 將前一個頁面或首頁url存入cookie
		resp.set_cookie('url', url, 60*60*24*7)
		return resp
	else:
		# 聲明響應對象 
		url = request.COOKIES.get('url','/')
		resp = redirect(url)
		# 從響應對象resp中刪除保存在cookies的url
		if 'url' in request.COOKIES:
			resp.delete_cookie('url')
		print('ok')
		user = User()
		# 註冊模板繼承自登錄模板 控鍵避免重名子 否則 unreachable code after return statement
		user.uphone = request.POST.get('uphone')
		print('uphone: ',request.POST.get('uphone'))
		user.upwd = request.POST.get('upwd')
		user.uname = request.POST.get('uname')
		user.uemail = request.POST.get('uemail')
		user.save()
		
		# 取出user中的id值保存進session
		request.session['uid'] = user.id
		request.session['uphone'] = user.uphone
		print(request.session)
		return resp

# 使用form模塊生成表單控件
def login_views(request):
	# 判斷是get or post 請求
	if request.method == 'GET':
		# 獲取重定向的url, (前面一頁面或首頁)
		url = request.META.get('HTTP_REFERER','/')
		resp = redirect(url)
		# 將前一個頁面或首頁url存入cookie
		resp.set_cookie('url', url, 60*60*24*7)

		# 判斷是否有session 有session則返回首頁
		if 'uid' in request.session and 'uphone' in request.session:
			return resp

		# 判斷是否有Cookie 有Cookie則將使用者存入session後返回首頁
		if 'uid' in request.COOKIES and 'uphone' in request.COOKIES:
			request.session['uphone'] = request.COOKIES['uphone']
			request.session['uid'] = request.COOKIES['uid']
			return resp	


		# 若沒有session 或 COOKIE 則返回首頁
		# 聲明一個帶有小部件的Form
		form = LoginForm()
		return render(request,'Homework-5test.html',locals())
		
	else:
		# 通過自動接收據
		# 1. 將request.POST數據傳遞給構造器
		form = LoginForm(request.POST)

		# 2. 驗證form對象
		if form.is_valid():

			# 聲明響應對象 
			url = request.COOKIES.get('url','/')
			resp = redirect(url)
			# 從響應對象resp中刪除保存在cookies的url
			if 'url' in request.COOKIES:
				resp.delete_cookie('url')
			# 通過驗證後獲取具體的數據
			dic = form.cleaned_data
			# 判斷使用者, 密碼是否存在於數據庫
			user = User.objects.filter(uphone=dic['uphone'], upwd=dic['upwd'])
			# 登錄成功
			if user:
				request.session['uphone'] = dic['uphone']
				request.session['uid'] = user[0].id
				# 判斷是否存入Cookie
				# if request.POST.get('isSaved'):
				if 'isSaved' in request.POST:
					resp.set_cookie('uid', user[0].id, 60*60*24*7)
					resp.set_cookie('uphone', dic['uphone'], 60*60*24*7)
				return resp
			# 登錄失敗
			else:
				form = LoginForm()
				return render(request,'Homework-5test.html',locals())

			# print(repr(**form.cleaned_data))
			# user = User(**form.cleaned_data)
			# # 數據庫配置成功彆且實體類映射成為表後 即可將數據插入數據庫			
			# user.save()		
		return HttpResponse('驗證失敗 表單提交錯誤')


def logout_views(request):
	# 設定重定向的url, 回到前面一頁面或首頁
	url = request.META.get('HTTP_REFERER','/')
	resp = redirect(url)
	if 'uphone' in request.session or 'uid' in request.session:
		del request.session['uid']
		del request.session['uphone']
	if 'uphone' in request.COOKIES or 'uid' in request.COOKIES:
		resp.delete_cookie('uid')
		resp.delete_cookie('uphone')
	print('url:',url)
	return resp


# 判斷使用者帳號是否使用過
# @main.route('/loginname-check')
def loginname_check_views(request):

	# 前端發送get請求, 提供querystring回調函數名callback
	cb = request.GET.get('callback')
	
	# 前端提供querystring用戶登錄名
	uphone = request.GET.get('loginname','not find')

	# 確認是否為有人註冊過這個uphone
	users = User.objects.filter(uphone=uphone)

	# method $.ajax
	# if users:
	# 	data = json.dumps({
	# 		'msg' :'手機號碼已經存在'
	# 	})
	# else:
	# 	data = json.dumps({
	# 		'msg' :'此號碼可以使用'
	# 	})

	# print('cb',cb)
	# print('uphone',uphone)
	# print(data)
	# # 組合成js函數名及傳入的參數的字符串
	# return HttpResponse(cb+"("+data+")")
	# ------------Another method---------------
	if users:
		status = 1
		msg = '手機號碼已經存在' 
	else:
		status = 0
		msg = '此號碼可以使用'
	dic = {'status':status,'msg':msg}
	print(dic,type(dic))
	return HttpResponse(json.dumps(dic))
	# ----------------------------------------


# def test_views(request):
# 	return render(request,'test.html')


def type_goods_views(request):
	all_list = []
	# 加載所有的商品類型
	types = GoodsType.objects.all()
	for type in types:
		# 將商品類型資訊轉為json
		type_json = json.dumps(type.to_dict())
		# print(type_json)
		# 獲取type類型下該商品類型下的商品中最新的10條數據物件
		goods_list = type.goods_set.order_by("-id")[0:10]
		print(goods_list)
		# 將g_list轉為json
		goods_json = serializers.serialize('json', goods_list)
		# print(goods_json)
		# 將type_json 和 goods_json封裝到字典內
		dic = {
			"type":type_json,
			"goods":goods_json
		}
		all_list.append(dic)
	return HttpResponse(json.dumps(all_list))


def carts_index_views(request):
	uid = request.session.get('uid')
	good_id = request.GET.get('good_id')
	# print(good_id)

	cart_list = CartInfo.objects.filter(user_id=uid, good_id=good_id)
	# 查詢用戶
	user = User.objects.get(id=uid)
	# 如果用戶購買了此商品
	# print('handling')
	if cart_list:
		# 添加數量
		cart_list.update(ccount=F('ccount')+1)
		dic={
		  'status': 0,
		  'statusText' :'增加商品購買數量'
		}
	# 如果資料庫中沒有該用戶購買該商品的資料則
	else:
		# 該用戶沒買過此商品時
		# 插入購物車新的數據
		item = CartInfo()
		item.user_id = uid
		item.good_id = good_id
		item.ccount = 1
		item.save()
		dic={
		  'status': 1,
		  'statusText' :'添加購物車成功'
		}

	# 將用戶名子存入字典		
	dic['uname'] = user.uname
	return HttpResponse(json.dumps(dic))


def carts_json_views(request):
	uid = request.session.get('uid')
	# 加載該使用者 所有的購物車訂單
	carts = CartInfo.objects.filter(user_id=uid)
	
	# 使用迴圈遍歷全部訂單
	all_list = []
	for cart in carts:
		# 使用Foreignkey關聯到一筆商品
		good = cart.good
		# # 該訂單購買數量
		ccount = cart.ccount

		total_cost = float(good.price * ccount)
		# print(float(total_cost),type(total_cost))
		# 將該商品的所有屬性轉換為字典
		good_json = json.dumps(good.to_dict())

		cart_json = json.dumps(cart.to_dict())
		# print('---------')
		dic = {
		  'good': good_json,
		  'cart': cart_json,
		  'total_cost':total_cost,

		}
		# print(dic,end='\n\n')
		all_list.append(dic)
	# return HttpResponse('okkk')
	return HttpResponse(json.dumps(all_list))


# 購物車頁面
def carts_render_views(request):
	return render(request,'cart.html',locals())


# Ajax 刪除購物車內容
def delete_cart_views(request):
	cart_id = request.GET.get('cart_id')
	print('cart_id:',cart_id)
	# 刪除單條數據
	cart = CartInfo.objects.get(id=cart_id)
	cart.delete()
	return HttpResponse('ok')

# Ajax 確認購物車訂單數量
def check_cart_views(request):
	# 計算所有訂單的數量
    cart_info =CartInfo.objects.all().count()

    dic = {
      'carts_total':cart_info,
    }
    return HttpResponse(json.dumps(dic))

# Ajax 修改購物車訂單數量
def modify_cart_views(request, cart_id):

	# 獲取該比訂單物件並將其屬性轉為字典格式
	cart_info =CartInfo.objects.get(id=cart_id).to_dict()

	return HttpResponse(json.dumps(cart_info))
