;;; p. 6 Sec. 3.2 Disjointness of types
;;; No object satisfies more than one of the following:

;;; boolean?  symbol?  char?    vector?  procedure?
;;; pair?     number?  string?  port?

;;; The empty list is a special object that satisfies none of the
;;; above predicates.

;;; p. 10 Sec. 4.2 Derived expression types

(cond ((> 3 2) 'greater)
      ((< 3 2) 'less)
      (else 'equal))

(case (* 2 3)
  ((2 3 5 7) 'prime)
  ((1 4 6 8 9) 'composite))

;;; p. 12 Sec. 4.2.4 Iteration

(do ((vec (make-vector 5))  ; variable, init
     (j 0 (+ j 1)))  ; variable, init, step
    ((= j 5) vec)  ; test, expression to be evaluated
  (vector-set! vec j j))  ; evaluated for effect

;; named let
(let loop ((numbers '(3 -2 1 6 -5))
           (nonneg '())
           (neg '()))
  (cond ((null? numbers) (list nonneg neg))
        ((>= (car numbers) 0)
         (loop (cdr numbers)
               (cons (car numbers) nonneg)
               neg))
        ((< (car numbers) 0)
         (loop (cdr numbers)
               nonneg
               (cons (car numbers) neg)))))

;;; p. 13 Sec. 4.2.5 Delayed evaluation

;; (delay <expression>)  returns a promise that may be asked by force
;;; to evaluate the expression and deliver the resulting value.

;;; p. 14 Sec. 4.3.1 Binding constructs for syntactic keywords

;; (let-syntax <bindings> <body>)

;; (letrec-syntax <bindings> <body>)

;; (syntax-rules <literals> <syntax rule> ...)

;;; p. 17 Sec. 5.3 Syntax definitions

;; (define-syntax <keyword> <transformer spec (syntax-rules instance)>)

;;; p. 17 Sec. 6.1 Equivalence predicates

;;; Most discriminating to least:
;;; eq?  eqv?  equal?

