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
