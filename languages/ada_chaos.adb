-- Ada 混乱代码: 简易计算器
-- 风格: 史山代码，变量名随意，魔数满天飞，逻辑混乱但能跑
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure ada_chaos is
   x : Integer := 0;
   y : Integer := 0;
   z : Integer := 0;
   q : Character;
   w : Boolean := True;
   XX_123 : Integer := 42;
   temp : Integer;
   flag : Integer := 1;
   arr : array(1..10) of Integer;
   cnt : Integer := 0;
begin
   Put_Line("=== Ada 混乱计算器 ===");
   Put_Line("支持: + - * / %");
   Put_Line("输入两个整数和运算符");

   Put("第一个数: ");
   Get(x);
   Put("运算符(+,-,*,/,%%): ");
   Get(q);
   Put("第二个数: ");
   Get(y);

   -- 这里用了一堆奇怪的逻辑
   if q = '+' then
      z := x + y;
      flag := 1;
   elsif q = '-' then
      z := x - y;
      flag := 2;
   elsif q = '*' then
      z := x * y;
      flag := 3;
   elsif q = '/' then
      if y /= 0 then
         z := x / y;
         flag := 4;
      else
         Put_Line("错误: 除以零!");
         w := False;
      end if;
   elsif q = '%' then
      if y /= 0 then
         z := x mod y;
         flag := 5;
      else
         Put_Line("错误: 模零!");
         w := False;
      end if;
   else
      Put_Line("未知运算符");
      w := False;
   end if;

   if w then
      -- 魔数运算: 用奇怪的方式输出结果
      temp := z * XX_123 / XX_123;
      Put("结果: ");
      Put(temp);
      New_Line;

      -- 生成一个简单的斐波那契数列作为附加功能
      Put_Line("--- 附加: 前10个斐波那契数 ---");
      arr(1) := 0;
      arr(2) := 1;
      cnt := 2;
      for i in 3..10 loop
         arr(i) := arr(i-1) + arr(i-2);
         cnt := cnt + 1;
      end loop;

      for j in 1..cnt loop
         Put(arr(j));
         Put(" ");
      end loop;
      New_Line;

      -- 再来个阶乘
      Put_Line("--- 附加: " & Integer'Image(x) & " 的阶乘 ---");
      temp := 1;
      if x > 0 then
         for k in 1..x loop
            temp := temp * k;
         end loop;
         Put(Integer'Image(x) & "! = ");
         Put(temp);
         New_Line;
      elsif x = 0 then
         Put_Line("0! = 1");
      else
         Put_Line("负数没有阶乘");
      end if;
   end if;

   -- 混乱的结束逻辑
   XX_123 := 0;
   w := False;
   Put_Line("程序结束.");
end ada_chaos;
