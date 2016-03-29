(define PATH "C:/Users/Heitor/Desktop/emacs-24.3/bin/scheme-learning/")
(define *stdout* (current-output-port))

(define (fizz n)
  (if (= 0 (remainder n 3))
      "fizz"
      ""))

(define (buzz n)
  (if (= 0 (remainder n 5))
      "buzz"
      ""))

(define (fizzbuzz n)
  (let ((s (string-append (fizz n) (buzz n))))
    (if (equal? s "")
        n
        s)))

(define (fizzbuzz-seq start stop)
  (cond ((<= start stop)
         (display (fizzbuzz start))
         (display (fizzbuzz start) *stdout*)
         (newline)
         (newline *stdout*)
         (fizzbuzz-seq (+ 1 start) stop))))

(define (fizzbuzz-main n)
  (fizzbuzz-seq 1 n))

(with-output-to-file
    (string-append PATH "out-fizzbuzz.txt")
  (lambda ()
    (display "Writing file..." *stdout*)
    (fizzbuzz-main 16)))
