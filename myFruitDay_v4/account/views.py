# Create your views here.
from django.shortcuts import render, HttpResponse, redirect
from django.contrib.auth import authenticate, login
from .forms import LoginForm
from django.contrib.auth.decorators import login_required
from index.models import *
from django.db.models import *
from social_core import *
import pymysql
from django.contrib.auth.models import User as Auth_user
from django.contrib.auth import views as auth_views
from django.contrib.auth.hashers import make_password, check_password

def password_reset_by_email(request):
    username = request.GET.get('username')
    password = request.GET.get('new_password2')

    # 修改mysql內的使用者密碼
    user = User.objects.get(uphone=username)
    user.upwd = password
    user.save()
    return render(request, 'registration/password_reset_complete.html')

def adduser(request):
    # user = Auth_user()
    # user.username = 'Mark'
    # user.password = 'a123456789'
    # user.email = 'xx20911xx@gmail.com'
    # user.save()
    user = Auth_user.objects.create_user("Sandy","xx20911xx@gmail.com","a123456789")
    return HttpResponse('!!!!!!!')

@login_required
def dashboard(request):
    # https://zh.m.wikibooks.org/zh-tw/Django/%E7%94%A8%E6%88%B7%E8%AE%A4%E8%AF%81
    first_name =request.user.first_name

    # 使用loop搜尋此用戶是否以存在
    third_party_user = get_third_party_user()
    # for i in range(len(third_party_user)-1,-1,-1):
    for i in range(0, len(third_party_user)):    
        id, uid, provider = third_party_user[i]

        user = User.objects.filter(uphone=provider, uemail=uid, auth_id=id, uname=first_name)
        if user:
            break
    else:
        new_user = User()
        new_user.uphone = provider
        new_user.upwd = uid + str(id)
        new_user.uname = first_name
        new_user.uemail = uid
        new_user.auth_id = id
        new_user.save()
        # 轉為倒敘排列以便取得最後一筆數據
        user = User.objects.all().order_by('-id')

    # 聲明響應對象 
    url = request.COOKIES.get('url','/')

    # 如果從"登錄頁"過來"註冊頁"則註冊後後返回首頁
    if url == ('http://%s/register/'% request.get_host()):
        url = '/'

    resp = redirect(url)
    # 使用完立即從響應對象resp中刪除保存在cookies的url
    # 避免造成之後的使用者操作時誤用
    if 'url' in request.COOKIES:
        resp.delete_cookie('url')       
    # 取出user中的id值保存進session
    request.session['fruit_uid'] = user[0].id
    request.session['uphone'] = user[0].uphone

    return resp



def get_third_party_user():

    # 1.創建數據庫連接對象
    db = pymysql.connect(host="localhost",user="root",
                    password="a123456",database="fruit",
                    charset="utf8")
    # 2.創建游標對象
    cur = db.cursor()

    try:
        sql_select = "select id,uid,provider from social_auth_usersocialauth order by id asc;"
        cur.execute(sql_select)
        data = cur.fetchall()
        print('-----',data)
        db.commit()
    except Exception as e:
        print(e)
        db.rollback()

    cur.close()
    db.close()

    return data


