import os

import xlwings as xw

base_dir = os.path.abspath(os.path.join(os.getcwd(), "."))

excel = xw.Book(f'{base_dir}/python_xlwings.xlsx')
app = excel.app
app.display_alerts = False
app.screen_updating = False




''' 关闭 '''
excel.close()
app.quit()
