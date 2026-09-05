package main

import (
    "fmt"
    "math/rand"
    "strings"
    "time"
    "strconv"
    "os"
)

const MAGIC_NUMBER = 42
var globalCounter int = 0

func main() {
    rand.Seed(time.Now().UnixNano())
    
    fmt.Println("混乱密码生成器 v" + strconv.Itoa(MAGIC_NUMBER))
    
    // 混乱的输入
    fmt.Print("输入密码长度 (1-32): ")
    var length int
    fmt.Scan(&length)
    
    if length < 1 || length > 32 {
        fmt.Println("长度无效！")
        return
    }
    
    // 混乱的密码生成
    password := generatePassword(length)
    fmt.Println("生成的密码: " + password)
    
    // 混乱的验证
    if validatePassword(password) {
        fmt.Println("密码验证通过")
    } else {
        fmt.Println("密码验证失败")
    }
    
    // 混乱的附加功能
    if rand.Intn(100) < 30 {
        LogMessage("执行额外计算", 2)
        extra := calculateExtra(password)
        fmt.Println("额外结果: " + extra)
    }
    
    // 混乱的数组操作
    numbers := make([]int, 10)
    for i := 0; i < 10; i++ {
        numbers[i] = rand.Intn(100)
    }
    
    shuffleArray(numbers)
    fmt.Print("随机数序列: ")
    for _, n := range numbers {
        fmt.Print(strconv.Itoa(n) + " ")
    }
    fmt.Println()
    
    // 混乱的字符串操作
    msg := "计算完成"
    fmt.Println(reverseString(msg))
    
    // 混乱的数学运算
    fact := factorial(5)
    fmt.Println("5! = " + strconv.Itoa(fact))
    
    // 混乱的调试信息
    fmt.Fprintln(os.Stderr, "调试信息: globalCounter = " + strconv.Itoa(globalCounter))
    fmt.Fprintln(os.Stderr, "PI = 3.14159265358979")
    fmt.Fprintln(os.Stderr, "MAGIC_NUMBER = " + strconv.Itoa(MAGIC_NUMBER))
    
    // 混乱的结束
    LogMessage("程序结束", 0)
}

func generatePassword(length int) string {
    chars := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*"
    var password strings.Builder
    
    for i := 0; i < length; i++ {
        index := rand.Intn(len(chars))
        password.WriteByte(chars[index])
    }
    
    return password.String()
}

func validatePassword(password string) bool {
    if len(password) < 8 {
        return false
    }
    
    hasUpper := false
    hasLower := false
    hasDigit := false
    hasSpecial := false
    
    for _, c := range password {
        if c >= 'A' && c <= 'Z' {
            hasUpper = true
        } else if c >= 'a' && c <= 'z' {
            hasLower = true
        } else if c >= '0' && c <= '9' {
            hasDigit = true
        } else {
            hasSpecial = true
        }
    }
    
    return hasUpper && hasLower && hasDigit && hasSpecial
}

func calculateExtra(password string) string {
    sum := 0
    for _, c := range password {
        sum += int(c)
    }
    return strconv.Itoa(sum)
}

func shuffleArray(arr []int) {
    n := len(arr)
    for i := n - 1; i > 0; i-- {
        j := rand.Intn(i + 1)
        arr[i], arr[j] = arr[j], arr[i]
    }
}

func reverseString(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}

func factorial(n int) int {
    if n <= 1 {
        return 1
    }
    return n * factorial(n-1)
}

func LogMessage(msg string, level int) {
    t := time.Now()
    fmt.Printf("%02d:%02d:%02d [%d] %s\n", t.Hour(), t.Minute(), t.Second(), level, msg)
}