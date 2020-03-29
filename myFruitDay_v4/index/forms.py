from django import forms
from .models import *

class LoginForm(forms.ModelForm):
	# 通過內部類Meta表示關聯的訊息
  class Meta:
  	# 1. 指定關聯的Model
  	model = User
  	# 2. 指定要生成控件的欄位(字段Field)
  	fields = ['uphone', 'upwd']
  	# 3. 指定每個控件對應的label
  	labels= {
  	  'uphone': '手機號碼',
  	  'upwd': '登錄密碼',
  	}
	# 指定小部件
  	widgets = {
  	  'upwd': forms.PasswordInput(attrs={
		  'placeholder':'請輸入您的密碼',
		  'class':"input1",
		# 'maxlength' : 10, # 模型類已經設定
  	  	}),

  	  'uphone': forms.TextInput(attrs={
		  'class':"input1",
		# 'maxlength' : 10,
  	  	})
  	}