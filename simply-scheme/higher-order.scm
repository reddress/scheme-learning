;;; Ch. 8

;;; repeated FN TIMES
;;; > ((repeated square 2) 3)
;;; 81

(define (square x) (* x x))

(define (repeated fn times)
  ;;; want: ((lambda (x) (square (square x))) 3)
  (lambda (x)
    (letrec ((my-call (lambda (n)
                        (if (= n 1)
                            (fn x)
                            (fn (my-call (- n 1)))))))
      (my-call times))))
                                       
;;      (lambda (x) (repeated fn (- times 1))

(define (book-repeated fn number)
  (if (= number 0)
      (lambda (x) x)
      (lambda (x)
        ((book-repeated fn (- number 1)) (fn x)))))

(define (my-compose fn-lst)
  ;;; (my-compose (list f g h)) -> (lambda (x) (f (g (h x))))
  ;;; function list cannot be quoted because they would represent
  ;;; the "symbol" value of the function, not the function itself
  (lambda (x)
    (if (empty? fn-lst)
        x
        ((my-compose (butlast fn-lst)) ((last fn-lst) x)))))

(define (any-numbers? sent)
  (not (empty? (keep number? sent))))

;;; ex. 8.8

(define (letter-count sent)
  (accumulate + (every count sent)))
