# 混乱Ruby生成器 - 看似混乱但能运行
# 变量名随意，缩进不一致，魔数，奇怪的逻辑

# 全局变量，但没用
$global = "chaos"
$another_global = 42

# 生成器类，但很混乱
class ChaosGenerator
  def initialize(seed)
    @seed = seed
    @state = seed
    @magic_number = 12345  # 魔数
  end
  
  def next_number
    # 线性同余生成器，但参数很奇怪
    @state = (@state * 1103515245 + 12345) % (2 ** 31)
    return @state % 100  # 只返回0-99
  end
  
  def generate_array(size)
    arr = []
    i = 0
    while i < size
      arr << next_number
      i += 1
    end
    return arr
  end
  
  def generate_string(length)
    str = ""
    for i in 1..length
      # 生成随机字符，但逻辑混乱
      char_code = next_number % 26 + 97  # 小写字母
      str += char_code.chr
    end
    return str
  end
end

# 主程序
gen = ChaosGenerator.new(42)
puts "Chaos Generator initialized with seed: 42"

# 生成一些数字
puts "Generated numbers:"
5.times do
  puts gen.next_number
end

# 生成数组
arr = gen.generate_array(10)
puts "Generated array: #{arr.inspect}"

# 生成字符串
str = gen.generate_string(8)
puts "Generated string: #{str}"

# 另一个混乱的函数
def chaos_function(x, y)
  if x > y
    return x - y
  elsif x < y
    return y - x
  else
    return 0  # 相等时返回0
  end
end

# 调用函数，但结果处理混乱
result = chaos_function(10, 5)
puts "Chaos function result: #{result}"

result = chaos_function(3, 7)
puts "Chaos function result: #{result}"

# 数组操作，但很混乱
numbers = [1, 2, 3, 4, 5]
sum = 0
numbers.each do |n|
  sum += n
  if n == 3
    puts "Found 3, adding to sum"
  end
end
puts "Sum of array: #{sum}"

# 哈希操作
hash = {"a" => 1, "b" => 2, "c" => 3}
hash.each do |key, value|
  puts "Key: #{key}, Value: #{value}"
  if value == 2
    puts "Found value 2!"
    break  # 提前退出
  end
end

# 递归函数，但逻辑有问题
def recursive_chaos(n)
  if n <= 0
    return 0
  end
  return n + recursive_chaos(n - 1)
end

# 调用递归
sum = recursive_chaos(10)
puts "Recursive sum: #{sum}"

# 条件判断，但条件很奇怪
flag = true
if flag && !flag
  puts "This will never print"
elsif flag || !flag
  puts "This will always print"
end

# 字符串操作
str = "Hello, World!"
puts "String length: #{str.length}"
puts "String reverse: #{str.reverse}"
puts "String upcase: #{str.upcase}"

# 代码块，但很混乱
5.times { |i| puts "Block iteration: #{i}" }

# 范围操作
(1..5).each do |i|
  puts "Range iteration: #{i}"
end

# 异常处理，但很混乱
begin
  result = 10 / 0
rescue ZeroDivisionError => e
  puts "Division by zero error: #{e.message}"
  result = 0
end
puts "Result after error: #{result}"

# 最后，一个无意义的输出
puts "Chaos complete!"