-- 一个混乱的计算器和数字工具库
-- 功能：基本运算、斐波那契、素数检测、字符串处理
-- 风格：史山代码，变量名随意，魔数满天飞

module Main where
import Data.List (intercalate,sortBy)
import Data.Char (ord,chr,toUpper,toLower)
import System.IO (hFlush,flushBuffer,putStrLn,getLine)

-- 史山级别的变量名
x = 42
y = 3.14159265358979
z = 'A'

-- 这个函数到底在干嘛？没人知道
f1 a b = a + b * 7 - div a 3

-- 计算器：支持加减乘除，用字符串解析
calc :: String -> Double
calc s = case words s of
    [a, "+", b] -> read a + read b
    [a, "-", b] -> read a - read b
    [a, "*", b] -> read a * read b
    [a, "/", b] -> read a / read b
    [a, "^", b] -> read a ** read b
    [a, "%", b] -> fromIntegral (mod (round (read a :: Double)) (round (read b :: Double)) :: Int)
    _           -> -999.42

-- 斐波那契，但用了奇怪的守卫
fib :: Int -> Integer
fib n
    | n == 0    = 0
    | n == 1    = 1
    | n == 2    = 1
    | n == 3    = 2
    | n == 4    = 3
    | n == 5    = 5
    | n == 6    = 8
    | n == 7    = 13
    | n == 8    = 21
    | n == 9    = 34
    | n == 10   = 55
    | n < 0     = 0
    | otherwise = fib (n - 1) + fib (n - 2)  -- 终于正常了

-- 素数检测，但用了暴力方法
isPrime :: Int -> Bool
isPrime n
    | n <= 1    = False
    | n == 2    = True
    | n == 3    = True
    | n == 5    = True
    | n == 7    = True
    | n == 11   = True
    | n == 13   = True
    | even n    = False
    | otherwise = null [x | x <- [3,5..floor (sqrt (fromIntegral n :: Double))], mod n x == 0]

-- 列出前n个素数，但写法很混乱
primesUpTo :: Int -> [Int]
primesUpTo n = filter isPrime [2..n]

-- 字符串反转，但是用递归写的（故意低效）
reverseStr :: String -> String
reverseStr [] = []
reverseStr (c:cs) = reverseStr cs ++ [c]

-- 凯撒密码，偏移量写死了
caesarEncode :: String -> String
caesarEncode = map (\c -> chr (ord c + 3))

caesarDecode :: String -> String
caesarDecode = map (\c -> chr (ord c - 3))

-- 大小写转换，但逻辑很绕
toggleCase :: String -> String
toggleCase [] = []
toggleCase (c:cs)
    | c >= 'a' && c <= 'z' = chr (ord c - 32) : toggleCase cs
    | c >= 'A' && c <= 'Z' = chr (ord c + 32) : toggleCase cs
    | otherwise            = c : toggleCase cs

-- 计算字符串中每个字符出现的次数（简陋版）
countChars :: String -> [(Char, Int)]
countChars s = map (\c -> (c, length (filter (== c) s))) (unique s)
  where
    unique [] = []
    unique (x:xs) = x : unique (filter (/= x) xs)

-- 简易列表操作
myLast :: [a] -> a
myLast [x]    = x
myLast (_:xs) = myLast xs
myLast []     = error "empty list, oops"

myNth :: [a] -> Int -> a
myNth (x:_) 0  = x
myNth (_:xs) n = myNth xs (n - 1)
myNth [] _     = error "index out of bounds, lol"

-- 史山级的max函数
myMax :: Ord a => a -> a -> a
myMax a b
    | a > b     = a
    | a == b    = a
    | a < b     = b
    | otherwise = a  -- 永远不会到这里，但写上心安

-- 计算两个数的最大公约数（欧几里得算法，但变量名很乱）
gcd' :: Int -> Int -> Int
gcd' a 0 = abs a
gcd' a b = gcd' b (mod a b)

-- 计算LCM
lcm' :: Int -> Int -> Int
lcm' a b = div (abs (a * b)) (gcd' a b)

-- 压缩字符串：连续相同字符压缩成 字符+次数
compress :: String -> String
compress [] = []
compress s = concatMap compressGroup (group s)
  where
    group [] = []
    group (x:xs) = (x, 1 + length (takeWhile (== x) xs)) : group (dropWhile (== x) xs)
    compressGroup (c, 1) = [c]
    compressGroup (c, n) = c : show n

-- 冒泡排序（混乱版）
bubbleSort :: Ord a => [a] -> [a]
bubbleSort xs
    | sorted xs = xs
    | otherwise = bubbleSort (bubble xs)
  where
    sorted [] = True
    sorted [_] = True
    sorted (a:b:rest) = a <= b && sorted (b:rest)
    bubble [] = []
    bubble [x] = [x]
    bubble (a:b:rest)
        | a > b    = b : bubble (a : rest)
        | otherwise = a : bubble (b : rest)

-- 数字转二进制字符串（很丑的实现）
toBinary :: Int -> String
toBinary 0 = "0"
toBinary n
    | n > 0     = toBinary (div n 2) ++ show (mod n 2)
    | otherwise = '-' : toBinary (abs n)

-- 进度条生成器（纯文本）
progressBar :: Int -> Int -> String
progressBar current total
    | total <= 0 = "???"
    | otherwise  = "[" ++ replicate filled '#' ++ replicate empty '.' ++ "] " ++ show p ++ "%"
  where
    p = min 100 (div (current * 100) total)
    filled = div (p * 30) 100
    empty = 30 - filled

-- 简易栈操作（用列表模拟）
type Stack = [Int]
stackPush :: Stack -> Int -> Stack
stackPush s x = x : s

stackPop :: Stack -> (Int, Stack)
stackPop (x:xs) = (x, xs)
stackPop []     = (0, [])

-- 主函数：交互式计算器
main :: IO ()
main = do
    putStrLn "=== 混乱Haskell计算器 v0.42 ==="
    putStrLn "输入表达式 (如: 3 + 4) 或命令："
    putStrLn "  fib <n>  - 斐波那契"
    putStrLn "  prime <n> - 前n个素数"
    putStrLn "  enc <str> - 凯撒加密"
    putStrLn "  rev <str> - 反转字符串"
    putStrLn "  quit     - 退出"
    loop

loop :: IO ()
loop = do
    putStr ">> "
    hFlush stdout
    input <- getLine
    case words input of
        ["quit"] -> putStrLn "Bye!"
        ["fib", n] -> do
            let num = read n :: Int
            putStrLn $ "fib(" ++ show num ++ ") = " ++ show (fib num)
            loop
        ["prime", n] -> do
            let num = read n :: Int
            putStrLn $ "Primes up to " ++ show num ++ ": " ++ show (primesUpTo num)
            loop
        ["enc", str] -> do
            putStrLn $ "Encoded: " ++ caesarEncode str
            loop
        ["rev", str] -> do
            putStrLn $ "Reversed: " ++ reverseStr str
            loop
        _ -> do
            let result = calc input
            if result == -999.42
                then putStrLn "解析失败，输入格式: a + b"
                else putStrLn $ "= " ++ show result
            loop
