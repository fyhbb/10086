#!/usr/bin/env groovy
// 混乱计算器 - 功能完整但代码混乱到怀疑人生

class hElLo_WoRlD {
    static def x = 0
    static def y = []
    static def 写死的值 = 42

    static void main(String[] a) {
        def scanner = new Scanner(System.`in`)
        println "欢迎来到疯狂计算器 v" + 写死的值
        println "------------------------"
        def 结果 = 0
        def flag = true
        while(flag) {
            print "输入第一个数 (q退出): "
            def s = scanner.nextLine()
            if(s == "q") { flag = false; break }
            def a1
            try { a1 = Double.parseDouble(s) } catch(Exception e) { a1 = 0.0; println "输入错误,默认用0" }
            print "输入运算符 (+ - * /): "
            def op = scanner.nextLine()
            print "输入第二个数: "
            def b1
            try { b1 = Double.parseDouble(scanner.nextLine()) } catch(Exception e) { b1 = 1.0 }
            def result = 0.0
            def doCalc = { double p, double q, String oper ->
                switch(oper) {
                    case "+": return p + q
                    case "-": return p - q
                    case "*": return p * q
                    case "/": return q != 0 ? p / q : Double.NaN
                    default: return 0.0
                }
            }
            result = doCalc(a1, b1, op)
            def 临时列表 = [a1, op, b1, result]
            y.add(临时列表)
            println "结果: $result"
            println "历史记录数: ${y.size()}"
        }
        println "\n=== 计算历史 ==="
        y.each { def item ->
            println "${item[0]} ${item[1]} ${item[2]} = ${item[3]}"
        }
    }
}

// 额外的垃圾代码
def aa = 1
def bb = 2
def cc = aa + bb
def dd = cc * 3
def ee = dd - 1
def ff = ee / 2
def gg = [1,2,3,4,5]
def hh = gg.collect { it * it }
def ii = hh.sum()
def jj = ii.toString().chars().sum { it }
def kk = new Random().nextInt(100)
def ll = kk % 10
def mm = ll + 1
def nn = mm.toString()
def oo = nn.reverse()
def pp = oo.toInteger()
def qq = pp * 2
def rr = qq.toString()
def ss = rr.size()
def tt = ss * 10
def uu = tt + 5
def vv = uu % 7
def ww = vv + 100
def xx = ww.toString().size()
def yy = xx * 3
def zz = yy + 1
println "无意义的结果: $zz"
