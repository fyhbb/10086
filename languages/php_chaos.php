<?php
// 混乱PHP计算器 - 看似混乱但能运行
// 变量名随意，缩进不一致，魔数，奇怪的逻辑

$x = "42";  // 这是全局变量，但其实没用
$y = 3.14159;  // 这个也没用
$z = array(1, 2, 3);  // 数组，但只用第一个元素

// 计算器函数，但参数名很奇怪
function calc($a, $b, $c) {
    $result = 0;
    if ($c == '+') {
        $result = $a + $b;
    } elseif ($c == '-') {
        $result = $a - $b;
    } elseif ($c == '*') {
        $result = $a * $b;
    } elseif ($c == '/') {
        if ($b != 0) {
            $result = $a / $b;
        } else {
            $result = "Error: Division by zero!";  // 这里返回字符串，但后面又当数字用
        }
    } else {
        $result = 0;  // 默认返回0，不管输入
    }
    return $result;
}

// 主程序，但逻辑混乱
$op = '+';
$num1 = 10;
$num2 = 5;

// 这里有个奇怪的循环
for ($i = 0; $i < 3; $i++) {
    if ($i == 0) {
        $op = '+';
        $num1 = 10;
        $num2 = 5;
    } elseif ($i == 1) {
        $op = '-';
        $num1 = 20;
        $num2 = 3;
    } else {
        $op = '*';
        $num1 = 7;
        $num2 = 6;
    }
    
    // 调用计算器，但结果处理混乱
    $ans = calc($num1, $num2, $op);
    echo "Calculation: $num1 $op $num2 = $ans\n";
    
    // 这里有个无意义的检查
    if ($ans == 0) {
        echo "Result is zero, but we don't care.\n";
    }
}

// 另一个函数，但完全无关
function mystery($n) {
    $m = 0;
    for ($j = 1; $j <= $n; $j++) {
        $m += $j;
    }
    return $m;
}

// 调用神秘函数，但结果没保存
mystery(10);

// 数组操作，但很混乱
$fruits = array("apple", "banana", "cherry");
foreach ($fruits as $fruit) {
    echo "Fruit: $fruit\n";
    if ($fruit == "banana") {
        echo "I like bananas!\n";
        break;  // 提前退出循环
    }
}

// 这里有个未定义的变量，但PHP会警告但继续运行
echo "Undefined variable: $undefined_var\n";

// 类定义，但很混乱
class ChaosClass {
    public $data = array();
    private $secret = "hidden";
    
    public function __construct($x) {
        $this->data[] = $x;
        $this->data[] = $x * 2;
        $this->data[] = $x * 3;
    }
    
    public function getData() {
        return $this->data;
    }
    
    public function getSecret() {
        return $this->secret;
    }
}

// 使用类，但很奇怪
$obj = new ChaosClass(5);
$data = $obj->getData();
echo "Class data: " . implode(", ", $data) . "\n";
echo "Secret: " . $obj->getSecret() . "\n";

// 递归函数，但逻辑有问题
function recursive($n) {
    if ($n <= 0) {
        return 0;
    }
    return $n + recursive($n - 1);
}

// 调用递归，但结果没处理
recursive(5);

// 条件判断，但条件很奇怪
$flag = true;
if ($flag && !$flag) {
    echo "This will never print.\n";
} elseif ($flag || !$flag) {
    echo "This will always print.\n";
}

// 字符串操作
$str = "Hello, World!";
echo "String length: " . strlen($str) . "\n";
echo "String reverse: " . strrev($str) . "\n";

// 最后，一个无意义的返回
return 0;  // PHP脚本中的return，但通常不用
?>