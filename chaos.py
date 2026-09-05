#!/usr/bin/env python3
import os,sys,json,random,string,time
from collections import defaultdict
from typing import List, Dict, Tuple, Optional, Any

# 混乱计算器 v0.1
class ChaosCalc:
    def __init__(self):
        self.history = []
        self.memories = {}
        
    def calc(self, expr):
        try:
            result = eval(expr)
            self.history.append((expr, result))
            return result
        except:
            return "你算错了"
    
    def add_memory(self, key, value):
        self.memories[key] = value
        
    def get_memory(self, key):
        return self.memories.get(key, "没有这个记忆")

# 随机字符串生成器
def gen_random(length=8):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

# 随机颜色
def random_color():
    return f"#{random.randint(0, 0xFFFFFF):06x}"

# 生成随机数据
def gen_data(count=10):
    data = []
    for i in range(count):
        data.append({
            "id": gen_random(6),
            "value": random.randint(1, 100),
            "color": random_color(),
            "name": f"item_{i}"
        })
    return data

# 混乱的格式化输出
def chaos_print(msg, style="normal"):
    styles = {
        "normal": msg,
        "bold": f"\033[1m{msg}\033[0m",
        "underline": f"\033[4m{msg}\033[0m",
        "reverse": f"\033[7m{msg}\033[0m"
    }
    print(styles.get(style, msg))

# 延迟执行
def delayed_exec(seconds, func, *args, **kwargs):
    time.sleep(seconds)
    return func(*args, **kwargs)

# 混乱的递归
def chaos_recursion(n):
    if n <= 0:
        return "结束"
    print(f"递归层级: {n}")
    chaos_recursion(n-1)

# 主程序
if __name__ == "__main__":
    calc = ChaosCalc()
    
    chaos_print("=== 混乱计算器 ===", "bold")
    
    while True:
        try:
            user_input = input("\n输入表达式 (或 'quit' 退出): ")
            if user_input.lower() == 'quit':
                break
            elif user_input.startswith('mem '):
                parts = user_input.split(' ', 2)
                if len(parts) == 3:
                    calc.add_memory(parts[1], parts[2])
                    chaos_print("已记住", "underline")
            elif user_input.startswith('recall '):
                key = user_input.split(' ', 1)[1]
                chaos_print(f"记忆: {calc.get_memory(key)}")
            else:
                result = calc.calc(user_input)
                chaos_print(f"结果: {result}", "reverse")
        except:
            print("出错了")