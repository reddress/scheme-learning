(use-modules (ice-9 format))

;;;; http://www.madore.org/~david/computers/callcc.html

;;; =42
(call/cc (lambda (k) (+ 10 (k 42))))

;;; =43
(+ 1 (call/cc (lambda (k) (+ 10000 (k 42)))))

;;; =42
(call/cc (lambda (k) 42))

;;; endless time loop
;; (let ((cont #f))
;;  (call/cc (lambda (k) (set! cont k)))
;;  (cont #f))

;;;; http://phillipwright.info/drafts/continuations.htm
(define handle #f)

(+ 12 (call/cc (lambda (k) (set! handle k) 2)))

;;; R5RS p. 33

;; (call-with-current-continuation proc), abbreviated as call/cc
;; proc must be a procedure of one argument

(define proc
  (lambda (k)
    (+ 10
       (k 1))))

(+ 1000 (+ 100 (call-with-current-continuation
                proc)))

(define cwcc (call-with-current-continuation proc))

(+ 200 cwcc)

;; break out of iteration
(use-modules (ice-9 format))

(call/cc
 (lambda (exit)
   (for-each (lambda (x)
               (if (negative? x)
                   (exit x)
                   (format #t "~d is not negative\n" x)))
             '(4 0 32 -2 3 5 9))
   'none-negative))

;;; how to backtrack?

(if (call/cc
     (lambda (k)
       (k #f))) 'true 'false)
