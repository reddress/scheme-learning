;;; p. 39, 1.1.5 Substitution model for procedure application

(define (square x)
  (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

;;; To apply a compound procedure to arguments, evaluate the body of the procedure with each FORMAL PARAMETER replaced by the corresponding ARGUMENT

(f 5)
;;; becomes
(sum-of-squares (+ 5 1) (* 5 2))
(+ (square 6) (square 10))
(+ (* 6 6) (* 10 10))
(+ 36 100)
136

;;; This process is called the SUBSTITUTION MODEL

;;; Applicative order versus Normal order

;;; An alternative evaluation model would not evaluate the operands until their values were needed, but substitute operand expressions until it obtained an expression involving only primitive operators

(sum-of-squares (+ 5 1)           (* 5 2))
(+      (square (+ 5 1))  (square (* 5 2)))
(+   (* (+ 5 1) (+ 5 1))  (* (* 5 2) (* 5 2)))

;;; Now there are only primitives, so proceed with reductions
(+   (* 6 6)     (* 10 10))
(+    36          100)
136

;;; This method of fully expanding then reducing is called NORMAL-ORDER EVALUATION. Note that the evaluation of (+ 5 1) and (* 5 2) is performed twice

;;; The other method of "evaluating the arguments then applying" is called APPLICATIVE-ORDER EVALUATION. It is the method used by Lisp.


;;; p. 59, 1.2.1 Linear Recursion and Iteration

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 3)
;;; becomes
(* 3 (factorial 2))
(* 3 (* 2 (factorial 1)))
(* 3 (* 2 1))
(* 3 2)
6

;;; This procedure is a LINEAR RECURSIVE PROCESS. As the expansion occurs, the process builds up a chain of DEFERRED OPERATIONS (multiplications). It is called linear because the growth is proportional to n.

;;; A different perspective for computing factorials is keeping a running product and a counter from 1 to n.

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

;;; Though the multiplications are the same, the "shape" of the process is very different. This process does not grow and shrink. It is called an ITERATIVE PROCESS. Its state is given by a fixed number of STATE VARIABLES with rules describing how the state variables are updated and a terminating condition.

;;; The number of steps grows linearly with n, so this process is called a LINEAR ITERATIVE PROCESS.

(factorial 3)
;;; becomes
; (iter 1 1)  ;; n is 3
; (iter 1 2)
; (iter 2 3)
; (iter 6 4)  ;; here counter > 3, so return 6

;;; We must be careful not to confuse a recursive process with the notion of a recursive procedure. A recursive procedure syntactically refers to the procedure itself (directly or indirectly). In describing a process as recursive, we are speaking about how the process evolves.

;;; An implementation of Scheme that executes an iterative process in constant space (even when it is described by a recursive procedure) is a TAIL-RECURSIVE IMPLEMENTATION.


;;; p. 65, 1.2.2 Tree Recursion

;;; Tree recursion is another common pattern of computation.

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

;;; An iterative process for computing Fibonacci numbers uses a pair of integers, a and b, and a counter

;;; a <- a + b,
;;; b <- a

(define (fib n)
  (fib-iter 1 0 n))
(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))

;;; p. 78, 1.2.5 Greatest Common Divisors

;;; Euclid's Algorithm is:
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;;; Move the right-hand number left, and place the remainder of a/b, in the right. If the right-hand number is 0, then the answer is on the left.

;;; p. 80, 1.2.6 Testing for Primality

;;; Searching for divisors
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

;;; p. 89, 1.3.1 Procedures as Arguments

;;; The abstraction of "summation of a series" is represented by "sigma notation"
;;; Sigma (n = a->b) of f(n) = f(a) + ... + f(b)

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (cube x)
  (* x x x))

(define (inc n)
  (+ n 1))

(define (sum-cubes a b)
  (sum cube a inc b))

(sum-cubes 1 10)

;;; p. 95 1.3.2 Constructing Procedures using LAMBDA

;;; A lambda expression is read as follows:
;;; (lambda                     (x)     (+   x     4))
;;; the procedure of an argument x that adds x and 4

;;; p. 107 1.3.4 Procedures as Returned Values

;;; Derivative Df(x) = (f(x+dx) - f(x)) / dx

(define (deriv f)
  (let ((dx 0.00001))
    (lambda (x) (/ (- (f (+ x dx)) (f x)) dx))))

((deriv cube) 5)

