import os
import re

import xlwings as xw

base_dir = os.path.abspath(os.path.join(os.getcwd(), "."))

lines = []

''' 获取文件并解析 '''
with open(f'{base_dir}/ods_new_s.hql', encoding='utf-8') as file:
    long_str = ''
    for line in file.readlines():
        if re.search(r'^-', line):
            continue
        long_str += re.sub(r'\s+', ' ', line.strip()) + ' '

    for line in long_str.split(';'):
        line = line.strip()
        if not re.search(r'^create table [\s\w`.]+\([\s\w\W]+\)[\s\w\W]+', line, re.I):
            continue
        lines.append(line)

print(lines)

''' 打开文档 '''
# excel = xw.Book(f'{base_dir}/python_xlwings.xlsx')
# app = excel.app
# app.display_alerts = False
# app.screen_updating = False

# sheets = excel.sheets

''' 关闭文档 '''
# excel.save()
# excel.close()
# app.quit()
