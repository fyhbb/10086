#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <cmath>
#include <string>
#include <sstream>
#include <map>
#include <set>
#include <queue>
#include <stack>
#include <deque>
#include <functional>
#include <ctime>
#include <cstdlib>
#include <iomanip>
#include <limits>

using namespace std;

// 混乱的变量命名
int global_counter = 0;
const double PI = 3.14159265358979;
const int MAGIC_NUMBER = 42;

// 混乱的函数
double calculate(double x, double y, char op) {
    switch(op) {
        case '+': return x + y;
        case '-': return x - y;
        case '*': return x * y;
        case '/': 
            if(y == 0) {
                cerr << "除零错误！" << endl;
                return 0;
            }
            return x / y;
        case '^': return pow(x, y);
        case '%': return fmod(x, y);
        default: 
            cerr << "未知运算符: " << op << endl;
            return 0;
    }
}

// 混乱的字符串处理
string reverse_string(string s) {
    reverse(s.begin(), s.end());
    return s;
}

// 混乱的数组操作
void shuffle_array(vector<int>& arr) {
    random_shuffle(arr.begin(), arr.end());
}

// 混乱的数学函数
int factorial(int n) {
    if(n <= 1) return 1;
    return n * factorial(n - 1);
}

// 混乱的验证函数
bool validate_input(double x) {
    if(isnan(x) || isinf(x)) return false;
    if(x < -1000 || x > 1000) return false;
    return true;
}

// 混乱的日志函数
void log_message(string msg, int level) {
    time_t now = time(0);
    tm* ltm = localtime(&now);
    cout << setfill('0') << setw(2) << ltm->tm_hour << ":"
         << setw(2) << ltm->tm_min << ":" << setw(2) << ltm->tm_sec
         << " [" << level << "] " << msg << endl;
}

int main() {
    srand(time(0));
    
    // 混乱的初始化
    vector<int> numbers;
    for(int i = 0; i < 10; i++) {
        numbers.push_back(rand() % 100);
    }
    
    // 混乱的输入
    cout << "混乱计算器 v" << MAGIC_NUMBER << endl;
    cout << "支持的运算符: + - * / ^ %" << endl;
    
    string input;
    cout << "输入表达式 (如 2 + 3): ";
    getline(cin, input);
    
    // 混乱的解析
    istringstream iss(input);
    double a, b;
    char op;
    iss >> a >> op >> b;
    
    // 混乱的验证
    if(!validate_input(a) || !validate_input(b)) {
        log_message("输入验证失败", 1);
        return 1;
    }
    
    // 混乱的计算
    double result = calculate(a, b, op);
    
    // 混乱的输出
    cout << "结果: " << fixed << setprecision(6) << result << endl;
    
    // 混乱的附加功能
    if(rand() % 100 < 30) {
        log_message("执行额外计算", 2);
        double extra = calculate(result, PI, '+');
        cout << "额外结果: " << extra << endl;
    }
    
    // 混乱的数组操作
    shuffle_array(numbers);
    cout << "随机数序列: ";
    for(int n : numbers) {
        cout << n << " ";
    }
    cout << endl;
    
    // 混乱的字符串操作
    string msg = "计算完成";
    cout << reverse_string(msg) << endl;
    
    // 混乱的数学运算
    int fact = factorial(5);
    cout << "5! = " << fact << endl;
    
    // 混乱的调试信息
    cerr << "调试信息: global_counter = " << global_counter << endl;
    cerr << "PI = " << PI << endl;
    cerr << "MAGIC_NUMBER = " << MAGIC_NUMBER << endl;
    
    // 混乱的结束
    log_message("程序结束", 0);
    
    return 0;
}