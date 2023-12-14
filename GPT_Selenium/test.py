import gpt_parser
from gpt_parser import gptParser
from time import sleep

username = "账号"
password = "密码"


# Set the working directory to ModelSim's directory
modelsim_dir = 'F:/modeltech64_10.7'
# Define the absolute paths
file_dir = "d:/Users/Downloads"
design_file = "d:/Users/Downloads/design.v"
testbench_file = "d:/Users/Downloads/tb.v"
compile_report_file = "d:/Users/Downloads/compile_report.txt"
simulation_report_file = "d:/Users/Downloads/simulation_report.txt"

i=0 #循环次数

dirver = gptParser.get_driver()
gpt = gptParser(driver=dirver)

input("确认您是真人")

gpt.auto_login(username,password)
sleep(5)

gpt_parser.auto_modelsim(modelsim_dir,design_file,testbench_file,compile_report_file,simulation_report_file)
num = gpt_parser.error_num(compile_report_file)

gpt_parser.rename_file(file_dir,"design.v","design.txt")
gpt_parser.rename_file(file_dir,"tb.v","tb.txt")


while(num!=0):
    i=i+1
    gpt.set_gpts()

    gpt.upload_files('"d:\\Users\\Downloads\\design.txt" "d:\\Users\\Downloads\\tb.txt" "d:\\Users\\Downloads\\compile_report.txt"')
    sleep(120)
    gpt.send_prompt("please provide the file in form of .v files which named updated_design.v and updated_tb.v.")
    sleep(120)
    gpt.download_files()

    gpt_parser.auto_modelsim(modelsim_dir,"d:/Users/Downloads/updated_design.v","d:/Users/Downloads/updated_tb.v",compile_report_file,simulation_report_file)
    # with open('gpts.txt', 'w') as f:
    #     print(gpt.get_gpt_response(),file=f)
    num = gpt_parser.error_num(compile_report_file)
    print(num) 
    
    gpt_parser.rename_file(file_dir,"design.txt","design("+str(i)+").txt")
    gpt_parser.rename_file(file_dir,"tb.txt","tb("+str(i)+").txt")
    gpt_parser.rename_file(file_dir,"updated_design.v","design.txt")
    gpt_parser.rename_file(file_dir,"updated_tb.v","tb.txt")


gpt.quit()