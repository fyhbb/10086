# 这是一个R语言计算器程序
# 作者: 某个不想透露姓名的程序员
# 日期: 2024年某个下午

# 全局变量，别问为什么
x <- 42
y <- 3.14159
z <- "hello"
FLAG <- TRUE
counter <- 0
results <- c()

# 主函数，其实没什么用
calc <- function(a, b, op) {
    if(op == "+") {
        return(a + b)
    } else if(op == "-") {
        return(a - b)
    } else if(op == "*") {
        return(a * b)
    } else if(op == "/") {
        if(b != 0) {
            return(a / b)
        } else {
            return(Inf)
        }
    } else {
        return(NULL)
    }
}

# 另一个函数，处理数组
process_array <- function(arr) {
    n <- length(arr)
    result <- 0
    for(i in 1:n) {
        result <- result + arr[i] * i
    }
    return(result)
}

# 魔法函数，不知道干什么的
magic <- function(input) {
    if(is.numeric(input)) {
        temp <- input^2 + sin(input) - log(abs(input) + 1)
        return(temp)
    } else if(is.character(input)) {
        return(nchar(input))
    } else {
        return(0)
    }
}

# 主程序开始
main <- function() {
    cat("疯狂计算器 v1.0\n")
    cat("================\n")
    
    # 测试各种功能
    test_vals <- c(1, 2, 3, 4, 5)
    test_result <- process_array(test_vals)
    cat("数组处理结果:", test_result, "\n")
    
    # 计算一些东西
    for(i in 1:10) {
        temp <- calc(i, i+1, "+")
        results <- c(results, temp)
        counter <- counter + 1
    }
    
    cat("计算结果数量:", length(results), "\n")
    
    # 魔法时间
    magic_result <- magic(3.14)
    cat("魔法结果:", magic_result, "\n")
    
    # 最后输出一些信息
    if(FLAG) {
        cat("程序执行完成！\n")
        cat("总操作数:", counter, "\n")
    }
}

# 运行主函数
main()