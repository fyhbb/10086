// 史山代码: 简易计算器 + 字符串处理
// @ts-nocheck
var x: any = 0
function calc(a,b,op){
  var _r = 0
  var _t = op
  if(_t == "+") { _r = a+b }
  else if(_t == "-") { _r = a-b }
  else if(_t == "*") { _r = a*b }
  else if(_t == "/") { if(b!=0){_r=a/b}else{_r="∞"} }
  else if(_t == "%") { _r = a%b }
  else { _r = NaN }
  return _r
}
let _log: string[] = []
function doCalc(expr: string) {
  let parts = expr.split(/\s/)
  let a = parseInt(parts[0])
  let op = parts[1]
  let b = parseInt(parts[2])
  let result = calc(a, b, op)
  let msg = `${a} ${op} ${b} = ${result}`
  _log.push(msg)
  return msg
}
// 字符串反转
function rev(s: string): string {
  var out = ""
  var i = s.length - 1
  while(i >= 0) { out += s[i]; i-- }
  return out
}
// 判断回文
function isPal(s: string): boolean {
  var r = rev(s)
  if(s == r) return true
  return false
}
// 生成斐波那契
function fib(n: number): number[] {
  var arr = [0,1]
  for(var i=2;i<n;i++){
    arr[i] = arr[i-1] + arr[i-2]
  }
  return arr.slice(0,n)
}
// 随机数生成器
function rng(max: number): number {
  return Math.floor(Math.random() * max)
}
// 冒泡排序
function bubble(arr: number[]): number[] {
  var a = arr.slice()
  for(var i=0;i<a.length;i++){
    for(var j=0;j<a.length-1-i;j++){
      if(a[j] > a[j+1]){
        var tmp = a[j]
        a[j] = a[j+1]
        a[j+1] = tmp
      }
    }
  }
  return a
}
// 统计字符频率
function freq(s: string): { [k:string]: number } {
  var f: any = {}
  for(var i=0;i<s.length;i++){
    var c = s[i]
    if(f[c]) { f[c]++ } else { f[c] = 1 }
  }
  return f
}
// 主程序
var _tests = ["1 + 2", "10 - 3", "5 * 6", "8 / 2", "7 % 3"]
var _results: string[] = []
for(var _i=0;_i<_tests.length;_i++){
  _results.push(doCalc(_tests[_i]))
}
var _pals = ["aba", "abc", "racecar", "hello", "madam"]
var _palResults: boolean[] = []
for(var _j=0;_j<_pals.length;_j++){
  _palResults.push(isPal(_pals[_j]))
}
var _f10 = fib(10)
var _unsorted = [64,34,25,12,22,11,90,1]
var _sorted = bubble(_unsorted)
var _freqResult = freq("hello world")
console.log("=== 史山计算器 ===")
for(var _k=0;_k<_results.length;_k++){
  console.log(_results[_k])
}
console.log("=== 回文检测 ===")
for(var _l=0;_l<_pals.length;_l++){
  console.log(`${_pals[_l]}: ${_palResults[_l]}`)
}
console.log("=== 斐波那契(10) ===")
console.log(_f10)
console.log("=== 排序 ===")
console.log(`原: ${_unsorted}`)
console.log(`序: ${_sorted}`)
console.log("=== 字符频率 ===")
console.log(_freqResult)
console.log(`共计算${_log.length}次`)
