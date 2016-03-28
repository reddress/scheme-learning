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
         (newline)
         (fizzbuzz-seq (+ 1 start) stop))))

(define (fizzbuzz-main n)
  (fizzbuzz-seq 1 n))
