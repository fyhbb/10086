use std::io;
use std::io::Write;
use rand::Rng;
use std::time::{SystemTime, UNIX_EPOCH};

const MAGIC_NUMBER: i32 = 42;
static mut GLOBAL_COUNTER: i32 = 0;

fn main() {
    let mut rng = rand::thread_rng();
    
    println!("混乱计算器 v{}", MAGIC_NUMBER);
    println!("支持的运算符: + - * / ^ %");
    
    // 混乱的输入
    print!("输入表达式 (如 2 + 3): ");
    io::stdout().flush().unwrap();
    
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("读取失败");
    
    // 混乱的解析
    let parts: Vec<&str> = input.trim().split_whitespace().collect();
    if parts.len() != 3 {
        println!("输入格式错误！");
        return;
    }
    
    let a: f64 = match parts[0].parse() {
        Ok(num) => num,
        Err(_) => {
            println!("数字解析失败！");
            return;
        }
    };
    
    let b: f64 = match parts[2].parse() {
        Ok(num) => num,
        Err(_) => {
            println!("数字解析失败！");
            return;
        }
    };
    
    let op = parts[1].chars().next().unwrap();
    
    // 混乱的计算
    let result = calculate(a, b, op);
    
    // 混乱的输出
    println!("结果: {:.6}", result);
    
    // 混乱的附加功能
    if rng.gen_range(0..100) < 30 {
        log_message("执行额外计算", 2);
        let extra = calculate(result, std::f64::consts::PI, '+');
        println!("额外结果: {}", extra);
    }
    
    // 混乱的数组操作
    let mut numbers: Vec<i32> = (0..10).map(|_| rng.gen_range(0..100)).collect();
    shuffle_array(&mut numbers);
    print!("随机数序列: ");
    for n in &numbers {
        print!("{} ", n);
    }
    println!();
    
    // 混乱的字符串操作
    let msg = "计算完成";
    println!("{}", reverse_string(msg));
    
    // 混乱的数学运算
    let fact = factorial(5);
    println!("5! = {}", fact);
    
    // 混乱的调试信息
    eprintln!("调试信息: GLOBAL_COUNTER = {}", unsafe { GLOBAL_COUNTER });
    eprintln!("PI = {}", std::f64::consts::PI);
    eprintln!("MAGIC_NUMBER = {}", MAGIC_NUMBER);
    
    // 混乱的结束
    log_message("程序结束", 0);
}

fn calculate(x: f64, y: f64, op: char) -> f64 {
    match op {
        '+' => x + y,
        '-' => x - y,
        '*' => x * y,
        '/' => {
            if y == 0.0 {
                eprintln!("除零错误！");
                0.0
            } else {
                x / y
            }
        }
        '^' => x.powf(y),
        '%' => x % y,
        _ => {
            eprintln!("未知运算符: {}", op);
            0.0
        }
    }
}

fn shuffle_array(arr: &mut Vec<i32>) {
    let mut rng = rand::thread_rng();
    let n = arr.len();
    for i in (1..n).rev() {
        let j = rng.gen_range(0..=i);
        arr.swap(i, j);
    }
}

fn reverse_string(s: &str) -> String {
    s.chars().rev().collect()
}

fn factorial(n: i32) -> i64 {
    if n <= 1 {
        1
    } else {
        n as i64 * factorial(n - 1)
    }
}

fn validate_input(x: f64) -> bool {
    if x.is_nan() || x.is_infinite() {
        return false;
    }
    if x < -1000.0 || x > 1000.0 {
        return false;
    }
    true
}

fn log_message(msg: &str, level: i32) {
    let duration = SystemTime::now().duration_since(UNIX_EPOCH).unwrap();
    let secs = duration.as_secs();
    let hours = (secs / 3600) % 24;
    let minutes = (secs / 60) % 60;
    let seconds = secs % 60;
    
    println!("{:02}:{:02}:{:02} [{}] {}", hours, minutes, seconds, level, msg);
}

// 混乱的辅助函数
fn chaotic_helper(x: i32) -> i32 {
    unsafe {
        GLOBAL_COUNTER += 1;
    }
    if x % 2 == 0 {
        x * 2 + MAGIC_NUMBER
    } else {
        x * 3 - MAGIC_NUMBER
    }
}