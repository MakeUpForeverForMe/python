# -*- coding: UTF-8 -*-
import pymysql


def init_mysql():
    connection = pymysql.connect('localhost', 'root', '000000', 'government', charset='utf8')
    pass
