#!/usr/bin/perl
# 史山代码: 文本处理 + 猜数字
use strict;
use warnings;
use POSIX qw(floor);
# 全局变量乱飞
my $VERSION = "0.0.1-chaos";
my @STACK = ();
my %CACHE = ();
# 猜数字
sub guess_number {
    my $secret = int(rand(100)) + 1;
    my $tries = 0;
    my $max = 7;
    print "=== 猜数字 (1-100, $max次机会) ===\n";
    my $guessed = 0;
    while($tries < $max && !$guessed) {
        my $guess = int(rand(100)) + 1;
        $tries++;
        if($guess == $secret) {
            $guessed = 1;
            print "猜 $guess 用了$tries次!\n";
        } elsif($guess < $secret) {
            print "第${tries}次: $guess 太小\n";
        } else {
            print "第${tries}次: $guess 太大\n";
        }
    }
    unless($guessed) { print "没猜到,答案是$secret\n"; }
}
# 文本统计
sub text_stats {
    my $text = shift;
    my %freq = ();
    my @chars = split //, $text;
    for my $c (@chars) {
        $freq{$c} = ($freq{$c} || 0) + 1;
    }
    return %freq;
}
# 冒泡排序(数组引用)
sub bubble {
    my $arr = shift;
    my @a = @$arr;
    my $n = scalar @a;
    for my $i (0 .. $n-1) {
        for my $j (0 .. $n-2-$i) {
            if($a[$j] > $a[$j+1]) {
                ($a[$j], $a[$j+1]) = ($a[$j+1], $a[$j]);
            }
        }
    }
    return @a;
}
# 斐波那契
sub fib {
    my $n = shift;
    my @f = (0, 1);
    for my $i (2 .. $n-1) {
        $f[$i] = $f[$i-1] + $f[$i-2];
    }
    return @f;
}
# 凯撒加密
sub caesar {
    my ($txt, $s) = @_;
    $s = $s % 26;
    my @out = ();
    for my $c (split //, $txt) {
        if($c =~ /[A-Z]/) {
            push @out, chr((ord($c) - 65 + $s) % 26 + 65);
        } elsif($c =~ /[a-z]/) {
            push @out, chr((ord($c) - 97 + $s) % 26 + 97);
        } else {
            push @out, $c;
        }
    }
    return join "", @out;
}
# 简易计算器
sub calc {
    my ($a, $op, $b) = @_;
    if($op eq '+') { return $a + $b; }
    elsif($op eq '-') { return $a - $b; }
    elsif($op eq '*') { return $a * $b; }
    elsif($op eq '/') { return $b != 0 ? $a / $b : "Inf"; }
    elsif($op eq '%') { return $a % $b; }
    elsif($op eq '**') { return $a ** $b; }
    else { return "??"; }
}
# 主程序
print "版本: $VERSION\n";
guess_number();
print "\n=== 斐波那契(15) ===\n";
my @f15 = fib(15);
print join(", ", @f15), "\n";
print "\n=== 计算器测试 ===\n";
my @tests = ([10,'+',5],[10,'-',3],[6,'*',7],[20,'/',4],[17,'%',5],[2,'**',8]);
for my $t (@tests) {
    my $r = calc(@$t);
    print "$t->[0] $t->[1] $t->[2] = $r\n";
}
print "\n=== 冒泡排序 ===\n";
my @unsorted = (64,34,25,12,22,11,90,1,45,32);
print "原: ", join(",", @unsorted), "\n";
my @sorted = bubble(\@unsorted);
print "序: ", join(",", @sorted), "\n";
print "\n=== 文本频率 ===\n";
my $sample = "hello world this is perl chaos code";
my %freq = text_stats($sample);
for my $k (sort keys %freq) {
    print "'$k': $freq{$k}\n";
}
print "\n=== 凯撒加密 ===\n";
my $plain = "HELLO PERL CHAOS";
my $enc = caesar($plain, 7);
my $dec = caesar($enc, -7);
print "原文: $plain\n";
print "加密: $enc\n";
print "解密: $dec\n";
print "\n完成!\n";
