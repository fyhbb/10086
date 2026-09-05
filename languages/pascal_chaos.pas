{ Pascal 混乱代码: 猜数字游戏 }
{ 风格: 变量名极短，缩进随意，魔数满天飞，逻辑绕来绕去 }
program pascal_chaos;

uses crt;

var
  a, b, c, d, e, f, g, h, i, j: integer;
  k: boolean;
  m: string;
  n: array[1..20] of integer;
  o: integer;

begin
  clrscr;
  writeln('=== Pascal 混乱猜数字 ===');
  writeln('我想了一个1-100的数字，猜猜看!');
  writeln;

  randomize;
  a := random(100) + 1;  { 目标数字 }
  b := 0;                { 猜测次数 }
  c := 7;                { 最大次数，用魔数 }
  k := true;
  o := 0;

  { 生成一些干扰数据，纯粹为了混乱 }
  for d := 1 to 20 do
  begin
    n[d] := d * 3 + random(10);
  end;

  while k do
  begin
    write('第 ', b + 1, '/', c, ' 次猜测: ');
    readln(e);

    b := b + 1;

    { 用奇怪的方式比较 }
    f := e - a;
    if f = 0 then
    begin
      writeln('恭喜! 你猜对了! 用了 ', b, ' 次');
      k := false;
      { 输出一些无意义的统计 }
      g := 0;
      for d := 1 to 20 do
      begin
        if n[d] mod 2 = 0 then
          g := g + 1;
      end;
      writeln('偶数干扰项数量: ', g);
    end
    else if f < 0 then
    begin
      writeln('太小了!');
      { 检查是否接近 }
      if (a - e) < 10 then
        writeln('提示: 很接近了!');
    end
    else
    begin
      writeln('太大了!');
      if (e - a) < 10 then
        writeln('提示: 很接近了!');
    end;

    if b >= c then
    begin
      writeln('次数用完了! 答案是: ', a);
      k := false;
    end;

    { 每次循环做些无用功 }
    h := 0;
    for d := 1 to 10 do
    begin
      h := h + n[d] * d;
    end;
    o := h mod 100;
  end;

  { 结尾输出一些奇怪的东西 }
  writeln;
  writeln('--- 混乱统计 ---');
  writeln('最终干扰值: ', o);
  writeln('猜测次数: ', b);
  writeln('目标数字: ', a);

  { 生成一个简单的图案 }
  writeln;
  for d := 1 to 5 do
  begin
    m := '';
    for e := 1 to d do
      m := m + '* ';
    writeln(m);
  end;
  for d := 4 downto 1 do
  begin
    m := '';
    for e := 1 to d do
      m := m + '* ';
    writeln(m);
  end;

  writeln;
  writeln('程序结束. 按回车退出...');
  readln;
end.
