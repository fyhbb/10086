# 混乱的Julia代码：科学计算 + 文本处理工具
# 史山风格：变量名随意，注释疯狂，魔数横飞

module ChaosJulia

export calc, fib, is_prime, caesar_encode, bubble_sort, compress
export progress_bar, random_string, stats_table

# 一些全局变量（没人知道这些是干嘛的）
const x = 42
const y = 3.14159265358979
const z = 'A'

# 神秘函数
function mystery_function(a, b)
    q = a + b
    w = q * 7
    e = w - div(a, 3)
    return e
end

# 计算器：字符串解析
function calc(expr::String)
    parts = split(expr)
    if length(parts) == 3
        a = parse(Float64, parts[1])
        op = parts[2]
        b = parse(Float64, parts[3])
        if op == "+"
            return a + b
        elseif op == "-"
            return a - b
        elseif op == "*"
            return a * b
        elseif op == "/"
            return a / b
        elseif op == "%"
            return mod(a, b)
        elseif op == "^"
            return a ^ b
        else
            println("未知运算符: ", op)
            return 0.0
        end
    else
        println("格式错误")
        return 0.0
    end
end

# 斐波那契（递归，故意低效）
function fib(n::Int)
    if n == 0
        return 0
    elseif n == 1
        return 1
    elseif n == 2
        return 1
    elseif n == 3
        return 2
    elseif n == 4
        return 3
    elseif n == 5
        return 5
    elseif n == 6
        return 8
    elseif n == 7
        return 13
    elseif n == 8
        return 21
    elseif n == 9
        return 34
    elseif n == 10
        return 55
    elseif n < 0
        return 0
    else
        return fib(n - 1) + fib(n - 2)
    end
end

# 素数检测（暴力法）
function is_prime(n::Int)
    if n <= 1
        return false
    elseif n == 2
        return true
    elseif n == 3
        return true
    elseif n == 5
        return true
    elseif n == 7
        return true
    elseif n == 11
        return true
    elseif n == 13
        return true
    elseif mod(n, 2) == 0
        return false
    else
        limit = isqrt(n)
        for i in 3:2:limit
            if mod(n, i) == 0
                return false
            end
        end
        return true
    end
end

# 列出素数
function primes_up_to(n::Int)
    return filter(is_prime, 2:n)
end

# 字符串反转（递归实现）
function reverse_str(s::String)
    if length(s) == 0
        return ""
    else
        return reverse_str(s[2:end]) * string(s[1])
    end
end

# 凯撒密码
function caesar_encode(s::String)
    return join([Char(Int(c) + 3) for c in s])
end

function caesar_decode(s::String)
    return join([Char(Int(c) - 3) for c in s])
end

# 大小写切换
function toggle_case(s::String)
    result = Char[]
    for c in s
        code = Int(c)
        if code >= 97 && code <= 122
            push!(result, Char(code - 32))
        elseif code >= 65 && code <= 90
            push!(result, Char(code + 32))
        else
            push!(result, c)
        end
    end
    return join(result)
end

# 字符计数
function count_chars(s::String)
    counts = Dict{Char, Int}()
    for c in s
        counts[c] = get(counts, c, 0) + 1
    end
    return counts
end

# 冒泡排序（混乱版）
function bubble_sort(arr)
    a = copy(arr)
    n = length(a)
    for i in 1:n-1
        for j in 1:n-i
            if a[j] > a[j+1]
                a[j], a[j+1] = a[j+1], a[j]
            end
        end
    end
    return a
end

# 压缩字符串
function compress(s::String)
    if isempty(s)
        return ""
    end
    result = ""
    i = 1
    while i <= length(s)
        c = s[i]
        count = 1
        while i + count <= length(s) && s[i+count] == c
            count += 1
        end
        if count == 1
            result *= string(c)
        else
            result *= string(c) * string(count)
        end
        i += count
    end
    return result
end

# 数字转二进制
function to_binary(n::Int)
    if n == 0
        return "0"
    end
    result = ""
    num = abs(n)
    while num > 0
        result = string(mod(num, 2)) * result
        num = div(num, 2)
    end
    if n < 0
        result = "-" * result
    end
    return result
end

# 进度条
function progress_bar(current::Int, total::Int)
    pct = min(100, div(current * 100, max(total, 1)))
    filled = div(pct * 30, 100)
    empty = 30 - filled
    bar = "^" * filled * "." * empty * "] "
    return "[$bar$pct%"
end

# 随机字符串生成
function random_string(len::Int)
    chars = "abcdefghijklmnopqrstuvwxyz"
    result = ""
    for _ in 1:len
        result *= chars[rand(1:length(chars))]
    end
    return result
end

# 简易栈
mutable struct ChaosStack
    items::Vector{Int}
    ChaosStack() = new(Int[])
end

function stack_push!(s::ChaosStack, v::Int)
    pushfirst!(s.items, v)
end

function stack_pop!(s::ChaosStack)
    if isempty(s.items)
        return (0, Int[])
    else
        v = popfirst!(s.items)
        return (v, s.items)
    end
end

# 字符串填充
function pad_left(s::String, width::Int, ch::Char)
    diff = width - length(s)
    if diff <= 0
        return s
    else
        return ch^diff * s
    end
end

function pad_right(s::String, width::Int, ch::Char)
    diff = width - length(s)
    if diff <= 0
        return s
    else
        return s * ch^diff
    end
end

# 简易字典
mutable struct ChaosDict
    data::Dict{String, Any}
    ChaosDict() = new(Dict{String, Any}())
end

function dict_set!(d::ChaosDict, key::String, val)
    d.data[key] = val
end

function dict_get(d::ChaosDict, key::String)
    return get(d.data, key, nothing)
end

function dict_delete!(d::ChaosDict, key::String)
    delete!(d.data, key)
end

# 学生成绩记录
struct Student
    id::Int
    name::String
    score::Float64
end

const students = [
    Student(1, "Alice", 88.5)
    Student(2, "Bob", 72.3)
    Student(3, "Charlie", 95.1)
    Student(4, "Diana", 66.7)
    Student(5, "Eve", 81.2)
]

# 查询top N学生
function top_students(n::Int)
    sorted = sort(students, by=s -> s.score, rev=true)
    return sorted[1:min(n, length(sorted))]
end

# 按名字搜索
function find_by_name(name::String)
    return filter(s -> occursin(name, s.name), students)
end

# 统计信息
function stats_table()
    scores = [s.score for s in students]
    avg = sum(scores) / length(scores)
    mx = maximum(scores)
    mn = minimum(scores)
    return (avg, mx, mn)
end

# 格式化输出
function print_table()
    println("+----+----------+-------+")
    println("| Id | Name     | Score |")
    println("+----+----------+-------+")
    for s in students
        Printf.@printf("| %2d | %-8s | %5.1f |\n", s.id, s.name, s.score)
    end
    println("+----+----------+-------+")
end

# 主函数
function main()
    println("=== 混乱Julia工具库 v0.42 ===")
    println()

    # 计算器
    println("[计算器]")
    println("3 + 4 = ", calc("3 + 4"))
    println("10 * 2 = ", calc("10 * 2"))
    println("2 ^ 8 = ", calc("2 ^ 8"))
    println()

    # 斐波那契
    println("[斐波那契]")
    for i in 0:10
        println("fib($i) = ", fib(i))
    end
    println()

    # 素数
    println("[素数 1-50]")
    println(primes_up_to(50))
    println()

    # 字符串操作
    println("[字符串操作]")
    println("反转: ", reverse_str("Hello World"))
    println("加密: ", caesar_encode("secret"))
    println("解密: ", caesar_decode("vhfuhw"))
    println("切换大小写: ", toggle_case("Hello World"))
    println("压缩: ", compress("aaabbbccddddee"))
    println("二进制: ", to_binary(42))
    println()

    # 进度条
    println("[进度条]")
    for i in [0, 10, 25, 50, 75, 99, 100]
        println(progress_bar(i, 100))
    end
    println()

    # 排序
    println("[冒泡排序]")
    data = [64, 34, 25, 12, 22, 11, 90]
    println("原始: ", data)
    println("排序: ", bubble_sort(data))
    println()

    # 栈操作
    println("[栈操作]")
    s = ChaosStack()
    stack_push!(s, 10)
    stack_push!(s, 20)
    stack_push!(s, 30)
    println("Push 10, 20, 30")
    v1, _ = stack_pop!(s)
    v2, _ = stack_pop!(s)
    println("Pop: $v1, $v2")
    println("Count: ", length(s.items))
    println()

    # 字典
    println("[字典操作]")
    d = ChaosDict()
    dict_set!(d, "name", "Chaos")
    dict_set!(d, "version", 0.42)
    println("Get name: ", dict_get(d, "name"))
    println("Get version: ", dict_get(d, "version"))
    println()

    # 学生数据
    println("[学生成绩]")
    print_table()
    println()
    println("Top 3 学生:")
    for s in top_students(3)
        println("  $(s.name): $(s.score)")
    end
    println()
    (avg, mx, mn) = stats_table()
    println("平均分: $avg, 最高: $mx, 最低: $mn")
    println()

    # 随机字符串
    println("[随机字符串]")
    for _ in 1:3
        println("  ", random_string(8))
    end
end

# 使用Printf模块（需要导入）
using Printf

# 运行主函数
main()

end # module
