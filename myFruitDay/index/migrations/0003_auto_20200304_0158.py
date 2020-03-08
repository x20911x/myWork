# -*- coding: utf-8 -*-
# Generated by Django 1.11.8 on 2020-03-04 01:58
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('index', '0002_auto_20200229_0624'),
    ]

    operations = [
        migrations.CreateModel(
            name='Goods',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=40, verbose_name='商品名稱')),
                ('price', models.DecimalField(decimal_places=2, max_digits=7, verbose_name='商品價格')),
                ('spec', models.CharField(max_length=20, verbose_name='商品規格')),
                ('picture', models.ImageField(null=True, upload_to='static/upload/goods', verbose_name='商品圖片')),
                ('isActive', models.BooleanField(default=True, verbose_name='是否上架')),
            ],
            options={
                'verbose_name_plural': '商品',
                'verbose_name': '商品',
                'db_table': 'goods',
            },
        ),
        migrations.CreateModel(
            name='GoodsType',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=20, verbose_name='類型標題')),
                ('picture', models.ImageField(null=True, upload_to='static/upload/goodstype', verbose_name='類型圖片')),
                ('desc', models.TextField(verbose_name='類型描述')),
            ],
            options={
                'verbose_name_plural': '商品類型',
                'verbose_name': '商品類型',
                'db_table': 'goods_type',
            },
        ),
        migrations.AddField(
            model_name='goods',
            name='goodsType',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='index.GoodsType', verbose_name='商品類型'),
        ),
    ]
