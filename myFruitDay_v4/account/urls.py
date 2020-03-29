from django.conf.urls import url
from . import views
from django.contrib.auth import views as auth_views
from django.contrib.auth.views import password_change
from django.contrib.auth.views import password_change_done
# 使用反向解析, 動態的返回鏈接。在這裡也可以硬編碼URL。
urlpatterns = [
    # url(r'^login/$', views.user_login, name='login'),
    # url(r'^login/$',auth_views.login,name='login'),
    # url(r'^logout/$',auth_views.logout,name='logout'),
	
    # # change password
    # url(r'^password-change/$', auth_views.password_change,
    # 	{'post_change_redirect': 'login'},
    # 	name='password_change'),
    # url(r'^password-change-done/$', auth_views.password_change_done,
    # 	name='password_change_done'),

	url(r'^$', views.dashboard, name='dashboard'),

    # reset password
    # restore password urls
    url(r'^password-reset/$',
        auth_views.password_reset,
        name='password_reset'),

    url(r'^password-reset/done/$',
        auth_views.password_reset_done,
        name='password_reset_done'),

    url(r'^password-reset/confirm/(?P<uidb64>[-\w]+)/(?P<token>[-\w]+)/$',
        # views.password_reset_by_email,
        auth_views.password_reset_confirm,
        name='password_reset_confirm'),

    url(r'^password-reset/complete/$',
        views.password_reset_by_email,
        # auth_views.password_reset_complete,
        name='password_reset_complete'),

    url(r'^adduser/$',
        views.adduser,
        name='adduser'
        )

]

