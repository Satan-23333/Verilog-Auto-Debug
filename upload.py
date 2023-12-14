import os
import time
import re

def main():
    # 启动仿真
    result = os.system('sim.bat')

    #定义文件路径
    path_design = ".\\design"
    path_log = ".\\"
    path_md = "D:\\Code\\Blog\\source\\_posts\\Multiply.md"
    design_files = collect_design(path_design)

    for i, design_file in enumerate(design_files):
        print(f"\t{i}:  {design_file}")

    result = ""
    current_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
    result += f"""---
title: Multiply
date: {current_time}
tags:
---
"""
    result += """---
## 1 **Spec**
---
"""
    result += """| 左对齐 | 右对齐 | 居中对齐 |
| :-----| ----: | :----: |
| 单元格 | 单元格 | 单元格 |
| 单元格 | 单元格 | 单元格 |
"""
    result += """---
## 2 **Design**
---
"""

    for i, design_file in enumerate(design_files):
        out = design_file.split("\\")[-1]
        result += f"### 2.{i+1} *{out}*\n"
        result += '``` Verilog\n'
        with open(design_file,'r',encoding="utf-8") as design:
            content = design.read()
        result += content
        result +='```\n'
    result += '''---
## 3 **Log**
---
### 3.1 *Compile Log*'''
    with open(path_log + 'vcompile.txt','r',encoding="utf-8") as design:
        content = design.read()
    #正则表达式查找报错信息   
    s = re.search(r"Errors: .*? Warnings: .*",content).group()
    result +=f'<p align="right">**{s}**</p>\n' 
    
    result +='```\n' 
    result += content
    result +='```\n'
    
    result += '### 3.2 *Simulation Log*'
    with open(path_log + 'vsim.txt','r',encoding="utf-8") as design:
        content = design.read()
    #正则表达式查找报错信息
    s = re.search(r"Errors: .*? Warnings: .*",content).group()
    result +=f'<p align="right">**{s}**</p>\n' 
    
    result +='```\n'
    result += content
    result +='```\n'
    
    result += '### 3.3 *TestBench Output*\n'

    result +='```\n'
    with open(path_log + 'report.txt','r',encoding="utf-8") as design:
        content = design.read()
    result += content
    result +='```\n'

    # 打开md文件，将仿真信息按格式写入md文件
    with open(path_md, "w", encoding="utf-8") as f:
        f.write(result)

    # 进入网页文件夹，生成网页索引，启动网页服务
    result = os.system('cd ../../Blog && hexo g -d && hexo s')
    # os.system("pause")

'''
遍历文件夹下的所.v文件，若文件名存在Disabled则跳过
'''
def collect_design(path, ignore="disabled"):
    design_files = []
    for root, dir, files in os.walk(path):
        if "disabled" in root.lower():
            continue
        for file in files:
            if "disabled" in file.lower() or ignore.lower() in file.lower():
                continue
            if os.path.splitext(file)[1] == ".v":
                design_files.append(os.path.join(root, file))
    return design_files


if __name__ == "__main__":
    main()
