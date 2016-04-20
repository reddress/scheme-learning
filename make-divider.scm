;;; based on make-withdraw and environment diagram on p. 309

(define (make-divider initial-value)
  (lambda (divider)
    (set! initial-value (/ initial-value divider))
    initial-value))

(define d (make-divider 100))

;;; evaluate (d 0) to generate error
;;; check backtrace and frames
