# a = []
# for i in range(10):
#     a.append(i)
#     print(a)
#
# a.reverse()
#
# while len(a):
#     if len(a) == 5:
#         break
#     print(a.pop())


# coding=utf-8
# import re
# import os
#
# content = '''''
# <script>var images = [
# { "big":"http://i-2.yxdown.com/2015/3/18/KDkwMHgp/6381ccc0-ed65-4422-8671-b3158d6ad23e.jpg",
#   "thumb":"http://i-2.yxdown.com/2015/3/18/KHgxMjAp/6381ccc0-ed65-4422-8671-b3158d6ad23e.jpg",
#   "original":"http://i-2.yxdown.com/2015/3/18/6381ccc0-ed65-4422-8671-b3158d6ad23e.jpg",
#   "title":"","descript":"","id":75109},
# { "big":"http://i-2.yxdown.com/2015/3/18/KDkwMHgp/fec26de9-8727-424a-b272-f2827669a320.jpg",
#   "thumb":"http://i-2.yxdown.com/2015/3/18/KHgxMjAp/fec26de9-8727-424a-b272-f2827669a320.jpg",
#   "original":"http://i-2.yxdown.com/2015/3/18/fec26de9-8727-424a-b272-f2827669a320.jpg",
#   "title":"","descript":"","id":75110},
# </script>
# '''
#
# html_script = r'<script>(.*?)</script>'
# m_script = re.findall(html_script, content, re.S | re.M)
# for script in m_script:
#     res_original = r'"original":"(.*?)"'  # 原图
#     m_original = re.findall(res_original, script)
#     for pic_url in m_original:
#         print(pic_url)
#         filename = os.path.basename(pic_url)  # 去掉目录路径,返回文件名
#         print(filename)


# ss = '    '
# print(ss.replace(' ', 'a'))


# import os

''' 获取当前目录 '''
# base_dir = os.path.abspath(os.path.join(os.getcwd(), "."))
# print(f'{base_dir}')

''' 获取目录下的所有子文件及子文件夹 '''
# for dirs in os.walk(base_dir):
#     print(dirs)

''' 获取目录下的所有文件及文件夹 '''
# for dirs in os.listdir(base_dir):
#     print(dirs)

# print(f'{base_dir}/python_xlwings')
# print(os.getcwd())
# print(os.path.abspath(os.path.dirname(__file__)))
# print(os.path.abspath(os.path.join(os.getcwd(), ".")))  # 主用
''' 获取上级目录 '''
# print(os.path.abspath(os.path.join(os.getcwd(), "../..")))  # 主用

# import xlwings as xw
# import pandas as pd
# import numpy as np

# df = pd.DataFrame(np.random.rand(10, 4), columns=['a', 'b', 'c', 'd'])
# xw.view(df)


# -*- coding:UTF-8 -*-
import sqlparse

sql = "CREATE TABLE IF NOT EXISTS `dim_new.dim_encrypt_info`( `dim_type` string COMMENT '数据类型', `dim_encrypt` string COMMENT '加密字段', `dim_decrypt` string COMMENT '明文字段', `create_time` timestamp COMMENT '创建时间（yyyy—MM—dd HH:mm:ss）', `update_time` timestamp COMMENT '更新时间（yyyy—MM—dd HH:mm:ss）' ) COMMENT '加密信息表' PARTITIONED BY (`product_id` string COMMENT '产品编号') STORED AS PARQUET;"
# 1.分割SQL
stmts = sqlparse.split(sql)
for stmt in stmts:
    # 2.format格式化
    print(sqlparse.format(stmt, reindent=True, keyword_case="upper"))
    # 3.解析SQL
    stmt_parsed = sqlparse.parse(stmt)
    print(stmt_parsed[0].tokens)
