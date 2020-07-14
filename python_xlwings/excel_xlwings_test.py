import os
import re

base_dir = os.path.abspath(os.path.join(os.getcwd(), "."))

''' 获取文件并解析 '''
with open(f'{base_dir}/ods_new_s.hql', encoding='utf-8') as file:
    flag = False
    lines = []
    sql_str = ''

    for line in file.readlines():
        if not flag:
            if re.match(r'^create[\w\s]+table[\s\w`.]*\(', line.strip(),
                        re.I) and not re.match(r'.*(as|like).*', line, re.I):
                sql_str, flag = '', True

        if flag:
            sql_str += line.replace('\n', ' ')

            if re.match(r'.*;$', sql_str.strip(), re.I):
                flag = False
                lines.append(re.sub(r'\s+', ' ', sql_str.strip()))

data = {}


def get_column_key(string: str):
    if string.find('STORED AS') != -1:
        stored_as = string.find('STORED AS')
        get_column_key(string[0:stored_as])
        data['stored_as'] = string[stored_as:].split(' ')[-1].lower()
    elif string.find('PARTITIONED BY') != -1:
        partitioned_by_index = string.find('PARTITIONED BY')
        get_column_key(string[0:partitioned_by_index])
        partitioned_by = string[partitioned_by_index:]
        print(partitioned_by)
        l_index = partitioned_by.find('(')
        r_index = partitioned_by.rfind(')')
        partitioned_by = partitioned_by[l_index + 1: r_index]
        partitioned_by = partitioned_by
        print(partitioned_by)
        # data['partition_by'] = [split[0], split[1]]
        # print(data['partition_by'])
    # elif comment:
    #     print(string)
    #     print(string.index('('), string.rindex(')'))
    #     print(string[0:string.index(comment.group())])
    #     print(string.index(comment.group()), comment.group())
    #     get_column_key(string[0:string.rindex(comment.group())])
    # elif create:
    #     print(string[0:string.index(create.group())])
    #     print(string.index(create.group()), create.group())
    #     get_column_key(string[0:string.index(create.group())])


for line in lines:
    # print(line)
    # index_1 = line.index('(')
    # table_name = line[:index_1]
    # other = line[index_1 + 1:].strip()
    # print(table_name)
    # print(other)
    find_db_tb_name = line.find('(')
    get_column_key(line[find_db_tb_name + 1:].strip())
    db_tb_name = line[0:find_db_tb_name].split(' ')[-1].strip('`').split('.')
    data['db_name'] = db_tb_name[0]
    data['tb_name'] = db_tb_name[1]
    print(data)
    # for index, column in enumerate(line.split(' ')):
    #     print(index, column)

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
