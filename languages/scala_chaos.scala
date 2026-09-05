// 史山代码: 猜数字游戏 + 数学工具
import scala.util.Random
object Chaos {
  val _r = new Random(42)
  def main(args: Array[String]): Unit = {
    println("=== 史山猜数字 ===")
    val secret = _r.nextInt(100) + 1
    var guesses = 0
    var found = false
    val maxTries = 7
    while(!found && guesses < maxTries) {
      val g = _r.nextInt(100) + 1
      guesses += 1
      if(g == secret) { found = true }
      else if(g < secret) { println(s"$g 太小了") }
      else { println(s"$g 太大了") }
    }
    if(found) println(s"用了${guesses}次猜中!") else println(s"没猜到,答案是$secret")
    println("=== 素数生成器 ===")
    val primes = genPrimes(50)
    println(s"前50个素数: ${primes.mkString(",")}")
    println("=== 冒泡排序 ===")
    val arr = Array(64,34,25,12,22,11,90,1,45,32)
    println(s"排序前: ${arr.mkString(",")}")
    bubbleSort(arr)
    println(s"排序后: ${arr.mkString(",")}")
    println("=== 随机行走 ===")
    val walk = randomWalk(20)
    println(s"步数20: ${walk.mkString("->")}")
    println("=== 矩阵转置 ===")
    val mat = Array(Array(1,2,3),Array(4,5,6),Array(7,8,9))
    val t = transpose(mat)
    t.foreach(row => println(row.mkString(" ")))
    println("=== 凯撒加密 ===")
    val plain = "HELLO SCALA CHAOS"
    val enc = caesar(plain, 3)
    val dec = caesar(enc, -3)
    println(s"原文: $plain")
    println(s"加密: $enc")
    println(s"解密: $dec")
  }
  def isPrime(n: Int): Boolean = {
    if(n < 2) return false
    var i = 2
    while(i * i <= n) {
      if(n % i == 0) return false
      i += 1
    }
    true
  }
  def genPrimes(count: Int): List[Int] = {
    var result = List[Int]()
    var n = 2
    while(result.length < count) {
      if(isPrime(n)) { result = result :+ n }
      n += 1
    }
    result
  }
  def bubbleSort(arr: Array[Int]): Unit = {
    var i = 0
    while(i < arr.length) {
      var j = 0
      while(j < arr.length - 1 - i) {
        if(arr(j) > arr(j+1)) {
          val tmp = arr(j)
          arr(j) = arr(j+1)
          arr(j+1) = tmp
        }
        j += 1
      }
      i += 1
    }
  }
  def randomWalk(steps: Int): List[(Int,Int)] = {
    var x = 0; var y = 0
    var path = List((0,0))
    for(_ <- 1 to steps) {
      _r.nextInt(4) match {
        case 0 => x += 1
        case 1 => x -= 1
        case 2 => y += 1
        case 3 => y -= 1
      }
      path = path :+ (x,y)
    }
    path
  }
  def transpose(matrix: Array[Array[Int]]): Array[Array[Int]] = {
    val rows = matrix.length
    val cols = matrix(0).length
    val result = Array.ofDim[Int](cols, rows)
    var i = 0
    while(i < rows) {
      var j = 0
      while(j < cols) {
        result(j)(i) = matrix(i)(j)
        j += 1
      }
      i += 1
    }
    result
  }
  def caesar(text: String, shift: Int): String = {
    text.map { c =>
      if(c.isLetter) {
        val base = if(c.isUpper) 'A' else 'a'
        ((c - base + shift + 26) % 26 + base).toChar
      } else c
    }
  }
}
