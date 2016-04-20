;;; to test the debugger

(define (f x)
  (let ((fn-name "function f"))
    (/ 1 x)))

(define (g x)
  (let ((fn-name "function g"))
    (* 2 (f (- x 1)))))

(define (h x)
  (let ((fn-name "function h"))
    (+ 1 (g x))))
