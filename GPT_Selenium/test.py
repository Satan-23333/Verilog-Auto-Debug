
#使用前在gpt_parser.py 52行和60行中分别输入账号和密码

from gpt_parser import gptParser
from time import sleep

driver = gptParser.get_driver()
gpt = gptParser(driver=driver)

gpt.auto_login()
sleep(5)

gpt.set_gpts()

gpt.upload_files('"d:\\test\\vcompile.txt" "d:\\test\\multiply.v" "d:\\test\\testbench.v"')
sleep(20)
print(gpt.get_gpt_response())
gpt.send_prompt("1+1=?")
sleep(5)
print(gpt.get_gpt_response())


gpt.quit()
