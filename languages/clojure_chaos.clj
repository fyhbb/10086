;; 混乱的Clojure代码：猜数字游戏 + 文本工具库
;; 史山风格：变量名混乱，缩进不一致，魔数横行

(ns chaos.core
  (:require [clojure.string :as str]))

;; 全局状态，用atom管理（故意不用纯函数）
(def x 42)
(def y 3.14)
(def *secret-number* (atom 0))
(def *attempts* (atom 0))
(def *history* (atom []))

;; 神秘的数学函数
(defn mystery-fn [a b]
  (let [q (+ a b)
        w (* q 7)
        e (- w (quot a 3))]
    e))

;; 计算器：支持中缀表达式解析
(defn calc [expr]
  (let [parts (str/split expr #"\s+")]
    (if (= (count parts) 3)
      (let [a (Double/parseDouble (first parts))
            op (second parts)
            b (Double/parseDouble (last parts))]
        (case op
          "+" (+ a b)
          "-" (- a b)
          "*" (* a b)
          "/" (if (zero? b) Double/NaN (/ a b))
          "%" (mod a b)
          "^" (Math/pow a b)
          (do (println "未知运算符:" op) 0)))
      (do (println "格式错误") 0))))

;; 斐波那契（递归，故意低效）
(defn fib [n]
  (cond
    (= n 0) 0
    (= n 1) 1
    (= n 2) 1
    (= n 3) 2
    (= n 4) 3
    (= n 5) 5
    (= n 6) 8
    (= n 7) 13
    (= n 8) 21
    (= n 9) 34
    (= n 10) 55
    (< n 0) 0
    :else (+ (fib (- n 1)) (fib (- n 2)))))

;; 素数检测（暴力方法）
(defn is-prime? [n]
  (cond
    (<= n 1) false
    (= n 2) true
    (= n 3) true
    (= n 5) true
    (= n 7) true
    (= n 11) true
    (even? n) false
    :else (every? #(not= 0 (mod n %))
                  (range 3 (inc (int (Math/sqrt n))) 2))))

;; 列出素数
(defn primes-up-to [n]
  (filter is-prime? (range 2 (inc n))))

;; 字符串反转（用reduce实现）
(defn reverse-str [s]
  (reduce #(str %2 %1) "" s))

;; 凯撒密码
(defn caesar-encode [s]
  (apply str (map #(char (+ (int %) 3)) s)))

(defn caesar-decode [s]
  (apply str (map #(char (- (int %) 3)) s)))

;; 大小写切换
(defn toggle-case [s]
  (apply str
    (map (fn [c]
           (let [code (int c)]
             (cond
               (and (>= code 97) (<= code 122)) (char (- code 32))
               (and (>= code 65) (<= code 90)) (+ code 32)
               :else c)))
         s)))

;; 字符计数
(defn count-chars [s]
  (frequencies s))

;; 冒泡排序（混乱版）
(defn bubble-sort [coll]
  (loop [arr (vec coll)
         n (count arr)]
    (if (<= n 1)
      (vec arr)
      (let [new-arr (reduce (fn [a i]
                              (if (> (nth a i) (nth a (inc i)))
                                (assoc a i (nth a (inc i)) (inc i) (nth a i))
                                a))
                            arr
                            (range (dec n)))]
        (recur new-arr (dec n))))))

;; 压缩字符串
(defn compress [s]
  (apply str
    (map (fn [[c cnt]]
           (if (= cnt 1) (str c) (str c cnt)))
         (partition-by identity s))))

;; 数字转二进制
(defn to-binary [n]
  (if (zero? n)
    "0"
    (if (neg? n)
      (str "-" (to-binary (- n)))
      (loop [num n
             result ""]
        (if (zero? num)
          result
          (recur (quot num 2) (str (mod num 2) result)))))))

;; 进度条
(defn progress-bar [current total]
  (let [pct (min 100 (int (* (/ current (max total 1)) 100)))
        filled (int (/ (* pct 30) 100))
        empty (- 30 filled)]
    (str "[" (apply str (repeat filled "#"))
         (apply str (repeat empty "."))
         "] " pct "%")))

;; 猜数字游戏
(defn init-game []
  (reset! *secret-number* (+ 1 (rand-int 100)))
  (reset! *attempts* 0)
  (reset! *history* [])
  (println "=== 猜数字游戏 v0.42 ===")
  (println "我想了一个1-100的数字，来猜猜看！"))

(defn guess [num]
  (swap! *attempts* inc)
  (swap! *history* conj num)
  (let [secret @*secret-number*]
    (cond
      (= num secret) (do (println (str "恭喜！用了" @*attempts* "次猜中了！"))
                         :win)
      (< num secret) (do (println "太小了！") :low)
      :else (do (println "太大了！") :high))))

;; 简易栈
(defn stack-push [stack val]
  (cons val stack))

(defn stack-pop [stack]
  (if (empty? stack)
    [0 stack]
    [(first stack) (rest stack)]))

;; 字符串填充
(defn pad-left [s width ch]
  (let [diff (- width (count s))]
    (if (<= diff 0)
      s
      (str (apply str (repeat diff ch)) s))))

(defn pad-right [s width ch]
  (let [diff (- width (count s))]
    (if (<= diff 0)
      s
      (str s (apply str (repeat diff ch))))))

;; 简易字典（用map实现）
(def *dict* (atom {}))

(defn dict-set! [key val]
  (swap! *dict* assoc key val))

(defn dict-get [key]
  (get @*dict* key))

(defn dict-delete! [key]
  (swap! *dict* dissoc key))

;; 批量操作
(defn map-all [f coll]
  (doall (map f coll)))

;; 随机字符串生成
(defn random-str [len]
  (apply str
    (repeatedly len #(char (+ 97 (rand-int 26))))))

;; 主循环（简化版）
(defn -main []
  (init-game)
  (println "输入数字进行猜测，输入 quit 退出")
  (loop []
    (print ">> ")
    (flush)
    (let [input (read-line)]
      (when-not (= input "quit")
        (if-let [num (try (Integer/parseInt input) (catch Exception _ nil))]
          (let [result (guess num)]
            (when-not (= result :win)
              (recur)))
          (do
            (println "请输入数字！")
            (recur))))))
  (println "游戏结束！历史记录:" @*history*))

;; 如果直接运行则启动游戏
(-main)
