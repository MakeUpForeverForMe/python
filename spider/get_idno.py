# -*- coding: UTF-8 -*-
import sys

import requests
from lxml import etree
import pymysql
import re


class Government(object):
    def __init__(self):
        self.one_url = 'http://www.mca.gov.cn/article/sj/xzqh/2020/'
        self.headers = {'User-Agent': 'Mozilla/5.0'}
        self.db = pymysql.connect(
            'localhost', 'root', '000000', 'government', charset='utf8'
        )
        self.cursor = self.db.cursor()

    # 提取二级页面链接（假链接）- 一定是最新的哪个链接
    def get_false_link(self):

        # xpath: //a[@class="artitlelist"]
        html = requests.get(
            url=self.one_url,
            headers=self.headers
        ).content.decode('utf-8', 'ignore')
        # 解析
        parse_html = etree.HTML(html)
        a_list = parse_html.xpath('//a[@class="artitlelist"]')
        for a in a_list:
            print(a.attrib)
            sys.exit(0)
            # title=a.xpath('./@title')[0]
            title = a.get('title')
            if re.findall('.*以上行政区划代码', title, re.S):
                two_false_link = 'http://www.mca.gov.cn' + a.get('href')
                return two_false_link

    # 提取真实二级页面链接（返回数据）
    def get_true_link(self):
        # 获取响应内容
        false_link = self.get_false_link()
        html = requests.get(url=false_link, headers=self.headers).text
        # 打印响应内容，查看真实链接的跳转，匹配出真实链接
        pattern = re.compile(r'window.location.href="(.*?)"', re.S)
        real_link = pattern.findall(html)[0]

        # 实现增量爬取
        # 到version表中查询real_link
        # 有：数据最新 没有：抓数据
        sel = 'select * from version where link="{}"'.format(real_link)
        self.cursor.execute(sel)

        # 链接已存在（不需要抓取数据）
        if self.cursor.fetchall():
            print('数据已是最新')
        else:
            # 先抓数据
            self.get_data(real_link)
            # 把real_link插入到version表中
            ins = 'insert into version value (%s)'
            self.cursor.execute(ins, [real_link])
            self.db.commit()

    # 真正提取数据函数
    def get_data(self, real_link):
        html = requests.get(
            url=real_link,
            headers=self.headers
        ).text
        # 基准xpath: //tr[@height="19"]
        parse_html = etree.HTML(html)
        tr_list = parse_html.xpath('//tr[@height="19"]')
        for tr in tr_list:
            code = tr.xpath('./td[2]/text()')[0]
            name = tr.xpath('./td[3]/text()')[0]
            print(name, code)
        # code: ./td[2]/text()
        # name: ./td[3]/text()

    # 主函数
    def main(self):
        self.get_true_link()


if __name__ == '__main__':
    spider = Government()
    spider.main()
