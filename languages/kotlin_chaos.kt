// 混乱Kotlin代码 - 看似混乱但能运行
// 变量名随意，缩进不一致，魔数，奇怪的逻辑

// 全局变量，但没用
val globalConst = "chaos"
var globalVar = 42

// 混乱类
class ChaosClass {
    private var data = mutableListOf<Int>()
    private val magicNumber = 12345  // 魔数
    
    constructor(seed: Int) {
        // 初始化，但逻辑混乱
        for (i in 1..5) {
            data.add(seed * i)
        }
    }
    
    fun getData(): List<Int> {
        return data
    }
    
    fun getMagicNumber(): Int {
        return magicNumber
    }
    
    fun processData(): Int {
        var sum = 0
        for (item in data) {
            sum += item
            if (item > 10) {
                println("Found large item: $item")
            }
        }
        return sum
    }
}

// 主函数
fun main() {
    println("欢迎来到Kotlin混乱世界！")
    
    // 使用类，但很奇怪
    val obj = ChaosClass(5)
    println("Class data: ${obj.getData()}")
    println("Magic number: ${obj.getMagicNumber()}")
    
    val processed = obj.processData()
    println("Processed sum: $processed")
    
    // 另一个混乱的函数
    val result = chaosMath(10, 5, "+")
    println("Math result: $result")
    
    // 数组操作，但很混乱
    val numbers = listOf(1, 2, 3, 4, 5)
    var sum = 0
    for (number in numbers) {
        sum += number
        if (number == 3) {
            println("Found 3, adding to sum")
        }
    }
    println("Sum of array: $sum")
    
    // Map操作
    val map = mapOf("a" to 1, "b" to 2, "c" to 3)
    for ((key, value) in map) {
        println("Key: $key, Value: $value")
        if (value == 2) {
            println("Found value 2!")
            break  // 提前退出
        }
    }
    
    // 递归函数，但逻辑有问题
    val recursiveSum = recursiveChaos(10)
    println("Recursive sum: $recursiveSum")
    
    // 条件判断，但条件很奇怪
    val flag = true
    if (flag && !flag) {
        println("This will never print")
    } else if (flag || !flag) {
        println("This will always print")
    }
    
    // 字符串操作
    val str = "Hello, World!"
    println("String length: ${str.length}")
    println("String reverse: ${str.reversed()}")
    println("String uppercase: ${str.uppercase()}")
    
    // Lambda表达式，但很混乱
    val numbers2 = listOf(1, 2, 3, 4, 5)
    val doubled = numbers2.map { it * 2 }
    println("Doubled numbers: $doubled")
    
    // 异常处理，但很混乱
    try {
        val riskyResult = riskyOperation(10, 0)
        println("Result: $riskyResult")
    } catch (e: ArithmeticException) {
        println("Division by zero error!")
    } catch (e: Exception) {
        println("Unknown error: ${e.message}")
    }
    
    // 最后，一个无意义的输出
    println("Chaos complete!")
}

// 混乱数学函数
fun chaosMath(a: Int, b: Int, operation: String): Int {
    var result = 0
    
    when (operation) {
        "+" -> result = a + b
        "-" -> result = a - b
        "*" -> result = a * b
        "/" -> {
            if (b != 0) {
                result = a / b
            } else {
                result = 0  // 除以零返回0
            }
        }
        else -> result = 0
    }
    
    return result
}

// 递归函数
fun recursiveChaos(n: Int): Int {
    if (n <= 0) {
        return 0
    }
    return n + recursiveChaos(n - 1)
}

// 风险操作
fun riskyOperation(a: Int, b: Int): Int {
    if (b == 0) {
        throw ArithmeticException("Division by zero")
    }
    return a / b
}

// 扩展函数，但很混乱
fun Int.chaosExtension(): Int {
    return this * 2 + 1
}

// 数据类
data class ChaosData(val id: Int, val value: String)

// 使用数据类
fun useChaosData() {
    val data1 = ChaosData(1, "first")
    val data2 = ChaosData(2, "second")
    
    println("Data1: $data1")
    println("Data2: $data2")
    println("Data1 equals Data2: ${data1 == data2}")
}

// 高阶函数
fun highOrderFunction(operation: (Int, Int) -> Int, a: Int, b: Int): Int {
    return operation(a, b)
}

// 使用高阶函数
fun useHighOrderFunction() {
    val sum = highOrderFunction({ x, y -> x + y }, 5, 3)
    println("High order function result: $sum")
}