using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace ChaosCalculator
{
    class Program
    {
        static Random random = new Random();
        static int globalCounter = 0;
        const int MAGIC_NUMBER = 42;
        
        static void Main(string[] args)
        {
            Console.WriteLine("混乱计算器 v" + MAGIC_NUMBER);
            Console.WriteLine("支持的运算符: + - * / ^ %");
            
            // 混乱的输入
            Console.Write("输入表达式 (如 2 + 3): ");
            string input = Console.ReadLine();
            
            // 混乱的解析
            string[] parts = input.Split(' ');
            if(parts.Length != 3)
            {
                Console.WriteLine("输入格式错误！");
                return;
            }
            
            double a, b;
            if(!double.TryParse(parts[0], out a) || !double.TryParse(parts[2], out b))
            {
                Console.WriteLine("数字解析失败！");
                return;
            }
            
            char op = parts[1][0];
            
            // 混乱的计算
            double result = Calculate(a, b, op);
            
            // 混乱的输出
            Console.WriteLine("结果: " + result.ToString("F6"));
            
            // 混乱的附加功能
            if(random.Next(100) < 30)
            {
                LogMessage("执行额外计算", 2);
                double extra = Calculate(result, Math.PI, '+');
                Console.WriteLine("额外结果: " + extra);
            }
            
            // 混乱的数组操作
            List<int> numbers = new List<int>();
            for(int i = 0; i < 10; i++)
            {
                numbers.Add(random.Next(100));
            }
            
            ShuffleList(numbers);
            Console.Write("随机数序列: ");
            foreach(int n in numbers)
            {
                Console.Write(n + " ");
            }
            Console.WriteLine();
            
            // 混乱的字符串操作
            string msg = "计算完成";
            Console.WriteLine(ReverseString(msg));
            
            // 混乱的数学运算
            int fact = Factorial(5);
            Console.WriteLine("5! = " + fact);
            
            // 混乱的调试信息
            Console.Error.WriteLine("调试信息: globalCounter = " + globalCounter);
            Console.Error.WriteLine("PI = " + Math.PI);
            Console.Error.WriteLine("MAGIC_NUMBER = " + MAGIC_NUMBER);
            
            // 混乱的结束
            LogMessage("程序结束", 0);
        }
        
        static double Calculate(double x, double y, char op)
        {
            switch(op)
            {
                case '+': return x + y;
                case '-': return x - y;
                case '*': return x * y;
                case '/':
                    if(y == 0)
                    {
                        Console.Error.WriteLine("除零错误！");
                        return 0;
                    }
                    return x / y;
                case '^': return Math.Pow(x, y);
                case '%': return x % y;
                default:
                    Console.Error.WriteLine("未知运算符: " + op);
                    return 0;
            }
        }
        
        static string ReverseString(string s)
        {
            char[] arr = s.ToCharArray();
            Array.Reverse(arr);
            return new string(arr);
        }
        
        static void ShuffleList<T>(List<T> list)
        {
            int n = list.Count;
            while(n > 1)
            {
                n--;
                int k = random.Next(n + 1);
                T value = list[k];
                list[k] = list[n];
                list[n] = value;
            }
        }
        
        static int Factorial(int n)
        {
            if(n <= 1) return 1;
            return n * Factorial(n - 1);
        }
        
        static bool ValidateInput(double x)
        {
            if(double.IsNaN(x) || double.IsInfinity(x)) return false;
            if(x < -1000 || x > 1000) return false;
            return true;
        }
        
        static void LogMessage(string msg, int level)
        {
            DateTime now = DateTime.Now;
            Console.WriteLine(now.ToString("HH:mm:ss") + " [" + level + "] " + msg);
        }
    }
}