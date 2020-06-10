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


ss = '    '

print(ss.replace(' ', 'a'))
