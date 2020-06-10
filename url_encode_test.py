import urllib.parse

chinese_str = '类型'
# 先进行gb2312编码
# 类型
# %E7%B1%BB%E5%9E%8B
# %E7%B1%BB%E5%9E%8B
utf8_str = chinese_str.encode('utf-8')
# 输出 b'\xd6\xd0\xce\xc4'
# 再进行urlencode编码
utf8_str_quote = urllib.parse.quote(utf8_str)
# 输出 %D6%D0%CE%C4
print(utf8_str_quote)

# 由于编码问题会报错，还未解决
unquote = urllib.parse.unquote('utf8_str_quote')
print(unquote)

print('\u02c8')

count = 1
while True:
    if count == 5:
        break
    count += 1
print(count)
