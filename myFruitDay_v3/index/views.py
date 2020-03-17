# Author: CHI-YAN CHEN
# Email: x20911x@gmail.com
from django.shortcuts import render,redirect
from django.http import HttpResponse,HttpResponseRedirect
from django.template import loader
# Create your views here.
from django.urls import reverse
from .models import *
from .forms import *

import datetime, json, csv, time
from django.core import serializers
from django.db.models import *


# Create your views here.
def index_views(request):
	return render(request, 'index_HW.html', locals())

# Ajax from index_Hw.js check_login()檢查是否有登錄過 
def check_login_views(request):
	# 若登錄者保存在session中 代表處於登錄狀態
	if ('fruit_uid' in request.session and 'uphone' in request.session):
		id = request.session['fruit_uid']
		uname=User.objects.get(id=id).uname
		dic = {
	  		'loginStatus': 1,
	  		'uname':uname
		}
	# 判斷是否有Cookie 有Cookie則將使用者存入session後返回		
	elif ('fruit_uid' in request.COOKIES and 'uphone' in request.COOKIES):
		request.session['uphone'] = request.COOKIES['uphone']
		request.session['fruit_uid'] = request.COOKIES['fruit_uid']

		id = request.COOKIES['fruit_uid']
		uname=User.objects.get(id=id).uname
		dic = {
	  		'loginStatus': 1,
	  		'uname':uname
		}
	else:
		dic = {
	  		'loginStatus': 0
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

		# 如果從"登錄頁"過來"註冊頁"則註冊後後返回首頁
		if url == ('http://%s/login/'% request.get_host()):
			url = '/'		
		resp = redirect(url)
		# 從響應對象resp中刪除保存在cookies的url
		if 'url' in request.COOKIES:
			resp.delete_cookie('url')

		user = User()
		# 註冊模板繼承自登錄模板 控鍵避免重名子 否則 unreachable code after return statement
		user.uphone = request.POST.get('uphone')
		print('uphone: ',request.POST.get('uphone'))
		user.upwd = request.POST.get('upwd')
		user.uname = request.POST.get('uname')
		user.uemail = request.POST.get('uemail')
		user.save()
		
		# 取出user中的id值保存進session
		request.session['fruit_uid'] = user.id
		request.session['uphone'] = user.uphone
		print(request.session)
		return resp

# 使用form模塊生成login表單控件
def login_views(request):
	# 判斷是get or post 請求
	if request.method == 'GET':
		# 獲取重定向的url, (前面一頁面或首頁)
		url = request.META.get('HTTP_REFERER','/')
		print('url in cookies at get request:',url)
		resp = redirect(url)
		# 將前一個頁面或首頁url存入cookie
		resp.set_cookie('url', url, 60*60*24*7)

		# 判斷是否有session 有session則返回
		if 'fruit_uid' in request.session and 'uphone' in request.session:
			return resp

		# 判斷是否有Cookie 有Cookie則將使用者存入session後返回
		if 'fruit_uid' in request.COOKIES and 'uphone' in request.COOKIES:
			request.session['uphone'] = request.COOKIES['uphone']
			request.session['fruit_uid'] = request.COOKIES['fruit_uid']
			return resp

		
		# 聲明一個帶有小部件的Form
		form = LoginForm()

		resp = render(request,'Login.html',locals())
		# 將前一個頁面或首頁url存入cookie
		resp.set_cookie('url', url, 60*60*24*7)		
		return resp
		
	else:
		# 通過自動接收據
		# 1. 將request.POST數據傳遞給構造器
		form = LoginForm(request.POST)

		# 2. 驗證form對象
		if form.is_valid():

			# 聲明響應對象 
			url = request.COOKIES.get('url','/')

			# 如果從"註冊頁"過來"登錄頁"則登錄後返回首頁
			if url == ('http://%s/register/'% request.get_host()):
				url = '/'

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
				request.session['fruit_uid'] = user[0].id
				# 判斷是否存入Cookie
				# if request.POST.get('isSaved'):
				if 'isSaved' in request.POST:
					resp.set_cookie('fruit_uid', user[0].id, 60*60*24*7)
					resp.set_cookie('uphone', dic['uphone'], 60*60*24*7)
				return resp
			# 登錄失敗
			else:

				return render(request,'Login.html',locals())

			# print(repr(**form.cleaned_data))
			# user = User(**form.cleaned_data)
			# # 數據庫配置成功彆且實體類映射成為表後 即可將數據插入數據庫			
			# user.save()		
		return HttpResponse('驗證失敗 表單提交錯誤')


# 處理用戶登出
def logout_views(request):
	# 設定重定向的url
	url = request.META.get('HTTP_REFERER','/')
	resp = redirect(url)
	# 刪除在session中的個人登入資訊
	if 'uphone' in request.session or 'fruit_uid' in request.session:
		del request.session['fruit_uid']
		del request.session['uphone']
	# 刪除在cookies中的個人登入資訊
	if 'uphone' in request.COOKIES or 'fruit_uid' in request.COOKIES:
		resp.delete_cookie('fruit_uid')
		resp.delete_cookie('uphone')
	# 回到前面一頁面或首頁
	return resp


# 判斷使用者帳號是否使用過
def loginname_check_views(request):

	# 前端發送get請求, 提供querystring回調函數名callback
	cb = request.GET.get('callback')
	
	# 前端提供querystring用戶登錄名
	uphone = request.GET.get('loginname','not find')

	# 確認是否為有人註冊過這個uphone
	users = User.objects.filter(uphone=uphone)

	# method $.ajax
	if users:
		data = json.dumps({
			'status': 1,
			'msg' :'手機號碼已經存在'
		})
	else:
		data = json.dumps({
			'status': 0,
			'msg' :'此號碼可以使用'
		})
	print('cb',cb)
	print('uphone',uphone)
	print(data)
	# 組合成js函數名及傳入的參數的字符串
	return HttpResponse(cb+"("+data+")")
	# ------------Another method---------------
	# if users:
	# 	status = 1
	# 	msg = '手機號碼已經存在' 
	# else:
	# 	status = 0
	# 	msg = '此號碼可以使用'
	# dic = {'status':status,'msg':msg}
	# print(dic,type(dic))
	# return HttpResponse(json.dumps(dic))
	# ----------------------------------------


# 加載所有的商品類型和前面5個商品
def type_goods_views(request):
	all_list = []
	# 加載所有的商品類型
	types = GoodsType.objects.all()
	for type in types:
		# 將商品類型資訊轉為json
		type_json = json.dumps(type.to_dict())
		# print(type_json)
		# 獲取type類型下該商品類型下的商品中最新的5條數據物件
		goods_list = type.goods_set.order_by("-id")[0:5]

		# 將g_list轉為json
		goods_json = serializers.serialize('json', goods_list)

		# 將type_json 和 goods_json封裝到字典內
		dic = {
			"type":type_json,
			"goods":goods_json
		}
		all_list.append(dic)
	# 將json數據交給前端
	return HttpResponse(json.dumps(all_list))


# 加載此商品類型原本加載的其餘所有商品
def load_other_goods_views(request):
	print('backend load other goods')
	# 獲取商品類型id
	type_id = request.GET.get('type_id')

	# 獲取此商品類型的數據物件
	type = GoodsType.objects.get(id=type_id)

	# 獲取type類型下該商品類型下的商品中第5條以後的數據物件
	goods_list = type.goods_set.order_by("-id")[5:]

	# 將物件列表序列化為json格式
	goods_json = serializers.serialize('json', goods_list)

	# 將json數據交給前端
	return HttpResponse(goods_json)


# 加載此依照價格排序的所有商品
def goods_price_order_views(request):

	# 獲取商品類型id
	type_id = request.GET.get('type_id')

	# 獲取此商品類型的數據物件
	type = GoodsType.objects.get(id=type_id)

	# 判斷依照價格高到低或是低到高
	desc_or_asc = request.GET.get('desc_or_asc')
	if desc_or_asc == 'desc':
		# 獲取type類型下該商品類型下的商品中價格高到低的數據物件
		goods_list = type.goods_set.order_by("-price")[:]
	else:
		# 獲取type類型下該商品類型下的商品中價格低到高的數據物件
		goods_list = type.goods_set.order_by("price")[:]
	# 將物件列表序列化為json格式
	goods_json = serializers.serialize('json', goods_list)

	# 將json數據交給前端
	return HttpResponse(goods_json)


# 添加商品數量
def carts_index_views(request):
	fruit_uid = request.session.get('fruit_uid')
	good_id = request.GET.get('good_id')
	# print(good_id)

	cart_list = CartInfo.objects.filter(user_id=fruit_uid, good_id=good_id)
	# 查詢用戶
	user = User.objects.get(id=fruit_uid)
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
		item.user_id = fruit_uid
		item.good_id = good_id
		item.ccount = 1
		item.save()
		dic={
		  'status': 1,
		  'statusText' :'添加購物車成功'
		}

	# 將用戶名子存入字典		
	dic['uname'] = user.uname

	# 將json數據交給前端
	return HttpResponse(json.dumps(dic))


# 購物車資料
def carts_json_views(request):
	fruit_uid = request.session.get('fruit_uid')
	# 加載該使用者 所有的購物車訂單
	carts = CartInfo.objects.filter(user_id=fruit_uid)
	
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

		all_list.append(dic)
	# 將json數據交給前端
	return HttpResponse(json.dumps(all_list))


# 購物車頁面
def carts_render_views(request):
	return render(request,'cart.html',locals())


# Ajax from cart.js delete_cart(cart_id)刪除購物車內容
def delete_cart_views(request):
	cart_id = request.GET.get('cart_id')
	print('cart_id:',cart_id)
	# 刪除單條數據
	cart = CartInfo.objects.get(id=cart_id)
	cart.delete()
	return HttpResponse('ok')


# Ajax from index_HW.js cart_status() 確認購物車訂單數量
def check_cart_views(request):
	# 若沒有登錄, 則購物車數量顯示0
	cart_info = 0

	if ('fruit_uid' in request.session and 'uphone' in request.session)\
	 or ('fruit_uid' in request.COOKIES and 'uphone' in request.COOKIES):		
		# 計算所有訂單的數量
	    cart_info =CartInfo.objects.filter(user_id=request.session.get('fruit_uid')).count()

	dic = {
      'carts_total':cart_info,
    }
    # 將json數據交給前端
	return HttpResponse(json.dumps(dic))


# Ajax from index_HW.js modify_cart(cart_id)修改購物車訂單數量
def modify_cart_views(request, cart_id):
	# 獲取該比訂單 並轉為字典格式
	cart_info =CartInfo.objects.get(id=cart_id).to_dict()

	# 如果點擊加法按鈕
	if request.GET.get('add_minus') == 'A':
		print('點擊加法按鈕')
		CartInfo.objects.filter(id=cart_id).update(ccount=F('ccount')+1)
	
	# 如果點擊減法按鈕
	if request.GET.get('add_minus') == 'M':
		print('點擊減法按鈕')
		CartInfo.objects.filter(id=cart_id).update(ccount=F('ccount')-1)
	
	if request.GET.get('add_minus') == 'I':
		print("輸入")
		CartInfo.objects.filter(id=cart_id).update(ccount = int(request.GET.get('value')))
	# 獲取該比訂單物件並將其屬性轉為字典格式
	cart_info =CartInfo.objects.get(id=cart_id).to_dict()

	# 將json數據交給前端
	return HttpResponse(json.dumps(cart_info))


# 購物車商品資訊生成csv檔案
def some_views(request):
	# Create the HttpResponse object with the appropriate CSV header.
	# 響應對象獲得了一個特殊的MIME類型，text / csv。這會告訴瀏覽器，文檔是個CSV文件而不是HTML文件。
	# 如果你把它去掉，瀏覽器可能會把輸出解釋為HTML。
	response = HttpResponse(content_type='text/csv')

	# # 響應對象獲取了附加的Content-Disposition協議頭，它包含CSV文件的名稱。文件名可以是任意的；你想把它叫做什麼都可以。
	filename = time.strftime("%Y-%m-%d %H-%M-%S",time.localtime())
	response['Content-Disposition'] = 'attachment; filename="{filename}.csv"'.format(filename=filename)
	# response['Content-Disposition'] = 'attachment; filename="xxxx.csv"'

	# 使用CSV模塊，把響應體內容封裝到CSV文件物件內，這樣寫入的內容都會被寫入到response.content之中
	writer = csv.writer(response)
	writer.writerow(['商品', '單價', '數量', '小計'])
	fruit_uid = request.session.get('fruit_uid')
	# 加載該使用者 所有的購物車訂單
	carts = CartInfo.objects.filter(user_id=fruit_uid)

	# 總消費
	total_cost = 0
	# 迴圈遍歷cart
	for cart in carts:
		# 關聯到該商品物件
		good = cart.good

		# 調用物件屬性price title account
		price, title, ccount = good.price, good.title, cart.ccount
		
		# 計算總價格
		one_cost = (price) * (ccount)
		total_cost += one_cost

		writer.writerow([title, price, ccount, one_cost])
	writer.writerow(['', '', '消費金額一共', '%s元' % total_cost])

	return response
