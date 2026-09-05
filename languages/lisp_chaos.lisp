;;; lisp_chaos.lisp - a chaotic mess that somehow works
;;; created by someone who clearly had too much coffee

(defvar *chaos-version* "0.0.0-UNSTABLE")
(defvar *debug-mode* nil)
(defvar *temp-list* nil)
(defvar *magic-number* 42)
(defvar *another-magic* 3.14159)
(defvar *counter* 0)

(defun main ()
  (format t "~%=== CHAOS LISP ~a ===~%" *chaos-version*)
  (format t "(it works, don't ask how)~%~%")
  (loop
    (format t "1) Fibonacci   2) Factorial~%")
    (format t "3) Prime?      4) Reverse string~%")
    (format t "5) List ops    6) Temperature~%")
    (format t "7) Dice roll   0) Quit~%")
    (format t "Choice: ")
    (let ((choice (read)))
      (cond
        ((= choice 1) (do-fib))
        ((= choice 2) (do-fact))
        ((= choice 3) (do-prime))
        ((= choice 4) (do-reverse))
        ((= choice 5) (do-lists))
        ((= choice 6) (do-temp))
        ((= choice 7) (do-dice))
        ((= choice 0) (progn (format t "Bye!~%") (return)))
        (t (format t "Invalid. Try again.~%"))))))

(defun do-fib ()
  (format t "Fibonacci up to n: ")
  (let ((n (read)))
    (format t "Fib sequence: ")
    (dotimes (i n)
      (format t "~a " (fib-helper i)))
    (format t "~%")))

(defun fib-helper (n)
  (if (<= n 1)
      n
      (+ (fib-helper (- n 1)) (fib-helper (- n 2)))))

(defun do-fact ()
  (format t "Factorial of: ")
  (let ((n (read)))
    (format t "~a! = ~a~%" n (fact-iter n 1))))

(defun fact-iter (n acc)
  (if (<= n 1)
      acc
      (fact-iter (- n 1) (* acc n))))

(defun do-prime ()
  (format t "Number to check: ")
  (let ((n (read)))
    (if (is-prime n)
        (format t "~a IS prime!~%" n)
        (format t "~a is NOT prime.~%" n))))

(defun is-prime (n)
  (cond
    ((<= n 1) nil)
    ((= n 2) t)
    ((evenp n) nil)
    (t (check-prime-divisors n 3))))

(defun check-prime-divisors (n d)
  (cond
    ((> (* d d) n) t)
    ((= (mod n d) 0) nil)
    (t (check-prime-divisors n (+ d 2)))))

(defun do-reverse ()
  (format t "String: ")
  (force-read-line)
  (let ((s (read-line)))
    (format t "Reversed: ~a~%" (reverse s))))

(defun force-read-line ()
  (read-line *standard-input* nil ""))

(defun do-lists ()
  (format t "Enter numbers (end with -1):~%")
  (let ((nums nil))
    (loop
      (format t "> ")
      (let ((val (read)))
        (when (= val -1) (return))
        (push val nums)))
    (setf nums (nreverse nums))
    (format t "List: ~a~%" nums)
    (format t "Sum: ~a~%" (apply #'+ nums))
    (format t "Max: ~a~%" (apply #'max nums))
    (format t "Min: ~a~%" (apply #'min nums))
    (format t "Length: ~a~%" (length nums))
    (format t "Sorted: ~a~%" (sort (copy-list nums) #'<))))

(defun do-temp ()
  (format t "Temperature value: ")
  (let ((temp (read)))
    (format t "~a F = ~a C~%" temp (/ (* (- temp 32) 5) 9))
    (format t "~a C = ~a F~%" temp (+ (* temp 1.8) 32))))

(defun do-dice ()
  (format t "How many dice? ")
  (let ((n (read)))
    (format t "Rolling ~a dice:~%" n)
    (let ((total 0))
      (dotimes (i n)
        (let ((roll (+ (random 6) 1)))
          (format t "  Die ~a: ~a~%" (+ i 1) roll)
          (incf total roll)))
      (format t "Total: ~a~%" total))))

(main)
