#!/usr/bin/python
# -*- coding: UTF-8 -*-
import os
import re
import sys
from configparser import ConfigParser
from email.mime.text import MIMEText
from email.header import Header
from smtplib import SMTP


class Mail(object):
    def __init__(self, path):
        self.charset = 'utf-8'
        self.str_join = ','
        self.end_with_mail = 'qq.com'
        self.sender_name = 'sender'
        self.host_name = 'host'
        self.user_name = 'user'
        self.pass_name = 'pass'
        self.receiver_name = 'receiver'
        self.receivers_name = 'receivers'
        self.sender_mail = 'sender_mail'
        self.receivers_mail = 'receivers_mail'
        self.config = ConfigParser(allow_no_value=True)  # 创建 ConfigParser 解析对象
        self.config.read(path, encoding=self.charset)
        self.server = None

    def sender(self, host, user, password):
        # 检查指定节点是否存在，如果不存在则创建
        if not self.config.has_section(self.sender_name):
            self.config.add_section(self.sender_name)

        if not self.config.has_option(self.sender_name, self.host_name):
            self.config.set(self.sender_name, self.host_name, host)

        if not self.config.has_option(self.sender_name, self.user_name):
            self.config.set(self.sender_name, self.user_name, user)

        if not self.config.has_option(self.sender_name, self.pass_name):
            self.config.set(self.sender_name, self.pass_name, password)

        __mail__ = self.config.get(self.sender_name, self.user_name)
        self.config.set(self.sender_name, self.sender_mail,
                        re.findall(r'<(.*?)>', __mail__)[0])

    def receivers(self, receiver_all):
        # 检查指定节点是否存在，如果不存在则创建
        if not self.config.has_section(self.receiver_name):
            self.config.add_section(self.receiver_name)

        if not self.config.has_option(self.receiver_name, self.receivers_name):
            self.config.set(self.receiver_name,
                            self.receivers_name, receiver_all)
            self.config.set(self.receiver_name, self.receivers_mail,
                            re.findall(r'<(.*?)>', receiver_all))

        __mails__ = self.config.get(self.receiver_name, self.receivers_name)
        self.config.set(self.receiver_name, self.receivers_mail,
                        self.str_join.join(re.findall(r'<(.*?)>', __mails__)))

    def send_mail(self, sub, msg):
        """ 设置邮件消息 """
        mail_msg = MIMEText(
            message, 'plain', _charset=self.charset)  # 根据邮件内容，获取邮件
        mail_msg['From'] = Header(self.config.get(
            self.sender_name, self.user_name), charset=self.charset)
        mail_msg['To'] = Header(self.config.get(
            self.receiver_name, self.receivers_name), charset=self.charset)
        mail_msg['Subject'] = Header('{}'.format(sub), charset=self.charset)

        print(mail_msg)
        print(self.config.items(self.sender_name))
        print(self.config.items(self.receiver_name))

        self.server = SMTP(self.config.get(
            self.sender_name, self.host_name), 25)  # 25 为 SMTP 端口号

        if self.config.get(self.sender_name, self.sender_mail).endswith(self.end_with_mail):
            self.server.login(self.config.get(self.sender_name, self.sender_mail),
                              self.config.get(self.sender_name, self.pass_name))

        self.server.sendmail(self.config.get(self.sender_name, self.user_name),
                             self.config.get(self.receiver_name, self.receivers_mail).split(
                                 self.str_join),
                             mail_msg.as_string())  # 发件人、收件人、消息

    def close(self):
        self.server.quit()  # 退出对话
        self.server.close()  # 关闭连接


if __name__ == '__main__':
    """ 获取参数 """
    if len(sys.argv[1:]) != 3:
        print("Error：请指定：配置文件、消息内容、主题", sys.argv)
        sys.exit(1)

    if not os.path.exists(sys.argv[1]):
        print("Error：配置文件 未找到！")
        sys.exit(1)

    """ 属性设置 """
    ini_path = sys.argv[1]
    subject = sys.argv[2]
    message = sys.argv[3]

    send_host = '10.80.0.133'
    send_user = '告警邮箱<DataCenter-Alert@services.weshreholdings.com>'
    send_pass = ''
    receivers = '郭超<chao.guo@weshareholdings.com>,' \
                '檀剑<jian.tan@weshareholdings.com>,' \
                '黄育楠<yunan.huang@weshareholdings.com>,' \
                '刘焕<huan.liu@weshareholdings.com>,' \
                '王禹衡<yuheng.wang@weshareholdings.com>,' \
                '魏喜明<ximing.wei@weshareholdings.com>'

    mail = Mail(ini_path)
    mail.sender(send_host, send_user, send_pass)
    mail.receivers(receivers)
    mail.send_mail(subject, message)
    mail.close()
