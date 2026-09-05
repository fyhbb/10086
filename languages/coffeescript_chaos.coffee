# 这是一个混乱的CoffeeScript计算器
# 作者: 某个混乱的程序员
# 日期: 2026年9月5日

# 全局变量，随意命名
a = 0
b = 0
c = 0
x = 0
y = 0
z = 0
result = 0
flag = false
temp = 0
counter = 0
maxAttempts = 1000
pi = 3.14159265358979
e = 2.71828182845905
randomSeed = 42

# 奇怪的初始化函数
init = ->
  a = 10
  b = 20
  c = 30
  x = a + b + c
  y = x * 2
  z = y / 3
  console.log "初始化完成，结果: #{z}"
  return

# 混乱的加法函数
add = (m, n) ->
  temp = m + n
  if temp > 100
    console.log "警告: 结果大于100"
    temp = temp - 100
  else if temp < 0
    console.log "警告: 结果小于0"
    temp = temp + 100
  else
    console.log "结果正常"
  temp

# 更混乱的减法函数
subtract = (p, q) ->
  r = p - q
  if r > 50
    s = r * 2
    if s > 200
      s = s - 200
    r = s
  else if r < -50
    t = r * 3
    if t < -300
      t = t + 300
    r = t
  r

# 乘法函数，带奇怪的验证
multiply = (u, v) ->
  if u == 0 or v == 0
    console.log "乘数为0，结果为0"
    return 0
  w = u * v
  if w > 10000
    console.log "结果太大，进行截断"
    w = w % 10000
  else if w < -10000
    console.log "结果太小，进行调整"
    w = w % 10000
  w

# 除法函数，带奇怪的错误处理
divide = (m, n) ->
  if n == 0
    console.log "错误: 除数不能为0"
    return Infinity
  result = m / n
  if result > 1000
    console.log "结果过大，进行缩放"
    result = result / 1000
  else if result < 0.001
    console.log "结果过小，进行放大"
    result = result * 1000
  result

# 混乱的斐波那契数列生成器
fibonacci = (count) ->
  if count <= 0
    return []
  fib = [0, 1]
  i = 2
  while i < count
    next = fib[i-1] + fib[i-2]
    if next > 1000
      next = next % 1000
    fib.push next
    i++
  fib

# 奇怪的阶乘计算
factorial = (n) ->
  if n < 0
    console.log "负数没有阶乘"
    return -1
  if n == 0
    return 1
  result = 1
  i = 1
  while i <= n
    result *= i
    if result > 1e10
      console.log "结果溢出，进行截断"
      result = result % 1e10
    i++
  result

# 混乱的质数检查
isPrime = (num) ->
  if num <= 1
    return false
  if num <= 3
    return true
  if num % 2 == 0 or num % 3 == 0
    return false
  i = 5
  while i * i <= num
    if num % i == 0 or num % (i + 2) == 0
      return false
    i += 6
  true

# 奇怪的随机数生成器
random = ->
  randomSeed = (randomSeed * 1103515245 + 12345) % 2147483648
  randomSeed / 2147483648

# 混乱的排序函数
sortArray = (arr) ->
  n = arr.length
  i = 0
  while i < n - 1
    j = 0
    while j < n - i - 1
      if arr[j] > arr[j + 1]
        temp = arr[j]
        arr[j] = arr[j + 1]
        arr[j + 1] = temp
      j++
    i++
  arr

# 奇怪的字符串反转
reverseString = (str) ->
  result = ""
  i = str.length - 1
  while i >= 0
    result += str[i]
    i--
  result

# 混乱的斐波那契调用
fibSequence = fibonacci(10)
console.log "斐波那契数列: #{fibSequence}"

# 计算阶乘
factResult = factorial(10)
console.log "10的阶乘: #{factResult}"

# 检查质数
primeCheck = isPrime(17)
console.log "17是质数吗? #{primeCheck}"

# 生成随机数
randNum = random()
console.log "随机数: #{randNum}"

# 排序数组
unsorted = [5, 2, 8, 1, 9, 3]
sorted = sortArray(unsorted)
console.log "排序后: #{sorted}"

# 反转字符串
original = "Hello World"
reversed = reverseString(original)
console.log "反转字符串: #{reversed}"

# 混乱的计算器主函数
calculator = ->
  console.log "=== 混乱计算器 ==="
  console.log "1. 加法"
  console.log "2. 减法"
  console.log "3. 乘法"
  console.log "4. 除法"
  console.log "5. 斐波那契"
  console.log "6. 阶乘"
  console.log "7. 质数检查"
  console.log "8. 随机数"
  console.log "9. 排序"
  console.log "10. 字符串反转"
  
  # 模拟用户选择
  choice = Math.floor(random() * 10) + 1
  console.log "随机选择: #{choice}"
  
  switch choice
    when 1
      a = Math.floor(random() * 100)
      b = Math.floor(random() * 100)
      result = add(a, b)
      console.log "#{a} + #{b} = #{result}"
    when 2
      a = Math.floor(random() * 100)
      b = Math.floor(random() * 100)
      result = subtract(a, b)
      console.log "#{a} - #{b} = #{result}"
    when 3
      a = Math.floor(random() * 100)
      b = Math.floor(random() * 100)
      result = multiply(a, b)
      console.log "#{a} * #{b} = #{result}"
    when 4
      a = Math.floor(random() * 100)
      b = Math.floor(random() * 100) + 1
      result = divide(a, b)
      console.log "#{a} / #{b} = #{result}"
    when 5
      n = Math.floor(random() * 10) + 1
      fib = fibonacci(n)
      console.log "斐波那契(#{n}): #{fib}"
    when 6
      n = Math.floor(random() * 10) + 1
      fact = factorial(n)
      console.log "#{n}! = #{fact}"
    when 7
      n = Math.floor(random() * 100) + 1
      prime = isPrime(n)
      console.log "#{n}是质数吗? #{prime}"
    when 8
      rand = random()
      console.log "随机数: #{rand}"
    when 9
      arr = []
      i = 0
      while i < 5
        arr.push Math.floor(random() * 100)
        i++
      sorted = sortArray(arr)
      console.log "排序: #{sorted}"
    when 10
      strings = ["hello", "world", "coffee", "script", "chaos"]
      str = strings[Math.floor(random() * strings.length)]
      rev = reverseString(str)
      console.log "#{str} -> #{rev}"
  
  console.log "计算完成"

# 初始化
init()

# 运行计算器
calculator()

# 混乱的结束代码
console.log "程序结束"
console.log "感谢使用混乱计算器"
console.log "再见!"