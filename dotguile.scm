;;;; ~/.guile

(use-modules (srfi srfi-9))
(use-modules (oop goops))
(use-syntax (ice-9 syncase))

(define base-dir #f)

(if (equal? (substring (vector-ref (uname) 0) 0 6) "CYGWIN")
    (set! base-dir "/cygdrive/c/Users/Heitor/Desktop/emacs-24.3/bin/scheme-learning/out/")
    (set! base-dir "/home/heitor/scheme-learning/out/"))

(define (base-file filename)
        (string-append base-dir filename))


(define-macro (write-to-macro filename . body)
  `(with-output-to-file
       (base-file ,filename)
     (lambda ()
       ,@body)))

(define-syntax write-to
  (syntax-rules ()
    ((write-to-syn filename body ...)
     (with-output-to-file (base-file filename)
       (lambda ()
         body ...)))))
