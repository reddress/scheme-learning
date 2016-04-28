;;;; http://www.willdonnelly.net/blog/scheme-syntax-rules/

;; (do ((n 1 (+ n 1)))
;;     ((> n 3))
;;   (display n))

(define-syntax repeat
  (syntax-rules ()
    ((repeat k body ...)
     (do ((n 1 (+ n 1)))
         ((> n k))
       body ...))))
    

;;;; silly example, prepend 'd' to procedure

(define (double x y) (* 2 x y))

;; (prepend-d (efine x 2))
;; >> (define x 2)

(define-syntax prepend-d-varargs
  (syntax-rules ()
    ((prepend-d (proc-name . body))
     (apply
      (eval
       (string->symbol
        (string-append
         "d" (symbol->string (quote proc-name))))
       (interaction-environment))
      (quote body)))))

(define-syntax prepend-s
  (syntax-rules ()
    ((prepend-s (proc-name arg))
     ((eval
       (string->symbol
        (string-append
         "s" (symbol->string (quote proc-name))))
       (interaction-environment)) arg))))
    
    ;; ((prepend-d (proc-name arg))
    ;;   (proc-name arg))))   ;; does nothing

