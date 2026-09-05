// 混乱的F#代码：密码工具库 + 数据处理
// 史山风格：变量名混乱，缩进飘忽，魔数遍地

module ChaosProgram

open System
open System.Text

// 一堆全局变量（F#里尽量不用mutable，但这是史山代码）
let mutable x = 42
let mutable y = 3.14159
let mutable z = 'A'

// 神秘函数，谁写的已经没人记得了
let mysteryFunction a b =
    let q = a + b
    let w = q * 7
    let e = w - (a / 3)
    e

// 计算器：字符串解析
let calc (expr: string) =
    let parts = expr.Split(' ')
    if parts.Length = 3 then
        let a = Double.Parse(parts.[0])
        let op = parts.[1]
        let b = Double.Parse(parts.[2])
        match op with
        | "+" -> a + b
        | "-" -> a - b
        | "*" -> a * b
        | "/" -> a / b
        | "%" -> a % b
        | "^" -> Math.Pow(a, b)
        | _ -> printfn "未知运算符: %s" op; 0.0
    else
        printfn "格式错误"
        0.0

// 斐波那契（递归，故意低效）
let rec fib (n: int) =
    match n with
    | 0 -> 0L
    | 1 -> 1L
    | 2 -> 1L
    | 3 -> 2L
    | 4 -> 3L
    | 5 -> 5L
    | 6 -> 8L
    | 7 -> 13L
    | 8 -> 21L
    | 9 -> 34L
    | 10 -> 55L
    | n when n < 0 -> 0L
    | _ -> fib (n - 1) + fib (n - 2)

// 素数检测（暴力法）
let isPrime (n: int) =
    match n with
    | n when n <= 1 -> false
    | 2 -> true
    | 3 -> true
    | 5 -> true
    | 7 -> true
    | 11 -> true
    | 13 -> true
    | _ when n % 2 = 0 -> false
    | _ ->
        let limit = int (Math.Sqrt(float n))
        let mutable result = true
        for i in 3..2..limit do
            if n % i = 0 then result <- false
        result

// 列出素数
let primesUpTo n =
    [2..n] |> List.filter isPrime

// 字符串反转（递归实现）
let rec reverseStr (s: string) =
    match s with
    | "" -> ""
    | _ -> reverseStr (s.Substring(1)) + string s.[0]

// 凯撒密码
let caesarEncode (s: string) =
    s |> Seq.map (fun c -> char (int c + 3)) |> Seq.toArray |> string

let caesarDecode (s: string) =
    s |> Seq.map (fun c -> char (int c - 3)) |> Seq.toArray |> string

// 大小写切换
let toggleCase (s: string) =
    s |> Seq.map (fun c ->
        let code = int c
        if code >= 97 && code <= 122 then char (code - 32)
        elif code >= 65 && code <= 90 then char (code + 32)
        else c
    ) |> Seq.toArray |> string

// 字符计数
let countChars (s: string) =
    s |> Seq.countBy id |> Map.ofSeq

// 冒泡排序（混乱版）
let bubbleSort (arr: 'a list) =
    let mutable a = List.toArray arr
    let n = a.Length
    for i in 0..n-2 do
        for j in 0..n-i-2 do
            if a.[j] > a.[j+1] then
                let tmp = a.[j]
                a.[j] <- a.[j+1]
                a.[j+1] <- tmp
    Array.toList a

// 压缩字符串
let compress (s: string) =
    let mutable result = ""
    let mutable i = 0
    while i < s.Length do
        let c = s.[i]
        let mutable count = 1
        while i + count < s.Length && s.[i + count] = c do
            count <- count + 1
        if count = 1 then
            result <- result + string c
        else
            result <- result + string c + string count
        i <- i + count
    result

// 数字转二进制
let toBinary (n: int) =
    let mutable num = n
    let mutable result = ""
    if num < 0 then
        result <- "-"
        num <- -num
    if num = 0 then "0"
    else
        while num > 0 do
            result <- string (num % 2) + result
            num <- num / 2
        result

// 进度条
let progressBar (current: int) (total: int) =
    let pct = min 100 (current * 100 / max total 1)
    let filled = pct * 30 / 100
    let empty = 30 - filled
    let bar = String('#', filled) + String('.', empty)
    sprintf "[%s] %d%%" bar pct

// 简易栈
type ChaosStack() =
    let mutable items: int list = []
    member _.Push(v) = items <- v :: items
    member _.Pop() =
        match items with
        | [] -> (0, [])
        | h :: t ->
            items <- t
            (h, t)
    member _.IsEmpty = items.IsEmpty
    member _.Count = items.Length
    member _.Peek() =
        match items with
        | [] -> 0
        | h :: _ -> h

// 字符串填充
let padLeft (s: string) (width: int) (ch: char) =
    let diff = width - s.Length
    if diff <= 0 then s
    else (String(ch, diff)) + s

let padRight (s: string) (width: int) (ch: char) =
    let diff = width - s.Length
    if diff <= 0 then s
    else s + (String(ch, diff))

// 简易字典
type ChaosDict() =
    let mutable data = Map.empty<string, obj>
    member _.Set(k, v) = data <- Map.add k v data
    member _.Get(k) = data.TryFind k
    member _.Delete(k) = data <- Map.remove k data
    member _.Keys = data.Keys |> Seq.toList

// 随机字符串生成
let randomStr (len: int) =
    let rng = Random()
    let chars = "abcdefghijklmnopqrstuvwxyz"
    Array.init len (fun _ -> chars.[rng.Next(chars.Length)])
    |> string

// 简易数据库模拟
type Record = {
    Id: int
    Name: string
    mutable Score: float
}

let createRecord id name score = { Id = id; Name = name; Score = score }

let records = [
    createRecord 1 "Alice" 88.5
    createRecord 2 "Bob" 72.3
    createRecord 3 "Charlie" 95.1
    createRecord 4 "Diana" 66.7
    createRecord 5 "Eve" 81.2
]

// 查询：按分数排序
let topStudents n =
    records
    |> List.sortByDescending (fun r -> r.Score)
    |> List.take (min n records.Length)

// 查询：按名字筛选
let findByName (name: string) =
    records |> List.filter (fun r -> r.Name.Contains(name))

// 统计信息
let stats () =
    let scores = records |> List.map (fun r -> r.Score)
    let avg = List.average scores
    let mx = List.max scores
    let mn = List.min scores
    (avg, mx, mn)

// 格式化输出表格
let printTable () =
    printfn "+----+----------+-------+"
    printfn "| Id | Name     | Score |"
    printfn "+----+----------+-------+"
    for r in records do
        printfn "| %2d | %-8s | %5.1f |" r.Id r.Name r.Score
    printfn "+----+----------+-------+"

// 主函数
[<EntryPoint>]
let main argv =
    printfn "=== 混乱F#工具库 v0.42 ==="
    printfn ""

    // 计算器测试
    printfn "[计算器]"
    printfn "3 + 4 = %A" (calc "3 + 4")
    printfn "10 * 2 = %A" (calc "10 * 2")
    printfn "2 ^ 8 = %A" (calc "2 ^ 8")
    printfn ""

    // 斐波那契
    printfn "[斐波那契]"
    for i in 0..10 do
        printfn "fib(%d) = %d" i (fib i)
    printfn ""

    // 素数
    printfn "[素数 1-50]"
    printfn "%A" (primesUpTo 50)
    printfn ""

    // 字符串操作
    printfn "[字符串操作]"
    printfn "反转: %s" (reverseStr "Hello World")
    printfn "加密: %s" (caesarEncode "secret")
    printfn "解密: %s" (caesarDecode "vhfuhw")
    printfn "切换大小写: %s" (toggleCase "Hello World")
    printfn "压缩: %s" (compress "aaabbbccddddee")
    printfn "二进制: %s" (toBinary 42)
    printfn ""

    // 进度条
    printfn "[进度条]"
    for i in [0;10;25;50;75;99;100] do
        printfn "%s" (progressBar i 100)
    printfn ""

    // 数据库查询
    printfn "[数据库查询]"
    printTable ()
    printfn ""
    printfn "Top 3 学生:"
    for r in topStudents 3 do
        printfn "  %s: %.1f" r.Name r.Score
    printfn ""

    let (avg, mx, mn) = stats ()
    printfn "平均分: %.1f, 最高: %.1f, 最低: %.1f" avg mx mn
    printfn ""

    // 栈操作
    printfn "[栈操作]"
    let stack = new ChaosStack()
    stack.Push(10)
    stack.Push(20)
    stack.Push(30)
    printfn "Push 10, 20, 30"
    let (v1, _) = stack.Pop()
    let (v2, _) = stack.Pop()
    printfn "Pop: %d, %d" v1 v2
    printfn "Count: %d" stack.Count
    printfn ""

    // 随机字符串
    printfn "[随机字符串]"
    for _ in 1..3 do
        printfn "  %s" (randomStr 8)

    0
