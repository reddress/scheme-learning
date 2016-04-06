;;;; ~/.guile

(define base-dir #f)

(if (equal? (substring (vector-ref (uname) 0) 0 6) "CYGWIN")
    (set! base-dir "/cygdrive/c/Users/Heitor/Desktop/emacs-24.3/bin/scheme-learning/")
    (set! base-dir "/home/heitor/scheme-learning/"))

(define (base-file filename)
        (string-append base-dir filename))

(use-modules (srfi srfi-9))
(use-modules (oop goops))

(define-macro (write-to filename . body)
  `(with-output-to-file
       (base-file ,filename)
     (lambda ()
       ,@body)))
