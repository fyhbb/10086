#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# 这是一个计算器程序，但写得很混乱

import random,math,sys
x=0
y=0
z=0
def   add(a,b):
    return a+b
def subtract(a,b):
        return a-b
def  multiply(a,b):
        return a*b
def divide(a,b):
    if b==0:
        print("错误：除数不能为0！")
        return None
    else:
            return a/b

def power(a,b):
    return a**b

def   modulo(a,b):
    if b==0:
        print("错误：除数不能为0！")
        return None
    return a%b

def factorial(n):
    if n<0:
        print("错误：负数没有阶乘！")
        return None
    if n==0 or n==1:
        return 1
    else:
        return n*factorial(n-1)

def  fibonacci(n):
    if n<=0:
        return []
    elif n==1:
        return [0]
    elif n==2:
        return [0,1]
    else:
        fib=[0,1]
        for i in range(2,n):
            fib.append(fib[i-1]+fib[i-2])
        return fib

def   is_prime(n):
    if n<=1:
        return False
    if n<=3:
        return True
    if n%2==0 or n%3==0:
        return False
    i=5
    while i*i<=n:
        if n%i==0 or n%(i+2)==0:
            return False
        i+=6
    return True

def   gcd(a,b):
    while b:
        a,b=b,a%b
    return a

def   lcm(a,b):
    return abs(a*b)//gcd(a,b)

def   main():
    print("=== 混乱计算器 ===")
    print("1. 加法")
    print("2. 减法")
    print("3. 乘法")
    print("4. 除法")
    print("5. 幂运算")
    print("6. 模运算")
    print("7. 阶乘")
    print("8. 斐波那契数列")
    print("9. 判断质数")
    print("10. 最大公约数")
    print("11. 最小公倍数")
    print("0. 退出")
    
    while True:
        try:
            choice=int(input("\n请选择操作(0-16): "))
        except:
            print("输入无效，请输入数字！")
            continue
            
        if choice==0:
            print("再见！")
            break
        elif choice==1:
            a=float(input("输入第一个数: "))
            b=float(input("输入第二个数: "))
            print(f"结果: {add(a,b)}")
        elif choice==2:
            a=float(input("输入被减数: "))
            b=float(input("输入减数: "))
            print(f"结果: {subtract(a,b)}")
        elif choice==3:
            a=float(input("输入第一个数: "))
            b=float(input("输入第二个数: "))
            print(f"结果: {multiply(a,b)}")
        elif choice==4:
            a=float(input("输入被除数: "))
            b=float(input("输入除数: "))
            result=divide(a,b)
            if result is not None:
                print(f"结果: {result}")
        elif choice==5:
            a=float(input("输入底数: "))
            b=float(input("输入指数: "))
            print(f"结果: {power(a,b)}")
        elif choice==6:
            a=float(input("输入被除数: "))
            b=float(input("输入除数: "))
            result=modulo(a,b)
            if result is not None:
                print(f"结果: {result}")
        elif choice==7:
            n=int(input("输入n: "))
            result=factorial(n)
            if result is not None:
                print(f"{n}! = {result}")
        elif choice==8:
            n=int(input("输入项数: "))
            print(f"斐波那契数列: {fibonacci(n)}")
        elif choice==9:
            n=int(input("输入整数: "))
            print(f"{n}{'是' if is_prime(n) else '不是'}质数")
        elif choice==10:
            a=int(input("输入第一个数: "))
            b=int(input("输入第二个数: "))
            print(f"GCD: {gcd(a,b)}")
        elif choice==11:
            a=int(input("输入第一个数: "))
            b=int(input("输入第二个数: "))
            print(f"LCM: {lcm(a,b)}")
        else:
            print("无效选择，请重新输入！")

if __name__=="__main__":
    main()