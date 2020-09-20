#!/usr/bin/python
# -*- coding: UTF-8 -*-

import smtplib
import sys
from email.mime.text import MIMEText
from email.header import Header
from configparser import ConfigParser

""" 属性设置 """
send_host = '10.80.0.133'
send_user = 'DataCenter-Alert@services.weshreholdings.com'
receivers = [
    'chao.guo@weshareholdings.com',
    'jian.tan@weshareholdings.com',
    'yunan.huang@weshareholdings.com',
    'huan.liu@weshareholdings.com',
    'yuheng.wang@weshareholdings.com',
    'ximing.wei@weshareholdings.com'
]

""" 获取参数 """
if len(sys.argv) - 1 != 3:
    print("Error：指定配置文件、消息内容、主题", sys.argv)
    sys.exit(1)

config_filePath = sys.argv[1]
email_subject = sys.argv[2]
message = sys.argv[3]

""" 解析配置文件 """
config = ConfigParser(allow_no_value=True)  # 创建对象
if len(config.read(config_filePath, encoding='utf-8')) == 0:  # 读取配置文件，如果配置文件不存在则创建
    print(f"Error：没有找到对应的配置文件 {config_filePath}")
    sys.exit(1)

if not config.has_section('sender'):  # 检查指定节点是否存在，返回True或False
    config.add_section('sender')
    config.set('sender', 'host', send_host)
    config.set('sender', 'user', send_user)

if not config.has_section('receiver'):
    print("Error：请在配置文件中配置节点 [receiver]")
    sys.exit(1)

if not config.has_option('receiver', 'receivers'):
    print("Error：请在配置文件中配置 receiver 节点的属性 receivers")
    sys.exit(1)

send_user = config.get('sender', 'user')
receivers_ = str(config.get('receiver', 'receivers'))
receivers = receivers_.split(',') if receivers_ != '' else receivers

""" 设置邮件消息 """
msg = MIMEText(message, _charset='utf-8')  # 根据邮件内容，获取邮件
msg['From'] = Header(send_user)
msg['To'] = Header(','.join(receivers))
msg['Subject'] = Header('{}'.format(email_subject), 'utf-8')

""" 发送邮件 """
server = smtplib.SMTP(config.get('sender', 'host'), 25)  # 25 为 SMTP 端口号
# server = smtplib.SMTP_SSL(config.get('sender', 'host'), 465 if str(send_user).endswith('qq.com') else 25)

if str(send_user).endswith('qq.com'):
    server.login(send_user, config.get('sender', 'pass'))

server.sendmail(send_user, receivers, msg.as_string())  # 发件人、收件人、消息
server.quit()  # 退出对话
server.close()  # 关闭连接
