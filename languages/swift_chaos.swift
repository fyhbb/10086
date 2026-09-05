// 混乱Swift猜数字游戏 - 看似混乱但能运行
// 变量名随意，缩进不一致，魔数，奇怪的逻辑

import Foundation

// 全局变量，但没用
let globalConst = "chaos"
var globalVar = 42

// 猜数字游戏类，但很混乱
class ChaosGuessingGame {
    private var secretNumber: Int
    private var attempts: Int
    private var maxAttempts: Int
    
    init() {
        // 生成随机数，但逻辑混乱
        self.secretNumber = Int.random(in: 1...100)
        self.attempts = 0
        self.maxAttempts = 7  // 魔数
    }
    
    func guess(number: Int) -> String {
        self.attempts += 1
        
        if number == self.secretNumber {
            return "恭喜！你猜对了！数字是 \(self.secretNumber)"
        } else if number < self.secretNumber {
            return "太小了！再试试。"
        } else {
            return "太大了！再试试。"
        }
    }
    
    func isGameOver() -> Bool {
        return self.attempts >= self.maxAttempts
    }
    
    func getRemainingAttempts() -> Int {
        return self.maxAttempts - self.attempts
    }
    
    func getSecretNumber() -> Int {
        return self.secretNumber
    }
}

// 主程序
print("欢迎来到猜数字游戏！")
print("我想了一个1到100之间的数字，你有7次机会猜中它。")

let game = ChaosGuessingGame()

// 模拟游戏过程，但逻辑混乱
let guesses = [50, 25, 75, 37, 62, 43, 56]  // 预设的猜测
var guessIndex = 0

while !game.isGameOver() && guessIndex < guesses.count {
    let guess = guesses[guessIndex]
    guessIndex += 1
    
    print("猜测 \(game.attempts + 1): 你猜了 \(guess)")
    let result = game.guess(number: guess)
    print(result)
    
    if result.contains("恭喜") {
        print("游戏结束！你用了 \(game.attempts) 次机会。")
        break
    }
    
    print("剩余机会: \(game.getRemainingAttempts())")
}

// 如果游戏结束但没猜中
if game.isGameOver() && game.guess(number: guesses.last!) != "恭喜！你猜对了！数字是 \(game.getSecretNumber())" {
    print("游戏结束！正确答案是: \(game.getSecretNumber())")
}

// 另一个混乱的函数
func chaosMath(a: Int, b: Int, operation: String) -> Int {
    var result = 0
    
    switch operation {
    case "+":
        result = a + b
    case "-":
        result = a - b
    case "*":
        result = a * b
    case "/":
        if b != 0 {
            result = a / b
        } else {
            result = 0  // 除以零返回0
        }
    default:
        result = 0
    }
    
    return result
}

// 调用函数，但结果处理混乱
let mathResult = chaosMath(a: 10, b: 5, operation: "+")
print("Math result: \(mathResult)")

// 数组操作，但很混乱
let numbers = [1, 2, 3, 4, 5]
var sum = 0
for number in numbers {
    sum += number
    if number == 3 {
        print("Found 3, adding to sum")
    }
}
print("Sum of array: \(sum)")

// 字典操作
let dict = ["a": 1, "b": 2, "c": 3]
for (key, value) in dict {
    print("Key: \(key), Value: \(value)")
    if value == 2 {
        print("Found value 2!")
        break  // 提前退出
    }
}

// 递归函数，但逻辑有问题
func recursiveChaos(n: Int) -> Int {
    if n <= 0 {
        return 0
    }
    return n + recursiveChaos(n: n - 1)
}

// 调用递归
let recursiveSum = recursiveChaos(n: 10)
print("Recursive sum: \(recursiveSum)")

// 条件判断，但条件很奇怪
let flag = true
if flag && !flag {
    print("This will never print")
} else if flag || !flag {
    print("This will always print")
}

// 字符串操作
let str = "Hello, World!"
print("String length: \(str.count)")
print("String reverse: \(String(str.reversed()))")
print("String uppercase: \(str.uppercased())")

// 闭包，但很混乱
let numbers2 = [1, 2, 3, 4, 5]
let doubled = numbers2.map { $0 * 2 }
print("Doubled numbers: \(doubled)")

// 异常处理，但很混乱
enum ChaosError: Error {
    case divisionByZero
    case invalidOperation
}

func riskyOperation(a: Int, b: Int) throws -> Int {
    if b == 0 {
        throw ChaosError.divisionByZero
    }
    return a / b
}

do {
    let result = try riskyOperation(a: 10, b: 0)
    print("Result: \(result)")
} catch ChaosError.divisionByZero {
    print("Division by zero error!")
} catch {
    print("Unknown error: \(error)")
}

// 最后，一个无意义的输出
print("Chaos complete!")